_GITLAB_PROJECTPIPELINE_MK_VERSION= $(_GITLAB_MK_VERSION)

# GLB_PROJECTPIPELINE_ID?= 123456 
# GLB_PROJECTPIPELINE_NAME?= my-pipeline 
# GLB_PROJECTPIPELINE_PROJECT_ID?= 123456
# GLB_PROJECTPIPELINE_PROJECT_NAME?= my-project
GLB_PROJECTPIPELINES_PAGE_NUMBER?= 1
GLB_PROJECTPIPELINES_PAGE_DENSITY?= 10

# Derived parameters
GLB_PROJECTPIPELINE_NAME?= $(GLB_PROJECTPIPELINE_ID)
GLB_PROJECTPIPELINE_PROJECT_ID?= $(GLB_PROJECT_ID)
GLB_PROJECTPIPELINE_PROJECT_NAME?= $(GLB_PROJECT_NAME)

# Option parameters
__GLB_ID__PROJECTPIPELINE= $(if $(GLB_PROJECTPIPELINE_ID),--id $(GLB_PROJECTPIPELINE_ID))
__GLB_PAGE__PROJECTPIPELINES= $(if $(GLB_PROJECTPIPELINES_PAGE_NUMBER),--page $(GLB_PROJECTPIPELINES_PAGE_NUMBER))
__GLB_PER_PAGE__PROJECTPIPELINES= $(if $(GLB_PROJECTPIPELINES_PAGE_DENSITY),--per-page $(GLB_PROJECTPIPELINES_PAGE_DENSITY))
__GLB_PIPELINE_ID= $(if $(GLB_PROJECTPIPELINE_ID),--pipeline-id $(GLB_PROJECTPIPELINE_ID))
__GLB_PROJECT_ID__PROJECTPIPELINE= $(if $(GLB_PROJECTPIPELINE_PROJECT_ID),--project-id $(GLB_PROJECTPIPELINE_PROJECT_ID))

# UI parameters

#--- Utilities

#--- MACROS

_glb_get_projectpipeline_ref= $(call _glb_get_projectpipeline_ref_I, $(GLB_PROJECTPIPELINE_ID))
_glb_get_projectpipeline_ref_I= $(call _glb_get_projectpipeline_ref_IP, $(1), $(GLB_PROJECTPIPELINE_PROJECT_ID))
_glb_get_projectpipeline_ref_IP= $(shell $(GITLAB) --output json project-pipeline get --id $(1) --project-id $(2) | jq -r '.ref')

_glb_get_projectpipeline_status= $(call _glb_get_projectpipeline_status_I, $(GLB_PROJECTPIPELINE_ID))
_glb_get_projectpipeline_status_I= $(call _glb_get_projectpipeline_status_IP, $(1), $(GLB_PROJECTPIPELINE_PROJECT_ID))
_glb_get_projectpipeline_status_IP= $(shell $(GITLAB) --output json project-pipeline get --id $(1) --project-id $(2) | jq -r '.status')

_glb_get_projectpipeline_url= $(call _glb_get_projectpipeline_url_I, $(GLB_PROJECTPIPELINE_ID))
_glb_get_projectpipeline_url_I= $(call _glb_get_projectpipeline_url_IP, $(1), $(GLB_PROJECTPIPELINE_PROJECT_ID))
_glb_get_projectpipeline_url_IP= $(shell $(GITLAB) --output json project-pipeline get --id $(1) --project-id $(2) | jq -r '.web_url')

#----------------------------------------------------------------------
# USAGE
#

_glb_view_framework_macros ::
	@echo 'GitLaB::ProjectPipeline ($(_GITLAB_PROJECTPIPELINE_MK_VERSION)) macros:'
	@echo '    _glb_get_projectpipeline_ref_{|I|IP}     - get the ref of a project-pipeline (Id,ProjectId)'
	@echo '    _glb_get_projectpipeline_status_{|I|IP}  - get the status of a project-pipeline (Id,ProjectId)'
	@echo '    _glb_get_projectpipeline_url_{|I|IP}     - get the url of a project-pipeline (Id,ProjectId)'
	@echo

