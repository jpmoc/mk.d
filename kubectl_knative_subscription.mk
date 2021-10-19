_KUBECTL_KNATIVE_SUBSCRIPTION_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# KCL_SUBSCRIPTION_BROKER_NAME?= default
# KCL_SUBSCRIPTION_KUSTOMIZATION_DIRPATH?= ./
# KCL_SUBSCRIPTION_LABELS_KEYVALUES?=
# KCL_SUBSCRIPTION_NAME?= my-name
# KCL_SUBSCRIPTION_NAMESPACE_NAME?= default
# KCL_SUBSCRIPTION_OUTPUT_FORMAT?=
# KCL_SUBSCRIPTION_SELECTOR?= app=global-registration-service
# KCL_SUBSCRIPTION_INTERNAL_URL?= http://subscription-ingress.knative-eventing.svc.cluster.local/event-example/default
# KCL_SUBSCRIPTIONS_CLUSTER_NAME?= my-cluster-name
# KCL_SUBSCRIPTIONS_FIELDSELECTOR?= metadata.name=my-subscription
# KCL_SUBSCRIPTIONS_MANIFEST_DIRPATH?= ./in/
# KCL_SUBSCRIPTIONS_MANIFEST_FILENAME?= manifest.yaml
# KCL_SUBSCRIPTIONS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_SUBSCRIPTIONS_MANIFEST_STDINFLAG?= false
# KCL_SUBSCRIPTIONS_MANIFEST_URL?= http://...
# KCL_SUBSCRIPTIONS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_SUBSCRIPTIONS_NAMESPACE_NAME?= default
# KCL_SUBSCRIPTIONS_OUTPUT_FORMAT?= jsonpath='{.items[0].metadata.name}'
# KCL_SUBSCRIPTIONS_SELECTOR?= run=ecr-read-only--renew-token
# KCL_SUBSCRIPTIONS_SET_NAME?= my-subscriptions-set
# KCL_SUBSCRIPTIONS_SORT_BY?= status.completionTime

