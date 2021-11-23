_AWS_EKS_MK_VERSION= 0.99.6

# EKS_ACCOUNT_ID?= 123456789012
EKS_IAMAUTHENTICATOR?=
EKS_IAMAUTHENTICATOR_ARCH?= amd64
EKS_IAMAUTHENTICATOR_OS?= linux
EKS_IAMAUTHENTICATOR_VERSION?= 1.10.3
# EKS_REGION_ID?= us-east-1
EKS_UI_LABEL?= $(AWS_UI_LABEL)

# Derived parameters
EKS_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
EKS_REGION_ID?= $(AWS_REGION_ID)

# Options

# Customizations

# Utilities

# Macros

#----------------------------------------------------------------------
# USAGE
#

_aws_list_macros :: _eks_list_macros
_eks_list_macros ::
	@#echo 'AWS::EKS:: ($(_AWS_EKS_MK_VERSION)) macros:'
	@#echo

_aws_list_parameters :: _eks_list_parameters
_eks_list_parameters ::
	@echo 'AWS::EKS:: ($(_AWS_EKS_MK_VERSION)) parameters:'
	@echo '    EKS_ACCOUNT_ID=$(EKS_ACCOUNT_ID)'
	@echo '    EKS_IAMAUTHENTICATOR_ARCH=$(EKS_IAMAUTHENTICATOR_ARCH)'
	@echo '    EKS_IAMAUTHENTICATOR_OS=$(EKS_IAMAUTHENTICATOR_OS)'
	@echo '    EKS_IAMAUTHENTICATOR_VERSION=$(EKS_IAMAUTHENTICATOR_VERSION)'
	@echo '    EKS_REGION_ID=$(EKS_REGION_ID)'
	@echo '    EKS_UI_LABEL=$(EKS_UI_LABEL)'
	@echo

_aws_list_targets :: _eks_list_targets
_eks_list_targets ::
	@echo 'AWS::EKS:: ($(_AWS_EKS_MK_VERSION)) targets:'
	@echo '    _eks_install_dependencies    - Install the dependencies'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIRPATH?= ./
-include $(MK_DIRPATH)aws_eks_addons.mk
-include $(MK_DIRPATH)aws_eks_cluster.mk
-include $(MK_DIRPATH)aws_eks_fargateprofiles.mk
-include $(MK_DIRPATH)aws_eks_kubeconfig.mk
-include $(MK_DIRPATH)aws_eks_nodegroup.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_dependencies :: _eks_install_dependencies
_eks_install_dependencies ::
	@# https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html
	curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/$(AWS_IAM_AUTHENTICATOR_OS)/amd64/aws-iam-authenticator
	chmod +x ./aws-iam-authenticator
	sudo mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
	which aws-iam-authenticator
	aws-iam-authenticator help
