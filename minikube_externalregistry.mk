_MINIKUBE_EXTERNALREGISTRY_MK_VERSION= $(_MINIKUBE_MK_VERSION)

# MKE_EXTERNALREGISTRY_NAME?=

# Derived variables

# Option variables

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_mke_view_framework_macros ::
	@#echo 'MiniKubE::ExternalRegistry ($(_MINIKUBE_EXTERNALREGISTRY_MK_VERSION)) macros:'
	@#echo

_mke_view_framework_parameters ::
	@echo 'MiniKubE::ExternalRegistry ($(_MINIKUBE_EXTERNALREGISTRY_MK_VERSION)) parameters:'
	@echo '    MKE_EXTERNALREGISTRY_NAME=$(MKE_MOUNT_NAME)'
	@echo

_mke_view_framework_targets ::
	@echo 'MiniKubE::ExternalRegistry ($(_MINIKUBE_EXTERNALREGISTRY_MK_VERSION)) targets:'
	@echo '    _mke_config_externalregistry               - Configure access to an external registry' 
	@echo '    _mke_enable_externalregistry               - Enable access to an external registry' 
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mke_config_externalregistry:
	@$(INFO) '$(MKE_UI_LABEL)Configuring access to external-registry "$(MKE_INTERNALREGISTRY_NAME)" ...'; $(NORMAL)
	# https://minikube.sigs.k8s.io/docs/tasks/registry/private/
	$(MINIKUBE) addons configure registry-creds

_mke_enable_externalregistry:
	@$(INFO) '$(MKE_UI_LABEL)Enabling access to external-registry "$(MKE_INTERNALREGISTRY_NAME)" ...'; $(NORMAL)
	# https://minikube.sigs.k8s.io/docs/tasks/registry/private/
	$(MINIKUBE) addons enable registry-creds
