_MINIKUBE_CLUSTER_MK_VERSION= $(_MINIKUBE_MK_VERSION)

# MKE_CLUSTER_CACHEIMAGES_FLAG?= false
# MKE_CLUSTER_CNI_TYPE?= calico
MKE_CLUSTER_CPU_COUNT?= 2
MKE_CLUSTER_DISK_SIZE?= 20000mb
MKE_CLUSTER_DRIVER_TYPE?= hyperkit
# MKE_CLUSTER_EXTRA_CONFIG?= apiserver.enable-admission-plugins=LimitRanger,...
# MKE_CLUSTER_HOST_CIDR?= 192.168.99.1/24
# MKE_CLUSTER_INSECURE_REGISTRY?= 10.0.0.0/24
MKE_CLUSTER_KUBERNETES_VERSION?= v1.17.2
MKE_CLUSTER_MEMORY_SIZE?= 2000mb
MKE_CLUSTER_MOUNT_FLAG?= false
# MKE_CLUSTER_MOUNT_MAP?= $$HOME:/host ...
# MKE_CLUSTER_MINIKUBEISO_URL?= https://github.com/kubernetes/minikube/releases/download/v1.5.1/minikube-v1.5.1.iso
# MKE_CLUSTER_NAME?= minikube
MKE_CLUSTER_NODE_COUNT?= 1
# MKE_CLUSTER_STATUS_FORMAT?= "minikube: {{.MinikubeStatus}}\ncluster: {{.ClusterStatus}}\nkubectl: {{.KubeconfigStatus}}\n"
# MKE_CLUSTERS_SET_NAME?= my-clusters-set

# Derived variables
MKE_CLUSTER_MINIKUBEISO_URL?= $(MKE_MINIKUBE_ISO_URL)
MKE_CLUSTER_NAME?= $(MINIKUBE_PROFILE_NAME)

# Option variables
__MKE_APISERVERS_IPS=
__MKE_APISERVERS_NAME=
__MKE_APISERVERS_NAMES=
__MKE_CACHE_IMAGES=
__MKE_CONTAINER_RUNTIME=
__MKE_CNI= $(if $(MKE_CLUSTER_CNI_TYPE),--cni=$(MKE_CLUSTER_CNI_TYPE))
__MKE_CPUS= $(if $(MKE_CLUSTER_CPU_COUNT),--cpus $(MKE_CLUSTER_CPU_COUNT))
__MKE_DISABLE_DRIVER_MOUNTS= --disable-driver-mounts
__MKE_DISK_SIZE= $(if $(MKE_CLUSTER_DISK_SIZE),--disk-size $(MKE_CLUSTER_DISK_SIZE))
__MKE_DNS_DOMAIN=
__MKE_DOCKER_ENV=
__MKE_DRIVER= $(if $(MKE_CLUSTER_DRIVER_TYPE),--driver=$(MKE_CLUSTER_DRIVER_TYPE))
__MKE_EXTRA_CONFIG= $(if $(MKE_CLUSTER_EXTRA_CONFIG),--extra-config=$(MKE_CLUSTER_EXTRA_CONFIG))
__MKE_FEATURE_GATES=
__MKE_FORMAT= $(if $(MKE_CLUSTER_STATUS_FORMAT),--format $(MKE_CLUSTER_STATUS_FORMAT))
__MKE_GPUS=
__MKE_HOST_ONLY_CIDR= $(if $(MKE_CLUSTER_HOST_CIDR),--host-only-cidr $(MKE_CLUSTER_HOST_CIDR))
__MKE_HYPERKIT_VPNKIT_SOCK=
__MKE_HYPERKIT_VSOCK_PORTS=
__MKE_HYPERV_VIRTUAL_SWITCH=
__MKE_INSECURE_REGISTRY= $(if $(MKE_CLUSTER_INSECURE_REGISTRY),--insecure-registry $(MKE_CLUSTER_INSECURE_REGISTRY))
__MKE_ISO_URL= $(if $(MKE_CLUSTER_MINIKUBEISO_URL),--iso-url $(MKE_CLUSTER_MINIKUBEISO_URL))
__MKE_KEEP_CONTEXT=
__MKE_KUBERNETES_VERSION= $(if $(MKE_CLUSTER_KUBERNETES_VERSION),--kubernetes-version $(MKE_CLUSTER_KUBERNETES_VERSION))
__MKE_KVM_NETWORK=
__MKE_MEMORY= $(if $(MKE_CLUSTER_MEMORY_SIZE),--memory $(MKE_CLUSTER_MEMORY_SIZE))
__MKE_MOUNT= $(if $(MKE_CLUSTER_MOUNT_FLAG),--mount=$(MKE_CLUSTER_MOUNT_FLAG))
__MKE_MOUNT_STRING= $(foreach M,$(MKE_CLUSTER_MOUNT_MAP),--mount-string $(M) )
__MKE_NETWORK_PLUGIN= $(if $(MKE_CLUSTER_NETWORK_PLUGIN),--network-plugin=$(MKE_CLUSTER_NETWORK_PLUGIN))
__MKE_NFS_SHARE=
__MKE_NFS_SHARES_ROOT=
__MKE_NODES= $(if $(MKE_CLUSTER_NODE_COUNT),--nodes $(MKE_CLUSTER_NODE_COUNT))
__MKE_REGISTRY_MIRROR=
__MKE_UUID=
__MKE_XHYVE_DISK_DRIVER=

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_mke_list_macros ::
	@#echo 'MiniKubE::Cluster ($(_MINIKUBE_CLUSTER_MK_VERSION)) macros:'
	@#echo

