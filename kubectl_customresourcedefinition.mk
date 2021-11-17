_KUBECTL_CUSTOMRESOURCEDEFINITION_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_CUSTOMRESOURCEDEFINITION_FIELDSELECTOR?= metadata
# KCL_CUSTOMRESOURCEDEFINITION_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_CUSTOMRESOURCEDEFINITION_NAME?= my-name
# KCL_CUSTOMRESOURCEDEFINITIONS_FIELDSELECTOR?= metadata.name=my-name
# KCL_CUSTOMRESOURCEDEFINITIONS_REGEX?= argoproj.io
# KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_DIRPATH?= ./in/
# KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILENAME?= manifest.yaml
# KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_STDINFLAG?= false
# KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_URL?= https://...
# KCL_CUSTOMRESOURCEDEFINITIONS_MANIFESTS_DIRPATH?= ./in/
# KCL_CUSTOMRESOURCEDEFINITIONS_SELECTOR?= release=istio
# KCL_CUSTOMRESOURCEDEFINITIONS_SET_NAME?= my-custom-resource-definitions-set

# Derived parameters
KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILEPATH?= $(if $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILENAME),$(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_DIRPATH)$(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILENAME))
KCL_CUSTOMRESOURCEDEFINITIONS_SET_NAME?= crds@$(KCL_CUSTOMRESOURCEDEFINITIONS_FIELDSELECTOR)@$(KCL_CUSTOMRESOURCEDEFINITIONS_SELECTOR)@$(KCL_CUSTOMRESOURCEDEFINITIONS_REGEX)

# Options
__KCL_ALL_NAMESPACES__CUSTOMRESOURCEDEFINITION=
__KCL_FILENAME__CUSTOMRESOURCEDEFINITIONS+= $(if $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILEPATH),--filename $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILEPATH))
__KCL_FILENAME__CUSTOMRESOURCEDEFINITIONS+= $(if $(filter true,$(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__CUSTOMRESOURCEDEFINITIONS+= $(if $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_URL),--filename $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_URL))
__KCL_FILENAME__CUSTOMRESOURCEDEFINITIONS+= $(if $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFESTS_DIRPATH),--filename $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFESTS_DIRPATH))
__KCL_FIELD_SELECTOR__CUSTOMRESOURCEDEFINITIONS= $(if $(KCL_CUSTOMRESOURCEDEFINITIONS_FIELDSELECTOR),--field-selector $(KCL_CUSTOMRESOURCEDEFINITIONS_FIELDSELECTOR))
__KCL_SELECTOR__CUSTOMRESOURCEDEFINITIONS= $(if $(KCL_CUSTOMRESOURCEDEFINITIONS_SELECTOR),--selector $(KCL_CUSTOMRESOURCEDEFINITIONS_SELECTOR))

