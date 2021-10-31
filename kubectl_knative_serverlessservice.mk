_KUBECTL_KNATIVE_SERVERLESSSERVICE_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# KCL_SERVERLESSSERVICE_CONFIGURATIONS_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_SERVERLESSSERVICE_CURL?= time curl
# KCL_SERVERLESSSERVICE_DEPLOYMENTS_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_SERVERLESSSERVICE_DIG?= time dig +short
# KCL_SERVERLESSSERVICE_DNSNAME?= v1.go-helloworld.default.example.com
# KCL_SERVERLESSSERVICE_DNSNAME_DOMAIN?= example.com
# KCL_SERVERLESSSERVICE_DNSNAME_SUBDOMAIN?= go-helloworld.default.example.com
# KCL_SERVERLESSSERVICE_ID?= 00001
# KCL_SERVERLESSSERVICE_KSERVICE_NAME?= go-helloworld
# KCL_SERVERLESSSERVICE_KUSTOMIZATION_DIRPATH?= ./in/
# KCL_SERVERLESSSERVICE_NAME?= go-helloworld-00001
# KCL_SERVERLESSSERVICE_NAMESPACE_NAME?= default
# KCL_SERVERLESSSERVICE_PODS_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_SERVERLESSSERVICE_REPLICASETS_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_SERVERLESSSERVICE_SERVERLESSSERVICES_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_SERVERLESSSERVICE_SERVICES_NAMES?= go-helloworld-00001 go-helloworld-00001-private
# KCL_SERVERLESSSERVICE_SERVICES_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_SERVERLESSSERVICE_UID?=bdd9a590-9fa1-4b93-9cd7-76b6d26e7056
# KCL_SERVERLESSSERVICE_URL?= http://v1.go-helloworld.default.example.com:80/my/path
# KCL_SERVERLESSSERVICE_URL_DNSNAME?= v1.go-helloworld.default.example.com
# KCL_SERVERLESSSERVICE_URL_PATH?= /my/path
# KCL_SERVERLESSSERVICE_URL_PROTOCOL?= http://
# KCL_SERVERLESSSERVICE_URL_PORT?= :80
# KCL_SERVERLESSSERVICES_FIELDSELECTOR?= metadata.name=my-serverless-service
# KCL_SERVERLESSSERVICES_MANIFEST_DIRPATH?= ./in/
# KCL_SERVERLESSSERVICES_MANIFEST_FILENAME?= manifest.yaml
# KCL_SERVERLESSSERVICES_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_SERVERLESSSERVICES_MANIFEST_STDINFLAG?= false
# KCL_SERVERLESSSERVICES_MANIFEST_URL?= http://...
# KCL_SERVERLESSSERVICES_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_SERVERLESSSERVICES_NAMESPACE_NAME?= default
# KCL_SERVERLESSSERVICES_OUTPUT?= wide
# KCL_SERVERLESSSERVICES_SELECTOR?=
# KCL_SERVERLESSSERVICES_SET_NAME?= my-set
# KCL_SERVERLESSSERVICES_SHOW_LABELS?= true
# KCL_SERVERLESSSERVICES_WATCH_ONLY?= true

