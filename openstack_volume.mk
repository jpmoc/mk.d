_OPENSTACK_VOLUME_MK_VERSION= 0.99.3

# NVA_VOLUME_

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _osv_view_framework_macros
_osv_view_framework_macros ::
	@echo "OpenStack::Volume ($(_OPENSTACK_VOLUME_MK_VERSION)) macros:"
	@echo

_view_framework_parameters :: _osv_view_framework_parameters
_osv_view_framework_parameters ::
	@echo "OpenStack::Volume ($(_OPENSTACK_VOLUME_MK_VERSION)) parameters:"
	@echo

_view_framework_targets :: _osv_view_framework_targets
_osv_view_framework_targets ::
	@echo "OpensStack::Volume ($(_OPENSTACK_VOLUME_MK_VERSION)) targets:"
	@echo "    _osv_view_volumes         - View the list of volumes"
	@echo "    _osv_view_volume_types    - View the list of volume-types"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_osv_view_volumes:
	@$(INFO) "$(OS_UI_LABEL)View volumes ..."; $(NORMAL)
	$(OPENSTACK) volume list

_osv_view_volume_types:
	@$(INFO) "$(OS_UI_LABEL)View volume types ..."; $(NORMAL)
	$(OPENSTACK) volume type list
