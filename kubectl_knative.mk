_KUBECTL_KNATIVE_MK_VERSION= 0.99.4

# KCL_KNATIVE_CURL?= time curl
# KCL_KNATIVE_DIG?= dig +short
KCL_KNATIVE_DNSNAME_DOMAIN?= example.com
# KCL_KNATIVE_NETWORKLAYER_TYPE?= istio
# KCL_KNATIVE_RELEASE?= v0.20.0
# KCL_KNATIVEEVENTING_DNSNAME_DOMAIN?= svc.cluster.local
KCL_KNATIVEEVENTING_CONFIGDOCS_FLAG?= false
KCL_KNATIVEEVENTING_NAMESPACE_NAME?= knative-eventing
# KCL_KNATIVEEVENTING_RELEASE?= v0.20.0
# KCL_KNATIVESERVING_CURL?= time curl
# KCL_KNATIVESERVING_DIG?= dig +short
# KCL_KNATIVESERVING_DNSNAME_DOMAIN?= example.com
KCL_KNATIVESERVING_CONFIGDOCS_FLAG?= false
KCL_KNATIVESERVING_ISTIOINGRESSGATEWAY_NAME?= knative-ingress-gateway
# KCL_KNATIVESERVING_ISTIOINGRESSGATEWAY_NAMESPACE?= knative-serving
KCL_KNATIVESERVING_NAMESPACE_NAME?= knative-serving
# KCL_KNATIVESERVING_RELEASE?= v0.20.0

# Derived parameters
KCL_KNATIVE_CURL?= $(KCL_CURL)
KCL_KNATIVE_DIG?= $(KCL_DIG)
KCL_KNATIVEEVENTING_CURL?= $(KCL_KNATIVE_CURL)
KCL_KNATIVEEVENTING_DIG?= $(KCL_KNATIVE_DIG)
KCL_KNATIVEEVENTING_DNSNAME_DOMAIN?= $(KCL_KNATIVE_DNSNAME_DOMAIN)
KCL_KNATIVEEVENTING_RELEASE?= $(KCL_KNATIVE_RELEASE)
KCL_KNATIVESERVING_CURL?= $(KCL_KNATIVE_CURL)
KCL_KNATIVESERVING_DIG?= $(KCL_KNATIVE_DIG)
KCL_KNATIVESERVING_DNSNAME_DOMAIN?= $(KCL_KNATIVE_DNSNAME_DOMAIN)
KCL_KNATIVESERVING_ISTIOINGRESSGATEWAY_NAMESPACE?= $(KCL_KNATIVESERVING_NAMESPACE_NAME)
KCL_KNATIVESERVING_RELEASE?= $(KCL_KNATIVE_RELEASE)

# OptionS
__KCL_NAMESPACE__KNATIVEEVENTING= --namespace $(KCL_KNATIVEEVENTING_NAMESPACE_NAME)
__KCL_NAMESPACE__KNATIVESERVING= --namespace $(KCL_KNATIVESERVING_NAMESPACE_NAME)

