_KUBECTL_KNATIVE_KSERVICE_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# KCL_KSERVICE_CURL?= time curl -k
# KCL_KSERVICE_CONFIGURATION_NAME?= go-helloworld
# KCL_KSERVICE_CONFIGURATIONS_SELECTOR?= serving.knative.dev/service=go-helloworld
# KCL_KSERVICE_DEPLOYMENTS_SELECTOR?= serving.knative.dev/service=go-helloworld
# KCL_KSERVICE_DIG?= time dig +short
# KCL_KSERVICE_DNSNAME?= go-helloworld.default.example.com
# KCL_KSERVICE_DNSNAME_DOMAIN?= example.com
# KCL_KSERVICE_DNSNAME_HOSTNAME?= go-helloworld
# KCL_KSERVICE_DNSNAME_SUBDOMAIN?= default.example.com
# KCL_KSERVICE_IMAGES_SELECTOR?= serving.knative.dev/service=go-helloworld
# KCL_KSERVICE_KINGRESS_NAME?= go-helloworld
# KCL_KSERVICE_KINGRESSES_SELECTOR?= serving.knative.dev/service=go-helloworld
# KCL_KSERVICE_KUSTOMIZATION_DIRPATH?= ./in/
# KCL_KSERVICE_METRICS_SELECTOR?= serving.knative.dev/service=go-helloworld
# KCL_KSERVICE_NAME?= ip-172-20-33-0.us-west-2.compute.internal
# KCL_KSERVICE_NAMESPACE_NAME?= default
# KCL_KSERVICE_PODAUTOSCALERS_SELECTOR?= serving.knative.dev/service=go-helloworld
# KCL_KSERVICE_PODS_SELECTOR?= serving.knative.dev/service=go-helloworld
# KCL_KSERVICE_REPLICASETS_SELECTOR?= serving.knative.dev/service=go-helloworld
# KCL_KSERVICE_REVISIONS_SELECTOR?= serving.knative.dev/service=go-helloworld
# KCL_KSERVICE_ROUTE_NAME?= go-helloworld
# KCL_KSERVICE_ROUTES_SELECTOR?= serving.knative.dev/service=go-helloworld
# KCL_KSERVICE_SERVERLESSSERVICES_SELECTOR?= serving.knative.dev/service=go-helloworld
# KCL_KSERVICE_SERVICES_SELECTOR?= serving.knative.dev/service=go-helloworld
# KCL_KSERVICE_URL?= http://go-helloworld.default.example.com:80/my/path
# KCL_KSERVICE_URL_DNSNAME?= go-helloworld.default.example.com
# KCL_KSERVICE_URL_PATH?= /my/path
# KCL_KSERVICE_URL_PORT?= :80
# KCL_KSERVICE_URL_PROTOCOL?= http://
# KCL_KSERVICE_VIRTUALSERVICES_NAMES?= go-helloworld-ingress go-helloworld-mesh
# KCL_KSERVICES_DNSNAME_DOMAIN?= example.com
# KCL_KSERVICES_DNSNAME_SUBDOMAIN?= default.example.com
# KCL_KSERVICES_FIELDSELECTOR?= metadata.name=my-service
# KCL_KSERVICES_MANIFEST_DIRPATH?= ./in/
# KCL_KSERVICES_MANIFEST_FILENAME?= manifest.yaml
# KCL_KSERVICES_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_KSERVICES_MANIFEST_STDINFLAG?= false
# KCL_KSERVICES_MANIFEST_URL?= http://...
# KCL_KSERVICES_MANIFESTS_DIRPATH?= ./in/manifests
# KCL_KSERVICES_NAMESPACE_NAME?= default
# KCL_KSERVICES_OUTPUT?= wide
# KCL_KSERVICES_SELECTOR?=
# KCL_KSERVICES_SET_NAME?= my-services-set
# KCL_KSERVICES_SHOW_LABELS?= true
# KCL_KSERVICES_WATCH_ONLY?= true

