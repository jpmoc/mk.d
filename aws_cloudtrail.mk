_AWS_CLOUDTRAIL_MK_VERSION=0.99.6

# CTL_ACCOUNT_ID?= -

# Derived variables

# Options variables

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_makefile_macros :: _ctl_view_makefile_macros
_ctl_view_makefile_macros ::
	@#echo 'AWS::CloudTraiL ($(_AWS_CLOUDTRAIL_MK_VERSION)) macros:'
	@#echo

_view_makefile_targets :: _ctl_view_makefile_targets
_ctl_view_makefile_targets ::
	@#echo 'AWS::CloudTraiL ($(_AWS_CLOUDTRAIL_MK_VERSION)) targets:'
	@#echo 

_view_makefile_variables :: _ctl_view_makefile_variables
_ctl_view_makefile_variables ::
	@#echo 'AWS::CloudTraiL ($(_AWS_CLOUDTRAIL_MK_VERSION)) variables:'
	@#echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_cloudtrail_event.mk
-include $(MK_DIR)/aws_cloudtrail_trail.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
