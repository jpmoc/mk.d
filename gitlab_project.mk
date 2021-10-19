_GITLAB_PROJECT_MK_VERSION= $(_GITLAB_MK_VERSION)

# GLB_PROJECT_ID?= 21302
# GLB_PROJECT_NAME?= allspark-namespace
# GLB_PROJECT_OUTPUT?= yaml
GLB_PROJECT_OUTPUT_PAGE?= 1
GLB_PROJECT_OUTPUT_PERPAGE?= 10
# GLB_PROJECT_TRIGGER_REF?= branch-name
# GLB_PROJECT_TRIGGER_TOKEN?= XXXXXprxP8HAnmJNBcaKd
# GLB_PROJECT_TRIGGER_VARIABLES?= VAR1=my-var VAR2=my-var2 ...
# GLB_PROJECT_URL?= https://gitlab.example.com/api/v4/projects/9

# Derived parameters
GLB_PROJECT_OUTPUT?= $(GLB_OUTPUT)
GLB_PROJECT_TRIGGER_TOKEN?= $(GLB_PROJECTTRIGGER_TOKEN)
GLB_PROJECT_URL?= $(GLB_PROFILE_API_URL)/projects/$(GLB_PROJECT_ID)

# Option parameters
__GLB_FORM_VARIABLES__PROJECT= $(foreach NV, $(GLB_PROJECT_TRIGGER_VARIABLES),--form "variables[$(firstword $(subst =,$(SPACE),$(NV)))]=$(lastword $(subst =,$(SPACE),$(NV)))" )
__GLB_ID__PROJECT= $(if $(GLB_PROJECT_ID),--id $(GLB_PROJECT_ID))
__GLB_OUTPUT__PROJECT= $(if $(GLB_PROJECT_OUTPUT),--output $(GLB_PROJECT_OUTPUT))
__GLB_PROJECT_ID= $(if $(GLB_PROJECT_ID),--project-id $(GLB_PROJECT_ID))
__GLB_PAGE__PROJECT= $(if $(GLB_PROJECT_OUTPUT_PAGE),--page $(GLB_PROJECT_OUTPUT_PAGE))
__GLB_PER_PAGE__PROJECT= $(if $(GLB_PROJECT_OUTPUT_PERPAGE),--per-page $(GLB_PROJECT_OUTPUT_PERPAGE))
__GLB_REF__PROJECT= $(if $(GLB_PROJECT_TRIGGER_REF),--ref $(GLB_PROJECT_TRIGGER_REF))
__GLB_TOKEN__PROJECT= $(if $(GLB_PROJECT_TRIGGER_TOKEN),--token $(GLB_PROJECT_TRIGGER_TOKEN))

# UI parameters

#--- Utilities

#--- MACROS
_glb_get_project_name= $(call _glb_get_project_name_I, $(GLB_PROJECT_ID))
_glb_get_project_name_I= $(shell $(GITLAB) --output json project get --id $(GLB_PROJECT_ID) | jq -r '.name')

#----------------------------------------------------------------------
# USAGE
#

_glb_view_framework_macros ::
	@echo 'GitLaB::Project ($(_GITLAB_PROJECT_MK_VERSION)) macros:'
	@echo '    _glb_get_project_name_{|I}      - get the name of a project (Id)'
	@echo

_glb_view_framework_parameters ::
	@echo 'GitLaB::Project ($(_GITLAB_PROJECT_MK_VERSION)) parameters:'
	@echo '    GLB_PROJECT_ID=$(GLB_PROJECT_ID)'
	@echo '    GLB_PROJECT_NAME=$(GLB_PROJECT_NAME)'
	@echo '    GLB_PROJECT_OUTPUT=$(GLB_PROJECT_OUTPUT)'
	@echo '    GLB_PROJECT_OUTPUT_PAGE=$(GLB_PROJECT_OUTPUT_PAGE)'
	@echo '    GLB_PROJECT_OUTPUT_PERPAGE=$(GLB_PROJECT_OUTPUT_PERPAGE)'
	@echo '    GLB_PROJECT_TRIGGER_REF=$(GLB_PROJECT_TRIGGER_REF)'
	@echo '    GLB_PROJECT_TRIGGER_TOKEN=$(GLB_PROJECT_TRIGGER_TOKEN)'
	@echo '    GLB_PROJECT_TRIGGER_VARIABLES=$(GLB_PROJECT_TRIGGER_VARIABLES)'
	@echo '    GLB_PROJECT_URL=$(GLB_PROJECT_URL)'
	@echo '    __GLB_FORM_VARIABLES__PROJECT=$(__GLB_FORM_VARIABLES__PROJECT)'
	@echo

