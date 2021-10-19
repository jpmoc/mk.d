_KIND_CLUSTER_MK_VERSION= $(_KIND_MK_VERSION)

# KND_CLUSTER_APIVERSION_NAME?= v1.19.1
# KND_CLUSTER_CONFIG_DIRPATH?= ./in/
# KND_CLUSTER_CONFIG_FILENAME?= kind-config.yaml
# KND_CLUSTER_CONFIG_FILEPATH?= ./in/kind-config.yaml
KND_CLUSTER_IMAGE_FAMILY?= kindest/node
# KND_CLUSTER_IMAGE_NAME?= kindest/node:v1.17.0 
# KND_CLUSTER_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config
KND_CLUSTER_NAME?= kind
KND_CLUSTER_RETAIN_FLAG?= false
KND_CLUSTERS_REGEX?= *
# KND_CLUSTERS_SET_NAME?= my-clusters-set

# Derived variables
KND_CLUSTER_APIVERSION_NAME?= $(KND_APIVERSION_NAME)
KND_CLUSTER_IMAGE_NAME?= $(if $(KND_CLUSTER_APIVERSION_NAME),$(KND_CLUSTER_IMAGE_FAMILY):$(KND_CLUSTER_APIVERSION_NAME))
KND_CLUSTER_CONFIG_DIRPATH?= $(KND_INPUTS_DIRPATH)
KND_CLUSTER_CONFIG_FILEPATH?= $(if $(KND_CLUSTER_CONFIG_FILENAME),$(KND_CLUSTER_CONFIG_DIRPATH)$(KND_CLUSTER_CONFIG_FILENAME))
KND_CLUSTERS_SET_NAME?= clusters@$(KND_CLUSTERS_REGEX)

# Option variables
__KND_CONFIG= $(if $(KND_CLUSTER_CONFIG_FILEPATH),--config $(KND_CLUSTER_CONFIG_FILEPATH))
__KND_IMAGE= $(if $(KND_CLUSTER_IMAGE_NAME),--image $(KND_CLUSTER_IMAGE_NAME))
__KND_KUBECONFIG= $(if $(KND_CLUSTER_KUBECONFIG_FILEPATH),--kubeconfig $(KND_CLUSTER_KUBECONFIG_FILEPATH))
__KND_NAME__CLUSTER= $(if $(KND_CLUSTER_NAME),--name $(KND_CLUSTER_NAME))
__KND_RETAIN= $(if $(filter true, $(KND_CLUSTER_RETAIN_FLAG)),--retain)
__KND_WAIT= --wait 0s

# Pipe parameters
|_KND_VIEW_CLUSTERS_SET?= | grep -E '$(KND_CLUSTERS_REGEX)'

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_knd_view_framework_macros ::
	@#echo 'KiND::Cluster ($(_KIND_CLUSTER_MK_VERSION)) macros:'
	@#echo

_knd_view_framework_parameters ::
	@echo 'KiND::Cluster ($(_KIND_CLUSTER_MK_VERSION)) parameters:'
	@echo '    KND_CLUSTER_APIVERSION_NAME=$(KND_CLUSTER_APIVERSION_NAME)'
	@echo '    KND_CLUSTER_CONFIG_DIRPATH=$(KND_CLUSTER_CONFIG_DIRPATH)'
	@echo '    KND_CLUSTER_CONFIG_FILENAME=$(KND_CLUSTER_CONFIG_FILENAME)'
	@echo '    KND_CLUSTER_CONFIG_FILEPATH=$(KND_CLUSTER_CONFIG_FILEPATH)'
	@echo '    KND_CLUSTER_IMAGE_FAMILY=$(KND_CLUSTER_IMAGE_FAMILY)'
	@echo '    KND_CLUSTER_IMAGE_NAME=$(KND_CLUSTER_IMAGE_NAME)'
	@echo '    KND_CLUSTER_KUBECONFIG_FILEPATH=$(KND_CLUSTER_KUBECONFIG_FILEPATH)'
	@echo '    KND_CLUSTER_NAME=$(KND_CLUSTER_NAME)'
	@echo '    KND_CLUSTER_RETAIN_FLAG=$(KND_CLUSTER_RETAIN_FLAG)'
	@echo '    KND_CLUSTERS_REGEX=$(KND_CLUSTERS_REGEX)'
	@echo '    KND_CLUSTERS_SET_NAME=$(KND_CLUSTERS_SET_NAME)'
	@echo

_knd_view_framework_targets ::
	@echo 'KiND::Cluster ($(_KIND_CLUSTER_MK_VERSION)) targets:'
	@echo '    _knd_create_cluster             - Create a new cluster'
	@echo '    _knd_delete_cluster             - Delete an existing cluster'
	@echo '    _knd_show_cluster               - Show everything related to a cluster'
	@echo '    _knd_show_cluster_config        - Show config of a cluster'
	@echo '    _knd_show_cluster_description   - Show description of a cluster'
	@echo '    _knd_view_clusters              - View all clusters'
	@echo '    _knd_view_clusters_set          - View a set of clusters'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_knd_create_cluster:
	@$(INFO) '$(KND_UI_LABEL)Creating cluster "$(KND_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'By default, this operation brings up only a control-plane node and no workers'; $(NORMAL)
	$(if $(KND_CLUSTER_CONFIG_FILEPATH), cat $(KND_CLUSTER_CONFIG_FILEPATH); echo)
	$(KIND) create cluster $(__KND_CONFIG) $(__KND_IMAGE) $(__KND_KUBECONFIG) $(__KND_NAME__CLUSTER) $(__KND_RETAIN) $(__KND_WAIT)

_knd_delete_cluster:
	@$(INFO) '$(KND_UI_LABEL)Deleting cluster "$(KND_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KIND) delete cluster $(__KND_NAME__CLUSTER)

_knd_show_cluster :: _knd_show_cluster_config _knd_show_cluster_description

_knd_show_cluster_config:
	@$(INFO) '$(KND_UI_LABEL)Showing config of cluster "$(KND_CLUSTER_NAME)" ...'; $(NORMAL)
	$(if $(KND_CLUSTER_CONFIG_FILEPATH), \
		cat $(KND_CLUSTER_CONFIG_FILEPATH); echo \
	, @\
		echo 'KND_CLUSTER_CONFIG_FILEPATH not set' \
	)

_knd_show_cluster_description:
	@$(INFO) '$(KND_UI_LABEL)Showing description of cluster "$(KND_CLUSTER_NAME)" ...'; $(NORMAL)

_knd_view_clusters:
	@$(INFO) '$(KND_UI_LABEL)Viewing clusters ...'; $(NORMAL)
	$(KIND) get clusters

_knd_view_clusters_set:
	@$(INFO) '$(KND_UI_LABEL)Viewing clusters-set "$(KND_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
	$(KIND) get clusters $(|_KND_VIEW_CLUSTERS_SET)
