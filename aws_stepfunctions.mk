_AWS_STEPFUCNTIONS_MK_VERSION= 0.99.0

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _sfs_view_framework_macros
_sfs_view_framework_macros ::
	@#echo 'AWS::StepFunctionS ($(_AWS_STEPFUNCTIONS_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _sfs_view_framework_parameters
_sfs_view_framework_parameters ::
	@#echo 'AWS::StepFunctionS ($(_AWS_STEPFUNCTIONS_MK_VERSION)) parameters:'
	@#echo

_view_framework_targets :: _sfs_view_framework_targets
_sfs_view_framework_targets ::
	@echo 'AWS::StepFunctionS ($(_AWS_STEPFUNCTIONS_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_stepfunctions_activity.mk
-include $(MK_DIR)/aws_stepfunctions_statemachine.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
