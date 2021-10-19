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
SFD_PROFILES_APPLICATION_DIRPATH?= $(SFD_PROFILE_APPLICATION_DIRPATH)
SFD_PROFILES_CONFIG_FILEPATH?= $(SFD_PROFILE_CONFIG_FILEPATH)
SFD_PROFILES_CONFIG_NAME?= $(SFD_PROFILE_CONFIG_NAME)
SFD_PROFILES_SET_NAME?= profiles@$(SFD_PROFILES_CONFIG_NAME)

# Option parameters
__SFD_FILENAME__PROFILE= $(if $(SFD_PROFILE_CONFIG_FILEPATH),--filename $(SFD_PROFILE_CONFIG_FILEPATH))
__SFD_PROFILE= $(if $(SFD_PROFILE_NAME),--profile $(SFD_PROFILE_NAME))

# UI & Pipe parameters
SFD_UI_VIEW_PROFILES_SET_QUERYFILTER?=
_SFD_CREATE_PROFILE_|?= $(_SFD_SHOW_PROFILE_|)
_SFD_DELETE_PROFILE_|?= $(_SFD_CREATE_PROFILE_|)
_SFD_EDIT_PROFILE_|?= $(_SFD_CREATE_PROFILE_|)
_SFD_SHOW_PROFILE_|?= cd $(SFD_PROFILE_APPLICATION_DIRPATH) && #
_SFD_SHOW_PROFILE_CONFIG_|?= $(_SFD_SHOW_PROFILE_|)
_SFD_SHOW_PROFILE_DESCRIPTION_|?= $(_SFD_SHOW_PROFILE_|)
_SFD_VIEW_PROFILES_|?= cd $(SFD_PROFILES_APPLICATION_DIRPATH) && #
_SFD_VIEW_PROFILES_SET_|?= $(_SFD_VIEW_PROFILES_|)
|_SFD_VIEW_PROFILES?=
|_SFD_VIEW_PROFILES_SET?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sfd_view_framework_macros ::
	@#echo 'SkaFfolD::Profile ($(_SKAFFOLD_PROFILE_MK_VERSION)) macros:'
	@#echo

_sfd_view_framework_parameters ::
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

_sfd_view_framework_targets ::
	@echo 'SkaFfolD::Profile ($(_SKAFFOLD_PROFILE_MK_VERSION)) targets:'
	@echo '    _sfd_create_profile             - Create a profile'
	@echo '    _sfd_delete_profile             - Delete an existing profile'
	@echo '    _sfd_show_profile               - Show everything related to a profile'
	@echo '    _sfd_show_profile_config        - Show the config of a profile'
	@echo '    _sfd_show_profile_description   - Show the description of a profile'
	@echo '    _sfd_view_profiles              - View ALL profiles'
	@echo '    _sfd_view_profiles_set          - View a set of profiles'
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

_sfd_show_profile :: _sfd_show_profile_config _sfd_show_profile_description

_sfd_show_profile_config:
	@$(INFO) '$(SFD_UI_LABEL)Showing config of profile "$(SFD_PROFILE_NAME)" ...'; $(NORMAL)
	$(_SFD_SHOW_PROFILE_CONFIG_|)$(SKAFFOLD) diagnose $(__SFD_FILENAME__PROFILE) $(__SFD_PROFILE)

_sfd_show_profile_description:
	@$(INFO) '$(SFD_UI_LABEL)Showing description of profile "$(SFD_PROFILE_NAME)" ...'; $(NORMAL)
	# $(_SFD_SHOW_PROFILE_DESCRIPTION_|)yq eval '.profiles' $(SFD_PROFILE_CONFIG_FILEPATH)

_sfd_view_profiles:
	@$(INFO) '$(SFD_UI_LABEL)Viewing ALL profiles ...'; $(NORMAL)
	$(_SFD_VIEW_PROFILES_|)yq eval '.profiles' $(SFD_PROFILES_CONFIG_FILEPATH)

_sfd_view_profiles_set:
	@$(INFO) '$(SFD_UI_LABEL)Viewing profiles-set "$(SFD_PROFILES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Profiles are grouped based on the provided config-file and query-filter''; $(NORMAL)'
	$(_SFD_VIEW_PROFILES_SET_|)yq eval '.profiles[$(SFD_UI_VIEW_PROFILES_SET_QUERYFILTER)]' $(SFD_PROFILES_CONFIG_FILEPATH)
