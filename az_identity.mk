_AZ_IDENTITY_MK_VERSION= 0.99.1

# IDY_LOCATION_ID?=
# IDY_MODE_NOWAIT?= false
# IDY_MODE_YES?= false
# IDY_RESOURCEGROUP_NAME?= my-resource-group
# IDY_OUTPUT_FORMAT?= table
# IDY_SUBSCRIPTION_ID_OR_NAME?=

# IDY_IDENTITY_CLIENT_ID?= e51443bf-dbe5-43f3-b03e-73469f090622
# IDY_IDENTITY_ID?= /subscriptions/f8b96ec7-cf11-4ae2-ab75-9e7755a00594/resourcegroups/emayssat-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/MyIdentity
# IDY_IDENTITY_IDS?=
# IDY_IDENTITY_LOCATION_ID?=
# IDY_IDENTITY_NAME?= my-identity
# IDY_IDENTITY_RESOURCEGROUP_NAME?= my-resource-group
# IDY_IDENTITY_TASG_KEYVALUES?=
# IDY_IDENTITIES_RESOURCEGROUP_NAME?= my-resource-group
# IDY_IDENTITIES_SET_NAME?= my-identities-set

# Derived parameters
IDY_LOCATION_ID?= $(AZ_LOCATION_ID)
IDY_MODE_DEBUG?= $(AZ_MODE_DEBUG)
IDY_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)
IDY_RESOURCEGROUP_NAME?= $(AZ_RESOURCEGROUP_NAME)
IDY_SUBSCRIPTION_ID?= $(AZ_SUBSCRIPTION_ID)
IDY_SUBSCRIPTION_ID_OR_NAME?= $(AZ_SUBSCRIPTION_ID_OR_NAME)
IDY_SUBSCRIPTION_NAME?= $(AZ_SUBSCRIPTION_NAME)

IDY_IDENTITY_ID?= /subscriptions/$(IDY_SUBSCRIPTION_ID)/resourcegroups/$(IDY_IDENTITY_RESOURCEGROUP_NAME)/providers/Microsoft.ManagedIdentity/userAssignedIdentities/$(IDY_IDENTITY_NAME)
IDY_IDENTITY_LOCATION_ID?= $(IDY_LOCATION_ID)
IDY_IDENTITY_RESOURCEGROUP_NAME?= $(IDY_RESOURCEGROUP_NAME)
IDY_IDENTITY_SUBSCRIPTION_ID?= $(IDY_SUBSCRIPTION_ID_OR_NAME)# Id or Name?
IDY_IDENTITIES_RESOURCEGROUP_NAME?= $(IDY_IDENTITY_RESOURCEGROUP_NAME)
IDY_IDENTITIES_SET_NAME?= $(IDY_IDENTITIES_RESOURCEGROUP_NAME)

# Options parameters
__IDY_DEBUG?= $(if $(filter true,$(IDY_MODE_DEBUG)),--debug)
__IDY_OUTPUT?= $(if $(IDY_OUTPUT_FORMAT),--output $(IDY_OUTPUT_FORMAT))
__IDY_SUBSCRIPTION?= $(if $(IDY_SUBSCRIPTION_ID_OR_NAME),--subscription $(IDY_SUBSCRIPTION_ID_OR_NAME))

__IDY_IDS__IDENTITY?= $(if $(IDY_IDENTITY_IDS),--ids $(IDY_IDENTITY_IDS))
__IDY_LOCATION__IDENTITY?= $(if $(IDY_IDENTITY_LOCATION_ID),--location $(IDY_IDENTITY_LOCATION_ID))
__IDY_NAME__IDENTITY?= $(if $(IDY_IDENTITY_NAME),--name $(IDY_IDENTITY_NAME))
__IDY_RESOURCE_GROUP__IDENTITY?= $(if $(IDY_IDENTITY_RESOURCEGROUP_NAME),--resource-group $(IDY_IDENTITY_RESOURCEGROUP_NAME))
__IDY_RESOURCE_GROUP__IDENTITIES?= $(if $(IDY_IDENTITIES_RESOURCEGROUP_NAME),--resource-group $(IDY_IDENTITIES_RESOURCEGROUP_NAME))

# UI parameters
IDY_UI_LABEL?= $(AZ_UI_LABEL)

IDY_UI_SHOW_IDENTITY_FIELDS?= .{clientId:clientId,location:location,name:name,principalId:principalId,resourceGroup:resourceGroup}
IDY_UI_VIEW_IDENTITIES_FIELDS?= .{location:location,name:name,principalId:principalId,resourceGroup:resourceGroup}
IDY_UI_VIEW_IDENTITIES_SET_FIELDS?= $(IDY_UI_VIEW_IDENTITIES_FIELDS)
IDY_UI_VIEW_IDENTITIES_SET_QUERYFILTER?=