_mke_list_parameters ::
	@echo 'MiniKubE::Cluster ($(_MINIKUBE_CLUSTER_MK_VERSION)) parameters:'
	@echo '    MKE_CLUSTER_CACHEIMAGES_FLAG=$(MKE_CLUSTER_CACHEIMAGES_FLAG)'
	@echo '    MKE_CLUSTER_CNI_TYPE=$(MKE_CLUSTER_CNI_TYPE)'
	@echo '    MKE_CLUSTER_CPU_COUNT=$(MKE_CLUSTER_CPU_COUNT)'
	@echo '    MKE_CLUSTER_DISK_SIZE=$(MKE_CLUSTER_DISK_SIZE)'
	@echo '    MKE_CLUSTER_DRIVER_TYPE=$(MKE_CLUSTER_DRIVER_TYPE)'
	@echo '    MKE_CLUSTER_EXTRA_CONFIG=$(MKE_CLUSTER_EXTRA_CONFIG)'
	@echo '    MKE_CLUSTER_HOST_CIDR=$(MKE_CLUSTER_HOST_CIDR)'
	@echo '    MKE_CLUSTER_INSECURE_REGISTRY=$(MKE_CLUSTER_INSECURE_REGISTRY)'
	@echo '    MKE_CLUSTER_KUBERNETES_VERSION=$(MKE_CLUSTER_KUBERNETES_VERSION)'
	@echo '    MKE_CLUSTER_MEMORY_SIZE=$(MKE_CLUSTER_MEMORY_SIZE)'
	@echo '    MKE_CLUSTER_MOUNT_FLAG=$(MKE_CLUSTER_MOUNT_FLAG)'
	@echo '    MKE_CLUSTER_MOUNT_MAP=$(MKE_CLUSTER_MOUNT_MAP)'
	@echo '    MKE_CLUSTER_NAME=$(MKE_CLUSTER_NAME)'
	@echo '    MKE_CLUSTER_NETWORK_PLUGIN=$(MKE_CLUSTER_NETWORK_PLUGIN)'
	@echo '    MKE_CLUSTER_NODE_COUNT=$(MKE_CLUSTER_NODE_COUNT)'
	@echo '    MKE_CLUSTER_STATUS_FORMAT=$(MKE_CLUSTER_STATUS_FORMAT)'
	@echo '    MKE_CLUSTERS_SET_NAME=$(MKE_CLUSTERS_SET_NAME)'
	@echo

