_VMC_VDP_ORGANIZATIOM_MK_VERSION= $(_VMC_VDP_MK_VERSION)

# VDP_ORGANIZATION_NAME?= 
# VDP_ORGANIZATION_OUTPUT?= json

# Derived variables
VDP_ORGANIZATION_OUTPUT= $(VDP_OUTPUT)

# Option variables
__VDP_OUTPUT__ORGANIZATION?= $(if $(VDP_ORGANIZATION_OUTPUT),-o $(VDP_ORGANIZATION_OUTPUT))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vdp_view_framework_macros ::
	@#echo 'VmwareClouD::VDP::Organization ($(_VMC_VDP_ORGANIZATIOM_MK_VERSION)) macros:'
	@#echo

_vdp_view_framework_parameters ::
	@echo 'VmwareClouD::VDP::Organization ($(_VMC_VDP_ORGANIZATIOM_MK_VERSION)) parameters:'
	@echo '    VDP_ORGANIZATION_NAME=$(VDP_ORGANIZATION_NAME)'
	@echo '    VDP_ORGANIZATION_OUTPUT=$(VDP_ORGANIZATION_OUTPUT)'
	@echo

_vdp_view_framework_targets ::
	@echo 'VmwareClouD::VDP::Organization ($(_VMC_VDP_ORGANIZATIOM_MK_VERSION)) targets:'
	@echo '    _vdp_create_organization                  - Create a new organization'
	@echo '    _vdp_delete_organization                  - Delete an existing organization'
	@echo '    _vdp_show_organization                    - Show everything related to a organization'
	@echo '    _vdp_show_organization_description        - Show description of an organization'
	@echo '    _vdp_show_organization_tree               - Show the tree of an organization'
	@echo '    _vdp_view_organization                    - View organization'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vdp_create_organization:
	@#$(INFO) '$(VDP_UI_LABEL)Creating organization "$(VDP_ORGANIZATION_NAME)" ...'; $(NORMAL)

_vdp_delete_organization:
	@#$(INFO) '$(VDP_UI_LABEL)Deleting organization "$(VDP_ORGANIZATION_NAME)" ...'; $(NORMAL)

_vdp_show_organization: _vdp_show_organization_tree _vdp_show_organization_description

_vdp_show_organization_description:
	@$(INFO) '$(VDP_UI_LABEL)Showing description of organization "$(VDP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	$(VDP) org get $(__VDP_OUTPUT__ORGANIZATION)

_vdp_show_organization_tree:
	@$(INFO) '$(VDP_UI_LABEL)Showing organization "$(VDP_ORGANIZATION_NAME)" ...'; $(NORMAL)
	$(VDP) org tree

_vdp_view_organizations:
	@#$(INFO) '$(VDP_UI_LABEL)Viewing organizations ...'; $(NORMAL)