# Derived parameters
KCL_KSERVICE_CONFIGURATION_NAME?= $(KCL_KSERVICE_NAME)
KCL_KSERVICE_CONFIGURATIONS_SELECTOR?= serving.knative.dev/service=$(KCL_KSERVICE_NAME)
KCL_KSERVICE_CURL?= $(KCL_KNATIVESERVING_CURL)
KCL_KSERVICE_DEPLOYMENTS_SELECTOR?= serving.knative.dev/service=$(KCL_KSERVICE_NAME)
KCL_KSERVICE_DIG?= $(KCL_KNATIVESERVING_DIG)
KCL_KSERVICE_DNSNAME?= $(KCL_KSERVICE_DNSNAME_HOSTNAME).$(KCL_KSERVICE_DNSNAME_SUBDOMAIN)
KCL_KSERVICE_DNSNAME_DOMAIN?= $(KCL_KSERVICES_DNSNAME_DOMAIN)
KCL_KSERVICE_DNSNAME_HOSTNAME?= $(KCL_KSERVICE_NAME)
KCL_KSERVICE_DNSNAME_SUBDOMAIN?= $(KCL_KSERVICE_NAMESPACE_NAME).$(KCL_KSERVICE_DNSNAME_DOMAIN)
KCL_KSERVICE_IMAGES_SELECTOR?= serving.knative.dev/service=$(KCL_KSERVICE_NAME)
KCL_KSERVICE_KINGRESS_NAME?= $(KCL_KSERVICE_NAME)
KCL_KSERVICE_KINGRESSES_SELECTOR?= serving.knative.dev/service=$(KCL_KSERVICE_NAME)
KCL_KSERVICE_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_KSERVICE_METRICS_SELECTOR?= serving.knative.dev/service=$(KCL_KSERVICE_NAME)
KCL_KSERVICE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_KSERVICE_PODAUTOSCALERS_SELECTOR?= serving.knative.dev/service=$(KCL_KSERVICE_NAME)
KCL_KSERVICE_PODS_SELECTOR?= serving.knative.dev/service=$(KCL_KSERVICE_NAME)
KCL_KSERVICE_REPLICASETS_SELECTOR?= serving.knative.dev/service=$(KCL_KSERVICE_NAME)
KCL_KSERVICE_REVISIONS_SELECTOR?= serving.knative.dev/service=$(KCL_KSERVICE_NAME)
KCL_KSERVICE_ROUTE_NAME?= $(KCL_KSERVICE_NAME)
KCL_KSERVICE_ROUTES_SELECTOR?= serving.knative.dev/service=$(KCL_KSERVICE_NAME)
KCL_KSERVICE_SERVERLESSSERVICES_SELECTOR?= serving.knative.dev/service=$(KCL_KSERVICE_NAME)
KCL_KSERVICE_SERVICES_SELECTOR?= serving.knative.dev/service=$(KCL_KSERVICE_NAME)
KCL_KSERVICE_URL?= $(KCL_KSERVICE_URL_PROTOCOL)$(KCL_KSERVICE_URL_DNSNAME)$(KCL_KSERVICE_URL_PORT)$(KCL_KSERVICE_URL_PATH)
KCL_KSERVICE_URL_DNSNAME?= $(KCL_KSERVICE_DNSNAME)
KCL_KSERVICES_DNSNAME_DOMAIN?= $(KCL_KNATIVESERVING_DNSNAME_DOMAIN)
KCL_KSERVICES_DNSNAME_SUBDOMAIN?= $(KCL_KSERVICES_NAMESPACE_NAME).$(KCL_KSERVICES_DNSNAME_DOMAIN)
KCL_KSERVICES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_KSERVICES_MANIFEST_FILEPATH?= $(if $(KCL_KSERVICES_MANIFEST_FILENAME),$(KCL_KSERVICES_MANIFEST_DIRPATH)$(KCL_KSERVICES_MANIFEST_FILENAME))
KCL_KSERVICES_NAMESPACE_NAME?= $(KCL_KSERVICE_NAMESPACE_NAME)
KCL_KSERVICES_SET_NAME?= kservices@$(KCL_KSERVICES_FIELDSELECTOR)@$(KCL_KSERVICES_SELECTOR)@$(KCL_KSERVICES_NAMESPACE_NAME)

