_AZ_NETWORK_LOADBALANCER_MK_VERSION= $(_AZ_NETWORK_MK_VERSION)

# NWK_LOADBALANCER_BACKENDPOOL_NAME?=
# NWK_LOADBALANCER_ID?= /subscriptions/59b066b1-4bd5-4a01-bbb1-14ee71d3d7fc/resourceGroups/LinuxGroup/providers/Microsoft.Network/networkInterfaces/LinuxBVMNic
# NWK_LOADBALANCER_FRONTENDIP_NAME?=
# NWK_LOADBALANCER_NAME?=
# NWK_LOADBALANCER_PUBLICIP_NAME?= myPublicIP
# NWK_LOADBALANCER_RESOURCEGROUP_NAME?=
# NWK_LOADBALANCER_SUBNET_NAME?=
# NWK_LOADBALANCER_VNET_NAME?=
# NWK_LOADBALANCERS_IDS?=
# NWK_LOADBALANCERS_RESOURCEGROUP_NAME?=
# NWK_LOADBALANCERS_SET_NAME?=

# Derived parameters
# NWK_LOADBALANCER_ID?= /subscriptions/$(NWK_SUBSCRIPTION_ID)/resourceGroups/$(NWK_RESOURCEGROUP_NAME)/providers/Microsoft.Network/
NWK_LOADBALANCER_PUBLICIP_NAME?= $(NWK_PUBLICIP_NAME)
NWK_LOADBALANCER_RESOURCEGROUP_NAME?= $(NWK_RESOURCEGROUP_NAME)
NWK_LOADBALANCER_SUBNET_NAME?= $(NWK_SUBNET_NAME)
NWK_LOADBALANCER_VNET_NAME?= $(NWK_VNET_NAME)
NWK_LOADBALANCERS_RESOURCEGROUP_NAME?= $(NWK_LOADBALANCER_RESOURCEGROUP_NAME)
NWK_LOADBALANCERS_SET_NAME?= load-balancers@$(NWK_LOADBALANCERS_RESOURCEGROUP_NAME)

# Options parameters
__NWK_BACKEND_POOL_NAME=
__NWK_FRONTEND_IP_NAME=
__NWK_IDS__LOADBALANCER= $(if $(NWK_LOADBALANCER_ID),--ids $(NWK_LOADBALANCER_ID))
__NWK_IDS__LOADBALANCERS= $(if $(NWK_LOADBALANCERS_IDS),--ids $(NWK_LOADBALANCERS_IDS))
__NWK_LB_NAME__LOADBALANCER= $(if $(NWK_LOADBALANCER_NAME),--lb-name $(NWK_LOADBALANCER_NAME))
__NWK_NAME__LOADBALANCER= $(if $(NWK_LOADBALANCER_NAME),--name $(NWK_LOADBALANCER_NAME))
__NWK_PUBLIC_IP_ADDRESS__LOADBALANCER= $(if $(NWK_LOADBALANCER_PUBLICIP_NAME),--public-ip-address $(NWK_LOADBALANCER_PUBLICIP_NAME))
__NWK_RESOURCE_GROUP__LOADBALANCER= $(if $(NWK_LOADBALANCER_RESOURCEGROUP_NAME),--resource-group $(NWK_LOADBALANCER_RESOURCEGROUP_NAME))
__NWK_RESOURCE_GROUP__LOADBALANCERS= $(if $(NWK_LOADBALANCERS_RESOURCEGROUP_NAME),--resource-group $(NWK_LOADBALANCERS_RESOURCEGROUP_NAME))
__NWK_VNET_NAME__LOADBALANCER= $(if $(NWK_LOADBALANCER_VNET_NAME),--vnet-name $(NWK_LOADBALANCER_VNET_NAME))

# UI parameters

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_nwk_view_framework_macros ::
	@#echo 'AZ::NetWorK::LoadBalancer ($(_AZ_NETWORK_LOADBALANCER_MK_VERSION)) macros:'
	@#echo

