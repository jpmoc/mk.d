_SKAFFOLD_CONFIG_MK_VERSION= $(_SKAFFOLD_MK_VERSION)

# SFD_CONFIG_APPLICATION_DIRPATH?= ./apps/my-app/
# SFD_CONFIG_APPLICATION_NAME?= my-app
SFD_CONFIG_DIRPATH?= ./
SFD_CONFIG_FILENAME?= skaffold.yaml
# SFD_CONFIG_FILEPATH?= ./skaffold.yaml
# SFD_CONFIG_NAME?= my-name
# SFD_CONFIGS_APPLICATIONS_DIRPATH?= ./apps/
# SFD_CONFIGS_SET_NAME?= my-set

# Derived parameters
SFD_CONFIG_APPLICATION_DIRPATH?= $(SFD_APPLICATION_DIRPATH)
SFD_CONFIG_APPLICATION_NAME?= $(SFD_APPLICATION_NAME)
SFD_CONFIG_FILEPATH?= $(SFD_CONFIG_DIRPATH)$(SFD_CONFIG_FILENAME)
SFD_CONFIG_NAME?= $(if $(SFD_CONFIG_APPLICATION_NAME),$(SFD_CONFIG_APPLICATION_NAME)-config)
SFD_CONFIGS_APPLICATIONS_DIRPATH?= $(SFD_APPLICATIONS_DIRPATH)
SFD_CONFIGS_SET_NAME?= configs@$(SFD_APPLICATIONS_DIRPATH)

# Option parameters
__SFD_FILENAME__CONFIG= $(if $(SFD_CONFIG_FILEPATH),--filename $(SFD_CONFIG_FILEPATH))

# UI & Pipe parameters
_SFD_CREATE_CONFIG_|?= $(_SFD_SHOW_CONFIG_|)
_SFD_DELETE_CONFIG_|?= $(_SFD_CREATE_CONFIG_|)
_SFD_EDIT_CONFIG_|?= $(_SFD_CREATE_CONFIG_|)
_SFD_SHOW_CONFIG_|?= cd $(SFD_CONFIG_APPLICATION_DIRPATH) && #
_SFD_SHOW_CONFIG_CONTENT_|?= $(_SFD_SHOW_CONFIG_|)
_SFD_SHOW_CONFIG_DESCRIPTION_|?= $(_SFD_SHOW_CONFIG_|)
_SFD_VIEW_CONFIGS_|?= cd $(SFD_CONFIGS_APPLICATIONS_DIRPATH) &&
_SFD_VIEW_CONFIGS_SET_|?= $(_SFD_VIEW_CONFIGS_|)
|_SFD_VIEW_CONFIGS?=
|_SFD_VIEW_CONFIGS_SET?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sfd_view_framework_macros ::
	@#echo 'SkaFfolD::Config ($(_SKAFFOLD_CONFIG_MK_VERSION)) macros:'
	@#echo

_sfd_view_framework_parameters ::
	@echo 'SkaFfolD::Config ($(_SKAFFOLD_CONFIG_MK_VERSION)) parameters:'
	@echo '    SFD_CONFIG_APPLICATION_DIRPATH=$(SFD_CONFIG_APPLICATION_DIRPATH)'
	@echo '    SFD_CONFIG_APPLICATION_NAME=$(SFD_CONFIG_APPLICATION_NAME)'
	@echo '    SFD_CONFIG_APPLICATIONS_DIRPATH=$(SFD_CONFIG_APPLICATIONS_DIRPATH)'
	@echo '    SFD_CONFIG_DIRPATH=$(SFD_CONFIG_DIRPATH)'
	@echo '    SFD_CONFIG_FILENAME=$(SFD_CONFIG_FILENAME)'
	@echo '    SFD_CONFIG_FILEPATH=$(SFD_CONFIG_FILEPATH)'
	@echo '    SFD_CONFIG_NAME=$(SFD_CONFIG_NAME)'
	@echo '    SFD_CONFIGS_SET_NAME=$(SFD_CONFIGS_SET_NAME)'
	@echo

_sfd_view_framework_targets ::
	@echo 'SkaFfolD::Config ($(_SKAFFOLD_CONFIG_MK_VERSION)) targets:'
	@echo '    _sfd_create_config             - Create a config'
	@echo '    _sfd_delete_config             - Delete an existing config'
	@echo '    _sfd_edit_config               - Edit a existing config'
	@echo '    _sfd_show_config               - Show everything related to a config'
	@echo '    _sfd_show_config_content       - Show the content of a config'
	@echo '    _sfd_show_config_description   - Show the description of a config'
	@echo '    _sfd_view_configs              - View ALL configs'
	@echo '    _sfd_view_configs_set          - View set of configs'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sfd_create_config:
	@$(INFO) '$(SFD_UI_LABEL)Creating config "$(SFD_CONFIG_NAME)" ...'; $(NORMAL)
	# $(_SFD_CREATE_CONFIG_|)$(SKAFFOLD)

_sfd_delete_config:
	@$(INFO) '$(SFD_UI_LABEL)Deleting config "$(SFD_CONFIG_NAME)" ...'; $(NORMAL)
	$(_SFD_DELETE_CONFIG_|)rm -rf $(SFD_CONFIG_FILEPATH)

_sfd_edit_config:
	@$(INFO) '$(SFD_UI_LABEL)Deleting config "$(SFD_CONFIG_NAME)" ...'; $(NORMAL)
	$(_SFD_EDIT_CONFIG_|)$(EDITOR) $(SFD_CONFIG_FILEPATH)

_sfd_show_config :: _sfd_show_config_content _sfd_show_config_description

_sfd_show_config_content:
	@$(INFO) '$(SFD_UI_LABEL)Showing content of config "$(SFD_CONFIG_NAME)" ...'; $(NORMAL)
	$(_SFD_SHOW_CONFIG_CONTENT_|)cat $(SFD_CONFIG_FILEPATH)

_sfd_show_config_description:
	@$(INFO) '$(SFD_UI_LABEL)Showing description of config "$(SFD_CONFIG_NAME)" ...'; $(NORMAL)
	$(_SFD_SHOW_CONFIG_DESCRIPTION_|)ls -al $(SFD_CONFIG_FILEPATH)

_sfd_view_configs:
	@$(INFO) '$(SFD_UI_LABEL)Viewing ALL configs ...'; $(NORMAL)
	# $(_SFD_VIEW_CONFIGS_|)

_sfd_view_configs_set:
	@$(INFO) '$(SFD_UI_LABEL)Viewing configs-set "$(SFD_CONFIGS_SET_NAME)" ...'; $(NORMAL)
	# $(_SFD_VIEW_CONFIGS_SET_|)
