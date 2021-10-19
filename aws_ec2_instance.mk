_AWS_EC2_INSTANCE_MK_VERSION= $(_AWS_EC2_MK_VERSION)

# EC2_INSTANCE_ATTRIBUTE_NAME?= userData
EC2_INSTANCE_ATTRIBUTE_NAMES?= userData
# EC2_INSTANCE_ATTRIBUTE_NAMES+= blockDeviceMapping disableApiTermination ebsOptimized
# EC2_INSTANCE_ATTRIBUTE_NAMES+= enaSupport  # Documented, but not supported?
# EC2_INSTANCE_ATTRIBUTE_NAMES+= groupSet instanceInitiatedShutdownBehavior instanceType
# EC2_INSTANCE_ATTRIBUTE_NAMES+= kernel iproductCodes rootDeviceName sriovNetSupport
# EC2_INSTANCE_ATTRIBUTE_NAMES+= sourceDestCheck userData 
# EC2_INSTANCE_ATTRIBUTE_VALUE?= file://./user_data/cloud_init.ud.base64
EC2_INSTANCE_EBS_OPTIMIZED?= false
# EC2_INSTANCE_ID?= i-0d6d2d862b5ff7a74
# EC2_INSTANCE_IDS?= i-0d6d2d862b5ff7a74 ...
# EC2_INSTANCE_IMAGE_ID?= ami-12345678
# EC2_INSTANCE_INSTANCEPROFILE_ARN?= arn:aws:iam::123456789012:instance-profile/ecs-instance-role
# EC2_INSTANCE_INSTANCEPROFILE_ARN_OR_NAME?=
# EC2_INSTANCE_INSTANCEPROFILE_NAME?=
# EC2_INSTANCE_KEYPAIR_NAME?=
# EC2_INSTANCE_MONITORING?= Enabled=boolean
# EC2_INSTANCE_NAME?= my-instance-name
# EC2_INSTANCE_OWNER?= FirstLastname
# EC2_INSTANCE_PLACEMENT?=
# EC2_INSTANCE_PUBLICIP?= 34.218.247.79  
EC2_INSTANCE_PUBLICIP_ENABLE?= false
# EC2_INSTANCE_PUBLICIPS?= 34.218.247.79 ...
# EC2_INSTANCE_RAMDISK_ID?=
# EC2_INSTANCE_SECURITYGROUP_IDS?= sg-12345678
EC2_INSTANCE_SHUTDOWN_BEHAVIOR?= stop
# EC2_INSTANCE_SOURCE_DEST_CHECK?= true
# EC2_INSTANCE_SUBNET_ID?= subnet-12345678
# EC2_INSTANCE_TAGS?= Key=Name,Value='My Machine' Key=Owner,Value=FirstLastname
# EC2_INSTANCE_TYPE?= t2.micro
# EC2_INSTANCE_USERDATA?=
# EC2_INSTANCE_USERDATA_FILEPATH?= ./user_data/cloud_init.ud
EC2_INSTANCES_COUNT?= 1
# EC2_INSTANCES_FILTERS?= Name=instance-id,Values=i-0d6d2d862b5ff7a74,i-0d6d2d862b5ff7a74 ...
# EC2_INSTANCES_SET_NAME?= my-instance-set

