_KUBECTL_KNATIVE_BROKER_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

KCL_BROKER_CLOUDEVENT_CONTENTTYPE?= application/json
KCL_BROKER_CLOUDEVENT_ID?= say-hello
KCL_BROKER_CLOUDEVENT_SOURCE?= not-sendoff
KCL_BROKER_CLOUDEVENT_SPECVERSION?= 1.0
KCL_BROKER_CLOUDEVENT_TYPE?= greeting
# KCL_BROKER_CURL?= time curl
KCL_BROKER_CURL_DATA?= -d '{"msg":"Hello Knative!"}'
# KCL_BROKER_CURL_HEADER?= -H "Ce-Id: say-hello" -H "Ce-Specversion: 1.0"
# KCL_BROKER_DNSNAME?= broker-ingress.knative-eventing.svc.cluster.local
# KCL_BROKER_DNSNAME_DOMAIN?= svc.cluster.local
# KCL_BROKER_DNSNAME_HOSTNAME?= broker-ingress
# KCL_BROKER_DNSNAME_SUBDOMAIN?= knative-eventing.svc.cluster.local
# KCL_BROKER_IMAGE_CNAME?= datawire/qotm:1.3
# KCL_BROKER_KUSTOMIZATION_DIRPATH?= ./
# KCL_BROKER_LABELS_KEYVALUES?=
# KCL_BROKER_NAME?= hello
# KCL_BROKER_NAMESPACE_NAME?= default
# KCL_BROKER_OUTPUT_FORMAT?=
# KCL_BROKER_URL?= http://broker-ingress.knative-eventing.svc.cluster.local/event-example/default
# KCL_BROKER_URL_DNSNAME?= broker-ingress.knative-eventing.svc.cluster.local
# KCL_BROKER_URL_PATH?= /event-example/default
# KCL_BROKER_URL_PORT?= :80
# KCL_BROKER_URL_PROTOCOL?= http://
# KCL_BROKERS_CLUSTER_NAME?= my-cluster-name
# KCL_BROKERS_FIELDSELECTOR?= metadata.name=my-broker
# KCL_BROKERS_MANIFEST_DIRPATH?= ./in/
# KCL_BROKERS_MANIFEST_FILENAME?= broker-manifest.yaml
# KCL_BROKERS_MANIFEST_FILEPATH?= ./in/broker-manifest.yaml
# KCL_BROKERS_MANIFEST_URL?= http://
# KCL_BROKERS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_BROKERS_NAMESPACE_NAME?= default
# KCL_BROKERS_OUTPUT_FORMAT?= jsonpath='{.items[0].metadata.name}'
# KCL_BROKERS_SELECTOR?= run=ecr-read-only--renew-token
# KCL_BROKERS_SET_NAME?= my-brokers-set
# KCL_BROKERS_SORT_BY?= status.completionTime

