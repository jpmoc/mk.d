_AZ_GROUP_RESOURCEGROUP_MK_VERSION= $(_AZ_GROUP_MK_VERSION)

# GRP_RESOURCEGROUP_ID?= /subscriptions/<subscriptionid>/resourcegroups/my-resource-group
# GRP_RESOURCEGROUP_LOCATION_ID?= westus2
# GRP_RESOURCEGROUP_MODE_NOWAIT?= false
# GRP_RESOURCEGROUP_MODE_YES?=
# GRP_RESOURCEGROUP_NAME?= my-resource-group
# GRP_RESOURCEGROUP_SUBSCRIPTION_ID?=
# GRP_RESOURCEGROUP_TAGS_KEYVALUES?=
# GRP_RESOURCEGROUP_TEMPLATE_DIRPATH?=
# GRP_RESOURCEGROUP_TEMPLATE_FILENAME?=
# GRP_RESOURCEGROUP_TEMPLATE_FILEPATH?=
# GRP_RESOURCEGROUP_WAIT_EVENT?= created
# GRP_RESOURCEGROUPS_SET_NAME?= my-resource-group-set

# Derived parameters
GRP_RESOURCEGROUP_ID?= /subscriptions/$(GRP_RESOURCEGROUP_SUBSCRIPTION_ID)/resourcegroups/$(GRP_RESOURCEGROUP_NAME)
GRP_RESOURCEGROUP_LOCATION_ID?= $(GRP_LOCATION_ID)
GRP_RESOURCEGROUP_MODE_NOWAIT?= $(GRP_MODE_NOWAIT)
GRP_RESOURCEGROUP_MODE_YES?= $(GRP_MODE_YES)
GRP_RESOURCEGROUP_NAME?= $(AZ_RESOURCEGROUP_NAME)
GRP_RESOURCEGROUP_SUBSCRIPTION_ID?= $(GRP_SUBSCRIPTION_ID)
GRP_RESOURCEGROUP_TEMPLATE_DIRPATH?= $(GRP_OUTPUTS_DIRPATH)
GRP_RESOURCEGROUP_TEMPLATE_FILENAME?= $(GRP_RESOURCEGROUP_NAME).json
GRP_RESOURCEGROUP_TEMPLATE_FILEPATH?= $(GRP_RESOURCEGROUP_TEMPLATE_DIRPATH)$(GRP_RESOURCEGROUP_TEMPLATE_FILENAME)

# Options parameters
__GRP_CREATED= $(if $(filter created, $(GRP_RESOURCEGROUP_WAIT_EVENT)),--created)
__GRP_DELETED= $(if $(filter deleted, $(GRP_RESOURCEGROUP_WAIT_EVENT)),--deleted)
__GRP_EXISTS= $(if $(filter deleted, $(GRP_RESOURCEGROUP_WAIT_EVENT)),--deleted)
__GRP_INCLUDE_COMMENTS=
__GRP_INCLUDE_PARAMETER_DEFAULT_VALUE=
__GRP_LOCATION= $(if $(GRP_RESOURCEGROUP_LOCATION_ID),--location $(GRP_RESOURCEGROUP_LOCATION_ID))
__GRP_NAME__RESOURCEGROUP= $(if $(GRP_RESOURCEGROUP_NAME),--name $(GRP_RESOURCEGROUP_NAME))
__GRP_NO_WAIT__RESOURCEGROUP= $(if $(filter true, $(GRP_RESOURCEGROUP_MODE_NOWAIT)),--no-wait)
# __GRP_OUTPUT?=
__GRP_RESOURCE_GROUP__RESOURCEGROUP= $(if $(GRP_RESOURCEGROUP_NAME),--resource-group $(GRP_RESOURCEGROUP_NAME))
__GRP_TAGS= $(if $(GRP_RESOURCEGROUP_TAGS_KEYVALUES),--tags $(GRP_RESOURCEGROUP_TAGS_KEYVALUES))
__GRP_UPDATED= $(if $(filter updated, $(GRP_RESOURCEGROUP_WAIT_EVENT)),--updated)
__GRP_YES__RESOURCEGROUP= $(if $(filter false, $(GRP_RESOURCEGROUP_MODE_YES)),--yes)

