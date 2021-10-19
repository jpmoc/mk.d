_VMC_CSP_ORGANIZATIONINVITATION_MK_VERSION= $(_VMC_CSP_MK_VERSION)

# CSP_ORGANIZATIONINVITATION_ORGANIZATION_ID?= 76e6c345-0634-4cbd-be6f-XXXXXXXXXXXXX
# CSP_ORGANIZATIONINVITATION_ORGANIZATION_NAME?= my-organization
# CSP_ORGANIZATIONINVITATION_NAME?= my-invitation
# CSP_ORGANIZATIONINVITATION_EMAILS?= email@domain.com email2@domain.com

# Derived variables
CSP_ORGANIZATIONINVITATION_ORGANIZATION_ID?= $(CSP_ORGANIZATION_ID)
CSP_ORGANIZATIONINVITATION_ORGANIZATION_NAME?= $(CSP_ORGANIZATION_NAME)

# Option variables
__CSP_DATA__ORGANIZATION= $(if $(CSP_ORGANIZATION_DATA),--header "Content-Type: application/json" --data $(CSP_ORGANIZATION_DATA))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_csp_view_framework_macros ::
	@echo 'VmwareClouD::CSP::OrganizationInvitation ($(_VMC_CSP_ORGANIZATIONINVITATION_MK_VERSION)) macros:'
	@echo

_csp_view_framework_parameters ::
	@echo 'VmwareClouD::CSP::OrganizationInvitation ($(_VMC_CSP_ORGANIZATIONINVITATION_MK_VERSION)) parameters:'
	@echo '    CSP_ORGANIZATIONINVITATION_EMAILS=$(CSP_ORGANIZATIONINVITATION_EMAILS)'
	@echo '    CSP_ORGANIZATIONINVITATION_ORGANIZATION_ID=$(CSP_ORGANIZATIONINVITATION_ORGANIZATION_ID)'
	@echo '    CSP_ORGANIZATIONINVITATION_ORGANIZATION_NAME=$(CSP_ORGANIZATIONINVITATION_ORGANIZATION_NAME)'
	@echo '    CSP_ORGANIZATIONINVITATION_NAME=$(CSP_ORGANIZATIONINVITATION_NAME)'
	@echo

_csp_view_framework_targets ::
	@echo 'VmwareClouD::CSP::OrganizationInvitation ($(_VMC_CSP_ORGANIZATIONINVITATION_MK_VERSION)) targets:'
	@echo '    _csp_create_organizationinvitiaton        - Create an invitation to an organization'
	@echo '    _csp_delete_organizationinvitation        - Delete an existing invitation to an organization'
	@echo '    _csp_show_organizationinvitation          - Show everything related to an organization-invitation'
	@echo '    _csp_view_organizationinvitations         - View invitations for an organization'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csp_create_organizationinvitation:
	@$(INFO) '$(CSP_UI_LABEL)Creating organization "$(CSP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	$(CSPCURL) $(__CSP_DATA__ORGANIZATIONINVITATION) --request POST  '$(CSP_HOST_URL)/csp/gateway/am/api/orgs' | jq '.'

_csp_delete_organizationinvitation:
	@$(INFO) '$(CSP_UI_LABEL)Deleting organization "$(CSP_ORGANIZATION_NAME)" ...'; $(NORMAL)

_csp_show_organizationinvitation: _csp_show_organizationinvitation_description

_csp_show_organizationinvitation_description:
	@$(INFO) '$(CSP_UI_LABEL)Showing description of organization-invitation "$(CSP_ORGANIZATIONINVITATION_NAME)" ...'; $(NORMAL)

_csp_view_organizationinvitations:
	@$(INFO) '$(CSP_UI_LABEL)Showing invitations for organization "$(CSP_ORGANIZATIONINVITATION_ORGANIZATION_NAME)" ...'; $(NORMAL)
	$(CSPCURL) '$(CSP_HOST_URL)/csp/gateway/am/api/orgs/$(CSP_ORGANIZATIONINVITATION_ORGANIZATION_ID)/invitations' | jq '.'
