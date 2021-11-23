_AWS_CLOUDFORMATION_STACKSET_MK_VERSION= $(_AWS_CLOUDFORMATION_MK_VERSION)

# CFN_STACKSET_DESCRIPTION?=
# CFN_STACKSET_NAME?=

# Derived parameters

# Options

# Customizations

# Macros

_cfn_get_stackset_stack_names=$(call _cfn_get_stack_names_S, $(CFN_STACKSET_NAME))
_cfn_get_stackset_stack_names_S=$(shell $(AWS) cloudformation list-stacks $(__CFN_STACK_STATUS_FILTER) --query "StackSummaries[?contains(StackName,'$(strip $(1))-')||StackName=='$(strip $(1))'].StackName" --output=text)

#----------------------------------------------------------------------
# USAGE
#

_cfn_list_macros ::
	@echo 'AWS::CloudFormatioN::StackSet ($(_AWS_CLOUDFORMATION_STACKSET_MK_VERSION)) macros:'
	@echo '    _cfn_get_stackset_stack_names_{|S}                    - Get the stack names of all the stack in a stackset (stackSet)'
	@echo

_cfn_list_parameters ::
	@echo 'AWS::CloudFormatioN::StackSet ($(_AWS_CLOUDFORMATION_STACKSET_MK_VERSION)) parameters:'
	@echo '    CFN_STACKSET_DESCRIPTION=$(CFN_STACKSET_DESCRIPTION)'
	@echo '    CFN_STACKSET_NAME=$(CFN_STACKSET_NAME)'
	@echo '    CFN_STACKSET_NAME=$(CFN_STACKSET_NAME)'
	@echo

_cfn_list_targets ::
	@echo 'AWS::CloudFormatioN::StackSet ($(_AWS_CLOUDFORMATION_STACKSET_MK_VERSION)) targets:'
	@echo '    _cfn_list_stacksets                     - View existing stacksets'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cfn_list_stacksets:
	@$(INFO) '$(CFN_UI_LABEL)Listing ALL stacksets ...'; $(NORMAL)
	$(AWS) cloudformation list-stack-sets
