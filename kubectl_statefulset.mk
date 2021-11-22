_KUBECTL_STATEFULSET_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_STATEFULSET_ANNOTATIONS_KEYS?= key1 ...
# KCL_STATEFULSET_ANNOTATIONS_KEYVALUES?= key1=value1 ...
# KCL_STATEFULSET_FIELD_JSONPATH?= .spec
# KCL_STATEFULSET_LABELS_KEYS?= key1 ...
# KCL_STATEFULSET_LABELS_KEYVALUES?= key1=value1 ...
# KCL_STATEFULSET_NAME?= my-stateful-set 
# KCL_STATEFULSET_NAMESPACE_NAME?= default
# KCL_STATEFULSET_PATCH?= "$(cat patch.yaml)"
# KCL_STATEFULSET_PATCH_DIRPATH?= ./in/
# KCL_STATEFULSET_PATCH_FILENAME?= patch.yaml
# KCL_STATEFULSET_PATCH_FILEPATH?= ./in/patch.yaml
# KCL_STATEFULSET_REPLICAS_COUNT?= 3
# KCL_STATEFULSETS_MANIFEST_DIRPATH?= ./in/ 
# KCL_STATEFULSETS_MANIFEST_FILENAME?= statefulset.yml
# KCL_STATEFULSETS_MANIFEST_FILEPATH?= ./in/statefulset.yml
KCL_STATEFULSETS_MANIFEST_STDINFLAG?= false
# KCL_STATEFULSETS_MANIFEST_URL?= http://...
# KCL_STATEFULSETS_MANIFESTS_DIRPATH?=
# KCL_STATEFULSETS_NAMESPACE_NAME?= default
# KCL_STATEFULSETS_SELECTOR?=
# KCL_STATEFULSETS_SET_NAME?= my-statefulsets-set

# Derived parameters
KCL_STATEFULSET_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_STATEFULSET_MANIFEST_FILEPATH?= $(KCL_STATEFULSET_MANIFEST_DIRPATH)$(KCL_STATEFULSET_MANIFEST_FILENAME)
KCL_STATEFULSET_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_STATEFULSETS_NAMESPACE_NAME?= $(KCL_STATEFULSET_NAMESPACE_NAME)
KCL_STATEFULSETS_SET_NAME?= statefulsets@$(KCL_STATEFULSETS_NAMESPACE_NAME)

