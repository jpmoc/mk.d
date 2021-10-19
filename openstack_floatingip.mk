_OPENSTACK_FLOATINGIP_MK_VERSION=0.99.3

# OSFI_FLOATIP_FIXED_IP_ADDRESS?=
# OSFI_FLOATIP_ID?= fd64ce54-0d93-4874-8e78-84337e6d908b
# OSFI_FLOATIP_NAME?= 136.179.34.26
# OSFI_FLOATIP_NETWORK?=
OSFI_FLOATIP_PORT?= $(OSP_PORT_NAME_OR_ID)
OSFI_FLOATIP_PROJECT?= $(OS_PROJECT_NAME_OR_ID)
# OSFI_FLOATIP_PROJECT_DOMAIN?=
# OSFI_FLOATIP_ROUTER?=
# OSFI_FLOATIP_STATUS?=

OSFI_FLOATIP_NAME_OR_ID?= $(strip $(if $(OSFI_FLOATIP_ID), $(OSFI_FLOATIP_ID), $(OSFI_FLOATIP_NAME)))

__OSFI_FIT_WIDTH?= $(__OS_FIT_WIDTH)
__OSFI_LONG?= --long
__OSFI_NETWORK?= $(if $(OSFI_FLOATIP_NETWORK), --network $(OSFI_FLOATIP_NETWORK))
__OSFI_PORT?= $(if $(OSFI_FLOATIP_PORT), --port $(OSFI_FLOATIP_PORT))
__OSFI_PROJECT?= $(if $(OSFI_FLOATIP_PROJECT), --project $(OSFI_FLOATIP_PROJECT))
__OSFI_PROJECT_DOMAIN?= $(if $(OSFI_FLOATIP_PROJECT_DOMAIN), --project-domain $(OSFI_FLOATIP_PROJECT_DOMAIN))
__OSFI_ROUTER?= $(if $(OSFI_FLOATIP_ROUTER), --router $(OSFI_FLOATIP_ROUTER))
__OSFI_STATUS?= $(if $(OSFI_FLOATIP_STATUS), --status $(OSFI_FLOATIP_STATUS))

#--- MACROS
# I couldn't find any other way to do that!
_osfi_get_floatip_id=$(shell neutron floatingip-list --format json | jq -r '.[]|select(.floating_ip_address=="136.179.34.26").id')
_osfi_get_floatip_id_N=$(shell neutron floatingip-list --format json | jq -r '.[]|select(.floating_ip_address=="$(strip $(1))").id')
# _osfi_get_floatip_id=$(call _osfi_list_floatip_P, ID)
# _osfi_get_floatip_id_F=$(call _osfi_list_floatip_FP, $(1), ID)
# _osfi_get_floatip_name_I=$(call _osfi_show_floatip_NP, $(1), name)
# _osfi_list_floatip_P=$(call _osfi_list_floatip_FP, $(__OSP_PROJECT), $(1))
# _osfi_list_floatip_FP=$(shell $(OPENSTACK) floatip list $(1) --column $(2) --format value)
# _osfi_show_floatip_NP=$(shell $(OPENSTACK) floatip show $(1) --column $(2) --format value)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _osfi_view_framework_macros
_osfi_view_framework_macros ::
	@echo "OpenStack::FloatingIp ($(_OPENSTACK_FLOATINGIP_MK_VERSION)) macros:"
	@echo

_view_framework_parameters :: _osfi_view_framework_parameters
_osfi_view_framework_parameters ::
	@echo "OpenStack::FloatingIp ($(_OPENSTACK_FLOATINGIP_MK_VERSION)) parameters:"
	@echo "    OSFI_FLOATIP_ID=$(OSFI_FLOATIP_ID)"
	@echo "    OSFI_FLOATIP_NAME=$(OSFI_FLOATIP_NAME)"
	@echo "    OSFI_FLOATIP_NETWORK=$(OSFI_FLOATIP_NETWORK)"
	@echo "    OSFI_FLOATIP_PORT=$(OSFI_FLOATIP_PORT)"
	@echo "    OSFI_FLOATIP_PROJECT=$(OSFI_FLOATIP_PROJECT)"
	@echo "    OSFI_FLOATIP_PROJECT_DOMAIN=$(OSFI_FLOATIP_PROJECT_DOMAIN)"
	@echo "    OSFI_FLOATIP_ROUTER=$(OSFI_FLOATIP_ROUTER)"
	@echo "    OSFI_FLOATIP_STATUS=$(OSFI_FLOATIP_STATUS)"
	@echo

_view_framework_targets :: _osfi_view_framework_targets
_osfi_view_framework_targets ::
	@echo "OpensStack::FloatingIp ($(_OPENSTACK_FLOATINGIP_MK_VERSION)) targets:"
	@echo "    _osfi_attach_floatingip         - Attach floating IP to interface/port"
	@echo "    _osfi_detach_floatingip         - Detach floating IP from interface/port"
	@echo "    _osfi_show_floatingip           - Show details of a given floating ip"
	@echo "    _osfi_view_floatingips          - View available floating ips"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_osfi_attach_floatingip:
	@$(INFO) "$(OS_UI_LABEL)Associate floating-IP '$(OSFI_FLOATIP_NAME_OR_ID)' ..."; $(NORMAL)
	@$(WARN) "Floating IP: $(OSFI_FLOATIP_ID) == $(OSFI_FLOATIP_NAME)"; $(NORMAL)
	@$(WARN) "Port ID: $(OSFI_FLOATIP_PORT)"; $(NORMAL)
	$(NEUTRON) floatingip-associate $(__OSFI_FIXED_IP_ADDRESS) $(OSFI_FLOATIP_ID) $(OSFI_FLOATIP_PORT)

_osfi_detach_floatingip:
	@$(INFO) "$(OS_UI_LABEL)Diassociating floating-IP '$(OSFI_FLOATIP_NAME_OR_ID)' ..."; $(NORMAL)
	@$(WARN) "Floating IP: $(OSFI_FLOATIP_ID) == $(OSFI_FLOATIP_NAME)"; $(NORMAL)
	$(NEUTRON) floatingip-disassociate $(OSFI_FLOATIP_NAME_OR_ID)

_osfi_show_floatingip:
	@$(INFO) "$(OS_UI_LABEL)Show floating-IP '$(OSFI_FLOATIP_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) floating ip show $(OSFI_FLOATIP_NAME_OR_ID)

_osfi_view_floatingips:
	@$(INFO) "$(OS_UI_LABEL)View floating-IPs ..."; $(NORMAL)
	$(OPENSTACK) floating ip list $(__OSFI_FIT_WIDTH) $(__OSFI_LONG) $(__OSFI_NETWORK) $(__OSFI_PORT) $(__OSFI_PROJECT) $(__OSFI_PROJECT_DOMAIN) $(__OSFI_ROUTER) $(__OSFI_STATUS)
