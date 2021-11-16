_KUBECTL_CRONJOB_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_CRONJOB_COMMAND_ARGS?= -- /bin/sh -c "date; echo Hello from the Kubernetes cluster"
KCL_CRONJOB_COMMAND_FLAG?= false
# KCL_CRONJOB_FOLLOW_LOGS?= false
# KCL_CRONJOB_IMAGE_NAME?= busybox
# KCL_CRONJOB_JOB_NAME?=
# KCL_CRONJOB_NAME?= hello
# KCL_CRONJOB_NAMESPACE_NAME?= default
# KCL_CRONJOB_PATCH?= "$(cat cronjob-patch.yaml)"
# KCL_CRONJOB_PATCH_DIRPATH?= ./in/
# KCL_CRONJOB_PATCH_FILENAME?= cronjob-patch.yaml
# KCL_CRONJOB_PATCH_FILEPATH?= ./in/cronjob-patch.yaml
# KCL_CRONJOB_POD_NAME?= ecr-read-only--renew-token-1537159920-zjbzp
# KCL_CRONJOB_RESTART?= OnFailure
# KCL_CRONJOB_SCHEDULE?= "*/1 * * * *"
# KCL_CRONJOBS_NAMESPACE_NAME?= default
# KCL_CRONJOBS_SET_NAME?= my-cronjobs-set

# Derived parameters
KCL_CRONJOB_FOLLOW_LOGS?= $(KCL_POD_FOLLOW_LOGS)
KCL_CRONJOB_JOB_NAME?= $(KCL_JOB_NAME)
KCL_CRONJOB_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_CRONJOB_NAMES?= $(KCL_CRONJOB_NAME)
KCL_CRONJOB_PATCH_FILEPATH?= $(KCL_CRONJOB_PATCH_DIRPATH)$(KCL_CRONJOB_PATCH_FILENAME)
KCL_CRONJOBS_NAMESPACE_NAME?= $(KCL_CRONJOB_NAMESPACE_NAME)
KCL_CRONJOBS_SET_NAME?= $(KCL_CRONJOBS_NAMESPACE_NAME)

# Options
__KCL_COMMAND__CRONJOB= $(if $(filter true,$(KCL_CRONJOB_COMMAND_FLAG)),--command)
__KCL_CONTAINER__CRONJOB=
__KCL_FOLLOW__CRONJOB= $(if $(KCL_CRONJOB_FOLLOWLOGS_FLAG),--follow=$(KCL_CRONJOB_FOLLOWLOGS_FLAG))
__KCL_IMAGE__CRONJOB= $(if $(KCL_CRONJOB_IMAGE_NAME),--image=$(KCL_CRONJOB_IMAGE))
__KCL_NAMESPACE__CRONJOB= $(if $(KCL_CRONJOB_NAMESPACE_NAME),--namespace $(KCL_CRONJOB_NAMESPACE_NAME))
__KCL_NAMESPACE__CRONJOBS= $(if $(KCL_CRONJOBS_NAMESPACE_NAME),--namespace $(KCL_CRONJOBS_NAMESPACE_NAME))
__KCL_PATCH__CRONJOB= $(if $(KCL_CRONJOB_PATCH),--patch $(KCL_CRONJOB_PATCH))
__KCL_PATCH_FILE__CRONJOB= $(if $(KCL_CRONJOB_PATCH_FILEPATH),--patch-file $(KCL_CRONJOB_PATCH_FILEPATH))
__KCL_RESTART__CRONJOB= $(if $(KCL_CRONJOB_RESTART),--restart=$(KCL_CRONJOB_RESTART))
__KCL_SCHEDULE= $(if $(KCL_CRONJOB_SCHEDULE),--schedule=$(KCL_CRONJOB_SCHEDULE))

# Customizations

#--- MACROS
_kcl_get_cronjob_lastjob_name= $(call _kcl_get_cronjob_lastjob_name_S, run=$(KCL_CRONJOB_NAME))
_kcl_get_cronjob_lastjob_name_S= $(call _kcl_get_cronjob_lastjob_name_SN, $(1), $(KCL_CRONJOB_NAMESPACE_NAME))
_kcl_get_cronjob_lastjob_name_SN= $(shell $(KUBECTL) get job --all-namespaces=false  --namespace $(2) --selector $(1)  --sort-by=metadata.name --output jsonpath="{.items[-1:].metadata.name}{'\n'}")

