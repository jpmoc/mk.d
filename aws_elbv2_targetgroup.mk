_AWS_ELBV2_TARGETGROUP_MK_VERSION= $(_AWS_ELBV2_MK_VERSION)

# ELB2_TARGETGROUP_ARN?=
ELB2_TARGETGROUP_HEALTHCHECK_FLAG?= true
ELB2_TARGETGROUP_HEALTHCHECK_INTERVAL?= 30
ELB2_TARGETGROUP_HEALTHCHECK_PATH?= /
ELB2_TARGETGROUP_HEALTHCHECK_PORT?= traffic-port
ELB2_TARGETGROUP_HEALTHCHECK_PROTOCOL?= HTTP
ELB2_TARGETGROUP_HEALTHCHECK_TIMEOUT?= 5
ELB2_TARGETGROUP_HEALTHYTHRESHOLD_COUNT?= 5
ELB2_TARGETGROUP_MATCHER_CONFIG?= HttpCode=200#,GrpcCode=12
# ELB2_TARGETGROUP_NAME?=
# ELB2_TARGETGROUP_NAME_UID?= 1234567890abcdef
# ELB2_TARGETGROUP_PORT?= 80
ELB2_TARGETGROUP_PROTOCOL?= HTTP
ELB2_TARGETGROUP_PROTOCOL_VERSION?= HTTP1
# ELB2_TARGETGROUP_TAGS_KEYVALUES?= Key=string,Value=string ...
ELB2_TARGETGROUP_TARGET_TYPE?= instance
# ELB2_TARGETGROUP_UNHEALTHYTHRESHOLD_COUNT?= 5
# ELB2_TARGETGROUP_VPC_ID?=
# ELB2_TARGETGROUPS_ARNS?=
# ELB2_TARGETGROUPS_LOADBALANCER_ARN?=
# ELB2_TARGETGROUPS_NAMES?=
# ELB2_TARGETGROUPS_SET_NAME?=

# Derived parameters
ELB2_TARGETGROUP_ARN?= $(if $(ELB2_TARGETGROUP_NAME_UID),arn:aws:elasticloadbalancing:$(ELB2_REGION_ID):$(ELB2_ACCOUNT_ID):targetgroup/$(ELB2_TARGETGROUP_NAME)/$(ELB2_TARGETGROUP_NAME_UID))
ELB2_TARGETGROUPS_ARNS?= $(ELB2_TARGETGROUP_ARN)
ELB2_TARGETGROUPS_LOADBALANCER_ARN?= $(ELB2_TARGETGROUP_LOADBALANCER_ARN)
ELB2_TARGETGROUPS_NAMES?= $(ELB2_TARGETGROUP_NAME)

