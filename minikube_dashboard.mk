_MINIKUBE_DASHBOARD_MK_VERSION= $(_MINIKUBE_MK_VERSION)

# MKE_DASHBOARD_CLUSTER_NAME?=
# MKE_DASHBOARD_PROFILE_NAME?=
# MKE_DASHBOARD_URL?=
MKE_DASHBOARD_URL_FLAG?= false

# Derived variables
MKE_DASHBOARD_CLUSTER_NAME?= $(MKE_CLUSTER_NAME)
MKE_DASHBOARD_PROFILE_NAME?= $(MKE_PROFILE_NAME)

# Option variables
__MKE_URL__DASHBOARD= $(if $(filter true, $(MKE_DASHBOARD_URL_FLAG)),--url)

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_mke_list_macros ::
	@#echo 'MiniKubE::Dashboard ($(_MINIKUBE_MOUNT_MK_VERSION)) macros:'
	@#echo

_mke_list_parameters ::
	@echo 'MiniKubE::Dashboard ($(_MINIKUBE_MOUNT_MK_VERSION)) parameters:'
	@echo '    MKE_DASHBOARD_CLUSTER_NAME=$(MKE_DASHBOARD_CLUSTER_NAME)'
	@echo '    MKE_DASHBOARD_PROFILE_NAME=$(MKE_DASHBOARD_PROFILE_NAME)'
	@echo '    MKE_DASHBOARD_URL=$(MKE_DASHBOARD_URL)'
	@echo '    MKE_DASHBOARD_URL_FLAG=$(MKE_DASHBOARD_URL_FLAG)'
	@echo

_mke_list_targets ::
	@echo 'MiniKubE::Dashboard ($(_MINIKUBE_MOUNT_MK_VERSION)) targets:'
	@echo '    _mke_open_dashboard               - Open the dashboard'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mke_open_dashboard:
	@$(INFO) '$(MKE_UI_LABEL)Opening dashboard of cluster "$(MKE_DASHBOARD_CLUSTER_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) dashboard $(__MKE_URL__DASHBOARD)