# Derived parameters
KCL_SERVERLESSSERVICE_CONFIGURATIONS_SELECTOR?= serving.knative.dev/XXX=$(KCL_SERVERLESSSERVICE_NAME)
KCL_SERVERLESSSERVICE_CURL= $(KCL_KNATIVESERVING_CURL)
KCL_SERVERLESSSERVICE_DEPLOYMENTS_SELECTOR?= serving.knative.dev/XXX=$(KCL_SERVERLESSSERVICE_NAME)
KCL_SERVERLESSSERVICE_DIG= $(KCL_KNATIVESERVING_DIG)
KCL_SERVERLESSSERVICE_DNSNAME?= $(KCL_SERVERLESSSERVICE_NAME).$(KCL_SERVERLESSSERVICE_DNSNAME_SUBDOMAIN)
KCL_SERVERLESSSERVICE_DNSNAME_DOMAIN?= $(KCL_KNATIVESERVING_DNSNAME_DOMAIN)
KCL_SERVERLESSSERVICE_DNSNAME_HOSTNAME?= $(KCL_SERVERLESSSERVICE_NAME)
KCL_SERVERLESSSERVICE_DNSNAME_SUBDOMAIN?= $(KCL_SERVERLESSSERVICE_KSERVICE_NAME).$(KCL_SERVERLESSSERVICE_NAMESPACE_NAME).$(KCL_SERVERLESSSERVICE_DNSNAME_DOMAIN)
KCL_SERVERLESSSERVICE_KSERVICE_NAME?= $(KCL_KSERVICE_NAME)
KCL_SERVERLESSSERVICE_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SERVERLESSSERVICE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_SERVERLESSSERVICE_NAME?= $(if $(KCL_SERVERLESSSERVICE_ID),$(KCL_SERVERLESSSERVICE_KSERVICE_NAME)-$(KCL_SERVERLESSSERVICE_ID))
KCL_SERVERLESSSERVICE_PODS_SELECTOR?= serving.knative.dev/XXX=$(KCL_SERVERLESSSERVICE_NAME)
KCL_SERVERLESSSERVICE_REPLICASETS_SELECTOR?= serving.knative.dev/XXX=$(KCL_SERVERLESSSERVICE_NAME)
KCL_SERVERLESSSERVICE_SERVERLESSSERVICES_SELECTOR?= serving.knative.dev/XXX=$(KCL_SERVERLESSSERVICE_NAME)
KCL_SERVERLESSSERVICE_SERVERLESSSERVICES_SELECTOR?= serving.knative.dev/XXX=$(KCL_SERVERLESSSERVICE_NAME)
KCL_SERVERLESSSERVICE_SERVERLESSSERVICES_SELECTOR?= serving.knative.dev/XXX=$(KCL_SERVERLESSSERVICE_NAME)
KCL_SERVERLESSSERVICE_SERVICES_NAMES?= $(KCL_SERVERLESSSERVICE_NAME) $(KCL_SERVERLESSSERVICE_NAME)-private
KCL_SERVERLESSSERVICE_SERVICES_SELECTOR?= serving.knative.dev/XXX=$(KCL_SERVERLESSSERVICE_NAME)
KCL_SERVERLESSSERVICE_URL?= $(KCL_SERVERLESSSERVICE_URL_PROTOCOL)$(KCL_SERVERLESSSERVICE_URL_DNSNAME)$(KCL_SERVERLESSSERVICE_URL_PORT)$(KCL_SERVERLESSSERVICE_URL_PATH)
KCL_SERVERLESSSERVICE_URL_DNSNAME?= $(KCL_SERVERLESSSERVICE_DNSNAME)
KCL_SERVERLESSSERVICES_DNSNAME_DOMAIN?= $(KCL_SERVERLESSSERVICE_DNSNAME_DOMAIN)
KCL_SERVERLESSSERVICES_DNSNAME_SUBDOMAIN?= $(KCL_SERVERLESSSERVICES_KSERVICE_NAME).$(KCL_SERVERLESSSERVICES_NAMESPACE_NAME).$(KCL_SERVERLESSSERVICES_DNSNAME_DOMAIN)
KCL_SERVERLESSSERVICES_KSERVICE_NAME?= $(KCL_SERVERLESSSERVICE_KSERVICE_NAME)
KCL_SERVERLESSSERVICES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SERVERLESSSERVICES_MANIFEST_FILEPATH?= $(if $(KCL_SERVERLESSSERVICES_MANIFEST_FILENAME),$(KCL_SERVERLESSSERVICES_MANIFEST_DIRPATH)$(KCL_SERVERLESSSERVICES_MANIFEST_FILENAME))
KCL_SERVERLESSSERVICES_NAMESPACE_NAME?= $(KCL_SERVERLESSSERVICE_NAMESPACE_NAME)
KCL_SERVERLESSSERVICES_SET_NAME?= serverless-services@$(KCL_SERVERLESSSERVICES_FIELDSELECTOR)@$(KCL_SERVERLESSSERVICES_SELECTOR)@$(KCL_SERVERLESSSERVICES_NAMESPACE_NAME)

