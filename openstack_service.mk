_OPENSTACK_SERVICE_MK_VERSION= 0.99.3

# OSSE_SERVICE_ID?= MyService
# OSSE_SERVICE_NAME?= MyService

# Derived parameters

# Option parameters
__OSSE_FORMAT?= $(__OS_FORMAT)
__OSSE_LONG?= --long

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _osse_view_framework_macros
_osse_view_framework_macros ::
	@echo "OpenStack::ServicE ($(_OPENSTACK_SERVICE_MK_VERSION)) macros:"
	@echo

_view_framework_targets :: _osse_view_framework_targets
_osse_view_framework_targets ::
	@echo "OpensStack::ServicE ($(_OPENSTACK_SERVICE_MK_VERSION)) targets:"
	@echo "    _osse_show_services             - Show details of a given service"
	@echo "    _osse_view_catalog              - View available services and their URLs"
	@echo "    _osse_view_services             - View available services"
	@echo

_view_framework_parameters :: _osse_view_framework_parameters
_osse_view_framework_parameters ::
	@echo "OpenStack::ServicE ($(_OPENSTACK_SERVICE_MK_VERSION)) parameters:"
	@echo "    OSSE_SERVICE_ID=$(OSSE_SERVICE_ID)"
	@echo "    OSSE_SERVICE_NAME=$(OSSE_SERVICE_NAME)"
	@echo "    OSSE_SERVICE_NAMEOR_ID=$(OSSE_SERVICE_NAME_OR_ID)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_osse_show_service:
	@$(INFO) "$(OS_UI_LABEL)Show service '$(OSSE_SERVICE_NAME)' ..."; $(NORMAL)
	$(OPENSTACK) service show $(OSSE_SERVICE_NAME)

_osse_view_catalog:
	@$(INFO) "$(OS_UI_LABEL)View service catalog ..."; $(NORMAL)
	$(OPENSTACK) catalog list $(__OSSE_FORMAT) $(_X__LONG)

_osse_view_services:
	@$(INFO) "$(OS_UI_LABEL)View services ..."; $(NORMAL)
	$(OPENSTACK) service list $(__OSSE_FORMAT) $(__OSSE_LONG)
