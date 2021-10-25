_KUBECTL_ISTIO_GATEWAY_MK_VERSION= $(_KUBECTL_ISTIO_MK_VERSION)

# KCL_GATEWAY_CURL?= curl
# KCL_GATEWAY_DIG?= dig
# KCL_GATEWAY_DNSNAME?= hostname.sub.domain.com
# KCL_GATEWAY_DNSNAME_DOMAIN?= domain.com
# KCL_GATEWAY_DNSNAME_HOSTNAME?= hostname
# KCL_GATEWAY_DNSNAME_SUBDOMAIN?= sub.domain.com
# KCL_GATEWAY_NAME?= my-gateway
# KCL_GATEWAY_NAMESPACE_NAME?= istio-namespace
# KCL_GATEWAY_OUTPUT_FORMAT?= yaml
# KCL_GATEWAY_PODS_NAMES?= istio-ingressgateway
# KCL_GATEWAY_PODS_SELECTOR?= istio=ingressgateway
KCL_GATEWAY_SERVICES_FIELDSELECTOR?= metadata.name=istio-ingressgateway
# KCL_GATEWAY_SERVICES_NAMES?= istio-ingressgateway
KCL_GATEWAY_SERVICES_SELECTOR?= istio=ingressgateway
# KCL_GATEWAY_URL?= https://hostname.sub.domain.com:443/my/path 
# KCL_GATEWAY_URL_DNSNAME?= hostname.sub.domain.com
# KCL_GATEWAY_URL_PATH?= /my/path
# KCL_GATEWAY_URL_PORT?= :443
# KCL_GATEWAY_URL_PROTOCOL?= https://
# KCL_GATEWAYS_MANIFEST_DIRPATH?= ./in/
# KCL_GATEWAYS_MANIFEST_FILENAME?= istio-gateway.yml
# KCL_GATEWAYS_MANIFEST_FILEPATH?= ./in/istio-gateway.yml
# KCL_GATEWAYS_NAMESPACE_NAME?= default
# KCL_GATEWAYS_OUTPUT_FORMAT?= yaml
# KCL_GATEWAYS_SELECTOR?=
# KCL_GATEWAYS_SET_NAME?= gateways@namespace
KCL_GATEWAYS_WATCHONLY_FLAG?= false

