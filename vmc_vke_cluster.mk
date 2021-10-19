_VMC_VKE_CLUSTER_MK_VERSION= $(_VMC_VKE_MK_VERSION)
 
# VKE_CLUSTER_ADDRESS?= allspark-vke-00232d04-c2bd-11e8-bc9f-0aec90b86dd2.82c51815-bced-4b00-a49a-b74e8f8f66f1.vke-user.com
# VKE_CLUSTER_API_VERSION?= 1.10.2-67
# VKE_CLUSTER_DASHBOARD_URL?= https://ui.allspark-vke-00232d04-c2bd-11e8-bc9f-0aec90b86dd2.82c51815-bced-4b00-a49a-b74e8f8f66f1.vke-user.com:443
# VKE_CLUSTER_DISPLAY_NAME?=
# VKE_CLUSTER_FOLDER_NAME?= SharedFolder
VKE_CLUSTER_HOST_NETWORK?= 10.1.0.0/16
# VKE_CLUSTER_NAME?= allspark-dev
VKE_CLUSTER_POD_NETWORK?= 10.2.0.0/16
# VKE_CLUSTER_PROJECT_NAME?= SharedProject
VKE_CLUSTER_PRIVILEGED_FORCE?= false
# VKE_CLUSTER_PRIVILEGED_MODE?= false
# VKE_CLUSTER_REGION?= us-west-2
VKE_CLUSTER_SERVICE_NETWORK?= 10.0.0.0/24
# VKE_CLUSTER_SHOW_PERF?= true
VKE_CLUSTER_TYPE?= DEVELOPMENT
# VKE_CLUSTER_TEMPLATE_NAME?= production
# VKE_CLUSTERS_SET_NAME?= my-clusters-set

# Derived variables
VKE_CLUSTER_DISPLAY_NAME?= $(VKE_CLUSTER_NAME)
VKE_CLUSTER_FOLDER_NAME?= $(VKE_FOLDER_NAME)
VKE_CLUSTER_NAME?= $(KCL_CLUSTER_NAME)
VKE_CLUSTER_NAME_NEW?= $(VKE_CLUSTER_NAME)
VKE_CLUSTER_NAME_OLD?= $(VKE_CLUSTER_NAME)
VKE_CLUSTER_PROJECT_NAME?= $(VKE_PROJECT_NAME)
VKE_CLUSTER_REGION?= $(VKE_REGION)

# Option variables
__VKE_CLUSTER_NETWORK= $(if $(VKE_CLUSTER_HOST_NETWORK),--cluster-network $(VKE_CLUSTER_HOST_NETWORK))
__VKE_CLUSTER_TYPE= $(if $(VKE_CLUSTER_TYPE),--cluster-type $(VKE_CLUSTER_TYPE))
__VKE_DISPLAY_NAME__CLUSTER= $(if $(VKE_CLUSTER_DISPLAY_NAME),--display-name $(VKE_CLUSTER_DISPLAY_NAME))
__VKE_FOLDER__CLUSTER= $(if $(VKE_CLUSTER_FOLDER_NAME),--folder $(VKE_CLUSTER_FOLDER_NAME))
__VKE_FORCE__CLUSTER= $(if $(filter true, $(VKE_CLUSTER_PRIVILEGED_FORCE)),--force)
__VKE_NAME__CLUSTER= $(if $(VKE_CLUSTER_NAME),--name $(VKE_CLUSTER_NAME))
__VKE_PERF= $(if $(filter true, $(VKE_CLUSTER_SHOW_PERF)),--perf)
__VKE_POD_NETWORK= $(if $(VKE_CLUSTER_POD_NETWORK),--pod-network $(VKE_CLUSTER_POD_NETWORK))
__VKE_PRIVILEGED_MODE= $(if $(filter true, $(VKE_CLUSTER_PRIVILEGED_MODE)),--privilegedMode)
__VKE_PROJECT__CLUSTER= $(if $(VKE_CLUSTER_PROJECT_NAME),--project $(VKE_CLUSTER_PROJECT_NAME))
__VKE_REGION__CLUSTER= $(if $(VKE_CLUSTER_REGION),--region $(VKE_CLUSTER_REGION))
__VKE_SERVICE_NETWORK= $(if $(VKE_CLUSTER_SERVICE_NETWORK),--service-network $(VKE_CLUSTER_SERVICE_NETWORK))
__VKE_TEMPLATE__CLUSTER= $(if $(VKE_CLUSTER_TEMPLATE_NAME),--cluster-template $(VKE_CLUSTER_TEMPLATE_NAME))
__VKE_VERSION= $(if $(VKE_CLUSTER_API_VERSION),--version $(VKE_CLUSTER_API_VERSION))