# Customizations
_KCL_SHOW_KNATIVESERVING_AUTOSCALERCONFIG_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
_KCL_SHOW_KNATIVESERVING_CONFIG_|?= # true ||
_KCL_SHOW_KNATIVESERVING_CONFIGMAPS_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
_KCL_SHOW_KNATIVESERVING_DEFAULTSCONFIG_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
_KCL_SHOW_KNATIVESERVING_DEPLOYMENTCONFIG_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
_KCL_SHOW_KNATIVESERVING_DOMAINCONFIG_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
_KCL_SHOW_KNATIVESERVING_FEATURESCONFIG_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
_KCL_SHOW_KNATIVESERVING_GCCONFIG_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
_KCL_SHOW_KNATIVESERVING_ISTIOCONFIG_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
_KCL_SHOW_KNATIVESERVING_LEADERELECTIONCONFIG_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
_KCL_SHOW_KNATIVESERVING_LOGGINGCONFIG_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
_KCL_SHOW_KNATIVESERVING_NETWORKCONFIG_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
_KCL_SHOW_KNATIVESERVING_OBSERVABILITYCONFIG_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
_KCL_SHOW_KNATIVESERVING_TRACINGCONFIG_|?= $(_KCL_SHOW_KNATIVESERVING_CONFIG_|)
|_KCL_SHOW_KNATIVESERVING_AUTOSCALERCONFIG?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)
|_KCL_SHOW_KNATIVESERVING_CONFIG?= # | head -10
|_KCL_SHOW_KNATIVESERVING_CONFIGMAPS?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)
|_KCL_SHOW_KNATIVESERVING_DEFAULTSCONFIG?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)
|_KCL_SHOW_KNATIVESERVING_DEPLOYMENTCONFIG?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)
|_KCL_SHOW_KNATIVESERVING_DOMAINCONFIG?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)
|_KCL_SHOW_KNATIVESERVING_FEATURESCONFIG?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)
|_KCL_SHOW_KNATIVESERVING_GCCONFIG?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)
|_KCL_SHOW_KNATIVESERVING_ISTIOCONFIG?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)
|_KCL_SHOW_KNATIVESERVING_LEADERELECTIONCONFIG?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)
|_KCL_SHOW_KNATIVESERVING_LOGGINGCONFIG?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)
|_KCL_SHOW_KNATIVESERVING_NETWORKCONFIG?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)
|_KCL_SHOW_KNATIVESERVING_OBSERVABILITYCONFIG?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)
|_KCL_SHOW_KNATIVESERVING_TRACINGCONFIG?= $(|_KCL_SHOW_KNATIVESERVING_CONFIG)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Knative:: ($(_KUBECTL_KNATIVE_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Knative:: ($(_KUBECTL_KNATIVE_MK_VERSION)) parameters:'
	@echo '    KCL_KNATIVE_DNSNAME_DOMAIN=$(KCL_KNATIVE_DNSNAME_DOMAIN)'
	@echo '    KCL_KNATIVE_NETWORKLAYER_TYPE=$(KCL_KNATIVE_NETWORKLAYER_TYPE)'
	@echo '    KCL_KNATIVE_RELEASE=$(KCL_KNATIVE_RELEASE)'
	@echo '    KCL_KNATIVEEVENTING_DNSNAME_DOMAIN=$(KCL_KNATIVEEVENTING_NAMESPACE_NAME)'
	@echo '    KCL_KNATIVEEVENTING_CONFIGDOCS_FLAG=$(KCL_KNATIVEEVENTING_CONFIGDOCS_FLAG)'
	@echo '    KCL_KNATIVEEVENTING_NAMESPACE_NAME=$(KCL_KNATIVEEVENTING_NAMESPACE_NAME)'
	@echo '    KCL_KNATIVEEVENTING_RELEASE=$(KCL_KNATIVEEVENTING_RELEASE)'
	@echo '    KCL_KNATIVESERVING_DNSNAME_DOMAIN=$(KCL_KNATIVESERVING_DNSNAME_DOMAIN)'
	@echo '    KCL_KNATIVESERVING_CONFIGDOCS_FLAG=$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)'
	@echo '    KCL_KNATIVESERVING_ISTIOINGRESSGATEWAY_NAME=$(KCL_KNATIVE_ISTIOINGRESSGAETWAY_NAME)'
	@echo '    KCL_KNATIVESERVING_ISTIOINGRESSGATEWAY_NAMESPACE=$(KCL_KNATIVE_ISTIOINGRESSGAETWAY_NAMESPACE)'
	@echo '    KCL_KNATIVESERVING_NAMESPACE_NAME=$(KCL_KNATIVESERVING_NAMESPACE_NAME)'
	@echo '    KCL_KNATIVESERVING_RELEASE=$(KCL_KNATIVESERVING_RELEASE)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Knative:: ($(_KUBECTL_KNATIVE_MK_VERSION)) targets:'
	@echo '    _kcl_list_sourcetypes                - List the types for sources'
	@echo '    _kcl_show_knative_config             - Show the config of knative components'
	@echo '    _kcl_show_knativeeventing_config     - Show the config of eventing components'
	@echo '    _kcl_show_knativeeventing_version    - Show version of eventing components'
	@echo '    _kcl_show_knativeserving_config      - Show the config of serving components'
	@echo '    _kcl_show_knativeserving_version     - Show version of serving components'
	@echo '    _kcl_view_knative_versions           - View versions of eventing and serving'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .

# Serving
-include $(MK_DIR)/kubectl_knative_configuration.mk
-include $(MK_DIR)/kubectl_knative_image.mk
-include $(MK_DIR)/kubectl_knative_kcertificate.mk
-include $(MK_DIR)/kubectl_knative_kingress.mk
-include $(MK_DIR)/kubectl_knative_kservice.mk
-include $(MK_DIR)/kubectl_knative_metrics.mk
-include $(MK_DIR)/kubectl_knative_podautoscaler.mk
-include $(MK_DIR)/kubectl_knative_revision.mk
-include $(MK_DIR)/kubectl_knative_route.mk
-include $(MK_DIR)/kubectl_knative_serverlessservice.mk

# Eventing
-include $(MK_DIR)/kubectl_knative_apiserversource.mk
-include $(MK_DIR)/kubectl_knative_broker.mk
-include $(MK_DIR)/kubectl_knative_channel.mk
-include $(MK_DIR)/kubectl_knative_containersource.mk
-include $(MK_DIR)/kubectl_knative_pingsource.mk
-include $(MK_DIR)/kubectl_knative_sinkbinding.mk
-include $(MK_DIR)/kubectl_knative_subscription.mk
-include $(MK_DIR)/kubectl_knative_trigger.mk

#----------------------------------------------------------------------
# EXTENSIONS TARGETS
#

_kcl_show_cluster__header :: # _kcl_show_cluster_globalnetworkpolicies

# _kcl_show_cluster_globalnetworkpolicies:
# 	@$(INFO) '$(KCL_UI_LABEL)Showing calico-global-network-policies in cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
# 	$(KUBECTL) get globalnetworkpolicies
# 
_kcl_show_namespace__header :: _kcl_show_namespace_brokers _kcl_show_namespace_kservices _kcl_show_namespace_revisions _kcl_show_namespace_routes _kcl_show_namespace_serverlessservices _kcl_show_namespace_subscriptions _kcl_show_namespace_triggers

_kcl_show_namespace_brokers:
	@$(INFO) '$(KCL_UI_LABEL)Showing knative-brokers in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if knative-eventing CRDs are not already installed!'; $(NORMAL)
	-$(KUBECTL) get brokers $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_kservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing knative-service in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if knative-serving CRDs are not already installed!'; $(NORMAL)
	-$(KUBECTL) get kservices $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_revisions:
	@$(INFO) '$(KCL_UI_LABEL)Showing knative-revisions in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if knative-serving CRDs are not already installed!'; $(NORMAL)
	-$(KUBECTL) get revisions $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_routes:
	@$(INFO) '$(KCL_UI_LABEL)Showing knative-routes in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if knative-serving CRDs are not already installed!'; $(NORMAL)
	-$(KUBECTL) get routes $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing knative-serverless-services in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if knative-serving CRDs are not already installed!'; $(NORMAL)
	-$(KUBECTL) get serverlessservices $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_subscriptions:
	@$(INFO) '$(KCL_UI_LABEL)Showing knative-subscriptions in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if knative-eventing CRDs are not already installed!'; $(NORMAL)
	-$(KUBECTL) get subscriptions $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_triggers:
	@$(INFO) '$(KCL_UI_LABEL)Showing knative-triggers in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if knative-eventing CRDs are not already installed!'; $(NORMAL)
	-$(KUBECTL) get triggers $(__KCL_NAMESPACE__NAMESPACE)

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_install_knative:
	# KNATIVE-SERVING
	# curl -L https://github.com/knative/serving/releases/download/v0.26.0/serving-crds.yaml
	# curl -L https://github.com/knative/serving/releases/download/v0.26.0/serving-core.yaml
	# ISTIO # curl -L https://github.com/knative/net-istio/releases/download/v0.26.0/istio.yaml
	# curl -L https://github.com/knative/net-istio/releases/download/v0.26.0/net-istio.yaml
	# KNATIVE-EVENTING

_kcl_list_sourcetypes:
	@$(INFO) '$(KCL_UI_LABEL)Listing supported knative-source-types ...'; $(NORMAL)
	$(KUBECTL) api-resources | grep sources.knative.dev

_kcl_show_knative_config: _kcl_show_knativeeventing_config _kcl_show_knativeserving_config

_kcl_show_knativeeventing_config: _kcl_show_knativeeventing_configmaps

_kcl_show_knativeeventing_configmaps:
	@$(INFO) '$(KCL_UI_LABEL)Showing ALL config-maps of knative-eventing ...'; $(NORMAL)
	$(KUBECTL) get configmap $(__KCL_NAMESPACE__KNATIVEEVENTING)


_kcl_show_knativeeventing_version:
	@$(INFO) '$(KCL_UI_LABEL)Installed version of knative-eventing ...'; $(NORMAL)
	@$(WARN) 'This operation fails if knative-eventing is not already installed!'; $(NORMAL)
	-kubectl get namespace knative-eventing -o 'go-template={{index .metadata.labels "serving.knative.dev/release"}}'
	@echo

# ifeq (KCL_KNATIVESERVING_NETWORKLAYER_TYPE,istio)
_KCL_SHOW_KNATIVESERVING_CONFIG_TARGETS?= _kcl_show_knativeserving_autoscalerconfig _kcl_show_knativeserving_defaultsconfig _kcl_show_knativeserving_deploymentconfig _kcl_show_knativeserving_domainconfig _kcl_show_knativeserving_featuresconfig _kcl_show_knativeserving_gcconfig _kcl_show_knativeserving_istioconfig _kcl_show_knativeserving_leaderelectionconfig _kcl_show_knativeserving_loggingconfig _kcl_show_knativeserving_networkconfig _kcl_show_knativeserving_observabilityconfig _kcl_show_knativeserving_tracingconfig _kcl_show_knativeserving_configmaps
# endif

_kcl_show_knativeserving_config :: $(_KCL_SHOW_KNATIVESERVING_CONFIG_TARGETS)

_kcl_show_knativeserving_autoscalerconfig:
	@$(INFO) '$(KCL_UI_LABEL)Showing the autoscaler-config of knative-serving ...'; $(NORMAL)
	@$(HIGHLIGHT)
	$(if $(filter true,$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)), \
		curl -L https://github.com/knative/serving/releases/download/$(KCL_KNATIVESERVING_RELEASE)/serving-core.yaml -s -o - | yq eval 'select(.metadata.name=="config-autoscaler").data._example' - \
	)
	@$(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_AUTOSCALERCONFIG_|)$(KUBECTL) describe configmap $(__KCL_NAMESPACE__KNATIVESERVING) config-autoscaler $(|_KCL_SHOW_KNATIVESERVING_AUTOSCALERCONFIG)

_kcl_show_knativeserving_configmaps:
	@$(INFO) '$(KCL_UI_LABEL)Showing ALL config-maps of knative-serving ...'; $(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_CONFIGMAPS_|)$(KUBECTL) get configmap $(__KCL_NAMESPACE__KNATIVESERVING)$(|_KCL_SHOW_KNATIVESERVING_CONFIGMAPS)

_kcl_show_knativeserving_defaultsconfig:
	@$(INFO) '$(KCL_UI_LABEL)Showing the defaults-config of knative-serving ...'; $(NORMAL)
	@$(HIGHLIGHT)
	$(if $(filter true,$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)), \
		curl -L https://github.com/knative/serving/releases/download/$(KCL_KNATIVESERVING_RELEASE)/serving-core.yaml -s -o - | yq eval 'select(.metadata.name=="config-defaults").data._example' - \
	)
	@$(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_DEFAULTSCONFIG_|)$(KUBECTL) describe configmap $(__KCL_NAMESPACE__KNATIVESERVING) config-defaults $(|_KCL_SHOW_KNATIVESERVING_DEFAULTSCONFIG)

