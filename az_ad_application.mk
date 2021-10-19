_AZ_AD_APPLICATION_MK_VERSION= $(_AZ_AD_MK_VERSION)

# AD_APPLICATION_DISPLAY_NAME= "My Display Name"
# AD_APPLICATION_ID?= f0bdb2fb-7148-4a4f-ac82-c2c357243d58
# AD_APPLICATION_NAME?= my-application
# AD_APPLICATIONS_SET_NAME?= my-application-set

# Derived parameters
AD_APPLICATION_DISPLAY_NAME?= $(AD_APPLICATION_NAME)
AD_APPLICATION_NAME?= $(AZ_APPLICATION_NAME)

# Options parameters
__AD_ALL= --all
__AD_APP_ID= $(if $(AD_APPLICATION_ID),--app-id $(AD_APPLICATION_ID))
__AD_APP_ROLES=
__AD_AVAILABLE_TO_OTHER_TENANTS=
__AD_CREDENTIAL_DESCRIPTION=
__AD_DISPLAY_NAME= $(if $(AD_APPLICATION_DISPLAY_NAME),--display-name $(APPLICATION_DISPLAY_NAME))
__AD_END_DATE=
__AD_FILTER= $(if $(AD_APPLICATION_FILTER),--filter $(AD_APPLICATION_FILTER))
__AD_HOMEPAGE=
__AD_ID__APPLICATION= $(if $(AD_APPLICATION_ID),--id $(AD_APPLICATION_ID))
__AD_IDENTIFIER_URIS=
__AD_KEY_TYPE=
__AD_KEY_USAGE=
__AD_KEY_VALUE=
__AD_NAME__APPLICATION= $(if $(AD_APPLICATION_NAME),--name $(AD_APPLICATION_NAME))
__AD_NATIVE_APP=
__AD_OAUTH2_ALLOW_IMPLICIT_FLOW=
# __AD_OUTPUT?=
__AD_PASSWORD=
__AD_REPLY_URLS=
__AD_REQUIRED_RESOURCE_ACCESSES=
__AD_START_DATE=

# Pipe

# UI parameters

#--- Utilities

#--- MACRO
_ad_get_application_id= $(call _ad_get_application_id_N, $(AD_APPLICATION_DISPLAY_NAME))
_ad_get_applicaiton_id_N=

#----------------------------------------------------------------------
# USAGE
#

_ad_view_framework_macros ::
	@echo 'AZ::AD::Application ($(_AZ_AD_APPLICATION_MK_VERSION)) macros:'
	@echo '    _ad_get_application_id_{|N}   - Get the id of a application (displayName)'
	@echo

_ad_view_framework_parameters ::
	@echo 'AZ::AD::Application ($(_AZ_AD_APPLICATION_MK_VERSION)) parameters:'
	@echo '    AD_APPLICATION_DISPLAY_NAME=$(AD_APPLICATION_DISPLAY_NAME)'
	@echo '    AD_APPLICATION_ID=$(AD_APPLICATION_ID)'
	@echo '    AD_APPLICATION_NAME=$(AD_APPLICATION_NAME)'
	@echo '    AD_APPLICATIONS_FILTER=$(AD_APPLICATIONS_FILTER)'
	@echo '    AD_APPLICATIONS_SET_NAME=$(AD_APPLICATIONS_SET_NAME)'
	@echo

_ad_view_framework_targets ::
	@echo 'AZ::AD::Application ($(_AZ_AD_APPLICATION_MK_VERSION)) targets:'
	@echo '    _ad_create_application             - Create an application'
	@echo '    _ad_delete_application             - Delete an application'
	@echo '    _ad_show_application               - Show everything related to an application'
	@echo '    _ad_show_application_description   - Show desription of an application'
	@echo '    _ad_show_application_object        - Show the object of an application'
	@echo '    _ad_update_application             - Update an application'
	@echo '    _ad_view_applications              - View applications'
	@echo '    _ad_view_applications_set          - View a set of applications'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ad_create_application:
	@$(INFO) '$(AD_UI_LABEL)Creating application "$(AD_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a application only if its name is not already used'; $(NORMAL)
	$(AZ) ad app create $(strip $(__AD_APP_ROLES) $(__AD_AVAILABLE_TO_OTHER_TENANTS) $(__AD_CREDENTIAL_DESCRIPTION) $(__AD_DISPLAY_NAME) $(__AD_END_DATE) $(__AD_HOMEPAGE) $(__AD_IDENTIFIERS_URIS) $(__AD_KEY_TYPE) $(__AD_KEY_USAGE) $(__AD_KEY_VALUE) $(__AD_NATIVE_APP) $(__AD_OAUTH2_ALLOW_IMPLICIT_FLOW) $(__AD_OUTPUT) $(__AD_PASSWORD) $(__AD_REPLY_URLS) $(__AD_REQUIRED_RESOURCE_ACCESSES) $(__AD_START_DATE) )

_ad_delete_application:
	@$(INFO) '$(AD_UI_LABEL)Deleting application "$(AD_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation identifies in the subscription the to-be-deleted application based on its name'; $(NORMAL)
	# $(AZ) ad app delete $(__AD_NAME__APPLICATION) $(__AD_NO_WAIT__APPLICATION) $(__AD_OUTPUT) $(__AD_SUBSCRIPTION) $(__AD_YES__APPLICATION)

_ad_show_application :: _ad_show_application_object _ad_show_application_description

_ad_show_application_description:
	@$(INFO) '$(AD_UI_LABEL)Showing description of application "$(AD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AZ) ad app show $(__AD_ID__APPLICATION) $(__AD_OUTPUT)

_ad_show_application_object:
	@$(INFO) '$(AD_UI_LABEL)Showing the object of application "$(AD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AZ) ad app show $(__AD_ID__APPLICATION) $(_X__AD_OUTPUT)

_ad_update_application:
	@$(INFO) '$(AD_UI_LABEL)Updating application "$(AD_APPLICATION_NAME)" ...'; $(NORMAL)
	# To be implemented!

_ad_view_applications:
	@$(INFO) '$(AD_UI_LABEL)Viewing applications ...'; $(NORMAL)
	$(AZ) ad app list $(__AD_ALL) $(__AD_APP_ID) $(__AD_DISPLAY_NAME) $(_X__AD_FILTER) $(__AD_IDENTIFIER_URI) $(__AD_OUTPUT) $(__AD_SHOW_MINE) $(__AD_SUBSCRIPTION)

_ad_view_applications_set:
	@$(INFO) '$(AD_UI_LABEL)Viewing applications-set "$(AD_APPLICATIONS_SET_NAME) ...'; $(NORMAL)
	# $(AZ) ad app list $(_X__AD_ALL) $(__AD_APP_ID) $(__AD_DISPLAY_NAME) $(__AD_FILTER) $(__AD_IDENTIFIER_URI) $(__AD_OUTPUT) $(__AD_SHOW_MINE) $(__AD_SUBSCRIPTION)
