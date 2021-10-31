_KUBECTL_MK_VERSION= 1.0.0

# KCL_AS_GROUP?=
# KCL_AS_USER?=
# KCL_CACHE_DIR?= $(HOME)/.kube/http-cache
# KCL_CERTIfICATE_AUTHORITY?=
# KCL_CERTIfICATE_CLIENT?=
# KCL_CERTIfICATE_KEY?=
# KCL_CLUSTER?=
# KCL_CURL?= curl -v
# KCL_DATE_YYYYMMDD_HHMMSS?=
# KCL_DIG?= dig
# KCL_INPUTS_DIRPATH?= ./in/
# KCL_INSECURE_TLS?= false
# KCL_LOG_ALSOOSTDERR?= false
# KCL_LOG_BACKTRACE_AT?= :0
# KCL_LOG_DIR?=
# KCL_LOG_FLUSH_FEQUENCEY?= 5s
# KCL_LOG_TOSTDERR?= true
# KCL_MATCH_SERVER_VERSION?= false
# KCL_OUTPUT_FORMAT?= yaml
# KCL_OUTPUTS_DIRPATH?= ./out/
# KCL_REQUEST_TIMEOUT?= 0
# KCL_SERVER?=
# KCL_WATCH_ONLY?= true
# KUBECTL_CONTEXT_NAME?= k1.emayssat-c2.k8s.local
KUBECTL_KUBECONFIG_DIRPATH?= $(HOME)/.kube/
KUBECTL_KUBECONFIG_FILENAME?= config
# KUBECTL_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config
# KUBECTL_STDERR_THRESHOLD?=
# KUBECTL_TOKEN?=
# KUBECTL_USER?=
KUBECTL_VERBOSITY_LEVEL?= 0
# KUBECTL_VMODULE?=

# Derived parameters
KCL_CURL?= $(CURL)
KCL_DATE_YYYYMMDD_HHMMSS?= $(CMN_DATE_YYYYMMDD_HHMMSS)
KCL_DIG?= $(DIG)
KCL_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
KCL_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
KUBECTL_CONTEXT_NAME?= $(KCL_CONTEXT_NAME)
KUBECTL_KUBECONFIG_FILEPATH?= $(KUBECTL_KUBECONFIG_DIRPATH)$(KUBECTL_KUBECONFIG_FILENAME)

# Option parameters

# UI parameters
KCL_UI_LABEL?= [kubectl] #

#--- Utilities
__KUBECTL_OPTIONS+= $(if $(KCL_LOG_ALSOTOSTDERR),--alsologtostderr=$(KCL_ALSOLOGTOSTDERR))#
__KUBECTL_OPTIONS+= $(if $(KCL_AS_USER),--as=$(KCL_AS_USER))#
__KUBECTL_OPTIONS+= $(if $(KCL_AS_GROUP),--as-group=[$(KCL_AS_GROUP)])#
__KUBECTL_OPTIONS+= $(if $(KCL_CACHE_DIR),--cache-dir=$(KCL_CACHE_DIR))#
__KUBECTL_OPTIONS+= $(if $(KCL_CERTIFICATE_AUTHORITY),--certificate-authority=$(KCL_CERTIFICATE_AUTHORITY))#
__KUBECTL_OPTIONS+= $(if $(KCL_CERTIFICATE_CLIENT),--certificate-client=$(KCL_CERTIFICATE_CLIENT))#
__KUBECTL_OPTIONS+= $(if $(KCL_CERTIFICATE_KEY),--certificate-key=$(KCL_CERTIFICATE_KEY))#
__KUBECTL_OPTIONS+= $(if $(KCL_CLUSTER),--cluster=$(KCL_CLUSTER))#
__KUBECTL_OPTIONS+= $(if $(KUBECTL_CONTEXT_NAME),--context $(KUBECTL_CONTEXT_NAME))#
__KUBECTL_OPTIONS+= $(if $(KCL_INSECURE_TLS),--insecure-skip-tls-verify=$(KCL_INSECURE_TLS))#
__KUBECTL_OPTIONS+= $(if $(KUBECTL_KUBECONFIG_FILEPATH),--kubeconfig=$(KUBECTL_KUBECONFIG_FILEPATH))#
__KUBECTL_OPTIONS+= $(if $(KCL_LOG_BACKTRACE_AT),--log-backtrace-at=$(KCL_LOG_BACKTRACE_AT))#
__KUBECTL_OPTIONS+= $(if $(KCL_LOG_DIR),--log-dir=$(KCL_LOG_DIR))#
__KUBECTL_OPTIONS+= $(if $(KCL_LOG_FLUSH_FREQUENCY),--log-flush-frequency=$(KCL_LOG_FLUSH_FREQUENCY))#
__KUBECTL_OPTIONS+= $(if $(KCL_LOG_TOSTDERR),--logtostderr=$(KCL_LOG_TOSTDERR))#
__KUBECTL_OPTIONS+= $(if $(KCL_MATCH_SERVER_VERSION),--match-server-version=$(KCL_MATCH_SERVER_VERSION))#
__KUBECTL_OPTIONS+= $(if $(KCL_REQUEST_TIMEOUT),--request-timeout=$(KCL_REQUEST_TIMEOUT))#
__KUBECTL_OPTIONS+= $(if $(KCL_SERVER),--server=$(KCL_SERVER))#
__KUBECTL_OPTIONS+= $(if $(KUBECTL_STDERR_THRESHOLD),--stderrthreshold=$(KUBECTL_STDERR_THRESHOLD))#
__KUBECTL_OPTIONS+= $(if $(KUBECTL_TOKEN),--token=$(KUBECTL_TOKEN))#
__KUBECTL_OPTIONS+= $(if $(KUBECTL_USER),--user=$(KUBECTL_USER))#
__KUBECTL_OPTIONS+= $(if $(KUBECTL_VERBOSITY_LEVEL),--v=$(KUBECTL_VERBOSITY_LEVEL))#
__KUBECTL_OPTIONS+= $(if $(KUBECTL_VMODULE),--vmodule=$(KUBECTL_VMODULE))#

