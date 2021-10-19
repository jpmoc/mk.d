_AWS_SAM_PROJECT_MK_VERSION= $(_AWS_SAM_MK_VERSION)

# SAM_PROJECT_AWS_REGION= us-west-1
# SAM_PROJECT_BUCKET_NAME?= my-bucket-name
# SAM_PROJECT_BUILD_DIRPATH?= ./project/hello-sam/.aws-sam/build/
# SAM_PROJECT_DEPENDENCY_MANAGER?= pip
# SAM_PROJECT_DIRPATH?= ./projects/sam-app/
SAM_PROJECT_NAME?= sam-app
# SAM_PROJECT_OUTPUT_TEMPLATE?= packaged.yaml
# SAM_PROJECT_RUNTIME?= python3.7
# SAM_PROJECT_STACK_NAME?= aws-python-simple-http-endpoint-dev
SAM_PROJECT_STAGE_NAME?= prod
# SAM_PROJECT_TEMPLATE_FILEPATH?= ./projects/sam-app/template.yaml 
# SAM_PROJECT_TEMPLATE_LOCATION?= app
# SAM_PROJECTS_DIRPATH?= ./apps/
SAM_PROJECTS_NAME_REGEX?= */
SAM_PROJECTS_SET_NAME?= all-projects

# Derived parameters
SAM_PROJECT_AWS_REGION?= $(SAM_AWS_REGION)
SAM_PROJECT_BUCKET_NAME?= $(S3_BUCKET_NAME)
SAM_PROJECT_BUILD_DIRPATH?= $(SAM_PROJECT_DIRPATH).aws-sam/build/
SAM_PROJECT_DIRPATH?= $(SAM_PROJECTS_DIRPATH)$(SAM_PROJECT_NAME)/
SAM_PROJECT_STACK_NAME?= $(SAM_PROJECT_NAME)-$(SAM_PROJECT_STAGE_NAME)
SAM_PROJECT_TEMPLATE_FILEPATH?= $(SAM_PROJECT_DIRPATH)/template.yaml

# Options parameters
__SAM_CAPABILITIES= $(if $(SAM_PROJECT_DEPLOY_CAPABILITIES),--capabilities $(SAM_PROJECT_DEPLOY_CAPABILITIES))
__SAM_DEPENDENCY_MANAGER= $(if $(SAM_PROJECT_DEPENDENCY_MANAGER),--dependency-manager $(SAM_PROJECT_DEPENDENCY_MANAGER))
__SAM_NAME__PROJECT= $(if $(SAM_PROJECT_NAME),--name $(SAM_PROJECT_NAME))
__SAM_OUTPUT_TEMPLATE= $(if $(SAM_PROJECT_OUTPUT_TEMPLATE),--output-template $(SAM_PROJECT_OUTPUT_TEMPLATE))
__SAM_RUNTIME= $(if $(SAM_PROJECT_RUNTIME),--runtime $(SAM_PROJECT_RUNTIME))
__SAM_S3_BUCKET= $(if $(SAM_PROJECT_BUCKET_NAME),--s3-bucket $(SAM_PROJECT_BUCKET_NAME))
__SAM_STACK_NAME= $(if $(SAM_PROJECT_STACK_NAME),--stack-name $(SAM_PROJECT_STACK_NAME))
__SAM_TEMPLATE_FILE= $(if $(SAM_PROJECT_OUTPUT_TEMPLATE),--template-file $(SAM_PROJECT_OUTPUT_TEMPLATE))
__SAM_TEMPLATE_LOCATION= $(if $(SAM_PROJECT_TEMPLATE_LOCATION),--template-location $(SAM_PROJECT_TEMPLATE_LOCATION))

