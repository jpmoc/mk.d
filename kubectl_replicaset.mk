_KUBECTL_REPLICASET_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_REPLICASET_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_REPLICASET_NAME?=
# KCL_REPLICASET_NAMESPACE_NAME?=
# KCL_REPLICASET_POD_NAMES?=
# KCL_REPLICASET_SSH_SHELL?= /bin/bash
# KCL_REPLICASETS_MANIFEST_DIRPATH?= ./in/
# KCL_REPLICASETS_MANIFEST_FILENAME?= manifest.yaml
# KCL_REPLICASETS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_REPLICASETS_MANIFEST_STDINFLAG?= false
# KCL_REPLICASETS_MANIFEST_URL?= http://...
# KCL_REPLICASETS_MANIFESTS_DIRPATH?=
# KCL_REPLICASETS_NAMESPACE_NAME?=
# KCL_REPLICASETS_SET_NAME?=

# Derived parameters
KCL_REPLICASET_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_REPLICASETS_NAMESPACE_NAME?= $(KCL_REPLICASET_NAMESPACE_NAME)
KCL_REPLICASET_SSH_SHELL?= $(KCL_POD_SSH_SHELL)
KCL_REPLICASETS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_REPLICASETS_MANIFEST_FILEPATH?= $(KCL_REPLICASETS_MANIFEST_DIRPATH)$(KCL_REPLICASETS_MANIFEST_FILENAME)

