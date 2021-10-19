_VMC_CSP_SERVICEACCESS_MK_VERSION= $(_VMC_CSP_MK_VERSION)

# CSP_SERVICEACCESS_ID?= 689db966-6ac0-11e9-b7e2-0699b9a80d52
# CSP_SERVICEACCESS_JSON_FILEPATH?= ./service-access.json
# CSP_SERVICEACCESS_LINK?= /csp/gateway/slc/api/service-access/grant-access-tasks/689db966-6ac0-11e9-b7e2-0699b9a80d52
# CSP_SERVICEACCESS_NAME?= MyService:ServiceAccess
# CSP_SERVICEACCESS_SERVICEDEFINITION_ID?=
# CSP_SERVICEACCESS_SERVICEDEFINITION_NAME?=
# CSP_SERVICEACCESS_SERVICE_ID?= 
# CSP_SERVICEACCESS_SERVICE_NAME?= MyService
# CSP_SERVICEACCESS_TARGETORGANIZATION_ID?=
# CSP_SERVICEACCESS_TARGETORGANIZATION_NAME?=

# Derived variables
CSP_SERVICEACCESS_LINK?= /csp/gateway/slc/api/service-access/grant-access-tasks/$(CSP_SERVICEACCESS_ID)
CSP_SERVICEACCESS_NAME?= $(CSP_SERVICE_NAME):ServiceAccess
CSP_SERVICEACCESS_SERVICEDEFINITION_ID?= $(CSP_SERVICEACCESS_SERVICEDEFINITION_ID)
CSP_SERVICEACCESS_SERVICEDEFINITION_NAME?= $(CSP_SERVICEACCESS_SERVICEDEFINITION_NAME)
CSP_SERVICEACCESS_SERVICE_ID?= $(CSP_SERVICE_ID)
CSP_SERVICEACCESS_SERVICE_NAME?= $(CSP_SERVICE_NAME)

# Option variables
__CSP_DATA__SERVICEACCESS= $(if $(CSP_SERVICEACCESS_JSON_FILEPATH),--data "@$(CSP_SERVICEACCESS_JSON_FILEPATH)" --header "Content-Type: application/json")

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

# SWAGGER: https://console-stg.cloud.vmware.com/csp/gateway/slc/api/swagger-ui.html

_csp_view_framework_macros ::
	@echo 'VmwareClouD::CSP::ServiceAccess ($(_VMC_CSP_SERVICEACCESS_MK_VERSION)) macros:'
	@echo

_csp_view_framework_parameters ::
	@echo 'VmwareClouD::CSP::ServiceAccess ($(_VMC_CSP_SERVICEACCESS_MK_VERSION)) parameters:'
	@echo '    CSP_SERVICEACCESS_ID=$(CSP_SERVICEACCESS_ID)'
	@echo '    CSP_SERVICEACCESS_JSON_FILEPATH=$(CSP_SERVICEACCESS_JSON_FILEPATH)'
	@echo '    CSP_SERVICEACCESS_NAME=$(CSP_SERVICEACCESS_NAME)'
	@echo '    CSP_SERVICEACCESS_SERVICEDEFINITION_ID=$(CSP_SERVICEACCESS_SERVICEDEFINITION_ID)'
	@echo '    CSP_SERVICEACCESS_SERVICEDEFINITION_NAME=$(CSP_SERVICEACCESS_SERVICEDEFINITION_NAME)'
	@echo '    CSP_SERVICEACCESS_SERVICE_ID=$(CSP_SERVICEACCESS_SERVICE_ID)'
	@echo '    CSP_SERVICEACCESS_SERVICE_NAME=$(CSP_SERVICEACCESS_SERVICE_NAME)'
	@echo '    CSP_SERVICEACCESS_TARGETORGANIZATION_ID=$(CSP_SERVICEACCESS_TARGETORGANIZATION_ID)'
	@echo '    CSP_SERVICEACCESS_TARGETORGANIZATION_NAME=$(CSP_SERVICEACCESS_TARGETORGANIZATION_NAME)'
	@echo

_csp_view_framework_targets ::
	@echo 'VmwareClouD::CSP::ServiceAccess ($(_VMC_CSP_SERVICEACCESS_MK_VERSION)) targets:'
	@echo '    _csp_create_serviceaccess                  - Create a new service-access'
	@echo '    _csp_delete_serviceaccess                  - Delete an existing service-access'
	@echo '    _csp_show_serviceaccess                    - Show everything related to a service-access'
	@echo '    _csp_show_serviceaccess_description        - Show description of a service-access'
	@echo '    _csp_update_serviceaccess                  - Update an existing service-access'
	@echo '    _csp_view_serviceaccesss                   - View service-accesss'
	@echo '    _csp_view_serviceaccesss_set               - View a set of service-accesss'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csp_create_serviceaccess:
	@$(INFO) '$(CSP_UI_LABEL)Creating service-access "$(CSP_SERVICEACCESS_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the current organization is not the service owner'; $(NORMAL)
	@$(WARN) 'This operation is idempotent and does not fail if the target org has already access to service'; $(NORMAL)
	@$(WARN) 'Organization link (Current)           : $(CSP_ORGANIZATION_LINK)'; $(NORMAL)
	@$(WARN) 'Organization name (Current)           : $(CSP_ORGANIZATION_NAME)'; $(NORMAL)
	$(if $(CSP_SERVICEACCESS_JSON_FILEPATH), cat $(CSP_SERVICEACCESS_JSON_FILEPATH))
	$(CSPCURL) $(__CSP_DATA__SERVICEACCESS) --request POST "$(CSP_HOST_URL)/csp/gateway/slc/api/service-access" | $(CSPJQ) '.'
	@$(WARN) 'The target organization now has access to service'; $(NORMAL)

_csp_delete_serviceaccess:

_csp_show_serviceaccess: _csp_show_serviceaccess_organizations _csp_show_serviceaccess_description

_csp_show_serviceaccess_description:
	@$(INFO) '$(CSP_UI_LABEL)Showing description of service-access "$(CSP_SERVICEACCESS_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Exporting in JSON format'; $(NORMAL)
	$(CSPCURL) --request GET "$(CSP_HOST_URL)/csp/gateway/slc/api/service-access/grant-access-tasks/$(CSP_SERVICEACCESS_ID)" | $(CSPJQ) '.'

_csp_show_serviceaccess_organizations:
	@$(INFO) '$(CSP_UI_LABEL)Showing organizationis that use service-access "$(CSP_SERVICEACCESS_NAME)" ...'; $(NORMAL)
	$(CSPCURL) --request GET "$(CSP_HOST_URL)/csp/gateway/slc/api/accesss/external/$(CSP_SERVICEACCESS_SERVICE_ID)" | $(CSPJQ) '.'

_csp_view_serviceaccess:
	@$(INFO) '$(CSP_UI_LABEL)Viewing services ...'; $(NORMAL)
	$(CSPCURL) --request GET "$(CSP_HOST_URL)/csp/gateway/slc/api/accesss" | $(CSPJQ) '.'
	#
	# $(CSP) services access list
	#

_csp_view_serviceaccesss_set:
	@$(INFO) '$(CSP_UI_LABEL)Showing services-set "$(CSP_SERVICEXS_SET_NAME)" ...'; $(NORMAL)

