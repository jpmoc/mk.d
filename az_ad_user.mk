_AZ_AD_USER_MK_VERSION= $(_AZ_AD_MK_VERSION)

# AD_USER_DISPLAYNAME?=
# AD_USER_ID?=
# AD_USER_NAME?= emayssat@domain.com
# AD_USER_PASSWORD?=
# AD_USER_PRINCIPAL_NAME?=
# AD_USERS_DISPLAYNAME?=
# AD_USERS_FILTER?=
# AD_USERS_PRINCIPAL_NAME?= emayssat@domain.com
# AD_USERS_SET_NAME?= my-user-set

# Derived parameters
AD_USER_ID?= $(AD_USER_NAME)
AD_USER_PRINCIPAL_NAME?= $(AD_USER_NAME)
AD_USERS_PRINCIPAL_NAME?= $(AD_USER_PRINCIPAL_NAME)

# Options parameters
__AD_ACCOUNT_ENABLED=
__AD_DISPLAY_NAME__USER= $(if $(AD_USER_DISPLAYNAME),--display-name $(AD_USER_DISPLAYNAME))
__AD_DISPLAY_NAME__USERS= $(if $(AD_USERS_DISPLAYNAME),--display-name $(AD_USERS_DISPLAYNAME))
__AD_ID__USER= $(if $(AD_USER_ID),--id $(AD_USER_ID))
__AD_FILTER__USERS= $(if $(AD_USERS_FILTER),--filter $(AD_USERS_FILTER))
__AD_FORCE_CHANGE_PASSWORD_NEXT_LOGIN=
__AD_IMMUTABLE_ID=
__AD_MAIL_NICKNAME=
# __AD_OUTPUT?=
__AD_PASSWORD=
__AD_UPN=
__AD_USER_PRINCIPAL_NAME= $(if $(AD_USER_PRINCIPAL_NAME),--user-principal-name $(AD_USER_PRINCIPAL_NAME))

# Pipe

# UI parameters
AD_UI_SHOW_USER_FIELDS?= .{city:city,displayName:displayName,jobTitle:jobTitle,phyisicalDeliveryOfficeName:physicalDeliveryOfficeName,sipProxyAddress:sipProxyAddress}
AD_UI_VIEW_USERS_FIELDS?= .{city:city,displayName:displayName,jobTitle:jobTitle,phyisicalDeliveryOfficeName:physicalDeliveryOfficeName,sipProxyAddress:sipProxyAddress}
AD_UI_VIEW_USERS_SET_FIELDS?= $(AD_UI_VIEW_USERS_FIELDS)

#--- Utilities

#--- MACRO
_ad_get_user_id= $(call _ad_get_user_id_N, $(AD_USER_DISPLAYNAME))
_ad_get_user_id_N=

#----------------------------------------------------------------------
# USAGE
#

_ad_view_framework_macros ::
	@echo 'AZ::AD::User ($(_AZ_AD_USER_MK_VERSION)) macros:'
	@echo '    _ad_get_user_id_{|N}   - Get the id of a user (displayName)'
	@echo

_ad_view_framework_parameters ::
	@echo 'AZ::AD::User ($(_AZ_AD_USER_MK_VERSION)) parameters:'
	@echo '    AD_USER_DISPLAYNAME=$(AD_USER_DISPLAYNAME)'
	@echo '    AD_USER_ID=$(AD_USER_ID)'
	@echo '    AD_USER_NAME=$(AD_USER_NAME)'
	@echo '    AD_USER_PASSWORD=$(AD_USER_PASSWORD)'
	@echo '    AD_USER_PRINCIPAL_NAME=$(AD_USER_PRINCIPAL_NAME)'
	@echo '    AD_USERS_DISPLAYNAME=$(AD_USERS_DISPLAYNAME)'
	@echo '    AD_USERS_FILTER=$(AD_USERS_FILTER)'
	@echo '    AD_USERS_PRINCIPAL_NAME=$(AD_USERS_PRINCIPAL_NAME)'
	@echo '    AD_USERS_SET_NAME=$(AD_USERS_SET_NAME)'
	@echo

_ad_view_framework_targets ::
	@echo 'AZ::AD::User ($(_AZ_AD_USER_MK_VERSION)) targets:'
	@echo '    _ad_create_user             - Create a user'
	@echo '    _ad_delete_user             - Delete a user'
	@echo '    _ad_show_user               - Show everything related to a user'
	@echo '    _ad_show_user_description   - Show desription of a user'
	@echo '    _ad_show_user_object        - Show the object of a user'
	@echo '    _ad_update_user             - Update a user'
	@echo '    _ad_view_users              - View users'
	@echo '    _ad_view_users_set          - View a set of users'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ad_create_user:
	@$(INFO) '$(AD_UI_LABEL)Creating user "$(AD_USER_NAME)" ...'; $(NORMAL)
	$(AZ) ad user create $(__AD_DISPLAY_NAME__USER) $(__AD_FORCE_CHANGE_PASSWORD_NEXT_LOGIN) $(__AD_IMMUTABLE_ID) $(__AD_MAIL_NICKNAME) $(__AD_OUTPUT) $(__AD_PASSWORD) $(__AD_USER_PRINCIPAL_NAME)

_ad_delete_user:
	@$(INFO) '$(AD_UI_LABEL)Deleting user "$(AD_USER_NAME)" ...'; $(NORMAL)
	$(AZ) ad user delete $(__AD_ID__USER) $(__AD_OUTPUT)

_ad_show_user :: _ad_show_user_object _ad_show_user_description

_ad_show_user_description:
	@$(INFO) '$(AD_UI_LABEL)Showing description of user "$(AD_USER_NAME)" ...'; $(NORMAL)
	$(AZ) ad user show $(__AD_ID__USER) $(__AD_OUTPUT) --query "@$(AD_UI_SHOW_USER_FIELDS)"

_ad_show_user_object:
	@$(INFO) '$(AD_UI_LABEL)Showing the object of user "$(AD_USER_NAME)" ...'; $(NORMAL)
	$(AZ) ad user show $(__AD_ID__USER) $(_X__AD_OUTPUT) --output json

_ad_update_user:
	@$(INFO) '$(AD_UI_LABEL)Updating user "$(AD_USER_NAME)" ...'; $(NORMAL)
	$(AZ) ad user update $(__AD_ACCOUNT_ENABLED) $(__AD_DISPLAY_NAME__USER) $(__AD_FORCE_CHANGE_PASSWORD_NEXT_LOGIN) $(__AD_ID__USER) $(__AD_MAIL_NICKNAME) $(__AD_OUTPUT) $(__AD_PASSWORD)

_ad_view_users:
	@$(INFO) '$(AD_UI_LABEL)Viewing users ...'; $(NORMAL)
	$(AZ) ad user list $(_X__AD_DISPLAY_NAME__USERS) $(_X__AD_FILTER__USERS) $(__AD_OUTPUT) $(_X__AD_UPN) --query "[]$(AD_UI_VIEW_USERS_FIELDS)"

_ad_view_users_set:
	@$(INFO) '$(AD_UI_LABEL)Viewing users-set "$(AD_USERS_SET_NAME) ...'; $(NORMAL)
	$(AZ) ad user list $(__AD_DISPLAY_NAME__USERS) $(__AD_FILTER__USERS) $(__AD_OUTPUT) $(__AD_UPN)
