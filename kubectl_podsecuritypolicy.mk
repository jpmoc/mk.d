_KUBECTL_PODSECURITYPOLICY_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_PODSECURITYPOLICY_ANNOTATIONS_KEYVALUES?= icon-url=http://goo.gl/XXBTWq ...
# KCL_PODSECURITYPOLICY_LABELS_KEYS?= new-label ...
# KCL_PODSECURITYPOLICY_LABELS_KEYVALUES?= new-label=awesome ...
# KCL_PODSECURITYPOLICY_MANIFEST_DIRPATH?= ./in/
# KCL_PODSECURITYPOLICY_MANIFEST_FILENAME?= manifest.yaml
# KCL_PODSECURITYPOLICY_MANIFEST_FILEPATH?= ./in/manifest.yaml
# KCL_PODSECURITYPOLICY_NAME?= my-pod--security-policy
# KCL_PODSECURITYPOLICY_NAMES?= 
# KCL_PODSECURITYPOLICIES_OUTPUT_FORMAT?= wide
# KCL_PODSECURITYPOLICIES_SELECTOR?=
# KCL_PODSECURITYPOLICIES_SET_NAME?= my-pod--security-policies-set
# KCL_PODSECURITYPOLICIES_WATCH_ONLY?= true

# Derived parameters
KCL_PODSECURITYPOLICY_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_PODSECURITYPOLICY_MANIFEST_FILEPATH?= $(KCL_PODSECURITYPOLICY_MANIFEST_DIRPATH)$(KCL_PODSECURITYPOLICY_MANIFEST_FILENAME)
KCL_PODSECURITYPOLICIES_OUTPUT_FORMAT?= $(KCL_OUTPUT_FORMAT)
KCL_PODSECURITYPOLICIES_SET_NAME?= pod-secrutiy-policies@@@
KCL_PODSECURITYPOLICIES_WATCH_ONLY?= $(KCL_WATCH_ONLY)

# Option parameters
__KCL_FILENAME__PODSECURITYPOLICY= $(if $(KCL_PODSECURITYPOLICY_MANIFEST_FILEPATH),--filename $(KCL_PODSECURITYPOLICY_MANIFEST_FILEPATH))
__KCL_OUTPUT__PODSECURITYPOLICIES= $(if $(KCL_PODSECURITYPOLICIES_OUTPUT_FORMAT),--output $(KCL_PODSECURITYPOLICIES_OUTPUT_FORMAT))
__KCL_SELECTOR__PODSECURITYPOLICIES= $(if $(KCL_PODSECURITYPOLICIES_SELECTOR),--selector=$(KCL_PODSECURITYPOLICIES_SELECTOR))
__KCL_SHOW_LABELS__PODSECURITYPOLICIES= $(if $(filter true,$(KCL_PODSECURITYPOLICIES_LABELS_FLAG)),--show-labels)
__KCL_WATCH__PODSECURITYPOLICIES=
__KCL_WATCH_ONLY__PODSECURITYPOLICIES= $(if $(KCL_PODSECURITYPOLICIES_WATCH_ONLY),--watch-only=$(KCL_PODSECURITYPOLICIES_WATCH_ONLY))

# UI parameters

