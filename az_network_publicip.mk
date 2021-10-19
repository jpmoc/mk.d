_AZ_NETWORK_PUBLICIP_MK_VERSION= $(_AZ_NETWORK_MK_VERSION)

# NWK_PUBLICIP_ID?= 
# NWK_PUBLICIP_NAME?= LinuxBVMNic
# NWK_PUBLICIP_NIC_NAME?=
# NWK_PUBLICIP_RESOURCEGROUP_NAME?=
# NWK_PUBLICIPS_IDS?=
# NWK_PUBLICIPS_RESOURCEGROUP_NAME?=
# NWK_PUBLICIPS_SET_NAME?=

# Derived parameters
NWK_PUBLICIP_NIC_NAME?= $(NWK_NIC_NAME)
NWK_PUBLICIP_RESOURCEGROUP_NAME?= $(NWK_RESOURCEGROUP_NAME)
NWK_PUBLICIPS_RESOURCEGROUP_NAME?= $(NWK_PUBLICIP_RESOURCEGROUP_NAME)
NWK_PUBLICIPS_SET_NAME?= public-ips@$(NWK_PUBLICIPS_RESOURCEGROUP_NAME)

# Options parameters
__NWK_IDS__PUBLICIP= $(if $(NWK_PUBLICIP_ID),--ids $(NWK_PUBLICIP_ID))
__NWK_IDS__PUBLICIPS= $(if $(NWK_PUBLICIPS_IDS),--ids $(NWK_PUBLICIPS_IDS))
__NWK_NAME__PUBLICIP= $(if $(NWK_PUBLICIP_NAME),--name $(NWK_PUBLICIP_NAME))
__NWK_RESOURCE_GROUP__PUBLICIP= $(if $(NWK_PUBLICIP_RESOURCEGROUP_NAME),--resource-group $(NWK_PUBLICIP_RESOURCEGROUP_NAME))
__NWK_RESOURCE_GROUP__PUBLICIPS= $(if $(NWK_PUBLICIPS_RESOURCEGROUP_NAME),--resource-group $(NWK_PUBLICIPS_RESOURCEGROUP_NAME))

# UI parameters

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_nwk_view_framework_macros ::
	@#echo 'AZ::NetWorK::PublicIp ($(_AZ_NETWORK_PUBLICIP_MK_VERSION)) macros:'
	@#echo

_nwk_view_framework_parameters ::
	@echo 'AZ::NetWorK::PublicIp ($(_AZ_NETWORK_PUBLICIP_MK_VERSION)) parameters:'
	@echo '    NWK_PUBLICIP_ID=$(NWK_PUBLICIP_ID)'
	@echo '    NWK_PUBLICIP_NAME=$(NWK_PUBLICIP_NAME)'
	@echo '    NWK_PUBLICIP_NIC_NAME=$(NWK_PUBLICIP_NIC_NAME)'
	@echo '    NWK_PUBLICIP_RESOUCEGROUP_NAME=$(NWK_PUBLICIP_RESOURCEGROUP_NAME)'
	@echo '    NWK_PUBLICIPS_IDS=$(NWK_PUBLICIPS_IDS)'
	@echo '    NWK_PUBLICIPS_RESOURCEGROUP_NAME=$(NWK_PUBLICIPS_RESOURCEGROUP_NAME)'
	@echo '    NWK_PUBLICIPS_SET_NAME=$(NWK_PUBLICIPS_SET_NAME)'
	@echo

_nwk_view_framework_targets ::
	@echo 'AZ::NetWork::PublicIp ($(_AZ_NETWORK_PUBLICIP_MK_VERSION)) targets:'
	@echo '    _nwk_create_publicip               - Create a public-ip'
	@echo '    _nwk_delete_publicip               - Delete a public-ip'
	@echo '    _nwk_show_publicip                 - Show everything related to a public-ip'
	@echo '    _nwk_show_publicip_description     - Show description of a public-ip'
	@echo '    _nwk_show_publicip_nic             - Show netwokr-interface of a public-ip'
	@echo '    _nwk_show_publicip_object          - Show object of a public-ip'
	@echo '    _nwk_view_publicips                - View public-ips'
	@echo '    _nwk_view_publicips_set            - View set of public-ips'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_nwk_create_publicip:
	@$(INFO) '$(NWK_UI_LABEL)Creating public-ip "$(NWK_PUBLICIP_NAME)" ...'; $(NORMAL)

_nwk_delete_publicip:
	@$(INFO) '$(NWK_UI_LABEL)Deleting public-ip "$(NWK_PUBLICIP_NAME)" ...'; $(NORMAL)

_nwk_show_publicip :: _nwk_show_publicip_nic _nwk_show_publicip_object _nwk_show_publicip_description

_nwk_show_publicip_description:
	@$(INFO) '$(NWK_UI_LABEL)Showing description of public-ip "$(NWK_PUBLICIP_NAME)" ...'; $(NORMAL)
	$(AZ) network public-ip show $(__NWK_EXPAND) $(__NWK_IDS__PUBLICIP) $(__NWK_NAME__PUBLICIP) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__PUBLICIP) $(__NWK_SUBSCRIPTION)

_nwk_show_publicip_nic:
	@$(INFO) '$(NWK_UI_LABEL)Showing network-interface with public-ip "$(NWK_PUBLICIP_NAME)" ...'; $(NORMAL)
	$(if $(NWK_PUBLICIP_NIC_NAME), \
		$(AZ) network nic show --name $(NWK_PUBLICIP_NIC_NAME) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__PUBLICIP) $(__NWK_SUBSCRIPTION) \
	, @\
		echo 'NWK_PUBLICIP_NIC_NAME not set'; \
	)

_nwk_show_publicip_object:
	@$(INFO) '$(NWK_UI_LABEL)Showing object of public-ip "$(NWK_PUBLICIP_NAME)" ...'; $(NORMAL)
	$(AZ) network public-ip show $(__NWK_EXPAND) $(__NWK_IDS__PUBLICIP) $(__NWK_NAME__PUBLICIP) $(_X__NWK_OUTPUT) --output json $(__NWK_RESOURCE_GROUP__PUBLICIP) $(__NWK_SUBSCRIPTION)

_nwk_view_publicips:
	@$(INFO) '$(NWK_UI_LABEL)View public-ips ...'; $(NORMAL)
	$(AZ) network public-ip list $(__NWK_OUTPUT) $(_X__NWK_RESOURCE_GROUP__PUBLICIPS) $(__NWK_SUBSCRIPTION)

_nwk_view_publicips_set:
	@$(INFO) '$(NWK_UI_LABEL)View public-ips-set "$(NWK_PUBLICIPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Public-ips are grouped based on provided resource-group, ...'; $(NORMAL)
	$(AZ) network public-ip list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__PUBLICIPS) $(__NWK_SUBSCRIPTION)