_nwk_view_framework_parameters ::
	@echo 'AZ::NetWorK::LoadBalancer ($(_AZ_NETWORK_LOADBALANCER_MK_VERSION)) parameters:'
	@echo '    NWK_LOADBALANCER_ID=$(NWK_LOADBALANCER_ID)'
	@echo '    NWK_LOADBALANCER_NAME=$(NWK_LOADBALANCER_NAME)'
	@echo '    NWK_LOADBALANCER_PUBLICIP_NAME=$(NWK_LOADBALANCER_PUBLICIP_NAME)'
	@echo '    NWK_LOADBALANCER_RESOUCEGROUP_NAME=$(NWK_LOADBALANCER_RESOURCEGROUP_NAME)'
	@echo '    NWK_LOADBALANCER_SUBNET_NAME=$(NWK_LOADBALANCER_SUBNET_NAME)'
	@echo '    NWK_LOADBALANCER_VNET_NAME=$(NWK_LOADBALANCER_VNET_NAME)'
	@echo '    NWK_LOADBALANCERS_IDS=$(NWK_LOADBALANCERS_IDS)'
	@echo '    NWK_LOADBALANCERS_RESOURCEGROUP_NAME=$(NWK_LOADBALANCERS_RESOURCEGROUP_NAME)'
	@echo '    NWK_LOADBALANCERS_SET_NAME=$(NWK_LOADBALANCERS_SET_NAME)'
	@echo

_nwk_view_framework_targets ::
	@echo 'AZ::NetWork::LoadBalancer ($(_AZ_NETWORK_LOADBALANCER_MK_VERSION)) targets:'
	@echo '    _nwk_create_loadbalancer               - Create a load-balancer'
	@echo '    _nwk_delete_loadbalancer               - Delete a load-balancer'
	@echo '    _nwk_show_loadbalancer                 - Show everything related to a load-balancer'
	@echo '    _nwk_show_loadbalancer_backend         - Show backend of a load-balancer'
	@echo '    _nwk_show_loadbalancer_description     - Show description of a load-balancer'
	@echo '    _nwk_show_loadbalancer_frontend        - Show frontend of a load-balancer'
	@echo '    _nwk_show_loadbalancer_object          - Show object of a load-balancer'
	@echo '    _nwk_show_loadbalancer_probes          - Show probes of a load-balancer'
	@echo '    _nwk_show_loadbalancer_publicip        - Show public-ip of a load-balancer'
	@echo '    _nwk_show_loadbalancer_rules           - Show rules of a load-balancer'
	@echo '    _nwk_show_loadbalancer_subnet          - Show subnet of a load-balancer'
	@echo '    _nwk_show_loadbalancer_vnet            - Show vnet of a load-balancer'
	@echo '    _nwk_view_loadbalancers                - View load-balancers'
	@echo '    _nwk_view_loadbalancers_set            - View set of load-balancers'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_nwk_create_loadbalancer:
	@$(INFO) '$(NWK_UI_LABEL)Creating load-balancer "$(NWK_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AZ) network lb create $(__NWK_BACKEND_POOL_NAME) $(__NWK_FRONTEND_IP_NAME) $(__NWK_NAME__LOADBALANCER) $(__NWT_OUTPUT) $(__NWT_PUBLIC_IP_ADDRESS__LOADBALANCER) $(__NWK_RESOURCE_GROUP__LOADBALANCER) $(__NW_SUBSCRIPTION)

_nwk_delete_loadbalancer:
	@$(INFO) '$(NWK_UI_LABEL)Deleting load-balancer "$(NWK_LOADBALANCER_NAME)" ...'; $(NORMAL)

_nwk_show_loadbalancer :: _nwk_show_loadbalancer_backend _nwk_show_loadbalancer_certificate _nwk_show_loadbalancer_frontend _nwk_show_loadbalancer_object _nwk_show_loadbalancer_probes _nwk_show_loadbalancer_publicip _nwk_show_loadbalancer_rules _nwk_show_loadbalancer_subnet _nwk_show_loadbalancer_vnet _nwk_show_loadbalancer_description

_nwk_show_loadbalancer_backend:
	@$(INFO) '$(NWK_UI_LABEL)Showing backend of load-balancer "$(NWK_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AZ) network lb show $(__NWK_EXPAND) $(__NWK_IDS__LOADBALANCER) $(__NWK_NAME__LOADBALANCER) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__LOADBALANCER) $(__NWK_SUBSCRIPTION) --query "@.backendAddressPools[]"
	$(AZ) network lb show $(__NWK_EXPAND) $(__NWK_IDS__LOADBALANCER) $(__NWK_NAME__LOADBALANCER) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__LOADBALANCER) $(__NWK_SUBSCRIPTION) --query "@.backendAddressPools[].backendIpConfigurations[].id"