# Option parameters
__KCL_ALL_NAMESPACES__SERVERLESSSERVICES=
__KCL_FIELD_SELECTOR__SERVERLESSSERVICES= $(if $(KCL_SERVERLESSSERVICES_FIELDSELECTOR),--field-selector $(KCL_SERVERLESSSERVICES_FIELDSELECTOR))
__KCL_FILENAME__SERVERLESSSERVICES+= $(if $(KCL_SERVERLESSSERVICES_MANIFEST_FILEPATH),--filename $(KCL_SERVERLESSSERVICES_MANIFEST_FILEPATH))
__KCL_FILENAME__SERVERLESSSERVICES+= $(if $(filter true,$(KCL_SERVERLESSSERVICES_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__SERVERLESSSERVICES+= $(if $(KCL_SERVERLESSSERVICES_MANIFEST_URL),--filename $(KCL_SERVERLESSSERVICES_MANIFEST_URL))
__KCL_FILENAME__SERVERLESSSERVICES+= $(if $(KCL_SERVERLESSSERVICES_MANIFESTS_DIRPATH),--filename $(KCL_SERVERLESSSERVICES_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__SERVERLESSSERVICE= $(if $(KCL_SERVERLESSSERVICE_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_SERVERLESSSERVICE_KUSTOMIZATION_DIRPATH))
__KCL_NAMESPACE__SERVERLESSSERVICE= $(if $(KCL_SERVERLESSSERVICE_NAMESPACE_NAME),--namespace $(KCL_SERVERLESSSERVICE_NAMESPACE_NAME))
__KCL_NAMESPACE__SERVERLESSSERVICES= $(if $(KCL_SERVERLESSSERVICES_NAMESPACE_NAME),--namespace $(KCL_SERVERLESSSERVICES_NAMESPACE_NAME))
__KCL_OUTPUT__SERVERLESSSERVICES= $(if $(KCL_SERVERLESSSERVICES_OUTPUT),--output $(KCL_SERVERLESSSERVICES_OUTPUT))
__KCL_SELECTOR__SERVERLESSSERVICES= $(if $(KCL_SERVERLESSSERVICES_SELECTOR),--selector=$(KCL_SERVERLESSSERVICES_SELECTOR))
__KCL_SHOW_LABELS__SERVERLESSSERVICE= $(if $(filter true, $(KCL_SERVERLESSSERVICE_SHOW_LABELS)),--show-labels)
__KCL_WATCH_ONLY__SERVERLESSSERVICES= $(if $(KCL_SERVERLESSSERVICES_WATCH_ONLY),--watch-only=$(KCL_SERVERLESSSERVICES_WATCH_ONLY))

# Pipe parameters
|_KCL_KUSTOMIZE_SERVERLESSSERVICE?=

# UI parameters

#--- MACROS
# _kcl_get_serverlessservice_pods_names= $(call _kcl_get_serverlessservice_pods_names_N, $(KCL_SERVERLESSSERVICE_NAME))
# _kcl_get_serverlessservice_pods_names_N= $(call _kcl_get_serverlessservice_pods_names_NN, $(1), $(KCL_SERVERLESSSERVICE_NAMESPACE_NAME))
# _kcl_get_serverlessservice_pods_names_NN= $(shell $(KUBECTL) get pods --namespace $(2) --selector=$(1) -o wide | awk 'NR==2 {print $$7}')

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Knative::ServerlessService ($(_KUBECTL_KNATIVE_SERVERLESSSERVICE_MK_VERSION)) macros:'
	@#echo '    _kcl_get_serverlessservice_pod_selector_{|N|NN}       - Get the pod-selector of a service (Name,Namespace)'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Knative::ServerlessService ($(_KUBECTL_KNATIVE_SERVERLESSSERVICE_MK_VERSION)) parameters:'
	@echo '    KCL_SERVERLESSSERVICE_CONFIGURATIONS_SELECTOR=$(KCL_SERVERLESSSERVICE_CONFIGURATIONS_SELECTOR)'
	@echo '    KCL_SERVERLESSSERVICE_DEPLOYMENTS_SELECTOR=$(KCL_SERVERLESSSERVICE_DEPLOYMENTS_SELECTOR)'
	@echo '    KCL_SERVERLESSSERVICE_DNSNAME=$(KCL_SERVERLESSSERVICE_DNSNAME)'
	@echo '    KCL_SERVERLESSSERVICE_DNSNAME_DOMAIN=$(KCL_SERVERLESSSERVICE_DNSNAME_DOMAIN)'
	@echo '    KCL_SERVERLESSSERVICE_DNSNAME_HOSTNAME=$(KCL_SERVERLESSSERVICE_DNSNAME_HOSTNAME)'
	@echo '    KCL_SERVERLESSSERVICE_DNSNAME_SUBDOMAIN=$(KCL_SERVERLESSSERVICE_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_SERVERLESSSERVICE_ID=$(KCL_SERVERLESSSERVICE_ID)'
	@echo '    KCL_SERVERLESSSERVICE_KSERVICE_NAME=$(KCL_SERVERLESSSERVICE_KSERVICE_NAME)'
	@echo '    KCL_SERVERLESSSERVICE_NAME=$(KCL_SERVERLESSSERVICE_NAME)'
	@echo '    KCL_SERVERLESSSERVICE_NAMESPACE_NAME=$(KCL_SERVERLESSSERVICE_NAMESPACE_NAME)'
	@echo '    KCL_SERVERLESSSERVICE_PODS_SELECTOR=$(KCL_SERVERLESSSERVICE_PODS_SELECTOR)'
	@echo '    KCL_SERVERLESSSERVICE_REPLICASETS_SELECTOR=$(KCL_SERVERLESSSERVICE_REPLICASETS_SELECTOR)'
	@echo '    KCL_SERVERLESSSERVICE_REVISIONS_SELECTOR=$(KCL_SERVERLESSSERVICE_REVISIONS_SELECTOR)'
	@echo '    KCL_SERVERLESSSERVICE_SERVICES_NAMES=$(KCL_SERVERLESSSERVICE_SERVICES_NAMES)'
	@echo '    KCL_SERVERLESSSERVICE_SERVICES_SELECTOR=$(KCL_SERVERLESSSERVICE_SERVICES_SELECTOR)'
	@echo '    KCL_SERVERLESSSERVICE_UID=$(KCL_SERVERLESSSERVICE_UID)'
	@echo '    KCL_SERVERLESSSERVICE_URL=$(KCL_SERVERLESSSERVICE_URL)'
	@echo '    KCL_SERVERLESSSERVICE_URL_DNSNAME=$(KCL_SERVERLESSSERVICE_URL_DNSNAME)'
	@echo '    KCL_SERVERLESSSERVICE_URL_PATH=$(KCL_SERVERLESSSERVICE_URL_PATH)'
	@echo '    KCL_SERVERLESSSERVICE_URL_PORT=$(KCL_SERVERLESSSERVICE_URL_PORT)'
	@echo '    KCL_SERVERLESSSERVICE_URL_PROTOCOL=$(KCL_SERVERLESSSERVICE_URL_PROTOCOL)'
	@echo '    KCL_SERVERLESSSERVICES_DNSNAME_DOMAIN=$(KCL_SERVERLESSSERVICES_DNSNAME_DOMAIN)'
	@echo '    KCL_SERVERLESSSERVICES_DNSNAME_SUBDOMAIN=$(KCL_SERVERLESSSERVICES_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_SERVERLESSSERVICES_FIELDSELECTOR=$(KCL_SERVERLESSSERVICES_FIELDSELECTOR)'
	@echo '    KCL_SERVERLESSSERVICES_KSERVICE_NAME=$(KCL_SERVERLESSSERVICES_KSERVICE_NAME)'
	@echo '    KCL_SERVERLESSSERVICES_MANIFEST_DIRPATH=$(KCL_SERVERLESSSERVICES_MANIFEST_DIRPATH)'
	@echo '    KCL_SERVERLESSSERVICES_MANIFEST_FILENAME=$(KCL_SERVERLESSSERVICES_MANIFEST_FILENAME)'
	@echo '    KCL_SERVERLESSSERVICES_MANIFEST_FILEPATH=$(KCL_SERVERLESSSERVICES_MANIFEST_FILEPATH)'
	@echo '    KCL_SERVERLESSSERVICES_MANIFEST_STDINFLAG=$(KCL_SERVERLESSSERVICES_MANIFEST_STDINFLAG)'
	@echo '    KCL_SERVERLESSSERVICES_MANIFEST_URL=$(KCL_SERVERLESSSERVICES_MANIFEST_URL)'
	@echo '    KCL_SERVERLESSSERVICES_MANIFESTS_DIRPATH=$(KCL_SERVERLESSSERVICES_MANIFESTS_DIRPATH)'
	@echo '    KCL_SERVERLESSSERVICES_NAMESPACE_NAME=$(KCL_SERVERLESSSERVICES_NAMESPACE_NAME)'
	@echo '    KCL_SERVERLESSSERVICES_OUTPUT=$(KCL_SERVERLESSSERVICES_OUTPUT)'
	@echo '    KCL_SERVERLESSSERVICES_SELECTOR=$(KCL_SERVERLESSSERVICES_SELECTOR)'
	@echo '    KCL_SERVERLESSSERVICES_SET_NAME=$(KCL_SERVERLESSSERVICES_SET_NAME)'
	@echo '    KCL_SERVERLESSSERVICES_SHOW_LABELS=$(KCL_SERVERLESSSERVICES_SHOW_LABELS)'
	@echo '    KCL_SERVERLESSSERVICES_WATCH_ONLY=$(KCL_SERVERLESSSERVICES_WATCH_ONLY)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Knative::ServerlessService ($(_KUBECTL_KNATIVE_SERVERLESSSERVICE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_serverlessservice                - Annotate a serverless-service'
	@echo '    _kcl_apply_serverlessservices                  - Apply manifest for one-or-more serverless-services'
	@echo '    _kcl_create_serverlessservice                  - Create a new serverless-service'
	@echo '    _kcl_curl_serverlessservice                    - Curl a serverless-service'
	@echo '    _kcl_dig_serverlessservice                     - Dig a serverless-service'
	@echo '    _kcl_delete_serverlessservice                  - Delete an existing serverless-service'
	@echo '    _kcl_diff_serverlessservices                   - Diff manifest for one-or-more serverless-services'
	@echo '    _kcl_dig_serverlessservice                     - Dig a serverless-service'
	@echo '    _kcl_edit_serverlessservice                    - Edit a serverless-service'
	@echo '    _kcl_explain_serverlessservice                 - Explain the serverless-service object'
	@echo '    _kcl_kustomize_serverlessservices              - Kustomize one-or-more serverless-services'
	@echo '    _kcl_label_serverlessservice                   - Label a serverless-service'
	@echo '    _kcl_list_serverlessservices                   - List all serverless-services'
	@echo '    _kcl_list_serverlessservices_set               - List a set of serverless-services'
	@echo '    _kcl_show_serverlessservice                    - Show everything related to a serverless-service'
	@echo '    _kcl_show_serverlessservice_configurations     - Show the configurations of a serverless-service'
	@echo '    _kcl_show_serverlessservice_deployments        - Show the deployments of a serverless-service'
	@echo '    _kcl_show_serverlessservice_description        - Show the description of a serverless-service'
	@echo '    _kcl_show_serverlessservice_object             - Show the object of a serverless-service'
	@echo '    _kcl_show_serverlessservice_pods               - Show the pods of a serverless-service'
	@echo '    _kcl_show_serverlessservice_replicasets        - Show the replica-sets of a serverless-service'
	@echo '    _kcl_show_serverlessservice_revisions          - Show the revisions of a serverless-service'
	@echo '    _kcl_show_serverlessservice_serverlessservices - Show the serverless-services of a serverless-service'
	@echo '    _kcl_show_serverlessservice_services           - Show the services of a serverless-service'
	@echo '    _kcl_show_serverlessservice_state              - Show the state of a serverless-service'
	@echo '    _kcl_unapply_serverlessservices                - Un-apply manifest for one-or-more serverless-services'
	@echo '    _kcl_update_serverlessservice                  - Update a serverless-service'
	@echo '    _kcl_watch_serverlessservices                  - Watch serverless-services'
	@echo '    _kcl_watch_serverlessservices_set              - Watch a set of serverless-services'
	@echo '    _kcl_write_serverlessservices                  - Write manifest for one-or-more serverless-services'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_serverlessservice:
	@$(INFO) '$(KCL_UI_LABEL)Annotating serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate ...

_kcl_apply_serverlessservice: _kcl_apply_serverlessservices
_kcl_apply_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more serverless-services ...'; $(NORMAL)
	$(if $(KCL_SERVERLESSSERVICES_MANIFEST_FILEPATH),cat $(KCL_SERVERLESSSERVICES_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_SERVERLESSSERVICES_MANIFEST_STDINFLAG)),$(_KCL_APPLY_SERVERLESSSERVICES_|)cat)
	$(if $(KCL_SERVERLESSSERVICES_MANIFEST_URL),curl -L $(KCL_SERVERLESSSERVICES_MANIFEST_URL))
	$(if $(KCL_SERVERLESSSERVICES_MANIFESTS_DIRPATH),ls -al $(KCL_SERVERLESSSERVICES_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_SERVERLESSSERVICES_|)$(KUBECTL) apply $(__KCL_FILENAME__SERVERLESSSERVICES) $(__KCL_NAMESPACE__SERVERLESSSERVICES)

_kcl_create_serverlessservice:
	@$(INFO) '$(KCL_UI_LABEL)Creating serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)

_kcl_curl_serverlessservice:
	@$(INFO) '$(KCL_UI_LABEL)Curling serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails of the revision is not mentioned in the route'; $(NORMAL)
	@$(WARN) 'In the route, the name of the revision should be specified'; $(NORMAL)
	$(KCL_SERVERLESSSERVICE_CURL) $(KCL_SERVERLESSSERVICE_URL) 

_kcl_delete_serverlessservice:
	@$(INFO) '$(KCL_UI_LABEL)Deleting serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)

_kcl_diff_serverlessservice: _kcl_diff_serverlessservices
_kcl_diff_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more knative-serverless-services ...'; $(NORMAL)
	# cat $(KCL_SERVERLESSSERVICES_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_SERVERLESSSERVICES_|)cat
	# curl -L $(KCL_SERVERLESSSERVICES_MANIFEST_URL)
	# ls -al $(KCL_SERVERLESSSERVICES_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_SERVERLESSSERVICES_|)$(KUBECTL) diff $(__KCL_FILENAME__SERVERLESSSERVICES) $(__KCL_NAMESPACE__SERVERLESSSERVICES)

_kcl_dig_serverlessservice:
	@$(INFO) '$(KCL_UI_LABEL)Dig-ing knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation validates the DNS resolution of the kservice-serverless-service; $(NORMAL)
	$(KCL_SERVERLESSSERVICE_DIG) $(KCL_SERVERLESSSERVICE_DNSNAME) 

_kcl_edit_serverlessservice:
	@$(INFO) '$(KCL_UI_LABEL)Editing knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit rev $(__KCL_NAMESPACE__SERVERLESSSERVICE) $(KCL_SERVERLESSSERVICE_NAME)

_kcl_explain_serverlessservice:
	@$(INFO) '$(KCL_UI_LABEL)Explaining knative-serverless-service object ...'; $(NORMAL)
	$(KUBECTL) explain serverlessservices

_kcl_kustomize_serverlessservice: _kcl_kustomize_serverlessservices
_kcl_kustomize_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more knative-serverless-services ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_SERVERLESSSERVICE_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_SERVERLESSSERVICE)

_kcl_label_serverlessservice:
	@$(INFO) '$(KCL_UI_LABEL)Labeling knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)

_kcl_list_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL knative-serverless-services ...'; $(NORMAL)
	$(KUBECTL) get serverlessservices --all-namespaces=true $(_X__KCL_NAMESPACE__SERVERLESSSERVICES) $(__KCL_OUTPUT__SERVERLESSSERVICES) $(_X__KCL_SELECTOR__SERVERLESSSERVICES)$(__KCL_SHOW_LABELS__SERVERLESSSERVICES)

_kcl_list_serverlessservices_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing knative-serverless-services-set "$(KCL_SERVERLESSSERVICES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Knative-serverless-services are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get serverlessservices --all-namespaces=false $(__KCL_FIELD_SELECTOR__SERVERLESSSERVICES) $(__KCL_NAMESPACE__SERVERLESSSERVICES) $(__KCL_OUTPUT__SERVERLESSSERVICES) $(__KCL_SELECTOR__SERVERLESSSERVICES) $(__KCL_SHOW_LABELS__SERVERLESSSERVICES)

_KCL_SHOW_SERVERLESSSERVICE_TARGETS?= _kcl_show_serverlessservice_deployments _kcl_show_serverlessservice_object _kcl_show_serverlessservice_pods _kcl_show_serverlessservice_replicasets _kcl_show_serverlessservice_serverlessservice _kcl_show_serverlessservice_services _kcl_show_serverlessservice_state _kcl_show_serverlessservice_description
_kcl_show_serverlessservice :: $(_KCL_SHOW_SERVERLESSSERVICE_TARGETS)

# _kcl_show_serverlessservice_configurations:
# 	@$(INFO) '$(KCL_UI_LABEL)Showing configurations of knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
# 	@$(WARN) 'Only one configuration should match?'; $(NORMAL)
# 	$(KUBECTL) get config $(__KCL_NAMESPACE__SERVERLESSSERVICE) --selector $(KCL_SERVERLESSSERVICE_CONFIGURATIONS_SELECTOR)

_kcl_show_serverlessservice_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Showing deployments of knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get deploy $(__KCL_NAMESPACE__SERVERLESSSERVICE) --selector $(KCL_SERVERLESSSERVICE_DEPLOYMENTS_SELECTOR)

_kcl_show_serverlessservice_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this service is accessible at $(KCL_SERVERLESSSERVICE_NAME).$(KCL_SERVERLESSSERVICE_NAMESPACE_NAME).svc.cluster.local'; $(NORMAL)
	$(KUBECTL) describe rev $(__KCL_NAMESPACE__SERVERLESSSERVICE) $(KCL_SERVERLESSSERVICE_NAME)

_kcl_show_serverlessservice_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get rev $(__KCL_NAMESPACE__SERVERLESSSERVICE) --output yaml $(KCL_SERVERLESSSERVICE_NAME) 

_kcl_show_serverlessservice_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods of knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get pods $(__KCL_NAMESPACE__SERVERLESSSERVICE) --selector $(KCL_SERVERLESSSERVICE_PODS_SELECTOR)

_kcl_show_serverlessservice_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Showing replica-sets of knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get replicasets $(__KCL_NAMESPACE__SERVERLESSSERVICE) --selector $(KCL_SERVERLESSSERVICE_REPLICASETS_SELECTOR)

_kcl_show_serverlessservice_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing serverless-services of knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get serverlessservices $(__KCL_NAMESPACE__SERVERLESSSERVICE) --selector $(KCL_SERVERLESSSERVICE_SERVERLESSSERVICES_SELECTOR)

_kcl_show_serverlessservice_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing services of knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return 2 services: $(KCL_SERVERLESSSERVICE_SERVICES_NAMES)'
	@$(WARN) 'Both services are expected to be ClusteIP ones'; $(NORMAL)
	@$(WARN) 'The first service is used when the function has no healthy backend pods to cache the request'; $(NORMAL)
	@$(WARN) ' * Service port 80/TCP   --> activator port 8012/TCP'; $(NORMAL)
	@$(WARN) 'The second service is used to reach a running function-pod if any'; $(NORMAL)
	@$(WARN) ' * Service port 80/TCP   --> endpoint-pod port 8012/TCP (queue-proxy to user-container port 80/TCP)'; $(NORMAL)
	@$(WARN) ' * Service port 8022/TCP --> endpoint-pod port 8022/TCP (queue-adm)'; $(NORMAL)
	@$(WARN) ' * Service port 9090/TCP --> endpoint-pod port 9090/TCP (auto-metric)'; $(NORMAL)
	@$(WARN) ' * Service port 9091/TCP --> endpoint-pod port 9091/TCP (user-metric)'; $(NORMAL)
	@$(WARN) ' * If the function-pods are all downscaled, this service has not endpoint'; $(NORMAL)
	$(KUBECTL) get services $(__KCL_NAMESPACE__SERVERLESSSERVICE) --selector $(KCL_SERVERLESSSERVICE_SERVICES_SELECTOR)

_kcl_show_serverlessservice_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If scaled down: REASON --> NoHealthyBackends'; $(NORMAL)
	$(KUBECTL) get serverlessservice $(__KCL_NAMESPACE__SERVERLESSSERVICE) $(KCL_SERVERLESSSERVICE_NAME) 

_kcl_unapply_serverlessservice: _kcl_unapply_serverlessservices
_kcl_unapply_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more knative-serverless-services ...'; $(NORMAL)
	# cat $(KCL_SERVERLESSSERVICES_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_SERVERLESSSERVICES_|)cat
	# curl -L $(KCL_SERVERLESSSERVICES_MANIFEST_FILEPATH)
	# curl -L $(KCL_SERVERLESSSERVICES_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_SERVERLESSSERVICES_|)$(KUBECTL) delete $(__KCL_FILENAME__SERVERLESSSERVICES) $(__KCL_NAMESPACE__SERVERLESSSERVICES)

_kcl_unlabel_serverlessservice:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)

_kcl_update_serverlessservice:
	@$(INFO) '$(KCL_UI_LABEL)Updating knative-serverless-service "$(KCL_SERVERLESSSERVICE_NAME)" ...'; $(NORMAL)

_kcl_watch_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL knative-serverless-services ...'; $(NORMAL)
	$(KUBECTL) get serverlessservices $(strip $(_X__KCL_ALL_NAMESPACES__SERVERLESSSERVICES) --all-namespaces=true $(_X__KCL_NAMESPACE__SERVERLESSSERVICES) $(__KCL_OUTPUT__SERVERLESSSERVICES) $(_X__KCL_SELECTOR__SERVERLESSSERVICES) $(_X__KCL_WATCH__SERVERLESSSERVICES) --watch=true $(__KCL_WATCH_ONLY__SERVERLESSSERVICES) )

_kcl_watch_serverlessservices_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching knative-serverless-services-set "$(KCL_SERVERLESSSERVICES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get serverlessservices $(strip $(__KCL_ALL_NAMESPACES__SERVERLESSSERVICES) $(__KCL_NAMESPACE__SERVERLESSSERVICES) $(__KCL_OUTPUT__SERVERLESSSERVICES) $(__KCL_SELECTOR__SERVERLESSSERVICES) $(_X__KCL_WATCH__SERVERLESSSERVICES) --watch=true $(__KCL_WATCH_ONLY__SERVERLESSSERVICES) )

_kcl_write_serverlessservice: _kcl_write_serverlessservices
_kcl_write_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more knative-serverless-services ...'; $(NORMAL)
	$(WRITER) $(KCL_SERVERLESSSERVICES_MANIFEST_FILEPATH)
