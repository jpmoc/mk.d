_AWS_CHALICE_PROJECT_MK_VERSION= $(_AWS_CHALICE_MK_VERSION)

CLE_PROJECT_AUTOGENPOLICY_ENABLE?= true
# CLE_PROJECT_AWS_PROFILE= 1234-emayssat@domain.com
# CLE_PROJECT_AWS_REGION= us-west-1
# CLE_PROJECT_BUCKET_NAME?= my-bucket-name
# CLE_PROJECT_BUILD_DIRPATH?= ./project/hello-cle/.aws-cle/build/
# CLE_PROJECT_DEPENDENCY_MANAGER?= pip
# CLE_PROJECT_DIRPATH?= ./projects/cle-app/
CLE_PROJECT_NAME?= cle-app
# CLE_PROJECT_RUNTIME?= python3.7
# CLE_PROJECT_RESTAPI_NAME?= p7efwe9tcl
# CLE_PROJECT_RESTAPI_URL?= https://p7efwe9tcl.execute-api.us-west-2.amazonaws.com/api/
# CLE_PROJECT_STACK_NAME?= aws-python-simple-http-endpoint-dev
CLE_PROJECT_STAGE_NAME?= dev
# CLE_PROJECT_TEMPLATE_FILEPATH?= ./projects/cle-app/template.yaml 
# CLE_PROJECT_TEMPLATE_LOCATION?= app
# CLE_PROJECTS_DIRPATH?= ./apps/
CLE_PROJECTS_NAME_REGEX?= */
CLE_PROJECTS_SET_NAME?= all-projects

# Derived parameters
CLE_PROJECT_AWS_PROFILE?= $(CLE_AWS_PROFILE)
CLE_PROJECT_AWS_REGION?= $(CLE_AWS_REGION)
CLE_PROJECT_DIRPATH?= $(CLE_PROJECTS_DIRPATH)$(CLE_PROJECT_NAME)/

# Options parameters
__CLE_AUTOGEN_POLICY= $(if $(filter false, $(CLE_PROJECT_AUTOGENPOLICY_ENABLE)),--no-autogen-policy,--autogen-policy)
__CLE_PROFILE__PROJECT= $(if $(CLE_PROJECT_AWS_PROFILE),--profile $(CLE_PROJECT_AWS_PROFILE))
__CLE_STAGE__PROJECT= $(if $(CLE_PROJECT_STAGE_NAME),--stage $(CLE_PROJECT_STAGE_NAME))

# Pipe parameters
_CLE_BUILD_PROJECT_|?= cd $(CLE_PROJECT_DIRPATH) && 
_CLE_CREATE_PROJECT_|?= cd $(CLE_PROJECTS_DIRPATH) && 
_CLE_DEPLOY_PROJECT_|?= cd $(CLE_PROJECT_DIRPATH) && 
_CLE_PACKAGE_PROJECT_|?= cd $(CLE_PROJECT_DIRPATH) && 
_CLE_SHOW_PROJECT_IAMPOLICIES_|?= cd $(CLE_PROJECT_DIRPATH) && 
_CLE_SHOW_PROJECT_RESTAPIURL_|?= cd $(CLE_PROJECT_DIRPATH) && 
_CLE_START_PROJECT_|?= cd $(CLE_PROJECT_DIRPATH) && 
_CLE_UNDEPLOY_PROJECT_|?= cd $(CLE_PROJECT_DIRPATH) && 
_CLE_VIEW_PROJECTS_|?= cd $(CLE_PROJECTS_DIRPATH) && 
_CLE_VIEW_PROJECTS_SET_|?= cd $(CLE_PROJECTS_DIRPATH) && 

# UI parameters

#--- Utilities

#--- MACROS
_cle_get_project_restapi_url= $(call _cle_get_project_restapi_url_D, $(CLE_PROJECT_DIRPATH))
_cle_get_project_restapi_url_D= $(shell cd $(CLE_PROJECT_DIRPATH); $(CHALICE) url)

# This macro is not tested!
_cle_get_project_runtime= $(shell python --version)

#----------------------------------------------------------------------
# USAGE
#

