_AWS_ECSCLI_CLUSTER_MK_VERSION= $(_AWS_ECSCLI_MK_VERSION)

# ECI_CLUSTER_CONFIG_NAME?=
ECI_CLUSTER_CAPABILITYIAM_FLAG?= false
# ECI_CLUSTER_IMAGE_ID?=
# ECI_CLUSTER_INSTANCE_COUNT?= 2
# ECI_CLUSTER_INSTANCE_TYPE?= t2.medium
# ECI_CLUSTER_KEYPAIR_NAME?=
# ECI_CLUSTER_LAUNCH_TYPE?= FARGATE
# ECI_CLUSTER_NAME?=
# ECI_CLUSTER_PORT_ID?= 80
# ECI_CLUSTER_REGION_ID?= us-west-1
# ECI_CLUSTER_SECURITYGROUP_IDS?=
# ECI_CLUSTER_SUBNET_IDS?=
# ECI_CLUSTER_TAGS_KEYVALUES?=
# ECI_CLUSTER_VPC_ID?=
# ECI_CLUSTERS_SET_NAME?=

# Derived parameters
ECI_CLUSTER_LAUNCH_TYPE?= $(ECI_LAUNCH_TYPE)
ECI_CLUSTER_REGION_ID?= $(ECI_REGION_ID)
ECI_CLUSTER_STACK_NAME?= $(if $(ECI_CLUSTER_NAME),amazon-ecs-cli-setup-$(ECI_CLUSTER_NAME))

# Options parameters
__ECI_AZS=
__ECI_CAPABILITY_IAM= $(if $(filter true, $(ECI_CLUSTER_CAPABILITYIAM_FLAG)),--capability-iam)
__ECI_CIDR=
__ECI_CLUSTER= $(if $(ECI_CLUSTER_NAME),--cluster $(ECI_CLUSTER_NAME))
__ECI_CLUSTER_CONFIG__CLUSTER= $(if $(ECI_CLUSTER_CONFIG_NAME),--cluster-config $(ECI_CLUSTER_CONFIG_NAME))
__ECI_EMPTY=
__ECI_EXTRA_USER_DATA=
__ECI_FORCE= $(if $(ECI_MODE_YES),--force)
__ECI_IMAGE_ID= $(if $(ECI_CLUSTER_IMAGE_ID),--image-id $(ECS_CLUSTER_IMAGE_ID))
__ECI_INSTANCE_TYPE= $(if $(ECI_CLUSTER_INSTANCE_TYPE),--instance-type $(ECI_CLUSTER_INSTANCE_TYPE))
__ECI_KEYPAIR= $(if $(ECI_CLUSTER_KEYPAIR_NAME),--keypair $(ECI_CLUSTER_KEYPAIR_NAME))
__ECI_LAUNCH_TYPE__CLUSTER= $(if $(ECI_CLUSTER_LAUNCH_TYPE),--launch-type $(ECI_CLUSTER_LAUNCH_TYPE))
__ECI_NO_ASSOCIATE_PUBLIC_IP_ADDRESS=
__ECI_PORT= $(if $(ECI_CLUSTER_PORT_ID),--port $(ECI_CLUSTER_PORT_ID))
__ECI_REGION__CLUSTER= $(if $(ECI_CLUSTER_REGION_ID),--region $(ECI_CLUSTER_REGION_ID))
__ECI_SIZE= $(if $(ECI_CLUSTER_INSTANCE_COUNT),--size $(ECI_CLUSTER_INSTANCE_COUNT))
__ECI_SECURITY_GROUP= $(if $(ECI_CLUSTER_SECURITYGROUP_ID),--security-group $(ECI_CLUSTER_SECURITYGROUP_ID))
__ECI_SUBNETS=
__ECI_TAGS__CLUSTER= $(if $(ECI_CLUSTER_TAGS_KEYVALUES),--tags $(subst $(SPACE),$(COMMA),$(ECI_CLUSTER_TAGS_KEYVALUES)))
__ECI_VPC= $(if $(ECI_CLUSTER_VPC_ID),--vpc $(ECI_CLUSTER_VPC_ID))

# Pipe parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_eci_view_framework_macros ::
	@echo 'AWS::EcsClI::Cluster ($(_AWS_ECSCLI_CLUSTER_MK_VERSION)) macros:'
	@echo

