_AWS_SNS_MK_VERSION = 0.99.0

# Varibales
#
# Derived variables

# Option variables

# UI variables
SNS_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _sns_view_makefile_macros
_sns_view_makefile_macros ::
	@#echo "AWS::SNS ($(_AWS_SNS_MK_VERSION)) macros:"
	@#echo

_aws_view_makefile_targets :: _sns_view_makefile_targets
_sns_view_makefile_targets ::
	@echo "AWS::SNS ($(_AWS_SNS_MK_VERSION)) targets:"
	@echo

_aws_view_makefile_variables :: _sns_view_makefile_variables
_sns_view_makefile_variables ::
	@#echo "AWS::SNS ($(_AWS_SNS_MK_VERSION)) variables:"
	@#echo


#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/aws_sns_subscription.mk
-include $(MK_DIR)/aws_sns_topic.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
