_VMC_VDP_NAMESPACE_MK_VERSION= $(_VMC_VDP_MK_VERSION)

# VDP_NAMESPACE_K8SNAME?= nsxsm-allspark-istio-system
# VDP_NAMESPACE_NAME?= my-namespace
# VDP_NAMESPACE_PROJECT__NAME?= myproject
# VDP_NAMESPACE_ORGANIZATION_NAME?= myproject

# Derived variables
VDP_NAMESPACE_K8SNAME?= $(VDP_NAMESPACE_ORGANIZATION_NAME)-$(VDP_NAMESPACE_PROJECT_NAME)-$(VDP_NAMESPACE_NAME)
VDP_NAMESPACE_PROJECT_NAME?= $(VDP_PROJECT_NAME)
VDP_NAMESPACE_ORGANIZATION_NAME?= $(VDP_ORGANIZATION_NAME)

# Option variables
__VDP_ORG__NAMESPACE?= $(if $(VDP_NAMESPACE_ORGANIZATION_NAME),--org $(VDP_NAMESPACE_ORGANIZATION_NAME))
__VDP_PROJECT__NAMESPACE?= $(if $(VDP_NAMESPACE_PROJECT_NAME),--project $(VDP_NAMESPACE_PROJECT_NAME))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vdp_view_framework_macros ::
	@#echo 'VMwareCloud::VDP::Namespace ($(_VMC_VDP_NAMESPACE_MK_VERSION)) macros:'
	@#echo

_vdp_view_framework_parameters ::
	@echo 'VMwareCloud::VDP::Namespace ($(_VMC_VDP_NAMESPACE_MK_VERSION)) parameters:'
	@echo '    VDP_NAMESPACE_K8SNAME=$(VDP_NAMESPACE_K8SNAME)'
	@echo '    VDP_NAMESPACE_NAME=$(VDP_NAMESPACE_NAME)'
	@echo '    VDP_NAMESPACE_ORGANIZATION_NAME=$(VDP_PROJECT_ORGANIZATION_NAME)'
	@echo '    VDP_NAMESPACE_PROJECT_NAME=$(VDP_NAMESPACE_PROJECT_NAME)'
	@echo

_vdp_view_framework_targets ::
	@echo 'VMwareCloud::VDP::Namespace ($(_VMC_VDP_NAMESPACE_MK_VERSION)) targets:'
	@echo '    _vdp_create_namespace                - Create a new namespace'
	@echo '    _vdp_delete_namespace                - Delete an existing namespace'
	@echo '    _vdp_show_namespace                  - Show everything related to a namespace'
	@echo '    _vdp_view_namespaces                 - View namespaces'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vdp_create_namespace:
	@$(INFO) '$(VDP_UI_LABEL)Creating namespace "$(VDP_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The name of VDP namespace is the short name of the corresponding kubernetes namespace'; $(NORMAL)
	$(VDP) ns create $(__VDP_ORG__PROJECT) $(__VDP_PROJECT__NAMESPACE) $(VDP_NAMESPACE_NAME)

_vdp_delete_namespace:
	@$(INFO) '$(VDP_UI_LABEL)Deleting namespace "$(VDP_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(VDP) ns delete $(__VDP_ORG__PROJECT) $(__VDP_PROJECT__NAMESPACE) $(VDP_NAMESPACE_NAME)

_vdp_show_namespace:
	@$(INFO) '$(VDP_UI_LABEL)Showing namespace "$(VDP_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(VDP) ns get $(__VDP_ORG__PROJECT) $(__VDP_PROJECT_NAME)

_vdp_view_namespaces:
	@$(INFO) '$(VDP_UI_LABEL)Viewing namespaces ...'; $(NORMAL)
	@$(WARN) 'A namespace in an UNKNOWN status is being deleted'; $(NORMAL)
	$(VDP) ns list $(__VDP_ORG__NAMESPACE) $(__VDP_PROJECT__NAMESPACE)