_glb_view_framework_targets ::
	@echo 'GitLaB::Project ($(_GITLAB_PROJECT_MK_VERSION)) targets:'
	@echo '    _glb_show_project                             - show everything related to a project'
	@echo '    _glb_show_project_approval                    - show approval of a project'
	@echo '    _glb_show_project_badges                      - show badges of a project'
	@echo '    _glb_show_project_branches                    - show branches in a project'
	@echo '    _glb_show_project_deployments                 - show deployments in a project'
	@echo '    _glb_show_project_environments                - show environments in a project'
	@echo '    _glb_show_project_jobs                        - show jobs in a project'
	@echo '    _glb_show_project_labels                      - show labels of a project'
	@echo '    _glb_show_project_notificationsettings        - show notification-settings of a project'
	@echo '    _glb_show_project_projectpipelineschedules    - show project-pipeline-schedules in a project'
	@echo '    _glb_show_project_projectpipelines            - show project-pipelines in a project'
	@echo '    _glb_show_project_protectedbranches           - show protected-branches in a project'
	@echo '    _glb_show_project_protectedtags               - show protected-tags in a project'
	@echo '    _glb_show_project_runners                     - show runners in a project'
	@echo '    _glb_show_project_services                    - show services in a project'
	@echo '    _glb_show_project_snippets                    - show snippets in a project'
	@echo '    _glb_show_project_tags                        - show tags in a project'
	@echo '    _glb_show_project_triggers                    - show triggers in a project'
	@echo '    _glb_show_project_users                       - show users in a project'
	@echo '    _glb_show_project_variables                   - show variables in a project'
	@echo '    _glb_show_project_wikipages                   - show wiki-pages of a project'
	@echo '    _glb_trigger_project                          - start a pipeline for project'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_glb_show_project: _glb_show_project_approval _glb_show_project_badges _glb_show_project_branches _glb_show_project_deployments _glb_show_project_environments _glb_show_project_jobs _glb_show_project_labels _glb_show_project_notificationsettings _glb_show_project_projectpipelines _glb_show_project_projectpipelineschedules _glb_show_project_protectedbranches _glb_show_project_protectedtags _glb_show_project_pushrules _glb_show_project_runners _glb_show_project_services _glb_show_project_snippets _glb_show_project_tags _glb_show_project_triggers _glb_show_project_users _glb_show_project_variables _glb_show_project_wikipages _glb_show_project_description

_glb_show_project_approval:
	@$(INFO) '$(GLB_UI_LABEL)Showing approval of project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the merge-request approval process'; $(NORMAL)
	$(GITLAB) project-approval get $(__GLB_PROJECT_ID)

_glb_show_project_badges:
	@$(INFO) '$(GLB_UI_LABEL)Showing badges of project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) badges'; $(NORMAL)
	$(GITLAB) project-badge list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_branches:
	@$(INFO) '$(GLB_UI_LABEL)Showing branches in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) branches'; $(NORMAL)
	$(GITLAB) project-branch list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_description:
	@$(INFO) '$(GLB_UI_LABEL)Showing description of project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)

_glb_show_project_deployments:
	@$(INFO) '$(GLB_UI_LABEL)Showing deployments in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) deployments'; $(NORMAL)
	$(GITLAB) project-deployment list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_environments:
	@$(INFO) '$(GLB_UI_LABEL)Showing environments in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) environments'; $(NORMAL)
	$(GITLAB) project-environment list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_jobs:
	@$(INFO) '$(GLB_UI_LABEL)Showing jobs in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) jobs'; $(NORMAL)
	$(GITLAB) project-job list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)
	
