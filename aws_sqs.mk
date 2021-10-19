_AWS_SQS_MK_VERSION=0.99.0

# SQS_QUEUE_URL?= https://sqs.us-east-1.amazonaws.com/80398EXAMPLE/MyNewerQueue

# Derived variables

# Options variables

# UI variables

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _sqs_view_makefile_macros
_sqs_view_makefile_macros ::
	@#echo "AWS::SQS ($(_AWS_SQS_MK_VERSION)) macros:"
	@#echo

_aws_view_makefile_targets :: _sqs_view_makefile_targets
_sqs_view_makefile_targets ::
	@#echo "AWS::SQS ($(_AWS_SQS_MK_VERSION)) targets:"
	@#echo

_aws_view_makefile_variables :: _sqs_view_makefile_variables
_sqs_view_makefile_variables ::
	@#echo "AWS::SQS ($(_AWS_SQS_MK_VERSION)) variables:"
	@#echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
MK_DIR?= .
-include $(MK_DIR)/aws_sqs_message.mk
-include $(MK_DIR)/aws_sqs_queue.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

