_KUBECTL_DAEMONSET_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_DAEMONSET_ANNOTATIONS_KEYS?= key1 ...
# KCL_DAEMONSET_ANNOTATIONS_KEYVALUES?= key1=value1 ...
KCL_DAEMONSET_DRYRUN_MODE?= none
# KCL_DAEMONSET_FIELD_JSONPATH?= .spec
# KCL_DAEMONSET_LABELS_KEYS?= key1 ...
# KCL_DAEMONSET_LABELS_KEYVALUES?= key1=value1 ...
# KCL_DAEMONSET_NAME?= hello
# KCL_DAEMONSET_NAMESPACE_NAME?= default
# KCL_DAEMONSET_OUTPUT_FORMAT?= yaml
# KCL_DAEMONSET_PATCH?=
# KCL_DAEMONSET_PATCH_DIRPATH?= ./in/
# KCL_DAEMONSET_PATCH_FILENAME?= patch.yaml
# KCL_DAEMONSET_PATCH_FILEPATH?= ./in/patch.yaml
# KCL_DAEMONSET_PODS_SELECTOR?=
# KCL_DAEMONSETS_MANIFEST_DIRPATH?= ./in/
# KCL_DAEMONSETS_MANIFEST_FILENAME?= manifest.yml
# KCL_DAEMONSETS_MANIFEST_FILEPATH?= ./in/manifest.yml
KCL_DAEMONSETS_MANIFEST_STDINFLAG?= false
# KCL_DAEMONSETS_MANIFEST_URL?= http://...
# KCL_DAEMONSETS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_DAEMONSETS_NAMESPACE_NAME?= default
# KCL_DAEMONSETS_OUTPUT_FORMAT?= wide
# KCL_DAEMONSETS_SELECTOR?=
# KCL_DAEMONSETS_SET_NAME?= my-daemonsets-set
# KCL_DAEMONSETS_WATCH_ONLY?= true

# Derived parameters
KCL_DAEMONSET_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_DAEMONSET_PATCH_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_DAEMONSET_PATCH_FILEPATH?= $(if $(KCL_DAEMONSET_PATCH_FILENAME),$(KCL_DAEMONSET_PATCH_DIRPATH)$(KCL_DAEMONSET_PATCH_FILENAME))
KCL_DAEMONSETS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_DAEMONSETS_MANIFEST_FILEPATH?= $(if $(KCL_DAEMONSETS_MANIFEST_FILENAME),$(KCL_DAEMONSETS_MANIFEST_DIRPATH)$(KCL_DAEMONSETS_MANIFEST_FILENAME))
KCL_DAEMONSETS_NAMESPACE_NAME?= $(KCL_DAEMONSET_NAMESPACE_NAME)
KCL_DAEMONSETS_SET_NAME?= $(KCL_DAEMONSETS_NAMESPACE_NAME)