_nwk_show_loadbalancer_certificate:
	@$(INFO) '$(NWK_UI_LABEL)Showing certificate of load-balancer "$(NWK_LOADBALANCER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The Azure load-balancer is layer 4 balancer. It can balance TCP/UDP traffic, but not terminate a SSL connection'; $(NORMAL)

_nwk_show_loadbalancer_description:
	@$(INFO) '$(NWK_UI_LABEL)Showing description of load-balancer "$(NWK_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AZ) network lb show $(__NWK_EXPAND) $(__NWK_IDS__LOADBALANCER) $(__NWK_NAME__LOADBALANCER) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__LOADBALANCER) $(__NWK_SUBSCRIPTION)

_nwk_show_loadbalancer_frontend:
	@$(INFO) '$(NWK_UI_LABEL)Showing frontend of load-balancer "$(NWK_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AZ) network lb show $(__NWK_EXPAND) $(__NWK_IDS__LOADBALANCER) $(__NWK_NAME__LOADBALANCER) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__LOADBALANCER) $(__NWK_SUBSCRIPTION) --query "@.frontendIpConfigurations"

_nwk_show_loadbalancer_object:
	@$(INFO) '$(NWK_UI_LABEL)Showing object of load-balancer "$(NWK_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AZ) network lb show $(__NWK_EXPAND) $(__NWK_IDS__LOADBALANCER) $(__NWK_NAME__LOADBALANCER) $(_X__NWK_OUTPUT) --output json $(__NWK_RESOURCE_GROUP__LOADBALANCER) $(__NWK_SUBSCRIPTION)

_nwk_show_loadbalancer_probes:
	@$(INFO) '$(NWK_UI_LABEL)Showing probes of load-balancer "$(NWK_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AZ) network lb probe list $(__NWK_LB_NAME__LOADBALANCER) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__LOADBALANCER) $(__NWK_SUBSCRIPTION)

_nwk_show_loadbalancer_publicip:
	@$(INFO) '$(NWK_UI_LABEL)Showing public-ip of load-balancer "$(NWK_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(if $(NWK_LOADBALANCER_PUBLICIP_NAME), \
		$(AZ) network public-ip show --name $(NWK_LOADBALANCER_PUBLICIP_NAME) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__LOADBALANCER) $(__NWK_SUBSCRIPTION) \
	, @\
		echo 'NWK_LOADBALANCER_PUBLICIP_NAME not set'; \
	)

_nwk_show_loadbalancer_rules:
	@$(INFO) '$(NWK_UI_LABEL)Showing load-balancing rules of load-balancer "$(NWK_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(AZ) network lb show  $(__NWK_NAME__LOADBALANCER) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__LOADBALANCER) $(__NWK_SUBSCRIPTION) --query "@.loadBalancingRules"

_nwk_show_loadbalancer_subnet:
	@$(INFO) '$(NWK_UI_LABEL)Showing subnet of load-balancer "$(NWK_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(if $(NWK_LOADBALANCER_SUBNET_NAME), \
		$(AZ) network vnet subnet show  --name $(NWK_LOADBALANCER_SUBNET_NAME) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__LOADBALANCER) $(__NWK_SUBSCRIPTION) $(__NWK_VNET_NAME__LOADBALANCER) \
	, @\
		echo 'NWK_LOADBALANCER_SUBNET_NAME not set'; \
	)

_nwk_show_loadbalancer_vnet:
	@$(INFO) '$(NWK_UI_LABEL)Showing virtual-network of load-balancer "$(NWK_LOADBALANCER_NAME)" ...'; $(NORMAL)
	$(if $(NWK_LOADBALANCER_VNET_NAME), \
		$(AZ) network vnet show  --name $(NWK_LOADBALANCER_VNET_NAME) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__LOADBALANCER) $(__NWK_SUBSCRIPTION) \
	, @\
		echo 'NWK_LOADBALANCER_VNET_NAME not set'; \
	)

_nwk_view_loadbalancers:
	@$(INFO) '$(NWK_UI_LABEL)Viewing load-balancers ...'; $(NORMAL)
	$(AZ) network lb list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__LOADBALANCERS) $(__NWK_SUBSCRIPTION)

_nwk_view_loadbalancers_set:
	@$(INFO) '$(NWK_UI_LABEL)Viewing load-balancers-set "$(NWK_LOADBALANCERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Load-balancers are grouped based on the provided resource-group, ...'; $(NORMAL)
	$(AZ) network lb list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__LOADBALANCERS) $(__NWK_SUBSCRIPTION)
