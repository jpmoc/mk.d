_AWS_EMR_MK_VERSION=0.99.6

# EMR_CLUSTER_AMI_VERSION?= 3.1.0
# EMR_CLUSTER_APPLICATIONS?= Name=Hue Name=Hive Name=Pig NAme=Spark
EMR_CLUSTER_AUTO_TERMINATE?= false
# EMR_CLUSTER_AUTO_SCALING_ROLE?= EMR_AutoScaling_DefaultRole
# EMR_CLUSTER_BOOTSTRAP_ACTIONS+= Path=s3://my_bucket/scripts/bootstrap/bootstrap-actions.sh
# EMR_CLUSTER_CONFIGURATIONS_FILEPATH?= ./configurations.json
# EMR_CLUSTER_CREATEDD_AFTER?= 2017-07-04T00:01:30
# EMR_CLUSTER_CREATEDD_BEFORE?= 2017-07-04T00:01:30
# EMR_CLUSTER_EC2_ATTRIBUTES?= InstanceProfile=EMR_EC2_DefaultRole
# EMR_CLUSTER_EMRFS?= Consistent=True
# EMR_CLUSTER_ENABLE_DEBUGGING?= false
# EMR_CLUSTER_INSTANCE_FLEETS+= InstanceFleetType=MASTER,TargetOnDemandCapacity=1,InstanceTypeConfigs=['{InstanceType=m3.xlarge}']
# EMR_CLUSTER_INSTANCE_FLEETS+= InstanceFleetType=CORE,TargetSpotCapacity=11,InstanceTypeConfigs=['{InstanceType=m3.xlarge,BidPrice=0.5,WeightedCapacity=3}','{InstanceType=m4.2xlarge,BidPrice=0.9,WeightedCapacity=5}'],LaunchSpecifications={SpotSpecification='{TimeoutDurationMinutes=120,TimeoutAction=SWITCH_TO_ON_DEMAND}'}
# EMR_CLUSTER_INSTANCE_GROUPS+= InstanceGroupType=MASTER,InstanceCount=1,InstanceType=m3.xlarge
# EMR_CLUSTER_INSTANCE_GROUPS+= InstanceGroupType=CORE,InstanceCount=2,InstanceType=m3.xlarge
# EMR_CLUSTER_LOG_URI?= s3://my_bucket/hadoop-logs
# EMR_CLUSTER_NAME?= Development Cluster
# EMR_CLUSTER_RELEASE_LABEL?= emr-5.7.0
# EMR_CLUSTER_SERVICE_ROLE?= EMR_EC2_DefaultRole
# EMR_CLUSTER_STATES?= RUNNING
# EMR_CLUSTER_STATES_ACTIVE?= true
# EMR_CLUSTER_STATES_FAILED?= false
# EMR_CLUSTER_STATES_TERMINATED?= false
# EMR_CLUSTER_USE_DEFAULT_ROLES?= false
# EMR_INSTANCE_FLEET_ID?=
# EMR_INSTANCE_FLEET_TYPE?= CORE
# EMR_INSTANCE_GROUP_ID?= ig-3S4Z0GYR778XR
# EMR_INSTANCE_GROUP_TYPE?= CORE
# EMR_INSTANCE_STATES?= RUNNING BOOTSTRAPING
# EMR_STEP_ID?= s-1ILGHEB5COEXU
# EMR_STEPS_FILEPATH?= ./steps.json

