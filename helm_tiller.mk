_HELM_TILLER_MK_VERSION= $(_HELM_MK_VERSION)

# HLM_TILLER_CANARY_IMAGE?=
# HLM_TILLER_CLIENT_ONLY?= true
HLM_TILLER_CLUSTERROLEBINDING_NAME?= tiller
# HLM_TILLER_CONNECTION_TIMEOUT?= 300
HLM_TILLER_DEPLOYMENT_NAME?= tiller-deploy
HLM_TILLER_HISTORY_MAX?= 0
# HLM_TILLER_HOSTPORT?= localhost:44134      # Global parameter
# HLM_TILLER_IMAGE_NAME?= gcr.io/kubernetes-helm/tiller:v2.11.0
# HLM_TILLER_IMAGE_REGISTRY?= gcr.io/kubernetes-helm/tiller
# HLM_TILLER_IMAGE_TAG?= v2.11.0
HLM_TILLER_LOCALREPO_URL?= http://127.0.0.1:8879/charts
# HLM_TILLER_NAMESPACE_NAME?= kube-system
# HLM_TILLER_NODE_SELECTORS?= "beta.kubernetes.io/os"="linux"
# HLM_TILLER_OUTPUT?= yaml
# HLM_TILLER_OVERRIDE?= metadata.annotations."deployment\.kubernetes\.io/revision"="1"
HLM_TILLER_POD_SELECTOR?= app=helm,name=tiller
HLM_TILLER_REPLICA_COUNT?= 1
HLM_TILLER_SERVICE_NAME?= tiller-deploy
HLM_TILLER_SERVICEACCOUNT_NAME?= tiller
# HLM_TILLER_SKIP_REFRESH?= true
HLM_TILLER_STABLEREPO_URL?= https://kubernetes-charts.storage.googleapis.com
# HLM_TILLER_TLS_CACERT?=
# HLM_TILLER_TLS_CERT?=
# HLM_TILLER_TLS_ENABLE?= true
# HLM_TILLER_TLS_KEY?=
# HLM_TILLER_TLS_VERIFY?= true
## HLM_TILLER_UPGRADE_ENABLE?= false
HLM_TILLER_WAIT_ENABLE?= false

# Derived parameters
HLM_TILLER_IMAGE_NAME?= $(if $(HLM_TILLER_IMAGE_TAG),$(HLM_TILLER_IMAGE_REGISTRY):$(HLM_TILLER_IMAGE_TAG))

# Option parameters
__HLM_CANARY_IMAGE= $(if $(HLM_TILLER_CANARY_IMAGE),--canary-image $(HLM_TILLER_CANARY_IMAGE))
__HLM_CLIENT_ONLY= $(if $(filter true, $(HLM_TILLER_CLIENT_ONLY)),--client-only)
__HLM_DRY_RUN__TILLER=
__HLM_FORCE_UPGRADE__TILLER=
__HLM_HISTORY_MAX= $(if $(HLM_TILLER_HISTORY_MAX),--history-max $(HLM_TILLER_HISTORY_MAX))
__HLM_LOCAL_REPO_URL= $(if $(HLM_TILLER_LOCALREPO_URL),--local-repo-url $(HLM_TILLER_LOCALREPO_URL))
__HLM_NET_HOST=
__HLM_NODE_SELECTORS__TILLER= $(if $(HLM_TILLER_NODE_SELECTORS),--node-selectors $(HLM_TILLER_NODE_SELECTORS))
__HLM_OUTPUT__TILLER=
__HLM_OVERRIDE__TILLER= $(if $(HLM_TILLER_OVERRIDE),--override $(HLM_TILLER_OVERRIDE) )
__HLM_REPLICAS= $(if $(HLM_TILLER_REPLICA_COUNT),--replicas $(HLM_TILLER_REPLICA_COUNT))
__HLM_SERVICE_ACCOUNT= $(if $(HLM_TILLER_SERVICEACCOUNT_NAME),--service-account $(HLM_TILLER_SERVICEACCOUNT_NAME))
__HLM_SKIP_REFRESH= $(if $(filter true, $(HLM_TILLER_SKIP_REFRESH)),--skip-refresh)
__HLM_STABLE_REPO_URL= $(if $(HLM_TILLER_STABLEREPO_URL),--stable-repo-url $(HLM_TILLER_STABLEREPO_URL))
__HLM_TILLER_IMAGE= $(if $(HLM_TILLER_IMAGE_NAME),--tiller-image $(HLM_TILLER_IMAGE_NAME))
__HLM_TILLER_TLS= $(if $(filter true, $(HLM_TILLER_TLS_ENABLE)),--tiller-tls)
__HLM_TILLER_TLS_CERT= $(if $(HLM_TILLER_TLS_CERT),--tiller-tls-cert $(HLM_TILLER_TLS_CERT))
__HLM_TILLER_TLS_KEY= $(if $(HLM_TILLER_TLS_KEY),--tiller-tls-key $(HLM_TILLER_TLS_KEY))
__HLM_TILLER_TLS_VERIFY= $(if $(filter true, $(HLM_TILLER_TLS_VERIFY)),--tiller-tls-verify)
__HLM_TLS_CA_CERT= $(if $(HLM_TILLER_TLS_CACERT),--tls-ca-cert $(HLM_TILLER_TLS_CACERT))
# __HLM_UPGRADE__TILLER= $(if $(filter true, $(HLM_TILLER_UPGRADE_ENABLE)), --upgrade)
__HLM_WAIT__TILLER= $(if $(filter true, $(HLM_TILLER_WAIT_ENABLE)),--wait)

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_hlm_view_framework_macros ::
	@echo 'HeLM::Tiller ($(_HELM_TILLER_MK_VERSION)) macros:'
	@echo