# Pipe
|_GRP_EXPORT_RESOURCEGROUP?= | tee $(GRP_RESOURCEGROUP_TEMPLATE_FILEPATH)

# UI parameters

#--- Utilities

#--- MACRO
_grp_get_resourcegroup_id= $(call _grp_get_resourcegroup_id_N, $(GRP_RESOURCEGROUP_NAME))
_grp_get_resourcegroup_id_N= $(call _grp_get_resourcegroup_id_NS, $(1), $(GRP_RESOURCEGROUP_SUBSCRIPTION_ID))
_grp_get_resourcegroup_id_NS= $(shell echo '/subscriptions/$(strip $(2))/resourcegroups/$(strip $(1))')

#----------------------------------------------------------------------
# USAGE
#

_grp_view_framework_macros ::
	@echo 'AZ::GRouP::ResourceGroup ($(_AZ_GROUP_RESOURCEGROUP_MK_VERSION)) macros:'
	@echo '    _grp_get_resourcegroup_id_{|N|NS}   - Get the id of a resource-group (Name,Subscription)'
	@echo

_grp_view_framework_parameters ::
	@echo 'AZ::Group::ResourceGroup ($(_AZ_GROUP_RESOURCEGROUP_MK_VERSION)) parameters:'
	@echo '    GRP_RESOURCEGROUP_DELETE_CONFIRM=$(GRP_RESOURCEGROUP_DELETE_CONFIRM)'
	@echo '    GRP_RESOURCEGROUP_DELETE_NOWAIT=$(GRP_RESOURCEGROUP_DELETE_NOWAIT)'
	@echo '    GRP_RESOURCEGROUP_ID=$(GRP_RESOURCEGROUP_ID)'
	@echo '    GRP_RESOURCEGROUP_LOCATION_ID=$(GRP_RESOURCEGROUP_LOCATION_ID)'
	@echo '    GRP_RESOURCEGROUP_MODE_NOWAIT=$(GRP_RESOURCEGROUP_MODE_NOWAIT)'
	@echo '    GRP_RESOURCEGROUP_MODE_YES=$(GRP_RESOURCEGROUP_MODE_YES)'
	@echo '    GRP_RESOURCEGROUP_NAME=$(GRP_RESOURCEGROUP_NAME)'
	@echo '    GRP_RESOURCEGROUP_SUBSCRIPTION_ID=$(GRP_RESOURCEGROUP_SUBSCRIPTION_ID)'
	@echo '    GRP_RESOURCEGROUP_TAGS_KEYVALUES=$(GRP_RESOURCEGROUP_TAGS_KEYVALUES)'
	@echo '    GRP_RESOURCEGROUP_TEMPLATE_DIRPATH=$(GRP_RESOURCEGROUP_TEMPLATE_DIRPATH)'
	@echo '    GRP_RESOURCEGROUP_TEMPLATE_FILENAME=$(GRP_RESOURCEGROUP_TEMPLATE_FILENAME)'
	@echo '    GRP_RESOURCEGROUP_TEMPLATE_FILEPATH=$(GRP_RESOURCEGROUP_TEMPLATE_FILEPATH)'
	@echo '    GRP_RESOURCEGROUP_WAIT_EVENT=$(GRP_RESOURCEGROUP_WAIT_EVENT)'
	@echo '    GRP_RESOURCEGROUPS_SET_NAME=$(GRP_RESOURCEGROUPS_SET_NAME)'
	@echo