# Derived parameters
EC2_INSTANCE_IDS?= $(EC2_INSTANCE_ID)
EC2_INSTANCE_IMAGE_ID?= $(EC2_IMAGE_ID)
EC2_INSTANCE_INSTANCEPROFILE_ARN?= $(IAM_INSTANCEPROFILE_ARN)
EC2_INSTANCE_INSTANCEPROFILE_ARN_OR_NAME?= $(if $(EC2_INSTANCE_INSTANCEPROFILE_ARN),Arn=$(EC2_INSTANCE_INSTANCEPROFILE_ARN))$(if $(EC2_INSTANCE_INSTANCEPROFILE_NAME),Name=$(EC2_INSTANCE_INSTANCEPROFILE_NAME))
EC2_INSTANCE_INSTANCEPROFILE_NAME?= $(IAM_INSTANCEPROFILE_NAME)
EC2_INSTANCE_KEYPAIR_NAME?= $(EC2_KEYPAIR_NAME)
EC2_INSTANCE_NAME?= $(EC2_INSTANCE_ID)
EC2_INSTANCE_PUBLICIPS?= $(EC2_INSTANCE_PUBLICIP)
EC2_INSTANCE_SECURITYGROUP_IDS?= $(EC2_SECURITYGROUP_IDS)
EC2_INSTANCE_SUBNET_ID?= $(EC2_SUBNET_ID)
EC2_INSTANCE_TAGS+= $(if $(EC2_INSTANCE_NAME),Key=Name$(COMMA)Value=$(EC2_INSTANCE_NAME))
EC2_INSTANCE_USERDATA?= $(if $(EC2_INSTANCE_USERDATA_FILEPATH), file://$(EC2_INSTANCE_USERDATA_FILEPATH))

# Option parameters
__EC2_ASSOCIATE_PUBLIC_IP_ADDRESS?= $(if $(filter true, $(EC2_INSTANCE_PUBLICIP_ENABLE)),--associate-public-ip-address,--no-associate-public-ip-address)
__EC2_ATTRIBUTE= $(if $(EC2_INSTANCE_ATTRIBUTE_NAME),--attribute $(EC2_INSTANCE_ATTRIBUTE_NAME))
__EC2_BLOCK_DEVICE_MAPPINGS=
__EC2_COUNT= $(if $(EC2_INSTANCES_COUNT),--count $(EC2_INSTANCES_COUNT))
__EC2_EBS_OPTIMIZED= $(if $(filter true, $(EC2_INSTANCE_EBS_OPTIMIZED)),--ebs-optimized, --no-ebs-optimized)
__EC2_FILTERS__INSTANCES= $(if $(EC2_INSTANCES_FILTERS),--filters $(EC2_INSTANCES_FILTERS))
__EC2_FORCE= --no-force
__EC2_IAM_INSTANCE_PROFILE= $(if $(EC2_INSTANCE_INSTANCEPROFILE_ARN_OR_NAME),--iam-instance-profile $(EC2_INSTANCE_INSTANCEPROFILE_ARN_OR_NAME))
__EC2_IMAGE_ID__INSTANCE= $(if $(EC2_INSTANCE_IMAGE_ID),--image-id $(EC2_INSTANCE_IMAGE_ID))
__EC2_INSTANCE_INITIATED_SHUTDOWN_BEHAVIOR= $(if $(EC2_INSTANCE_SHUTDOWN_BEHAVIOR),--instance-initiated-shutdown-behavior $(EC2_INSTANCE_SHUTDOWN_BEHAVIOR))
__EC2_INSTANCE_ID= $(if $(EC2_INSTANCE_ID),--instance-id $(EC2_INSTANCE_ID))
__EC2_INSTANCE_IDS__INSTANCE= $(if $(EC2_INSTANCE_ID),--instance-ids $(EC2_INSTANCE_ID))
__EC2_INSTANCE_IDS__INSTANCES= $(if $(EC2_INSTANCE_IDS),--instance-ids $(EC2_INSTANCE_IDS))
__EC2_INSTANCE_TYPE= $(if $(EC2_INSTANCE_TYPE),--instance-type $(EC2_INSTANCE_TYPE))
__EC2_IPV6_ADDRESS_COUNT=
__EC2_IPV6_ADDRESSES=
__EC2_KERNEL_ID=
__EC2_KEY_NAME__INSTANCE= $(if $(EC2_INSTANCE_KEYPAIR_NAME),--key-name $(EC2_INSTANCE_KEYPAIR_NAME))
__EC2_LAUNCH_TEMPLATE=
__EC2_MONITORING= $(if $(EC2_INSTANCE_MONITORING),--monitoring $(EC2_INSTANCE_MONITORING))
__EC2_PLACEMENT= $(if $(EC2_INSTANCE_PLACEMENT),--placement $(EC2_INSTANCE_PLACEMENT))
__EC2_RAMDISK_ID= $(if $(EC2_INSTANCE_RAMDISK_ID),--ramdisk-id $(EC2_INSTANCE_RAMDISK_ID))
__EC2_SECURITY_GROUP_IDS__INSTANCE= $(if $(EC2_INSTANCE_SECURITYGROUP_IDS),--security-group-ids $(EC2_INSTANCE_SECURITYGROUP_IDS))
# __EC2_SOURCE_DEST_CHECK= $(if $(filter false, $(EC2_INSTANCE_SOURCE_DEST_CHECK)), --no-source-dest-check, --source-dest-check)
__EC2_SUBNET_ID__INSTANCE= $(if $(EC2_INSTANCE_SUBNET_ID),--subnet-id $(EC2_INSTANCE_SUBNET_ID))
__EC2_TAG_SPECIFICATIONS__INSTANCE= $(if $(EC2_INSTANCE_TAGS),--tag-specifications ResourceType=instance$(COMMA)Tags=[{$(subst $(SPACE),}$(COMMA){,$(EC2_INSTANCE_TAGS))}])
__EC2_USER_DATA= $(if $(EC2_INSTANCE_USERDATA),--user-data $(EC2_INSTANCE_USERDATA))
__EC2_VALUE= $(if $(EC2_ATTRIBUTE_VALUE),--value $(EC2_ATTRIBUTE_VALUE))

# UI parameters
EC2_UI_GET_INSTANCE_PARAMETERS_FIELDS?= .[InstanceId,Tags[?Key=='Name']|[0].Value,PublicIpAddress]
EC2_UI_SHOW_INSTANCE_TAGS_FIELDS?= .Tags[]
EC2_UI_TERMINATE_INSTANCES_FIELDS?= .{InstanceId:InstanceId,PreviousState:PreviousState.Name,CurrentState:CurrentState.Name}
# EC2_UI_VIEW_INSTANCES_FIELDS?=.{Name:Tags[?Key=='Name']|[0].Value,InstanceId:InstanceId,_InstanceType:InstanceType,_ImageId:ImageId,_AvailabilityZone:Placement.AvailabilityZone,_PrivateIp:PrivateIpAddress,_PublicIp:PublicIpAddress,State:State.Name,_VpcId:VpcId,_KeyName:KeyName}
EC2_UI_VIEW_INSTANCES_FIELDS?= .{Name:Tags[?Key=='Name']|[0].Value,InstanceId:InstanceId,instanceType:InstanceType,imageId:ImageId,availabilityZone:Placement.AvailabilityZone,keyName:KeyName,publicIp:PublicIpAddress,state:State.Name}
EC2_UI_VIEW_INSTANCES_SET_FIELDS?= $(EC2_UI_VIEW_INSTANCES_FIELDS)

#--- Shell Utilities

#--- MACROS
_ec2_get_instance_ids= $(call _ec2_get_instance_ids_V, $(EC2_INSTANCE_NAME))
_ec2_get_instance_ids_V= $(call _ec2_get_instance_ids_VF, $(1), tag:Name)
_ec2_get_instance_ids_VF= $(call _ec2_get_instance_ids_VFS, $(1), $(2), running$(COMMA)stopped)
_ec2_get_instance_ids_VFS= $(call _ec2_get_instance_ids_VFSB, $(1), $(2), $(3), &InstanceId)
_ec2_get_instance_ids_VFSB= $(shell $(AWS) ec2 describe-instances --filters "Name=$(strip $(2)),Values=$(strip $(1))" "Name=instance-state-name,Values=$(strip $(3))" --query 'sort_by(Reservations[].Instances[],$(4))[].InstanceId' --output text)

_ec2_get_instance_id= $(call _ec2_get_instance_id_N, $(EC2_INSTANCE_NAME))
_ec2_get_instance_id_N= $(call _ec2_get_instance_id_VF, $(1), tag:Name)
_ec2_get_instance_id_VF= $(call _ec2_get_instance_id_VFS, $(1), $(2), running$(COMMA)stopped)
_ec2_get_instance_id_VFS= $(call _ec2_get_instance_id_VFSI, $(1), $(2), $(3), 0)
_ec2_get_instance_id_VFSI= $(call _ec2_get_instance_id_VFSIB, $(1), $(2), $(3), $(4), &InstanceId)
_ec2_get_instance_id_VFSIB= $(shell $(AWS) ec2 describe-instances --filters "Name=$(strip $(2)),Values=$(strip $(1))" "Name=instance-state-name,Values=$(strip $(3))" --query 'sort_by(Reservations[].Instances[],$(5))[$(4)].InstanceId' --output text)

_ec2_get_instance_instanceprofile_arn= $(call _ec2_get_instance_instanceprofile_arn_I, $(EC2_INSTANCE_ID))
_ec2_get_instance_instanceprofile_arn_I= $(shell $(AWS) ec2 describe-instances --instance-ids $(1) --query  "Reservations[].Instances[].IamInstanceProfile.Arn" --output text)

_ec2_get_instance_parameters= $(call _ec2_get_instance_parameters_I, $(EC2_INSTANCE_ID))
_ec2_get_instance_parameters_I= $(shell $(AWS) ec2 describe-instances --instance-ids $(1) --query "Reservations[].Instances[]$(EC2_UI_GET_INSTANCE_PARAMETERS_FIELDS)" --output text))

