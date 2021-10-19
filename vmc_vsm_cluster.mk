_VMC_VSM_CLUSTER_MK_VERSION= $(_VMC_VSM_MK_VERSION)

# VSM_CLUSTER_FLAVOR_NAME?= kops_small
# VSM_CLUSTER_NAME?=

# Derived variables

# Option variables
__VSM_REGION= $(if $(VSM_CLUSTE_REGION),--region $(VSM_CLUSTER_REGION))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vsm_view_framework_macros ::
	@echo 'VmwareCloud::VSM::Cluster ($(_VMC_VSM_CLUSTER_MK_VERSION)) macros:'
	@echo

_vsm_view_framework_parameters ::
	@echo 'VmwareCloud::VSM::Cluster ($(_VMC_VSM_CLUSTER_MK_VERSION)) parameters:'
	@echo '    VSM_CLUSTER_FLAVOR_NAME=$(VSM_CLUSTER_FLAVOR_NAME)'
	@echo '    VSM_CLUSTER_NAME=$(VSM_CLUSTER_NAME)'
	@echo '    VSM_CLUSTER_REGION=$(VSM_CLUSTER_REGION)'
	@echo

_vsm_view_framework_targets ::
	@echo 'VmwareCloud::VSM::Cluster ($(_VMC_VSM_CLUSTER_MK_VERSION)) targets:'
	@echo '    _vsm_create_cluster         - Create a cluster'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vsm_create_cluster:
	@$(INFO) '$(VSM_UI_LABEL)Reconfiguring profile with org ...'; $(NORMAL)
	$(VSM) cluster create using flavor $(VSM_CLUSTER_FLAVOR_NAME) $(VSM_CLUSTER_NAME) $(__VSM_REGION)