# UI variables
 
#--- Utilities

#--- MACROS

_vke_get_cluster_address= $(call _vke_get_cluster_address_N, $(VKE_CLUSTER_NAME))
_vke_get_cluster_address_N= $(call _vke_get_cluster_address_NP, $(1), $(VKE_CLUSTER_PROJECT_NAME))
_vke_get_cluster_address_NP= $(call _vke_get_cluster_address_NPF, $(1), $(2), $(VKE_CLUSTER_FOLDER_NAME))
_vke_get_cluster_address_NPF= $(shell $(VKE) --output json cluster show --folder $(3) --project $(2) $(1) | jq -r '.details.address')

_vke_get_cluster_dashboard_url= $(call _vke_get_cluster_dashboard_url_N, $(VKE_CLUSTER_NAME))
_vke_get_cluster_dashboard_url_N= $(call _vke_get_cluster_dashboard_url_NP, $(1), $(VKE_CLUSTER_PROJECT_NAME))
_vke_get_cluster_dashboard_url_NP= $(call _vke_get_cluster_dashboard_url_NPF, $(1), $(2), $(VKE_CLUSTER_FOLDER_NAME))
_vke_get_cluster_dashboard_url_NPF= $(shell $(VKE) --output json cluster show --folder $(3) --project $(2) $(1) | jq -r '.details.uiUrl')

# vke -o json cluster show --folder SharedFolder --perf --project SharedProject staging-vke | jq -r '.details.uiUrl'

#----------------------------------------------------------------------
# USAGE
#

_vke_view_framework_macros ::
	@echo 'VMC::VKE::Cluster ($(_VMC_VKE_CLUSTER_MK_VERSION)) macros:'
	@echo '    _vke_get_cluster_address_{|N|NP|NPF}         - Get the address of a cluster (Name,Project,Folder)'
	@echo '    _vke_get_cluster_dashboard_url_{|N|NP|NPF}   - Get the dashboard URL of a cluster (Name,Project,Folder)'
	@echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::Cluster ($(_VMC_VKE_CLUSTER_MK_VERSION)) parameters:'
	@echo '    VKE_CLUSTER_ADDRESS=$(VKE_CLUSTER_ADDRESS)'
	@echo '    VKE_CLUSTER_API_VERSION=$(VKE_CLUSTER_API_VERSION)'
	@echo '    VKE_CLUSTER_DASHBOARD_URL=$(VKE_CLUSTER_DASHBOARD_URL)'
	@echo '    VKE_CLUSTER_DISPLAY_NAME=$(VKE_CLUSTER_DISPLAY_NAME)'
	@echo '    VKE_CLUSTER_FOLDER_NAME=$(VKE_CLUSTER_FOLDER_NAME)'
	@echo '    VKE_CLUSTER_HOST_NETWORK=$(VKE_CLUSTER_HOST_NETWORK)'
	@echo '    VKE_CLUSTER_NAME=$(VKE_CLUSTER_NAME)'
	@echo '    VKE_CLUSTER_NAME_NEW=$(VKE_CLUSTER_NAME_NEW)'
	@echo '    VKE_CLUSTER_NAME_OLD=$(VKE_CLUSTER_NAME_OLD)'
	@echo '    VKE_CLUSTER_POD_NETWORK=$(VKE_CLUSTER_POD_NETWORK)'
	@echo '    VKE_CLUSTER_PRIVILEGED_FORCE=$(VKE_CLUSTER_PRIVILEGED_FORCE)'
	@echo '    VKE_CLUSTER_PRIVILEGED_MODE=$(VKE_CLUSTER_PRIVILEGED_MODE)'
	@echo '    VKE_CLUSTER_PROJECT_NAME=$(VKE_CLUSTER_PROJECT_NAME)'
	@echo '    VKE_CLUSTER_REGION=$(VKE_CLUSTER_REGION)'
	@echo '    VKE_CLUSTER_SERVICE_NETWORK=$(VKE_CLUSTER_SERVICE_NETWORK)'
	@echo '    VKE_CLUSTER_SHOW_PERF=$(VKE_CLUSTER_SHOW_PERF)'
	@echo '    VKE_CLUSTER_TEMPLATE_NAME=$(VKE_CLUSTER_TEMPLATE_NAME)'
	@echo '    VKE_CLUSTER_TYPE=$(VKE_CLUSTER_TYPE)'
	@echo '    VKE_CLUSTERS_SET_NAME=$(VKE_CLUSTERS_SET_NAME)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::Cluster ($(_VMC_VKE_CLUSTER_MK_VERSION)) targets:'
	@echo '    _vke_create_cluster                  - Create a new cluster'
	@echo '    _vke_delete_cluster                  - Delete an existing cluster'
	@echo '    _vke_rename_cluster                  - Rename a cluster'
	@echo '    _vke_show_cluster                    - Show everything related to a cluster'
	@echo '    _vke_show_cluster_description        - Show description of a cluster'
	@echo '    _vke_show_cluster_health             - Show health of a cluster'
	@echo '    _vke_show_cluster_namespaces         - Show namespaces of a cluster'
	@echo '    _vke_upgrade_cluster                 - Upgrade version of cluster'
	@echo '    _vke_view_clusters                   - View clusters'
	@echo '    _vke_view_clusters_set               - View a set of clusters'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_create_cluster:
	@$(INFO) '$(VKE_UI_LABEL)Creating cluster "$(VKE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(VKE) cluster create $(strip $(__VKE_CLUSTER_NETWORK) $(__VKE_CLUSTER_TYPE) $(__VKE_DISPLAY_NAME__CLUSTER) $(__VKE_FOLDER__CLUSTER) $(__VKE_FORCE__CLUSTER) $(__VKE_NAME__CLUSTER) $(__VKE_POD_NETWORK) $(__VKE_PRIVILEGED_MODE) $(__VKE_PROJECT__CLUSTER) $(__VKE_REGION__CLUSTER) $(__VKE_SERVICE_NETWORK) $(__VKE_TEMPLATE__CLUSTER) $(__VKE_VERSION) )