# Pipe parameters
_SAM_BUILD_PROJECT_|?= cd $(SAM_PROJECT_DIRPATH) && 
_SAM_CREATE_PROJECT_|?= cd $(SAM_PROJECTS_DIRPATH) && 
_SAM_DEPLOY_PROJECT_|?= cd $(SAM_PROJECT_DIRPATH) && 
_SAM_PACKAGE_PROJECT_|?= cd $(SAM_PROJECT_DIRPATH) && 
_SAM_SHOW_PROJECT_DESCRIPTION_|?= cd $(SAM_PROJECT_DIRPATH) && 
_SAM_START_PROJECT_|?= cd $(SAM_PROJECT_DIRPATH) && 
_SAM_VALIDATE_PROJECT_|?= cd $(SAM_PROJECT_DIRPATH) && 
_SAM_VIEW_PROJECTS_|?= cd $(SAM_PROJECTS_DIRPATH) && 
_SAM_VIEW_PROJECTS_SET_|?= cd $(SAM_PROJECTS_DIRPATH) && 

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sam_view_framework_macros ::
	@echo 'AWS::SAM::Project ($(_AWS_SAM_PROJECT_MK_VERSION)) macros:'
	@echo

_sam_view_framework_parameters ::
	@echo 'AWS::SAM::Project ($(_AWS_SAM_PROJECT_MK_VERSION)) parameters:'
	@echo '    SAM_PROJECT_AWS_REGION=$(SAM_PROJECT_AWS_REGION)'
	@echo '    SAM_PROJECT_BUCKET_NAME=$(SAM_PROJECT_BUCKET_NAME)'
	@echo '    SAM_PROJECT_BUILD_DIRPATH=$(SAM_PROJECT_BUILD_DIRPATH)'
	@echo '    SAM_PROJECT_DEPENDENCY_MANAGER=$(SAM_PROJECT_DEPENDENCY_MANAGER)'
	@echo '    SAM_PROJECT_DEPLOY_CAPABILITIES=$(SAM_PROJECT_DEPLOY_CAPABILITIES)'
	@echo '    SAM_PROJECT_DIRPATH=$(SAM_PROJECT_DIRPATH)'
	@echo '    SAM_PROJECT_NAME=$(SAM_PROJECT_NAME)'
	@echo '    SAM_PROJECT_OUTPUT_TEMPLATE=$(SAM_PROJECT_OUTPUT_TEMPLATE)'
	@echo '    SAM_PROJECT_RUNTIME=$(SAM_PROJECT_RUNTIME)'
	@echo '    SAM_PROJECT_STACK_NAME=$(SAM_PROJECT_STACK_NAME)'
	@echo '    SAM_PROJECT_STAGE_NAME=$(SAM_PROJECT_STAGE_NAME)'
	@echo '    SAM_PROJECT_TEMPLATE_LOCATION=$(SAM_PROJECT_TEMPLATE_LOCATION)'
	@echo '    SAM_PROJECTS_DIRPATH=$(SAM_PROJECTS_DIRPATH)'
	@echo '    SAM_PROJECTS_NAME_REGEX=$(SAM_PROJECTS_NAME_REGEX)'
	@echo '    SAM_PROJECTS_SET_NAME=$(SAM_PROJECTS_SET_NAME)'
	@echo

_sam_view_framework_targets ::
	@echo 'AWS::SAM::Project ($(_AWS_SAM_PROJECT_MK_PROJECT_VERSION)) targets:'
	@echo '    _sam_create_project                  - Create a new project'
	@echo '    _sam_delete_project                  - Delete a project'
	@echo '    _sam_deploy_project                  - Deploy a project'
	@echo '    _sam_package_project                 - Package a project'
	@echo '    _sam_show_project                    - Show everything related to a project'
	@echo '    _sam_show_project_build              - Show build of a project'
	@echo '    _sam_show_project_description        - Show the description of a project'
	@echo '    _sam_show_project_files              - Show files of a project'
	@echo '    _sam_show_project_template           - Show template of a project'
	@echo '    _sam_stop_project                    - Stop a local api a project'
	@echo '    _sam_validate_project                - Validate template of a project'
	@echo '    _sam_view_projects                   - View projects'
	@echo '    _sam_view_projects_set               - View a set of projects'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sam_create_project:
	@$(INFO) '$(SAM_UI_LABEL)Creating project "$(SAM_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the project already exists!'; $(NORMAL)
	-$(_SAM_CREATE_PROJECT_|) $(SAM) init $(__SAM_NAME__PROJECT) $(__SAM_RUNTIME) $(__SAM_TEMPLATE_LOCATION)

