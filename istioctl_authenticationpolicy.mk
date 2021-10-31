_ISTIOCTL_AUTHENTICATIONPOLICY_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

# ICL_AUTHENTICATIONPOLICY_NAME?=  grafana-ports-mtls-disabled
# ICL_AUTHENTICATIONPOLICY_NAMESPACE_NAME?= kube-vault
# ICL_AUTHENTICATIONPOLICY_POD_NAME?= vault-release
# ICL_AUTHENTICATIONPOLICY_SERVICE_HOST?= istio-pilot.istio-system.svc.cluster.local

# Derived parameters
ICL_AUTHENTICATIONPOLICY_NAME?= $(KCL_AUTHENTICATIONPOLICY_NAME)
ICL_AUTHENTICATIONPOLICY_NAMESPACE_NAME?= $(KCL_POD_NAMESPACE_NAME)
ICL_AUTHENTICATIONPOLICY_POD_NAME?= $(KCL_POD_NAME)
ICL_AUTHENTICATIONPOLICY_SERVICE_HOST?= $(KCL_AUTHENTICATIONPOLICY_SERVICE_HOST)

# Option parameters
__ICL_NAMESPACE__AUTHENTICATIONPOLICY?= $(if $(ICL_AUTHENTICATIONPOLICY_NAMESPACE_NAME),--namespace $(ICL_AUTHENTICATIONPOLICY_NAMESPACE_NAME))

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_icl_list_macros ::
	@#echo 'IstioCtL::AuthenticationPolicy ($(_ISTIOCTL_AUTHENTICATIONPOLICY_MK_VERSION)) macros:'
	@#echo

_icl_list_parameters ::
	@echo 'IstioCtl::AuthenticationPolicy ($(_ISTIOCTL_AUTHENTICATIONPOLICY_MK_VERSION)) parameters:'
	@echo '    ICL_AUTHENTICATIONPOLICY_NAME=$(ICL_AUTHENTICATIONPOLICY_NAME)'
	@echo '    ICL_AUTHENTICATIONPOLICY_NAMESPACE_NAME=$(ICL_AUTHENTICATIONPOLICY_NAMESPACE_NAME)'
	@echo '    ICL_AUTHENTICATIONPOLICY_POD_NAME=$(ICL_AUTHENTICATIONPOLICY_POD_NAME)'
	@echo '    ICL_AUTHENTICATIONPOLICY_SERVICE_HOST=$(ICL_AUTHENTICATIONPOLICY_SERVICE_HOST)'
	@echo

_icl_list_targets ::
	@echo 'IstioCtl::AuthenticationPolicy ($(_ISTIOCTL_AUTHENTICATIONPOLICY_MK_VERSION)) targets:'
	@echo '    _icl_show_authenticationpolicies               - Show everything related to an authentication-policies'
	@echo '    _icl_show_authenticationpolicies_description   - Show description of an authentication-policies'
	@echo '    _icl_show_authenticationpolicies_hostport      - Show a host:port which use an authentication-policies'
	@echo '    _icl_show_authenticationpolicies_hostports     - Show host:ports which use an authentication-policies'
	@echo '    _icl_list_authenticationpolicies               - List the authentication-policies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_show_authenticationpolicy :: _icl_show_authenticationpolicy_hostport _icl_show_authenticationpolicy_hostports _icl_show_authenticationpolicy_description

_icl_show_authenticationpolicy_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing the authentication-policy "$(ICL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)

_icl_show_authenticationpolicy_hostports:
	@$(INFO) '$(ICL_UI_LABEL)Showing all host:ports using the authentication-policy "$(ICL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns whether communication is possible between this pod and the service-host'; $(NORMAL)
	@$(WARN) 'The HOST:PORT column reports the possible destination'; $(NORMAL)
	@$(WARN) 'The CLIENT column reports the configuration set in the destination rule for that HOST:PORT'; $(NORMAL)
	@$(WARN) 'The SERVER column reports the configuration set in the authentication-policy rule for that HOST:PORT'; $(NORMAL)
	@$(WARN) '  * DISABLE:  ???'; $(NORMAL)
	@$(WARN) '  * PERMISSIVE:  mTLS is optional'; $(NORMAL)
	@$(WARN) '  * STRICT:  mTLS is enforced'; $(NORMAL)
	@$(WARN) 'If STATUS=OK, communication is possible with the HOST:PORT'; $(NORMAL)
	$(ISTIOCTL) authn tls-check $(__ICL_NAMESPACE__AUTHENTICATIONPOLICY) $(ICL_AUTHENTICATIONPOLICY_POD_NAME) | grep -E 'HOST:PORT|$(ICL_AUTHENTICATIONPOLICY_NAME)'

_icl_show_authenticationpolicy_hostport:
	@$(INFO) '$(ICL_UI_LABEL)Showing an host:port which use the authentication-policy "$(ICL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)
	$(if $(ICL_AUTHENTICATIONPOLICY_SERVICE_HOST), \
		$(ISTIOCTL) authn tls-check $(__ICL_NAMESPACE__AUTHENTICATIONPOLICY) $(ICL_AUTHENTICATIONPOLICY_POD_NAME) $(ICL_AUTHENTICATIONPOLICY_SERVICE_HOST) \
	, @\
		echo 'ICL_AUTHENTICATIONPOLICY_SERVICE_HOST not set ...'; \
	)

_icl_list_authenticationpolicies:
	@$(INFO) '$(ICL_UI_LABEL)Listing the authentication-policies ...'; $(NORMAL)
	@$(WARN) 'This operation checks whether the client and service-side mTLS settings allow for communication'; $(NORMAL)
	@$(WARN) 'On the server-side, the auth-policy is set in the mesh-policy and possibly overwriten by a policy resource'
	@$(WARN) '* When the auth-policy is set to DISABLE, istio-proxies of service-endpoints will not terminate mTLS'
	@$(WARN) '* When the auth-policy is set to PERMISSIVE, services can accept either plaintext and mTLS traffic'
	@$(WARN) '* When the auth-policy is set to STRICT, only mTLS-traffic is accepted'
	@$(WARN) 'On the client-side, the auth-policy is set in the destination-rules'
	@$(WARN) '* When mTLS is set to DISABLE in a destinatyion-rule, the client istio-proxy does not use mTLS'
	@$(WARN) '* When mTLS is set to ISTIO_MUTUAL in the destination-rule, client istio-proxies initiate a mTLS using istio certificates'
	@$(WARN) '* When mTLS is set to MUTUAL in the destination-rule, istio-proxies initiate a mTLS connection using a custom certificate (tls secret)'
	@$(WARN) '* When mTLS is set to SIMPLE in the destination-rule, istio-proxies initiate a TLS connection to envoy-upstream endpoint (like https)'
	@$(NORMAL)
	$(ISTIOCTL) authn tls-check $(__ICL_NAMESPACE__AUTHENTICATIONPOLICY) $(ICL_AUTHENTICATIONPOLICY_POD_NAME)
