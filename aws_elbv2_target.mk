_AWS_ELBV2_TARGET_MK_VERSION= $(_AWS_ELBV2_MK_VERSION)

# ELB2_TARGET_ARN?=
# ELB2_TARGET_AZ_ID?=
# ELB2_TARGET_CONFIG?= Id=string,Port=integer,AvailabilityZone=string
# ELB2_TARGET_ID?=
# ELB2_TARGET_IP?= 123.123.123.123
# ELB2_TARGET_NAME?=
# ELB2_TARGET_PORT?= 80
# ELB2_TARGET_TARGETGROUP_ARN?=
# ELB2_TARGET_TARGETGROUP_NAME?= my-target-group
# ELB2_TARGET_URL?= http://....:80
# ELB2_TARGETS_ARNS?=
# ELB2_TARGETS_CONFIGS?= Id=string,Port=integer,AvailabilityZone=string ...
# ELB2_TARGETS_IDS?=
# ELB2_TARGETS_NAME?= my-group-of-targets
# ELB2_TARGETS_SET_NAME?=
# ELB2_TARGETS_TARGETGROUP_ARN?=
# ELB2_TARGETS_TARGETGROUP_NAME?= my-traget-group

# Derived parameters
ELB2_TARGET_CONFIG?= Id=$(ELB2_TARGET_ID),Port=$(ELB2_TARGET_PORT)$(if $(ELB2_TARGET_AZ_ID),$(COMMA)AvailabilityZone=$(ELB2_TARGET_AZ_ID))
ELB2_TARGET_PORT?= $(ELB2_TARGETGROUP_PORT)
ELB2_TARGET_TARGETGROUP_ARN?= $(ELB2_TARGETGROUP_ARN)
ELB2_TARGET_TARGETGROUP_NAME?= $(ELB2_TARGETGROUP_NAME)
ELB2_TARGET_URL?= http://$(ELB2_TARGET_IP):$(ELB2_TARGET_PORT)
ELB2_TARGETS_ARNS?= $(ELB2_TARGET_ARN)
ELB2_TARGETS_CONFIGS?= $(ELB2_TARGET_CONFIG)
ELB2_TARGETS_IDS?= $(ELB2_TARGET_ID)
ELB2_TARGETS_SET_NAME?= targets@$(ELB2_TARGETS_TARGETGROUP_NAME)
ELB2_TARGETS_TARGETGROUP_ARN?= $(ELB2_TARGET_TARGETGROUP_ARN)
ELB2_TARGETS_TARGETGROUP_NAME?= $(ELB2_TARGET_TARGETGROUP_NAME)

# Option parameters
__ELB2_TARGET_GROUP_ARN__TARGET= $(if $(ELB2_TARGET_TARGETGROUP_ARN),--target-group-arn $(ELB2_TARGET_TARGETGROUP_ARN))
__ELB2_TARGET_GROUP_ARN__TARGETS= $(if $(ELB2_TARGETS_TARGETGROUP_ARN),--target-group-arn $(ELB2_TARGETS_TARGETGROUP_ARN))
__ELB2_TARGETS__TARGET= $(if $(ELB2_TARGET_CONFIG),--targets $(ELB2_TARGET_CONFIG)) 
__ELB2_TARGETS__TARGETS= $(if $(ELB2_TARGETS_CONFIGS),--targets $(ELB2_TARGETS_CONFIGS)) 

# UI parameters
ELB2_UI_VIEW_TARGETS_FIELDS?= # .{TargetGroupName:TargetGroupName,protocol:Protocol,port:Port,targetType:TargetType,vpcId:VpcId,protocolVersion:ProtocolVersion,TargetGroupArn:TargetGroupArn}
ELB2_UI_VIEW_TARGETS_SET_FIELDS?= $(ELB2_UI_VIEW_TARGETGROUPS_FIELDS)
ELB2_UI_VIEW_TARGETS_SET_QUERYFILTER?=

