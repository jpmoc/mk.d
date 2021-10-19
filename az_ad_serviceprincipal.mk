_AZ_AD_SERVICEPRINCIPAL_MK_VERSION= $(_AZ_AD_MK_VERSION)

# AD_SERVICEPRINCIPAL_ID?= /subscriptions/<subscriptionid>/serviceprincipals/my-service-principal
# AD_SERVICEPRINCIPAL_NAME?= my-service-principal
# AD_SERVICEPRINCIPAL_OBJECT_ID?= 8ab0a742-652f-48b9-a449-62b394a769a1
# AD_SERVICEPRINCIPAL_PASSWORD?= d7e1e4fc-c4c6-4578-8562-XXXXXXXXX
# AD_SERVICEPRINCIPAL_ROLE_NAME?= Contributor
# AD_SERVICEPRINCIPAL_SCOPES?= /subscription/f8b96ec7-cf11-4ae2-ab75-9e7755a00594
# AD_SERVICEPRINCIPAL_TENANT_ID?= b39138ca-3cee-4b4a-a4d6-XXXXXX
AD_SERVICEPRINCIPAL_YEARS_COUNT?= 1
# AD_SERVICEPRINCIPALS_DISPLAY_NAME?=
# AD_SERVICEPRINCIPALS_SHOWMINE_FLAG?= false
# AD_SERVICEPRINCIPALS_SET_NAME?= my-service-principal-set

# Derived parameters
AD_SERVICEPRINCIPAL_NAME?= $(AZ_SERVICEPRINCIPAL_NAME)
AD_SERVICEPRINCIPAL_TENANT_ID?= $(AZ_TENANT_ID)

# Options parameters
__AD_ADD=
__AD_ALL= --all
__AD_ASSIGNEE__SERVICEPRINCIPAL= $(if $(AD_SERVICEPRINCIPAL_ID),--assignee $(AD_SERVICEPRINCIPAL_ID))
__AD_ID__SERVICEPRINCIPAL= $(if $(AD_SERVICEPRINCIPAL_ID),--id $(AD_SERVICEPRINCIPAL_ID))
__AD_NAME__SERVICEPRINCIPAL= $(if $(AD_SERVICEPRINCIPAL_NAME),--name $(AD_SERVICEPRINCIPAL_NAME))
__AD_DISPLAY_NAME__SERVICEPRINCIPAL= $(if $(AD_SERVICEPRINCIPAL_DISPLAYNAME),--display-name $(AD_SERVICEPRINCIPAL_DISPLAYNAME))
__AD_DISPLAY_NAME__SERVICEPRINCIPALS= $(if $(AD_SERVICEPRINCIPALS_DISPLAYNAME),--display-name $(AD_SERVICEPRINCIPALS_DISPLAYNAME))
__AD_FILTER__SERVICEPRINCIPALS= $(if $(AD_SERVICEPRINCIPALS_FILTER),--filter $(AD_SERVICEPRINCIPALS_FILTER))
__AD_FORCE_STRING=
# __AD_OUTPUT?=
__AD_PASSWORD__SERVICEPRINCIPAL= $(if $(AD_SERVICEPRINCIPAL_PASSWORD),--password $(AD_SERVICEPRINCIPAL_PASSWORD))
__AD_REMOVE=
__AD_ROLE__SERVICEPRINCIPAL= $(if $(AD_SERVICEPRINCIPAL_ROLE_NAME),--role $(AD_SERVICEPRINCIPAL_ROLE_NAME))
__AD_SHOW_MINE__SERVICEPRINCIPALS= $(if $(AD_SERVICEPRINCIPALS_SHOWMINE_FLAG),--show-mine)
__AD_SCOPES__SERVICEPRINCIPAL= $(if $(AD_SERVICEPRINCIPAL_SCOPES),--scopes $(AD_SERVICEPRINCIPAL_SCOPES))
__AD_SET=
__AD_YEARS= $(if $(AD_SERVICEPRINCIPAL_YEARS_COUNT),--years $(AD_SERVICEPRINCIPAL_YEARS_COUNT))

# Pipe

# UI parameters
AD_UI_SHOW_SERVICEPRINCIPAL_DESCRIPTION_FIELDS?= .{appDisplayName:appDisplayName,appId:appId,objectId:objectId,displayName:displayName,servicePrincipalType:servicePrincipalType}
AD_UI_SHOW_SERVICEPRINCIPAL_ROLES_FIELDS?= .{name:name,principalType:principalType,roleDefinitionName:roleDefinitionName,principalName:principalName,resourceGroup:resourceGroup,scope:scope}

#--- Utilities

#--- MACRO
_ad_get_serviceprincipal_id= $(call _ad_get_serviceprincipal_id_N, $(AD_SERVICEPRINCIPAL_DISPLAYNAME))
_ad_get_serviceprincipal_id_N=

_ad_get_serviceprincipal_object_id= $(call _ad_get_serviceprincipal_object_id_I, $(AD_SERVICEPRINCIPAL_ID))
_ad_get_serviceprincipal_object_id_I= $(shell $(AZ) ad sp show --id $(1) --query "@.objectId" --output tsv)

