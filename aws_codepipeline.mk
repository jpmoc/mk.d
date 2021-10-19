_AWS_CODEPIPELINE_MK_VERSION= 0.99.6

# CPE_PARAMETER?=

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _cpe_view_makefile_macros
_cpe_view_makefile_macros ::
	@#echo 'AWS::CodePipelinE ($(_AWS_CODEPIPELINE_MK_VERSION)) macros:'
	@#echo

_aws_view_makefile_parameters :: _cpe_view_makefile_parameters
_cpe_view_makefile_parameters ::
	@#echo 'AWS::CodePipelinE ($(_AWS_CODEPIPELINE_MK_VERSION)) parameters:'
	@#echo

_aws_view_makefile_targets :: _cpe_view_makefile_targets
_cpe_view_makefile_targets ::
	@#echo 'AWS::CodePipelinE ($(_AWS_CODEPIPELINE_MK_VERSION)) targets:'
	@#echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_codepipeline_actiontype.mk
-include $(MK_DIR)/aws_codepipeline_pipeline.mk
-include $(MK_DIR)/aws_codepipeline_webhook.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS

