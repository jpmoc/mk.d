_KUBECTL_VERTICALPODAUTOSCALER_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_VERTICALPODAUTOSCALER_NAME?= hello
# KCL_VERTICALPODAUTOSCALER_NAMESPACE_NAME?= default
# KCL_VERTICALPODAUTOSCALERS_NAMESPACE_NAME?= default
# KCL_VERTICALPODAUTOSCALERS_SELECTOR?=
# KCL_VERTICALPODAUTOSCALERS_SET_NAME?= my-vertical-pod-autoscalers-set

# Derived parameters
KCL_VERTICALPODAUTOSCALER_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_VERTICALPODAUTOSCALERS_NAMESPACE_NAME?= $(KCL_VERTICALPODAUTOSCALER_NAMESPACE_NAME)
KCL_VERTICALPODAUTOSCALERS_SET_NAME?= $(KCL_VERTICALPODAUTOSCALERS_NAMESPACE_NAME)

# Option parameters
__KCL_NAMESPACE__VERTICALPODAUTOSCALER= $(if $(KCL_VERTICALPODAUTOSCALER_NAMESPACE_NAME), --namespace $(KCL_VERTICALPODAUTOSCALER_NAMESPACE_NAME))
__KCL_NAMESPACE__VERTICALPODAUTOSCALERS= $(if $(KCL_VERTICALPODAUTOSCALERS_NAMESPACE_NAME), --namespace $(KCL_VERTICALPODAUTOSCALERS_NAMESPACE_NAME))
__KCL_SELECTOR__VERTICALPODAUTOSCALERS= $(if $(KCL_VERTICALPODAUTOSCALERS_SELECTOR), --selector=$(KCL_VERTICALPODAUTOSCALERS_SELECTOR))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::VerticalPodAutoscaler ($(_KUBECTL_VERTICALPODAUTOSCALER_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::VerticalPodAutoscaler ($(_KUBECTL_VERTICALPODAUTOSCALER_MK_VERSION)) parameters:'
	@echo '    KCL_VERTICALPODAUTOSCALER_NAME=$(KCL_VERTICALPODAUTOSCALER_NAME)'
	@echo '    KCL_VERTICALPODAUTOSCALER_NAMESPACE_NAME=$(KCL_VERTICALPODAUTOSCALER_NAMESPACE_NAME)'
	@echo '    KCL_VERTICALPODAUTOSCALERS_NAMESPACE_NAME=$(KCL_VERTICALPODAUTOSCALERS_NAMESPACE_NAME)'
	@echo '    KCL_VERTICALPODAUTOSCALERS_SELECTOR=$(KCL_VERTICALPODAUTOSCALERS_SELECTOR)'
	@echo '    KCL_VERTICALPODAUTOSCALERS_SET_NAME=$(KCL_VERTICALPODAUTOSCALERS_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::VerticalPodAutoscaler ($(_KUBECTL_VERTICALPODAUTOSCALER_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_verticalpodautoscaler                - Annotate a vertical-pod-autoscaler'
	@echo '    _kcl_apply_verticalpodautoscalers                  - Apply a manifest for one-or-more vertical-pod-autoscalers'
	@echo '    _kcl_create_verticalpodautoscaler                  - Create a new vertical-pod-autoscaler'
	@echo '    _kcl_delete_verticalpodautoscaler                  - Delete an existing vertical-pod-autoscaler'
	@echo '    _kcl_edit_verticalpodautoscaler                    - Edit a vertical-pod-autoscaler'
	@echo '    _kcl_explain_verticalpodautoscaler                 - Explain the vertical-pod-autoscaler object'
	@echo '    _kcl_label_verticalpodautoscaler                   - Label a vertical-pod-autoscaler'
	@echo '    _kcl_list_verticalpodautoscalers                   - List all vertical-pod-autoscalers'
	@echo '    _kcl_list_verticalpodautoscalers_set               - List set of vertical-pod-autoscalers'
	@echo '    _kcl_show_verticalpodautoscaler                    - Show everything related to a vertical-pod-autoscaler'
	@echo '    _kcl_show_verticalpodautoscaler_description        - Show the description of a vertical-pod-autoscaler'
	@echo '    _kcl_show_verticalpodautoscaler_state              - Show the state of a vertical-pod-autoscaler'
	@echo '    _kcl_unapply_verticalpodautoscalers                - Un-apply a manifest for one-or-more vertical-pod-autoscalers'
	@echo '    _kcl_watch_verticalpodautoscalers                  - Watch all vertical-pod-autoscalers'
	@echo '    _kcl_watch_verticalpodautoscalers_set              - Watch set of vertical-pod-autoscalers'
	@echo '    _kcl_write_verticalpodautoscalers                  - Write a manifest for one-or-more vertical-pod-autoscalers'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_verticalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Annotating vertical-pod-autoscaler "$(KCL_VERTICALPODAUTOSCALER_NAME)" ...'; $(NORMAL)

_kcl_apply_verticalpodautoscaler: _kcl_apply_verticalpodautoscalers
_kcl_apply_verticalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more vertical-pod-autoscalers ...'; $(NORMAL)

_kcl_create_verticalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Creating vertical-pod-autoscaler "$(KCL_VERTICALPODAUTOSCALER_NAME)" ...'; $(NORMAL)
	#$(KUBECTL) run $(KCL_VERTICALPODAUTOSCALER_NAME) $(__KCL_IMAGE__VERTICALPODAUTOSCALER) $(__KCL_NAMESPACE__VERTICALPODAUTOSCALER) $(__KCL_RSTART__VERTICALPODAUTOSCALER) -- $(KCL_VERTICALPODAUTOSCALER_COMMAND)

_kcl_delete_verticalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Deleting vertical-pod-autoscaler "$(KCL_VERTICALPODAUTOSCALER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete verticalpodautoscaler $(__KCL_NAMESPACE__VERTICALPODAUTOSCALER) $(KCL_VERTICALPODAUTOSCALER_NAME)

_kcl_diff_verticalpodautoscaler: _kcl_diff_verticalpodautoscalers
_kcl_diff_verticalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more vertical-pod-autoscalers ...'; $(NORMAL)

_kcl_edit_verticalpodautoscaler:

_kcl_explain_verticalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Explaining vertical-pod-autoscaler object ...'; $(NORMAL)
	$(KUBECTL) explain verticalpodautoscaler

_kcl_label_verticalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Labeling vertical-pod-autoscaler "$(KCL_VERTICALPODAUTOSCALER_NAME)" ...'; $(NORMAL)

_kcl_list_verticalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL vertical-pod-autoscalers ...'; $(NORMAL)
	$(KUBECTL) get verticalpodautoscalers --all-namespaces=true $(_X__KCL_NAMESPACE__VERTICALPODAUTOSCALERS) $(_X__KCL_SELECTOR__VERTICALPODAUTOSCALERS)

_kcl_list_verticalpodautoscalers_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing vertical-pod-autoscalers-set "$(KCL_VERTICALPODAUTOSCALERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Vertical-pod-autoscalers are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get verticalpodautoscalers --all-namespaces=false $(__KCL_NAMESPACE__VERTICALPODAUTOSCALERS) $(__KCL_SELECTOR__VERTICALPODAUTOSCALERS)

_KCL_SHOW_VERTICALPODAUTOSCALER_TARGETS?= _kcl_show_verticalpodautoscaler_state _kcl_show_verticalpodautoscaler_description
_kcl_show_verticalpodautoscaler: $(_KCL_SHOW_VERTICALPODAUTOSCALER_TARGETS)

_kcl_show_verticalpodautoscaler_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of vertical-pod-autoscaler "$(KCL_VERTICALPODAUTOSCALER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe verticalpodautoscaler $(__KCL_NAMESPACE__VERTICALPODAUTOSCALER) $(KCL_VERTICALPODAUTOSCALER_NAME)

_kcl_show_verticalpodautoscaler_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing the state of vertical-pod-autoscaler "$(KCL_VERTICALPODAUTOSCALER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get verticalpodautoscaler $(__KCL_NAMESPACE__VERTICALPODAUTOSCALER) $(KCL_VERTICALPODAUTOSCALER_NAME)

_kcl_unapply_verticalpodautoscaler: _kcl_unapply_verticalpodautoscalers
_kcl_unapply_verticalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more vertical-pod-autoscalers ...'; $(NORMAL)

_kcl_update_verticalpodautoscaler:

_kcl_watch_verticalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL vertical-pod-autoscalers ...'; $(NORMAL)
	$(KUBECTL) get verticalpodautoscalers --all-namespaces=true --watch 

_kcl_watch_verticalpodautoscalers_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching vertical-pod-autoscalers-set "$(KCL_VERTICALPODAUTOSCALERS_SET_NAME)" ...'; $(NORMAL)

_kcl_write_verticalpodautoscaler: _kcl_write_verticalpodautoscalers
_kcl_write_verticalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more vertical-pod-autoscalers ...'; $(NORMAL)
	$(WRITER) $(KCL_VERTICALPODAUTOSCALERS_MANIFEST_FILEPATH)
