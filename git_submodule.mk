_GIT_SUBMODULE_MK_VERSION=  $(_GIT_MK_VERSION)

GIT_SUBMODULE_BRANCH_NAME?= master
# GIT_SUBMODULE_DIRPATH?= ./submodules/istio/
GIT_SUBMODULE_MODE_FORCE?= false
GIT_SUBMODULE_MODE_QUIET?= false
# GIT_SUBMODULE_NAME?= istio
# GIT_SUBMODULE_URL?= https://github.com/istio/istio.git
# GIT_SUBMODULES_DIRPATH?= ./submodules/

# Derived variables
GIT_SUBMODULE_DIRPATH?= $(GIT_SUBMODULES_DIRPATH)$(GIT_SUBMODULE_NAME)

# Option variables
__GIT_BRANCH__SUBMODULE?= $(if $(filter true, $(GIT_SUBMODULE_BRANCH_NAME)), -b $(GIT_SUBMODULE_BRANCH_NAME))
__GIT_FORCE__SUBMODULE?= $(if $(filter true, $(GIT_SUBMODULE_MODE_FORCE)), --force)
__GIT_QUIET__SUBMODULE?= $(if $(filter true, $(GIT_SUBMODULE_MODE_QUIET)), --quiet)

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_git_view_framework_macros ::
	@#echo 'Git::Submodules ($(_GIT_SUBMODULE_MK_VERSION)) macros:'
	@#echo

_git_view_framework_parameters ::
	@echo 'Git::Submodule ($(_GIT_SUBMODULE_MK_VERSION)) parameters:'
	@echo '    GIT_SUBMODULE_BRANCH_NAME=$(GIT_SUBMODULE_BRANCH_NAME)'
	@echo '    GIT_SUBMODULE_DIRPATH=$(GIT_SUBMODULE_DIRPATH)'
	@echo '    GIT_SUBMODULE_MODE_FORCE=$(GIT_SUBMODULE_MODE_FORCE)'
	@echo '    GIT_SUBMODULE_MODE_QUIET=$(GIT_SUBMODULE_MODE_QUIET)'
	@echo '    GIT_SUBMODULE_NAME=$(GIT_SUBMODULE_NAME)'
	@echo '    GIT_SUBMODULE_URL=$(GIT_SUBMODULE_URL)'
	@echo '    GIT_SUBMODULES_DIRPATH=$(GIT_SUBMODULES_DIRPATH)'
	@echo

_git_view_framework_targets ::
	@echo 'Git::Submodule ($(_GIT_SUBMODULE_MK_VERSION)) targets:'
	@echo '    _git_configure_submodule         - Configure a submodule'
	@echo '    _git_create_submodule            - Create/add a new submodule'
	@echo '    _git_delete_submodule            - Delete an existing submodule'
	@echo '    _git_import_submodule            - Import the content of a submodule'
	@echo '    _git_update_submodule            - Update a submodule'
	@echo '    _git_update_submodule_content    - Update the content of a submodule'
	@echo '    _git_update_submodule_metadata   - Update the metadata of a submodule'
	@echo '    _git_view_submodules             - View all existing submodules'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

_get_configure_submodule:
	@$(INFO) '$(GIT_UI_LABEL)Configuring submodule "$(GIT_SUBMODULE_NAME)" ...'; $(NORMAL)
	$(GIT) config -f .gitmodules submodule.$(GIT_SUBMODULE_NAME).branch stable

_git_create_submodule:
	@$(INFO) '$(GIT_UI_LABEL)Creating submodule "$(GIT_SUBMODULE_NAME)" ...'; $(NORMAL)
	@#git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
	@$(WARN) 'This operation creates the destination directory and populates it'; $(NORMAL)
	@$(WARN) 'cat REPO_TOP_DIR/.gitmodules'; $(NORMAL)
	$(GIT) submodule $(__GIT_QUIET__SUBMODULE) add $(__GIT_BRANCH__SUBMODULE) $(__GIT_FORCE__SUBMODULE) $(GIT_SUBMODULE_URL) $(GIT_SUBMODULE_DIRPATH)

