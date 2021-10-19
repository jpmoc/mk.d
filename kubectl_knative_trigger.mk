_KUBECTL_KNATIVE_TRIGGER_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# KCL_TRIGGER_ANNOTATIONS_KEYVALUES?= key=value ...
# KCL_TRIGGER_BROKER_NAME?= default
# KCL_TRIGGER_KUSTOMIZATION_DIRPATH?= ./
# KCL_TRIGGER_LABELS_KEYVALUES?= key=value ...
# KCL_TRIGGER_NAME?= may-name
# KCL_TRIGGER_NAMESPACE_NAME?= default
# KCL_TRIGGER_OUTPUT_FORMAT?=
# KCL_TRIGGER_SELECTOR?= app=global-registration-service
KCL_TRIGGER_SUBSCRIBER_KIND?= Service
# KCL_TRIGGER_SUBSCRIBER_NAME?= hello-display 
# KCL_TRIGGER_SUBSCRIBER_NAMESPACENAME?= default
# KCL_TRIGGERS_FIELDSELECTOR?= metadata.name=my-trigger
# KCL_TRIGGERS_MANIFEST_DIRPATH?= ./in/
# KCL_TRIGGERS_MANIFEST_FILENAME?= manifest.yaml
# KCL_TRIGGERS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_TRIGGERS_MANIFEST_STDINFLAG?= false
# KCL_TRIGGERS_MANIFEST_URL?= http://...
# KCL_TRIGGERS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_TRIGGERS_NAMESPACE_NAME?= default
# KCL_TRIGGERS_OUTPUT_FORMAT?= jsonpath='{.items[0].metadata.name}'
# KCL_TRIGGERS_SELECTOR?= run=ecr-read-only--renew-token
# KCL_TRIGGERS_SET_NAME?= my-triggers-set
# KCL_TRIGGERS_SORT_BY?= status.completionTime