# Derived parameters
KCL_GATEWAY_CURL?= $(KCL_ISTIO_CURL)
KCL_GATEWAY_DIG?= $(KCL_ISTIO_DIG)
KCL_GATEWAY_DNSNAME?= $(KCL_GATEWAY_DNSNAME_HOSTNAME).$(KCL_GATEWAY_DNSNAME_SUBDOMAIN)
KCL_GATEWAY_DNSNAME_SUBDOMAIN?= $(KCL_GATEWAY_DNSNAME_DOMAIN)
KCL_GATEWAY_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_GATEWAY_URL?= $(KCL_GATEWAY_URL_PROTOCOL)$(KCL_GATEWAY_URL_DNSNAME)$(KCL_GATEWAY_URL_PORT)$(KCL_GATEWAY_URL_PATH)
KCL_GATEWAY_URL_DNSNAME?= $(KCL_GATEWAY_DNSNAME)
KCL_GATEWAYS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_GATEWAYS_MANIFEST_FILEPATH?= $(KCL_GATEWAYS_MANIFEST_DIRPATH)$(KCL_GATEWAYS_MANIFEST_FILENAME)
KCL_GATEWAYS_NAMESPACE_NAME?= $(KCL_GATEWAY_NAMESPACE_NAME)
KCL_GATEWAYS_SET_NAME?= gateways@$(KCL_GATEWAYS_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__GATEWAYS= $(if $(KCL_GATEWAYS_MANIFEST_FILEPATH),--filename $(KCL_GATEWAYS_MANIFEST_FILEPATH))
__KCL_LABELS__GATEWAY= $(if $(KCL_GATEWAY_LABELS_KEYVALUES),--labels $(KCL_GATEWAY_LABELS_KEYVALUES))
__KCL_NAMESPACE__GATEWAY= $(if $(KCL_GATEWAY_NAMESPACE_NAME),--namespace $(KCL_GATEWAY_NAMESPACE_NAME))
__KCL_NAMESPACE__GATEWAYS= $(if $(KCL_GATEWAYS_NAMESPACE_NAME),--namespace $(KCL_GATEWAYS_NAMESPACE_NAME))
__KCL_OUTPUT__GATEWAY= $(if $(KCL_GATEWAY_OUTPUT_FORMAT),--output $(KCL_GATEWAY_OUTPUT_FORMAT))
# __KCL_OUTPUT__GATEWAYS= $(if $(KCL_GATEWAYS_OUTPUT_FORMAT),--output $(KCL_GATEWAYS_OUTPUT_FORMAT))
__KCL_SELECTOR__GATEWAYS= $(if $(KCL_GATEWAYS_SELECTOR),--selector=$(KCL_GATEWAYS_SELECTOR))
__KCL_SORT_BY__GATEWAYS= $(if $(KCL_GATEWAYS_SORT_BY),--sort-by=$(KCL_GATEWAYS_SORT_BY))
__KCL_WATCH_ONLY__GATEWAYS= $(if $(KCL_GATEWAYS_WATCH_ONLY),--watch-only=$(KCL_GATEWAYS_WATCH_ONLY))

# UI parameters
|_KCL_CURL_GATEWAY?=
|_KCL_DIG_GATEWAY?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Istio::Gateway ($(_KUBECTL_ISTIO_GATEWAY_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Istio::Gateway ($(_KUBECTL_ISTIO_GATEWAY_MK_VERSION)) parameters:'
	@echo '    KCL_GATEWAY_DNSNAME=$(KCL_GATEWAY_DNSNAME)'
	@echo '    KCL_GATEWAY_DNSNAME_DOMAIN=$(KCL_GATEWAY_DNSNAME_DOMAIN)'
	@echo '    KCL_GATEWAY_DNSNAME_HOSTNAME=$(KCL_GATEWAY_DNSNAME_HOSTNAME)'
	@echo '    KCL_GATEWAY_DNSNAME_SUBDOMAIN=$(KCL_GATEWAY_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_GATEWAY_NAME=$(KCL_GATEWAY_NAME)'
	@echo '    KCL_GATEWAY_NAMESPACE_NAME=$(KCL_GATEWAY_NAMESPACE_NAME)'
	@echo '    KCL_GATEWAY_PODS_NAMES=$(KCL_GATEWAY_PODS_NAMES)'
	@echo '    KCL_GATEWAY_PODS_SELECTOR=$(KCL_GATEWAY_PODS_SELECTOR)'
	@echo '    KCL_GATEWAY_SERVICES_FIELDSELECTOR=$(KCL_GATEWAY_SERVICES_FIELDSELECTOR)'
	@echo '    KCL_GATEWAY_SERVICES_NAMES=$(KCL_GATEWAY_SERVICES_NAMES)'
	@echo '    KCL_GATEWAY_SERVICES_SELECTOR=$(KCL_GATEWAY_SERVICES_SELECTOR)'
	@echo '    KCL_GATEWAY_URL=$(KCL_GATEWAY_URL)'
	@echo '    KCL_GATEWAY_URL_DNSNAME=$(KCL_GATEWAY_URL_DNSNAME)'
	@echo '    KCL_GATEWAY_URL_PATH=$(KCL_GATEWAY_URL_PATH)'
	@echo '    KCL_GATEWAY_URL_PORT=$(KCL_GATEWAY_URL_PORT)'
	@echo '    KCL_GATEWAY_URL_PROTOCOL=$(KCL_GATEWAY_URL_PROTOCOL)'
	@echo '    KCL_GATEWAY_VIRTUALSERVICES_FIELDSELECTOR=$(KCL_GATEWAY_VIRTUALSERVICES_FIELDSELECTOR)'
	@echo '    KCL_GATEWAY_VIRTUALSERVICES_NAMES=$(KCL_GATEWAY_VIRTUALSERVICES_NAMES)'
	@echo '    KCL_GATEWAY_VIRTUALSERVICES_SELECTOR=$(KCL_GATEWAY_VIRTUALSERVICES_SELECTOR)'
	@echo '    KCL_GATEWAYS_MANIFEST_DIRPATH=$(KCL_GATEWAYS_MANIFEST_DIRPATH)'
	@echo '    KCL_GATEWAYS_MANIFEST_FILENAME=$(KCL_GATEWAYS_MANIFEST_FILENAME)'
	@echo '    KCL_GATEWAYS_MANIFEST_FILEPATH=$(KCL_GATEWAYS_MANIFEST_FILEPATH)'
	@echo '    KCL_GATEWAYS_NAMESPACE_NAME=$(KCL_GATEWAYS_NAMESPACE_NAME)'
	@#echo '    KCL_GATEWAYS_OUTPUT_FORMAT=$(KCL_GATEWAYS_OUTPUT_FORMAT)'
	@echo '    KCL_GATEWAYS_SELECTOR=$(KCL_GATEWAYS_SELECTOR)'
	@echo '    KCL_GATEWAYS_SET_NAME=$(KCL_GATEWAYS_SET_NAME)'
	@echo '    KCL_GATEWAYS_WATCHONLY_FLAG=$(KCL_GATEWAYS_WATCHONLY_FLAG)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Istio::Gateway ($(_KUBECTL_ISTIO_GATEWAY_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_gateway                - Annotate a gateway'
	@echo '    _kcl_apply_gateways                  - Apply manifest for one-or-more gateways'
	@echo '    _kcl_create_gateway                  - Create a gateway'
	@echo '    _kcl_curl_gateway                    - Curl a gateway'
	@echo '    _kcl_delete_gateway                  - Delete a gateway'
	@echo '    _kcl_dig_gateway                     - Dig a gateway'
	@echo '    _kcl_edit_gateway                    - Edit a gateway'
	@echo '    _kcl_explain_gateway                 - Explain gateway resource'
	@echo '    _kcl_show_gateway                    - Show everything related to a gateway'
	@echo '    _kcl_show_gateway_certificate        - Show certificate used by a gateway'
	@echo '    _kcl_show_gateway_description        - Show description of a gateway'
	@echo '    _kcl_show_gateway_object             - Show object-representation of a gateway'
	@echo '    _kcl_show_gateway_pods               - Show pods of a gateway'
	@echo '    _kcl_show_gateway_services           - Show services of a gateway'
	@echo '    _kcl_show_gateway_state              - Show state of a gateway'
	@echo '    _kcl_show_gateway_virtualservices    - Show the virtual-services bound to a gateway'
	@echo '    _kcl_unapply_gateways                - Unapply mannifest for one-or-more gateways'
	@echo '    _kcl_unlabel_gateway                 - Unlabelling a gateway'
	@echo '    _kcl_view_gateways                   - View all gateways'
	@echo '    _kcl_view_gateways_set               - View set of gateways'
	@echo '    _kcl_watch_gateways                  - Watch gateways'
	@echo '    _kcl_watch_gateways_set              - Watch a set of gateways'
	@echo '    _kcl_write_gateways                  - Edit manifest for one-or-more gateways'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_gateway:
	@$(INFO) '$(KCL_UI_LABEL)Annotating gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)

_kcl_apply_gateway: _kcl_apply_gateways
_kcl_apply_gateways:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more gateways ...'; $(NORMAL)
	cat $(KCL_GATEWAYS_MANIFEST_FILEPATH)
	$(KUBECTL) apply $(__KCL_FILENAME__GATEWAYS) $(__KCL_NAMESPACE__GATEWAYS) 

_kcl_create_gateway:
	@$(INFO) '$(KCL_UI_LABEL)Creating gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)

_kcl_curl_gateway:
	@$(INFO) '$(KCL_UI_LABEL)Curl-ing gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation sends requests to the istio-ingress-gateway to exercise the gateway/virtual-service configuration'; $(NORMAL)
	$(KCL_GATEWAY_CURL) $(KCL_GATEWAY_URL) $(|_KCL_CURL_GATEWAY)

_kcl_delete_gateway:
	@$(INFO) '$(KCL_UI_LABEL)Deleting gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT delete services of exposed deployments'; $(NORMAL)
	$(KUBECTL) delete gateway $(__KCL_NAMESPACE__GATEWAY) $(KCL_GATEWAY_NAME)

_kcl_diff_gateway: _kcl_diff_gateways
_kcl_diff_gateways:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more gateways ...'; $(NORMAL)
	# cat $(KCL_GATEWAYS_MANIFEST_FILEPATH)
	$(KUBECTL) diff $(__KCL_FILENAME__GATEWAYS) $(__KCL_NAMESPACE__GATEWAYS) 

_kcl_dig_gateway:
	@$(INFO) '$(KCL_UI_LABEL)Dig-ing gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation should resolve to one-or-more IP-addresses to reach the istio-ingress-gateway'; $(NORMAL)
	$(KCL_GATEWAY_DIG) $(KCL_GATEWAY_DNSNAME) $(|_KCL_DIG_GATEWAY)

_kcl_edit_gateway:
	@$(INFO) '$(KCL_UI_LABEL)Editing gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit gateway $(__KCL_NAMESPACE__GATEWAY) $(KCL_GATEWAY_NAME)

_kcl_explain_gateway:
	@$(INFO) '$(KCL_UI_LABEL)Explaining gateway resource ...'; $(NORMAL)
	$(KUBECTL) explain gateway

_kcl_label_gateway:
	@$(INFO) '$(KCL_UI_LABEL)Labeling gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)

_KCL_SHOW_GATEWAY_TARGETS?= _kcl_show_gateway_certificate _kcl_show_gateway_object _kcl_show_gateway_pods _kcl_show_gateway_services _kcl_show_gateway_state _kcl_show_gateway_virtualservices _kcl_show_gateway_description
_kcl_show_gateway: $(_KCL_SHOW_GATEWAY_TARGETS)

_kcl_show_gateway_certificate:
	@$(INFO) '$(KCL_UI_LABEL)Showing certificate used by gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)
	# The certificate specified in the gateway object are files in mounted-volumes on the istio-ingress-gateway
	# If mode is set to:
	# * SIMPLE: client checks the certificate of the server
	# * MUTUAL: client and server check the certificate of each other

_kcl_show_gateway_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe gateway $(__KCL_NAMESPACE__GATEWAY) $(KCL_GATEWAY_NAME)

_kcl_show_gateway_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get gateway $(__KCL_NAMESPACE__GATEWAY) $(_X__KCL_OUTPUT__GATEWAY) --output yaml $(KCL_GATEWAY_NAME)

_kcl_show_gateway_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods of gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)
	$(if $(KCL_GATEWAY_PODS_NAMES)$(KCL_GATEWAY_PODS_SELECTOR), \
		$(KUBECTL) get pod \
			--selector $(KCL_GATEWAY_PODS_SELECTOR) \
			$(KCL_GATEWAY_PODS_NAMES) \
	, @\
		echo 'KCL_GATEWAY_PODS_NAMES not set'; \
		echo 'KCL_GATEWAY_PODS_SELECTOR not set'; \
	)

_kcl_show_gateway_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing services of  gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the IP of the ingress-gateway'; $(NORMAL)
	$(if $(KCL_GATEWAY_SERVICES_FIELDSELECTOR)$(KCL_GATEWAY_SERVICES_NAMES)$(KCL_GATEWAY_SERVICES_SELECTOR), \
		$(KUBECTL) get services --all-namespaces=true $(_X__KCL_NAMESPACE__GATEWAY) \
			$(if $(KCL_GATEWAY_SERVICES_FIELDSELECTOR),--field-selector $(KCL_GATEWAY_SERVICES_FIELDSELECTOR)) \
			$(if $(KCL_GATEWAY_SERVICES_SELECTOR),--selector $(KCL_GATEWAY_SERVICES_SELECTOR)) \
			$(KCL_GATEWAY_SERVICES_NAMES) \
	, @\
		echo 'KCL_GATEWAY_SERVICES_FIELDSELECTOR not set'; \
		echo 'KCL_GATEWAY_SERVICES_NAMES not set'; \
		echo 'KCL_GATEWAY_SERVICES_SELECTOR not set'; \
	)

_kcl_show_gateway_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get gateway $(__KCL_NAMESPACE__GATEWAY) $(_X__KCL_OUTPUT__GATEWAY) $(KCL_GATEWAY_NAME)

_kcl_show_gateway_virtualservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing virtual-services bound to gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the HOSTS configured in the virtual-service which should align with those in the gateway'; $(NORMAL)
	@$(WARN) 'Possible value for HOSTS: *.domain.com, domain.com, or/and IP addresses'; $(NORMAL)
	$(if $(KCL_GATEWAY_VIRTUALSERVICES_FIELDSELECTOR)$(KCL_GATEWAY_VIRTUALSERVICES_NAMES)$(KCL_GATEWAY_VIRTUALSERVICES_SELECTOR), \
		$(KUBECTL) get virtualservices $(__KCL_NAMESPACE__GATEWAY) \
			$(if $(KCL_GATEWAY_VIRTUALSERVICES_FIELDSELECTOR),--field-selector $(KCL_GATEWAY_VIRTUALSERVICES_FIELDSELECTOR)) \
			$(if $(KCL_GATEWAY_VIRTUALSERVICES_SELECTOR),--selector $(KCL_GATEWAY_VIRTUALSERVICES_SELECTOR)) \
			$(KCL_GATEWAY_VIRTUALSERVICES_NAMES) \
	, @\
		echo 'KCL_GATEWAY_VIRTUALSERVICES_FIELDSELECTOR not set'; \
		echo 'KCL_GATEWAY_VIRTUALSERVICES_NAMES not set'; \
		echo 'KCL_GATEWAY_VIRTUALSERVICES_SELECTOR not set'; \
	)
	$(if $(KCL_GATEWAY_VIRTUALSERVICES_FIELDSELECTOR)$(KCL_GATEWAY_VIRTUALSERVICES_NAMES)$(KCL_GATEWAY_VIRTUALSERVICES_SELECTOR),, \
		$(KUBECTL) get virtualservices --all-namespaces=true | grep -E 'GATEWAYS|$(KCL_GATEWAY_NAME)'; \
	)

_kcl_unapply_gateway: _kcl_unapply_gateways
_kcl_unapply_gateways:
	@$(INFO) '$(KCL_UI_LABEL)Unapplying manifest for one-or-more gateways ...'; $(NORMAL)
	# cat $(KCL_GATEWAYS_MANIFEST_FILEPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__GATEWAYS) $(__KCL_NAMESPACE__GATEWAYS) 

_kcl_unlabel_gateway:
	@$(INFO) '$(KCL_UI_LABEL)Removing labels from gateway "$(KCL_GATEWAY_NAME)" ...'; $(NORMAL)

_kcl_view_gateways:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL gateways ...'; $(NORMAL)
	$(KUBECTL) get gateway --all-namespaces=true $(_X__KCL_NAMESPACE__GATEWAYS) $(__KCL_OUTPUT_GATEWAYS) $(_X__KCL_SELECTOR__GATEWAYS) $(__KCL_SORT_BY__GATEWAYS)

_kcl_view_gateways_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing gateways-set "$(KCL_GATEWAYS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Gateways are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get gateway --all-namespaces=false $(__KCL_NAMESPACE__GATEWAYS) $(__KCL_OUTPUT__GATEWAYS) $(__KCL_SELECTOR__GATEWAYS) $(__KCL_SORT_BY__GATEWAYS)

_kcl_watch_gateways:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL gateways ...'; $(NORMAL)
	$(KUBECTL) get gateways --all-namespaces=true --watch=true $(__KCL_WATCH_ONLY__GATEWAYS)

_kcl_watch_gateways_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching gateways-set "$(KCL_GATEWAYS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Gateways are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get gateway --all-namespaces=false $(__KCL_NAMESPACE__GATEWAYS) $(__KCL_OUTPUT__GATEWAYS) $(__KCL_SELECTOR__GATEWAYS) $(__KCL_SORT_BY__GATEWAYS) --watch $(__KCL_WATCH_ONLY__GATEWAYS)

_kcl_write_gateway: _kcl_write_gateways
_kcl_write_gateways:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more gateways ...'; $(NORMAL)
	$(EDITOR) $(KCL_GATEWAYS_MANIFEST_FILEPATH)
