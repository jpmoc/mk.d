_VMC_VSM_GLOBALSERVICE_MK_VERSION= $(_VMC_VSM_MK_VERSION)

# VSM_GLOBALSERVICE_BACKENDCLUSTER_NAME?= blue-gke
# VSM_GLOBALSERVICE_BACKENDSERVICE_CNAME?= server.default.svc.cluster.local
# VSM_GLOBALSERVICE_BACKENDSERVICE_PORT?= 80
# VSM_GLOBALSERVICE_NAME?= gke-server-service
# VSM_GLOBALSERVICE_PORT?= 80
# VSM_GLOBALSERVICE_PROTOCOL?= HTTP

# Derived variables

# Option variables

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_vsm_view_framework_macros ::
	@#echo 'VmwareClouD::ServiceMesh::GlobalService ($(_VMC_VSM_GLOBALSERVICE_MK_VERSION)) macros:'
	@#echo

_vsm_view_framework_parameters ::
	@echo 'VmwareClouD::ServiceMesh::GlobalService ($(_VMC_VSM_GLOBALSERVICE_GROUP_MK_VERSION)) parameters:'
	@echo '    VSM_GLOBALSERVICE_BACKENDCLUSTER_NAME=$(VSM_GLOBALSERVICE_BACKENDCLUSTER_NAME)'
	@echo '    VSM_GLOBALSERVICE_BACKENDSERVICE_CNAME=$(VSM_GLOBALSERVICE_BACKENDSERVICE_CNAME)'
	@echo '    VSM_GLOBALSERVICE_BACKENDSERVICE_PORT=$(VSM_GLOBALSERVICE_BACKENDSERVICE_PORT)'
	@echo '    VSM_GLOBALSERVICE_NAME=$(VSM_GLOBALSERVICE_NAME)'
	@echo '    VSM_GLOBALSERVICE_PORT=$(VSM_GLOBALSERVICE_PORT)'
	@echo '    VSM_GLOBALSERVICE_PROTOCOL=$(VSM_GLOBALSERVICE_PROTOCOL)'
	@echo

_vke_view_framework_targets ::
	@echo 'VmwareClouD::ServiceMesh::GlobalService ($(_VMC_VSM_GLOBALSERVICE_MK_VERSION)) targets:'
	@echo '    _vke_create_globalservice               - Create a new global-service'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vsm_create_globalservice:
	@$(INFO) '$(VSM_UI_LABEL)Creating global-service "$(VSM_GLOBALSERVICE_NAME)" ...'; $(NORMAL)
	$(VSM) create global-service $(VSM_GLOBALSERVICE_NAME) $(VSM_GLOBALSERVICE_PORT)/$(VSM_GLOBALSERVICE_PROTOCOL)/$(VSM_GLOBALSERVICE_BACKENDSERVICE_PORT) $(VSM_GLOBALSERVICE_BACKENDCLUSTER_NAME)/$(VSM_GLOBALSERVICE_BACKENDSERVICE_CNAME) 
