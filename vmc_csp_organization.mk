_VMC_CSP_ORGANIZATION_MK_VERSION= $(_VMC_CSP_MK_VERSION)

# CSP_ORGANIZATION_DATA?= '{"displayName":"my-organization"}'
# CSP_ORGANIZATION_DATA_FILEPATH?= ./organization.json
# CSP_ORGANIZATION_ID?= 76e6c345-0634-4cbd-be6f-XXXXXXXXXXXXX
# CSP_ORGANIZATION_LINK?= /csp/gateway/am/api/orgs/76e6c345-0634-4cbd-be6f-XXXXXXXXXXXXX
# CSP_ORGANIZATION_NAME?= 'my-organization'

# Derived variables
CSP_ORGANIZATION_DATA?= $(if $(CSP_ORGANIZATION_DATA_FILEPATH),'@$(CSP_ORGANIZATION_DATA_FILEPATH)','{"displayName": "$(CSP_ORGANIZATION_NAME)"}')
CSP_ORGANIZATION_LINK?= /csp/gateway/am/api/orgs/$(strip $(CSP_ORGANIZATION_ID))

# Option variables
__CSP_DATA__ORGANIZATION= $(if $(CSP_ORGANIZATION_DATA),--header "Content-Type: application/json" --data $(CSP_ORGANIZATION_DATA))
__CSP_LINK__ORGANIZATION= $(if $(CSP_ORGANIZATION_LINK), --link $(CSP_ORGANIZATION_LINK))
__CSP_ORG= $(if $(CSP_ORGANIZATION_LINK), --org $(CSP_ORGANIZATION_LINK))

# UI variables
 
#--- Utilities

#--- MACROS

_csp_get_organization_name= $(call _csp_get_organization_name_L, $(CSP_ORGANIZATION_LINK))
# $(CSP) may fail because of the verbose options!
_csp_get_organization_name_L= $(shell csp org get --link $(1) | jq -r '.displayName')

#----------------------------------------------------------------------
# USAGE
#

_csp_view_framework_macros ::
	@echo 'VmwareClouD::CSP::Organization ($(_VMC_CSP_ORGANIZATION_MK_VERSION)) macros:'
	@echo '    _csp_get_organization_name_{|L}           - Get the name of the organization (Link)'
	@echo

_csp_view_framework_parameters ::
	@echo 'VmwareClouD::CSP::Organization ($(_VMC_CSP_ORGANIZATION_MK_VERSION)) parameters:'
	@echo '    CSP_ORGANIZATION_ID=$(CSP_ORGANIZATION_ID)'
	@echo '    CSP_ORGANIZATION_LINK=$(CSP_ORGANIZATION_LINK)'
	@echo '    CSP_ORGANIZATION_NAME=$(CSP_ORGANIZATION_NAME)'
	@echo

_csp_view_framework_targets ::
	@echo 'VmwareClouD::CSP::Organization ($(_VMC_CSP_ORGANIZATION_MK_VERSION)) targets:'
	@echo '    _csp_create_organization                  - Create a new organization'
	@echo '    _csp_delete_organization                  - Delete an existing organization'
	@echo '    _csp_show_organization                    - Show everything related to a organization'
	@echo '    _csp_view_organizations                   - View organizations'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csp_create_organization:
	@$(INFO) '$(CSP_UI_LABEL)Creating organization "$(CSP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation requires the user to use a valid refresh token from an existing organization!'; $(NORMAL)
	@$(WARN) 'The default organization name is "Firstname Lastname`s organization"'; $(NORMAL)
	$(CSPCURL) $(__CSP_DATA__ORGANIZATION) --request POST  '$(CSP_HOST_URL)/csp/gateway/am/api/orgs' | jq '.'
	@$(WARN) 'Now if you log in $(CSP_HOST_URL), your user will see the new organization'; $(NORMAL)
	@$(WARN) 'You will need to complete the creation of the CSP organization by providing additional info (address, etc)'; $(NORMAL)
	@$(WARN) 'BEWARE: To progammatically access this new organization, you need first to login to create a refresh token'; $(NORMAL)
	#
	# $(CSP) org create
	#
	@$(WARN) 'The organization ID is the end of the refLink'; $(NORMAL)