_grp_view_framework_targets ::
	@echo 'AZ::Group::ResourceGroup ($(_AZ_GROUP_RESOURCEGROUP_MK_VERSION)) targets:'
	@echo '    _grp_check_resourcegroup                  - Check existence of a resource-group'
	@echo '    _grp_create_resourcegroup                 - Create a resource-group'
	@echo '    _grp_delete_resourcegroup                 - Delete a resource-group'
	@echo '    _grp_export_resourcegroup                 - Export resources in a resource-group'
	@echo '    _grp_show_resourcegroup                   - Show everything related to a resource-group'
	@echo '    _grp_show_resourcegroup_acrs              - Show container-registries in a resource-group'
	@echo '    _grp_show_resourcegroup_aks               - Show kubernetes-clusters in a resource-group'
	@echo '    _grp_show_resourcegroup_disks             - Show disks in a resource-group'
	@echo '    _grp_show_resourcegroup_description       - Show description of a resource-group'
	@echo '    _grp_show_resourcegroup_gateways          - Show vnet-gateways in a resource-group'
	@echo '    _grp_show_resourcegroup_lbs               - Show load-balancers in a resource-group'
	@echo '    _grp_show_resourcegroup_nics              - Show NICs in a resource-group'
	@echo '    _grp_show_resourcegroup_object            - Show the object of a resource-group'
	@echo '    _grp_show_resourcegroup_privatednszones   - Show private-dns-zones in a resource-group'
	@echo '    _grp_show_resourcegroup_publicips         - Show public-IPs in a resource-group'
	@echo '    _grp_show_resourcegroup_resources         - Show the resources in a resource-group'
	@echo '    _grp_show_resourcegroup_routetables       - Show the route-tables in a resource-group'
	@echo '    _grp_show_resourcegroup_securitygroups    - Show the security-groups in a resource-group'
	@echo '    _grp_show_resourcegroup_vms               - Show virtual-machines in a resource-group'
	@echo '    _grp_show_resourcegroup_vnets             - Show virtual-networks in a resource-group'
	@echo '    _grp_show_resourcegroup_vrouters          - Show virtual-routers in a resource-group'
	@echo '    _grp_view_resourcegroups                  - View resource-groups'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_grp_check_resourcegroup:
	@$(INFO) '$(GRP_UI_LABEL)Checking existence of resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) group exists $(__GRP_NAME__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_create_resourcegroup:
	@$(INFO) '$(GRP_UI_LABEL)Creating resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a resource-group only if its name is not already used'; $(NORMAL)
	$(AZ) group create $(__GRP_LOCATION) $(__GRP_NAME__RESOURCEGROUP) $(__GRP_OUTPUT) $(__GRP_SUBSCRIPTION) $(__GRP_TAGS)

_grp_delete_resourcegroup:
	@$(INFO) '$(GRP_UI_LABEL)Deleting resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation identifies in the subscription the to-be-deleted resource-group based on its name'; $(NORMAL)
	$(AZ) group delete $(__GRP_NAME__RESOURCEGROUP) $(__GRP_NO_WAIT__RESOURCEGROUP) $(__GRP_OUTPUT) $(__GRP_SUBSCRIPTION) $(__GRP_YES__RESOURCEGROUP)

_grp_export_resourcegroup:
	@$(INFO) '$(GRP_UI_LABEL)Export resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) group export $(__GRP_INCLUDE_COMMENTS) $(__GRP_INCLUDE_PARAMETER_DEFAULT_VALUE) $(__GRP_NAME__RESOURCEGROUP) $(_X__GRP_OUTPUT) --output json $(__GRP_SUBSCRIPTION) $(|_GRP_EXPORT_RESOURCEGROUP)

_grp_show_resourcegroup :: _grp_show_resourcegroup_locks _grp_show_resourcegroup_object _grp_show_resourcegroup_resources _grp_show_resourcegroup_description

