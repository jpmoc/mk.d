_AWS_WORKDOCS_USER_MK_VERSION= $(_AWS_WORKDOCS_MK_VERSION)

# WDS_USER_AUTH_TOKEN?=
# WDS_USER_EMAIL?= email@address.com
# WDS_USER_GIVENNAME?= Bob
# WDS_USER_ID?= "S-1-5-21-2990784087-3063864224-3398220445-1108&d-90672e8e22"
# WDS_USER_IDS?= "S-1-5-21-2990784087-3063864224-3398220445-1108&d-90672e8e22" ...
# WDS_USER_LOCAL?= en
# WDS_USER_NAME?= email@adress.com
# WDS_USER_ORGANIZATION_ID?= d-90672e8e22
# WDS_USER_PASSWORD?=
# WDS_USER_ISPOWERUSER?= false
# WDS_USER_QUERY?=
# WDS_USER_STORAGE_RULE?= StorageAllocatedInBytes=long,StorageType=string
# WDS_USER_SURNAME?= Smith
# WDS_USER_TIMEZONE_ID?=
# WDS_USER_TYPE?= ADMIN
# WDS_USERS_SET_NAME?=

# Derived parameters
WDS_USER_IDS?= $(WDS_USER_ID)
WDS_USER_NAME?= $(WDS_USER_EMAIL)
WDS_USER_ORGANIZATION_ID?= $(AWS_ACCOUNT_ID)

# Option parameters
__WDS_AUTHENTICATION_TOKEN= $(if $(WDS_USER_AUTH_TOKEN), --authentication-token $(WDS_USER_AUTH_TOKEN))
__WDS_EMAIL_ADDRESS= $(if $(WDS_USER_EMAIL), --email-address $(WDS_USER_EMAIL))
__WDS_FIELDS=
__WDS_GIVEN_NAME= $(if $(WDS_USER_GIVENNAME), --given-name $(WDS_USER_GIVENNAME))
__WDS_GRANT_POWERUSER_PRIVILEGES= $(if $(filter true, $(WDS_USER_ISPOWERUSER)), --grant-poweruser-privileges TRUE, --grant-poweruser-privileges FALSE)
__WDS_INCLUDE=
__WDS_LOCALE=
__WDS_ORDER=
__WDS_ORGANIZATION_ID= $(if $(WDS_USER_ORGANIZATION_ID), --organization-id $(WDS_USER_ORGANIZATION_ID))
__WDS_PASSWORD= $(if $(WDS_USER_PASSWORD), --password $(WDS_USER_PASSWORD))
__WDS_SORT=
__WDS_STORAGE_RULE= $(if $(WDS_USER_STORAGE_RULE), --storage-rule $(WDS_USER_STORAGE_RULE))
__WDS_SURNAME= $(if $(WDS_USER_SURNAME), --surname $(WDS_USER_SURNAME))
__WDS_TIME_ZONE_ID= $(if $(WDS_USER_TIMEZONE_ID), --time-zone-id $(WDS_USER_TIMEZONE_ID))
__WDS_TYPE= $(if $(WDS_USER_TYPE), --type $(WDS_USER_TYPE))
__WDS_USER_ID= $(if $(WDS_USER_ID), --user-id $(WDS_USER_ID))
__WDS_USER_IDS= $(if $(WDS_USER_IDS), --user-ids $(WDS_USER_IDS))
__WDS_USER_QUERY= $(if $(WDS_USER_QUERY), --user-query $(WDS_USER_QUERY))
__WDS_USERNAME= $(if $(WDS_USER_NAME), --username $(WDS_USER_NAME))

# UI parameters
WDS_UI_VIEW_USERS_FIELDS?= .{Username:Username,type:Type,Id:Id,status:Status,surname:Surname,givenName:GivenName}
WDS_UI_VIEW_USERS_SET_FIELDS?= $(WDS_UI_VIEW_USERS_FIELDS)
WDS_UI_VIEW_USERS_SET_SLICE?=

#--- Utilities

#--- MACROS

_wds_get_user_id= $(call _wds_get_user_id_N, $(WDS_USER_NAME))
_wds_get_user_id_N= $(call _wds_get_user_id_NO, $(1), $(WDS_USER_ORGANIZATION_ID))
_wds_get_user_id_NO= "$(shell $(AWS) workdocs describe-users --organization-id $(2) --query "Users[?Username=='$(strip $(1))'].Id" --output text)"

#----------------------------------------------------------------------
# USAGE
#

_wds_view_framework_macros ::
	@echo 'AWS::WorkDocS::User ($(_AWS_WORKDOCS_USER_MK_VERSION)) macros:'
	@echo '    _wds_get_user_id_{|N|NO}                     - Get the ID of a user (Name,OrganizationId)'
	@echo