_cle_view_framework_macros ::
	@echo 'AWS::Chalice::Project ($(_AWS_CHALICE_PROJECT_MK_VERSION)) macros:'
	@echo '    _cle_get_project_restapi_url_{|D}         - Get the URL of a project rest API'
	@echo '    _cle_get_project_runtime                  - Get the runtime of a project'
	@echo

_cle_view_framework_parameters ::
	@echo 'AWS::Chalice::Project ($(_AWS_CHALICE_PROJECT_MK_VERSION)) parameters:'
	@echo '    CLE_PROJECT_AUTOGENPOLICY_ENABLE=$(CLE_PROJECT_AUTOGENPOLICY_ENABLE)'
	@echo '    CLE_PROJECT_AWS_PROFILE=$(CLE_PROJECT_AWS_PROFILE)'
	@#echo '    CLE_PROJECT_AWS_REGION=$(CLE_PROJECT_AWS_REGION)'
	@#echo '    CLE_PROJECT_BUCKET_NAME=$(CLE_PROJECT_BUCKET_NAME)'
	@#echo '    CLE_PROJECT_BUILD_DIRPATH=$(CLE_PROJECT_BUILD_DIRPATH)'
	@#echo '    CLE_PROJECT_DEPENDENCY_MANAGER=$(CLE_PROJECT_DEPENDENCY_MANAGER)'
	@#echo '    CLE_PROJECT_DEPLOY_CAPABILITIES=$(CLE_PROJECT_DEPLOY_CAPABILITIES)'
	@echo '    CLE_PROJECT_DIRPATH=$(CLE_PROJECT_DIRPATH)'
	@echo '    CLE_PROJECT_NAME=$(CLE_PROJECT_NAME)'
	@#echo '    CLE_PROJECT_OUTPUT_TEMPLATE=$(CLE_PROJECT_OUTPUT_TEMPLATE)'
	@echo '    CLE_PROJECT_RESTAPI_URL=$(CLE_PROJECT_RESTAPI_URL)'
	@echo '    CLE_PROJECT_RUNTIME=$(CLE_PROJECT_RUNTIME)'
	@echo '    CLE_PROJECT_STACK_NAME=$(CLE_PROJECT_STACK_NAME)'
	@echo '    CLE_PROJECT_STAGE_NAME=$(CLE_PROJECT_STAGE_NAME)'
	@#echo '    CLE_PROJECT_TEMPLATE_LOCATION=$(CLE_PROJECT_TEMPLATE_LOCATION)'
	@echo '    CLE_PROJECTS_DIRPATH=$(CLE_PROJECTS_DIRPATH)'
	@echo '    CLE_PROJECTS_NAME_REGEX=$(CLE_PROJECTS_NAME_REGEX)'
	@echo '    CLE_PROJECTS_SET_NAME=$(CLE_PROJECTS_SET_NAME)'
	@echo

_cle_view_framework_targets ::
	@echo 'AWS::Chalice::Project ($(_AWS_CHALICE_PROJECT_MK_PROJECT_VERSION)) targets:'
	@echo '    _cle_create_project                  - Create a new project'
	@echo '    _cle_delete_project                  - Delete a project'
	@echo '    _cle_deploy_project                  - Deploy a project'
	@#echo '    _cle_package_project                 - Package a project'
	@echo '    _cle_show_project                    - Show everything related to a project'
	@#echo '    _cle_show_project_build              - Show build of a project'
	@echo '    _cle_show_project_description        - Show the description of a project'
	@echo '    _cle_show_project_files              - Show files of a project'
	@echo '    _cle_show_project_iampolicies        - Show iam policies of a project'
	@echo '    _cle_show_project_restapiurl         - Show the URL of the rest API of a project'
	@echo '    _cle_show_project_runtime            - Show the runtime of a project'
	@#echo '    _cle_show_project_template           - Show template of a project'
	@echo '    _cle_view_projects                   - View projects'
	@echo '    _cle_view_projects_set               - View a set of projects'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cle_create_project:
	@$(INFO) '$(CLE_UI_LABEL)Creating project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the project already exists!'; $(NORMAL)
	-$(_CLE_CREATE_PROJECT_|) $(CHALICE) new-project $(CLE_PROJECT_NAME)

