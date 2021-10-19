_TELEPRESENCE_CONTAINER_MK_VERSION= $(_TELEPRESENCE_MK_VERSION)

# TPE_CONTAINER_DEPLOYMENT_NAME?= telepresence-VVVVVVVVVV-WWWWWW-XXXXX
# TPE_CONTAINER_DOCKER_RUN?= -i -t alpine /bin/sh
# TPE_CONTAINER_EXPOSE?= 8080:80
# TPE_CONTAINER_NAMESPACE_NAME?= default
# TPE_CONTAINER_POD_NAME?= telepresence-VVVVVVVVVV-WWWWWW-XXXXX-YYYYYYYYYY-ZZZZZ
# TPE_CONTAINER_REPLICASET_NAME?= telepresence-VVVVVVVVVV-WWWWWW-XXXXX-YYYYYYYYYY
# TPE_CONTAINER_NAMESPACE_NAME?= default

# Derived variables
TPE_CONTAINER_DEPLOYMENT_NAME?= $(TPE_DEPLOYMENT_NAME)
TPE_CONTAINER_DOCKER_RUN?= $(DKR_CONTAINER_RUN)
TPE_CONTAINER_EXPOSE?= $(TPE_CONTAINER_EXPOSE_LOCALPORT)$(if $(TPE_CONTAINER_EXPOSE_REMOTEPORT),:$(TPE_CONTAINER_EXPOSE_REMOTEPORT))
TPE_CONTAINER_NAMESPACE_NAME?= $(TPE_NAMESPACE_NAME)
TPE_CONTAINER_POD_NAME?= $(TPE_CONTAINER_REPLICASET_NAME)-ZZZZZ
TPE_CONTAINER_REPLICASET_NAME?= $(TPE_CONTAINER_DEPLOYMENT_NAME)-YYYYYYYYYY

# Option variables
__TPE_EXPOSE__CONTAINER= $(if $(TPE_CONTAINER_EXPOSE),--expose $(TPE_CONTAINER_EXPOSE))
__TPE_NAMESPACE__CONTAINER= $(if $(TPE_CONTAINER_NAMESPACE_NAME),--namespace $(TPE_CONTAINER_NAMESPACE_NAME))
__TPE_NEW_DEPLOYMENT__CONTAINER= $(if $(TPE_CONTAINER_DEPLOYMENT_NAME),--new-deployment $(TPE_CONTAINER_DEPLOYMENT_NAME))
__TPE_SWAP_DEPLOYMENT__CONTAINER= $(if $(TPE_CONTAINER_DEPLOYMENT_NAME),--swap-deployment $(TPE_CONTAINER_DEPLOYMENT_NAME))
__TPE_Z_DOCKER_RUN= $(if $(TPE_CONTAINER_DOCKER_RUN),--docker-run $(TPE_CONTAINER_DOCKER_RUN))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_tpe_view_framework_macros ::
	@#echo 'TelePresencE::Container ($(_TELEPRESENCE_CONTAINER_MK_VERSION)) macros:'
	@#echo

_tpe_view_framework_parameters ::
	@echo 'TelePresencE::Container ($(_TELEPRESENCE_CONTAINER_MK_VERSION)) parameters:'
	@echo '    TPE_CONTAINER_DEPLOYMENT_NAME=$(TPE_CONTAINER_DEPLOYMENT_NAME)'
	@echo '    TPE_CONTAINER_DOCKER_RUN=$(TPE_CONTAINER_DOCKER_RUN)'
	@echo '    TPE_CONTAINER_EXPOSE=$(TPE_CONTAINER_EXPOSE)'
	@echo '    TPE_CONTAINER_NAMESPACE_NAME=$(TPE_CONTAINER_NAMESPACE_NAME)'
	@echo '    TPE_CONTAINER_NAME=$(TPE_CONTAINER_NAME)'
	@echo '    TPE_CONTAINER_REPLICASET_NAME=$(TPE_CONTAINER_REPLICASET_NAME)'
	@echo

_tpe_view_framework_targets ::
	@echo 'TelePresencE::Container ($(_TELEPRESENCE_CONTAINER_MK_VERSION)) targets:'
	@echo '    _mke_proxy_container            - Inject/Proxy the local container in a remote cluster'
	@echo '    _mke_swap_container             - Swap the local container with a deployment'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

_tpe_proxy_container:
	@$(INFO) '$(TPE_UI_LABEL)Proxying local-container ...'; $(NORMAL)
	@$(WARN) 'This operation creates a virtual network between a remote cluster and your local-container'; $(NORMAL)
	@$(WARN) 'This operation creates deployment "$(TPE_CONTAINER_DEPLOYMENT_NAME)" in namespace $(TPE_CONTAINER_NAMESPACE_NAME)"'; $(NORMAL)
	$(TELEPRESENCE) $(__TPE_EXPOSE__CONTAINER) $(__TPE_NAMESPACE__CONTAINER) $(__TPE_NEW_DEPLOYMENT__CONTAINER) $(_X__TPE_SWAP_DEPLOYMENT__CONTAINER) $(__TPE_Z_DOCKER_RUN)

_tpe_swap_container:
	@$(INFO) '$(TPE_UI_LABEL)Swapping pods in deployment "$(TPE_DOCKER_DEPLOYMENT_NAME)" with local-container ...'; $(NORMAL)
	@$(WARN) 'This operation creates a virtual network between a remote cluster and your local-container'; $(NORMAL)
	$(TELEPRESENCE) $(__TPE_EXPOSE__CONTAINER) $(__TPE_NAMESPACE__CONTAINER) $(_X__TPE_NEW_DEPLOYMENT__CONTAINER) $(__TPE_SWAP_DEPLOYMENT__CONTAINER) $(__TPE_Z_DOCKER_RUN)