#--- Utilities

#--- MACRO

_idy_get_identity_client_id= $(call _idy_get_identity_client_id_N, $(IDY_IDENTITY_NAME))
_idy_get_identity_client_id_N= $(call _idy_get_identity_client_id_NG, $(1), $(IDY_IDENTITY_RESOURCEGROUP_NAME))
_idy_get_identity_client_id_NG= $(call _idy_get_identity_client_id_NGS, $(1), $(2), $(IDY_IDENTITY_SUBSCRIPTION_ID))
_idy_get_identity_client_id_NGS= $(shell $(AZ) identity show --name $(1) --resource-group $(2) --subscription $(3) --query "clientId" --output tsv)

_idy_get_identity_id= $(call _idy_get_identity_id_N, $(IDY_IDENTITY_NAME))
_idy_get_identity_id_N= $(call _idy_get_identity_id_NG, $(1), $(IDY_IDENTITY_RESOURCEGROUP_NAME))
_idy_get_identity_id_NG= $(call _idy_get_identity_id_NGS, $(1), $(2), $(IDY_IDENTITY_SUBSCRIPTION_ID))
_idy_get_identity_id_NGS= $(shell echo /subscriptions/$(strip $(3))/resourcegroups/$(strip $(2))/providers/Microsoft.ManagedIdentity/userAssignedIdentities/$(strip $(1)))

_idy_get_identity_principal_id= $(call _idy_get_identity_principal_id_N, $(IDY_IDENTITY_NAME))
_idy_get_identity_principal_id_N= $(call _idy_get_identity_principal_id_NG, $(1), $(IDY_IDENTITY_RESOURCEGROUP_NAME))
_idy_get_identity_principal_id_NG= $(call _idy_get_identity_principal_id_NGS, $(1), $(2), $(IDY_IDENTITY_SUBSCRIPTION_ID))
_idy_get_identity_principal_id_NGS= $(shell $(AZ) identity show --name $(1) --resource-group $(2) --subscription $(3) --query "principalId" --output tsv)

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _idy_view_framework_macros
_idy_view_framework_macros ::
	@echo 'AZ::IDentitY ($(_AZ_IDENTITY_MK_VERSION)) macros:'
	@echo '    _idy_get_identity_client_id_{|N|NG|NGS}    - Get the client-id of an identity (Name,resourceGroup,Subsc)'
	@echo '    _idy_get_identity_id_{|N|NG|NGS}           - Get the id of an identity (Name,resourceGroup,Subscription)'
	@echo '    _idy_get_identity_principal_id_{|N|NG|NGS} - Get the principal-id of an identity (Name,resourceGroup,Subsc)'
	@echo

_az_view_framework_parameters :: _idy_view_framework_parameters
_idy_view_framework_parameters ::
	@echo 'AZ::IDentitY ($(_AZ_IDENTITY_MK_VERSION)) parameters:'
	@echo '    IDY_LOCATION_ID=$(IDY_LOCATION_ID)'
	@echo '    IDY_MODE_DEBUG=$(IDY_MODE_DEBUG)'
	@echo '    IDY_OUTPUT_FORMAT=$(IDY_OUTPUT_FORMAT)'
	@echo '    IDY_SUBSCRIPTION_ID=$(IDY_SUBSCRIPTION_ID)'
	@echo '    IDY_SUBSCRIPTION_ID_OR_NAME=$(IDY_SUBSCRIPTION_ID_OR_NAME)'
	@echo '    IDY_SUBSCRIPTION_NAME=$(IDY_SUBSCRIPTION_NAME)'
	@echo '    ---'
	@echo '    IDY_IDENTITY_CLIENT_ID=$(IDY_IDENTITY_CLIENT_ID)'
	@echo '    IDY_IDENTITY_ID=$(IDY_IDENTITY_ID)'
	@echo '    IDY_IDENTITY_IDS=$(IDY_IDENTITY_IDS)'
	@echo '    IDY_IDENTITY_LOCATION_ID=$(IDY_IDENTITY_LOCATION_ID)'
	@echo '    IDY_IDENTITY_NAME=$(IDY_IDENTITY_NAME)'
	@echo '    IDY_IDENTITY_PRINCIPAL_ID=$(IDY_IDENTITY_PRINCIPAL_ID)'
	@echo '    IDY_IDENTITY_RESOURCEGROUP_NAME=$(IDY_IDENTITY_RESOURCEGROUP_NAME)'
	@echo '    IDY_IDENTITY_SUBSCRIPTION_ID=$(IDY_IDENTITY_SUBSCRIPTION_ID)'
	@echo '    IDY_IDENTITIES_RESOURCEGROUP_NAME=$(IDY_IDENTITIES_RESOURCEGROUP_NAME)'
	@echo '    IDY_IDENTITIES_SET_NAME=$(IDY_IDENTITIES_SET_NAME)'
	@echo