_hlm_view_framework_parameters ::
	@echo 'HeLM::Tiller ($(_HELM_TILLER_MK_VERSION)) variables:'
	@echo '    HLM_TILLER_CANARY_IMAGE=$(HLM_TILLER_CANARY_IMAGE)'
	@echo '    HLM_TILLER_CLIENT_ONLY=$(HLM_TILLER_CLIENT_ONLY)'
	@echo '    HLM_TILLER_CLUSTERROLEBINDING_NAME=$(HLM_TILLER_CLUSTERROLEBINDING_NAME)'
	@echo '    HLM_TILLER_CONNECTION_TIMEOUT=$(HLM_TILLER_CONNECTION_TIMEOUT)'
	@echo '    HLM_TILLER_DEPLOYMENT_NAME=$(HLM_TILLER_DEPLOYMENT_NAME)'
	@echo '    HLM_TILLER_HISTORY_MAX=$(HLM_TILLER_HISTORY_MAX)'
	@echo '    HLM_TILLER_HOSTPORT=$(HLM_TILLER_HOSTPORT)'
	@echo '    HLM_TILLER_IMAGE_NAME=$(HLM_TILLER_IMAGE_NAME)'
	@echo '    HLM_TILLER_IMAGE_REGISTRY=$(HLM_TILLER_IMAGE_REGISTRY)'
	@echo '    HLM_TILLER_IMAGE_TAG=$(HLM_TILLER_IMAGE_TAG)'
	@echo '    HLM_TILLER_LOCAREPO_URL=$(HLM_TILLER_LOCALREPO_URL)'
	@echo '    HLM_TILLER_NAMESPACE_NAME=$(HLM_TILLER_NAMESPACE_NAME)'
	@echo '    HLM_TILLER_NODE_SELECTORS=$(HLM_TILLER_NODE_SELECTORS)'
	@echo '    HLM_TILLER_OVERRIDE=$(HLM_TILLER_OVERRIDE)'
	@echo '    HLM_TILLER_POD_SELECTOR=$(HLM_TILLER_POD_SELECTOR)'
	@echo '    HLM_TILLER_REPLICA_COUNT=$(HLM_TILLER_REPLICA_COUNT)'
	@echo '    HLM_TILLER_SERVICE_NAME=$(HLM_TILLER_SERVICE_NAME)'
	@echo '    HLM_TILLER_SERVICEACCOUNT_NAME=$(HLM_TILLER_SERVICEACCOUNT_NAME)'
	@echo '    HLM_TILLER_STABLEREPO_URL=$(HLM_TILLER_STABLEREPO_URL)'
	@echo '    HLM_TILLER_TLS_CACERT=$(HLM_TILLER_TLS_CACERT)'
	@echo '    HLM_TILLER_TLS_CERT=$(HLM_TILLER_TLS_CERT)'
	@echo '    HLM_TILLER_TLS_ENABLE=$(HLM_TILLER_TLS_ENABLE)'
	@echo '    HLM_TILLER_TLS_KEY=$(HLM_TILLER_TLS_KEY)'
	@echo '    HLM_TILLER_TLS_VERIFY=$(HLM_TILLER_TLS_VERIFY)'
	@#echo '    HLM_TILLER_UPGRADE_ENABLE=$(HLM_TILLER_UPGRADE_ENABLE)'
	@echo '    HLM_TILLER_WAIT_ENABLE=$(HLM_TILLER_WAIT_ENABLE)'
	@echo

