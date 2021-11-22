_KUBECTL_SERVICE_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_SERVICE_ANNOTATIONS_KEYVALUES?= key1=value1 ...
# KCL_SERVICE_ANNOTATIONS_KEYS?= key1 ...
# KCL_SERVICE_CURL?= curl
# KCL_SERVICE_DIG?= dig
# KCL_SERVICE_DNSNAME?= hostname.sub.domain.com
# KCL_SERVICE_DNSNAME_DOMAIN?= domain.com
# KCL_SERVICE_DNSNAME_HOSTNAME?= hostname
# KCL_SERVICE_DNSNAME_SUBDOMAIN?= sub.domain.com
# KCL_SERVICE_DRYRUN_MODE?= client
# KCL_SERVICE_ENDPOINTS_FIELDSELECTOR?= metadata.name=my-endpoint
# KCL_SERVICE_ENDPOINTS_SELECTOR?= app=service-name
# KCL_SERVICE_FIELD_JSONPATH?= .spec
# KCL_SERVICE_KUSTOMIZATION_DIRPATH?= ./in/
# KCL_SERVICE_LABELS_KEYVALUES?= key1=value1 ...
# KCL_SERVICE_LABELS_KEYS?= key1 ...
# KCL_SERVICE_NAME?= ip-172-20-33-0.us-west-2.compute.internal
# KCL_SERVICE_NAMESPACE_NAME?= default
# KCL_SERVICE_PATCH?=
# KCL_SERVICE_PATCH_DIRPATH?= ./in/
# KCL_SERVICE_PATCH_FILENAME?= patch.yaml
# KCL_SERVICE_PATCH_FILEPATH?= ./in/patch.yaml
# KCL_SERVICE_PODS_SELECTOR?= app=service-name
# KCL_SERVICE_PORTFORWARD_ADDRESS?= localhost,10.19.21.31,0.0.0.0
# KCL_SERVICE_PORTFORWARD_PORTMAPPINGS?= 8080:80 ...
# KCL_SERVICE_PORTFORWARD_TIMEOUT?= 1m0s
# KCL_SERVICE_TAILCONTAINER_NAME?= istio-proxy
KCL_SERVICE_TAILFOLLOW_FLAG?= false
# KCL_SERVICE_URL?= https://hostname.domain.com:80/my/path
# KCL_SERVICE_URL_DNSNAME?= hostname.domain.com
# KCL_SERVICE_URL_PATH?= /my/path
# KCL_SERVICE_URL_PORT?= :80
KCL_SERVICE_URL_PROTOCOL?= http://
# KCL_SERVICES_FIELDSELECTOR?= metadata.name=my-service
# KCL_SERVICES_MANIFEST_DIRPATH?= ./in/
# KCL_SERVICES_MANIFEST_FILENAME?= manifest.yaml
# KCL_SERVICES_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_SERVICES_MANIFEST_STDINFLAG?= false
# KCL_SERVICES_MANIFEST_URL?= http://...
# KCL_SERVICES_MANIFESTS_DIRPATH?= ./in/
# KCL_SERVICES_NAMESPACE_NAME?= default
# KCL_SERVICES_OUTPUT?= wide
# KCL_SERVICES_SELECTOR?=
# KCL_SERVICES_SET_NAME?= my-services-set
# KCL_SERVICES_SHOW_LABELS?= true
# KCL_SERVICES_SORTBY_JSONPATH?= true
# KCL_SERVICES_WATCH_ONLY?= true