_az_view_framework_targets :: _idy_view_framework_targets
_idy_view_framework_targets ::
	@echo 'AZ::IDentitY ($(_AZ_IDENTITY_MK_VERSION)) targets:'
	@echo '    _idy_create_identity                    - Create a new identity'
	@echo '    _idy_delete_identity                    - Delete an existing identity'
	@echo '    _idy_show_identity                      - Show everything related to an identity'
	@echo '    _idy_show_identity_description          - Show the description of an identity'
	@echo '    _idy_show_identity_object               - Show the object of an identity'
	@echo '    _idy_show_identityprovider              - Show everything related to an identity-provider'
	@echo '    _idy_show_identityprovider_description  - Show the description of the identity-provider'
	@echo '    _idy_show_identityprovider_object       - Show the object of the identity-provider'
	@echo '    _idy_view_identities                    - View identities'
	@echo '    _idy_view_identities_set                - view a set of identities'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
# -include $(MK_DIR)/az_identity_XXXX.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_idy_create_identity:
	@$(INFO) '$(IDY_UI_LABEL)Creating identity "$(IDY_IDENTITY_NAME)" ...'; $(NORMAL)
	$(AZ) identity create $(__IDY_LOCATION__IDENTITY) $(__IDY_NAME__IDENTITY) $(__IDY_RESOURCE_GROUP__IDENTITY) $(__IDY_SUBSCRIPTION)

_idy_delete_identity:
	@$(INFO) '$(IDY_UI_LABEL)Deleting identity "$(IDY_IDENTITY_NAME)" ...'; $(NORMAL)
	$(AZ) identity delete $(__IDY_IDS__IDENTITY) $(__IDY_LOCATION_ID) $(__IDY_NAME__IDENTITY) $(__IDY_RESOURCE_GROUP__IDENTITY) $(__IDY_SUBSCRIPTION)

_idy_show_identity :: _idy_show_identity_object _idy_show_identity_description

_idy_show_identity_description:
	@$(INFO) '$(IDY_UI_LABEL)Showing description of identity "$(IDY_IDENTITY_NAME)" ...'; $(NORMAL)
	$(AZ) identity show $(__IDY_IDS__IDENTITY) $(__IDY_NAME__IDENTITY) $(__IDY_OUTPUT) $(__IDY_RESOURCE_GROUP__IDENTITY) $(__IDY_SUBSCRIPTION) --query "@$(IDY_UI_SHOW_IDENTITY_FIELDS)"

_idy_show_identity_object:
	@$(INFO) '$(IDY_UI_LABEL)Showing object of identity "$(IDY_IDENTITY_NAME)" ...'; $(NORMAL)
	$(AZ) identity show $(__IDY_IDS__IDENTITY) $(__IDY_NAME__IDENTITY) $(_X__IDY_OUTPUT) $(__IDY_RESOURCE_GROUP__IDENTITY) $(__IDY_SUBSCRIPTION)

_idy_show_identityprovider :: _idy_show_identityprovider_object _idy_show_identityprovider_description

_idy_show_identityprovider_description:
	@$(INFO) '$(IDY_UI_LABEL)Showing operations of managed-identity-provider ...'; $(NORMAL)
	$(AZ) identity list-operations $(__IDY_OUTPUT) $(__IDY_SUBSCRIPTION)

_idy_show_identityprovider_object:
	@$(INFO) '$(IDY_UI_LABEL)Showing object of managed-identity-provider ...'; $(NORMAL)
	$(AZ) identity list-operations $(_X__IDY_OUTPUT) $(__IDY_SUBSCRIPTION)

_idy_view_identities:
	@$(INFO) '$(IDY_UI_LABEL)Viewing identities ...'; $(NORMAL)
	$(AZ) identity list $(__IDY_DEBUG) $(__IDY_OUTPUT) $(_X__IDY_RESOURCE_GROUP__IDENTITIES) $(__IDY_SUBSCRIPTION) --query "[]$(IDY_UI_VIEW_IDENTITIES_FIELDS)"

_idy_view_identities_set:
	@$(INFO) '$(IDY_UI_LABEL)Viewing identities-set "$(IDY_IDENTITIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The identities are grouped based on the provided resource-group and query-filter'; $(NORMAL)
	$(AZ) identity list $(__IDY_DEBUG) $(__IDY_OUTPUT) $(__IDY_RESOURCE_GROUP__IDENTITIES) $(__IDY_SUBSCRIPTION) --query "[$(IDY_VIEW_IDENTITIES_SET_QUERYFILTER)]$(IDY_UI_VIEW_IDENTITIES_SET_FIELDS)"
