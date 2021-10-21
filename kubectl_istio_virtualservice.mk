_KUBECTL_ISTIO_VIRTUALSERVICE_MK_VERSION= $(_KUBECTL_ISTIO_MK_VERSION)

# KCL_VIRTUALSERVICE_CURL?= curl
# KCL_VIRTUALSERVICE_DESTINATIONRULES_FIELDSELECTOR?=
# KCL_VIRTUALSERVICE_DESTINATIONRULES_NAME?=
# KCL_VIRTUALSERVICE_DESTINATIONRULES_SELECTOR?=
# KCL_VIRTUALSERVICE_DIG?= dig
# KCL_VIRTUALSERVICE_DNSNAME?= hostname.sub.domain.com
# KCL_VIRTUALSERVICE_DNSNAME_DOMAIN?= domain.com
# KCL_VIRTUALSERVICE_DNSNAME_HOSTNAME?= hostname
# KCL_VIRTUALSERVICE_DNSNAME_SUBDOMAIN?= sub.domain.com
# KCL_VIRTUALSERVICE_GATEWAY_NAME?= my-gateway
# KCL_VIRTUALSERVICE_GATEWAY_NAMESPACE?= knative-serving
# KCL_VIRTUALSERVICE_GATEWAYS_FIELDSELECTOR?= metatadata.name=my-gateway
# KCL_VIRTUALSERVICE_GATEWAYS_SELECTOR?= app=my-gateway
# KCL_VIRTUALSERVICE_NAME?=
# KCL_VIRTUALSERVICE_NAMESPACE_NAME?= istio-namespace
# KCL_VIRTUALSERVICE_SERVICES_SELECTOR?= metadata.name=my-service
# KCL_VIRTUALSERVICE_SERVICES_NAMES?= my-service ...
# KCL_VIRTUALSERVICE_SERVICES_SELECTOR?= app=service
# KCL_VIRTUALSERVICE_URL?= http://host.domain.com:80/my/path
# KCL_VIRTUALSERVICE_URL_DNSNAME?= host.domain.com
# KCL_VIRTUALSERVICE_URL_PATH?= /my/path
# KCL_VIRTUALSERVICE_URL_PORT?= :80
# KCL_VIRTUALSERVICE_URL_PROTOCOL?= http://
# KCL_VIRTUALSERVICES_FIELDSELECTOR?=
# KCL_VIRTUALSERVICES_MANIFEST_DIRPATH?= ./in/
# KCL_VIRTUALSERVICES_MANIFEST_FILENAME?= virtualservices.yaml
# KCL_VIRTUALSERVICES_MANIFEST_FILEPATH?= ./in/virtualservices.yaml
# KCL_VIRTUALSERVICES_NAMESPACE_NAME?= istio-namespace
# KCL_VIRTUALSERVICES_OUTPUT?=
# KCL_VIRTUALSERVICES_SELECTOR?=

