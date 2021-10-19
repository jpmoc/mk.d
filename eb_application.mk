_EB_APPLICATION_MK_VERSION= $(_EB_MK_VERSION)

# EB_PROFILE?=

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_eb_view_framework_macros ::
	@echo 'EB::Application ($(_EB_APPLICATION_MK_VERSION)) targets:'
	@echo

_eb_view_framework_parameters ::
	@echo 'EB::Application ($(_EB_APPLICATION_MK_VERSION)) parameters:'
	@echo

_eb_view_framework_targets ::
	@echo 'EB::Application ($(_EB_APPLICATION_MK_VERSION)) targets:'
	@echo '    _eb_browse_application         - Browse application'
	@echo '    _eb_deploy_application         - Deploy the application on the environment'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_eb_browse_application:
	@$(INFO) '$(EB_UI_LABEL)Browsing to website of application'; $(NORMAL)
	$(EB) open

_eb_deploy_application:
	@$(INFO) '$(EB_UI_LABEL)Deploying application to environment'; $(NORMAL)
	$(EB) deploy
