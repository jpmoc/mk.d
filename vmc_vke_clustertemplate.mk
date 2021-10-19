_VMC_VKE_CLUSTERTEMPLATE_MK_VERSION= $(_VMC_VKE_MK_VERSION)

# VKE_CLUSTERTEMPLATE_NAME?= developer

# Derived variables

# Option variables

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_vke_view_framework_macros ::
	@#echo 'VMC::VKE::ClusterTemplate ($(_VMC_VKE_CLUSTERTEMPLATE_MK_VERSION)) macros:'
	@#echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::ClusterTemplate ($(_VMC_VKE_CLUSTERTEMPLATE_MK_VERSION)) parameters:'
	@echo '    VKE_CLUSTERTEMPLATE_NAME=$(VKE_CLUSTERTEMPLATE_NAME)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::ClusterTemplate ($(_VMC_VKE_CLUSTERTEMPLATE_MK_VERSION)) targets:'
	@echo '    _vke_view_clustertemplates            - View cluster-templates'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_view_clustertemplates:
	@$(INFO) '$(VKE_UI_LABEL)Viewing cluster-templates ...'; $(NORMAL)
	$(VKE) cluster templates list