# Option parameters
__KCL_FILENAME__REPLICASETS?= $(if $(KCL_REPLICASETS_MANIFEST_FILEPATH),--filename $(KCL_REPLICASETS_MANIFEST_FILEPATH))
__KCL_FILENAME__REPLICASETS?= $(if $(filter true,$(KCL_REPLICASETS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__REPLICASETS?= $(if $(KCL_REPLICASETS_MANIFEST_URL),--filename $(KCL_REPLICASETS_MANIFEST_URL))
__KCL_FILENAME__REPLICASETS?= $(if $(KCL_REPLICASETS_MANIFESTS_DIRPATH),--filename $(KCL_REPLICASETS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__REPLICASET?= $(if $(KCL_REPLICASET_NAMESPACE_NAME),--namespace $(KCL_REPLICASET_NAMESPACE_NAME))
__KCL_NAMESPACE__REPLICASETS?= $(if $(KCL_REPLICASETS_NAMESPACE_NAME),--namespace $(KCL_REPLICASETS_NAMESPACE_NAME))

# UI parameters
_KCL_APPLY_REPLICASETS_|?= #
_KCL_DIFF_REPLICASETS_|?= $(_KCL_APPLY_DEPLICASETS_|)
_KCL_UNAPPLY_REPLICASETS_|?= $(_KCL_APPLY_DEPLICASETS_|)

#--- MACROS
_kcl_get_replicaset_pod_names= $(_kcl_get_replicaset_pod_names_S, $(KCL_REPLICASET_POD_SELECTOR))
_kcl_get_replicaset_pod_name_S= $(call _kcl_get_replicaset_pod_names_SN, $(1), $(KCL_REPLICASET_NAMESPACE_NAME))
_kcl_get_replicaset_pod_name_SN= $(shell $(KUBECTL) get pods --namespace $(2) --selector=$(strip $(1)))

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::ReplicaSet ($(_KUBECTL_REPLICASET_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::ReplicaSet ($(_KUBECTL_REPLICASET_MK_VERSION)) parameters:'
	@echo '    KCL_REPLICASET_LABELS_KEYVALUES=$(KCL_REPLICASET_LABELS_KEYVALUES)'
	@echo '    KCL_REPLICASET_NAME=$(KCL_REPLICASET_NAME)'
	@echo '    KCL_REPLICASET_NAMESPACE_NAME=$(KCL_REPLICASET_NAMESPACE_NAME)'
	@echo '    KCL_REPLICASET_SSH_SHELL=$(KCL_REPLICASET_SSH_SHELL)'
	@echo '    KCL_REPLICASETS_MANIFEST_DIRPATH=$(KCL_REPLICASETS_MANIFEST_DIRPATH)'
	@echo '    KCL_REPLICASETS_MANIFEST_FILEPATH=$(KCL_REPLICASETS_MANIFEST_FILEPATH)'
	@echo '    KCL_REPLICASETS_MANIFEST_STDINFLAG=$(KCL_REPLICASETS_MANIFEST_STDINFLAG)'
	@echo '    KCL_REPLICASETS_MANIFEST_URL=$(KCL_REPLICASETS_MANIFEST_URL)'
	@echo '    KCL_REPLICASETS_MANIFESTS_DIRPATH=$(KCL_REPLICASETS_MANIFESTS_DIRPATH)'
	@echo '    KCL_REPLICASETS_NAMESPACE_NAME=$(KCL_REPLICASETS_NAMESPACE_NAME)'
	@echo '    KCL_REPLICASETS_SET_NAME=$(KCL_REPLICASETS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::ReplicaSet ($(_KUBECTL_REPLICASET_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_replicaset               - Annotate replica-set'
	@echo '    _kcl_apply_replicaset                  - Apply a manifest for a replica-set'
	@echo '    _kcl_create_replicaset                 - Create a new replica-set'
	@echo '    _kcl_delete_replicaset                 - Delete an existing replica-set'
	@echo '    _kcl_diff_replicaset                   - Diff manifest with running replica-set'
	@echo '    _kcl_edit_replicaset                   - Edit a replica-set'
	@echo '    _kcl_explain_replicaset                - Explain the replica-set object'
	@echo '    _kcl_labe_replicaset                   - Label a replica-set'
	@echo '    _kcl_show_replicaset                   - Show everything related to a replica-set'
	@echo '    _kcl_show_replicaset_description       - Show description of a replica-set'
	@echo '    _kcl_show_replicaset_pods              - Show pods of a replica-set'
	@echo '    _kcl_ssh_replicaset                    - Ssh in a pod of a replica-set'
	@echo '    _kcl_tail_replicaset                   - Tail logs of a pod in a replica-set'
	@echo '    _kcl_unapply_replicaset                - Un-apply a manifest for a replica-set'
	@echo '    _kcl_unlabel_replicaset                - Un-label a replica-set'
	@echo '    _kcl_update_replicaset                 - Update replica-set'
	@echo '    _kcl_view_replicasets                  - View replica-sets'
	@echo '    _kcl_view_replicasets_set              - View a set of replica-sets'
	@echo '    _kcl_watch_replicasets                 - Watch ALL replica-sets'
	@echo '    _kcl_wtch_replicasets_set              - Watch a set of a replica-sets'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_replicaset:
	@$(INFO) '$(KCL_UI_LABEL)Annotating replica-set "$(KCL_REPLICASET_NAME)" ...'; $(NORMAL)

_kcl_apply_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more replica-sets ...'; $(NORMAL)
	$(if $(KCL_REPLICASETS_MANIFEST_FILEPATH),cat $(KCL_REPLICASETS_MANIFEST_FILEPATH); echo)
	$(if $(KCL_REPLICASETS_MANIFEST_FILEPATH),$(_KCL_APPLY_REPLICASETS_|)cat)
	$(if $(KCL_REPLICASETS_MANIFEST_URL),curl -L $(KCL_REPLICATSETS_MANIFEST_URL); echo )
	$(if $(KCL_REPLICASETS_MANIFESTS_DIRPATH),ls -al $(KCL_REPLICASETS_MANIFESTS_DIRPATH); echo)
	$(_KCL_APPLY_REPLICASETS_|)$(KUBECTL) apply $(__KCL_FILENAME__REPLICATSETS) $(__KCL_NAMESPACE__REPLICASETS)

_kcl_create_replicaset:
	@$(INFO) '$(KCL_UI_LABEL)Creating replica-set "$(KCL_REPLICASET_NAME)" ...'; $(NORMAL)

_kcl_delete_replicaset:
	@$(INFO) '$(KCL_UI_LABEL)Deleting replica-set "$(KCL_REPLICASET_NAME)" ...'; $(NORMAL)

_kcl_diff_replicaset: _kcl_diff_replicasets
_kcl_diff_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing one-or-more replica-sets ...'; $(NORMAL)
	@$(WARN) 'This operation submits the manifest to the cluster to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_REPLICASETS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_REPLICASETS_|)cat
	# curl -L $(KCL_REPLICASETS_MANIFEST_FILEPATH)
	# ls -al $(KCL_REPLICASETS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_REPLICASETS_|)$(KUBECTL) diff $(__KCL_FILENAME__REPLICATSETS) $(__KCL_NAMESPACE__REPLICASETS)

_kcl_edit_replicaset:
	@$(INFO) '$(KCL_UI_LABEL)Editing replica-set "$(KCL_REPLICASET_NAME)" ...'; $(NORMAL)

_kcl_explain_replicaset:
	@$(INFO) '$(KCL_UI_LABEL)Explaining replica-set object ...'; $(NORMAL)
	$(KUBECTL) explain replicaset

_kcl_label_replicaset:
	@$(INFO) '$(KCL_UI_LABEL)Labeling replica-set "$(KCL_REPLICASET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label replicaset $(KCL_REPLICASET_NAME) $(KCL_REPLICASET_LABELS_KEYVALUES)

_kcl_show_replicaset: _kcl_show_replicaset_pods _kcl_show_replicaset_description

_kcl_show_replicaset_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of replica-set "$(KCL_REPLICASET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe replicaset $(__KCL_NAMESPACE__REPLICASET) $(KCL_REPLICASET_NAME)

_kcl_show_replicaset_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods in replica-set "$(KCL_REPLICASET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pods $(__KCL_NAMESPACE__REPLICASET)

_kcl_ssh_replicaset:

_kcl_tail_replicaset:

_kcl_unapply_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Unapplying manifest for one-or-more replica-set ...'; $(NORMAL)
	# cat $(KCL_REPLICASETS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_REPLICASETS_|)cat
	# curl -L $(KCL_REPLICASETS_MANIFEST_FILEPATH)
	# ls -al $(KCL_REPLICASETS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_REPLICASETS_|)$(KUBECTL) delete $(__KCL_FILENAME__REPLICATSETS) $(__KCL_NAMESPACE__REPLICASETS)

_kcl_unlabel_replicaset:
	@$(INFO) '$(KCL_UI_LABEL)Unlabel replica-set "$(KCL_REPLICASET_NAME)" ...'; $(NORMAL)

_kcl_update_replicaset:
	@$(INFO) '$(KCL_UI_LABEL)Updating replica-set "$(KCL_REPLICASET_NAME)" ...'; $(NORMAL)

_kcl_view_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Viewing replica-sets ...'; $(NORMAL)
	$(KUBECTL) get replicasets --all-namespaces=true $(_X__KCL_NAMESPACE__REPLICASETS)

_kcl_view_replicasets_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing replica-sets-set "$(KCL_REPLICASETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Replica-sets are grouped based on namespace, ...'; $(NORMAL)
	$(KUBECTL) get replicasets --all-namespaces=false $(__KCL_NAMESPACE__REPLICASETS)

_kcl_watch_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Viewing replica-sets ...'; $(NORMAL)

_kcl_watch_replicasets_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching replica-sets-set "$(KCL_REPLICASETS_SET_NAME)" ...'; $(NORMAL)
