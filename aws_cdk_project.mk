_AWS_CDK_PROJECT_MK_VERSION= $(_AWS_CDK_MK_VERSION)

# CDK_PROJECT_DIRPATH?= ./projects/helloworld/
# CDK_PROJECT_LANGUAGE_NAME?= python
# CDK_PROJECT_NAME?= helloworld
CDK_PROJECT_TEMPLATE_NAME?= app
# CDK_PROJECTS_DIRPATH?= ./projects/
CDK_PROJECTS_NAME_REGEX?= */
CDK_PROJECTS_SET_NAME?= all-projects

# Derived parameters
CDK_PROJECT_DIRPATH?= $(CDK_PROJECTS_DIRPATH)$(CDK_PROJECT_NAME)/

# Options parameters
__CDK_LANGUAGE= $(if $(CDK_PROJECT_LANGUAGE_NAME),--language $(CDK_PROJECT_LANGUAGE_NAME))

# Pipe parameters
_CDK_CREATE_PROJECT_|?= cd $(CDK_PROJECT_DIRPATH) && 
_CDK_DEPLOY_PROJECT_|?= cd $(CDK_PROJECT_DIRPATH) && 
_CDK_SHOW_PROJECT_DESCRIPTION_|?= cd $(CDK_PROJECT_DIRPATH) && 
_CDK_SHOW_PROJECT_FILES_|?= cd $(CDK_PROJECTS_DIRPATH) && 
_CDK_VIEW_PROJECTS_|?= cd $(CDK_PROJECTS_DIRPATH) && 
_CDK_VIEW_PROJECTS_SET_|?= cd $(CDK_PROJECTS_DIRPATH) && 

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cdk_view_framework_macros ::
	@echo 'AWS::CDK::Project ($(_AWS_CDK_PROJECT_MK_VERSION)) macros:'
	@echo

_cdk_view_framework_parameters ::
	@echo 'AWS::CDK::Project ($(_AWS_CDK_PROJECT_MK_VERSION)) parameters:'
	@echo '    CDK_PROJECT_DIRPATH=$(CDK_PROJECT_DIRPATH)'
	@echo '    CDK_PROJECT_LANGUAGE_NAME=$(CDK_PROJECT_LANGUAGE_NAME)'
	@echo '    CDK_PROJECT_NAME=$(CDK_PROJECT_NAME)'
	@echo '    CDK_PROJECT_TEMPLATE_NAME=$(CDK_PROJECT_TEMPLATE_NAME)'
	@echo '    CDK_PROJECTS_DIRPATH=$(CDK_PROJECTS_DIRPATH)'
	@echo '    CDK_PROJECTS_NAME_REGEX=$(CDK_PROJECTS_NAME_REGEX)'
	@echo '    CDK_PROJECTS_SET_NAME=$(CDK_PROJECTS_SET_NAME)'
	@echo

_cdk_view_framework_targets ::
	@echo 'AWS::CDK::Project ($(_AWS_CDK_PROJECT_MK_VERSION)) targets:'
	@echo '    _cdk_create_project                  - Create a new project'
	@echo '    _cdk_delete_project                  - Delete an existing project'
	@echo '    _cdk_show_project                    - Show everything related to a project'
	@echo '    _cdk_show_project_build              - Show the description of a project'
	@echo '    _cdk_show_project_description        - Show the description of a project'
	@echo '    _cdk_show_project_files              - Show the files in a project'
	@echo '    _cdk_show_project_stacks             - Show the cloudformation-stacks of a project'
	@echo '    _cdk_show_project_templates          - Show the cloudformation-templates of a project'
	@echo '    _cdk_view_projects                   - View projects'
	@echo '    _cdk_view_projects_set               - View a set of projects'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cdk_create_project:
	@$(INFO) '$(CDK_UI_LABEL)Creating project "$(CDK_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the project already exists!'; $(NORMAL)
	-mkdir -pv $(CDK_PROJECT_DIRPATH)
	$(CDK) init --help
	-$(_CDK_CREATE_PROJECT_|) $(CDK) init $(__CDK_LANGUAGE) $(CDK_PROJECT_TEMPLATE_NAME)

_cdk_delete_project:
	@$(INFO) '$(CDK_UI_LABEL)Deleting project "$(CDK_PROJECT_NAME)" ...'; $(NORMAL)
	@read -p 'You are about to delete the project directory "$(CDK_PROJECT_DIRPATH)". Are you sure?' yesNo
	rm -r $(CDK_PROJECT_DIRPATH)

_cdk_show_project :: _cdk_show_project_files _cdk_show_project_stacks _cdk_show_project_templates _cdk_show_project_description

_cdk_show_project_description: 
	@$(INFO) '$(CDK_UI_LABEL)Showing description of project "$(CDK_PROJECT_NAME)" ...'; $(NORMAL)
	# $(_CDK_SHOW_PROJECT_DESCRIPTION_|) $(CDK) info $(__CDK_NO_COLOR__PROJECT) $(__CDK_REGION__PROJECT) $(__CDK_STAGE__PROJECT) $(__CDK_VERBOSE__PROJECT)

_cdk_show_project_files:
	@$(INFO) '$(CDK_UI_LABEL)Showing files of project "$(CDK_PROJECT_NAME)" ...'; $(NORMAL)
	-tree $(CDK_PROJECT_DIRPATH)

_cdk_show_project_stacks:
	@$(INFO) '$(CDK_UI_LABEL)Showing cloudformation-stacks of project "$(CDK_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the expected stack-names, which may or may not be deployed!'; $(NORMAL)
	$(_CDK_SHOW_PROJECT_STACKS_|) $(CDK) list

_cdk_show_project_templates:
	@$(INFO) '$(CDK_UI_LABEL)Showing cloudformation-templates of project "$(CDK_PROJECT_NAME)" ...'; $(NORMAL)
	$(_CDK_SHOW_PROJECT_STACKS_|) $(CDK) synth

_cdk_view_projects:
	@$(INFO) '$(CDK_UI_LABEL)Viewing projects ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no projects are found!'; $(NORMAL)
	-$(_CDK_VIEW_PROJECTS_|) ls -dl */

_cdk_view_projects_set:
	@$(INFO) '$(CDK_UI_LABEL)Viewing projects-set "$(CDK_PROJECTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no matching projects are found!'; $(NORMAL)
	-$(_CDK_VIEW_PROJECTS_SET_|) ls -dl $(CDK_PROJECTS_NAME_REGEX)
