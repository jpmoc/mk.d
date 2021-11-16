_ISTIOCTL_ISTIOPROXY_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

# ICL_ISTIOPROXY_CLUSTER_NAME?= "outbound|9080||reviews.default.svc.cluster.local"
ICL_ISTIOPROXY_CONTAINER_NAME?= istio-proxy
# ICL_ISTIOPROXY_NAME?= istio-proxy@<my-pod>
# ICL_ISTIOPROXY_NAMESPACE_NAME?= istio-system
# ICL_ISTIOPROXY_PILOT_HOST?= istio-pilot.istio-system.svc.cluster.local
# ICL_ISTIOPROXY_PILOT_HOSTPORT?= istio-pilot.istio-system.svc.cluster.local:8080
# ICL_ISTIOPROXY_POD_NAME?=
# ICL_ISTIOPROXY_PODS_SELECTOR?= app=something
ICL_ISTIOPROXY_PORT?= 15000
# ICL_ISTIOPROXY_PORTFORWARD_PORTS?= 15000:15000
# ICL_ISTIOPROXY_URL?= http://localhost:15000
# ICL_ISTIOPROXY_URL_DNSNAME?= localhost
# ICL_ISTIOPROXY_URL_PORT?= :15000
# ICL_ISTIOPROXY_URL_PROTOCOL?= http://
# ICL_ISTIOPROXIES_NAMESPACE_NAME?=
# ICL_ISTIOPROXIES_SET_NAME?=

# Derived parameters
ICL_ISTIOPROXY_NAME?= $(ICL_ISTIOPROXY_CONTAINER_NAME)$(if $(ICL_ISTIOPROXY_POD_NAME),@$(ICL_ISTIOPROXY_POD_NAME))
ICL_ISTIOPROXY_NAMESPACE_NAME?= $(ICL_APPMANIFEST_NAMESPACE_NAME)
ICL_ISTIOPROXY_PILOT_HOST?= $(ICL_ISTIOPILOT_HOST)
ICL_ISTIOPROXY_PILOT_HOSTPORT?= $(ICL_ISTIOPILOT_HOSTPORT)
ICL_ISTIOPROXY_URL?= $(ICL_ISTIOPROXY_URL_PROTOCOL)$(ICL_ISTIOPROXY_DNSNAME)$(ICL_ISTIOPROXY_PORT)
ICL_ISTIOPROXIES_NAMESPACE_NAME?= $(ICL_ISTIOPROXY_NAMESPACE_NAME)

# Options
__ICL_CLUSTER__ISTIOPROXY= $(if $(ICL_ISTIOPROXY_CLUSTER_NAME),--cluster $(ICL_ISTIOPROXY_CLUSTER_NAME))
__ICL_CONTAINER__ISTIOPROXY= $(if $(ICL_ISTIOPROXY_CONTAINER_NAME),--container $(ICL_ISTIOPROXY_CONTAINER_NAME))
__ICL_NAMESPACE__ISTIOPROXY= $(if $(ICL_ISTIOPROXY_NAMESPACE_NAME),--namespace $(ICL_ISTIOPROXY_NAMESPACE_NAME))
__ICL_SELECTOR__ISTIOPROXY= $(if $(ICL_ISTIOPROXY_PODS_SELECTOR),--selector $(ICL_ISTIOPROXY_PODS_SELECTOR))

# Customizations
|_ICL_CHECK_ISTIOPROXY_MTLS?= | head -20; echo '...'
|_ICL_CHECK_ISTIOPROXY_NOMTLS?= | head -20; echo '...'
|_ICL_SHOW_ISTIOPROXY_BOOTSTRAP?= | head -20; echo '...'
|_ICL_SHOW_ISTIOPROXY_CERTIFICATE?= | openssl x509 -text -noout
|_ICL_SHOW_ISTIOPROXY_CONFIG?= | head -20; echo '...'
|_ICL_SHOW_ISTIOPROXY_ENDPOINTS?= | sort --reverse
|_ICL_SHOW_ISTIOPROXY_REALLISTENERS?= | head -20; echo '...'
|_ICL_SHOW_ISTIOPROXY_VIRTUALLISTENERS?= | sort --key 1,2 --reverse

