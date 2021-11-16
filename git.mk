_GIT_MK_VERSION= 0.99.0

# GIT_PARAMETER?= value
GIT_UI_LABEL?= [git] #

# Derived parameters

# Options

# Customizations
 
#--- Utilities
GIT_BIN?= git
GIT?= $(strip $(__GIT_ENVIRONMENT) $(GIT_ENVIRONMENT) $(GIT_BIN) $(__GIT_OPTIONS) $(GIT_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _git_list_macros
_git_list_macros ::
	@#echo 'Git:: ($(_GIT_MK_VERSION)) targets:'
	@#echo

_list_parameters :: _git_list_parameters
_git_list_parameters ::
	@echo 'Git:: ($(_GIT_MK_VERSION)) parameters:'
	@echo '    GIT_UI_LABEL=$(GIT_UI_LABEL)'
	@echo

_list_targets :: _git_list_targets
_git_list_targets ::
	@echo 'Git:: ($(_GIT_MK_VERSION)) targets:'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/git_branch.mk
-include $(MK_DIR)/git_commit.mk
-include $(MK_DIR)/git_config.mk
-include $(MK_DIR)/git_repository.mk
-include $(MK_DIR)/git_submodule.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_view_versions :: _git_view_versions
_git_view_versions:
	@$(INFO) '$(GIT_UI_LABEL)Viewing versions of dependencies'; $(NORMAL)
	git --version
