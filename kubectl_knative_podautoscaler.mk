_KUBECTL_KNATIVE_PODAUTOSCALER_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# KCL_PODAUTOSCALER_KUSTOMIZATION_DIRPATH?= ./in/
# KCL_PODAUTOSCALER_NAME?= go-helloworld-00001
# KCL_PODAUTOSCALER_NAMESPACE_NAME?= default
# KCL_PODAUTOSCALER_REVISION_NAME?= go-helloworld-00001
# KCL_PODAUTOSCALERS_FIELDSELECTOR?= metadata.name=my-pod-autoscaler
# KCL_PODAUTOSCALERS_MANIFEST_DIRPATH?= ./in/
# KCL_PODAUTOSCALERS_MANIFEST_FILENAME?= manifest.yaml
# KCL_PODAUTOSCALERS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_PODAUTOSCALERS_MANIFEST_STDINFLAG?= false
# KCL_PODAUTOSCALERS_MANIFEST_URL?= http://...
# KCL_PODAUTOSCALERS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_PODAUTOSCALERS_NAMESPACE_NAME?= default
# KCL_PODAUTOSCALERS_OUTPUT?= wide
# KCL_PODAUTOSCALERS_SELECTOR?=
# KCL_PODAUTOSCALERS_SET_NAME?= my-set
# KCL_PODAUTOSCALERS_SHOW_LABELS?= true
# KCL_PODAUTOSCALERS_WATCH_ONLY?= true

# Derived parameters
KCL_PODAUTOSCALER_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_PODAUTOSCALER_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_PODAUTOSCALER_REVISION_NAME?= $(KCL_PODAUTOSCALER_NAME)
KCL_PODAUTOSCALERS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_PODAUTOSCALERS_MANIFEST_FILEPATH?= $(if $(KCL_PODAUTOSCALERS_MANIFEST_FILENAME),$(KCL_PODAUTOSCALERS_MANIFEST_DIRPATH)$(KCL_PODAUTOSCALERS_MANIFEST_FILENAME))
KCL_PODAUTOSCALERS_NAMESPACE_NAME?= $(KCL_PODAUTOSCALER_NAMESPACE_NAME)
KCL_PODAUTOSCALERS_SET_NAME?= pod-autoscalers@$(KCL_PODAUTOSCALERS_FIELDSELECTOR)@$(KCL_PODAUTOSCALERS_SELECTOR)@$(KCL_PODAUTOSCALERS_NAMESPACE_NAME)