#--- Macros
_icl_get_istioproxy_pod_name= $(call _icl_get_istioproxy_pod_name_S, $(ICL_ISTIOPROXY_PODS_SELECTOR))
_icl_get_istioproxy_pod_name_S= $(call _icl_get_istioproxy_pod_name_SN, $(1), $(ICL_ISTIOPROXY_NAMESPACE_NAME))
_icl_get_istioproxy_pod_name_SN= $(firstword $(shell $(KUBECTL) get pods --namespace $(2) --output name --selector $(1) | sed 's.pod/..' ))

#----------------------------------------------------------------------
# USAGE
#

_icl_list_macros ::
	@echo 'IstioCtL::IstioProxy ($(_ISTIOCTL_ISTIOPROXY_MK_VERSION)) macros:'
	@echo '    _icl_get_istioproxy_pod_name_{|S|SN}       - Get the pod of an istio-proxy (Selector,Namespace)'
	@echo

_icl_list_parameters ::
	@echo 'IstioCtl::IstioProxy ($(_ISTIOCTL_ISTIOPROXY_MK_VERSION)) variables:'
	@echo '    ICL_ISTIOPROXY_CLUSTER_NAME=$(ICL_ISTIOPROXY_CLUSTER_NAME)'
	@echo '    ICL_ISTIOPROXY_CONTAINER_NAME=$(ICL_ISTIOPROXY_CONTAINER_NAME)'
	@echo '    ICL_ISTIOPROXY_NAME=$(ICL_ISTIOPROXY_NAME)'
	@echo '    ICL_ISTIOPROXY_NAMESPACE_NAME=$(ICL_ISTIOPROXY_NAMESPACE_NAME)'
	@echo '    ICL_ISTIOPROXY_PILOT_HOSTPORT=$(ICL_ISTIOPROXY_PILOT_HOSTPORT)'
	@echo '    ICL_ISTIOPROXY_POD_NAME=$(ICL_ISTIOPROXY_POD_NAME)'
	@echo '    ICL_ISTIOPROXY_PODS_SELECTOR=$(ICL_ISTIOPROXY_PODS_SELECTOR)'
	@echo '    ICL_ISTIOPROXY_PORT=$(ICL_ISTIOPROXY_PORT)'
	@echo '    ICL_ISTIOPROXY_PORTFORWARD_PORTS=$(ICL_ISTIOPROXY_PORTFORWARD_PORTS)'
	@echo '    ICL_ISTIOPROXY_URL=$(ICL_ISTIOPROXY_URL)'
	@echo '    ICL_ISTIOPROXIES_NAMESPACE_NAME=$(ICL_ISTIOPROXIES_NAMESPACE_NAME)'
	@echo '    ICL_ISTIOPROXIES_SET_NAME=$(ICL_ISTIOPROXIES_SET_NAME)'
	@echo