# Pipe
|_CURL_TARGET?= | head -10

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_elb2_view_framework_macros ::
	@echo 'AWS::ElasticLoadBalancerV2::Target ($(_AWS_ELBV2_TARGET_MK_VERSION)) macros:'
	@echo

_elb2_view_framework_parameters ::
	@echo 'AWS::ElasticLoadBalancerV2::Target($(_AWS_ELBV2_TARGET_MK_VERSION)) parameters:'
	@echo '    ELB2_TARGET_ARN=$(ELB2_TARGET_ARN)'
	@echo '    ELB2_TARGET_AZ_ID=$(ELB2_TARGET_AZ_ID)'
	@echo '    ELB2_TARGET_CONFIG=$(ELB2_TARGET_CONFIG)'
	@echo '    ELB2_TARGET_ID=$(ELB2_TARGET_ID)'
	@echo '    ELB2_TARGET_NAME=$(ELB2_TARGET_NAME)'
	@echo '    ELB2_TARGET_IP=$(ELB2_TARGET_IP)'
	@echo '    ELB2_TARGET_PORT=$(ELB2_TARGETGROUP_PORT)'
	@echo '    ELB2_TARGET_TARGETGROUP_ARN=$(ELB2_TARGET_TARGETGROUP_ARN)'
	@echo '    ELB2_TARGET_TARGETGROUP_NAME=$(ELB2_TARGET_TARGETGROUP_NAME)'
	@echo '    ELB2_TARGETS_ARNS=$(ELB2_TARGETS_ARNS)'
	@echo '    ELB2_TARGETS_CONFIGS=$(ELB2_TARGETS_CONFIGS)'
	@echo '    ELB2_TARGETS_IDS=$(ELB2_TARGETS_IDS)'
	@echo '    ELB2_TARGETS_NAME=$(ELB2_TARGETS_NAME)'
	@echo '    ELB2_TARGETS_TARGETGROUP_ARN=$(ELB2_TARGETS_TARGETGROUP_ARN)'
	@echo '    ELB2_TARGETS_TARGETGROUP_NAME=$(ELB2_TARGETS_TARGETGROUP_NAME)'
	@echo '    ELB2_TARGETS_SET_NAME=$(ELB2_TARGETS_SET_NAME)'
	@echo

_elb2_view_framework_targets ::
	@echo 'AWS::ElasticLoadBalancerV2::Target($(_AWS_ELBV2_TARGET_MK_VERSION)) targets:'
	@#echo '    _elb2_create_target                           - Create a target'
	@#echo '    _elb2_delete_target                           - Delete an target'
	@echo '    _elb2_deregister_target                       - Deregister an target'
	@echo '    _elb2_deregister_targets                      - Deregister a group of targets'
	@echo '    _elb2_register_target                         - Register a target'
	@echo '    _elb2_register_targets                        - Register a group of targets'
	@echo '    _elb2_show_target                             - Show everything related to a target'
	@echo '    _elb2_show_target_description                 - Show description of a target'
	@echo '    _elb2_show_target_health                      - Show the health of a target'
	@echo '    _elb2_show_target_targetgroup                 - Show the target-group of a target'
	@echo '    _elb2_view_targets                            - View all targets'
	@echo '    _elb2_view_targets_set                        - View a set of targets'
	@echo '    _elb2_watch_targets                           - Watch all targets'
	@echo '    _elb2_watch_targets_set                       - Watch a set of targets'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_elb2_create_target: _elb2_register_target

_elb2_curl_target:
	@$(INFO) '$(ELB2_UI_LABEL)Curling target "$(ELB2_TARGET_NAME)" ...'; $(NORMAL)
	$(ELB2_CURL) $(ELB2_TARGET_URL) $(|_CURL_TARGET)

_elb2_delete_target:
	@$(INFO) '$(ELB2_UI_LABEL)Deleting/Deregister target "$(ELB2_TARGET_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 deregister-targets $(__ELB2_TARGET_GROUP_ARN__TARGET) $(__ELB2_TARGETS__TARGET)

