_SKAFFOLD_PROFILE_MK_VERSION= $(_SKAFFOLD_MK_VERSION)

# SFD_PROFILE_APPLICATION_DIRPATH?= ./apps/my-app/
# SFD_PROFILE_APPLICATION_NAME?= my-app
# SFD_PROFILE_CONFIG_DIRPATH?= ./
# SFD_PROFILE_CONFIG_FILENAME?= skaffold.yaml
# SFD_PROFILE_CONFIG_FILEPATH?= ./skaffold.yaml
# SFD_PROFILE_CONFIG_NAME?= my-app-config
# SFD_PROFILE_NAME?= my-name
# SFD_PROFILES_APPLICATIONS_DIRPATH?= ./apps/
# SFD_PROFILES_CONFIG_FILEPATH?= ./skaffold.yaml
# SFD_PROFILES_CONFIG_NAME?= my-app-config
# SFD_PROFILES_SET_NAME?= my-set

# Derived parameters
SFD_PROFILE_APPLICATION_DIRPATH?= $(SFD_APPLICATION_DIRPATH)
SFD_PROFILE_APPLICATION_NAME?= $(SFD_APPLICATION_NAME)
SFD_PROFILE_CONFIG_DIRPATH?= $(SFD_CONFIG_DIRPATH)
SFD_PROFILE_CONFIG_FILENAME?= $(SFD_CONFIG_FILENAME)
SFD_PROFILE_CONFIG_FILEPATH?= $(SFD_PROFILE_CONFIG_DIRPATH)$(SFD_PROFILE_CONFIG_FILENAME)
SFD_PROFILE_CONFIG_NAME?= $(SFD_CONFIG_NAME)
SFD_PROFILE_NAME?= $(SKAFFOLD_PROFILE_NAME)
SFD_PROFILES_APPLICATION_DIRPATH?= $(SFD_PROFILE_APPLICATION_DIRPATH)
SFD_PROFILES_CONFIG_FILEPATH?= $(SFD_PROFILE_CONFIG_FILEPATH)
SFD_PROFILES_CONFIG_NAME?= $(SFD_PROFILE_CONFIG_NAME)
SFD_PROFILES_SET_NAME?= profiles@$(SFD_PROFILES_CONFIG_NAME)

# Options
__SFD_FILENAME__PROFILE= $(if $(SFD_PROFILE_CONFIG_FILEPATH),--filename $(SFD_PROFILE_CONFIG_FILEPATH))
__SFD_PROFILE= $(if $(SFD_PROFILE_NAME),--profile $(SFD_PROFILE_NAME))

# Customizations
_SFD_CREATE_PROFILE_|?= $(_SFD_SHOW_PROFILE_|)
_SFD_DELETE_PROFILE_|?= $(_SFD_CREATE_PROFILE_|)
_SFD_EDIT_PROFILE_|?= $(_SFD_CREATE_PROFILE_|)
_SFD_LIST_PROFILES_SET_QUERYFILTER?=
_SFD_LIST_PROFILES_|?= $(if $(SFD_PROFILES_APPLICATION_DIRPATH),cd $(SFD_PROFILES_APPLICATION_DIRPATH) && )#
_SFD_LIST_PROFILES_SET_|?= $(_SFD_LIST_PROFILES_|)
|_SFD_LIST_PROFILES?=
|_SFD_LIST_PROFILES_SET?=
_SFD_SHOW_PROFILE_|?= $(if $(SFD_PROFILE_APPLICATION_DIRPATH),cd $(SFD_PROFILE_APPLICATION_DIRPATH) && )#
_SFD_SHOW_PROFILE_CONFIG_|?= $(_SFD_SHOW_PROFILE_|)
_SFD_SHOW_PROFILE_DESCRIPTION_|?= $(_SFD_SHOW_PROFILE_|)

# Macros

#----------------------------------------------------------------------
# USAGE
#

_sfd_list_macros ::
	@#echo 'SkaFfolD::Profile ($(_SKAFFOLD_PROFILE_MK_VERSION)) macros:'
	@#echo

