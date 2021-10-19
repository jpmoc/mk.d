_AWS_INSPECTOR_MK_VERSION=0.99.6

# GCR_ACCOUNT_ID?= -

# Derived variables

# Options variables

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _ipr_view_makefile_macros
_ipr_view_makefile_macros ::
	@#echo 'AWS::InsPectoR ($(_AWS_INSPECTOR_MK_VERSION)) macros:'
	@#echo

_aws_view_makefile_targets :: _ipr_view_makefile_targets
_ipr_view_makefile_targets ::
	@#echo 'AWS::InsPectoR ($(_AWS_INSPECTOR_MK_VERSION)) targets:'
	@#echo 

_aws_view_makefile_variables :: _ipr_view_makefile_variables
_ipr_view_makefile_variables ::
	@#echo 'AWS::InsPectoR ($(_AWS_INSPECTOR_MK_VERSION)) variables:'
	@#echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_inspector_target.mk
-include $(MK_DIR)/aws_inspector_template.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
