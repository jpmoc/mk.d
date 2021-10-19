_OPENSTACK_NETWORK_MK_VERSION= 0.99.3

# OSN_NETWORK_EXTERNAL?= true
# OSN_NETWORK_ID?=
# OSN_NETWORK_NAME?=
# OSN_NETWORK_SHARE?= true
# OSN_PROVIDER_NAME_OR_ID?=
# OSN_PROVIDER_NETWORK_TYPE?= vlan
# OSN_PROVIDER_PHYSICAL_NETWORK?= datacenter
# OSN_PROVIDER_SEGMENT?= 195	# VLAN_ID

# Derived parameters
OSN_NETWORK_NAME_OR_ID?= $(if $(OSN_NETWORK_ID),$(OSN_NETWORK_ID),$(OSN_NETWORK_NAME))

# Option parameters
__OSN_EXTERNAL?= $(if $(filter true, $(OSN_NETWORK_EXTERNAL)), --external)
__OSN_PROVIDER_NETWORK_TYPE?= $(if $(OSN_PROVIDER_NETWORK_TYPE), --provider-network-type $(OSN_PROVIDER_NETWORK_TYPE))
__OSN_PROVIDER_PHYSICAL_NETWORK?= $(if $(OSN_PROVIDER_PHYSICAL_NETWORK), --provider-physical-network $(OSN_PROVIDER_PHYSICAL_NETWORK))
__OSN_PROVIDER_SEGMENT?= $(if $(OSN_PROVIDER_SEGMENT), --provider-segment $(OSN_PROVIDER_SEGMENT))
__OSN_SHARE?= $(if $(filter true, $(OSN_NETWORK_SHARE)), --share)

# UI parameters

#--- MACROS
_osn_get_network_id_N=$(call _osn_get_network_parameter_NP, $(1), id)
_osn_get_network_name_N=$(call _osn_get_network_parameter_NP, $(1), name)
_osn_get_subnet_ids_N=$(call _osn_get_network_parameter_NP, $(1), subnets)
_osn_get_network_parameter_NP=$(shell $(OPENSTACK) network show $(1) --column $(2) --format value)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _osn_view_framework_macros
_osn_view_framework_macros ::
	@echo "OpenStack::Network ($(_OPENSTACK_NETWORK_MK_VERSION)) macros:"
	@echo "    _osn_get_network_id_N             - Get the ID of a network given its name"
	@echo "    _osn_get_network_name_I           - Get the name of a network given its ID"
	@echo "    _osn_get_subnet_ids_N             - Get the subnets of a network given its name or ID"
	@echo "    _osn_get_network_parameter_NP     - Get a parameter given a network name/ID"
	@echo

_view_framework_parameters :: _osn_view_framework_parameters
_osn_view_framework_parameters ::
	@echo "OpenStack::Network ($(_OPENSTACK_NETWORK_MK_VERSION)) parameters:"
	@echo "    OSN_NETWORK_EXTERNAL=$(OSN_NETWORK_EXTERNAL)"
	@echo "    OSN_NETWORK_ID=$(OSN_NETWORK_ID)"
	@echo "    OSN_NETWORK_NAME=$(OSN_NETWORK_NAME)"
	@echo "    OSN_NETWORK_NAME_OR_ID=$(OSN_NETWORK_NAME_OR_ID)"
	@echo "    OSN_NETWORK_SHARE=$(OSN_NETWORK_SHARE)"
	@echo "    OSN_PROVIDER_NETWORK_TYPE=$(OSN_PROVIDER_NETWORK_TYPE)"
	@echo "    OSN_PROVIDER_PHYSICAL_NETWORK=$(OSN_PROVIDER_PHYSICAL_NETWORK)"
	@echo "    OSN_PROVIDER_SEGMENT=$(OSN_PROVIDER_SEGMENT)"
	@echo

_view_framework_targets :: _osn_view_framework_targets
_osn_view_framework_targets ::
	@echo "OpensStack::Network ($(_OPENSTACK_NETWORK_MK_VERSION)) targets:"
	@echo "    _osn_create_network               - Create a new network"
	@echo "    _osn_delete_network               - Delete an existing network"
	@echo "    _osn_show_network                 - Show the details of a given network"
	@echo "    _osn_view_networks                - View the list of existing networks"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_osn_create_network:
	@$(INFO) "$(OS_UI_LABEL)Create network '$(OSN_NETWORK_NAME)'..."; $(NORMAL)
	$(OPENSTACK) network create ppppublic $(__OSN_EXTERNAL) $(__OSN_PROVIDER_NETWORK_TYPE) $(__OSN_PROVIDER_PHYCIAL_NETWORK) $(__OSN_PROVIDER_SEGMENT) $(__OSN_SHARE) $(OSN_NETWORK_NAME)

_osn_delete_network:
	@$(INFO) "$(OS_UI_LABEL)Create network '$(OSN_NETWORK_NAME)'..."; $(NORMAL)
	$(OPENSTACK) network delete $(OSN_NETWORK_NAME_OR_ID)

_osn_show_network:
	@$(INFO) "$(OS_UI_LABEL)Show network '$(OSN_NETWORK_NAME_OR_ID)'..."; $(NORMAL)
	$(OPENSTACK) network show $(OSN_NETWORK_NAME_OR_ID)

_osn_view_networks:
	@$(INFO) "$(OS_UI_LABEL)View networks ..."; $(NORMAL)
	$(OPENSTACK) network list