# Options
__ELB2_HEALTH_CHECK_ENABLED= $(if $(filter false, $(ELB2_TARGETGROUP_HEALTHCHECK_FLAG)),--no-health-check-enabled,--health-check-enabled) # Enabled by default
__ELB2_HEALTH_CHECK_INTERVAL_SECONDS= $(if $(ELB2_TARGETGROUP_HEALTHCHECK_INTERVAL),--health-check-interval-seconds $(ELB2_TARGETGROUP_HEALTHCHECK_INTERVAL))
__ELB2_HEALTH_CHECK_PATH= $(if $(ELB2_TARGETGROUP_HEALTHCHECK_PATH),--health-check-path $(ELB2_TARGETGROUP_HEALTHCHECK_PATH))
__ELB2_HEALTH_CHECK_PORT= $(if $(ELB2_TARGETGROUP_HEALTHCHECK_PORT),--health-check-port $(ELB2_TARGETGROUP_HEALTHCHECK_PORT))
__ELB2_HEALTH_CHECK_PROTOCOL= $(if $(ELB2_TARGETGROUP_HEALTHCHECK_PROTOCOL),--health-check-protocol $(ELB2_TARGETGROUP_HEALTHCHECK_PROTOCOL))
__ELB2_HEALTH_CHECK_TIMEOUT_SECONDS= $(if $(ELB2_TARGETGROUP_HEALTHCHECK_TIMEOUT),--health-check-timeout-seconds $(ELB2_TARGETGROUP_HEALTHCHECK_TIMEOUT))
__ELB2_HEALTHY_THRESHOLD_COUNT= $(if $(ELB2_TARGETGROUP_HEALTHYTHRESHOLD_COUNT),--healthy-threshold-count $(ELB2_TARGETGROUP_HEALTHYTHRESHOLD_COUNT))
__ELB2_LOAD_BALANCER_ARN__TARGETGROUPS= $(if $(ELB2_TARGETGROUP_LOADBALANCER_ARN),--load-balancer-arn $(ELB2_TARGETGROUP_LOADBALANCER_ARN))
__ELB2_MATCHER= $(if $(ELB2_TARGETGROUP_MATCHER_CONFIG),--matcher $(ELB2_TARGETGROUP_MATCHER_CONFIG))
__ELB2_NAME__TARGETGROUP= $(if $(ELB2_TARGETGROUP_NAME),--name $(ELB2_TARGETGROUP_NAME))
__ELB2_NAMES__TARGETGROUP= $(if $(ELB2_TARGETGROUP_NAME),--names $(ELB2_TARGETGROUP_NAME))
__ELB2_NAMES__TARGETGROUPS= $(if $(ELB2_TARGETGROUPS_NAMES),--names $(ELB2_TARGETGROUPS_NAMES))
__ELB2_PORT__TARGETGROUP= $(if $(ELB2_TARGETGROUP_PORT),--port $(ELB2_TARGETGROUP_PORT))
__ELB2_PROTOCOL__TARGETGROUP= $(if $(ELB2_TARGETGROUP_PROTOCOL),--protocol $(ELB2_TARGETGROUP_PROTOCOL))
__ELB2_PROTOCOL_VERSION= $(if $(ELB2_TARGETGROUP_PROTOCOL_VERSION),--protocol-version $(ELB2_TARGETGROUP_PROTOCOL_VERSION))
__ELB2_TAGS__TARGETGROUP= $(if $(ELB2_TARGETGROUP_TAGS_KEYVALUES),--tags $(ELB2_TARGETGROUP_TAGS_KEYVALUES))
__ELB2_TARGET_GROUP_ARN= $(if $(ELB2_TARGETGROUP_ARN),--target-group-arn $(ELB2_TARGETGROUP_ARN))
__ELB2_TARGETS=
__ELB2_TARGET_TYPE= $(if $(ELB2_TARGETGROUP_TARGET_TYPE),--target-type $(ELB2_TARGETGROUP_TARGET_TYPE))
__ELB2_UNHEALTHY_THRESHOLD_COUNT= $(if $(ELB2_TARGETGROUP_UNHEALTHYTHRESHOLD_COUNT),--unhealthy-threshold-count $(ELB2_TARGETGROUP_UNHEALTHYTHRESHOLD_COUNT))
__ELB2_VPC_ID__TARGETGROUP= $(if $(ELB2_TARGETGROUP_VPC_ID),--vpc-id $(ELB2_TARGETGROUP_VPC_ID))

# Customizations
_ELB2_LIST_TARGETGROUPS_FIELDS?= .{TargetGroupName:TargetGroupName,protocol:Protocol,port:Port,targetType:TargetType,vpcId:VpcId,protocolVersion:ProtocolVersion,TargetGroupArn:TargetGroupArn}
_ELB2_LIST_TARGETGROUPS_SET_FIELDS?= $(_ELB2_LIST_TARGETGROUPS_FIELDS)
_ELB2_LIST_TARGETGROUPS_SET_QUERYFILTER?=
_ELB2_SHOW_TARGETGROUP_HEALTH_FIELDS?=

# Macros
_elb2_get_targetgroup_arn= $(call _elb2_get_targetgroup_arn_N, $(ELB2_TARGETGROUP_NAME))
_elb2_get_targetgroup_arn_N= $(shell $(AWS) elbv2 describe-target-groups --names $(1) --query "TargetGroups[].TargetGroupArn" --output text) 

#----------------------------------------------------------------------
# USAGE
#

_elb2_list_macros ::
	@echo 'AWS::ElasticLoadBalancerV2::TargetGroup ($(_AWS_ELBV2_TARGETGROUP_MK_VERSION)) macros:'
	@echo '    _elb2_get_targetgroup_arn_{|N}                     - Get the ARN of a targetgroup (Name)'
	@echo

