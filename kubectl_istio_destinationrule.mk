_KUBECTL_ISTIO_DESTINATIONRULE_MK_VERSION= $(_KUBECTL_ISTIO_MK_VERSION)

# KCL_DESTINATIONRULE_MANIFEST_DIRPATH?=
# KCL_DESTINATIONRULE_MANIFEST_FILENAME?=
# KCL_DESTINATIONRULE_MANIFEST_FILEPATH?=
# KCL_DESTINATIONRULE_NAME?=
# KCL_DESTINATIONRULE_NAMESPACE_NAME?= istio-namespace
# KCL_DESTINATIONRULE_OUTPUT_FORMAT?=
# KCL_DESTINATIONRULE_SUBSETS_SELECTOR?= 'app=productpage,version in (v1, v2)'
# KCL_DESTINATIONRULES_NAMESPACE_NAME?= istio-namespace
# KCL_DESTINATIONRULES_OUTPUT_FORMAT?=
# KCL_DESTINATIONRULES_SELECTOR?=

# Derived parameters
KCL_DESTINATIONRULE_MANIFEST_DIRPATH= $(KCL_INPUTS_DIRPATH)
KCL_DESTINATIONRULE_MANIFEST_FILEPATH= $(KCL_DESTINATIONRULE_MANIFEST_DIRPATH)$(KCL_DESTINATIONRULE_MANIFEST_FILENAME)
KCL_DESTINATIONRULE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_DESTINATIONRULES_NAMESPACE_NAME?= $(KCL_DESTINATIONRULE_NAMESPACE_NAME)
KCL_DESTINATIONRULES_SET_NAME?= destination-rules@$(KCL_DESTINATIONRULES_NAMESPACE_NAME)@$(KCL_DESTINATIONRULES_SELECTOR)

