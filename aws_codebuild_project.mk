_AWS_CODEBUILD_PROJECT_MK_VERSION= $(_AWS_CODEBUILD_MK_VERSION)

# CBD_PROJECT_ARTIFACTS?= type=string,location=string,path=string,namespaceType=string,name=string,packaging=string
# CBD_PROJECT_ARTIFACTS_FILEPATH?= ./project-artifacts.json
# CBD_PROJECT_BADGE_ENABLED?= false
# CBD_PROJECT_BUILD_ID?= devops-webapp-project:d26242cc-27f8-4138-b078-256a9be435f6
CBD_PROJECT_BUILD_INDEX?= 0
# CBD_PROJECT_CACHE?= type=string,location=string
# CBD_PROJECT_CACHE_FILEPATH?= ./project-cache.json
# CBD_PROJECT_DESCRIPTION?= "This is my project!"
# CBD_PROJECT_ENCRYPTION_KEY?=
# CBD_PROJECT_NAME?= my-project
# CBD_PROJECT_ENVIRONMENT?= type=string,image=string,computeType=string,environmentVariables=[{name=string,value=string,type=string},{name=string,value=string,type=string}],privilegedMode=boolean,certificate=string
# CBD_PROJECT_ENVIRONMENT_FILEPATH?= ./project-environment.json
# CBD_PROJECT_SERVICEROLE_ARN?= arn:aws:iam::123456789012:role/DevopsWorkshop-roles-BuildTrustRole-DPU4KD612LLM
# CBD_PROJECT_SOURCE?= type=string,location=string,gitCloneDepth=integer,buildspec=string,auth={type=string,resource=string},insecureSsl=boolean
# CBD_PROJECT_SOURCE_FILEPATH?= ./project-source.json
# CBD_PROJECT_TAGS?= key=string,value=string ...
# CBD_PROJECT_TIMEOUTINMINUTES?= 1
# CBD_PROJECT_VPC_CONFIG?= vpcId=string,subnets=string,string,securityGroupIds=string,string