# Derived variables
EMR_CLUSTER_CONFIGURATIONS?= $(if $(EMR_CLUSTER_CONFIGURATIONS_FILEPATH), file://$(EMR_CLUSTER_CONFIGURATIONS_FILEPATH))
EMR_CLUSTER_IDS?= $(EMR_CLUSTER_ID)
EMR_STEPS?= $(if $(EMR_STEPS_FILEPATH), file://$(EMR_STEPS_FILEPATH))
# EMR_STEPS?= Type=HIVE,Name='SOME_HIVE_ACTIONS',ActionOnFailure=CANCEL_AND_WAIT,Args=[-f,s3://[bucket]/scripts/hive/hive_script.sql]

# Optoins
__EMR_ACTIVE?= $(if $(filter true, $(EMR_CLUSTER_STATES_ACTIVE)), --active)
__EMR_ADDITIONAL_INFO?=
__EMR_AMI_VERSION?= $(if $(EMR_CLUSTER_AMI_VERSION), --ami-verison $(EMR_CLUSTER_AMI_VERSION))
__EMR_APPLICATIONS?= $(if $(EMR_CLUSTER_APPLICATIONS), --application $(EMR_CLUSTER_APPLICATIONS))
__EMR_AUTO_SCALING_ROLE?= $(if $(EMR_CLUSTER_AUTO_SCALING_ROLE), --auto-scaling-role $(EMR_CLUSTER_AUTO_SCALING_ROLE))
__EMR_AUTO_TERMINATE?= $(if $(filter true, $(EMR_CLUSTER_AUTO_TERMINATE)), --auto-terminate, --no-auto-terminate)
__EMR_BOOTSTRAP_ACTIONS?= $(if $(EMR_CLUSTER_BOOTSTRAP_ACTIONS), --bootstrap-actions $(EMR_CLUSTER_BOOTSTRAP_ACTIONS))
__EMR_CLUSTER_ID?= $(if $(EMR_CLUSTER_ID), --cluster-id $(EMR_CLUSTER_ID))
__EMR_CLUSTER_IDS?= $(if $(EMR_CLUSTER_IDS), --cluster-ids $(EMR_CLUSTER_IDS))
__EMR_CONFIGURATIONS?= $(if $(EMR_CLUSTER_CONFIGURATIONS), --configurations $(EMR_CLUSTER_CONFIGURATION))
__EMR_CREATED_AFTER?= $(if $(EMR_CLUSTER_CREATED_AFTER), --created-after $(EMR_CLUSTER_CREATED_AFTER))
__EMR_CREATED_BEFORE?= $(if $(EMR_CLUSTER_CREATED_BEFORE), --created-before $(EMR_CLUSTER_CREATED_BEFORE))
__EMR_CUSTOM_AMI_ID?=
__EMR_EBS_ROOT_VOLUME_SIZE?=
__EMR_EC2_ATTRIBUTES?= $(if $(EMR_CLUSTER_EC2_ATTRIBUTES), --ec2-attributes $(EMR_CLUSTER_EC2_ATTRIBUTES))
__EMR_EMRFS?= $(if $(EMR_CLUSTER_EMRFS), --emrfs $(EMR_CLUSTER_EMRFS))
__EMR_ENABLE_DEBUGGING?= $(if $(filter true, $(EMR_CLUSTER_ENABLE_DEBUGGING)), --enable-debugging, --no-enable-debugging)
__EMR_FAILED?= $(if $(filter true, $(EMR_CLUSTER_STATES_FAILED)), --failed)
__EMR_INSTANCE_COUNT?=
__EMR_INSTANCE_FLEET_ID?= $(if $(EMR_INSTANCE_FLEET_ID), --instance-fleet-id $(EMR_INSTANCE_FLEET_ID))
__EMR_INSTANCE_FLEET_TYPES?= $(if $(EMR_INSTANCE_FLEET_TYPES), --instance-fleet-types $(EMR_INSTANCE_FLEET_TYPES))
__EMR_INSTANCE_FLEETS?= $(if $(EMR_CLUSTER_INSTANCE_FLEETS), --instance-fleets $(EMR_CLUSTER_INSTANCE_FLEETS))
__EMR_INSTANCE_GROUP_ID?= $(if $(EMR_INSTANCE_GROUP_ID), --instance-group-id $(EMR_INSTANCE_GROUP_ID))
__EMR_INSTANCE_GROUP_TYPES?= $(if $(EMR_INSTANCE_GROUP_TYPES), --instance-group-types $(EMR_INSTANCE_GROUP_TYPES))
__EMR_INSTANCE_GROUPS?= $(if $(EMR_CLUSTER_INSTANCE_GROUPS), --instance-groups $(EMR_CLUSTER_INSTANCE_GROUPS))
__EMR_INSTANCE_STATES?= $(if $(EMR_INSTANCE_STATES), --instance-states $(EMR_INSTANCE_STATES))
__EMR_INSTANCE_TYPE?=
__EMR_KERBEROS_ATTRIBUTES?=
__EMR_LOG_URI?= $(if $(EMR_CLUSTER_LOG_URI), --log-uri $(EMR_CLUSTER_LOG_URI))
__EMR_NAME?= $(if $(EMR_CLUSTER_NAME), --name "$(EMR_CLUSTER_NAME)")
__EMR_RELEASE_LABEL?= $(if $(EMR_CLUSTER_RELEASE_LABEL), --release-label $(EMR_CLUSTER_RELEASE_LABEL))
__EMR_REPO_UPGRADE_ON_BOOT?=
__EMR_RESTORE_FROM_HBASE_BACKUP?=
__EMR_SECURITY_CONFIGURATION?=
__EMR_SERVICE_ROLE?= $(if $(EMR_CLUSTER_SERVICE_ROLE), --service-role $(EMR_CLUSTER_SERVICE_ROLE))
__EMR_STEP_ID?= $(if $(EMR_STEP_ID), --step-id $(EMR_STEP_ID))
__EMR_STEPS?= $(if $(EMR_STEPS), --steps $(EMR_STEPS))
__EMR_TAGS?=
__EMR_TERMINATED?= $(if $(filter true, $(EMR_CLUSTER_STATES_TERMINATED)), --terminated)
__EMR_TERMINATION_PROTECTED?= $(if $(filter true, $(EMR_CLUSTER_TERMINATION_PROTECTED)), --termination-protected, --no-termination-protected)
__EMR_USE_DEFAULT_ROLES?= $(if $(filter true, $(EMR_CLUSTER_USE_DEFAULT_ROLES)), --use-default-roles)
__EMR_VISIBLE_TO_ALL_USERS?= $(if $(filter true, $(EMR_CLUSTER_VISIBLE_TO_ALL_USERS)), --visible-to-all-users, --no-vsible-to-all-users)

# Text UI
EMR_SHOW_CLUSTER_FIELDS?=
EMR_VIEW_CLUSTERS_FIELDS?= .{Id:Id,Name:Name,State:Status.State,CreationDateTime:Status.Timeline.CreationDateTime}
EMR_VIEW_INSTANCES_FIELDS?= .{Ec2InstanceId:Ec2InstanceId,InstanceType:InstanceType,PublicIpAddress:PublicIpAddress,InstanceGroupId:InstanceGroupId,Id:Id,PrivateIpAddress:PrivateIpAddress,State:Status.State}
EMR_VIEW_STEPS_FIELDS?= .{Id:Id,CreationDateTime:Status.Timeline.CreationDateTime,Name:Name,_ActionOnfailure:ActionOnFailure,_EndDataTime:Status.Timeline.EndDateTime,_BeginningDateTime:Status.Timeline.StartDateTime,_State:Status.State}

#--- MACROS
_emr_get_cluster_id=$(call _emr_get_cluster_id_N, $(EMR_CLUSTER_NAME))
_emr_get_cluster_id_N=$(shell $(AWS) emr list-clusters --query "Clusters[?Name=='$(strip $(1))'] | [0].Id" --output text)
_emr_get_cluster_name=$(call _emr_get_cluster_name_I, $(EMR_CLUSTER_ID))
_emr_get_cluster_name_I=$(shell $(AWS) emr describe-cluster --cluster-id $(1) --query "Cluster.Name" --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _emr_view_makefile_macros
_emr_view_makefile_macros:
	@echo "AWS::EMR ($(_AWS_EMR_MK_VERSION)) macros:"
	@echo "    _emr_get_cluster_id_{|N}                   - Get the cluster ID"
	@echo "    _emr_get_cluster_name_{|N}                 - Get the cluster name"
	@echo

_aws_view_makefile_targets :: _emr_view_makefile_targets
_emr_view_makefile_targets:
	@echo "AWS::EMR ($(_AWS_EMR_MK_VERSION)) targets:"
	@echo "    _emr_configure_awscli                  - Configure the AWS cli"
	@echo "    _emr_create_cluster                    - Create a new cluster"
	@echo "    _emr_create_cluster                    - Create a new cluster"
	@echo "    _emr_create_default_roles              - Create default roles"
	@echo "    _emr_show_cluster                      - Show details of an existing cluster"
	@echo "    _emr_show_step                         - Show details of an existing step"
	@echo "    _emr_terminate_clusters                - Terminate one or more clusters"
	@echo "    _emr_view_clusters                     - View existing clusters"
	@echo "    _emr_view_steps                        - View steps to be executed on cluster"
	@echo 

_aws_view_makefile_variables :: _emr_view_makefile_variables
_emr_view_makefile_variables:
	@echo "AWS::EMR ($(_AWS_EMR_MK_VERSION)) variables:"
	@echo "    EMR_CLUSTER_AMI_VERSION=$(EMR_CLUSTER_AMI_VERSION)"
	@echo "    EMR_CLUSTER_APPLICATIONS=$(EMR_CLUSTER_APPLICATIONS)"
	@echo "    EMR_CLUSTER_AUTO_SCALING_ROLE=$(EMR_CLUSTER_SCALING_ROLE)"
	@echo "    EMR_CLUSTER_AUTO_TERMINATE=$(EMR_CLUSTER_AUTO_TERMINATE)"
	@echo "    EMR_CLUSTER_BOOTSTRAP_ACTIONS=$(EMR_CLUSTER_BOOTSTRAP_ACTIONS)"
	@echo "    EMR_CLUSTER_CONFIGURATIONS=$(EMR_CLUSTER_CONFIGURATIONS)"
	@echo "    EMR_CLUSTER_CONFIGURATIONS_FILEPATH=$(EMR_CLUSTER_CONFIGURATIONS_FILEPATH)"
	@echo "    EMR_CLUSTER_CREATED_AFTER=$(EMR_CLUSTER_CREATED_AFTER)"
	@echo "    EMR_CLUSTER_CREATED_BEFORE=$(EMR_CLUSTER_CREATED_BEFORE)"
	@echo "    EMR_CLUSTER_EC2_ATTRIBUTES=$(EMR_CLUSTER_EC2_ATTRIBUTES)"
	@echo "    EMR_CLUSTER_EMRFS=$(EMR_CLUSTER_EMRFS)"
	@echo "    EMR_CLUSTER_ENABLE_DEBUGGING=$(EMR_CLUSTER_ENABLE_DEBUGGING)"
	@echo "    EMR_CLUSTER_ID=$(EMR_CLUSTER_ID)"
	@echo "    EMR_CLUSTER_IDS=$(EMR_CLUSTER_IDS)"
	@echo "    EMR_CLUSTER_INSTANCE_FLEETS=$(EMR_CLUSTER_INSTANCE_FLEETS)"
	@echo "    EMR_CLUSTER_INSTANCE_GROUPS=$(EMR_CLUSTER_INSTANCE_GROUPS)"
	@echo "    EMR_CLUSTER_LOG_URI=$(EMR_CLUSTER_LOG_URI)"
	@echo "    EMR_CLUSTER_NAME=$(EMR_CLUSTER_NAME)"
	@echo "    EMR_CLUSTER_RELEASE_LABEL=$(EMR_CLUSTER_RELEASE_LABEL)"
	@echo "    EMR_CLUSTER_SERVICE_ROLES=$(EMR_CLUSTER_SERVICE_ROLES)"
	@echo "    EMR_CLUSTER_STATES=$(EMR_CLUSTER_STATES)"
	@echo "    EMR_CLUSTER_STATES_ACTIVE=$(EMR_CLUSTER_STATES_ACTIVE)"
	@echo "    EMR_CLUSTER_STATES_FAILED=$(EMR_CLUSTER_STATES_FAILED)"
	@echo "    EMR_CLUSTER_STATES_TERMINATED=$(EMR_CLUSTER_STATES_TERMINATED)"
	@echo "    EMR_CLUSTER_TERMINATION_PROTECTED=$(EMR_CLUSTER_TERMINATION_PROTECTED)"
	@echo "    EMR_CLUSTER_USE_DEFAULT_ROLES=$(EMR_CLUSTER_USE_DEFAULT_ROLES)"
	@echo "    EMR_CLUSTER_USE_DEFAULT_ROLES=$(EMR_CLUSTER_USE_DEFAULT_ROLES)"
	@echo "    EMR_INSTANCE_FLEET_ID=$(EMR_INSTANCE_FLEET_ID)"
	@echo "    EMR_INSTANCE_FLEET_TYPE=$(EMR_INSTANCE_FLEET_TYPE)"
	@echo "    EMR_INSTANCE_GROUP_ID=$(EMR_INSTANCE_GROUP_ID)"
	@echo "    EMR_INSTANCE_GROUP_TYPE=$(EMR_INSTANCE_GROUP_TYPE)"
	@echo "    EMR_INSTANCE_STATES=$(EMR_INSTANCE_STATES)"
	@echo "    EMR_STEPS_FILEPATH=$(EMR_STEPS_FILEPATH)"
	@echo "    EMR_STEPS=$(EMR_STEPS)"
	@echo "    EMR_PRIVATE_KEY_FILEPATH=$(EMR_PRIVATE_KEY_FILEPATH)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_emr_add_steps:
	@$(INFO) "$(AWS_LABEL)Adding steps to cluster '$(EMR_CLUSTER_ID)' ..."; $(NORMAL)
	$(AWS)  emr add-steps $(__EMR_CLUSTER_ID) $(__EMR_STEPS)

_emr_configure_awscli:
	@$(INFO) "$(AWS_LABEL)Configure the AWS CLI ..."; $(NORMAL)
	$(AWS)  configure set emr.key_pair_file $(EMR_PRIVATE_KEY_FILEPATH)

_emr_create_cluster:
	@$(INFO) "$(AWS_LABEL)Creating EMR clusters '$(EMR_CLUSTER_NAME)' ..."; $(NORMAL)
	$(AWS) emr create-cluster $(__EMR_ADDITONAL_INFO) $(__EMR_AMI_VERSION) $(__EMR_APPLICATIONS) $(__EMR_AUTO_TERMINATE) $(__EMR_BOOTSTRAP_ACTIONS) $(__EMR_CONFIGURATIONS) $(__EMR_CUSTOM_AMI_ID) $(__EMR_EBS_ROOT_VOLUME_SIZE) $(__EMR_EC2_ATTRIBUTES) $(__EMR_EMRF) $(__EMR_ENABLE_DEBUGGING) $(__EMR_INSTANCE_COUNT) $(__EMR_INSTANCE_FLEETS) $(__EMR_INSTANCE_GROUPS) $(__EMR_INSTANCE_TYPES) $(__EMR_KERBEROS_ATTRIBUTES) $(__EMR_LOG_URI) $(__EMR_NAME) $(__EMR_RELEASE_LABEL) $(__EMR_REPO_UPGRADE_ON_BOOT) $(__EMR_RESTORE_FROM_HBASE_BACKUP) $(__EMR_SECURITY_CONFIGURATION) $(__EMR_SERVICE_ROLE) $(__EMR_STEPS) $(__EMR_TAGS) $(__EMR_TERMINATION_PROTECTED) $(__EMR_USE_DEFAULT_ROLES) $(__EMR_VISIBLE_TO_ALL_USER)

_emr_create_default_roles:
	@$(INFO) "$(AWS_LABEL)Creating default roles if not already done ..."; $(NORMAL)
	@$(WARN) "Default roles: EMR_EC2_DefaultRole, EMR_DefaultRole, EMR_AutoScaling_DefaultRole"; $(NORMAL)
	$(AWS) emr create-default-roles

_emr_show_cluster:
	@$(INFO) "$(AWS_LABEL)Show EMR cluster '$(EMR_CLUSTER_ID)' ..."; $(NORMAL)
	@$(WARN) "EMR_CLUSTER_NAME: $(call _emr_get_cluster_name_I, $(EMR_CLUSTER_ID))"; $(NORMAL)
	$(AWS) emr describe-cluster $(__EMR_CLUSTER_ID)

_emr_show_step:
	@$(INFO) "$(AWS_LABEL)Show step '$(EMR_STEP_ID)' of EMR cluster '$(EMR_CLUSTER_ID)' ..."; $(NORMAL)
	$(AWS) emr describe-step $(__EMR_CLUSTER_ID) $(__EMR_STEP_ID)

_emr_terminate_clusters:
	@$(INFO) "$(AWS_LABEL)Terminate one or more EMR clusters ..."; $(NORMAL)
	$(AWS) emr terminate-clusters $(__EMR_CLUSTER_IDS)

_emr_view_clusters:
	@$(INFO) "$(AWS_LABEL)View EMR clusters ..."; $(NORMAL)
	$(AWS) emr list-clusters $(__EMR_ACTIVE) $(__EMR_CLUSTER_STATES) $(__EMR_CREATED_AFTER) $(__EMR_CREATED_BEFORE) $(__EMR_FAILED) $(__EMR_TERMINATED) --query "Clusters[]$(EMR_VIEW_CLUSTERS_FIELDS)"

_emr_view_instances:
	@$(INFO) "$(AWS_LABEL)View steps for EMR cluster '$(EMR_CLUSTER_NAME)' ..."; $(NORMAL)
	$(AWS) emr list-instances $(__EMR_CLUSTER_ID) $(__EMR_INSTANCE_FLEET_ID) $(__EMR_INSTANCE_FLEET_TYPE) $(__EMR_INSTANCE_GROUP_ID) $(__EMR_INSTANCE_GROUP_TYPES) $(__EMR_INSTANCE_STATES) --query "Instances[]$(EMR_VIEW_INSTANCES_FIELDS)"

_emr_view_steps:
	@$(INFO) "$(AWS_LABEL)View steps for EMR cluster '$(EMR_CLUSTER_NAME)' ..."; $(NORMAL)
	$(AWS) emr list-steps $(__EMR_CLUSTER_ID) --query "Steps[]$(EMR_VIEW_STEPS_FIELDS)"
