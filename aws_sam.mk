_AWS_SAM_MK_VERSION= 0.99.3

SAM_APIGATEWAY_URL?= http://172.0.0.1:3000
# SAM_AWS_PROFILE= emayssat
# SAM_AWS_REGION= us-east-1
# SAM_MODE_DEBUG?= false
# SAM_VERSION?= 1.9.0

# Derived parameters
SAM_AWS_PROFILE?= $(AWS_PROFILE)
SAM_AWS_REGION?= $(AWS_REGION)
SAM_MODE_DEBUG?= $(CMN_MODE_DEBUG)

# Options parameters

# UI parameters
SAM_UI_LABEL?= $(AWS_UI_LABEL)#

#--- Utilities

__SAM_ENVIRONMENT+= $(if $(SAM_AWS_PROFILE),AWS_PROFILE=$(SAM_AWS_PROFILE))

__SAM_OPTIONS+= $(if $(filter true, $(SAM_MODE_DEBUG)),--debug)
# https://github.com/awslabs/aws-sam-cli/issues/1435
# __SAM_OPTIONS+= $(if $(SAM_AWS_PROFILE),--profile $(SAM_AWS_PROFILE))
# __SAM_OPTIONS+= $(if $(SAM_AWS_REGION),--region $(SAM_AWS_REGION))

SAM_BIN?= sam
SAM?= $(strip $(__SAM_ENVIRONMENT) $(SAM_ENVIRONMENT) $(SAM_BIN) $(__SAM_OPTIONS) $(SAM_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _sam_view_framework_macros
_sam_view_framework_macros ::
	@echo 'AWS::SAM:: ($(_AWS_SAM_MK_VERSION)) macros:'
	@echo


_view_framework_parameters :: _sam_view_framework_parameters
_sam_view_framework_parameters ::
	@echo 'AWS::SAM:: ($(_AWS_SAM_MK_VERSION)) parameters:'
	@echo '    SAM=$(SAM)'
	@echo '    SAM_APIGATEWAY_URL=$(SAM_APIGATEWAY_URL)'
	@echo '    SAM_AWS_PROFILE=$(SAM_AWS_PROFILE)'
	@echo '    SAM_AWS_REGION=$(SAM_AWS_REGION)'
	@echo '    SAM_MODE_DEBUG=$(SAM_MODE_DEBUG)'
	@echo

_view_framework_targets :: _sam_view_framework_targets
_sam_view_framework_targets ::
	@echo 'AWS::SAM:: ($(_AWS_SAM_MK_VERSION)) targets:'
	@echo '    _sam_install_dependencies              - Install dependencies'
	@echo '    _sam_show_version                      - Show versions of utilities '
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/aws_sam_event.mk
-include $(MK_DIR)/aws_sam_localfunction.mk
-include $(MK_DIR)/aws_sam_localapi.mk
-include $(MK_DIR)/aws_sam_project.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _sam_install_dependencies
_sam_install_dependencies ::
	@$(INFO) '$(SAM_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-linux.html'; $(NORMAL)
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
	# test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
	# test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
	# test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
	# echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
	brew --version
	brew tap aws/tap
	brew install aws-sam-cli
	# OTHER INSTALL METHODS: https://aws.amazon.com/blogs/aws/new-aws-sam-local-beta-build-and-test-serverless-applications-locally/
	# npm install -g aws-sam-local
	# go get github.com/awslabs/aws-sam-local
	# but brew installation method is preferred @ https://github.com/awslabs/aws-sam-cli/issues/1273
	which sam
	sam --version

_view_versions :: _sam_show_version
_sam_show_version ::
	@$(INFO) '$(SAM_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	sam --version
