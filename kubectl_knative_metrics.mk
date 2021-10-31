_KUBECTL_KNATIVE_METRIC_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# KCL_METRIC_KUSTOMIZATION_DIRPATH?= ./in/
# KCL_METRIC_NAME?= go-helloworld-00001
# KCL_METRIC_NAMESPACE_NAME?= default
# KCL_METRIC_REVISION_NAME?= go-helloworld-00001
# KCL_METRICS_FIELDSELECTOR?= metadata.name=my-metric
# KCL_METRICS_MANIFEST_DIRPATH?= ./in/
# KCL_METRICS_MANIFEST_FILENAME?= manifest.yaml
# KCL_METRICS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_METRICS_MANIFEST_STDINFLAG?= false
# KCL_METRICS_MANIFEST_URL?= http://...
# KCL_METRICS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_METRICS_NAMESPACE_NAME?= default
# KCL_METRICS_OUTPUT?= wide
# KCL_METRICS_SELECTOR?=
# KCL_METRICS_SET_NAME?= my-set
# KCL_METRICS_SHOW_LABELS?= true
# KCL_METRICS_WATCH_ONLY?= true

# Derived parameters
KCL_METRIC_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_METRIC_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_METRIC_REVISION_NAME?= $(KCL_METRIC_NAME)
KCL_METRICS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_METRICS_MANIFEST_FILEPATH?= $(if $(KCL_METRICS_MANIFEST_FILENAME),$(KCL_METRICS_MANIFEST_DIRPATH)$(KCL_METRICS_MANIFEST_FILENAME))
KCL_METRICS_NAMESPACE_NAME?= $(KCL_METRIC_NAMESPACE_NAME)
KCL_METRICS_SET_NAME?= metrics@$(KCL_METRICS_FIELDSELECTOR)@$(KCL_METRICS_SELECTOR)@$(KCL_METRICS_NAMESPACE_NAME)

