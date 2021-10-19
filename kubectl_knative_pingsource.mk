_KUBECTL_KNATIVE_PINGSOURCE_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# KCL_PINGSOURCE_CURL_BIN?= time curl
# KCL_PINGSOURCE_CONFIGURATIONS_SELECTOR?= serving.knative.dev/service=helloworld-go
# KCL_PINGSOURCE_DEPLOYMENTS_SELECTOR?= serving.knative.dev/service=helloworld-go
# KCL_PINGSOURCE_DNSNAME?= host.subdomain.example.com
# KCL_PINGSOURCE_DNSNAME_DOMAIN?= example.com
# KCL_PINGSOURCE_DNSNAME_HOSTNAME?= host
# KCL_PINGSOURCE_DNSNAME_SUBDOMAIN?= default.example.com
# KCL_PINGSOURCE_URL?= http://helloworld-go.default.example.com:80
# KCL_PINGSOURCE_URL_PATH?= /my/path
# KCL_PINGSOURCE_URL_PORT?= :80
# KCL_PINGSOURCE_URL_PROTOCOL?= http://
# KCL_PINGSOURCE_KUSTOMIZATION_DIRPATH?= ./in/
# KCL_PINGSOURCE_MANIFEST_DIRPATH?= ./in/
# KCL_PINGSOURCE_MANIFEST_FILENAME?= service.yaml
# KCL_PINGSOURCE_MANIFEST_FILEPATH?= ./in/service.yaml
# KCL_PINGSOURCE_MANIFEST_URL?= http://
# KCL_PINGSOURCE_NAME?= ip-172-20-33-0.us-west-2.compute.internal
# KCL_PINGSOURCE_NAMESPACE_NAME?= default
# KCL_PINGSOURCE_PODS_SELECTOR?= serving.knative.dev/service=helloworld-go
# KCL_PINGSOURCE_REPLICASETS_SELECTOR?= serving.knative.dev/service=helloworld-go
# KCL_PINGSOURCE_REVISIONS_SELECTOR?= serving.knative.dev/service=helloworld-go
# KCL_PINGSOURCE_ROUTES_SELECTOR?= serving.knative.dev/service=helloworld-go
# KCL_PINGSOURCE_SERVICES_SELECTOR?= serving.knative.dev/service=helloworld-go
# KCL_PINGSOURCES_FIELDSELECTOR?= metadata.name=my-ping-source
# KCL_PINGSOURCES_NAMESPACE_NAME?= default
# KCL_PINGSOURCES_OUTPUT?= wide
# KCL_PINGSOURCES_SELECTOR?=
# KCL_PINGSOURCES_SET_NAME?= my-ping-sources-set
# KCL_PINGSOURCES_SHOW_LABELS?= true
# KCL_PINGSOURCES_WATCH_ONLY?= true