# Option parameters
__KCL_ALL_NAMESPACES__PODAUTOSCALERS=
__KCL_FIELD_SELECTOR__PODAUTOSCALERS= $(if $(KCL_PODAUTOSCALERS_FIELDSELECTOR),--field-selector $(KCL_PODAUTOSCALERS_FIELDSELECTOR))
__KCL_FILENAME__PODAUTOSCALERS+= $(if $(KCL_PODAUTOSCALERS_MANIFEST_FILEPATH),--filename $(KCL_PODAUTOSCALERS_MANIFEST_FILEPATH))
__KCL_FILENAME__PODAUTOSCALERS+= $(if $(filter true,$(KCL_PODAUTOSCALERS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__PODAUTOSCALERS+= $(if $(KCL_PODAUTOSCALERS_MANIFEST_URL),--filename $(KCL_PODAUTOSCALERS_MANIFEST_URL))
__KCL_FILENAME__PODAUTOSCALERS+= $(if $(KCL_PODAUTOSCALERS_MANIFESTS_DIRPATH),--filename $(KCL_PODAUTOSCALERS_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__PODAUTOSCALER= $(if $(KCL_PODAUTOSCALER_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_PODAUTOSCALER_KUSTOMIZATION_DIRPATH))
__KCL_NAMESPACE__PODAUTOSCALER= $(if $(KCL_PODAUTOSCALER_NAMESPACE_NAME),--namespace $(KCL_PODAUTOSCALER_NAMESPACE_NAME))
__KCL_NAMESPACE__PODAUTOSCALERS= $(if $(KCL_PODAUTOSCALERS_NAMESPACE_NAME),--namespace $(KCL_PODAUTOSCALERS_NAMESPACE_NAME))
__KCL_OUTPUT__PODAUTOSCALERS= $(if $(KCL_PODAUTOSCALERS_OUTPUT),--output $(KCL_PODAUTOSCALERS_OUTPUT))
__KCL_SELECTOR__PODAUTOSCALERS= $(if $(KCL_PODAUTOSCALERS_SELECTOR),--selector=$(KCL_PODAUTOSCALERS_SELECTOR))
__KCL_SHOW_LABELS__PODAUTOSCALER= $(if $(filter true, $(KCL_PODAUTOSCALER_SHOW_LABELS)),--show-labels)
__KCL_WATCH_ONLY__PODAUTOSCALERS= $(if $(KCL_PODAUTOSCALERS_WATCH_ONLY),--watch-only=$(KCL_PODAUTOSCALERS_WATCH_ONLY))

# Pipe parameters
|_KCL_KUSTOMIZE_PODAUTOSCALER?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Knative::PodAutoscaler ($(_KUBECTL_KNATIVE_PODAUTOSCALER_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Knative::PodAutoscaler ($(_KUBECTL_KNATIVE_PODAUTOSCALER_MK_VERSION)) parameters:'
	@echo '    KCL_PODAUTOSCALER_NAME=$(KCL_PODAUTOSCALER_NAME)'
	@echo '    KCL_PODAUTOSCALER_NAMESPACE_NAME=$(KCL_PODAUTOSCALER_NAMESPACE_NAME)'
	@echo '    KCL_PODAUTOSCALER_REVISION_NAME=$(KCL_PODAUTOSCALER_REVISION_NAME)'
	@echo '    KCL_PODAUTOSCALERS_FIELDSELECTOR=$(KCL_PODAUTOSCALERS_FIELDSELECTOR)'
	@echo '    KCL_PODAUTOSCALERS_MANIFEST_DIRPATH=$(KCL_PODAUTOSCALERS_MANIFEST_DIRPATH)'
	@echo '    KCL_PODAUTOSCALERS_MANIFEST_FILENAME=$(KCL_PODAUTOSCALERS_MANIFEST_FILENAME)'
	@echo '    KCL_PODAUTOSCALERS_MANIFEST_FILEPATH=$(KCL_PODAUTOSCALERS_MANIFEST_FILEPATH)'
	@echo '    KCL_PODAUTOSCALERS_MANIFEST_STDINFLAG=$(KCL_PODAUTOSCALERS_MANIFEST_STDINFLAG)'
	@echo '    KCL_PODAUTOSCALERS_MANIFEST_URL=$(KCL_PODAUTOSCALERS_MANIFEST_URL)'
	@echo '    KCL_PODAUTOSCALERS_MANIFESTS_DIRPATH=$(KCL_PODAUTOSCALERS_MANIFESTS_DIRPATH)'
	@echo '    KCL_PODAUTOSCALERS_NAMESPACE_NAME=$(KCL_PODAUTOSCALERS_NAMESPACE_NAME)'
	@echo '    KCL_PODAUTOSCALERS_OUTPUT=$(KCL_PODAUTOSCALERS_OUTPUT)'
	@echo '    KCL_PODAUTOSCALERS_SELECTOR=$(KCL_PODAUTOSCALERS_SELECTOR)'
	@echo '    KCL_PODAUTOSCALERS_SET_NAME=$(KCL_PODAUTOSCALERS_SET_NAME)'
	@echo '    KCL_PODAUTOSCALERS_SHOW_LABELS=$(KCL_PODAUTOSCALERS_SHOW_LABELS)'
	@echo '    KCL_PODAUTOSCALERS_WATCH_ONLY=$(KCL_PODAUTOSCALERS_WATCH_ONLY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Knative::PodAutoscaler ($(_KUBECTL_KNATIVE_PODAUTOSCALER_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_podautoscaler                 - Annotate a pod-autoscaler'
	@echo '    _kcl_apply_podautoscalers                   - Apply manifest for one-or-more pod-autoscalers'
	@echo '    _kcl_create_podautoscaler                   - Create a new pod-autoscaler'
	@echo '    _kcl_delete_podautoscaler                   - Delete an existing pod-autoscaler'
	@echo '    _kcl_diff_podautoscaler                     - Diff manifest for one-or-more pod-autoscalers'
	@echo '    _kcl_edit_podautoscaler                     - Edit a pod-autoscaler'
	@echo '    _kcl_explain_podautoscaler                  - Explain the pod-autoscaler object'
	@echo '    _kcl_kustomize_podautoscaler                - Kustomize one-or-more pod-autoscalers'
	@echo '    _kcl_label_podautoscaler                    - Label a pod-autoscaler'
	@echo '    _kcl_show_podautoscaler                     - Show everything related to a pod-autoscaler'
	@echo '    _kcl_show_podautoscaler_description         - Show the description of a pod-autoscaler'
	@echo '    _kcl_show_podautoscaler_object              - Show the object of a pod-autoscaler'
	@echo '    _kcl_show_podautoscaler_revision            - Show the revision of a pod-autoscaler'
	@echo '    _kcl_unapply_podautoscalers                 - Unapply amnifest for one-or-more pod-autoscalers'
	@echo '    _kcl_update_podautoscaler                   - Update a pod-autoscaler'
	@echo '    _kcl_view_podautoscalers                    - View all pod-autoscalers'
	@echo '    _kcl_view_podautoscalers_set                - View a set of pod-autoscalers'
	@echo '    _kcl_watch_podautoscalers                   - Watch pod-autoscalers'
	@echo '    _kcl_watch_podautoscalers_set               - Watch a set of pod-autoscalers'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_podautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Annotating pod-autoscaler "$(KCL_PODAUTOSCALER_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate ...

_kcl_apply_podautoscaler: _kcl_apply_podautoscalers
_kcl_apply_podautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more pod-autoscalers ...'; $(NORMAL)
	$(if $(KCL_PODAUTOSCALERS_MANIFEST_FILEPATH),cat $(KCL_PODAUTOSCALERS_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_PODAUTOSCALERS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_PODAUTOSCALERS_|)cat)
	$(if $(KCL_PODAUTOSCALERS_MANIFEST_URL),curl -L $(KCL_PODAUTOSCALERS_MANIFEST_URL))
	$(if $(KCL_PODAUTOSCALERS_MANIFESTS_DIRPATH),ls -al $(KCL_PODAUTOSCALERS_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_PODAUTOSCALERS_|)$(KUBECTL) apply $(__KCL_FILENAME__PODAUTOSCALERS) $(__KCL_NAMESPACE__PODAUTOSCALERS)

_kcl_create_podautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Creating pod-autoscaler "$(KCL_PODAUTOSCALER_NAME)" ...'; $(NORMAL)

_kcl_delete_podautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Deleting pod-autoscaler "$(KCL_PODAUTOSCALER_NAME)" ...'; $(NORMAL)

_kcl_diff_podautoscaler: _kcl_diff_podautoscalers
_kcl_diff_podautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more pod-autoscalers ...'; $(NORMAL)
	# cat $(KCL_PODAUTOSCALERS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_PODAUTOSCALERS_|)cat
	# curl -L $(KCL_PODAUTOSCALERS_MANIFEST_URL)
	# ls -al $(KCL_PODAUTOSCALERS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_PODAUTOSCALERS_|)$(KUBECTL) diff $(__KCL_FILENAME__PODAUTOSCALERS) $(__KCL_NAMESPACE__PODAUTOSCALERS)

_kcl_edit_podautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Editing pod-autoscaler "$(KCL_PODAUTOSCALER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit podautoscaler $(__KCL_NAMESPACE__PODAUTOSCALER) $(KCL_PODAUTOSCALER_NAME)

_kcl_explain_podautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Explaining pod-autoscaler object ...'; $(NORMAL)
	$(KUBECTL) explain podautoscaler

_kcl_kustomize_podautoscaler: _kcl_kustomize_podautoscalers
_kcl_kustomize_podautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more pod-autoscalers ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_PODAUTOSCALER_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_PODAUTOSCALER)

_kcl_label_podautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Labeling pod-autoscaler "$(KCL_PODAUTOSCALER_NAME)" ...'; $(NORMAL)

_KCL_SHOW_PODAUTOSCALER_TARGETS?= _kcl_show_podautoscaler_object _kcl_show_podautoscaler_state _kcl_show_podautoscaler_description
_kcl_show_podautoscaler :: $(_KCL_SHOW_PODAUTOSCALER_TARGETS)

_kcl_show_podautoscaler_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing the description fo pod-autoscaler "$(KCL_PODAUTOSCALER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this service is accessible at $(KCL_PODAUTOSCALER_NAME).$(KCL_PODAUTOSCALER_NAMESPACE_NAME).svc.cluster.local'; $(NORMAL)
	$(KUBECTL) describe podautoscaler $(__KCL_NAMESPACE__PODAUTOSCALER) $(KCL_PODAUTOSCALER_NAME)

_kcl_show_podautoscaler_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing the object of the pod-autoscaler "$(KCL_PODAUTOSCALER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get podautoscaler $(__KCL_NAMESPACE__PODAUTOSCALER) --output yaml $(KCL_PODAUTOSCALER_NAME) 

_kcl_unapply_podautoscaler: _kcl_unapply_podautoscalers
_kcl_unapply_podautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more pod-autoscalers ...'; $(NORMAL)
	# cat $(KCL_PODAUTOSCALERS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_PODAUTOSCALERS_|)cat
	# curl -L $(KCL_PODAUTOSCALERS_MANIFEST_FILEPATH)
	# curl -L $(KCL_PODAUTOSCALERS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_PODAUTOSCALERS_|)$(KUBECTL) delete $(__KCL_FILENAME__PODAUTOSCALERS) $(__KCL_NAMESPACE__PODAUTOSCALERS)

_kcl_unlabel_podautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for pod-autoscaler "$(KCL_PODAUTOSCALER_NAME)" ...'; $(NORMAL)

_kcl_update_podautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Updating pod-autoscaler "$(KCL_PODAUTOSCALER_NAME)" ...'; $(NORMAL)

_kcl_view_podautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL pod-autoscalers ...'; $(NORMAL)
	$(KUBECTL) get podautoscalers --all-namespaces=true $(_X__KCL_NAMESPACE__PODAUTOSCALERS) $(__KCL_OUTPUT__PODAUTOSCALERS) $(_X__KCL_SELECTOR__PODAUTOSCALERS)$(__KCL_SHOW_LABELS__PODAUTOSCALERS)

_kcl_view_podautoscalers_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing pod-autoscalers-set "$(KCL_PODAUTOSCALERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Pod-autoscalers are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get podautoscalers --all-namespaces=false $(__KCL_FIELD_SELECTOR__PODAUTOSCALERS) $(__KCL_NAMESPACE__PODAUTOSCALERS) $(__KCL_OUTPUT__PODAUTOSCALERS) $(__KCL_SELECTOR__PODAUTOSCALERS) $(__KCL_SHOW_LABELS__PODAUTOSCALERS)

_kcl_watch__podautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL pod-autoscalers ...'; $(NORMAL)
	$(KUBECTL) get podautoscalers $(strip $(_X__KCL_ALL_NAMESPACES__PODAUTOSCALERS) --all-namespaces=true $(_X__KCL_NAMESPACE__PODAUTOSCALERS) $(__KCL_OUTPUT__PODAUTOSCALERS) $(_X__KCL_SELECTOR__PODAUTOSCALERS) $(_X__KCL_WATCH__PODAUTOSCALERS) --watch=true $(__KCL_WATCH_ONLY__PODAUTOSCALERS) )

_kcl_watch_podautoscalers_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching pod-autoscalers-set "$(KCL_PODAUTOSCALERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Pod-autoscalers are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get podautoscalers $(strip $(__KCL_ALL_NAMESPACES__PODAUTOSCALERS) $(__KCL_NAMESPACE__PODAUTOSCALERS) $(__KCL_OUTPUT__PODAUTOSCALERS) $(__KCL_SELECTOR__PODAUTOSCALERS) $(_X__KCL_WATCH__PODAUTOSCALERS) --watch=true $(__KCL_WATCH_ONLY__PODAUTOSCALERS) )