# Derived parameters
KCL_VIRTUALSERVICE_CURL?= $(KCL_ISTIO_CURL)
KCL_VIRTUALSERVICE_DIG?= $(KCL_ISTIO_DIG)
KCL_VIRTUALSERVICE_DNSNAME?= $(KCL_VIRTUALSERVICE_DNSNAME_HOSTNAME).$(KCL_VIRTUALSERVICE_DNSNAME_SUBDOMAIN)
KCL_VIRTUALSERVICE_DNSNAME_SUBDOMAIN?= $(KCL_VIRTUALSERVICE_DNSNAME_DOMAIN)
KCL_VIRTUALSERVICE_GATEWAY_NAME?= $(KCL_GATEWAY_NAME)
KCL_VIRTUALSERVICE_GATEWAY_NAMESPACE?= $(KCL_VIRTUALSERVICE_NAMESPACE_NAME)
KCL_VIRTUALSERVICE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_VIRTUALSERVICE_URL?= $(KCL_VIRTUALSERVICE_URL_PROTOCOL)$(KCL_VIRTUALSERVICE_URL_DNSNAME)$(KCL_VIRTUALSERVICE_URL_PORT)$(KCL_VIRTUALSERVICE_URL_PATH)
KCL_VIRTUALSERVICE_URL_DNSNAME?= $(KCL_VIRTUALSERVICE_DNSNAME)
KCL_VIRTUALSERVICES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_VIRTUALSERVICES_MANIFEST_FILEPATH?= $(KCL_VIRTUALSERVICES_MANIFEST_DIRPATH)$(KCL_VIRTUALSERVICES_MANIFEST_FILENAME)
KCL_VIRTUALSERVICES_NAMESPACE_NAME?= $(KCL_VIRTUALSERVICE_NAMESPACE_NAME)
KCL_VIRTUALSERVICES_SET_NAME?= virtual-services@$(KCL_VIRTUALSERVICES_FIELDSELECTER)@$(KCL_VIRTUALSERVICES_SELECTOR)@$(KCL_VIRTUALSERVICES_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__VIRTUALSERVICES= $(if $(KCL_VIRTUALSERVICES_MANIFEST_FILEPATH),--filename $(KCL_VIRTUALSERVICES_MANIFEST_FILEPATH))
__KCL_LABELS__VIRTUALSERVICE= $(if $(KCL_VIRTUALSERVICE_LABELS_KEYVALUES),--labels $(KCL_VIRTUALSERVICE_LABELS_KEYVALUES))
__KCL_NAMESPACE__VIRTUALSERVICE= $(if $(KCL_VIRTUALSERVICE_NAMESPACE_NAME),--namespace $(KCL_VIRTUALSERVICE_NAMESPACE_NAME))
__KCL_NAMESPACE__VIRTUALSERVICES= $(if $(KCL_VIRTUALSERVICES_NAMESPACE_NAME),--namespace $(KCL_VIRTUALSERVICES_NAMESPACE_NAME))
__KCL_OUTPUT__VIRTUALSERVICES= $(if $(KCL_VIRTUALSERVICES_OUTPUT),--output $(KCL_VIRTUALSERVICES_OUTPUT))
__KCL_SELECTOR__VIRTUALSERVICES= $(if $(KCL_VIRTUALSERVICES_SELECTOR),--selector=$(KCL_VIRTUALSERVICES_SELECTOR))
__KCL_SORT_BY__VIRTUALSERVICES= $(if $(KCL_VIRTUALSERVICES_SORT_BY),--sort-by=$(KCL_VIRTUALSERVICES_SORT_BY))

# UI parameters
|_KCL_CURL_VIRTUALSERVICE?=
|_KCL_DIG_VIRTUALSERVICE?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Istio::VirtualService ($(_KUBECTL_ISTIO_VIRTUALSERVICE_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Istio::VirtualService ($(_KUBECTL_ISTIO_VIRTUALSERVICE_MK_VERSION)) parameters:'
	@echo '    KCL_VIRTUALSERVICE_DESTINATIONRULES_FIELDSELECTOR=$(KCL_VIRTUALSERVICE_DESTINATIONRULE_FIELDSELECTOR)'
	@echo '    KCL_VIRTUALSERVICE_DESTINATIONRULES_NAME=$(KCL_VIRTUALSERVICE_DESTINATIONRULE_NAME)'
	@echo '    KCL_VIRTUALSERVICE_DESTINATIONRULES_SELECTOR=$(KCL_VIRTUALSERVICE_DESTINATIONRULE_SELECTOR)'
	@echo '    KCL_VIRTUALSERVICE_DNSNAME=$(KCL_VIRTUALSERVICE_DNSNAME)'
	@echo '    KCL_VIRTUALSERVICE_DNSNAME_DOMAIN=$(KCL_VIRTUALSERVICE_DNSNAME_DOMAIN)'
	@echo '    KCL_VIRTUALSERVICE_DNSNAME_HOSTNAME=$(KCL_VIRTUALSERVICE_DNSNAME_HOSTNAME)'
	@echo '    KCL_VIRTUALSERVICE_DNSNAME_SUBDOMAIN=$(KCL_VIRTUALSERVICE_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_VIRTUALSERVICE_GATEWAY_NAME=$(KCL_VIRTUALSERVICE_GATEWAY_NAME)'
	@echo '    KCL_VIRTUALSERVICE_GATEWAY_NAMESPACE=$(KCL_VIRTUALSERVICE_GATEWAY_NAMESPACE)'
	@echo '    KCL_VIRTUALSERVICE_GATEWAYS_FIELDSELECTOR=$(KCL_VIRTUALSERVICE_GATEWAYS_FIELDSELECTOR)'
	@echo '    KCL_VIRTUALSERVICE_GATEWAYS_SELECTOR=$(KCL_VIRTUALSERVICE_GATEWAYS_SELECTOR)'
	@echo '    KCL_VIRTUALSERVICE_NAME=$(KCL_VIRTUALSERVICE_NAME)'
	@echo '    KCL_VIRTUALSERVICE_NAMESPACE_NAME=$(KCL_VIRTUALSERVICE_NAMESPACE_NAME)'
	@echo '    KCL_VIRTUALSERVICE_SERVICES_FIELDSELECTOR=$(KCL_VIRTUALSERVICE_SERVICES_FIELDSELECTOR)'
	@echo '    KCL_VIRTUALSERVICE_SERVICES_NAMES=$(KCL_VIRTUALSERVICE_SERVICES_NAMES)'
	@echo '    KCL_VIRTUALSERVICE_SERVICES_SELECTOR=$(KCL_VIRTUALSERVICE_SERVICES_SELECTOR)'
	@echo '    KCL_VIRTUALSERVICE_URL=$(KCL_VIRTUALSERVICE_URL)'
	@echo '    KCL_VIRTUALSERVICE_URL_DNSNAME=$(KCL_VIRTUALSERVICE_URL_DNSNAME)'
	@echo '    KCL_VIRTUALSERVICE_URL_PATH=$(KCL_VIRTUALSERVICE_URL_PATH)'
	@echo '    KCL_VIRTUALSERVICE_URL_PORT=$(KCL_VIRTUALSERVICE_URL_PORT)'
	@echo '    KCL_VIRTUALSERVICE_URL_PROTOCOL=$(KCL_VIRTUALSERVICE_URL_PROTOCOL)'
	@echo '    KCL_VIRTUALSERVICES_FIELDSELECTOR=$(KCL_VIRTUALSERVICES_FIELDSELECTOR)'
	@echo '    KCL_VIRTUALSERVICES_MANIFEST_DIRPATH=$(KCL_VIRTUALSERVICES_MANIFEST_DIRPATH)'
	@echo '    KCL_VIRTUALSERVICES_MANIFEST_FILENAME=$(KCL_VIRTUALSERVICES_MANIFEST_FILENAME)'
	@echo '    KCL_VIRTUALSERVICES_MANIFEST_FILEPATH=$(KCL_VIRTUALSERVICES_MANIFEST_FILEPATH)'
	@echo '    KCL_VIRTUALSERVICES_NAMESPACE_NAME=$(KCL_VIRTUALSERVICES_NAMESPACE_NAME)'
	@echo '    KCL_VIRTUALSERVICES_SELECTOR=$(KCL_VIRTUALSERVICES_SELECTOR)'
	@echo '    KCL_VIRTUALSERVICES_SET_NAME=$(KCL_VIRTUALSERVICES_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Istio::VirtualService ($(_KUBECTL_ISTIO_VIRTUALSERVICE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_virtualservice                - Annotate a virtual-service'
	@echo '    _kcl_apply_virtualservices                  - Apply manifest for one-or-more virtual-services'
	@echo '    _kcl_create_virtualservice                  - Create a virtual-service'
	@echo '    _kcl_curl_virtualservice                    - Curl a virtual-service'
	@echo '    _kcl_delete_virtualservice                  - Delete a virtual-service'
	@echo '    _kcl_diff_virtualservices                   - Diff manifest for one-or-more virtual-services'
	@echo '    _kcl_dig_virtualservice                     - Dig a virtual-service'
	@echo '    _kcl_label_virtualservice                   - Label a virtual-service'
	@echo '    _kcl_show_virtualservice                    - Show everything related to a virtual-service'
	@echo '    _kcl_show_virtualservice_description        - Show description of a virtual-service'
	@echo '    _kcl_show_virtualservice_destinationrules   - Show destination-rules of a virtual-service'
	@echo '    _kcl_show_virtualservice_gateway            - Show gateway of a virtual-service'
	@echo '    _kcl_show_virtualservice_manifest           - Show manifest of a virtual-service'
	@echo '    _kcl_show_virtualservice_services           - Show services of a virtual-service'
	@echo '    _kcl_show_virtualservice_state              - Show state of a virtual-service'
	@echo '    _kcl_unapply_virtualservices                - Unapply a manifest for one-or-more virtual-services'
	@echo '    _kcl_unlabel_virtualservice                 - Unlabel a virtual-service'
	@echo '    _kcl_update_lvirtualservice                 - Updating a virtual-service'
	@echo '    _kcl_view_virtualservices                   - View all virtual-services'
	@echo '    _kcl_view_virtualservices_set               - View a set of virtual-services'
	@echo '    _kcl_watch_virtualservices                  - Watch virtual-services'
	@echo '    _kcl_watch_virtualservices_set              - Watch a set of virtual-services'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_virtualservice:
	@$(INFO) '$(KCL_UI_LABEL)Annotating virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)

_kcl_apply_virtualservice: _kcl_apply_virtualservices
_kcl_apply_virtualservices:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more virtual-services ...'; $(NORMAL)
	cat $(KCL_VIRTUALSERVICES_MANIFEST_FILEPATH); echo
	$(KUBECTL) apply $(__KCL_FILENAME__VIRTUALSERVICES) $(__KCL_NAMESPACE__VIRTUALSERVICES)

_kcl_create_virtualservice:
	@$(INFO) '$(KCL_UI_LABEL)Creating virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)

_kcl_curl_virtualservice:
	@$(INFO) '$(KCL_UI_LABEL)Curl-ing virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)
	$(KCL_VIRTUALSERVICE_CURL) $(KCL_VIRTUALSERVICE_URL) $(|_KCL_CURL_VIRTUALSERVICE)

_kcl_delete_virtualservice:
	@$(INFO) '$(KCL_UI_LABEL)Deleting virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT delete services of exposed deployments'; $(NORMAL)
	$(KUBECTL) delete virtualservice $(__KCL_NAMESPACE__VIRTUALSERVICE) $(KCL_VIRTUALSERVICE_NAME)

_kcl_diff_virtualservice: _kcl_diff_virtualservices
_kcl_diff_virtualservices: 
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest of one-or-more virtual-services ...'; $(NORMAL)
	$(_KCL_DIFF_VIRTUALSERVICES_|)$(KUBECTL) diff $(__KCL_FILENAME__VIRTUALSERVICES) $(__KCL_NAMESPACE__VIRTUALSERVICES)

_kcl_dig_virtualservice:
	@$(INFO) '$(KCL_UI_LABEL)Dig-ing virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)
	$(KCL_VIRTUALSERVICE_DIG) $(KCL_VIRTUALSERVICE_DNSNAME) $(|_KCL_DIG_VIRTUALSERVICE)

_kcl_edit_virtualservice:
	@$(INFO) '$(KCL_UI_LABEL)Editing virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit virtualservice $(__KCL_NAMESPACE__VIRTUALSERVICE) $(KCL_VIRTUALSERVICE_NAME)

_kcl_explain_virtualservice:
	@$(INFO) '$(KCL_UI_LABEL)Explaining virtual-service object ...'; $(NORMAL)
	$(KUBECTL) explain virtualservice

_KCL_SHOW_VIRTUALSERVICE_TARGETS?= _kcl_show_virtualservice_destinationrules _kcl_show_virtualservice_gateways _kcl_show_virtualservice_object _kcl_show_virtualservice_services _kcl_show_virtualservice_state _kcl_show_virtualservice_description
_kcl_show_virtualservice :: $(_KCL_SHOW_VIRTUALSERVICE_TARGETS)

_kcl_show_virtualservice_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe virtualservice $(__KCL_NAMESPACE__VIRTUALSERVICE) $(KCL_VIRTUALSERVICE_NAME)

_kcl_show_virtualservice_destinationrules:
	@$(INFO) '$(KCL_UI_LABEL)Showing destination-rules used by virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)
	$(if $(KCL_VIRTUALSERVICE_DESTINATIONRULES_FIELDSELECTOR)$(KCL_VIRTUALSERVICE_DESTINATIONRULES_NAMES)$(KCL_VIRTUALSERVICE_DESTINATIONRULES_SELECTOR), \
		$(KUBECTL) get destinationrules $(__KCL_NAMESPACE__VIRTUALSERVICE) \
			$(if $(KCL_VIRTUALSERVICE_DESTINATIONRULES_FIELDSELECTOR),--field-selector $(KCL_VIRTUALSERVICE_DESTINATIONRULES_FIELDSELECTOR)) \
			$(if $(KCL_VIRTUALSERVICE_DESTINATIONRULES_SELECTOR),--selector $(KCL_VIRTUALSERVICE_DESTINATIONRULES_SELECTOR)) \
			$(KCL_VIRTUALSERVICE_DESTINATIONRULES_NAMES) \
	, @ \
		echo 'KCL_VIRTUALSERVICE_DESTINATIONRULES_FIELDSELECTOR not set'; \
		echo 'KCL_VIRTUALSERVICE_DESTINATIONRULES_NAMES not set'; \
		echo 'KCL_VIRTUALSERVICE_DESTINATIONRULES_SELECTOR not set'; \
	)

_kcl_show_virtualservice_gateways:
	@$(INFO) '$(KCL_UI_LABEL)Showing the gateways bound to virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if none of the gateways the virtual-service binds to exist!'; $(NORMAL)
	@$(WARN) 'Beware the referenced gateways often are located in other namespaces'; $(NORMAL)
	$(if $(KCL_VIRTUALSERVICE_GATEWAY_NAME)$(KCL_VIRTUALSERVICE_GATEWAY_NAMESPACE)$(KCL_VIRTUALSERVICE_GATEWAYS_FIELDSELECTOR)$(KCL_VIRTUALSERVICE_GATEWAYS_SELECTOR), \
		$(KUBECTL) get gateways \
			$(if $(KCL_VIRTUALSERVICE_GATEWAYS_FIELDSELECTOR),--field-selector $(KCL_VIRTUALSERVICE_GATEWAYS_FIELDSELECTOR)) \
		    $(if $(KCL_VIRTUALSERVICE_GATEWAY_NAMESPACE),--namespace $(KCL_VIRTUALSERVICE_GATEWAY_NAMESPACE)) \
            $(if $(KCL_VIRTUALSERVICE_DESTINATIONRULES_SELECTOR),--selector $(KCL_VIRTUALSERVICE_DESTINATIONRULES_SELECTOR)) \
			$(KCL_VIRTUALSERVICE_GATEWAY_NAME) \
	, @\
		echo 'KCL_VIRTUALSERVICE_GATEWAY_NAME not set'; \
		echo 'KCL_VIRTUALSERVICE_GATEWAY_NAMESPACE not set'; \
		echo 'KCL_VIRTUALSERVICE_GATEWAYS_FIELDSELECTOR not set'; \
		echo 'KCL_VIRTUALSERVICE_GATEWAYS_SELECTOR not set'; \
	)

_kcl_show_virtualservice_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get virtualservice $(__KCL_NAMESPACE__VIRTUALSERVICE) $(_X__KCL_OUTPUT__VIRTUALSERVICE) -o yaml $(KCL_VIRTUALSERVICE_NAME)

_kcl_show_virtualservice_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing services used by virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The configured routes in virtual-service must be existing k8s services!'; $(NORMAL)
	$(if $(KCL_VIRTUALSERVICE_SERVICES_FIELDSELECTOR)$(KCL_VIRTUALSERVICE_SERVICES_NAMES)$(KCL_VIRTUALSERVICE_SERVICES_SELECTOR), \
		$(KUBECTL) get services $(__KCL_NAMESPACE__VIRTUALSERVICE) \
			$(if $(KCL_VIRTUALSERVICE_SERVICES_FIELDSELECTOR),--field-selector $(KCL_VIRTUALSERVICE_SERVICES_FIELDSELECTOR)) \
            $(if $(KCL_VIRTUALSERVICE_SERVICES_SELECTOR),--selector $(KCL_VIRTUALSERVICE_SERVICES_SELECTOR)) \
			$(KCL_VIRTUALSERVICE_SERVICES_NAMES) \
	, @\
		echo 'KCL_VIRTUALSERVICE_SERVICES_FIELDSELECTOR not set'; \
		echo 'KCL_VIRTUALSERVICE_SERVICES_NAMES not set'; \
		echo 'KCL_VIRTUALSERVICE_SERVICES_SELECTOR not set'; \
	)

_kcl_show_virtualservice_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get virtualservice $(__KCL_NAMESPACE__VIRTUALSERVICE) $(_X__KCL_OUTPUT__VIRTUALSERVICE) $(KCL_VIRTUALSERVICE_NAME)

_kcl_unapply_virtualservice: _kcl_unapply_virtualservices
_kcl_unapply_virtualservices:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more virtual-services ...'; $(NORMAL)
	# cat $(KCL_VIRTUALSERVICES_MANIFEST_FILEPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__VIRTUALSERVICES) $(__KCL_NAMESPACE__VIRTUALSERVICES)

_kcl_unlabel_virtualservice:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)

_kcl_update_virtualservice:
	@$(INFO) '$(KCL_UI_LABEL)Updating virtual-service "$(KCL_VIRTUALSERVICE_NAME)" ...'; $(NORMAL)

_kcl_view_virtualservices:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL virtual-services ...'; $(NORMAL)
	$(KUBECTL) get virtualservices --all-namespaces=true $(_X__KCL_NAMESPACE__VIRTUALSERVICES) $(__KCL_OUTPUT_VIRTUALSERVICES) $(_X__KCL_SELECTOR__VIRTUALSERVICES) $(__KCL_SORT_BY__VIRTUALSERVICES)

_kcl_view_virtualservices_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing virtual-services-set "$(KCL_VIRTUALSERVICES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Deployments are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get virtualservices --all-namespaces=false $(__KCL_NAMESPACE__VIRTUALSERVICES) $(__KCL_OUTPUT__VIRTUALSERVICES) $(__KCL_SELECTOR__VIRTUALSERVICES) $(__KCL_SORT_BY__VIRTUALSERVICES)

_kcl_watch_virtualservices:
	@$(INFO) '$(KCL_UI_LABEL)Watching virtual-services ...'; $(NORMAL)
	$(KUBECTL) get virtualservices --all-namespaces=true --watch 

_kcl_watch_virtualservices_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching virtual-services-set "$(KCL_VIRTUALSERVICES_SET_NAME)" ...'; $(NORMAL)