# Options
__KCL_ALL_NAMESPACES=
__KCL_DRY_RUN__DAEMONSET= $(if  $(KCL_DAEMONSET_DRYRUN_MODE),--dry-run $(KCL_DAEMONSET_DRYRUN_MODE))
__KCL_FILENAME__DAEMONSETS= $(if $(KCL_DAEMONSETS_MANIFEST_FILEPATH),--filename $(KCL_DAEMONSETS_MANIFEST_FILEPATH))
__KCL_FILENAME__DAEMONSETS= $(if $(filter true,$(KCL_DAEMONSETS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__DAEMONSETS= $(if $(KCL_DAEMONSETS_MANIFEST_URL),--filename $(KCL_DAEMONSETS_MANIFEST_URL))
__KCL_FILENAME__DAEMONSETS= $(if $(KCL_DAEMONSETS_MANIFESTS_DIRPATH),--filename $(KCL_DAEMONSETS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__DAEMONSET= $(if $(KCL_DAEMONSET_NAMESPACE_NAME),--namespace $(KCL_DAEMONSET_NAMESPACE_NAME))
__KCL_NAMESPACE__DAEMONSETS= $(if $(KCL_DAEMONSETS_NAMESPACE_NAME),--namespace $(KCL_DAEMONSETS_NAMESPACE_NAME))
__KCL_OUTPUT__DAEMONSET= $(if $(KCL_DAEMONSET_OUTPUT_FORMAT),--output $(KCL_DAEMONSET_OUTPUT_FORMAT))
__KCL_OUTPUT__DAEMONSETS= $(if $(KCL_DAEMONSETS_OUTPUT_FORMAT),--output $(KCL_DAEMONSETS_OUTPUT_FORMAT))
__KCL_SELECTOR__DAEMONSETS= $(if $(KCL_DAEMONSETS_SELECTOR),--selector $(KCL_DAEMONSETS_SELECTOR))
__KCL_TO_REVISION__DAEMONSET=

# Customizations
_KCL_APPLY_DAEMONSETS_|?= #
_KCL_DIFF_DAEMONSETS_|?= $(_KCL_APPLY_DAEMONSETS_|)
_KCL_UNAPPLY_DAEMONSETS_|?= $(_KCL_APPLY_DAEMONSETS_|)
|_KCL_CREATE_DAEMONSET?= # | tee manifest.yaml

# Macros
_kcl_get_daemonset_pods_names= $(call _kcl_get_daemonset_pods_names_S, $(KCL_DAEMONSET_PODS_SELECTOR))
_kcl_get_daemonset_pods_names_S= $(call _kcl_get_daemonset_pods_names_SN, $(1), $(KCL_DAEMONSET_NAMESPACE_NAME))
_kcl_get_daemonset_pods_names_SN= $(shell $(KUBECTL) get pods --namespace $(2) --selector=$(strip $(1)) --output=jsonpath="{.items..metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::DaemonSet ($(_KUBECTL_DAEMONSET_MK_VERSION)) macros:'
	@echo '    _kcl_get_daemonset_pod_names_{|S|SN}    - Get the names of the pods in the daemonset' 
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::DaemonSet ($(_KUBECTL_DAEMONSET_MK_VERSION)) parameters:'
	@echo '    KCL_DAEMONSET_ANNOTATIONS_KEYS=$(KCL_DAEMONSET_ANNOTATIONS_KEYS)'
	@echo '    KCL_DAEMONSET_ANNOTATIONS_KEYVALUES=$(KCL_DAEMONSET_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_DAEMONSET_LABELS_KEYS=$(KCL_DAEMONSET_LABELS_KEYS)'
	@echo '    KCL_DAEMONSET_LABELS_KEYVALUES=$(KCL_DAEMONSET_LABELS_KEYVALUES)'
	@echo '    KCL_DAEMONSET_DRYRUN_MODE=$(KCL_DAEMONSET_DRYRUN_MODE)'
	@echo '    KCL_DAEMONSET_FIELD_JSONPATH=$(KCL_DAEMONSET_FIELD_JSONPATH)'
	@echo '    KCL_DAEMONSET_NAME=$(KCL_DAEMONSET_NAME)'
	@echo '    KCL_DAEMONSET_NAMESPACE_NAME=$(KCL_DAEMONSET_NAMESPACE_NAME)'
	@echo '    KCL_DAEMONSET_PATCH=$(KCL_DAEMONSET_PATCH)'
	@echo '    KCL_DAEMONSET_PATCH_DIRPATH=$(KCL_DAEMONSET_PATCH_DIRPATH)'
	@echo '    KCL_DAEMONSET_PATCH_FILENAME=$(KCL_DAEMONSET_PATCH_FILENAME)'
	@echo '    KCL_DAEMONSET_PATCH_FILEPATH=$(KCL_DAEMONSET_PATCH_FILEPATH)'
	@echo '    KCL_DAEMONSET_PODS_SELECTOR=$(KCL_DAEMONSET_PODS_SELECTOR)'
	@echo '    KCL_DAEMONSETS_MANIFEST_DIRPATH=$(KCL_DAEMONSETS_MANIFEST_DIRPATH)'
	@echo '    KCL_DAEMONSETS_MANIFEST_FILENAME=$(KCL_DAEMONSETS_MANIFEST_FILENAME)'
	@echo '    KCL_DAEMONSETS_MANIFEST_FILEPATH=$(KCL_DAEMONSETS_MANIFEST_FILEPATH)'
	@echo '    KCL_DAEMONSETS_MANIFEST_STDINFLAG=$(KCL_DAEMONSETS_MANIFEST_STDINFLAG)'
	@echo '    KCL_DAEMONSETS_MANIFEST_URL=$(KCL_DAEMONSETS_MANIFEST_URL)'
	@echo '    KCL_DAEMONSETS_MANIFESTS_DIRPATH=$(KCL_DAEMONSETS_MANIFESTS_DIRPATH)'
	@echo '    KCL_DAEMONSETS_NAMESPACE_NAME=$(KCL_DAEMONSETS_NAMESPACE_NAME)'
	@echo '    KCL_DAEMONSETS_SELECTOR=$(KCL_DAEMONSETS_SELECTOR)'
	@echo '    KCL_DAEMONSETS_SET_NAME=$(KCL_DAEMONSETS_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::DaemonSet ($(_KUBECTL_DAEMONSET_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_daemonset                - Annotate a daemon-set'
	@echo '    _kcl_apply_daemonsets                  - Apply a manifest for one-or-more daemon-sets'
	@echo '    _kcl_create_daemonset                  - Create a new daemon-set'
	@echo '    _kcl_delete_daemonset                  - Delete an existing daemon-set'
	@echo '    _kcl_diff_daemonsets                   - Diff a manifest for one-or-more daemon-sets'
	@echo '    _kcl_edit_daemonset                    - Edit a daemon-set'
	@echo '    _kcl_explain_daemonset                 - Explain the daemon-set object'
	@echo '    _kcl_label_daemonset                   - Label a daemon-set'
	@echo '    _kcl_list_daemonsets                   - List all daemon-sets'
	@echo '    _kcl_list_daemonsets_set               - List a set of daemon-sets'
	@echo '    _kcl_patch_daemonset                   - Patch a daemon-set'
	@echo '    _kcl_pause_daemonset                   - Pause rollout of a daemon-set'
	@echo '    _kcl_resume_daemonset                  - Resume rollout of a daemon-set'
	@echo '    _kcl_rollback_daemonset                - Rollback a daemon-set to a previous version'
	@echo '    _kcl_restart_daemonset                 - Restart a daemon-set'
	@echo '    _kcl_show_daemonset                    - Show everything related to a daemon-set'
	@echo '    _kcl_show_daemonset_description        - Show the description of a daemon-set'
	@echo '    _kcl_show_daemonset_rollouthistory     - Show the rollout-history of a daemon-set'
	@echo '    _kcl_show_daemonset_rolloutstatus      - Show the rollout-status of a daemon-set'
	@echo '    _kcl_unannotate_daemonset              - Un-annotate a daemon-set'
	@echo '    _kcl_unapply_daemonsets                - Un-apply manifest for one-or-more daemon-sets'
	@echo '    _kcl_unlabel_daemonset                 - Un-label a daemon-set'
	@echo '    _kcl_watch_daemonsets                  - Watch all daemon-sets'
	@echo '    _kcl_watch_daemonsets_set              - Watch a set of daemon-sets'
	@echo '    _kcl_write_daemonsets                  - Write manifest for one-or-more daemon-sets'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_daemonset:
	@$(INFO) '$(KCL_UI_LABEL)Annotating daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate daemonset $(__KCL_NAMESPACE__DAEMONSET) $(KCL_DAEMONSET_NAME) $(KCL_DAEMONSET_ANNOTATIONS_KEYVALUES)

_kcl_apply_daemonset: _kcl_apply_daemonsets
_kcl_apply_daemonsets:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more daemon-sets ...'; $(NORMAL)
	$(if $(KCL_DAEMONSETS_MANIFEST_FILEPATH),cat $(KCL_DAEMONSETS_MANIFEST_FILEPATH))
	$(if $(KCL_DAEMONSETS_MANIFEST_URL),curl -L $(KCL_DAEMONSETS_MANIFEST_URL))
	$(if $(KCL_DAEMONSETS_MANIFESTS_DIRPATH),ls -al $(KCL_DAEMONSETS_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_DAEMONSETS_|)$(KUBECTL) apply $(__KCL_FILENAME__DAEMONSETS) $(__KCL_NAMESPACE__DAEMONSETS)

_kcl_create_daemonset:
	@$(INFO) '$(KCL_UI_LABEL)Creating daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create daemonset $(__KCL_DRY_RUN__DAEMONSET) $(__KCL_IMAGE__DAEMONSET) $(__KCL_NAMESPACE__DAEMONSET) $(__KCL_OUTPUT__DAEMONSET) $(KCL_DAEMONSET_NAME) $(|_KCL_CREATE_DAEMONSET)

_kcl_delete_daemonset:
	@$(INFO) '$(KCL_UI_LABEL)Deleting daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete daemonset $(__KCL_NAMESPACE__DAEMONSET) $(KCL_DAEMONSET_NAME)

_kcl_diff_daemonset: _kcl_diff_daemonsets
_kcl_diff_daemonsets:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more daemon-sets ...'; $(NORMAL)
	# cat $(KCL_DAEMONSETS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_DAEMONSETS_|)cat
	# curl -L $(KCL_DAEMONSETS_MANIFEST_URL)
	# ls -al $(KCL_DAEMONSETS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_DAEMONSETS_|)$(KUBECTL) diff $(__KCL_FILENAME__DAEMONSETS) $(__KCL_NAMESPACE__DAEMONSETS)

_kcl_edit_daemonset:
	@$(INFO) '$(KCL_UI_LABEL)Editing daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit daemonset $(__KCL_NAMESPACE__DAEMONSET) $(KCL_DAEMONSET_NAME)

_kcl_explain_daemonset:
	@$(INFO) '$(KCL_UI_LABEL)Explaining daemon-set object ...'; $(NORMAL)
	$(KUBECTL) explain daemonset$(KCL_DAEMONSET_FIELD_JSONPATH)

_kcl_label_daemonset:
	@$(INFO) '$(KCL_UI_LABEL)Labelling daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label daemonset $(__KCL_NAMESPACE__DAEMONSET) $(KCL_DAEMONSET_NAME) $(KCL_DAEMONSET_LABELS_KEYVALUES)

_kcl_list_daemonsets:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL daemon-sets ...'; $(NORMAL)
	$(KUBECTL) get daemonset --all-namespaces=true $(_X__KCL_NAMESPACE__DAEMONSETS) $(_X__KCL_SELECTOR__DAEMONSETS) $(_X_KCL_WATCH__DAEMONSETS) $(_X_KCL_WATCH_ONLY__DAEMONSETS)

_kcl_list_daemonsets_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing daemon-sets-set "$(KCL_DAEMONSETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Daemon-sets are grouped based on the provided namespace'; $(NORMAL)
	$(KUBECTL) get daemonsets --all-namespaces=false $(__KCL_NAMESPACE__DAEMONSETS) $(__KCL_SELECTOR__DAEMONSETS) $(_X_KCL_WATCH__DAEMONSETS) $(_X_KCL__WATCH_ONLY__DAEMONSETS)

_kcl_pause_daemonset:
	@$(INFO) '$(KCL_UI_LABEL)Pausing rollout of daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout pause daemonset $(__KCL_NAMESPACE__DAEMONSET) $(KCL_DAEMONSET_NAME)

_kcl_resume_daemonset:
	@$(INFO) '$(KCL_UI_LABEL)Resuming rollout of daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout resume daemonset $(__KCL_NAMESPACE__DAEMONSET) $(KCL_DAEMONSET_NAME)

_kcl_restart_daemonset:
	@$(INFO) '$(KCL_UI_LABEL)Rolling-back daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout restart daemonset $(__KCL_NAMESPACE__DAEMONSET) $(KCL_DAEMONSET_NAME)

_kcl_rollout_daemonset:
	@$(INFO) '$(KCL_UI_LABEL)Rolling out a new version of daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)

_KCL_SHOW_DAEMONSET_TARGETS?= _kcl_show_daemonset_rollouthistory _kcl_show_daemonset_rolloutstatus _kcl_show_daemonset_description
_kcl_show_daemonset: $(_KCL_SHOW_DAEMONSET_TARGETS)

_kcl_show_daemonset_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe daemonset $(__KCL_NAMESPACE__DAEMONSET) $(KCL_DAEMONSET_NAME)

_kcl_show_daemonset_rollouthistory:
	@$(INFO) '$(KCL_UI_LABEL)Showing rollout-history of daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout history daemonset $(__KCL_NAMESPACE__DAEMONSET) $(KCL_DAEMONSET_NAME)

_kcl_show_daemonset_rolloutstatus:
	@$(INFO) '$(KCL_UI_LABEL)Showing rollout-status of daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout status daemonset $(__KCL_NAMESPACE__DAEMONSET) $(KCL_DAEMONSET_NAME)

_kcl_unannotate_daemonset:
	@$(INFO) '$(KCL_UI_LABEL)Un-annotating daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate $(__KCL_NAMESPACE__DAEMONSET) $(KCL_DAEMONSET_NAME) $(foreach K,$(KCL_DAEMONSET_ANNOTATIONS_LEYS), $(K)-)

_kcl_unapply_daemonset: _kcl_unapply_daemonsets
_kcl_unapply_daemonsets:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more daemon-sets...'; $(NORMAL)
	# cat $(KCL_DAEMONSETS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_DAEMONSETS_|)cat
	# curl -L $(KCL_DAEMONSETS_MANIFEST_URL)
	# ls -al $(KCL_DAEMONSETS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_DAEMONSETS_|)$(KUBECTL) delete $(__KCL_FILENAME__DAEMONSETS) $(__KCL_NAMESPACE__DAEMONSETS)

_kcl_unlabel_daemonset:
	@$(INFO) '$(KCL_UI_LABEL)Unlabeling daemon-set "$(KCL_DAEMONSET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label $(__KCL_NAMESPACE__DAEMONSET) $(KCL_DAEMONSET_NAME) $(foreach K,$(KCL_DAEMONSET_LABELS_LEYS), $(K)-)

_kcl_watch_daemonsets:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL daemon-sets ...'; $(NORMAL)

_kcl_watch_daemonsets_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching daemon-sets-set "$(KCL_DAEMONSETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Daemon-sets are grouped based on the provided namespace'; $(NORMAL)

_kcl_write_daemonsets:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more daemon-sets ...'; $(NORMAL)
	$(WRITER) $(KCL_DAEMONSETS_MANIFEST_FILEPATH)
