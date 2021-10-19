_OPENSTACK_ROUTER_MK_VERSION= 0.99.3

# OSR_ROUTER_DISABLE?= true
# OSR_ROUTER_ENABLE?= true
# OSR_ROUTER_ID?=
# OSR_ROUTER_NAME?=
# OSR_ROUTER_NAME_OR_ID?=
OSR_ROUTER_PROJECT?= $(OS_PROJECT_NAME_OR_ID)
# OS_ROUTER_PROJECT_DOMAIN?= 
# OS_ROUTERS_SET_NAME?= my-routers-set

# Derived parameters
OSR_ROUTER_NAME_OR_ID?= $(strip $(if $(OSR_ROUTER_ID), $(OSR_ROUTER_ID), $(OSR_ROUTER_NAME)))

# Options parameters
__OSR_DISABLE?= $(if $(filter true, $(OSR_ROUTER_DISABLE)), --disable)
__OSR_ENABLE?= $(if $(filter true, $(OSR_ROUTER_ENABLE)), --enable)
__OSR_FIT_WIDTH?= $(__OS_FIT_WIDTH)
__OSR_LONG?= --long
__OSR_NAME?= $(if $(OSR_ROUTER_NAME), --name $(OSR_ROUTER_NAME))
__OSR_PROJECT?=$(if $(OSR_ROUTER_PROJECT), --project $(OSR_ROUTER_PROJECT))
__OSR_PROJECT_DOMAIN?=$(if $(OSR_ROUTER_PROJECT_DOMAIN), --project-domain $(OSR_ROUTER_PROJECT_DOMAIN))

# UI parameters

#--- MACROS
_osr_get_router_id=$(call _osr_list_router_FP, $(__OSR_PROJECT) $(__OSR_PROJECT_DOMAIN), ID)
_osr_get_router_id_F=$(call _osr_list_router_FP, $(1), ID)
_osr_list_router_FP=$(shell  $(OPENSTACK) router list $(1) --column $(2) --format value)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _osr_view_framework_macros
_osr_view_framework_macros ::
	@echo "OpenStack::Router ($(_OPENSTACK_ROUTER_MK_VERSION)) macros:"
	@echo

_view_framework_parameters :: _osr_view_framework_parameters
_osr_view_framework_parameters ::
	@echo "OpenStack::Router ($(_OPENSTACK_ROUTER_MK_VERSION)) parameters:"
	@echo "    OSR_ROUTER_DISABLE=$(OSR_ROUTER_DISABLE)"
	@echo "    OSR_ROUTER_ENABLE=$(OSR_ROUTER_ENABLE)"
	@echo "    OSR_ROUTER_ID=$(OSR_ROUTER_ID)"
	@echo "    OSR_ROUTER_NAME=$(OSR_ROUTER_NAME)"
	@echo "    OSR_ROUTER_NAME_OR_ID=$(OSR_ROUTER_NAME_OR_ID)"
	@echo "    OSR_ROUTER_PROJECT=$(OSR_ROUTER_PROJECT)"
	@echo "    OSR_ROUTER_PROJECT_DOMAIN=$(OSR_ROUTER_PROJECT_DOMAIN)"
	@echo "    OSR_ROUTERS_SET_NAME=$(OSR_ROUTERS_SET_NAME)"
	@echo

_view_framework_targets :: _osr_view_framework_targets
_osr_view_framework_targets ::
	@echo "OpensStack::Router ($(_OPENSTACK_ROUTER_MK_VERSION)) targets:"
	@echo "    _osr_show_router              - Show details of a given router"
	@echo "    _osr_view_routers             - View the list of existing routers"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_osr_show_router:
	@$(INFO) "$(OS_UI_LABEL)Show router '$(OSR_ROUTER_NAME_OR_ID)'..."; $(NORMAL)
	$(OPENSTACK) router show $(__OSR_FIT_WIDTH) $(OSR_ROUTER_NAME_OR_ID)

_osr_view_routers:
	@$(INFO) "$(OS_UI_LABEL)View routers ..."; $(NORMAL)
	$(OPENSTACK) router list $(_X__OSR_DISABLE) $(_X__OSR_ENABLE) $(_X__OSR_FIT_WIDTH) $(_X__OSR_LONG) $(_X__OSR_NAME) $(_X__OSR_PROJECT) $(_X__OSR_PROJECT_DOMAIN)

_osr_view_routers_set:
	@$(INFO) '$(OS_UI_LABEL)View routers-set "$(OSR_ROUTERS_SET_NAME)" ...'; $(NORMAL)
	$(OPENSTACK) router list $(__OSR_DISABLE) $(__OSR_ENABLE) $(__OSR_FIT_WIDTH) $(__OSR_LONG) $(__OSR_NAME) $(__OSR_PROJECT) $(__OSR_PROJECT_DOMAIN)
