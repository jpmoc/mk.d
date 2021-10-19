_KUBECTL_QUOTA_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_QUOTA_NAME?=
# KCL_QUOTA_NAMESPACE_NAME?= default
# KCL_QUOTAS_FIELDSELECTOR?=
# KCL_QUOTAS_MANIFEST_DIRPATH?= ./in/
# KCL_QUOTAS_MANIFEST_FILENAME?= manifest.yaml
# KCL_QUOTAS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_QUOTAS_MANIFEST_STDINFLAG?= false
# KCL_QUOTAS_MANIFEST_URL?= http://...
# KCL_QUOTAS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_QUOTAS_NAMESPACE_NAME?= default
# KCL_QUOTAS_SELECTOR?=
# KCL_QUOTAS_SET_NAME?= my-quotas-set

# Derived parameters
KCL_QUOTA_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_QUOTAS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_QUOTAS_MANIFEST_FILEPATH?= $(if $(KCL_QUOTAS_MANIFEST_FILENAME),$(KCL_QUOTAS_MANIFEST_DIRPATH)$(KCL_QUOTAS_MANIFEST_FILENAME))
KCL_QUOTAS_NAMESPACE_NAME?= $(KCL_QUOTA_NAMESPACE_NAME)
KCL_QUOTAS_SET_NAME?= quotas@$(KCL_QUOTAS_FILEDSELECTOR)@$(KCL_QUOTAS_SELECTOR)@$(KCL_QUOTAS_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__QUOTAS= $(if $(KCL_QUOTAS_MANIFEST_FILEPATH),--filename $(KCL_QUOTAS_MANIFEST_FILEPATH))
__KCL_FILENAME__QUOTAS= $(if $(filter true,$(KCL_QUOTAS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__QUOTAS= $(if $(KCL_QUOTAS_MANIFEST_URL),--filename $(KCL_QUOTAS_MANIFEST_URL))
__KCL_FILENAME__QUOTAS= $(if $(KCL_QUOTAS_MANIFESTS_DIRPATH),--filename $(KCL_QUOTAS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__QUOTA= $(if $(KCL_QUOTA_NAMESPACE_NAME),--namespace $(KCL_QUOTA_NAMESPACE_NAME))
__KCL_NAMESPACE__QUOTAS= $(if $(KCL_QUOTAS_NAMESPACE_NAME),--namespace $(KCL_QUOTAS_NAMESPACE_NAME))
__KCL_SELECTOR__QUOTAS= $(if $(KCL_QUOTAS_SELECTOR),--selector $(KCL_QUOTAS_SELECTOR))

# UI parameters
_KCL_APPLY_QUOTAS_|?= #
_KCL_DIFF_QUOTAS_|?= $(_KCL_APPLY_QUOTAS_|)
_KCL_UNAPPLY_QUOTAS_|?= $(_KCL_APPLY_QUOTAS_|)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Quota ($(_KUBECTL_QUOTA_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Quota ($(_KUBECTL_QUOTA_MK_VERSION)) parameters:'
	@echo '    KCL_QUOTA_NAME=$(KCL_QUOTA_NAME)'
	@echo '    KCL_QUOTA_NAMESPACE_NAME=$(KCL_QUOTA_NAMESPACE_NAME)'
	@echo '    KCL_QUOTAS_FIELDSELECTOR=$(KCL_QUOTAS_FIELDSELECTOR)'
	@echo '    KCL_QUOTAS_MANIFEST_DIRPATH=$(KCL_QUOTAS_MANIFEST_DIRPATH)'
	@echo '    KCL_QUOTAS_MANIFEST_FILENAME=$(KCL_QUOTAS_MANIFEST_FILENAME)'
	@echo '    KCL_QUOTAS_MANIFEST_FILEPATH=$(KCL_QUOTAS_MANIFEST_FILEPATH)'
	@echo '    KCL_QUOTAS_MANIFEST_STDINFLAG=$(KCL_QUOTAS_MANIFEST_STDINFLAG)'
	@echo '    KCL_QUOTAS_MANIFEST_URL=$(KCL_QUOTAS_MANIFEST_URL)'
	@echo '    KCL_QUOTAS_MANIFESTS_DIRPATH=$(KCL_QUOTAS_MANIFESTS_DIRPATH)'
	@echo '    KCL_QUOTAS_NAMESPACE_NAME=$(KCL_QUOTAS_NAMESPACE_NAME)'
	@echo '    KCL_QUOTAS_SELECTOR=$(KCL_QUOTAS_SELECTOR)'
	@echo '    KCL_QUOTAS_SET_NAME=$(KCL_QUOTAS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Quota ($(_KUBECTL_QUOTA_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_quota                - Annotate a quota'
	@echo '    _kcl_apply_quotas                  - Apply manifest for one-or-more quotas'
	@echo '    _kcl_create_quota                  - Create a new quota'
	@echo '    _kcl_delete_quota                  - Delete an existing quota'
	@echo '    _kcl_diff_quotas                   - Diff manifest for one-or-more quotas'
	@echo '    _kcl_edit_quota                    - Edit a quota'
	@echo '    _kcl_explain_quota                 - Explain the quota object'
	@echo '    _kcl_label_quota                   - Label a quota'
	@echo '    _kcl_show_quota                    - Show everything related to an quota'
	@echo '    _kcl_show_quota_description        - Show the description of an quota'
	@echo '    _kcl_unapply_quotas                - Un-apply manifest for one-or-more quotas'
	@echo '    _kcl_unlabel_quota                 - Un-label a quota'
	@echo '    _kcl_update_quota                  - Update a quota'
	@echo '    _kcl_view_quotas                   - View all quotas'
	@echo '    _kcl_view_quotas_set               - View a set of quotas'
	@echo '    _kcl_watch_quotas                  - Watch all quotas'
	@echo '    _kcl_watch_quotas_set              - Watch a set of quotas'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotating_quota:
	@$(INFO) '$(KCL_UI_LABEL)Annotating quota "$(KCL_QUOTA_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate ...

_kcl_apply_quota: _kcl_apply_quotas
_kcl_apply_quotas:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more quotas ...'; $(NORMAL)
	# cat $(KCL_QUOTAS_MANIFEST_FILENAME)
	# $(_KCL_APPLY_QUOTAS_|)cat
	# curl -L $(KCL_QUOTAS_MANIFEST_URL)
	# ls -al $(KCL_QUOTAS_MANIFESTS_DIRPATH)
	$(_KCL_APPLY_QUOTAS_|)$(KUBECTL) apply $(__KCL_FILENAME__QUOTAS) $(__KCL_NAMESPACE__QUOTAS)

_kcl_create_quota:
	@$(INFO) '$(KCL_UI_LABEL)Creating quota "$(KCL_QUOTA_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) create ...

_kcl_delete_quota:
	@$(INFO) '$(KCL_UI_LABEL)Deleting quota "$(KCL_QUOTA_NAME)" ...'; $(NORMAL)

_kcl_diff_quota: _kcl_diff_quotas
_kcl_diff_quotas:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more quotas ...'; $(NORMAL)
	# cat $(KCL_QUOTAS_MANIFEST_FILENAME)
	# $(_KCL_DIFF_QUOTAS_|)cat
	# curl -L $(KCL_QUOTAS_MANIFEST_URL)
	# ls -al $(KCL_QUOTAS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_QUOTAS_|)$(KUBECTL) diff $(__KCL_FILENAME__QUOTAS) $(__KCL_NAMESPACE__QUOTAS)

_kcl_edit_quota:
	@$(INFO) '$(KCL_UI_LABEL)Editing quota "$(KCL_QUOTA_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit quota $(__KCL_NAMESPACE__QUOTA) $(KCL_QUOTA_NAME)

_kcl_explain_quota:
	@$(INFO) '$(KCL_UI_LABEL)Explaining quota object ...'; $(NORMAL)
	$(KUBECTL) explain quota

_kcl_label_quota:
	@$(INFO) '$(KCL_UI_LABEL)Labeling quota "$(KCL_QUOTA_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_show_quota: _kcl_show_quota_description

_kcl_show_quota_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description quota "$(KCL_QUOTA_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe quota $(__KCL_NAMESPACE__QUOTA) $(KCL_QUOTA_NAME)

_kcl_unapply_quota: _kcl_unapply_quotas
_kcl_unapply_quotas:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more quotas ...'; $(NORMAL)
	# cat $(KCL_QUOTAS_MANIFEST_FILENAME)
	# $(_KCL_UNAPPLY_QUOTAS_|)cat
	# curl -L $(KCL_QUOTAS_MANIFEST_URL)
	# ls -al $(KCL_QUOTAS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_QUOTAS_|)$(KUBECTL) delete $(__KCL_FILENAME__QUOTAS) $(__KCL_NAMESPACE__QUOTAS)

_kcl_unlabel_quota:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling quota "$(KCL_QUOTA_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_update_quota:
	@$(INFO) '$(KCL_UI_LABEL)Unpdating quota "$(KCL_QUOTA_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) patch ...

_kcl_view_quotas:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL quotas ...'; $(NORMAL)
	$(KUBECTL) get quota --all-namespaces=true $(_X__KCL_NAMESPACE__QUOTAS)

_kcl_view_quotas_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing quotas-set "$(KCL_QUOTAS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Quotas are grouped based on the provided namespace'; $(NORMAL)
	$(KUBECTL) get quota --all-namespaces=false $(__KCL_NAMESPACE__QUOTAS)

_kcl_watch_quotas:
	@$(INFO) '$(KCL_UI_LABEL)Watch ALL quotas ...'; $(NORMAL)

_kcl_watch_quotas_set:
	@$(INFO) '$(KCL_UI_LABEL)Watch quotas-set "$(KCL_QUOTAS_SET_NAME)" ...'; $(NORMAL)
