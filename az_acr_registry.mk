_AZ_ACR_REGISTRY_MK_VERSION= $(_AZ_ACR_MK_VERSION)

# ACR_REGISTRY_ID?= /subscriptions/59b066b1-4bd5-4a01-bbb1-14ee71d3d7fc/resourceGroups/LinuxGroup/providers/Microsoft.Compute/virtualMachines/LinuxB
# ACR_REGISTRY_LOCATION_ID?= westus2
# ACR_REGISTRY_NAME?= Myregistry
# ACR_REGISTRY_RESOURCEGROUP_NAME?= MyResourceGroup
# ACR_REGISTRY_SHOW_DETAILS?= false
# ACR_REGISTRYS_IDS?=
# ACR_REGISTRYS_SET_NAME?=

# Derived parameters
ACR_REGISTRY_LOCATION_ID?= $(ACR_LOCATION_ID)
ACR_REGISTRY_RESOURCEGROUP_NAME?= $(ACR_RESOURCEGROUP_NAME)

# Options parameters
__ACR_ADMIN_ENABLED=
__ACR_DEFAULT_ACTION=
__ACR_IDS__REGISTRY= $(if $(ACR_REGISTRY_ID),--ids $(ACR_REGISTRY_ID))
__ACR_IDS__REGISTRYS= $(if $(ACR_REGISTRYS_IDS),--ids $(ACR_REGISTRYS_IDS))
__ACR_LOCATION__REGISTRY= $(if $(ACR_REGISTRY_LOCATION_ID),--location $(ACR_REGISTRY_LOCATION_ID))
__ACR_NAME__REGISTRY= $(if $(ACR_REGISTRY_NAME),--name $(ACR_REGISTRY_NAME))
__ACR_REGISTRY_GROUP__REGISTRY= $(if $(ACR_REGISTRY_REGISTRYGROUP_NAME),--registry-group $(ACR_REGISTRY_REGISTRYGROUP_NAME))
__ACR_SKU= $(if $(ACR_REGISTRY_SKU),--sku $(ACR_REGISTRY_SKU))
__ACR_TAGS__REGISTRY=

# UI parameters

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_acr_view_framework_macros ::
	@echo 'AZ::ACR::Registry ($(_AZ_ACR_REGISTRY_MK_VERSION)) macros:'
	@echo

_acr_view_framework_parameters ::
	@echo 'AZ::ACR::Registry ($(_AZ_ACR_REGISTRY_MK_VERSION)) parameters:'
	@echo '    ACR_REGISTRY_DELETE_NOWAIT=$(ACR_REGISTRY_DELETE_NOWAIT)'
	@echo '    ACR_REGISTRY_DELETE_YES=$(ACR_REGISTRY_DELETE_YES)'
	@echo '    ACR_REGISTRY_ID=$(ACR_REGISTRY_ID)'
	@echo '    ACR_REGISTRY_LOCATION_ID=$(ACR_REGISTRY_LOCATION_ID)'
	@echo '    ACR_REGISTRY_NAME=$(ACR_REGISTRY_NAME)'
	@echo '    ACR_REGISTRY_SKU=$(ACR_REGISTRY_SKU)'
	@echo '    ACR_REGISTRYS_IDS=$(ACR_REGISTRYS_IDS)'
	@echo '    ACR_REGISTRYS_SET_NAME=$(ACR_REGISTRYS_SET_NAME)'
	@echo

_acr_view_framework_targets ::
	@echo 'AZ::ACR::Registry ($(_AZ_ACR_REGISTRY_MK_VERSION)) targets:'
	@echo '    _acr_check_registry                 - Check health of a registry'
	@echo '    _acr_create_registry                - Create a registry'
	@echo '    _acr_delete_registry                - Delete a registry'
	@echo '    _acr_login_registry                 - Delete a registry'
	@echo '    _acr_show_registry                  - Show everything related to a registry'
	@echo '    _acr_show_registry_description      - Show description of a registry'
	@echo '    _acr_show_registry_usage            - Show usage of a registry'
	@echo '    _acr_view_registries                - View registries'
	@echo '    _acr_view_registries_set            - View a set of registries'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_acr_check_registry:
	@$(INFO) '$(ACR_UI_LABEL)Checking health of registry "$(ACR_REGISTRY_NAME)" ...'; $(NORMAL)

_acr_create_registry:
	@$(INFO) '$(ACR_UI_LABEL)Creating registry "$(ACR_REGISTRY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if a registry with the same name already exists'; $(NORMAL)
	$(AZ) acr create $(__ACR_NAME__REGSITRY) $(__ACR_REGISTRY_GROUP__REGISTRY) $(__ACR_SKU)

_acr_delete_registry:
	@$(INFO) '$(ACR_UI_LABEL)Deleting registry "$(ACR_REGISTRY_NAME)" ...'; $(NORMAL)
	$(AZ) acr delete $(__ACR_NAME__REGISTRY) $(__ACR_RESOURCE_GROUP__REGISTRY)

_acr_login_registry:
	@$(INFO) '$(ACR_UI_LABEL)Login in registry "$(ACR_REGISTRY_NAME)" ...'; $(NORMAL)

_acr_show_registry :: _acr_show_registry_usage _acr_show_registry_description

_acr_show_registry_description:
	@$(INFO) '$(ACR_UI_LABEL)Showing description of registry "$(ACR_REGISTRY_NAME)" ...'; $(NORMAL)
	$(AZ) acr show $(___ACR_GLOBALS) $(__ACR_IDS__REGISTRY) $(__ACR_NAME__REGISTRY) $(__ACR_RESOURCE_GROUP__REGISTRY) $(__ACR_SHOW_DETAILS) 

_acr_show_registry_usage:
	@$(INFO) '$(ACR_UI_LABEL)Showing usage of registry "$(ACR_REGISTRY_NAME)" ...'; $(NORMAL)
	$(AZ) acr show-usage $(___ACR_GLOBALS) $(__ACR_NAME__REGISTRY) $(__ACR_RESOURCE_GROUP)

_acr_view_registries:
	@$(INFO) '$(ACR_UI_LABEL)Viewing registries ...'; $(NORMAL)
	$(AZ) acr list $(___ACR_GLOBALS) $(_X__ACR_RESOURCE_GROUP)

_acr_view_registries_set:
	@$(INFO) '$(ACR_UI_LABEL)Viewing registries-set "$(ACR_REGISTRYS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Registries are grouped based on resource-group and query-filter'; $(NORMAL)
	$(AZ) acr list $(__ACR_RESOURCE_GROUP)
