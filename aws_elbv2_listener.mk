_AWS_ELBV2_LISTENER_MK_VERSION= $(_AWS_ELBV2_MK_VERSION)

# ELB2_LISTENER_ACTION_CONFIG?= Type=forward,TargetGroupArn=arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/my-targets/73e2d6bc24d8a067
# ELB2_LISTENER_ACTION_TARGETGROUPARN?=
# ELB2_LISTENER_ACTION_TYPE?= forward
# ELB2_LISTENER_ACTIONS_CONFIGS?= Type=forward,TargetGroupArn=arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/my-targets/73e2d6bc24d8a067 ...
# ELB2_LISTENER_ALPN_POLICY?=
# ELB2_LISTENER_ARN?=
# ELB2_LISTENER_CERTIFICATES_ARNS?= arn:aws:acm:us-west-2:123456789012:certificate/3dcb0a41-bd72-4774-9ad9-756919c40557 ...
# ELB2_LISTENER_LOADBALANCER_DNSNAME?=
# ELB2_LISTENER_LOADBALANCER_NAME?= my-load-balancer
# ELB2_LISTENER_NAME?= load-balancer:80
# ELB2_LISTENER_NAME_UID?= fdd171463f082e4f
# ELB2_LISTENER_PROTOCOL?= HTTP
# ELB2_LISTENER_PORT?= 80
# ELB2_LISTENER_SSL_POLICY?= ELBSecurityPolicy-2016-08
# ELB2_LISTENER_TAGS_KEYVALUES?= Key=string,Value=string ...
# ELB2_LISTENER_TARGETGROUP_ARN?=
# ELB2_LISTENERS_ARNS?=
# ELB2_LISTENERS_LOADBALANCER_ARN?= arn:aws:elasticloadbalancing:us-west-2:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188
# ELB2_LISTENERS_LOADBALANCER_NAME?= my-load-balancer
# ELB2_LISTENERS_SET_NAME?=

# Derived parameters
ELB2_LISTENER_ACTION_CONFIG?= Type=$(ELB2_LISTENER_ACTION_TYPE),TargetGroupArn=$(ELB2_LISTENER_TARGETGROUP_ARN)# More config
ELB2_LISTENER_ACTIONS_CONFIGS?= $(ELB2_LISTENER_ACTION_CONFIG)
ELB_LISTENER_ARN?= $(if $(ELB2_LISTENER_NAME_UID),$(ELB2_LISTENER_LOADBALANCER_ARN)/$(ELB2_LISTENER_NAME_UID))
ELB2_LISTENER_LOADBALANCER_ARN?= $(ELB2_LOADBALANCER_ARN)
ELB2_LISTENER_LOADBALANCER_DNSNAME?= $(ELB2_LOADBALANCER_DNSNAME)
ELB2_LISTENER_LOADBALANCER_NAME?= $(ELB2_LOADBALANCER_NAME)
ELB2_LISTENER_NAME?= $(ELB2_LISTENER_LOADBALANCER_NAME):$(ELB2_LISTENER_PORT)
ELB2_LISTENER_TARGETGROUP_ARN?= $(ELB2_TARGETGROUP_ARN)
ELB2_LISTENER_URL?= http://$(ELB2_LISTENER_LOADBALANCER_DNSNAME):$(ELB2_LISTENER_PORT)
ELB2_LISTENERS_ARNS?= $(ELB2_LISTENER_ARN)
ELB2_LISTENERS_LOADBALANCER_ARN?= $(ELB2_LISTENER_LOADBALANCER_ARN)
ELB2_LISTENERS_LOADBALANCER_NAME?= $(ELB2_LISTENER_LOADBALANCER_NAME)
ELB2_LISTENERS_SET_NAME?= listeners@$(ELB_LISTENERS_LOADBALANCER_NAME)