_icl_list_targets ::
	@echo 'IstioCtl::IstioProxy ($(_ISTIOCTL_ISTIOPROXY_MK_VERSION)) targets:'
	@echo '    _icl_check_istioproxy                       - Check everything related to an istio-proxy'
	@echo '    _icl_check_istioproxy_connectionconfig      - Check connections between an external-pod and an istio-proxy'
	@echo '    _icl_check_istioproxy_mtls                  - Check a mTLS connection between an external-pod and an istio-proxy'
	@echo '    _icl_check_istioproxy_nomtls                - Check a non-mTLS connection between an external-pod and an istio-proxy'
	@echo '    _icl_list_istioproxies                      - List all istio-proxies'
	@echo '    _icl_list_istioproxies_set                  - List a set of istio-proxies'
	@echo '    _icl_open_istioproxy                        - Open an istio-proxy dashboard'
	@echo '    _icl_portfoward_istioproxy                  - Port-forward to an istio-proxy'
	@echo '    _icl_show_istioproxy                        - Show everything related to an istio-proxy'
	@echo '    _icl_show_istioproxy_authpolicies           - Show the authentication-policies of an istio-proxy'
	@echo '    _icl_show_istioproxy_bootstrap              - Show the bootstrap configuration of an istio-proxy'
	@echo '    _icl_show_istioproxy_clusters               - Show the clusters of an istio-proxy'
	@echo '    _icl_show_istioproxy_config                 - Show the config-dump of an istio-proxy'
	@echo '    _icl_show_istioproxy_connectionconfig       - Show the connection-settings of an istio-proxy'
	@echo '    _icl_show_istioproxy_description            - Show description of an istio-proxy'
	@echo '    _icl_show_istioproxy_certificate            - Show certificate of an istio-proxy'
	@echo '    _icl_show_istioproxy_endpoints              - Show the endpoints of an istio-proxy'
	@echo '    _icl_show_istioproxy_internals              - Show the internals of an istio-proxy'
	@echo '    _icl_show_istioproxy_listeners              - Show the listeners of an istio-proxy'
	@echo '    _icl_show_istioproxy_logconfig              - Show the log-config of an istio-proxy'
	@echo '    _icl_show_istioproxy_pilotconfigdiff        - Show the config-diff between pilot and an istio-proxy'
	@echo '    _icl_show_istioproxy_pod                    - Show pod of an istio-proxy'
	@echo '    _icl_show_istioproxy_reallisteners          - Show the real-listeners of an istio-proxy'
	@echo '    _icl_show_istioproxy_resources              - Show resouces linked to an istio-proxy'
	@echo '    _icl_show_istioproxy_routes                 - Show the routes of an istio-proxy'
	@echo '    _icl_show_istioproxy_service                - Show service of an istio-proxy'
	@echo '    _icl_show_istioproxy_secrets                - Show secrets of an istio-proxy'
	@echo '    _icl_show_istioproxy_virtuallisteners       - Show the virtual-listeners of an istio-proxy'
	@echo '    _icl_ssh_istioproxy                         - Ssh into an istio-proxy'
	@echo '    _icl_update_istioproxy_logconfig            - Update the log-configuration of an istio-proxy'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_check_istioproxy :: _icl_check_istioproxy_connectionconfig _icl_check_istioproxy_mtls _icl_check_istioproxy_nomtls

_icl_check_istioproxy_connectionconfig:
	@$(INFO) '$(ICL_UI_LABEL)Checking connection-config between an external-pod and istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The mTLS configuration can is set at a cluster-level in the mesh-policy'
	@$(WARN) '* When PERMISSIVE mode is enabled in the mesh-policy, services can accept plaintext and mTLS traffic at the same time'
	@$(WARN) '* When STRICT mode is enabled in the mesh-policy, mTLS connections are enforced and plaintext traffic is dropped'
	@$(WARN) 'For a gradual roll-out (PERMISSIVE), mTLS configuration can be set a service-to-service level in destination-rules'
	@$(WARN) '* When DISABLE mode is enabled in a destinatyion-rule, plaintext/HTTP is sent by the client to reach the server'
	@$(WARN) '* When ISTIO_MUTUAL mode is enabled in a destination-rule, mTLS is initiated by the client to reach the server/host'
	@$(WARN) '* When MUTUAL mode is enabled in a destination-rule, same as ISTIO_MUTUAL but with a custom certificate (tls secret)'
	@$(WARN) '* When SIMPLE mode is enabled in a destination-rule, TLS connection to envoy-upstream endpoint (like https)'; $(NORMAL)
	$(ISTIOCTL) authn tls-check $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) $(ICL_ISTIOPROXY_PILOT_HOST)

_icl_check_istioproxy_mtls:
	@$(INFO) '$(ICL_UI_LABEL)Checking mTLS connections between pilot and istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation attemps to connect from the pod to pilot using mTLS'; $(NORMAL)
	@$(WARN) 'This operation fails if mTLS is disabled and non-usage of mTLS is enforced'; $(NORMAL)
	-$(KUBECTL) exec $(__ICL_CONTAINER__ISTIOPROXY) $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) -- curl --cert /etc/certs/cert-chain.pem --cacert /etc/certs/root-cert.pem --key /etc/certs/key.pem --silent http://$(ICL_ISTIOPROXY_PILOT_HOSTPORT)/debug/edsz $(|_ICL_CHECK_ISTIOPROXY_MTLS)

