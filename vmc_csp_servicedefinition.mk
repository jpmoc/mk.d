_VMC_CSP_SERVICEDEFINITION_MK_VERSION= $(_VMC_CSP_MK_VERSION)

# CSP_SERVICEDEFINITION_YAML_FILEPATH?= ./service-definition.json
# CSP_SERVICEDEFINITION_YAML_FILEPATH?= ./service-definition.yml
# CSP_SERVICEDEFINITION_ID?= bce5cf1a-cba6-4180-aa27-6bc39adb7981
# CSP_SERVICEDEFINITION_LINK?= /csp/gateway/slc/api/definitions/external/bce5cf1a-cba6-4180-aa27-6bc39adb7981
# CSP_SERVICEDEFINITION_NAME?= 'my-service-definition'
# CSP_SERVICEDEFINITION_ORGANIZATION_ID?= from-file
# CSP_SERVICEDEFINITION_SERVICE_NAME?= from-file

# Derived variables
CSP_SERVICEDEFINITION_ID?= $(CSP_SERVICE_ID)
CSP_SERVICEDEFINITION_LINK?= /csp/gateway/slc/api/definitions/external/$(strip $(CSP_SERVICEDEFINITION_ID))
CSP_SERVICEDEFINITION_NAME?= $(CSP_SERVICE_NAME):ServiceDefinition

# Option variables
__CSP_DATA__SERVICEDEFINITION= $(if $(CSP_SERVICEDEFINITION_JSON_FILEPATH),--data "@$(CSP_SERVICEDEFINITION_JSON_FILEPATH)" --header "Content-Type: application/json")
__CSP_DATA_BINARY__SERVICEDEFINITION= $(if $(CSP_SERVICEDEFINITION_YAML_FILEPATH),--data-binary "@$(CSP_SERVICEDEFINITION_YAML_FILEPATH)" --header "Content-Type: text/plain")
__CSP_FILE__SERVICEDEFINITION= $(if $(CSP_SERVICEDEFINITION_YAML_FILEPATH),--file $(CSP_SERVICEDEFINITION_YAML_FILEPATH))
__CSP_LINK__SERVICEDEFINITION= $(if $(CSP_SERVICEDEFINITION_LINK),--link $(CSP_SERVICEDEFINITION_LINK))

# UI variables
 
#--- Utilities

#--- MACROS
_csp_get_servicedefinition_organization_link= $(call _csp_get_servicedefinition_organization_link_F, $(CSP_SERVICEDEFINITION_YAML_FILEPATH))
_csp_get_servicedefinition_organization_link_F= $(shell yq -r '."org-id"'  $(1))

_csp_get_servicedefinition_service_name= $(call _csp_get_servicedefinition_service_name_F, $(CSP_SERVICEDEFINITION_YAML_FILEPATH))
_csp_get_servicedefinition_service_name_F= $(shell yq -r '.name'  $(1))

#----------------------------------------------------------------------
# USAGE
#

# SWAGGER: https://console-stg.cloud.vmware.com/csp/gateway/slc/api/swagger-ui.html

_csp_view_framework_macros ::
	@echo 'VmwareClouD::CSP::ServiceDefinition ($(_VMC_CSP_SERVICEDEFINITION_MK_VERSION)) macros:'
	@echo '    _csp_get_servicedefinition_organization_id_{|F} - Get the organization-id from the service definition (Filepath)'
	@echo '    _csp_get_servicedefinition_service_name_{|F}    - Get the sevice-name from the service definition (Filepath)'
	@echo

_csp_view_framework_parameters ::
	@echo 'VmwareClouD::CSP::ServiceDefinition ($(_VMC_CSP_SERVICEDEFINITION_MK_VERSION)) parameters:'
	@echo '    CSP_SERVICEDEFINITION_ID=$(CSP_SERVICEDEFINITION_ID)'
	@echo '    CSP_SERVICEDEFINITION_JSON_FILEPATH=$(CSP_SERVICEDEFINITION_JSON_FILEPATH)'
	@echo '    CSP_SERVICEDEFINITION_LINK=$(CSP_SERVICEDEFINITION_LINK)'
	@echo '    CSP_SERVICEDEFINITION_NAME=$(CSP_SERVICEDEFINITION_NAME)'
	@echo '    CSP_SERVICEDEFINITION_ORGANIZATION_LINK=$(CSP_SERVICEDEFINITION_ORGANIZATION_LINK)'
	@echo '    CSP_SERVICEDEFINITION_SERVICE_NAME=$(CSP_SERVICEDEFINITION_SERVICE_NAME)'
	@echo '    CSP_SERVICEDEFINITION_YAML_FILEPATH=$(CSP_SERVICEDEFINITION_YAML_FILEPATH)'
	@echo

