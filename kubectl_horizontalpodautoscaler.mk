_KUBECTL_HORIZONTALPODAUTOSCALER_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_HORIZONTALPODAUTOSCALER_DEPLOYMENT_NAME?= my-deployment
# KCL_HORIZONTALPODAUTOSCALER_NAME?= hello
# KCL_HORIZONTALPODAUTOSCALER_NAMESPACE_NAME?= default
# KCL_HORIZONTALPODAUTOSCALER_REPLICASETS_FILEDSELECTOR?= metadata.name=toto
# KCL_HORIZONTALPODAUTOSCALER_REPLICASETS_NAMES?=
# KCL_HORIZONTALPODAUTOSCALER_REPLICASETS_SELECTOR?= app=vault
# KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_DIRPATH?= ./in/
# KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILENAME?= manifest.yaml
# KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_STDINFLAG?= false
# KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_URL?= http://...
# KCL_HORIZONTALPODAUTOSCALERS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_HORIZONTALPODAUTOSCALERS_NAMESPACE_NAME?= default
# KCL_HORIZONTALPODAUTOSCALERS_SELECTOR?=
# KCL_HORIZONTALPODAUTOSCALERS_SET_NAME?= my-horizontal-pod-autoscalers-set

# Derived parameters
KCL_HORIZONTALPODAUTOSCALER_DEPLOYMENT_NAME?= $(KCL_DEPLOYMENT_NAME)
KCL_HORIZONTALPODAUTOSCALER_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILEPATH?= $(if $(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILENAME),$(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_DIRPATH)$(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILENAME))
KCL_HORIZONTALPODAUTOSCALERS_NAMESPACE_NAME?= $(KCL_HORIZONTALPODAUTOSCALER_NAMESPACE_NAME)
KCL_HORIZONTALPODAUTOSCALERS_SET_NAME?= $(KCL_HORIZONTALPODAUTOSCALERS_NAMESPACE_NAME)