# Option parameters
__KCL_FILENAME__DESTINATIONRULE= $(if $(KCL_DESTINATIONRULE_MANIFEST_FILEPATH),--filename $(KCL_DESTINATIONRULE_MANIFEST_FILEPATH))
__KCL_LABELS__DESTINATIONRULE= $(if $(KCL_DESTINATIONRULE_LABELS_KEYVALUES),--labels $(KCL_DESTINATIONRULE_LABELS_KEYVALUES))
__KCL_NAMESPACE__DESTINATIONRULE= $(if $(KCL_DESTINATIONRULE_NAMESPACE_NAME),--namespace $(KCL_DESTINATIONRULE_NAMESPACE_NAME))
__KCL_NAMESPACE__DESTINATIONRULES= $(if $(KCL_DESTINATIONRULES_NAMESPACE_NAME),--namespace $(KCL_DESTINATIONRULES_NAMESPACE_NAME))
__KCL_OUTPUT__DESTINATIONRULE= $(if $(KCL_DESTINATIONRULE_OUTPUT_FORMAT),--output $(KCL_DESTINATIONRULE_OUTPUT_FORMAT))
__KCL_OUTPUT__DESTINATIONRULES= $(if $(KCL_DESTINATIONRULES_OUTPUT_FORMAT),--output $(KCL_DESTINATIONRULES_OUTPUT_FORMAT))
__KCL_SELECTOR__DESTINATIONRULES= $(if $(KCL_DESTINATIONRULES_SELECTOR),--selector=$(KCL_DESTINATIONRULES_SELECTOR))
__KCL_SORT_BY__DESTINATIONRULES= $(if $(KCL_DESTINATIONRULES_SORT_BY),--sort-by=$(KCL_DESTINATIONRULES_SORT_BY))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Istio::DestinationRule ($(_KUBECTL_ISTIO_DESTINATIONRULE_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Istio::DestinationRule ($(_KUBECTL_ISTIO_DESTINATIONRULE_MK_VERSION)) parameters:'
	@echo '    KCL_DESTINATIONRULE_MANIFEST_DIRPATH=$(KCL_DESTINATIONRULE_MANIFEST_DIRPATH)'
	@echo '    KCL_DESTINATIONRULE_MANIFEST_FILENAME=$(KCL_DESTINATIONRULE_MANIFEST_FILENAME)'
	@echo '    KCL_DESTINATIONRULE_MANIFEST_FILEPATH=$(KCL_DESTINATIONRULE_MANIFEST_FILEPATH)'
	@echo '    KCL_DESTINATIONRULE_NAME=$(KCL_DESTINATIONRULE_NAME)'
	@echo '    KCL_DESTINATIONRULE_NAMESPACE_NAME=$(KCL_DESTINATIONRULE_NAMESPACE_NAME)'
	@echo '    KCL_DESTINATIONRULE_OUTPUT_FORMAT=$(KCL_DESTINATIONRULE_OUTPUT_FORMAT)'
	@echo '    KCL_DESTINATIONRULE_SUBSETS_SELECTOR=$(KCL_DESTINATIONRULE_SUBSETS_SELECTOR)'
	@echo '    KCL_DESTINATIONRULES_NAMESPACE_NAME=$(KCL_DESTINATIONRULES_NAMESPACE_NAME)'
	@echo '    KCL_DESTINATIONRULES_OUTPUT_FORMAT=$(KCL_DESTINATIONRULES_OUTPUT_FORMAT)'
	@echo '    KCL_DESTINATIONRULES_SELECTOR=$(KCL_DESTINATIONRULES_SELECTOR)'
	@echo '    KCL_DESTINATIONRULES_SET_NAME=$(KCL_DESTINATIONRULES_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Istio::DestinationRule ($(_KUBECTL_ISTIO_DESTINATIONRULE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_destinationrule                - Annotate a destination-rule'
	@echo '    _kcl_apply_destinationrule                   - Apply a destination-rule'
	@echo '    _kcl_create_destinationrule                  - Create a destination-rule'
	@echo '    _kcl_delete_destinationrule                  - Delete a destination-rule'
	@echo '    _kcl_edit_destinationrule                    - Edit a destination-rule'
	@echo '    _kcl_explain_destinationrule                 - Explain destination-rule'
	@echo '    _kcl_label_destinationrule                   - Label a destination-rule'
	@echo '    _kcl_show_destinationrule                    - Show everything related to a destination-rule'
	@echo '    _kcl_show_destinationrule_description        - Show description of a destination-rule'
	@echo '    _kcl_show_destinationrule_object             - Show object of a destination-rule'
	@echo '    _kcl_show_destinationrule_state              - Show the state of a destination-rule'
	@echo '    _kcl_unapply_destinationrule                 - Unapply a destination-rule'
	@echo '    _kcl_unlabel_destinationrule                 - Unlabel a destination-rule'
	@echo '    _kcl_update_destinationrule                  - Update a destination-rule'
	@echo '    _kcl_view_destinationrules                   - View all destination-rules'
	@echo '    _kcl_view_destinationrules_set               - View a set of destination-rules'
	@echo '    _kcl_watch_destinationrules                  - Watch destination-rules'
	@echo '    _kcl_watch_destinationrules_set              - Watch a set of destination-rules'
	@echo '    _kcl_write_destinationrules                  - Write manifest for one-or-more destination-rules'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_destinationrule:
	@$(INFO) '$(KCL_UI_LABEL)Annotating destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)

_kcl_apply_destinationrule:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)
	cat $(KCL_DESTINATIONRULE_MANIFEST_FILEPATH); echo
	$(KUBECTL) apply $(__KCL_FILENAME__DESTINATIONRULE) $(__KCL_NAMESPACE__DESTINATIONRULE)

_kcl_create_destinationrule:
	@$(INFO) '$(KCL_UI_LABEL)Creating destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)

_kcl_delete_destinationrule:
	@$(INFO) '$(KCL_UI_LABEL)Deleting destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT delete services of exposed deployments'; $(NORMAL)
	$(KUBECTL) delete destinationrule $(__KCL_NAMESPACE__DESTINATIONRULE) $(KCL_DESTINATIONRULE_NAME)

_kcl_edit_destinationrule:
	@$(INFO) '$(KCL_UI_LABEL)Editing destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit destinationrule $(__KCL_NAMESPACE__DESTINATIONRULE) $(KCL_DESTINATIONRULE_NAME)

_kcl_explain_destinationrule:
	@$(INFO) '$(KCL_UI_LABEL)Explaining destination-rule object ...'; $(NORMAL)
	$(KUBECTL) explain destinationrule

_kcl_label_destionationrule:
	@$(INFO) '$(KCL_UI_LABEL)Labeling destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)

_kcl_show_destinationrule: _kcl_show_destinationrule_object _kcl_show_destinationrule_state _kcl_show_destinationrule_subsets _kcl_show_destinationrule_description

_kcl_show_destinationrule_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe destinationrule $(__KCL_NAMESPACE__DESTINATIONRULE) $(KCL_DESTINATIONRULE_NAME)

_kcl_show_destinationrule_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get destinationrule $(__KCL_NAMESPACE__DESTINATIONRULE) $(_X__KCL_OUTPUT__DESTINATIONRULE) --output yaml $(KCL_DESTINATIONRULE_NAME)

_kcl_show_destinationrule_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get destinationrule $(__KCL_NAMESPACE__DESTINATIONRULE) $(_X__KCL_OUTPUT__DESTINATIONRULE) $(KCL_DESTINATIONRULE_NAME)

_kcl_show_destinationrule_subsets:
	@$(INFO) '$(KCL_UI_LABEL)Showing subsets of destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the pod-groups/subsets that will process incoming queries'; $(NORMAL)
	$(if $(KCL_DESTINATIONRULE_SUBSETS_SELECTOR), \
		$(KUBECTL) get pods $(__KCL_NAMESPACE__DESTINATIONRULE) --selector $(KCL_DESTINATIONRULE_SUBSETS_SELECTOR), \
		@echo "KCL_DESTINATIONRULE_SUBSETS_SELECTOR not set" \
	)

_kcl_unapply_destinationrule:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)
	cat $(KCL_DESTINATIONRULE_MANIFEST_FILEPATH); echo
	$(KUBECTL) delete $(__KCL_FILENAME__DESTINATIONRULE) $(__KCL_NAMESPACE__DESTINATIONRULE)

