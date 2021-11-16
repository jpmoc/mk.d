_KUBECTL_KUBECONFIG_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_KUBECONFIG_CLUSTER_NAME?= allspark-vke
# KCL_KUBECONFIG_CLUSTER_URL?= https://hzvault-emayssat-dev-f8b96e-fc440225.hcp.westus2.azmk8s.io:443
# KCL_KUBECONFIG_CONTEXT_NAME?= allspark-vke
# KCL_KUBECONFIG_DIRPATH?= $(HOME)/.kube/
# KCL_KUBECONFIG_FILENAME?= config
# KCL_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config
# KCL_KUBECONFIG_PROPERTY_NAME?= contexts.foo.namespace
# KCL_KUBECONFIG_PROPERTY_VALUE?= 
# KCL_KUBECONFIGS_DIRPATH?= 
KCL_KUBECONFIGS_REGEX?= *
# KCL_KUBECONFIGS_SET_NAME?= 

# Derived parameters
KCL_KUBECONFIG_CLUSTER_NAME?= $(KCL_CLUSTER_NMAE)
KCL_KUBECONFIG_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_KUBECONFIG_FILEPATH?= $(if $(KCL_KUBECONFIG_FILENAME),$(KCL_KUBECONFIG_DIRPATH)$(KCL_KUBECONFIG_FILENAME),$(KUBECTL_KUBECONFIG_FILEPATH))
KCL_KUBECONFIG_NAME?= $(KCL_KUBECONFIG_FILENAME)
KCL_KUBECONFIGS_DIRPATH?= $(KCL_KUBECONFIG_DIRPATH)

# Options

# Customizations
_KCL_LIST_KUBECONFIGS_|= cd $(KCL_KUBECONFIGS_DIRPATH) && #
_KCL_LIST_KUBECONFIGS_SET_|= $(_KCL_LIST_KUBECONFIGS_|)

#--- MACROS

_kcl_get_kubeconfig_context= $(shell $(KUBECTL) config current-context)

_kcl_get_kubeconfig_cluster_url= $(shell $(KUBECTL) config view --minify | yq --raw-output ".clusters[0].cluster.server")

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Kubeconfig ($(_KUBECTL_KUBECONFIG_MK_VERSION)) macros:'
	@echo '    _kcl_get_kubeconfig_context        - Get the current config-context'
	@echo '    _kcl_get_kubeconfig_cluster_url    - Get the URL of the active cluster in kubeconfig'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Kubeconfig ($(_KUBECTL_KUBECONFIG_MK_VERSION)) parameters:'
	@echo '    KCL_KUBECONFIG_CLUSTER_NAME=$(KCL_KUBECONFIG_CLUSTER_NAME)'
	@echo '    KCL_KUBECONFIG_CLUSTER_URL=$(KCL_KUBECONFIG_CLUSTER_URL)'
	@echo '    KCL_KUBECONFIG_CONTEXT_NAME=$(KCL_KUBECONFIG_CONTEXT_NAME)'
	@echo '    KCL_KUBECONFIG_DIRPATH=$(KCL_KUBECONFIG_DIRPATH)'
	@echo '    KCL_KUBECONFIG_FILENAME=$(KCL_KUBECONFIG_FILENAME)'
	@echo '    KCL_KUBECONFIG_FILEPATH=$(KCL_KUBECONFIG_FILEPATH)'
	@echo '    KCL_KUBECONFIG_NAME=$(KCL_KUBECONFIG_NAME)'
	@echo '    KCL_KUBECONFIG_PROPERTY_NAME=$(KCL_KUBECONFIG_PROPERTY_NAME)'
	@echo '    KCL_KUBECONFIG_PROPERTY_VALUE=$(KCL_KUBECONFIG_PROPERTY_VALUE)'
	@echo '    KCL_KUBECONFIGS_DIRPATH=$(KCL_KUBECONFIGS_DIRPATH)'
	@echo '    KCL_KUBECONFIGS_REGEX=$(KCL_KUBECONFIGS_REGEX)'
	@echo '    KCL_KUBECONFIGS_SET_NAME=$(KCL_KUBECONFIGS_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Kubeconfig ($(_KUBECTL_KUBECONFIG_MK_VERSION)) targets:'
	@echo '    _kcl_set_kubeconfig_property              - Set a kubeconfig property'
	@echo '    _kcl_show_kubeconfig                      - Show everything related to a kubeconfig'
	@echo '    _kcl_show_kubeconfig_clusters             - Show available clusters in kubeconfig'
	@echo '    _kcl_show_kubeconfig_content              - Show content of kubeconfig'
	@echo '    _kcl_show_kubeconfig_contexts             - Show available contexts in kubeconfig'
	@echo '    _kcl_unset_kubeconfig_property            - Unset a kubeconfig property'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_kcl_list_kubeconfigs:
	@$(INFO) '$(KCL_UI_LABEL)Listing all kubeconfigs ...'; $(NORMAL)
	$(_KCL_LIST_KUBECONFIGS_|)ls -la 

_kcl_list_kubeconfigs_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing kubeconfigs-set "$(KCL_KUBECONFIG_SET_NAME)" ...'; $(NORMAL)
	$(_KCL_LIST_KUBECONFIGS_SET_|)ls -la $(KCL_KUBECONFIGS_REGEX) 

_kcl_set_kubeconfig_property:
	@$(INFO) '$(KCL_UI_LABEL)Setting property "$(KCL_KUBECONFIG_PROPERTY_NAME)" in kubeconfig "$(KCL_KUBECONFIG_NAME)" ...'; $(NORMAL)
	$(KUBECTL) config set $(KCL_KUBECONFIG_PROPERTY_NAME)  $(KCL_KUBECONFIG_PROPERTY_VALUE)

_KCL_SHOW_KUBECONFIG_TARGETS?= _kcl_show_kubeconfig_availableclusters _kcl_show_kubeconfig_availablecontexts _kcl_show_kubeconfig_context _kcl_show_kubeconfig_content _kcl_show_kubeconfig_description
_kcl_show_kubeconfig: $(_KCL_SHOW_KUBECONFIG_TARGETS)

_kcl_show_kubeconfig_availableclusters:
	@$(INFO) '$(KCL_UI_LABEL)Showing available-clusters in kubeconfig "$(KCL_KUBECONFIG_NAME)" ...'; $(NORMAL)
	$(KUBECTL) config get-clusters

_kcl_show_kubeconfig_availablecontexts:
	@$(INFO) '$(KCL_UI_LABEL)Showing available-contexts in kubeconfig "$(KCL_KUBECONFIG_NAME)" ...'; $(NORMAL)
	$(KUBECTL) config get-contexts

_kcl_show_kubeconfig_content:
	@$(INFO) '$(KCL_UI_LABEL)Showing entire kubeconfig "$(KCL_KUBECONFIG_NAME)" ...'; $(NORMAL)
	$(KUBECTL) config view 

_kcl_show_kubeconfig_context:
	@$(INFO) '$(KCL_UI_LABEL)Showing active-context of kubeconfig "$(KCL_KUBECONFIG_NAME)" ...'; $(NORMAL)
	$(KUBECTL) config view --minify

_kcl_show_kubeconfig_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing desription of kubeconfig "$(KCL_KUBECONFIG_NAME)" ...'; $(NORMAL)

_kcl_unset_kubeconfig_property:
	@$(INFO) '$(KCL_UI_LABEL)Unsetting parameter "$(KCL_KUBECONFIG_PROPERTY_NAME)" in kubeconfig ...'; $(NORMAL)
	$(KUBECTL) config unset $(KCL_KUBECONFIG_PROPERTY_NAME) 