# Customizations
_KCL_APPLY_CUSTOMRESOURCEDEFINITIONS_|?= #
_KCL_DIFF_CUSTOMRESOURCEDEFINITIONS_|?= $(_KCL_APPLY_CUSTOMRESOURCEDEFINITIONS_|)
_KCL_UNAPPLY_CUSTOMRESOURCEDEFINITIONS_|?= $(_KCL_APPLY_CUSTOMRESOURCEDEFINITIONS_|)
|_KCL_LIST_CUSTOMRESOURCEDEFINITIONS_SET?= | grep -E '$(KCL_CUSTOMRESOURCEDEFINITIONS_REGEX)'

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::CustomResourceDefinition ($(_KUBECTL_CUSTOMRESOURCEDEFINITION_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::CustomResourceDefinition ($(_KUBECTL_CUSTOMRESOURCEDEFINITION_MK_VERSION)) parameters:'
	@echo '    KCL_CUSTOMRESOURCEDEFINITION_LABELS_KEYVALUES=$(KCL_CUSTOMRESOURCEDEFINITION_LABELS_KEYVALUES)'
	@echo '    KCL_CUSTOMRESOURCEDEFINITION_NAME=$(KCL_CUSTOMRESOURCEDEFINITION_NAME)'
	@echo '    KCL_CUSTOMRESOURCEDEFINITIONS_FIELDSELECTOR=$(KCL_CUSTOMRESOURCEDEFINITIONS_FIELDSELECTOR)'
	@echo '    KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_DIRPATH=$(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_DIRPATH)'
	@echo '    KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILENAME=$(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILENAME)'
	@echo '    KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILEPATH=$(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILEPATH)'
	@echo '    KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_STDINFLAG=$(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_STDINFLAG)'
	@echo '    KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_URL=$(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_URL)'
	@echo '    KCL_CUSTOMRESOURCEDEFINITIONS_MANIFESTS_DIRPATH=$(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFESTS_DIRPATH)'
	@echo '    KCL_CUSTOMRESOURCEDEFINITIONS_REGEX=$(KCL_CUSTOMRESOURCEDEFINITIONS_REGEX)'
	@echo '    KCL_CUSTOMRESOURCEDEFINITIONS_SELECTOR=$(KCL_CUSTOMRESOURCEDEFINITIONS_SELECTOR)'
	@echo '    KCL_CUSTOMRESOURCEDEFINITIONS_SET_NAME=$(KCL_CUSTOMRESOURCEDEFINITIONS_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::CustomResourceDefinition ($(_KUBECTL_CUSTOMRESOURCEDEFINITION_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_customresourcedefinition           - Annotate the custom-resource-definition'
	@echo '    _kcl_apply_customresourcedefinitions             - Apply a manifest for one-or-more custom-resource-definitions'
	@echo '    _kcl_create_customresourcedefinition             - Create a new custom-resource-definition'
	@echo '    _kcl_delete_customresourcedefinition             - Delete an existing custom-resource-definition'
	@echo '    _kcl_diff_customresourcedefinitions              - Diff current-state with manifest of one-or-more custom-resource-definitions'
	@echo '    _kcl_edit_customresourcedefinition               - Edit a custom-resource-definition'
	@echo '    _kcl_explain_customresourcedefinition            - Explain the custom-resource-definition object'
	@echo '    _kcl_list_customresourcedefinitions              - List all custom-resource-definitions'
	@echo '    _kcl_list_customresourcedefinitions_set          - List a set of custom-resource-definitions'
	@echo '    _kcl_show_customresourcedefinition               - Show everything related to a custom-resource-definition'
	@echo '    _kcl_show_customresourcedefinition_description   - Show description of a custom-resource-definition'
	@echo '    _kcl_show_customresourcedefinition_instances     - Show instances of a custom-resource-definition'
	@echo '    _kcl_show_customresourcedefinition_object        - Show object of a custom-resource-definition'
	@echo '    _kcl_unapply_customresourcedefinitions           - Un-apply manifest for one-or-more custom-resource-definitions'
	@echo '    _kcl_unlabel_customresourcedefinition            - Un-label a custom-resource-definition'
	@echo '    _kcl_watch_customresourcedefinition              - Watch all custom-resource-definitions'
	@echo '    _kcl_watch_customresourcedefinition_set          - Watch a set of custom-resource-definitions'
	@echo '    _kcl_write_customresourcedefinitions             - Write manifest for one-or-more custom-resource-definitions'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_customresourcedefinition:
	@$(INFO) '$(KCL_UI_LABEL)Annotating custom-resource-definition "$(KCL_CUSTOMRESOURCEDEFINITION_NAME)" ...'; $(NORMAL)

_kcl_apply_customresourcedefinition: _kcl_apply_customresourcedefinitions
_kcl_apply_customresourcedefinitions:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more custom-resource-definitions ...'; $(NORMAL)
	$(if $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILEPATH),cat $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_CUSTOMRESOURCEDEFINITIONS_|)cat)
	$(if $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_URL),curl -L $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_URL))
	$(if $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFESTS_DIRPATH),ls -al $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_CUSTOMRESOURCEDEFINITIONS_|)$(KUBECTL) apply $(__KCL_FILENAME__CUSTOMRESOURCEDEFINITIONS)

_kcl_create_customresourcedefinition:
	@$(INFO) '$(KCL_UI_LABEL)Creating custom-resource-definition "$(KCL_CUSTOMRESOURCEDEFINITION_NAME)" ...'; $(NORMAL)

_kcl_delete_customresourcedefinition:
	@$(INFO) '$(KCL_UI_LABEL)DEleting custom-resource-definition "$(KCL_CUSTOMRESOURCEDEFINITION_NAME)" ...'; $(NORMAL)

