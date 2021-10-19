_AWS_CODEBUILD_MK_VERSION= 0.99.6

# CBD_PARAMETER?=

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _cbd_view_framework_macros
_cbd_view_framework_macros ::
	@#echo 'AWS::CodeBuilD ($(_AWS_CODEBUILD_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _cbd_view_framework_parameters
_cbd_view_framework_parameters ::
	@#echo 'AWS::CodeBuilD ($(_AWS_CODEBUILD_MK_VERSION)) parameters:'
	@#echo

_aws_view_framework_targets :: _cbd_view_framework_targets
_cbd_view_framework_targets ::
	@#echo 'AWS::CodeBuilD ($(_AWS_CODEBUILD_MK_VERSION)) targets:'
	@#echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_codebuild_build.mk
-include $(MK_DIR)/aws_codebuild_environment.mk
-include $(MK_DIR)/aws_codebuild_project.mk
-include $(MK_DIR)/aws_codebuild_webhook.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