_kcl_unlabel_destinationrule:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)

_kcl_update_destinationrule:
	@$(INFO) '$(KCL_UI_LABEL)Updating destination-rule "$(KCL_DESTINATIONRULE_NAME)" ...'; $(NORMAL)

_kcl_view_destinationrules:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL destination-rules ...'; $(NORMAL)
	$(KUBECTL) get destinationrules --all-namespaces=true $(_X__KCL_NAMESPACE__DESTINATIONRULES) $(__KCL_OUTPUT_DESTINATIONRULES) $(_X__KCL_SELECTOR__DESTINATIONRULES) $(__KCL_SORT_BY__DESTINATIONRULES)

_kcl_view_destinationrules_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing destination-rules-set "$(KCL_DESTINATIONRULES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Destination-rules are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get destinationrules --all-namespaces=false $(__KCL_NAMESPACE__DESTINATIONRULES) $(__KCL_OUTPUT__DESTINATIONRULES) $(__KCL_SELECTOR__DESTINATIONRULES) $(__KCL_SORT_BY__DESTINATIONRULES)

_kcl_watch_destinationrules:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL destination-rules ...'; $(NORMAL)
	$(KUBECTL) get destinationrules --all-namespaces=true --watch 

_kcl_watch_destinationrules_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching destination-rules-set "$(KCL_DESTINATIONRULES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get destinationrules --all-namespaces=true --watch 

_kcl_write_destinationrule: _kcl_write_destinationrules
_kcl_write_destinationrules:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-moredestination-rules ...'; $(NORMAL)
	$(EDITOR) $(KCL_DESTINATIONRULES_MANIFEST_FILEPATH)
