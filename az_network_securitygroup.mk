_AZ_NETWORK_SECURITYGROUP_MK_VERSION= $(_AZ_NETWORK_MK_VERSION)

# NWK_SECURITYGROUP_ID?= /subscriptions/59b066b1-4bd5-4a01-bbb1-14ee71d3d7fc/resourceGroups/LinuxGroup/providers/Microsoft.Network/networkInterfaces/LinuxBVMNic
# NWK_SECURITYGROUP_NAME?= LinuxBVMNic
# NWK_SECURITYGROUP_RESOURCEGROUP_NAME?=
# NWK_SECURITYGROUPS_IDS?=
# NWK_SECURITYGROUPS_RESOURCEGROUP_NAME?=
# NWK_SECURITYGROUPS_SET_NAME?= security-groups@resourcegroup

# Derived parameters
NWK_SECURITYGROUP_RESOURCEGROUP_NAME?= $(NWK_RESOURCEGROUP_NAME)
NWK_SECURITYGROUPS_RESOURCEGROUP_NAME?= $(NWK_SECURITYGROUP_RESOURCEGROUP_NAME)
NWK_SECURITYGROUPS_SET_NAME?= security-groups@$(NWK_SECURITYGROUPS_RESOURCEGROUP_NAME)

# Options parameters
__NWK_IDS__SECURITYGROUP= $(if $(NWK_SECURITYGROUP_ID),--ids $(NWK_SECURITYGROUP_ID))
__NWK_IDS__SECURITYGROUPS= $(if $(NWK_SECURITYGROUPS_IDS),--ids $(NWK_SECURITYGROUPS_IDS))
__NWK_NAME__SECURITYGROUP= $(if $(NWK_SECURITYGROUP_NAME),--name $(NWK_SECURITYGROUP_NAME))
__NWK_RESOURCE_GROUP__SECURITYGROUP= $(if $(NWK_SECURITYGROUP_RESOURCEGROUP_NAME),--resource-group $(NWK_SECURITYGROUP_RESOURCEGROUP_NAME))
__NWK_RESOURCE_GROUP__SECURITYGROUPS= $(if $(NWK_SECURITYGROUPS_RESOURCEGROUP_NAME),--resource-group $(NWK_SECURITYGROUPS_RESOURCEGROUP_NAME))

# UI parameters
NWK_UI_SHOW_SECURITYGROUP_FIELDS?= # .{name:name,location:location,macAddress:macAddress,enableAcceleratedNetworking:enableAcceleratedNetworking,enableIpForwarding:enableIpForwarding,provisioningState:provisioningState,privateIpAddress:ipConfigurations[0].privateIpAddress}
NWK_UI_VIEW_SECURITYGROUPS_FIELDS?= # .{name:name,location:location,resourceGroup:resourceGroup,privateIpAddress:ipConfigurations[0].privateIpAddress}
NWK_UI_VIEW_SECURITYGROUPS_SET_FIELDS?= $(NWK_UI_SHOW_SECURITYGROUP_FIELDS)

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_nwk_view_framework_macros ::
	@#echo 'AZ::NetWorK ($(_AZ_NETWORK_MK_VERSION)) macros:'
	@#echo

_nwk_view_framework_parameters ::
	@echo 'AZ::NetWorK::SECURITYGROUP ($(_AZ_NETWORK_SECURITYGROUP_MK_VERSION)) parameters:'
	@echo '    NWK_SECURITYGROUP_ID=$(NWK_SECURITYGROUP_ID)'
	@echo '    NWK_SECURITYGROUP_NAME=$(NWK_SECURITYGROUP_NAME)'
	@echo '    NWK_SECURITYGROUP_RESOUCEGROUP_NAME=$(NWK_SECURITYGROUP_RESOURCEGROUP_NAME)'
	@echo '    NWK_SECURITYGROUPS_IDS=$(NWK_SECURITYGROUPS_IDS)'
	@echo '    NWK_SECURITYGROUPS_RESOURCEGROUP_NAME=$(NWK_SECURITYGROUPS_RESOURCEGROUP_NAME)'
	@echo '    NWK_SECURITYGROUPS_SET_NAME=$(NWK_SECURITYGROUPS_SET_NAME)'
	@echo