_elb2_deregister_target:
	@$(INFO) '$(ELB2_UI_LABEL)De-registering target "$(ELB2_TARGET_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 deregister-targets $(__ELB2_TARGET_GROUP_ARN__TARGET) $(__ELB2_TARGETS__TARGET)

_elb2_deregister_targets:
	@$(INFO) '$(ELB2_UI_LABEL)De-registering targets "$(ELB2_TARGETS_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 deregister-targets $(__ELB2_TARGET_GROUP_ARN__TARGETS) $(__ELB2_TARGETS__TARGETS)

_elb2_register_target:
	@$(INFO) '$(ELB2_UI_LABEL)Registering target "$(ELB2_TARGET_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 register-targets $(__ELB2_TARGET_GROUP_ARN__TARGET) $(__ELB2_TARGETS__TARGET)

_elb2_register_targets:
	@$(INFO) '$(ELB2_UI_LABEL)Registering targets "$(ELB2_TARGETS_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 register-targets $(__ELB2_TARGET_GROUP_ARN__TARGETS) $(__ELB2_TARGETS__TARGETS)

_elb2_show_target: _elb2_show_target_health _elb2_show_target_targetgroup _elb2_show_target_description

_elb2_show_target_description:
	@$(INFO) '$(ELB2_UI_LABEL)Showing description of target "$(ELB2_TARGET_NAME)" ...'; $(NORMAL)

_elb2_show_target_health:
	@$(INFO) '$(ELB2_UI_LABEL)Showing health of target "$(ELB2_TARGET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the target-group does not exist'; $(NORMAL)
	@$(WARN) 'This operation MUST return at least one healthy target'; $(NORMAL)
	-$(AWS) elbv2 describe-target-health $(__ELB2_TARGET_GROUP_ARN__TARGET) $(__ELB2_TARGETS__TARGET) --query "TargetHealthDescriptions[]"

_elb2_show_target_targetgroup:
	@$(INFO) '$(ELB2_UI_LABEL)Showing target-group of target "$(ELB2_TARGET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the target-group does not exist'; $(NORMAL)
	-$(AWS) elbv2 describe-target-groups $(_X__ELB2_LOAD_BALANCER_ARNS__TARGETGROUP) $(__ELB2_NAMES__TARGETGROUP) $(_X__ELB2_TARGET_GROUP_ARNS) --query "TargetGroups[]"

_elb2_view_targets:
	@$(INFO) '$(ELB2_UI_LABEL)Viewing ALL targets ...'; $(NORMAL)
	$(AWS) elbv2 describe-target-groups $(_X__ELB2_LOAD_BALANCER_ARNS) $(_X__ELB2_NAMES__TARGETGROUPS) --query "TargetGroups[]$(ELB2_UI_VIEW_TARGETGROUPS_FIELDS)"

_elb2_view_targets_set:
	@$(INFO) '$(ELB2_UI_LABEL)Viewing targets-set "$(ELB2_TARGETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Targets are grouped based on the provided target-group ARNs/names, and query-filter'; $(NORMAL)
	$(AWS) elbv2 describe-target-groups $(__ELB2_LOAD_BALANCER_ARN__TARGETGROUPS) $(__ELB2_NAMES__TARGETGROUPS) $(__ELB2_TARGETGROUP_ARNS) --query "TargetGroups[$(ELB2_UI_VIEW_TARGETGROUPS_SET_QUERYFILTER)]$(ELB2_UI_VIEW_TARGETGROUPS_SET_FIELDS)"

_elb2_watch_targets:
	@$(INFO) '$(ELB2_UI_LABEL)Watching ALL targets ...'; $(NORMAL)

_elb2_watch_targets_set:
	@$(INFO) '$(ELB2_UI_LABEL)Watching targets-set "$(ELB2_TARGETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Targets are grouped based on the provided target-group ARNs/names, and query-filter'; $(NORMAL)
