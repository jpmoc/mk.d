_GIT_MK_VERSION= 0.99.0

# GIT_PARAMETER?= value

# Derived parameters

# Option parameters

# UI parameters
GIT_UI_LABEL?= [git] #
 
#--- Utilities
GIT_BIN?= git
GIT?= $(strip $(__GIT_ENVIRONMENT) $(GIT_ENVIRONMENT) $(GIT_BIN) $(__GIT_OPTIONS) $(GIT_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _git_view_framework_macros
_git_view_framework_macros ::
	@#echo 'Git:: ($(_GIT_MK_VERSION)) targets:'
	@#echo

_view_framework_parameters :: _git_view_framework_parameters
_git_view_framework_parameters ::
	@#echo 'Git:: ($(_GIT_MK_VERSION)) parameters:'
	@#echo

_view_framework_targets :: _git_view_framework_targets
_git_view_framework_targets ::
	@#echo 'Git:: ($(_GIT_MK_VERSION)) targets:'
	@#echo

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