# Derived parameters
KCL_TRIGGER_BROKER_NAME?= $(KCL_BROKER_NAME)
KCL_TRIGGER_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_TRIGGER_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_TRIGGER_NAMES?= $(KCL_TRIGGER_NAME)
KCL_TRIGGER_OUTPUT_FORMAT?= $(KCL_OUTPUT_FORMAT)
KCL_TRIGGER_SUBSCRIBER_NAME?= $(KCL_TRIGGER_NAME)
KCL_TRIGGER_SUBSCRIBER_NAMESPACENAME?= $(KCL_TRIGGER_NAMESPACE_NAME)
KCL_TRIGGERS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_TRIGGERS_MANIFEST_FILEPATH?= $(if $(KCL_TRIGGERS_MANIFEST_FILENAME),$(KCL_TRIGGERS_MANIFEST_DIRPATH)$(KCL_TRIGGERS_MANIFEST_FILENAME))
KCL_TRIGGERS_NAMESPACE_NAME?= $(KCL_TRIGGER_NAMESPACE_NAME)
KCL_TRIGGERS_SET_NAME?= $(KCL_TRIGGERS_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__TRIGGERS+= $(if $(KCL_TRIGGERS_MANIFEST_FILEPATH),--filename $(KCL_TRIGGERS_MANIFEST_FILEPATH))
__KCL_FILENAME__TRIGGERS+= $(if $(filter true,$(KCL_TRIGGERS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__TRIGGERS+= $(if $(KCL_TRIGGERS_MANIFEST_URL),--filename $(KCL_TRIGGERS_MANIFEST_URL))
__KCL_FILENAME__TRIGGERS+= $(if $(KCL_TRIGGERS_MANIFESTS_DIRPATH),--filename $(KCL_TRIGGERS_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__TRIGGER= $(if $(KCL_TRIGGER_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_TRIGGER_KUSTOMIZATION_DIRPATH))
__KCL_LABELS__TRIGGER= $(if $(KCL_TRIGGER_LABELS_KEYVALUES),--labels $(KCL_TRIGGER_LABELS_KEYVALUES))
__KCL_NAME__TRIGGER= $(if $(KCL_TRIGGER_SERVICE_NAME),--name $(KCL_TRIGGER_SERVICE_NAME))
__KCL_NAMESPACE__TRIGGER= $(if $(KCL_TRIGGER_NAMESPACE_NAME),--namespace $(KCL_TRIGGER_NAMESPACE_NAME))
__KCL_NAMESPACE__TRIGGERS= $(if $(KCL_TRIGGERS_NAMESPACE_NAME),--namespace $(KCL_TRIGGERS_NAMESPACE_NAME))
__KCL_OUTPUT__TRIGGER= $(if $(KCL_TRIGGER_OUTPUT_FORMAT),--output $(KCL_TRIGGER_OUTPUT_FORMAT))
__KCL_OUTPUT__TRIGGERS= $(if $(KCL_TRIGGERS_OUTPUT_FORMAT),--output $(KCL_TRIGGERS_OUTPUT_FORMAT))
__KCL_SELECTOR__TRIGGERS= $(if $(KCL_TRIGGERS_SELECTOR),--selector=$(KCL_TRIGGERS_SELECTOR))
__KCL_SORT_BY__TRIGGERS= $(if $(KCL_TRIGGERS_SORT_BY),--sort-by=$(KCL_TRIGGERS_SORT_BY))

# Pipe parameters
_KCL_APPLY_TRIGGERS_|?= #
_KCL_DIFF_TRIGGERS_|?= $(_KCL_APPLY_TRIGGERS_|)
_KCL_UNAPPLY_TRIGGERS_|?= $(_KCL_APPLY_TRIGGERS_|)
|_KCL_KUSTOMIZE_TRIGGER?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Knative::Trigger ($(_KUBECTL_KNATIVE_TRIGGER_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Knative::Trigger ($(_KUBECTL_KNATIVE_TRIGGER_MK_VERSION)) parameters:'
	@echo '    KCL_TRIGGER_ANNOTATIONS_KEYS=$(KCL_TRIGGER_ANNOTATIONS_KEYS)'
	@echo '    KCL_TRIGGER_ANNOTATIONS_KEYS=$(KCL_TRIGGER_ANNOTATIONS_KEYS)'
	@echo '    KCL_TRIGGER_BROKER_NAME=$(KCL_TRIGGER_BROKER_NAME)'
	@echo '    KCL_TRIGGER_KUSTOMIZATION_DIRPATH=$(KCL_TRIGGER_KUSTOMIZATION_DIRPATH)'
	@echo '    KCL_TRIGGER_LABELS_KEYS=$(KCL_TRIGGER_LABELS_KEYS)'
	@echo '    KCL_TRIGGER_LABELS_KEYVALUES=$(KCL_TRIGGER_LABELS_KEYVALUES)'
	@echo '    KCL_TRIGGER_NAME=$(KCL_TRIGGER_NAME)'
	@echo '    KCL_TRIGGER_NAMESPACE_NAME=$(KCL_TRIGGER_NAMESPACE_NAME)'
	@echo '    KCL_TRIGGER_OUTPUT_FORMAT=$(KCL_TRIGGER_OUTPUT_FORMAT)'
	@echo '    KCL_TRIGGER_SELECTOR=$(KCL_TRIGGER_SELECTOR)'
	@echo '    KCL_TRIGGER_SUBSCRIBER_KIND=$(KCL_TRIGGER_SUBSCRIBER_KIND)'
	@echo '    KCL_TRIGGER_SUBSCRIBER_NAME=$(KCL_TRIGGER_SUBSCRIBER_NAME)'
	@echo '    KCL_TRIGGER_SUBSCRIBER_NAMESPACENAME=$(KCL_TRIGGER_SUBSCRIBER_NAMESPACENAME)'
	@echo '    KCL_TRIGGERS_FIELDSELECTOR=$(KCL_TRIGGERS_FIELDSELECTOR)'
	@echo '    KCL_TRIGGERS_MANIFEST_DIRPATH=$(KCL_TRIGGERS_MANIFEST_DIRPATH)'
	@echo '    KCL_TRIGGERS_MANIFEST_FILENAME=$(KCL_TRIGGERS_MANIFEST_FILENAME)'
	@echo '    KCL_TRIGGERS_MANIFEST_FILEPATH=$(KCL_TRIGGERS_MANIFEST_FILEPATH)'
	@echo '    KCL_TRIGGERS_MANIFEST_STDINFLAG=$(KCL_TRIGGERS_MANIFEST_STDINFLAG)'
	@echo '    KCL_TRIGGERS_MANIFEST_URL=$(KCL_TRIGGERS_MANIFEST_URL)'
	@echo '    KCL_TRIGGERS_MANIFESTS_DIRPATH=$(KCL_TRIGGERS_MANIFESTS_DIRPATH)'
	@echo '    KCL_TRIGGERS_NAMESPACE_NAME=$(KCL_TRIGGERS_NAMESPACE_NAME)'
	@echo '    KCL_TRIGGERS_OUTPUT_FORMAT=$(KCL_TRIGGERS_OUTPUT_FORMAT)'
	@echo '    KCL_TRIGGERS_SELECTOR=$(KCL_TRIGGERS_SELECTOR)'
	@echo '    KCL_TRIGGERS_SET_NAME=$(KCL_TRIGGERS_SET_NAME)'
	@echo '    KCL_TRIGGERS_SORT_BY=$(KCL_TRIGGERS_SORT_BY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Knative::Trigger ($(_KUBECTL_KNATIVE_TRIGGER_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_trigger                - Annotate a trigger'
	@echo '    _kcl_apply_triggers                  - Apply manifest for one-por-more triggers'
	@echo '    _kcl_create_trigger                  - Create a new trigger'
	@echo '    _kcl_delete_trigger                  - Delete an existing trigger'
	@echo '    _kcl_diff_triggers                   - Diff a manifest with one-or-more existing triggers'
	@echo '    _kcl_edit_trigger                    - Edit a trigger'
	@echo '    _kcl_explain_trigger                 - Explain the trigger object'
	@echo '    _kcl_kustomize_trigger               - Kustomize one-or-more triggers'
	@echo '    _kcl_label_trigger                   - Label a trigger'
	@echo '    _kcl_show_trigger                    - Show everything related to a trigger'
	@echo '    _kcl_show_trigger_broker             - Show the broker of a trigger'
	@echo '    _kcl_show_trigger_description        - Show the description of a trigger'
	@echo '    _kcl_show_trigger_object             - Show the object of a trigger'
	@echo '    _kcl_show_trigger_state              - Show state of a trigger'
	@echo '    _kcl_show_trigger_subscriber         - Show subscriber of a trigger'
	@echo '    _kcl_unapply_triggers                - Un-apply manifest for one-or-more triggers'
	@echo '    _kcl_unlabel_trigger                 - Un-label manifest for a trigger'
	@echo '    _kcl_update_trigger                  - Update a trigger'
	@echo '    _kcl_view_triggers                   - View all triggers'
	@echo '    _kcl_view_triggers_set               - View a set of triggers'
	@echo '    _kcl_watch_triggers                  - Watching triggers'
	@echo '    _kcl_watch_triggers_set              - Watching a set of triggers'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_trigger:
	@$(INFO) '$(KCL_UI_LABEL)Annotating trigger "$(KCL_TRIGGER_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate ...

_kcl_apply_trigger: _kcl_apply_triggers
_kcl_apply_triggers:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more triggers ...'; $(NORMAL)
	$(if $(KCL_TRIGGERS_MANIFEST_FILEPATH),cat $(KCL_TRIGGERS_MANIFEST_FILEPATH); echo)
	$(if $(filter true,$(KCL_TRIGGERS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_TRIGGERS_|)cat )
	$(if $(KCL_TRIGGERS_MANIFEST_URL),curl -L $(KCL_TRIGGERS_MANIFEST_URL); echo )
	$(if $(KCL_TRIGGERS_MANIFESTS_DIRPATH),ls -al $(KCL_TRIGGERS_MANIFESTS_DIRPATH); echo)
	$(_KCL_APPLY_TRIGGERS_|)$(KUBECTL) apply $(__KCL_FILENAME__TRIGGERS) $(__KCL_NAMESPACE__TRIGGERS)

_kcl_create_trigger:
	@$(INFO) '$(KCL_UI_LABEL)Creating trigger "$(KCL_TRIGGER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) run $(__KCL_IMAGE__TRIGGER) $(__KCL_EXPOSE__TRIGGER) $(__KCL_LABELS__TRIGGER) $(__KCL_NAMESPACE__TRIGGER) $(__KCL_PORT__TRIGGER) $(__KCL_REPLICAS__TRIGGER) $(__KCL_RESTART__TRIGGER) $(__KCL_SERVICEACCOUNT__TRIGGER) $(KCL_TRIGGER_NAME)

_kcl_delete_trigger:
	@$(INFO) '$(KCL_UI_LABEL)Deleting trigger "$(KCL_TRIGGER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete trigger $(__KCL_NAMESPACE__TRIGGER) $(KCL_TRIGGER_NAME)

_kcl_diff_trigger: _kcl_diff_triggers
_kcl_diff_triggers:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster state with manifest for one-or-more triggers ...'; $(NORMAL)
	# cat $(KCL_TRIGGERS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_TRIGGERS_|)cat
	# curl -L $(KCL_TRIGGERS_MANIFEST_URL)
	# ls -al $(KCL_TRIGGERS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_TRIGGERS_|)$(KUBECTL) diff $(__KCL_FILENAME__TRIGGERS) $(__KCL_NAMESPACE__TRIGGERS)

_kcl_edit_trigger:
	@$(INFO) '$(KCL_UI_LABEL)Editing trigger "$(KCL_TRIGGER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit trigger $(__KCL_NAMESPACE__TRIGGER) $(KCL_TRIGGER_NAME)

_kcl_explain_trigger:
	@$(INFO) '$(KCL_UI_LABEL)Explaining trigger object ...'; $(NORMAL)
	$(KUBECTL) explain trigger

_kcl_kustomize_trigger: _kcl_kustomize_triggers
_kcl_kustomize_triggers:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more triggers ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_TRIGGER_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_TRIGGER)

_kcl_label_trigger:
	@$(INFO) '$(KCL_UI_LABEL)Labeling trigger "$(KCL_TRIGGER_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_show_trigger: _kcl_show_trigger_broker _kcl_show_trigger_object _kcl_show_trigger_state _kcl_show_trigger_subscriber _kcl_show_trigger_description

_kcl_show_trigger_broker:
	@$(INFO) '$(KCL_UI_LABEL)Showing broker of trigger "$(KCL_TRIGGER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The broker and trigger must be in the same namespace'; $(NORMAL)
	$(KUBECTL) get broker $(__KCL_NAMESPACE__TRIGGER) $(KCL_TRIGGER_BROKER_NAME)

_kcl_show_trigger_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description trigger "$(KCL_TRIGGER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe trigger $(__KCL_NAMESPACE__TRIGGER) $(KCL_TRIGGER_NAME)

_kcl_show_trigger_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of trigger "$(KCL_TRIGGER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get trigger $(__KCL_NAMESPACE__TRIGGER) $(_X__KCL_OUTPUT__TRIGGER) --output yaml $(KCL_TRIGGER_NAME)

_kcl_show_trigger_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of trigger "$(KCL_TRIGGER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get trigger $(__KCL_NAMESPACE__TRIGGER) $(KCL_TRIGGER_NAME) 

_kcl_show_trigger_subscriber:
	@$(INFO) '$(KCL_UI_LABEL)Showing subscriber of trigger "$(KCL_TRIGGER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'A subscriber may be in a different namespace than the trigger'; $(NORMAL)
	@$(WARN) 'The same subscriber can also have more than one trigger'; $(NORMAL)
	@$(WARN) 'Supported kind for subscribers are: service, kservice, and ...'; $(NORMAL)
	$(KUBECTL) get $(KCL_TRIGGER_SUBSCRIBER_KIND) --namespace $(KCL_TRIGGER_SUBSCRIBER_NAMESPACENAME) $(KCL_TRIGGER_SUBSCRIBER_NAME) 

_kcl_unapply_trigger: _kcl_unapply_triggers
_kcl_unapply_triggers:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more triggers ...'; $(NORMAL)
	# cat $(KCL_TRIGGERS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_TRIGGERS_|)cat
	# curl -L $(KCL_TRIGGERS_MANIFEST_URL)
	# ls -al $(KCL_TRIGGERS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_TRIGGERS_|)$(KUBECTL) delete $(__KCL_FILENAME__TRIGGERS) $(__KCL_NAMESPACE__TRIGGERS)

_kcl_unlabel_trigger:
	@$(INFO) '$(KCL_UI_LABEL)Removing labels from trigger "$(KCL_TRIGGER_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_update_trigger:
	@$(INFO) '$(KCL_UI_LABEL)Updating trigger "$(KCL_TRIGGER_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) patch ...

_kcl_view_triggers:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL triggers ...'; $(NORMAL)
	$(KUBECTL) get triggers --all-namespaces=true $(_X__KCL_NAMESPACE__TRIGGERS) $(__KCL_OUTPUT_TRIGGERS) $(_X__KCL_SELECTOR__TRIGGERS) $(__KCL_SORT_BY__TRIGGERS)

_kcl_view_triggers_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing triggers-set "$(KCL_TRIGGERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Triggers are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get triggers --all-namespaces=false $(__KCL_NAMESPACE__TRIGGERS) $(__KCL_OUTPUT__TRIGGERS) $(__KCL_SELECTOR__TRIGGERS) $(__KCL_SORT_BY__TRIGGERS)

_kcl_watch_triggers:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL triggers ...'; $(NORMAL)
	$(KUBECTL) get triggers --all-namespaces=true --watch 

_kcl_watch_triggers_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching triggers-set "$(KCL_TRIGGERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Triggers are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
