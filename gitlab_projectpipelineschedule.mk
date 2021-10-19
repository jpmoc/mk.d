_GITLAB_PROJECTPIPELINESCHEDULE_MK_VERSION= $(_GITLAB_MK_VERSION)

# ┌───────────── minute (0 - 59)
# │ ┌───────────── hour (0 - 23)
# │ │ ┌───────────── day of the month (1 - 31)
# │ │ │ ┌───────────── month (1 - 12)
# │ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday;
# │ │ │ │ │                                   7 is also Sunday on some systems)
# │ │ │ │ │
# │ │ │ │ │
# * * * * * command to execute

GLB_PROJECTPIPELINESCHEDULE_ENABLE?= true
# GLB_PROJECTPIPELINESCHEDULE_CRON_SCHEDULE?= '* * * * *'
GLB_PROJECTPIPELINESCHEDULE_CRON_TIMEZONE?= UTC# https://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html
# GLB_PROJECTPIPELINESCHEDULE_ID?= 123456 
# GLB_PROJECTPIPELINESCHEDULE_NAME?= my-pipeline -schedule
GLB_PROJECTPIPELINESCHEDULE_INDEX?= 0
# GLB_PROJECTPIPELINESCHEDULE_PROJECT_ID?= 123456
# GLB_PROJECTPIPELINESCHEDULE_PROJECT_NAME?= my-project
# GLB_PROJECTPIPELINESCHEDULE_REF?= my-branch
# GLB_PROJECTPIPELINESCHEDULES_PROJECT_ID?= 123456
# GLB_PROJECTPIPELINESCHEDULES_PROJECT_NAME?= my-project

# Derived parameters
GLB_PROJECTPIPELINESCHEDULE_NAME?= $(GLB_PROJECTPIPELINESCHEDULE_ID)
GLB_PROJECTPIPELINESCHEDULE_PROJECT_ID?= $(GLB_PROJECT_ID)
GLB_PROJECTPIPELINESCHEDULE_PROJECT_NAME?= $(GLB_PROJECT_NAME)
GLB_PROJECTPIPELINESCHEDULES_PROJECT_ID?= $(GLB_PROJECTPIPELINESCHEDULE_PROJECT_ID)
GLB_PROJECTPIPELINESCHEDULES_PROJECT_NAME?= $(GLB_PROJECTPIPELINESCHEDULE_PROJECT_NAME)

# Option parameters
__GLB_ACTIVE= $(if $(GLB_PROJECTPIPELINESCHEDULE_ENABLE),--active $(GLB_PROJECTPIPELINESCHEDULE_ENABLE))
__GLB_CRON= $(if $(GLB_PROJECTPIPELINESCHEDULE_CRON_SCHEDULE),--cron $(GLB_PROJECTPIPELINESCHEDULE_CRON_SCHEDULE))
__GLB_CRON_TIMEZONE= $(if $(GLB_PROJECTPIPELINESCHEDULE_CRON_TIMEZONE),--cron-timezone $(GLB_PROJECTPIPELINESCHEDULE_CRON_TIMEZONE))
__GLB_DESCRIPTION__PROJECTPIPELINESCHEDULE= $(if $(GLB_PROJECTPIPELINESCHEDULE_NAME),--description $(GLB_PROJECTPIPELINESCHEDULE_NAME))
__GLB_ID__PROJECTPIPELINESCHEDULE= $(if $(GLB_PROJECTPIPELINESCHEDULE_ID),--id $(GLB_PROJECTPIPELINESCHEDULE_ID))
__GLB_PROJECT_ID__PROJECTPIPELINESCHEDULE= $(if $(GLB_PROJECTPIPELINESCHEDULE_PROJECT_ID),--project-id $(GLB_PROJECTPIPELINESCHEDULE_PROJECT_ID))
__GLB_PROJECT_ID__PROJECTPIPELINESCHEDULES= $(if $(GLB_PROJECTPIPELINESCHEDULES_PROJECT_ID),--project-id $(GLB_PROJECTPIPELINESCHEDULES_PROJECT_ID))
__GLB_REF__PROJECTPIPELINESCHEDULE= $(if $(GLB_PROJECTPIPELINESCHEDULE_REF),--ref $(GLB_PROJECTPIPELINESCHEDULE_REF))

# UI parameters

#--- Utilities

#--- MACROS