_glb_view_framework_parameters ::
	@echo 'GitLaB::ProjectPipeline ($(_GITLAB_PROJECTPIPELINE_MK_VERSION)) parameters:'
	@echo '    GLB_PROJECTPIPELINE_ID=$(GLB_PROJECTPIPELINE_ID)'
	@echo '    GLB_PROJECTPIPELINE_NAME=$(GLB_PROJECTPIPELINE_NAME)'
	@echo '    GLB_PROJECTPIPELINE_PROJECT_ID=$(GLB_PROJECTPIPELINE_PROJECT_ID)'
	@echo '    GLB_PROJECTPIPELINE_PROJECT_NAME=$(GLB_PROJECTPIPELINE_PROJECT_NAME)'
	@echo '    GLB_PROJECTPIPELINE_REF=$(GLB_PROJECTPIPELINE_REF)'
	@echo '    GLB_PROJECTPIPELINE_STATUS=$(GLB_PROJECTPIPELINE_STATUS)'
	@echo '    GLB_PROJECTPIPELINES_PAGE_NUMBER=$(GLB_PROJECTPIPELINE_PAGE_NUMBER)'
	@echo

_glb_view_framework_targets ::
	@echo 'GitLaB::ProjectPipeline ($(_GITLAB_PROJECTPIPELINE_MK_VERSION)) targets:'
	@echo '    _glb_rerun_projectpipeline               - rerun a project-pipeline'
	@echo '    _glb_retry_projectpipeline               - retry a project-pipeline'
	@echo '    _glb_run_projectpipeline                 - run a project-pipeline'
	@echo '    _glb_show_projectpipeline                - show everything related to a project-pipeline'
	@echo '    _glb_show_projectpipeline_description    - show description of a project-pipeline'
	@echo '    _glb_view_projectpipelines               - view  project-pipelines'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_glb_rerun_projectpipeline: GLB_PROJECT_TRIGGER_REF=$(GLB_PROJECTPIPELINE_REF)
_glb_rerun_projectpipeline: _glb_trigger_project 

_glb_retry_projectpipeline:
	@$(INFO) '$(GLB_UI_LABEL)Retying project-pipeline "$(GLB_PROJECTPIPELINE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation retries only failed pipelines'; $(NORMAL)
	$(GITLAB) project-pipeline retry $(__GLB_ID__PROJECTPIPELINE) $(__GLB_PROJECT_ID__PROJECTPIPELINE)

_glb_run_projectpipeline: _glb_trigger_project

_glb_show_projectpipeline: _glb_show_projectpipeline_jobs _glb_show_projectpipeline_description

_glb_show_projectpipeline_description:
	@$(INFO) '$(GLB_UI_LABEL)Showing description of project-pipeline "$(GLB_PROJECTPIPELINE_NAME)" ...'; $(NORMAL)
	$(GITLAB) project-pipeline get $(__GLB_ID__PROJECTPIPELINE) $(__GLB_PROJECT_ID__PROJECTPIPELINE)

_glb_show_projectpipeline_jobs:
	@$(INFO) '$(GLB_UI_LABEL)Showing jobs of project-pipeline "$(GLB_PROJECTPIPELINE_NAME)" ...'; $(NORMAL)
	$(GITLAB) project-pipeline-job list $(__GLB_PIPELINE_ID) $(__GLB_PROJECT_ID__PROJECTPIPELINE)

_glb_view_projectpipelines:
	@$(INFO) '$(GLB_UI_LABEL)Viewing project-pipelines ...'; $(NORMAL)
	@$(WARN) 'This operation returns only a limited number of project-pipelines'; $(NORMAL)
	$(GITLAB) project-pipeline list $(__GLB_PAGE__PROJECTPIPELINES) $(__GLB_PER_PAGE__PROJECTPIPELINES) $(__GLB_PROJECT_ID__PROJECTPIPELINE)