# Derived parameters
KCL_PINGSOURCE_CONFIGURATIONS_SELECTOR?= serving.knative.dev/service=$(KCL_PINGSOURCE_NAME)
KCL_PINGSOURCE_CURL?= $(KCL_KNATIVEEVENTING_CURL)
KCL_PINGSOURCE_DEPLOYMENTS_SELECTOR?= serving.knative.dev/service=$(KCL_PINGSOURCE_NAME)
KCL_PINGSOURCE_DNSNAME?= $(KCL_PINGSOURCE_DNSNAME_HOSTNAME).$(KCL_PINGSOURCE_DNSNAME_SUBDOMAIN)
KCL_PINGSOURCE_DNSNAME_DOMAIN?= $(KCL_KNATIVEENVENTING_DNSNAME_DOMAIN)
KCL_PINGSOURCE_DNSNAME_HOSTNAME?= $(KCL_PINGSOURCE_NAME)
KCL_PINGSOURCE_DNSNAME_SUBDOMAIN?= $(KCL_PINGSOURCE_NAMESPACE_NAME).$(KCL_PINGSOURCE_DNSNAME_DOMAIN)
KCL_PINGSOURCE_URL?= $(KCL_PINGSOURCE_URL_PROTOCOL)$(KCL_PINGSOURCE_URL_DNSNAME)$(KCL_PINGSOURCE_URL_PORT)$(KCL_PINGSOURCE_URL_PATH)
KCL_PINGSOURCE_URL_DNSNAME?= $(KCL_PINGSOURCE_DNSNAME)
KCL_PINGSOURCE_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_PINGSOURCE_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_PINGSOURCE_MANIFEST_FILEPATH?= $(KCL_PINGSOURCE_MANIFEST_DIRPATH)$(KCL_PINGSOURCE_MANIFEST_FILENAME)
KCL_PINGSOURCE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_PINGSOURCE_PODS_SELECTOR?= serving.knative.dev/service=$(KCL_PINGSOURCE_NAME)
KCL_PINGSOURCE_REPLICASETS_SELECTOR?= serving.knative.dev/service=$(KCL_PINGSOURCE_NAME)
KCL_PINGSOURCE_REVISIONS_SELECTOR?= serving.knative.dev/service=$(KCL_PINGSOURCE_NAME)
KCL_PINGSOURCE_ROUTES_SELECTOR?= serving.knative.dev/service=$(KCL_PINGSOURCE_NAME)
KCL_PINGSOURCE_SERVICES_SELECTOR?= serving.knative.dev/service=$(KCL_PINGSOURCE_NAME)
KCL_PINGSOURCES_NAMESPACE_NAME?= $(KCL_PINGSOURCE_NAMESPACE_NAME)
KCL_PINGSOURCES_SET_NAME?= pingsources@$(KCL_PINGSOURCES_FIELDSELECTOR)@$(KCL_PINGSOURCES_SELECTOR)@$(KCL_PINGSOURCES_NAMESPACE_NAME)

# Option parameters
__KCL_ALL_NAMESPACES__PINGSOURCES=
__KCL_FIELD_SELECTOR__PINGSOURCES= $(if $(KCL_PINGSOURCES_FIELDSELECTOR),--field-selector $(KCL_PINGSOURCES_FIELDSELECTOR))
__KCL_FILENAME__PINGSOURCE+= $(if $(KCL_PINGSOURCE_MANIFEST_FILEPATH),--filename $(KCL_PINGSOURCE_MANIFEST_FILEPATH))
__KCL_FILENAME__PINGSOURCE+= $(if $(KCL_PINGSOURCE_MANIFEST_URL),--filename $(KCL_PINGSOURCE_MANIFEST_URL))
__KCL_KUSTOMIZE__PINGSOURCE= $(if $(KCL_PINGSOURCE_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_PINGSOURCE_KUSTOMIZATION_DIRPATH))
__KCL_NAMESPACE__PINGSOURCE= $(if $(KCL_PINGSOURCE_NAMESPACE_NAME),--namespace $(KCL_PINGSOURCE_NAMESPACE_NAME))
__KCL_NAMESPACE__PINGSOURCES= $(if $(KCL_PINGSOURCES_NAMESPACE_NAME),--namespace $(KCL_PINGSOURCES_NAMESPACE_NAME))
__KCL_OUTPUT__PINGSOURCES= $(if $(KCL_PINGSOURCES_OUTPUT),--output $(KCL_PINGSOURCES_OUTPUT))
__KCL_SELECTOR__PINGSOURCES= $(if $(KCL_PINGSOURCES_SELECTOR),--selector=$(KCL_PINGSOURCES_SELECTOR))
__KCL_SHOW_LABELS__PINGSOURCE= $(if $(filter true, $(KCL_PINGSOURCE_SHOW_LABELS)),--show-labels)
__KCL_WATCH_ONLY__PINGSOURCES= $(if $(KCL_PINGSOURCES_WATCH_ONLY),--watch-only=$(KCL_PINGSOURCES_WATCH_ONLY))

# Pipe parameters
|_KCL_KUSTOMIZE_PINGSOURCE?=

# UI parameters

