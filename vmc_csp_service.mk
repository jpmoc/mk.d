_VMC_CSP_SERVICE_MK_VERSION= $(_VMC_CSP_MK_VERSION)

# CSP_SERVICE_ID?= 724511a6-a699-48ba-9434-XXXXXXXXXXX
# CSP_SERVICE_LINK?= /csp/gateway/am/api/orgs/76e6c345-0634-4cbd-be6f-XXXXXXXXXXXXX
# CSP_SERVICE_NAME?= 'my-service'
# CSP_SERVICE_ORGANIZATION_LINK?=
# CSP_SERVICES_ORGANIZATION_LINK?=
# CSP_SERVICES_SET_NAME?= my-service-sets

# Derived variables
CSP_SERVICE_LINK?= /csp/gateway/am/api/orgs/$(strip $(CSP_SERVICE_ID))
CSP_SERVICE_ORGANIZATION_LINK?= $(CSP_ORGANIZATION_LINK)
CSP_SERVICES_ORGANIZATION_LINK?= $(CSP_SERVICE_ORGANIZATION_LINK)
CSP_SERVICES_SET_NAME?= $(CSP_SERVICES_ORGANIZATION_LINK):ServicesSet

# Option variables
__CSP_ORG__SERVICE= $(if $(CSP_SERVICE_ORGANIZATION_LINK), --org $(CSP_SERVICE_ORGANIZATION_LINK))
__CSP_ORG__SERVICES= $(if $(CSP_SERVICES_ORGANIZATION_LINK), --org $(CSP_SERVICES_ORGANIZATION_LINK))

# UI variables
 
#--- Utilities

#--- MACROS
_csp_get_service_name= $(call _csp_get_service_name_I, $(CSP_SERVICE_ID))
_csp_get_service_name_I= $(call _csp_get_service_name_IL, $(1), $(CSP_SERVICE_ORGANIZATION_LINK))
_csp_get_service_name_IL= $(shell csp-cli org services show --org $(2) | jq -r '.servicesRoles[] | select(.serviceId=="$(strip $(1))") | .serviceDisplayName')

#----------------------------------------------------------------------
# USAGE
#

_csp_view_framework_macros ::
	@echo 'VmwareClouD::CSP::Service ($(_VMC_CSP_SERVICE_MK_VERSION)) macros:'
	@echo '    _csp_get_service_name_{|I|IL}        - Get the service name (Id,organizationLink)'
	@echo

_csp_view_framework_parameters ::
	@echo 'VmwareClouD::CSP::Service ($(_VMC_CSP_SERVICE_MK_VERSION)) parameters:'
	@echo '    CSP_SERVICE_ID=$(CSP_SERVICE_ID)'
	@echo '    CSP_SERVICE_LINK=$(CSP_SERVICE_LINK)'
	@echo '    CSP_SERVICE_NAME=$(CSP_SERVICE_NAME)'
	@echo '    CSP_SERVICE_ORGANIZATION_LINK=$(CSP_SERVICE_ORGANIZATION_LINK)'
	@echo '    CSP_SERVICES_ORGANIZATION_LINK=$(CSP_SERVICES_ORGANIZATION_LINK)'
	@echo '    CSP_SERVICES_SET_NAME=$(CSP_SERVICES_SET_NAME)'
	@echo

_csp_view_framework_targets ::
	@echo 'VmwareClouD::CSP::Service ($(_VMC_CSP_SERVICE_MK_VERSION)) targets:'
	@echo '    _csp_create_service                  - Create a new service'
	@echo '    _csp_delete_service                  - Delete an existing service'
	@echo '    _csp_show_service                    - Show everything related to a service'
	@echo '    _csp_view_services                   - View services'
	@echo '    _csp_view_services_set               - View a set of services'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csp_create_service:
	@$(INFO) '$(CSP_UI_LABEL)Creating service "$(CSP_SERVICE_NAME)" ...'; $(NORMAL)

_csp_delete_service:
	@$(INFO) '$(CSP_UI_LABEL)Deleting service "$(CSP_SERVICE_NAME)" ...'; $(NORMAL)

_csp_show_service: _csp_show_service_servicedefinition _csp_show_service_serviceroles _csp_show_service_description

_csp_show_service_servicedefinition:
	@$(INFO) '$(CSP_UI_LABEL)Showing service-definition of service "$(CSP_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the query is not using an access/refresh token of the service-owner organization'; $(NORMAL)
	$(CSPCURL) --request GET "https://console-stg.cloud.vmware.com/csp/gateway/slc/api/definitions/external/$(CSP_SERVICE_ID)/export"
	@$(WARN) 'If this operation returns "Unauthorized api invocation", you are NOT using a service-owner refresh token!'; $(NORMAL)

_csp_show_service_description:
	@$(INFO) '$(CSP_UI_LABEL)Showing description of service "$(CSP_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the service-owner organization ID where the service was created'; $(NORMAL)
	$(CSP) org services show $(__CSP_ORG__SERVICE) | jq -r '.servicesRoles[] | select(.serviceId == "$(strip $(CSP_SERVICE_ID))") | {serviceId: .serviceId, serviceType: .serviceType, orgId: .orgId, serviceDisplayName: .serviceDisplayName}'

_csp_show_service_serviceroles:
	@$(INFO) '$(CSP_UI_LABEL)Showing service-roles of service "$(CSP_SERVICE_NAME)" ...'; $(NORMAL)
	$(CSP) org services show  $(__CSP_ORG__SERVICE) | jq -r '.servicesRoles[] | select(.serviceId == "$(strip $(CSP_SERVICE_ID))") | .serviceRoles'

_csp_view_services:
	@$(INFO) '$(CSP_UI_LABEL)Viewing services ...'; $(NORMAL)
	@$(WARN) 'Gated services may not be displayed if an invitation has not been sent'; $(NORMAL)
	$(CSP) org services show $(__CSP_ORG__SERVICE)
	@$(WARN) 'Compact format ...'; $(NORMAL)
	@$(WARN) 'Gated services may not be displayed if an invitation has not been sent'; $(NORMAL)
	$(CSP) org services show $(__CSP_ORG__SERVICE) | jq -r '.servicesRoles[].serviceDisplayName' | sort

_csp_view_services_set:
	@$(INFO) '$(CSP_UI_LABEL)Showing services-set "$(CSP_SERVICES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Services are grouped based on the organization they were created in'; $(NORMAL)
	@$(WARN) 'Gated services may not be displayed if an invitation has not been sent'; $(NORMAL)
	$(CSP) org services show $(__CSP_ORG__SERVICES) | jq -r '.servicesRoles[] | select(.orgId == "$(strip $(CSP_SERVICES_ORGANIZATION_LINK))") '

