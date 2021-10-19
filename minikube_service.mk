_MINIKUBE_SERVICE_MK_VERSION= $(_MINIKUBE_MK_VERSION)

# MKE_SERVICE_CLUSTER_NAME?=
# MKE_SERVICE_NAMESPACE_NAME?=
# MKE_SERVICE_PROFILE_NAME?=
# MKE_SERVICE_URL?=
MKE_SERVICE_URL_FLAG?= false
# MKE_SERVICES_CLUSTER_NAME?=
# MKE_SERVICES_NAMESPACE_NAME?=
# MKE_SERVICES_PROFILE_NAME?=

# Derived variables
MKE_SERVICE_CLUSTER_NAME?= $(MKE_CLUSTER_NAME)
MKE_SERVICE_PROFILE_NAME?= $(MKE_PROFILE_NAME)
MKE_SERVICES_CLUSTER_NAME?= $(MKE_SERVICE_CLUSTER_NAME)
MKE_SERVICES_NAMESPACE_NAME?= $(MKE_SERVICE_NAMESPACE_NAME)
MKE_SERVICES_PROFILE_NAME?= $(MKE_SERVICE_PROFILE_NAME)

# Option variables
__MKE_NAMESPACE__SERVICES= $(if $(MKE_SERVICES_NAMESPACE_NAME),--namespace $(MKE_SERVICES_NAMESPACE_NAME))
__MKE_URL__SERVICE= $(if $(filter true, $(MKE_SERVICE_URL_FLAG)),--url)

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_mke_view_framework_macros ::
	@#echo 'MiniKubE::Service ($(_MINIKUBE_SERVICE_MK_VERSION)) macros:'
	@#echo

_mke_view_framework_parameters ::
	@echo 'MiniKubE::Service ($(_MINIKUBE_SERVICE_MK_VERSION)) parameters:'
	@echo '    MKE_SERVICE_CLUSTER_NAME=$(MKE_SERVICE_CLUSTER_NAME)'
	@echo '    MKE_SERVICE_NAMESPACE_NAME=$(MKE_SERVICE_NAMESPACE_NAME)'
	@echo '    MKE_SERVICE_PROFILE_NAME=$(MKE_SERVICE_PROFILE_NAME)'
	@echo '    MKE_SERVICE_URL=$(MKE_SERVICE_URL)'
	@echo '    MKE_SERVICE_URL_FLAG=$(MKE_SERVICE_URL_FLAG)'
	@echo '    MKE_SERVICES_CLUSTER_NAME=$(MKE_SERVICES_CLUSTER_NAME)'
	@echo '    MKE_SERVICES_NAMESPACE_NAME=$(MKE_SERVICES_NAMESPACE_NAME)'
	@echo '    MKE_SERVICES_PROFILE_NAME=$(MKE_SERVICES_PROFILE_NAME)'
	@echo '    MKE_SERVICES_SET_NAME=$(MKE_SERVICES_SET_NAME)'
	@echo

_mke_view_framework_targets ::
	@echo 'MiniKubE::Service ($(_MINIKUBE_SERVICE_MK_VERSION)) targets:'
	@echo '    _mke_open_service               - Open the service'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mke_open_service:
	@$(INFO) '$(MKE_UI_LABEL)Opening service-URL on cluster "$(MKE_SERVICE_CLUSTER_NAME)" ...'; $(NORMAL)
	# $(MINIKUBE) open $(__MKE_URL__SERVICE)

_mke_view_services:
	@$(INFO) '$(MKE_UI_LABEL)Viewing services on cluster "$(MKE_SERVICE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) service list $(_X__MKE_NAMESPACE__SERVICES)

_mke_view_services_set:
	@$(INFO) '$(MKE_UI_LABEL)Viewing services-set "$(MKE_SERVICES_SET_NAME)" on cluster "$(MKE_SERVICE_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Services are grouped based on provided namespace and ...'; $(NORMAL)
	$(MINIKUBE) service list $(__MKE_NAMESPACE__SERVICES)
