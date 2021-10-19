_AWS_CHALICE_MK_VERSION= 0.99.3

# CLE_APIGATEWAY_URL?= http://172.0.0.1:3000
# CLE_AWS_PROFILE= emayssat
# CLE_AWS_REGION= us-east-1
# CLE_MODE_DEBUG?= false
# CLE_VERSION?= 1.9.0

# Derived parameters
CLE_AWS_PROFILE?= $(AWS_PROFILE)
CLE_AWS_REGION?= $(AWS_REGION)
CLE_MODE_DEBUG?= $(CMN_MODE_DEBUG)

# Options parameters

# UI parameters
CLE_UI_LABEL?= $(AWS_UI_LABEL)#

#--- Utilities

# __CHALICE_ENVIRONMENT+= $(if $(CFE_AWS_PROFILE),AWS_PROFILE=$(CFE_AWS_PROFILE))

# __CHALICE_OPTIONS+= $(if $(filter true, $(CFE_MODE_DEBUG)),--debug)
# https://github.com/awslabs/aws-sam-cli/issues/1435
# __CHALICE_OPTIONS+= $(if $(CFE_AWS_PROFILE),--profile $(CFE_AWS_PROFILE))
# __CHALICE_OPTIONS+= $(if $(CFE_AWS_REGION),--region $(CFE_AWS_REGION))

CHALICE_BIN?= chalice
CHALICE?= $(strip $(__CHALICE_ENVIRONMENT) $(CHALICE_ENVIRONMENT) $(CHALICE_BIN) $(__CHALICE_OPTIONS) $(CHALICE_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _cle_view_framework_macros
_cle_view_framework_macros ::
	@echo 'AWS::Chalice:: ($(_AWS_CHALICE_MK_VERSION)) macros:'
	@echo


_view_framework_parameters :: _cle_view_framework_parameters
_cle_view_framework_parameters ::
	@echo 'AWS::Chalice:: ($(_AWS_CHALICE_MK_VERSION)) parameters:'
	@echo '    CHALICE=$(CHALICE)'
	@#echo '    CLE_APIGATEWAY_URL=$(CLE_APIGATEWAY_URL)'
	@echo '    CLE_AWS_PROFILE=$(CLE_AWS_PROFILE)'
	@echo '    CLE_AWS_REGION=$(CLE_AWS_REGION)'
	@echo '    CLE_MODE_DEBUG=$(CLE_MODE_DEBUG)'
	@echo

_view_framework_targets :: _cle_view_framework_targets
_cle_view_framework_targets ::
	@echo 'AWS::Chalice:: ($(_AWS_CHALICE_MK_VERSION)) targets:'
	@echo '    _cle_install_dependencies              - Install dependencies'
	@echo '    _cle_show_version                      - Show versions of utilities '
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
# -include $(MK_DIR)/aws_chalice_event.mk
-include $(MK_DIR)/aws_chalice_iampolicy.mk
-include $(MK_DIR)/aws_chalice_localfunction.mk
-include $(MK_DIR)/aws_chalice_localapi.mk
-include $(MK_DIR)/aws_chalice_project.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _cle_install_dependencies
_cle_install_dependencies ::
	@$(INFO) '$(CLE_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-linux.html'; $(NORMAL)
	# http://wako.yaya.yoga/mywiki/SoftwareNotebook/LearningPython/PyAlternatives
	# $(SUDO) pip install chalice   # THe problem is that the version is installed for python3.5 
	$(SUDO) python3.7 -m pip install chalice
	which chalice
	chalice --version

_view_versions :: _cle_show_version
_cle_show_version ::
	@$(INFO) '$(CLE_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	@$(WARN) 'Chalice correctly works only for python version > 3.6'; $(NORMAL)
	chalice --version