#--- MACROS
_kcl_get_podsecuritypolicies_names= $(call _kcl_get_podsecuritypolicies_names_S, $(KCL_PODSECURITYPOLICIES_SELECTOR))
_kcl_get_podsecuritypolicies_names_S= $(shell $(KUBECTL) get podsecuritypolicies --selector $(1) --output jsonpath="{.items[*].metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::PodSecurityPolicy ($(_KUBECTL_PODSECURITYPOLICY_MK_VERSION)) macros:'
	@echo '    _kcl_get_podsecuritypolicies_names_{|I|IN}     - Get names of pod--securitypolicies (Selector,Namespace)'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::PodSecurityPolicy ($(_KUBECTL_PODSECURITYPOLICY_MK_VERSION)) parameters:'
	@echo '    KCL_PODSECURITYPOLICY_ANNOTATIONS_KEYVALUES=$(KCL_PODSECURITYPOLICY_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_PODSECURITYPOLICY_LABELS_KEYVALUES=$(KCL_PODSECURITYPOLICY_LABELS_KEYVALUES)'
	@echo '    KCL_PODSECURITYPOLICY_MANIFEST_DIRPATH=$(KCL_PODSECURITYPOLICY_MANIFEST_DIRPATH)'
	@echo '    KCL_PODSECURITYPOLICY_MANIFEST_FILENAME=$(KCL_PODSECURITYPOLICY_MANIFEST_FILENAME)'
	@echo '    KCL_PODSECURITYPOLICY_MANIFEST_FILEPATH=$(KCL_PODSECURITYPOLICY_MANIFEST_FILEPATH)'
	@echo '    KCL_PODSECURITYPOLICY_NAME=$(KCL_PODSECURITYPOLICY_NAME)'
	@echo '    KCL_PODSECURITYPOLICY_NAMESPACE_NAME=$(KCL_PODSECURITYPOLICY_NAMESPACE_NAME)'
	@echo '    KCL_PODSECURITYPOLICY_PREVIOUS=$(KCL_PODSECURITYPOLICY_PREVIOUS)'
	@echo '    KCL_PODSECURITYPOLICIES_NAMES=$(KCL_PODSECURITYPOLICIES_NAMES)'
	@echo '    KCL_PODSECURITYPOLICIES_NAMESPACE_NAME=$(KCL_PODSECURITYPOLICIES_NAMESPACE_NAME)'
	@echo '    KCL_PODSECURITYPOLICIES_LABELS_FLAG=$(KCL_PODSECURITYPOLICIES_LABELS_FLAG)'
	@echo '    KCL_PODSECURITYPOLICIES_OUTPUT_FORMAT=$(KCL_PODSECURITYPOLICIES_OUTPUT_FORMAT)'
	@echo '    KCL_PODSECURITYPOLICIES_SELECTOR=$(KCL_PODSECURITYPOLICIES_SELECTOR)'
	@echo '    KCL_PODSECURITYPOLICIES_SET_NAME=$(KCL_PODSECURITYPOLICIES_SET_NAME)'
	@echo '    KCL_PODSECURITYPOLICIES_WATCH_ONLY=$(KCL_PODSECURITYPOLICIES_WATCH_ONLY)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::PodSecurityPolicy ($(_KUBECTL_PODSECURITYPOLICY_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_podsecuritypolicy                     - Annotate a pod-security-policy'
	@echo '    _kcl_apply_podsecuritypolicy                        - Apply manifest for a pod-security-policy'
	@echo '    _kcl_create_podsecuritypolicy                       - Create a new pod-security-policy'
	@echo '    _kcl_delete_podsecuritypolicy                       - Delete an existing pod-security-policy'
	@echo '    _kcl_edit_podsecuritypolicy                         - Edit a pod-security-policy'
	@echo '    _kcl_explain_podsecuritypolicy                      - Explain the pod-security-policy object'
	@echo '    _kcl_label_podsecuritypolicy                        - Label a pod-security-policy'
	@echo '    _kcl_show_podsecuritypolicy                         - Show everything related to a pod-security-policy'
	@echo '    _kcl_show_podsecuritypolicy_description             - Show the description of a pod-security-policy'
	@echo '    _kcl_show_podsecuritypolicy_object                  - Show the object of a pod-security-policy'
	@echo '    _kcl_show_podsecuritypolicy_state                   - Show the state of a pod-security-policy'
	@echo '    _kcl_unapply_podsecuritypolicy                      - Un-apply manifest for a pod-security-policy'
	@echo '    _kcl_unlabel_podsecuritypolicy                      - Un-label a pod-security-policy'
	@echo '    _kcl_update_podsecuritypolicy                       - Update a pod-security-policy'
	@echo '    _kcl_list_podsecuritypolicies                       - List all pod-security-policies'
	@echo '    _kcl_list_podsecuritypolicies_set                   - List a set of pod-security-policies'
	@echo '    _kcl_watch_podsecuritypolicies                      - Watching pod-security-policies'
	@echo '    _kcl_watch_podsecuritypolicies_set                  - Watching a set of pod-security-policies'
	@echo '    _kcl_write_podsecuritypolicies                      - Write a manifest for one-or-more pod-security-policies'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_podsecuritypolicy:
	@$(INFO) '$(KCL_UI_LABEL)Annotating pod-security-policy "$(KCL_PODSECURITYPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate podsecuritypolicy $(KCL_PODSECURITYPOLICY_NAME) $(KCL_PODSECURITYPOLICY_ANNOTATIONS_KEYVALUES)

_kcl_apply_podsecuritypolicy:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for pod-security-policy "$(KCL_PODSECURITYPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) apply $(__KCL_FILENAME__PODSECURITYPOLICY)

_kcl_create_podsecuritypolicy:
	@$(INFO) '$(KCL_UI_LABEL)Creating pod-security-policy "$(KCL_PODSECURITYPOLICY_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) run $(__KCL_IMAGE__PODSECURITYPOLICY) $(__KCL_STDIN) $(__KCL_TTY) $(KCL_PODSECURITYPOLICY_NAME)

_kcl_delete_podsecuritypolicy:
	@$(INFO) '$(KCL_UI_LABEL)Deleting pod-security-policy "$(KCL_PODSECURITYPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete podsecuritypolicy $(KCL_PODSECURITYPOLICY_NAME)

_kcl_edit_podsecuritypolicy:
	@$(INFO) '$(KCL_UI_LABEL)Editing pod-security-policy "$(KCL_PODSECURITYPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit podsecuritypolicy $(KCL_PODSECURITYPOLICY_NAME)

_kcl_explain_podsecuritypolicy:
	@$(INFO) '$(KCL_UI_LABEL)Explaining pod-security-policy object ...'; $(NORMAL)
	$(KUBECTL) explain podsecuritypolicy

_kcl_label_podsecuritypolicy:
	@$(INFO) '$(KCL_UI_LABEL)Labelling pod-security-policy "$(KCL_PODSECURITYPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label podsecuritypolicy $(KCL_PODSECURITYPOLICY_NAME) $(KCL_PODSECURITYPOLICY_LABELS_KEYVALUES)

_kcl_list_podsecuritypolicies:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL pod-security-policies ...'; $(NORMAL)
	$(KUBECTL) get podsecuritypolicies $(_X__KCL_SELECTOR__PODSECURITYPOLICIES) $(__KCL_SHOW_LABELS__PODSECURITYPOLICIES) $(_X_KCL_WATCH__PODSECURITYPOLICIES) $(_X_KCL_WATCH_ONLY__PODSECURITYPOLICIES)

_kcl_list_podsecuritypolicies_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing pod-security-policies-set "$(KCL_PODSECURITYPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Pod-security-policies are grouped based on the provided selector'; $(NORMAL)
	$(KUBECTL) get podsecuritypolicies $(__KCL_OUTPUT__PODSECURITYPOLICIES) $(__KCL_SELECTOR__PODSECURITYPOLICIES) $(__KCL_SHOW_LABELS__PODSECURITYPOLICIES) $(_X_KCL_WATCH__PODSECURITYPOLICIES) $(_X_KCL__WATCH_ONLY__PODSECURITYPOLICIES)

_KCL_SHOW_PODSECURITYPOLICY_TARGETS?= _kcl_show_podsecuritypolicy_object _kcl_show_podsecuritypolicy_state _kcl_show_podsecuritypolicy_description
_kcl_show_podsecuritypolicy: $(_KCL_SHOW_PODSECURITYPOLICY_TARGETS)

_kcl_show_podsecuritypolicy_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of pod-security-policy "$(KCL_PODSECURITYPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe podsecuritypolicy $(KCL_PODSECURITYPOLICY_NAME)

_kcl_show_podsecuritypolicy_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of pod-security-policy "$(KCL_PODSECURITYPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get podsecuritypolicy $(KCL_PODSECURITYPOLICY_NAME) --output yaml

_kcl_show_podsecuritypolicy_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of pod-security-policy "$(KCL_PODSECURITYPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get podsecuritypolicy $(KCL_PODSECURITYPOLICY_NAME)

_kcl_unapply_podsecuritypolicy:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for pod-security-policy "$(KCL_PODSECURITYPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete $(__KCL_FILENAME__PODSECURITYPOLICY)

_kcl_unlabel_podsecuritypolicy:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling pod-distruption-securitypolicy "$(KCL_PODSECURITYPOLICY_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label podsecuritypolicy $(KCL_PODSECURITYPOLICY_NAME) $(_X_KCL_PODSECURITYPOLICY_LABELS_KEYVALUES) $(foreach K,$(KCL_PODSECURITYPOLICY_LABELS_KEYS),$(K)- )

_kcl_update_podsecuritypolicy:
	@$(INFO) '$(KCL_UI_LABEL)Updating pod-security-policy "$(KCL_PODSECURITYPOLICY_NAME)" ...'; $(NORMAL)

_kcl_watch_podsecuritypolicies:
	@$(INFO) '$(KCL_UI_LABEL)Watching pod-security-policies ...'; $(NORMAL)
	$(KUBECTL) get podsecuritypolicies $(_X__KCL_SELECTOR__PODSECURITYPOLICIES) $(__KCL_SHOW_LABELS__PODSECURITYPOLICIES) $(_X__KCL_WATCH__PODSECURITYPOLICIES) --watch=true $(__KCL_WATCH_ONLY__PODSECURITYPOLICIES)

_kcl_watch_podsecuritypolicies_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching pod-security-policies-set "$(KCL_PODSECURITYPOLICIES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get podsecuritypolicies $(__KCL_SELECTOR__PODSECURITYPOLICIES) $(__KCL_SHOW_LABELS__PODSECURITYPOLICIES) $(_X__KCL_WATCH__PODSECURITYPOLICIES) --watch=true $(__KCL_WATCH_ONLY__PODSECURITYPOLICIES)

_kcl_write_podsecuritypolicy: _kcl_write_podsecuritypolicies
_kcl_write_podsecuritypolicies:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more pod-security-policies ...'; $(NORMAL)
	$(WRITER) $(KCL_PODSECURITYPOLICIES_MANIFEST_FILEPATH)