# Option parameters
__KCL_ALL_NAMESPACES__KSERVICES=
__KCL_FIELD_SELECTOR__KSERVICES= $(if $(KCL_KSERVICES_FIELDSELECTOR),--field-selector $(KCL_KSERVICES_FIELDSELECTOR))
__KCL_FILENAME__KSERVICES+= $(if $(KCL_KSERVICES_MANIFEST_FILEPATH),--filename $(KCL_KSERVICES_MANIFEST_FILEPATH))
__KCL_FILENAME__KSERVICES+= $(if $(filter true,$(KCL_KSERVICES_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__KSERVICES+= $(if $(KCL_KSERVICES_MANIFEST_URL),--filename $(KCL_KSERVICES_MANIFEST_URL))
__KCL_FILENAME__KSERVICES+= $(if $(KCL_KSERVICES_MANIFESTS_DIRPATH),--filename $(KCL_KSERVICES_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__KSERVICE= $(if $(KCL_KSERVICE_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_KSERVICE_KUSTOMIZATION_DIRPATH))
__KCL_NAMESPACE__KSERVICE= $(if $(KCL_KSERVICE_NAMESPACE_NAME),--namespace $(KCL_KSERVICE_NAMESPACE_NAME))
__KCL_NAMESPACE__KSERVICES= $(if $(KCL_KSERVICES_NAMESPACE_NAME),--namespace $(KCL_KSERVICES_NAMESPACE_NAME))
__KCL_OUTPUT__KSERVICES= $(if $(KCL_KSERVICES_OUTPUT),--output $(KCL_KSERVICES_OUTPUT))
__KCL_SELECTOR__KSERVICES= $(if $(KCL_KSERVICES_SELECTOR),--selector=$(KCL_KSERVICES_SELECTOR))
__KCL_SHOW_LABELS__KSERVICE= $(if $(filter true, $(KCL_KSERVICE_SHOW_LABELS)),--show-labels)
__KCL_WATCH_ONLY__KSERVICES= $(if $(KCL_KSERVICES_WATCH_ONLY),--watch-only=$(KCL_KSERVICES_WATCH_ONLY))

# Pipe parameters
_KCL_APPLY_KSERVICES_|?= #
_KCL_CURL_KSERVICES_|?= # repeat 10 {
_KCL_DIFF_KSERVICES_|?= $(_KCL_APPLY_KSERVICES_|)
_KCL_DIG_KSERVICES_|?=
_KCL_UNAPPLY_KSERVICES_|?= $(_KCL_APPLY_KSERVICES_|)
|_KCL_CURL_KSERVICES?= # ; sleep 10 }
|_KCL_DIG_KSERVICES?=
|_KCL_KUSTOMIZE_KSERVICE?=


# UI parameters

#--- MACROS
# _kcl_get_kservice_pods_names= $(call _kcl_get_kservice_pods_names_N, $(KCL_KSERVICE_NAME))
# _kcl_get_kservice_pods_names_N= $(call _kcl_get_kservice_pods_names_NN, $(1), $(KCL_KSERVICE_NAMESPACE_NAME))
# _kcl_get_kservice_pods_names_NN= $(shell $(KUBECTL) get pods --namespace $(2) --selector=$(1) -o wide | awk 'NR==2 {print $$7}')

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Knative::KService ($(_KUBECTL_KNATIVE_KSERVICE_MK_VERSION)) macros:'
	@#echo '    _kcl_get_kservice_pod_selector_{|N|NN}       - Get the pod-selector of a service (Name,Namespace)'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Knative::KService ($(_KUBECTL_KNATIVE_KSERVICE_MK_VERSION)) parameters:'
	@echo '    KCL_KSERVICE_CONFIGURATIONS_NAME=$(KCL_KSERVICE_CONFIGURATIONS_NAME)'
	@echo '    KCL_KSERVICE_CONFIGURATIONS_SELECTOR=$(KCL_KSERVICE_CONFIGURATIONS_SELECTOR)'
	@echo '    KCL_KSERVICE_CURL_BIN=$(KCL_KSERVICE_CURL_BIN)'
	@echo '    KCL_KSERVICE_DEPLOYMENTS_SELECTOR=$(KCL_KSERVICE_DEPLOYMENTS_SELECTOR)'
	@echo '    KCL_KSERVICE_DIG_BIN=$(KCL_KSERVICE_DIG_BIN)'
	@echo '    KCL_KSERVICE_DNSNAME=$(KCL_KSERVICE_DNSNAME)'
	@echo '    KCL_KSERVICE_DNSNAME_DOMAIN=$(KCL_KSERVICE_DNSNAME_DOMAIN)'
	@echo '    KCL_KSERVICE_DNSNAME_HOSTNAME=$(KCL_KSERVICE_DNSNAME_HOSTNAME)'
	@echo '    KCL_KSERVICE_DNSNAME_SUBDOMAIN=$(KCL_KSERVICE_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_KSERVICE_IMAGES_SELECTOR=$(KCL_KSERVICE_IMAGES_SELECTOR)'
	@echo '    KCL_KSERVICE_KINGRESS_NAME=$(KCL_KSERVICE_KINGRESS_NAME)'
	@echo '    KCL_KSERVICE_KINGRESSES_SELECTOR=$(KCL_KSERVICE_KINGRESSES_SELECTOR)'
	@echo '    KCL_KSERVICE_METRICS_SELECTOR=$(KCL_KSERVICE_METRICS_SELECTOR)'
	@echo '    KCL_KSERVICE_NAME=$(KCL_KSERVICE_NAME)'
	@echo '    KCL_KSERVICE_NAMESPACE_NAME=$(KCL_KSERVICE_NAMESPACE_NAME)'
	@echo '    KCL_KSERVICE_PODAUTOSCALERS_SELECTOR=$(KCL_KSERVICE_PODAUTOSCALERS_SELECTOR)'
	@echo '    KCL_KSERVICE_PODS_SELECTOR=$(KCL_KSERVICE_PODS_SELECTOR)'
	@echo '    KCL_KSERVICE_REPLICASETS_SELECTOR=$(KCL_KSERVICE_REPLICASETS_SELECTOR)'
	@echo '    KCL_KSERVICE_REVISIONS_SELECTOR=$(KCL_KSERVICE_REVISIONS_SELECTOR)'
	@echo '    KCL_KSERVICE_ROUTE_NAME=$(KCL_KSERVICE_ROUTE_NAME)'
	@echo '    KCL_KSERVICE_ROUTES_SELECTOR=$(KCL_KSERVICE_ROUTES_SELECTOR)'
	@echo '    KCL_KSERVICE_SERVERLESSSERVICES_SELECTOR=$(KCL_KSERVICE_SERVERLESSSERVICES_SELECTOR)'
	@echo '    KCL_KSERVICE_SERVICES_SELECTOR=$(KCL_KSERVICE_SERVICES_SELECTOR)'
	@echo '    KCL_KSERVICE_URL=$(KCL_KSERVICE_URL)'
	@echo '    KCL_KSERVICE_URL_DNSNAME=$(KCL_KSERVICE_URL_DNSNAME)'
	@echo '    KCL_KSERVICE_URL_PATH=$(KCL_KSERVICE_URL_PATH)'
	@echo '    KCL_KSERVICE_URL_PORT=$(KCL_KSERVICE_URL_PORT)'
	@echo '    KCL_KSERVICE_URL_PROTOCOL=$(KCL_KSERVICE_EXTERNAL_PROTOCOL)'
	@echo '    KCL_KSERVICES_DNSNAME_DOMAIN=$(KCL_KSERVICES_DNSNAME_DOMAIN)'
	@echo '    KCL_KSERVICES_DNSNAME_SUBDOMAIN=$(KCL_KSERVICES_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_KSERVICES_FIELDSELECTOR=$(KCL_KSERVICES_FIELDSELECTOR)'
	@echo '    KCL_KSERVICES_MANIFEST_DIRPATH=$(KCL_KSERVICES_MANIFEST_DIRPATH)'
	@echo '    KCL_KSERVICES_MANIFEST_FILENAME=$(KCL_KSERVICES_MANIFEST_FILENAME)'
	@echo '    KCL_KSERVICES_MANIFEST_FILEPATH=$(KCL_KSERVICES_MANIFEST_FILEPATH)'
	@echo '    KCL_KSERVICES_MANIFEST_STDINFLAG=$(KCL_KSERVICES_MANIFEST_STDINFLAG)'
	@echo '    KCL_KSERVICES_MANIFEST_URL=$(KCL_KSERVICES_MANIFEST_URL)'
	@echo '    KCL_KSERVICES_MANIFESTS_DIRPATH=$(KCL_KSERVICES_MANIFESTS_DIRPATH)'
	@echo '    KCL_KSERVICES_NAMESPACE_NAME=$(KCL_KSERVICES_NAMESPACE_NAME)'
	@echo '    KCL_KSERVICES_OUTPUT=$(KCL_KSERVICES_OUTPUT)'
	@echo '    KCL_KSERVICES_SELECTOR=$(KCL_KSERVICES_SELECTOR)'
	@echo '    KCL_KSERVICES_SET_NAME=$(KCL_KSERVICES_SET_NAME)'
	@echo '    KCL_KSERVICES_SHOW_LABELS=$(KCL_KSERVICES_SHOW_LABELS)'
	@echo '    KCL_KSERVICES_WATCH_ONLY=$(KCL_KSERVICES_WATCH_ONLY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Knative::KService ($(_KUBECTL_KNATIVE_KSERVICE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_kservice                - Annotate a knative-service'
	@echo '    _kcl_apply_kservices                  - Apply manifest for one-or-more knative-services'
	@echo '    _kcl_create_kservice                  - Create a new knative-service'
	@echo '    _kcl_curl_kservice                    - Curl a knative-service'
	@echo '    _kcl_delete_kservice                  - Delete an existing knative-service'
	@echo '    _kcl_diff_kservices                   - Diff manifest for one-or-more knative-services'
	@echo '    _kcl_dig_kservice                     - Dig the host of a knative-services'
	@echo '    _kcl_edit_kservice                    - Edit a knative-service'
	@echo '    _kcl_explain_kservice                 - Explain the knative-service object'
	@echo '    _kcl_kustomize_kservices              - Kustomize one-or-more knative-services'
	@echo '    _kcl_label_kservice                   - Label a knative-service'
	@echo '    _kcl_show_kservice                    - Show everything related to a knative-service'
	@echo '    _kcl_show_kservice_configuration      - Show the configuration of a knative-service'
	@echo '    _kcl_show_kservice_deployments        - Show the deployments of a knative-service'
	@echo '    _kcl_show_kservice_description        - Show the description of a knative-service'
	@echo '    _kcl_show_kservice_images             - Show the images used by a knative-service'
	@echo '    _kcl_show_kservice_kingress           - Show the knative-ingress of a knative-service'
	@echo '    _kcl_show_kservice_object             - Show the object of a knative-service'
	@echo '    _kcl_show_kservice_podautoscalers     - Show the pod-autoscalers used by a knative-service'
	@echo '    _kcl_show_kservice_pods               - Show the pods of a knative-service'
	@echo '    _kcl_show_kservice_replicasets        - Show the replica-sets of a knative-service'
	@echo '    _kcl_show_kservice_revisions          - Show the revisions of a knative-service'
	@echo '    _kcl_show_kservice_route              - Show the route of a knative-service'
	@echo '    _kcl_show_kservice_serverlessservices - Show the serverless-services of a knative-service'
	@echo '    _kcl_show_kservice_services           - Show the services of a knative-service'
	@echo '    _kcl_show_kservice_state              - Show the state of a knative-service'
	@echo '    _kcl_unapply_kservices                - Unapply a manifest for one-or-more knative-services'
	@echo '    _kcl_update_kservice                  - Update a knative-service'
	@echo '    _kcl_view_kservices                   - View all knative-services'
	@echo '    _kcl_view_kservices_set               - View a set of knative-services'
	@echo '    _kcl_watch_kservices                  - Watch knative-services'
	@echo '    _kcl_watch_kservices_set              - Watch a set of knative-services'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_kservice:
	@$(INFO) '$(KCL_UI_LABEL)Annotating knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)

_kcl_apply_kservice: _kcl_apply_kservices
_kcl_apply_kservices:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more knative-services ...'; $(NORMAL)
	$(if $(KCL_KSERVICES_MANIFEST_FILEPATH),cat $(KCL_KSERVICES_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_KSERVICES_MANIFEST_STDINFLAG)),$(_KCL_APPLY_KSERVICES_|)cat)
	$(if $(KCL_KSERVICES_MANIFEST_URL),curl -L $(KCL_KSERVICES_MANIFEST_URL))
	$(if $(KCL_KSERVICES_MANIFESTS_DIRPATH),ls -al $(KCL_KSERVICES_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_KSERVICES_|)$(KUBECTL) apply $(__KCL_FILENAME__KSERVICES) $(__KCL_NAMESPACE__KSERVICES)

_kcl_create_kservice:
	@$(INFO) '$(KCL_UI_LABEL)Creating knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)

_kcl_curl_kservice:
	@$(INFO) '$(KCL_UI_LABEL)Curling knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the gateway times out before the backend pods reach the running state'; $(NORMAL)
	$(_KCL_CURL_KSERVICE_|)$(KCL_KSERVICE_CURL) $(KCL_KSERVICE_URL) $(|_KCL_CURL_KSERVICE)

_kcl_delete_kservice:
	@$(INFO) '$(KCL_UI_LABEL)Deleting knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)

_kcl_diff_kservice: _kcl_diff_kservices
_kcl_diff_kservices:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more knative-services ...'; $(NORMAL)
	# cat $(KCL_KSERVICES_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_KSERVICES_|)cat
	# curl -L $(KCL_KSERVICES_MANIFEST_URL)
	# ls -al $(KCL_KSERVICES_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_KSERVICES_|)$(KUBECTL) diff $(__KCL_FILENAME__KSERVICES) $(__KCL_NAMESPACE__KSERVICES)

_kcl_dig_kservice:
	@$(INFO) '$(KCL_UI_LABEL)Dig-ing the knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the provided DNS record for the kservice is incorrect '; $(NORMAL)
	$(_KCL_DIG_KSERVICE_|)$(KCL_KSERVICE_DIG) $(KCL_KSERVICE_DNSNAME) $(|_KCL_DIG_KSERVICE) 

_kcl_edit_kservice:
	@$(INFO) '$(KCL_UI_LABEL)Editing knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit kservice $(__KCL_NAMESPACE__KSERVICE) $(KCL_KSERVICE_NAME)

_kcl_explain_kservice:
	@$(INFO) '$(KCL_UI_LABEL)Explaining knative-service object ...'; $(NORMAL)
	$(KUBECTL) explain kservice

_kcl_kustomize_kservice: _kcl_kustomize_kservices
_kcl_kustomize_kservices:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more knative-services ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_KSERVICE_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_KSERVICE)

_kcl_label_kservice:
	@$(INFO) '$(KCL_UI_LABEL)Labeling knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)

_KCL_SHOW_KSERVICE_TARGETS?= _kcl_show_kservice_configuration _kcl_show_kservice_deployments _kcl_show_kservice_images _kcl_show_kservice_kingress _kcl_show_kservice_metrics _kcl_show_kservice_object _kcl_show_kservice_podautoscalers _kcl_show_kservice_pods _kcl_show_kservice_replicasets _kcl_show_kservice_revisions _kcl_show_kservice_route _kcl_show_kservice_serverlessservices _kcl_show_kservice_services _kcl_show_kservice_state _kcl_show_kservice_description
_kcl_show_kservice: $(_KCL_SHOW_KSERVICE_TARGETS)

_kcl_show_kservice_configuration:
	@$(INFO) '$(KCL_UI_LABEL)Showing the configuration of knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return only one configuration: $(KCL_KSERVICE_CONFIGURATION_NAME)'; $(NORMAL)
	@$(WARN) 'The configuration resourcesi is managed by the kservice controller'; $(NORMAL)
	$(KUBECTL) get configurations $(__KCL_NAMESPACE__KSERVICE) --selector $(KCL_KSERVICE_CONFIGURATIONS_SELECTOR)

_kcl_show_kservice_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Showing deployments of knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return one deployment for each revision'; $(NORMAL)
	@$(WARN) 'The deployments have been created by the revision controller'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get deployments $(__KCL_NAMESPACE__KSERVICE) --selector $(KCL_KSERVICE_DEPLOYMENTS_SELECTOR)

_kcl_show_kservice_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this service is accessible at $(KCL_KSERVICE_NAME).$(KCL_KSERVICE_NAMESPACE_NAME).svc.cluster.local'; $(NORMAL)
	$(KUBECTL) describe kservice $(__KCL_NAMESPACE__KSERVICE) $(KCL_KSERVICE_NAME)

_kcl_show_kservice_images:
	@$(INFO) '$(KCL_UI_LABEL)Showing the images used by knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return one image for each revision'; $(NORMAL)
	$(KUBECTL) get images $(__KCL_NAMESPACE__KSERVICE) --selector $(KCL_KSERVICE_IMAGES_SELECTOR)

_kcl_show_kservice_kingress:
	@$(INFO) '$(KCL_UI_LABEL)Showing knative-ingress of knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return only one knative-ingress: $(KCL_KSERVICE_KINGRESS_NAME)'; $(NORMAL)
	@$(WARN) 'Ingress are managed by the route-controller'; $(NORMAL)
	$(KUBECTL) get kingress $(__KCL_NAMESPACE__KSERVICE) --selector $(KCL_KSERVICE_KINGRESSES_SELECTOR)

_kcl_show_kservice_metrics:
	@$(INFO) '$(KCL_UI_LABEL)Showing the metrics used by knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return one metric per revision'; $(NORMAL)
	$(KUBECTL) get metrics $(__KCL_NAMESPACE__KSERVICE) --selector $(KCL_KSERVICE_METRICS_SELECTOR)

_kcl_show_kservice_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get kservice $(__KCL_NAMESPACE__KSERVICE) --output yaml $(KCL_KSERVICE_NAME) 

_kcl_show_kservice_podautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Showing the pod-autoscalers used by knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return one pod-autoscaler per revision'; $(NORMAL)
	$(KUBECTL) get podautoscalers $(__KCL_NAMESPACE__KSERVICE) --selector $(KCL_KSERVICE_PODAUTOSCALERS_SELECTOR)

_kcl_show_kservice_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods of knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The pods have be created by the replicat-set controller'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get pods $(__KCL_NAMESPACE__KSERVICE) --selector $(KCL_KSERVICE_PODS_SELECTOR)

_kcl_show_kservice_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Showing replica-sets of knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The replicasets have be created by the deployment controller'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get replicasets $(__KCL_NAMESPACE__KSERVICE) --selector $(KCL_KSERVICE_REPLICASETS_SELECTOR)

_kcl_show_kservice_revisions:
	@$(INFO) '$(KCL_UI_LABEL)Showing revisions of knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The revisions have be created by the configuration controller'; $(NORMAL)
	$(KUBECTL) get revisions $(__KCL_NAMESPACE__KSERVICE) --selector $(KCL_KSERVICE_REVISIONS_SELECTOR)

_kcl_show_kservice_route:
	@$(INFO) '$(KCL_UI_LABEL)Showing the route of knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return only one route: $(KCL_KSERVICE_ROUTE_NAME)'; $(NORMAL)
	@$(WARN) 'The routes have be created by the knative-service controller'; $(NORMAL)
	$(KUBECTL) get routes $(__KCL_NAMESPACE__KSERVICE) --selector $(KCL_KSERVICE_ROUTES_SELECTOR)

_kcl_show_kservice_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing serverless-services of knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return one serverless-service per revision'; $(NORMAL)
	$(KUBECTL) get serverlessservices $(__KCL_NAMESPACE__KSERVICE) --selector $(KCL_KSERVICE_SERVERLESSSERVICES_SELECTOR)

_kcl_show_kservice_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing services of knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return one service and 2 others per revison'; $(NORMAL)
	@$(WARN) 'This operation is expected to return a minimum of 3 services'; $(NORMAL)
	$(KUBECTL) get services $(__KCL_NAMESPACE__KSERVICE) --selector $(KCL_KSERVICE_SERVICES_SELECTOR)

_kcl_show_kservice_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get kservice $(__KCL_NAMESPACE__KSERVICE) $(KCL_KSERVICE_NAME) 

_kcl_unapply_kservice: _kcl_unapply_kservices
_kcl_unapply_kservices:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more knative-services ...'; $(NORMAL)
	# cat $(KCL_KSERVICES_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_KSERVICES_|)cat
	# curl -L $(KCL_KSERVICES_MANIFEST_FILEPATH)
	# ls -al $(KCL_KSERVICES_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_KSERVICES_|)$(KUBECTL) delete $(__KCL_FILENAME__KSERVICES) $(__KCL_NAMESPACE__KSERVICES)

_kcl_unlabel_kservice:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)

_kcl_update_kservice:
	@$(INFO) '$(KCL_UI_LABEL)Updating knative-service "$(KCL_KSERVICE_NAME)" ...'; $(NORMAL)

_kcl_view_kservices:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL knative-services ...'; $(NORMAL)
	$(KUBECTL) get kservice --all-namespaces=true $(_X__KCL_NAMESPACE__KSERVICES) $(__KCL_OUTPUT__KSERVICES) $(_X__KCL_SELECTOR__KSERVICES)$(__KCL_SHOW_LABELS__KSERVICES)

_kcl_view_kservices_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing knative-services-set "$(KCL_KSERVICES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Knative-services are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get kservice --all-namespaces=false $(__KCL_FIELD_SELECTOR__KSERVICES) $(__KCL_NAMESPACE__KSERVICES) $(__KCL_OUTPUT__KSERVICES) $(__KCL_SELECTOR__KSERVICES) $(__KCL_SHOW_LABELS__KSERVICES)

_kcl_watch_kservices:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL knative-services ...'; $(NORMAL)
	$(KUBECTL) get kservice $(strip $(_X__KCL_ALL_NAMESPACES__KSERVICES) --all-namespaces=true $(_X__KCL_NAMESPACE__KSERVICES) $(__KCL_OUTPUT__KSERVICES) $(_X__KCL_SELECTOR__KSERVICES) $(_X__KCL_WATCH__KSERVICES) --watch=true $(__KCL_WATCH_ONLY__KSERVICES) )

_kcl_watch_kservices_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching knative-services-set "$(KCL_KSERVICES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get kservice $(strip $(__KCL_ALL_NAMESPACES__KSERVICES) $(__KCL_NAMESPACE__KSERVICES) $(__KCL_OUTPUT__KSERVICES) $(__KCL_SELECTOR__KSERVICES) $(_X__KCL_WATCH__KSERVICES) --watch=true $(__KCL_WATCH_ONLY__KSERVICES) )