_kcl_show_knativeserving_deploymentconfig:
	@$(INFO) '$(KCL_UI_LABEL)Showing the deployment-config of knative-serving ...'; $(NORMAL)
	@$(HIGHLIGHT)
	$(if $(filter true,$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)), \
		curl -L https://github.com/knative/serving/releases/download/$(KCL_KNATIVESERVING_RELEASE)/serving-core.yaml -s -o - | yq eval 'select(.metadata.name=="config-deployment").data._example' - \
	)
	@$(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_DEPLOYMENTCONFIG_|)$(KUBECTL) describe configmap $(__KCL_NAMESPACE__KNATIVESERVING) config-deployment $(|_KCL_SHOW_KNATIVESERVING_DEPLOYMENTCONFIG)

_kcl_show_knativeserving_domainconfig:
	@$(INFO) '$(KCL_UI_LABEL)Showing the domain-config of knative-serving ...'; $(NORMAL)
	@$(HIGHLIGHT)
	$(if $(filter true,$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)), \
		curl -L https://github.com/knative/serving/releases/download/$(KCL_KNATIVESERVING_RELEASE)/serving-core.yaml -s -o - | yq eval 'select(.metadata.name=="config-domain").data._example' - \
	)
	@$(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_DOMAINCONFIG_|)$(KUBECTL) describe configmap $(__KCL_NAMESPACE__KNATIVESERVING) config-domain $(|_KCL_SHOW_KNATIVESERVING_DOMAINCONFIG)

