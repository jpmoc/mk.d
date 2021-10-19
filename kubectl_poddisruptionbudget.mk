_KUBECTL_PODDISRUPTIONBUDGET_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_PODDISRUPTIONBUDGET_ANNOTATIONS_KEYVALUES?= icon-url=http://goo.gl/XXBTWq ...
# KCL_PODDISRUPTIONBUDGET_LABELS_KEYS?= new-label ...
# KCL_PODDISRUPTIONBUDGET_LABELS_KEYVALUES?= new-label=awesome ...
# KCL_PODDISRUPTIONBUDGET_MANIFEST_DIRPATH?= ./in/
# KCL_PODDISRUPTIONBUDGET_MANIFEST_FILENAME?= manifest.yaml
# KCL_PODDISRUPTIONBUDGET_MANIFEST_FILEPATH?= ./in/manifest.yaml
# KCL_PODDISRUPTIONBUDGET_NAME?= my-pod-disruption-budget
# KCL_PODDISRUPTIONBUDGET_NAMESPACE_NAME?= default
# KCL_PODDISRUPTIONBUDGETS_NAMES?= 
# KCL_PODDISRUPTIONBUDGETS_NAMESPACE_NAME?= default
# KCL_PODDISRUPTIONBUDGETS_OUTPUT_FORMAT?= wide
# KCL_PODDISRUPTIONBUDGETS_SELECTOR?=
# KCL_PODDISRUPTIONBUDGETS_SET_NAME?= my-pod-disruption-budgets-set
# KCL_PODDISRUPTIONBUDGETS_WATCH_ONLY?= true

# Derived parameters
KCL_PODDISRUPTIONBUDGET_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_PODDISRUPTIONBUDGET_MANIFEST_FILEPATH?= $(KCL_PODDISRUPTIONBUDGET_MANIFEST_DIRPATH)$(KCL_PODDISRUPTIONBUDGET_MANIFEST_FILENAME)
KCL_PODDISRUPTIONBUDGET_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_PODDISRUPTIONBUDGETS_NAMESPACE_NAME?= $(KCL_PODDISRUPTIONBUDGET_NAMESPACE_NAME)
KCL_PODDISRUPTIONBUDGETS_OUTPUT_FORMAT?= $(KCL_OUTPUT_FORMAT)
KCL_PODDISRUPTIONBUDGETS_SET_NAME?= $(KCL_PODDISRUPTIONBUDGETS_NAMESPACE_NAME)
KCL_PODDISRUPTIONBUDGETS_WATCH_ONLY?= $(KCL_WATCH_ONLY)

# Option parameters
__KCL_ALL_NAMESPACES=
__KCL_FILENAME__PODDISRUPTIONBUDGET= $(if $(KCL_PODDISRUPTIONBUDGET_MANIFEST_FILEPATH),--filename $(KCL_PODDISRUPTIONBUDGET_MANIFEST_FILEPATH))
__KCL_NAMESPACE__PODDISRUPTIONBUDGET= $(if $(KCL_PODDISRUPTIONBUDGET_NAMESPACE_NAME),--namespace $(KCL_PODDISRUPTIONBUDGET_NAMESPACE_NAME))
__KCL_NAMESPACE__PODDISRUPTIONBUDGETS= $(if $(KCL_PODDISRUPTIONBUDGETS_NAMESPACE_NAME),--namespace $(KCL_PODDISRUPTIONBUDGETS_NAMESPACE_NAME))
__KCL_OUTPUT__PODDISRUPTIONBUDGETS= $(if $(KCL_PODDISRUPTIONBUDGETS_OUTPUT_FORMAT),--output $(KCL_PODDISRUPTIONBUDGETS_OUTPUT_FORMAT))
__KCL_SELECTOR__PODDISRUPTIONBUDGETS= $(if $(KCL_PODDISRUPTIONBUDGETS_SELECTOR),--selector=$(KCL_PODDISRUPTIONBUDGETS_SELECTOR))
__KCL_SHOW_LABELS__PODDISRUPTIONBUDGETS= $(if $(filter true,$(KCL_PODDISRUPTIONBUDGETS_LABELS_FLAG)),--show-labels)
__KCL_WATCH__PODDISRUPTIONBUDGETS=
__KCL_WATCH_ONLY__PODDISRUPTIONBUDGETS= $(if $(KCL_PODDISRUPTIONBUDGETS_WATCH_ONLY),--watch-only=$(KCL_PODDISRUPTIONBUDGETS_WATCH_ONLY))

# UI parameters