# Options
__KCL_FILENAME__STATEFULSETS+= $(if $(KCL_STATEFULSETS_MANIFEST_FILEPATH),--filename $(KCL_STATEFULSETS_MANIFEST_FILEPATH))
__KCL_FILENAME__STATEFULSETS+= $(if $(filter true,$(KCL_STATEFULSETS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__STATEFULSETS+= $(if $(KCL_STATEFULSETS_MANIFEST_URL),--filename $(KCL_STATEFULSETS_MANIFEST_URL))
__KCL_FILENAME__STATEFULSETS+= $(if $(KCL_STATEFULSETS_MANIFESTS_DIRPATH),--filename $(KCL_STATEFULSETS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__STATEFULSET= $(if $(KCL_STATEFULSET_NAMESPACE_NAME),--namespace $(KCL_STATEFULSET_NAMESPACE_NAME))
__KCL_NAMESPACE__STATEFULSETS= $(if $(KCL_STATEFULSETS_NAMESPACE_NAME),--namespace $(KCL_STATEFULSETS_NAMESPACE_NAME))
__KCL_REPLICAS__STATEFULSET= $(if $(KCL_STATEFULSET_REPLICAS_COUNT),--replicas $(KCL_STATEFULSET_REPLICAS_COUNT))
__KCL_SELECTOR__STATEFULSETS= $(if $(KCL_STATEFULSETS_SELECTOR),--selector $(KCL_STATEFULSETS_SELECTOR))

# Customizations
_KCL_APPLY_STATEFULSETS_|?= #-#
_KCL_DIFF_STATEFULSETS_|?= $(_KCL_APPLY_STATEFULSETS_|)
_KCL_UNAPPLY_STATEFULSETS_|?= $(_KCL_APPLY_STATEFULSETS_|)
|_KCL_CREATE_STATEFULSET?= # | tee manifest.yaml

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::StatefulSet ($(_KUBECTL_STATEFULSET_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::StatefulSet ($(_KUBECTL_STATEFULSET_MK_VERSION)) parameters:'
	@echo '    KCL_STATEFULSET_ANNOTATIONS_KEYS=$(KCL_STATEFULSET_ANNOTATIONS_KEYS)'
	@echo '    KCL_STATEFULSET_ANNOTATIONS_KEYVALUES=$(KCL_STATEFULSET_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_STATEFULSET_FIELD_JSONPATH=$(KCL_STATEFULSET_FIELD_JSONPATH)'
	@echo '    KCL_STATEFULSET_LABELS_KEYS=$(KCL_STATEFULSET_LABELS_KEYS)'
	@echo '    KCL_STATEFULSET_LABELS_KEYVALUES=$(KCL_STATEFULSET_LABELS_KEYVALUES)'
	@echo '    KCL_STATEFULSET_NAME=$(KCL_STATEFULSET_NAME)'
	@echo '    KCL_STATEFULSET_NAMESPACE_NAME=$(KCL_STATEFULSET_NAMESPACE_NAME)'
	@echo '    KCL_STATEFULSET_PATCH=$(KCL_STATEFULSET_PATCH)'
	@echo '    KCL_STATEFULSET_PATCH_DIRPATH=$(KCL_STATEFULSET_PATCH_DIRPATH)'
	@echo '    KCL_STATEFULSET_PATCH_FILENAME=$(KCL_STATEFULSET_PATCH_FILENAME)'
	@echo '    KCL_STATEFULSET_PATCH_FILEPATH=$(KCL_STATEFULSET_PATCH_FILEPATH)'
	@echo '    KCL_STATEFULSET_REPLICAS_COUNT=$(KCL_STATEFULSET_REPLICAS_COUNT)'
	@echo '    KCL_STATEFULSETS_MANIFEST_DIRPATH=$(KCL_STATEFULSETS_MANIFEST_DIRPATH)'
	@echo '    KCL_STATEFULSETS_MANIFEST_FILENAME=$(KCL_STATEFULSETS_MANIFEST_FILENAME)'
	@echo '    KCL_STATEFULSETS_MANIFEST_FILEPATH=$(KCL_STATEFULSETS_MANIFEST_FILEPATH)'
	@echo '    KCL_STATEFULSETS_MANIFEST_STDINFLAG=$(KCL_STATEFULSETS_MANIFEST_STDINFLAG)'
	@echo '    KCL_STATEFULSETS_MANIFEST_URL=$(KCL_STATEFULSETS_MANIFEST_URL)'
	@echo '    KCL_STATEFULSETS_MANIFESTS_DIRPATH=$(KCL_STATEFULSETS_MANIFESTS_DIRPATH)'
	@echo '    KCL_STATEFULSETS_NAMESPACE_NAME=$(KCL_STATEFULSETS_NAMESPACE_NAME)'
	@echo '    KCL_STATEFULSETS_SET_NAME=$(KCL_STATEFULSETS_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::StatefulSet ($(_KUBECTL_STATEFULSET_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_statefulset               - Annotate a stateful-set'
	@echo '    _kcl_apply_statefulsets                 - Apply a manifest for a new stateful-set'
	@echo '    _kcl_create_statefulset                 - Create a new stateful-set'
	@echo '    _kcl_delete_statefulset                 - Delete an existing stateful-set'
	@echo '    _kcl_diff_statefulsets                  - Diff manifest for one-or-more stateful-sets'
	@echo '    _kcl_edit_statefulset                   - Edit a stateful-set'
	@echo '    _kcl_explain_statefulset                - Explain the stateful-set object'
	@echo '    _kcl_label_statefulset                  - Label a stateful-set'
	@echo '    _kcl_list_statefulsets                  - List all stateful-sets'
	@echo '    _kcl_list_statefulsets_set              - List a set of stateful-sets'
	@echo '    _kcl_pause_statefulset                  - Pause rollout of a stateful-set'
	@echo '    _kcl_patch_statefulset                  - Patch a stateful-set'
	@echo '    _kcl_read_statefulsets                  - Read a manifest for one-or-more stateful-sets'
	@echo '    _kcl_restart_statefulset                - Restart rollout of a stateful-set'
	@echo '    _kcl_resume_statefulset                 - Resume rollout of a stateful-set'
	@echo '    _kcl_rollback_statefulset               - Rollback rollout of a stateful-set'
	@echo '    _kcl_scale_statefulset                  - Scale a stateful-set'
	@echo '    _kcl_show_statefulset                   - Show everything related to a stateful-set'
	@echo '    _kcl_show_statefulset_description       - Show description of a stateful-set'
	@echo '    _kcl_show_statefulset_rollouthistory    - Show the rollout-history of a stateful-set'
	@echo '    _kcl_show_statefulset_rolloutstatus     - Show the rollout-status of a stateful-set'
	@echo '    _kcl_unapply_statefulsets               - Un-apply a manifest of a new stateful-set'
	@echo '    _kcl_unannotate_statefulset             - Un-nnotate a stateful-set'
	@echo '    _kcl_unlabel_statefulset                - Un-label a stateful-set'
	@echo '    _kcl_watch_statefulsets                 - Watch all stateful-sets'
	@echo '    _kcl_watch_statefulsets_set             - Watch a set of stateful-sets'
	@echo '    _kcl_write_statefulsets                 - Write a manifest for one-or-more stateful-sets'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Annotating stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME) $(KCL_STATEFULSET_ANNOTATIONS_KEYVALUES)

_kcl_apply_statefulset: _kcl_apply_statefulsets
_kcl_apply_statefulsets:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more stateful-sets ...'; $(NORMAL)
	$(if $(KCL_STATEFULSETS_MANIFEST_FILEPATH), cat $(KCL_STATEFULSETS_MANIFEST_FILEPATH); echo)
	$(if $(filter true,$(KCL_STATEFULSETS_MANIFEST_STDINFLAG)), $(_KCL_APPLY_STATEFULSETS_|)cat )
	$(if $(KCL_STATEFULSETS_MANIFEST_URL), curl -L $(KCL_STATEFULSETS_MANIFEST_URL); echo )
	$(if $(KCL_STATEFULSETS_MANIFESTS_DIRPATH), ls -al $(KCL_STATEFULSETS_MANIFESTS_DIRPATH); echo)
	$(_KCL_APPLY_STATEFULSETS_|)$(KUBECTL) apply $(__KCL_FILENAME__STATEFULSETS) $(__KCL_NAMESPACE__STATEFULSETS)

_kcl_create_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Creating stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) create statefulset $(__DRY_RUN__STATEFULSET) $(__KCL_NAMESPACE__STATEFULSET) $(__KCL_OUTPUT__STATEFULSET) $(KCL_STATEFULSET_NAME) $(|_KCL_CREATE_STATEFULSET)

_kcl_delete_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Applying stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete statefulset $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME)

_kcl_diff_statefulset: _kcl_diff_statefulsets
_kcl_diff_statefulsets:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster state with manifest for one-or-more stateful-sets..'; $(NORMAL)
	@$(WARN) 'This operation submits the manifest to the cluster to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_STATEFULSETS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_STATEFULSETS_|)cat
	# curl -L $(KCL_STATEFULSETS_MANIFEST_URL)
	# ls -al $(KCL_STATEFULSETS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_STATEFULSETS_|)$(KUBECTL) diff $(__KCL_FILENAME__STATEFULSETS) $(__KCL_NAMESPACE__STATEFULSETS)

_kcl_edit_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Editing stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit statefulset $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME)

_kcl_explain_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Explaining stateful-set object ...'; $(NORMAL)
	$(KUBECTL) explain statefulset$(KCL_STATEFULSET_FIELD_JSONPATH)

_kcl_label_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Labelling stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label statefulset $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME) $(KCL_STATEFULSET_LABELS_KEYVALUES)

_kcl_list_statefulsets:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL stateful-sets ...'; $(NORMAL)
	$(KUBECTL) get statefulsets --all-namespaces=true $(_X__KCL_STATEFULSETS_NAMESPACE_NAME)

_kcl_list_statefulsets_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing stateful-sets-set "$(KCL_STATEFULSETS_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Stateful-sets are grouped based on namespace, selector, ...'; $(NORMAL)
	$(KUBECTL) get statefulsets --all-namespaces=false $(__KCL_NAMESPACE__STATEFULSETS) $(__KCL_SELECTOR__STATEFULSETS)

_kcl_patch_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Patching stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) patch statefulset $(__KCL_NAMESPACE__STATEFULSET) $(__KCL_PATCH__STATEFULSET) $(__KCL_PATCH_FILE__STATEFULSET) $(KCL_STATEFULSET_NAME)

_kcl_pause_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Pausing rollout of stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout pause statefulset $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME)

