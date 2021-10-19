_AWS_IAM_MK_VERSION= 0.99.0

# IAM_ACCOUNT_ID?=
# IAM_INPUTS_DIRPATH?= ./in/
# IAM_OUTPUTS_DIRPATH?= ./out/
# IAM_REGION_ID?= us-west-2

# Derived parameters
IAM_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
IAM_INPUTS_DIRPATH?= $(AWS_INPUTS_DIRPATH)
IAM_OUTPUTS_DIRPATH?= $(AWS_OUTPUTS_DIRPATH)
IAM_REGION_ID?= $(AWS_REGION_ID)

# Option parameters

# UI parameters
IAM_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _iam_view_framework_macros
_iam_view_framework_macros ::
	@#echo 'AWS::IAM ($(_AWS_IAM_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _iam_view_framework_parameters
_iam_view_framework_parameters ::
	@echo 'AWS::IAM ($(_AWS_IAM_MK_VERSION)) parameters:'
	@echo '    IAM_ACCOUNT_ID=$(IAM_ACCOUNT_ID)'
	@echo '    IAM_INPUTS_DIRPATH=$(IAM_INPUTS_DIRPATH)'
	@echo '    IAM_OUTPUTS_DIRPATH=$(IAM_OUTPUTS_DIRPATH)'
	@echo '    IAM_REGION_ID=$(IAM_REGION_ID)'
	@echo

_view_framework_targets :: _iam_view_framework_targets
_iam_view_framework_targets ::
	@echo 'AWS::IAM ($(_AWS_IAM_MK_VERSION)) targets:'
	@echo '    _iam_generate_credentialreport         - Generate a credential-report'
	@echo '    _iam_fetch_credentialreport            - Fetch the last generated credential-report'
	@echo '    _iam_show_password_policy    - Show password-policy'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

-include $(MK_DIR)/aws_iam_account.mk
-include $(MK_DIR)/aws_iam_accesskey.mk
-include $(MK_DIR)/aws_iam_certificate.mk
-include $(MK_DIR)/aws_iam_inlinepolicy.mk
-include $(MK_DIR)/aws_iam_instanceprofile.mk
-include $(MK_DIR)/aws_iam_group.mk
-include $(MK_DIR)/aws_iam_managedpolicy.mk
-include $(MK_DIR)/aws_iam_mfadevice.mk
-include $(MK_DIR)/aws_iam_password.mk
-include $(MK_DIR)/aws_iam_role.mk
-include $(MK_DIR)/aws_iam_sshpublickey.mk
-include $(MK_DIR)/aws_iam_user.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_iam_generate_credentialreport:
	@$(INFO) '$(IAM_UI_LABEL)Generating a credential-report ...'; $(NORMAL)
	@$(WARN) 'Once generated, fetch the report'; $(NORMAL)
	$(AWS) iam generate-credential-report

_iam_fetch_credentialreport:
	@$(INFO) '$(IAM_UI_LABEL)Fetching metadata of credential-report ...'; $(NORMAL)
	$(AWS) iam get-credential-report --query '{GeneratedTime:GeneratedTime,ReportFormat:ReportFormat}'
	@$(INFO) '$(IAM_UI_LABEL)Fetching content of credential report ...'; $(NORMAL)
	$(AWS) iam get-credential-report --query 'Content' --output text | base64 --decode
