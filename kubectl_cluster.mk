_KUBECTL_CLUSTER_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_CLUSTER_BEARERTOKEN?=
# KCL_CLUSTER_DUMP_DIRPATH?= ./out/
# KCL_CLUSTER_DUMP_FILENAME?= my-cluster.txt
# KCL_CLUSTER_DUMP_FILEPATH?= ./out/my-cluster.txt
# KCL_CLUSTER_NAME?= kube-system
# KCL_CLUSTER_SECRET_NAME?=
# KCL_CLUSTER_URL?= https://hzvault-emayssat-dev-f8b96e-fc440225.hcp.westus2.azmk8s.io:443

# Derived parameters
KCL_CLUSTER_DUMP_DIRPATH?= $(KCL_OUTPUTS_DIRPATH)
KCL_CLUSTER_DUMP_FILENAME?= $(KCL_CLUSTER_NAME).$(KCL_DATE_YYYYMMDD_HHMMSS).dump
KCL_CLUSTER_DUMP_FILEPATH?= $(KCL_CLUSTER_DUMP_DIRPATH)$(KCL_CLUSTER_DUMP_FILENAME)

# Options

# Customizations
_KCL_TAIL_CLUSTER_|?=
|_KCL_TAIL_CLUSTER?= # | tee cluster.log

# Macros
_kcl_get_cluster_bearertoken= $(call _kcl_get_cluster_bearertoken_S, $(KCL_CLUSTER_SERCRET_NAME))
_kcl_get_cluster_bearertoken_S= $(shell $(KUBECTL) get secrets --namespace default $(1) --output jsonpath='{.data.token}' | base64 --decode)

_kcl_get_cluster_secret_name= $(shell $(KUBECTL) get serviceaccount default -o jsonpath='{.secrets[0].name}')

# See _kcl_get_kubeconfig_cluster_url
_kcl_get_cluster_url= $(shell $(KUBECTL) cluster-info | head -1 | cut -d ' ' -f 6 )

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Cluster ($(_KUBECTL_CLUSTER_MK_VERSION)) macros:'
	@echo '    _kcl_get_cluster_bearertoken                - Get the bearer-token of the active-cluster'
	@echo '    _kcl_get_cluster_secret_name                - Get the default secret of the active-cluster'
	@echo '    _kcl_get_cluster_url                        - Get the URL of the active-cluster'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Cluster ($(_KUBECTL_CLUSTER_MK_VERSION)) parameters:'
	@echo '    KCL_CLUSTER_BEARERTOKEN=$(KCL_CLUSTER_BEARERTOKEN)'
	@echo '    KCL_CLUSTER_DUMP_DIRPATH=$(KCL_CLUSTER_DUMP_DIRPATH)'
	@echo '    KCL_CLUSTER_DUMP_FILENAME=$(KCL_CLUSTER_DUMP_FILENAME)'
	@echo '    KCL_CLUSTER_DUMP_FILEPATH=$(KCL_CLUSTER_DUMP_FILEPATH)'
	@echo '    KCL_CLUSTER_NAME=$(KCL_CLUSTER_NAME)'
	@echo '    KCL_CLUSTER_SECRET_NAME=$(KCL_CLUSTER_SECRET_NAME)'
	@echo '    KCL_CLUSTER_URL=$(KCL_CLUSTER_URL)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Cluster ($(_KUBECTL_CLUSTER_MK_VERSION)) targets:'
	@echo '    _kcl_curl_cluster                           - Curl at the cluster'
	@echo '    _kcl_dump_cluster                           - Dump everything from a cluster (for troubleshooting!)'
	@echo '    _kcl_show_cluster                           - Show everything related to a cluster'
	@echo '    _kcl_show_cluster_allocatedresources        - Show allocated-resources on a cluster'
	@echo '    _kcl_show_cluster_apiresources              - Show api-resources of a cluster'
	@echo '    _kcl_show_cluster_apiservices               - Show api-services of a cluster'
	@echo '    _kcl_show_cluster_clusterroles              - Show cluster-roles of a cluster'
	@echo '    _kcl_show_cluster_clusterrolebindings       - Show cluster-role-bindings of a cluster'
	@echo '    _kcl_show_cluster_consumedresources         - Show consumed-resources of a cluster'
	@echo '    _kcl_show_cluster_description               - Show description of a cluster'
	@echo '    _kcl_show_cluster_mutatingwebhookconfigs    - Show mutating-webhook-configs of a cluster'
	@echo '    _kcl_show_cluster_namesparces               - Show namespaces of a cluster'
	@echo '    _kcl_show_cluster_nodepoddistributon        - Show node-pod distributtion in a cluster'
	@echo '    _kcl_show_cluster_nodes                     - Show nodes of a cluster'
	@echo '    _kcl_show_cluster_persistentvolumes         - Show persistent-volumes of a cluster'
	@echo '    _kcl_show_cluster_podsecuritypolicies       - Show pod-security-policies of a cluster'
	@echo '    _kcl_show_cluster_resources                 - Show allocated and consumed resources of a cluster'
	@echo '    _kcl_show_cluster_storageclasses            - Show storage-classes of a cluster'
	@echo '    _kcl_show_cluster_validatingwebhookconfigs  - Show validating-webhook-configs of a cluster'
	@echo '    _kcl_show_cluster_webhookconfigs            - Show X-webhook-configs of a cluster'
	@echo '    _kcl_tail_cluster                           - Tail pods in the entire cluster'
	@echo '    _kcl_top_cluster                            - Show allocated and consumed resources of a cluster'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_curl_cluster:
	@$(INFO) '$(KCL_UI_LABEL)Curling at cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'More info at https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster/'; $(NORMAL)
	curl --header 'Authorization: Bearer $(KCL_CLUSTER_BEARERTOKEN)' --insecure $(KCL_CLUSTER_URL)/api