_git_delete_submodule:
	@$(INFO) '$(GIT_UI_LABEL)Deleting submodule "$(GIT_SUBMODULE_NAME)" ...'; $(NORMAL)
	# $(GIT) submodule $(__GIT_QUIET__SUBMODULE) deinit $(__GIT_FORCE__SUBMODULE) $(GIT_SUBMODULE_DIRPATH)
	$(GIT) rm $(__GIT_FORCE__SUBMODULE) $(__GIT_RECURSE__SUBMODULE) $(GIT_SUBMODULE_DIRPATH)

_git_import_submodule:
	@$(INFO) '$(GIT_UI_LABEL)Importing submodule "$(GIT_SUBMODULE_NAME)" ...'; $(NORMAL)
	$(GIT) submodule $(__GIT_QUIET__SUBMODULE) update --init

_git_reset_submodule:
	@$(INFO) '$(GIT_UI_LABEL)Reseting submodule "$(GIT_SUBMODULE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation wipes out all the changes in the submodule'; $(NORMAL)
	@# cd $(GIT_SUBMODULE_DIRPATH)           # Hopefully GIT_SUBMODULE_DIRPATH is not empty!
	@# git status
	@# rm -rf *				# Are you executing this where you think it should be?
	@# git status
	@# git reset --hard                      # You will lose manual changes
	$(GIT) rm $(_X__GIT_FORCE__SUBMODULE) --force $(__GIT_RECURSE__SUBMODULE) $(GIT_SUBMODULE_DIRPATH)
	$(GIT) submodule $(__GIT_QUIET__SUBMODULE) add $(__GIT_BRANCH_SUBMODULE) $(_X__GIT_FORCE__SUBMODULE) --force $(GIT_SUBMODULE_URL) $(GIT_SUBMODULE_DIRPATH)

_git_show_submodule: _git_show_submodule_head _git_show_submodule_description

_git_show_submodule_description:
	@$(INFO) '$(GIT_UI_LABEL)Showing description of submodule "$(GIT_SUBMODULE_NAME)" ...'; $(NORMAL)
	 ls -ld $(GIT_SUBMODULE_DIRPATH)

_git_show_submodule_head:
	@$(INFO) '$(GIT_UI_LABEL)Showing lst-commit of submodule "$(GIT_SUBMODULE_NAME)" ...'; $(NORMAL)
	cd $(GIT_SUBMODULE_DIRPATH); git show | cat

_git_update_submodule: _git_update_submodule_content # _git_update_submodule_metadata

_git_update_submodule_content:
	@$(INFO) '$(GIT_UI_LABEL)Updating content of submodule "$(GIT_SUBMODULE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is effective running a "git fetch" and "git checkout" in each of your submodules'; $(NORMAL)
	@# or: git submodule [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
	$(GIT) submodule $(__GIT_QUIET__SUBMODULE) update $(__GIT_FORCE__SUBMODULE) 

_git_update_submodule_metadata:
	@$(INFO) '$(GIT_UI_LABEL)Updating metadata of submodule "$(GIT_SUBMODULE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation resynchronize info in submodule/.git/config with the info in local_repo/.gitmodule'; $(NORMAL)
	@# or: git submodule [--quiet] sync [--recursive] [--] [<path>...]
	$(GIT) submodule $(__GIT_QUIET__SUBMODULE) sync ...

_git_view_submodules:
	@$(INFO) '$(GIT_UI_LABEL)Viewing submodules ...'; $(NORMAL)
	@$(WARN) 'cat REPO_TOP_DIR/.gitmodules'; $(NORMAL)
	@# or: git submodule [--quiet] status [--cached] [--recursive] [--] [<path>...]
	$(GIT) submodule $(__GIT_QUIET__SUBMODULE) status
	# or ?
	$(GIT) ls-files --stage | grep 160000 || true

   # or: git submodule [--quiet] init [--] [<path>...]
   # or: git submodule [--quiet] deinit [-f|--force] [--] <path>...
   # or: git submodule [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
   # or: git submodule [--quiet] foreach [--recursive] <command>