#--- MACROS
# _kcl_get_pingsource_pods_names= $(call _kcl_get_pingsource_pods_names_N, $(KCL_PINGSOURCE_NAME))
# _kcl_get_pingsource_pods_names_N= $(call _kcl_get_pingsource_pods_names_NN, $(1), $(KCL_PINGSOURCE_NAMESPACE_NAME))
# _kcl_get_pingsource_pods_names_NN= $(shell $(KUBECTL) get pods --namespace $(2) --selector=$(1) -o wide | awk 'NR==2 {print $$7}')

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Knative::PingSource ($(_KUBECTL_KNATIVE_PINGSOURCE_MK_VERSION)) macros:'
	@#echo '    _kcl_get_pingsource_pod_selector_{|N|NN}       - Get the pod-selector of a service (Name,Namespace)'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Knative::PingSource ($(_KUBECTL_KNATIVE_PINGSOURCE_MK_VERSION)) parameters:'
	@echo '    KCL_PINGSOURCE_CONFIGURATIONS_SELECTOR=$(KCL_PINGSOURCE_CONFIGURATIONS_SELECTOR)'
	@echo '    KCL_PINGSOURCE_CURL_BIN=$(KCL_PINGSOURCE_CURL_BIN)'
	@echo '    KCL_PINGSOURCE_DEPLOYMENTS_SELECTOR=$(KCL_PINGSOURCE_DEPLOYMENTS_SELECTOR)'
	@echo '    KCL_PINGSOURCE_DNSNAME=$(KCL_PINGSOURCE_DNSNAME)'
	@echo '    KCL_PINGSOURCE_DNSNAME_DOMAIN=$(KCL_PINGSOURCE_DNSNAME_DOMAIN)'
	@echo '    KCL_PINGSOURCE_DNSNAME_HOSTNAME=$(KCL_PINGSOURCE_DNSNAME_HOSTNAME)'
	@echo '    KCL_PINGSOURCE_DNSNAME_SUBDOMAIN=$(KCL_PINGSOURCE_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_PINGSOURCE_MANIFEST_DIRPATH=$(KCL_PINGSOURCE_MANIFEST_DIRPATH)'
	@echo '    KCL_PINGSOURCE_MANIFEST_FILENAME=$(KCL_PINGSOURCE_MANIFEST_FILENAME)'
	@echo '    KCL_PINGSOURCE_MANIFEST_FILEPATH=$(KCL_PINGSOURCE_MANIFEST_FILEPATH)'
	@echo '    KCL_PINGSOURCE_NAME=$(KCL_PINGSOURCE_NAME)'
	@echo '    KCL_PINGSOURCE_NAMESPACE_NAME=$(KCL_PINGSOURCE_NAMESPACE_NAME)'
	@echo '    KCL_PINGSOURCE_PODS_SELECTOR=$(KCL_PINGSOURCE_PODS_SELECTOR)'
	@echo '    KCL_PINGSOURCE_REPLICASETS_SELECTOR=$(KCL_PINGSOURCE_REPLICASETS_SELECTOR)'
	@echo '    KCL_PINGSOURCE_REVISIONS_SELECTOR=$(KCL_PINGSOURCE_REVISIONS_SELECTOR)'
	@echo '    KCL_PINGSOURCE_ROUTES_SELECTOR=$(KCL_PINGSOURCE_ROUTES_SELECTOR)'
	@echo '    KCL_PINGSOURCE_SERVICES_SELECTOR=$(KCL_PINGSOURCE_SERVICES_SELECTOR)'
	@echo '    KCL_PINGSOURCE_URL=$(KCL_PINGSOURCE_URL)'
	@echo '    KCL_PINGSOURCE_URL_DNSNAME=$(KCL_PINGSOURCE_URL_DNSNAME)'
	@echo '    KCL_PINGSOURCE_URL_PATH=$(KCL_PINGSOURCE_URL_PATH)'
	@echo '    KCL_PINGSOURCE_URL_PORT=$(KCL_PINGSOURCE_URL_PORT)'
	@echo '    KCL_PINGSOURCE_URL_PROTOCOL=$(KCL_PINGSOURCE_URL_PROTOCOL)'
	@echo '    KCL_PINGSOURCES_FIELDSELECTOR=$(KCL_PINGSOURCES_FIELDSELECTOR)'
	@echo '    KCL_PINGSOURCES_NAMESPACE_NAME=$(KCL_PINGSOURCES_NAMESPACE_NAME)'
	@echo '    KCL_PINGSOURCES_OUTPUT=$(KCL_PINGSOURCES_OUTPUT)'
	@echo '    KCL_PINGSOURCES_SELECTOR=$(KCL_PINGSOURCES_SELECTOR)'
	@echo '    KCL_PINGSOURCES_SET_NAME=$(KCL_PINGSOURCES_SET_NAME)'
	@echo '    KCL_PINGSOURCES_SHOW_LABELS=$(KCL_PINGSOURCES_SHOW_LABELS)'
	@echo '    KCL_PINGSOURCES_WATCH_ONLY=$(KCL_PINGSOURCES_WATCH_ONLY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Knative::PingSource ($(_KUBECTL_KNATIVE_PINGSOURCE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_pingsource                - Annotate a knative-ping-source'
	@echo '    _kcl_apply_pingsource                   - Apply manifest for one-or-more knative-ping-sources'
	@echo '    _kcl_create_pingsource                  - Create a new knative-ping-source'
	@echo '    _kcl_curl_pingsource                    - Curl a knative-ping-source'
	@echo '    _kcl_dig_pingsource                     - Dig a knative-ping-source'
	@echo '    _kcl_delete_pingsource                  - Delete an existing knative-ping-source'
	@echo '    _kcl_diff_pingsource                    - Diff manifest for one-or-more knative-ping-sources'
	@echo '    _kcl_edit_pingsource                    - Edit a knative-ping-source'
	@echo '    _kcl_explain_pingsource                 - Explain the knative-ping-source object'
	@echo '    _kcl_kustomize_pingsources              - Kustomize one-or-more knative-ping-sources'
	@echo '    _kcl_label_pingsource                   - Label a knative-ping-source'
	@echo '    _kcl_show_pingsource                    - Show everything related to a knative-ping-source'
	@echo '    _kcl_show_pingsource_configurations     - Show the configurations of a knative-ping-source'
	@echo '    _kcl_show_pingsource_deployments        - Show the deployments of a knative-ping-source'
	@echo '    _kcl_show_pingsource_description        - Show the description of a knative-ping-source'
	@echo '    _kcl_show_pingsource_object             - Show the object of a knative-ping-source'
	@echo '    _kcl_show_pingsource_pods               - Show the pods of a knative-ping-source'
	@echo '    _kcl_show_pingsource_replicasets        - Show the replica-sets of a knative-ping-source'
	@echo '    _kcl_show_pingsource_revisions          - Show the revisions of a knative-ping-source'
	@echo '    _kcl_show_pingsource_routes             - Show the routes of a knative-ping-source'
	@echo '    _kcl_show_pingsource_services           - Show the services of a knative-ping-source'
	@echo '    _kcl_show_pingsource_state              - Show the state of a knative-ping-source'
	@echo '    _kcl_unapply_pingsource                 - Unapply a knative-ping-source'
	@echo '    _kcl_update_pingsource                  - Update a knative-ping-source'
	@echo '    _kcl_view_pingsources                   - View all knative-ping-sources'
	@echo '    _kcl_view_pingsources_set               - View a set of knative-ping-sources'
	@echo '    _kcl_watch_pingsources                  - Watch knative-ping-sources'
	@echo '    _kcl_watch_pingsources_set              - Watch a set of knative-ping-sources'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_pingsource:
	@$(INFO) '$(KCL_UI_LABEL)Annotating knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)