# Derived parameters
KCL_SUBSCRIPTION_BROKER_NAME?= $(KCL_BROKER_NAME)
KCL_SUBSCRIPTION_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SUBSCRIPTION_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_SUBSCRIPTION_NAMES?= $(KCL_SUBSCRIPTION_NAME)
KCL_SUBSCRIPTION_OUTPUT_FORMAT?= $(KCL_OUTPUT_FORMAT)
KCL_SUBSCRIPTIONS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SUBSCRIPTIONS_MANIFEST_FILEPATH?= $(if $(KCL_SUBSCRIPTIONS_MANIFEST_FILENAME),$(KCL_SUBSCRIPTIONS_MANIFEST_DIRPATH)$(KCL_SUBSCRIPTIONS_MANIFEST_FILENAME))
KCL_SUBSCRIPTIONS_NAMESPACE_NAME?= $(KCL_SUBSCRIPTION_NAMESPACE_NAME)
KCL_SUBSCRIPTIONS_SET_NAME?= $(KCL_SUBSCRIPTIONS_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__SUBSCRIPTIONS+= $(if $(KCL_SUBSCRIPTIONS_MANIFEST_FILEPATH),--filename $(KCL_SUBSCRIPTIONS_MANIFEST_FILEPATH))
__KCL_FILENAME__SUBSCRIPTIONS+= $(if $(filter true,$(KCL_SUBSCRIPTIONS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__SUBSCRIPTIONS+= $(if $(KCL_SUBSCRIPTIONS_MANIFEST_URL),--filename $(KCL_SUBSCRIPTIONS_MANIFEST_URL))
__KCL_FILENAME__SUBSCRIPTIONS+= $(if $(KCL_SUBSCRIPTIONS_MANIFESTS_DIRPATH),--filename $(KCL_SUBSCRIPTIONS_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__SUBSCRIPTION= $(if $(KCL_SUBSCRIPTION_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_SUBSCRIPTION_KUSTOMIZATION_DIRPATH))
__KCL_LABELS__SUBSCRIPTION= $(if $(KCL_SUBSCRIPTION_LABELS_KEYVALUES),--labels $(KCL_SUBSCRIPTION_LABELS_KEYVALUES))
__KCL_NAME__SUBSCRIPTION= $(if $(KCL_SUBSCRIPTION_SERVICE_NAME),--name $(KCL_SUBSCRIPTION_SERVICE_NAME))
__KCL_NAMESPACE__SUBSCRIPTION= $(if $(KCL_SUBSCRIPTION_NAMESPACE_NAME),--namespace $(KCL_SUBSCRIPTION_NAMESPACE_NAME))
__KCL_NAMESPACE__SUBSCRIPTIONS= $(if $(KCL_SUBSCRIPTIONS_NAMESPACE_NAME),--namespace $(KCL_SUBSCRIPTIONS_NAMESPACE_NAME))
__KCL_OUTPUT__SUBSCRIPTION= $(if $(KCL_SUBSCRIPTION_OUTPUT_FORMAT),--output $(KCL_SUBSCRIPTION_OUTPUT_FORMAT))
__KCL_OUTPUT__SUBSCRIPTIONS= $(if $(KCL_SUBSCRIPTIONS_OUTPUT_FORMAT),--output $(KCL_SUBSCRIPTIONS_OUTPUT_FORMAT))
__KCL_SELECTOR__SUBSCRIPTIONS= $(if $(KCL_SUBSCRIPTIONS_SELECTOR),--selector=$(KCL_SUBSCRIPTIONS_SELECTOR))
__KCL_SORT_BY__SUBSCRIPTIONS= $(if $(KCL_SUBSCRIPTIONS_SORT_BY),--sort-by=$(KCL_SUBSCRIPTIONS_SORT_BY))

# Pipe parameters
_KCL_APPLY_SUBSCRIPTIONS_|?= #
_KCL_DIFF_SUBSCRIPTIONS_|?= $(_KCL_APPLY_SUBSCRIPTIONS_|)
_KCL_UNAPPLY_SUBSCRIPTIONS_|?= $(_KCL_APPLY_SUBSCRIPTIONS_|)
|_KCL_KUSTOMIZE_SUBSCRIPTION?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Knative::Subscription ($(_KUBECTL_KNATIVE_SUBSCRIPTION_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Knative::Subscription ($(_KUBECTL_KNATIVE_SUBSCRIPTION_MK_VERSION)) parameters:'
	@echo '    KCL_SUBSCRIPTION_ANNOTATIONS_KEYS=$(KCL_SUBSCRIPTION_ANNOTATIONS_KEYS)'
	@echo '    KCL_SUBSCRIPTION_ANNOTATIONS_KEYVALUES=$(KCL_SUBSCRIPTION_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_SUBSCRIPTION_BROKER_NAME=$(KCL_SUBSCRIPTION_BROKER_NAME)'
	@echo '    KCL_SUBSCRIPTION_KUSTOMIZATION_DIRPATH=$(KCL_SUBSCRIPTION_KUSTOMIZATION_DIRPATH)'
	@echo '    KCL_SUBSCRIPTION_LABELS_KEYS=$(KCL_SUBSCRIPTION_LABELS_KEYS)'
	@echo '    KCL_SUBSCRIPTION_LABELS_KEYVALUES=$(KCL_SUBSCRIPTION_LABELS_KEYVALUES)'
	@echo '    KCL_SUBSCRIPTION_NAME=$(KCL_SUBSCRIPTION_NAME)'
	@echo '    KCL_SUBSCRIPTION_NAMESPACE_NAME=$(KCL_SUBSCRIPTION_NAMESPACE_NAME)'
	@echo '    KCL_SUBSCRIPTION_OUTPUT_FORMAT=$(KCL_SUBSCRIPTION_OUTPUT_FORMAT)'
	@echo '    KCL_SUBSCRIPTION_SELECTOR=$(KCL_SUBSCRIPTION_SELECTOR)'
	@echo '    KCL_SUBSCRIPTIONS_FIELDSELECTOR=$(KCL_SUBSCRIPTIONS_FIELDSELECTOR)'
	@echo '    KCL_SUBSCRIPTIONS_MANIFEST_DIRPATH=$(KCL_SUBSCRIPTIONS_MANIFEST_DIRPATH)'
	@echo '    KCL_SUBSCRIPTIONS_MANIFEST_FILENAME=$(KCL_SUBSCRIPTIONS_MANIFEST_FILENAME)'
	@echo '    KCL_SUBSCRIPTIONS_MANIFEST_FILEPATH=$(KCL_SUBSCRIPTIONS_MANIFEST_FILEPATH)'
	@echo '    KCL_SUBSCRIPTIONS_MANIFEST_STDINFLAG=$(KCL_SUBSCRIPTIONS_MANIFEST_STDINFLAG)'
	@echo '    KCL_SUBSCRIPTIONS_MANIFEST_URL=$(KCL_SUBSCRIPTIONS_MANIFEST_URL)'
	@echo '    KCL_SUBSCRIPTIONS_MANIFESTS_DIRPATH=$(KCL_SUBSCRIPTIONS_MANIFESTS_DIRPATH)'
	@echo '    KCL_SUBSCRIPTIONS_NAMESPACE_NAME=$(KCL_SUBSCRIPTIONS_NAMESPACE_NAME)'
	@echo '    KCL_SUBSCRIPTIONS_OUTPUT_FORMAT=$(KCL_SUBSCRIPTIONS_OUTPUT_FORMAT)'
	@echo '    KCL_SUBSCRIPTIONS_SELECTOR=$(KCL_SUBSCRIPTIONS_SELECTOR)'
	@echo '    KCL_SUBSCRIPTIONS_SET_NAME=$(KCL_SUBSCRIPTIONS_SET_NAME)'
	@echo '    KCL_SUBSCRIPTIONS_SORT_BY=$(KCL_SUBSCRIPTIONS_SORT_BY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Knative::Subscription ($(_KUBECTL_KNATIVE_SUBSCRIPTION_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_subscription                - Annotate a subscription'
	@echo '    _kcl_apply_subscriptions                  - Apply manifest for one-por-more subscriptions'
	@echo '    _kcl_create_subscription                  - Create a new subscription'
	@echo '    _kcl_curl_subscription                    - Curl a new subscription'
	@echo '    _kcl_delete_subscription                  - Delete an existing subscription'
	@echo '    _kcl_diff_subscriptions                   - Diff a manifest with one-or-more existing subscriptions'
	@echo '    _kcl_edit_subscription                    - Edit a subscription'
	@echo '    _kcl_explain_subscription                 - Explain the subscription object'
	@echo '    _kcl_kustomize_subscription               - Kustomize one-or-more subscriptions'
	@echo '    _kcl_label_subscription                   - Label a subscription'
	@echo '    _kcl_show_subscription                    - Show everything related to a subscription'
	@echo '    _kcl_show_subscription_channel            - Show the channel of a subscription'
	@echo '    _kcl_show_subscription_description        - Show the description of a subscription'
	@echo '    _kcl_show_subscription_object             - Show the object of a subscription'
	@echo '    _kcl_show_subscription_state              - Show state of a subscription'
	@echo '    _kcl_unapply_subscriptions                - Un-apply manifest for one-or-more subscriptions'
	@echo '    _kcl_unlabel_subscription                 - Un-label manifest for a subscription'
	@echo '    _kcl_update_subscription                  - Update a subscription'
	@echo '    _kcl_view_subscriptions                   - View all subscriptions'
	@echo '    _kcl_view_subscriptions_set               - View a set of subscriptions'
	@echo '    _kcl_watch_subscriptions                  - Watching subscriptions'
	@echo '    _kcl_watch_subscriptions_set              - Watching a set of subscriptions'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_subscription:
	@$(INFO) '$(KCL_UI_LABEL)Annotating subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate ...

_kcl_apply_subscription: _kcl_apply_subscriptions
_kcl_apply_subscriptions:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more subscriptions ...'; $(NORMAL)
	$(if $(KCL_SUBSCRIPTIONS_MANIFEST_FILEPATH),cat $(KCL_SUBSCRIPTIONS_MANIFEST_FILEPATH); echo)
	$(if $(filter true,$(KCL_SUBSCRIPTIONS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_SUBSCRIPTIONS_|)cat)
	$(if $(KCL_SUBSCRIPTIONS_MANIFEST_URL), curl -L $(KCL_SUBSCRIPTIONS_MANIFEST_URL); echo )
	$(if $(KCL_SUBSCRIPTIONS_MANIFESTS_DIRPATH), ls -al $(KCL_SUBSCRIPTIONS_MANIFESTS_DIRPATH); echo)
	$(_KCL_APPLY_SUBSCRIPTIONS_|)$(KUBECTL) apply $(__KCL_FILENAME__SUBSCRIPTIONS) $(__KCL_NAMESPACE__SUBSCRIPTIONS)

_kcl_create_subscription:
	@$(INFO) '$(KCL_UI_LABEL)Creating subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) run $(__KCL_IMAGE__SUBSCRIPTION) $(__KCL_EXPOSE__SUBSCRIPTION) $(__KCL_LABELS__SUBSCRIPTION) $(__KCL_NAMESPACE__SUBSCRIPTION) $(__KCL_PORT__SUBSCRIPTION) $(__KCL_REPLICAS__SUBSCRIPTION) $(__KCL_RESTART__SUBSCRIPTION) $(__KCL_SERVICEACCOUNT__SUBSCRIPTION) $(KCL_SUBSCRIPTION_NAME)

_kcl_delete_subscription:
	@$(INFO) '$(KCL_UI_LABEL)Deleting subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete subscription $(__KCL_NAMESPACE__SUBSCRIPTION) $(KCL_SUBSCRIPTION_NAME)

_kcl_diff_subscription: _kcl_diff_subscriptions
_kcl_diff_subscriptions:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster state with manifest for one-or-more subscriptions ...'; $(NORMAL)
	# cat $(KCL_SUBSCRIPTIONS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_SUBSCRIPTIONS_|)cat
	# curl -L $(KCL_SUBSCRIPTIONS_MANIFEST_URL)
	# ls -al $(KCL_SUBSCRIPTIONS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_SUBSCRIPTIONS_|)$(KUBECTL) diff $(__KCL_FILENAME__SUBSCRIPTIONS) $(__KCL_NAMESPACE__SUBSCRIPTIONS)

_kcl_edit_subscription:
	@$(INFO) '$(KCL_UI_LABEL)Editing subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit subscription $(__KCL_NAMESPACE__SUBSCRIPTION) $(KCL_SUBSCRIPTION_NAME)

_kcl_explain_subscription:
	@$(INFO) '$(KCL_UI_LABEL)Explaining subscription object ...'; $(NORMAL)
	$(KUBECTL) explain subscription

_kcl_kustomize_subscription: _kcl_kustomize_subscriptions
_kcl_kustomize_subscriptions:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more subscriptions ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_SUBSCRIPTION_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_SUBSCRIPTION)

_kcl_label_subscription:
	@$(INFO) '$(KCL_UI_LABEL)Labeling subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	@ $(KUBECTL) label ...

_kcl_show_subscription: _kcl_show_description_channel _kcl_show_subscription_object _kcl_show_subscription_state _kcl_show_subscription_subscriber _kcl_show_subscription_description

_kcl_show_subscription_broker:
	@$(INFO) '$(KCL_UI_LABEL)Showing broker of subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get broker $(__KCL_NAMESPACE__SUBSCRIPTION) $(KCL_SUBSCRIPTION_BROKER_NAME)

_kcl_show_subscription_channel:
	@$(INFO) '$(KCL_UI_LABEL)Showing channel of subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get channel $(__KCL_NAMESPACE__SUBSCRIPTION)

_kcl_show_subscription_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe subscription $(__KCL_NAMESPACE__SUBSCRIPTION) $(KCL_SUBSCRIPTION_NAME)

_kcl_show_subscription_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get subscription $(__KCL_NAMESPACE__SUBSCRIPTION) $(_X__KCL_OUTPUT__SUBSCRIPTION) --output yaml $(KCL_SUBSCRIPTION_NAME)

_kcl_show_subscription_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The URL is the INTERNAL URL where producer can curl-post CloudEvents'; $(NORMAL)
	$(KUBECTL) get subscription $(__KCL_NAMESPACE__SUBSCRIPTION) $(KCL_SUBSCRIPTION_NAME) 

_kcl_show_subscription_triggers:
	@$(INFO) '$(KCL_UI_LABEL)Showing triggers of subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The SUBSCRIBER_URI is where the filtered event will be sent'; $(NORMAL)
	$(KUBECTL) get triggers $(__KCL_NAMESPACE__SUBSCRIPTION) --selector eventing.knative.dev/subscription=$(KCL_SUBSCRIPTION_NAME)

_kcl_unapply_subscription: _kcl_unapply_subscriptions
_kcl_unapply_subscriptions:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more subscriptions ...'; $(NORMAL)
	# cat $(KCL_SUBSCRIPTIONS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_SUBSCRIPTIONS_|)cat
	# curl -L $(KCL_SUBSCRIPTIONS_MANIFEST_URL)
	# ls -al $(KCL_SUBSCRIPTIONS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_SUBSCRIPTIONS_|)$(KUBECTL) delete $(__KCL_FILENAME__SUBSCRIPTIONS) $(__KCL_NAMESPACE__SUBSCRIPTIONS)

_kcl_unlabel_subscription:
	@$(INFO) '$(KCL_UI_LABEL)Removing labels from subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_update_subscription:
	@$(INFO) '$(KCL_UI_LABEL)Updating subscription "$(KCL_SUBSCRIPTION_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) patch ...

_kcl_view_subscriptions:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL subscriptions ...'; $(NORMAL)
	$(KUBECTL) get subscriptions --all-namespaces=true $(_X__KCL_NAMESPACE__SUBSCRIPTIONS) $(__KCL_OUTPUT_SUBSCRIPTIONS) $(_X__KCL_SELECTOR__SUBSCRIPTIONS) $(__KCL_SORT_BY__SUBSCRIPTIONS)

_kcl_view_subscriptions_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing subscriptions-set "$(KCL_SUBSCRIPTIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Subscriptions are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get subscriptions --all-namespaces=false $(__KCL_NAMESPACE__SUBSCRIPTIONS) $(__KCL_OUTPUT__SUBSCRIPTIONS) $(__KCL_SELECTOR__SUBSCRIPTIONS) $(__KCL_SORT_BY__SUBSCRIPTIONS)

_kcl_watch_subscriptions:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL subscriptions ...'; $(NORMAL)
	$(KUBECTL) get subscriptions --all-namespaces=true --watch 

_kcl_watch_subscriptions_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching subscriptions-set "$(KCL_SUBSCRIPTIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Subscriptions are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