_icl_check_istioproxy_nomtls:
	@$(INFO) '$(ICL_UI_LABEL)Checking non-mTLS connections between an external-pod and istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation attampts ito connect from the istio-proxy to the external-pod without using mTLS'; $(NORMAL)
	@$(WARN) 'This operation fails if usage of mTLS is enforced'; $(NORMAL)
	$(KUBECTL) exec $(__ICL_CONTAINER__ISTIOPROXY) $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) -- curl --silent http://$(ICL_ISTIOPROXY_PILOT_HOSTPORT)/debug/edsz $(|_ICL_CHECK_ISTIOPROXY_NOMTLS)

_icl_list_istioproxies:
	@$(INFO) '$(ICL_UI_LABEL)Listing ALL istio-proxies ...'; $(NORMAL)
	$(ISTIOCTL) proxy-status $(_X__ICL_NAMESPACE__ISTIOPROXY)

_icl_list_istioproxies_set:
	@$(INFO) '$(ICL_UI_LABEL)Listing istio-proxies-set "$(ICL_ISTIOPROXIES_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'The Istio-proxies are grouped based on provided namespace'; $(NORMAL)
	$(ISTIOCTL) proxy-status $(__ICL_NAMESPACE__ISTIOPROXY)

_icl_open_istioproxy:
	@$(INFO) '$(ICL_UI_LABEL)Opening dashboard of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) dashboard envoy $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME)

_icl_portfoward_istioproxy:
	@$(INFO) '$(ICL_UI_LABEL)Port-forwarding to istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) port-forward $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) $(ICL_ISTIOPROXY_PORTFORWARD_PORTS)

_ICL_SHOW_ISTIOPROXY_TARGETS?= _icl_show_istioproxy_bootstrap _icl_show_istioproxy_config _icl_show_istioproxy_connectionconfig _icl_show_istioproxy_internals _icl_show_istioproxy_logconfig _icl_show_istioproxy_resources _icl_show_istioproxy_version _icl_show_istioproxy_description
_icl_show_istioproxy: $(_ICL_SHOW_ISTIOPROXY_TARGETS)

_icl_show_istioproxy_authpolicies:
	@$(INFO) '$(ICL_UI_LABEL)Showing authentication-policies of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) authn tls-check $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME)

_icl_show_istioproxy_bootstrap:
	@$(INFO) '$(ICL_UI_LABEL)Showing bootstrap of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the required bootstrap configuration that includes information like where Pilot can be found'; $(NORMAL)
	$(ISTIOCTL) proxy-config bootstrap $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) $(|_ICL_SHOW_ISTIOPROXY_BOOTSTRAP)

_icl_show_istioproxy_certificate:
	@$(INFO) '$(ICL_UI_LABEL)Showing certificate of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If the issuer is organization = cluster, then the certificate is managed by istio'
	@$(WARN) 'If this is an istio-managed certificate, it should be valid for 90 days'; $(NORMAL)
	-$(KUBECTL) exec $(__ICL_CONTAINER__ISTIOPROXY) $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) -- ls -al /etc/certs
	-$(KUBECTL) exec $(__ICL_CONTAINER__ISTIOPROXY) $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) -- cat /etc/certs/cert-chain.pem $(|_ICL_SHOW_ISTIOPROXY_CERTIFICATE)

_icl_show_istioproxy_config:
	@$(INFO) '$(ICL_UI_LABEL)Showing config of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	-$(KUBECTL) exec $(__ICL_CONTAINER__ISTIOPROXY) $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) -- curl --request GET --silent localhost:15000/config_dump $(|_ICL_SHOW_ISTIOPROXY_CONFIG)

_icl_show_istioproxy_connectionconfig: _icl_show_istioproxy_authpolicies _icl_show_istioproxy_certificate 

_icl_show_istioproxy_clusters:
	@$(INFO) '$(ICL_UI_LABEL)Showing clusters of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) proxy-config clusters $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME)