_hlm_view_framework_targets ::
	@echo 'HeLM::Tiller ($(_HELM_TILLER_MK_VERSION)) targets:'
	@echo '    _hlm_install_tiller               - Install tiller on cluster'
	@echo '    _hlm_show_tiller                  - Show everything related to tiller'
	@echo '    _hlm_show_tiller_version          - Show version of tiller'
	@echo '    _hlm_uninstall_tiller             - Uninstall tiller on cluster'
	@#echo '    _hlm_update_tiller_image          - Update the image of tiller deployment'
	@echo '    _hlm_upgrade_tiller               - Update the configuration, image, and version of tiller'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_hlm_install_tiller:
	@$(INFO) '$(HLM_UI_LABEL)Installing tiller in the cluster...'; $(NORMAL)
	@$(WARN) 'This operation configure helm on the client and server side'; $(NORMAL)
	$(HELM) init $(strip $(__HLM_CANARY_IMAGE) $(__HLM_CLIENT_ONLY) $(__HLM_DRY_RUN__TILLER) $(__HLM_FORCE_UPGRADE__TILLER) $(__HLM_HISTORY_MAX) $(__HLM_LOCAL_REPO_URL) $(__HLM_NET_HOST) $(__HLM_NODE_SELECTORS__TILLER) $(__HLM_OUTPUT__TILLER) $(__HLM_OVERRIDE__TILLER) $(__HLM_REPLICAS) $(__HLM_SERVICE_ACCOUNT) $(__HLM_SKIP_REFRESH) $(__HLM_STABLE_REPO_URL) $(__HLM_TILLER_IMAGE) $(__HLM_TILLER_TLS) $(__HLM_TILLER_TLS_CERT) $(__HLM_TILLER_TLC_KEY) $(__HLM_TILLER_TLS_VERIFY) $(__HLM_TLS_CA_CERT) $(_X__HLM_UPGRADE__TILLER) $(__HLM_WAIT__TILLER) )

_hlm_show_tiller: _hlm_show_tiller_commands _hlm_show_tiller_pods _hlm_show_tiller_version

_hlm_show_tiller_commands:
	@#$(INFO) '$(HLM_UI_LABEL)Showing commands to interface with tiller ...'; $(NORMAL)
	@#echo 'Tiller is available at HLM_TILLER_HOSTPORT=$(HLM_TILLER_HOSTPORT)'

_hlm_show_tiller_pods:
	@$(INFO) '$(HLM_UI_LABEL)Showing pods of tiller ...'; $(NORMAL)
	@$(WARN) 'This operation requires the kubectl utility to be configured'; $(NORMAL)
	$(if $(KUBECTL),$(KUBECTL) get pods --namespace $(HLM_TILLER_NAMESPACE_NAME) --selector $(HLM_TILLER_POD_SELECTOR))

_hlm_show_tiller_version:
	@$(INFO) '$(HLM_UI_LABEL)Showing version of tiller ...'; $(NORMAL)
	@$(WARN) 'The HELM_HOST must point to the tiller host:port'; $(NORMAL)
	$(HELM) version --server

# _hlm_update_tiller_image:
# 	@$(INFO) '$(HLM_UI_LABEL)Updting image of tiller ...'; $(NORMAL)
# 	@$(WARN) 'This operation requires the kubectl utility to be configured'; $(NORMAL)
# 	$(if $(KUBECTL),$(KUBECTL) set image deployment/$(HLM_TILLER_DEPLOYMENT_NAME) --namespace $(HLM_TILLER_NAMESPACE_NAME) --tiller=$(HLM_TILLER_IMAGE_NAME) )

_hlm_upgrade_tiller:
	@$(INFO) '$(HLM_UI_LABEL)Upgrading tiller in the cluster...'; $(NORMAL)
	@$(WARN) 'This operation upgrades the version of tiller and its configuration'; $(NORMAL)
	# curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash
	$(HELM) init $(strip $(__HLM_CANARY_IMAGE) $(__HLM_CLIENT_ONLY) $(__HLM_DRY_RUN__TILLER) $(__HLM_FORCE_UPGRADE__TILLER) $(__HLM_HISTORY_MAX) $(__HLM_LOCAL_REPO_URL) $(__HLM_NET_HOST) $(__HLM_NODE_SELECTORS__TILLER) $(__HLM_OUTPUT__TILLER) $(__HLM_OVERRIDE__TILLER) $(__HLM_REPLICAS) $(__HLM_SERVICE_ACCOUNT) $(__HLM_SKIP_REFRESH) $(__HLM_STABLE_REPO_URL) $(__HLM_TILLER_IMAGE) $(__HLM_TILLER_TLS) $(__HLM_TILLER_TLS_CERT) $(__HLM_TILLER_TLC_KEY) $(__HLM_TILLER_TLS_VERIFY) $(__HLM_TLS_CA_CERT) $(_X__HLM_UPGRADE__TILLER) --upgrade $(__HLM_WAIT__TILLER) )

_hlm_uninstall_tiller:
	@$(INFO) '$(HLM_UI_LABEL)Uninstalling tiller ...'; $(NORMAL)
	@$(WARN) 'This operation requires the kubectl utility to be configured'; $(NORMAL)
	-$(if $(KUBECTL),$(KUBECTL) delete deployment --namespace $(HLM_TILLER_NAMESPACE_NAME) $(HLM_TILLER_DEPLOYMENT_NAME))
	-$(if $(KUBECTL),$(KUBECTL) delete clusterrolebinding $(HLM_TILLER_CLUSTERROLEBINDING_NAME))
	-$(if $(KUBECTL),$(KUBECTL) delete serviceaccount --namespace $(HLM_TILLER_NAMESPACE_NAME) $(HLM_TILLER_SERVICEACCOUNT_NAME))
	-$(if $(KUBECTL),$(KUBECTL) delete service --namespace $(HLM_TILLER_NAMESPACE_NAME) $(HLM_TILLER_SERVICE_NAME))