_kcl_read_statefulset: _kcl_read_statefulsets
_kcl_read_statefulsets:
	@$(INFO) '$(KCL_UI_LABEL)Reading manifest for one-or-more stateful-sets ...'; $(NORMAL)
	$(READER) $(KCL_STATEFULSETS_MANIFEST_FILEPATH)

_kcl_restart_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Restarting rollout of stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout restart statefulset $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME)

_kcl_resume_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Resuming rollout of stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout resume statefulset $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME)

_kcl_rollback_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Rolling back rollout of stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout undo statefulset $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME)

_kcl_scale_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Scaling stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) scale statefulset $(__KCL_NAMESPACE__STATEFULSET) $(__KCL_REPLICAS__STATEFULSET) $(KCL_STATEFULSET_NAME)

_KCL_SHOW_STATEFULSET_TARGETS?=: _kcl_show_statefulset_rollouthistory _kcl_show_statefulset_rolloutstatus _kcl_show_statefulset_description
_kcl_show_statefulset :: $(_KCL_SHOW_STATEFULESET_TARGETS)

_kcl_show_statefulset_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe statefulset $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME) 

_kcl_show_statefulset_rollouthistory:
	@$(INFO) '$(KCL_UI_LABEL)Showing rollout-history of stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout history statefulset $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME) 

