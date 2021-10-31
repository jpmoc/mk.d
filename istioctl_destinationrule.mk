_ISTIOCTL_DESTINATIONRULE_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

# ICL_DESTINATIONRULE_NAME?=  grafana-ports-mtls-disabled
# ICL_DESTINATIONRULE_NAMESPACE_NAME?= kube-vault
# ICL_DESTINATIONRULE_POD_NAME?= vault-release
# ICL_DESTINATIONRULE_SERVICE_HOST?= istio-pilot.istio-system.svc.cluster.local

# Derived parameters
ICL_DESTINATIONRULE_NAME?= $(KCL_DESTINATIONRULE_NAME)
ICL_DESTINATIONRULE_NAMESPACE_NAME?= $(KCL_POD_NAMESPACE_NAME)
ICL_DESTINATIONRULE_POD_NAME?= $(KCL_POD_NAME)
ICL_DESTINATIONRULE_SERVICE_HOST?= $(KCL_DESTINATIONRULE_SERVICE_HOST)

# Option parameters
__ICL_NAMESPACE__DESTINATIONRULE?= $(if $(ICL_DESTINATIONRULE_NAMESPACE_NAME),--namespace $(ICL_DESTINATIONRULE_NAMESPACE_NAME))

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_icl_list_macros ::
	@#echo 'IstioCtL::DestinationRule ($(_ISTIOCTL_DESTINATIONRULE_MK_VERSION)) macros:'
	@#echo

_icl_list_parameters ::
	@echo 'IstioCtl::DestinationRule ($(_ISTIOCTL_DESTINATIONRULE_MK_VERSION)) parameters:'
	@echo '    ICL_DESTINATIONRULE_NAME=$(ICL_DESTINATIONRULE_NAME)'
	@echo '    ICL_DESTINATIONRULE_NAMESPACE_NAME=$(ICL_DESTINATIONRULE_NAMESPACE_NAME)'
	@echo '    ICL_DESTINATIONRULE_POD_NAME=$(ICL_DESTINATIONRULE_POD_NAME)'
	@echo '    ICL_DESTINATIONRULE_SERVICE_HOST=$(ICL_DESTINATIONRULE_SERVICE_HOST)'
	@echo

_icl_list_targets ::
	@echo 'IstioCtl::DestinationRule ($(_ISTIOCTL_DESTINATIONRULE_MK_VERSION)) targets:'
	@echo '    _icl_list_destinationrules              - List all destination-rules'
	@echo '    _icl_show_destinationrule               - Show everything related to a destination-rule'
	@echo '    _icl_show_destinationrule_description   - Show description of a destination-rule'
	@echo '    _icl_show_destinationrule_hostport      - Show a host:port which use a destination-rule'
	@echo '    _icl_show_destinationrule_hostports     - Show host:ports which use a destination-rule'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_list_destinationrules:
	@$(INFO) '$(ICL_UI_LABEL)Listing ALL destination-rules ...'; $(NORMAL)
	@$(WARN) 'This operation checks whether the client and service-side mTLS settings allow for communication'; $(NORMAL)
	@$(WARN) 'On the server-side, the auth-policy is set in the mesh-policy and possibly overwriten by a policy resource'
	@$(WARN) '* When the auth-policy is set to DISABLE, istio-proxies of service-endpoints will not terminate mTLS'
	@$(WARN) '* When the auth-policy is set to PERMISSIVE, services can accept either plaintext and mTLS traffic'
	@$(WARN) '* When the auth-policy is set to STRICT, only mTLS-traffic is accepted'
	@$(WARN) 'On the client-side, the auth-policy is set in the destination-rules'
	@$(WARN) '* When mTLS is set to DISABLE in a destination-rule, the client istio-proxy does not use mTLS'
	@$(WARN) '* When mTLS is set to ISTIO_MUTUAL in the destination-rule, client istio-proxies initiate a mTLS using istio certificates'
	@$(WARN) '* When mTLS is set to MUTUAL in the destination-rule, istio-proxies initiate a mTLS connection using a custom certificate (tls secret)'
	@$(WARN) '* When mTLS is set to SIMPLE in the destination-rule, istio-proxies initiate a TLS connection to envoy-upstream endpoint (like https)'
	@$(NORMAL)
	$(ISTIOCTL) authn tls-check $(__ICL_NAMESPACE__DESTINATIONRULE) $(ICL_DESTINATIONRULE_POD_NAME)

_ICL_SHOW_DESTINATIONRULE_TARGETS?= _icl_show_destinationrule_hostport _icl_show_destinationrule_hostports _icl_show_destinationrule_description
_icl_show_destinationrule: $(_ICL_SHOW_DESTINATIONRULE_TARGETS)

_icl_show_destinationrule_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing the destination-rule "$(ICL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)

_icl_show_destinationrule_hostports:
	@$(INFO) '$(ICL_UI_LABEL)Showing all host:ports using the destination-rule "$(ICL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns whether communication is possible between this pod and the service-host'; $(NORMAL)
	@$(WARN) 'The HOST:PORT column reports the possible destination'; $(NORMAL)
	@$(WARN) 'The CLIENT column reports the configuration set in the destination-rule for that HOST:PORT'; $(NORMAL)
	@$(WARN) '  * DISABLE: client proxy does not use mTLS'; $(NORMAL)
	@$(WARN) '  * ISTIO_MUTUAL: connections are initiated using the istio-certificate'; $(NORMAL)
	@$(WARN) '  * MUTAL: connections are initiated using a custom certificate'; $(NORMAL)
	@$(WARN) '  * SIMPLE: connections are initiated ... (like https)'; $(NORMAL)
	@$(WARN) 'The SERVER column reports the configuration set in the authentication-rule rule for that HOST:PORT'; $(NORMAL)
	@$(WARN) 'If STATUS=OK, communication is possible with the HOST:PORT'; $(NORMAL)
	$(ISTIOCTL) authn tls-check $(__ICL_NAMESPACE__DESTINATIONRULE) $(ICL_DESTINATIONRULE_POD_NAME) | grep -E 'HOST:PORT|$(ICL_DESTINATIONRULE_NAME)'

_icl_show_destinationrule_hostport:
	@$(INFO) '$(ICL_UI_LABEL)Showing an host:port which use the destination-rule "$(ICL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)
	$(if $(ICL_DESTINATIONRULE_SERVICE_HOST), \
		$(ISTIOCTL) authn tls-check $(__ICL_NAMESPACE__DESTINATIONRULE) $(ICL_DESTINATIONRULE_POD_NAME) $(ICL_DESTINATIONRULE_SERVICE_HOST) \
	, @\
		echo 'ICL_DESTINATIONRULE_SERVICE_HOST not set ...'; \
	)
