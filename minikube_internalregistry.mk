_MINIKUBE_INTERNALREGISTRY_MK_VERSION= $(_MINIKUBE_MK_VERSION)

# MKE_INTERNALREGISTRY_NAME?=

# Derived variables

# Option variables

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_mke_view_framework_macros ::
	@#echo 'MiniKubE::InternalRegistry ($(_MINIKUBE_INTERNALREGISTRY_MK_VERSION)) macros:'
	@#echo

_mke_view_framework_parameters ::
	@echo 'MiniKubE::InternalRegistry ($(_MINIKUBE_INTERNALREGISTRY_MK_VERSION)) parameters:'
	@echo '    MKE_INTERNALREGISTRY_NAME=$(MKE_MOUNT_NAME)'
	@echo

_mke_view_framework_targets ::
	@echo 'MiniKubE::InternalRegistry ($(_MINIKUBE_INTERNALREGISTRY_MK_VERSION)) targets:'
	@echo '    _mke_enable_internalregistry               - Enable access to an internal registry'
	@echo '    _mke_show_internalregistry                 - Show everything related to an internal registry'
	@echo '    _mke_show_internalregistry_description     - Show description of an internal registry'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mke_enable_internalregistry:
	@$(INFO) '$(MKE_UI_LABEL)Enabling internal-registry "$(MKE_INTERNALREGISTRY_NAME)" ...'; $(NORMAL)
	# https://minikube.sigs.k8s.io/docs/tasks/registry/insecure/
	$(MINIKUBE) addons enable registry

_mke_show_internalregistry: _mke_show_internalregistry_description

_mke_show_internalregistry_description:
	@$(INFO) '$(MKE_UI_LABEL)Showing description of internal-registry "$(MKE_INTERNALREGISTRY_NAME)" ...'; $(NORMAL)
