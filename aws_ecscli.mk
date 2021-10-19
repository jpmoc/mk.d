_AWS_ECSCLI_MK_VERSION= 0.99.3

# ECI_ACCOUNT_ID?= 123456789012
# ECI_AWSPROFILE_NAME?=
# ECI_ENDPOINT_URL?=
ECI_INPUTS_DIRPATH?= ./
# ECI_LAUNCH_TYPE?= EC2
# ECI_MODE_YES?= false
# ECI_MODE_DEBUG?= false
# ECI_REGION_ID?= us-west-2

# Derived parameters
ECI_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
ECI_AWSPROFILE_NAME= $(AWS_PROFILE_NAME)
ECI_MODE_DEBUG?= $(CMN_MODE_DEBUG)
ECI_MODE_YES?= $(CMN_MODE_YES)
ECI_REGION_ID?= $(AWS_REGION_ID)

# Options parameters
__ECI_AWS_PROFILE= $(if $(ECI_AWSPROFILE_NAME),--aws-profile $(ECI_AWSPROFILE_NAME))
__ECI_REGION= $(if $(ECI_REGION_ID),--region $(ECI_REGION_ID))

# UI parameters
ECI_UI_LABEL?= $(AWS_UI_LABEL)#

#--- Utilities

ECSCLI_BIN?= ecs-cli
ECSCLI?= $(strip $(__ECSCLI_ENVIRONMENT) $(ECSCLI_ENVIRONMENT) $(ECSCLI_BIN) $(__ECSCLI_OPTIONS) $(ECSCLI_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _eci_view_framework_macros
_eci_view_framework_macros ::
	@echo 'AWS::EcsClI ($(_AWS_ECSCLI_MK_VERSION)) macros:'
	@echo


_view_framework_parameters :: _eci_view_framework_parameters
_eci_view_framework_parameters ::
	@echo 'AWS::EcsClI ($(_AWS_ECSCLI_MK_VERSION)) parameters:'
	@echo '    ECSCLI=$(ECSCLI)'
	@echo '    ECI_ACCOUNT_ID=$(ECI_ACCOUNT_ID)'
	@echo '    ECI_AWSPROFILE_NAME=$(ECI_AWSPROFILE_NAME)'
	@echo '    ECI_ENDPOINT_URL=$(ECI_ENDPOINT_URL)'
	@echo '    ECI_INPUTS_DIRPATH=$(ECI_INPUTS_DIRPATH)'
	@echo '    ECI_LAUNCH_TYPE=$(ECI_LAUNCH_TYPE)'
	@echo '    ECI_MODE_DEBUG=$(ECI_MODE_DEBUG)'
	@echo '    ECI_MODE_YES=$(ECI_MODE_YES)'
	@echo '    ECI_REGION_ID=$(ECI_REGION_ID)'
	@echo

_view_framework_targets :: _eci_view_framework_targets
_eci_view_framework_targets ::
	@echo 'AWS::EcsClI ($(_AWS_ECSCLI_MK_VERSION)) targets:'
	@echo '    _eci_install_dependencies              - Install dependencies'
	@echo '    _eci_show_license                      - Show license of utilities '
	@echo '    _eci_show_version                      - Show versions of utilities '
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_ecscli_cluster.mk
-include $(MK_DIR)/aws_ecscli_clusterconfig.mk
-include $(MK_DIR)/aws_ecscli_ecsprofile.mk
-include $(MK_DIR)/aws_ecscli_image.mk
-include $(MK_DIR)/aws_ecscli_service.mk
-include $(MK_DIR)/aws_ecscli_task.mk
-include $(MK_DIR)/aws_ecscli_taskdefinition.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _eci_install_dependencies
_eci_install_dependencies ::
	@$(INFO) '$(ECI_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI_installation.html'; $(NORMAL)
	$(SUDO) curl --output /usr/local/bin/ecs-cli --silent https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
	$(SUDO) chmod +755 /usr/local/bin/ecs-cli
	which ecs-cli
	ecs-cli --version

_eci_show_license:
	@$(INFO) '$(ECI_UI_LABEL)Showing license of dependencies ...'; $(NORMAL)
	ecs-cli license | more

_view_versions :: _eci_show_version
_eci_show_version ::
	@$(INFO) '$(ECI_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	ecs-cli --version
