_AWS_ELBV2_RULE_MK_VERSION= $(_AWS_ELBV2_MK_VERSION)

# ELB2_RULE_ARN?=
# ELB2_RULE_NAME?=
# ELB2_RULE_NAME_UID?= a26ba45387e23467
# ELB2_RULE_LISTENER_ARN?=
# ELB2_RULE_LISTENER_NAME?= my-listener
# ELB2_RULE_LISTENER_NAMEUID?= 0a2287fed599aa02
# ELB2_RULE_LOADBALANCER_NAME?= my-load-balancer
# ELB2_RULE_LOADBALANCER_NAMEUID?= 2ed2ef62e75d7b07
# ELB2_RULES_ARNS?=
# ELB2_RULES_LISTENER_ARN?=
# ELB2_RULES_LISTENER_NAME?= my-listener
## ELB2_RULES_LISTENER_NAMEUID?=
## ELB2_RULES_LOADBALANCER_NAME?= my-load-balancer
## ELB2_RULES_LOADBALANCER_NAMEUID?= 2ed2ef62e75d7b07
# ELB2_RULES_SET_NAME?=

# Derived parameters
ELB2_RULE_ARN?= arn:aws:elasticloadbalancing:$(ELB2_REGION_ID):$(ELB2_ACCOUNT_ID):listener-rule/app/$(ELB_RULE_LOADBALANCER_NAME)/2ed2ef62e75d7b07/0a2287fed599aa02/a26ba45387e23467
ELB2_RULE_LISTENER_ARN?= $(ELB2_LISTENER_ARN)
ELB2_RULE_LISTENER_NAME?= $(ELB2_LISTENER_NAME)
ELB2_RULE_LISTENER_NAMEUID?= $(ELB2_LISTENER_NAME_UID)
ELB2_RULES_ARNS?= $(ELB2_RULE_ARN)
ELB2_RULES_LISTENER_ARN?= $(ELB2_RULE_LISTENER_ARN)
ELB2_RULES_LISTENER_NAME?= $(ELB2_RULE_LISTENER_NAME)
# ELB2_RULES_LISTENER_NAMEUID?= $(ELB2_RULE_LISTENER_NAMEUID)
# ELB2_RULES_LOADBALANCER_NAME?= $(ELB2_RULE_LOADBALANCER_NAME)
# ELB2_RULES_LOADBALANCER_NAMEUID?= $(ELB2_RULE_LOADBALANCER_NAMEUID)
ELB2_RULES_SET_NAME?= rules@$(ELB2_RULES_LISTENER_NAME)

# Options
__ELB2_LISTENER_ARN__RULE= $(if $(ELB2_RULE_LISTENER_ARN),--listener-arn $(ELB2_RULE_LISTENER_ARN))
__ELB2_LISTENER_ARN__RULES= $(if $(ELB2_RULES_LISTENER_ARN),--listener-arn $(ELB2_RULES_LISTENER_ARN))
__ELB2_RULE_ARNS__RULE= $(if $(ELB2_RULE_ARN),--rule-arns $(ELB2_RULE_ARN)) 
__ELB2_RULE_ARNS__RULES= $(if $(ELB2_RULES_ARNS),--rule-arns $(ELB2_RULES_ARNS)) 

# Customizations
_ELB2_LIST_RULES_FIELDS?= .{RuleArn:RuleArn,priority:Priority,isDefault:IsDefault}
_ELB2_LIST_RULES_SET_FIELDS?= $(ELB2_UI_LIST_RULES_FIELDS)
_ELB2_LIST_RULES_SET_QUERYFILTER?=

#--- MACROS
_elb2_get_rule_arn=

#----------------------------------------------------------------------
# USAGE
#

_elb2_list_macros ::
	@#echo 'AWS::ElasticLoadBalancerV2::Rule ($(_AWS_ELBV2_RULE_MK_VERSION)) macros:'
	@#echo '    _elb_get_rule_arn                           - To implement'
	@#echo