_kcl_apply_pingsource: _kcl_apply_pingsources
_kcl_apply_pingsources:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more knative-ping-sources ...'; $(NORMAL)
	$(if $(KCL_PINGSOURCE_MANIFEST_FILEPATH), cat $(KCL_PINGSOURCE_MANIFEST_FILEPATH))
	$(if $(KCL_PINGSOURCE_MANIFEST_URL), curl -L $(KCL_PINGSOURCE_MANIFEST_URL))
	$(KUBECTL) apply $(__KCL_FILENAME__PINGSOURCE) $(__KCL_NAMESPACE__PINGSOURCE)

_kcl_create_pingsource:
	@$(INFO) '$(KCL_UI_LABEL)Creating knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)

_kcl_curl_pingsource:
	@$(INFO) '$(KCL_UI_LABEL)Curling knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	$(KCL_PINGSOURCE_CURL) $(KCL_PINGSOURCE_URL) 

_kcl_delete_pingsource:
	@$(INFO) '$(KCL_UI_LABEL)Deleting knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)

_kcl_diff_pingsource: _kcl_diff_pingsources
_kcl_diff_pingsources:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more knative-ping-sources ...'; $(NORMAL)
	# cat $(KCL_PINGSOURCE_MANIFEST_FILEPATH)
	# curl -L $(KCL_PINGSOURCE_MANIFEST_URL)
	$(KUBECTL) diff $(__KCL_FILENAME__PINGSOURCE) $(__KCL_NAMESPACE__PINGSOURCE)

