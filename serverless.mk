_SERVERLESS_MK_VERSION= 0.99.3

# SLS_AWS_PROFILE= emayssat
# SLS_AWS_REGION= us-east-1
# SLS_DASHBOARD_APPLICATIONS_URL?= https://dashboard.serverless.com/tenants/emmanuelmayssat/applications
# SLS_DASHBOARD_TENANT_URL?= https://dashboard.serverless.com/tenants/emmanuelmayssat
SLS_DASHBOARD_URL?= https://dashboard.serverless.com
# SLS_MODE_DEBUG?= false
SLS_COLOR_ENABLE?= true
SLS_STAGE_NAME?= dev
# SLS_TENANT_NAME?= emmanuelmayssat

# Derived parameters
SLS_AWS_PROFILE?= $(AWS_PROFILE)
SLS_AWS_REGION?= $(AWS_REGION)
SLS_DASHBOARD_APPLICATIONS_URL?= $(SLS_DASHBOARD_TENANT_URL)/applications
SLS_DASHBOARD_TENANT_URL?= $(SLS_DASHBOARD_URL)/tenants/$(SLS_TENANT_NAME)
SLS_MODE_DEBUG?= $(CMN_MODE_DEBUG)

# Options parameters

# UI parameters
SLS_UI_LABEL?= [serverless] #

#--- Utilities

__SERVERLESS_ENVIRONMENT+= $(if $(SLS_AWS_PROFILE), AWS_PROFILE=$(SLS_AWS_PROFILE))

SERVERLESS_BIN?= serverless
SERVERLESS?= $(strip $(__SERVERLESS_ENVIRONMENT) $(SERVERLESS_ENVIRONMENT) $(SERVERLESS_BIN) $(__SERVERLESS_OPTIONS) $(SERVERLESS_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _sls_view_framework_macros
_sls_view_framework_macros ::
	@echo 'ServerLesS:: ($(_SERVERLESS_MK_VERSION)) targets:'
	@echo


_view_framework_parameters :: _sls_view_framework_parameters
_sls_view_framework_parameters ::
	@echo 'ServerLesS:: ($(_SERVERLESS_MK_VERSION)) parameters:'
	@echo '    SERVERLESS=$(SERVERLESS)'
	@echo '    SLS_AWS_PROFILE=$(SLS_AWS_PROFILE)'
	@echo '    SLS_AWS_REGION=$(SLS_AWS_REGION)'
	@echo '    SLS_COLOR_ENABLE=$(SLS_COLOR_ENABLE)'
	@echo '    SLS_DASHBOARD_APPLICATIONS_URL=$(SLS_DASHBOARD_APPLICATIONS_URL)'
	@echo '    SLS_DASHBOARD_TENANT_URL=$(SLS_DASHBOARD_TENANT_URL)'
	@echo '    SLS_DASHBOARD_URL=$(SLS_DASHBOARD_URL)'
	@echo '    SLS_MODE_DEBUG=$(SLS_MODE_DEBUG)'
	@echo '    SLS_STAGE_NAME=$(SLS_STAGE_NAME)'
	@echo '    SLS_TENANT_NAME=$(SLS_TENANT_NAME)'
	@echo

_view_framework_targets :: _sls_view_framework_targets
_sls_view_framework_targets ::
	@echo 'ServerLesS:: ($(_SERVERLESS_MK_VERSION)) targets:'
	@echo '    _sls_install_dependencies              - Install dependencies'
	@echo '    _sls_show_version                      - Show versions of utilities '
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/serverless_function.mk
-include $(MK_DIR)/serverless_plugin.mk
-include $(MK_DIR)/serverless_service.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _sls_install_dependencies
_sls_install_dependencies ::
	@$(INFO) '$(SLS_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	$(SUDO) npm install serverless -g
	which serverless
	serverless --version

_view_versions :: _sls_show_version
_sls_show_version ::
	@$(INFO) '$(SLS_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	serverless --version
