_VMC_VDP_PROJECT_MK_VERSION= $(_VMC_VDP_MK_VERSION)

# VDP_PROJECT_NAME?= myproject
# VDP_PROJECT_ORGANIZATION_NAME?= myproject

# Derived variables
VDP_PROJECT_NAME?= $(VDP_PROJECT) # From Environment !
VDP_PROJECT_ORGANIZATION_NAME?= $(VDP_ORGANIZATION_NAME)

# Option variables
__VDP_ORG__PROJECT?= $(if $(VDP_PROJECT_ORGANIZATION_NAME),--org $(VDP_PROJECT_ORGANIZATION_NAME))


# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vdp_view_framework_macros ::
	@#echo 'VMwareCloud::VDP::Project ($(_VMC_VDP_PROJECT_MK_VERSION)) macros:'
	@#echo

_vdp_view_framework_parameters ::
	@echo 'VMwareCloud::VDP::Project ($(_VMC_VDP_PROJECT_MK_VERSION)) parameters:'
	@echo '    VDP_PROJECT_NAME=$(VDP_PROJECT_NAME)'
	@echo '    VDP_PROJECT_ORGANIZATION_NAME=$(VDP_PROJECT_ORGANIZATION_NAME)'
	@echo

_vdp_view_framework_targets ::
	@echo 'VMwareCloud::VDP::Project ($(_VMC_VDP_PROJECT_MK_VERSION)) targets:'
	@echo '    _vdp_create_project                  - Create a new project'
	@echo '    _vdp_delete_project                  - Delete an existing project'
	@echo '    _vdp_edit_project                    - Edit a project'
	@echo '    _vdp_show_project                    - Show everything related to a project'
	@echo '    _vdp_view_projects                   - View projects'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vdp_create_project:
	@$(INFO) '$(VDP_UI_LABEL)Updating project "$(VDP_PROJECT_NAME)" ...'; $(NORMAL)
	$(VDP) project create $(__VDP_ORG__PROJECT) $(VDP_PROJECT_NAME)

_vdp_delete_project:
	@$(INFO) '$(VDP_UI_LABEL)Deleting project "$(VDP_PROJECT_NAME)" ...'; $(NORMAL)
	$(VDP) project delete $(VDP_PROJECT_NAME)

_vdp_edit_project:
	@$(INFO) '$(VDP_UI_LABEL)Editing project "$(VDP_PROJECT_NAME)" ...'; $(NORMAL)
	$(VDP) project edit $(VDP_PROJECT_NAME)

_vdp_show_project:
	@$(INFO) '$(VDP_UI_LABEL)Showing project "$(VDP_PROJECT_NAME)" ...'; $(NORMAL)
	$(VDP) project get $(VDP_PROJECT_NAME) $(__VDP_ORG__PROJECT)

_vdp_view_projects:
	@$(INFO) '$(VDP_UI_LABEL)Viewing available projects ...'; $(NORMAL)
	$(VDP) project list
