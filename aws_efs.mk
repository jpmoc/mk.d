_AWS_EFS_MK_VERSION=0.99.6

# EFS_SOMETHING?=

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_install_framework_dependencies :: _efs_install_framework_dependencies
_efs_install_framework_dependencies ::
	sudo apt-get install parallel          # GNU parallel to increase multi-threading of 'aws s3 cp'
	sudo apt-get install nload             # To monitor bandwidth usage ina terminal 'nload -u M'

_aws_view_framework_macros :: _efs_view_framework_macros
_efs_view_framework_macros ::
	@#echo 'AWS::EFS ($(_AWS_EFS_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _efs_view_framework_parameters
_efs_view_framework_parameters ::
	@#echo 'AWS::EFS ($(_AWS_EFS_MK_VERSION)) parameters:'
	@#echo

_aws_view_framework_targets :: _efs_view_framework_targets
_efs_view_framework_targets ::
	@#echo 'AWS::EFS ($(_AWS_EFS_MK_VERSION)) targets:'
	@#echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_efs_filesystem.mk
-include $(MK_DIR)/aws_efs_mounttarget.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
