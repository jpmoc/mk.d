_AWS_SAGEMAKER_NOTEBOOKINSTANCE_MK_VERSION= $(_AWS_SAGEMAKER_MK_VERSION)

# SMR_INSTANCE_KMSKEY_ID?=
# SMR_NOTEBOOKINSTANCE_LIFECYCLECONFIG_NAME?=
# SMR_NOTEBOOKINSTANCE_NAME?=
# SMR_NOTEBOOKINSTANCE_ROLE_ARN?=
SMR_NOTEBOOKINSTANCE_ROOTACCESS_FLAG?= true
# SMR_NOTEBOOKINSTANCE_SECURITYGROUP_ID?=
# SMR_NOTEBOOKINSTANCE_SUBNET_ID?=
# SMR_NOTEBOOKINSTANCE_TAGS_KEYVALUES+=
# SMR_NOTEBOOKINSTANCE_TYPE?= ml.t2.medium
SMR_NOTEBOOKINSTANCE_VOLUME_SIZE?= 5# GB
# SMR_NOTEBOOKINSTANCES_SET_NAME?=

# Derived parameters
SMR_NOTEBOOKINSTANCE_LIFECYCLECONFIG_NAME?= $(EC2_LIFECYCLECONFIG_NAME)
SMR_NOTEBOOKINSTANCE_ROLE_ARN?= $(IAM_ROLE_ARN)
SMR_NOTEBOOKINSTANCE_SECURITYGROUP_ID?= $(EC2_SECURITYGROUP_ID)

# Option parameters
__SMR_ACCELERATOR_TYPES=
__SMR_ADDITIONAL_CODE_REPOSITORIES=
__SMR_CREATION_TIME_AFTER__NOTEBOOKINSTANCES=
__SMR_CREATION_TIME_BEFORE__NOTEBOOKINSTANCES=
__SMR_DEFAULT_CODE_REPOSITORY=
__SMR_DIRECT_INTERNET_ACCESS=
__SMR_INSTANCE_TYPE= $(if $(SMR_NOTEBOOKINSTANCE_TYPE),--instance-type $(SMR_NOTEBOOKINSTANCE_TYPE))
__SMR_KMS_KEY_ID= $(if $(SMR_NOTEBOOKINSTANCE_KMSKEY_ID),--kms-key-id $(SMR_NOTEBOOKINSTANCE_KMSKEY_ID))
__SMR_LAST_MODIFIED_TIME_AFTER__NOTEBOOKINSTANCES=
__SMR_LAST_MODIFIED_TIME_BEFORE__NOTEBOOKINSTANCES=
__SMR_LIFECYCLE_CONFIG_NAME= $(if $(SMR_NOTEBOOKINSTANCE_LIFECYCLECONFIG_NAME),--lifecycle-config-name $(SMR_NOTEBOOKINSTANCE_LIFECYCLECONFIG_NAME))
__SMR_NAME_CONTAINS__NOTEBOOKINSTANCES=
__SMR_NOTEBOOK_INSTANCE_LIFECYCLE_CONFIG_NAME_CONTAINS=
__SMR_NOTEBOOK_INSTANCE_NAME= $(if $(SMR_NOTEBOOKINSTANCE_NAME),--notebook-instance-name $(SMR_NOTEBOOKINSTANCE_NAME))
__SMR_ROLE_ARN= $(if $(SMR_NOTEBOOKINSTANCE_ROLE_ARN),--role-arn $(SMR_NOTEBOOKINSTANCE_ROLE_ARN))
__SMR_ROOT_ACCESS= $(if $(filter false, $(SMR_NOTEBOOKINSTANCE_ROOTACCESS_FLAG)),--root-access Disabled,--root-access Enabled)
__SMR_SORT_BY__NOTEBOOKINSTANCES=
__SMR_SORT_ORDER__NOTEBOOKINSTANCES=
__SMR_SECURITY_GROUP_ID= $(if $(SMR_NOTEBOOKINSTANCE_SECURITYGROUP_ID),--security-group-id $(SMR_NOTEBOOKINSTANCE_SECURITYGROUP_ID))
__SMR_STATUS_EQUALS=
__SMR_SUBNET_ID= $(if $(SMR_NOTEBOOKINSTANCE_SUBNET_ID),--subnet-id $(SMR_SUBNET_ID))
__SMR_TAGS__NOTEBOOKINSTANCE= $(if $(SMR_NOTEBOOKINSTANCE_TAGS_KEYVALUES),--tags $(SMR_NOTEBOOKINSTANCE_TAGS_KEYVALUES))
__SMR_VOLUME_SIZE_IN_GB= $(if $(SMR_NOTEBOOKINSTANCE_VOLUME_SIZE),--volume-size-in-gb $(SMR_NOTEBOOKINSTANCE_VOLUME_SIZE))

