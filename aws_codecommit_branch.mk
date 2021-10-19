_AWS_CODECOMMIT_BRANCH_MK_VERSION= $(_AWS_CODECOMMIT_MK_VERSION)

# CCT_BRANCH_NAME?=

# Derived parameters

# Option parameters
__CCT_BRANCH_NAME= $(if $(CCT_BRANCH_NAME), --branch-name $(CCT_BRANCH_NAME))
__CCT_COMMIT_ID= $(if $(CCT_COMMIT_ID), --commit-id $(CCT_COMMIT_ID))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cct_view_framework_macros ::
	@#echo 'AWS::CodeCommiT::Branch ($(_AWS_CODECOMMIT_BRANCH_MK_VERSION)) macros:'
	@#echo

_cct_view_framework_parameters ::
	@echo 'AWS::CodeCommiT::Branch ($(_AWS_CODECOMMIT_BRANCH_MK_VERSION)) parameters:'
	@echo '    CCT_BRANCH_NAME=$(CCT_BRANCH_NAME)'
	@echo

_cct_view_framework_targets ::
	@echo 'AWS::CodeCommiT::Branch ($(_AWS_CODECOMMIT_BRANCH_MK_VERSION)) targets:'
	@echo '    _cct_create_branch                 - Create a branch in given repository'
	@echo '    _cct_delete_branch                 - Delete a branch in given repository'
	@echo '    _cct_show_branch                   - Show details for a branch'
	@echo '    _cct_view_branches                 - View existing branches'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cct_create_branch:
	@$(INFO) '$(AWS_UI_LABEL)Creating branch "$(CCT_BRANCH_NAME)" in repository "$(CCT_REPOSITORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Commit ID: $(CCT_COMMIT_ID)'; $(NORMAL)
	$(AWS) codecommit create-branch $(__CCT_BRANCH_NAME) $(__CCT_COMMIT_ID) $(__CCT_REPOSITORY_NAME)

_cct_delete_branch:
	@$(INFO) '$(AWS_UI_LABEL)Deleting branch "$(CCT_BRANCH_NAME)" in repository "$(CCT_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) codecommit delete-branch $(__CCT_BRANCH_NAME) $(__CCT_REPOSITORY_NAME)

_cct_show_branch:
	@$(INFO) '$(AWS_UI_LABEL)Showing branch "$(CCT_BRANCH_NAME)" in repository "$(CCT_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) codecommit get-branch $(__CCT_BRANCH_NAME) $(__CCT_REPOSITORY_NAME)

_cct_view_branches:
	@$(INFO) '$(AWS_UI_LABEL)Viewing branches in repository "$(CCT_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) codecommit list-branches $(__CCT_REPOSITORY_NAME)
