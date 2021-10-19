_TELEPRESENCE_PROCESS_MK_VERSION= $(_TELEPRESENCE_MK_VERSION)

# TPE_PROCESS_COMMAND?=
# TPE_PROCESS_DEPLOYMENT_NAME?= telepresence-VVVVVVVVVV-WWWWWW-XXXXX
# TPE_PROCESS_EXPOSE?= 8080:80
# TPE_PROCESS_POD_NAME?= telepresence-VVVVVVVVVV-WWWWWW-XXXXX-YYYYYYYYYY-ZZZZZ
# TPE_PROCESS_REPLICASET_NAME?= telepresence-VVVVVVVVVV-WWWWWW-XXXXX-YYYYYYYYYY
# TPE_PROCESS_NAMESPACE_NAME?= default

# Derived variables
TPE_PROCESS_DEPLOYMENT_NAME?= $(TPE_DEPLOYMENT_NAME)
TPE_PROCESS_NAMESPACE_NAME?= $(TPE_NAMESPACE_NAME)
TPE_PROCESS_POD_NAME?= $(TPE_PROCESS_REPLICASET_NAME)-ZZZZZ
TPE_PROCESS_REPLICASET_NAME?= $(TPE_PROCESS_DEPLOYMENT_NAME)-YYYYYYYYYY

# Option variables
__TPE_NAMESPACE__PROCESS= $(if $(TPE_PROCESS_NAMESPACE_NAME),--namespace $(TPE_PROCESS_NAMESPACE_NAME))
__TPE_NEW_DEPLOYMENT__PROCESS= $(if $(TPE_PROCESS_DEPLOYMENT_NAME),--new-deployment $(TPE_PROCESS_DEPLOYMENT_NAME))
__TPE_SWAP_DEPLOYMENT__PROCESS= $(if $(TPE_PROCESS_DEPLOYMENT_NAME),--swap-deployment $(TPE_PROCESS_DEPLOYMENT_NAME))
__TPE_Z_RUN= $(if $(TPE_PROCESS_COMMAND),--run $(TPE_PROCESS_COMMAND))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_tpe_view_framework_macros ::
	@#echo 'TelePresencE::Process ($(_TELEPRESENCE_PROCESS_MK_VERSION)) macros:'
	@#echo

_tpe_view_framework_parameters ::
	@echo 'TelePresencE::Process ($(_TELEPRESENCE_PROCESS_MK_VERSION)) parameters:'
	@echo '    TPE_PROCESS_COMMAND=$(TPE_PROCESS_COMMAND)'
	@echo '    TPE_PROCESS_DEPLOYMENT_NAME=$(TPE_PROCESS_DEPLOYMENT_NAME)'
	@echo '    TPE_PROCESS_EXPOSE=$(TPE_PROCESS_EXPOSE)'
	@echo '    TPE_PROCESS_NAMESPACE_NAME=$(TPE_PROCESS_NAMESPACE_NAME)'
	@echo '    TPE_PROCESS_REPLICASET_NAME=$(TPE_PROCESS_REPLICASET_NAME)'
	@echo

_tpe_view_framework_targets ::
	@echo 'TelePresencE::Process ($(_TELEPRESENCE_PROCESS_MK_VERSION)) targets:'
	@echo '    _mke_proxy_process            - Inject/Proxy the local process in a remote cluster'
	@echo '    _mke_swap_process             - Swap the local process with a deployment'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

_tpe_proxy_process:
	@$(INFO) '$(TPE_UI_LABEL)Proxying local-process ...'; $(NORMAL)
	@$(WARN) 'This operation creates a virtual network between a remote cluster and your local-process'; $(NORMAL)
	@$(WARN) 'This operation deploys a telepresence proxy in the namespace "$(TPE_PROCESS_NAMESPACE_NAME)"'; $(NORMAL)
	$(TELEPRESENCE) $(__TPE_EXPOSE__PROCESS) $(__TPE_NAMESPACE__PROCESS) $(__TPE_NEW_DEPLOYMENT__PROCESS) $(_X__TPE_RUN_SHELL) $(_X__TPE_SWAP_DEPLOYMENT__PROCESS) $(_X__TPE_Z_DOCKER_RUN) $(__TPE_Z_RUN)

_tpe_swap_process:
	@$(INFO) '$(TPE_UI_LABEL)Swapping local-process with deployment "$(TPE_PROCESS_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation replaces pods in deployment "$(TPE_PROCESS_DEPLOYMENT_NAME)" namespace "$(TPE_PROCESS_NAMESPACE_NAME)" with teleprecence-proxies'; $(NORMAL)
	$(TELEPRESENCE) $(__TPE_EXPOSE__PROCESS) $(__TPE_NAMESPACE__PROCESS) $(_X__TPE_DEPLOYMENT_NAME__PROCESS) $(_X__TPE_RUN_SHELL) $(__TPE_SWAP_DEPLOYMENT__RPOCESS) $(_X__TPE_Z_DOCKER_RUN) $(__TPE_Z_RUN)