_cle_delete_project:
	@$(INFO) '$(CLE_UI_LABEL)Deleting project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)
	@read -p 'You are about to delete the project directory "$(CLE_PROJECT_DIRPATH)". Are you sure?' yesNo
	rm -r $(CLE_PROJECT_DIRPATH)

_cle_deploy_project:
	@$(INFO) '$(CLE_UI_LABEL)Deploying project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)
	$(_CLE_DEPLOY_PROJECT_|) $(CHALICE) deploy $(__CLE_AUTOGEN_POLICY) $(__CLE_PROFILE__PROJECT) $(__CLE_STAGE__PROJECT)

_cle_build_project:
	@$(INFO) '$(CLE_UI_LABEL)Building project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)
	$(_CLE_BUILD_PROJECT_|) $(CLE) build

_cle_package_project:
	@$(INFO) '$(CLE_UI_LABEL)Package project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)
	$(_CLE_PACKAGE_PROJECT_|) $(CLE) package $(__CLE_OUTPUT_TEMPLATE) $(__CLE_S3_BUCKET)

_cle_show_project :: _cle_show_project_files _cle_show_project_iampolicies _cle_show_project_restapiurl _cle_show_project_runtime _cle_show_project_template _cle_show_project_description

_cle_show_project_build: 
	@$(INFO) '$(CLE_UI_LABEL)Showing build of project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)
	[ -d $(CLE_PROJECT_BUILD_DIRPATH) ] && tree $(CLE_PROJECT_BUILD_DIRPATH)

_cle_show_project_description: 
	@$(INFO) '$(CLE_UI_LABEL)Showing description of project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)

_cle_show_project_files: 
	@$(INFO) '$(CLE_UI_LABEL)Showing files of project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)
	tree $(CLE_PROJECT_DIRPATH)

_cle_show_project_iampolicies: 
	@$(INFO) '$(CLE_UI_LABEL)Showing IAM policies of project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The policies are autogenerated by chalice'; $(NORMAL)
	$(_CLE_SHOW_PROJECT_IAMPOLICIES_|) $(CHALICE) gen-policy

_cle_show_project_restapiurl:
	@$(INFO) '$(CLE_UI_LABEL)Showing the URL of the rest API of project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)
	$(_CLE_SHOW_PROJECT_RESTAPIURL_|) $(CHALICE) url $(__CLE_STAGE__PROJECT)

_cle_show_project_runtime:
	@$(INFO) '$(CLE_UI_LABEL)Showing runtime of project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Local version of python: $(shell python -V)'; $(NORMAL)
	@echo 'CLE_PROJECT_RUNTIME=$(CLE_PROJECT_RUNTIME)'

_cle_show_project_template: 
	@$(INFO) '$(CLE_UI_LABEL)Showing cloudformation-template of project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'This template file contains CLE API Gateway + Lambda definitions'; $(NORMAL)
	@#$(WARN) 'It is used to generate all the project-templates sent to cloudformation'; $(NORMAL)
	@#$(WARN) 'In this template the paths to the lambda deployment-packages are assumed to be local'; $(NORMAL)
	# cat $(CLE_PROJECT_TEMPLATE_FILEPATH)

_cle_undeploy_project:
	@$(INFO) '$(CLE_UI_LABEL)Deleting deployment for project "$(CLE_PROJECT_NAME)" ...'; $(NORMAL)
	$(_CLE_UNDEPLOY_PROJECT_|) $(CHALICE) delete $(__CLE_PROFILE__PROJECT) $(__CLE_STAGE__PROJECT)

_cle_view_projects:
	@$(INFO) '$(CLE_UI_LABEL)Viewing projects ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no projects are found!'; $(NORMAL)
	-$(_CLE_VIEW_PROJECTS_|) ls -dl */

_cle_view_projects_set:
	@$(INFO) '$(CLE_UI_LABEL)Viewing projects-set "$(CLE_PROJECTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no matching projects are found!'; $(NORMAL)
	-$(_CLE_VIEW_PROJECTS_SET_|) ls -dl $(CLE_PROJECTS_NAME_REGEX)
