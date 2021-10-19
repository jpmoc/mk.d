_ARGOCD_REPOSITORY_MK_VERSION= $(_ARGOCD_MK_VERSION)

ACD_REPOSITORY_CREDENTIALS_REGEX?= *
# ACD_REPOSITORY_NAME?= my-repo
# ACD_REPOSITORY_PRIVATEKEY_FILEPATH?= $(HOME)/.shh/id_rsa
ACD_REPOSITORY_TYPE?= git
# ACD_REPOSITORY_URL?= git@github.com:argoproj/argocd-example-apps.git
# ACD_REPOSITORY_USER_NAME?=
# ACD_REPOSITORY_USER_PASSWORD?=
ACD_REPOSITORIES_REGEX?= *
# ACD_REPOSITORIES_SET_NAME?= my-repositories-set

# Derived parameters
ACD_REPOSITORY_NAME?= $(lastword $(subst /,$(SPACE),$(ACD_REPOSITORY_URL)))
ACD_REPOSITORIES_SET_NAME?= repositories@@@$(ACD_REPOSITORIES_REGEX)

# Option parameters
__ACD_INSECURE_SKIP_SERVER_VERIFICATION= $(if $(filter true,$(ACD_REPOSITORY_INSECURE_FLAG)),--insecure-skip-server-verification)
__ACD_NAME= $(if $(ACD_REPOSITORY_NAME),--name $(ACD_REPOSITORY_NAME))
__ACD_PASSWORD= $(if $(ACD_REPOSITORY_USER_PASSWORD),--password $(ACD_REPOSITORY_USER_PASSWORD))
__ACD_SSH_PRIVATE_KEY_PATH= $(if $(ACD_REPOSITORY_PRIVATEKEY_FILEPATH),--ssh-private-key-path $(ACD_REPOSITORY_PRIVATEKEY_FILEPATH))
__ACD_TLS_CLIENT_CERT_KEY_PATH=
__ACD_TLS_CLIENT_CERT_PATH=
__ACD_TYPE= $(if $(ACD_REPOSITORY_TYPE),--type $(ACD_REPOSITORY_TYPE))
__ACD_USERNAME= $(if $(ACD_REPOSITORY_USER_NAME),--username $(ACD_REPOSITORY_USER_NAME))

# Pipe parameters
|_ACD_SHOW_REPOSITORY_CREDENTIALS?= | grep -E 'NAME|$(ACD_REPOSITORY_CREDENTIALS_REGEX)'
|_ACD_VIEW_REPOSITORIES_SET?= | grep -E 'NAME|$(ACD_REPOSITORIES_REGEX)'

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_acd_view_framework_macros ::
	@echo 'ArgoCD::Repository ($(_ARGOCD_REPOSITORY_MK_VERSION)) macros:'
	@echo

_acd_view_framework_parameters ::
	@echo 'ArgoCD::Repository ($(_ARGOCD_REPOSITORY_MK_VERSION)) parameters:'
	@echo '    ACD_REPOSITORY_CREDENTIALS_REGEX=$(ACD_REPOSITORY_CREDENTIALS_REGEX)'
	@echo '    ACD_REPOSITORY_NAME=$(ACD_REPOSITORY_NAME)'
	@echo '    ACD_REPOSITORY_PRIVATEKEY_FILEPATH=$(ACD_REPOSITORY_PRIVATEKEY_FILEPATH)'
	@echo '    ACD_REPOSITORY_TYPE=$(ACD_REPOSITORY_TYPE)'
	@echo '    ACD_REPOSITORY_URL=$(ACD_REPOSITORY_URL)'
	@echo '    ACD_REPOSITORY_USER_NAME=$(ACD_REPOSITORY_USER_NAME)'
	@echo '    ACD_REPOSITORY_USER_PASSWORD=$(ACD_REPOSITORY_USER_PASSWORD)'
	@echo '    ACD_REPOSITORIES_REGEX=$(ACD_REPOSITORIES_REGEX)'
	@echo '    ACD_REPOSITORIES_SET_NAME=$(ACD_REPOSITORIES_SET_NAME)'
	@echo

_acd_view_framework_targets ::
	@echo 'ArgoCD::Repository ($(_ARGOCD_REPOSITORY_MK_VERSION)) targets:'
	@echo '    _acd_create_repository             - Create a repository'
	@echo '    _acd_delete_repository             - Delete a repository'
	@echo '    _acd_show_repository               - Show everything related to a repository'
	@echo '    _acd_show_repository_credentials   - Show credentials of a repository'
	@echo '    _acd_show_repository_description   - Show description of a repository'
	@echo '    _acd_update_repository             - Update a repository'
	@echo '    _acd_view_repositories             - View repositories'
	@echo '    _acd_view_repositories_set         - View set of repositories'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_acd_create_repository:
	@$(INFO) '$(ACD_UI_LABEL)Creating repository "$(ACD_REPOSITORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the credentials are not valid'; $(NORMAL)
	$(ARGOCD) repo add $(__ACD_INSECURE_SKIP_SERVER_VERIFICATION) $(__ACD_NAME) $(__ACD_PASSWORD) $(__ACD_SSH_PRIVATE_KEY_PATH) $(__ACD_TLS_CLIENT_CERT_KEY_PATH) $(__ACD_TLS_CLIENT_CERT_PATH) $(__ACD_TYPE) $(__ACD_UPSERT) $(__ACD_USERNAME) $(ACD_REPOSITORY_URL)

_acd_delete_repository:
	@$(INFO) '$(ACD_UI_LABEL)Deleting repository "$(ACD_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(ARGOCD) repo rm $(ACD_REPOSITORY_URL)

_acd_show_repository :: _acd_show_repository_credentials _acd_show_repository_description

_acd_show_repository_credentials:
	@$(INFO) '$(ACD_UI_LABEL)Show credentials for repository "$(ACD_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(ARGOCD) repocreds list $(|_ACD_SHOW_REPOSITORY_CREDENTIALS)

_acd_show_repository_description:
	@$(INFO) '$(ACD_UI_LABEL)Showing description of repository "$(ACD_REPOSITORY_NAME)" ...'; $(NORMAL)

_acd_update_repository:
	@$(INFO) '$(ACD_UI_LABEL)Updating repository "$(ACD_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(ARGOCD) repo add $(__ACD_INSECURE_SKIP_SERVER_VERIFICATION) $(__ACD_NAME) $(__ACD_PASSWORD) $(__ACD_SSH_PRIVATE_KEY_PATH) $(__ACD_TLS_CLIENT_CERT_KEY_PATH) $(__ACD_TLS_CLIENT_CERT_PATH) $(__ACD_TYPE) --upsert $(__ACD_USERNAME) $(ACD_REPOSITORY_URL)

_acd_view_repositories:
	@$(INFO) '$(ACD_UI_LABEL)Viewing repositories ...'; $(NORMAL)
	$(ARGOCD) repo list 

_acd_view_repositories_set:
	@$(INFO) '$(ACD_UI_LABEL)Viewing repositories-set "$(ACD_REPOSITORIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Repositories are grouped based on provided regex'; $(NORMAL)
	$(ARGOCD) repo list $(|_ACD_VIEW_REPOSITORIES_SET)
