_KUBECTL_JOB_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_JOB_COMMAND?= /bin/sh -c "date; echo Hello from the Kubernetes cluster"
# KCL_JOB_CONTAINER?=
# KCL_JOB_FOLLOW_LOGS?= false
# KCL_JOB_IMAGE?= busybox
# KCL_JOB_MANIFEST_DIRPATH?= ./in/
# KCL_JOB_MANIFEST_FILENAME?= job.yaml
# KCL_JOB_MANIFEST_FILEPATH?= ./in/job.yaml
# KCL_JOB_NAME?= my-job-name
# KCL_JOB_NAMESPACE_NAME?= default
# KCL_JOB_OUTPUT?=
# KCL_JOB_POD_NAME?= hello-4111706356-o9qcm
# KCL_JOB_PODS_NAMES?= hello-4111706356-o9qcm ...
# KCL_JOB_PODS_SELECTOR?= job-name=my-job-name
# KCL_JOB_RESTART?= OnFailure
# KCL_JOB_SCHEDULE?= "*/1 * * * *"
KCL_JOB_SSH_SHELL?= /bin/bash
# KCL_JOBS_CLUSTER_NAME?= my-cluster-name
# KCL_JOBS_FIELDSELECTOR?= metadata.name=my-job
# KCL_JOBS_NAMESPACE_NAME?= default
# KCL_JOBS_OUTPUT?= jsonpath='{.items[0].metadata.name}'
# KCL_JOBS_SELECTOR?= run=ecr-read-only--renew-token
# KCL_JOBS_SET_NAME?= my-jobs-set
# KCL_JOBS_SORT_BY?= status.completionTime

# Derived parameters
KCL_JOB_FOLLOW_LOGS?= $(KCL_POD_FOLLOW_LOGS)
KCL_JOB_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_JOB_MANIFEST_FILEPATH?= $(KCL_JOB_MANIFEST_DIRPATH)$(KCL_JOB_MANIFEST_FILENAME)
KCL_JOB_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_JOB_NAMES?= $(KCL_JOB_NAME)
KCL_JOB_POD_NAME?= $(firstword $(KCL_JOB_PODS_NAMES))
KCL_JOB_PODS_SELECTOR?= job-name=$(KCL_JOB_NAME)
KCL_JOBS_NAMESPACE_NAME?= $(KCL_JOB_NAMESPACE_NAME)
KCL_JOBS_SET_NAME?= jobs@$(KCL_JOBS_FIELDSELECTOR)@$(KCL_JOBS_SELECTOR)@$(KCL_JOBS_NAMESPACE_NAME)

# Option parameters
__KCL_CONTAINER__JOB= $(if $(KCL_JOB_CONTAINER_NAME),--container=$(KCL_CONTAINER_NAME))
__KCL_FIELD_SELECTOR__JOBS= $(if $(KCL_JOBS_FIELDSELECTOR),--field-selector=$(KCL_JOBS_FIELDSELECTOR))
__KCL_FILENAME__JOB= $(if $(KCL_JOB_MANIFEST_FILEPATH),--filename $(KCL_JOB_MANIFEST_FILEPATH))
__KCL_FOLLOW__JOB= $(if $(KCL_JOB_FOLLOW_LOGS),--follow=$(KCL_JOB_FOLLOW_LOGS))
__KCL_IMAGE__JOB= $(if $(KCL_JOB_IMAGE),--image=$(KCL_JOB_IMAGE))
__KCL_NAMESPACE__JOB= $(if $(KCL_JOB_NAMESPACE_NAME),--namespace $(KCL_JOB_NAMESPACE_NAME))
__KCL_NAMESPACE__JOBS= $(if $(KCL_JOBS_NAMESPACE_NAME),--namespace $(KCL_JOBS_NAMESPACE_NAME))
__KCL_OUTPUT__JOB= $(if $(KCL_JOB_OUTPUT),--output $(KCL_JOB_OUTPUT))
__KCL_OUTPUT__JOBS= $(if $(KCL_JOBS_OUTPUT),--output $(KCL_JOBS_OUTPUT))
__KCL_RESTART__JOB= $(if $(KCL_JOB_RESTART),--restart=$(KCL_JOB_RESTART))
__KCL_SELECTOR__JOBS= $(if $(KCL_JOBS_SELECTOR),--selector=$(KCL_JOBS_SELECTOR))
__KCL_SORT_BY__JOBS= $(if $(KCL_JOBS_SORT_BY),--sort-by=$(KCL_JOBS_SORT_BY))

# UI parameters