_kcl_dig_pingsource:
	@$(INFO) '$(KCL_UI_LABEL)Dig-ing knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	$(KCL_PINGSOURCE_DIG) $(KCL_PINGSOURCE_DNSNAME) 

_kcl_edit_pingsource:
	@$(INFO) '$(KCL_UI_LABEL)Editing knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit pingsource $(__KCL_NAMESPACE__PINGSOURCE) $(KCL_PINGSOURCE_NAME)

_kcl_explain_pingsource:
	@$(INFO) '$(KCL_UI_LABEL)Explaining knative-ping-source object ...'; $(NORMAL)
	$(KUBECTL) explain pingsource

_kcl_kustomize_pingsource: _kcl_kustomize_pingsources
_kcl_kustomize_pingsources:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more knative-ping-sources ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_PINGSOURCE_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_PINGSOURCE)

_kcl_label_pingsource:
	@$(INFO) '$(KCL_UI_LABEL)Labeling knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)

_kcl_show_pingsource: _kcl_show_pingsource_configurations _kcl_show_pingsource_deployments _kcl_show_pingsource_object _kcl_show_pingsource_pods _kcl_show_pingsource_replicasets _kcl_show_pingsource_revisions _kcl_show_pingsource_routes _kcl_show_pingsource_services _kcl_show_pingsource_state _kcl_show_pingsource_description

_kcl_show_pingsource_configurations:
	@$(INFO) '$(KCL_UI_LABEL)Showing configurations of knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The configuration has been created/updated by the pingsource controller'; $(NORMAL)
	@$(WARN) 'Only one configuration should match?'; $(NORMAL)
	$(KUBECTL) get config $(__KCL_NAMESPACE__PINGSOURCE) --selector $(KCL_PINGSOURCE_CONFIGURATIONS_SELECTOR)

_kcl_show_pingsource_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Showing deployments of knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The deployments have been created by the revision controller'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get deploy $(__KCL_NAMESPACE__PINGSOURCE) --selector $(KCL_PINGSOURCE_DEPLOYMENTS_SELECTOR)

_kcl_show_pingsource_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this service is accessible at $(KCL_PINGSOURCE_NAME).$(KCL_PINGSOURCE_NAMESPACE_NAME).svc.cluster.local'; $(NORMAL)
	$(KUBECTL) describe pingsource $(__KCL_NAMESPACE__PINGSOURCE) $(KCL_PINGSOURCE_NAME)

_kcl_show_pingsource_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pingsource $(__KCL_NAMESPACE__PINGSOURCE) --output yaml $(KCL_PINGSOURCE_NAME) 

_kcl_show_pingsource_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods of knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The pods have be created by the replicat-set controller'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get pods $(__KCL_NAMESPACE__PINGSOURCE) --selector $(KCL_PINGSOURCE_PODS_SELECTOR)

_kcl_show_pingsource_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Showing replica-sets of knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The replicasets have be created by the deployment controller'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get replicasets $(__KCL_NAMESPACE__PINGSOURCE) --selector $(KCL_PINGSOURCE_REPLICASETS_SELECTOR)