_ec2_get_instance_publicip= $(call _ec2_get_instance_publicip_I, $(EC2_INSTANCE_ID))
_ec2_get_instance_publicip_I= $(shell $(AWS) ec2 describe-instances --instance-ids $(1) --query "Reservations[].Instances[].PublicIpAddress" --output text)

_ec2_get_instance_securitygroup_ids= $(call _ec2_get_instance_securitygroup_ids_I, $(EC2_INSTANCE_ID))
_ec2_get_instance_securitygroup_ids_I= $(shell $(AWS) ec2 describe-instances --instance-ids $(1) --query "Reservations[].Instances[].SecurityGroups[]" --output text)

_ec2_get_instance_subnet_id= $(call _ec2_get_instance_subnet_id_I, $(EC2_INSTANCE_ID))
_ec2_get_instance_subnet_id_I= $(shell $(AWS) ec2 describe-instances --instance-ids $(1) --query "Reservations[0].Instances[0].SubnetId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ec2_view_framework_macros ::
	@echo 'AWS::EC2::Instance ($(_AWS_EC2_INSTANCE_MK_VERSION)) macros:' 
	@echo '    _ec2_get_instance_ids_{|V|VF|VFS|VFSB}         - Get a list of instance ids (Value,Filter,State,sortBy)'
	@echo '    _ec2_get_instance_id_{|N|VF|VFS|FVSI|VFSIB}    - Get an instance ID (Name/Value,Filter,State,Index,sortBy)'
	@echo '    _ec2_get_instance_instanceprofile_{|I}         - Get the instance-profile of 1 instance (Id)'
	@echo '    _ec2_get_instance_parameters_{|I}              - Get parameter-values for 1 instance (Id)'
	@echo '    _ec2_get_instance_publicip_{|I}                - Get the public-ip of an instance (Id)'
	@echo '    _ec2_get_instance_securitygroup_ids_{|I}       - Get the IDs of all the security-groups of an instance (Id)'
	@echo '    _ec2_get_instance_subnet_id_{|I}               - Get the ID of the subnet to which the instance is attached (Id)'
	@echo

_ec2_view_framework_parameters ::
	@echo 'AWS::EC2::Instances ($(_AWS_EC2_INSTANCE_MK_VERSION)) parameters:'
	@echo '    EC2_INSTANCE_ATTRIBUTE_NAME=$(EC2_INSTANCE_ATTRIBUTE_NAME)'
	@echo '    EC2_INSTANCE_ATTRIBUTE_NAMES=$(EC2_INSTANCE_ATTRIBUTE_NAMES)'
	@echo '    EC2_INSTANCE_ATTRIBUTE_VALUE=$(EC2_INSTANCE_ATTRIBUTE_VALUE)'
	@echo '    EC2_INSTANCE_EBS_OPTIMIZED=$(EC2_INSTANCE_EBS_OPTIMIZED)'
	@echo '    EC2_INSTANCE_ID=$(EC2_INSTANCE_ID)'
	@echo '    EC2_INSTANCE_IDS=$(EC2_INSTANCE_IDS)'
	@echo '    EC2_INSTANCE_IMAGE_ID=$(EC2_INSTANCE_IMAGE_ID)'
	@echo '    EC2_INSTANCE_INSTANCEPROFILE_ARN=$(EC2_INSTANCE_INSTANCEPROFILE_ARN)'
	@echo '    EC2_INSTANCE_KEYPAIR_NAME=$(EC2_INSTANCE_KEYPAIR_NAME)'
	@echo '    EC2_INSTANCE_NAME=$(EC2_INSTANCE_NAME)'
	@echo '    EC2_INSTANCE_PLACEMENT=$(EC2_INSTANCE_PLACEMENT)'
	@echo '    EC2_INSTANCE_PUBLICIP=$(EC2_INSTANCE_PUBLICIP)'
	@echo '    EC2_INSTANCE_PUBLICIPS=$(EC2_INSTANCE_PUBLICIPS)'
	@echo '    EC2_INSTANCE_PUBLICIP_ENABLE=$(EC2_INSTANCE_PUBLICIP_ENABLE)'
	@echo '    EC2_INSTANCE_RAMDISK_ID=$(EC2_INSTANCE_RAMDISK_ID)'
	@echo '    EC2_INSTANCE_SECURITYGROUP_IDS=$(EC2_INSTANCE_SECURITYGROUP_IDS)'
	@echo '    EC2_INSTANCE_SHUTDOWN_BEHAVIOR=$(EC2_INSTANCE_SHUTDOWN_BEHAVIOR)'
	@#echo '    EC2_INSTANCE_SOURCE_DEST_CHECK=$(EC2_INSTANCE_SOURCE_DEST_CHECK)'
	@echo '    EC2_INSTANCE_SUBNET_ID=$(EC2_INSTANCE_SUBNET_ID)'
	@echo '    EC2_INSTANCE_TYPE=$(EC2_INSTANCE_TYPE)'
	@echo '    EC2_INSTANCE_USERDATA=$(EC2_INSTANCE_USERDATA)'
	@echo '    EC2_INSTANCE_USERDATA_FILEPATH=$(EC2_INSTANCE_USERDATA_FILEPATH)'
	@echo '    EC2_INSTANCES_COUNT=$(EC2_INSTANCES_COUNT)'
	@echo '    EC2_INSTANCES_FILTERS=$(EC2_INSTANCES_FILTERS)'
	@echo '    EC2_INSTANCES_SET_NAME=$(EC2_INSTANCES_SET_NAME)'
	@echo

_ec2_view_framework_targets ::
	@echo 'AWS::EC2::Instance ($(_AWS_EC2_INSTANCE_MK_VERSION)) targets:' 
	@#echo '    _ec2_apply_termination_protection       - Applies termination protection to all INSTANCE_IDS'
	@echo '    _ec2_create_instance                    - Create one or more instances'
	@echo '    _ec2_remove_termination_protection      - Removes termination protection of all INSTANCE_IDS'
	@echo '    _ec2_show_instance                      - Show everything related to an instance'
	@echo '    _ec2_show_instance_attributes           - Show the attributes of an instance'
	@echo '    _ec2_show_instance_description          - Show description of an instance'
	@echo '    _ec2_show_instance_tags                 - Show tags of an instance'
	@echo '    _ec2_show_instance_userdata             - Show user-date of an instance'
	@echo '    _ec2_start_instances                    - Start one or more instanceS'
	@echo '    _ec2_stop_instances                     - Stop one or more instances'
	@echo '    _ec2_terminate_instances                - Terminate one or more all INSTANCE_IDS'
	@echo '    _ec2_update_instance_attribute          - Update one or more attributes of a stopped instance'
	@echo '    _ec2_view_instances                     - View instances'
	@echo '    _ec2_view_instances_set                 - View a set of instances'
	@echo '    _ec2_wait_instance_running              - Wait for instances to be running'
	@echo '    _ec2_wait_instance_statusok             - Wait for instances to report status-ok'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_create_instance:
	@$(INFO) '$(EC2_UI_LABEL)Creating one or more instances ...'; $(NORMAL)
	$(if $(EC2_INSTANCE_USERDATA_FILEPATH), cat $(EC2_INSTANCE_USERDATA_FILEPATH))
	$(AWS) ec2 run-instances $(strip $(__EC2_ASSOCIATE_PUBLIC_IP_ADDRESS) $(__EC2_BLOCK_DEVICE_MAPPINGS) $(__EC2_EBS_OPTIMIZED) $(__EC2_COUNT) $(__EC2_IAM_INSTANCE_PROFILE) $(__EC2_IMAGE_ID__INSTANCE) $(__EC2_INSTANCE_TYPE) $(__EC2_IPV6_ADDRESS_COUNT) $(__EC2_IPV6_ADDRESSES) $(__EC2_KERNEL_ID) $(__EC2_KEY_NAME__INSTANCE) $(__EC2_RAMDISK_ID) $(_X__EC2_SECURITY_GROUP_NAME) $(__EC2_SECURITY_GROUP_IDS__INSTANCE) $(__EC2_SUBNET_ID__INSTANCE) $(__EC2_TAG_SPECIFICATIONS__INSTANCE) $(__EC2_USER_DATA))

_ec2_delete_instance:
	@$(INFO) '$(EC2_UI_LABEL)Deleting instance "$(EC2_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 terminate-instances --instance-ids $(EC2_INSTANCE_ID) --query "TerminatingInstances[]"

_ec2_protect_instance:
	@$(INFO) '$(EC2_UI_LABEL)Applying termination-protection to instance "$(EC2_INSTANCE_NAME)" ...'; $(NORMAL)

_ec2_show_instance :: _ec2_show_instance_securitygroups _ec2_show_instance_userdata _ec2_show_instance_description
# _ec2_show_instance: _ec2_show_instance_attributes _ec2_show_instance_securitygroups _ec2_show_instance_userdata _ec2_show_instance_description

_ec2_show_instance_attributes:
	@$(INFO) '$(EC2_UI_LABEL)Showing attributes of instance "$(EC2_INSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Attributes of interest: $(EC2_INSTANCE_ATTRIBUTE_NAMES)'; $(NORMAL)
	$(foreach A, $(EC2_INSTANCE_ATTRIBUTE_NAMES), \
		$(AWS) ec2 describe-instance-attribute --attribute $(A) $(__EC2_INSTANCE_ID); \
	)

_ec2_show_instance_description:
	@$(INFO) '$(EC2_UI_LABEL)Showing description of instance "$(EC2_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-instances $(__EC2_INSTANCE_IDS__INSTANCE)

_ec2_show_instance_securitygroups:
	@$(INFO) '$(EC2_UI_LABEL)Showing security-groups of instance "$(EC2_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-instances $(__EC2_INSTANCE_ID) --query "Reservations[].Instances[].SecurityGroups[]"

_ec2_show_instance_tags:
	@$(INFO) '$(EC2_UI_LABEL)Showing tags of instance "$(EC2_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-instances $(__EC2_INSTANCE_IDS__INSTANCE) --query "Reservations[].Instances[]$(EC2_UI_SHOW_INSTANCE_TAGS_FIELDS)"

_ec2_show_instance_userdata:
	@$(INFO) '$(EC2_UI_LABEL)Showing user-data of instance "$(EC2_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-instance-attribute --attribute userData $(__EC2_INSTANCE_ID) --query "UserData.Value" --output text | base64 -d; echo

_ec2_start_instance:
	@$(INFO) '$(EC2_UI_LABEL)Starting instance "$(EC2_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 start-instances $(__EC2_INSTANCE_IDS__INSTANCE) --query "StartingInstances[]"

_ec2_stop_instance:
	@$(INFO) '$(EC2_UI_LABEL)Stopping instance "$(EC2_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 stop-instances $(__EC2_FORCE) $(__EC2_INSTANCE_IDS__INSTANCE) --query "StoppingInstances[]"

_ec2_update_instance_attribute:
	@$(INFO) '$(EC2_UI_LABEL)Modifying attribute "$(EC2_INSTANCE_ATTRIBUTE_NAME)" of instance "$(EC2_INSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'To modify the attribute, the instance must be stopped!'; $(NORMAL)
	@$(WARN) 'If modifying user-data with a file://, the document need to be base64: base64 userdata.txt > userdata64.txt'; $(NORMAL)
	$(AWS) ec2 modify-instance-attribute $(__EC2_ATTRIBUTE) $(__EC2_INSTANCE_ID) $(__EC2_VALUE)

_ec2_unprotect_instance:
	@$(INFO) '$(EC2_UI_LABEL)Removing termination protection for instance "$(EC2_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 modify-instance-attribute $(__EC2_INSTANCE_ID) --no-disable-api-termination

_ec2_view_instances:
	@$(INFO) '$(EC2_UI_LABEL)Viewing ALL instances ...'; $(NORMAL)
	$(AWS) ec2 describe-instances $(_X__EC2_FILTERS__INSTANCES) --query "Reservations[].Instances[]$(EC2_UI_VIEW_INSTANCES_FIELDS)"

_ec2_view_instances_set:
	@$(INFO) '$(EC2_UI_LABEL)Viewing instances-set "$(EC2_INSTANCES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Instances are grouped based on provided filter'; $(NORMAL)
	$(AWS) ec2 describe-instances $(__EC2_FILTERS__INSTANCES) --query "Reservations[].Instances[]$(EC2_UI_VIEW_INSTANCES_SET_FIELDS)"

_ec2_wait_instance_running:
	@$(INFO) '$(EC2_UI_LABEL)Waiting for instances to be in 'running' state ...'; $(NORMAL)
	@$(WARN) 'Polling status at 15 sec intervals'; $(NORMAL)
	$(AWS) ec2 wait instance-running $(_X__EC2_INSTANCE_FILTERS) $(__EC2_INSTANCE_IDS__INSTANCES)

# You need to call this function with make in the makefile to re-computer EC2_INSTANCE_IDS after instanciation
_ec2_wait_instance_statusok:
	@$(INFO) '$(EC2_UI_LABEL)Waiting status-checks for instances to pass ...'; $(NORMAL)
	@$(WARN) 'The status is polled at 15 sec intervals'; $(NORMAL)
	$(AWS) ec2 wait instance-status-ok $(_X__EC2_INSTANCE_FILTERS) $(__EC2_INSTANCE_IDS__INSTANCES)
	@$(WARN) 'System reachability check passed'; $(NORMAL)
	@$(WARN) 'Instance reachability check passed'; $(NORMAL)
