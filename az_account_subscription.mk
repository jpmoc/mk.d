_AZ_ACCOUNT_SUBSCRIPTION_MK_VERSION= $(_AZ_ACCOUNT_MK_VERSION)

# ACT_SUBSCRIPTION_ID?= 59b066b1-4bd5-4a01-bbb1-14ee71d3d7fc
# ACT_SUBSCRIPTION_ID_OR_NAME?= 59b066b1-4bd5-4a01-bbb1-14ee71d3d7fc
# ACT_SUBSCRIPTION_NAME?= my-subscription
# ACT_SUBSCRIPTION_TENANT_NAME?= Company, Inc.
# ACT_SUBSCRIPTIONS_SET_NAME?= my-subscriptions-set

# Derived parameters
ACT_SUBSCRIPTION_ID?= $(AZ_SUBSCRIPTION_ID)
ACT_SUBSCRIPTION_ID_OR_NAME?= $(if $(ACT_SUBSCRIPTION_ID),$(ACT_SUBSCRIPTION_ID),$(ACT_SUBSCRIPTION_NAME))
ACT_SUBSCRIPTION_NAME?= $(AZ_SUBSCRIPTION_NAME)

# Options parameters
__ACT_ALL= --all
__ACT_REFRESH= --refresh
__ACT_SUBSCRIPTION= $(if $(ACT_SUBSCRIPTION_ID),--subscription $(ACT_SUBSCRIPTION_ID))

# UI parameters

#--- Utilities

#--- MACRO
_act_get_subscription_id= $(call _act_get_subscription_id_N, $(ACT_SUBSCRIPTION_NAME))
_act_get_subscription_id_N= $(shell $(AZ) account list --all --refresh --query "[? name=='$(strip $(1))'].id" --output tsv)

_act_get_subscription_name= $(call _act_get_subscription_name_I, $(ACT_SUBSCRIPTION_ID))
_act_get_subscription_name_I= $(shell $(AZ) account list --all --refresh --query "[? id=='$(strip $(1))'].name" --output tsv)

_act_get_subscription_tenant_id= $(call _act_get_subscription_id_N, $(ACT_SUBSCRIPTION_ID_OR_NAME))
_act_get_subscription_tenant_id_N= $(shell $(AZ) account show --subscription $(1) --query "tenantId" --output tsv)

#----------------------------------------------------------------------
# USAGE
#

_act_view_framework_macros ::
	@echo 'AZ::ACcounT::Subscription ($(_AZ_ACCOUNT_SUBSCRIPTION_MK_VERSION)) macros:'
	@echo '    _act_get_subscription_id_{|N}          - Get ID of a subscription (Name)'
	@echo '    _act_get_subscription_name_{|I}        - Get name of a subscription (Id)'
	@echo '    _act_get_subscription_tenant_id_{|N}   - Get tenant-ID of a subscription (Name)'
	@echo

_act_view_framework_parameters ::
	@echo 'AZ::ACcounT::Subscription ($(_AZ_ACCOUNT_SUBSCRIPTION_MK_VERSION)) parameters:'
	@echo '    ACT_SUBSCRIPTION_ID=$(ACT_SUBSCRIPTION_ID)'
	@echo '    ACT_SUBSCRIPTION_NAME=$(ACT_SUBSCRIPTION_NAME)'
	@echo '    ACT_SUBSCRIPTIONS_SET_NAME=$(ACT_SUBSCRIPTIONS_SET_NAME)'
	@echo

_act_view_framework_targets ::
	@echo 'AZ::ACcounT::Subscription ($(_AZ_ACCOUNT_SUBSCRIPTION_MK_VERSION)) targets:'
	@echo '    _act_create_subscription               - Create a subscription'
	@echo '    _act_delete_subscription               - Delete a subscription'
	@echo '    _act_show_subscription                 - Show everything related to a subscription'
	@echo '    _act_show_subscription_description     - Show description of a subscription'
	@echo '    _act_view_subscriptions                - View subscriptions'
	@echo '    _act_view_subscriptions_set            - View subscriptions-set'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_act_create_subscription:

_act_delete_subscription:

_cft_view_defaults :: _act_show_defaultsubscription
_act_show_defaultsubscription:
	@$(INFO) '$(ACT_UI_LABEL)Showing the default subscription ...'; $(NORMAL)
	$(AZ) account list $(__ACT_ALL) $(__ACT_OUTPUT) $(__ACT_REFRESH) --query "[? isDefault]"

_act_set_defaultsubscription:
	@$(INFO) '$(ACT_UI_LABEL)Setting the default subscription to subscription "$(ACT_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(AZ) account set $(__ACT_OUTPUT) $(__ACT_SDK_AUTH) $(__ACT_SUBSCRIPTION)

_act_show_subscription: _act_show_subscription_object _act_show_subscription_description

_act_show_subscription_description:
	@$(INFO) '$(ACT_UI_LABEL)Showing description of subscription "$(ACT_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(AZ) account show $(__ACT_OUTPUT) $(__ACT_SDK_AUTH) $(__ACT_SUBSCRIPTION)

_act_show_subscription_object:
	@$(INFO) '$(ACT_UI_LABEL)Showing object of subscription "$(ACT_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(AZ) account show $(_X__ACT_OUTPUT) $(__ACT_SDK_AUTH) $(__ACT_SUBSCRIPTION)

_act_view_subscriptions:
	@$(INFO) '$(ACT_UI_LABEL)Viewing subscriptions ...'; $(NORMAL)
	$(AZ) account list $(__ACT_ALL) $(__ACT_OUTPUT) $(__ACT_REFRESH)

_act_view_subscriptions_set:
	@$(INFO) '$(ACT_UI_LABEL)Viewing subscriptions-set "$(ACT_SUBSCRIPTIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Subscriptions are grouped based on enable-status'; $(NORMAL) 
	$(AZ) account list $(_X__ACT_ALL) $(__ACT_OUTPUT) $(__ACT_REFRESH)
