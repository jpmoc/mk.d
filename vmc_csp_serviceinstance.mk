_VMC_CSP_SERVICEINSTANCE_MK_VERSION= $(_VMC_CSP_MK_VERSION)

# CSP_SERVICEINSTANCE_ID?= 873d8451-db05-41fa-beb4-e74095585554
# CSP_SERVICEINSTANCE_LINK?= /slc/api/definitions/external/873d8451-db05-41fa-beb4-e74095585554/serivce-instances/12345
# CSP_SERVICEINSTANCE_NAME?= 'my-service-instance'
# CSP_SERVICEINSTANCE_ORGANIZATION_ID?=
# CSP_SERVICEINSTANCE_SERVICEDEFINITION_ID?=
# CSP_SERVICEINSTANCE_SERVICEDEFINITION_LINK?=
# CSP_SERVICEINSTANCE_SERVICEDEFINITION_NAME?=

# Derived variables
CSP_SERVICEINSTANCE_ORGANIZATION_ID?= $(CSP_ORGANIZATION_ID)
CSP_SERVICEINSTANCE_SERVICEDEFINITION_ID?= $(CSP_SERVICEDEFINITION_ID)
CSP_SERVICEINSTANCE_SERVICEDEFINITION_LINK?= $(CSP_SERVICEDEFINITION_LINK)
CSP_SERVICEINSTANCE_SERVICEDEFINITION_NAME?= $(CSP_SERVICEDEFINITION_NAME)
CSP_SERVICEINSTANCE_LINK?= $(CSP_SERVICEINSTANCE_SERVICEDEFINITION_LINK)/service-instances/$(CSP_SERVICEINSTANCE_ID)

# Option variables
# __CSP_DEFINITION__SERVICEINSTANCE= $(if $(CSP_SERVICEINSTANCE_SERVICEDEFINITION_LINK), --definition $(CSP_SERVICEINSTANCE_SERVICEDEFINITION_LINK))
# __CSP_DATA__SERVICEINSTANCE= $(if $(CSP_SERVICEINSTANCE_FILEPATH), -H "Content-Type: application/json" --data @$(CSP_SERVICEINSTANCE_FILEPATH))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_csp_view_framework_macros ::
	@echo 'VmwareClouD::CSP::ServiceInstance ($(_VMC_CSP_SERVICEINSTANCE_MK_VERSION)) macros:'
	@echo

_csp_view_framework_parameters ::
	@echo 'VmwareClouD::CSP::ServiceInstance ($(_VMC_CSP_SERVICEINSTANCE_MK_VERSION)) parameters:'
	@echo '    CSP_SERVICEINSTANCE_ID=$(CSP_SERVICEINSTANCE_ID)'
	@echo '    CSP_SERVICEINSTANCE_LINK=$(CSP_SERVICEINSTANCE_LINK)'
	@echo '    CSP_SERVICEINSTANCE_NAME=$(CSP_SERVICEINSTANCE_NAME)'
	@echo '    CSP_SERVICEINSTANCE_ORGANIZATION_ID=$(CSP_SERVICEINSTANCE_ORGANIZATION_ID)'
	@echo '    CSP_SERVICEINSTANCE_SERVICEDEFINITION_ID=$(CSP_SERVICEINSTANCE_SERVICEDEFINITION_ID)'
	@echo '    CSP_SERVICEINSTANCE_SERVICEDEFINITION_NAME=$(CSP_SERVICEINSTANCE_SERVICEDEFINITION_NAME)'
	@echo '    CSP_SERVICEINSTANCE_SERVICEDEFINITION_LINK=$(CSP_SERVICEINSTANCE_SERVICEDEFINITION_LINK)'
	@echo

_csp_view_framework_targets ::
	@echo 'VmwareClouD::CSP::ServiceInstance ($(_VMC_CSP_SERVICEINSTANCE_MK_VERSION)) targets:'
	@echo '    _csp_create_serviceinstance                  - Create a new service-instance'
	@echo '    _csp_delete_serviceinstance                  - Delete an existing service-instance'
	@echo '    _csp_show_serviceinstance                    - Show everything related to a service-instance'
	@echo '    _csp_show_serviceinstance_description        - Show description of a service-instance'
	@echo '    _csp_view_serviceinstances                   - View service-instances'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csp_create_serviceinstance:
	@$(INFO) '$(CSP_UI_LABEL)Creating a service-instance "$(CSP_SERVICEINSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if you are not using credentials from the service-organization'; $(NORMAL)
	@$(WARN) 'Service instance makes sense only for gated services (!?)'; $(NORMAL)
	$(if $(CSP_SERVICEINSTANCE_FILEPATH), cat $(CSP_SERVICEINSTANCE_FILEPATH))
	$(CSPCURL) $(__CSP_DATA__SERVICEINSTANCE) --request POST "$(CSP_HOST_URL)/csp/gateway/slc/api/service-instances" | $(CSPJQ) '.'
	#
	# $(CSP) services instances create $(__CSP_DEFINITION__SERVICEINSTANCE)
	#
	@$(WARN) 'Once you click on the service-instance link, you will select a owned organization to which the instance applies'; $(NORMAL)

_csp_delete_serviceinstance:
	@$(INFO) '$(CSP_UI_LABEL)Deleting service-instance "$(CSP_SERVICEINSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Invitation links expire once redeemed or 7-days after their creation! '; $(NORMAL)

_csp_show_serviceinstance: _csp_show_serviceinstance_url _csp_show_serviceinstance_description

_csp_show_serviceinstance_description:
	@$(INFO) '$(CSP_UI_LABEL)Showing service-instance "$(CSP_SERVICEINSTANCE_NAME)" ...'; $(NORMAL)A
	$(CSPCURL) --request GET "$(CSP_HOST_URL)/csp/gateway/slc/api/service-instances/$(CSP_SERVICEINSTANCE_ID)" | $(CSPJQ) '.'

_csp_show_serviceinstance_url:
	@$(INFO) '$(CSP_UI_LABEL)Showing service-instance "$(CSP_SERVICEINSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Invitation links expire once redeemed or 7-days after their creation! '; $(NORMAL)
	@echo "If still valid, you can redeem the instance at the following  URL:\n$(CSP_SERVICEINSTANCE_URL)"

_csp_view_serviceinstances:
	@$(INFO) '$(CSP_UI_LABEL)Viewing service-instances ...'; $(NORMAL)
	$(CSPCURL) --request GET "$(CSP_HOST_URL)/csp/gateway/slc/api/definitions/external/$(CSP_SERVICEINSTANCE_SERVICEDEFINITION_ID)/service-instances?orgId=$(CSP_SERVICEINSTANCE_ORGANIZATION_ID)" | $(CSPJQ) '.'
