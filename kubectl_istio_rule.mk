_KUBECTL_ISTIO_RULE_MK_VERSION= $(_KUBECTL_ISTIO_MK_VERSION)

# KCL_RULE_NAME?=
# KCL_RULE_NAMESPACE_NAME?= istio-namespace
# KCL_RULE_OUTPUT?=
# KCL_RULES_FIELDSELECTOR?= metadata.name=my-rule
# KCL_RULES_MANIFEST_DIRPATH?= ./in/
# KCL_RULES_MANIFEST_FILENAME?= rule.yaml
# KCL_RULES_MANIFEST_FILEPATH?= ./in/rule.yaml
# KCL_RULES_OUTPUT?=
# KCL_RULES_SELECTOR?=
# KCL_RULES_SET_NAME?=

# Derived parameters
KCL_RULE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_RULES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_RULES_MANIFEST_FILEPATH?= $(KCL_RULES_MANIFEST_DIRPATH)$(KCL_RULES_MANIFEST_FILENAME)
KCL_RULES_SET_NAME?= rules@$(KCL_RULES_FIELDSELECTOR)@$(KCL_RULES_SELECTOR)@$(KCL_RULES_NAMESPACE_NAME)

# Options
__KCL_FIELD_SELECTOR__RULES= $(if $(KCL_RULES_FIELDSELECTOR),--field-selector $(KCL_RULES_FIELDSELECTOR))
__KCL_FILENAME__RULES= $(if $(KCL_RULES_MANIFEST_FILEPATH),--filename $(KCL_RULES_MANIFEST_FILEPATH))
__KCL_LABELS__RULE= $(if $(KCL_RULE_LABELS_KEYVALUES),--labels $(KCL_RULE_LABELS_KEYVALUES))
__KCL_NAMESPACE__RULE= $(if $(KCL_RULE_NAMESPACE_NAME),--namespace $(KCL_RULE_NAMESPACE_NAME))
__KCL_NAMESPACE__RULES= $(if $(KCL_RULES_NAMESPACE_NAME),--namespace $(KCL_RULES_NAMESPACE_NAME))
__KCL_OUTPUT__RULE= $(if $(KCL_RULE_OUTPUT),--output $(KCL_RULE_OUTPUT))
__KCL_OUTPUT__RULES= $(if $(KCL_RULES_OUTPUT),--output $(KCL_RULES_OUTPUT))
__KCL_SELECTOR__RULES= $(if $(KCL_RULES_SELECTOR),--selector=$(KCL_RULES_SELECTOR))
__KCL_SORT_BY__RULES= $(if $(KCL_RULES_SORT_BY),--sort-by=$(KCL_RULES_SORT_BY))

