_EB_MK_VERSION= 0.99.3

# EB_PROFILE?=
# EB_REGION?= us-west-1

# Derived parameters

# Options parameters

# UI parameters
EB_UI_LABEL?= [eb] #

#--- Utilities
EB?= $(__EB_ENVIRONMENT) $(EB_ENVIRONMENT) eb $(__EB_OPTIONS) $(EB_OPTIONS)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _eb_install_framework_dependencies
_eb_install_framework_dependencies ::
	@echo 'EB:: ($(_EB_MK_VERSION)) dependencies:'
	pip install awsebcli --upgrade --user
	eb --version

_view_framework_macros :: _eb_view_framework_macros
_eb_view_framework_macros ::
	@#echo 'EB:: ($(_EB_MK_VERSION)) targets:'
	@#echo

_view_framework_parameters :: _eb_view_framework_parameters
_eb_view_framework_parameters ::
	@echo 'EB:: ($(_EB_MK_VERSION)) parameters:'
	@echo '    EB=$(EB)'
	@echo

_view_framework_targets :: _eb_view_framework_targets
_eb_view_framework_targets ::
	@echo 'EB:: ($(_EB_MK_VERSION)) targets:'
	@echo '    _eb_init_projectdirectory               - Initialize a project-directory'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/eb_application.mk
-include $(MK_DIR)/eb_environment.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_eb_init_projectdirectory:
	@$(INFO) '$(EB_UI_LABEL)Initializing project-directory'; $(NORMAL)
	$(EB) init