# Options
__KCL_FILENAME__HORIZONTALPODAUTOSCALERS= $(if $(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILEPATH),--filename $(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILEPATH))
__KCL_FILENAME__HORIZONTALPODAUTOSCALERS= $(if $(filter true,$(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__HORIZONTALPODAUTOSCALERS= $(if $(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_URL),--filename $(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_URL))
__KCL_FILENAME__HORIZONTALPODAUTOSCALERS= $(if $(KCL_HORIZONTALPODAUTOSCALERS_MANIFESTS_DIRPATH),--filename $(KCL_HORIZONTALPODAUTOSCALERS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__HORIZONTALPODAUTOSCALER= $(if $(KCL_HORIZONTALPODAUTOSCALER_NAMESPACE_NAME),--namespace $(KCL_HORIZONTALPODAUTOSCALER_NAMESPACE_NAME))
__KCL_NAMESPACE__HORIZONTALPODAUTOSCALERS= $(if $(KCL_HORIZONTALPODAUTOSCALERS_NAMESPACE_NAME),--namespace $(KCL_HORIZONTALPODAUTOSCALERS_NAMESPACE_NAME))
__KCL_SELECTOR__HORIZONTALPODAUTOSCALERS= $(if $(KCL_HORIZONTALPODAUTOSCALERS_SELECTOR),--selector=$(KCL_HORIZONTALPODAUTOSCALERS_SELECTOR))

# Customizations
_KCL_APPLY_HORIZONTALPODAUTOSCALERS_|?= #
_KCL_DIFF_HORIZONTALPODAUTOSCALERS_|?= $(_KCL_APPLY_HORIZONTALPODAUTOSCALERS_|)
_KCL_UNAPPLY_HORIZONTALPODAUTOSCALERS_|?= $(_KCL_APPLY_HORIZONTALPODAUTOSCALERS_|)

# Macros
_kcl_get_horizontalpodautoscaler_replicasets_names= $(call _kcl_get_horizontalpodautoscaler_replicasets_names_S, $(KCL_HORIZONTALPODAUTOSCALER_REPLICASETS_SELECTOR))
_kcl_get_horizontalpodautoscaler_replicasets_names_S= $(call _kcl_get_horizontalpodautoscaler_replicasets_names_SN, $(1), $(KCL_HORIZONTALPODAUTOSCALER_NAMESPACE_NAME))
_kcl_get_horizontalpodautoscaler_replicasets_names_SN= $(shell $(KUBECTL) get replicaset --namespace $(2) --selector $(1) --output jsonpath="{.items[*].metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::HorizontalPodAutoscaler ($(_KUBECTL_HORIZONTALPODAUTOSCALER_MK_VERSION)) macros:'
	@echo '    _kcl_get_horizontalpodautoscaler_replicasets_names_{|S|SN} - Get replica-sets modified by the horizontal-pod-auto (Selector,Namespace)'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::HorizontalPodAutoscaler ($(_KUBECTL_HORIZONTALPODAUTOSCALER_MK_VERSION)) parameters:'
	@echo '    KCL_HORIZONTALPODAUTOSCALER_DEPLOYMENT_NAME=$(KCL_HORIZONTALPODAUTOSCALER_DEPLOYMENT_NAME)'
	@echo '    KCL_HORIZONTALPODAUTOSCALER_NAME=$(KCL_HORIZONTALPODAUTOSCALER_NAME)'
	@echo '    KCL_HORIZONTALPODAUTOSCALER_NAMESPACE_NAME=$(KCL_HORIZONTALPODAUTOSCALER_NAMESPACE_NAME)'
	@echo '    KCL_HORIZONTALPODAUTOSCALER_REPLICASETS_FIELDSELECTOR=$(KCL_HORIZONTALPODAUTOSCALER_REPLICASETS_FIELDSELECTOR)'
	@echo '    KCL_HORIZONTALPODAUTOSCALER_REPLICASETS_NAMES=$(KCL_HORIZONTALPODAUTOSCALER_REPLICASETS_NAMES)'
	@echo '    KCL_HORIZONTALPODAUTOSCALER_REPLICASETS_SELECTOR=$(KCL_HORIZONTALPODAUTOSCALER_REPLICASETS_SELECTOR)'
	@echo '    KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_DIRPATH=$(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_DIRPATH)'
	@echo '    KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILENAME=$(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILENAME)'
	@echo '    KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILEPATH=$(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILEPATH)'
	@echo '    KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_STDINFLAG=$(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_STDINFLAG)'
	@echo '    KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_URL=$(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_URL)'
	@echo '    KCL_HORIZONTALPODAUTOSCALERS_MANIFESTS_DIRPATH=$(KCL_HORIZONTALPODAUTOSCALERS_MANIFESTS_DIRPATH)'
	@echo '    KCL_HORIZONTALPODAUTOSCALERS_NAMESPACE_NAME=$(KCL_HORIZONTALPODAUTOSCALERS_NAMESPACE_NAME)'
	@echo '    KCL_HORIZONTALPODAUTOSCALERS_SELECTOR=$(KCL_HORIZONTALPODAUTOSCALERS_SELECTOR)'
	@echo '    KCL_HORIZONTALPODAUTOSCALERS_SET_NAME=$(KCL_HORIZONTALPODAUTOSCALERS_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::HorizontalPodAutoscaler ($(_KUBECTL_HORIZONTALPODAUTOSCALER_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_horizontalpodautoscaler                - Annotate a horizontal-pod-autoscaler'
	@echo '    _kcl_apply_horizontalpodautoscalers                  - Apply manifest for one-or-more horizontal-pod-autoscalers'
	@echo '    _kcl_create_horizontalpodautoscaler                  - Create a new horizontal-pod-autoscaler'
	@echo '    _kcl_delete_horizontalpodautoscaler                  - Delete an existing horizontal-pod-autoscaler'
	@echo '    _kcl_diff_horizontalpodautoscalers                   - Diff manifest for one-or-more horizontal-pod-autoscalers'
	@echo '    _kcl_edit_horizontalpodautoscaler                    - Edit a horizontal-pod-autoscaler'
	@echo '    _kcl_explain_horizontalpodautoscaler                 - Explain the horizontal-pod-autoscaler object'
	@echo '    _kcl_label_horizontalpodautoscaler                   - Label a horizontal-pod-autoscaler'
	@echo '    _kcl_list_horizonpodautoscalers                      - List all horizontal-pod-autoscalers'
	@echo '    _kcl_list_horizonpodautoscalers_set                  - List set of horizontal-pod-autoscalers'
	@echo '    _kcl_patch_horizontalpodautoscaler                   - Patch an horizontal-pod-autoscaler'
	@echo '    _kcl_show_horizontalpodautoscaler                    - Show everything related to a horizontal-pod-autoscaler'
	@echo '    _kcl_show_horizonpodautoscaler_description           - Show the description of a horizontal-pod-autoscaler'
	@echo '    _kcl_show_horizonpodautoscaler_replicaset            - Show the replica-set of a horizontal-pod-autoscaler'
	@echo '    _kcl_show_horizonpodautoscaler_state                 - Show the state of a horizontal-pod-autoscaler'
	@echo '    _kcl_unapply_horizontalpodautoscalers                - Un-apply manifest for one-or-more horizontal-pod-autoscalers'
	@echo '    _kcl_unlabel_horizontalpodautoscaler                 - Un-label an horizontal-pod-autoscaler'
	@echo '    _kcl_watch_horizonpodautoscalers                     - Watch all horizontal-pod-autoscalers'
	@echo '    _kcl_watch_horizonpodautoscalers_set                 - Watch a set of horizontal-pod-autoscalers'
	@echo '    _kcl_write_horizonpodautoscalers                     - Write a manifest for one-or-more horizontal-pod-autoscalers'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_horizontalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Annotating horizontal-pod-autoscaler "$(KCL_HORIZONTALPODAUTOSCALER_NAME)" ...'; $(NORMAL)

_kcl_apply_horizontalpodautoscaler: _kcl_apply_horizontalpodautoscalers
_kcl_apply_horizontalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more horizontal-pod-autoscalers ...'; $(NORMAL)
	# cat $(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILEPATH)
	# $(_KCL_APPLY_HORIZONTALPODAUTOSCALERS_|)cat
	# curl -L $(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_URL)
	# ls -al $(KCL_HORIZONTALPODAUTOSCALERS_MANIFESTS_DIRPATH)
	$(_KCL_APPLY_HORIZONTALPODAUTOSCALERS_|)$(KUBECTL) apply $(__KCL_FILENAME__HORIZONTALPODAUTOSCALERS) $(__KCL_NAMESPACE__HORIZONTALPODAUTOSCALERS)

_kcl_create_horizontalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Creating horizontal-pod-autoscaler "$(KCL_HORIZONTALPODAUTOSCALER_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) autoscale $(__KCL_CPU_PERCENT__HORIZONTALPODAUTOSCALER) $(__KCL_MAX__HORIZONTALPODAUTOSCALER) $(__KCL_MIN__HORIZONTALPODAUTOSCALER) $(__KCL_NAMESPACE__HORIZONTALPODAUTOSCALER) deployment $(KCL_HORIZONTALPODAUTOSCALER_DEPLOYMENT_NAME)

_kcl_delete_horizontalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Deleting horizontal-pod-autoscaler "$(KCL_HORIZONTALPODAUTOSCALER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete horizontalpodautoscaler $(__KCL_NAMESPACE__HORIZONTALPODAUTOSCALER) $(KCL_HORIZONTALPODAUTOSCALER_NAME)

_kcl_diff_horizontalpodautoscaler: _kcl_diff_horizontalpodautoscalers
_kcl_diff_horizontalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more horizontal-pod-autoscalers ...'; $(NORMAL)
	# cat $(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_HORIZONTALPODAUTOSCALERS_|)cat
	# curl -L $(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_URL)
	# ls -al $(KCL_HORIZONTALPODAUTOSCALERS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_HORIZONTALPODAUTOSCALERS_|)$(KUBECTL) diff $(__KCL_FILENAME__HORIZONTALPODAUTOSCALERS) $(__KCL_NAMESPACE__HORIZONTALPODAUTOSCALERS)

_kcl_edit_horizontalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Editing horizontal-pod-autoscaler "$(KCL_HORIZONTALPODAUTOSCALER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit horizontalpodautoscaler $(__KCL_NAMESPACE__HORIZONTALPODAUTOSCALER) $(KCL_HORIZONTALPODAUTOSCALER_NAME)

_kcl_explain_horizontalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Explaining horizontal-pod-autoscaler object ...'; $(NORMAL)
	$(KUBECTL) explain horizontalpodautoscaler

_kcl_label_horizontalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Labeling horizontal-pod-autoscaler "$(KCL_HORIZONTALPODAUTOSCALER_NAME)" ...'; $(NORMAL)

_kcl_list_horizontalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL horizontal-pod-autoscalers ...'; $(NORMAL)
	$(KUBECTL) get horizontalpodautoscalers --all-namespaces=true $(_X__KCL_NAMESPACE__HORIZONTALPODAUTOSCALERS) $(_X__KCL_SELECTOR__HORIZONTALPODAUTOSCALERS)

_kcl_list_horizontalpodautoscalers_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing horizontalpodautoscalers-set "$(KCL_HORIZONTALPODAUTOSCALERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Horizontal-pod-autoscalers are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get horizontalpodautoscalers --all-namespaces=false $(__KCL_NAMESPACE__HORIZONTALPODAUTOSCALERS) $(__KCL_SELECTOR__HORIZONTALPODAUTOSCALERS)

_kcl_patch_horizontalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Patching horizontal-pod-autoscaler "$(KCL_HORIZONTALPODAUTOSCALER_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) patch ...

_KCL_SHOW_HORIZONTALPODAUTOSCALER_TARGETS?= _kcl_show_horizontalpodautoscaler_replicaset _kcl_show_horizontalpodautoscaler_state _kcl_show_horizontalpodautoscaler_description
_kcl_show_horizontalpodautoscaler: $(_KCL_SHOW_HORIZONTALPODAUTOSCALER_TARGETS)

_kcl_show_horizontalpodautoscaler_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of horizontal-pod-autoscaler "$(KCL_HORIZONTALPODAUTOSCALER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe horizontalpodautoscaler $(__KCL_NAMESPACE__HORIZONTALPODAUTOSCALER) $(KCL_HORIZONTALPODAUTOSCALER_NAME)

_kcl_show_horizontalpodautoscaler_replicaset:
	@$(INFO) '$(KCL_UI_LABEL)Showing replica-set of horizontal-pod-autoscaler "$(KCL_HORIZONTALPODAUTOSCALER_NAME)" ...'; $(NORMAL)
	$(if $(KCL_HORIZONTALPODAUTOSCALER_REPLICASET_FIELDSELECTOR)$(KCL_HORIZONTALPODAUTOSCALER_REPLICASET_SELECTOR), \
		$(KUBECTL) get horizontalpodautoscaler $(__KCL_NAMESPACE__HORIZONTALPODAUTOSCALER) $(KCL_HORIZONTALPODAUTOSCALER_NAME) \
			$(if $(KCL_HORIZONTALPODAUTOSCALER_REPLICASET_FIELDSELECTOR),--field-selector $(KCL_HORIZONTALPODAUTOSCALER_REPLICASET_FIELDSELECTOR)) \
			$(if $(KCL_HORIZONTALPODAUTOSCALER_REPLICASET_SELECTOR),--selector $(KCL_HORIZONTALPODAUTOSCALER_REPLICASET_SELECTOR)) \
	, @\
		echo 'KCL_HORIZONTALPODAUTOSCALER_REPLICASET_FIELDSELECTOR not set'; \
		echo 'KCL_HORIZONTALPODAUTOSCALER_REPLICASET_SELECTOR not set'; \
	)

_kcl_show_horizontalpodautoscaler_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of horizontal-pod-autoscaler "$(KCL_HORIZONTALPODAUTOSCALER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get horizontalpodautoscaler $(__KCL_NAMESPACE__HORIZONTALPODAUTOSCALER) $(KCL_HORIZONTALPODAUTOSCALER_NAME)

_kcl_unapply_horizontalpodautoscaler: _kcl_unapply_horizontalpodautoscalers
_kcl_unapply_horizontalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more horizontal-pod-autoscaler ...'; $(NORMAL)
	# cat $(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_HORIZONTALPODAUTOSCALERS_|)cat
	# curl -L $(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_URL)
	# ls -al $(KCL_HORIZONTALPODAUTOSCALERS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_HORIZONTALPODAUTOSCALERS_|)$(KUBECTL) delete $(__KCL_FILENAME__HORIZONTALPODAUTOSCALER) $(__KCL_NAMESPACE__HORIZONTALPODAUTOSCALER)

_kcl_unlabel_horizontalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling horizontal-pod-autoscaler "$(KCL_HORIZONTALPODAUTOSCALER_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_watch_horizontalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL horizontal-pod-autoscalers ...'; $(NORMAL)
	$(KUBECTL) get horizontalpodautoscalers --all-namespaces=true --watch 

_kcl_watch_horizontalpodautoscalers_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching horizontal-pod-autoscalers-set "$(KCL_HORIZONTALPODAUTOSCALERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Horizontal-pod-autoscalers are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get horizontalpodautoscalers --all-namespaces=false $(__KCL_NAMESPACE__HORIZONTALPODAUTOSCALERS) $(__KCL_SELECTOR__HORIZONTALPODAUTOSCALERS) --watch 

_kcl_write_horizontalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more horizontal-pod-autoscalers ...'; $(NORMAL)
	$(WRITER) $(KCL_HORIZONTALPODAUTOSCALERS_MANIFEST_FILEPATH)