# Options
__ELB2_ALPN_POLICY= $(if $(ELB2_LISTENER_ALPN_POLICY),--alpn-policy $(ELB2_LISTENER_ALPN_POLICY))
__ELB2_CERTIFICATES= $(if $(ELB2_LISTENER_CERTIFICATES_ARNS),--certificates CertificateArn=$(ELB2_LISTENER_CERTIFICATES_ARNS))
__ELB2_DEFAULT_ACTIONS= $(if $(ELB2_LISTENER_ACTIONS_CONFIGS),--default-actions $(ELB2_LISTENER_ACTIONS_CONFIGS))
__ELB2_LISTENER_ARN= $(if $(ELB2_LISTENER_ARN),--listener-arn $(ELB2_LISTENER_ARN))
__ELB2_LISTENER_ARNS__LISTENER= $(if $(ELB2_LISTENER_ARN),--listener-arns $(ELB2_LISTENER_ARN))
__ELB2_LISTENER_ARNS__LISTENERS= $(if $(ELB2_LISTENERS_ARNS),--listener-arns $(ELB2_LISTENERS_ARNS))
__ELB2_LOAD_BALANCER_ARN__LISTENER= $(if $(ELB2_LISTENER_LOADBALANCER_ARN),--load-balancer-arn $(ELB2_LISTENER_LOADBALANCER_ARN))
__ELB2_LOAD_BALANCER_ARN__LISTENERS= $(if $(ELB2_LISTENERS_LOADBALANCER_ARN),--load-balancer-arn $(ELB2_LISTENERS_LOADBALANCER_ARN))
__ELB2_PORT__LISTENER= $(if $(ELB2_LISTENER_PORT),--port $(ELB2_LISTENER_PORT))
__ELB2_PROTOCOL__LISTENER= $(if $(ELB2_LISTENER_PROTOCOL),--protocol $(ELB2_LISTENER_PROTOCOL))
__ELB2_SSL_POLICY= $(if $(ELB2_LISTENER_SSL_POLICY),--ssl-policy $(ELB2_LISTENER_SSL_POLICY))
__ELB2_TAGS__LISTENER= $(if $(ELB2_LISTENER_TAGS_KEYVALUES),--tags $(ELB2_LISTENER_TAGS_KEYVALUES))
__ELB2_TARGET_GROUP_ARNS__LISTENER= $(if $(ELB2_LISTENER_TARGETGROUP_ARN),--target-group-arns $(ELB2_LISTENER_TARGETGROUP_ARN))

# Customizations
|_ELB2_CURL_LISTENER?= | head -10
_ELB2_LIST_LISTENERS_FIELDS?= .{ListenerArn:ListenerArn,port:Port,protocol:Protocol}
_ELB2_LIST_LISTENERS_SET_FIELDS?= $(_ELB2_LIST_LISTENERS_FIELDS)
_ELB2_LIST_LISTENERS_SET_QUERYFILTER?=

#--- MACROS

_elb2_get_listener_arn= $(call _elb2_get_listener_arn_A, $(ELB2_LISTENER_LOADBALANCER_ARN))
_elb2_get_listener_arn_A= $(call _elb2_get_listener_arn_AP, $(1), $(ELB2_LISTENER_PORT))
_elb2_get_listener_arn_AP= $(shell $(AWS) elbv2 describe-listeners --load-balancer-arn $(1) --query 'Listeners[?Port==`$(strip $(2))`].ListenerArn' --output text) 

#----------------------------------------------------------------------
# USAGE
#

_elb2_list_macros ::
	@echo 'AWS::ElasticLoadBalancerV2::Listener ($(_AWS_ELBV2_LISTENER_MK_VERSION)) macros:'
	@echo '    _elb2_get_listener_arn_{|N}                     - Get the ARN of a listener (Name)'
	@echo

