_KUBECTL_ISTIO_DASHBOARD_MK_VERSION= $(_KUBECTL_ISTIO_MK_VERSION)

# KCL_DASHBOARD_GRAPHANA_PORTS?=
KCL_DASHBOARD_JAEGER_PORTS?= 16686:16686# LocalPort:PodPort
KCL_DASHBOARD_KIALI_PORTS?= 20001:20001
# KCL_DASHBOARD_NAMESPACE_NAME?= istio-system
KCL_DASHBOARD_PROMETHEUS_PORTS?= 9090:9090
KCL_DASHBOARD_ZIPKIN_PORTS?= 9411:9411

# Derived parameters
KCL_DASHBOARD_NAMESPACE_NAME?= $(KCL_ISTIO_NAMESPACE_NAME)

# Option parameters
__KCL_ADDRESS__DASHBOARD=
__KCL_NAMESPACE__DASHBOARD= $(if $(KCL_DASHBOARD_NAMESPACE_NAME),--namespace $(KCL_DASHBOARD_NAMESPACE_NAME))
__KCL_POD_RUNNING_TIMEOUT__DASHBOARD=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Istio::Dashboard ($(_KUBECTL_ISTIO_DASHBOARD_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Istio::Dashboard ($(_KUBECTL_ISTIO_DASHBOARD_MK_VERSION)) parameters:'
	@echo '    KCL_DASHBOARD_GRAPHANA_PORTS=$(KCL_DASHBOARD_GRAPHANA_PORTS)'
	@echo '    KCL_DASHBOARD_JAEGER_PORTS=$(KCL_DASHBOARD_JAEGER_PORTS)'
	@echo '    KCL_DASHBOARD_KIALI_PORTS=$(KCL_DASHBOARD_KIALI_PORTS)'
	@echo '    KCL_DASHBOARD_NAMESPACE_NAME=$(KCL_DASHBOARD_NAMESPACE_NAME)'
	@echo '    KCL_DASHBOARD_PROMETHEUS_PORTS=$(KCL_DASHBOARD_PROMETHEUS_PORTS)'
	@echo '    KCL_DASHBOARD_ZIPKIN_PORTS=$(KCL_DASHBOARD_ZIPKIN_PORTS)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Istio::Dashboard ($(_KUBECTL_ISTIO_DASHBOARD_MK_VERSION)) targets:'
	@echo '    _kcl_portforward_graphana             - Port-forward to graphana'
	@echo '    _kcl_portforward_jaeger               - Port-forward to jaeger'
	@echo '    _kcl_portforward_kiali                - Port-forward to kiali'
	@echo '    _kcl_portforward_prometheus           - Port-forward to prometheus'
	@echo '    _kcl_portforward_zipkin               - Port-forward to zipkin'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_portforward_grafana:
	@$(INFO) '$(KCL_UI_LABEL)Port-forwarding to grafana ...'; $(NORMAL)
	# while true; do $(KUBECTL) port-forward $(__KCL_ADDRESS__DASHBOARD) $(__KCL_NAMESPACE__DASHBOARD) $(__KCL_POD_RUNNING_TIMEOUT__DASHBOARD) service/jaeger $(KCL_DASHBOARD_JAEGER_PORTS) || sleep 10 ; date; done

_kcl_portforward_jaeger:
	@$(INFO) '$(KCL_UI_LABEL)Port-forwarding to jaeger ...'; $(NORMAL)
	while true; do $(KUBECTL) port-forward $(__KCL_ADDRESS__DASHBOARD) $(__KCL_NAMESPACE__DASHBOARD) $(__KCL_POD_RUNNING_TIMEOUT__DASHBOARD) service/jaeger $(KCL_DASHBOARD_JAEGER_PORTS) || sleep 10 ; date; done

_kcl_portforward_kiali:
	@$(INFO) '$(KCL_UI_LABEL)Port-forwarding to kiali ...'; $(NORMAL)
	while true; do $(KUBECTL) port-forward $(__KCL_ADDRESS__DASHBOARD) $(__KCL_NAMESPACE__DASHBOARD) $(__KCL_POD_RUNNING_TIMEOUT__DASHBOARD) service/kiali $(KCL_DASHBOARD_KIALI_PORTS) || sleep 10 ; date; done

_kcl_portforward_prometheus:
	@$(INFO) '$(KCL_UI_LABEL)Port-forwarding to prometheus ...'; $(NORMAL)
	while true; do $(KUBECTL) port-forward $(__KCL_ADDRESS__DASHBOARD) $(__KCL_NAMESPACE__DASHBOARD) $(__KCL_POD_RUNNING_TIMEOUT__DASHBOARD) service/prometheus $(KCL_DASHBOARD_PROMETHEUS_PORTS) || sleep 10 ; date; done

_kcl_portforward_zipkin:
	@$(INFO) '$(KCL_UI_LABEL)Port-forwarding to zipkin ...'; $(NORMAL)
	# while true; do $(KUBECTL) port-forward $(__KCL_ADDRESS__DASHBOARD) $(__KCL_NAMESPACE__DASHBOARD) $(__KCL_POD_RUNNING_TIMEOUT__DASHBOARD) service/zipkin $(KCL_DASHBOARD_ZIPKIN_PORTS) || sleep 10 ; date; done
