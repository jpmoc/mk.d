_KN_SERVICE_MK_VERSION= $(_KN_MK_VERSION)

# KN_SERVICE_CURL?= time curl
# KN_SERVICE_DIG?= time dig
# KN_SERVICE_DNSNAME?= helloworld-go.knative-app.example.com
# KN_SERVICE_DNSNAME_DOMAIN?= example.com
# KN_SERVICE_DNSNAME_HOSTNAME?= helloworld-go
# KN_SERVICE_DNSNAME_SUBDOMAIN?= knative-app.example.com
# KN_SERVICE_ENV_KEYVALUES?= TARGET="Go Sample v1"
# KN_SERVICE_IMAGE_CNAME?= gcr.io/knative-samples/helloworld-go
# KN_SERVICE_NAME?= helloworld-go
# KN_SERVICE_NAMESPACE_NAME?= default
# KN_SERVICE_URL?= http://helloworld-go.knative-app.example.com:80/my/path
# KN_SERVICE_URL_DNSNAME?= helloworld-go.knative-app.example.com
# KN_SERVICE_URL_PATH?= /my/path
# KN_SERVICE_URL_PORT?= :80
# KN_SERVICE_URL_PROTOCOL?= http://
# KN_SERVICES_NAMESPACE_NAME?= default

# Derived parameters
KN_SERVICE_CURL?= $(KN_CURL)
KN_SERVICE_DNSNAME?= $(KN_SERVICE_DNSNAME_HOSTNAME).$(KN_SERVICE_DNSNAME_SUBDOMAIN)
KN_SERVICE_DNSNAME_DOMAIN?= $(KN_DNSNAME_DOMAIN)
KN_SERVICE_DNSNAME_HOSTNAME?= $(KN_SERVICE_NAME)
KN_SERVICE_DNSNAME_SUBDOMAIN?= $(KN_SERVICE_NAMESPACE_NAME).$(KN_SERVICE_DNSNAME_DOMAIN)
KN_SERVICE_URL?= $(KN_SERVICE_URL_PROTOCOL)$(KN_SERVICE_URL_DNSNAME)$(KN_SERVICE_URL_PORT)$(KN_SERVICE_URL_PATH)
KN_SERVICE_URL_DNSNAME?= $(KN_SERVICE_DNSNAME)
# KN_SERVICE_MANIFEST_DIRPATH?= $(KN_INPUTS_DIRPATH)
# KN_SERVICE_MANIFEST_FILEPATH?= $(KN_SERVICE_MANIFEST_DIRPATH)$(KN_SERVICE_MANIFEST_FILENAME)
KN_SERVICE_NAMESPACE_NAME?= $(KN_NAMESPACE_NAME)
KN_SERVICES_NAMESPACE_NAME?= $(KN_SERVICE_NAMESPACE_NAME)
KN_SERVICES_SET_NAME?= knative-services@@@$(KN_SERVICES_NAMESPACE_NAME)

# Option parameters
# __KN_ALL_NAMESPACES__SERVICES=
# __KN_ADDRESS__SERVICE= $(if $(KN_SERVICE_PORTFORWARD_ADDRESS),--address $(KN_SERVICE_PORTFORWARD_ADDRESS))
__KN_ENV__SERVICE= $(foreach KV, $(KN_SERVICE_ENV_KEYVALUES),--env $(KV) )
# __KN_FIELD_SELECTOR__SERVICES= $(if $(KN_SERVICES_FIELDSELECTOR),--field-selector $(KN_SERVICES_FIELDSELECTOR))
# __KN_FILENAME__SERVICE+= $(if $(KN_SERVICE_MANIFEST_FILEPATH),--filename $(KN_SERVICE_MANIFEST_FILEPATH))
# __KN_FILENAME__SERVICE+= $(if $(KN_SERVICE_MANIFEST_URL),--filename $(KN_SERVICE_MANIFEST_URL))
__KN_IMAGE__SERVICE= $(if $(KN_SERVICE_IMAGE_CNAME),--image $(KN_SERVICE_IMAGE_CNAME))
# __KN_KUSTOMIZE__SERVICE= $(if $(KN_SERVICE_KUSTOMIZATION_DIRPATH),--kustomize $(KN_SERVICE_KUSTOMIZATION_DIRPATH))
__KN_NAMESPACE__SERVICE= $(if $(KN_SERVICE_NAMESPACE_NAME),--namespace $(KN_SERVICE_NAMESPACE_NAME))
__KN_NAMESPACE__SERVICES= $(if $(KN_SERVICES_NAMESPACE_NAME),--namespace $(KN_SERVICES_NAMESPACE_NAME))
# __KN_OUTPUT__SERVICES= $(if $(KN_SERVICES_OUTPUT),--output $(KN_SERVICES_OUTPUT))
# __KN_POD_RUNNING_TIMEOUT__SERVICE= $(if $(KN_SERVICE_PORTFORWARD_TIMEOUT),--pod-running-timeout=$(KN_SERVICE_PORTFORWARD_TIMEOUT))
# __KN_SELECTOR__SERVICES= $(if $(KN_SERVICES_SELECTOR),--selector=$(KN_SERVICES_SELECTOR))
# __KN_SHOW_LABELS__SERVICE= $(if $(filter true, $(KN_SERVICE_SHOW_LABELS)),--show-labels)
# __KN_WATCH_ONLY__SERVICES= $(if $(KN_SERVICES_WATCH_ONLY),--watch-only=$(KN_SERVICES_WATCH_ONLY))

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kn_view_framework_macros ::
	@echo 'KN::Service ($(_KN_SERVICE_MK_VERSION)) macros:'
	@echo

