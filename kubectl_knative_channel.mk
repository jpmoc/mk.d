_KUBECTL_KNATIVE_CHANNEL_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

KCL_CHANNEL_CLOUDEVENT_CONTENTTYPE?= application/json
KCL_CHANNEL_CLOUDEVENT_ID?= say-hello
KCL_CHANNEL_CLOUDEVENT_SOURCE?= not-sendoff
KCL_CHANNEL_CLOUDEVENT_SPECVERSION?= 1.0
KCL_CHANNEL_CLOUDEVENT_TYPE?= greeting
# KCL_CHANNEL_CURL?= time curl
KCL_CHANNEL_CURL_DATA?= -d '{"msg":"Hello Knative!"}'
# KCL_CHANNEL_CURL_HEADER?= -H "Ce-Id: say-hello" -H "Ce-Specversion: 1.0"
# KCL_CHANNEL_CURL_METHOD?= -X POST
# KCL_CHANNEL_DNSNAME?= channel-ingress.knative-eventing.svc.cluster.local
# KCL_CHANNEL_DNSNAME_DOMAIN?= svc.cluster.local
# KCL_CHANNEL_DNSNAME_HOSTNAME?= channel-ingress
# KCL_CHANNEL_DNSNAME_SUBDOMAIN?= knative-eventing.svc.cluster.local
# KCL_CHANNEL_IMAGE_CNAME?= datawire/qotm:1.3
# KCL_CHANNEL_KUSTOMIZATION_DIRPATH?= ./
# KCL_CHANNEL_LABELS_KEYVALUES?=
# KCL_CHANNEL_NAME?= hello
# KCL_CHANNEL_NAMESPACE_NAME?= default
# KCL_CHANNEL_OUTPUT_FORMAT?=
# KCL_CHANNEL_SELECTOR?= app=global-registration-service
# KCL_CHANNEL_URL?= http://channel-ingress.knative-eventing.svc.cluster.local/event-example/default
# KCL_CHANNEL_URL_DNSNAME?= channel-ingress.knative-eventing.svc.cluster.local
# KCL_CHANNEL_URL_PATH?= /event-example/default
# KCL_CHANNEL_URL_PORT?= :80
# KCL_CHANNEL_URL_PROTOCOL?= http://
# KCL_CHANNELS_CLUSTER_NAME?= my-cluster-name
# KCL_CHANNELS_FIELDSELECTOR?= metadata.name=my-channel
# KCL_CHANNELS_MANIFEST_DIRPATH?= ./in/
# KCL_CHANNELS_MANIFEST_FILENAME?= channel-manifest.yaml
# KCL_CHANNELS_MANIFEST_FILEPATH?= ./in/channel-manifest.yaml
# KCL_CHANNELS_MANIFEST_URL?= http://
# KCL_CHANNELS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_CHANNELS_NAMESPACE_NAME?= default
# KCL_CHANNELS_OUTPUT_FORMAT?= jsonpath='{.items[0].metadata.name}'
# KCL_CHANNELS_SELECTOR?= run=ecr-read-only--renew-token
# KCL_CHANNELS_SET_NAME?= my-channels-set
# KCL_CHANNELS_SORT_BY?= status.completionTime