_kcl_diff_customresourcedefinition: _kcl_diff_customresourcedefinitions
_kcl_diff_customresourcedefinitions:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more custom-resource-definitions ...'; $(NORMAL)
	@$(WARN) 'This operation submits the manifest to the cluster to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_CUSTOMRESOURCEDEFINITIONS_|)cat
	# curl -L $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_URL)
	# ls -al $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_CUSTOMRESOURCEDEFINITIONS_|)$(KUBECTL) diff $(__KCL_FILENAME__CUSTOMRESOURCEDEFINITIONS)

_kcl_edit_customresourcedefinition:
	@$(INFO) '$(KCL_UI_LABEL)Editing custom-resource-definition "$(KCL_CUSTOMRESOURCEDEFINITION_NAME)" ...'; $(NORMAL)

_kcl_explain_customresourcedefinition:
	@$(INFO) '$(KCL_UI_LABEL)Explaining custom-resource-definition object ...'; $(NORMAL)
	$(KUBECTL) explain customresourcedefinition

_kcl_label_customresourcedefinition:
	@$(INFO) '$(KCL_UI_LABEL)Labeling custom-resource-definition "$(KCL_CUSTOMRESOURCEDEFINITION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label customresourcedefinition $(KCL_CUSTOMRESOURCEDEFINITION_NAME) $(KCL_CUSTOMRESOURCEDEFINITION_LABELS_KEYVALUES)

_kcl_list_customresourcedefinitions:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL custom-resource-definitions ...'; $(NORMAL)
	$(KUBECTL) get customresourcedefinitions

_kcl_list_customresourcedefinitions_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing custom-resource-definitions-set "$(KCL_CUSTOMRESOURCEDEFINITIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Custom-resource-definitions are grouped based on provided field-selector, selector, and regex'; $(NORMAL)
	$(KUBECTL) get customresourcedefinitions $(__KCL_FIELD_SELECTOR__CUSTOMRESOURCEDEFINITIONS) $(__KCL_SELECTOR__CUSTOMRESOURCEDEFINITIONS) $(|_KCL_LIST_CUSTOMRESOURCEDEFINITIONS_SET)

_KCL_SHOW_CUSTOMRESOURCEDEFINITION_TARGETS?= _kcl_show_customresourcedefinition_instances _kcl_show_customresourcedefinition_object _kcl_show_customresourcedefinition_description
_KCL_SHOW_CUSTOMRESOURCEDEFINITION: $(_KCL_SHOW_CUSTOMRESOURCEDEFINITION_TARGETS)

_kcl_show_customresourcedefinition_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of custom-resource-definition "$(KCL_CUSTOMRESOURCEDEFINITION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get customresourcedefinition $(KCL_CUSTOMRESOURCEDEFINITION_NAME)

_kcl_show_customresourcedefinition_instances:
	@$(INFO) '$(KCL_UI_LABEL)Showing instances of custom-resource-definition "$(KCL_CUSTOMRESOURCEDEFINITION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get customresourcedefinition --all-namespaces=true $(KCL_CUSTOMRESOURCEDEFINITION_NAME)

_kcl_show_customresourcedefinition_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of custom-resource-definition "$(KCL_CUSTOMRESOURCEDEFINITION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe customresourcedefinition $(KCL_CUSTOMRESOURCEDEFINITION_NAME) 

_kcl_unapply_customresourcedefinition: _kcl_unapply_customresourcedefinitions
_kcl_unapply_customresourcedefinitions:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more custom-resource-definitions ...'; $(NORMAL)
	# cat $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_CUSTOMRESOURCEDEFINITIONS_|)cat
	# curl -L $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_URL)
	# ls -al $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_CUSTOMRESOURCEDEFINITIONS_|)$(KUBECTL) delete $(__KCL_FILENAME__CUSTOMRESOURCEDEFINITIONS)

_kcl_unlabel_customresourcedefinition:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling custom-resource-definition "$(KCL_CUSTOMRESOURCEDEFINITION_NAME)" ...'; $(NORMAL)

_kcl_watch_customresourcedefinitions:
	@$(INFO) '$(KCL_UI_LABEL)Watch custom-resource-definitions ...'; $(NORMAL)

_kcl_watch_customresourcedefinitions_set:
	@$(INFO) '$(KCL_UI_LABEL)Watch custom-resource-definitions-set "$(KCL_CUSTOMRESOURCEDEFINITIONS_SET_NAME)"  ...'; $(NORMAL)

_kcl_write_customresourcedefinitions:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more custom-resource-definitions ...'; $(NORMAL)
	$(WRITER) $(KCL_CUSTOMRESOURCEDEFINITIONS_MANIFEST_FILEPATH)