_kn_view_framework_parameters ::
	@echo 'KN::Service ($(_KN_SERVICE_MK_VERSION)) parameters:'
	@echo '    KN_SERVICE_DNSNAME=$(KN_SERVICE_DNSNAME)'
	@echo '    KN_SERVICE_DNSNAME_DOMAIN=$(KN_SERVICE_DNSNAME_DOMAIN)'
	@echo '    KN_SERVICE_DNSNAME_HOSTNAME=$(KN_SERVICE_DNSNAME_HOSTNAME)'
	@echo '    KN_SERVICE_DNSNAME_SUBDOMAIN=$(KN_SERVICE_DNSNAME_SUBDOMAIN)'
	@#echo '    KN_SERVICE_ENDPOINTS_FIELDSELECTOR=$(KN_SERVICE_ENDPOINTS_FIELDSELECTOR)'
	@#echo '    KN_SERVICE_ENDPOINTS_SELECTOR=$(KN_SERVICE_ENDPOINTS_SELECTOR)'
	@#echo '    KN_SERVICE_EXTERNAL_IP=$(KN_SERVICE_EXTERNAL_IP)'
	@echo '    KN_SERVICE_ENV_KEYVALUES=$(KN_SERVICE_ENV_KEYVALUES)'
	@echo '    KN_SERVICE_IMAGE_CNAME=$(KN_SERVICE_IMAGE_CNAME)'
	@#echo '    KN_SERVICE_MANIFEST_DIRPATH=$(KN_SERVICE_MANIFEST_DIRPATH)'
	@#echo '    KN_SERVICE_MANIFEST_FILENAME=$(KN_SERVICE_MANIFEST_FILENAME)'
	@#echo '    KN_SERVICE_MANIFEST_FILEPATH=$(KN_SERVICE_MANIFEST_FILEPATH)'
	@echo '    KN_SERVICE_NAME=$(KN_SERVICE_NAME)'
	@echo '    KN_SERVICE_NAMESPACE_NAME=$(KN_SERVICE_NAMESPACE_NAME)'
	@#echo '    KN_SERVICE_PODS_SELECTOR=$(KN_SERVICE_PODS_SELECTOR)'
	@echo '    KN_SERVICE_URL=$(KN_SERVICE_URL)'
	@echo '    KN_SERVICE_URL_DNSNAME=$(KN_SERVICE_URL_DNSNAME)'
	@echo '    KN_SERVICE_URL_PATH=$(KN_SERVICE_URL_PATH)'
	@echo '    KN_SERVICE_URL_PORT=$(KN_SERVICE_URL_PORT)'
	@echo '    KN_SERVICE_URL_PROTOCOL=$(KN_SERVICE_URL_PROTOCOL)'
	@#echo '    KN_SERVICES_FIELDSELECTOR=$(KN_SERVICES_FIELDSELECTOR)'
	@echo '    KN_SERVICES_NAMESPACE_NAME=$(KN_SERVICES_NAMESPACE_NAME)'
	@#echo '    KN_SERVICES_OUTPUT=$(KN_SERVICES_OUTPUT)'
	@#echo '    KN_SERVICES_SELECTOR=$(KN_SERVICES_SELECTOR)'
	@#echo '    KN_SERVICES_SET_NAME=$(KN_SERVICES_SET_NAME)'
	@#echo '    KN_SERVICES_SHOW_LABELS=$(KN_SERVICES_SHOW_LABELS)'
	@#echo '    KN_SERVICES_WATCH_ONLY=$(KN_SERVICES_WATCH_ONLY)'
	@echo