# Note that the name of the project-pipeline-schedule is not unique. Use the index if required!
_glb_get_projectpipelineschedule_id= $(call _glb_get_projectpipelineschedule_id_N, $(GLB_PROJECTPIPELINESCHEDULE_NAME))
_glb_get_projectpipelineschedule_id_N= $(call _glb_get_projectpipelineschedule_id_NP, $(1), $(GLB_PROJECTPIPELINESCHEDULE_PROJECT_ID))
_glb_get_projectpipelineschedule_id_NP= $(call _glb_get_projectpipelineschedule_id_NPI, $(1), $(2), $(GLB_PROJECTPIPELINESCHEDULE_INDEX))
_glb_get_projectpipelineschedule_id_NPI= $(shell $(GITLAB) --output json project-pipeline-schedule list --project-id $(2) | jq -r '[.[] | select(.description=="$(strip $(1))")][$3].id')

_glb_get_projectpipelineschedule_name= $(call _glb_get_projectpipelineschedule_name_I, $(GLB_PROJECTPIPELINESCHEDULE_ID))
_glb_get_projectpipelineschedule_name_I= $(call _glb_get_projectpipelineschedule_name_IP, $(1), $(GLB_PROJECTPIPELINESCHEDULE_PROJECT_ID))
_glb_get_projectpipelineschedule_name_IP= $(shell $(GITLAB) --output json project-pipeline-schedule get --id $(1) --project-id $(2) | jq -r '.description')

#----------------------------------------------------------------------
# USAGE
#

_glb_view_framework_macros ::
	@echo 'GitLaB::ProjectPipelineSchedule ($(_GITLAB_PROJECTPIPELINESCHEDULE_MK_VERSION)) macros:'
	@echo '    _glb_get_projectpipelineschedule_id_{|N|NP|NPI}    - get the id of project-pipeline-schedule (Name,ProjectId, Index)'
	@echo '    _glb_get_projectpipelineschedule_name_{|I|IP}      - get the name of project-pipeline-schedule (Id,ProjectId)'
	@echo

_glb_view_framework_parameters ::
	@echo 'GitLaB::ProjectPipelineSchedule ($(_GITLAB_PROJECTPIPELINESCHEDULE_MK_VERSION)) parameters:'
	@echo '    GLB_PROJECTPIPELINESCHEDULE_CRON_SCHEDULE=$(GLB_PROJECTPIPELINESCHEDULE_CRON_SCHEDULE)'
	@echo '    GLB_PROJECTPIPELINESCHEDULE_CRON_TIMEZONE=$(GLB_PROJECTPIPELINESCHEDULE_CRON_TIMEZONE)'
	@echo '    GLB_PROJECTPIPELINESCHEDULE_ID=$(GLB_PROJECTPIPELINESCHEDULE_ID)'
	@echo '    GLB_PROJECTPIPELINESCHEDULE_INDEX=$(GLB_PROJECTPIPELINESCHEDULE_INDEX)'
	@echo '    GLB_PROJECTPIPELINESCHEDULE_NAME=$(GLB_PROJECTPIPELINESCHEDULE_NAME)'
	@echo '    GLB_PROJECTPIPELINESCHEDULE_PROJECT_ID=$(GLB_PROJECTPIPELINESCHEDULE_PROJECT_ID)'
	@echo '    GLB_PROJECTPIPELINESCHEDULE_PROJECT_NAME=$(GLB_PROJECTPIPELINESCHEDULE_PROJECT_NAME)'
	@echo '    GLB_PROJECTPIPELINESCHEDULE_REF=$(GLB_PROJECTPIPELINESCHEDULE_REF)'
	@echo '    GLB_PROJECTPIPELINESCHEDULES_PROJECT_ID=$(GLB_PROJECTPIPELINESCHEDULE_PROJECT_ID)'
	@echo '    GLB_PROJECTPIPELINESCHEDULES_PROJECT_NAME=$(GLB_PROJECTPIPELINESCHEDULE_PROJECT_NAME)'
	@echo

_glb_view_framework_targets ::
	@echo 'GitLaB::ProjectPipelineSchedule ($(_GITLAB_PROJECTPIPELINESCHEDULE_MK_VERSION)) targets:'
	@echo '    _glb_activate_projectpipelineschedule      - activating a project-pipeline-schedules'
	@echo '    _glb_create_projectpipelineschedule        - create a project-pipeline-schedules'
	@echo '    _glb_deactivate_projectpipelineschedule    - deactivating a project-pipeline-schedules'
	@echo '    _glb_delete_projectpipelineschedule        - delete a project-pipeline-schedule '
	@echo '    _glb_own_projectpipelineschedule           - take ownership of a project-pipeline-schedule '
	@echo '    _glb_show_projectpipelineschedule          - show a project-pipeline-schedule '
	@echo '    _glb_update_projectpipelineschedule        - update a project-pipeline-schedule '
	@echo '    _glb_view_projectpipelineschedules         - view project-pipeline-schedules'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_glb_activate_projectpipelineschedule:
	@$(INFO) '$(GLB_UI_LABEL)Activateing the project-pipeline-schedule "$(GLB_PROJECTPIPELINESCHEDULE_NAME)" ...'; $(NORMAL)
	$(GITLAB) project-pipeline-schedule update --active true $(__GLB_ID__PROJECTPIPELINESCHEDULE) $(__GLB_PROJECT_ID__PROJECTPIPELINESCHEDULE)