_vke_delete_cluster:
	@$(INFO) '$(VKE_UI_LABEL)Deleting cluster "$(VKE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(VKE) cluster delete $(__VKE_FOLDER__CLUSTER) $(__VKE_PROJECT__CLUSTER) $(VKE_CLUSTER_NAME)

_vkew_rename_cluster:
	@$(INFO) '$(VKE_UI_LABEL)Renaming cluster "$(VKE_CLUSTER_NAME_OLD)" ...'; $(NORMAL)
	$(VKE) cluster rename $(__VKE_FOLDER__CLUSTER) $(__VKE_PROJECT__CLUSTER) $(VKE_CLUSTER_NAME_OLD) $(VKE_CLUSTER_NAME_NEW)

_vke_show_cluster: _vke_show_cluster_accesspolicy _vke_show_cluster_health _vke_show_cluster_description

_vke_show_cluster_accesspolicy:
	@$(INFO) '$(VKE_UI_LABEL)Showing access-policies of cluster "$(VKE_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Access-policies are direct or inherited'; $(NORMAL)
	$(VKE) cluster iam show $(__VKE_FOLDER__CLUSTER) $(__VKE_PROJECT__CLUSTER) $(VKE_CLUSTER_NAME)

_vke_show_cluster_description:
	@$(INFO) '$(VKE_UI_LABEL)Showing description of cluster "$(VKE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(VKE) cluster show $(__VKE_FOLDER__CLUSTER) $(__VKE_PERF) $(__VKE_PROJECT__CLUSTER) $(VKE_CLUSTER_NAME)

_vke_show_cluster_health:
	@$(INFO) '$(VKE_UI_LABEL)Showing the health of cluster "$(VKE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(VKE) cluster show-health $(__VKE_FOLDER__CLUSTER) $(__VKE_PROJECT__CLUSTER) $(VKE_CLUSTER_NAME)

_vke_show_cluster_namespaces:
	@$(INFO) '$(VKE_UI_LABEL)Showing namespaces of cluster "$(VKE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(VKE) cluster namespace list  $(__VKE_FOLDER__CLUSTER) $(__VKE_PROJECT__CLUSTER) $(VKE_CLUSTER_NAME)

_vke_upgrade_cluster:
	@$(INFO) '$(VKE_UI_LABEL)Upgrading cluster "$(VKE_CLUSTER_NAME)" to version "$(VKE_CLUSTER_VERSION)" ...'; $(NORMAL)
	$(VKE) cluster upgrade  $(__VKE_FOLDER__CLUSTER) $(__VKE_PROJECT__CLUSTER) $(__VKE_VERSION) $(VKE_CLUSTER_NAME)

_vke_view_clusters:
	@$(INFO) '$(VKE_UI_LABEL)Viewing clusters ...'; $(NORMAL)
	$(VKE) cluster list $(_X__VKE_FOLDER__CLUSTER) $(_X__VKE_PROJECT__CLUSTER)

_vke_view_clusters_set:
	@$(INFO) '$(VKE_UI_LABEL)Viewing clusters-set "$(VKE_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Clusters are grouped based on the provided folder and project'; $(NORMAL)
	$(VKE) cluster list $(__VKE_FOLDER__CLUSTER) $(__VKE_PROJECT__CLUSTER)
