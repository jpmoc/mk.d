_AWS_CDK_STACK_MK_VERSION= $(_AWS_CDK_MK_VERSION)

# CDK_STACK_BUILD_DIRPATH?= ./projects/helloworld/cdk.out/
CDK_STACK_CREATE_APPROVAL?= any-change
CDK_STACK_DELETE_FORCE?= false
# CDK_STACK_NAME?= LambdaCronExample
# CDK_STACK_PROJECT_DIRPATH?= ./projects/helloworld/
# CDK_STACK_PROJECT_NAME?= helloworld
# CDK_STACK_TAGS_KEYVALUES?= Owner=EmmanuelMayssat ...

# Derived parameters
CDK_STACK_BUILD_DIRPATH?= $(CDK_PROJECT_DIRPATH)cdk.out/
CDK_STACK_PROJECT_DIRPATH?= $(CDK_PROJECTS_DIRPATH)
CDK_STACK_PROJECT_NAME?= $(CDK_PROJECT_NAME)

# Options parameters
__CDK_APP__STACK= $(if $(CDK_STACK_BUILD_DIRPATH),--app $(CDK_STACK_BUILD_DIRPATH))
__CDK_FORCE__STACK= $(if $(CDK_STACK_DELETE_FORCE),--force)
__CDK_REQUIRE_APPROVAL= $(if $(CDK_STACK_CREATE_APPROVAL),--require-approval $(CDK_STACK_CREATE_APPROVAL))
__CDK_TAGS__STACK= $(foreach KV, $(CDK_STACK_TAGS_KEYVALUES),--tags $(KV) )

# Pipe parameters

# UI parameters

#--- Utilities

#--- MACROS
_cdk_get_stack_name= $(call _cdk_get_stack_name_D, $(CDK_STACK_BUILD_DIRPATH)) 
_cdk_get_stack_name_D= $(shell $(CDK) list --app $(1)) 

#----------------------------------------------------------------------
# USAGE
#

_cdk_view_framework_macros ::
	@echo 'AWS::CDK::Stack ($(_AWS_CDK_STACK_MK_VERSION)) macros:'
	@echo '    _cdk_get_stack_name_{|D}            - Get the expected stack name (Dirpath)'
	@echo

_cdk_view_framework_parameters ::
	@echo 'AWS::CDK::Stack ($(_AWS_CDK_STACK_MK_VERSION)) parameters:'
	@echo '    CDK_STACK_BUILD_DIRPATH=$(CDK_STACK_BUILD_DIRPATH)'
	@echo '    CDK_STACK_CREATE_APPROVAL=$(CDK_STACK_CREATE_APPROVAL)'
	@echo '    CDK_STACK_DELETE_FORCE=$(CDK_STACK_DELETE_FORCE)'
	@echo '    CDK_STACK_NAME=$(CDK_STACK_NAME)'
	@echo '    CDK_STACK_PROJECT_DIRPATH=$(CDK_STACK_PROJECT_DIRPATH)'
	@echo '    CDK_STACK_PROJECT_NAME=$(CDK_STACK_PROJECT_NAME)'
	@echo '    CDK_STACK_TAGS_KEYVALUES=$(CDK_STACK_TAGS_KEYVALUES)'
	@echo

_cdk_view_framework_targets ::
	@echo 'AWS::CDK::Stack ($(_AWS_CDK_STACK_MK_VERSION)) targets:'
	@echo '    _cdk_create_stack                  - Create a new project-stack'
	@echo '    _cdk_delete_stack                  - Delete an existing project-stack'
	@echo '    _cdk_diff_stack                    - Diff a project-stack'
	@echo '    _cdk_show_stack                    - Show everything related to a project-stack'
	@echo '    _cdk_show_stack_description        - Show the description of a project-stack'
	@echo '    _cdk_show_stack_metadata           - Show the metadata of a project-stack'
	@echo '    _cdk_view_stacks                   - View project-stacks'
	@echo '    _cdk_view_stacks_set               - View a set of project-stacks'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cdk_create_stack:
	@$(INFO) '$(CDK_UI_LABEL)Creating cloudformation-stack "$(CDK_STACK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a stack change-set'; $(NORMAL)
	$(CDK) doctor
	$(CDK) deploy $(__CDK_APP__STACK) $(__CDK_REQUIRE_APPROVAL) $(__CDK_TAGS__STACK) $(CDK_STACK_NAME)

_cdk_delete_stack:
	@$(INFO) '$(CDK_UI_LABEL)Deleting cloudformation-stack "$(CDK_STACK_NAME)" ...'; $(NORMAL)
	$(CDK) doctor
	$(CDK) destroy $(__CDK_APP__STACK) $(__CDK_FORCE__STACK) $(CDK_STACK_NAME)

_cdk_diff_stack:
	@$(INFO) '$(CDK_UI_LABEL)Diff-ing cloudformation-stack "$(CDK_STACK_NAME)" ...'; $(NORMAL)
	$(CDK) diff $(__CDK_APP__STACK) $(CDK_STACK_NAME)

_cdk_show_stack :: _cdk_show_stack_metadata _cdk_show_stack_description

_cdk_show_stack_description:
	@$(INFO) '$(CDK_UI_LABEL)Showing cloudformation-stacks "$(CDK_STACK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the expected stack-names, which may or may not be deployed!'; $(NORMAL)
	$(CDK) list $(__CDK_APP__STACK)

_cdk_show_stack_metadata:
	@$(INFO) '$(CDK_UI_LABEL)Showing metadata of cloudformation-stack "$(CDK_STACK_NAME)" ...'; $(NORMAL)

_cdk_show_stack_project:
	@$(INFO) '$(CDK_UI_LABEL)Showing project of cloudformation-stack "$(CDK_STACK_NAME)" ...'; $(NORMAL)
	@echo 'CDK_STACK_PROJECT_NAME=$(CDK_STACK_PROJECT_NAME)'

_cdk_view_stacks:

_cdk_view_stacks_set:
