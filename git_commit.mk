_GIT_COMMIT_MK_VERSION=  $(_GIT_MK_VERSION)

GIT_COMMIT_ALL_FLAG?= false
GIT_COMMIT_FORCE_FLAG?= false
# GIT_COMMIT_HASH?= 9cc8969200a413b2a03d70faa3adf24acb033350
# GIT_COMMIT_HASH_OR_SHORTHASH?=
GIT_COMMIT_NAME?= ticket-0000
# GIT_COMMIT_MESSAGE?= "my message""
# GIT_COMMIT_SHORTHASH?= 9cc8969
# GIT_COMMITS_REGEX?= '.*'
# GIT_COMMITS_SET_NAME?=

# Derived parameters
GIT_COMMIT_HASH_OR_SHORTHASH?= $(if $(GIT_COMMIT_HASH),$(GIT_COMMIT_HASH),$(GIT_COMMIT_SHORTHASH))

# Options
__GIT_ALL= $(if $(filter true,$(GIT_COMMIT_ALL_FLAG)),--all)
__GIT_EDIT=
__GIT_FORCE__COMMIT= $(if $(filter true,$(GIT_COMMIT_FORCE_FLAG)),--force)
__GIT_MESSAGE= $(if $(GIT_COMMIT_MESSAGE),--message $(GIT_COMMIT_MESSAGE))

# Customizations
|_GIT_LIST_COMMITS_SET?= | grep $(GIT_COMMITS_REGEX)
 
# Macros

_git_get_head_hash= $(shell $(GIT) rev-parse HEAD)
# Same as git log -1 --pretty=format:%h ?
_git_get_head_shorthash= $(shell $(GIT) rev-parse --short HEAD)

_git_get_commit_count= $(call _git_get_commit_count_H, $(GIT_COMMIT_HASH))
_git_get_commit_count_H= $(shell $(GIT) rev-list --count $(1))

#----------------------------------------------------------------------
# USAGE
#

_git_list_macros ::
	@echo 'Git::Commit ($(_GIT_COMMIT_MK_VERSION)) macros:'
	@echo '    _git_get_commit_count               - Get number of commits to reach specified one (Hash)'
	@echo '    _git_get_head_hash                  - Get the hash of the head'
	@echo '    _git_get_head_shorthash             - Get the short-hash of the head'
	@echo

_git_list_parameters ::
	@echo 'Git::Commit ($(_GIT_COMMIT_MK_VERSION)) parameters:'
	@echo '    GIT_COMMIT_FORCE_FLAG=$(GIT_COMMIT_FORCE_FLAG)'
	@echo '    GIT_COMMIT_HASH=$(GIT_COMMIT_HASH)'
	@echo '    GIT_COMMIT_HASH_OR_SHORTHASH=$(GIT_COMMIT_HASH_OR_SHORTHASH)'
	@echo '    GIT_COMMIT_MESSAGE=$(GIT_COMMIT_MESSAGE)'
	@echo '    GIT_COMMIT_NAME=$(GIT_COMMIT_NAME)'
	@echo '    GIT_COMMIT_SHORTHASH=$(GIT_COMMIT_SHORTHASH)'
	@echo '    GIT_COMMITS_SET_NAME=$(GIT_COMMITS_SET_NAME)'
	@echo

_git_list_targets ::
	@echo 'Git::Commit ($(_GIT_COMMIT_MK_VERSION)) targets:'
	@echo '    _git_amend_commit                - Amend a commit'
	@echo '    _git_create_commit               - Create a commit'
	@echo '    _git_delete_commit               - Delete a commit'
	@echo '    _git_list_commits                - List all commits'
	@echo '    _git_list_commits_set            - List a set of commits'
	@echo '    _git_push_commit                 - Push a commit'
	@echo '    _git_show_commit                 - Show everything related to a commit'
	@echo '    _git_show_commit_code            - Show code included in a commit'
	@echo '    _git_show_commit_comment         - Show comment of a commit'
	@echo '    _git_show_commit_tags            - Show tags pointing at a commit'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

_git_amend_commit:
	@$(INFO) '$(GIT_UI_LABEL)Amending changes in "$(GIT_COMMIT_NAME)" ...'; $(NORMAL)
	$(GIT) commit --amend $(__GIT_EDIT) $(__GIT_ALL)

_git_create_commit:
	@$(INFO) '$(GIT_UI_LABEL)Creating commit "$(GIT_COMMIT_NAME)" ...'; $(NORMAL)
	$(GIT) commit $(__GIT_ALL) $(__GIT_MESSAGE) 

_git_delete_commit: 
	@$(INFO) '$(GIT_UI_LABEL)Deleting commit "$(GIT_COMMIT_NAME)" ...'; $(NORMAL)
	# $(GIT) reset --hard

_git_list_commits:
	@$(INFO) '$(GIT_UI_LABEL)Listing ALL commits ...'; $(NORMAL)
	$(GIT) log --pretty=oneline

_git_list_commits_set:
	@$(INFO) '$(GIT_UI_LABEL)Listing commits-set "$(GIT_COMMITS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Commits are grouped based on the provided regex and pipe-filter'
	$(GIT) log --pretty=oneline $(|_GIT_LIST_COMMITS_SET)

_git_push_commit:
	@$(INFO) '$(GIT_UI_LABEL)Pushing commit "$(GIT_COMMIT_NAME)" ...'; $(NORMAL)
	$(GIT) push $(__GIT_FORCE__COMMIT)

_GIT_SHOW_COMMIT_TARGETS?= _git_show_commit_code _git_show_commit_tags _git_show_commit_comment
_git_show_commit: $(_GIT_SHOW_COMMIT_TARGETS)

_git_show_commit_code:

_git_show_commit_comment:
	@$(INFO) '$(GIT_UI_LABEL)Showing comment of commit "$(GIT_COMMIT_NAME)" ...'; $(NORMAL)
	$(GIT) show $(GIT_COMMIT_SHORTHASH_OR_HASH)

_git_show_commit_tags:
	@$(INFO) '$(GIT_UI_LABEL)Showing tags that points to commit "$(GIT_COMMIT_NAME)" ...'; $(NORMAL)
	$(GIT) tag --list --points-at $(GIT_COMMIT_SHORTHASH_OR_HASH)

_git_tag_commit:
	@$(INFO) '$(GIT_UI_LABEL)Tagging commit "$(GIT_COMMIT_NAME)" ...'; $(NORMAL)
	$(GIT) tag $(GIT_COMMIT_TAG) $(GIT_COMMIT_SHORTHASH_OR_HASH)
