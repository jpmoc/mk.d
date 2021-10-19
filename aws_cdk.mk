_AWS_CDK_MK_VERSION= 0.99.3

# CDK_AWS_PROFILE= emayssat
# CDK_AWS_REGION= us-east-1
# CDK_DEFAULT_ACCOUNT?= 1234567890
# CDK_DEFAULT_REGION?= us-west-2
# CDK_DOCS_URL?= https://docs.aws.amazon.com/cdk/latest
CDK_MODE_DEBUG?= false
# CDK_VERSION?= 1.9.0

# Derived parameters
CDK_AWS_PROFILE?= $(AWS_PROFILE)
CDK_AWS_REGION?= $(AWS_REGION)
CDK_MODE_DEBUG?= $(CMN_MODE_DEBUG)

# Options parameters

# UI parameters
CDK_UI_LABEL?= $(AWS_UI_LABEL)#

#--- Utilities

__CDK_ENVIRONMENT+= $(if $(CDK_AWS_REGION),AWS_REGION=$(AWS_REGION))
__CDK_ENVIRONMENT+= $(if $(CDK_DEFAULT_ACCOUNT),CDK_DEFAULT_ACCOUNT=$(CDK_DEFAULT_ACCOUNT))
__CDK_ENVIRONMENT+= $(if $(CDK_DEFAULT_REGION),CDK_DEFAULT_REGION=$(CDK_DEFAULT_REGION))
__CDK_OPTIONS+= $(if $(CDK_AWS_PROFILE),--profile $(CDK_AWS_PROFILE))
__CDK_OPTIONS+= $(if $(filter true,$(CDK_MODE_DEBUG)),--verbose)

CDK_BIN?= cdk
CDK?= $(strip $(__CDK_ENVIRONMENT) $(CDK_ENVIRONMENT) $(CDK_BIN) $(__CDK_OPTIONS) $(CDK_OPTIONS))

#--- MACROS
_cdk_get_docs_url= $(shell $(CDK) docs)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _cdk_view_framework_macros
_cdk_view_framework_macros ::
	@echo 'AWS::CDK:: ($(_AWS_CDK_MK_VERSION)) macros:'
	@echo '    _cdk_get_docs_url                       - Get the URL for the docs'
	@echo


_view_framework_parameters :: _cdk_view_framework_parameters
_cdk_view_framework_parameters ::
	@echo 'AWS::CDK:: ($(_AWS_CDK_MK_VERSION)) parameters:'
	@echo '    CDK=$(CDK)'
	@echo '    CDK_AWS_PROFILE=$(CDK_AWS_PROFILE)'
	@echo '    CDK_AWS_REGION=$(CDK_AWS_REGION)'
	@echo '    CDK_DEFAULT_ACCOUNT=$(CDK_DEFAULT_ACCOUNT)'
	@echo '    CDK_DEFAULT_REGION=$(CDK_DEFAULT_REGION)'
	@echo '    CDK_DOCS_URL=$(CDK_DOCS_URL)'
	@echo '    CDK_MODE_DEBUG=$(CDK_MODE_DEBUG)'
	@echo

_view_framework_targets :: _cdk_view_framework_targets
_cdk_view_framework_targets ::
	@echo 'AWS::CDK:: ($(_AWS_CDK_MK_VERSION)) targets:'
	@echo '    _cdk_install_dependencies              - Install dependencies'
	@echo '    _cdk_show_version                      - Show versions of utilities '
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/aws_cdk_project.mk
-include $(MK_DIR)/aws_cdk_stack.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _cdk_install_dependencies
_cdk_install_dependencies ::
	@$(INFO) '$(CDK_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	$(SUDO) apt-get -y install python3-venv
	$(SUDO) npm install --global aws-cdk
	which cdk
	cdk --version

_view_versions :: _cdk_show_version
_cdk_show_version ::
	@$(INFO) '$(CDK_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	cdk --version
	cdk docs
