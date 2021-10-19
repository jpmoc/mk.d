_EKSCTL_IAMIDENTITYMAPPING_MK_VERSION= $(_EKSCTL_MK_VERSION)

# ECL_IAMIDENTITYMAPPING_AWS_PROFILE?=
# ECL_IAMIDENTITYMAPPING_AWS_REGION?= us-west-2
# ECL_IAMIDENTITYMAPPING_CLUSTER_NAME?= my-cluster
# ECL_IAMIDENTITYMAPPING_GROUP_NAME?=
# ECL_IAMIDENTITYMAPPING_ROLE_ARN?=
ECL_IAMIDENTITYMAPPING_TIMEOUT?= 20m0s
# ECL_IAMIDENTITYMAPPING_USER_NAME?=
# ECL_IAMIDENTITYMAPPINGS_NAMES?= my-iamidentitymapping ...
# ECL_IAMIDENTITYMAPPINGS_SET_NAME?= my-iamidentitymappings-set

# Derived parameters
ECL_IAMIDENTITYMAPPING_AWS_PROFILE?= $(ECL_AWS_PROFILE)
ECL_IAMIDENTITYMAPPING_AWS_REGION?= $(ECL_AWS_REGION)
ECL_IAMIDENTITYMAPPING_CLUSTER_NAME?= $(ECL_CLUSTER_NAME)

# Option parameters
__ECL_CFN_ROLE_ARN__IAMIDENTITYMAPPING=
__ECL_CLUSTER__IAMIDENTITYMAPPING= $(if $(ECL_IAMIDENTITYMAPPING_CLUSTER_NAME),--cluster $(ECL_IAMIDENTITYMAPPING_CLUSTER_NAME))
__ECL_GROUP= $(if $(ECL_IAMIDENTITYMAPPING_GROUP_NAME),--group $(ECL_IAMIDENTITYMAPPING_GROUP_NAME))
__ECL_NAME__IAMIDENTITYMAPPING= $(if $(ECL_IAMIDENTITYMAPPING_CLUSTER_NAME),--name $(ECL_IAMIDENTITYMAPPING_CLUSTER_NAME))
__ECL_PROFILE__IAMIDENTITYMAPPING= $(if $(ECL_IAMIDENTITYMAPPING_AWS_PROFILE),--profile $(ECL_IAMIDENTITYMAPPING_AWS_PROFILE))
__ECL_REGION__IAMIDENTITYMAPPING= $(if $(ECL_IAMIDENTITYMAPPING_AWS_REGION),--region=$(ECL_IAMIDENTITYMAPPING_AWS_REGION))
__ECL_ROLE__IAMIDENTITYMAPPING= $(if $(ECL_IAMIDENTITYMAPPING_ROLE_ARN),--role $(ECL_IAMIDENTITYMAPPING_ROLE_ARN))
__ECL_USERNAME= $(if $(ECL_IAMIDENTITYMAPPING_USER_NAME),--username $(ECL_IAMIDENTITYMAPPING_USER_NAME))
__ECL_TIMEOUT= $(if $(ECL_IAMIDENTITYMAPPING_TIMEOUT),--timeout $(ECL_IAMIDENTITYMAPPING_TIMEOUT))

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_ecl_view_framework_macros ::
	@echo 'EksCtL::IamIdentityMapping ($(_EKSCTL_IAMIDENTITYMAPPING_MK_VERSION)) macros:'
	@echo

_ecl_view_framework_parameters ::
	@echo 'EksCtL::IamIdentityMapping ($(_EKSCTL_IAMIDENTITYMAPPING_MK_VERSION)) parameters:'
	@echo '    ECL_IAMIDENTITYMAPPING_AWS_PROFILE=$(ECL_IAMIDENTITYMAPPING_AWS_PROFILE)'
	@echo '    ECL_IAMIDENTITYMAPPING_AWS_REGION=$(ECL_IAMIDENTITYMAPPING_AWS_REGION)'
	@echo '    ECL_IAMIDENTITYMAPPING_CLUSTER_NAME=$(ECL_IAMIDENTITYMAPPING_CLUSTER_NAME)'
	@echo '    ECL_IAMIDENTITYMAPPING_GROUP_NAME=$(ECL_IAMIDENTITYMAPPING_GROUP_NAME)'
	@echo '    ECL_IAMIDENTITYMAPPING_NAME=$(ECL_IAMIDENTITYMAPPING_NAME)'
	@echo '    ECL_IAMIDENTITYMAPPING_ROLE_ARN=$(ECL_IAMIDENTITYMAPPING_ROLE_ARN)'
	@echo '    ECL_IAMIDENTITYMAPPING_USER_NAME=$(ECL_IAMIDENTITYMAPPING_USER_NAME)'
	@echo '    ECL_IAMIDENTITYMAPPINGS_NAMES=$(ECL_IAMIDENTITYMAPPINGS_NAMES)'
	@echo '    ECL_IAMIDENTITYMAPPINGS_SET_NAME=$(ECL_IAMIDENTITYMAPPINGS_SET_NAME)'
	@echo

