_KUBECTL_LIMITRANGE_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_LIMITRANGE_MANIFEST_DIRPATH?= ./in/
# KCL_LIMITRANGE_MANIFEST_FILENAME?= limitrange.yaml
# KCL_LIMITRANGE_MANIFEST_FILEPATH?= ./in/limitrange.yaml
# KCL_LIMITRANGE_NAME?=
# KCL_LIMITRANGE_NAMESPACE_NAME?= default
# KCL_LIMITRANGES_FIELDSELECTOR?=
# KCL_LIMITRANGES_NAMESPACE_NAME?= default
# KCL_LIMITRANGES_SELECTOR?=
# KCL_LIMITRANGES_SET_NAME?= my-limit-ranges-set

# Derived parameters
KCL_LIMITRANGE_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_LIMITRANGE_MANIFEST_FILEPATH?= $(KCL_LIMITRANGE_MANIFEST_DIRPATH)$(KCL_LIMITRANGE_MANIFEST_FILENAME)
KCL_LIMITRANGE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_LIMITRANGE_NAMES?= $(KCL_LIMITRANGE_NAME)
KCL_LIMITRANGES_NAMESPACE_NAME?= $(KCL_LIMITRANGE_NAMESPACE_NAME)
KCL_LIMITRANGES_SET_NAME?= limitranges@$(KCL_LIMITRANGES_FILEDSELECTOR)@$(KCL_LIMITRANGES_SELECTOR)@$(KCL_LIMITRANGES_NAMESPACE_NAME)

# Options
__KCL_FILENAME__LIMITRANGE= $(if $(KCL_LIMITRANGE_MANIFEST_FILEPATH),--filename $(KCL_LIMITRANGE_AMNIFEST_FILEPATH))
__KCL_NAMESPACE__LIMITRANGE= $(if $(KCL_LIMITRANGE_NAMESPACE_NAME),--namespace $(KCL_LIMITRANGE_NAMESPACE_NAME))
__KCL_NAMESPACE__LIMITRANGES= $(if $(KCL_LIMITRANGES_NAMESPACE_NAME),--namespace $(KCL_LIMITRANGES_NAMESPACE_NAME))
__KCL_SELECTOR__LIMITRANGES= $(if $(KCL_LIMITRANGES_SELECTOR),--selector $(KCL_LIMITRANGES_SELECTOR))

