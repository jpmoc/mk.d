_GIT_BRANCH_MK_VERSION= $(_GIT_MK_VERSION)

GIT_BRANCH_FORCE_FLAG?= false
GIT_BRANCH_GRAPH_FLAG?= false
GIT_BRANCH_HISTORY_COUNT?= 20
# GIT_BRANCH_NAME?= master
GIT_BRANCH_ONELINE_FLAG?= false
GIT_BRANCH_REMOTE?= origin
GIT_BRANCHES_REGEX?= '.*'
# GIT_BRANCHES_SET_NAME?= branches@regex

# Derived variables
GIT_BRANCHES_SET_NAME?= branches@$(GIT_BRANCHES_REGEX)

# Option variables
__GIT_GRAPH?= $(if $(filter true, $(GIT_BRANCH_GRAPH_FLAG)),--graph)
__GIT_MAX_COUNT?= $(if $(GIT_BRANCH_HISTORY_COUNT), --max-count=$(GIT_BRANCH_HISTORY_COUNT))
__GIT_ONELINE?= $(if $(filter true, $(GIT_BRANCH_ONELINE_FLAG)),--oneline)

# UI variables
|_GIT_SHOW_BRANCH_HEAD?= | head -10
|_GIT_SHOW_BRANCH_HISTORY?= | cat
|_GIT_VIEW_BRANCHES?= | cat
|_GIT_VIEW_BRANCHES_SET?= | grep $(GIT_BRANCHES_REGEX)
 
#--- Utilities

#--- MACROS
_git_get_branch_name=$(shell git branch --show-current)

#----------------------------------------------------------------------
# USAGE
#

_git_view_framework_macros ::
	@echo 'Git::Branch ($(GIT_BRANCH_MK_VERSION)) targets:'
	@echo '    _git_get_branch_name     - Get the current branch name'
	@echo

_git_view_framework_parameters ::
	@echo 'Git::Branch ($(GIT_BRANCH_MK_VERSION)) parameters:'
	@echo '    GIT_BRANCH_FORCE_FLAG=$(GIT_BRANCH_FORCE_FLAG)'
	@echo '    GIT_BRANCH_GRAPH_FLAG=$(GIT_BRANCH_GRAPH_FLAG)'
	@echo '    GIT_BRANCH_HISTORY_COUNT=$(GIT_BRANCH_HISTORY_COUNT)'
	@echo '    GIT_BRANCH_NAME=$(GIT_BRANCH_NAME)'
	@echo '    GIT_BRANCH_ONELINE_FLAG=$(GIT_BRANCH_ONELINE_FLAG)'
	@echo '    GIT_BRANCH_REMOTE=$(GIT_BRANCH_REMOTE)'
	@echo '    GIT_BRANCH_REMOTEBRANCH_NAME=$(GIT_BRANCH_REMOTEBRANCH_NAME)'
	@echo '    GIT_BRANCH_STARTPOINT_ID=$(GIT_BRANCH_STARTPOINT_ID)'

_git_view_framework_targets ::
	@echo 'Git::Branch ($(GIT_BRANCH_MK_VERSION)) targets:'
	@echo '    _git_push_branch              - Push a local branch to a remote server'
	@echo '    _git_show_branch              - Show everything related to a branch'
	@echo '    _git_show_branch_description  - Show description of a branch'
	@echo '    _git_show_branch_head         - Show the head of a branch'
	@echo '    _git_show_branch_history      - Show history of a branch'
	@echo '    _git_show_branch_repository   - Show repository of a branch'
	@echo '    _git_view_branches            - View branches'
	@echo '    _git_view_branches_set        - View a set of branches'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

_git_create_branch:
	@$(INFO) '$(GIT_UI_LABEL)Creating branch "$(GIT_BRANCH_NAME)" ...'
	@$(WARN) 'This operation creates a branch and links it to an existing commits'; $(NORMAL)
	@$(WARN) 'Occasionally a branch can be orphaned and not linked to any commit'; $(NORMAL)
	$(GIT) checkout $(GIT_BRANCH_NAME) $(GIT_BRANCH_STARTPONT_ID)

_git_delete_branch:
	@$(INFO) '$(GIT_UI_LABEL)Deleting branch "$(GIT_BRANCH_NAME)" ...'

_git_push_branch:
	@$(INFO) '$(GIT_UI_LABEL)Pushing branch "$(GIT_BRANCH_NAME)" ...'
	$(GIT) push $(GIT_BRANCH_REMOTE) $(GIT_BRANCH_NAME):$(GIT_BRANCH_REMOTEBRANCH_NAME) $(__GIT_FORCE)

_git_show_branch: _git_show_branch_head _git_show_branch_history _git_show_branch_repository _git_show_branch_description

_git_show_branch_description:
	@$(INFO) '$(GIT_UI_LABEL)Showing the description of branch "$(GIT_BRANCH_NAME)" ...'; $(NORMAL)

_git_show_branch_head:
	@$(INFO) '$(GIT_UI_LABEL)Showing head of branch "$(GIT_BRANCH_NAME)" ...'; $(NORMAL)
	-$(GIT) show HEAD $(|_GIT_SHOW_BRANCH_HEAD)

_git_show_branch_history:
	@$(INFO) '$(GIT_UI_LABEL)Showing history of branch "$(GIT_BRANCH_NAME)" ...'; $(NORMAL)
	$(GIT) log $(__GIT_GRAPH) $(__GIT_MAX_COUNT) $(__GIT_ONELINE) $(|_GIT_SHOW_BRANCH_HISTORY)

_git_show_branch_repository:
	@$(INFO) '$(GIT_UI_LABEL)Showing repository of branch "$(GIT_BRANCH_NAME)" ...'; $(NORMAL)

_git_switch_branch:
	@$(INFO) '$(GIT_UI_LABEL)Switching to branch "$(GIT_BRANCH_NAME)" ...'; $(NORMAL)

_git_view_branches:
	@$(INFO) '$(GIT_UI_LABEL)Viewing ALL branches ...'; $(NORMAL)
	$(GIT) branch --all $(|_GIT_VIEW_BRANCHES)

_git_view_branches_set:
	@$(INFO) '$(GIT_UI_LABEL)Viewing branches-set "$(GIT_BRANCHES_SET_NAME)" ...'; $(NORMAL)
	$(GIT) branch --all $(|_GIT_VIEW_BRANCHES_SET)
