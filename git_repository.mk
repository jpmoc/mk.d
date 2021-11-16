_GIT_REPOSITORY_MK_VERSION=$(_GIT_MK_VERSION)

# GIT_REPOSITORY_DIRPATH?= $(HOME)/my-cloned-repo
# GIT_REPOSITORY_HTTPREMOTE_URL?= https://git-codecommit.us-west-2.amazonaws.com/v1/repos/MyRepo
# GIT_REPOSITORY_REMOTE_URL?= https://git-codecommit.us-west-2.amazonaws.com/v1/repos/MyRepo
# GIT_REPOSITORY_SSHREMOTE_URL?= ssh://git-codecommit.us-west-2.amazonaws.com/v1/repos/MyRepo
# GIT_REPOSITORY_NAME?= MyRepo
# GIT_REPOSITORIES_HTTPREMOTE_PREFIX?= https://git-codecommit.us-west-2.amazonaws.com/v1/repos/
# GIT_REPOSITORIES_REMOTE_PREFIX?= https://git-codecommit.us-west-2.amazonaws.com/v1/repos/
# GIT_REPOSITORIES_SSHREMOTE_PREFIX?= ssh://git-codecommit.us-west-2.amazonaws.com/v1/repos/

# Derived variables
GIT_REPOSITORY_HTTPREMOTE_URL?= $(if $(GIT_REPOSITORIES_HTTPREMOTE_PREFIX),$(GIT_REPOSITORIES_HTTPREMOTE_PREFIX)$(GIT_REPOSITORY_NAME))
GIT_REPOSITORY_SSHREMOTE_URL?= $(if $(GIT_REPOSITORIES_SSHREMOTE_PREFIX),$(GIT_REPOSITORIES_SSHREMOTE_PREFIX)$(GIT_REPOSITORY_NAME))
GIT_REPOSITORY_REMOTE_URL?= $(if $(GIT_REPOSITORY_SSHREMOTE_URL),$(GIT_REPOSITORY_SSHREMOTE_URL),$(GIT_REPOSITORY_HTTPREMOTE_URL))

# Options

# Customizations
 
# Macros
_git_get_repository_dirpath=$(shell git rev-parse --show-toplevel)

#----------------------------------------------------------------------
# USAGE
#

_git_list_macros ::
	@echo 'Git::Repository ($(_GIT_REPOSITORY_MK_VERSION)) targets:'
	@echo '    _git_get_repository_dirpath     - Get the top-level directory of the repo'
	@echo

_git_list_parameters ::
	@echo 'Git::Repository ($(_GIT_REPOSITORY_MK_VERSION)) parameters:'
	@echo '    GIT_REPOSITORY_DIRPATH=$(GIT_REPOSITORY_DIRPATH)'
	@echo '    GIT_REPOSITORY_NAME=$(GIT_REPOSITORY_NAME)'
	@echo '    GIT_REPOSITORY_HTTPREMOTE_URL=$(GIT_REPOSITORY_HTTPREMOTE_URL)'
	@echo '    GIT_REPOSITORY_REMOTE_URL=$(GIT_REPOSITORY_PREMOTE_URL)'
	@echo '    GIT_REPOSITORY_SSHREMOTE_URL=$(GIT_REPOSITORY_SSHPREMOTE_URL)'
	@echo '    GIT_REPOSITORIES_HTTPREMOTE_PREFIX=$(GIT_REPOSITORIES_HTTPREMOTE_PREFIX)'
	@echo '    GIT_REPOSITORIES_REMOTE_PREFIX=$(GIT_REPOSITORIES_REMOTE_PREFIX)'
	@echo '    GIT_REPOSITORIES_SSHREMOTE_PREFIX=$(GIT_REPOSITORIES_SSHREMOTE_PREFIX)'
	@echo

_git_list_targets ::
	@echo 'Git::Repository ($(_GIT_REPOSITORY_MK_VERSION)) targets:'
	@echo '    _git_clone_repository     - Clone a remote repository'
	@echo '    _git_create_repository    - Create a remote repository'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

_git_clone_repository:
	@$(INFO) '$(GIT_UI_LABEL)Cloning repository "$(GIT_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(GIT) clone $(GIT_REPOSITORY_REMOTE_URL) $(GIT_REPOSITORY_DIRPATH)

_git_create_repository:
	@$(INFO) '$(GIT_UI_LABEL)Create a repository "$(GIT_REPOSITORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation automatically create an empty master branch'; $(NORMAL)
	$(GIT) init
