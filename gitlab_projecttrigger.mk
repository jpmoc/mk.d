_GITLAB_PROJECTTRIGGER_MK_VERSION= $(_GITLAB_MK_VERSION)

# GLB_PROJECTTRIGGER_ID?= 123456 
# GLB_PROJECTTRIGGER_NAME?= my-pipeline 
# GLB_PROJECTTRIGGER_PROJECT_ID?= 123456
# GLB_PROJECTTRIGGER_PROJECT_NAME?= my-project
# GLB_PROJECTTRIGGER_PROJECT_ID?= 123456
# GLB_PROJECTTRIGGER_PROJECT_NAME?= my-project

# Derived parameters
GLB_PROJECTTRIGGER_PROJECT_ID?= $(GLB_PROJECT_ID)
GLB_PROJECTTRIGGER_PROJECT_NAME?= $(GLB_PROJECT_NAME)
GLB_PROJECTTRIGGERS_PROJECT_ID?= $(GLB_PROJECTTRIGGER_PROJECT_ID)
GLB_PROJECTTRIGGERS_PROJECT_NAME?= $(GLB_PROJECTTRIGGER_PROJECT_NAME)

# Option parameters
__GLB_DESCRIPTION__PROJECTTRIGGER?= $(if $(GLB_PROJECTTRIGGER_NAME),--description $(GLB_PROJECTTRIGGER_NAME))
__GLB_ID__PROJECTTRIGGER?= $(if $(GLB_PROJECTTRIGGER_ID),--id $(GLB_PROJECTTRIGGER_ID))
__GLB_PROJECT_ID__PROJECTTRIGGER?= $(if $(GLB_PROJECTTRIGGER_PROJECT_ID),--project-id $(GLB_PROJECTTRIGGER_PROJECT_ID))
__GLB_PROJECT_ID__PROJECTTRIGGERS?= $(if $(GLB_PROJECTTRIGGER_PROJECT_ID),--project-id $(GLB_PROJECTTRIGGERS_PROJECT_ID))

# UI parameters

#--- Utilities

#--- MACROS

_glb_get_projecttrigger_id= $(call _glb_get_projecttrigger_id_N, $(GLB_PROJECTTRIGGER_NAME))
_glb_get_projecttrigger_id_N= $(call _glb_get_projecttrigger_id_NP, $(1), $(GLB_PROJECTTRIGGER_PROJECT_ID))
_glb_get_projecttrigger_id_NP= $(shell $(GITLAB) --output json project-trigger list --project $(2) | jq '.[]|select(.description=="$(strip $(1))").id')

_glb_get_projecttrigger_token= $(call _glb_get_projecttrigger_token_I, $(GLB_PROJECTTRIGGER_ID))
_glb_get_projecttrigger_token_I= $(call _glb_get_projecttrigger_token_IP, $(1), $(GLB_PROJECTTRIGGER_PROJECT_ID))
_glb_get_projecttrigger_token_IP= $(shell $(GITLAB) --output json project-trigger get --id $(1) --project-id $(2) | jq -r '.token')

#----------------------------------------------------------------------
# USAGE
#

_glb_view_framework_macros ::
	@echo 'GitLaB::ProjectTrigger ($(_GITLAB_PROJECTTRIGGER_MK_VERSION)) macros:'
	@echo '    _glb_get_projecttrigger_token_{|I|II}        - Get the token of a project-trigger'
	@echo

_glb_view_framework_parameters ::
	@echo 'GitLaB::ProjectTrigger ($(_GITLAB_PROJECTTRIGGER_MK_VERSION)) parameters:'
	@echo '    GLB_PROJECTTRIGGER_ID=$(GLB_PROJECTTRIGGER_ID)'
	@echo '    GLB_PROJECTTRIGGER_NAME=$(GLB_PROJECTTRIGGER_NAME)'
	@echo '    GLB_PROJECTTRIGGER_PROJECT_ID=$(GLB_PROJECTTRIGGER_PROJECT_ID)'
	@echo '    GLB_PROJECTTRIGGER_PROJECT_NAME=$(GLB_PROJECTTRIGGER_PROJECT_NAME)'
	@echo '    GLB_PROJECTTRIGGER_TOKEN=$(GLB_PROJECTTRIGGER_TOKEN)'
	@echo '    GLB_PROJECTTRIGGERS_PROJECT_ID=$(GLB_PROJECTTRIGGERS_PROJECT_ID)'
	@echo '    GLB_PROJECTTRIGGERS_PROJECT_NAME=$(GLB_PROJECTTRIGGERS_PROJECT_NAME)'
	@echo

_glb_view_framework_targets ::
	@echo 'GitLaB::ProjectTrigger ($(_GITLAB_PROJECTTRIGGER_MK_VERSION)) targets:'
	@echo '    _glb_create_projecttrigger     - create a project-trigger'
	@echo '    _glb_view_projecttriggers      - view project-triggers'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_glb_create_projecttrigger: 
	@$(INFO) '$(GLB_UI_LABEL)Creating trigger "$(GLB_PROJECTTRIGGER_NAME)" ...'; $(NORMAL)
	$(GITLAB) project-trigger create $(__GLB_DESCRIPTION__PROJECTTRIGGER) $(__GLB_PROJECT_ID__PROJECTTRIGGER)

_glb_delete_projecttrigger:
	@$(INFO) '$(GLB_UI_LABEL)Deleting trigger "$(GLB_PROJECTTRIGGER_NAME)" ...'; $(NORMAL)
	$(GITLAB) project-trigger delete $(__GLB_ID__PROJECTTRIGGER) $(__GLB_PROJECT_ID__PROJECTTRIGGER)

_glb_view_projecttriggers:
	@$(INFO) '$(GLB_UI_LABEL)Viewing project-triggers ...'; $(NORMAL)
	$(GITLAB) project-trigger list $(__GLB_PROJECT_ID__PROJECTTRIGGERS)