_kcl_get_cronjob_lastpod_name= $(call _kcl_get_cronjob_lastpod_name_S, run=$(KCL_CRONJOB_NAME)$(COMMA)job-name=$(KCL_CRONJOB_JOB_NAME))
_kcl_get_cronjob_lastpod_name_S= $(call _kcl_get_cronjob_lastpod_name_SN, $(1), $(KCL_CRONJOB_NAMESPACE_NAME))
_kcl_get_cronjob_lastpod_name_SN= $(shell $(KUBECTL) get pods --all-namespaces=false --namespace $(2) --selector $(1) --output=jsonpath="{.items..metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Cronjob ($(_KUBECTL_CRONJOB_MK_VERSION)) macros:'
	@echo '    _kcl_get_cronjob_lastjob_name_{|S|SN}           - Get the name of the last-job spawned by a cronjob (Selector,Namespace)'
	@echo '    _kcl_get_cronjob_lastpod_name_{|S|SN}           - Get the name of the pod spawned by the last-job of a cronjob (Selector,Namespace)'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Cronjob ($(_KUBECTL_CRONJOB_MK_VERSION)) parameters:'
	@echo '    KCL_CRONJOB_ANNOTATIONS_KEYS=$(KCL_CRONJOB_ANNOTATIONS_KEYS)'
	@echo '    KCL_CRONJOB_ANNOTATIONS_KEYVALUES=$(KCL_CRONJOB_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_CRONJOB_COMMAND_ARGS=$(KCL_CRONJOB_COMMAND_ARGS)'
	@echo '    KCL_CRONJOB_COMMAND_FLAG=$(KCL_CRONJOB_COMMAND_FLAG)'
	@echo '    KCL_CRONJOB_FIELD_JSONPATH=$(KCL_CRONJOB_FIELD_JSONPATH)'
	@echo '    KCL_CRONJOB_FOLLOWLOGS_FLAG=$(KCL_CRONJOB_FOLLOWLOGS_FLAG)'
	@echo '    KCL_CRONJOB_IMAGE_NAME=$(KCL_CRONJOB_IMAGE_NAME)'
	@echo '    KCL_CRONJOB_JOB_NAME=$(KCL_CRONJOB_JOB_NAME)'
	@echo '    KCL_CRONJOB_LABELS_KEYS=$(KCL_CRONJOB_LABELS_KEYS)'
	@echo '    KCL_CRONJOB_LABELS_KEYVALUES=$(KCL_CRONJOB_LABELS_KEYVALUES)'
	@echo '    KCL_CRONJOB_NAME=$(KCL_CRONJOB_NAME)'
	@echo '    KCL_CRONJOB_NAMESPACE_NAME=$(KCL_CRONJOB_NAMESPACE_NAME)'
	@echo '    KCL_CRONJOB_PATCH=$(KCL_CRONJOB_PATCH)'
	@echo '    KCL_CRONJOB_PATCH_DIRPATH=$(KCL_CRONJOB_PATCH_DIRPATH)'
	@echo '    KCL_CRONJOB_PATCH_FILENAME=$(KCL_CRONJOB_PATCH_FILENAME)'
	@echo '    KCL_CRONJOB_PATCH_FILEPATH=$(KCL_CRONJOB_PATCH_FILEPATH)'
	@echo '    KCL_CRONJOB_POD_NAME=$(KCL_CRONJOB_POD_NAME)'
	@echo '    KCL_CRONJOB_RESTART=$(KCL_CRONJOB_RESTART)'
	@echo '    KCL_CRONJOB_SCHEDULE=$(KCL_CRONJOB_SCHEDULE)'
	@echo '    KCL_CRONJOBS_MANIFEST_DIRPATH=$(KCL_CRONJOBS_MANIFEST_DIRPATH)'
	@echo '    KCL_CRONJOBS_MANIFEST_FILENAME=$(KCL_CRONJOBS_MANIFEST_FILENAME)'
	@echo '    KCL_CRONJOBS_MANIFEST_FILEPATH=$(KCL_CRONJOBS_MANIFEST_FILEPATH)'
	@echo '    KCL_CRONJOBS_NAMESPACE_NAME=$(KCL_CRONJOBS_NAMESPACE_NAME)'
	@echo '    KCL_CRONJOBS_SET_NAME=$(KCL_CRONJOBS_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Cronjob ($(_KUBECTL_CRONJOB_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_cronjob                - Annotate a cronjob'
	@echo '    _kcl_apply_cronjobs                  - Apply manifest for one-or-more cronjobs'
	@echo '    _kcl_create_cronjob                  - Create a new cronjob'
	@echo '    _kcl_delete_cronjob                  - Delete an existing cronjob'
	@echo '    _kcl_diff_cronjobs                   - Diff a manifest for one-or-more cronjobs'
	@echo '    _kcl_edit_cronjob                    - Edit a cronjob'
	@echo '    _kcl_explain_cronjob                 - Explain the cronjob object'
	@echo '    _kcl_label_cronjob                   - Lable a cronjob'
	@echo '    _kcl_list_cronjobs                   - List all cronjobs'
	@echo '    _kcl_list_cronjobs_set               - List a set of cronjobs'
	@echo '    _kcl_patch_cronjob                   - Patch a cronjob'
	@echo '    _kcl_show_cronjob                    - Show everything related to a cronjob'
	@echo '    _kcl_show_cronjob_description        - Show the description of a cronjob'
	@echo '    _kcl_tail_cronjob                    - Tail pods of a cronjob'
	@echo '    _kcl_unannotate_cronjob              - Un-annotate a cronjob'
	@echo '    _kcl_unapply_cronjobs                - Un-apply a manifest for one-or-more cronjobs'
	@echo '    _kcl_unlabel_cronjob                 - Un-label a cronjob'
	@echo '    _kcl_watch_cronjobs                  - Watching all cronjobs'
	@echo '    _kcl_watch_cronjobs_set              - Watching a set of cronjobs'
	@echo '    _kcl_write_cronjobs                  - Writing manifest for one-or-more cronjobs'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Annotating cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label cronjob $(KCL_CRONJOB_NAME) $(KCL_CRONJOB_ANNOTATIONS_KEYVALUES)

_kcl_apply_cronjob: _kcl_apply_cronjobs
_kcl_apply_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more cronjobs ...'; $(NORMAL)

_kcl_create_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Creating cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) run $(KCL_CRONJOB_NAME) $(__KCL_IMAGE__CRONJOB) $(__KCL_NAMESPACE__CRONJOB) $(__KCL_RESTART__CRONJOB) $(__KCL_SCHEDULE) \
		$(if $(KCL_CRONJOB_COMMAND_ARGS),-- $(KCL_CRONJOB_COMMAND_ARGS))

