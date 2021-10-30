_AWS_IAM_ACCOUNTALIAS_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_ACCOUNTALIAS_NAME?= my-account
# IAM_ACCOUNTALIAS_AWSACCOUNT_ID?= 123456789012

# Derived parameters
IAM_ACCOUNTALIAS_AWSACOUNT_ID?= $(IAM_AWSACCOUNT_ID)

# Option parameters
__IAM_ACCOUNT_ALIAS= $(if $(IAM_ACCOUNTALIAS_NAME),--account-alias $(AWS_ACCOUNTALIAS_NAME))


#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_iam_view_framework_macros ::
	@echo 'AWS::IAM::AccountAlias ($(_AWS_IAM_ACCOUNTALIAS_MK_VERSION)) macros:'
	@echo

_iam_view_framework_parameters ::
	@echo 'AWS::IAM::AccountAlias ($(_AWS_IAM_ACCOUNTALIAS_MK_VERSION)) parameters:'
	@echo '    IAM_ACCOUNTALIAS_NAME=$(IAM_ACCOUNTALIAS_NAME)'
	@echo '    IAM_ACCOUNTALIAS_AWSACCOUNT_ID=$(IAM_ACCOUTNALIAS_AWSACCOUNT_ID)'
	@echo

_iam_view_framework_targets ::
	@echo 'AWS::IAM::AccountAlias ($(_AWS_IAM_ACCOUNTALIAS_MK_VERSION)) targets:'
	@echo '    _iam_create_accountalias    - Create an alias to an AWS-account'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_aws_create_accountalias:
	@$(INFO) '$(IAM_UI_LABEL)Creating account-alias "$(IAM_ACCOUNTALIAS_NAME)" ...'; $(NORMAL)
	$(AWS) iam create-account-alias $(__IAM_ACCOUNT_ALIAS)