_csp_view_framework_targets ::
	@echo 'VmwareClouD::CSP::ServiceDefinition ($(_VMC_CSP_SERVICEDEFINITION_MK_VERSION)) targets:'
	@echo '    _csp_create_servicedefinition                  - Create a new service-definition'
	@echo '    _csp_delete_servicedefinition                  - Delete an existing service-definition'
	@echo '    _csp_show_servicedefinition                    - Show everything related to a service-definition'
	@echo '    _csp_show_servicedefinition_description        - Show description of a service-definition'
	@echo '    _csp_update_servicedefinition                  - Update an existing service-definition'
	@echo '    _csp_view_servicedefinitions                   - View service-definitions'
	@echo '    _csp_view_servicedefinitions_set               - View a set of service-definitions'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csp_create_servicedefinition:
	@$(INFO) '$(CSP_UI_LABEL)Creating service-definition "$(CSP_SERVICEDEFINITION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the current organization is not a service-organization'; $(NORMAL)
	@$(WARN) 'This operation fails if the current organization is not the service owner in the definition'; $(NORMAL)
	@$(WARN) 'This operation fails if the name is the service-definition already exist'; $(NORMAL)
	@$(WARN) 'Organization link (Current)           : $(CSP_ORGANIZATION_LINK)'; $(NORMAL)
	@$(WARN) 'Organization link (Service definition): $(CSP_SERVICEDEFINITION_ORGANIZATION_LINK)'; $(NORMAL)
	$(CSPCURL) $(__CSP_DATA_BINARY__SERVICEDEFINITION) --request POST "$(CSP_HOST_URL)/csp/gateway/slc/api/definitions" | $(CSPJQ) '.'
	#
	# $(CSP) services definition import $(__CSP_FILE__SERVICEDEFINITION)
	#

_csp_delete_servicedefinition:
	@$(INFO) '$(CSP_UI_LABEL)Deleting service-definition "$(CSP_SERVICEDEFINITION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is deprecated!'; $(NORMAL)
	# $(CSPCURL) --request DELETE "$(CSP_HOST_URL)/csp/gateway/slc/api/definitions/$(CSP_SERVICEDEFINITION_ID)" | $(CSPJQ) '.'

_csp_show_servicedefinition: _csp_show_servicedefinition_organizations _csp_show_servicedefinition_description

_csp_show_servicedefinition_description:
	@$(INFO) '$(CSP_UI_LABEL)Showing description of service-definition "$(CSP_SERVICEDEFINITION_NAME)" ...'; $(NORMAL)
	@echo "CSP_SERVICEDEFINITION_ID=$(CSP_SERVICEDEFINITION_ID)"
	@echo "CSP_SERVICEDEFINITION_LINK=$(CSP_SERVICEDEFINITION_LINK)"
	@$(WARN) 'Exporting in JSON format'; $(NORMAL)
	$(CSPCURL) --request GET "$(CSP_HOST_URL)/csp/gateway/slc/api/definitions/external/$(CSP_SERVICEDEFINITION_ID)" | $(CSPJQ) '.'
	#
	# $(CSP) services definition get $(__CSP_LINK__SERVICEDEFINITION)
	#
	@$(WARN) 'Exporting in YAML format'; $(NORMAL)
	$(CSPCURL) --request GET "$(CSP_HOST_URL)/csp/gateway/slc/api/definitions/external/$(CSP_SERVICEDEFINITION_ID)/export"

_csp_show_servicedefinition_organizations:
	@$(INFO) '$(CSP_UI_LABEL)Showing organizationis that use service-definition "$(CSP_SERVICEDEFINITION_NAME)" ...'; $(NORMAL)
	$(CSPCURL) --request GET "$(CSP_HOST_URL)/csp/gateway/slc/api/definitions/external/$(CSP_SERVICEDEFINITION_ID)" | $(CSPJQ) '.'

_csp_update_servicedefinition:
	@$(INFO) '$(CSP_UI_LABEL)Updating service-definition "$(CSP_SERVICEDEFINITION_NAME)" ...'; $(NORMAL)
	$(CSPCURL) $(__CSP_DATA__SERVICEDEFINITION) --request PATCH "$(CSP_HOST_URL)/csp/gateway/slc/api/definitions/external/$(CSP_SERVICEDEFINITION_ID)" | $(CSPJQ) '.'

_csp_view_servicedefinitions:
	@$(INFO) '$(CSP_UI_LABEL)Viewing services ...'; $(NORMAL)
	$(CSPCURL) --request GET "$(CSP_HOST_URL)/csp/gateway/slc/api/definitions" | $(CSPJQ) '.'
	#
	# $(CSP) services definition list
	#


_csp_view_servicedefinitions_set:
	@$(INFO) '$(CSP_UI_LABEL)Showing services-set "$(CSP_SERVICEDEFINITIONS_SET_NAME)" ...'; $(NORMAL)