_elb2_list_parameters ::
	@echo 'AWS::ElasticLoadBalancerV2::TargetGroup ($(_AWS_ELBV2_TARGETGROUP_MK_VERSION)) parameters:'
	@echo '    ELB2_TARGETGROUP_ARN=$(ELB2_TARGETGROUP_ARN)'
	@echo '    ELB2_TARGETGROUP_HEALTHCHECK_FLAG=$(ELB2_TARGETGROUP_HEALTHCHECK_FLAG)'
	@echo '    ELB2_TARGETGROUP_HEALTHCHECK_INTERVAL=$(ELB2_TARGETGROUP_HEALTHCHECK_INTERVAL)'
	@echo '    ELB2_TARGETGROUP_HEALTHCHECK_PATH=$(ELB2_TARGETGROUP_HEALTHCHECK_PATH)'
	@echo '    ELB2_TARGETGROUP_HEALTHCHECK_PORT=$(ELB2_TARGETGROUP_HEALTHCHECK_PORT)'
	@echo '    ELB2_TARGETGROUP_HEALTHCHECK_PROTOCOL=$(ELB2_TARGETGROUP_HEALTHCHECK_PROTOCOL)'
	@echo '    ELB2_TARGETGROUP_HEALTHCHECK_TIMEOUT=$(ELB2_TARGETGROUP_HEALTHCHECK_TIMEOUT)'
	@echo '    ELB2_TARGETGROUP_HEALTHYTHRESHOLD_COUNT=$(ELB2_TARGETGROUP_HEALTHYTHRESHOLD_COUNT)'
	@echo '    ELB2_TARGETGROUP_MATCHER_CONFIG=$(ELB2_TARGETGROUP_MATCHER_CONFIG)'
	@echo '    ELB2_TARGETGROUP_NAME=$(ELB2_TARGETGROUP_NAME)'
	@echo '    ELB2_TARGETGROUP_NAME_UID=$(ELB2_TARGETGROUP_NAME_UID)'
	@echo '    ELB2_TARGETGROUP_PORT=$(ELB2_TARGETGROUP_PORT)'
	@echo '    ELB2_TARGETGROUP_PROTOCOL=$(ELB2_TARGETGROUP_PROTOCOL)'
	@echo '    ELB2_TARGETGROUP_PROTOCOL_VERSION=$(ELB2_TARGETGROUP_PROTOCOL_VERSION)'
	@echo '    ELB2_TARGETGROUP_TAGS_KEYVALUES=$(ELB2_TARGETGROUP_TAGS_KEYVALUES)'
	@echo '    ELB2_TARGETGROUP_TARGET_TYPE=$(ELB2_TARGETGROUP_TARGET_TYPE)'
	@echo '    ELB2_TARGETGROUP_UNHEALTHYTHRESHOLD_COUNT=$(ELB2_TARGETGROUP_UNHEALTHYTHRESHOLD_COUNT)'
	@echo '    ELB2_TARGETGROUP_VPC_ID=$(ELB2_TARGETGROUP_VPC_ID)'
	@echo '    ELB2_TARGETGROUPS_ARNS=$(ELB2_TARGETGROUPS_ARNS)'
	@echo '    ELB2_TARGETGROUPS_LOADBALANCER_ARN=$(ELB2_TARGETGROUPS_LOADBALANCER_ARN)'
	@echo '    ELB2_TARGETGROUPS_NAMES=$(ELB2_TARGETGROUPS_NAMES)'
	@echo '    ELB2_TARGETGROUPS_SET_NAME=$(ELB2_TARGETGROUPS_SET_NAME)'
	@echo

_elb2_list_targets ::
	@echo 'AWS::ElasticLoadBalancerV2::TargetGroup ($(_AWS_ELBV2_TARGETGROUP_MK_VERSION)) targets:'
	@echo '    _elb2_create_targetgroup                           - Create a target-group'
	@echo '    _elb2_delete_targetgroup                           - Delete an existing target-group'
	@echo '    _elb2_list_targetgroups                            - List all target-groups'
	@echo '    _elb2_list_targetgroups_set                        - List a set of target-groups'
	@echo '    _elb2_show_targetgroup                             - Show everything related to a target-group'
	@echo '    _elb2_show_targetgroup_attributes                  - Show attributes of a target-group'
	@echo '    _elb2_show_targetgroup_description                 - Show description of a target-group'
	@echo '    _elb2_show_targetgroup_health                      - Show the health of a target-group'
	@echo '    _elb2_watch_targetgroups                           - Watch all target-groups'
	@echo '    _elb2_watch_targetgroups_set                       - Watch a set of target-groups'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_elb2_create_targetgroup:
	@$(INFO) '$(ELB2_UI_LABEL)Creating target-group "$(ELB2_TARGETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 create-target-group $(strip $(__ELB2_HEALTH_CHECK_ENABLED) $(__ELB2_HEALTH_CHECK_INTERVAL_SECONDS) $(__ELB2_HEALTH_CHECK_PATH) $(__ELB2_HEALTH_CHECK_PORT) $(__ELB2_HEALTH_CHECK_PROTOCOL) $(__ELB2_HEALTH_CHECK_TIMEOUT_SECONDS) $(__ELB2_HEALTHY_THREASHOLD_COUNT) $(__ELB2_MATCHER) $(__ELB2_NAME__TARGETGROUP) $(__ELB2_PORT__TARGETGROUP) $(__ELB2_PROTOCOL__TARGETGROUP) $(__ELB2_PROTOCOL_VERSION) $(__ELB2_TARGET_TYPE) $(__ELB2_UNHEALTHY_THRESHOLD_COUNT) $(__ELB2_TAGS__TARGETGROUP) $(__ELB2_VPC_ID__TARGETGROUP)) --query 'TargetGroups'