_kn_view_framework_targets ::
	@echo 'KN::Service ($(_KN_SERVICE_MK_VERSION)) targets:'
	@#echo '    _kn_annotate_service                - Annotate a service'
	@#echo '    _kn_apply_service                   - Apply manifest for one-or-more services'
	@echo '    _kn_create_service                  - Create a new service'
	@echo '    _kn_curl_service                    - Curl a service'
	@#echo '    _kn_delete_service                  - Delete an existing service'
	@#echo '    _kn_diff_service                    - Diff manifest for one-or-more services'
	@echo '    _kn_dig_service                     - Dig a service'
	@#echo '    _kn_edit_service                    - Edit a service'
	@#echo '    _kn_explain_service                 - Explain the service object'
	@#echo '    _kn_kustomize_service               - Kustomize one-or-more services'
	@#echo '    _kn_label_service                   - Label a service'
	@#echo '    _kn_portforward_service             - Forward local ports to an endpoint-pod of a service'
	@echo '    _kn_show_service                    - Show everything related to a service'
	@echo '    _kn_show_service_description        - Show the description of a service'
	@#echo '    _kn_show_service_endpoints          - Show the endpoints of a service'
	@#echo '    _kn_show_service_object             - Show the object of a service'
	@#echo '    _kn_show_service_pods               - Show the pods of a service'
	@#echo '    _kn_show_service_state              - Show the state of a service'
	@#echo '    _kn_unapply_service                 - Unapply a service'
	@#echo '    _kn_update_service                  - Update a service'
	@echo '    _kn_view_services                   - View all services'
	@echo '    _kn_view_services_set               - View a set of services'
	@#echo '    _kn_watch_services                  - Watch services'
	@#echo '    _kn_watch_services_set              - Watch a set of services'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kn_annotate_service:
	@$(INFO) '$(KN_UI_LABEL)Annotating service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)

_kn_apply_service: _kn_apply_services
_kn_apply_services:
	@$(INFO) '$(KN_UI_LABEL)Applying manifest for one-or-more services ...'; $(NORMAL)
	$(if $(KN_SERVICE_MANIFEST_FILEPATH), cat $(KN_SERVICE_MANIFEST_FILEPATH))
	$(if $(KN_SERVICE_MANIFEST_URL), curl -L $(KN_SERVICE_MANIFEST_URL))
	$(KN) service apply $(__KN_FILENAME__SERVICE) $(__KN_NAMESPACE__SERVICE)

_kn_create_service:
	@$(INFO) '$(KN_UI_LABEL)Creating service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)
	$(KN) service create $(__KN_ENV__SERVICE) $(__KN_IMAGE__SERVICE) $(__KN_NAMESPACE__SERVICE) $(KN_SERVICE_NAME)

_kn_curl_service:
	@$(INFO) '$(KN_UI_LABEL)Curling service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)
	$(KN_SERVICE_CURL) $(KN_SERVICE_URL) 

_kn_delete_service:
	@$(INFO) '$(KN_UI_LABEL)Deleting service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)
	$(KN) service delete $(__KN_NAMESPACE__SERVICE) $(KN_SERVICE_NAME)

_kn_diff_service: _kn_diff_services
_kn_diff_services:
	@$(INFO) '$(KN_UI_LABEL)Diff-ing manifest for one-or-more services ...'; $(NORMAL)
	# cat $(KN_SERVICE_MANIFEST_FILEPATH)
	# curl -L $(KN_SERVICE_MANIFEST_URL)
	$(KN) diff $(__KN_FILENAME__SERVICE) $(__KN_NAMESPACE__SERVICE)

_kn_dig_service:
	@$(INFO) '$(KN_UI_LABEL)Dig-ing service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)
	$(KN_SERVICE_DIG) $(KN_SERVICE_DNSNAME) 

_kn_edit_service:
	@$(INFO) '$(KN_UI_LABEL)Editing service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)
	$(KN) edit service $(__KN_NAMESPACE__SERVICE) $(KN_SERVICE_NAME)

_kn_explain_service:
	@$(INFO) '$(KN_UI_LABEL)Explaining service object ...'; $(NORMAL)
	$(KN) explain service

_kn_kustomize_service: _kn_kustomize_services
_kn_kustomize_services:
	@$(INFO) '$(KN_UI_LABEL)Kustomizing one-or-more services ...'; $(NORMAL)
	$(KN) kustomize $(KN_SERVICE_KUSTOMIZATION_DIRPATH) $(|_KN_KUSTOMIZE_SERVICE)

_kn_label_service:
	@$(INFO) '$(KN_UI_LABEL)Labeling service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)

