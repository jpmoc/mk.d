_AWS_SSM_MK_VERSION = 0.99.0

# SSM_KEY_ID?= alias/aws/ssm 

# Derived variables

# Option variables

# UI variables

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _ssm_view_makefile_macros
_ssm_view_makefile_macros ::
	@#echo "AWS::SSM ($(_AWS_SSM_MK_VERSION)) macros:"
	@#echo

_aws_view_makefile_targets :: _ssm_view_makefile_targets
_ssm_view_makefile_targets ::
	@#echo "AWS::SSM ($(_AWS_SSM_MK_VERSION)) targets:"
	@#echo

_aws_view_makefile_variables :: _ssm_view_makefile_variables
_ssm_view_makefile_variables ::
	@#echo "AWS::SSM ($(_AWS_SSM_MK_VERSION)) variables:"
	@#echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/aws_ssm_activation.mk
-include $(MK_DIR)/aws_ssm_association.mk
-include $(MK_DIR)/aws_ssm_command.mk
-include $(MK_DIR)/aws_ssm_document.mk
-include $(MK_DIR)/aws_ssm_maintenancewindow.mk
-include $(MK_DIR)/aws_ssm_parameter.mk
-include $(MK_DIR)/aws_ssm_patchbaseline.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

