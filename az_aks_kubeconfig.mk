_AZ_AKS_KUBECONFIG_MK_VERSION= $(_AZ_AKS_MK_VERSION)

AKS_KUBECONFIG_ADMIN_FLAG?= false
# AKS_KUBECONFIG_CLUSTER_NAME?= Mykubeconfig
# AKS_KUBECONFIG_CONTEXT?=
# AKS_KUBECONFIG_FILENAME?= config
AKS_KUBECONFIG_FILEPATH?= ~/.kube/config
# AKS_KUBECONFIG_LOCATION_ID?= westus2
AKS_KUBECONFIG_OVERWRITE_FLAG?= false
# AKS_KUBECONFIG_RESOURCEGROUP_NAME?= MyResourceGroup

# Derived parameters
AKS_KUBECONFIG_CLUSTER_NAME?= $(AKS_CLUSTER_NAME)
# AKS_KUBECONFIG_LOCATION_ID?= $(AKS_CLUSTER_LOCATION_ID)
AKS_KUBECONFIG_FILENAME= $(notdir $(AKS_KUBECONFIG_FILEPATH))
AKS_KUBECONFIG_NAME= $(AKS_KUBECONFIG_FILENAME)
AKS_KUBECONFIG_RESOURCEGROUP_NAME?= $(AKS_CLUSTER_RESOURCEGROUP_NAME)

# Options parameters
__AKS_ADMIN= $(if $(filter true, $(AKS_KUBECONFIG_ADMIN_FLAG)),--admin)
__AKS_CONTEXT= $(if $(AKS_KUBECONFIG_CONTEXT),--context $(AKS_KUBECONFIG_CONTEXT))
__AKS_FILE__KUBECONFIG= $(if $(AKS_KUBECONFIG_FILEPATH),--file $(AKS_KUBECONFIG_FILEPATH))
# __AKS_LOCATION__KUBECONFIG= $(if $(AKS_KUBECONFIG_LOCATION_ID),--location $(AKS_KUBECONFIG_LOCATION_ID))
__AKS_NAME__KUBECONFIG= $(if $(AKS_KUBECONFIG_CLUSTER_NAME),--name $(AKS_KUBECONFIG_CLUSTER_NAME))
__AKS_OVERWRITE_EXISTING= $(if $(filter true, $(AKS_KUBECONFIG_OVERWRITE_FLAG)),--overwrite-existing)
__AKS_RESOURCE_GROUP__KUBECONFIG= $(if $(AKS_KUBECONFIG_RESOURCEGROUP_NAME),--resource-group $(AKS_KUBECONFIG_RESOURCEGROUP_NAME))

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_aks_view_framework_macros ::
	@echo 'AZ::AKS::Kubeconfig ($(_AZ_AKS_KUBECONFIG_MK_VERSION)) macros:'
	@echo

_aks_view_framework_parameters ::
	@echo 'AZ::AKS::Kubeconfig ($(_AZ_AKS_KUBECONFIG_MK_VERSION)) parameters:'
	@echo '    AKS_KUBECONFIG_ADMIN_FLAG=$(AKS_KUBECONFIG_ADMIN_FLAG)'
	@echo '    AKS_KUBECONFIG_CLUSTER_NAME=$(AKS_KUBECONFIG_CLUSTER_NAME)'
	@echo '    AKS_KUBECONFIG_CONTEXT=$(AKS_KUBECONFIG_CONTEXT)'
	@echo '    AKS_KUBECONFIG_FILENAME=$(AKS_KUBECONFIG_FILENAME)'
	@echo '    AKS_KUBECONFIG_FILEPATH=$(AKS_KUBECONFIG_FILEPATH)'
	@#echo '    AKS_KUBECONFIG_LOCATION_ID=$(AKS_KUBECONFIG_LOCATION_ID)'
	@echo '    AKS_KUBECONFIG_OVERWRITE_FLAG=$(AKS_KUBECONFIG_OVERWRITE_FLAG)'
	@echo '    AKS_KUBECONFIG_RESOURCEGROUP_NAME=$(AKS_KUBECONFIG_RESOURCEGROUP_NAME)'
	@echo

_aks_view_framework_targets ::
	@echo 'AZ::AKS::Kubeconfig ($(_AZ_AKS_KUBECONFIG_MK_VERSION)) targets:'
	@echo '    _aks_create_kubeconfig                - Create a kubeconfig'
	@echo '    _aks_delete_kubeconfig                - Delete a kubeconfig'
	@echo '    _aks_show_kubeconfig                  - Show everything related to a kubeconfig'
	@echo '    _aks_show_kubeconfig_description      - Show description of a kubeconfig'
	@echo '    _aks_view_kubeconfigs                 - View kubeconfigs'
	@echo '    _aks_view_kubeconfigs_set             - View a set of kubeconfigs'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aks_create_kubeconfig:
	@$(INFO) '$(AKS_UI_LABEL)Creating kubeconfig "$(AKS_KUBECONFIG_NAME)" ...'; $(NORMAL)
	$(AZ) aks get-credentials $(strip $(__AKS_ADMIN) $(__AKS_CONTEXT) $(__AKS_FILE__KUBECONFIG) $(__AKS_NAME__KUBECONFIG) $(__AKS_OVERWRITE_EXISTING) $(__AKS_RESOURCE_GROUP__KUBECONFIG) $(__AKS_SUBSCRIPTION) )

_aks_delete_kubeconfig:
	@$(INFO) '$(AKS_UI_LABEL)Deleting kubeconfig "$(AKS_KUBECONFIG_NAME)" ...'; $(NORMAL)
	$(AZ) aks delete $(__AKS_NAME__KUBECONFIG) $(__AKS_NO_WAIT__KUBECONFIG) $(__AKS_RESOURCE_GROUP__KUBECONFIG) $(__AKS_SUBSCRIPTION) $(__AKS_YES__KUBECONFIG)

_aks_show_kubeconfig :: _aks_show_kubeconfig_content _aks_show_kubeconfig_description

_aks_show_kubeconfig_content:
	@$(INFO) '$(AKS_UI_LABEL)Showing content of kubeconfig "$(AKS_KUBECONFIG_NAME)" ...'; $(NORMAL)
	$(if $(AKS_KUBECONFIG_FILEPATH), cat $(AKS_KUBECONFIG_FILEPATH))

_aks_show_kubeconfig_description:
	@$(INFO) '$(AKS_UI_LABEL)Showing description of kubeconfig "$(AKS_KUBECONFIG_NAME)" ...'; $(NORMAL)
	ls -l $(AKS_KUBECONFIG_FILEPATH)

_aks_view_kubeconfigs:
	@$(INFO) '$(AKS_UI_LABEL)Viewing kubeconfigs ...'; $(NORMAL)
	$(AZ) aks list $(___AKS_GLOBALS) $(_X__AKS_RESOURCE_GROUP)

_aks_view_kubeconfigs_set:
	@$(INFO) '$(AKS_UI_LABEL)Viewing kubeconfigs-set "$(AKS_KUBECONFIGS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Registries are grouped based on resource-group and query-filter'; $(NORMAL)
	$(AZ) aks list $(___AKS_GLOBALS) $(__AKS_RESOURCE_GROUP)