_icl_show_istioproxy_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing description of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@echo 'ICL_ISTIOPROXY_URL=$(ICL_ISTIOPROXY_URL)'; $(NORMAL)

_icl_show_istioproxy_endpoints:
	@$(INFO) '$(ICL_UI_LABEL)Showing endpoints of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) proxy-config endpoints $(_X__ICL_CLUSTER__ISTIOPROXY) $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) $(|_ICL_SHOW_ISTIOPROXY_ENDPOINTS)

_icl_show_istioproxy_internals: _icl_show_istioproxy_clusters _icl_show_istioproxy_endpoints _icl_show_istioproxy_listeners _icl_show_istioproxy_routes


_icl_show_istioproxy_listeners: _icl_show_istioproxy_reallisteners _icl_show_istioproxy_virtuallisteners _icl_show_istioproxy_listenerports

_icl_show_istioproxy_listenerports:
	@$(INFO) '$(ICL_UI_LABEL)Showing listener-ports of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Source @ https://istio.io/docs/ops/deployment/requirements/#ports-used-by-istio'; $(NORMAL)
	@echo '    PORT     PROTOCOL     USED BY                            DESCRIPTION'
	@echo '      53     TCP          Kube-DNS                           Cluster DNS service'
	@echo '      80     TCP          Kube-dashboard                     Cluster Kubernetes dashboard'
	@echo '     443     TCP          Kube-API                           Cluster Kubernetes API'
	@echo '                          Kube-metrics-server                Cluster methics-server'
	@echo '                          Egress-gateway                     Istio egress gateway'
	@echo '                          Galley                             Istio ingress gateway'
	@echo '                          Ingress-gateway                    Istio ingress gateway'
	@echo '                          Sidecar-Injector                   Istio sidecar injector'
	@echo '    8060     HTTP         Citadel                            GRPC server' 
	@echo '    8080     HTTP         Citadel agent                      SDS service monitoring' 
	@echo '    9090     HTTP         Prometheus                         Prometheus' 
	@echo '    9091     HTTP         Mixer                              Policy/Telemetry'
	@echo '    9093     HTTP         Citadel                            TCP server'
	@echo '    9876     HTTP         Citadel, Citadel agent             ControlZ user interface'
	@echo '    9901     GRPC         GAlley                             Mesh Configuratoin Protocol'
	@echo '   15000     TCP          Envoy                              Envoy admin port (commands/diagnostics)'
	@echo '   15001     TCP          Envoy                              Envoy outbound'
	@echo '   15004     HTTP         Mixer,Pilot                        Policy/Telemetry - mTLS'
	@echo '   15006     TCP          Envoy                              Envoy inbound'
	@echo '   15010     HTTP         Pilot                              Pilot service - XDS pilot - discovery'
	@echo '   15011     TCP          Pilot                              Pilot service - mTLS - Proxy - discovery'
	@echo '   15014     HTTP         Citadel, Mixer, Pilot, Sidecar     Control-plane monitoring'
	@echo '   15020     HTTP         Ingress Gataeway                   Pilot health checks'
	@echo '   15030     HTTP         Prometheus                         Prometheus User Interface'
	@echo '   15031     HTTP         Grafana                            Grafana User Interface'
	@echo '   15031     HTTP         Tracing                            Tracing User Interface'
	@echo '   15090     HTTP         Mixer                              Proxy'
	@echo '   42422     TCP          Mixer                              Telemetry - Prometheus'
	@echo

_icl_show_istioproxy_logconfig:
	@$(INFO) '$(ICL_UI_LABEL)Showing log-config of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'By default, the log level of all the facilities is set to "warning"'; $(NORMAL)
	$(ISTIOCTL) proxy-config log $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME)

_icl_show_istioproxy_pilot: _icl_show_istioproxy_pilotconnection _icl_show_istioproxy_pilotconfigdiff

_icl_show_istioproxy_pilotconfigdiff:
	@$(INFO) '$(ICL_UI_LABEL)Showing config-diff between pilot and istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation shows what has is out of sync and where the issue may lie'; $(NORMAL)
	$(ISTIOCTL) proxy-status $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME)

