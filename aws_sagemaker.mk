_AWS_SAGEMAKER_MK_VERSION= 0.99.6

# SMR_INPUTS_DIRPATH?= ./in/
# SMR_OUTPUTS_DIRPATH?= ./out/

# Derived parameters
# Option parameters
#
# UI parameters
SMR_UI_LABEL?= $(AWS_UI_LABEL)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _smr_view_framework_macros
_smr_view_framework_macros ::
	@#echo 'AWS::SageMakeR ($(_AWS_SAGEMAKER_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _smr_view_framework_parameters
_smr_view_framework_parameters ::
	@echo 'AWS::SageMakeR ($(_AWS_SAGEMAKER_MK_VERSION)) parameters:'
	@echo '    SMR_INPUTS_DIRPATH=$(SMR_INPUTS_DIRPATH)'
	@echo '    SMR_OUTPUTS_DIRPATH=$(SMR_OUTPUTS_DIRPATH)'
	@echo

_aws_view_framework_targets :: _smr_view_framework_targets
_smr_view_framework_targets ::
	@#echo 'AWS::SageMakeR ($(_AWS_SAGEMAKER_MK_VERSION)) targets:'
	@#echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_sagemaker_endpoint.mk
-include $(MK_DIR)/aws_sagemaker_lifecycleconfig.mk
-include $(MK_DIR)/aws_sagemaker_notebookinstance.mk
-include $(MK_DIR)/aws_sagemaker_trainingjob.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
