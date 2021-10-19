_SCP_MK_VERSION= 0.99.4

SCP_CONFIG_DIRPATH?= $(HOME)/.ssh/
SCP_CONFIG_FILENAME?= config
# SCP_CONFIG_FILEPATH?= $(HOME)/.ssh/config
SCP_HOST_PORT?= 22
SCP_HOSTKEYCHECKING_FLAG?= true
# SCP_INPUTS_DIRPATH?= ./in/
# SCP_OUTPUTS_DIRPATH?= ./out/

# Derived parameters A
SCP_CONFIG_FILEPATH?= $(SCP_CONFIG_DIRPATH)$(SCP_CONFIG_FILENAME)
SCP_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
SCP_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Option parameters
__SCP_CONFIG= $(if $(SCP_CONFIG_FILEPATH),-F $(SCP_CONFIG_FILEPATH))
__SCP_HOST_KEY_CHECKING= $(if $(filter false,$(SCP_HOSTKEYCHECKING_FLAG)),-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no)

# UI parameters
SCP_UI_LABEL?= [scp] #

#--- Utilities
__SCP_OPTIONS+= $(__SCP_CONFIG)
__SCP_OPTIONS+= $(__SCP_HOST_KEY_CHECKING)
SCP_BIN?= scp
SCP?= $(strip $(__SCP_ENVIRONMENT) $(SCP_ENVIRONMENT) $(SCP_BIN) $(__SCP_OPTIONS) $(SCP_OPTIONS))

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _scp_view_framework_macros
_scp_view_framework_macros ::
	@echo 'SCP ($(_SCP_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _scp_view_framework_parameters
_scp_view_framework_parameters ::
	@echo 'SCP ($(_SCP_MK_VERSION)) parameters:'
	@echo '    SCP=$(SCP)'
	@echo '    SCP_CONFIG_DIRPATH=$(SCP_CONFIG_DIRPATH)'
	@echo '    SCP_CONFIG_FILENAME=$(SCP_CONFIG_FILENAME)'
	@echo '    SCP_CONFIG_FILEPATH=$(SCP_CONFIG_FILEPATH)'
	@echo '    SCP_HOST_KEYCHECKING_FLAG=$(SCP_HOST_KEYCHEKING_FLAG)'
	@echo '    SCP_HOST_PORT=$(SCP_HOST_PORT)'
	@echo '    SCP_INPUTS_DIRPATH=$(SCP_INPUTS_DIRPATH)'
	@echo '    SCP_OUTPUTS_DIRPATH=$(SCP_OUTPUTS_DIRPATH)'
	@echo

_view_framework_targets :: _scp_view_framework_targets
_scp_view_framework_targets ::
	@echo 'SCP ($(_SCP_MK_VERSION)) targets:'
	@echo '    _scp_view_versions                  - View versions of depedencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/scp_remoteuser.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_view_versions :: _scp_view_versions
_scp_view_versions:
	@$(INFO) '$(SCP_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(SCP) -V
