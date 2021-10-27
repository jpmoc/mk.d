_KUBECTL_ISTIO_INGRESSGATEWAY_MK_VERSION=$(_KUBECTL_ISTIO_MK_VERSION)

KCL_ISTIOINGRESSGATEWAY_DEPLOYMENT_NAME?= istio-ingressgateway
# KCL_ISTIOINGRESSGATEWAY_DIG?= dig
# KCL_ISTIOINGRESSGATEWAY_DNSNAME?=
# KCL_ISTIOINGRESSGATEWAY_IP?=
# KCL_ISTIOINGRESSGATEWAY_NAMESPACE_NAME?= istio-system
# KCL_ISTIOINGRESSGATEWAY_PODS_NAMES?= istio-ingressgateway-7781233-fdj23 ...
KCL_ISTIOINGRESSGATEWAY_PORTFORWARD_PORTMAPPINGS?= 15000:15000
# KCL_ISTIOINGRESSGATEWAY_URL?= http://localhost:15000
KCL_ISTIOINGRESSGATEWAY_URL_DNSNAME?= localhost
# KCL_ISTIOINGRESSGATEWAY_URL_PATH?= /my/path
KCL_ISTIOINGRESSGATEWAY_URL_PORT?= :15000
KCL_ISTIOINGRESSGATEWAY_URL_PROTOCOL?= http://

# Derived parameters
KCL_ISTIOINGRESSGATEWAY_DIG?= $(KCL_ISTIO_DIG)
KCL_ISTIOINGRESSGATEWAY_NAMESPACE_NAME?= $(KCL_ISTIO_NAMESPACE_NAME)
KCL_ISTIOINGRESSGATEWAY_URL?= $(KCL_ISTIOINGRESSGATEWAY_URL_PROTOCOL)$(KCL_ISTIOINGRESSGATEWAY_URL_DNSNAME)$(KCL_ISTIOINGRESSGATEWAY_URL_PORT)$(KCL_ISTIOINGRESSGATEWAY_URL_PATH)

KCL_ISTIOINGRESSGATEWAYCONFIG_CURL?= $(KCL_ISTIO_CURL)
KCL_ISTIOINGRESSGATEWAYCONFIG_URL?= $(KCL_ISTIOINGRESSGATEWAY_URL)/config_dump

# Option parameters
__KCL_NAMESPACE__ISTIOINGRESSGATEWAY?= --namespace $(KCL_ISTIOINGRESSGATEWAY_NAMESPACE_NAME)

# UI parameters
_KCL_SHOW_ISTIOINGRESSGATEWAYCONFIG_CONTENT|?= [ -f $(KCL_ISTIOINGRESSGATEWAY_CONFIG_FILEPATH) ] &&
|_KCL_SHOW_ISTIOINGRESSGATEWAYCONFIG_CONTENT?=

_KCL_PORTFORWARD_ISTIOINGRESSGATEWAY_|?= while true; do
|_KCL_PORTFORWARD_ISTIOINGRESSGATEWAY?= || sleep 10; date; done
|_KCL_SHOW_ISTIOINGRESSGATEWAY_CONFIG?= | yq eval -P 'sortKeys(..)' - # | tee envoy.yaml

#--- Utilities

#--- MACROS