_ecl_view_framework_targets ::
	@echo 'EksCtL::IamIdentityMapping ($(_EKSCTL_IAMIDENTITYMAPPING_MK_VERSION)) targets:'
	@echo '    _ecl_create_iamidentitymapping               - Create a new iam-identity-mapping'
	@echo '    _ecl_delete_iamidentitymapping               - Delete a iam-identity-mapping'
	@echo '    _ecl_show_iamidentitymapping                 - Show everything related to a iam-identity-mapping'
	@echo '    _ecl_show_iamidentitymapping_description     - Show description of a iam-identity-mapping'
	@echo '    _ecl_show_iamidentitymapping_stacks          - Show stacks attached to a iam-identity-mapping'
	@echo '    _ecl_view_iamidentitymappings                - View iam-identity-mappings'
	@echo '    _ecl_view_iamidentitymappingset              - View a set of iam-identity-mappings'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ecl_create_iamidentitymapping:
	@$(INFO) '$(ECL_UI_LABEL)Creating iam-identity-mapping "$(ECL_IAMIDENTITYMAPPING_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no EKS control plan has been deployed'; $(NORMAL)
	$(EKSCTL) create iamidentitymapping $(strip $(__ECL_CFN_ROLE_ARN) $(__ECL_CLUSTER__IAMIDENTITYMAPPING) $(__ECL_GROUP) $(__ECL_NAME__IAMIDENTITYMAPPING) $(__ECL_PROFILE__IAMIDENTITYMAPPING) $(__ECL_REGION__IAMIDENTITYMAPPING) $(__ECL_ROLE__IAMIDENTITYMAPPING) $(__ECL_USERNAME))

_ecl_delete_iamidentitymapping:
	@$(INFO) '$(ECL_UI_LABEL)Deleting iam-identity-mapping "$(ECL_IAMIDENTITYMAPPING_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The deletion of a iam-identity-mapping is asynchronous!'; $(NORMAL)
	$(EKSCTL) delete iamidentitymapping $(__ECL_CLUSTER__IAMIDENTITYMAPPING) $(__ECL_DRAIN) $(__ECL_NAME__IAMIDENTITYMAPPING) $(__ECL_REGION__IAMIDENTITYMAPPING) $(__ECL_WAIT__IAMIDENTITYMAPPING)

_ecl_show_iamidentitymapping: _ecl_show_iamidentitymapping_cluster _ecl_show_iamidentitymapping_stacks _ecl_show_iamidentitymapping_description

_ecl_show_iamidentitymapping_cluster:
	@$(INFO) '$(ECL_UI_LABEL)Showing cluster of iam-identity-mapping "$(ECL_IAMIDENTITYMAPPING_NAME)" ...'; $(NORMAL)
	$(EKSCTL) get iamidentitymapping $(__ECL_IAMIDENTITYMAPPING) $(__ECL_OUTPUT__IAMIDENTITYMAPPING) $(__ECL_REGION__IAMIDENTITYMAPPING)

_ecl_show_iamidentitymapping_description:
	@$(INFO) '$(ECL_UI_LABEL)Showing description of iam-identity-mapping "$(ECL_IAMIDENTITYMAPPING_NAME)" ...'; $(NORMAL)
	$(EKSCTL) get iamidentitymapping $(__ECL_NAME__IAMIDENTITYMAPPING) $(__ECL_REGION__IAMIDENTITYMAPPING)

_ecl_show_iamidentitymapping_stacks:
	@$(INFO) '$(ECL_UI_LABEL)Showing cloudformation stacks of iam-identity-mapping "$(ECL_IAMIDENTITYMAPPING_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a stack for the control-plane and one for each iamidentitymapping'; $(NORMAL)
	$(EKSCTL) utils describe-stacks $(__ECL_NAME__IAMIDENTITYMAPPING) $(__ECL_REGION__IAMIDENTITYMAPPING)

_ecl_view_iamidentitymappings:
	@$(INFO) '$(ECL_UI_LABEL)Viewing iam-identity-mappings ...'; $(NORMAL)
	@$(WARN) 'This operation returns information extracted from the control-plane stacks'; $(NORMAL)
	@$(WARN) 'At this time, only the mapped roles are returned, but not the mapped users'; $(NORMAL)
	$(EKSCTL) get iamidentitymapping $(__ECL_NAME__IAMIDENTITYMAPPING) $(__ECL_REGION__IAMIDENTITYMAPPING)

_ecl_view_iamidentitymappings_set:
	@$(INFO) '$(ECL_UI_LABEL)Viewing iam-identity-mappings-set "$(ECL_IAMIDENTITYMAPPINGS_SET_NAME)" ...'; $(NORMAL)
	@$(foreach N,$(ECL_IAMIDENTITYMAPPINGS_NAMES), $(EKSCTL) get iamidentitymapping --name $(N) --region $(ECL_IAMIDENTITYMAPPINGS_AWS_REGION); )
