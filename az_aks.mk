_AZ_AKS_MK_VERSION= 0.99.0

AKS_CLIENT_VERSION?= latest
AKS_INSTALL_LOCATION?= /usr/local/bin/kubectl
# AKS_LOCATION_ID?= westus2
# AKS_MODE_NOWAIT?= false
# AKS_MODE_YES?= false
# AKS_OUTPUT_FORMAT?= table
# AKS_RESOURCEGROUP_NAME?=
# AKS_SUBSCRIPTION_NAME_OR_ID?=

# Derived parameters
AKS_LOCATION_ID?= $(AZ_LOCATION_ID)
AKS_MODE_NOWAIT?= $(AZ_MODE_NOWAIT)
AKS_MODE_YES?= $(AZ_MODE_YES)
AKS_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)
AKS_RESOURCEGROUP_NAME?= $(AZ_RESOURCEGROUP_NAME)
AKS_SUBSCRIPTION_ID_OR_NAME?= $(AZ_SUBSCRIPTION_ID_OR_NAME)

# Options parameters
__AKS_CLIENT_VERSION= $(if $(AKS_CLIENT_VERSION),--client-version $(AKS_CLIENT_VERSION))
__AKS_INSTALL_LOCATION= $(if $(AKS_INSTALL_LOCATION),--install-location $(AKS_INSTALL_LOCATION))
__AKS_LOCATION= $(if $(AKS_LOCATION_ID),--location $(AKS_LOCATION_ID))
__AKS_NO_WAIT= $(if $(filter true, $(AKS_MODE_NOWAIT)),--no-wait)
__AKS_OUTPUT= $(if $(AKS_OUTPUT_FORMAT),--output $(AKS_OUTPUT_FORMAT))
__AKS_RESOURCE_GROUP= $(if $(AKS_RESOURCEGROUP_NAME),--resource-group $(AKS_RESOURCEGROUP_NAME))
__AKS_SUBSCRIPTION= $(if $(AKS_SUBSCRIPTION_ID_OR_NAME),--subscription $(AKS_SUBSCRIPTION_ID_OR_NAME))
__AKS_YES= $(if $(filter true, $(AKS_MODE_YES)),--yes)

___AKS_GLOBALS= $(__AKS_OUTPUT) $(__AKS_SUBSCRIPTION)

# UI parameters
AKS_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- MAKSO

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _aks_view_framework_macros
_aks_view_framework_macros ::
	@#echo 'AZ::AKS ($(_AZ_AKS_MK_VERSION)) macros:'
	@#echo

_az_view_framework_parameters :: _aks_view_framework_parameters
_aks_view_framework_parameters ::
	@echo 'AZ::AKS ($(_AZ_AKS_MK_VERSION)) parameters:'
	@echo '    AKS_CLIENT_VERSION=$(AKS_CLIENT_VERSION)'
	@echo '    AKS_INSTALL_LOCATION=$(AKS_INSTALL_LOCATION)'
	@echo '    AKS_LOCATION_ID=$(AKS_LOCATION_ID)'
	@echo '    AKS_MODE_NOWAIT=$(AKS_MODE_NOWAIT)'
	@echo '    AKS_MODE_YES=$(AKS_MODE_YES)'
	@echo '    AKS_OUTPUT_FORMAT=$(AKS_OUTPUT_FORMAT)'
	@echo '    AKS_RESOURCEGROUP_NAME=$(AKS_RESOURCEGROUP_NAME)'
	@echo '    AKS_SUBSCRIPTION_ID_OR_NAME=$(AKS_SUBSCRIPTION_ID_OR_NAME)'
	@echo

_az_view_framework_targets :: _aks_view_framework_targets
_aks_view_framework_targets ::
	@echo 'AZ::AKS ($(_AZ_AKS_MK_VERSION)) targets:'
	@echo '    _aks_install_dependencies      - Install dependencies'
	@echo '    _aks_view_k8sversions          - View the available k8s-versions'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/az_aks_cluster.mk
-include $(MK_DIR)/az_aks_kubeconfig.mk
-include $(MK_DIR)/az_aks_nodepool.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_az_install_dependencies :: _aks_install_dependencies
_aks_install_dependencies:
	@$(INFO) '$(AKS_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	$(SUDO) $(AZ) aks install-cli $(__AKS_CLIENT_VERSION) $(__AKS_INSTALL_LOCATION) $(__AKS_SUBSCRIPTION) 
	which kubectl
	kubectl version --client

_aks_view_k8sversions:
	@$(INFO) '$(AKS_UI_LABEL)Showing available versions of kubernetes ...'; $(NORMAL)
	$(AZ) aks get-versions $(__AKS_LOCATION) $(__AKS_OUTPUT) $(__AKS_SUBSCRIPTION)