_csp_delete_organization:
	@$(INFO) '$(CSP_UI_LABEL)Deleting organization "$(CSP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'In non-production environment, this operation is only authorized to org_owners'; $(NORMAL)
	@$(WARN) 'In production environment, this operation is only authorized to platform_operators'; $(NORMAL)
	# $(CSPCURL) --request DELETE "$(CSP_HOST_URL)/csp/gateway/am/api/orgs/$(CSP_ORGANIZATION_ID)"

_csp_show_organization: _csp_show_organization_invitations _csp_show_organization_roles _csp_show_organization_services _csp_show_organization_suborganizations _csp_show_organization_users _csp_show_organization_description

_csp_show_organization_description:
	@$(INFO) '$(CSP_UI_LABEL)Showing description of organization "$(CSP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	$(CSP) org get $(__CSP_LINK__ORGANIZATION)

_csp_show_organization_invitations:
	@$(INFO) '$(CSP_UI_LABEL)Showing invitations for organization "$(CSP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	$(CSPCURL) '$(CSP_HOST_URL)/csp/gateway/am/api/orgs/$(CSP_ORGANIZATION_ID)/invitations' | jq '.'

_csp_show_organization_roles:
	@$(INFO) '$(CSP_UI_LABEL)Showing roles in organization "$(CSP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If this operation returns the "Service Owner" role, then this organization is a service organization'; $(NORMAL)
	$(CSPCURL) --show-error --silent '$(CSP_HOST_URL)/csp/gateway/am/api/orgs/$(CSP_ORGANIZATION_ID)/roles' | jq '.'
	#
	$(CSP) org roles get $(__CSP_LINK__ORGANIZATION)

_csp_show_organization_services: _csp_show_organization_accessibleservices _csp_show_organization_availableservices _csp_show_organization_ownedservices

_csp_show_organization_accessibleservices:
	@$(INFO) '$(CSP_UI_LABEL)Showing accessible-services for organization "$(CSP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns services that organization users have access to'; $(NORMAL)
	@echo "To be imlemented! But check the user service-roles as a work around!"

_csp_show_organization_availableservices:
	@$(INFO) '$(CSP_UI_LABEL)Showing services available to organization "$(CSP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT return existing GATED services for which you have not received an invitation!'; $(NORMAL) 
	$(CSP) org services show $(__CSP_ORG) | jq -r '.servicesRoles[] | [.serviceId, .serviceDisplayName] | @tsv' | sort -k2
	@$(WARN) 'This operation does NOT return existing GATED services for which you have not received an invitation!'; $(NORMAL) 

_csp_show_organization_ownedservices:
	@$(INFO) '$(CSP_UI_LABEL)Showing services owned by organization "$(CSP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Only a service-owner organization can own and manage services'; $(NORMAL)
	$(CSP) org services show $(__CSP_ORG) | jq -r '.servicesRoles[select(.orgId=="$(CSP_ORGANIZATION_ID)")]'

_csp_show_organization_suborganizations:
	@$(INFO) '$(CSP_UI_LABEL)Showing sub-organizations of organization "$(CSP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	$(CSPCURL) --request GET '$(CSP_HOST_URL)/csp/gateway/am/api/orgs/$(CSP_ORGANIZATION_ID)/sub-orgs' | jq '.'

_csp_show_organization_users:
	@$(INFO) '$(CSP_UI_LABEL)Showing users in organization "$(CSP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the services and service-roles for each organization member/user'; $(NORMAL)
	$(CSPCURL) --show-error --silent '$(CSP_HOST_URL)/csp/gateway/am/api/v2/orgs/$(CSP_ORGANIZATION_ID)/users' | jq '.'
	#
	# Deprecated command line
	# $(CSP) org users show $(__CSP_ORG)
	#

_csp_view_organizations:
	@$(INFO) '$(CSP_UI_LABEL)Viewing available organizations ...'; $(NORMAL)