# UI parameters

#--- MACROS
_smr_get_notebookinstance_role_arn= $(call _smr_get_notebookinstance_role_arn_N, $(SMR_NOTEBOOKINSTANCE_NAME))
_smr_get_notebookinstance_role_arn_N= $(call _smr_describe_notebookinstance_parameter_NP, $(1), RoleArn)

_smr_get_notebookinstance_status= $(call _smr_get_notebookinstance_status_N, $(SMR_NOTEBOOKINSTANCE_NAME))
_smr_get_notebookinstance_status_N= $(call _smr_describe_notebookinstance_parameter_NP, $(1),  NotebookInstanceStatus)

_smr_get_notebookinstance_parameter_NP= $(shell $(AWS) sagemaker describe-notebook-instance --notebook-instance-name $(1) --query $(2) --output text)

#----------------------------------------------------------------------
# USAGE
#

_smr_view_framework_macros ::
	@echo 'AWS::SageMakeR::NotebookInstance ($(_AWS_SAGEMAKER_NOTEBOOKINSTANCE_MK_VERSION)) macros:'
	@echo '    _smr_get_notebookinstance_parameter_NP   - Get a parameter from a notebook-instance (Name, Param)'
	@echo '    _smr_get_notebookinstance_role_{|N}      - Get the role of the notebook-instance'
	@echo '    _smr_get_notebookinstance_status_{|N}    - Get the status of the notebook-instance'
	@echo

_smr_view_framework_parameters ::
	@echo 'AWS::SageMakeR::NotebookInstance ($(_AWS_SAGEMAKER_NOTEBOOKINSTANCE_MK_VERSION)) parameters:'
	@echo '    SMR_NOTEBOOKINSTANCE_KMSKEY_ID=$(SMR_NOTEBOOKINSTANCE_KMSKEY_ID)'
	@echo '    SMR_NOTEBOOKINSTANCE_LIFECYCLECONFIG_NAME=$(SMR_NOTEBOOKINSTANCE_LIFECYCLECONFIG_NAME)'
	@echo '    SMR_NOTEBOOKINSTANCE_NAME=$(SMR_NOTEBOOKINSTANCE_NAME)'
	@echo '    SMR_NOTEBOOKINSTANCE_ROLE_ARN=$(SMR_NOTEBOOKINSTANCE_ROLE_ARN)'
	@echo '    SMR_NOTEBOOKINSTANCE_ROOTACCESS_FLAG=$(SMR_NOTEBOOKINSTANCE_ROOTACCESS_FLAG)'
	@echo '    SMR_NOTEBOOKINSTANCE_SECURITYGROUP_ID=$(SMR_NOTEBOOKINSTANCE_SECURITYGROUP_ID)'
	@echo '    SMR_NOTEBOOKINSTANCE_SUBNET_ID=$(SMR_NOTEBOOKINSTANCE_SUBNET_ID)'
	@echo '    SMR_NOTEBOOKINSTANCE_TAGS_KEYVALUES=$(SMR_NOTEBOOKINSTANCE_TAGS_KEYVALUES)'
	@echo '    SMR_NOTEBOOKINSTANCE_TYPE=$(SMR_NOTEBOOKINSTANCE_TYPE)'
	@echo '    SMR_NOTEBOOKINSTANCE_VOLUME_SIZE=$(SMR_NOTEBOOKINSTANCE_VOLUME_SIZE)'
	@echo '    SMR_NOTEBOOKINSTANCES_SET_NAME=$(SMR_NOTEBOOKINSTANCES_SET_NAME)'
	@echo

