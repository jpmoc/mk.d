_AZ_ACCOUNT_MK_VERSION= 0.99.0

# ACT_OUTPUT_FORMAT?= table
# ACT_TENANT_ID?= b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
# ACT_TENANT_NAME?= Company, Inc

# Derived parameters
ACT_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)

# Options parameters
__ACT_OUTPUT?= $(if $(ACT_OUTPUT_FORMAT),--output $(ACT_OUTPUT_FORMAT))

# UI parameters
ACT_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- MACRO
_act_get_tenant_id= $(shell $(AZ) account list --all --query "[0].tenantId" --output tsv)

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _act_view_framework_macros
_act_view_framework_macros ::
	@echo 'AZ::ACcounT ($(_AWS_LOGS_MK_VERSION)) macros:'
	@echo '    _act_get_tenant_id        - Get the tenant-ID'
	@echo

_az_view_framework_parameters :: _act_view_framework_parameters
_act_view_framework_parameters ::
	@echo 'AZ::ACcounT ($(_AZ_ACCOUNT_MK_VERSION)) parameters:'
	@echo '    ACT_OUTPUT_FORMAT=$(ACT_OUTPUT_FORMAT)'
	@echo '    ACT_TENANT_ID=$(ACT_TENANT_ID)'
	@echo '    ACT_TENANT_NAME=$(ACT_TENANT_NAME)'
	@echo

_az_view_framework_targets :: _grp_view_framework_targets
_grp_view_framework_targets ::
	@echo 'AZ::ACcounT ($(_AZ_ACCOUNT_MK_VERSION)) targets:'
	@echo '    _act_view_locations               - View locations'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/az_account_accesstoken.mk
-include $(MK_DIR)/az_account_subscription.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_act_view_locations:
	@$(INFO) '$(ACT_UI_LABEL)Viewing locations ...'; $(NORMAL)
	$(AZ) account list-locations $(__ACT_OUTPUT) # --query "destinations[]$(LGS_UI_VIEW_DESTINATIONS_FIELDS)"
