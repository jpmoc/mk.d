_AWS_KINESISANALYTICS_MK_VERSION= 0.99.6

# KAS_PARAMETER?=

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _kas_view_framework_macros
_kas_view_framework_macros ::
	@echo 'AWS::KinesisAnalyticS ($(_AWS_KINESISANALYTICS_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _kas_view_framework_parameters
_kas_view_framework_parameters ::
	@echo 'AWS::KinesisAnalyticS ($(_AWS_KINESISANALYTICS_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _kas_view_framework_targets
_kas_view_framework_targets ::
	@echo 'AWS::KinesisAnalyticS ($(_AWS_KINESISANALYTICS_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_kinesisanalytics_application.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
