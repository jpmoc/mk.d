_VMC_VKE_PEERING_MK_VERSION= $(_VMC_VKE_MK_VERSION)

# VKE_PEERING_FOLDER_NAME?= SharedFolder
# VKE_PEERING_ID?=
# VKE_PEERING_PROJECT_NAME?= SharedProject

# Derived variables
VKE_PEERING_FOLDER_NAME?= $(VKE_CLUSTER_FOLDER_NAME)
VKE_PEERING_PROJECT_NAME?= $(VKE_CLUSTER_PROJECT_NAME)

# Option variables
__VKE_FOLDER__PEERING= $(if $(VKE_PEERING_FOLDER_NAME), --folder $(VKE_PEERING_FOLDER_NAME))
__VKE_PROJECT__PEERING= $(if $(VKE_PEERING_PROJECT_NAME), --project $(VKE_PEERING_PROJECT_NAME))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_vke_view_framework_macros ::
	@#echo 'VMC::VKE::Peering ($(_VMC_VKE_PEERING_MK_VERSION)) macros:'
	@#echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::Peering ($(_VMC_VKE_PEERING_MK_VERSION)) parameters:'
	@echo '    VKE_PEERING_FOLDER_NAME=$(VKE_PEERING_FOLDER_NAME)'
	@echo '    VKE_PEERING_ID=$(VKE_PEERING_ID)'
	@echo '    VKE_PEERING_PROJECT_NAME=$(VKE_PEERING_PROJECT_NAME)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::Peering ($(_VMC_VKE_PEERING_MK_VERSION)) targets:'
	@echo '    _vke_show_peering                    - Show everything related to a peering'
	@echo '    _vke_view_peerings                   - View peerings'
	@echo '    _vke_view_peerings_set               - View a set of peerings'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_create_peering:

_vke_delete_peering:

_vke_show_peering:
	@$(INFO) '$(VKE_UI_LABEL)Showing description of peering "$(VKE_PEERING_NAME)" ...'; $(NORMAL)
	$(VKE) cluster peering show $(__VKE_FOLDER__PEERING) $(__VKE_PROJECT__PEERING) $(VKE_PEERING_NAME)

_vke_view_peerings:
	@$(INFO) '$(VKE_UI_LABEL)Viewing peerings ...'; $(NORMAL)
	$(VKE) cluster peering list $(_X__VKE_FOLDER__PEERING) $(_X__VKE_PROJECT__PEERING)

_vke_view_peerings_set:
	@$(INFO) '$(VKE_UI_LABEL)Viewing peerings-set ...'; $(NORMAL)
	@$(WARN) 'Peerings are grouped based on folder and project'; $(NORMAL)
	$(VKE) cluster peering list $(__VKE_FOLDER__PEERING) $(__VKE_PROJECT__PEERING)