_kcl_show_pingsource_revisions:
	@$(INFO) '$(KCL_UI_LABEL)Showing revisions of knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The revisions have be created by the configuration controller'; $(NORMAL)
	$(KUBECTL) get rev $(__KCL_NAMESPACE__PINGSOURCE) --selector $(KCL_PINGSOURCE_REVISIONS_SELECTOR)

_kcl_show_pingsource_routes:
	@$(INFO) '$(KCL_UI_LABEL)Showing routes of knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The routes have be created by the knative-ping-source controller'; $(NORMAL)
	@$(WARN) 'Only one route should match!'; $(NORMAL)
	$(KUBECTL) get route $(__KCL_NAMESPACE__PINGSOURCE) --selector $(KCL_PINGSOURCE_ROUTES_SELECTOR)

_kcl_show_pingsource_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing services of knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'At the minimum, 3 services should be present'
	@$(WARN) ' * For a knative-ping-source'
	@$(WARN) '   * ExternalName, a CNAME to an envoy-based proxy for proper routing'
	@$(WARN) ' * For each revision:'
	@$(WARN) '   * ClusterIP to use to access the specific revision'
	@$(WARN) '   * ClusterIP to use to collect metrics and configure queue proxy'; $(NORMAL)
	$(KUBECTL) get services $(__KCL_NAMESPACE__PINGSOURCE) --selector $(KCL_PINGSOURCE_SERVICES_SELECTOR)

_kcl_show_pingsource_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pingsource $(__KCL_NAMESPACE__PINGSOURCE) $(KCL_PINGSOURCE_NAME) 

_kcl_unapply_pingsource: _kcl_unapply_pingsources
_kcl_unapply_pingsources:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more knative-ping-sources ...'; $(NORMAL)
	# cat $(KCL_PINGSOURCE_MANIFEST_FILEPATH)
	# curl -L $(KCL_PINGSOURCE_MANIFEST_FILEPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__PINGSOURCE) $(__KCL_NAMESPACE__PINGSOURCE)

_kcl_unlabel_pingsource:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)

_kcl_update_pingsource:
	@$(INFO) '$(KCL_UI_LABEL)Updating knative-ping-source "$(KCL_PINGSOURCE_NAME)" ...'; $(NORMAL)

_kcl_view_pingsources:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL knative-ping-sources ...'; $(NORMAL)
	$(KUBECTL) get pingsource --all-namespaces=true $(_X__KCL_NAMESPACE__PINGSOURCES) $(__KCL_OUTPUT__PINGSOURCES) $(_X__KCL_SELECTOR__PINGSOURCES)$(__KCL_SHOW_LABELS__PINGSOURCES)

_kcl_view_pingsources_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing knative-ping-sources-set "$(KCL_PINGSOURCES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Knative-ping-sources are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get pingsource --all-namespaces=false $(__KCL_FIELD_SELECTOR__PINGSOURCES) $(__KCL_NAMESPACE__PINGSOURCES) $(__KCL_OUTPUT__PINGSOURCES) $(__KCL_SELECTOR__PINGSOURCES) $(__KCL_SHOW_LABELS__PINGSOURCES)

_kcl_watch_pingsources:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL knative-ping-sources ...'; $(NORMAL)
	$(KUBECTL) get pingsource $(strip $(_X__KCL_ALL_NAMESPACES__PINGSOURCES) --all-namespaces=true $(_X__KCL_NAMESPACE__PINGSOURCES) $(__KCL_OUTPUT__PINGSOURCES) $(_X__KCL_SELECTOR__PINGSOURCES) $(_X__KCL_WATCH__PINGSOURCES) --watch=true $(__KCL_WATCH_ONLY__PINGSOURCES) )

_kcl_watch_pingsources_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching knative-ping-sources-set "$(KCL_PINGSOURCES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pingsource $(strip $(__KCL_ALL_NAMESPACES__PINGSOURCES) $(__KCL_NAMESPACE__PINGSOURCES) $(__KCL_OUTPUT__PINGSOURCES) $(__KCL_SELECTOR__PINGSOURCES) $(_X__KCL_WATCH__PINGSOURCES) --watch=true $(__KCL_WATCH_ONLY__PINGSOURCES) )