_kcl_show_knativeserving_featuresconfig:
	@$(INFO) '$(KCL_UI_LABEL)Showing the features-config of knative-serving ...'; $(NORMAL)
	@$(HIGHLIGHT)
	$(if $(filter true,$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)), \
		curl -L https://github.com/knative/serving/releases/download/$(KCL_KNATIVESERVING_RELEASE)/serving-core.yaml -s -o - | yq eval 'select(.metadata.name=="config-features").data._example' - \
	)
	@$(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_FEATURESCONFIG_|)$(KUBECTL) describe configmap $(__KCL_NAMESPACE__KNATIVESERVING) config-features $(|_KCL_SHOW_KNATIVESERVING_FEATURESCONFIG)
	# kubectl patch cm config-features -n knative-serving -p '{"data":{"tag-header-based-routing":"Enabled", "kubernetes.podspec-fieldref": "Enabled"}}'

_kcl_show_knativeserving_gcconfig:
	@$(INFO) '$(KCL_UI_LABEL)Showing the gc-config of knative-serving ...'; $(NORMAL)
	@$(HIGHLIGHT)
	$(if $(filter true,$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)), \
		curl -L https://github.com/knative/serving/releases/download/$(KCL_KNATIVESERVING_RELEASE)/serving-core.yaml -s -o - | yq eval 'select(.metadata.name=="config-gc").data._example' - \
	)
	@$(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_GCCONFIG_|)$(KUBECTL) describe configmap $(__KCL_NAMESPACE__KNATIVESERVING) config-gc $(|_KCL_SHOW_KNATIVESERVING_GCCONFIG)