_sfd_list_parameters ::
	@echo 'SkaFfolD::Profile ($(_SKAFFOLD_PROFILE_MK_VERSION)) parameters:'
	@echo '    SFD_PROFILE_APPLICATION_DIRPATH=$(SFD_PROFILE_APPLICATION_DIRPATH)'
	@echo '    SFD_PROFILE_CONFIG_DIRPATH=$(SFD_PROFILE_CONFIG_DIRPATH)'
	@echo '    SFD_PROFILE_CONFIG_FILENAME=$(SFD_PROFILE_CONFIG_FILENAME)'
	@echo '    SFD_PROFILE_CONFIG_FILEPATH=$(SFD_PROFILE_CONFIG_FILEPATH)'
	@echo '    SFD_PROFILE_CONFIG_NAME=$(SFD_PROFILE_CONFIG_NAME)'
	@echo '    SFD_PROFILE_NAME=$(SFD_PROFILE_NAME)'
	@echo '    SFD_PROFILES_APPLICATION_DIRPATH=$(SFD_PROFILES_APPLICATION_DIRPATH)'
	@echo '    SFD_PROFILES_CONFIG_FILEPATH=$(SFD_PROFILES_CONFIG_FILEPATH)'
	@echo '    SFD_PROFILES_CONFIG_NAME=$(SFD_PROFILES_CONFIG_NAME)'
	@echo '    SFD_PROFILES_SET_NAME=$(SFD_PROFILES_SET_NAME)'
	@echo

_sfd_list_targets ::
	@echo 'SkaFfolD::Profile ($(_SKAFFOLD_PROFILE_MK_VERSION)) targets:'
	@echo '    _sfd_create_profile             - Create a profile'
	@echo '    _sfd_delete_profile             - Delete an existing profile'
	@echo '    _sfd_list_profiles              - List all profiles'
	@echo '    _sfd_list_profiles_set          - List a set of profiles'
	@echo '    _sfd_show_profile               - Show everything related to a profile'
	@echo '    _sfd_show_profile_config        - Show the config of a profile'
	@echo '    _sfd_show_profile_description   - Show the description of a profile'
	@#echo '    _sfd_watch_profiles             - Watch ALL profiles'
	@#echo '    _sfd_watch_profiles_set         - Watch a set of profiles'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sfd_create_profile:
	@$(INFO) '$(SFD_UI_LABEL)Creating profile "$(SFD_PROFILE_NAME)" ...'; $(NORMAL)
	# $(_SFD_CREATE_PROFILE_|)$(SKAFFOLD)

_sfd_delete_profile:
	@$(INFO) '$(SFD_UI_LABEL)Deleting profile "$(SFD_PROFILE_NAME)" ...'; $(NORMAL)
	# $(_SFD_DELETE_PROFILE_|)

_sfd_list_profiles:
	@$(INFO) '$(SFD_UI_LABEL)Listing ALL profiles ...'; $(NORMAL)
	$(_SFD_LIST_PROFILES_|)yq eval '.profiles' $(SFD_PROFILES_CONFIG_FILEPATH)

_sfd_list_profiles_set:
	@$(INFO) '$(SFD_UI_LABEL)Listing profiles-set "$(SFD_PROFILES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Profiles are grouped based on the provided config-file and query-filter''; $(NORMAL)'
	$(_SFD_LIST_PROFILES_SET_|)yq eval '.profiles[$(_SFD_LIST_PROFILES_SET_QUERYFILTER)]' $(SFD_PROFILES_CONFIG_FILEPATH)

_SFD_SHOW_PROFILE_TARGETS?= _sfd_show_profile_config _sfd_show_profile_description
_sfd_show_profile: $(_SFD_SHOW_PROFILE_TARGETS)

_sfd_show_profile_config:
	@$(INFO) '$(SFD_UI_LABEL)Showing config of profile "$(SFD_PROFILE_NAME)" ...'; $(NORMAL)
	$(_SFD_SHOW_PROFILE_CONFIG_|)$(SKAFFOLD) diagnose $(__SFD_FILENAME__PROFILE) $(__SFD_PROFILE)

_sfd_show_profile_description:
	@$(INFO) '$(SFD_UI_LABEL)Showing description of profile "$(SFD_PROFILE_NAME)" ...'; $(NORMAL)
	$(_SFD_SHOW_PROFILE_DESCRIPTION_|)yq eval '.profiles[]|select(.name=="$(SFD_PROFILE_NAME)")' $(SFD_PROFILE_CONFIG_FILEPATH)