_icl_show_istioproxy_pod:
	@$(INFO) '$(ICL_UI_LABEL)Showing pod of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Unless misconfigured, this operation returns exactly one pod'; $(NORMAL)
	$(KUBECTL) get pods $(__ICL_NAMESPACE__ISTIOPROXY) $(__ICL_SELECTOR__ISTIOPROXY)

_icl_show_istioproxy_reallisteners:
	@$(INFO) '$(ICL_UI_LABEL)Showing real-listeners of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Every sidecar has a real-listener bound to 0.0.0.0:15001 which is where IP tables routes all inbound and outbound pod traffic to'; $(NORMAL)
	@$(WARN) 'If the listener has useOriginalDst set to true which means it hands the request over to the listener that best matches the original destination of the request'; $(NORMAL)
	@$(WARN) 'If proxy cannot find any matching virtual listeners it sends the request to the PassthroughCluster which connects to the destination directly'; $(NORMAL)
	$(ISTIOCTL) proxy-config listeners  $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) --port 15001 --output json $(|_ICL_SHOW_ISTIOPROXY_REALLISTENERS)

_icl_show_istioproxy_resources: _icl_show_istioproxy_pod _icl_show_istioproxy_secrets _icl_show_istioproxy_service

_icl_show_istioproxy_routes:
	@$(INFO) '$(ICL_UI_LABEL)Showing routes of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) proxy-config routes $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME)

_icl_show_istioproxy_secrets:
	@$(INFO) '$(ICL_UI_LABEL)Showing secrets of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) proxy-config secret $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) 

_icl_show_istioproxy_service:
	@$(INFO) '$(ICL_UI_LABEL)Showing service of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Unless misconfigured, this operation returns exactly one service'; $(NORMAL)
	$(KUBECTL) get service $(__ICL_NAMESPACE__ISTIOPROXY) $(__ICL_SELECTOR__ISTIOPROXY)

_icl_show_istioproxy_virtuallisteners:
	@$(INFO) '$(ICL_UI_LABEL)Showing virtual-listeners of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns virtual-listeners for inbound and outbound HTTP and non-HTTP traffic'; $(NORMAL)
	@$(WARN) 'Inbound virtual-listeners:'
	@$(WARN) '   * match the IP address of the pod'; $(NORMAL)
	@$(WARN) '   * match an exposed port by the main container'; $(NORMAL)
	@$(WARN) '   * receive all inbound traffic from real-listener 0.0.0.0:15001'; $(NORMAL)
	@$(WARN) 'Outbound virtual-listeners:'
	@$(WARN) '   * match 0.0.0.0 or the IP address of a service IP'
	@$(WARN) '   * match IP:PORT or PORT of external destination'; $(NORMAL)
	@$(WARN) '   * receive all outbound traffic from real-listener 0.0.0.0:15001'; $(NORMAL)
	$(ISTIOCTL) proxy-config listeners $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) $(|_ICL_SHOW_ISTIOPROXY_VIRTUALLISTENERS)

_icl_show_istioproxy_version:
	@$(INFO) '$(ICL_UI_LABEL)Showing version of istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) exec -it --container istio-proxy $(__ICL_NAMESPACE__ISTIOPROXY)  $(ICL_ISTIOPROXY_POD_NAME)  pilot-agent request GET server_info

_icl_ssh_istioproxy:
	@$(INFO) '$(ICL_UI_LABEL)Ssh-ing into istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) exec $(__ICL_CONTAINER__ISTIOPROXY) -i $(__ICL_NAMESPACE__ISTIOPROXY) --tty=true $(ICL_ISTIOPROXY_POD_NAME) -- /bin/bash

_icl_update_istioproxy_logconfig:
	@$(INFO) '$(ICL_UI_LABEL)Updating the log-config for istio-proxy "$(ICL_ISTIOPROXY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) exec $(__ICL_CONTAINER__ISTIOPROXY) $(__ICL_NAMESPACE__ISTIOPROXY) $(ICL_ISTIOPROXY_POD_NAME) -- curl --request POST --silent localhost:15000/logging?rbac=debug 
