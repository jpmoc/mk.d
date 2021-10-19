_DIVE_MK_VERSION= 0.99.1

# DVe_CONFIG_DIRPATH?= ./in/
# DVE_CONFIG_FILENAME?= dive.yml
# DVE_CONFIG_FILEPATH?= ./in/dive.yml
# DVE_IMAGE_NAME?= docker#

# Derived parameters
DVE_CONFIG_DIRPATH?= $(CMN_INPUTS_DIRPATH)
DVE_CONFIG_FILEPATH?= $(DVE_CONFIG_DIRPATH)$(DVE_CONFIG_FILENAME)

# Option parameters
__DVE_CONFIG?= $(if $(DVE_CONFIG_FILEPATH),--config $(DVE_CONFIG_FILEPATH))

# UI parameters
DVE_UI_LABEL?= [dive] #

#--- Utilities

DIVE_BIN?= dive
DIVE?= $(strip $(__DIVE_ENVIRONMENT) $(DIVE_ENVIRONMENT) $(DIVE_BIN) $(__DIVE_OPTION) $(DIVE_OPTION))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _dve_view_framework_macros
_dve_view_framework_macros ::
	@echo 'Dive:: ($(_DIVE_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _dve_view_framework_parameters
_dve_view_framework_parameters ::
	@echo 'Dive:: ($(_DIVE_MK_VERSION)) parameters:'
	@echo '    DIVE=$(DIVE)'
	@echo '    DVE_CONFIG_DIRPATH=$(DVE_CONFIG_DIRPATH)'
	@echo '    DVE_CONFIG_FILENAME=$(DVE_CONFIG_FILENAME)'
	@echo '    DVE_CONFIG_FILEPATH=$(DVE_CONFIG_FILEPATH)'
	@echo '    DVE_IMAGE_NAME=$(DVE_IMAGE_NAME)'
	@echo

_view_framework_targets :: _dve_view_framework_targets
_dve_view_framework_targets ::
	@echo 'Dive:: ($(_DIVE_MK_VERSION)) targets:'
	@echo '    _dve_slice_image        - Slice a docker image'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
# -include $(MK_DIR)/dive_image.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _dve_install_dependencies
_dve_install_dependencies:
	@$(INFO) '$(DVE_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://github.com/wagoodman/dive'; $(NORMAL)
	wget https://github.com/wagoodman/dive/releases/download/v0.6.0/dive_0.6.0_linux_amd64.deb
	sudo apt install ./dive_0.6.0_linux_amd64.deb

_dve_slice_image:
	@$(INFO) '$(DVE_UI_LABEL)Slicing image "$(DVE_IMAGE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the image is not cached locally'; $(NORMAL)
	$(DIVE) $(__DVE_CONFIG) $(DVE_IMAGE_NAME)