_elb2_delete_targetgroup:
	@$(INFO) '$(ELB2_UI_LABEL)Deleting target-group "$(ELB2_TARGETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 delete-target-group $(__ELB2_TARGET_GROUP_ARN)

_elb2_list_targetgroups:
	@$(INFO) '$(ELB2_UI_LABEL)Listing ALL target-groups ...'; $(NORMAL)
	$(AWS) elbv2 describe-target-groups $(_X__ELB2_LOAD_BALANCER_ARNS) $(_X__ELB2_NAMES__TARGETGROUPS) --query "TargetGroups[]$(_ELB2_LIST_TARGETGROUPS_FIELDS)"

_elb2_list_targetgroups_set:
	@$(INFO) '$(ELB2_UI_LABEL)Listing target-groups-set "$(ELB2_TARGETGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Target-groups are grouped based on the provided load-balancer ARN, target-group ARNs/names, and query-filter'; $(NORMAL)
	$(AWS) elbv2 describe-target-groups $(__ELB2_LOAD_BALANCER_ARN__TARGETGROUPS) $(__ELB2_NAMES__TARGETGROUPS) $(__ELB2_TARGETGROUP_ARNS) --query "TargetGroups[$(_ELB2_LIST_TARGETGROUPS_SET_QUERYFILTER)]$(_ELB2_LIST_TARGETGROUPS_SET_FIELDS)"

_ELB2_SHOW_TARGETGROUP_TARGETS?= _elb2_show_targetgroup_attributes _elb2_show_targetgroup_health _elb2_show_targetgroup_description
_elb2_show_targetgroup: $(_ELB2_SHOW_TARGETGROUP_TARGETS)

_elb2_show_targetgroup_attributes:
	@$(INFO) '$(ELB2_UI_LABEL)Showing attributes of target-group "$(ELB2_TARGETGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the target-group does not exist'; $(NORMAL)
	-$(AWS) elbv2 describe-target-group-attributes $(__ELB2_TARGET_GROUP_ARN) --query "Attributes[]"

_elb2_show_targetgroup_description:
	@$(INFO) '$(ELB2_UI_LABEL)Showing description of target-group "$(ELB2_TARGETGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the target-group does not exist'; $(NORMAL)
	-$(AWS) elbv2 describe-target-groups $(_X__ELB2_LOAD_BALANCER_ARNS__TARGETGROUP) $(__ELB2_NAMES__TARGETGROUP) $(_X__ELB2_TARGET_GROUP_ARNS) --query "TargetGroups[]"

_elb2_show_targetgroup_health:
	@$(INFO) '$(ELB2_UI_LABEL)Showing health of target-group "$(ELB2_TARGETGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the target-group does not exist'; $(NORMAL)
	@$(WARN) 'This operation MUST return at least one healthy target'; $(NORMAL)
	-$(AWS) elbv2 describe-target-health $(__ELB2_TARGET_GROUP_ARN) $(__ELB2_TARGETS) --query "TargetHealthDescriptions[]$(_ELB2_SHOW_TARGETGROUP_HEALTH_FIELDS)"

_elb2_watch_targetgroups:
	@$(INFO) '$(ELB2_UI_LABEL)Watching ALL target-groups ...'; $(NORMAL)

_elb2_watch_targetgroups_set:
	@$(INFO) '$(ELB2_UI_LABEL)Watching target-groups-set "$(ELB2_TARGETGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Target-groups are grouped based on the provided load-balancer ARN, target-group ARNs/names, and query-filter'; $(NORMAL)