_elb2_list_parameters ::
	@echo 'AWS::ElasticLoadBalancerV2::Listener ($(_AWS_ELBV2_LISTENER_MK_VERSION)) parameters:'
	@echo '    ELB2_LISTENER_ACTION_CONFIG=$(ELB2_LISTENER_ACTION_CONFIG)'
	@echo '    ELB2_LISTENER_ACTION_TARGETGROUPARN=$(ELB2_LISTENER_ACTION_TARGETGROUPARN)'
	@echo '    ELB2_LISTENER_ACTION_TYPE=$(ELB2_LISTENER_ACTION_TYPE)'
	@echo '    ELB2_LISTENER_ACTIONS_CONFIGS=$(ELB2_LISTENER_ACTIONS_CONFIGS)'
	@echo '    ELB2_LISTENER_ALPN_POLICY=$(ELB2_LISTENER_ALPN_POLICY)'
	@echo '    ELB2_LISTENER_ARN=$(ELB2_LISTENER_ARN)'
	@echo '    ELB2_LISTENER_CERTIFICATES=$(ELB2_LISTENER_CERTIFICATES)'
	@echo '    ELB2_LISTENER_LOADBALANCER_ARN=$(ELB2_LISTENER_LOADBALANCER_ARN)'
	@echo '    ELB2_LISTENER_LOADBALANCER_DNSNAME=$(ELB2_LISTENER_LOADBALANCER_DNSNAME)'
	@echo '    ELB2_LISTENER_LOADBALANCER_NAME=$(ELB2_LISTENER_LOADBALANCER_NAME)'
	@echo '    ELB2_LISTENER_NAME=$(ELB2_LISTENER_NAME)'
	@echo '    ELB2_LISTENER_NAME_UID=$(ELB2_LISTENER_NAME_UID)'
	@echo '    ELB2_LISTENER_PORT=$(ELB2_LISTENER_PORT)'
	@echo '    ELB2_LISTENER_PROTOCOL=$(ELB2_LISTENER_PROTOCOL)'
	@echo '    ELB2_LISTENER_SSL_POLICY=$(ELB2_LISTENER_SSL_POLICY)'
	@echo '    ELB2_LISTENER_TAGS_KEYVALUES=$(ELB2_LISTENER_TAGS_KEYVALUES)'
	@echo '    ELB2_LISTENER_TARGETGROUP_ARN=$(ELB2_LISTENER_TARGETGROUP_ARN)'
	@echo '    ELB2_LISTENER_URL=$(ELB2_LISTENER_URL)'
	@echo '    ELB2_LISTENERS_ARNS=$(ELB2_LISTENERS_ARNS)'
	@echo '    ELB2_LISTENERS_LOADBALANCER_ARN=$(ELB2_LISTENERS_LOADBALANCER_ARN)'
	@echo '    ELB2_LISTENERS_SET_NAME=$(ELB2_LISTENERS_SET_NAME)'
	@echo

_elb2_list_targets ::
	@echo 'AWS::ElasticLoadBalancerV2::Listener ($(_AWS_ELBV2_LISTENER_MK_VERSION)) targets:'
	@echo '    _elb2_create_listener                           - Create a listener'
	@echo '    _elb2_curl_listener                             - Curl a listener'
	@echo '    _elb2_delete_listener                           - Delete an existing listener'
	@echo '    _elb2_list_listeners                            - View all listeners of a load-balancer'
	@echo '    _elb2_list_listeners_set                        - View a set of listeners'
	@echo '    _elb2_show_listener                             - Show everything related to a listener'
	@echo '    _elb2_show_listener_certificate                 - Show certificate of a listener'
	@echo '    _elb2_show_listener_description                 - Show description of a listener'
	@echo '    _elb2_show_listener_rules                       - Show rules of a listener'
	@echo '    _elb2_show_listener_targetgroups                - Show the target-groups of a listener'
	@echo '    _elb2_watch_listeners                           - Watch all listeners of a load-balancer'
	@echo '    _elb2_watch_listeners_set                       - Watch a set of listeners'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_elb2_create_listener:
	@$(INFO) '$(ELB2_UI_LABEL)Creating listener "$(ELB2_LISTENER_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 create-listener $(strip $(__ELB2_ALPN_POLICY) $(__ELB2_CERTIFICATES) $(__ELB2_DEFAULT_ACTIONS) $(__ELB2_LOAD_BALANCER_ARN__LISTENER) $(__ELB2_PORT__LISTENER) $(__ELB2_PROTOCOL__LISTENER) $(__ELB2_SSL_POLICY) $(__ELB2_TAGS__LISTENER) ) --query 'Listeners'

