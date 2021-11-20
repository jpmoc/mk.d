_SKAFFOLD_USERCONFIG_MK_VERSION= $(_SKAFFOLD_MK_VERSION)

SFD_USERCONFIG_DIRPATH?= $(HOME)/.skaffold/
SFD_USERCONFIG_FILENAME?= config
# SFD_USERCONFIG_FILEPATH?= $(HOME)/.skaffold/config
# SFD_USERCONFIG_NAME?= my-name
# SFD_USERCONFIGS_DIRPATH?= $(HOME)/.skaffold
# SFD_USERCONFIGS_SET_NAME?= my-set

# Derived parameters
SFD_USERCONFIG_FILEPATH?= $(SFD_USERCONFIG_DIRPATH)$(SFD_USERCONFIG_FILENAME)
SFD_USERCONFIG_NAME?= $(SFD_USERCONFIG_FILENAME)
SFD_USERCONFIGS_DIRPATH?= $(SFD_USERCONFIG_DIRPATH)
SFD_USERCONFIGS_SET_NAME?= user-configs@$(SFD_USERCONFIGS_DIRPATH)

# Options

# Customizations

# Macros

#----------------------------------------------------------------------
# USAGE
#

_sfd_list_macros ::
	@#echo 'SkaFfolD::UserConfig ($(_SKAFFOLD_USERCONFIG_MK_VERSION)) macros:'
	@#echo

_sfd_list_parameters ::
	@echo 'SkaFfolD::UserConfig ($(_SKAFFOLD_USERCONFIG_MK_VERSION)) parameters:'
	@echo '    SFD_USERCONFIG_DIRPATH=$(SFD_USERCONFIG_DIRPATH)'
	@echo '    SFD_USERCONFIG_FILENAME=$(SFD_USERCONFIG_FILENAME)'
	@echo '    SFD_USERCONFIG_FILEPATH=$(SFD_USERCONFIG_FILEPATH)'
	@echo '    SFD_USERCONFIG_NAME=$(SFD_USERCONFIG_NAME)'
	@echo '    SFD_USERCONFIGS_DIRPATH=$(SFD_USERCONFIGS_DIRPATH)'
	@echo '    SFD_USERCONFIGS_SET_NAME=$(SFD_USERCONFIGS_SET_NAME)'
	@echo

_sfd_list_targets ::
	@echo 'SkaFfolD::UserConfig ($(_SKAFFOLD_USERCONFIG_MK_VERSION)) targets:'
	@echo '    _sfd_create_userconfig             - Create a user-config'
	@echo '    _sfd_delete_userconfig             - Delete an existing user-config'
	@echo '    _sfd_edit_userconfig               - Edit a existing user-config'
	@echo '    _sfd_list_userconfigs              - List ALL user-configs'
	@echo '    _sfd_list_userconfigs_set          - List set of user-configs'
	@echo '    _sfd_show_userconfig               - Show everything related to a user-config'
	@echo '    _sfd_show_userconfig_content       - Show the content of a user-config'
	@echo '    _sfd_show_userconfig_description   - Show the description of a user-config'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sfd_create_userconfig:
	@$(INFO) '$(SFD_UI_LABEL)Creating user-config "$(SFD_USERCONFIG_NAME)" ...'; $(NORMAL)
	# $(_SFD_CREATE_USERCONFIG_|)$(SKAFFOLD)

_sfd_delete_userconfig:
	@$(INFO) '$(SFD_UI_LABEL)Deleting user-config "$(SFD_USERCONFIG_NAME)" ...'; $(NORMAL)
	rm -rf $(SFD_USERCONFIG_FILEPATH)

_sfd_edit_userconfig:
	@$(INFO) '$(SFD_UI_LABEL)Deleting user-config "$(SFD_USERCONFIG_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(SFD_USERCONFIG_FILEPATH)

_sfd_show_userconfig :: _sfd_show_userconfig_content _sfd_show_userconfig_description

_sfd_show_userconfig_content:
	@$(INFO) '$(SFD_UI_LABEL)Showing content of user-config "$(SFD_USERCONFIG_NAME)" ...'; $(NORMAL)
	cat $(SFD_USERCONFIG_FILEPATH)

_sfd_show_userconfig_description:
	@$(INFO) '$(SFD_UI_LABEL)Showing description of user-config "$(SFD_USERCONFIG_NAME)" ...'; $(NORMAL)
	ls -al $(SFD_USERCONFIG_FILEPATH)

_sfd_list_userconfigs:
	@$(INFO) '$(SFD_UI_LABEL)Listing ALL user-configs ...'; $(NORMAL)
	# $(_SFD_LIST_USERCONFIGS_|)

_sfd_list_userconfigs_set:
	@$(INFO) '$(SFD_UI_LABEL)Listing user-configs-set "$(SFD_USERCONFIGS_SET_NAME)" ...'; $(NORMAL)
	# $(_SFD_LIST_USERCONFIGS_SET_|)
