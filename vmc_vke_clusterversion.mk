_VMC_VKE_CLUSTERVERSION_MK_VERSION= $(_VMC_VKE_MK_VERSION)

# VKE_CLUSTERVERSION_NAME?= developer
# VKE_CLUSTERVERSION_REGION?= us-west-2

# Derived variables
VKE_CLUSTERVERSION_NAME?= $(VKE_CLUSTER_VERSION)
VKE_CLUSTERVERSION_REGION?= $(VKE_CLUSTER_REGION)

# Option variables
__VKE_REGION__CLUSTERVERSION= $(if $(VKE_CLUSTERVERSION_REGION), --region $(VKE_CLUSTERVERSION_REGION))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_vke_view_framework_macros ::
	@#echo 'VMC::VKE::ClusterVersion ($(_VMC_VKE_CLUSTERVERSION_MK_VERSION)) macros:'
	@#echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::ClusterVersion ($(_VMC_VKE_CLUSTERVERSION_MK_VERSION)) parameters:'
	@echo '    VKE_CLUSTERVERSION_NAME=$(VKE_CLUSTERVERSION_NAME)'
	@echo '    VKE_CLUSTERVERSION_REGION=$(VKE_CLUSTERVERSION_REGION)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::ClusterVersion ($(_VMC_VKE_CLUSTERVERSION_MK_VERSION)) targets:'
	@echo '    _vke_view_clusterversions            - View cluster-versions'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_view_clusterversions:
	@$(INFO) '$(VKE_UI_LABEL)Viewing cluster-versions ...'; $(NORMAL)
	$(VKE) cluster versions list $(__VKE_REGION__CLUSTERVERSION)
