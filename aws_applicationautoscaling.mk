_AWS_APPLICATIONAUTOSCALING_MK_VERSION= 0.99.6

# AAG_SERVICE_NAMESPACE?= ec2

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _aag_view_framework_macros
_aag_view_framework_macros ::
	@#echo 'AWS::ApplicationAutoscalinG ($(_AWS_APPLICATIONAUTOSCALING_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _aag_view_framework_parameters
_aag_view_framework_parameters ::
	@echo 'AWS::ApplicationAutoscalinG ($(_AWS_APPLICATIONAUTOSCALING_MK_VERSION)) parameters:'
	@echo '    AAG_SERVICE_NAMESPACE=$(AAG_SERVICE_NAMESPACE)'
	@echo

_aws_view_framework_targets :: _aag_view_framework_targets
_aag_view_framework_targets ::
	@echo 'AWS::ApplicationAutoscalinG ($(_AWS_APPLICATIONAUTOSCALING_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_applicationautoscaling_scalabletarget.mk
-include $(MK_DIR)/aws_applicationautoscaling_scalingpolicy.mk
-include $(MK_DIR)/aws_applicationautoscaling_scheduledaction.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
