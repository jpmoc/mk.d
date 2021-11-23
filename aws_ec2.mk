_AWS_EC2_MK_VERSION= 0.99.0

# EC2_INPUTS_DIRPATH?= ./in/
# EC2_UI_LABEL?= [ec2] #

# Derived parameters
EC2_INPUTS_DIRPATH?= $(AWS_INPUTS_DIRPATH)
EC2_UI_LABEL?= $(AWS_UI_LABEL)

# Options

# Customizations
_EC2_VIEW_LIMITS_FIELDS?= .[AttributeName,AttributeValues[0].AttributeValue]

# Utilities

# Macros

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _ec2_list_macros
_ec2_list_macros ::
	@#echo 'AWS::EC2 ($(_AWS_EC2_MK_VERSION)) macros:'
	@#echo 

_list_parameters :: _ec2_list_parameters
_ec2_list_parameters ::
	@echo 'AWS::EC2 ($(_AWS_EC2_MK_VERSION)) parameters:'
	@echo '    EC2_INPUTS_DIRPATH=$(EC2_INPUTS_DIRPATH)'
	@echo '    EC2_UI_LABEL=$(EC2_UI_LABEL)'
	@echo 

_list_targets :: _ec2_list_targets
_ec2_list_targets ::
	@echo 'AWS::EC2 ($(_AWS_EC2_MK_VERSION)) targets:'
	@echo '    _ec2_view_limits               - View the EC2-limits'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIRPATH?= ./
-include $(MK_DIRPATH)aws_ec2_availabilityzone.mk
-include $(MK_DIRPATH)aws_ec2_image.mk
-include $(MK_DIRPATH)aws_ec2_instance.mk
-include $(MK_DIRPATH)aws_ec2_keypair.mk
-include $(MK_DIRPATH)aws_ec2_natgateway.mk
-include $(MK_DIRPATH)aws_ec2_networkinterface.mk
-include $(MK_DIRPATH)aws_ec2_securitygroup.mk
-include $(MK_DIRPATH)aws_ec2_securitygroupegress.mk
-include $(MK_DIRPATH)aws_ec2_securitygroupingress.mk
-include $(MK_DIRPATH)aws_ec2_snapshot.mk
-include $(MK_DIRPATH)aws_ec2_subnet.mk
-include $(MK_DIRPATH)aws_ec2_vpc.mk
-include $(MK_DIRPATH)aws_ec2_vpcendpoint.mk
-include $(MK_DIRPATH)aws_ec2_vpcendpointservice.mk
-include $(MK_DIRPATH)aws_ec2_vpcpeering.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_view_limits:
	@$(INFO) '$(EC2_UI_LABEL)Viewing ALL EC2-limits ...'; $(NORMAL)
	@$(WARN) 'This operation returns account and region limits'; $(NORMAL)
	@$(WARN) 'For more detailed limits see the support/trusted-advisor API'; $(NORMAL)
	$(AWS) ec2 describe-account-attributes --query "AccountAttributes[]$(_EC2_VIEW_LIMITS_FIELDS)"
