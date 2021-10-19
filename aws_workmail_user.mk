_AWS_WORKMAIL_USER_MK_VERSION= $(_AWS_WORKMAIL_MK_VERSION)

# WML_USER_DISPLAYNAME?=
# WML_USER_ID?=
# WML_USER_NAME?=
# WML_USER_ORGANIZATION_ID?= m-637f623935dc457e91720e5036eefb62
# WML_USER_PASSWORD?=
# WML_USER_PRIMARYEMAIL?= bob@domain.com
# WML_USERS_SET_NAME?=

# Derived parameters
WML_USER_PRIMARYEMAIL?= $(if $(WML_USER_ORGANIZATION_MAILDOMAIN),$(WML_USER_NAME)@$(WML_USER_ORGANIZATION_MAILDOMAIN))
# WML_USER_IDS?= $(WML_USER_ID)
WML_USER_ORGANIZATION_ID?= $(WML_ORGANIZATION_ID)
WML_USER_ORGANIZATION_MAILDOMAIN?= $(WML_ORGANIZATION_MAILDOMAIN)

# Option parameters
__WML_DISPLAY_NAME= $(if $(WML_USER_DISPLAYNAME), --display-name $(WML_USER_DISPLAYNAME))
__WML_EMAIL= $(if $(WML_USER_PRIMARYEMAIL), --email $(WML_USER_PRIMARYEMAIL))
__WML_ENTITY_ID__USER= $(if $(WML_USER_ID), --entity-id $(WML_USER_ID))
__WML_NAME__USER= $(if $(WML_USER_NAME), --name $(WML_USER_NAME))
__WML_ORGANIZATION_ID__USER= $(if $(WML_USER_ORGANIZATION_ID), --organization-id $(WML_USER_ORGANIZATION_ID))
__WML_PASSWORD= $(if $(WML_USER_PASSWORD), --password $(WML_USER_PASSWORD))
__WML_USER_ID= $(if $(WML_USER_ID), --user-id $(WML_USER_ID))
__WML_USER_IDS= $(if $(WML_USER_IDS), --user-ids $(WML_USER_IDS))

# UI parameters
WML_UI_VIEW_USERS_FIELDS?= .{userRole:UserRole,state:State,Id:Id,Name:Name,email:Email}
WML_UI_VIEW_USERS_SET_FIELDS?= $(WML_UI_VIEW_USERS_FIELDS)
WML_UI_VIEW_USERS_SET_SLICE?=

#--- Utilities

#--- MACROS

_wml_get_user_id= $(call _wml_get_user_id_N, $(WML_USER_NAME))
_wml_get_user_id_N= $(call _wml_get_user_id_NO, $(1), $(WML_USER_ORGANIZATION_ID))
_wml_get_user_id_NO= "$(shell $(AWS) workmail list-users --organization-id $(2) --query "Users[?Name=='$(strip $(1))'].Id" --output text)"

#----------------------------------------------------------------------
# USAGE
#

_wml_view_framework_macros ::
	@echo 'AWS::WorkMaiL::User ($(_AWS_WORKMAIL_USER_MK_VERSION)) macros:'
	@echo '    _wml_get_user_id_{|N|NO}                     - Get the ID of a user (Name,OrganizationId)'
	@echo

_wml_view_framework_parameters ::
	@echo 'AWS::WorkMaiL::User ($(_AWS_WORKMAIL_USER_MK_VERSION)) parameters:'
	@echo '    WML_USER_DISPLAYNAME=$(WML_USER_DISPLAYNAME)'
	@echo '    WML_USER_ID=$(WML_USER_ID)'
	@echo '    WML_USER_IDS=$(WML_USER_IDS)'
	@echo '    WML_USER_NAME=$(WML_USER_NAME)'
	@echo '    WML_USER_ORGANIZATION_ID=$(WML_USER_ORGANIZATION_ID)'
	@echo '    WML_USER_PASSWORD=$(WML_USER_PASSWORD)'
	@echo '    WML_USER_PRIMARYEMAIL=$(WML_USER_PRIMARYEMAIL)'
	@echo '    WML_USERS_SET_NAME=$(WML_USERS_SET_NAME)'
	@echo

_wml_view_framework_targets ::
	@echo 'AWS::WorkMaiL::User ($(_AWS_WORKMAIL_USER_MK_VERSION)) targets:'A
	@echo '    _wml_create_user                           - Create a new user'
	@echo '    _wml_delete_user                           - Delete an existing user'
	@echo '    _wml_disable_user                          - Disable a user'
	@echo '    _wml_enable_user                           - Enable a user'
	@echo '    _wml_show_user                             - Show everything related to a user'
	@echo '    _wml_update_user                           - Update a user'
	@echo '    _wml_view_users                            - View users'
	@echo '    _wml_view_users_set                        - View a set of users'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wml_create_user:
	@$(INFO) '$(AWS_UI_LABEL)Creating user "$(WML_USER_NAME)" ...'; $(NORMAL)
	$(AWS) workmail create-user $(__WML_DISPLAY_NAME) $(__WML_NAME__USER) $(__WML_ORGANIZATION_ID__USER) $(__WML_PASSWORD)

_wml_delete_user:
	@$(INFO) '$(AWS_UI_LABEL)Deleting user "$(WML_USER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Only disabled users can be deleted!'; $(NORMAL)
	$(AWS) workmail delete-user $(__WML_ORGANIZATION_ID) $(__WML_USER_ID)

_wml_disable_user:
	@$(INFO) '$(AWS_UI_LABEL)Disabling user "$(WML_USER_NAME)" ...'; $(NORMAL)
	$(AWS) workmail deregister-from-work-mail $(__WML_ENTITY_ID__USER) $(__WML_ORGANIZATION_ID)

_wml_enable_user:
	@$(INFO) '$(AWS_UI_LABEL)Enabling user "$(WML_USER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the provided email is not valid, e.g. [a-zA-Z0-9._%+-]{1,64}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'; $(NORMAL)
	$(AWS) workmail register-to-work-mail $(__WML_EMAIL) $(__WML_ENTITY_ID__USER) $(__WML_ORGANIZATION_ID)

_wml_show_user:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of user "$(WML_USER_NAME)" ...'; $(NORMAL)
	$(AWS) workmail describe-user $(__WML_ORGANIZATION_ID__USER) $(__WML_USER_ID) # --query "Users[]"

_wml_view_users:
	@$(INFO) '$(AWS_UI_LABEL)Viewing users ...'; $(NORMAL)
	$(AWS) workmail list-users $(__WML_ORGANIZATION_ID__USER) --query "Users[]$(WML_UI_VIEW_USERS_FIELDS)"

_wml_view_users_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing users-set "$(WML_USERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Users are grouped based on the provided organization-id and slice'; $(NORMAL)
	$(AWS) workmail list-users $(__WML_ORGANIZATION_ID__USER)  --query "Users[$(WML_UI_VIEW_USERS_SET_SLICE)]$(WML_UI_VIEW_USERS_SET_FIELDS)"
