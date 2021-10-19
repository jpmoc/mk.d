_AWS_EKS_MK_VERSION= 0.99.6

# EKS_ACCOUNT_ID?= 123456789012
# EKS_REGION_ID?= us-east-1

# Derived parameters
EKS_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
EKS_REGION_ID?= $(AWS_REGION_ID)

# Option parameters

# UI parameters
EKS_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities
AWS_IAM_AUTHENTICATOR?=
AWS_IAM_AUTHENTICATOR_ARCH?= amd64
AWS_IAM_AUTHENTICATOR_OS?= linux
AWS_IAM_AUTHENTICATOR_VERSION?= 1.10.3

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _eks_install_framework_dependencies
_eks_install_framework_dependencies ::
	@# https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html
	curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/$(AWS_IAM_AUTHENTICATOR_OS)/amd64/aws-iam-authenticator
	chmod +x ./aws-iam-authenticator
	sudo mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
	which aws-iam-authenticator
	aws-iam-authenticator help


_aws_view_framework_macros :: _eks_view_framework_macros
_eks_view_framework_macros ::
	@echo 'AWS::EKS ($(_AWS_EKS_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _eks_view_framework_parameters
_eks_view_framework_parameters ::
	@echo 'AWS::EKS ($(_AWS_EKS_MK_VERSION)) parameters:'
	@echo '    EKS_ACCOUNT_ID=$(EKS_ACCOUNT_ID)'
	@echo '    EKS_REGION_ID=$(EKS_REGION_ID)'
	@echo

_aws_view_framework_targets :: _eks_view_framework_targets
_eks_view_framework_targets ::
	@echo 'AWS::EKS ($(_AWS_EKS_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_eks_addons.mk
-include $(MK_DIR)/aws_eks_cluster.mk
-include $(MK_DIR)/aws_eks_fargateprofiles.mk
-include $(MK_DIR)/aws_eks_kubeconfig.mk
-include $(MK_DIR)/aws_eks_nodegroup.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