# Derived parameters
KCL_CHANNEL_CURL?= $(KCL_KNATIVEEVENTING_CURL)
KCL_CHANNEL_CURL_HEADERS?= -H "Content-Type: $(KCL_CHANNEL_CLOUDEVENT_CONTENTTYPE)" -H "Ce-Id: $(KCL_CHANNEL_CLOUDEVENT_ID)" -H "Ce-Source: $(KCL_CHANNEL_CLOUDEVENT_SOURCE)" -H "Ce-Specversion: $(KCL_CHANNEL_CLOUDEVENT_SPECVERSION)" -H "Ce-Type: $(KCL_CHANNEL_CLOUDEVENT_TYPE)"
KCL_CHANNEL_DIG?= $(KCL_KNATIVEEVENTING_DIG)
KCL_CHANNEL_DNSNAME?= $(KCL_CHANNEL_DNSNAME_HOSTNAME).$(KCL_CHANNEL_SUBDOMAIN)
KCL_CHANNEL_DNSNAME_DOMAIN?= $(KCL_KNATIVEEVENTING_DOMAIN)
KCL_CHANNEL_DNSNAME_SUBDOMAIN?= $(KCL_KNATIVEEVENTING_NAMESPACE_NAME).$(KCL_CHANNEL_DNSNAME_DOMAIN)
KCL_CHANNEL_URL?= $(KCL_CHANNEL_URL_PROTOCOL)$(KCL_CHANNEL_URL_DNSNAME)$(KCL_CHANNEL_URL_PORT)$(KCL_CHANNEL_URL_PATH)
KCL_CHANNEL_URL_DNSNAME?= $(KCL_CHANNEL_DNSNAME)
KCL_CHANNEL_URL_PATH?= /$(KCL_CHANNEL_NAMESPACE_NAME)/$(KCL_CHANNEL_NAME)
KCL_CHANNEL_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CHANNEL_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_CHANNEL_NAMES?= $(KCL_CHANNEL_NAME)
KCL_CHANNEL_OUTPUT_FORMAT?= $(KCL_OUTPUT_FORMAT)
KCL_CHANNELS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CHANNELS_MANIFEST_FILEPATH?= $(KCL_CHANNELS_MANIFEST_DIRPATH)$(KCL_CHANNELS_MANIFEST_FILENAME)
KCL_CHANNELS_NAMESPACE_NAME?= $(KCL_CHANNEL_NAMESPACE_NAME)
KCL_CHANNELS_SET_NAME?= $(KCL_CHANNELS_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__CHANNELS+= $(if $(KCL_CHANNELS_MANIFEST_FILEPATH),--filename $(KCL_CHANNELS_MANIFEST_FILEPATH))
__KCL_FILENAME__CHANNELS+= $(if $(KCL_CHANNELS_MANIFEST_URL),--filename $(KCL_CHANNELS_MANIFEST_URL))
__KCL_FILENAME__CHANNELS+= $(if $(KCL_CHANNELS_MANIFESTS_DIRPATH),--filename $(KCL_CHANNELS_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__CHANNEL= $(if $(KCL_CHANNEL_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_CHANNEL_KUSTOMIZATION_DIRPATH))
__KCL_LABELS__CHANNEL= $(if $(KCL_CHANNEL_LABELS_KEYVALUES),--labels $(KCL_CHANNEL_LABELS_KEYVALUES))
__KCL_NAME__CHANNEL= $(if $(KCL_CHANNEL_SERVICE_NAME),--name $(KCL_CHANNEL_SERVICE_NAME))
__KCL_NAMESPACE__CHANNEL= $(if $(KCL_CHANNEL_NAMESPACE_NAME),--namespace $(KCL_CHANNEL_NAMESPACE_NAME))
__KCL_NAMESPACE__CHANNELS= $(if $(KCL_CHANNELS_NAMESPACE_NAME),--namespace $(KCL_CHANNELS_NAMESPACE_NAME))
__KCL_OUTPUT__CHANNEL= $(if $(KCL_CHANNEL_OUTPUT_FORMAT),--output $(KCL_CHANNEL_OUTPUT_FORMAT))
__KCL_OUTPUT__CHANNELS= $(if $(KCL_CHANNELS_OUTPUT_FORMAT),--output $(KCL_CHANNELS_OUTPUT_FORMAT))
__KCL_SELECTOR__CHANNELS= $(if $(KCL_CHANNELS_SELECTOR),--selector=$(KCL_CHANNELS_SELECTOR))
__KCL_SORT_BY__CHANNELS= $(if $(KCL_CHANNELS_SORT_BY),--sort-by=$(KCL_CHANNELS_SORT_BY))

# Pipe parameters
|_KCL_KUSTOMIZE_CHANNEL?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Knative::Channel ($(_KUBECTL_KNATIVE_CHANNEL_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Knative::Channel ($(_KUBECTL_KNATIVE_CHANNEL_MK_VERSION)) parameters:'
	@echo '    KCL_CHANNEL_CLOUDEVENT_CONTENTTYPE=$(KCL_CHANNEL_CLOUDEVENT_CONTENTTYPE)'
	@echo '    KCL_CHANNEL_CLOUDEVENT_ID=$(KCL_CHANNEL_CLOUDEVENT_ID)'
	@echo '    KCL_CHANNEL_CLOUDEVENT_SOURCE=$(KCL_CHANNEL_CLOUDEVENT_SOURCE)'
	@echo '    KCL_CHANNEL_CLOUDEVENT_SPECVERSION=$(KCL_CHANNEL_CLOUDEVENT_SPECVERSION)'
	@echo '    KCL_CHANNEL_CLOUDEVENT_TYPE=$(KCL_CHANNEL_CLOUDEVENT_TYPE)'
	@echo '    KCL_CHANNEL_DNSNAME=$(KCL_CHANNEL_DNSNAME)'
	@echo '    KCL_CHANNEL_DNSNAME_DOMAIN=$(KCL_CHANNEL_DNSNAME_DOMAIN)'
	@echo '    KCL_CHANNEL_DNSNAME_HOSTNAME=$(KCL_CHANNEL_DNSNAME_HOSTNAME)'
	@echo '    KCL_CHANNEL_DNSNAME_SUBDOMAIN=$(KCL_CHANNEL_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_CHANNEL_KUSTOMIZATION_DIRPATH=$(KCL_CHANNEL_KUSTOMIZATION_DIRPATH)'
	@echo '    KCL_CHANNEL_LABELS_KEYS=$(KCL_CHANNEL_LABELS_KEYS)'
	@echo '    KCL_CHANNEL_LABELS_KEYVALUES=$(KCL_CHANNEL_LABELS_KEYVALUES)'
	@echo '    KCL_CHANNEL_NAME=$(KCL_CHANNEL_NAME)'
	@echo '    KCL_CHANNEL_NAMESPACE_NAME=$(KCL_CHANNEL_NAMESPACE_NAME)'
	@echo '    KCL_CHANNEL_OUTPUT_FORMAT=$(KCL_CHANNEL_OUTPUT_FORMAT)'
	@echo '    KCL_CHANNEL_SELECTOR=$(KCL_CHANNEL_SELECTOR)'
	@echo '    KCL_CHANNEL_URL=$(KCL_CHANNEL_URL)'
	@echo '    KCL_CHANNEL_URL_DNSNAME=$(KCL_CHANNEL_URL_DNSNAME)'
	@echo '    KCL_CHANNEL_URL_PATH=$(KCL_CHANNEL_URL_PATH)'
	@echo '    KCL_CHANNEL_URL_PORT=$(KCL_CHANNEL_URL_PORT)'
	@echo '    KCL_CHANNEL_URL_PROTOCOL=$(KCL_CHANNEL_URL_PROTOCOL)'
	@echo '    KCL_CHANNELS_FIELDSELECTOR=$(KCL_CHANNELS_FIELDSELECTOR)'
	@echo '    KCL_CHANNELS_MANIFEST_DIRPATH=$(KCL_CHANNELS_MANIFEST_DIRPATH)'
	@echo '    KCL_CHANNELS_MANIFEST_FILENAME=$(KCL_CHANNELS_MANIFEST_FILENAME)'
	@echo '    KCL_CHANNELS_MANIFEST_FILEPATH=$(KCL_CHANNELS_MANIFEST_FILEPATH)'
	@echo '    KCL_CHANNELS_MANIFEST_URL=$(KCL_CHANNELS_MANIFEST_URL)'
	@echo '    KCL_CHANNELS_MANIFESTS_DIRPATH=$(KCL_CHANNELS_MANIFESTS_DIRPATH)'
	@echo '    KCL_CHANNELS_NAMESPACE_NAME=$(KCL_CHANNELS_NAMESPACE_NAME)'
	@echo '    KCL_CHANNELS_OUTPUT_FORMAT=$(KCL_CHANNELS_OUTPUT_FORMAT)'
	@echo '    KCL_CHANNELS_SELECTOR=$(KCL_CHANNELS_SELECTOR)'
	@echo '    KCL_CHANNELS_SET_NAME=$(KCL_CHANNELS_SET_NAME)'
	@echo '    KCL_CHANNELS_SORT_BY=$(KCL_CHANNELS_SORT_BY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Knative::Channel ($(_KUBECTL_KNATIVE_CHANNEL_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_channel                - Annotate a channel'
	@echo '    _kcl_apply_channels                  - Apply manifest for one-por-more channels'
	@echo '    _kcl_create_channel                  - Create a channel'
	@echo '    _kcl_curl_channel                    - Curl a channel'
	@echo '    _kcl_delete_channel                  - Delete an existing channel'
	@echo '    _kcl_diff_channels                   - Diff a manifest with one-or-more existing channels'
	@echo '    _kcl_dig_channel                     - Dig a channel'
	@echo '    _kcl_edit_channel                    - Edit a channel'
	@echo '    _kcl_explain_channel                 - Explain the channel object'
	@echo '    _kcl_kustomize_channel               - Kustomize one-or-more channels'
	@echo '    _kcl_label_channel                   - Label a channel'
	@echo '    _kcl_show_channel                    - Show everything related to a channel'
	@echo '    _kcl_show_channel_description        - Show the description of a channel'
	@echo '    _kcl_show_channel_object             - Show the object of a channel'
	@echo '    _kcl_show_channel_state              - Show state of a channel'
	@echo '    _kcl_show_channel_triggers           - Show triggers of a channel'
	@echo '    _kcl_unapply_channels                - Un-apply manifest for one-or-more channels'
	@echo '    _kcl_unlabel_channel                 - Un-label manifest for a channel'
	@echo '    _kcl_update_channel                  - Update a channel'
	@echo '    _kcl_view_channels                   - View all channels'
	@echo '    _kcl_view_channels_set               - View a set of channels'
	@echo '    _kcl_watch_channels                  - Watching channels'
	@echo '    _kcl_watch_channels_set              - Watching a set of channels'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_channel:
	@$(INFO) '$(KCL_UI_LABEL)Annotating channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)

_kcl_apply_channel: _kcl_apply_channels
_kcl_apply_channels:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more channels ...'; $(NORMAL)
	$(if $(KCL_CHANNELS_MANIFEST_FILEPATH), cat $(KCL_CHANNELS_MANIFEST_FILEPATH); echo)
	$(if $(KCL_CHANNELS_MANIFEST_URL), curl -L $(KCL_CHANNELS_MANIFEST_URL); echo )
	$(if $(KCL_CHANNELS_MANIFESTS_DIRPATH), ls -al $(KCL_CHANNELS_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__CHANNELS) $(__KCL_NAMESPACE__CHANNELS)

_kcl_create_channel:
	@$(INFO) '$(KCL_UI_LABEL)Creating channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)
	$(KUBECTL) run $(__KCL_IMAGE__CHANNEL) $(__KCL_EXPOSE__CHANNEL) $(__KCL_LABELS__CHANNEL) $(__KCL_NAMESPACE__CHANNEL) $(__KCL_PORT__CHANNEL) $(__KCL_REPLICAS__CHANNEL) $(__KCL_RESTART__CHANNEL) $(__KCL_SERVICEACCOUNT__CHANNEL) $(KCL_CHANNEL_NAME)

_kcl_curl_channel: 
	@$(INFO) '$(KCL_UI_LABEL)Posting on channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation posts an event to a channel'; $(NORMAL)
	$(KCL_CHANNEL_CURL) -X POST $(KCL_CHANNEL_CURL_DATA) $(KCL_CHANNEL_CURL_HEADERS) $(KCL_CHANNEL_URL)

_kcl_delete_channel:
	@$(INFO) '$(KCL_UI_LABEL)Deleting channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete channel $(__KCL_NAMESPACE__CHANNEL) $(KCL_CHANNEL_NAME)

_kcl_diff_channel: _kcl_diff_channels
_kcl_diff_channels:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster state with manifest for one-or-more channels ...'; $(NORMAL)
	# cat $(KCL_CHANNELS_MANIFEST_FILEPATH)
	# curl -L $(KCL_CHANNELS_MANIFEST_URL)
	# ls -al $(KCL_CHANNELS_MANIFESTS_DIRPATH)
	$(KUBECTL) diff $(__KCL_FILENAME__CHANNELS) $(__KCL_NAMESPACE__CHANNELS)

_kcl_dig_channel:
	@$(INFO) '$(KCL_UI_LABEL)Dig-ing channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)
	$(KCL_CHANNEL_DIG) $(KCL_CHANNEL_DNSNAME)

_kcl_edit_channel:
	@$(INFO) '$(KCL_UI_LABEL)Editing channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit channel $(__KCL_NAMESPACE__CHANNEL) $(KCL_CHANNEL_NAME)

_kcl_explain_channel:
	@$(INFO) '$(KCL_UI_LABEL)Explaining channel object ...'; $(NORMAL)
	$(KUBECTL) explain channel

_kcl_kustomize_channel: _kcl_kustomize_channels
_kcl_kustomize_channels:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more channels ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_CHANNEL_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_CHANNEL)

_kcl_label_channel:
	@$(INFO) '$(KCL_UI_LABEL)Labeling channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)

_kcl_show_channel: _kcl_show_channel_object _kcl_show_channel_state _kcl_show_channel_triggers _kcl_show_channel_description

_kcl_show_channel_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe channel $(__KCL_NAMESPACE__CHANNEL) $(KCL_CHANNEL_NAME)

_kcl_show_channel_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get channel $(__KCL_NAMESPACE__CHANNEL) $(_X__KCL_OUTPUT__CHANNEL) --output yaml $(KCL_CHANNEL_NAME)

_kcl_show_channel_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The URL is the INTERNAL URL where producer can curl-post CloudEvents'; $(NORMAL)
	$(KUBECTL) get channel $(__KCL_NAMESPACE__CHANNEL) $(KCL_CHANNEL_NAME) 

_kcl_show_channel_triggers:
	@$(INFO) '$(KCL_UI_LABEL)Showing triggers of channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The SUBSCRIBER_URI is where the filtered event will be sent'; $(NORMAL)
	$(KUBECTL) get triggers $(__KCL_NAMESPACE__CHANNEL) --selector eventing.knative.dev/channel=$(KCL_CHANNEL_NAME)

_kcl_unapply_channel: _kcl_unapply_channels
_kcl_unapply_channels:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more channels ...'; $(NORMAL)
	# cat $(KCL_CHANNELS_MANIFEST_FILEPATH)
	# curl -L $(KCL_CHANNELS_MANIFEST_URL)
	# ls -al $(KCL_CHANNELS_MANIFESTS_DIRPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__CHANNELS) $(__KCL_NAMESPACE__CHANNELS)

_kcl_unlabel_channel:
	@$(INFO) '$(KCL_UI_LABEL)Removing labels from channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)

_kcl_update_channel:
	@$(INFO) '$(KCL_UI_LABEL)Updating channel "$(KCL_CHANNEL_NAME)" ...'; $(NORMAL)

_kcl_view_channels:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL channels ...'; $(NORMAL)
	$(KUBECTL) get channels --all-namespaces=true $(_X__KCL_NAMESPACE__CHANNELS) $(__KCL_OUTPUT_CHANNELS) $(_X__KCL_SELECTOR__CHANNELS) $(__KCL_SORT_BY__CHANNELS)

_kcl_view_channels_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing channels-set "$(KCL_CHANNELS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'channels are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get channels --all-namespaces=false $(__KCL_NAMESPACE__CHANNELS) $(__KCL_OUTPUT__CHANNELS) $(__KCL_SELECTOR__CHANNELS) $(__KCL_SORT_BY__CHANNELS)

_kcl_watch_channels:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL channels ...'; $(NORMAL)
	$(KUBECTL) get channels --all-namespaces=true --watch 

_kcl_watch_channels_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching channels-set "$(KCL_CHANNELS_SET_NAME)" ...'; $(NORMAL)
