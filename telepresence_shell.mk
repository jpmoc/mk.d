_TELEPRESENCE_SHELL_MK_VERSION= $(_TELEPRESENCE_MK_VERSION)

# TPE_SHELL_DEPLOYMENT_NAME?= telepresence-VVVVVVVVVV-WWWWWW-XXXXX
# TPE_SHELL_EXPOSE?= 8080:80
# TPE_SHELL_POD_NAME?= telepresence-VVVVVVVVVV-WWWWWW-XXXXX-YYYYYYYYYY-ZZZZZ
# TPE_SHELL_REPLICASET_NAME?= telepresence-VVVVVVVVVV-WWWWWW-XXXXX-YYYYYYYYYY
# TPE_SHELL_NAMESPACE_NAME?= default

# Derived variables
TPE_SHELL_DEPLOYMENT_NAME?= $(TPE_DEPLOYMENT_NAME)
TPE_SHELL_NAMESPACE_NAME?= $(TPE_NAMESPACE_NAME)
TPE_SHELL_POD_NAME?= $(TPE_SHELL_REPLICASET_NAME)-ZZZZZ
TPE_SHELL_REPLICASET_NAME?= $(TPE_SHELL_DEPLOYMENT_NAME)-YYYYYYYYYY

# Option variables
__TPE_NAMESPACE__SHELL= $(if $(TPE_SHELL_NAMESPACE_NAME),--namespace $(TPE_SHELL_NAMESPACE_NAME))
__TPE_NEW_DEPLOYMENT__SHELL= $(if $(TPE_SHELL_DEPLOYMENT_NAME),--new-deployment $(TPE_SHELL_DEPLOYMENT_NAME))
__TPE_SWAP_DEPLOYMENT__SHELL= $(if $(TPE_SHELL_DEPLOYMENT_NAME),--swap-deployment $(TPE_SHELL_DEPLOYMENT_NAME))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_tpe_view_framework_macros ::
	@#echo 'TelePresencE::Shell ($(_TELEPRESENCE_SHELL_MK_VERSION)) macros:'
	@#echo

_tpe_view_framework_parameters ::
	@echo 'TelePresencE::Shell ($(_TELEPRESENCE_SHELL_MK_VERSION)) parameters:'
	@echo '    TPE_SHELL_DEPLOYMENT_NAME=$(TPE_SHELL_DEPLOYMENT_NAME)'
	@echo '    TPE_SHELL_EXPOSE=$(TPE_SHELL_EXPOSE)'
	@echo '    TPE_SHELL_NAMESPACE_NAME=$(TPE_SHELL_NAMESPACE_NAME)'
	@echo '    TPE_SHELL_NAME=$(TPE_SHELL_NAME)'
	@echo '    TPE_SHELL_REPLICASET_NAME=$(TPE_SHELL_REPLICASET_NAME)'
	@echo

_tpe_view_framework_targets ::
	@echo 'TelePresencE::Shell ($(_TELEPRESENCE_SHELL_MK_VERSION)) targets:'
	@echo '    _mke_proxy_shell            - Inject/Proxy the local shell in a remote cluster'
	@echo '    _mke_swap_shell             - Swap the local shell with a deployment'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

_tpe_proxy_shell:
	@$(INFO) '$(TPE_UI_LABEL)Proxying local-shell ...'; $(NORMAL)
	@$(WARN) 'This operation creates a virtual network between a remote cluster and your local-shell'; $(NORMAL)
	@$(WARN) 'This operation deploys proxies in the namespace "$(TPE_SHELL_NAMESPACE_NAME)" using deployment "$(TPE_SHELL_DEPLOYMENT_NAME)"'; $(NORMAL)
	@$(WARN) 'This operation uses the vpn-tcp default? method'; $(NORMAL)
	$(TELEPRESENCE) $(__TPE_EXPOSE__SHELL) $(__TPE_NAMESPACE__SHELL) $(__TPE_NEW_DEPLOYMENT__SHELL) $(_X__TPE_RUN_SHELL) --run-shell $(_X__TPE_SWAP_DEPLOYMENT__SHELL) $(_X__TPE_Z_DOCKER_RUN)

_tpe_swap_shell:
	@$(INFO) '$(TPE_UI_LABEL)Swapping pods in deployment "$(TPE_SHELL_DEPLOYMENT_NAME).$(TPE_SHELL_NAMESPACE_NAME)" with proxies ...'; $(NORMAL)
	$(TELEPRESENCE) $(__TPE_EXPOSE__CONTAINER) $(__TPE_NAMESPACE__CONTAINER) $(_X__TPE_RUN_SHELL) --run-shell $(__TPE_SWAP_DEPLOYMENT__CONTAINER) $(__TPE_Z_DOCKER_RUN)