_sam_delete_project:
	@$(INFO) '$(SAM_UI_LABEL)Deleting project "$(SAM_PROJECT_NAME)" ...'; $(NORMAL)
	@read -p 'You are about to delete the project directory "$(SAM_PROJECT_DIRPATH)". Are you sure?' yesNo
	rm -r $(SAM_PROJECT_DIRPATH)

_sam_deploy_project:
	@$(INFO) '$(SAM_UI_LABEL)Deploying project "$(SAM_PROJECT_NAME)" ...'; $(NORMAL)
	$(_SAM_DEPLOY_PROJECT_|) $(AWS) cloudformation deploy $(__SAM_CAPABILITIES) $(__SAM_TEMPLATE_FILE) $(__SAM_STACK_NAME)

_sam_build_project:
	@$(INFO) '$(SAM_UI_LABEL)Building project "$(SAM_PROJECT_NAME)" ...'; $(NORMAL)
	$(_SAM_BUILD_PROJECT_|) $(SAM) build

_sam_package_project:
	@$(INFO) '$(SAM_UI_LABEL)Package project "$(SAM_PROJECT_NAME)" ...'; $(NORMAL)
	$(_SAM_PACKAGE_PROJECT_|) $(SAM) package $(__SAM_OUTPUT_TEMPLATE) $(__SAM_S3_BUCKET)

_sam_show_project :: _sam_show_project_build _sam_show_project_files _sam_show_project_template _sam_show_project_description

_sam_show_project_build: 
	@$(INFO) '$(SAM_UI_LABEL)Showing build of project "$(SAM_PROJECT_NAME)" ...'; $(NORMAL)
	[ -d $(SAM_PROJECT_BUILD_DIRPATH) ] && tree $(SAM_PROJECT_BUILD_DIRPATH)

_sam_show_project_description: 
	@$(INFO) '$(SAM_UI_LABEL)Showing description of project "$(SAM_PROJECT_NAME)" ...'; $(NORMAL)

_sam_show_project_files: 
	@$(INFO) '$(SAM_UI_LABEL)Showing files of project "$(SAM_PROJECT_NAME)" ...'; $(NORMAL)
	tree $(SAM_PROJECT_DIRPATH)

_sam_show_project_template: 
	@$(INFO) '$(SAM_UI_LABEL)Showing cloudformation-template of project "$(SAM_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This template file contains SAM API Gateway + Lambda definitions'; $(NORMAL)
	@$(WARN) 'It is used to generate all the project-templates sent to cloudformation'; $(NORMAL)
	@$(WARN) 'In this template the paths to the lambda deployment-packages are assumed to be local'; $(NORMAL)
	cat $(SAM_PROJECT_TEMPLATE_FILEPATH)

_sam_validate_project:
	@$(INFO) '$(SAM_UI_LABEL)Validating project "$(SAM_PROJECT_NAME)" ...'; $(NORMAL)
	$(_SAM_VALIDATE_PROJECT_|) $(SAM) validate

_sam_view_projects:
	@$(INFO) '$(SAM_UI_LABEL)Viewing projects ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no projects are found!'; $(NORMAL)
	-$(_SAM_VIEW_PROJECTS_|) ls -dl */

_sam_view_projects_set:
	@$(INFO) '$(SAM_UI_LABEL)Viewing projects-set "$(SAM_PROJECTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no matching projects are found!'; $(NORMAL)
	-$(_SAM_VIEW_PROJECTS_SET_|) ls -dl $(SAM_PROJECTS_NAME_REGEX)
