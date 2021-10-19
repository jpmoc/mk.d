_AWS_IAM_ACCOUNT_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_

# Derived parameters
IAM_ACCOUNT_ALIAS?= $(AWS_ACCOUNT_ALIAS)

# Option parameters
__IAM_ACCOUNT_ALIAS= $(if $(IAM_ACCOUNT_ALIAS), --account-alias $(AWS_ACCOUNT_ALIAS))


#--- MACROS
_iam_get_group_arn=$(call _iam_get_group_arn_N, $(IAM_GROUP_NAME))
_iam_get_group_arn_N=$(shell $(AWS) ... )

#----------------------------------------------------------------------
# USAGE
#

_iam_view_framework_macros ::
	@echo 'AWS::IAM::Account ($(_AWS_IAM_ACCOUNT__MK_VERSION)) macros:'
	@echo '    _iam_get_group_arn_{|N}   - Get the ARN of a group'
	@echo

_iam_view_framework_parameters ::
	@echo 'AWS::IAM::Account ($(_AWS_IAM_ACCOUNT_MK_VERSION)) parameters:'
	@echo '    IAM_ACCOUNT_ALIAS=$(IAM_ACCOUNT_ALIAS)'
	@echo

_iam_view_framework_targets ::
	@echo 'AWS::IAM::Account ($(_AWS_IAM_ACCOUNT_MK_VERSION)) targets:'
	@echo '    _iam_create_account_alias    - Alias the account ID to an alias'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_aws_create_account_alias:
	@$(INFO) '$(IAM_UI_LABEL)Creating alias to account "$(AWS_ACCOUNT_ID)" ...'; $(NORMAL)
	$(AWS) iam create-account-alias $(__IAM_ACCOUNT_ALIAS)