_wds_view_framework_parameters ::
	@echo 'AWS::WorkDocS::User ($(_AWS_WORKDOCS_USER_MK_VERSION)) parameters:'
	@echo '    WDS_USER_AUTH_TOKEN=$(WDS_USER_AUTH_TOKEN)'
	@echo '    WDS_USER_EMAIL=$(WDS_USER_EMAIL)'
	@echo '    WDS_USER_GIVENNAME=$(WDS_USER_GIVENNAME)'
	@echo '    WDS_USER_ID=$(WDS_USER_ID)'
	@echo '    WDS_USER_IDS=$(WDS_USER_IDS)'
	@echo '    WDS_USER_ISPOWERUSER=$(WDS_USER_ISPOWERUSER)'
	@echo '    WDS_USER_LOCAL=$(WDS_USER_LOCAL)'
	@echo '    WDS_USER_NAME=$(WDS_USER_NAME)'
	@echo '    WDS_USER_ORGANIZATION_ID=$(WDS_USER_ORGANIZATION_ID)'
	@echo '    WDS_USER_PASSWORD=$(WDS_USER_PASSWORD)'
	@echo '    WDS_USER_QUERY=$(WDS_USER_QUERY)'
	@echo '    WDS_USER_STORAGE_RULE=$(WDS_USER_STORAGE_RULE)'
	@echo '    WDS_USER_SURNAME=$(WDS_USER_SURNAME)'
	@echo '    WDS_USER_TIMEZONE_ID=$(WDS_USER_TIMEZONE_ID)'
	@echo '    WDS_USERS_SET_NAME=$(WDS_USERS_SET_NAME)'
	@echo

_wds_view_framework_targets ::
	@echo 'AWS::WorkDocS::User ($(_AWS_WORKDOCS_USER_MK_VERSION)) targets:'
	@echo '    _wds_create_user                           - Create a new user'
	@echo '    _wds_delete_user                           - Delete an existing user'
	@echo '    _wds_show_user                             - Show everything related to a user'
	@echo '    _wds_update_user                           - Update a user'
	@echo '    _wds_view_users                            - View users'
	@echo '    _wds_view_users_set                        - View a set of users'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wds_activate_user:
	@$(INFO) '$(AWS_UI_LABEL)Activating user "$(WDS_USER_NAME)" ...'; $(NORMAL)
	$(AWS) workdocs activate-user $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_USER_ID) --query "User"

_wds_create_user:
	@$(INFO) '$(AWS_UI_LABEL)Creating user "$(WDS_USER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'By default, the user is activated and the user-type is MINIMALUSER'; $(NORMAL)
	$(AWS) workdocs create-user $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_EMAIL_ADDRESS) $(__WDS_GIVEN_NAME) $(__WDS_ORGANIZATION_ID) $(__WDS_PASSWORD) $(__WDS_STORAGE_RULE) $(__WDS_SURNAME) $(__WDS_TIME_ZONE_ID) $(__WDS_USERNAME)

_wds_deactivate_user:
	@$(INFO) '$(AWS_UI_LABEL)Deactivating user "$(WDS_USER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails ALL THE TIME! Not sure why!'; $(NORMAL)
	$(AWS) workdocs deactivate-user $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_USER_ID)

_wds_delete_user:
	@$(INFO) '$(AWS_UI_LABEL)Deleting user "$(WDS_USER_NAME)" ...'; $(NORMAL)
	$(AWS) workdocs delete-user $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_USER_ID)

_wds_show_user:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of user "$(WDS_USER_NAME)" ...'; $(NORMAL)
	$(AWS) workdocs describe-users $(__WDS_AUTHENTICATION_TOKEN) $(_X__WDS_FIELDS) $(_X__WDS_INCLUDE) $(_X__WDS_ORDER) $(_X__WDS_ORGANIZATION_ID) $(_X__WDS_SORT) $(_X__WDS_USER_IDS) $(_X__WDS_USER_QUERY) --user-ids $(WDS_USER_ID) --query "Users[]"

_wds_update_user:
	@$(INFO) '$(AWS_UI_LABEL)Updating user "$(WDS_USER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The email address, organization-id, password, username cannot be updated!'; $(NORMAL)
	$(AWS) workdocs update-user $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_GIVEN_NAME) $(__WDS_GRANT_POWERUSER_PRIVILEGES) $(__WDS_LOCALE) $(__WDS_STORAGE_RULE) $(__WDS_SURNAME) $(__WDS_TIME_ZONE_ID) $(__WDS_TYPE) $(__WDS_USER_ID)

_wds_view_users:
	@$(INFO) '$(AWS_UI_LABEL)Viewing users ...'; $(NORMAL)
	$(AWS) workdocs describe-users $(__WDS_AUTHENTICATION_TOKEN) $(_X__WDS_FIELDS) $(_X__WDS_INCLUDE) $(_X__WDS_ORDER) $(__WDS_ORGANIZATION_ID) $(_X__WDS_SORT) $(_X__WDS_USER_IDS) $(_X__WDS_USER_QUERY) --query "Users[]$(WDS_UI_VIEW_USERS_FIELDS)"

_wds_view_users_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing users-set "$(WDS_USERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Users are grouped based on the provided user-ids, organization-id, slice'; $(NORMAL)
	$(AWS) workdocs describe-users $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_FIELDS) $(__WDS_INCLUDE) $(__WDS_ORDER) $(__WDS_ORGANIZATION_ID) $(__WDS_SORT) $(__WDS_USER_IDS) $(__WDS_USER_QUERY) --query "Users[$(WDS_UI_VIEW_USERS_SET_SLICE)]$(WDS_UI_VIEW_USERS_SET_FIELDS)"
