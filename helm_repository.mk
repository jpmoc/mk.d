_HELM_REPOSITORY_MK_VERSION= $(_HELM_MK_VERSION)

# HLM_REPOSITORY_DIRPATH?= helm-repo/
# HLM_REPOSITORY_NAME?= stable
# HLM_REPOSITORY_URL?= https://kubernetes-charts.storage.googleapis.com
HLM_REPOSITORIES_REGEX?= *
# HLM_REPOSITORIES_SET_NAME?= my-repository-set

# Derived parameters

# Options
__HLM_CA_FILE=
__HLM_CERT_FILE=
__HLM_KEY_FILE=
__HLM_MERGE=
__HLM_NO_UPDATE=
__HLM_PASSWORD=
__HLM_URL__REPOSITORY= $(if $(HLM_REPOSITORY_URL),--url $(HLM_REPOSITORY_URL))
__HLM_USERNAME=

# Customizations
_HLM_LIST_REPOSITORIES_|?= #-#
|_HLM_LIST_REPOSITORIES_SET?= | grep 'NAME\|$(HLM_REPOSITORIES_REGEX)'

#--- Utilities
|_HLM_SHOW_REPOSITORY_CHARTVERSIONS?= | head -10

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_hlm_list_macros ::
	@#echo 'HeLM::Repository ($(_HELM_REPOSITORY_MK_VERSION)) macros:'
	@#echo

_hlm_list_parameters ::
	@echo 'HeLM::Repository ($(_HELM_REPOSITORY_MK_VERSION)) parameters:'
	@echo '    HLM_REPOSITORY_DIRPATH=$(HLM_REPOSITORY_DIRPATH)'
	@echo '    HLM_REPOSITORY_NAME=$(HLM_REPOSITORY_NAME)'
	@echo '    HLM_REPOSITORY_URL=$(HLM_REPOSITORY_URL)'
	@echo '    HLM_REPOSITORIES_REGEX=$(HLM_REPOSITORIES_REGEX)'
	@echo '    HLM_REPOSITORIES_SET_NAME=$(HLM_REPOSITORIES_SET_NAME)'
	@echo

_hlm_list_targets ::
	@echo 'HeLM::Repository ($(_HELM_REPOSITORY_MK_VERSION)) targets:'
	@echo '    _hlm_add_repository                 - Add a repository'
	@echo '    _hlm_index_repository               - Index a local repository'
	@echo '    _hlm_list_repositories              - List all repositories'
	@echo '    _hlm_list_repositories_set          - List a set of repositories'
	@echo '    _hlm_remove_repository              - Remove a repository'
	@echo '    _hlm_show_repository                - Show everything related to a repository'
	@echo '    _hlm_show_repository_charts         - Show the charts published on a repository'
	@echo '    _hlm_show_repository_chartversions  - Show the chart-versions published on a repository'
	@echo '    _hlm_show_repository_description    - Show description of a repository'
	@echo '    _hlm_update_repositories            - Update local-indexes of repositories'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_hlm_add_repository:
	@$(INFO) '$(HLM_UI_LABEL)Adding repository "$(HLM_REPOSITORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the index.yaml cannot be found at the top-level of the provided URL'; $(NORMAL)
	$(HELM) repo add  $(strip $(__HLM_CA_FILE) $(__HLM_CERT_FILE) $(__HLM_KEY_FILE) $(__HLM_NO_UPDATE) $(__HLM_PASSWORD) $(__HLM_USERNAME) $(HLM_REPOSITORY_NAME) $(HLM_REPOSITORY_URL) )

_hlm_index_repository:
	@$(INFO) '$(HLM_UI_LABEL)Indexing local repository ...'; $(NORMAL)
	@$(WARN) 'This operation updates the local helm-repository-source based on the contained chart-packages'; $(NORMAL)
	@$(WARN) 'This operation updates the repository index.yaml file'; $(NORMAL)
	$(HELM) repo index $(__HLM_MERGE) $(__HLM_URL__REPOSITORY) $(HLM_REPOSITORY_DIRPATH)
	@$(WARN) 'After successful completion, publish your repository online. Git push on github?'; $(NORMAL)

_hlm_list_repositories:
	@$(INFO) '$(HLM_UI_LABEL)Listing ALL repositories ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the repository list is empty!'; $(NORMAL)
	$(_HLM_LIST_REPOSITORIES)$(HELM) repo list

_hlm_list_repositories_set:
	@$(INFO) '$(HLM_UI_LABEL)Listing repositories-set "$(HLM_REPOSITORIES_SET_NAME)" ...'; $(NORMAL)
	$(HELM) repo list $(|_HLM_LIST_REPOSITORIES_SET)

_hlm_remove_repository:
	@$(INFO) '$(HLM_UI_LABEL)Removing repository "$(HLM_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(HELM) repo remove $(HLM_REPOSITORY_NAME)

_HLM_SHOW_REPOSITORY_TARGETS?= _hlm_show_repository_charts _hlm_show_repository_chartversions _hlm_show_repository_description
_hlm_show_repository: $(_HLM_SHOW_REPOSITORY_TARGETS)

_hlm_show_repository_charts:
	@$(INFO) '$(HLM_UI_LABEL)Showing charts published on repository "$(HLM_REPOSITORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation reads the index.yaml file from the repository'; $(NORMAL)
	@$(WARN) 'This operation lists only the latest version for each chart'; $(NORMAL)
	$(HELM) search repo $(HLM_REPOSITORY_NAME)

_hlm_show_repository_chartversions:
	@$(INFO) '$(HLM_UI_LABEL)Showing ALL chart-versions published on repository "$(HLM_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(HELM) search repo --versions $(HLM_REPOSITORY_NAME) $(|_HLM_SHOW_REPOSITORY_CHARTVERSIONS)

_hlm_show_repository_description:
	@$(INFO) '$(HLM_UI_LABEL)Showing description repository "$(HLM_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(HELM) repo list | grep 'NAME\|$(HLM_REPOSITORY_NAME)'

_hlm_update_repository: _hlm_update_repositories
_hlm_update_repositories:
	@$(INFO) '$(HLM_UI_LABEL)Updating local index with list of charts available content on remote repositories ...'; $(NORMAL)
	@$(WARN) 'This operation updates the local index/cache with the list of available charts available on each repository'; $(NORMAL)
	@$(WARN) 'This operation re-reads the index.yaml of each registered repository'; $(NORMAL)
	$(HELM) repo update

_hlm_watch_repositories:
	@$(INFO) '$(HLM_UI_LABEL)Watching ALL repositories ...'; $(NORMAL)

_hlm_watch_repositories_set:
	@$(INFO) '$(HLM_UI_LABEL)Watching repositories-set "$(HLM_REPOSITORIES_SET_NAME)" ...'; $(NORMAL)