_grp_show_resourcegroup_acrs:
	@$(INFO) '$(GRP_UI_LABEL)Showing ACRs in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) acr list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_aks:
	@$(INFO) '$(GRP_UI_LABEL)Showing AKS-clusters in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) aks list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_description:
	@$(INFO) '$(GRP_UI_LABEL)Showing description of resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) group show $(__GRP_OUTPUT) $(__GRP_NAME__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_disks:
	@$(INFO) '$(GRP_UI_LABEL)Showing disks in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) disk list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_gateways:
	@$(INFO) '$(GRP_UI_LABEL)Showing vnet-gateways in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) network vnet-gateway list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_loadbalancers:
	@$(INFO) '$(GRP_UI_LABEL)Showing load-balancers in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) network lb list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_locks:
	@$(INFO) '$(GRP_UI_LABEL)Showing locks in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) group lock list  $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION) 

_grp_show_resourcegroup_nics:
	@$(INFO) '$(GRP_UI_LABEL)Showing NICs in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) network nic list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_object:
	@$(INFO) '$(GRP_UI_LABEL)Showing the object of resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) group show $(__GRP_NAME__RESOURCEGROUP) $(_X__GRP_OUTPUT) --output json $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_privatednszones:
	@$(INFO) '$(GRP_UI_LABEL)Showing private-dns-zones in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) network private-dns zone list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_publicips:
	@$(INFO) '$(GRP_UI_LABEL)Showing public-IPs in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) network public-ip list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_routetables:
	@$(INFO) '$(GRP_UI_LABEL)Showing route-tables in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) network route-table list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_securitygroups::
	@$(INFO) '$(GRP_UI_LABEL)Showing security-groups in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) network nsg list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_subnets:
	@$(INFO) '$(GRP_UI_LABEL)Showing subnets in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	# To identitify he subnets in the resource-group, query the individual vnets

_grp_show_resourcegroup_resources :: _grp_show_resourcegroup_acrs _grp_show_resourcegroup_aks _grp_show_resourcegroup_disks _grp_show_resourcegroup_gateways _grp_show_resourcegroup_loadbalancers _grp_show_resourcegroup_nics _grp_show_resourcegroup_privatednszones _grp_show_resourcegroup_publicips _grp_show_resourcegroup_routetables _grp_show_resourcegroup_securitygroups _grp_show_resourcegroup_subnets _grp_show_resourcegroup_vms _grp_show_resourcegroup_vmsss _grp_show_resourcegroup_vnets _grp_show_resourcegroup_vrouters

_grp_show_resourcegroup_vms:
	@$(INFO) '$(GRP_UI_LABEL)Showing VMs in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) vm list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_vmsss:
	@$(INFO) '$(GRP_UI_LABEL)Showing VM-scale-sets in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) vmss list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_vnets:
	@$(INFO) '$(GRP_UI_LABEL)Showing VNETs in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) network vnet list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION)

_grp_show_resourcegroup_vrouters:
	@$(INFO) '$(GRP_UI_LABEL)Showing virtual-routers in resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) network vrouter list $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__RESOURCEGROUP) $(__GRP_SUBSCRIPTION) 

_grp_update_resourcegroup:
	@$(INFO) '$(GRP_UI_LABEL)Updating resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	# To be implemented!

_grp_view_resourcegroups:
	@$(INFO) '$(GRP_UI_LABEL)Viewing resource-groups ...'; $(NORMAL)
	$(AZ) group list $(__GRP_OUTPUT) $(__GRP_SUBSCRIPTION)

_grp_view_resourcegroups_set:
	@$(INFO) '$(GRP_UI_LABEL)Viewing resource-groups-set "$(GRP_RESOURCEGROUPS_SET_NAME) ...'; $(NORMAL)
	# To be implemented!

_grp_wait_resourcegroup:
	@$(INFO) '$(GRP_UI_LABEL)Waiting for resource-group "$(GRP_RESOURCEGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) wait $(__GRP_CREATED) $(__GRP_CUSTOM) $(__GRP_DELETED) $(__GRP_EXISTS) $(__GRP_INTERVAL) $(__GRP_NAME__RESOURCEGROUP) $(__GRP_SUBSCRIPTION) $(__GRP_TIMEOUT) $(__GRP_UPDATED)
