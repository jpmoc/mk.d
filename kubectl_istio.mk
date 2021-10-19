_KUBECTL_ISTIO_MK_VERSION= 0.99.4

# KCL_ISTIO_CURL?= curl
KCL_ISTIO_NAMESPACE_NAME?= istio-system
# KCL_ISTIOINGRESSGATEWAY_DNSNAME?=
# KCL_ISTIOINGRESSGATEWAY_IP?=
# KCL_ISTIOINGRESSGATEWAY_NAMESPACE_NAME?= istio-system
# KCL_ISTIO_VERSION?= 1.10.3

# Derived parameters
KCL_ISTIO_CURL?= $(KCL_CURL)
KCL_ISTIO_DIG?= $(KCL_DIG)
KCL_ISTIOINGRESSGATEWAY_NAMESPACE_NAME?= $(KCL_ISTIO_NAMESPACE_NAME)

# Option parameters

# UI parameters

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
	@echo 'KubeCtL::Istio ($(_KUBECTL_ISTIO_MK_VERSION)) macros:'
	@echo '    _kcl_get_istioingress_dnsname_{|N}          - Get the DNS-name of the istio-ingress-gateway (Namespace)'
	@echo '    _kcl_get_istioingress_ip_{|N}               - Get the IP of the istio-ingress-gateway (Namespace)'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Istio ($(_KUBECTL_ISTIO_MK_VERSION)) parameters:'
	@echo '    KCL_ISTIO_NAMESPACE_NAME=$(KCL_ISTIO_NAMESPACE_NAME)'
	@echo '    KCL_ISTIO_VERSION=$(KCL_ISTIO_VERSION)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_DNSNAME=$(KCL_ISTIOINGRESSGATEWAY_DNSNAME)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_IP=$(KCL_ISTIOINGRESSGATEWAY_IP)'
	@echo '    KCL_ISTIOINGRESSGATEWAY_NAMESPACE_NAME=$(KCL_ISTIOINGRESSGATEWAY_NAMESPACE_NAME)'
	@echo

_view_framework_targets :: _kcl_view_framework_targets
_kcl_view_framework_targets ::
	@echo 'KubeCtL::Istio ($(_KUBECTL_ISTIO_MK_VERSION)) targets:'
	@echo '    dig_istioingressgateway           - Dig the ingress gateway'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/kubectl_istio_adapter.mk
-include $(MK_DIR)/kubectl_istio_attributemanifests.mk
-include $(MK_DIR)/kubectl_istio_authenticationpolicy.mk
-include $(MK_DIR)/kubectl_istio_authorizationpolicy.mk
-include $(MK_DIR)/kubectl_istio_clusterrbacconfigs.mk
-include $(MK_DIR)/kubectl_istio_dashboard.mk
-include $(MK_DIR)/kubectl_istio_destinationrule.mk
-include $(MK_DIR)/kubectl_istio_envoyfilters.mk
-include $(MK_DIR)/kubectl_istio_gateway.mk
-include $(MK_DIR)/kubectl_istio_handler.mk
-include $(MK_DIR)/kubectl_istio_httpapispecbinding.mk
-include $(MK_DIR)/kubectl_istio_httpapispecs.mk
-include $(MK_DIR)/kubectl_istio_instance.mk
-include $(MK_DIR)/kubectl_istio_meshpolicy.mk
# -include $(MK_DIR)/kubectl_istio_policy.mk # Renamed authenticationpolicy
-include $(MK_DIR)/kubectl_istio_quotaspecbinding.mk
-include $(MK_DIR)/kubectl_istio_quotaspec.mk
-include $(MK_DIR)/kubectl_istio_rbacconfig.mk
-include $(MK_DIR)/kubectl_istio_rule.mk
-include $(MK_DIR)/kubectl_istio_serviceentry.mk
-include $(MK_DIR)/kubectl_istio_servicerolebinding.mk
-include $(MK_DIR)/kubectl_istio_servicerole.mk
-include $(MK_DIR)/kubectl_istio_sidecar.mk
-include $(MK_DIR)/kubectl_istio_template.mk
-include $(MK_DIR)/kubectl_istio_virtualservice.mk

#----------------------------------------------------------------------
# EXTENSIONS TARGETS
#

_kcl_show_cluster__header :: _kcl_show_cluster_meshpolicies

_kcl_show_cluster_meshpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Showing istio-mesh-policies in cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get meshpolicies

_kcl_show_cluster_serviceentries::
	@$(INFO) '$(KCL_UI_LABEL)Showing istio-service-entries in cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get serviceentries

_kcl_show_namespace__header :: _kcl_show_namespace_authorizationpolicies _kcl_show_namespace_destinationrules _kcl_show_namespace_gateways _kcl_show_namespace_instances _kcl_show_namespace_virtualservices

_kcl_show_namespace_authorizationpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Showing istio-authorization-policies in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get authorizationpolicies $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_destinationrules:
	@$(INFO) '$(KCL_UI_LABEL)Showing istio-destination-rules in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get destinationrules $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_gateways:
	@$(INFO) '$(KCL_UI_LABEL)Showing istio-gateways in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get gateways $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_instances:
	@$(INFO) '$(KCL_UI_LABEL)Showing istio-instances in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	-$(KUBECTL) get instances $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_virtualservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing istio-virtual-services in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get virtualservices $(__KCL_NAMESPACE__NAMESPACE)

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_dig_istioingressgateway:
	@$(INFO) '$(KCL_UI_LABEL)Dig-ing the istio-ingress-gateway'; $(NORMAL)
	$(KCL_ISTIO_DIG) $(KCL_ISTIOINGRESSGATEWAY_DNSNAME)
