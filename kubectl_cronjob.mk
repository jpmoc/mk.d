_KUBECTL_CRONJOB_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_CRONJOB_COMMAND?= /bin/sh -c "date; echo Hello from the Kubernetes cluster"
# KCL_CRONJOB_FOLLOW_LOGS?= false
# KCL_CRONJOB_IMAGE?= busybox
# KCL_CRONJOB_JOB_NAME?= 
# KCL_CRONJOB_NAME?= hello
# KCL_CRONJOB_NAMESPACE_NAME?= default
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
KCL_CRONJOBS_NAMESPACE_NAME?= $(KCL_CRONJOB_NAMESPACE_NAME)
KCL_CRONJOBS_SET_NAME?= $(KCL_CRONJOBS_NAMESPACE_NAME)

# Option parameters
__KCL_CONTAINER__CRONJOB=
__KCL_FOLLOW__CRONJOB= $(if $(KCL_CRONJOB_FOLLOW_LOGS), --follow=$(KCL_CRONJOB_FOLLOW_LOGS))
__KCL_IMAGE__CRONJOB= $(if $(KCL_CRONJOB_IMAGE), --image=$(KCL_CRONJOB_IMAGE))
__KCL_NAMESPACE__CRONJOB= $(if $(KCL_CRONJOB_NAMESPACE_NAME), --namespace $(KCL_CRONJOB_NAMESPACE_NAME))
__KCL_NAMESPACE__CRONJOBS= $(if $(KCL_CRONJOBS_NAMESPACE_NAME), --namespace $(KCL_CRONJOBS_NAMESPACE_NAME))
__KCL_RESTART__CRONJOB= $(if $(KCL_CRONJOB_RESTART), --restart=$(KCL_CRONJOB_RESTART))
__KCL_SCHEDULE= $(if $(KCL_CRONJOB_SCHEDULE), --schedule=$(KCL_CRONJOB_SCHEDULE))

# UI parameters

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

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Cronjob ($(_KUBECTL_CRONJOB_MK_VERSION)) macros:'
	@echo '    _kcl_get_cronjob_lastjob_name_{|S|SN}           - Get the name of the last-job spawned by a cronjob (Selector,Namespace)'
	@echo '    _kcl_get_cronjob_lastpod_name_{|S|SN}           - Get the name of the pod spawned by the last-job of a cronjob (Selector,Namespace)'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Cronjob ($(_KUBECTL_CRONJOB_MK_VERSION)) parameters:'
	@echo '    KCL_CRONJOB_COMMAND=$(KCL_CRONJOB_COMMAND)'
	@echo '    KCL_CRONJOB_FOLLOW_LOGS=$(KCL_CRONJOB_FOLLOW_LOGS)'
	@echo '    KCL_CRONJOB_IMAGE=$(KCL_CRONJOB_IMAGE)'
	@echo '    KCL_CRONJOB_JOB_NAME=$(KCL_CRONJOB_JOB_NAME)'
	@echo '    KCL_CRONJOB_NAME=$(KCL_CRONJOB_NAME)'
	@echo '    KCL_CRONJOB_NAMESPACE_NAME=$(KCL_CRONJOB_NAMESPACE_NAME)'
	@echo '    KCL_CRONJOB_POD_NAME=$(KCL_CRONJOB_POD_NAME)'
	@echo '    KCL_CRONJOB_RESTART=$(KCL_CRONJOB_RESTART)'
	@echo '    KCL_CRONJOB_SCHEDULE=$(KCL_CRONJOB_SCHEDULE)'
	@echo '    KCL_CRONJOBS_NAMESPACE_NAME=$(KCL_CRONJOBS_NAMESPACE_NAME)'
	@echo '    KCL_CRONJOBS_SET_NAME=$(KCL_CRONJOBS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Cronjob ($(_KUBECTL_CRONJOB_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_cronjob                - Annotate a cronjob'
	@echo '    _kcl_apply_cronjobs                  - Apply manifest for one-or-more cronjobs'
	@echo '    _kcl_create_cronjob                  - Create a new cronjob'
	@echo '    _kcl_delete_cronjob                  - Delete an existing cronjob'
	@echo '    _kcl_diff_cronjobs                   - Diff a manifest for one-or-more cronjobs'
	@echo '    _kcl_edit_cronjob                    - Edit a cronjob'
	@echo '    _kcl_explain_cronjob                 - Explain the cronjob object'
	@echo '    _kcl_show_cronjob                    - Show everything related to a cronjob'
	@echo '    _kcl_show_cronjob_description        - Show the description of a cronjob'
	@echo '    _kcl_tail_cronjob                    - Tail pods of a cronjob'
	@echo '    _kcl_unapply_cronjobs                - Un-apply a manifest for one-or-more cronjobs'
	@echo '    _kcl_unlabel_cronjob                 - Un-label a cronjob'
	@echo '    _kcl_update_cronjob                  - Update a cronjob'
	@echo '    _kcl_view_cronjobs                   - View all cronjobs'
	@echo '    _kcl_view_cronjobs_set               - View a set of cronjobs'
	@echo '    _kcl_watch_cronjobs                  - Watching cronjobs/jobs'
	@echo '    _kcl_watch_cronjobs_set              - Watching a set of cronjobs/jobs'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Annotating cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)

