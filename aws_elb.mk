_AWS_ELB_MK_VERSION= 0.99.6

# ELB_CURL?=
# ELB_REGION_ID?= us-east-1

# Derived parameters
ELB_CURL?= $(CURL)
ELB_REGION_ID?= $(AWS_REGION_ID)

# Option parameters

# UI parameters
ELB_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _elb_view_framework_macros
_elb_view_framework_macros ::
	@echo 'AWS::ElasticLoadBalancer ($(_AWS_ELB_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _elb_view_framework_parameters
_elb_view_framework_parameters ::
	@echo 'AWS::ElasticLoadBalancer ($(_AWS_ELB_MK_VERSION)) parameters:'
	@echo '    ELB_REGION_ID=$(ELB_REGION_ID)'
	@echo

_aws_view_framework_targets :: _elb_view_framework_targets
_elb_view_framework_targets ::
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
