_VMC_CSP_SERVICEINVITATION_MK_VERSION= $(_VMC_CSP_MK_VERSION)

CSP_SERVICEINVITATION_COUNT?= 1
# CSP_SERVICEINVITATION_FILEPATH?= ./service-invitation.json
# CSP_SERVICEINVITATION_ID?= 873d8451-db05-41fa-beb4-e74095585554
# CSP_SERVICEINVITATION_LINK?= /csp/slc/api/service-invitations/873d8451-db05-41fa-beb4-e74095585554
# CSP_SERVICEINVITATION_NAME?= 'my-service-invitation'
# CSP_SERVICEINVITATION_SERVICE_ID?=
# CSP_SERVICEINVITATION_SERVICE_NAME?=
# CSP_SERVICEINVITATION_SERVICEDEFINITION_LINK?= /csp/gateway/slc/api/definitions/external/f737e6c9-1aae-4066-9f43-e8744ceed436
# CSP_SERVICEINVITATION_URL?= https://console-stg.cloud.vmware.com/csp/gateway/portal/api/service-invitations?serviceInvitationLink=/csp/slc/api/service-invitations/873d8451-db05-41fa-beb4-e74095585554
# CSP_SERVICEINVITATIONS_SET_NAME?= my-serviceinvitations-set

# Derived variables
CSP_SERVICEINVITATION_LINK?= /csp/slc/api/service-invitations/$(CSP_SERVICEINVITATION_ID)
CSP_SERVICEINVITATION_NAME?= $(CSP_SERVICEINVITATION_SERVICE_NAME):ServiceInvitation
CSP_SERVICEINVITATION_SERVICE_ID?= $(CSP_SERVICE_ID)
CSP_SERVICEINVITATION_SERVICE_NAME?= $(CSP_SERVICE_NAME)
CSP_SERVICEINVITATION_URL?= $(CSP_HOST_URL)/csp/gateway/portal/api/service-invitations?serviceInvitationLink=$(CSP_SERVICEINVITATION_LINK)
CSP_SERVICEINVITATION_SERVICEDEFINITION_LINK?= $(CSP_SERVICEDEFINITION_LINK)

# Option variables
__CSP_DEFINITION__SERVICEINVITATION= $(if $(CSP_SERVICEINVITATION_SERVICEDEFINITION_LINK),--definition $(CSP_SERVICEINVITATION_SERVICEDEFINITION_LINK))
__CSP_DATA__SERVICEINVITATION= $(if $(CSP_SERVICEINVITATION_FILEPATH),--data @$(CSP_SERVICEINVITATION_FILEPATH),--data '{"isFundMandatory": false, "numberOfInvitationsToGenerate": $(CSP_SERVICEINVITATION_COUNT), "serviceDefinitionLink": "/csp/gateway/slc/api/definitions/external/$(CSP_SERVICEINVITATION_SERVICE_ID)"}')

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

# SWAGGER @ https://console-stg.cloud.vmware.com/csp/gateway/slc/api/swagger-ui.html

_csp_view_framework_macros ::
	@echo 'VmwareClouD::CSP::ServiceInvitation ($(_VMC_CSP_SERVICEINVITATION_MK_VERSION)) macros:'
	@echo

_csp_view_framework_parameters ::
	@echo 'VmwareClouD::CSP::ServiceInvitation ($(_VMC_CSP_SERVICEINVITATION_MK_VERSION)) parameters:'
	@echo '    CSP_SERVICEINVITATION_COUNT=$(CSP_SERVICEINVITATION_COUNT)'
	@echo '    CSP_SERVICEINVITATION_FILEPATH=$(CSP_SERVICEINVITATION_FILEPATH)'
	@echo '    CSP_SERVICEINVITATION_ID=$(CSP_SERVICEINVITATION_ID)'
	@echo '    CSP_SERVICEINVITATION_LINK=$(CSP_SERVICEINVITATION_LINK)'
	@echo '    CSP_SERVICEINVITATION_NAME=$(CSP_SERVICEINVITATION_NAME)'
	@echo '    CSP_SERVICEINVITATION_SERVICE_ID=$(CSP_SERVICEINVITATION_SERVICE_ID)'
	@echo '    CSP_SERVICEINVITATION_SERVICE_NAME=$(CSP_SERVICEINVITATION_SERVICE_NAME)'
	@echo '    CSP_SERVICEINVITATION_SERVICEDEFINITION_LINK=$(CSP_SERVICEINVITATION_SERVICEDEFINITION_LINK)'
	@echo '    CSP_SERVICEINVITATION_URL=$(CSP_SERVICEINVITATION_URL)'
	@echo '    CSP_SERVICEINVITATIONS_SET_NAME=$(CSP_SERVICEINVITATIONS_SET_NAME)'
	@echo