# Customizations

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Istio::Rule ($(_KUBECTL_ISTIO_RULE_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Istio::Rule ($(_KUBECTL_ISTIO_RULE_MK_VERSION)) parameters:'
	@echo '    KCL_RULE_NAME=$(KCL_RULE_NAME)'
	@echo '    KCL_RULE_NAMESPACE_NAME=$(KCL_RULE_NAMESPACE_NAME)'
	@echo '    KCL_RULES_FIELDSELECTOR=$(KCL_RULES_FIELDSELECTOR)'
	@echo '    KCL_RULES_MANIFEST_DIRPATH=$(KCL_RULES_MANIFEST_DIRPATH)'
	@echo '    KCL_RULES_MANIFEST_FILENAME=$(KCL_RULES_MANIFEST_FILENAME)'
	@echo '    KCL_RULES_MANIFEST_FILEPATH=$(KCL_RULES_MANIFEST_FILEPATH)'
	@echo '    KCL_RULES_NAMESPACE_NAME=$(KCL_RULES_NAMESPACE_NAME)'
	@echo '    KCL_RULES_SELECTOR=$(KCL_RULES_SELECTOR)'
	@echo '    KCL_RULES_SET_NAME=$(KCL_RULES_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Istio::Rule ($(_KUBECTL_ISTIO_RULE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_rule                - Annotate a rule'
	@echo '    _kcl_apply_rules                  - Apply manifest for one-or-more rules'
	@echo '    _kcl_list_rules                   - List all rules'
	@echo '    _kcl_list_rules_set               - List a set of rules'
	@echo '    _kcl_show_rule                    - Show everything related to a rule'
	@echo '    _kcl_show_rule_description        - Show description of a rule'
	@echo '    _kcl_unapply_rules                - Un-apply manifest for one-or-more rules'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_rule:
	@$(INFO) '$(KCL_UI_LABEL)Annotating rule "$(KCL_RULE_NAME)" ...'; $(NORMAL)

_kcl_apply_rule: _kcl_apply_rules
_kcl_apply_rules:
	@$(INFO) '$(KCL_UI_LABEL)Applying amnifest for rule "$(KCL_RULE_NAME)" ...'; $(NORMAL)
	cat $(KCL_RULES_MANIFEST_FILEPATH)
	$(KUBECTL) apply $(__KCL_FILENAME__RULES) $(__KCL_NAMESPACE__RULES)

_kcl_create_rule:
	@$(INFO) '$(KCL_UI_LABEL)Creating rule "$(KCL_RULE_NAME)" ...'; $(NORMAL)

_kcl_delete_rule:
	@$(INFO) '$(KCL_UI_LABEL)Deleting rule "$(KCL_RULE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT delete services of exposed deployments'; $(NORMAL)
	$(KUBECTL) delete rule $(__KCL_NAMESPACE__RULE) $(KCL_RULE_NAME)

_kcl_edit_rule:
	@$(INFO) '$(KCL_UI_LABEL)Editing rule "$(KCL_RULE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit rule $(__KCL_NAMESPACE__RULE) $(KCL_RULE_NAME)

_kcl_explain_rule:
	@$(INFO) '$(KCL_UI_LABEL)Explaining rule object ...'; $(NORMAL)
	$(KUBECTL) explain rule

_kcl_label_rule:
	@$(INFO) '$(KCL_UI_LABEL)Labeling rule "$(KCL_RULE_NAME)" ...'; $(NORMAL)

_kcl_list_rules:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL rules ...'; $(NORMAL)
	$(KUBECTL) get rule --all-namespaces=true $(_X__KCL_NAMESPACE__RULES) $(__KCL_OUTPUT_RULES) $(_X__KCL_SELECTOR__RULES) $(__KCL_SORT_BY__RULES)

_kcl_list_rules_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing rules-set "$(KCL_RULES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Deployments are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get rule --all-namespaces=false $(__KCL_NAMESPACE__RULES) $(__KCL_OUTPUT__RULES) $(__KCL_SELECTOR__RULES) $(__KCL_SORT_BY__RULES)

_KCL_SHOW_RULE_TARGETS?= _kcl_show_rule_object _kcl_show_rule_state _kcl_show_rule_description
_kcl_show_rule: $(_KCL_SHOW_RULE_TARGETS)

_kcl_show_rule_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description rule "$(KCL_RULE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe rule $(__KCL_NAMESPACE__RULE) $(KCL_RULE_NAME)

_kcl_show_rule_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of rule "$(KCL_RULE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get rule $(__KCL_NAMESPACE__RULE) $(_X__KCL_OUTPUT__RULE) --output yaml $(KCL_RULE_NAME)

_kcl_show_rule_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of rule "$(KCL_RULE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get rule $(__KCL_NAMESPACE__RULE) $(_X__KCL_OUTPUT__RULE) $(KCL_RULE_NAME)

_kcl_unapply_rule: _kcl_unapply_rules
_kcl_unapply_rules:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more rules ...'; $(NORMAL)
	# cat $(KCL_RULE_MANIFEST_FILEPATH)
	$(KUBECTL) apply $(__KCL_FILENAME__RULES) $(__KCL_NAMESPACE__RULES)

_kcl_unlabel_rule:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling rule "$(KCL_RULE_NAME)" ...'; $(NORMAL)

_kcl_update_rule:
	@$(INFO) '$(KCL_UI_LABEL)Updating rule "$(KCL_RULE_NAME)" ...'; $(NORMAL)

_kcl_watch_rules:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL rules ...'; $(NORMAL)
	$(KUBECTL) get rules --all-namespaces=true --watch 

_kcl_watch_rules_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching rules-set "$(KCL_RULES_SET_NAME)" ...'; $(NORMAL)

_kcl_write_rule: _kcl_write_rules
_kcl_write_rules:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more rules ...'; $(NORMAL)
