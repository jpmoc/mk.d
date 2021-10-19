_MULTIPASS_MK_VERSION= 0.99.0

# MPS_PARAMETER?= value

# Derived variables
MPS_MODE_DEBUG?= $(MPS_MODE_DEBUG)
MPS_MODE_INTERACTIVE?= $(MPS_MODE_INTERACTIVE)

# Option variables

# UI variables
MPS_UI_LABEL?= [multipass] #
 
#--- Utilities

MULTIPASS_BIN?= multipass
MULTIPASS?= $(strip $(__MULTIPASS_ENVIRONMENT) $(MULTIPASS_ENVIRONMENT) $(MULTIPASS_BIN) $(__MULTIPASS_OPTIONS) $(MULTIPASS_OPTIONS) )

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _mps_view_framework_macros
_mps_view_framework_macros ::
	@#echo 'Multipass: ($(_MULTIPASS_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _mps_view_framework_parameters
_mps_view_framework_parameters ::
	@echo 'Multipass:: ($(_MULTIPASS_MK_VERSION)) parameters:'
	@echo '    MULTIPASS=$(MULTIPASS)'
	@echo

_view_framework_targets :: _mps_view_framework_targets
_mps_view_framework_targets ::
	@echo 'Multipass:: ($(_MULTIPASS_MK_VERSION)) targets:'
	@echo '    _mps_install_dependencies            - Install dependencies'
	@echo '    _mps_show_version                    - Show the version'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/locust_runner.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _mps_install_dependencies
_mps_install_dependencies:
	@$(INFO) '$(LCT_UI_LABEL)Install dependencies ....'; $(NORMAL)
	# Docs @ https://snapcraft.io/multipass
	sudo snap install multipass --classic --beta
	which multipass
	multipass --version

_mps_show_version:
	@$(INFO) '$(LCT_UI_LABEL)Showing version of utility ...'; $(NORMAL)
	$(MULTIPASS) --version