_elb2_list_parameters ::
	@echo 'AWS::ElasticLoadBalancerV2::Rule($(_AWS_ELBV2_RULE_MK_VERSION)) parameters:'
	@echo '    ELB2_RULE_ARN=$(ELB2_RULE_ARN)'
	@echo '    ELB2_RULE_NAME=$(ELB2_RULE_NAME)'
	@echo '    ELB2_RULE_NAME_UID=$(ELB2_RULE_NAME_UID)'
	@echo '    ELB2_RULE_LISTENER_ARN=$(ELB2_RULE_LISTENER_ARN)'
	@echo '    ELB2_RULE_LISTENER_NAME=$(ELB2_RULE_LISTENER_NAME)'
	@echo '    ELB2_RULE_LISTENER_NAMEUID=$(ELB2_RULE_LISTENER_NAMEUID)'
	@echo '    ELB2_RULE_LOADBALANCER_NAME=$(ELB2_RULE_LOADBALANCER_NAME)'
	@echo '    ELB2_RULE_LOADBALACNER_NAMEUID=$(ELB2_RULE_LOADBALANCER_NAMEUID)'
	@echo '    ELB2_RULES_ARNS=$(ELB2_RULES_ARNS)'
	@echo '    ELB2_RULES_LISTENER_ARN=$(ELB2_RULES_LISTENER_ARN)'
	@echo '    ELB2_RULES_LISTENER_NAME=$(ELB2_RULES_LISTENER_NAME)'
	@#echo '    ELB2_RULES_LISTENER_NAMEUID=$(ELB2_RULES_LISTENER_NAMEUID)'
	@#echo '    ELB2_RULES_LOADBALANCER_NAME=$(ELB2_RULES_LOADBALANCER_NAME)'
	@#echo '    ELB2_RULES_LOADBALACNER_NAMEUID=$(ELB2_RULES_LOADBALANCER_NAMEUID)'
	@echo '    ELB2_RULES_SET_NAME=$(ELB2_RULES_SET_NAME)'
	@echo

_elb2_list_targets ::
	@echo 'AWS::ElasticLoadBalancerV2::Rule($(_AWS_ELBV2_RULE_MK_VERSION)) targets:'
	@echo '    _elb2_create_rule                           - Create a rule'
	@echo '    _elb2_delete_rule                           - Delete an rule'
	@echo '    _elb2_show_rule                             - Show everything related to a rule'
	@echo '    _elb2_show_rule_description                 - Show description of a rule'
	@echo '    _elb2_list_rules                            - List all rules'
	@echo '    _elb2_list_rules_set                        - List a set of rules'
	@echo '    _elb2_watch_rules                           - Watch all rules'
	@echo '    _elb2_watch_rules_set                       - Watch a set of rules'
	@echo 

#----------------------------------------------------------------------
# PRIVATE RULES
#

#----------------------------------------------------------------------
# PUBLIC RULES
#

_elb2_create_rule:
	@$(INFO) '$(ELB2_UI_LABEL)Creating rule "$(ELB2_RULE_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 create-rule $(__ELB2_RULE_GROUP_ARN__RULE) $(__ELB2_RULES__RULE)

_elb2_delete_rule:
	@$(INFO) '$(ELB2_UI_LABEL)Deleting rule "$(ELB2_RULE_NAME)" ...'; $(NORMAL)
	$(AWS) elbv2 delete-rule $(__ELB2_RULE_GROUP_ARN__RULE) $(__ELB2_RULES__RULE)

_elb2_list_rules:
	@$(INFO) '$(ELB2_UI_LABEL)Listing ALL listener-rules ...'; $(NORMAL)
	@$(WARN) 'Rules are grouped based on the provided listener ARN'; $(NORMAL)
	$(AWS) elbv2 describe-rules $(__ELB2_LISTENER_ARN__RULES) $(_X_ELB2_RULE_ARNS__RULES) --query "Rules[]$(ELB2_UI_LIST_RULES_FIELDS)"

_elb2_list_rules_set:
	@$(INFO) '$(ELB2_UI_LABEL)Listing rules-set "$(ELB2_RULES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Rules are grouped based on the provided listener ARN, rule ARNs, and query-filter'; $(NORMAL)
	$(AWS) elbv2 describe-rules $(__ELB2_LISTENER_ARN__RULES) $(__ELB2_RULE_ARNS__RULES) # --query "Rules[$(ELB2_UI_LIST_RULES_SET_QUERYFILTER)]$(ELB2_UI_LIST_RULES_SET_FIELDS)"

_ELB2_SHOW_RULE_TARGETS?= _elb2_show_rule_targetgroup _elb2_show_rule_description
_elb2_show_rule: $(_ELB2_SHOW_RULE_TARGETS)

_elb2_show_rule_description:
	@$(INFO) '$(ELB2_UI_LABEL)Showing description of rule "$(ELB2_RULE_NAME)" ...'; $(NORMAL)
	-$(AWS) elbv2 describe-rules $(_X__ELB2_LISTENER_ARN__RULE) $(__ELB2_RULE_ARNS__RULE) --query "Rules[]"

_elb2_show_rule_targetgroup:
	@$(INFO) '$(ELB2_UI_LABEL)Showing targetgroup of rule "$(ELB2_RULE_NAME)" ...'; $(NORMAL)
	# To be implemented

_elb2_watch_rules:
	@$(INFO) '$(ELB2_UI_LABEL)Watching ALL rules ...'; $(NORMAL)

_elb2_watch_rules_set:
	@$(INFO) '$(ELB2_UI_LABEL)Watching rules-set "$(ELB2_RULES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Rules are grouped based on the provided listener ARN, rule ARNs, and query-filter'; $(NORMAL)