_ad_get_serviceprincipal_tenant_id= $(call _ad_get_serviceprincipal_tenant_id_I, $(AD_SERVICEPRINCIPAL_ID))
_ad_get_serviceprincipal_tenant_id_I= $(shell $(AZ) ad sp show --id $(1) --query "@.appOwnerTenantId" --output tsv)

#----------------------------------------------------------------------
# USAGE
#

_ad_view_framework_macros ::
	@echo 'AZ::AD::ServicePrincipal ($(_AZ_AD_SERVICEPRINCIPAL_MK_VERSION)) macros:'
	@echo '    _ad_get_serviceprincipal_id_{|N}        - Get the id of a service-principal (displayName)'
	@echo '    _ad_get_serviceprincipal_object_id_{|I} - Get the object-id of a service-principal (id)'
	@echo '    _ad_get_serviceprincipal_tenant_id_{|I} - Get the tenant-id of a service-principal (id)'
	@echo

_ad_view_framework_parameters ::
	@echo 'AZ::AD::ServicePrincipal ($(_AZ_AD_SERVICEPRINCIPAL_MK_VERSION)) parameters:'
	@echo '    AD_SERVICEPRINCIPAL_DISPLAYNAME=$(AD_SERVICEPRINCIPAL_DISPLAYNAME)'
	@echo '    AD_SERVICEPRINCIPAL_ID=$(AD_SERVICEPRINCIPAL_ID)'
	@echo '    AD_SERVICEPRINCIPAL_NAME=$(AD_SERVICEPRINCIPAL_NAME)'
	@echo '    AD_SERVICEPRINCIPAL_OBJECT_ID=$(AD_SERVICEPRINCIPAL_OBJECT_ID)'
	@echo '    AD_SERVICEPRINCIPAL_PASSWORD=$(AD_SERVICEPRINCIPAL_PASSWORD)'
	@echo '    AD_SERVICEPRINCIPAL_ROLE_NAME=$(AD_SERVICEPRINCIPAL_ROLE_NAME)'
	@echo '    AD_SERVICEPRINCIPAL_SCOPES=$(AD_SERVICEPRINCIPAL_SCOPES)'
	@echo '    AD_SERVICEPRINCIPAL_TENANT_ID=$(AD_SERVICEPRINCIPAL_TENANT_ID)'
	@echo '    AD_SERVICEPRINCIPAL_YEARS_COUNT=$(AD_SERVICEPRINCIPAL_YEARS_COUNT)'
	@echo '    AD_SERVICEPRINCIPALS_DISPLAYNAME=$(AD_SERVICEPRINCIPALS_DISPLAYNAME)'
	@echo '    AD_SERVICEPRINCIPALS_SHOWMINE_FLAG=$(AD_SERVICEPRINCIPALS_SHOWMINE_FLAG)'
	@echo '    AD_SERVICEPRINCIPALS_SET_NAME=$(AD_SERVICEPRINCIPALS_SET_NAME)'
	@echo

_ad_view_framework_targets ::
	@echo 'AZ::AD::ServicePrincipal ($(_AZ_AD_SERVICEPRINCIPAL_MK_VERSION)) targets:'
	@echo '    _ad_create_serviceprincipal             - Create a service-principal'
	@echo '    _ad_create_serviceprincipal_forazure    - Create a service-principal for azure'
	@echo '    _ad_delete_serviceprincipal             - Delete a service-principal'
	@echo '    _ad_show_serviceprincipal               - Show everything related to a service-principal'
	@echo '    _ad_show_serviceprincipal_credentials   - Show credentials of a service-principal'
	@echo '    _ad_show_serviceprincipal_description   - Show desription of a service-principal'
	@echo '    _ad_show_serviceprincipal_object        - Show the object of a service-principal'
	@echo '    _ad_show_serviceprincipal_owner         - Show the owner of a service-principal'
	@echo '    _ad_update_serviceprincipal             - Update a service-principal'
	@echo '    _ad_update_serviceprincipal_forazure    - Update a service-principal for azure'
	@echo '    _ad_view_serviceprincipals              - View service-principals'
	@echo '    _ad_view_serviceprincipals_set          - View a set of service-principals'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ad_create_serviceprincipal:
	@$(INFO) '$(AD_UI_LABEL)Creating service-principal "$(AD_SERVICEPRINCIPAL_NAME)" ...'; $(NORMAL)
	$(AZ) ad sp create $(__AD_ID__SERVICEPRINCIPAL) $(__AD_OUTPUT) $(__AD_SUBSCRIPTION)

_ad_create_serviceprincipal_forazure:
	@$(INFO) '$(AD_UI_LABEL)Creating/updating service-principal "$(AD_SERVICEPRINCIPAL_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a service principal and configure it to access azure resources'; $(NORMAL)
	@$(WARN) 'Note that the password field is updated each time a creation/update occurs'; $(NORMAL)
	$(AZ) ad sp create-for-rbac $(__AD_CERT) $(__AD_CREATE_CERT) $(__AD_KEYVAULT) $(__AD_NAME__SERVICEPRINCIPAL) $(__AD_OUTPUT) $(_X__AD_PASSWORD__SERVICEPRINCIPAL) $(__AD_ROLE__SERVICEPRINCIPAL) $(__AD_SCOPES__SERVICEPRINCIPAL) $(__AD_SDK_AUTH) $(__AD_SKIP_ASSIGNMENT) $(_X__AD_SUBSCRIPTION) $(__AD_YEARS)