# Derived parameters
CBD_PROJECT_ARTIFACTS?= $(if $(CBD_PROJECT_ARTIFACTS_FILEPATH),file://$(CBD_PROJECT_ARTIFACTS_FILEPATH))
CBD_PROJECT_CACHE?= $(if $(CBD_PROJECT_CACHE_FILEPATH),file://$(CBD_PROJECT_CACHE_FILEPATH))
CBD_PROJECT_ENVIRONMENT?= $(if $(CBD_PROJECT_ENVIRONMENT_FILEPATH),file://$(CBD_PROJECT_ENVIRONMENT_FILEPATH))
CBD_PROJECT_SOURCE?= $(if $(CBD_PROJECT_SOURCE_FILEPATH),file://$(CBD_PROJECT_SOURCE_FILEPATH))

# Options parameters
__CBD_ARTIFACTS= $(if $(CBD_PROJECT_ARTIFACTS), --artifacts $(CBD_PROJECT_ARTIFACTS))
__CBD_BADGE_ENABLED= $(if $(filter true, $(CBD_PROJECT_BADGE_ENABLED)), --badge-enabled, --no-badge-enabled)
__CBD_CACHE= $(if $(CBD_PROJECT_CACHE), --cache $(CBD_PROJECT_CACHE))
__CBD_DESCRIPTION__PROJECT= $(if $(CBD_PROJECT_DESCRIPTION), --description $(CBD_PROJECT_DESCRIPTION))
__CBD_ENCRYPTION_KEY= $(if $(CBD_PROJECT_ENCRYPTION_KEY), --encryption-key $(CBD_PROJECT_ENCRYPTION_KEY))
__CBD_ENVIRONMENT= $(if $(CBD_PROJECT_ENVIRONMENT), --environment $(CBD_PROJECT_ENVIRONMENT))
__CBD_NAME__PROJECT= $(if $(CBD_PROJECT_NAME), --name $(CBD_PROJECT_NAME))
__CBD_PROJECT_NAME= $(if $(CBD_PROJECT_NAME), --project-name $(CBD_PROJECT_NAME))
__CBD_SERVICE_ROLE= $(if $(CBD_PROJECT_SERVICEROLE_ARN), --service-role $(CBD_PROJECT_SERVICEROLE_ARN))
__CBD_SORT_BY__PROJECT=
__CBD_SORT_ORDER__PROJECTS=
__CBD_SOURCE= $(if $(CBD_PROJECT_SOURCE), --source $(CBD_PROJECT_SOURCE))
__CBD_TAGS__PROJECT= $(if $(CBD_PROJECT_TAGS), --tags $(CBD_PROJECT_TAGS))
__CBD_TIMEOUT_IN_MINUTES= $(if $(CBD_PROJECT_TIMEOUTINMINUTES), --timeout-in-minutes $(CBD_PROJECT_TIMEOUTINMINUTES))
__CBD_VPC_CONFIG= $(if $(CBD_PROJECT_VPC_CONFIG), --vpc-config $(CBD_PROJECT_VPC_CONFIG))

# UI parameters
CBD_UI_VIEW_PROJECTS_FIELDS?=
CBD_UI_VIEW_PROJECTS_SET_FIELDS?= $(CBD_UI_VIEW_PROJECTS_FIELDS)
CBD_UI_VIEW_PROJECTS_SET_SLICE?=

#--- Utilities

#--- MACROS
_cbd_get_project_build_id= $(call _cbd_get_project_build_id_N, $(CBD_PROJECT_NAME))
_cbd_get_project_build_id_N= $(call _cbd_get_project_build_id_NI, $(1), $(CBD_PROJECT_BUILD_INDEX))
_cbd_get_project_build_id_NI= $(shell $(AWS) codebuild list-builds-for-project  --project-name $(1)  --query "ids[$(2)]" --output text)

#----------------------------------------------------------------------
# USAGE
#

_cbd_view_framework_macros ::
	@echo 'AWS::CodeBuilD::Project ($(_AWS_CODEBUILD_PROJECT_MK_VERSION)) macros:'
	@echo '    _cbd_get_project_build_id_{|N|NI}   - Get the ID of a project-build (Name,Index)'
	@echo

_cbd_view_framework_parameters ::
	@echo 'AWS::CodeBuilD::Project ($(_AWS_CODEBUILD_PROJECT_MK_VERSION)) parameters:'
	@echo '    CBD_PROJECT_ARTIFACTS=$(CBD_PROJECT_ARTIFACTS)'
	@echo '    CBD_PROJECT_ARTIFACTS_FILEPATH=$(CBD_PROJECT_ARTIFACTS_FILEPATH)'
	@echo '    CBD_PROJECT_BUILD_ID=$(CBD_PROJECT_BUILD_ID)'
	@echo '    CBD_PROJECT_BUILD_INDEX=$(CBD_PROJECT_BUILD_INDEX)'
	@echo '    CBD_PROJECT_CACHE=$(CBD_PROJECT_CACHE)'
	@echo '    CBD_PROJECT_CACHE_FILEPATH=$(CBD_PROJECT_CACHE_FILEPATH)'
	@echo '    CBD_PROJECT_DESCRIPTION=$(CBD_PROJECT_DESCRIPTION)'
	@echo '    CBD_PROJECT_ENCRYPTION_KEY=$(CBD_PROJECT_ENCRYPTION_KEY)'
	@echo '    CBD_PROJECT_ENVIRONMENT=$(CBD_PROJECT_ENVIRONMENT)'
	@echo '    CBD_PROJECT_ENVIRONMENT_FILEPATH=$(CBD_PROJECT_ENVIRONMENT_FILEPATH)'
	@echo '    CBD_PROJECT_NAME=$(CBD_PROJECT_NAME)'
	@echo '    CBD_PROJECT_SERVICEROLE_ARN=$(CBD_PROJECT_SERVICEROLE_ARN)'
	@echo '    CBD_PROJECT_SOURCE=$(CBD_PROJECT_SOURCE)'
	@echo '    CBD_PROJECT_SOURCE_FILEPATH=$(CBD_PROJECT_SOURCE_FILEPATH)'
	@echo '    CBD_PROJECT_TAGS=$(CBD_PROJECT_TAGS)'
	@echo '    CBD_PROJECT_TIMEOUTINMINUTES=$(CBD_PROJECT_TIMEOUTINMINUTES)'
	@echo '    CBD_PROJECT_VPC_CONFIG=$(CBD_PROJECT_VPC_CONFIG)'
	@echo

_cbd_view_framework_targets ::
	@echo 'AWS::CodeBuilD::Project ($(_AWS_CODEBUILD_PROJECT_MK_VERSION)) targets:'
	@echo '    _cbd_create_project                 - Create a new project'
	@echo '    _cbd_delete_project                 - Delete an existing project'
	@echo '    _cbd_invalidate_project_cache       - Invalidate the project cache'
	@echo '    _cbd_show_project                   - Show everything related to a project'
	@echo '    _cbd_show_project_builds            - Show builds related to a project'
	@echo '    _cbd_update_project                 - Update an existing project'
	@echo '    _cbd_view_projects                  - View existing projects'
	@echo '    _cbd_view_projects_set              - View a set of projects'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cbd_create_project:
	@$(INFO) '$(AWS_UI_LABEL)Creating project "$(CBD_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codebuild create-project $(__CBD_ARTIFACTS) $(__CBD_BADGE_ENABLED) $(__CBD_CACHE) $(__CBD_DESCRIPTION__PROJECT) $(__CBD_ENCRYPTION_KEY) $(__CBD_ENVIRONMENT) $(__CBD_NAME__PROJECT) $(__CBD_SOURCE) $(__CBD_SERVICE_ROLE) $(__CBD_TAGS__PROJECT) $(__CBD_TIMEOUT_IN_MINUTES) $(__CBD_VPC_CONFIG)

_cbd_delete_project:
	@$(INFO) '$(AWS_UI_LABEL)Deleting project "$(CBD_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codebuild delete-project $(__CBD_NAME__PROJECT)

_cbd_invalidate_project_cache:
	@$(INFO) '$(AWS_UI_LABEL)Invalidating cache of project "$(CBD_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codebuild invalidate-project-cache $(__CBD_PROJECT_NAME)

_cbd_show_project: _cbd_show_project_builds

_cbd_show_project_builds:
	@$(INFO) '$(AWS_UI_LABEL)Showing builds in project "$(CBD_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codebuild list-builds-for-project $(__CBD_PROJECT_NAME) $(__CBD_SORT_ORDER__BUILDS) --query "ids[]"

_cbd_update_project:
	@$(INFO) '$(AWS_UI_LABEL)Updating project "$(CBD_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codebuild update-project $(__CBD_ARTIFACTS) $(__CBD_BADGE_ENABLED) $(__CBD_CACHE) $(__CBD_DESCRIPTION__PROJECT) $(__CBD_ENCRYPTION_KEY) $(__CBD_ENVIRONMENT) $(__CBD_NAME__PROJECT) $(__CBD_SOURCE) $(__CBD_SERVICE_ROLE) $(__CBD_TAGS__PROJECT) $(__CBD_TIMEOUT_IN_MINUTES) $(__CBD_VPC_CONFIG)

_cbd_view_projects:
	@$(INFO) '$(AWS_UI_LABEL)Viewing projects ...'; $(NORMAL)
	$(AWS) codebuild list-projects $(__CBD_SORT_BY__PROJECT) $(__CBD_SORT_ORDER__PROJECTS) --query "projects[]$(CBD_UI_VIEW_PROJECTS_FIELDS)"

_cbd_view_projects_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing projects-set "$(CBD_PROJECTS_SET_NAME)"  ...'; $(NORMAL)
	$(AWS) codebuild list-projects $(__CBD_SORT_BY__PROJECT) $(__CBD_SORT_ORDER__PROJECTS) --query "projects[$(CDB_UI_VIEW_PROJECTS_SET_SLICE)]$(CBD_UI_VIEW_PROJECTS_SET_FIELDS)"
