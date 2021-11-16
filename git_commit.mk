_GIT_COMMIT_MK_VERSION=  $(_GIT_MK_VERSION)

# GIT_COMMIT_HASH?= 9cc8969200a413b2a03d70faa3adf24acb033350
# GIT_COMMIT_HASH_OR_SHORTHASH?=
# GIT_COMMIT_SHORTHASH?= 9cc8969
# GIT_COMMITS_SET_NAME?=

# Derived parameters
GIT_COMMIT_HASH_OR_SHORTHASH?= $(if $(GIT_COMMIT_HASH),$(GIT_COMMIT_HASH),$(GIT_COMMIT_SHORTHASH))

# Options

# Customizations
 
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
	@echo '    GIT_COMMIT_HASH=$(GIT_COMMIT_HASH)'
	@echo '    GIT_COMMIT_HASH=$(GIT_COMMIT_HASH)'
	@echo '    GIT_COMMIT_SHORTHASH=$(GIT_COMMIT_SHORTHASH)'
	@echo '    GIT_COMMITS_SET_NAME=$(GIT_COMMITS_SET_NAME)'
	@echo

_git_list_targets ::
	@echo 'Git::Commit ($(_GIT_COMMIT_MK_VERSION)) targets:'
	@echo '    _git_amend_commit                - Amend a commit'
	@echo '    _git_list_commits                - List all commits'
	@echo '    _git_list_commits_set            - List a set of commits'
	@echo '    _git_show_commit                 - Show everything related to a commit'
	@echo '    _git_show_commit_code            - Show code included in a commit'
	@echo '    _git_show_commit_comment         - Show comment of a commit'
	@echo '    _git_show_commit_tags            - Show tags pointing at a commit'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

_git_amend_commit:
	@$(INFO) '$(GIT_UI_LABEL)Amending changes in "$(GIT_LOCAL_BRANCH_NAME)" ...'; $(NORMAL)
	$(GIT) commit --amend $(__GIT_EDIT) $(__GIT_ALL)


_git_list_commits:
	@$(INFO) '$(GIT_UI_LABEL)Listing ALL commits ...'; $(NORMAL)
	$(GIT) log --pretty=oneline

_git_list_commits_set:
	@$(INFO) '$(GIT_UI_LABEL)Listing commits-set "$(GIT_COMMITS_SET_NAME)" ...'; $(NORMAL)

_GIT_SHOW_COMMIT_TARGETS?= _git_show_commit_code _git_show_commit_tags _git_show_commit_comment
_git_show_commit: $(_GIT_SHOW_COMMIT_TARGETS)

_git_show_commit_code:

_git_show_commit_comment:
	@$(INFO) '$(GIT_UI_LABEL)Showing comment of commit "$(GIT_COMMIT_SHORTHASH_OR_HASH)" ...'; $(NORMAL)
	$(GIT) show $(GIT_COMMIT_SHORTHASH_OR_HASH)

_git_show_commit_tags:
	@$(INFO) '$(GIT_UI_LABEL)Showing tags that points to commit "$(GIT_COMMIT_HASH)" ...'; $(NORMAL)
	$(GIT) tag --list --points-at $(GIT_COMMIT_SHORTHASH_OR_HASH)

_git_tag_commit:
	@$(INFO) '$(GIT_UI_LABEL)Tagging commit "$(GIT_COMMIT_HASH)" with tag "$(GIT_COMMIT_TAG)" ...'; $(NORMAL)
	$(GIT) tag $(GIT_COMMIT_TAG) $(GIT_COMMIT_SHORTHASH_OR_HASH)
