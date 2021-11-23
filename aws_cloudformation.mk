_AWS_CLOUDFORMATION_MK_VERSION=0.99.6

# CFN_UI_LABEL?= [cloudformation] #

# Derived parameters
CFN_UI_LABEL?= $(AWS_UI_LABEL)

# Options

# Customizations
_CFN_LIST_EXPORTS_FIELDS?= .{Name:Name,Value:Value}

# Utilities

# Macros
_cfn_get_export_N=$(call _cfn_get_export_NR, $(AWS_REGION))
_cfn_get_export_NR=$(shell $(AWS) cloudformation list-exports --query "Exports[?Name=='$(strip $(1))'].Value" --region $(2) --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_list_macros :: _cfn_list_macros
_cfn_list_macros ::
	@echo 'AWS::CloudFormatioN:: ($(_AWS_CLOUDFORMATION_MK_VERSION)) targets:'
	@echo '    _cfn_get_export_{N|NR}             - Get exported variables (Name,Region)'
	@echo 

_aws_list_parameters :: _list_parameters
_cfn_list_parameters ::
	@echo 'AWS::CloudFormatioN:: ($(_AWS_CLOUDFORMATION_MK_VERSION)) parameters:'
	@echo '    CFN_UI_LABEL=$(CFN_UI_LABEL)'
	@echo

_aws_list_targets :: _cfn_list_targets
_cfn_list_targets ::
	@echo 'AWS::CloudFormatioN:: ($(_AWS_CLOUDFORMATION_MK_VERSION)) targets:'
	@echo '    _cfn_install_dependencies         - Install software dependencies'
	@echo '    _cfn_list_exports                 - List regional and account-specific exports'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIRPATH?= ./
-include $(MK_DIRPATH)aws_cloudformation_changeset.mk
-include $(MK_DIRPATH)aws_cloudformation_layer.mk
-include $(MK_DIRPATH)aws_cloudformation_stack.mk
# -include $(MK_DIRPATH)aws_cloudformation_stackset.mk
-include $(MK_DIRPATH)aws_cloudformation_template.mk
-include $(MK_DIRPATH)aws_cloudformation_s3template.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_aws_install_dependencies :: _cfn_install_dependencies
_cfn_install_dependencies:
	sudo -H pip install cfn_flip
	sudo -H pip install troposphere[policy]

_cfn_list_exports:
	@$(INFO) '$(CFN_UI_LABEL)Listing regional and account-specific exports ...'; $(NORMAL)
	$(AWS) cloudformation list-exports --query "Exports[]$(_CFN_LIST_EXPORTS_FIELDS)"
