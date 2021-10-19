_AWS_DEPLOY_MK_VERSION=0.99.6

# CBD_ENVIRONMENT_OS_PLATFORM?= UBUNTU

# Derived variables

# Options variables

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _dpy_view_makefile_macros
_dpy_view_makefile_macros ::
	@#echo 'AWS::DePloY ($(_AWS_DEPLOY_MK_VERSION)) macros:'
	@#echo

_aws_view_makefile_targets :: _dpy_view_makefile_targets
_dpy_view_makefile_targets ::
	@echo 'AWS::DePloY ($(_AWS_DEPLOY_MK_VERSION)) targets:'
	@echo 

_aws_view_makefile_variables :: _dpy_view_makefile_variables
_dpy_view_makefile_variables ::
	@echo 'AWS::DePloY ($(_AWS_DEPLOY_MK_VERSION)) variables:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_deploy_application.mk
-include $(MK_DIR)/aws_deploy_deploymentgroup.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