# Derived parameters
KCL_SERVICE_CURL?= $(KCL_CURL)
KCL_SERVICE_DIG?= $(KCL_DIG)
KCL_SERVICE_DNSNAME?= $(KCL_SERVICE_DNSNAME_HOSTNAME).$(KCL_SERVICE_DNSNAME_SUBDOMAIN)
KCL_SERVICE_DNSNAME_SUBDOMAIN?= $(KCL_SERVICE_DNSNAME_DOMAIN)
KCL_SERVICE_ENDPOINTS_SELECTOR?= $(KCL_SERVICE_PODS_SELECTOR)
KCL_SERVICE_URL?= $(KCL_SERVICE_URL_PROTOCOL)$(KCL_SERVICE_URL_DNSNAME)$(KCL_SERVICE_URL_PORT)$(KCL_SERVICE_URL_PATH)
KCL_SERVICE_URL_DNSNAME?= $(KCL_SERVICE_DNSNAME)
KCL_SERVICE_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SERVICE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_SERVICE_PATCH_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SERVICE_PATCH_FILEPATH?= $(if $(KCL_SERVICE_PATCH_FILENAME),$(KCL_SERVICE_PATCH_DIRPATH)$(KCL_SERVICE_PATCH_FILENAME))
KCL_SERVICES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SERVICES_MANIFEST_FILEPATH?= $(if $(KCL_SERVICES_MANIFEST_FILENAME),$(KCL_SERVICES_MANIFEST_DIRPATH)$(KCL_SERVICES_MANIFEST_FILENAME))
KCL_SERVICES_NAMESPACE_NAME?= $(KCL_SERVICE_NAMESPACE_NAME)
KCL_SERVICES_SET_NAME?= services@$(KCL_SERVICES_FIELDSELECTOR)@$(KCL_SERVICES_SELECTOR)@$(KCL_SERVICES_NAMESPACE_NAME)