#--- MACROS
_kcl_get_poddisruptionbudgets_names= $(call _kcl_get_poddisruptionbudgets_names_S, $(KCL_PODDISRUPTIONBUDGETS_SELECTOR))
_kcl_get_poddisruptionbudgets_names_S= $(call _kcl_get_poddisruptionbudgets_names_SN, $(1), $(KCL_PODDISRUPTIONBUDGETS_NAMESPACE_NAME))
_kcl_get_poddisruptionbudgets_names_SN= $(shell $(KUBECTL) get poddisruptionbudget --namespace $(2) --selector $(1) --output jsonpath="{.items[*].metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framwork_macros ::
	@echo 'KubeCtL::PodDisruptionBudget ($(_KUBECTL_PODDISRUPTIONBUDGET_MK_VERSION)) macros:'
	@echo '    _kcl_get_poddisruptionbudgets_names_{|I|IN}     - Get names of pod-disruption-budgets (Selector,Namespace)'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::PodDisruptionBudget ($(_KUBECTL_PODDISRUPTIONBUDGET_MK_VERSION)) parameters:'
	@echo '    KCL_PODDISRUPTIONBUDGET_ANNOTATIONS_KEYVALUES=$(KCL_PODDISRUPTIONBUDGET_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_PODDISRUPTIONBUDGET_LABELS_KEYVALUES=$(KCL_PODDISRUPTIONBUDGET_LABELS_KEYVALUES)'
	@echo '    KCL_PODDISRUPTIONBUDGET_MANIFEST_DIRPATH=$(KCL_PODDISRUPTIONBUDGET_MANIFEST_DIRPATH)'
	@echo '    KCL_PODDISRUPTIONBUDGET_MANIFEST_FILENAME=$(KCL_PODDISRUPTIONBUDGET_MANIFEST_FILENAME)'
	@echo '    KCL_PODDISRUPTIONBUDGET_MANIFEST_FILEPATH=$(KCL_PODDISRUPTIONBUDGET_MANIFEST_FILEPATH)'
	@echo '    KCL_PODDISRUPTIONBUDGET_NAME=$(KCL_PODDISRUPTIONBUDGET_NAME)'
	@echo '    KCL_PODDISRUPTIONBUDGET_NAMESPACE_NAME=$(KCL_PODDISRUPTIONBUDGET_NAMESPACE_NAME)'
	@echo '    KCL_PODDISRUPTIONBUDGET_PREVIOUS=$(KCL_PODDISRUPTIONBUDGET_PREVIOUS)'
	@echo '    KCL_PODDISRUPTIONBUDGETS_NAMES=$(KCL_PODDISRUPTIONBUDGETS_NAMES)'
	@echo '    KCL_PODDISRUPTIONBUDGETS_NAMESPACE_NAME=$(KCL_PODDISRUPTIONBUDGETS_NAMESPACE_NAME)'
	@echo '    KCL_PODDISRUPTIONBUDGETS_LABELS_FLAG=$(KCL_PODDISRUPTIONBUDGETS_LABELS_FLAG)'
	@echo '    KCL_PODDISRUPTIONBUDGETS_OUTPUT_FORMAT=$(KCL_PODDISRUPTIONBUDGETS_OUTPUT_FORMAT)'
	@echo '    KCL_PODDISRUPTIONBUDGETS_SELECTOR=$(KCL_PODDISRUPTIONBUDGETS_SELECTOR)'
	@echo '    KCL_PODDISRUPTIONBUDGETS_SET_NAME=$(KCL_PODDISRUPTIONBUDGETS_SET_NAME)'
	@echo '    KCL_PODDISRUPTIONBUDGETS_WATCH_ONLY=$(KCL_PODDISRUPTIONBUDGETS_WATCH_ONLY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::PodDisruptionBudget ($(_KUBECTL_PODDISRUPTIONBUDGET_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_poddisruptionbudget                     - Annotate a pod-distruption-budget'
	@echo '    _kcl_apply_poddisruptionbudget                        - Apply manifest for a pod-distruption-budget'
	@echo '    _kcl_create_poddisruptionbudget                       - Create a new pod-distruption-budget'
	@echo '    _kcl_delete_poddisruptionbudget                       - Delete an existing pod-distruption-budget'
	@echo '    _kcl_edit_poddisruptionbudget                         - Edit a pod-distruption-budget'
	@echo '    _kcl_explain_poddisruptionbudget                      - Explain the pod-distruption-budget object'
	@echo '    _kcl_label_poddisruptionbudget                        - Label a pod-distruption-budget'
	@echo '    _kcl_show_poddisruptionbudget                         - Show everything related to a pod-distruption-budget'
	@echo '    _kcl_show_poddisruptionbudget_description             - Show the description of a pod-distruption-budget'
	@echo '    _kcl_show_poddisruptionbudget_object                  - Show the object of a pod-distruption-budget'
	@echo '    _kcl_show_poddisruptionbudget_state                   - Show the state of a pod-distruption-budget'
	@echo '    _kcl_unapply_poddisruptionbudget                      - Un-apply manifest for a pod-distruption-budget'
	@echo '    _kcl_unlabel_poddisruptionbudget                      - Un-label a pod-distruption-budget'
	@echo '    _kcl_update_poddisruptionbudget                       - Update a pod-distruption-budget'
	@echo '    _kcl_view_poddisruptionbudgets                        - View all pod-disruption-budgets'
	@echo '    _kcl_view_poddisruptionbudgets_set                    - View a set of pod-disruption-budgets'
	@echo '    _kcl_watch_poddisruptionbudgets                       - Watching pod-disruption-budgets'
	@echo '    _kcl_watch_poddisruptionbudgets_set                   - Watching a set of pod-disruption-budgets'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_poddisruptionbudget:
	@$(INFO) '$(KCL_UI_LABEL)Annotating pod-distruption-budget "$(KCL_PODDISRUPTIONBUDGET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate poddisruptionbudget $(__KCL_NAMESPACE__PODDISRUPTIONBUDGET) $(KCL_PODDISRUPTIONBUDGET_NAME) $(KCL_PODDISRUPTIONBUDGET_ANNOTATIONS_KEYVALUES)

_kcl_apply_poddisruptionbudget:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for pod-distruption-budget "$(KCL_PODDISRUPTIONBUDGET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) apply $(__KCL_FILENAME__PODDISRUPTIONBUDGET) $(__KCL_NAMESPACE__PODDISRUPTIONBUDGET)

_kcl_create_poddisruptionbudget:
	@$(INFO) '$(KCL_UI_LABEL)Creating pod-distruption-budget "$(KCL_PODDISRUPTIONBUDGET_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) run $(__KCL_IMAGE__PODDISRUPTIONBUDGET) $(__KCL_NAMESPACE__PODDISRUPTIONBUDGET) $(__KCL_STDIN) $(__KCL_TTY) $(KCL_PODDISRUPTIONBUDGET_NAME)

_kcl_delete_poddisruptionbudget:
	@$(INFO) '$(KCL_UI_LABEL)Deleting pod-distruption-budget "$(KCL_PODDISRUPTIONBUDGET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If the deleted pod is part of a deployment/replica-set, another one will be respawned'; $(NORMAL)
	$(KUBECTL) delete poddisruptionbudget $(__KCL_NAMESPACE__PODDISRUPTIONBUDGET) $(KCL_PODDISRUPTIONBUDGET_NAME)

_kcl_edit_poddisruptionbudget:
	@$(INFO) '$(KCL_UI_LABEL)Editing pod-distruption-budget "$(KCL_PODDISRUPTIONBUDGET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit poddisruptionbudget $(__KCL_NAMESPACE__PODDISRUPTIONBUDGET) $(KCL_PODDISRUPTIONBUDGET_NAME)

_kcl_explain_poddisruptionbudget:
	@$(INFO) '$(KCL_UI_LABEL)Explaining pod-distruption-budget object ...'; $(NORMAL)
	$(KUBECTL) explain poddisruptionbudget

_kcl_label_poddisruptionbudget:
	@$(INFO) '$(KCL_UI_LABEL)Labelling pod-distruption-budget "$(KCL_PODDISRUPTIONBUDGET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label poddisruptionbudget $(__KCL_NAMESPACE__PODDISRUPTIONBUDGET) $(KCL_PODDISRUPTIONBUDGET_NAME) $(KCL_PODDISRUPTIONBUDGET_LABELS_KEYVALUES)

_kcl_show_poddisruptionbudget: _kcl_show_poddisruptionbudget_object _kcl_show_poddisruptionbudget_state _kcl_show_poddisruptionbudget_description

_kcl_show_poddisruptionbudget_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of pod-distruption-budget "$(KCL_PODDISRUPTIONBUDGET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe poddisruptionbudget $(__KCL_NAMESPACE__PODDISRUPTIONBUDGET) $(KCL_PODDISRUPTIONBUDGET_NAME)

_kcl_show_poddisruptionbudget_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of pod-distruption-budget "$(KCL_PODDISRUPTIONBUDGET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get poddisruptionbudget $(__KCL_NAMESPACE__PODDISRUPTIONBUDGET) $(KCL_PODDISRUPTIONBUDGET_NAME) --output yaml

_kcl_show_poddisruptionbudget_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of pod-distruption-budget "$(KCL_PODDISRUPTIONBUDGET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get poddisruptionbudget $(__KCL_NAMESPACE__PODDISRUPTIONBUDGET) $(KCL_PODDISRUPTIONBUDGET_NAME)

_kcl_unapply_poddisruptionbudget:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for pod-distruption-budget "$(KCL_PODDISRUPTIONBUDGET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete $(__KCL_FILENAME__PODDISRUPTIONBUDGET) $(__KCL_NAMESPACE__PODDISRUPTIONBUDGET)

_kcl_unlabel_poddisruptionbudget:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling pod-distruption-budget "$(KCL_PODDISRUPTIONBUDGET_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label poddisruptionbudget $(__KCL_NAMESPACE__PODDISRUPTIONBUDGET) $(KCL_PODDISRUPTIONBUDGET_NAME) $(_X_KCL_PODDISRUPTIONBUDGET_LABELS_KEYVALUES) $(foreach K,$(KCL_PODDISRUPTIONBUDGET_LABELS_KEYS),$(K)- )

_kcl_update_poddisruptionbudget:
	@$(INFO) '$(KCL_UI_LABEL)Updating pod-distruption-budget "$(KCL_PODDISRUPTIONBUDGET_NAME)" ...'; $(NORMAL)

_kcl_view_poddisruptionbudgets:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL pod-disruption-budgets ...'; $(NORMAL)
	$(KUBECTL) get poddisruptionbudget --all-namespaces=true $(_X__KCL_NAMESPACE__PODDISRUPTIONBUDGETS) $(_X__KCL_SELECTOR__PODDISRUPTIONBUDGETS) $(__KCL_SHOW_LABELS__PODDISRUPTIONBUDGETS) $(_X_KCL_WATCH__PODDISRUPTIONBUDGETS) $(_X_KCL_WATCH_ONLY__PODDISRUPTIONBUDGETS)

_kcl_view_poddisruptionbudgets_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing pod-disruption-budgets-set "$(KCL_PODDISRUPTIONBUDGETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Pod-disruptoin-budgets are grouped based on the provided namespace, selector'; $(NORMAL)
	$(KUBECTL) get poddisruptionbudget --all-namespaces=false $(__KCL_NAMESPACE__PODDISRUPTIONBUDGETS) $(__KCL_OUTPUT__PODDISRUPTIONBUDGETS) $(__KCL_SHOW_LABELS__PODDISRUPTIONBUDGETS) $(__KCL_SELECTOR__PODDISRUPTIONBUDGETS) $(_X_KCL_WATCH__PODDISRUPTIONBUDGETS) $(_X_KCL__WATCH_ONLY__PODDISRUPTIONBUDGETS)

_kcl_watch_poddisruptionbudgets:
	@$(INFO) '$(KCL_UI_LABEL)Watching pod-disruption-budgets ...'; $(NORMAL)
	$(KUBECTL) get poddisruptionbudgets $(_X__KCL_ALL_NAMESPACES__PODDISRUPTIONBUDGETS) --all-namespaces=true $(_X__KCL_NAMESPACE__PODDISRUPTIONBUDGETS) $(_X__KCL_SELECTOR__PODDISRUPTIONBUDGETS) $(__KCL_SHOW_LABELS__PODDISRUPTIONBUDGETS) $(_X__KCL_WATCH__PODDISRUPTIONBUDGETS) --watch=true $(__KCL_WATCH_ONLY__PODDISRUPTIONBUDGETS)

_kcl_watch_poddisruptionbudgets_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching pod-disruption-budgets-set "$(KCL_PODDISRUPTIONBUDGETS_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get poddisruptionbudgets $(__KCL_ALL_NAMESPACES__PODDISRUPTIONBUDGETS) $(__KCL_NAMESPACE__PODDISRUPTIONBUDGETS) $(__KCL_SELECTOR__PODDISRUPTIONBUDGETS) $(__KCL_SHOW_LABELS__PODDISRUPTIONBUDGETS) $(_X__KCL_WATCH__PODDISRUPTIONBUDGETS) --watch=true $(__KCL_WATCH_ONLY__PODDISRUPTIONBUDGETS)
