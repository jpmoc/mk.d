_AWS_CLOUDFORMATION_MK_VERSION=0.99.6

# Derived parameters

# Options parameters

# UI parameters
CFN_UI_VIEW_EXPORTS_FIELDS?= .{Name:Name,Value:Value}

#--- Utilities

#--- MACROS
_cfn_get_export_N=$(call _cfn_get_export_NR, $(AWS_REGION))
_cfn_get_export_NR=$(shell $(AWS) cloudformation list-exports --query "Exports[?Name=='$(strip $(1))'].Value" --region $(2) --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_install_framework_dependencies :: _cfn_install_framework_dependencies
_cfn_install_framework_dependencies:
	sudo -H pip install cfn_flip
	sudo -H pip install troposphere[policy]

_aws_view_framework_macros :: _cfn_view_framework_macros
_cfn_view_framework_macros ::
	@echo 'AWS::CloudFormatioN ($(_AWS_CLOUDFORMATION_MK_VERSION)) targets:'
	@echo '    _cfn_get_export_{N|NR}             - Get exported variables (Name,Region)'
	@echo 

_aws_view_framework_parameters :: _cfn_view_framework_parameters
_cfn_view_framework_parameters ::
	@echo 'AWS::CloudFormatioN ($(_AWS_CLOUDFORMATION_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _cfn_view_framework_targets
_cfn_view_framework_targets ::
	@echo 'AWS::CloudFormatioN ($(_AWS_CLOUDFORMATION_MK_VERSION)) targets:'
	@echo '    _cfn_view_exports                 - View regional and account-specific exports'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

-include $(MK_DIR)/aws_cloudformation_changeset.mk
-include $(MK_DIR)/aws_cloudformation_layer.mk
-include $(MK_DIR)/aws_cloudformation_stack.mk
# -include $(MK_DIR)/aws_cloudformation_stackset.mk
-include $(MK_DIR)/aws_cloudformation_template.mk
-include $(MK_DIR)/aws_cloudformation_s3template.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cfn_view_exports:
	@$(INFO) '$(AWS_UI_LABEL)Viewing regional and account-specific exports ...'; $(NORMAL)
	$(AWS) cloudformation list-exports --query "Exports[]$(CFN_UI_VIEW_EXPORTS_FIELDS)"
