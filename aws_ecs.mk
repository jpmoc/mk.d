_AWS_ECS_MK_VERSION= 0.99.0

# ECS_ACCOUNT_ID?=
# ECS_INPUTS_DIRPATH?= ./in/
# ECS_PARAMETER?= value
# ECS_PRINCIPAL_ARN?=arn:aws:iam::123456789012:user/me@domain.com
# ECS_REGION_ID?= us-west-2
# ECS_SETTINGS_CONTAINERINSTANCE_LONGARN?= disabled
# ECS_SETTINGS_SERVICE_LONGARN?= disabled
# ECS_SETTINGS_TASK_LONGARN?= disabled

# Derived parameters
ECS_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
ECS_INPUTS_DIRPATH?= $(AWS_INPUTS_DIRPATH)
ECS_OUTPUTS_DIRPATH?= $(AWS_OUTPUTS_DIRPATH)
ECS_REGION_ID?= $(AWS_REGION_ID)

# Option parameters
__ECS_PRINCIPAL_ARN= $(if $(ECS_PRINCIPAL_ARN),--principal-arn $(ECS_PRINCIPAL_ARN))

# UI parameters
ECS_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- Macros


#----------------------------------------------------------------------
# USAGE
#

_aws_install_software_dependencies :: _ecs_install_software_dependencies
_ecs_install_software_dependencies ::

_aws_view_framework_macros :: _ecs_view_framework_macros
_ecs_view_framework_macros ::
	@#echo 'AWS::ECS ($(_AWS_ECS_MK_VERSION)) targets:'
	@#echo

_aws_view_framework_parameters :: _ecs_view_framework_parameters
_ecs_view_framework_parameters ::
	@echo 'AWS::ECS ($(_AWS_ECS_MK_VERSION)) parameters:'
	@echo '    ECS_ACCOUNT_ID=$(ECS_ACCOUNT_ID)'
	@echo '    ECS_INPUTS_DIRPATH=$(ECS_INPUTS_DIRPATH)'
	@echo '    ECS_PRINCIPAL_ARN=$(ECS_PRINCIPAL_ARN)'
	@echo '    ECS_REGION_ID=$(ECS_REGION_ID)'
	@echo '    ECS_SETTINGS_CONTAINERINSTANCE_LONGARN=$(ECS_SETTINGS_CONTAINERINSTANCE_LONGARN)'
	@echo '    ECS_SETTINGS_SERVICE_LONGARN=$(ECS_SETTINGS_SERVICE_LONGARN)'
	@echo '    ECS_SETTINGS_TASK_LONGARN=$(ECS_SETTINGS_TASK_LONGARN)'
	@echo

_aws_view_framework_targets :: _ecs_view_framework_targets
_ecs_view_framework_targets ::
	@echo 'AWS::ECS ($(_AWS_ECS_MK_VERSION)) targets:'
	@echo '    _ecs_reset_accountsettings                     - Reset account-settings'
	@echo '    _ecs_reset_accountsettings_containerinstance   - Reset account-settings for container-instances'
	@echo '    _ecs_reset_accountsettings_service             - Reset account-settings for services'
	@echo '    _ecs_reset_accountsettings_task                - Reset account-settings for tasks'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

MK_DIR?= .
-include $(MK_DIR)/aws_ecs_agent.mk
-include $(MK_DIR)/aws_ecs_cluster.mk
-include $(MK_DIR)/aws_ecs_containerinstance.mk
-include $(MK_DIR)/aws_ecs_service.mk
-include $(MK_DIR)/aws_ecs_task.mk
-include $(MK_DIR)/aws_ecs_taskdefinition.mk
-include $(MK_DIR)/aws_ecs_taskdefinitionfamily.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_ecs_reset_accountsettings:
	@$(INFO) '$(AWS_UI_LABEL)Resetting conntainer-instance account-settings ...'; $(NORMAL)
	$(if $(ECS_SETTINGS_CONTAINERINSTANCE_LONGARN),$(AWS) ecs put-account-setting --name containerInstanceLongArnFormat $(__ECS_PRINCIPAL_ARN) --value $(ECS_SETTINGS_CONTAINERINSTANCE_LONGARN))
	@$(INFO) '$(AWS_UI_LABEL)Resetting service account-settings ...'; $(NORMAL)
	$(if $(ECS_SETTINGS_SERVICE_LONGARN),$(AWS) ecs put-account-setting --name serviceLongArnFormat $(__ECS_PRINCIPAL_ARN) --value $(ECS_SETTINGS_SERVICE_LONGARN))
	@$(INFO) '$(AWS_UI_LABEL)Resetting task account-settings ...'; $(NORMAL)
	$(if $(ECS_SETTINGS_TASK_LONGARN),$(AWS) ecs put-account-setting --name taskLongArnFormat $(__ECS_PRINCIPAL_ARN) --value $(ECS_SETTINGS_TASK_LONGARN))

_ecs_view_accountsettings: 
	@$(INFO) '$(AWS_UI_LABEL)View account-settings ...'; $(NORMAL)
	$(AWS) ecs list-account-settings --name containerInstanceLongArnFormat $(__ECS_PRINCIPAL_ARN)
	$(AWS) ecs list-account-settings --name serviceLongArnFormat $(__ECS_PRINCIPAL_ARN)
	$(AWS) ecs list-account-settings --name taskLongArnFormat $(__ECS_PRINCIPAL_ARN)