_kn_portforward_service:
	@$(INFO) '$(KN_UI_LABEL)Forwarding ports of a pod behind service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation binds ports to 127.0.0.1 (host-port:container-port) but does NOT allow for bind addresses'; $(NORMAL)
	@$(WARN) 'If connection is idle, the port-forward will time out after a few minutes'; $(NORMAL)
	while true; do $(KN) port-forward $(__KN_ADDRESS__POD) $(__KN_NAMESPACE__SERVICE) $(__KN_POD_RUNNING_TIMEOUT__SERVICE) service/$(KN_SERVICE_NAME) $(KN_SERVICE_PORTFORWARD_PORTS) || sleep 10; date; done

_kn_show_service: _kn_show_service_description

_kn_show_service_description:
	@$(INFO) '$(KN_UI_LABEL)Showing description service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)
	$(KN) service describe $(__KN_NAMESPACE__SERVICE) $(KN_SERVICE_NAME)

_kn_show_service_endpoints:
	@$(INFO) '$(KN_UI_LABEL)Showing endpoints of service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)
	$(if $(KN_SERVICE_ENDPOINTS_FIELDSELECTOR)$(KN_SERVICE_ENDPOINTS_SELECTOR), \
		$(KN) get endpoints $(__KN_NAMESPACE__SERVICE) \
			$(if $(KN_SERVICE_ENDPOINTS_FIELDSELECTOR),--field-selector $(KN_SERVICE_ENDPOINTS_FIELDSELECTOR)) \
			$(if $(KN_SERVICE_ENDPOINTS_SELECTOR),--selector $(KN_SERVICE_ENDPOINTS_SELECTOR)) \
	, @ \
		echo 'KN_SERVICE_ENDPOINTS_FIELDSELECTOR not set';\
		echo 'KN_SERVICE_ENDPOINTS_SELECTOR not set';\
	)

_kn_show_service_object:
	@$(INFO) '$(KN_UI_LABEL)Showing object of service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)
	$(KN) get service $(__KN_NAMESPACE__SERVICE) --output yaml $(KN_SERVICE_NAME) 

_kn_show_service_pods:
	@$(INFO) '$(KN_UI_LABEL)Showing pods of service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)
	$(if $(KN_SERVICE_PODS_FIELDSELECTOR)$(KN_SERVICE_PODS_SELECTOR), \
		$(KN) get pods $(__KN_NAMESPACE__SERVICE) --output wide \
			$(if $(KN_SERVICE_PODS_FIELDSELECTOR),--field-selector $(KN_SERVICE_PODS_FIELDSELECTOR)) \
			$(if $(KN_SERVICE_PODS_SELECTOR),--selector $(KN_SERVICE_PODS_SELECTOR)) \
	, @\
		echo 'KN_SERVICE_PODS_FIELDSELECTOR not set'; \
		echo 'KN_SERVICE_PODS_SELECTOR not set'; \
	)

_kn_show_service_state:
	@$(INFO) '$(KN_UI_LABEL)Showing state of service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)
	$(KN) get service $(__KN_NAMESPACE__SERVICE) $(KN_SERVICE_NAME) 

_kn_unapply_service: _kn_unapply_services
_kn_unapply_services:
	@$(INFO) '$(KN_UI_LABEL)Un-applying manifest for one-or-more services ...'; $(NORMAL)
	# cat $(KN_SERVICE_MANIFEST_FILEPATH)
	# curl -L $(KN_SERVICE_MANIFEST_FILEPATH)
	$(KN) delete $(__KN_FILENAME__SERVICE) $(__KN_NAMESPACE__SERVICE)

_kn_unlabel_service:
	@$(INFO) '$(KN_UI_LABEL)Un-labeling manifest for service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)

_kn_update_service:
	@$(INFO) '$(KN_UI_LABEL)Updating service "$(KN_SERVICE_NAME)" ...'; $(NORMAL)

_kn_view_services:
	@$(INFO) '$(KN_UI_LABEL)Viewing ALL services ...'; $(NORMAL)
	$(KN) service list --all-namespaces=true $(_X__KN_NAMESPACE__SERVICES) $(__KN_TARGET__SERVICES)

_kn_view_services_set:
	@$(INFO) '$(KN_UI_LABEL)Viewing services-set "$(KN_SERVICES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Services are grouped based on the provided namespace, and ...'; $(NORMAL)
	$(KN) service list --all-namespaces=false $(__KN_NAMESPACE__SERVICES) $(__KN_TARGET__SERVICES)

_kn_watch_services:
	@$(INFO) '$(KN_UI_LABEL)Watching services ...'; $(NORMAL)

_kn_watch_services_set:
	@$(INFO) '$(KN_UI_LABEL)Watching services ...'; $(NORMAL)