_mke_list_targets ::
	@echo 'MiniKubE::Cluster ($(_MINIKUBE_CLUSTER_MK_VERSION)) targets:'
	@echo '    _mke_create_cluster             - Create a new cluster'
	@echo '    _mke_delete_cluster             - Delete an existing cluster'
	@echo '    _mke_stop_cluster               - Stop a running cluster'
	@echo '    _mke_show_cluster               - Show everything related to a cluster'
	@echo '    _mke_show_cluster_dashboardurl  - Show the dashboard-url of a cluster'
	@echo '    _mke_show_cluster_status        - Show the status of a cluster'
	@echo '    _mke_start_cluster              - Start a new cluster'
	@echo '    _mke_stop_cluster               - Stop a running cluster'
	@echo '    _mke_list_clusters              - List all clusters'
	@echo '    _mke_list_clusters_set          - List a set of clusters'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mke_create_cluster:
	@$(INFO) '$(MKE_UI_LABEL)Starting cluster "$(MKE_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation adds a cluster-configuration and updates the active-context of the kubeconfig'; $(NORMAL)
	$(MINIKUBE) start $(strip $(__MKE_APISERVER_IPS) $(__MKE_APISERVER_NAME) $(__MKE_APISERVER_NAMES) $(__MKE_CACHE_IMAGES) $(__MKE_CNI) $(__MKE_CONTAINER_RUNTIME) $(__MKE_CPUS) $(__MKE_DRIVER) $(__MKE_DISABLE_DRIVER_MOUNTS) $(__MKE_DISK_SIZE) $(__MKE_DNS_DOMAIN) $(__MKE_DOCKER_ENV) $(__MKE_EXTRA_CONFIG) $(__MKE_FEATURE_GATES) $(__MKE_GPU) $(_X__HELP) $(__MKE_HOST_ONLY_CIDR) $(__MKE_HYPERKIT_VPNKIT_SOCK) $(__MKE_HYPERKIT_VSOCK_PORTS) $(__MKE_HYPERV_VIRTUAL_SWITCH) $(__MKE_INSECURE_REGISTRY) $(__MKE_ISO_URL) $(__MKE_KEEP_CONTEXT) $(__MKE_KUBERNETES_VERSION) $(__MKE_KVM_NETWORK) $(__MKE_MEMORY) $(__MKE_MOUNT) $(__MKE_MOUNT_STRING) $(__MKE_NETWORK_PLUGIN) $(__MKE_NFS_SHARE) $(__MKE_NFS_SHARES_ROOT) $(__MKE_NODES) $(__MKE_REGISTRY_MIRROR) $(__MKE_UUID) $(__MKE_XHYVE_DISK_DRIVER) )

_mke_delete_cluster:
	@$(INFO) '$(MKE_UI_LABEL)Deleting cluster "$(MKE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) delete

_mke_list_clusters:
	@$(INFO) '$(MKE_UI_LABEL)Listing ALL clusters ...'; $(NORMAL)
	$(MINIKUBE) profile list

_mke_list_clusters_set:
	@$(INFO) '$(MKE_UI_LABEL)Listing clusters-set "$(MKE_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
	# $(MINIKUBE) profile list

_MKE_SHOW_CLUSTER_TARGETS: _mke_show_cluster_status
_mke_show_cluster: $(_MKE_SHOW_CLUSTER_TARGETS)

_mke_show_cluster_dashboard:
	@$(INFO) '$(MKE_UI_LABEL)Showing dashboard-url of cluster "$(MKE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) dashboard --url

_mke_show_cluster_status:
	@$(INFO) '$(MKE_UI_LABEL)Showing status of cluster "$(MKE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) status $(__MKE_FORMAT) $(_X__MKE_HELP)

_mke_start_cluster: _mke_create_cluster

_mke_stop_cluster:
	@$(INFO) '$(MKE_UI_LABEL)Stopping cluster "$(MKE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) stop $(_X__HELP)