_csp_view_framework_targets ::
	@echo 'VmwareClouD::CSP::ServiceInvitation ($(_VMC_CSP_SERVICEINVITATION_MK_VERSION)) targets:'
	@echo '    _csp_create_serviceinvitation                  - Create a new service-invitation'
	@echo '    _csp_delete_serviceinvitation                  - Delete an existing service-invitation'
	@echo '    _csp_show_serviceinvitation                    - Show everything related to a service-invitation'
	@echo '    _csp_show_serviceinvitation_description        - Show description of a service-invitation'
	@echo '    _csp_view_serviceinvitations                   - View service-invitations'
	@echo '    _csp_view_serviceinvitations_set               - View a set of service-invitations'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csp_create_serviceinvitation:
	@$(INFO) '$(CSP_UI_LABEL)Creating a service-invitation "$(CSP_SERVICEINVITATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if you are not using credentials from the service-organization'; $(NORMAL)
	@$(WARN) 'Service invitation makes sense only for gated services (!?)'; $(NORMAL)
	$(if $(CSP_SERVICEINVITATION_FILEPATH), cat $(CSP_SERVICEINVITATION_FILEPATH))
	@$(WARN) 'If you are using a file, make sure that the invitation is for the right service!'; $(NORMAL)
	@$(WARN) 'CSP_SERVICEINVITATION_SERVICE_ID=$(CSP_SERVICEINVITATION_SERVICE_ID)'; $(NORMAL)
	@$(WARN) 'CSP_SERVICEINVITATION_SERVICE_NAME=$(CSP_SERVICEINVITATION_SERVICE_NAME)'; $(NORMAL)
	$(CSPCURL) --header "Content-Type: application/json" $(__CSP_DATA__SERVICEINVITATION) --request POST "$(CSP_HOST_URL)/csp/gateway/slc/api/service-invitations" | $(CSPJQ) '.'
	#
	# $(CSP) services invitations create $(__CSP_DEFINITION__SERVICEINVITATION)
	#
	@$(WARN) 'Once you click on the service-invitation link, you will select a owned organization to which the invitation applies'; $(NORMAL)

_csp_delete_serviceinvitation:
	@$(INFO) '$(CSP_UI_LABEL)Deleting service-invitation "$(CSP_SERVICEINVITATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Invitation links expire once redeemed or 7-days after their creation! '; $(NORMAL)

_csp_show_serviceinvitation: _csp_show_serviceinvitation_url _csp_show_serviceinvitation_description

_csp_show_serviceinvitation_description:
	@$(INFO) '$(CSP_UI_LABEL)Showing service-invitation "$(CSP_SERVICEINVITATION_NAME)" ...'; $(NORMAL)A
	$(CSPCURL) --request GET "$(CSP_HOST_URL)/csp/gateway/slc/api/service-invitations/$(CSP_SERVICEINVITATION_ID)" | $(CSPJQ) '.'

_csp_show_serviceinvitation_url:
	@$(INFO) '$(CSP_UI_LABEL)Showing service-invitation "$(CSP_SERVICEINVITATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Invitation links expire once redeemed or 7-days after their creation! '; $(NORMAL)
	@echo "If still valid, you can redeem the invitation at the following  URL:\n$(CSP_SERVICEINVITATION_URL)"

_csp_view_serviceinvitations:
	@$(INFO) '$(CSP_UI_LABEL)Viewing services ...'; $(NORMAL)

_csp_view_serviceinvitations_set:
	@$(INFO) '$(CSP_UI_LABEL)Viewing services-set "$(CSP_SERVICEINVITATIONS_SET_NAME)" ...'; $(NORMAL)