_kcl_show_knativeserving_istioconfig:
	@$(INFO) '$(KCL_UI_LABEL)Showing the istio-config of knative-serving ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the config-map does NOT exist, if the network-layer is NOT istio'; $(NORMAL)
	@$(HIGHLIGHT)
	$(if $(filter true,$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)), \
		curl -L https://github.com/knative/net-istio/releases/download/$(KCL_KNATIVESERVING_RELEASE)/net-istio.yaml -s -o - | yq eval 'select(.metadata.name=="config-istio").data._example' - \
	)
	@$(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_ISTIOCONFIG_|)$(KUBECTL) describe configmap $(__KCL_NAMESPACE__KNATIVESERVING) config-istio $(|_KCL_SHOW_KNATIVESERVING_ISTIOCONFIG)

_kcl_show_knativeserving_leaderelectionconfig:
	@$(INFO) '$(KCL_UI_LABEL)Showing the leader-election-config of knative-serving ...'; $(NORMAL)
	@$(HIGHLIGHT)
	$(if $(filter true,$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)), \
		curl -L https://github.com/knative/serving/releases/download/$(KCL_KNATIVESERVING_RELEASE)/serving-core.yaml -s -o - | yq eval 'select(.metadata.name=="config-leader-election").data._example' - \
	)
	@$(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_LEADERELECTIONCONFIG_|)$(KUBECTL) describe configmap $(__KCL_NAMESPACE__KNATIVESERVING) config-leader-election $(|_KCL_SHOW_KNATIVESERVING_LEADERELECTIONCONFIG)