_nwk_view_framework_targets ::
	@echo 'AZ::NetWork::SECURITYGROUP ($(_AZ_NETWORK_SECURITYGROUP_MK_VERSION)) targets:'
	@echo '    _nwk_create_securitygroup               - Create a security-group'
	@echo '    _nwk_delete_securitygroup               - Delete a security-group'
	@echo '    _nwk_show_securitygroup                 - Show everything related to a security-group'
	@echo '    _nwk_show_securitygroup_description     - Show description of a security-group'
	@echo '    _nwk_show_securitygroup_nics            - Show nics using a security-group'
	@echo '    _nwk_show_securitygroup_object          - Show object for a security-group'
	@echo '    _nwk_show_securitygroup_rules           - Show rules in a security-group'
	@echo '    _nwk_view_securitygroups                - View security-groups'
	@echo '    _nwk_view_securitygroups_set            - View set of security-groups'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_nwk_create_securitygroup:
	@$(INFO) '$(NWK_UI_LABEL)Creating security-group "$(NWK_SECURITYGROUP_NAME)" ...'; $(NORMAL)

_nwk_delete_securitygroup:
	@$(INFO) '$(NWK_UI_LABEL)Deleting security-group "$(NWK_SECURITYGROUP_NAME)" ...'; $(NORMAL)

_nwk_show_securitygroup :: _nwk_show_securitygroup_nics _nwk_show_securitygroup_object _nwk_show_securitygroup_rules _nwk_show_securitygroup_description

_nwk_securitygroup_customrules:
	@$(INFO) '$(NWK_UI_LABEL)Showing custom-rules for security-group "$(NWK_SECURITYGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Custom-rules with higher priority override the default-rules'; $(NORMAL)
	$(AZ) network nsg show $(__NWK_EXPAND) $(__NWK_IDS__SECURITYGROUP) $(__NWK_NAME__SECURITYGROUP) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__SECURITYGROUP) $(__NWK_SUBSCRIPTION) --query "@.securityRules"

_nwk_securitygroup_defaultrules:
	@$(INFO) '$(NWK_UI_LABEL)Showing default-rules for security-group "$(NWK_SECURITYGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Custom-rules with higher priority override the default-rules'; $(NORMAL)
	$(AZ) network nsg show $(__NWK_EXPAND) $(__NWK_IDS__SECURITYGROUP) $(__NWK_NAME__SECURITYGROUP) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__SECURITYGROUP) $(__NWK_SUBSCRIPTION) --query "@.defaultSecurityRules"

_nwk_show_securitygroup_description:
	@$(INFO) '$(NWK_UI_LABEL)Showing description of security-group "$(NWK_SECURITYGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) network nsg show $(__NWK_EXPAND) $(__NWK_IDS__SECURITYGROUP) $(__NWK_NAME__SECURITYGROUP) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__SECURITYGROUP) $(__NWK_SUBSCRIPTION) --query "@$(NWK_UI_SHOW_SECURITYGROUP_FIELDS)"

_nwk_show_securitygroup_nics:
	@$(INFO) '$(NWK_UI_LABEL)Showing network-interfaces of security-group "$(NWK_SECURITYGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) network nsg show $(__NWK_EXPAND) $(__NWK_IDS__SECURITYGROUP) $(__NWK_NAME__SECURITYGROUP) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__SECURITYGROUP) $(__NWK_SUBSCRIPTION) --query "@.networkInterfaces"

_nwk_show_securitygroup_object:
	@$(INFO) '$(NWK_UI_LABEL)Showing object of security-group "$(NWK_SECURITYGROUP_NAME)" ...'; $(NORMAL)
	$(AZ) network nsg show $(__NWK_EXPAND) $(__NWK_IDS__SECURITYGROUP) $(__NWK_NAME__SECURITYGROUP) $(_X__NWK_OUTPUT) --output json $(__NWK_RESOURCE_GROUP__SECURITYGROUP) $(__NWK_SUBSCRIPTION)

_nwk_show_securitygroup_rules: _nwk_securitygroup_defaultrules _nwk_securitygroup_customrules

_nwk_view_securitygroups:
	@$(INFO) '$(NWK_UI_LABEL)View security-groups ...'; $(NORMAL)
	$(AZ) network nsg list $(__NWK_OUTPUT) $(_X__NWK_RESOURCE_GROUP__SECURITYGROUPS) $(__NWK_SUBSCRIPTION) --query "@[]$(NWK_UI_VIEW_SECURITYGROUPS_FIELDS)"

_nwk_view_securitygroups_set:
	@$(INFO) '$(NWK_UI_LABEL)View security-groups-set "$(NWK_SECURITYGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Security-groups are grouped based on the resource-group'; $(NORMAL)
	$(AZ) network nsg list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__SECURITYGROUPS) $(__NWK_SUBSCRIPTION) --query "@[]$(NWK_UI_VIEW_SECURITYGROUPS_SET_FIELDS)"
