_VMC_VKE_PROJECT_MK_VERSION= $(_VMC_VKE_MK_VERSION)

# VKE_PROJECT_DISPLAY_NAME?= "Shared Project"
# VKE_PROJECT_FOLDER_NAME?= SharedFolder
# VKE_PROJECT_NAME?= SharedProject

# Derived variables
VKE_PROJECT_DISPLAY_NAME?= $(VKE_PROJECT_NAME)
VKE_PROJECT_NAME?= $(VKE_CLUSTER_PROJECT_NAME)
VKE_PROJECT_FOLDER_NAME?= $(VKE_CLUSTER_FOLDER_NAME)

# Option variables
__VKE_DISPLAY_NAME__PROJECT= $(if $(VKE_PROJECT_DISPLAY_NAME),--display-name $(VKE_PROJECT_DISPLAY_NAME))
__VKE_FOLDER__PROJECT= $(if $(VKE_PROJECT_FOLDER_NAME),--folder $(VKE_PROJECT_FOLDER_NAME))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_vke_view_framework_macros ::
	@#echo 'VMC::VKE::Project ($(_VMC_VKE_PROJECT_MK_VERSION)) macros:'
	@#echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::Project ($(_VMC_VKE_PROJECT_MK_VERSION)) parameters:'
	@echo '    VKE_PROJECT_DISPLAY_NAME=$(VKE_PROJECT_DISPLAY_NAME)'
	@echo '    VKE_PROJECT_FOLDER_NAME=$(VKE_PROJECT_FOLDER_NAME)'
	@echo '    VKE_PROJECT_NAME=$(VKE_PROJECT_NAME)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::Project ($(_VMC_VKE_PROJECT_MK_VERSION)) targets:'
	@echo '    _vke_create_project           - Create a new project'
	@echo '    _vke_delete_project           - Deleted an existing project'
	@echo '    _vke_show_project             - Show everything related to a project'
	@echo '    _vke_show_project_clusters    - Show clusters in a project'
	@echo '    _vke_view_projects            - View projects'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_create_project:
	@$(INFO) '$(VKE_UI_LABEL)Creating new project "$(VKE_PROJECT_NAME)" in folder "$(VKE_PROJECT_FOLDER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the current user does NOT have the correct policy-role attached!'; $(NORMAL)
	$(VKE) project create $(__VKE_DISPLAY_NAME__PROJECT) $(__VKE_FOLDER__PROJECT) $(VKE_PROJECT_NAME)

_vke_delete_project:
	@$(INFO) '$(VKE_UI_LABEL)Deleting project "$(VKE_PROJECT_NAME)" in folder "$(VKE_PROJECT_FOLDER_NAME)" ...'; $(NORMAL)
	$(VKE) project delete $(__VKE_FOLDER__PROJECT) $(VKE_PROJECT_NAME)

_vke_show_project: _vke_show_project_clusters

_vke_show_project_clusters:
	@$(INFO) '$(VKE_UI_LABEL)Showing clusters in project "$(VKE_PROJECT_NAME)" ...'; $(NORMAL)
	$(VKE) cluster list $(__VKE_FOLDER__PROJECT) --project $(VKE_PROJECT_NAME)

_vke_view_projects: _vke_show_folder_projects