_kcl_show_knativeserving_loggingconfig:
	@$(INFO) '$(KCL_UI_LABEL)Showing the logging-config of knative-serving ...'; $(NORMAL)
	@$(HIGHLIGHT)
	$(if $(filter true,$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)), \
		curl -L https://github.com/knative/serving/releases/download/$(KCL_KNATIVESERVING_RELEASE)/serving-core.yaml -s -o - | yq eval 'select(.metadata.name=="config-logging").data._example' - \
	)
	@$(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_LOGGINGCONFIG_|)$(KUBECTL) describe configmap $(__KCL_NAMESPACE__KNATIVESERVING) config-logging $(|_KCL_SHOW_KNATIVESERVING_LOGGINGCONFIG)

_kcl_show_knativeserving_networkconfig:
	@$(INFO) '$(KCL_UI_LABEL)Showing the network-config of knative-serving ...'; $(NORMAL)
	@$(HIGHLIGHT)
	$(if $(filter true,$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)), \
		curl -L https://github.com/knative/serving/releases/download/$(KCL_KNATIVESERVING_RELEASE)/serving-core.yaml -s -o - | yq eval 'select(.metadata.name=="config-network").data._example' - \
	)
	@$(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_NETWORKCONFIG_|)$(KUBECTL) describe configmap $(__KCL_NAMESPACE__KNATIVESERVING) config-network $(|KCL_SHOW_KNATIVESERVING_NETWORKCONFIG)

_kcl_show_knativeserving_observabilityconfig:
	@$(INFO) '$(KCL_UI_LABEL)Showing the observability-config of knative-serving ...'; $(NORMAL)
	@$(HIGHLIGHT)
	$(if $(filter true,$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)), \
		curl -L https://github.com/knative/serving/releases/download/$(KCL_KNATIVESERVING_RELEASE)/serving-core.yaml -s -o - | yq eval 'select(.metadata.name=="config-observability").data._example' - \
	)
	@$(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_OBSERVABILITYCONFIG_|)$(KUBECTL) describe configmap $(__KCL_NAMESPACE__KNATIVESERVING) config-observability $(|_KCL_SHOW_KNATIVESERVING_OBSERVABILITYCONFIG)

_kcl_show_knativeserving_tracingconfig:
	@$(INFO) '$(KCL_UI_LABEL)Showing the tracing-config of knative-serving ...'; $(NORMAL)
	@$(HIGHLIGHT)
	$(if $(filter true,$(KCL_KNATIVESERVING_CONFIGDOCS_FLAG)), \
		curl -L https://github.com/knative/serving/releases/download/$(KCL_KNATIVESERVING_RELEASE)/serving-core.yaml -s -o - | yq eval 'select(.metadata.name=="config-tracing").data._example' - \
	)
	@$(NORMAL)
	$(_KCL_SHOW_KNATIVESERVING_TRACINGCONFIG_|)$(KUBECTL) describe configmap $(__KCL_NAMESPACE__KNATIVESERVING) config-tracing $(|_KCL_SHOW_KNATIVESERVING_TRACINGCONFIG)


_kcl_show_knativeserving_version:
	@$(INFO) '$(KCL_UI_LABEL)Installed version of knative-serving ...'; $(NORMAL)
	@$(WARN) 'This operation fails if knative-serving is not already installed!'; $(NORMAL)
	-kubectl get namespace $(KCL_KNATIVESERVING_NAMESPACE_NAME) -o 'go-template={{index .metadata.labels "serving.knative.dev/release"}}'
	@echo

_kcl_view_versions :: _kcl_view_knative_versions
_kcl_view_knative_versions :: _kcl_show_knativeeventing_version _kcl_show_knativeservice_version
