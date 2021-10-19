_AWS_ELBV2_MK_VERSION= 0.99.6

# ELB2_ACCOUNT_ID?= 123456789012
# ELB2_CURL?= curl -v
# ELB2_REGION_ID?= us-east-1

# Derived parameters
ELB2_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
ELB2_CURL?= $(CURL)
ELB2_REGION_ID?= $(AWS_REGION_ID)

# Option parameters

# UI parameters
ELB2_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _elb2_view_framework_macros
_elb2_view_framework_macros ::
	@echo 'AWS::ElasticLoadBalancerV2 ($(_AWS_ELBV2_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _elb2_view_framework_parameters
_elb2_view_framework_parameters ::
	@echo 'AWS::ElasticLoadBalancerV2 ($(_AWS_ELBV2_MK_VERSION)) parameters:'
	@echo '    ELB2_ACCOUNT_ID=$(ELB2_ACCOUNT_ID)'
	@echo '    ELB2_REGION_ID=$(ELB2_REGION_ID)'
	@echo

_aws_view_framework_targets :: _elb2_view_framework_targets
_elb2_view_framework_targets ::
	@echo 'AWS::ElasticLoadBalancerV2 ($(_AWS_ELBV2_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_elbv2_listener.mk
-include $(MK_DIR)/aws_elbv2_loadbalancer.mk
-include $(MK_DIR)/aws_elbv2_rule.mk
-include $(MK_DIR)/aws_elbv2_targetgroup.mk
-include $(MK_DIR)/aws_elbv2_target.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
