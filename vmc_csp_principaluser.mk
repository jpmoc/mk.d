_VMC_CSP_PRINCIPALUSER_MK_VERSION= $(_VMC_CSP_MK_VERSION)

# CSP_PRINCIPALUSER_EMAIL?= emayssat@vmware.com
# CSP_PRINCIPALUSER_FIRSTNAME?= Emmanuel
# CSP_PRINCIPALUSER_LASTNAME?= Mayssat
# CSP_PRINCIPALUSER_ORGANIZATION_ID?=
# CSP_PRINCIPALUSER_ORGANIZATION_NAME?=
# CSP_PRINCIPALUSER_USERNAME?= emayssat@vmware.com

# Derived variables
CSP_PRINCIPALUSER_ORGANIZATION_ID?= $(CSP_ORGANIZATION_ID)
CSP_PRINCIPALUSER_ORGANIZATION_LINK?= $(CSP_ORGANIZATION_LINK)
CSP_PRINCIPALUSER_ORGANIZATION_NAME?= $(CSP_ORGANIZATION_NAME)
CSP_PRINCIPALUSER_SERVICE_LINK?= $(CSP_SERVICE_LINK)
CSP_PRINCIPALUSER_SERVICE_NAME?= $(CSP_SERVICE_NAME)
CSP_PRINCIPALUSER_USERNAME?= $(CSP_PRINCIPALUSER_EMAIL)

# Option variables
__CSP_ORG__PRINCIPALUSER= $(if $(CSP_PRINCIPALUSER_ORGANIZATION_LINK),--org $(CSP_PRINCIPALUSER_ORGANIZATION_LINK))

# UI variables
 
#--- Utilities

#--- MACROS

_csp_get_principaluser_username= $(shell csp-cli user get | jq -r '.username')

#----------------------------------------------------------------------
# USAGE
#

_csp_view_framework_macros ::
	@echo 'VmwareClouD::CSP::PrincipalUser ($(_VMC_CSP_PRINCIPALUSER_MK_VERSION)) macros:'
	@echo '    _csp_get_principaluser_username            - Get the username'
	@echo

_csp_view_framework_parameters ::
	@echo 'VmwareClouD::CSP::PrincipalUser ($(_VMC_CSP_PRINCIPALUSER_MK_VERSION)) parameters:'
	@echo '    CSP_PRINCIPALUSER_EMAIL=$(CSP_PRINCIPALUSER_EMAIL)'
	@echo '    CSP_PRINCIPALUSER_FIRSTNAME=$(CSP_PRINCIPALUSER_FIRSTNAME)'
	@echo '    CSP_PRINCIPALUSER_LASTNAME=$(CSP_PRINCIPALUSER_LASTNAME)'
	@echo '    CSP_PRINCIPALUSER_ORGANIZATION_ID=$(CSP_PRINCIPALUSER_ORGANIZATION_ID)'
	@echo '    CSP_PRINCIPALUSER_ORGANIZATION_LINK=$(CSP_PRINCIPALUSER_ORGANIZATION_LINK)'
	@echo '    CSP_PRINCIPALUSER_ORGANIZATION_NAME=$(CSP_PRINCIPALUSER_ORGANIZATION_NAME)'
	@echo '    CSP_PRINCIPALUSER_SERVICE_LINK=$(CSP_PRINCIPALUSER_SERVICE_LINK)'
	@echo '    CSP_PRINCIPALUSER_SERVICE_NAME=$(CSP_PRINCIPALUSER_SERVICE_NAME)'
	@echo '    CSP_PRINCIPALUSER_USERNAME=$(CSP_PRINCIPALUSER_USERNAME)'
	@echo

_csp_view_framework_targets ::
	@echo 'VmwareClouD::CSP::PrincipalUser ($(_VMC_CSP_PRINCIPALUSER_MK_VERSION)) targets:'
	@echo '    _csp_show_principaluser                    - Show everything related to the principal-user'
	@echo '    _csp_show_principaluser_description        - Show description of the principal-user'
	@echo '    _csp_show_principaluser_organizations      - Show organizations of principal-user'
	@echo '    _csp_show_principaluser_roles              - Show roles of the princiapl-user'
	@echo '    _csp_show_principaluser_serviceroles       - Show service-roles of the princiapl-user'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csp_show_principaluser: _csp_show_principaluser_organizations _csp_show_principaluser_roles _csp_show_principaluser_serviceroles _csp_show_principaluser_description

_csp_show_principaluser_description:
	@$(INFO) '$(CSP_UI_LABEL)Showing description of principal-user "$(CSP_PRINCIPALUSER_NAME)" ...'; $(NORMAL)
	$(CSPCURL) --request GET '$(CSP_HOST_URL)/csp/gateway/am/api/loggedin/user' | jq '.'
	#
	# $(CSP) user get
	#

_csp_show_principaluser_organizations:
	@$(INFO) '$(CSP_UI_LABEL)Showing organizations of principal-user "$(CSP_PRINCIPALUSER_NAME)" ...'; $(NORMAL)
	$(CSPCURL) --request GET '$(CSP_HOST_URL)/csp/gateway/am/api/loggedin/user/orgs' | jq '.'
	#
	# $(CSP) org list
	#
	@$(INFO) '$(CSP_UI_LABEL)Showing default-organization of principal-user "$(CSP_PRINCIPALUSER_NAME)" ...'; $(NORMAL)
	$(CSPCURL) --request GET '$(CSP_HOST_URL)/csp/gateway/am/api/loggedin/user/default-org' | jq '.'
	#
	@$(INFO) '$(CSP_UI_LABEL)Showing current-organization of principal-user "$(CSP_PRINCIPALUSER_NAME)" ...'; $(NORMAL)
	$(CSPCURL) --request GET '$(CSP_HOST_URL)/csp/gateway/am/api/loggedin/user/orgs/$(CSP_PRINCIPALUSER_ORGANIZATION_ID)/info' | jq '.userOrgInfo[]'

_csp_show_principaluser_roles:
	@$(INFO) '$(CSP_UI_LABEL)Showing roles of principal-user "$(CSP_PRINCIPALUSER_NAME)" ...'; $(NORMAL)
	$(CSPCURL) --request GET '$(CSP_HOST_URL)/csp/gateway/am/api/loggedin/user/orgs/$(CSP_PRINCIPALUSER_ORGANIZATION_ID)/roles' | jq '.'
	#
	# $(CSP) user roles get $(__CSP_ORG__PRINCIPALUSER)
	#
	
_csp_show_principaluser_serviceroles:
	@$(INFO) '$(CSP_UI_LABEL)Showing service-roles for service "$(CSP_PRINCIPALUSER_SERVICE_NAME)" of principal-user "$(CSP_PRINCIPALUSER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Service-roles are roles defined in the service definition'; $(NORMAL)
	@$(WARN) 'This operation requires a service-link to identify the service'; $(NORMAL)
	$(CSPCURL) --request GET '$(CSP_HOST_URL)/csp/gateway/am/api/loggedin/user/orgs/$(CSP_PRINCIPALUSER_ORGANIZATION_ID)/service-roles?serviceDefinitionLink=$(CSL_PRINCIPALUSER_SERVICE_LINK)' | jq '.'

_csp_update_principaluser_defaultorganization:
	@$(INFO) '$(CSP_UI_LABEL)Updating the default-organization of principal-user "$(CSP_PRINCIPALUSER_NAME)" ...'; $(NORMAL)
	$(CSPCURL) --data XXX --request POST '$(CSP_HOST_URL)/csp/gateway/am/api/loggedin/user/default-org' | jq '.'
	#  