_eci_view_framework_parameters ::
	@echo 'AWS::EcsClI::Cluster ($(_AWS_ECSCLI_CLUSTER_MK_VERSION)) parameters:'
	@echo '    ECI_CLUSTER_CAPABILITYIAM_FLAG=$(ECI_CLUSTER_CAPABILITYIAM_FLAG)'
	@echo '    ECI_CLUSTER_CONFIG_NAME=$(ECI_CLUSTER_CONFIG_NAME)'
	@echo '    ECI_CLUSTER_IMAGE_ID=$(ECI_CLUSTER_IMAGE_ID)'
	@echo '    ECI_CLUSTER_INSTANCE_COUNT=$(ECI_CLUSTER_INSTANCE_COUNT)'
	@echo '    ECI_CLUSTER_INSTANCE_TYPE=$(ECI_CLUSTER_INSTANCE_TYPE)'
	@echo '    ECI_CLUSTER_KEYPAIR_NAME=$(ECI_CLUSTER_KEYPAIR_NAME)'
	@echo '    ECI_CLUSTER_LAUNCH_TYPE=$(ECI_CLUSTER_LAUNCH_TYPE)'
	@echo '    ECI_CLUSTER_NAME=$(ECI_CLUSTER_NAME)'
	@echo '    ECI_CLUSTER_PORT_ID=$(ECI_CLUSTER_PORT_ID)'
	@echo '    ECI_CLUSTER_REGION_ID=$(ECI_CLUSTER_REGION_ID)'
	@echo '    ECI_CLUSTER_SECURITYGROUP_IDS=$(ECI_CLUSTER_SECURITYGROUP_IDS)'
	@echo '    ECI_CLUSTER_STACK_NAME=$(ECI_CLUSTER_STACK_NAME)'
	@echo '    ECI_CLUSTER_SUBNET_IDS=$(ECI_CLUSTER_SUBNET_IDS)'
	@echo '    ECI_CLUSTER_TAGS_KEYVALUES=$(ECI_CLUSTER_TAGS_KEYVALUES)'
	@echo '    ECI_CLUSTER_VPC_ID=$(ECI_CLUSTER_VPC_ID)'
	@echo '    ECI_CLUSTERS_SET_NAME=$(ECI_CLUSTERS_SET_NAME)'
	@echo

_eci_view_framework_targets ::
	@echo 'AWS::EcsClI::Cluster ($(_AWS_ECSCLI_CLUSTER_MK_VERSION)) targets:'
	@echo '    _eci_create_cluster                  - Create a new cluster'
	@echo '    _eci_delete_cluster                  - Delete an existing cluster'
	@echo '    _eci_scale_cluster                   - Scale cluster up/down'
	@echo '    _eci_show_cluster                    - Show everything related to a cluster'
	@echo '    _eci_show_cluster_description        - Show the description of a cluster'
	@echo '    _eci_view_clusters                   - View clusters'
	@echo '    _eci_view_clusters_set               - View a set of clusters'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_eci_create_cluster:
	@$(INFO) '$(ECI_UI_LABEL)Creating cluster "$(ECI_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the key-pair cannot be found on AWS'; $(NORMAL)
	$(ECSCLI) up $(strip $(__ECI_AWS_PROFILE) $(__ECI_AZS) $(__ECI_CAPABILITY_IAM) $(__ECI_CIDR) $(__ECI_CLUSTER) $(__ECI_CLUSTER_CONFIG__CLUSTER) $(__ECI_EMPTY) $(__ECI_EXTRA_USER_DATA) $(__ECI_FORCE) $(__ECI_IMAGE_ID) $(__ECI_INSTANCE_TYPE) $(__ECI_KEYPAIR) $(__ECI_LAUNCH_TYPE__CLUSTER) $(__ECI_NO_ACCOCIATE_PUBLIC_IP_ADDRESS) $(__ECI_PORT) $(__ECI_REGION__CLUSTER) $(__ECI_SECURITY_GROUP) $(__ECI_SIZE) $(__ECI_SUBNETS) $(__ECI_TAGS__CLUSTER) $(__ECI_VERBOSE) $(__ECI_VPC))

_eci_delete_cluster:
	@$(INFO) '$(ECI_UI_LABEL)Deleting cluster "$(ECI_CLUSTER_NAME)" ...'; $(NORMAL)
	$(ECSCLI) down $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER) $(__ECI_CLUSTER_CONFIG__CLUSTER) $(__ECI_FORCE) $(__ECI_REGION__CLUSTER) $(__ECI_VERBOSE)

_eci_scale_cluster:
	@$(INFO) '$(ECI_UI_LABEL)Scaling cluster "$(ECI_CLUSTER_NAME)" ...'; $(NORMAL)
	$(ECSCLI) scale $(__ECI_CAPABILITY_IAM) $(__ECI_CLUSTER) $(__ECI_REGION__CLUSTER) $(__ECI_SIZE)

_eci_show_cluster :: _eci_show_cluster_tasks _eci_show_cluster_description

_eci_show_cluster_description: 
	@$(INFO) '$(ECI_UI_LABEL)Showing description of cluster "$(ECI_CLUSTER_NAME)" ...'; $(NORMAL)

_eci_show_cluster_tasks:
	@$(INFO) '$(ECI_UI_LABEL)Showing tasks in cluster "$(ECI_CLUSTER_NAME)" ...'; $(NORMAL)
	$(ECSCLI) ps $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER)

_eci_view_clusters:
	@$(INFO) '$(ECI_UI_LABEL)Viewing clusters ...'; $(NORMAL)

_eci_view_clusters_set:
	@$(INFO) '$(ECI_UI_LABEL)Viewing clusters-set "$(ECI_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