# Customizations

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::LimitRange ($(_KUBECTL_LIMITRANGE_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::LimitRange ($(_KUBECTL_LIMITRANGE_MK_VERSION)) parameters:'
	@echo '    KCL_LIMITRANGE_MANIFEST_DIRPATH=$(KCL_LIMITRANGE_MANIFEST_DIRPATH)'
	@echo '    KCL_LIMITRANGE_MANIFEST_FILENAME=$(KCL_LIMITRANGE_MANIFEST_FILENAME)'
	@echo '    KCL_LIMITRANGE_MANIFEST_FILEPATH=$(KCL_LIMITRANGE_MANIFEST_FILEPATH)'
	@echo '    KCL_LIMITRANGE_NAME=$(KCL_LIMITRANGE_NAME)'
	@echo '    KCL_LIMITRANGE_NAMESPACE_NAME=$(KCL_LIMITRANGE_NAMESPACE_NAME)'
	@echo '    KCL_LIMITRANGES_FIELDSELECTOR=$(KCL_LIMITRANGES_FIELDSELECTOR)'
	@echo '    KCL_LIMITRANGES_NAMESPACE_NAME=$(KCL_LIMITRANGES_NAMESPACE_NAME)'
	@echo '    KCL_LIMITRANGES_SELECTOR=$(KCL_LIMITRANGES_SELECTOR)'
	@echo '    KCL_LIMITRANGES_SET_NAME=$(KCL_LIMITRANGES_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::LimitRange ($(_KUBECTL_LIMITRANGE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_limitrange                - Annotate a limit-range'
	@echo '    _kcl_apply_limitrange                   - Apply a manifest of one or more limit-ranges'
	@echo '    _kcl_create_limitrange                  - Create a new limit-range'
	@echo '    _kcl_delete_limitrange                  - Delete an existing limit-range'
	@echo '    _kcl_explain_limitrange                 - Explain the limit-range object'
	@echo '    _kcl_label_limitrange                   - Label a limit-range'
	@echo '    _kcl_list_limitranges                   - List all limit-ranges'
	@echo '    _kcl_list_limitranges_set               - List a set of limit-ranges'
	@echo '    _kcl_patch_limitrange                   - Patch a limit-range'
	@echo '    _kcl_show_limitrange                    - Show everything related to an limit-range'
	@echo '    _kcl_show_limitrange_description        - Show the description of an limit-range'
	@echo '    _kcl_unapply_limitrange                 - Un-apply a manifest of one or more limit-ranges'
	@echo '    _kcl_unlabel_limitrange                 - Un-label a limit-range'
	@echo '    _kcl_watch_limitranges                  - Watch all limit-ranges'
	@echo '    _kcl_watch_limitranges_set              - Watch a set of limit-ranges'
	@echo '    _kcl_write_limitranges                  - Write manifest for one-or-more limit-ranges'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotating_limitrange:
	@$(INFO) '$(KCL_UI_LABEL)Annotating limit-range "$(KCL_LIMITRANGE_NAME)" ...'; $(NORMAL)

_kcl_apply_limitrange:
	@$(INFO) '$(KCL_UI_LABEL)Applying limit-range "$(KCL_LIMITRANGE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) apply $(__KCL_FILENAME__LIMITRANGE) $(__KCL_NAMESPACE__LIMITRANGE)

_kcl_create_limitrange:
	@$(INFO) '$(KCL_UI_LABEL)Creating limit-range "$(KCL_LIMITRANGE_NAME)" ...'; $(NORMAL)

_kcl_delete_limitrange:
	@$(INFO) '$(KCL_UI_LABEL)Deleting limit-range "$(KCL_LIMITRANGE_NAME)" ...'; $(NORMAL)

_kcl_explain_limitrange:
	@$(INFO) '$(KCL_UI_LABEL)Explaining limit-range object ...'; $(NORMAL)
	$(KUBECTL) explain limitrange

_kcl_label_limitrange:
	@$(INFO) '$(KCL_UI_LABEL)Labeling limit-range "$(KCL_LIMITRANGE_NAME)" ...'; $(NORMAL)

_kcl_list_limitranges:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL limit-ranges ...'; $(NORMAL)
	$(KUBECTL) get limitranges --all-namespaces=true $(_X__KCL_NAMESPACE__LIMITRANGES)

_kcl_list_limitranges_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing limit-ranges-set "$(KCL_LIMITRANGES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Limit-ranges are grouped based on the provided namespace'; $(NORMAL)
	$(KUBECTL) get limitranges --all-namespaces=false $(__KCL_NAMESPACE__LIMITRANGES)

_KCL_SHOW_LIMITRANGE_TARGETS?= _kcl_show_limitrange_description
_kcl_show_limitrange: $(_KCL_SHOW_LIMITRANGE_TARGETS)

_kcl_show_limitrange_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description limit-range "$(KCL_LIMITRANGE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe limitrange $(__KCL_NAMESPACE__LIMITRANGE) $(KCL_LIMITRANGE_NAME)

_kcl_watch_limitranges:
	@$(INFO) '$(KCL_UI_LABEL)Watch ALL limit-ranges ...'; $(NORMAL)

_kcl_watch_limitranges_set:
	@$(INFO) '$(KCL_UI_LABEL)Watch limit-ranges-set "$(KCL_LIMITRANGES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Limit-ranges are grouped based on the provided namespace'; $(NORMAL)

_kcl_write_limitranges:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more limit-ranges ...'; $(NORMAL)