_ad_delete_serviceprincipal:
	@$(INFO) '$(AD_UI_LABEL)Deleting service-principal "$(AD_SERVICEPRINCIPAL_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation deletes the SP and removes corresponding role-assignments'; $(NORMAL)
	$(AZ) ad sp delete $(__AD_ID__SERVICEPRINCIPAL) $(__AD_OUTPUT) $(_X__AD_SUBSCRIPTION)

_ad_show_serviceprincipal :: _ad_show_serviceprincipal_credentials _ad_show_serviceprincipal_object _ad_show_serviceprincipal_owner _ad_show_serviceprincipal_roles _ad_show_serviceprincipal_description

_ad_show_serviceprincipal_description:
	@$(INFO) '$(AD_UI_LABEL)Showing description of service-principal "$(AD_SERVICEPRINCIPAL_NAME)" ...'; $(NORMAL)
	$(AZ) ad sp show $(__AD_ADD) $(__AD_FORCE_STRING) $(__AD_ID__SERVICEPRINCIPAL) $(__AD_OUTPUT) $(__AD_REMOVE) $(__AD_SET) $(_X__AD_SUBSCRIPTION) --query "@$(AD_UI_SHOW_SERVICEPRINCIPAL_DESCRIPTION_FIELDS)"

_ad_show_serviceprincipal_credentials:
	@$(INFO) '$(AD_UI_LABEL)Showing credentials of service-principal "$(AD_SERVICEPRINCIPAL_NAME)" ...'; $(NORMAL)
	$(AZ) ad sp credential list $(__AD_ID__SERVICEPRINCIPAL) $(__AD_OUTPUT) $(_X__AD_SUBSCRIPTION)

_ad_show_serviceprincipal_object:
	@$(INFO) '$(AD_UI_LABEL)Showing the object of service-principal "$(AD_SERVICEPRINCIPAL_NAME)" ...'; $(NORMAL)
	$(AZ) ad sp show $(__AD_ID__SERVICEPRINCIPAL) $(_X__AD_OUTPUT) $(_X__AD_SUBSCRIPTION) --output json

_ad_show_serviceprincipal_owner:
	@$(INFO) '$(AD_UI_LABEL)Showing owner of service-principal "$(AD_SERVICEPRINCIPAL_NAME)" ...'; $(NORMAL)
	$(AZ) ad sp owner list $(__AD_ID__SERVICEPRINCIPAL) $(__AD_OUTPUT) $(_X__AD_SUBSCRIPTION)

_ad_show_serviceprincipal_roles:
	@$(INFO) '$(AD_UI_LABEL)Showing roles of service-principal "$(AD_SERVICEPRINCIPAL_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the roles/rights for the SP in the provided subscription'; $(NORMAL)
	@$(WARN) 'Beware that resource can also have access-policies, such as keyvault for individual secrets'; $(NORMAL)
	$(AZ) role assignment list --all $(__AD_ASSIGNEE__SERVICEPRINCIPAL) $(__AD_OUTPUT) $(__AD_SUBSCRIPTION) --query "[]$(AD_UI_SHOW_SERVICEPRINCIPAL_ROLES_FIELDS)"

_ad_update_serviceprincipal:
	@$(INFO) '$(AD_UI_LABEL)Updating service-principal "$(AD_SERVICEPRINCIPAL_NAME)" ...'; $(NORMAL)
	$(AZ) ad sp update $(__AD_ID__SERVICEPRINCIPAL) $(__AD_OUTPUT) $(__AD_SET) $(__AD_SUBSCRIPTION)

_ad_update_serviceprincipal_forazure: _ad_create_serviceprincipal_forazure

_ad_view_serviceprincipals:
	@$(INFO) '$(AD_UI_LABEL)Viewing service-principals ...'; $(NORMAL)
	$(AZ) ad sp list $(__AD_ALL) $(__AD_DISPLAY_NAME__SERVICEPRINCIPALS) $(__AD_FILTER__SERVICEPRINCIPALS) $(__AD_OUTPUT) $(__AD_SHOW_MINE__SERVICEPRINCIPALS) $(__AD_SPN) $(__AD_SUBSCRIPTION)

_ad_view_serviceprincipals_set:
	@$(INFO) '$(AD_UI_LABEL)Viewing service-principals-set "$(AD_SERVICEPRINCIPALS_SET_NAME) ...'; $(NORMAL)
	$(AZ) ad sp list $(_X__AD_ALL) $(__AD_DISPLAY_NAME__SERVICEPRINCIPALS) $(__AD_FILTER__SERVICEPRINCIPALS) $(__AD_OUTPUT) $(__AD_SHOW_MINE__SERVICEPRINCIPALS) $(__AD_SPN) $(__AD_SUBSCRIPTION)