_smr_view_framework_targets ::
	@echo 'AWS::SageMakeR::NotebookInstance ($(_AWS_SAGEMAKER_NOTEBOOKINSTANCE_MK_VERSION)) targets:'
	@echo '    _smr_create_notebookinstance             - Create a notebook-instance'
	@echo '    _smr_delete_notebookinstance             - Create a notebook-instance'
	@echo '    _smr_show_notebookinstance               - Show everything related to a notebook-instance'
	@echo '    _smr_show_notebookinstance_description   - Show description of a notebook-instance'
	@echo '    _smr_start_notebookinstance              - Start a notebook-instance'
	@echo '    _smr_stop_notebookinstance               - Stop a running notebook-instance'
	@echo '    _smr_view_notebookinstances              - View notebook-instances'
	@echo '    _smr_view_notebookinstances_set          - View a set of notebook-instances'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_smr_create_notebookinstance:
	@$(INFO) '$(SMR_UI_LABEL)Creating notebook-instance "$(SMR_NOTEBOOKINSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) sagemaker create-notebook-instance $(strip $(__SMR_ACCELERATOR_TYPES) $(__SMR_ADDITIONAL_CODE_REPOSITORIES) $(__SMR_DEFAULT_CODE_REPOSITORY) $(__SMR_DIRECT_INTERNET_ACCESS) $(__SMR_INSTANCE_TYPE) $(__SMR_KMS_KEY_ID) $(__SMR_LIFECYCLE_CONFIG_NAME) $(__SMR_NOTEBOOK_INSTANCE_NAME) $(__SMR_ROLE_ARN) $(__SMR_ROOT_ACCESS) $(__SMR_SECURITY_GROUP_ID) $(__SMR_SUBNET_ID) $(__SMR_TAGS__NOTEBOOKINSTANCE) $(__SMR_VOLUME_SIZE_IN_GB) )

_smr_delete_notebookinstance:
	@$(INFO) '$(SMR_UI_LABEL)Deleting notebook-instance "$(SMR_NOTEBOOKINSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the notebook-instance is not stopped!'; $(NORMAL)
	$(AWS) sagemaker delete-notebook-instance $(__SMR_NOTEBOOK_INSTANCE_NAME)

_smr_show_notebookinstance :: _smr_show_notebookinstance_description

_smr_show_notebookinstance_description:
	@$(INFO) '$(SMR_UI_LABEL)Showing description of  notebook-instance "$(SMR_NOTEBOOKINSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) sagemaker describe-notebook-instance $(__SMR_NOTEBOOK_INSTANCE_NAME)

_smr_start_notebookinstance:
	@$(INFO) '$(SMR_UI_LABEL)Starting notebook-instance "$(SMR_NOTEBOOKINSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation re-attaches a ML storage to the instance'; $(NORMAL)
	$(AWS) sagemaker start-notebook-instance $(__SMR_NOTEBOOK_INSTANCE_NAME)

_smr_stop_notebookinstance:
	@$(INFO) '$(SMR_UI_LABEL)Stopping notebook-instance "$(SMR_NOTEBOOKINSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation detaches and preserves the ML storage'; $(NORMAL)
	$(AWS) sagemaker stop-notebook-instance $(__SMR_NOTEBOOK_INSTANCE_NAME)

_smr_view_notebookinstances:
	@$(INFO) '$(SMR_UI_LABEL)Viewing notebook-instances ...'; $(NORMAL)
	$(AWS) sagemaker list-notebook-instances $(__SMR_CREATION_TIME_AFTER__NOTEBOOKINSTANCES) $(__SMR_CREATION_TIME_BEFORE__NOTEBOOKINSTANCES) $(__SMR_LAST_MODIFIED_TIME_AFTER__NOTEBOOKINSTANCES) $(__SMR_LAST_MODIFIED_TIME_BEFORE__NOTEBOOKINSTANCES) $(__SMR_NAME_CONTAINS__NOTEBOOKINSTANCES) $(__SMR_NOTEBOOK_INSTANCE_LIFECYCLE_CONFIG_NAME_CONTAINS) $(__SMR_SORT_BY__NOTEBOOKINSTANCES) $(__SMR_SORT_ORDER__NOTEBOOKINSTANCES) $(__SMR_STATUS_EQUALS) --query "NotebookInstances[]"

_smr_view_notebookinstances_set:
	@$(INFO) '$(SMR_UI_LABEL)Viewing notebook-instances-set "$(SMR_NOTEBOOKINSTANCES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Notebook-instances are grouped based on ..'; $(NORMAL)
	# $(AWS) sagemaker list-notebook-instances ...
