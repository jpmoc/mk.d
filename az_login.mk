_AZ_LOGIN_MK_VERSION= 0.99.0

LGN_IDENTITY_FLAG?= false
# LGN_OUTPUT_FORMAT?= table
# LGN_TENANT_ID?= b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
# LGN_TENANT_NAME?= Company, Inc

# Derived parameters
LGN_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)

# Options parameters
__LGN_IDENTITY?= $(if $(filter true, $(LGN_IDENTITY_FLAG)),--identity)
__LGN_OUTPUT?= $(if $(LGN_OUTPUT_FORMAT),--output $(LGN_OUTPUT_FORMAT))
__LGN_TENANT?= $(if $(LGN_TENANT_ID),--tenant $(LGN_TENANT_ID))

# UI parameters
LGN_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _lgn_view_framework_macros
_lgn_view_framework_macros ::
	@echo 'AZ::LoGiN ($(_AZ_LOGIN_MK_VERSION)) macros:'
	@echo

_az_view_framework_parameters :: _lgn_view_framework_parameters
_lgn_view_framework_parameters ::
	@echo 'AZ::LoGiN ($(_AZ_LOGIN_MK_VERSION)) parameters:'
	@echo '    LGN_IDENTITY_FLAG=$(LGN_IDENTITY_FLAG)'
	@echo '    LGN_OUTPUT_FORMAT=$(LGN_OUTPUT_FORMAT)'
	@echo '    LGN_TENANT_ID=$(LGN_TENANT_ID)'
	@echo '    LGN_TENANT_NAME=$(LGN_TENANT_NAME)'
	@echo

_az_view_framework_targets :: _lgn_view_framework_targets
_lgn_view_framework_targets ::
	@echo 'AZ::LoGiN ($(_AZ_LOGIN_MK_VERSION)) targets:'
	@echo '    _act_login_identity            - Logi in using the current identity'
	@echo '    _act_login_oauth               - Log in using the OAuth'
	@echo '    _act_login_serviceprincipal    - Log in using the service-principal'
	@echo '    _act_login_tenant              - Log in another tenant'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
# -include $(MK_DIR)/az_account_accesstoken.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_lgn_login_identity:
	@$(INFO) '$(LGN_UI_LABEL)Logging in in tenant "$(LGN_TENANT_NAME)" ...'; $(NORMAL)
	$(AZ) login $(__LGN_IDENTITY)

_lgn_login_oauth:
	@$(INFO) '$(LGN_UI_LABEL)Logging in using OAuth ...'; $(NORMAL)
	$(AZ) login

_lgn_login_serviceprincipal:
	@$(INFO) '$(LGN_UI_LABEL)Logging in using Service Principal ...'; $(NORMAL)
	$(AZ) login $(__LGN_SERVICE_PRINCIPAL) -u ... -p ... $(__LGN_TENANT)

_lgn_login_tenant:
	@$(INFO) '$(LGN_UI_LABEL)Logging in in tenant "$(LGN_TENANT_NAME)" ...'; $(NORMAL)
	$(AZ) login $(__LGN_TENANT)
