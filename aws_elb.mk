_AWS_ELB_MK_VERSION= 0.99.6

# ELB_CURL?=
# ELB_REGION_ID?= us-east-1
# ELB_UI_LABEL?= [elb]

# Derived parameters
ELB_CURL?= $(CURL)
ELB_REGION_ID?= $(AWS_REGION_ID)
ELB_UI_LABEL?= $(AWS_UI_LABEL)

# Options

# Customizations

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_list_macros :: _elb_list_macros
_elb_list_macros ::
	@#echo 'AWS::ElasticLoadBalancer ($(_AWS_ELB_MK_VERSION)) macros:'
	@#echo

_aws_list_parameters :: _elb_list_parameters
_elb_list_parameters ::
	@echo 'AWS::ElasticLoadBalancer ($(_AWS_ELB_MK_VERSION)) parameters:'
	@echo '    ELB_REGION_ID=$(ELB_REGION_ID)'
	@echo '    ELB_UI_LABEL=$(ELB_UI_LABEL)'
	@echo

_aws_list_targets :: _elb_list_targets
_elb_list_targets ::
	@echo 'AWS::ElasticLoadBalancer ($(_AWS_ELB_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_elb_loadbalancer.mk
-include $(MK_DIR)/aws_elb_policy.mk
-include $(MK_DIR)/aws_elb_policytype.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