# Options
__KCL_ALL_NAMESPACES__SERVICES=
__KCL_ADDRESS__SERVICE= $(if $(KCL_SERVICE_PORTFORWARD_ADDRESS),--address $(KCL_SERVICE_PORTFORWARD_ADDRESS))
__KCL_CONTAINER__SERVICE= $(if $(KCL_SERVICE_TAILCONTAINER_NAME),--container $(KCL_SERVICE_TAILCONTAINER_NAME))
__KCL_DRY_RUN__SERVICE= $(if $(KCL_SERVICE_DRYRUN_MODE),--dry-run=$(KCL_SERVICE_DRYRUN_MODE))
__KCL_FIELD_SELECTOR__SERVICES= $(if $(KCL_SERVICES_FIELDSELECTOR),--field-selector $(KCL_SERVICES_FIELDSELECTOR))
__KCL_FILENAME__SERVICES+= $(if $(KCL_SERVICES_MANIFEST_FILEPATH),--filename $(KCL_SERVICES_MANIFEST_FILEPATH))
__KCL_FILENAME__SERVICES+= $(if $(filter true,$(KCL_SERVICES_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__SERVICES+= $(if $(KCL_SERVICES_MANIFEST_URL),--filename $(KCL_SERVICES_MANIFEST_URL))
__KCL_FILENAME__SERVICES+= $(if $(KCL_SERVICES_MANIFESTS_DIRPATH),--filename $(KCL_SERVICES_MANIFESTS_DIRPATH))
__KCL_FOLLOW__SERVICE+= $(if $(KCL_SERVICE_TAILFOLLOW_FLAG),--follow=$(KCL_SERVICE_TAILFOLLOW_FLAG))
__KCL_KUSTOMIZE__SERVICE= $(if $(KCL_SERVICE_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_SERVICE_KUSTOMIZATION_DIRPATH))
__KCL_NAMESPACE__SERVICE= $(if $(KCL_SERVICE_NAMESPACE_NAME),--namespace $(KCL_SERVICE_NAMESPACE_NAME))
__KCL_NAMESPACE__SERVICES= $(if $(KCL_SERVICES_NAMESPACE_NAME),--namespace $(KCL_SERVICES_NAMESPACE_NAME))
__KCL_OUTPUT__SERVICES= $(if $(KCL_SERVICES_OUTPUT),--output $(KCL_SERVICES_OUTPUT))
__KCL_POD_RUNNING_TIMEOUT__SERVICE= $(if $(KCL_SERVICE_PORTFORWARD_TIMEOUT),--pod-running-timeout=$(KCL_SERVICE_PORTFORWARD_TIMEOUT))
__KCL_SELECTOR__SERVICES= $(if $(KCL_SERVICES_SELECTOR),--selector=$(KCL_SERVICES_SELECTOR))
__KCL_SHOW_LABELS__SERVICE= $(if $(filter true, $(KCL_SERVICE_SHOW_LABELS)),--show-labels)
__KCL_SORT_BY__SERVICES= $(if $(KCL_SERVICES_SORTBY_JSONPATH),--sort-by=$(KCL_SERVICES_SORTBY_JSONPATH))
__KCL_TAIL__SERVICE= $(if $(KCL_SERVICE_TAILHISTORY_COUNT),--tail=$(KCL_SERVICE_TAILHISTORY_COUNT))
__KCL_TIMESTAMP__SERVICE=
__KCL_WATCH_ONLY__SERVICES= $(if $(KCL_SERVICES_WATCH_ONLY),--watch-only=$(KCL_SERVICES_WATCH_ONLY))

# Customizations
_KCL_APPLY_SERVICES_|?= #
_KCL_CURL_SERVICE_|?=
_KCL_DIFF_SERVICES_|?= $(_KCL_APPLY_SERVICE_|)
_KCL_DIG_SERVICE_|?=
_KCL_PORTFORWARD_SERVICE_|?= while true; do #
_KCL_TAIL_SERVICE_|?=
_KCL_UNAPPLY_SERVICES_|?= $(_KCL_APPLY_SERVICES_|)
|_KCL_CURL_SERVICE?=
|_KCL_DIG_SERVICE?=
|_KCL_KUSTOMIZE_SERVICE?=
|_KCL_PORTFORWARD_SERVICE?= || sleep 10; date; done
|_KCL_TAIL_SERVICE?= # | tee service.log

# Macros
_kcl_get_service_external_ip= $(call _kcl_get_service_external_ip_N, $(KCL_SERVICE_NAME))
_kcl_get_service_external_ip_N= $(call _kcl_get_service_external_ip_NN, $(1), $(KCL_SERVICE_NAMESPACE_NAME))
_kcl_get_service_external_ip_NN= $(shell $(KUBECTL) get services --namespace $(2) $(1) -o jsonpath="{.status.loadBalancer.ingress[].ip}")

_kcl_get_service_pod_selector= $(call _kcl_get_service_pod_selector_N, $(KCL_SERVICE_NAME))
_kcl_get_service_pod_selector_N= $(call _kcl_get_service_pod_selector_NN, $(1), $(KCL_SERVICE_NAMESPACE_NAME))
_kcl_get_service_pod_selector_NN= $(shell $(KUBECTL) get service --namespace $(2) $(1) -o wide | awk 'NR==2 {print $$7}')

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Service ($(_KUBECTL_SERVICE_MK_VERSION)) macros:'
	@echo '    _kcl_get_service_loadbalancer_ip_{|N|NN}    - Get the IP of a load-balancer service (Name,Namespace)'
	@echo '    _kcl_get_service_pod_selector_{|N|NN}       - Get the pod-selector of a service (Name,Namespace)'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Service ($(_KUBECTL_SERVICE_MK_VERSION)) parameters:'
	@echo '    KCL_SERVICE_ANNOTATIONS_KEYS=$(KCL_SERVICE_ANNOTATIONS_KEYS)'
	@echo '    KCL_SERVICE_ANNOTATIONS_KEYVALUES=$(KCL_SERVICE_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_SERVICE_DNSNAME=$(KCL_SERVICE_DNSNAME)'
	@echo '    KCL_SERVICE_DNSNAME_DOMAIN=$(KCL_SERVICE_DNSNAME_DOMAIN)'
	@echo '    KCL_SERVICE_DNSNAME_HOSTNAME=$(KCL_SERVICE_DNSNAME_HOSTNAME)'
	@echo '    KCL_SERVICE_DNSNAME_SUBDOMAIN=$(KCL_SERVICE_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_SERVICE_ENDPOINTS_FIELDSELECTOR=$(KCL_SERVICE_ENDPOINTS_FIELDSELECTOR)'
	@echo '    KCL_SERVICE_ENDPOINTS_SELECTOR=$(KCL_SERVICE_ENDPOINTS_SELECTOR)'
	@echo '    KCL_SERVICE_FIELD_JSONPATH=$(KCL_SERVICE_FIELD_JSONPATH)'
	@echo '    KCL_SERVICE_LABELS_KEYS=$(KCL_SERVICE_LABELS_KEYS)'
	@echo '    KCL_SERVICE_LABELS_KEYVALUES=$(KCL_SERVICE_LABELS_KEYVALUES)'
	@echo '    KCL_SERVICE_NAME=$(KCL_SERVICE_NAME)'
	@echo '    KCL_SERVICE_NAMESPACE_NAME=$(KCL_SERVICE_NAMESPACE_NAME)'
	@echo '    KCL_SERVICE_PATCH=$(KCL_SERVICE_PATCH)'
	@echo '    KCL_SERVICE_PATCH_DIRPATH=$(KCL_SERVICE_PATCH_DIRPATH)'
	@echo '    KCL_SERVICE_PATCH_FILENAME=$(KCL_SERVICE_PATCH_FILENAME)'
	@echo '    KCL_SERVICE_PATCH_FILEPATH=$(KCL_SERVICE_PATCH_FILEPATH)'
	@echo '    KCL_SERVICE_PODS_SELECTOR=$(KCL_SERVICE_PODS_SELECTOR)'
	@echo '    KCL_SERVICE_PORTFORWARD_ADDRESS=$(KCL_SERVICE_PORTFORWARD_ADDRESS)'
	@echo '    KCL_SERVICE_PORTFORWARD_PORTMAPPINGS=$(KCL_SERVICE_PORTFORWARD_PORTMAPPINGS)'
	@echo '    KCL_SERVICE_PORTFORWARD_TIMEOUT=$(KCL_SERVICE_PORTFORWARD_TIMEOUT)'
	@echo '    KCL_SERVICE_TAILCONTAINER_NAME=$(KCL_SERVICE_TAILCONTAINER_NAME)'
	@echo '    KCL_SERVICE_TAILFOLLOW_FLAG=$(KCL_SERVICE_TAILFOLLOW_FLAG)'
	@echo '    KCL_SERVICE_TAILHISTORY_COUNT=$(KCL_SERVICE_TAILHISTORY_COUNT)'
	@echo '    KCL_SERVICE_URL=$(KCL_SERVICE_URL)'
	@echo '    KCL_SERVICE_URL_DNSNAME=$(KCL_SERVICE_URL_DNSNAME)'
	@echo '    KCL_SERVICE_URL_PATH=$(KCL_SERVICE_URL_PATH)'
	@echo '    KCL_SERVICE_URL_PORT=$(KCL_SERVICE_URL_PORT)'
	@echo '    KCL_SERVICE_URL_PROTOCOL=$(KCL_SERVICE_URL_PROTOCOL)'
	@echo '    KCL_SERVICES_FIELDSELECTOR=$(KCL_SERVICES_FIELDSELECTOR)'
	@echo '    KCL_SERVICES_MANIFEST_DIRPATH=$(KCL_SERVICES_MANIFEST_DIRPATH)'
	@echo '    KCL_SERVICES_MANIFEST_FILENAME=$(KCL_SERVICES_MANIFEST_FILENAME)'
	@echo '    KCL_SERVICES_MANIFEST_FILEPATH=$(KCL_SERVICES_MANIFEST_FILEPATH)'
	@echo '    KCL_SERVICES_MANIFEST_STDINFLAG=$(KCL_SERVICES_MANIFEST_STDINFLAG)'
	@echo '    KCL_SERVICES_MANIFEST_URL=$(KCL_SERVICES_MANIFEST_URL)'
	@echo '    KCL_SERVICES_MANIFESTS_DIRPATH=$(KCL_SERVICES_MANIFESTS_DIRPATH)'
	@echo '    KCL_SERVICES_NAMESPACE_NAME=$(KCL_SERVICES_NAMESPACE_NAME)'
	@echo '    KCL_SERVICES_OUTPUT=$(KCL_SERVICES_OUTPUT)'
	@echo '    KCL_SERVICES_SELECTOR=$(KCL_SERVICES_SELECTOR)'
	@echo '    KCL_SERVICES_SET_NAME=$(KCL_SERVICES_SET_NAME)'
	@echo '    KCL_SERVICES_SHOW_LABELS=$(KCL_SERVICES_SHOW_LABELS)'
	@echo '    KCL_SERVICES_SORTBY_JSONPATH=$(KCL_SERVICES_SORTBY_JSONPATH)'
	@echo '    KCL_SERVICES_WATCH_ONLY=$(KCL_SERVICES_WATCH_ONLY)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Service ($(_KUBECTL_SERVICE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_service                - Annotate a service'
	@echo '    _kcl_apply_services                  - Apply a manifest for one-or-more services'
	@echo '    _kcl_create_service                  - Create a new service'
	@echo '    _kcl_curl_service                    - Curl a service'
	@echo '    _kcl_delete_service                  - Delete an existing service'
	@echo '    _kcl_diff_services                   - Diff manifest for one-or-more services'
	@echo '    _kcl_dig_service                     - Dig a service'
	@echo '    _kcl_edit_service                    - Edit a service'
	@echo '    _kcl_explain_service                 - Explain the service object'
	@echo '    _kcl_kustomize_service               - Kustomize one-or-more services'
	@echo '    _kcl_label_service                   - Label a service'
	@echo '    _kcl_list_services                   - List all services'
	@echo '    _kcl_list_services_set               - List a set of services'
	@echo '    _kcl_patch_service                   - Patch a service'
	@echo '    _kcl_portforward_service             - Forward local ports to an endpoint-pod of a service'
	@echo '    _kcl_read_services                   - Read a manifest for one-or-more services'
	@echo '    _kcl_show_service                    - Show everything related to a service'
	@echo '    _kcl_show_service_description        - Show the description of a service'
	@echo '    _kcl_show_service_endpoints          - Show the endpoints of a service'
	@echo '    _kcl_show_service_envvars            - Show the environment-variables of a service'
	@echo '    _kcl_show_service_object             - Show the object of a service'
	@echo '    _kcl_show_service_pods               - Show the pods of a service'
	@echo '    _kcl_show_service_state              - Show the state of a service'
	@echo '    _kcl_tail_service                    - Tail the pods of a service'
	@echo '    _kcl_unannotate_service              - Un-annotate a service'
	@echo '    _kcl_unapply_services                - Un-apply a manifest for one-or-more services'
	@echo '    _kcl_unlabel_service                 - Un-label a service'
	@echo '    _kcl_watch_services                  - Watch services'
	@echo '    _kcl_watch_services_set              - Watch a set of services'
	@echo '    _kcl_write_services                  - Write a manifest for one-or-more services'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_service:
	@$(INFO) '$(KCL_UI_LABEL)Annotating service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate $(__KCL_NAMESPACE__SERVICE) $(KCL_SERVICE_NAME) $(KCL_SERVICE_ANNOTATIONS_KEYVALUES)

_kcl_apply_service: _kcl_apply_services
_kcl_apply_services:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more services ...'; $(NORMAL)
	$(if $(KCL_SERVICES_MANIFEST_FILEPATH),cat $(KCL_SERVICES_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_SERVICES_MANIFEST_STDINFLAG)),$(_KCL_APPLY_SERVICES_|)cat)
	$(if $(KCL_SERVICES_MANIFEST_URL),curl -L $(KCL_SERVICES_MANIFEST_URL))
	$(if $(KCL_SERVICES_MANIFESTS_DIRPATH),ls -al $(KCL_SERVICES_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_SERVICES_|)$(KUBECTL) apply $(__KCL_FILENAME__SERVICES) $(__KCL_NAMESPACE__SERVICES)

_kcl_create_service:
	@$(INFO) '$(KCL_UI_LABEL)Creating service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) create service $(__KCL_NAMESPACE__SERVICE) $(__KCL_SERVICE_PORT)

_kcl_curl_service:
	@$(INFO) '$(KCL_UI_LABEL)Curling service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	$(_KCL_CURL_SERVICE_|)$(KCL_SERVICE_CURL) $(KCL_SERVICE_URL) $(|_KCL_CURL_SERVICE)

_kcl_delete_service:
	@$(INFO) '$(KCL_UI_LABEL)Deleting service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete service $(__KCL_NAMESPACE__SERVICE) $(KCL_SERVICE_NAME)

_kcl_diff_service: _kcl_diff_services
_kcl_diff_services:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more services ...'; $(NORMAL)
	@$(WARN) 'This operation submits the manifest to the cluster to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_SERVICES_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_SERVICES_|)cat
	# curl -L $(KCL_SERVICES_MANIFEST_URL)
	# ls -al $(KCL_SERVICES_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_SERVICES_|)$(KUBECTL) diff $(__KCL_FILENAME__SERVICES) $(__KCL_NAMESPACE__SERVICES)

_kcl_dig_service:
	@$(INFO) '$(KCL_UI_LABEL)Dig-ing service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	$(_KCL_DIG_SERVICE_|)$(KCL_SERVICE_DIG) $(KCL_SERVICE_DNSNAME) $(|_KCL_DIG_SERVICE)

_kcl_edit_service:
	@$(INFO) '$(KCL_UI_LABEL)Editing service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit service $(__KCL_NAMESPACE__SERVICE) $(KCL_SERVICE_NAME)

_kcl_explain_service:
	@$(INFO) '$(KCL_UI_LABEL)Explaining service object ...'; $(NORMAL)
	$(KUBECTL) explain service$(KCL_SERVICE_FIELD_JSONPATH)

_kcl_kustomize_service: _kcl_kustomize_services
_kcl_kustomize_services:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more services ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_SERVICE_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_SERVICE)

_kcl_label_service:
	@$(INFO) '$(KCL_UI_LABEL)Labeling service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label $(__KCL_NAMESPACE__SERVICE) $(KCL_SERVICE_NAME) $(KCL_SERVICE_LABELS_KEYVALUES)

_kcl_list_services:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL services ...'; $(NORMAL)
	@$(WARN) 'At a minimum, this operation returns the service to connect to the K8s API server, i.e. kubernetes.default.svc.cluster.local'; $(NORMAL)
	@$(WARN) 'Ports are reported as CSV of Service_port:Node_port/protocol or Service_port/protocol'; $(NROMAL)
	@$(WARN) 'To see the target-ports on backends you must describe the services'; $(NORMAL)
	$(KUBECTL) get services --all-namespaces=true $(_X__KCL_NAMESPACE__SERVICES) $(__KCL_OUTPUT__SERVICES) $(_X__KCL_SELECTOR__SERVICES)$(__KCL_SHOW_LABELS__SERVICES) $(__KCL_SORT_BY__SERVICES)

_kcl_list_services_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing services-set "$(KCL_SERVICES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Services are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	@$(WARN) 'Ports are reported as CSV of Service_port:Node_port/protocol or Service_port/protocol'; $(NROMAL)
	@$(WARN) 'To see the target-ports on backends you must describe the services'; $(NORMAL)
	$(KUBECTL) get services --all-namespaces=false $(__KCL_FIELD_SELECTOR__SERVICES) $(__KCL_NAMESPACE__SERVICES) $(__KCL_OUTPUT__SERVICES) $(__KCL_SELECTOR__SERVICES) $(__KCL_SHOW_LABELS__SERVICES) $(__KCL_SORT_BY__SERVICES)

_kcl_patch_service:
	@$(INFO) '$(KCL_UI_LABEL)Patching service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) patch service $(__KCL_NAMESPACE__SERVICE) $(__KCL_PATCH__SERVICE) $(__KCL_PATCH_FILE__SERVICE) $(KCL_SERVICE_NAME)

_kcl_portforward_service:
	@$(INFO) '$(KCL_UI_LABEL)Port-forwarding a pod behind service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation binds ports to 127.0.0.1 (host-port:container-port) but does NOT allow for bind addresses'; $(NORMAL)
	@$(WARN) 'If connection is idle, the port-forward will time out after a few minutes'; $(NORMAL)
	$(_KCL_PORTFORWARD_SERVICE_|)$(KUBECTL) port-forward $(__KCL_ADDRESS__SERVICE) $(__KCL_NAMESPACE__SERVICE) $(__KCL_POD_RUNNING_TIMEOUT__SERVICE) service/$(KCL_SERVICE_NAME) $(KCL_SERVICE_PORTFORWARD_PORTMAPPINGS) $(|_KCL_PORTFORWARD_SERVICE)

_kcl_read_service: _kcl_read_services
_kcl_read_services:
	@$(INFO) '$(KCL_UI_LABEL)Reading a manifest for one-or-more services ...'; $(NORMAL)
	$(READER) $(KCL_SERVICES_MANIFEST_FILEPATH)

_KCL_SHOW_SERVICE_TARGETS?= _kcl_show_service_dnsname _kcl_show_service_endpoints _kcl_show_service_envvars _kcl_show_service_object _kcl_show_service_pods _kcl_show_service_state _kcl_show_service_description
_kcl_show_service: $(_KCL_SHOW_SERVICE_TARGETS)

_kcl_show_service_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this service is accessible at $(KCL_SERVICE_NAME).$(KCL_SERVICE_NAMESPACE_NAME).svc.cluster.local'; $(NORMAL)
	$(KUBECTL) describe service $(__KCL_NAMESPACE__SERVICE) $(KCL_SERVICE_NAME)

_kcl_show_service_endpoints:
	@$(INFO) '$(KCL_UI_LABEL)Showing endpoints of service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	$(if $(KCL_SERVICE_ENDPOINTS_FIELDSELECTOR)$(KCL_SERVICE_ENDPOINTS_SELECTOR), \
		$(KUBECTL) get endpoints $(__KCL_NAMESPACE__SERVICE) \
			$(if $(KCL_SERVICE_ENDPOINTS_FIELDSELECTOR),--field-selector $(KCL_SERVICE_ENDPOINTS_FIELDSELECTOR)) \
			$(if $(KCL_SERVICE_ENDPOINTS_SELECTOR),--selector $(KCL_SERVICE_ENDPOINTS_SELECTOR)) \
	, @ \
		echo 'KCL_SERVICE_ENDPOINTS_FIELDSELECTOR not set';\
		echo 'KCL_SERVICE_ENDPOINTS_SELECTOR not set';\
	)

_kcl_show_service_dnsname:
	@$(INFO) '$(KCL_UI_LABEL)Showing the DNS-names to reach service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the DNSNAMES to be used in URLs to reach the service within the cluster'; $(NORMAL)
	@$(WARN) 'To reach the service from outside the cluster, look at the service with load-balancer type or node-ports'; $(NORMAL)
	@echo 'Federated cluster: $(KCL_SERVICE_NAME).$(KCL_SERVICE_NAMESPACE_NAME).svc.cluster.local'
	@echo 'Cluster wide: $(KCL_SERVICE_NAME).$(KCL_SERVICE_NAMESPACE_NAME)'
	@echo 'In same namespace: $(KCL_SERVICE_NAME)'

_kcl_show_service_envvars:
	@$(INFO) '$(KCL_UI_LABEL)Showing environment-variables of service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation displays the environment variables auto-injected in all NEW pods by service-discovery'; $(NORMAL)
	@echo '<NAME>_<OF>_<SERVICE>_SERVICE_HOST for the IP address of the service'
	@echo '<NAME>_<OF>_<SERVICE>_SERVICE_PORT for the unnamed port number of the service'
	@echo '<NAME>_<OF>_<SERVICE>_SERVICE_PORT_<NAME> for a named port number of the service'
	@$(WARN) 'Environment variables uses only upper case letters!'; $(NORMAL)
	@echo 'Ex: A redis client-pod can set its envvar REDIS_URL to "redis://$$(DATA_TIER_SERVICE_HOST):$$(DATA_TIER_SERVICE_PORT_REDIS)"'

_kcl_show_service_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get service $(__KCL_NAMESPACE__SERVICE) --output yaml $(KCL_SERVICE_NAME) 

_kcl_show_service_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods of service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	$(if $(KCL_SERVICE_PODS_FIELDSELECTOR)$(KCL_SERVICE_PODS_SELECTOR), \
		$(KUBECTL) get pods $(__KCL_NAMESPACE__SERVICE) --output wide \
			$(if $(KCL_SERVICE_PODS_FIELDSELECTOR),--field-selector $(KCL_SERVICE_PODS_FIELDSELECTOR)) \
			$(if $(KCL_SERVICE_PODS_SELECTOR),--selector $(KCL_SERVICE_PODS_SELECTOR)) \
	, @\
		echo 'KCL_SERVICE_PODS_FIELDSELECTOR not set'; \
		echo 'KCL_SERVICE_PODS_SELECTOR not set'; \
	)

_kcl_show_service_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Ports are reported as CSV of Service_port:Node_port/protocol or Service_port/protocol'; $(NORMAL)
	@$(WARN) 'To see the target-ports on backends you must describe the service'; $(NORMAL)
	$(KUBECTL) get service $(__KCL_NAMESPACE__SERVICE) $(KCL_SERVICE_NAME) 

_kcl_tail_service:
	@$(INFO) '$(KCL_UI_LABEL)Tailing pods of service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation tails a single pod in the endpoints of the service'; $(NORMAL)
	$(_KCL_TAIL_SERVICE_|)$(KUBECTL) logs $(__KCL_CONTAINER__SERVICE) $(__KCL_FOLLOW__SERVICE) $(__KCL_NAMESPACE__SERVICE) $(__KCL_TAIL__SERVICE) $(__KLC_TIMESTAMP__SERVICE) service/$(strip $(KCL_SERVICE_NAME) )

_kcl_unannotate_service:
	@$(INFO) '$(KCL_UI_LABEL)Un-annotating service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate $(_KCL_NAMESPACE__SERVICE) $(KCL_SERVICE_NAME) $(foreach K,$(KCL_SERVICE_ANNOTATIONS_KEYS), $(K)-)

_kcl_unapply_service: _kcl_unapply_services
_kcl_unapply_services:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more services ...'; $(NORMAL)
	# cat $(KCL_SERVICES_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_SERVICES_|)cat
	# curl -L $(KCL_SERVICES_MANIFEST_FILEPATH)
	# ls -al $(KCL_SERVICES_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_SERVICES_|)$(KUBECTL) delete $(__KCL_FILENAME__SERVICES) $(__KCL_NAMESPACE__SERVICES)

_kcl_unlabel_service:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling service "$(KCL_SERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label $(_KCL_NAMESPACE__SERVICE) $(KCL_SERVICE_NAME) $(foreach K,$(KCL_SERVICE_LABELS_KEYS), $(K)-)

_kcl_watch_services:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL services ...'; $(NORMAL)
	@$(WARN) 'At a minimum, this operation returns the service to connect to the K8s API server, i.e. kubernetes.default.svc.cluster.local'; $(NORMAL)
	@$(WARN) 'Ports are reported as CSV of Service_port:Node_port/protocol or Service_port/protocol'; $(NORMAL)
	@$(WARN) 'To see the target-ports on backends you must describe the services'; $(NORMAL)
	$(KUBECTL) get services $(strip $(_X__KCL_ALL_NAMESPACES__SERVICES) --all-namespaces=true $(_X__KCL_NAMESPACE__SERVICES) $(__KCL_OUTPUT__SERVICES) $(_X__KCL_SELECTOR__SERVICES) $(_X__KCL_WATCH__SERVICES) --watch=true $(__KCL_WATCH_ONLY__SERVICES) )

_kcl_watch_services_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching services-set "$(KCL_SERVICES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Services are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	@$(WARN) 'Ports are reported as CSV of Service_port:Node_port/protocol or Service_port/protocol.'
	@$(WARN) 'To see the target-ports on backends you must describe the services'; $(NORMAL)
	$(KUBECTL) get services $(strip $(__KCL_ALL_NAMESPACES__SERVICES) $(__KCL_NAMESPACE__SERVICES) $(__KCL_OUTPUT__SERVICES) $(__KCL_SELECTOR__SERVICES) $(_X__KCL_WATCH__SERVICES) --watch=true $(__KCL_WATCH_ONLY__SERVICES) )

_kcl_write_service: _kcl_write_services
_kcl_write_services:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more services ...'; $(NORMAL)
	$(WRITER) $(KCL_SERVICES_MANIFEST_FILEPATH)