_kcl_delete_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Deleting cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete cronjob $(__KCL_NAMESPACE__CRONJOB) $(KCL_CRONJOB_NAME)

_kcl_diff_cronjob: _kcl_diff_cronjobs
_kcl_diff_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more cronjobs ...'; $(NORMAL)

_kcl_edit_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Editing cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)

_kcl_explain_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Explaining cronjob object and its fields...'; $(NORMAL)
	@$(WARN) 'THis operation fails if you do not have access to a cluster'; $(NORMAL)
	$(KUBECTL) explain cronjob$(KCL_CRONJOB_FIELD_JSONPATH)

_kcl_label_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Labeling cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label cronjob $(KCL_CRONJOB_NAME) $(KCL_CRONJOB_LABELS_KEYVALUES)

_kcl_list_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL cronjobs ...'; $(NORMAL)
	$(KUBECTL) get cronjob --all-namespaces=true $(_X__KCL_NAMESPACE__CRONJOBS)

_kcl_list_cronjobs_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing cronjobs-set "$(KCL_CRONJOBS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Cronjobs are grouped based on the provided namespace and selector'; $(NORMAL)
	$(KUBECTL) get cronjob --all-namespaces=false $(__KCL_NAMESPACE__CRONJOBS)

_kcl_patch_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Patching cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)
	$(if $(KCL_CRONJOB_PATCH_FILEPATH),cat $(KCL_CRONJOB_FILEPATH))
	$(KUBECTL) patch cronjob $(__KCL_NAMESPACE__CRONJOB) $(__KCL_PATCH__CRONJOB) $(__KCL_PATCH_FILE__CRONJOB) $(KCL_CRONJOB_NAME)

_KCL_SHOW_CRONJOB_TARGETS?= _kcl_show_cronjob_description
_kcl_show_cronjob: $(_KCL_SHOW_CRONJOB_TARGETS)

_kcl_show_cronjob_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe cronjob $(__KCL_NAMESPACE__CRONJOB) $(KCL_CRONJOB_NAME)

_kcl_tail_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Tailing logs of container spawn by cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) logs $(__KCL_CONTAIMER__CRONJOB) $(__KCL_FOLLOW__CRONJOB) $(__KCL_NAMESPACE__CRONJOB) $(KCL_CRONJOB_POD_NAME)

_kcl_test_cronjob_macros:
	$(KUBECTL) get job --all-namespaces=false  --namespace $(KCL_CRONJOB_NAMESPACE_NAME) --selector=run=$(KCL_CRONJOB_NAME)  --sort-by=metadata.name --output jsonpath="{.items[-1:].metadata.name}{'\n'}"

_kcl_unannotate_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Un-annotating cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)

_kcl_unapply_cronjob: _kcl_unapply_cronjobs
_kcl_unapply_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more cronjobs ...'; $(NORMAL)

_kcl_unlabel_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)

_kcl_watch_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL cronjobs ...'; $(NORMAL)

_kcl_watch_cronjobs_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching cronjobs-set "$(KCL_CRONJOBS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Cronjobs are grouped based on the provided namespace and selector'; $(NORMAL)

_kcl_write_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more cronjobs ...'; $(NORMAL)
	$(WRITER) $(KCL_CRONJOBS_MANIFEST_FILEPATH)
