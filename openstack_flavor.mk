_OPENSTACK_FLAVOR_MK_VERSION=0.99.3

OSF_FLAVOR_DISK?= 8
OSF_FLAVOR_EPHEMERAL?= 8
# OSF_FLAVOR_ID?= 07dc1704-4a74-424e-9623-2fe3a0207ebf
# OSF_FLAVOR_NAME?= m1.large
OSF_FLAVOR_RAM?= 512
# OSF_FLAVOR_SWAP?= 8
OSF_FLAVOR_VCPUS?= 1

# Derived parameters
OSF_FLAVOR_NAME_OR_ID?= $(strip $(if $(OSF_FLAVOR_ID), $(OSF_FLAVOR_ID), $(OSF_FLAVOR_NAME)))

# Option parameters
__OSF_DISK?= $(if $(OSF_FLAVOR_DISK), --disk $(OSF_FLAVOR_DISK))
__OSF_EPHEMERAL?= $(if $(OSF_FLAVOR_EPHEMERAL), --ephemeral $(OSF_FLAVOR_EPHEMERAL))
__OSF_RAM?= $(if $(OSF_FLAVOR_RAM), --ram $(OSF_FLAVOR_RAM))
__OSF_SWAP?= $(if $(OSF_FLAVOR_SWAP), --swap $(OSF_FLAVOR_SWAP))
__OSF_VCPUS?= $(if $(OSF_FLAVOR_VCPUS), --vcpus $(OSF_FLAVOR_VCPUS))

#--- MACROS
_osf_get_flavor_id_N=$(call _osf_get_flavor_paramter_NP, $(1), id)
_osf_get_flavor_name_I=$(call _osf_get_flavor_paramter_NP, $(1), name)
_osf_get_flavor_parameter_NP=$(shell $(OPENSTACK) flavor show $(1) --column $(2) --format value)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _osf_view_framework_macros
_osf_view_framework_macros ::
	@echo "OpenStack::Flavor ($(_OPENSTACK_FLAVOR_MK_VERSION)) macros:"
	@echo "    _osf_get_flavor_id_N          - Get the ID of flavor given its name"
	@echo "    _osf_get_flavor_name_I        - Get the name of flavor given its ID"
	@echo "    _osf_get_flavor_parameter_NP  - Get a flavor parameter given its name/ID"
	@echo

_view_framework_parameters :: _osf_view_framework_parameters
_osf_view_framework_parameters ::
	@echo "OpenStack::Flavor ($(_OPENSTACK_FLAVOR_MK_VERSION)) parameters:"
	@echo "    OSF_FLAVOR_DISK=$(OSF_FLAVOR_DISK) (GB)"
	@echo "    OSF_FLAVOR_EPHEMERAL=$(OSF_FLAVOR_EPHEMERAL) (GB)"
	@echo "    OSF_FLAVOR_ID=$(OSF_FLAVOR_ID)"
	@echo "    OSF_FLAVOR_NAME=$(OSF_FLAVOR_NAME)"
	@echo "    OSF_FLAVOR_NAME_OR_ID=$(OSF_FLAVOR_NAME_OR_ID)"
	@echo "    OSF_FLAVOR_RAM=$(OSF_FLAVOR_RAM) (MB)"
	@echo "    OSF_FLAVOR_SWAP=$(OSF_FLAVOR_SWAP) (GB)"
	@echo "    OSF_FLAVOR_VCPUS=$(OSF_FLAVOR_VCPUS)"
	@echo

_view_framework_targets :: _osf_view_framework_targets
_osf_view_framework_targets ::
	@echo "OpensStack::Flavor ($(_OPENSTACK_FLAVOR_MK_VERSION)) targets:"
	@echo "    _osf_create_flavor            - Create a new flavor"
	@echo "    _osf_delete_flavor            - Delete an existing flavor"
	@echo "    _osf_show_flavor              - Show details on given flavor"
	@echo "    _osf_view_flavors             - List available flavors"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_osf_create_flavor:
	@$(INFO) "$(OS_UI_LABEL)Create flavor '$(OSF_FLAVOR_NAME)' ..."; $(NORMAL)
	-$(OPENSTACK) flavor create $(__OSF_DISK) $(__OSF_EPHEMERAL) $(__OSF_RAM) $(__OSF_SWAP) $(__OSF_VCPUS) $(OSF_FLAVOR_NAME)

_osf_delete_flavor:
	@$(INFO) "$(OS_UI_LABEL)Delete flavor '$(OSF_FLAVOR_NAME)' ..."; $(NORMAL)
	$(OPENSTACK) flavor delete $(OSF_FLAVOR_NAME_OR_ID)

_osf_show_flavor:
	@$(INFO) "$(OS_UI_LABEL)Show flavor '$(OSF_FLAVOR_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) flavor show $(OSF_FLAVOR_NAME_OR_ID)

_osf_view_flavors:
	@$(INFO) "$(OS_UI_LABEL)View flavors ..."; $(NORMAL)
	$(OPENSTACK) flavor list
