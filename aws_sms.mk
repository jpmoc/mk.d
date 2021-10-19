_AWS_SMS_MK_VERSION= 0.99.0

# Derived parameters

# Options parameters

# UI parameters

#--- Commands

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _waf_view_framework_macros
_waf_view_framework_macros ::
	@echo 'AWS::SMS ($(_AWS_SMS_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _waf_view_framework_parameters
_waf_view_framework_parameters ::
	@echo 'AWS::SMS ($(_AWS_SMS_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _waf_view_framework_targets
_waf_view_framework_targets ::
	@echo 'AWS::SMS ($(_AWS_SMS_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_sms_replicationjob.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