# Derived parameters
KCL_BROKER_CURL?= $(KCL_KNATIVEEVENTING_CURL)
KCL_BROKER_CURL_HEADERS?= -H "Content-Type: $(KCL_BROKER_CLOUDEVENT_CONTENTTYPE)" -H "Ce-Id: $(KCL_BROKER_CLOUDEVENT_ID)" -H "Ce-Source: $(KCL_BROKER_CLOUDEVENT_SOURCE)" -H "Ce-Specversion: $(KCL_BROKER_CLOUDEVENT_SPECVERSION)" -H "Ce-Type: $(KCL_BROKER_CLOUDEVENT_TYPE)"
KCL_BROKER_DIG?= $(KCL_KNATIVEEVENTING_DIG)
KCL_BROKER_DNSNAME?= $(KCL_BROKER_HOSTNAME).$(KCL_BROKER_DNSNAME_SUBDOMAIN)
KCL_BROKER_DNSNAME_DOMAIN?= $(KCL_KNATIVEEVENTING_DNSNAME_DOMAIN)
KCL_BROKER_DNSNAME_SUBDOMAIN?= $(KCL_KNATIVEEVENTING_NAMESPACE_NAME).$(KCL_BROKER_DNSNAME_DOMAIN)
KCL_BROKER_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_BROKER_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_BROKER_NAMES?= $(KCL_BROKER_NAME)
KCL_BROKER_OUTPUT_FORMAT?= $(KCL_OUTPUT_FORMAT)
KCL_BROKER_URL?= $(KCL_BROKER_URL_PROTOCOL)$(KCL_BROKER_URL_DNSNAME)$(KCL_BROKER_URL_PORT)$(KCL_BROKER_URL_PATH)
KCL_BROKER_URL_DNSNAME?= $(KCL_BROKER_DNSNAME)
KCL_BROKER_URL_PATH?= /$(KCL_BROKER_NAMESPACE_NAME)/$(KCL_BROKER_NAME)
KCL_BROKERS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_BROKERS_MANIFEST_FILEPATH?= $(KCL_BROKERS_MANIFEST_DIRPATH)$(KCL_BROKERS_MANIFEST_FILENAME)
KCL_BROKERS_NAMESPACE_NAME?= $(KCL_BROKER_NAMESPACE_NAME)
KCL_BROKERS_SET_NAME?= $(KCL_BROKERS_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__BROKERS+= $(if $(KCL_BROKERS_MANIFEST_FILEPATH),--filename $(KCL_BROKERS_MANIFEST_FILEPATH))
__KCL_FILENAME__BROKERS+= $(if $(KCL_BROKERS_MANIFEST_URL),--filename $(KCL_BROKERS_MANIFEST_URL))
__KCL_FILENAME__BROKERS+= $(if $(KCL_BROKERS_MANIFESTS_DIRPATH),--filename $(KCL_BROKERS_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__BROKER= $(if $(KCL_BROKER_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_BROKER_KUSTOMIZATION_DIRPATH))
__KCL_LABELS__BROKER= $(if $(KCL_BROKER_LABELS_KEYVALUES),--labels $(KCL_BROKER_LABELS_KEYVALUES))
__KCL_NAME__BROKER= $(if $(KCL_BROKER_SERVICE_NAME),--name $(KCL_BROKER_SERVICE_NAME))
__KCL_NAMESPACE__BROKER= $(if $(KCL_BROKER_NAMESPACE_NAME),--namespace $(KCL_BROKER_NAMESPACE_NAME))
__KCL_NAMESPACE__BROKERS= $(if $(KCL_BROKERS_NAMESPACE_NAME),--namespace $(KCL_BROKERS_NAMESPACE_NAME))
__KCL_OUTPUT__BROKER= $(if $(KCL_BROKER_OUTPUT_FORMAT),--output $(KCL_BROKER_OUTPUT_FORMAT))
__KCL_OUTPUT__BROKERS= $(if $(KCL_BROKERS_OUTPUT_FORMAT),--output $(KCL_BROKERS_OUTPUT_FORMAT))
__KCL_SELECTOR__BROKERS= $(if $(KCL_BROKERS_SELECTOR),--selector=$(KCL_BROKERS_SELECTOR))
__KCL_SORT_BY__BROKERS= $(if $(KCL_BROKERS_SORT_BY),--sort-by=$(KCL_BROKERS_SORT_BY))

# Pipe parameters
|_KCL_KUSTOMIZE_BROKER?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Knative::Broker ($(_KUBECTL_KNATIVE_BROKER_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Knative::Broker ($(_KUBECTL_KNATIVE_BROKER_MK_VERSION)) parameters:'
	@echo '    KCL_BROKER_CLOUDEVENT_CONTENTTYPE=$(KCL_BROKER_CLOUDEVENT_CONTENTTYPE)'
	@echo '    KCL_BROKER_CLOUDEVENT_ID=$(KCL_BROKER_CLOUDEVENT_ID)'
	@echo '    KCL_BROKER_CLOUDEVENT_SOURCE=$(KCL_BROKER_CLOUDEVENT_SOURCE)'
	@echo '    KCL_BROKER_CLOUDEVENT_SPECVERSION=$(KCL_BROKER_CLOUDEVENT_SPECVERSION)'
	@echo '    KCL_BROKER_CLOUDEVENT_TYPE=$(KCL_BROKER_CLOUDEVENT_TYPE)'
	@echo '    KCL_BROKER_DNSNAME=$(KCL_BROKER_DNSNAME)'
	@echo '    KCL_BROKER_DNSNAME_DOMAIN=$(KCL_BROKER_DNSNAME_DOMAIN)'
	@echo '    KCL_BROKER_DNSNAME_HOSTNAME=$(KCL_BROKER_DNSNAME_HOSTNAME)'
	@echo '    KCL_BROKER_DNSNAME_SUBDOMAIN=$(KCL_BROKER_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_BROKER_KUSTOMIZATION_DIRPATH=$(KCL_BROKER_KUSTOMIZATION_DIRPATH)'
	@echo '    KCL_BROKER_LABELS_KEYS=$(KCL_BROKER_LABELS_KEYS)'
	@echo '    KCL_BROKER_LABELS_KEYVALUES=$(KCL_BROKER_LABELS_KEYVALUES)'
	@echo '    KCL_BROKER_NAME=$(KCL_BROKER_NAME)'
	@echo '    KCL_BROKER_NAMESPACE_NAME=$(KCL_BROKER_NAMESPACE_NAME)'
	@echo '    KCL_BROKER_OUTPUT_FORMAT=$(KCL_BROKER_OUTPUT_FORMAT)'
	@echo '    KCL_BROKER_URL=$(KCL_BROKER_URL)'
	@echo '    KCL_BROKER_URL_DNSNAME=$(KCL_BROKER_URL_DNSNAME)'
	@echo '    KCL_BROKER_URL_PATH=$(KCL_BROKER_URL_PATH)'
	@echo '    KCL_BROKER_URL_PORT=$(KCL_BROKER_URL_PORT)'
	@echo '    KCL_BROKER_URL_PROTOCOL=$(KCL_BROKER_URL_PROTOCOL)'
	@echo '    KCL_BROKERS_FIELDSELECTOR=$(KCL_BROKERS_FIELDSELECTOR)'
	@echo '    KCL_BROKERS_MANIFEST_DIRPATH=$(KCL_BROKERS_MANIFEST_DIRPATH)'
	@echo '    KCL_BROKERS_MANIFEST_FILENAME=$(KCL_BROKERS_MANIFEST_FILENAME)'
	@echo '    KCL_BROKERS_MANIFEST_FILEPATH=$(KCL_BROKERS_MANIFEST_FILEPATH)'
	@echo '    KCL_BROKERS_MANIFEST_URL=$(KCL_BROKERS_MANIFEST_URL)'
	@echo '    KCL_BROKERS_MANIFESTS_DIRPATH=$(KCL_BROKERS_MANIFESTS_DIRPATH)'
	@echo '    KCL_BROKERS_NAMESPACE_NAME=$(KCL_BROKERS_NAMESPACE_NAME)'
	@echo '    KCL_BROKERS_OUTPUT_FORMAT=$(KCL_BROKERS_OUTPUT_FORMAT)'
	@echo '    KCL_BROKERS_SELECTOR=$(KCL_BROKERS_SELECTOR)'
	@echo '    KCL_BROKERS_SET_NAME=$(KCL_BROKERS_SET_NAME)'
	@echo '    KCL_BROKERS_SORT_BY=$(KCL_BROKERS_SORT_BY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Knative::Broker ($(_KUBECTL_KNATIVE_BROKER_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_broker                - Annotate a broker'
	@echo '    _kcl_apply_brokers                  - Apply manifest for one-por-more brokers'
	@echo '    _kcl_create_broker                  - Create a broker'
	@echo '    _kcl_curl_broker                    - Curl a broker'
	@echo '    _kcl_delete_broker                  - Delete an existing broker'
	@echo '    _kcl_diff_brokers                   - Diff a manifest with one-or-more existing brokers'
	@echo '    _kcl_dig_broker                     - Dig a broker'
	@echo '    _kcl_edit_broker                    - Edit a broker'
	@echo '    _kcl_explain_broker                 - Explain the broker object'
	@echo '    _kcl_kustomize_broker               - Kustomize one-or-more brokers'
	@echo '    _kcl_label_broker                   - Label a broker'
	@echo '    _kcl_show_broker                    - Show everything related to a broker'
	@echo '    _kcl_show_broker_description        - Show the description of a broker'
	@echo '    _kcl_show_broker_object             - Show the object of a broker'
	@echo '    _kcl_show_broker_state              - Show state of a broker'
	@echo '    _kcl_show_broker_triggers           - Show triggers of a broker'
	@echo '    _kcl_unapply_brokers                - Un-apply manifest for one-or-more brokers'
	@echo '    _kcl_unlabel_broker                 - Un-label manifest for a broker'
	@echo '    _kcl_update_broker                  - Update a broker'
	@echo '    _kcl_view_brokers                   - View all brokers'
	@echo '    _kcl_view_brokers_set               - View a set of brokers'
	@echo '    _kcl_watch_brokers                  - Watching brokers'
	@echo '    _kcl_watch_brokers_set              - Watching a set of brokers'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_broker:
	@$(INFO) '$(KCL_UI_LABEL)Annotating broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)

_kcl_apply_broker: _kcl_apply_brokers
_kcl_apply_brokers:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more brokers ...'; $(NORMAL)
	$(if $(KCL_BROKERS_MANIFEST_FILEPATH), cat $(KCL_BROKERS_MANIFEST_FILEPATH); echo)
	$(if $(KCL_BROKERS_MANIFEST_URL), curl -L $(KCL_BROKERS_MANIFEST_URL); echo )
	$(if $(KCL_BROKERS_MANIFESTS_DIRPATH), ls -al $(KCL_BROKERS_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__BROKERS) $(__KCL_NAMESPACE__BROKERS)

_kcl_create_broker:
	@$(INFO) '$(KCL_UI_LABEL)Creating broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) run $(__KCL_IMAGE__BROKER) $(__KCL_EXPOSE__BROKER) $(__KCL_LABELS__BROKER) $(__KCL_NAMESPACE__BROKER) $(__KCL_PORT__BROKER) $(__KCL_REPLICAS__BROKER) $(__KCL_RESTART__BROKER) $(__KCL_SERVICEACCOUNT__BROKER) $(KCL_BROKER_NAME)

_kcl_curl_broker: 
	@$(INFO) '$(KCL_UI_LABEL)Curl-ing broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation post an event on the broker'; $(NORMAL)
	$(KCL_BROKER_CURL) -X POST $(KCL_BROKER_CURL_DATA) $(KCL_BROKER_CURL_HEADERS) $(KCL_BROKER_URL)

_kcl_delete_broker:
	@$(INFO) '$(KCL_UI_LABEL)Deleting broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete broker $(__KCL_NAMESPACE__BROKER) $(KCL_BROKER_NAME)

_kcl_diff_broker: _kcl_diff_brokers
_kcl_diff_brokers:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster state with manifest for one-or-more brokers ...'; $(NORMAL)
	# cat $(KCL_BROKERS_MANIFEST_FILEPATH)
	# curl -L $(KCL_BROKERS_MANIFEST_URL)
	# ls -al $(KCL_BROKERS_MANIFESTS_DIRPATH)
	$(KUBECTL) diff $(__KCL_FILENAME__BROKERS) $(__KCL_NAMESPACE__BROKERS)

_kcl_dig_broker:
	@$(INFO) '$(KCL_UI_LABEL)Dig-ing broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)
	$(KCL_BROKER_DIG) $(KCL_BROKER_DNSNAME)

_kcl_edit_broker:
	@$(INFO) '$(KCL_UI_LABEL)Editing broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit broker $(__KCL_NAMESPACE__BROKER) $(KCL_BROKER_NAME)

_kcl_explain_broker:
	@$(INFO) '$(KCL_UI_LABEL)Explaining broker object ...'; $(NORMAL)
	$(KUBECTL) explain broker

_kcl_kustomize_broker: _kcl_kustomize_brokers
_kcl_kustomize_brokers:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more brokers ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_BROKER_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_BROKER)

_kcl_label_broker:
	@$(INFO) '$(KCL_UI_LABEL)Labeling broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)

_kcl_show_broker: _kcl_show_broker_object _kcl_show_broker_state _kcl_show_broker_triggers _kcl_show_broker_description

_kcl_show_broker_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe broker $(__KCL_NAMESPACE__BROKER) $(KCL_BROKER_NAME)

_kcl_show_broker_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get broker $(__KCL_NAMESPACE__BROKER) $(_X__KCL_OUTPUT__BROKER) --output yaml $(KCL_BROKER_NAME)

_kcl_show_broker_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The URL is the INTERNAL URL where producer can curl-post CloudEvents'; $(NORMAL)
	$(KUBECTL) get broker $(__KCL_NAMESPACE__BROKER) $(KCL_BROKER_NAME) 

_kcl_show_broker_triggers:
	@$(INFO) '$(KCL_UI_LABEL)Showing triggers of broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The SUBSCRIBER_URI is where the filtered event will be sent'; $(NORMAL)
	$(KUBECTL) get triggers $(__KCL_NAMESPACE__BROKER) --selector eventing.knative.dev/broker=$(KCL_BROKER_NAME)

_kcl_unapply_broker: _kcl_unapply_brokers
_kcl_unapply_brokers:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more brokers ...'; $(NORMAL)
	# cat $(KCL_BROKERS_MANIFEST_FILEPATH)
	# curl -L $(KCL_BROKERS_MANIFEST_URL)
	# ls -al $(KCL_BROKERS_MANIFESTS_DIRPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__BROKERS) $(__KCL_NAMESPACE__BROKERS)

_kcl_unlabel_broker:
	@$(INFO) '$(KCL_UI_LABEL)Removing labels from broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)

_kcl_update_broker:
	@$(INFO) '$(KCL_UI_LABEL)Updating broker "$(KCL_BROKER_NAME)" ...'; $(NORMAL)

_kcl_view_brokers:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL brokers ...'; $(NORMAL)
	$(KUBECTL) get brokers --all-namespaces=true $(_X__KCL_NAMESPACE__BROKERS) $(__KCL_OUTPUT_BROKERS) $(_X__KCL_SELECTOR__BROKERS) $(__KCL_SORT_BY__BROKERS)

_kcl_view_brokers_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing brokers-set "$(KCL_BROKERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'brokers are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get brokers --all-namespaces=false $(__KCL_NAMESPACE__BROKERS) $(__KCL_OUTPUT__BROKERS) $(__KCL_SELECTOR__BROKERS) $(__KCL_SORT_BY__BROKERS)

_kcl_watch_brokers:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL brokers ...'; $(NORMAL)
	$(KUBECTL) get brokers --all-namespaces=true --watch 

_kcl_watch_brokers_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching brokers-set "$(KCL_BROKERS_SET_NAME)" ...'; $(NORMAL)
