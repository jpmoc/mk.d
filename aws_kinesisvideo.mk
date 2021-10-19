_AWS_KINESISVIDEO_MK_VERSION= 0.99.6

# KVO_PARAMETER?=

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _kvo_view_framework_macros
_kvo_view_framework_macros ::
	@echo 'AWS::KinesisVideO ($(_AWS_KINESISVIDEO_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _kvo_view_framework_parameters
_kvo_view_framework_parameters ::
	@echo 'AWS::KinesisVideO ($(_AWS_KINESISVIDEO_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _kvo_view_framework_targets
_kvo_view_framework_targets ::
	@echo 'AWS::KinesisVideO ($(_AWS_KINESISVIDEO_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_kinesisvideo_stream.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
