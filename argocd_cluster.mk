_ARGOCD_CLUSTER_MK_VERSION= $(_ARGOCD_MK_VERSION)

# ACD_CLUSTER_APISERVER_URL?= https://kubernetes.default.svc
# ACD_CLUSTER_CONTEXT_NAME?= docker-for-desktop
# ACD_CLUSTER_NAME?= docker-for-desktop

# Derived parameters
ACD_CLUSTER_NAME?= $(ACD_CLUSTER_CONTEXT_NAME)

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_acd_view_framework_macros ::
	@echo 'ArgoCD::Cluster ($(_ARGOCD_CLUSTER_MK_VERSION)) macros:'
	@echo

_acd_view_framework_parameters ::
	@echo 'ArgoCD::Cluster ($(_ARGOCD_CLUSTER_MK_VERSION)) parameters:'
	@echo '    ACD_CLUSTER_APISERVER_URL=$(ACD_CLUSTER_APISERVER_URL)'
	@echo '    ACD_CLUSTER_CONTEXT_NAME=$(ACD_CLUSTER_CONTEXT_NAME)'
	@echo '    ACD_CLUSTER_NAME=$(ACD_CLUSTER_NAME)'
	@echo '    ACD_CLUSTERS_SET_NAME=$(ACD_CLUSTERS_SET_NAME)'
	@echo

_acd_view_framework_targets ::
	@echo 'ArgoCD::Cluster ($(_ARGOCD_CLUSTER_MK_VERSION)) targets:'
	@echo '    _acd_create_cluster                     - Create a cluster'
	@echo '    _acd_delete_cluster                     - Delete a cluster'
	@echo '    _acd_show_cluster                       - Show everything related to a cluster'
	@echo '    _acd_show_cluster_description           - Show description of a cluster'
	@echo '    _acd_view_clusters                      - View clusters'
	@echo '    _acd_view_clusters_set                  - View a set of clusters'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_acd_create_cluster:
	@$(INFO) '$(ACD_UI_LABEL)Creating cluster "$(ACD_CLUSTER_NAME)" ...'; $(NORMAL)
	$(ARGOCD) cluster add $(ACD_CLUSTER_CONTEXT_NAME)

_acd_delete_cluster:
	@$(INFO) '$(ACD_UI_LABEL)Deleting cluster "$(ACD_CLUSTER_NAME)" ...'; $(NORMAL)

_acd_show_cluster :: _acd_show_cluster_description

_acd_show_cluster_description:
	@$(INFO) '$(ACD_UI_LABEL)Showing description of cluster "$(ACD_CLUSTER_NAME)" ...'; $(NORMAL)
	$(ARGOCD) cluster get $(ACD_CLUSTER_APISERVER_URL)

_acd_view_clusters:
	@$(INFO) '$(ACD_UI_LABEL)Viewing clusters ...'; $(NORMAL)
	$(ARGOCD) cluster list

_acd_view_clusters_set:
	@$(INFO) '$(ACD_UI_LABEL)Viewing clusters-set "$(ACD_CLUSTERS_SET_NAME)" ...'; $(NORMAL)

