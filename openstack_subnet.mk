_OPENSTACK_SUBNET_MK_VERSION= 0.99.3

# OSST_SUBNET_ALLOCATION_POOL_START?=
# OSST_SUBNET_ALLOCATION_POOL_END?=
# OSST_SUBNET_DESCRIPTION?=
OSST_SUBNET_DHCP?=true
# OSST_SUBNET_DNS_NAMESERVER?=
# OSST_SUBNET_GATEWAY?= 192.168.9.1
# OSST_SUBNET_HOST_ROUTES+= destination=10.10.0.0/16,gateway=192.168.71.254
# OSST_SUBNET_ID?=
# OSST_SUBNET_IP_VERSION?=4
# OSST_SUBNET_NAME?=
OSST_SUBNET_NETWORK?= $(OSN_NETWORK_NAME_OR_ID)
# OSST_SUBNET_TAGS+=

# Derived parameters
OSST_SUBNET_ALLOCATION_POOL?= $(if $(OSST_SUBNET_ALLOCATION_POOL_START), start=$(OSST_SUBNET_ALLOCATION_POOL_START)$(COMMA)end=$(OSST_SUBNET_ALLOCATION_POOL_END))
OSST_SUBNET_NAME_OR_ID?= $(if $(OSST_SUBNET_ID),$(OSST_SUBNET_ID),$(OSST_SUBNET_NAME))

# Option parameters
__OSST_ALLOCATION_POOL?= $(if $(OSST_SUBNET_ALLOCATION_POOL), --allocation-pool $(OSST_SUBNET_ALLOCATION_POOL))
__OSST_DESCRIPTION?= $(if $(OSST_SUBNET_DESCRIPTION), --description $(OSST_DESCRIPTION))
__OSST_DHCP?= $(if $(filter true, $(OSST_SUBNET_DHCP)), --dhcp, --no-dhcp)
__OSST_DNS_NAMESERVER?= $(if $(OSST_SUBNET_DNS_NAMESERVER), --dns-nameserver $(OSST_SUBNET_DNS_NAME_SERVER))
__OSST_GATEWAY?= $(if $(OSST_SUBNET_GATEWAY), --gateway $(OSST_SUBNET_GATEWAY))
__OSST_HOST_ROUTE?= $(foreach R, $(OSST_SUBNET_HOST_ROUTE), --host-route $(R))
__OSST_IP_VERSION?= $(if $(OSST_SUBNET_IP_VERSION), --ip-version $(OSST_SUBNET_IP_VERSION))
__OSST_NETWORK?= $(if $(OSST_SUBNET_NETWORK), --network $(OSST_SUBNET_NETWORK))
__OSST_TAG?= $(foreach T, $(OSST_SUBNET_TAGS), --tag $(T))

# UI parameters

#--- MACROS
_osst_get_subnet_id_N=$(call _osst_get_subnet_parameter_NP, $(1), ID)
_osst_get_subnet_name_I=$(call _osst_get_subnet_parameter_NP, $(1), name)
_osst_get_subnet_parameter_NP=$(shell $(OPENSTACK) subnet show $(1) --column $(2) --format value)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _osst_view_framework_macros
_osst_view_framework_macros ::
	@echo "OpenStack::SubneT ($(_OPENSTACK_SUBNET_MK_VERSION)) macros:"
	@echo "    _osst_get_subnet_id_N          - Get a subnet ID given its name"
	@echo "    _osst_get_subnet_name_I        - Get a subnet name given its ID"
	@echo "    _osst_get_subnet_paramter_NP   - Get a subnet parameter given its name/id and paramter name"
	@echo

_view_framework_parameters :: _osst_view_framework_parameters
_osst_view_framework_parameters ::
	@echo "OpenStack::SubneT ($(_OPENSTACK_SUBNET_MK_VERSION)) parameters:"
	@echo "    OSST_SUBNET_ALLOCATION_POOL=$(OSST_SUBNET_ALLOCATION_POOL)"
	@echo "    OSST_SUBNET_DESCRIPTION=$(OSST_SUBNET_DESCRIPTION)"
	@echo "    OSST_SUBNET_DNS_NAMESERVER=$(OSST_SUBNET_DNS_NAMESERVER)"
	@echo "    OSST_SUBNET_DHCP=$(OSST_SUBNET_DHCP)"
	@echo "    OSST_SUBNET_GATEWAY=$(OSST_SUBNET_GATEWAY)"
	@echo "    OSST_SUBNET_HOST_ROUTES=$(OSST_SUBNET_HOST_ROUTES)"
	@echo "    OSST_SUBNET_ID=$(OSST_SUBNET_ID)"
	@echo "    OSST_SUBNET_IP_VERSION=$(OSST_SUBNET_IP_VERSION)"
	@echo "    OSST_SUBNET_NAME=$(OSST_SUBNET_NAME)"
	@echo "    OSST_SUBNET_NAME_OR_ID=$(OSST_SUBNET_NAME_OR_ID)"
	@echo "    OSST_SUBNET_NETWORK=$(OSST_SUBNET_NETWORK)"
	@echo "    OSST_SUBNET_TAGS=$(OSST_SUBNET_TAGS)"
	@echo

_view_framework_targets :: _osst_view_framework_targets
_osst_view_framework_targets ::
	@echo "OpensStack::SubneT ($(_OPENSTACK_SUBNET_MK_VERSION)) targets:"
	@echo "    _osst_create_subnet            - Create a new subnet"
	@echo "    _osst_delete_subnet            - Delete an existing subnet"
	@echo "    _osst_show_subnet              - Show details of a given subnet"
	@echo "    _osst_view_subnets             - View the list of existing subnets"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_osst_create_subnet:
	@$(INFO) "$(OS_UI_LABEL)Creating subnet '$(OSST_SUBNET_NAME)'..."; $(NORMAL)
	$(OPENSTACK) subnet create $(__OSST_ALLOCATION_POOL) $(__OSST_DNS_NAMESERVER) $(__OSST_GATEWAY) $(__OSST_HOST_ROUTE) $(__OSST_IP_VERSION) $(__OSST_NETWORK) $(__OSST_TAG) $(OSST_SUBNET_NAME)

_osst_delete_subnet:
	@$(INFO) "$(OS_UI_LABEL)Deleting existing subnet '$(OSST_SUBNET_NAME_OR_ID)'..."; $(NORMAL)
	$(OPENSTACK) subnet delete $(OSST_SUBNET_NAME_OR_ID)

_osst_show_subnet:
	@$(INFO) "$(OS_UI_LABEL)Show subnet '$(OSST_SUBNET_NAME_OR_ID)'..."; $(NORMAL)
	$(OPENSTACK) subnet show $(OSST_SUBNET_NAME_OR_ID)

_osst_view_subnets:
	@$(INFO) "$(OS_UI_LABEL)View subnets ..."; $(NORMAL)
	$(OPENSTACK) subnet list $(__OSST_NETWORK)
