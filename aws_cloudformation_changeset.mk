_AWS_CLOUDFORMATION_CHANGESET_MK_VERSION= $(_AWS_CLOUDFORMATION_MK_VERSION)
 
# CFN_CHANGESET_DESCRIPTION?= "This is my change set description!"
# CFN_CHANGESET_NAME?= my-change-set
# CFN_CHANGESET_TAGS?=
# CFN_CHANGESET_TYPE?=

# Derived parameters

# Options parameters
__CFN_CHANGE_SET_NAME= $(if $(CFN_CHANGESET_NAME), --change-set-name $(CFN_CHANGESET_NAME))
__CFN_CHANGE_SET_TYPE= $(if $(CFN_CHANGESET_TYPE), --change-set-type $(CFN_CHANGESET_TYPE))
__CFN_DESCRIPTION_CHANGESET= $(if $(CFN_CHANGESET_DESCRIPTION), --description $(CFN_CHANGESET_DESCRIPTION))

# UI parameters
CFN_UI_VIEW_CHANGESETS_FIELDS?= .{ChangeSetName:ChangeSetName,StackName:StackName,_Description:Description,_Status:Status,_ExecutionStatus:ExecutionStatus}

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cfn_view_framework_macros ::
	@#echo 'AWS::CloudFormatioN::ChangeSet ($(_AWS_CLOUDFORMATION_CHANGESET_MK_VERSION)) macros:'
	@#echo

_cfn_view_framework_targets ::
	@echo 'AWS::CloudFormatioN::ChangeSet ($(_AWS_CLOUDFORMATION_CHANGESET_MK_VERSION)) targets:'
	@echo '    _cfn_create_changeset             - Create a change-set'
	@echo '    _cfn_delete_changeset             - Delete an existing change-set'
	@echo '    _cfn_execute_changeset            - Execute a change-set'
	@echo '    _cfn_show_changeset               - Show details of a change-set'
	@echo '    _cfn_view_changeset               - View all change-sets'
	@echo 

_cfn_view_framework_parameters ::
	@echo 'AWS::CloudFormatioN::ChangeSet ($(_AWS_CLOUDFORMATION_CHANGESET_MK_VERSION)) parameters:'
	@echo '    CFN_CHANGESET_DESCRIPTION=$(CFN_CHANGESET_DESCRIPTION)'
	@echo '    CFN_CHANGESET_NAME=$(CFN_CHANGESET_NAME)'
	@echo '    CFN_CHANGESET_TAGS=$(CFN_CHANGESET_TAGS)'
	@echo '    CFN_CHANGESET_TYPE=$(CFN_CHANGESET_TYPE)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cfn_create_changeset:
	@$(INFO) '$(AWS_UI_LABEL)Creating change-set "$(CFN_CHANGESET_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation create-change-set $(__CFN_CAPABILITIES) $(__CFN_CHANGE_SET_NAME) $(__CFN_CHANGE_SET_TYPE) $(__CFN_DESCRIPTION_CHANGESET) $(__CFN_NOTIFICATION_ARNS) $(__CFN_PARAMETERS) $(__CFN_RESOURCE_TYPES) $(__CFN_ROLE_ARN) $(__CFN_ROLLBACK_CONFIGURATION) $(__CFN_STACK_NAME) $(__CFN_TAGS) $(__CFN_TEMPLATE_BODY_OR_URL) $(__CFN_USE_PREVIOUS_TEMPLATE)

_cfn_delete_changeset:
	@$(INFO) '$(AWS_UI_LABEL)Deleting change-set "$(CFN_CHANGESET_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation delete-change-set $(__CFN_CHANGE_SET_NAME) $(__CFN_STACK_NAME)

_cfn_execute_changeset:
	@$(INFO) '$(AWS_UI_LABEL)Executing change-set "$(CFN_CHANGESET_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation delete-change-set $(__CFN_CHANGE_SET_NAME) $(__CFN_STACK_NAME)

_cfn_show_changeset:
	@$(INFO) '$(AWS_UI_LABEL)Showing change-set "$(CFN_CHANGESET_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation describe-change-set $(__CFN_CHANGE_SET_NAME) $(__CFN_STACK_NAME)

_cfn_view_changesets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing change-sets of stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation list-change-sets $(__CFN_STACK_NAME) --query "Summaries[]$(CFN_UI_VIEW_CHANGESETS_FIELDS)"