#--- MACROS
_kcl_get_job_pods_names= $(call _kcl_get_job_pods_names_S, $(KCL_JOB_PODS_SELECTOR))
_kcl_get_job_pods_names_S= $(call _kcl_get_job_pods_names_SN, $(1), $(KCL_JOB_NAMESPACE_NAME))
_kcl_get_job_pods_names_SN= $(shell $(KUBECTL) get pods --namespace $(2) --selector=$(strip $(1)) --output=jsonpath="{.items..metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Job ($(_KUBECTL_JOB_MK_VERSION)) macros:'
	@echo '    _kcl_get_job_pods_names_{|S|SN}        - Get the name of pods spawned by a job (Selector,Namespace)'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Job ($(_KUBECTL_JOB_MK_VERSION)) parameters:'
	@echo '    KCL_JOB_COMMAND=$(KCL_JOB_NAME)'
	@echo '    KCL_JOB_CONTAINER_NAME=$(KCL_JOB_CONTAINER_NAME)'
	@echo '    KCL_JOB_FOLLOW_LOGS=$(KCL_JOB_FOLLOW_LOGS)'
	@echo '    KCL_JOB_MANIFEST_DIRPATH=$(KCL_JOB_MANIFEST_DIRPATH)'
	@echo '    KCL_JOB_MANIFEST_FILENAME=$(KCL_JOB_MANIFEST_FILENAME)'
	@echo '    KCL_JOB_MANIFEST_FILEPATH=$(KCL_JOB_MANIFEST_FILEPATH)'
	@echo '    KCL_JOB_NAME=$(KCL_JOB_NAME)'
	@echo '    KCL_JOB_NAMESPACE_NAME=$(KCL_JOB_NAMESPACE_NAME)'
	@echo '    KCL_JOB_OUTPUT=$(KCL_JOB_OUTPUT)'
	@echo '    KCL_JOB_POD_NAME=$(KCL_JOB_POD_NAME)'
	@echo '    KCL_JOB_PODS_NAMES=$(KCL_JOB_PODS_NAMES)'
	@echo '    KCL_JOB_PODS_SELECTOR=$(KCL_JOB_PODS_SELECTOR)'
	@echo '    KCL_JOB_SSH_SHELL=$(KCL_JOB_SSH_SHELL)'
	@echo '    KCL_JOBS_FIELDSELECTOR=$(KCL_JOBS_FIELDSELECTOR)'
	@echo '    KCL_JOBS_NAMESPACE_NAME=$(KCL_JOBS_NAMESPACE_NAME)'
	@echo '    KCL_JOBS_OUTPUT=$(KCL_JOBS_OUTPUT)'
	@echo '    KCL_JOBS_SELECTOR=$(KCL_JOBS_SELECTOR)'
	@echo '    KCL_JOBS_SET_NAME=$(KCL_JOBS_SET_NAME)'
	@echo '    KCL_JOBS_SORT_BY=$(KCL_JOBS_SORT_BY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Job ($(_KUBECTL_JOB_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_job                      - Annotate a job'
	@echo '    _kcl_apply_job                         - Apply a manifest for a job'
	@echo '    _kcl_create_job                        - Create a new job'
	@echo '    _kcl_delete_job                        - Delete an existing job'
	@echo '    _kcl_edit_job                          - Edit a job'
	@echo '    _kcl_explain_job                       - Explain the job object'
	@echo '    _kcl_label_job                         - Label a job'
	@echo '    _kcl_show_job                          - Show everything related to a job'
	@echo '    _kcl_show_job_description              - Show the description of a job'
	@echo '    _kcl_ssh_job                           - Ssh a job'
	@echo '    _kcl_tail_job                          - Tail pods of a job'
	@echo '    _kcl_unapply_job                       - Un-apply a manifest for a job'
	@echo '    _kcl_unlabel_job                       - Un-label a manifest for a job'
	@echo '    _kcl_update_job                        - Update a job'
	@echo '    _kcl_view_jobs                         - View all jobs'
	@echo '    _kcl_view_jobs_set                     - View a set of jobs'
	@echo '    _kcl_watch_jobs                        - Watch jobs'
	@echo '    _kcl_watch_jobs_set                    - Watch a set of jobs'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_job:
	@$(INFO) '$(KCL_UI_LABEL)Annotating job "$(KCL_JOB_NAME)" ...'; $(NORMAL)

_kcl_apply_job:
	@$(INFO) '$(KCL_UI_LABEL)Applying job "$(KCL_JOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) apply $(__KCL_FILENAME__JOB) $(__KCL_NAMESPACE__JOB)

_kcl_create_job:
	@$(INFO) '$(KCL_UI_LABEL)Creating job "$(KCL_JOB_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) run $(KCL_JOB_NAME) $(__KCL_IMAGE__JOB) $(__KCL_NAMESPACE__JOB) $(__KCL_RESTART__JOB) -- $(KCL_JOB_COMMAND)

_kcl_delete_job:
	@$(INFO) '$(KCL_UI_LABEL)Deleting job "$(KCL_JOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete job $(__KCL_NAMESPACE__JOB) $(KCL_JOB_NAME)

_kcl_edit_job:
	@$(INFO) '$(KCL_UI_LABEL)Editing job "$(KCL_JOB_NAME)" ...'; $(NORMAL)

_kcl_explain_job:
	@$(INFO) '$(KCL_UI_LABEL)Explaining job object ...'; $(NORMAL)
	$(KUBECTL) explain job

_kcl_label_job:
	@$(INFO) '$(KCL_UI_LABEL)Labeling job "$(KCL_JOB_NAME)" ...'; $(NORMAL)

_kcl_show_job: _kcl_show_job_cronjobs _kcl_show_job_pods _kcl_show_job_description

_kcl_show_job_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Showing cron-jobs of job "$(KCL_JOB_NAME)" ...'; $(NORMAL)
	# Not implemented yet!

_kcl_show_job_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description job "$(KCL_JOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe job $(__KCL_NAMESPACE__JOB) $(KCL_JOB_NAME)

_kcl_show_job_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods spawned by job "$(KCL_JOB_NAME)" ...'; $(NORMAL)
	$(if $(KCL_JOB_PODS_FIELDSELECTOR)$(KCL_JOB_PODS_SELECTOR), \
		$(KUBECTL) get pod $(__KCL_NAMESPACE__JOB) \
			$(if $(KCL_JOB_PODS_FIELDSELECTOR),--field-selector $(KCL_JOB_PODS_FIELDSELECTOR)) \
			$(if $(KCL_JOB_PODS_SELECTOR),--selector $(KCL_JOB_PODS_SELECTOR)) \
	, @ \
		echo 'KCL_JOB_PODS_FIELDSELECTOR not set'; \
		echo 'KCL_JOB_PODS_SELECTOR not set'; \
	)

_kcl_ssh_job:
	@$(INFO) '$(KCL_UI_LABEL)Sshing into job "$(KCL_JOB_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation ssh into pod "$(KCL_JOB_POD_NAME)" spawned by the job'; $(NORMAL)
	$(KUBECTL) exec $(__KCL_CONTAINER__JOB) $(__KCL_NAMESPACE__JOB) $(KCL_JOB_POD_NAME) -i -t -- $(KCL_JOB_SSH_SHELL)

_kcl_tail_job:
	@$(INFO) '$(KCL_UI_LABEL)Tailing logs of job "$(KCL_JOB_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation tails the logs of pod "$(KCL_JOB_POD_NAME)" spawned by the job'; $(NORMAL)
	$(KUBECTL) logs $(__KCL_CONTAINER__JOB) $(__KCL_FOLLOW__JOB) $(__KCL_NAMESPACE__JOB) $(KCL_JOB_POD_NAME)

_kcl_unapply_job:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying job "$(KCL_JOB_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete $(__KCL_FILENAME__JOB) $(__KCL_NAMESPACE__JOB)

_kcl_unlabel_job:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling job "$(KCL_JOB_NAME)" ...'; $(NORMAL)

_kcl_update_job:
	@$(INFO) '$(KCL_UI_LABEL)Updating job "$(KCL_JOB_NAME)" ...'; $(NORMAL)

_kcl_view_jobs:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL jobs ...'; $(NORMAL)
	$(KUBECTL) get job --all-namespaces=true $(_X__KCL_NAMESPACE__JOBS) $(__KCL_OUTPUT_JOBS) $(_X__KCL_SELECTOR__JOBS) $(__KCL_SORT_BY__JOBS)

_kcl_view_jobs_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing jobs-set "$(KCL_JOBS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Jobs are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get job --all-namespaces=false $(__KCL_NAMESPACE__JOBS) $(__KCL_OUTPUT__JOBS) $(__KCL_SELECTOR__JOBS) $(__KCL_SORT_BY__JOBS)

_kcl_watch_jobs:
	@$(INFO) '$(KCL_UI_LABEL)Watching jobs ...'; $(NORMAL)
	$(KUBECTL) get jobs --all-namespaces=true --watch

_kcl_watch_jobs_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching jobs-set "$(KCL_JOBS_SET_NAME)" ...'; $(NORMAL)
