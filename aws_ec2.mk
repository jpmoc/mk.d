_AWS_EC2_MK_VERSION= 0.99.0

# EC2_INPUTS_DIRPATH?= ./in/

# Derived parameters
EC2_INPUTS_DIRPATH?= $(AWS_INPUTS_DIRPATH)

# Option parameters

# UI parameters
EC2_UI_LABEL?= $(AWS_UI_LABEL)
EC2_UI_VIEW_ACCOUNT_LIMITS_FIELDS?= .[AttributeName,AttributeValues[0].AttributeValue]

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _ec2_view_framework_macros
_ec2_view_framework_macros ::
	@echo 'AWS::EC2 ($(_AWS_EC2_MK_VERSION)) macros:'
	@echo 

_view_framework_parameters :: _ec2_view_framework_parameters
_ec2_view_framework_parameters ::
	@echo 'AWS::EC2 ($(_AWS_EC2_MK_VERSION)) parameters:'
	@echo '    EC2_INPUTS_DIRPATH=$(EC2_INPUTS_DIRPATH)'
	@echo 

_view_framework_targets :: _ec2_view_framework_targets
_ec2_view_framework_targets ::
	@echo 'AWS::EC2 ($(_AWS_EC2_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/aws_ec2_availabilityzone.mk
-include $(MK_DIR)/aws_ec2_image.mk
-include $(MK_DIR)/aws_ec2_instance.mk
-include $(MK_DIR)/aws_ec2_keypair.mk
-include $(MK_DIR)/aws_ec2_natgateway.mk
-include $(MK_DIR)/aws_ec2_networkinterface.mk
-include $(MK_DIR)/aws_ec2_securitygroup.mk
-include $(MK_DIR)/aws_ec2_securitygroupegress.mk
-include $(MK_DIR)/aws_ec2_securitygroupingress.mk
-include $(MK_DIR)/aws_ec2_snapshot.mk
-include $(MK_DIR)/aws_ec2_subnet.mk
-include $(MK_DIR)/aws_ec2_vpc.mk
-include $(MK_DIR)/aws_ec2_vpcendpoint.mk
-include $(MK_DIR)/aws_ec2_vpcendpointservice.mk
-include $(MK_DIR)/aws_ec2_vpcpeering.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aws_view_account_limits :: _ec2_view_account_limits
_ec2_view_account_limits:
	@$(INFO) '$(EC2_UI_LABEL)Viewing EC2-service limits in current region ...'; $(NORMAL)
	@$(WARN) 'For more detailed limits see the support/trusted-advisor API'; $(NORMAL)
	$(AWS) ec2 describe-account-attributes --query "AccountAttributes[]$(EC2_UI_VIEW_ACCOUNT_LIMITS_FIELDS)"
