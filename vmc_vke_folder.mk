_VMC_VKE_FOLDER_MK_VERSION= $(_VMC_VKE_MK_VERSION)

# VKE_FOLDER_DISPLAY_NAME?= "Shared Folder"
# VKE_FOLDER_NAME?= SharedFolder

# Derived variables
VKE_FOLDER_DISPLAY_NAME?= $(VKE_FOLDER_NAME)

# Option variables
__VKE_DISPLAY_NAME__FOLDER= $(if $(VKE_FOLDER_DISPLAY_NAME),--display-name $(VKE_FOLDER_DISPLAY_NAME))
__VKE_FOLDER= $(if $(VKE_FOLDER_NAME), --folder $(VKE_FOLDER_NAME))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_vke_view_framework_macros ::
	@#echo 'VMC::VKE::Folder ($(_VMC_VKE_FOLDER_MK_VERSION)) macros:'
	@#echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::Folder ($(_VMC_VKE_FOLDER_MK_VERSION)) parameters:'
	@echo '    VKE_FOLDER_DISPLAY_NAME=$(VKE_FOLDER_DISPLAY_NAME)'
	@echo '    VKE_FOLDER_NAME=$(VKE_FOLDER_NAME)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::Folder ($(_VMC_VKE_FOLDER_MK_VERSION)) targets:'A
	@echo '    _vke_create_folder               - Create a new folder'
	@echo '    _vke_delete_folder               - Delete a new folder'
	@echo '    _vke_set_folder                  - Set the active folder'
	@echo '    _vke_show_folder                 - Show everything related to a folder'
	@echo '    _vke_show_folder_projects        - Show projects in a folder'
	@echo '    _vke_view_folders                - View existing folders'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_create_folder:
	@$(INFO) '$(VKE_UI_LABEL)Creating folder "$(VKE_FOLDER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the current user does NOT have the required policy-role'; $(NORMAL)
	$(VKE) folder create $(__VKE_DISPLAY_NAME__FOLDER) $(VKE_FOLDER_NAME)

_vke_delete_folder:
	@$(INFO) '$(VKE_UI_LABEL)Deleting folder "$(VKE_FOLDER_NAME)" ...'; $(NORMAL)
	$(VKE) folder delete $(VKE_FOLDER_NAME)

_vke_set_folder:
	@$(INFO) '$(VKE_UI_LABEL)Set active folder to "$(VKE_FOLDER_NAME)" ...'; $(NORMAL)
	$(VKE) folder set $(VKE_FOLDER_NAME)

_vke_show_folder: _vke_show_folder_projects

_vke_show_folder_projects:
	@$(INFO) '$(VKE_UI_LABEL)Showing projects in folder "$(VKE_FOLDER_NAME)" ...'; $(NORMAL)
	$(VKE) project list $(__VKE_FOLDER)

_vke_view_folders:
	@$(INFO) '$(VKE_UI_LABEL)Viewing all folders ...'; $(NORMAL)
	$(VKE) folder list