_kcl_dump_cluster:
	@$(INFO) '$(KCL_UI_LABEL)Dumping all info of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) cluster-info dump | tee $(KCL_CLUSTER_DUMP_FILEPATH)
	@$(WARN) 'All available cluster-information has been dumped in file "$(KCL_CLUSTER_DUMP_FILEPATH)"'; $(NORMAL)

_KCL_SHOW_CLUSTER_TARGETS?= _kcl_show_cluster__header _kcl_show_cluster_apiresources _kcl_show_cluster_apiservices _kcl_show_cluster_clusterroles _kcl_show_cluster_clusterrolebindings _kcl_show_cluster_customresourcedefinitions _kcl_show_cluster_namespaces _kcl_show_cluster_nodepoddistribution _kcl_show_cluster_nodes _kcl_show_cluster_persistentvolumes _kcl_show_cluster_podsecuritypolicies _kcl_show_cluster_priorityclasses _kcl_show_cluster_resources _kcl_show_cluster_storageclasses _kcl_show_cluster_webhookconfigs _kcl_show_cluster_description _kcl_show_cluster__footer
_kcl_show_cluster :: $(_KCL_SHOW_CLUSTER_TARGETS)

_kcl_show_cluster__footer ::

_kcl_show_cluster__header ::

_kcl_show_cluster_allocatedresources:
	@$(INFO) '$(KCL_UI_LABEL)Showing allocated-resources of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(WARN) 'This operation fails of the metrics-server is not running'; $(NORMAL)
	$(WARN) 'For better results, review the resource requested by each pods'; $(NORMAL)
	-$(KUBECTL) top pod --all-namespaces=true

_kcl_show_cluster_apiresources:
	@$(INFO) '$(KCL_UI_LABEL)Showing api-resources of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The output of api-resources and api-services can be used to find the available api-versions for a given kind'; $(NORMAL)
	$(KUBECTL) api-resources

_kcl_show_cluster_apiservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing api-services of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The output of api-resources and api-services can be used to find the available api-versions for a given kind'; $(NORMAL)
	$(KUBECTL) get apiservices

_kcl_show_cluster_clusterroles:
	@$(INFO) '$(KCL_UI_LABEL)Showing cluster-roles of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get clusterroles

_kcl_show_cluster_clusterrolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Showing cluster-role-bindings of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get clusterrolebindings

_kcl_show_cluster_consumedresources:
	@$(INFO) '$(KCL_UI_LABEL)Showing consumed-resources of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails of the metric-server is not installed!'; $(NORMAL)
	-$(KUBECTL) top node

_kcl_show_cluster_customresourcedefinitions:
	@$(INFO) '$(KCL_UI_LABEL)Showing custom-resource-definitions of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get customresourcedefinitions

_kcl_show_cluster_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) cluster-info

_kcl_show_cluster_mutatingwebhookconfigs:
	@$(INFO) '$(KCL_UI_LABEL)Showing mutating-webhook-configs of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get mutatingwebhookconfigurations

_kcl_show_cluster_namespaces:
	@$(INFO) '$(KCL_UI_LABEL)Showing namespaces of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get namespaces

_kcl_show_cluster_nodepoddistribution:
	@$(INFO) '$(KCL_UI_LABEL)Showing node-pod distribution in cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the distribution of pods on master and worker nodes'; $(NORMAL)
	$(KUBECTL) get  pod  --all-namespaces -o=jsonpath="{range .items[*]}{.spec.nodeName}{'\t'}{.metadata.name}{'\n'}{end}"  --sort-by=.spec.nodeName

_kcl_show_cluster_nodes:
	@$(INFO) '$(KCL_UI_LABEL)Showing nodes of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get nodes --output wide --show-labels=true

_kcl_show_cluster_persistentvolumes:
	@$(INFO) '$(KCL_UI_LABEL)Showing persistent-volume in cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get persistentvolumes

_kcl_show_cluster_podsecuritypolicies:
	@$(INFO) '$(KCL_UI_LABEL)Showing pod-security-policies in cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get podsecuritypolicies

_kcl_show_cluster_priorityclasses:
	@$(INFO) '$(KCL_UI_LABEL)Showing priority-classes in cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get priorityclass

_kcl_show_cluster_resources: _kcl_show_cluster_allocatedresources _kcl_show_cluster_consumedresources

_kcl_show_cluster_storageclasses:
	@$(INFO) '$(KCL_UI_LABEL)Showing storage-classes of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get storageclasses

_kcl_show_cluster_validatingwebhookconfigs:
	@$(INFO) '$(KCL_UI_LABEL)Showing validating-webhook-configs of cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get validatingwebhookconfigurations

_kcl_show_cluster_webhookconfigs: _kcl_show_cluster_mutatingwebhookconfigs _kcl_show_cluster_validatingwebhookconfigs

_kcl_tail_cluster: _stn_tail_cluster

_kcl_top_cluster: _kcl_show_cluster_resources