_kcl_apply_cronjob: _kcl_apply_cronjobs
_kcl_apply_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more cronjobs ...'; $(NORMAL)

_kcl_create_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Creating cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) run $(KCL_CRONJOB_NAME) $(__KCL_IMAGE__CRONJOB) $(__KCL_NAMESPACE__CRONJOB) $(__KCL_RESTART__CRONJOB) $(__KCL_SCHEDULE) -- $(KCL_CRONJOB_COMMAND)

_kcl_delete_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Deleting cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete cronjob $(__KCL_NAMESPACE__CRONJOB) $(KCL_CRONJOB_NAME)

_kcl_diff_cronjob: _kcl_diff_cronjobs
_kcl_diff_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more cronjobs ...'; $(NORMAL)

_kcl_edit_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Editing cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)

_kcl_explain_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Explaining cronjob object ...'; $(NORMAL)
	$(KUBECTL) explain cronjob

_kcl_label_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Labeling cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)

_kcl_show_cronjob: _kcl_show_cronjob_description

_kcl_show_cronjob_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe cronjob $(__KCL_NAMESPACE__CRONJOB) $(KCL_CRONJOB_NAME)

_kcl_unapply_cronjob: _kcl_unapply_cronjobs
_kcl_unapply_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more cronjobs ...'; $(NORMAL)

_kcl_unlabel_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)

_kcl_tail_cronjob:
	@$(INFO) '$(KCL_UI_LABEL)Tailing logs of container spawn by cronjob "$(KCL_CRONJOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) logs $(__KCL_CONTAIMER__CRONJOB) $(__KCL_FOLLOW__CRONJOB) $(__KCL_NAMESPACE__CRONJOB) $(KCL_CRONJOB_POD_NAME)

_kcl_test_cronjob_macros:
	$(KUBECTL) get job --all-namespaces=false  --namespace $(KCL_CRONJOB_NAMESPACE_NAME) --selector=run=$(KCL_CRONJOB_NAME)  --sort-by=metadata.name --output jsonpath="{.items[-1:].metadata.name}{'\n'}"

_kcl_update_cronjob:

_kcl_view_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL cronjobs ...'; $(NORMAL)
	$(KUBECTL) get cronjob --all-namespaces=true $(_X__KCL_NAMESPACE__CRONJOBS)

_kcl_view_cronjobs_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing cronjobs-set "$(KCL_CRONJOBS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Cronjobs are grouped based on the provided namespace and selector'; $(NORMAL)
	$(KUBECTL) get cronjob --all-namespaces=false $(__KCL_NAMESPACE__CRONJOBS)

_kcl_watch_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL cronjobs ...'; $(NORMAL)

_kcl_watch_cronjobs_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching cronjobs-set "$(KCL_CRONJOBS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Cronjobs are grouped based on the provided namespace and selector'; $(NORMAL)
