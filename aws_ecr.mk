_AWS_ECR_MK_VERSION= 0.99.6

# ECR_ACCOUNT_ID?= 123456789012
# ECR_REGION_ID?= us-west-1

# Derived parameters
ECR_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
ECR_REGION_ID?= $(AWS_REGION_ID)

# Options parameters

# UI parameters
ECR_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _ecr_view_framework_macros
_ecr_view_framework_macros ::
	@#echo 'AWS::ECR ($(_AWS_ECR_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _ecr_view_framework_parameters
_ecr_view_framework_parameters ::
	@echo 'AWS::ECR ($(_AWS_ECR_MK_VERSION)) parameters:'
	@echo '    ECR_ACCOUNT_ID=$(ECR_ACCOUNT_ID)'
	@echo '    ECR_REGION_ID=$(ECR_REGION_ID)'
	@echo

_aws_view_framework_targets :: _ecr_view_framework_targets
_ecr_view_framework_targets ::
	@#echo 'AWS::ECR ($(_AWS_ECR_MK_VERSION)) targets:'
	@#echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_ecr_image.mk
-include $(MK_DIR)/aws_ecr_registry.mk
-include $(MK_DIR)/aws_ecr_repository.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