_kcl_get_istioingressgateway_dnsname= $(call _kcl_get_istioingressgateway_dnsname_N, $(KCL_ISTIOINGRESSGATEWAY_NAMESPACE_NAME))
_kcl_get_istioingressgateway_dnsname_N= $(shell $(KUBECTL) get service --namespace $(1) istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

_kcl_get_istioingressgateway_ip= $(call _kcl_get_istioingressgateway_ip_N, $(KCL_ISTIOINGRESSGATEWAY_NAMESPACE_NAME))
_kcl_get_istioingressgateway_ip_N= $(shell $(KUBECTL) get service --namespace $(1) istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Istio::IngressGateway ($(_KUBECTL_ISTIO_MK_VERSION)) macros:'
	@echo '    _kcl_get_istioingress_dnsname_{|N}          - Get the DNS-name of the istio-ingress-gateway (Namespace)'
	@echo '    _kcl_get_istioingress_ip_{|N}               - Get the IP of the istio-ingress-gateway (Namespace)'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Istio::IngressGateway ($(_KUBECTL_ISTIO_MK_VERSION)) parameters:'
	@echo '    KCL_ISTIOINGRESSGATEWAY_DEPLOYMENT_NAME=$(KCL_ISTIOINGRESSGATEWAY_DEPLOYMENT_NAME)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_DNSNAME=$(KCL_ISTIOINGRESSGATEWAY_DNSNAME)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_IP=$(KCL_ISTIOINGRESSGATEWAY_IP)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_NAMESPACE_NAME=$(KCL_ISTIOINGRESSGATEWAY_NAMESPACE_NAME)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_PODS_NAMES=$(KCL_ISTIOINGRESSGATEWAY_PODS_NAMES)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_SERVICE_NAME=$(KCL_ISTIOINGRESSGATEWAY_SERVICE_NAME)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_PORTFORWARD_PORTMAPPINGS=$(KCL_ISTIOINGRESSGATEWAY_PORTFORWARD_PORTMAPPINGS)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_URL=$(KCL_ISTIOINGRESSGATEWAY_URL)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_URL_DNSNAME=$(KCL_ISTIOINGRESSGATEWAY_URL_DNSNAME)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_URL_PATH=$(KCL_ISTIOINGRESSGATEWAY_URL_PATH)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_URL_PORT=$(KCL_ISTIOINGRESSGATEWAY_URL_PORT)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_URL_PROTOCOL=$(KCL_ISTIOINGRESSGATEWAY_URL_PROTOCOL)'
	@echo
	@echo '    KCL_ISTIOINGRESSGATEWAYCONFIG_DIRPATH=$(KCL_ISTIOINGRESSGATEWAYCONFIG_DIRPATH)'
	@echo '    KCL_ISTIOINGRESSGATEWAYCONFIG_FILENAME=$(KCL_ISTIOINGRESSGATEWAYCONFIG_FILENAME)'
	@echo '    KCL_ISTIOINGRESSGATEWAYCONFIG_FILEPATH=$(KCL_ISTIOINGRESSGATEWAYCONFIG_FILEPATH)'
	@echo '    KCL_ISTIOINGRESSGATEWAYCONFIG_URL=$(KCL_ISTIOINGRESSGATEWAYCONFIG_URL)'
	@echo

_view_framework_targets :: _kcl_view_framework_targets
_kcl_view_framework_targets ::
	@echo 'KubeCtL::Istio::IngressGateway ($(_KUBECTL_ISTIO_MK_VERSION)) targets:'
	@echo '    dig_istioingressgateway           - Dig the ingress gateway'
	@#echo '    portforward_istioingressgateway   - Port-forward to the ingress gateway'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_dump_istioingressgatewayconfig:
	@$(INFO) '$(KCL_UI_LABEL)Dumping the istio-ingressgateway configuration'; $(NORMAL)
	$(KCL_ISTIOINGRESSGATEWAYCONFIG_CURL) $(KCL_ISTIOINGRESSGATEWAYCONFIG_URL) $(|_KCL_DUMP_ISTIOINGRESSGATEWAYCONFIG)

_kcl_show_istioingressgatewayconfig: _kcl_show_istioingressgatewayconfig_content _kcl_show_istioingressgatewayconfig_tlscertificate

_kcl_show_istioingressgatewayconfig_content:
	@$(INFO) '$(KCL_UI_LABEL)Showing content of the istio-ingressgateway configuration'; $(NORMAL)
	@$(WARN) 'This operation works only if you have already dumped the istio-ingressgataeway config'; $(NORMAL)
	$(if $(KCL_ISTIOINGRESSGATEWAYCONFIG_FILEPATH), \
		$(_KCL_SHOW_ISTIOINGRESSGATEWAYCONFIG_CONTENT|)cat $(KCL_ISTIOINGRESSGATEWAYCONFIG_FILEPATH)$(|_KCL_SHOW_ISTIOINGRESSGATEWAYCONFIG_CONTENT), \
		@echo "KCL_ISTIOINGRESSGATEWAYCONFIG_FILEPATH not set ..."\
	)

_kcl_show_istioingressgatewayconfig_tlscertificate:
	@$(INFO) '$(KCL_UI_LABEL)Showing tls-certificate in the istio-ingressgateway configuration'; $(NORMAL)
	@$(WARN) 'This operation works only if you have already dumped the istio-ingressgataeway config'; $(NORMAL)
	$(_KCL_SHOW_ISTIOINGRESSGATEWAYCONFIG_CONTENT|)cat $(KCL_ISTIOINGRESSGATEWAYCONFIG_FILEPATH) | yq eval '.configs.5.dynamic_active_secrets.0.secret.tls_certificate' -

_kcl_dig_istioingressgateway:
	@$(INFO) '$(KCL_UI_LABEL)Dig-ing the istio-ingress-gateway'; $(NORMAL)
	$(KCL_ISTIOINGRESSGATEWAY_DIG) $(KCL_ISTIOINGRESSGATEWAY_DNSNAME)

# _kcl_portforward_istioingressgateway:
# 	@$(INFO) '$(KCL_UI_LABEL)Port-forwarding the istio-ingress-gateway'; $(NORMAL)
# 	$(_KCL_PORTFORWARD_ISTIOINGRESSGATEWAY_|)$(KUBECTL) port-forward $(__KCL_NAMESPACE__ISTIOINGRESSGATEWAY) deployment/$(KCL_ISTIOINGRESSGATEWAY_DEPLOYMENT_NAME) $(KCL_ISTIOINGRESSGATEWAY_PORTFORWARD_PORTMAPPINGS) $(|_KCL_PORTFORWARD_ISTIOINGRESSGATEWAY)

_KCL_SHOW_ISTIOINGRESSGATEWAY_TARGETS: _kcl_show_istioingressgateway_deployment _kcl_show_istioingressgataeway_config _kcl_show_istioingressgatewat_pod _kcl_show_istioingressgateway_service _kcl_show_istioingressgateway_description
_kcl_show_istioingressgateway: $(_KCL_SHOW_ISTIOINGRESSGATEWAY_TARGETS)

_kcl_show_istioingressgateway_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Showing deployment of istio-ingressgateway'; $(NORMAL)
	$(KUBECTL) get deployment $(__KCL_NAMESPACE__ISTIOINGRESSGATEWAY) $(KCL_ISTIOINGRESSGATEWAY_DEPLOYMENT_NAME)

_kcl_show_istioingressgateway_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of istio-ingressgateway'; $(NORMAL)
	# Under construction!

_kcl_show_istioingressgateway_pod:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods of istio-ingressgateway'; $(NORMAL)
	$(if $(KCL_ISTIOINGRESSGATEWAY_PODS_NAMES), \
		$(KUBECTL) get pods $(__KCL_NAMESPACE__ISTIOINGRESSGATEWAY) $(KCL_ISTIOINGRESSGATEWAY_PODS_NAMES) \
	, @\
		echo 'KCL_ISTIOINGRESSGATEWAY_PODS_NAMES not set!' \
	)

_kcl_show_istioingressgateway_service:
	@$(INFO) '$(KCL_UI_LABEL)Showing service of istio-ingressgateway'; $(NORMAL)
	$(KUBECTL) get service $(__KCL_NAMESPACE__ISTIOINGRESSGATEWAY) $(KCL_ISTIOINGRESSGATEWAY_SERVICE_NAME)