# Option parameters
__KCL_ALL_NAMESPACES__METRICS=
__KCL_FIELD_SELECTOR__METRICS= $(if $(KCL_METRICS_FIELDSELECTOR),--field-selector $(KCL_METRICS_FIELDSELECTOR))
__KCL_FILENAME__METRICS+= $(if $(KCL_METRICS_MANIFEST_FILEPATH),--filename $(KCL_METRICS_MANIFEST_FILEPATH))
__KCL_FILENAME__METRICS+= $(if $(filter true,$(KCL_METRICS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__METRICS+= $(if $(KCL_METRICS_MANIFEST_URL),--filename $(KCL_METRICS_MANIFEST_URL))
__KCL_FILENAME__METRICS+= $(if $(KCL_METRICS_MANIFESTS_DIRPATH),--filename $(KCL_METRICS_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__METRIC= $(if $(KCL_METRIC_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_METRIC_KUSTOMIZATION_DIRPATH))
__KCL_NAMESPACE__METRIC= $(if $(KCL_METRIC_NAMESPACE_NAME),--namespace $(KCL_METRIC_NAMESPACE_NAME))
__KCL_NAMESPACE__METRICS= $(if $(KCL_METRICS_NAMESPACE_NAME),--namespace $(KCL_METRICS_NAMESPACE_NAME))
__KCL_OUTPUT__METRICS= $(if $(KCL_METRICS_OUTPUT),--output $(KCL_METRICS_OUTPUT))
__KCL_SELECTOR__METRICS= $(if $(KCL_METRICS_SELECTOR),--selector=$(KCL_METRICS_SELECTOR))
__KCL_SHOW_LABELS__METRIC= $(if $(filter true, $(KCL_METRIC_SHOW_LABELS)),--show-labels)
__KCL_WATCH_ONLY__METRICS= $(if $(KCL_METRICS_WATCH_ONLY),--watch-only=$(KCL_METRICS_WATCH_ONLY))

# Pipe parameters
|_KCL_KUSTOMIZE_METRIC?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Knative::Metric ($(_KUBECTL_KNATIVE_METRIC_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Knative::Metric ($(_KUBECTL_KNATIVE_METRIC_MK_VERSION)) parameters:'
	@echo '    KCL_METRIC_NAME=$(KCL_METRIC_NAME)'
	@echo '    KCL_METRIC_NAMESPACE_NAME=$(KCL_METRIC_NAMESPACE_NAME)'
	@echo '    KCL_METRIC_REVISION_NAME=$(KCL_METRIC_REVISION_NAME)'
	@echo '    KCL_METRICS_FIELDSELECTOR=$(KCL_METRICS_FIELDSELECTOR)'
	@echo '    KCL_METRICS_MANIFEST_DIRPATH=$(KCL_METRICS_MANIFEST_DIRPATH)'
	@echo '    KCL_METRICS_MANIFEST_FILENAME=$(KCL_METRICS_MANIFEST_FILENAME)'
	@echo '    KCL_METRICS_MANIFEST_FILEPATH=$(KCL_METRICS_MANIFEST_FILEPATH)'
	@echo '    KCL_METRICS_MANIFEST_STDINFLAG=$(KCL_METRICS_MANIFEST_STDINFLAG)'
	@echo '    KCL_METRICS_MANIFEST_URL=$(KCL_METRICS_MANIFEST_URL)'
	@echo '    KCL_METRICS_MANIFESTS_DIRPATH=$(KCL_METRICS_MANIFESTS_DIRPATH)'
	@echo '    KCL_METRICS_NAMESPACE_NAME=$(KCL_METRICS_NAMESPACE_NAME)'
	@echo '    KCL_METRICS_OUTPUT=$(KCL_METRICS_OUTPUT)'
	@echo '    KCL_METRICS_SELECTOR=$(KCL_METRICS_SELECTOR)'
	@echo '    KCL_METRICS_SET_NAME=$(KCL_METRICS_SET_NAME)'
	@echo '    KCL_METRICS_SHOW_LABELS=$(KCL_METRICS_SHOW_LABELS)'
	@echo '    KCL_METRICS_WATCH_ONLY=$(KCL_METRICS_WATCH_ONLY)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Knative::Metric ($(_KUBECTL_KNATIVE_METRIC_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_metric                 - Annotate a metric'
	@echo '    _kcl_apply_metrics                   - Apply manifest for one-or-more metrics'
	@echo '    _kcl_create_metric                   - Create a new metric'
	@echo '    _kcl_delete_metric                   - Delete an existing metric'
	@echo '    _kcl_diff_metric                     - Diff manifest for one-or-more metrics'
	@echo '    _kcl_edit_metric                     - Edit a metric'
	@echo '    _kcl_explain_metric                  - Explain the metric object'
	@echo '    _kcl_kustomize_metric                - Kustomize one-or-more metrics'
	@echo '    _kcl_label_metric                    - Label a metric'
	@echo '    _kcl_list_metrics                    - List all metrics'
	@echo '    _kcl_list_metrics_set                - List a set of metrics'
	@echo '    _kcl_show_metric                     - Show everything related to a metric'
	@echo '    _kcl_show_metric_description         - Show the description of a metric'
	@echo '    _kcl_show_metric_object              - Show the object of a metric'
	@echo '    _kcl_show_metric_revision            - Show the revision of a metric'
	@echo '    _kcl_unapply_metrics                 - Unapply manifest for one-or-more metrics'
	@echo '    _kcl_update_metric                   - Update a metric'
	@echo '    _kcl_watch_metrics                   - Watch metrics'
	@echo '    _kcl_watch_metrics_set               - Watch a set of metrics'
	@echo '    _kcl_write_metrics                   - Write a manifest for one-or-more metrics'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_metric:
	@$(INFO) '$(KCL_UI_LABEL)Annotating metric "$(KCL_METRIC_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate ...

_kcl_apply_metric: _kcl_apply_metrics
_kcl_apply_metrics:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more metrics ...'; $(NORMAL)
	$(if $(KCL_METRICS_MANIFEST_FILEPATH),cat $(KCL_METRICS_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_METRICS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_METRICS_|)cat)
	$(if $(KCL_METRICS_MANIFEST_URL),curl -L $(KCL_METRICS_MANIFEST_URL))
	$(if $(KCL_METRICS_MANIFESTS_DIRPATH),ls -al $(KCL_METRICS_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_METRICS_|)$(KUBECTL) apply $(__KCL_FILENAME__METRICS) $(__KCL_NAMESPACE__METRICS)

_kcl_create_metric:
	@$(INFO) '$(KCL_UI_LABEL)Creating metric "$(KCL_METRIC_NAME)" ...'; $(NORMAL)

_kcl_delete_metric:
	@$(INFO) '$(KCL_UI_LABEL)Deleting metric "$(KCL_METRIC_NAME)" ...'; $(NORMAL)

_kcl_diff_metric: _kcl_diff_metrics
_kcl_diff_metrics:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more metrics ...'; $(NORMAL)
	# cat $(KCL_METRICS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_METRICS_|)cat
	# curl -L $(KCL_METRICS_MANIFEST_URL)
	# ls -al $(KCL_METRICS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_METRICS_|)$(KUBECTL) diff $(__KCL_FILENAME__METRICS) $(__KCL_NAMESPACE__METRICS)

_kcl_edit_metric:
	@$(INFO) '$(KCL_UI_LABEL)Editing metric "$(KCL_METRIC_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit metric $(__KCL_NAMESPACE__METRIC) $(KCL_METRIC_NAME)

_kcl_explain_metric:
	@$(INFO) '$(KCL_UI_LABEL)Explaining metric object ...'; $(NORMAL)
	$(KUBECTL) explain metric

_kcl_kustomize_metric: _kcl_kustomize_metrics
_kcl_kustomize_metrics:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more metrics ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_METRIC_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_METRIC)

_kcl_label_metric:
	@$(INFO) '$(KCL_UI_LABEL)Labeling metric "$(KCL_METRIC_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_list_metrics:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL metrics ...'; $(NORMAL)
	$(KUBECTL) get metrics --all-namespaces=true $(_X__KCL_NAMESPACE__METRICS) $(__KCL_OUTPUT__METRICS) $(_X__KCL_SELECTOR__METRICS)$(__KCL_SHOW_LABELS__METRICS)

_kcl_list_metrics_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing metrics-set "$(KCL_METRICS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Metrics are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get metrics --all-namespaces=false $(__KCL_FIELD_SELECTOR__METRICS) $(__KCL_NAMESPACE__METRICS) $(__KCL_OUTPUT__METRICS) $(__KCL_SELECTOR__METRICS) $(__KCL_SHOW_LABELS__METRICS)

_KCL_SHOW_METRIC_TARGETS?= _kcl_show_metric_object _kcl_show_metric_state _kcl_show_metric_description
_kcl_show_metric: $(_KCL_SHOW_METRIC_TARGETS)

_kcl_show_metric_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description metric "$(KCL_METRIC_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this service is accessible at $(KCL_METRIC_NAME).$(KCL_METRIC_NAMESPACE_NAME).svc.cluster.local'; $(NORMAL)
	$(KUBECTL) describe metric $(__KCL_NAMESPACE__METRIC) $(KCL_METRIC_NAME)

_kcl_show_metric_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of metric "$(KCL_METRIC_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get metric $(__KCL_NAMESPACE__METRIC) --output yaml $(KCL_METRIC_NAME) 

_kcl_unapply_metric: _kcl_unapply_metrics
_kcl_unapply_metrics:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more metrics ...'; $(NORMAL)
	# cat $(KCL_METRICS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_METRICS_|)cat
	# curl -L $(KCL_METRICS_MANIFEST_FILEPATH)
	# curl -L $(KCL_METRICS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_METRICS_|)$(KUBECTL) delete $(__KCL_FILENAME__METRICS) $(__KCL_NAMESPACE__METRICS)

_kcl_unlabel_metric:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for metric "$(KCL_METRIC_NAME)" ...'; $(NORMAL)

_kcl_update_metric:
	@$(INFO) '$(KCL_UI_LABEL)Updating metric "$(KCL_METRIC_NAME)" ...'; $(NORMAL)

_kcl_watch__metrics:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL metrics ...'; $(NORMAL)
	$(KUBECTL) get metrics $(strip $(_X__KCL_ALL_NAMESPACES__METRICS) --all-namespaces=true $(_X__KCL_NAMESPACE__METRICS) $(__KCL_OUTPUT__METRICS) $(_X__KCL_SELECTOR__METRICS) $(_X__KCL_WATCH__METRICS) --watch=true $(__KCL_WATCH_ONLY__METRICS) )

_kcl_watch_metrics_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching metrics-set "$(KCL_METRICS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Metrics are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get metrics $(strip $(__KCL_ALL_NAMESPACES__METRICS) $(__KCL_NAMESPACE__METRICS) $(__KCL_OUTPUT__METRICS) $(__KCL_SELECTOR__METRICS) $(_X__KCL_WATCH__METRICS) --watch=true $(__KCL_WATCH_ONLY__METRICS) )

_kcl_write_metric: _kcl_write_metrics
_kcl_write_metrics:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more metrics ...'; $(NORMAL)
	$(WRITER) $(KCL_METRICS_MANIFEST_FILEPATH)
