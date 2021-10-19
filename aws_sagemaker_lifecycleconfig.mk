_AWS_SAGEMAKER_LIFECYCLECONFIG_MK_VERSION= $(_AWS_SAGEMAKER_MK_VERSION)

# SMR_LIFECYCLECONFIG_ARN?= arn:aws:sagemaker:us-east-1:123456789012:notebook-instance-lifecycle-config/better-sagemaker
# SMR_LIFECYCLECONFIG_NAME?=
# SMR_LIFECYCLECONFIG_ONCREATE?=
# SMR_LIFECYCLECONFIG_ONSTART?=
# SMR_LIFECYCLECONFIGS_SET_NAME?=

# Derived parameters
SMR_LIFECYCLECONFIG_ARN?= arn:aws:sagemaker:$(AWS_REGION_ID):$(AWS_ACCOUNT_ID):notebook-instance-lifecycle-config/$(SMR_LIFECYCLECONFIG_NAME)

# Option parameters
__SMR_CREATION_TIME_AFTER__LIFECYCLECONFIGS=
__SMR_CREATION_TIME_BEFORE__LIFECYCLECONFIGS=
__SMR_LAST_MODIFIED_TIME_AFTER__LIFECYCLECONFIGS=
__SMR_LAST_MODIFIED_TIME_BEFORE__LIFECYCLECONFIGS=
__SMR_NAME_CONTAINS__LIFECYCLECONFIGS=
__SMR_NOTEBOOK_INSTANCE_LIFECYCLE_CONFIG_NAME= $(if $(SMR_LIFECYCLECONFIG_NAME),--notebook-instance-lifecycle-config-name $(SMR_LIFECYCLECONFIG_NAME))
__SMR_ON_CREATE= $(if $(SMR_LIFECYCLECONFIG_ONCREATE),--on-create $(SMR_LIFECYCLECONFIG_ONCREATE))
__SMR_ON_START= $(if $(SMR_LIFECYCLECONFIG_ONSTART),--on-start $(SMR_LIFECYCLECONFIG_ONSTART))
__SMR_SORT_BY__LIFECYCLECONFIGS=
__SMR_SORT_ORDER__LIFECYCLECONFIGS=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_smr_view_framework_macros ::
	@echo 'AWS::SageMakeR::LifecycleConfig ($(_AWS_SAGEMAKER_LIFECYCLECONFIG_MK_VERSION)) macros:'
	@echo

_smr_view_framework_parameters ::
	@echo 'AWS::SageMakeR::LifecycleConfig ($(_AWS_SAGEMAKER_LIFECYCLECONFIG_MK_VERSION)) parameters:'
	@echo '    SMR_LIFECYCLECONFIG_ARN=$(SMR_LIFECYCLECONFIG_ARN)'
	@echo '    SMR_LIFECYCLECONFIG_NAME=$(SMR_LIFECYCLECONFIG_NAME)'
	@echo '    SMR_LIFECYCLECONFIG_ONCREATE=$(SMR_LIFECYCLECONFIG_ONCREATE)'
	@echo '    SMR_LIFECYCLECONFIG_ONSTART=$(SMR_LIFECYCLECONFIG_ONSTART)'
	@echo '    SMR_LIFECYCLECONFIGS_SET_NAME=$(SMR_LIFECYCLECONFIGS_SET_NAME)'
	@echo

_smr_view_framework_targets ::
	@echo 'AWS::SageMakeR::LifecycleConfig ($(_AWS_SAGEMAKER_LIFECYCLECONFIG_MK_VERSION)) targets:'
	@echo '    _smr_create_lifecycleconfig             - Create a lifecycle-config'
	@echo '    _smr_delete_lifecycleconfig             - Create a lifecycle-config'
	@echo '    _smr_show_lifecycleconfig               - Show everything related to a lifecycle-config'
	@echo '    _smr_show_lifecycleconfig_description   - Show description of a lifecycle-config'
	@echo '    _smr_view_lifecycleconfigs              - View lifecycle-configs'
	@echo '    _smr_view_lifecycleconfigs_set          - View a set of lifecycle-configs'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_smr_create_lifecycleconfig:
	@$(INFO) '$(SMR_UI_LABEL)Creating lifecycle-config "$(SMR_LIFECYCLECONFIG_NAME)" ...'; $(NORMAL)
	$(AWS) sagemaker create-notebook-instance-lifecycle-config $(__SMR_NOTEBOOK_INSTANCE_LIFECYCLE_CONFIG_NAME) $(__SMR_ON_CREATE) $(__SMR_ON_START)

_smr_delete_lifecycleconfig:
	@$(INFO) '$(SMR_UI_LABEL)Deleting lifecycle-config "$(SMR_LIFECYCLECONFIG_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Before being deleted, a lifecycle-config needs to be stopped!'; $(NORMAL)
	$(AWS) sagemaker delete-notebook-instance-lifecycle-config $(__SMR_NOTEBOOK_INSTANCE_LIFECYCLE_CONFIG_NAME)

_smr_show_lifecycleconfig :: _smr_show_lifecycleconfig_description

_smr_show_lifecycleconfig_description:
	@$(INFO) '$(SMR_UI_LABEL)Showing description of lifecycle-config "$(SMR_LIFECYCLECONFIG_NAME)" ...'; $(NORMAL)
	$(AWS) sagemaker describe-notebook-instance-lifecycle-config $(__SMR_NOTEBOOK_INSTANCE_LIFECYCLE_CONFIG_NAME)

_smr_update_lifecycleconfig:
	@$(INFO) '$(SMR_UI_LABEL)Updating lifecycle-config "$(SMR_LIFECYCLECONFIG_NAME)" ...'; $(NORMAL)
	$(AWS) sagemakeer update-notebook-instance-lifecycle-config $(__SMR_NOTEBOOK_INSTANCE_LIFECYCLE_CONFIG_NAME) $(__SMR_ON_CREATE) $(__SMR_ON_START)

_smr_view_lifecycleconfigs:
	@$(INFO) '$(SMR_UI_LABEL)Viewing lifecycle-configs ...'; $(NORMAL)
	$(AWS) sagemaker list-notebook-instance-lifecycle-configs $(__SMR_CREATION_TIME_AFTER__LIFECYCLECONFIGS) $(__SMR_CREATION_TIME_BEFORE__LIFECYCLECONFIGS) $(__SMR_LAST_MODIFIED_TIME_AFTER__LIFECYCLECONFIGS) $(__SMR_LAST_MODIFIED_TIME_BEFORE__LIFECYCLECONFIGS) $(__SMR_NAME_CONTAINS__LIFECYCLECONFIGS) $(__SMR_SORT_BY__LIFECYCLECONFIGS) $(__SMR_SORT_ORDER__LIFECYCLECONFIGS)

_smr_view_lifecycleconfigs_set:
	@$(INFO) '$(SMR_UI_LABEL)Viewing lifecycle-configs "$(SMR_LIFECYCLECONFIGS_SET)" ...'; $(NORMAL)
	@$(WARN) 'Lifecycle-configs are grouped based on the provided ...'; $(NORMAL)