_elb2_curl_listener:
	@$(INFO) '$(ELB2_UI_LABEL)Curling listener "$(ELB2_LISTENER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if there is no backend or no healthy backend'; $(NORMAL)
	@$(WARN) '503 Error ==> Do yo have a target backned?'; $(NORMAL)
	$(ELB2_CURL) $(ELB2_LISTENER_URL) $(|_ELB2_CURL_LISTENER)

_elb2_delete_listener:
	@$(INFO) '$(ELB2_UI_LABEL)Deleting listener "$(ELB2_LISTENER_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 delete-listener $(__ELB2_LISTENER_ARN)

_elb2_list_listeners:
	@$(INFO) '$(ELB2_UI_LABEL)Listing ALL listeners ...'; $(NORMAL)
	@$(WARN) 'Listeners are grouped based on the provided load-balancer ARN'; $(NORMAL)
	$(AWS) elbv2 describe-listeners $(__ELB2_LOAD_BALANCER_ARN__LISTENERS) $(_X__ELB2_LISTENER_ARNS__LISTENERS) --query "Listeners[]$(_ELB2_LIST_LISTENERS_FIELDS)"

_elb2_list_listeners_set:
	@$(INFO) '$(ELB2_UI_LABEL)Listing listeners-set "$(ELB2_LISTENERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Listeners are grouped based on the provided load-balancer ARN, and query-filter'; $(NORMAL)
	$(AWS) elbv2 describe-listeners $(__ELB2_LOAD_BALANCER_ARN__LISTENERS) $(__ELB2_LISTENER_ARNS__LISTENERS) --query "Listeners[$(_ELB2_LIST_LISTENERS_SET_QUERYFILTER)]$(_ELB2_LIST_LISTENERS_SET_FIELDS)"

_ELB2_SHOW_LISTENER_TARGETS?= _elb2_show_listener_certificate _elb2_show_listener_rules _elb2_show_listener_targetgroups _elb2_show_listener_description
_elb2_show_listener: $(_ELB2_SHOW_LISTENER_TARGETS)

_elb2_show_listener_certificate:
	@$(INFO) '$(ELB2_UI_LABEL)Showing certificates of listener "$(ELB2_LISTENER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Many certificates can attached to the same listener'; $(NORMAL)
	$(AWS) elbv2 describe-listener-certificates $(__ELB2_LISTENER_ARN) --query "Certificates[]"

_elb2_show_listener_description:
	@$(INFO) '$(ELB2_UI_LABEL)Showing description of listener "$(ELB2_LISTENER_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 describe-listeners $(_X__ELB2_LOAD_BALANCER_ARN__LISTENER) $(__ELB2_LISTENER_ARNS__LISTENER) --query "Listeners[]"

_elb2_show_listener_rules:
	@$(INFO) '$(ELB2_UI_LABEL)Showing rules of listener "$(ELB2_LISTENER_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 describe-rules $(__ELB2_LISTENER_ARN) $(_X__ELB2_RULE_ARNS__LISTENER) --query "Rules[]"

_elb2_show_listener_targetgroups:
	@$(INFO) '$(ELB2_UI_LABEL)Showing target-groups of listener "$(ELB2_LISTENER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Many target-groups can be used as backend for the same listener'; $(NORMAL)
	$(AWS) elbv2 describe-target-groups $(_X__ELB2_LOAD_BALANCER_ARN__LISTENER) $(__ELB2_TARGET_GROUP_ARNS__LISTENER) --query "TargetGroups[]"

_elb2_watch_listeners:
	@$(INFO) '$(ELB2_UI_LABEL)Watching ALL-LB listeners ...'; $(NORMAL)

_elb2_watch_listeners_set:
	@$(INFO) '$(ELB2_UI_LABEL)Watching listeners-set "$(ELB2_LISTENERS_SET_NAME)" ...'; $(NORMAL)