_kcl_show_statefulset_rolloutstatus:
	@$(INFO) '$(KCL_UI_LABEL)Showing rollout-status of stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout status statefulset $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME) 

_kcl_unannotate_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Un-annotating stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label statefulset $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME) $(foreach K,$(KCL_STATEFULSET_ANNOTATIONS_KEYS), $(K)-)

_kcl_unapply_statefulset: _kcl_unapply_statefulsets
_kcl_unapply_statefulsets:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more stateful-sets ...'; $(NORMAL)
	# cat $(KCL_STATEFULSETS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_STATEFULSETS_|)cat
	# curl -L $(KCL_STATEFULSETS_MANIFEST_URL)
	# ls -al $(KCL_STATEFULSETS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_STATEFULSETS_|)$(KUBECTL) delete $(__KCL_FILENAME__STATEFULSET) $(__KCL_NAMESPACE__STATEFULSET)

_kcl_unlabel_statefulset:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling stateful-set "$(KCL_STATEFULSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label statefulset $(__KCL_NAMESPACE__STATEFULSET) $(KCL_STATEFULSET_NAME) $(foreach K,$(KCL_STATEFULSET_LABELS_KEYS), $(K)-)

_kcl_watch_statefulsets:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL stateful-sets ...'; $(NORMAL)

_kcl_watch_statefulsets_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching stateful-sets-set "$(KCL_STATEFULSETS_SET_NAME)"  ...'; $(NORMAL)

_kcl_write_statefulset: _kcl_write_statefulsets
_kcl_write_statefulsets:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more stateful-sets ...'; $(NORMAL)
	$(WRITER) $(KCL_STATEFULSETS_MANIFEST_FILEPATH)