_glb_create_projectpipelineschedule:
	@$(INFO) '$(GLB_UI_LABEL)Creating a project-pipeline-schedule "$(GLB_PROJECTPIPELINESCHEDULE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Pipelines cannot be triggered faster than the Sidekiq scheduler configured interval'; $(NORMAL)
	@$(WARN) 'A project-pipeline-schedule name is not necessarily unique, its id is'; $(NORMAL)
	$(GITLAB) project-pipeline-schedule create $(__GLB_ACTIVE) $(__GLB_CRON) $(__GLB_CRON_TIMEZONE) $(__GLB_DESCRIPTION__PROJECTPIPELINESCHEDULE) $(__GLB_PROJECT_ID__PROJECTPIPELINESCHEDULE) $(__GLB_REF__PROJECTPIPELINESCHEDULE)
	@$(WARN) 'A project-pipeline-schedule has been created, but no variable are yet attached to it'; $(NORMAL)

_glb_deactivate_projectpipelineschedule:
	@$(INFO) '$(GLB_UI_LABEL)Deactivateing the project-pipeline-schedule "$(GLB_PROJECTPIPELINESCHEDULE_NAME)" ...'; $(NORMAL)
	$(GITLAB) project-pipeline-schedule update --active false $(__GLB_ID__PROJECTPIPELINESCHEDULE) $(__GLB_PROJECT_ID__PROJECTPIPELINESCHEDULE)

_glb_delete_projectpipelineschedule:
	@$(INFO) '$(GLB_UI_LABEL)Deleting a project-pipeline-schedule "$(GLB_PROJECTPIPELINESCHEDULE_NAME)" ...'; $(NORMAL)
	$(GITLAB) project-pipeline-schedule delete $(__GLB_ID__PROJECTPIPELINESCHEDULE) $(__GLB_PROJECT_ID__PROJECTPIPELINESCHEDULE)

_glb_own_projectpipelineschedule:
	@$(INFO) '$(GLB_UI_LABEL)Take ownership of project-pipeline-schedule "$(GLB_PROJECTPIPELINESCHEDULE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation gives ownership of the schedule to the current user'; $(NORMAL)
	@$(WARN) 'Any failure of this schedule will trigger a notification to its owner'; $(NORMAL)
	$(GITLAB) project-pipeline-schedule take-ownership $(__GLB_ID__PROJECTPIPELINESCHEDULE) $(__GLB_PROJECT_ID__PROJECTPIPELINESCHEDULE)

_glb_show_projectpipelineschedule: _glb_show_projectpipelineschedule_description

_glb_show_projectpipelineschedule_description:
	@$(INFO) '$(GLB_UI_LABEL)Showing description of project-pipeline-schedule "$(GLB_PROJECTPIPELINESCHEDULE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Pipelines can Not be triggered faster than the Sidekiq scheduler configured interval'; $(NORMAL)
	$(GITLAB) project-pipeline-schedule get $(__GLB_ID__PROJECTPIPELINESCHEDULE) $(__GLB_PROJECT_ID__PROJECTPIPELINESCHEDULE)

_glb_update_projectpipelineschedule:
	@$(INFO) '$(GLB_UI_LABEL)Updating project-pipeline-schedule "$(GLB_PROJECTPIPELINESCHEDULE_NAME)" ...'; $(NORMAL)
	$(GITLAB) project-pipeline-schedule update $(__GLB_ID__PROJECTPIPELINESCHEDULE) $(__GLB_PROJECT_ID__PROJECTPIPELINESCHEDULE)

_glb_view_projectpipelineschedules:
	@$(INFO) '$(GLB_UI_LABEL)Viewing project-pipeline-schedules ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT show the attached variables'; $(NORMAL)
	$(GITLAB) project-pipeline-schedule list $(__GLB_PROJECT_ID__PROJECTPIPELINESCHEDULES)
