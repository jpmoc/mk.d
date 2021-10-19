_GIT_CONFIG_MK_VERSION= $(_GIT_MK_VERSION)

GIT_CONFIG_EDITCONFIG_TARGETS?= _git_edit_config_repository
# GIT_CONFIG_REPOSITORY_DIRPATH?= ./git/repository-name
# GIT_CONFIG_REPOSITORYCONFIG_FILEPATH?= ~/git/repo/.git/config
GIT_CONFIG_SHOWCONFIG_TARGETS?= _git_show_config_repository _git_show_config_system _git_show_config_useraccount _git_show_config_overlay
GIT_CONFIG_SHOWORIGIN_FLAG?= false
GIT_CONFIG_SYSTEMCONFIG_FILEPATH?= /etc/gitconfig
# GIT_CONFIG_USERACCOUNTCONFIG_FILEPATH?= $(HOME)/.gitconfig

# Derived variables
GIT_CONFIG_REPOSITORY_DIRPATH?= $(GIT_REPOSITORY_DIRPATH)
GIT_CONFIG_REPOSITORYCONFIG_FILEPATH?= $(GIT_CONFIG_REPOSITORY_DIRPATH)/.git/config
GIT_CONFIG_USERACCOUNTCONFIG_FILEPATH?= $(HOME)/.gitconfig

# Option variables

# UI variables
|_GIT_SHOW_CONFIG_OVERLAY= | cat
|_GIT_SHOW_CONFIG_REPOSITORY= $(|_GIT_SHOW_CONFIG_OVERLAY)
|_GIT_SHOW_CONFIG_SYSTEM= $(|_GIT_SHOW_CONFIG_OVERLAY)
|_GIT_SHOW_CONFIG_USERACCOUNT= $(|_GIT_SHOW_CONFIG_OVERLAY)
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_git_view_framework_macros ::
	@#echo 'Git::Config ($(_GIT_CONFIG_MK_VERSION)) targets:'
	@#echo

_git_view_framework_parameters ::
	@echo 'Git::Config ($(_GIT_CONFIG_MK_VERSION)) parameters:'
	@echo '    GIT_CONFIG_EDITCONFIG_TARGET=$(GIT_CONFIG_EDITCONFIG_TARGET)'
	@echo '    GIT_CONFIG_REPOSITORY_DIRPATH=$(GIT_CONFIG_REPOSITORY_DIRPATH)'
	@echo '    GIT_CONFIG_REPOSITORYCONFIG_FILEPATH=$(GIT_CONFIG_REPOSITORYCONFIG_FILEPAH)'
	@echo '    GIT_CONFIG_SHOWCONFIG_TARGET=$(GIT_CONFIG_SHOWCONFIG_TARGET)'
	@echo '    GIT_CONFIG_SHOWORIGIN_FLAG=$(GIT_CONFIG_SHOWORIGIN_FLAG)'
	@echo '    GIT_CONFIG_SYSTEMCONFIG_FILEPATH=$(GIT_CONFIG_SYSTEMCONFIG_FILEPAH)'
	@echo '    GIT_CONFIG_USERACCOUNTCONFIG_FILEPATH=$(GIT_CONFIG_USERACCOUNTCONFIG_FILEPATH)'
	@echo '    GIT_LOCAL_TOPDIR_CURRENT=$(GIT_LOCAL_TOPDIR_CURRENT)'
	@echo

_git_view_framework_targets ::
	@echo 'Git::Config ($(_GIT_CONFIG_MK_VERSION)) targets:'
	@echo '    _git_edit_config             - Edit the <default> configuration'
	@echo '    _git_edit_config_repository  - Edit the repository configuration'
	@echo '    _git_edit_config_system      - Edit the system-host configuration'
	@echo '    _git_edit_config_useraccount - Edit the user-account configuration'
	@echo '    _git_show_config             - Show everything related to a configuration'
	@echo '    _git_show_config_overlay     - Show the oevrlay of the configurations'
	@echo '    _git_show_config_repository  - Show the repository configuration'
	@echo '    _git_show_config_system      - Show the system-host configuration'
	@echo '    _git_show_config_useraccount - Show the user-account configuration'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

_git_edit_config: $(GIT_CONFIG_EDITCONFIG_TARGETS)

_git_edit_config_repository:
	@$(INFO) '$(GIT_UI_LABEL)Editing the repository configuration ...'; $(NORMAL)
	$(GIT) config --local --edit

_git_edit_config_system:
	@$(INFO) '$(GIT_UI_LABEL)Editing the system configuration ...'; $(NORMAL)
	$(GIT) config --system --edit

_git_edit_config_useraccount:
	@$(INFO) '$(GIT_UI_LABEL)Editing the user-account configuration ...'; $(NORMAL)
	$(GIT) config --local --edit

_git_show_config :: $(GIT_CONFIG_SHOWCONFIG_TARGETS)

_git_show_config_overlay:
	@$(INFO) '$(GIT_UI_LABEL)Showing the overlay configuration ...'; $(NORMAL)
	@$(WARN) 'This operation returns the complete overlay of all the configurations'; $(NORMAL)
	$(GIT) config --list $(__GIT_SHOW_ORIGIN) $(|_GIT_SHOW_CONFIG_OVERLAY)

_git_show_config_repository:
	@$(INFO) '$(GIT_UI_LABEL)Showing the repository configuration ...'; $(NORMAL)
	@$(WARN) 'Repository config: $(GIT_CONFIG_REPOSITORYCONFIG_FILEPATH)'; $(NORMAL)
	$(GIT) config --local --list $(|_GIT_SHOW_CONFIG_REPOSITORY)

_git_show_config_system:
	@$(INFO) '$(GIT_UI_LABEL)Showing the system/host configuration ...'; $(NORMAL)
	@$(WARN) 'System config: $(GIT_CONFIG_SYSTEMCONFIG_FILEPATH)'; $(NORMAL)
	-$(GIT) config --system --list $(|_GIT_SHOW_CONFIG_SYSTEM)

_git_show_config_useraccount:
	@$(INFO) '$(GIT_UI_LABEL)Showing the global/user-account configuration ...'; $(NORMAL)
	@$(WARN) 'User-account config: $(GIT_CONFIG_USERACCOUNTCONFIG_FILEPATH)'; $(NORMAL)
	$(GIT) config --global --list $(|_GIT_SHOW_CONFIG_USERACCOUNT)
