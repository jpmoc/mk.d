_MINIKUBE_TUNNEL_MK_VERSION= $(_MINIKUBE_MK_VERSION)

MKE_TUNNEL_CLEANUP_FLAG?= false
# MKE_TUNNEL_NAME?= my-tunnel

# Derived variables
MKE_TUNNEL_NAME?=$(MINIKUBE_PROFILE_NAME)

# Option variables
__MKE_CLEANUP__TUNNEL?= $(if $(filter true,$(MKE_TUNNEL_CLEANUP_FLAG)),--cleanup)

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_mke_list_macros ::
	@#echo 'MiniKubE::Tunnel ($(_MINIKUBE_TUNNEL_MK_VERSION)) macros:'
	@#echo

_mke_list_parameters ::
	@echo 'MiniKubE::Tunnel ($(_MINIKUBE_TUNNEL_MK_VERSION)) parameters:'
	@echo '    MKE_TUNNEL_CLEANUP_FLAG=$(MKE_TUNNEL_CLEANUP_FLAG)'
	@echo '    MKE_TUNNEL_NAME=$(MKE_TUNNEL_NAME)'
	@echo

_mke_list_targets ::
	@echo 'MiniKubE::Tunnel ($(_MINIKUBE_TUNNEL_MK_VERSION)) targets:'
	@echo '    _mke_create_tunnel           - Create a tunnel to a cluster'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mke_create_tunnel:
	@$(INFO) '$(MKE_UI_LABEL)Creating tunnel "$(MKE_TUNNEL_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will block port 80 and 443 of localhost'
	@$(WARN) 'The other ports are available for port-forwards or other'; $(NORMAL)
	$(MINIKUBE) tunnel $(__MKE_CLEANUP__TUNNEL)
