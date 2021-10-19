_VMC_CSP_USER_MK_VERSION= $(_VMC_CSP_MK_VERSION)

# CSP_USER_CREATE_FILEPATH?= ./create-user.json
# CSP_USER_EMAIL?= emayssat@vmware.com
# CSP_USER_FIRSTNAME?= Emmanuel
# CSP_USER_LASTNAME?= Mayssat
# CSP_USER_ORGANIZATION_LINK?= /csp/gateway/am/api/orgs/76e6c345-0634-4cbd-be6f-XXXXXXXXXXXXX
# CSP_USER_ORGANIZATION_NAME?=
# CSP_USER_PASSWORD?= <my-password>
# CSP_USER_USERNAME?= emayssat@vmware.com

# Derived variables
CSP_USER_ORGANIZATION_LINK?= $(CSP_ORGANIZATION_LINK)
CSP_USER_ORGANIZATION_NAME?= $(CSP_ORGANIZATION_NAME)
CSP_USER_USERNAME?= $(CSP_USER_EMAIL)

# Option variables
__CSP_FILE__USER= $(if $(CSP_USER_CREATE_FILEPATH), --file $(CSP_USER_CREATE_FILEPATH))
__CSP_FIRST_NAME= $(if $(CSP_USER_FIRSTNAME), --first-name $(CSP_USER_FIRSTNAME))
__CSP_LAST_NAME= $(if $(CSP_USER_LASTNAME), --last-name $(CSP_USER_LATNAME))
__CSP_ORG__USER= $(if $(CSP_USER_ORGANIZATION_LINK), --org $(CSP_USER_ORGANIZATION_LINK))
__CSP_PASSWORD__USER= $(if $(CSP_USER_PASSWORD), --password $(CSP_USER_PASSWORD))
__CSP_USERNAME__USER= $(if $(CSP_USER_USERNAME), --username $(CSP_USER_USERNAME))

# UI variables
 
#--- Utilities

#--- MACROS

_csp_get_user_username= $(shell csp-cli user get | jq -r '.username')

#----------------------------------------------------------------------
# USAGE
#

_csp_view_framework_macros ::
	@#echo 'VmwareClouD::CSP::User ($(_VMC_CSP_USER_MK_VERSION)) macros:'
	@#echo

_csp_view_framework_parameters ::
	@echo 'VmwareClouD::CSP::User ($(_VMC_CSP_USER_MK_VERSION)) parameters:'
	@echo '    CSP_USER_CREATE_FILEPATH=$(CSP_USER_CREATE_FILEPATH)'
	@echo '    CSP_USER_EMAIL=$(CSP_USER_EMAIL)'
	@echo '    CSP_USER_FIRSTNAME=$(CSP_USER_FIRSTNAME)'
	@echo '    CSP_USER_LASTNAME=$(CSP_USER_LASTNAME)'
	@echo '    CSP_USER_ORGANIZATION_LINK=$(CSP_USER_ORGANIZATION_LINK)'
	@echo '    CSP_USER_ORGANIZATION_NAME=$(CSP_USER_ORGANIZATION_NAME)'
	@echo '    CSP_USER_PASSWORD=$(CSP_USER_PASSWORD)'
	@echo '    CSP_USER_USERNAME=$(CSP_USER_USERNAME)'
	@echo

_csp_view_framework_targets ::
	@echo 'VmwareClouD::CSP::User ($(_VMC_CSP_USER_MK_VERSION)) targets:'
	@echo '    _csp_create_user                  - Create a new user'
	@echo '    _csp_delete_user                  - Delete an existing user'
	@echo '    _csp_show_user                    - Show everything related to a user'
	@echo '    _csp_show_user_description        - Show description of a user'
	@echo '    _csp_show_user_organizations      - Show organizations to which a user belongs to'
	@echo '    _csp_show_user_roles              - Show roles of a user in an organization'
	@echo '    _csp_view_users                   - View users'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csp_create_user:
	@$(INFO) '$(CSP_UI_LABEL)Creating user "$(CSP_USER_USERNAME)" ...'; $(NORMAL)
	@$(if $(CSP_USER_CREATE_FILEPATH), cat $(CSP_USER_CREATE_FILEPATH))
	#$(CSP) user create $(__CSP_FILE__USER) $(__CSP_FIRST_NAME) $(__CSP_LAST_NAME) $(__CSP_PASSWORD__USER) $(CSP_USERNAME__USER)
	@$(WARN) 'This operation is NOT supported from this 'deprecated' command line :-( !'; $(NORMAL)

_csp_delete_user:
	@$(INFO) '$(CSP_UI_LABEL)Deleting user "$(CSP_USER_USERNAME)" ...'; $(NORMAL)

_csp_show_user: _csp_show_user_organizations _csp_show_user_roles _csp_show_user_description

_csp_show_user_description:
	@$(INFO) '$(CSP_UI_LABEL)Showing description of user "$(CSP_USER_USERNAME)" ...'; $(NORMAL)
	# $(CSP) user get

_csp_show_user_organizations:
	@$(INFO) '$(CSP_UI_LABEL)Showing organizations of user "$(CSP_USER_USERNAME)" ...'; $(NORMAL)
	# $(CSP) org list

_csp_show_user_roles:
	@$(INFO) '$(CSP_UI_LABEL)Showing roles of user "$(CSP_USER_USERNAME)" in organization "$(CSP_USER_ORGANIZATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The active organization is $(CSP_USER_ORGANIZATION_LINK)'; $(NORMAL)
	# $(CSP) user roles get $(__CSP_ORG__USER)

_csp_view_users:
	@$(INFO) '$(CSP_UI_LABEL)Viewing users ...'; $(NORMAL)
	@$(WARN) 'Users are grouped based on the current organization'; $(NORMAL)
	$(CSPCURL) --request GET '$(CSP_HOST_URL)/csp/gateway/am/api/v2/orgs/831a06ab-9781-487c-a9da-6c73973e540a/users' | jq '.'