KUBECTL_BIN?= kubectl
KUBECTL?= $(strip $(__KUBECTL_ENVIRONMENT) $(KUBECTL_ENVIRONMENT) $(KUBECTL_BIN) $(__KUBECTL_OPTIONS) $(KUBECTL_OPTIONS))

KUBECTL_KREW_BIN?= kubectl-krew
KUBECTL_KREW?= $(strip $(__KUBECTL_KREW_ENVIRONMENT) $(KUBECTL_KREW_ENVIRONMENT) $(KUBECTL_KREW_BIN) $(__KUBECTL_KREW_OPTIONS) $(KUBECTL_KREW_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _kcl_list_macros
_kcl_list_macros ::
	@#echo 'KubeCtL ($(_KUBECTL_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _kcl_list_parameters
_kcl_list_parameters ::
	@echo 'KubeCtL ($(_KUBECTL_MK_VERSION)) parameters:'
	@echo '    KCL_AS_GROUP=$(KCL_AS_GROUP)'
	@echo '    KCL_AS_USER=$(KCL_AS_USER)'
	@echo '    KCL_CACHE_DIR=$(KCL_CACHE_DIR)'
	@echo '    KCL_CERTIFICATE_AUTHORITY=$(KCL_CERTIFICATE_AUTHORITY)'
	@echo '    KCL_CERTIFICATE_CLIENT=$(KCL_CERTIFICATE_CLIENT)'
	@echo '    KCL_CERTIFICATE_KEY=$(KCL_CERTIFICATE_KEY)'
	@echo '    KCL_CLUSTER=$(KCL_CLUSTER)'
	@echo '    KCL_CURL=$(KCL_CURL)'
	@echo '    KCL_DATE_YYYYMMDD_HHMMSS=$(KCL_DATE_YYYYMMDD_HHMMSS)'
	@echo '    KCL_INPUTS_DIRPATH=$(KCL_INPUTS_DIRPATH)'
	@echo '    KCL_INSECURE_TLS=$(KCL_INSECURE_TLS)'
	@echo '    KCL_LOG_ASLOTOSTDERR=$(KCL_LOG_ASLOTOSTDERR)'
	@echo '    KCL_LOG_BACKTRACE_AT=$(KCL_LOG_BACKTRACE_AT)'
	@echo '    KCL_LOG_DIR=$(KCL_LOG_DIR)'
	@echo '    KCL_LOG_FLUSH_FREQUENCY=$(KCL_LOG_FLUSH_FREQUENCY)'
	@echo '    KCL_LOG_TOSTDERR=$(KCL_LOG_TOSTDERR)'
	@echo '    KCL_MATCH_SERVER_VERSION=$(KCL_MATCH_SERVER_VERSION)'
	@#echo '    KCL_NAMESPACE=$(KCL_NAMESPACE)'
	@echo '    KCL_OUTPUT_FORMAT=$(KCL_OUTPUT_FORMAT)'
	@echo '    KCL_OUTPUTS_DIRPATH=$(KCL_OUTPUTS_DIRPATH)'
	@echo '    KCL_REQUEST_TIMEOUT=$(KCL_REQUEST_TIMEOUT)'
	@echo '    KCL_SERVER=$(KCL_SERVER)'
	@echo '    KCL_WATCH_ONLY=$(KCL_WATCH_ONLY)'
	@echo '    KUBECTL=$(KUBECTL)'
	@echo '    KUBECTL_CONTEXT_NAME=$(KUBECTL_CONTEXT_NAME)'
	@echo '    KUBECTL_KUBECONFIG_DIRPATH=$(KUBECTL_KUBECONFIG_DIRPATH)'
	@echo '    KUBECTL_KUBECONFIG_FILENAME=$(KUBECTL_KUBECONFIG_FILENAME)'
	@echo '    KUBECTL_KUBECONFIG_FILEPATH=$(KUBECTL_KUBECONFIG_FILEPATH)'
	@echo '    KUBECTL_STDERR_THRESHDLD=$(KUBECTL_STDERR_THRESHOLD)'
	@echo '    KUBECTL_TOKEN=$(KUBECTL_TOKEN)'
	@echo '    KUBECTL_USER=$(KUBECTL_USER)'
	@echo '    KUBECTL_VERBOSITY_LEVEL=$(KUBECTL_VERBOSITY_LEVEL)'
	@echo '    KUBECTL_VMODULE=$(KUBECTL_VMODULE)'
	@echo

_list_targets :: _kcl_list_targets
_kcl_list_targets ::
	@echo 'KubeCtL ($(_KUBECTL_MK_VERSION)) targets:'
	@echo '    _kcl_install_dependencies              - Install dependencies'
	@echo '    _kcl_list_secrettypes                  - List all secret-types'
	@echo '    _kcl_view_versions                     - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/kubectl_api.mk
-include $(MK_DIR)/kubectl_certificatesigningrequest.mk
-include $(MK_DIR)/kubectl_certificate.mk
-include $(MK_DIR)/kubectl_cluster.mk
-include $(MK_DIR)/kubectl_clusterrole.mk
-include $(MK_DIR)/kubectl_clusterrolebinding.mk
-include $(MK_DIR)/kubectl_configmap.mk
-include $(MK_DIR)/kubectl_context.mk
-include $(MK_DIR)/kubectl_cronjob.mk
-include $(MK_DIR)/kubectl_customresourcedefinition.mk
-include $(MK_DIR)/kubectl_daemonset.mk
-include $(MK_DIR)/kubectl_deployment.mk
-include $(MK_DIR)/kubectl_endpoint.mk
-include $(MK_DIR)/kubectl_event.mk
-include $(MK_DIR)/kubectl_horizontalpodautoscaler.mk
-include $(MK_DIR)/kubectl_ingress.mk
-include $(MK_DIR)/kubectl_job.mk
-include $(MK_DIR)/kubectl_kubeconfig.mk
-include $(MK_DIR)/kubectl_kubesystem.mk
-include $(MK_DIR)/kubectl_kustomization.mk
-include $(MK_DIR)/kubectl_limitrange.mk
-include $(MK_DIR)/kubectl_manifest.mk
-include $(MK_DIR)/kubectl_mutatingwebhookconfiguration.mk
-include $(MK_DIR)/kubectl_namespace.mk
-include $(MK_DIR)/kubectl_networkpolicy.mk
-include $(MK_DIR)/kubectl_node.mk
-include $(MK_DIR)/kubectl_persistentvolume.mk
-include $(MK_DIR)/kubectl_persistentvolumeclaim.mk
-include $(MK_DIR)/kubectl_pod.mk
-include $(MK_DIR)/kubectl_poddisruptionbudget.mk
-include $(MK_DIR)/kubectl_podsecuritypolicy.mk
-include $(MK_DIR)/kubectl_priorityclass.mk
-include $(MK_DIR)/kubectl_quota.mk
-include $(MK_DIR)/kubectl_replicaset.mk
-include $(MK_DIR)/kubectl_role.mk
-include $(MK_DIR)/kubectl_rolebinding.mk
-include $(MK_DIR)/kubectl_rollout.mk
-include $(MK_DIR)/kubectl_secret.mk
-include $(MK_DIR)/kubectl_service.mk
-include $(MK_DIR)/kubectl_serviceaccount.mk
-include $(MK_DIR)/kubectl_stack.mk #!?!?
-include $(MK_DIR)/kubectl_statefulset.mk
-include $(MK_DIR)/kubectl_storageclass.mk
-include $(MK_DIR)/kubectl_thirdpartyresource.mk
-include $(MK_DIR)/kubectl_user.mk
-include $(MK_DIR)/kubectl_validatingwebhookconfiguration.mk
-include $(MK_DIR)/kubectl_verticalpodautoscaler.mk
-include $(MK_DIR)/kubectl_volumesnapshot.mk

# Plugins
-include $(MK_DIR)/kubectl_sniff.mk

# Utilities
-include $(MK_DIR)/kubectl_dnsclient.mk

# CRDS
-include $(MK_DIR)/kubectl_azureassignedidentity.mk
-include $(MK_DIR)/kubectl_azureidentity.mk
-include $(MK_DIR)/kubectl_azureidentitybinding.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _kcl_install_dependencies
_kcl_install_dependencies :: __kcl_install_kubectl __kcl_install_krew

_kcl_list_secrettypes:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL secret-types ...'; $(NORMAL)
	@echo 'Type: generic/Opaque                      ~~> key-value pair secret for pods'; $(NORMAL)
	@echo 'Type: kubernetes.io/dockerconfigjson      ~~> docker registry credentials'; $(NORMAL)
	@echo 'Type: kubernetes.io/service-account-token ~~> RBAC for pods'; $(NORMAL)
	@echo 'Type: kubernetes.io/tls                   ~~> HTTPS certificate for ingress-pods'; $(NORMAL)
	@echo

_view_versions :: _kcl_show_versions
_kcl_show_versions ::
	@$(INFO) '$(KCL_UI_LABEL)Showing versions of dependencies ...'; $(NORMAL)
	kubectl version --short --client
	# Latest version of kubectl ...
	curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
