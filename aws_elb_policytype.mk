_AWS_ELB_POLICYTYPE_MK_VERSION= $(_AWS_ELB_MK_VERSION)

# ELB_POLICYTYPE_NAME?=
# ELB_POLICYTYPES_NAMES?=
# ELB_POLICYTYPES_SET_NAME?=

# Derived parameters
ELB_POLICYTYPES_NAMES?= $(ELB_POLICYTYPE_NAME)

# Options
__ELB_POLICY_TYPE_NAMES__POLICYTYPE= $(if $(ELB_POLICYTYPE_NAME),--policy-type-names $(ELB_POLICYTYPE_NAME))
__ELB_POLICY_TYPE_NAMES__POLICYTYPES= $(if $(ELB_POLICYTYPES_NAMES),--policy-type-names $(ELB_POLICYTYPES_NAMES))

# Customizations
_ELB_LIST_POLICYTYPES_FIELDS?= .{PolicyTypeName:PolicyTypeName,description:Description}
_ELB_LIST_POLICYTYPES_SET_FIELDS?= $(_ELB_LIST_POLICYTYPES_FIELDS)
_ELB_LIST_POLICYTYPES_SET_QUERYFILTER?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_elb_list_macros ::
	@#echo 'AWS::ElasticLoadBalancer::PolicyType ($(_AWS_ELB_POLICYTYPE_MK_VERSION)) macros:'
	@#echo

_elb_list_parameters ::
	@echo 'AWS::ElasticLoadBalancer::PolicyType ($(_AWS_ELB_POLICYTYPE_MK_VERSION)) parameters:'
	@echo '    ELB_POLICYTYPE_NAME=$(ELB_POLICYTYPE_NAME)'
	@echo '    ELB_POLICYTYPES_NAMES=$(ELB_POLICYTYPE_NAMES)'
	@echo '    ELB_POLICYTYPES_SET_NAME=$(ELB_POLICYTYPES_SET_NAME)'
	@echo

_elb_list_targets ::
	@echo 'AWS::ElasticLoadBalancer::PolicyType ($(_AWS_ELB_POLICYTYPE_MK_VERSION)) targets:'
	@#echo '    _elb_create_policytype                           - Create a policy-type'
	@#echo '    _elb_delete_policytype                           - Delete an existing policy-type'
	@echo '    _elb_list_policytypes                            - List all policy-types'
	@echo '    _elb_list_policytypes_set                        - List a set of policy-types'
	@echo '    _elb_show_policytype                             - Show everything related to a policy-type'
	@echo '    _elb_show_policytype_description                 - Show description of a policy-type'
	@#echo '    _elb_watch_policytypes                           - Watch all policy-types'
	@#echo '    _elb_watch_policytypes_set                       - Watch a set of policy-types'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_elb_create_policytype:
	@$(INFO) '$(ELB_UI_LABEL)Creating policy-type "$(ELB_POLICYTYPE_NAME)" ...'; $(NORMAL)

_elb_delete_policytype:
	@$(INFO) '$(ELB_UI_LABEL)Deleting policy-type "$(ELB_POLICYTYPE_NAME)" ...'; $(NORMAL)

_elb_list_policytypes:
	@$(INFO) '$(ELB_UI_LABEL)Listing ALL policy-types ...'; $(NORMAL)
	$(AWS) elb describe-load-balancer-policy-types $(_X__ELB_POLICY_TYPE_NAMES__POLICYTYPES) --query "PolicyTypeDescriptions[]$(_ELB_LIST_POLICYTYPES_FIELDS)"

_elb_list_policytypes_set:
	@$(INFO) '$(ELB_UI_LABEL)Listing policy-types-set "$(ELB_POLICYTYPES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Policy-types are grouped based on the provided names and query-filter'; $(NORMAL)
	$(AWS) elb describe-load-balancer-policy-types $(__ELB_POLICY_TYPE_NAMES__POLICYTYPES) --query "PolicyTypeDescriptions[$(_ELB_LIST_POLICYTYPES_SET_QUERYFILTER)]$(_ELB_LIST_POLICYTYPES_SET_FIELDS)"

_ELB_SHOW_POLICYTYPE_TARGETS?= _elb_show_policytype_description
_elb_show_policytype: $(_ELB_SHOW_POLICYTYPE_TARGETS)

_elb_show_policytype_description:
	@$(INFO) '$(ELB_UI_LABEL)Showing description of load-balancer "$(ELB_POLICYTYPE_NAME)" ...'; $(NORMAL)
	$(AWS) elb describe-load-balancer-policy-types $(__ELB_POLICY_TYPE_NAMES__POLICYTYPE) --query "PolicyTypeDescriptions[]"

_elb_watch_policytypes:
	@$(INFO) '$(ELB_UI_LABEL)Watching ALL policy-types ...'; $(NORMAL)

_elb_watch_policytypes_set:
	@$(INFO) '$(ELB_UI_LABEL)Watching policy-types-set "$(ELB_POLICYTYPES_SET_NAME)" ...'; $(NORMAL)
