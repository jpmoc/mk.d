_OPENSTACK_PORT_MK_VERSION= 0.99.3

# OSP_PORT_DEVICE_OWNER?=
# OSP_PORT_ID?= 0f851b52-573d-4e52-ad14-7f3f4c45f5af
# OSP_PORT_FIXED_IP?= subnet=<subnet>,ip-address=<ip-address>
# OSP_PORT_MAC_ADDRESS?= fa:16:3e:25:a9:5a
# OSP_PORT_NAME?=
# OSP_PORT_NAME_OR_ID?=
OSP_PORT_NETWORK?= $(OSN_NETWORK_NAME_OR_ID)
OSP_PORT_PROJECT?= $(OS_PROJECT_NAME_OR_ID)
# OSP_PORT_PROJECT_DOMAIN?= $(OS_PROJECT_DOMAIN)
# OSP_PORT_ROUTER?=
OSP_PORT_SERVER?= $(OSS_SERVER_NAME_OR_ID)

# Derived parameters
OSP_PORT_NAME_OR_ID?= $(strip $(if $(OSP_PORT_ID), $(OSP_PORT_ID), $(OSP_PORT_NAME)))

# Option parameters
__OSP_DEVICE_OWNER?= $(if $(OSP_PORT_DEVICE_OWNER), --device-owner $(OSP_PORT_DEVICE_OWNER))
__OSP_FIT_WIDTH=$(__OS_FIT_WIDTH)
__OSP_FIXED_IP?= $(if $(OSP_PORT_FIXED_IP), --fixed-ip $(OSP_PORT_FIXED_IP))
__OSP_MAC_ADDRESS?= $(if $(OSP_PORT_MAC_ADDRESS), --mac-address $(OSP_PORT_MAC_ADDRESS))
__OSP_NETWORK?= $(if $(OSP_PORT_NETWORK), --network $(OSP_PORT_NETWORK))
__OSP_PROJECT=$(if $(OSP_PORT_PROJECT), --project $(OSP_PORT_PROJECT))
__OSP_PROJECT_DOMAIN=$(if $(OSP_PORT_PROJECT_DOMAIN), --project $(OSP_PORT_PROJECT_DOMAIN))
__OSP_ROUTER=$(if $(OSP_PORT_ROUTER), --router $(OSP_PORT_ROUTER))
__OSP_SERVER=$(if $(OSP_PORT_SERVER), --server $(OSP_PORT_SERVER))

# UI parameters

#--- MACROS
_osp_get_port_id=$(call _osp_list_port_P, ID)
_osp_get_port_id_F=$(call _osp_list_port_FP, $(1), ID)
_osp_get_port_name_I=$(call _osp_show_port_NP, $(1), name)
_osp_list_port_P=$(call _osp_list_port_FP, $(__OSP_NETWORK) $(__OSP_PROJECT) $(__OSP_ROUTER) $(__OSP_SERVER), $(1))
_osp_list_port_FP=$(shell $(OPENSTACK) port list $(1) --column $(2) --format value)
_osp_show_port_NP=$(shell $(OPENSTACK) port show $(1) --column $(2) --format value)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _osp_view_framework_macros
_osp_view_framework_macros ::
	@echo "OpenStack::Port ($(_OPENSTACK_PORT_MK_VERSION)) macros:"
	@echo "    _osp_get_port_id_N          - Get a port ID given its name"
	@echo "    _osp_get_port_name_I        - Get a port name given its ID"
	@echo "    _osp_list_port_{P|FP}       - Get a port parameter based on a filter"
	@echo "    _osp_show_port_NP           - Get a port parameter given its name/ID"
	@echo

_view_framework_parameters :: _osp_view_framework_parameters
_osp_view_framework_parameters ::
	@echo "OpenStack::Port ($(_OPENSTACK_PORT_MK_VERSION)) parameters:"
	@echo "    OSP_PORT_DEVICE_OWNER=$(OSP_PORT_DEVICE_OWNER)"
	@echo "    OSP_PORT_ID=$(OSP_PORT_ID)"
	@echo "    OSP_PORT_FIXED_IP=$(OSP_PORT_FIXED_IP)"
	@echo "    OSP_PORT_MAC_ADDRESS=$(OSP_PORT_MAC_ADDRESS)"
	@echo "    OSP_PORT_NAME=$(OSP_PORT_NAME)"
	@echo "    OSP_PORT_NAME_OR_ID=$(OSP_PORT_NAME_OR_ID)"
	@echo "    OSP_PORT_NETWORK=$(OSP_PORT_NETWORK)"
	@echo "    OSP_PORT_PROJECT=$(OSP_PORT_PROJECT)"
	@echo "    OSP_PORT_PROJECT_DOMAIN=$(OSP_PORT_PROJECT_DOMAIN)"
	@echo "    OSP_PORT_ROUTER=$(OSP_PORT_ROUTER)"
	@echo "    OSP_PORT_SERVER=$(OSP_PORT_SERVER)"
	@echo

_view_framework_targets :: _osp_view_framework_targets
_osp_view_framework_targets ::
	@echo "OpensStack::Port ($(_OPENSTACK_PORT_MK_VERSION)) targets:"
	@echo "    _osp_show_port              - Show details on given port"
	@echo "    _osp_view_ports             - List available ports"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_osp_show_port:
	@$(INFO) "$(OS_UI_LABEL)Show port '$(OSP_PORT_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) port show $(OSP_PORT_NAME_OR_ID)

_osp_view_ports:
	@$(INFO) "$(OS_UI_LABEL)View ports ..."; $(NORMAL)
	$(OPENSTACK) port list --long $(__OSP_DEVICE_OWNER) $(__OSP_FIXED_IP) $(__OSP_FORMAT) $(__OSP_MAC_ADDRESS) $(__OSP_NETWORK) $(__OSP_PROJECT) $(__OSP_PROJECT_DOMAIN) $(__OSP_ROUTER) $(__OSP_SERVER)