_glb_show_project_labels:
	@$(INFO) '$(GLB_UI_LABEL)Showing labels of project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) labels'; $(NORMAL)
	$(GITLAB) project-label list $(__GLB_PROJECT_ID)

_glb_show_project_notificationsettings:
	@$(INFO) '$(GLB_UI_LABEL)Showing notification-settings of project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	$(GITLAB) project-notification-settings get $(__GLB_PROJECT_ID)

_glb_show_project_projectpipelines:
	@$(INFO) '$(GLB_UI_LABEL)Showing project-pipelines in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation orders project-pipelines from latest to oldest'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) project-pipelines'; $(NORMAL)
	$(GITLAB) project-pipeline list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_projectpipelineschedules:
	@$(INFO) '$(GLB_UI_LABEL)Showing project-pipeline-schedules in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) project-pipeline-schedules'; $(NORMAL)
	$(GITLAB) project-pipeline-schedule list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_protectedbranches:
	@$(INFO) '$(GLB_UI_LABEL)Showing protected-branches in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) protected-branches'; $(NORMAL)
	$(GITLAB) project-protected-branch list $(__GLB_PROJECT_ID)

_glb_show_project_protectedtags:
	@$(INFO) '$(GLB_UI_LABEL)Showing protected-tags in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) protected-tags'; $(NORMAL)
	$(GITLAB) project-protected-tag list $(__GLB_PROJECT_ID)

_glb_show_project_pushrules:
	@$(INFO) '$(GLB_UI_LABEL)Showing push-rules in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	$(GITLAB) project-push-rules get $(__GLB_PROJECT_ID)

_glb_show_project_runners:
	@$(INFO) '$(GLB_UI_LABEL)Showing runners in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) runners'; $(NORMAL)
	$(GITLAB) project-runner list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_services:
	@$(INFO) '$(GLB_UI_LABEL)Showing services in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) services'; $(NORMAL)
	$(GITLAB) project-service list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_snippets:
	@$(INFO) '$(GLB_UI_LABEL)Showing snippets in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) snippets'; $(NORMAL)
	$(GITLAB) project-snippet list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_tags:
	@$(INFO) '$(GLB_UI_LABEL)Showing tags in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) tags'; $(NORMAL)
	$(GITLAB) project-tag list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_triggers:
	@$(INFO) '$(GLB_UI_LABEL)Showing triggers in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) triggers'; $(NORMAL)
	$(GITLAB) project-trigger list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_users:
	@$(INFO) '$(GLB_UI_LABEL)Showing users in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) users'; $(NORMAL)
	$(GITLAB) project-user list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_variables:
	@$(INFO) '$(GLB_UI_LABEL)Showing variables in project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) variables'; $(NORMAL)
	$(GITLAB) project-variable list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_show_project_wikipages:
	@$(INFO) '$(GLB_UI_LABEL)Showing wiki-pages of project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'As configured, this operation shows a maximum of $(GLB_PROJECT_OUTPUT_PERPAGE) wiki-pages'; $(NORMAL)
	$(GITLAB) project-wiki list $(__GLB_PAGE__PROJECT) $(__GLB_PER_PAGE__PROJECT) $(__GLB_PROJECT_ID)

_glb_trigger_project:
	@$(INFO) '$(GLB_UI_LABEL)Triggering project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation tries to match a tag first and a branch second'; $(NORMAL)
	$(GITLAB) project trigger-pipeline $(__GLB_ID__PROJECT) $(__GLB_REF__PROJECT) $(__GLB_TOKEN__PROJECT)

_glb_trigger2_project:
	@$(INFO) '$(GLB_UI_LABEL)Triggering project "$(GLB_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation tries to match a tag first and a branch second'; $(NORMAL)
	curl --request POST --form token=$(GLB_PROJECT_TRIGGER_TOKEN) --form ref=$(GLB_PROJECT_TRIGGER_REF) $(__GLB_FORM_VARIABLES__PROJECT) $(GLB_PROJECT_URL)/trigger/pipeline
