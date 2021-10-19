_EKSCTL_MK_VERSION= 0.99.4

ECL_API_VERSION?= 1.14
# ECL_AWSACCOUNT_ID?=
# ECL_AWSPROFILE_NAME?=
# ECL_AWSREGION_ID?=
# ECL_INPUTS_DIRPATH?= ./in/
ECL_OUTPUT_FORMAT?= table
# ECL_OUTPUTS_DIRPATH?= ./out/
# EKSCTL_AWSPROFILE_NAME?=
# EKSCTL_AWSREGION_ID?=
EKSCTL_COLOR_FLAG?= false
# EKSCTL_KUBECONFIG_FILEPATH?=
EKSCTL_VERBOSITY_LEVEL?= 3

# Derived parameters
ECL_AWSACCOUNT_ID?= $(AWS_ACCOUNT_ID)
ECL_AWSPROFILE_NAME?= $(AWS_PROFILE_NAME)
ECL_AWSREGION_ID?= $(AWS_REGION_ID)
##  EKSCTL_AWSPROFILE_NAME?= $(ECL_AWSPROFILE_NAME)
##  EKSCTL_AWSREGION_ID?= $(ECL_AWSREGION_ID)
EKSCTL_KUBECONFIG_FILEPATH?= $(KUBECTL_KUBECONFIG_FILEPATH)

# Option parameters

# UI parameters
ECL_UI_LABEL?= [eksctl] [$(strip $(ECL_AWSPROFILE_NAME) $(ECL_AWSACCOUNT_ID) $(ECL_AWSREGION_ID))] #

#--- Utilities

__EKSCTL_ENVIRONMENT+= $(if $(EKSCTL_KUBECONFIG_FILEPATH),KUBECONFIG=$(EKSCTL_KUBECONFIG_FILEPATH))
## __EKSCTL_ENVIRONMENT+= $(if $(EKSCTL_AWSPROFILE_NAME),AWS_PROFILE=$(EKSCTL_AWSPROFILE_NAME))
## __EKSCTL_ENVIRONMENT+= $(if $(EKSCTL_AWSREGION_ID),AWS_REGION=$(EKSCTL_AWSREGION_ID))

__EKSCTL_OPTIONS+= $(if $(EKSCTL_COLOR_FLAG),--color=$(EKSCTL_COLOR_FLAG))
## __EKSCTL_OPTIONS+= $(if $(EKSCTL_AWSREGION_ID),--region=$(EKSCTL_AWSREGION_ID))
__EKSCTL_OPTIONS+= $(if $(EKSCTL_VERBOSITY_LEVEL),--verbose $(EKSCTL_VERBOSITY_LEVEL))

EKSCTL?= $(strip $(__EKSCTL_ENVIRONMENT) $(EKSCTL_ENVIRONMENT) eksctl $(__EKSCTL_OPTIONS) $(EKSCTL_OPTIONS))

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _ecl_view_framework_macros
_ecl_view_framework_macros ::
	@echo 'EksCtL ($(_EKSCTL_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _ecl_view_framework_parameters
_ecl_view_framework_parameters ::
	@echo 'EksCtL ($(_EKSCTL_MK_VERSION)) parameters:'
	@echo '    ECL_API_VERSION=$(ECL_API_VERSION)'
	@echo '    ECL_AWSACCOUNT_ID=$(ECL_AWSACCOUNT_ID)'
	@echo '    ECL_AWSPROFILE_ID=$(ECL_AWSPROFILE_ID)'
	@echo '    ECL_AWSREGION_ID=$(ECL_AWSREGION_ID)'
	@echo '    ECL_INPUTS_DIRPATH=$(ECL_INPUTS_DIRPATH)'
	@echo '    ECL_OUTPUT_FORMAT=$(ECL_OUTPUT_FORMAT)'
	@echo '    ECL_OUTPUTS_DIRPATH=$(ECL_OUTPUTS_DIRPATH)'
	@echo '    EKSCTL=$(EKSCTL)'
	@##echo '    EKSCTL_AWSPROFILE_NAME=$(EKSCTL_AWSPROFILE_NAME)'
	@##echo '    EKSCTL_AWSREGION_ID=$(EKSCTL_AWSREGION_ID)'
	@echo '    EKSCTL_COLOR_FLAG=$(EKSCTL_COLOR_FLAG)'
	@echo '    EKSCTL_VERBOSITY_LEVEL=$(EKSCTL_VERBOSITY_LEVEL)'
	@echo '    EKSCTL_KUBECONFIG_FILEPATH=$(EKSCTL_KUBECONFIG_FILEPATH)'
	@echo

_view_framework_targets :: _ecl_view_framework_targets
_ecl_view_framework_targets ::
	@echo 'EksCtL ($(_EKSCTL_MK_VERSION)) targets:'
	@echo '    _ecl_install_dependencies        - Install dependencies'
	@echo '    _ecl_view_versions               - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/eksctl_cluster.mk
-include $(MK_DIR)/eksctl_iamidentitymapping.mk
-include $(MK_DIR)/eksctl_kubeconfig.mk
-include $(MK_DIR)/eksctl_nodegroup.mk
-include $(MK_DIR)/eksctl_stack.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _ecl_install_dependencies
_ecl_install_dependencies ::
	@$(INFO) '$(ECL_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@# Install docs at https://eksctl.io/
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(shell uname -s)_amd64.tar.gz" | tar xz -C /tmp
	sudo mv -f /tmp/eksctl /usr/local/bin
	which eksctl
	eksctl version
	@# https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html
	curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator
	chmod +x ./aws-iam-authenticator
	sudo mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
	which aws-iam-authenticator
	aws-iam-authenticator help

_view_versions :: _ecl_view_versions
_ecl_view_versions:
	@$(INFO) '$(ECL_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(EKSCTL) version
	# aws-iam-authenticator --version
