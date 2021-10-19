_AWS_ORGANIZATIONS_MK_VERSION= 0.99.0

# IAM_GROUP_NAME?= my-group

# Derived parameters 

# Option parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _ozs_view_framework_macros
_ozs_view_framework_macros ::
	@#echo 'AWS::OrganiZationS ($(_AWS_ORGANIZATIONS_MK_VERSION)) targets:'
	@#echo

aws_view_framework_parameters :: _ozs_view_framework_parameters
_ozs_view_framework_parameters ::
	@#echo 'AWS::OrganiZationS ($(_AWS_ORGANIZATIONS_MK_VERSION)) parameters:'
	@#echo

_aws_view_framework_targets :: _ozs_view_framework_targets
_ozs_view_framework_targets ::
	@echo 'AWS::OrganiZationS ($(_AWS_ORGANIZATIONS_MK_VERSION)) targets:'
	@echo '    _ozs_leave_organization              - To leave an organization'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

MK_DIR?= .
-include $(MK_DIR)/aws_organizations_account.mk
-include $(MK_DIR)/aws_organizations_organization.mk
-include $(MK_DIR)/aws_organizations_policy.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_ozs_leave_organization:
	@$(INFO) '$(AWS_LABEL)Leaving organization ...'; $(NORMAL)
	@$(WARN) 'To leave the organization, the current account must be configured with a payment method'; $(NORMAL)
	$(AWS) organizations leave-organization
