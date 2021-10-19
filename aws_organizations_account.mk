_AWS_ORGANIZATIONS_ACCOUNT_MK_VERSION= $(_AWS_ORGANIZATIONS_MK_VERSION)

OZS_ACCOUNT_BILLING_ACCESS?= true
# OZS_ACCOUNT_EMAIL?= susan@example.com
# OZS_ACCOUNT_ID?= 123456789012
# OZS_ACCOUNT_NAME?= "Production Account"
OZS_ACCOUNT_ROLE_NAME?= OrganizationAccountAccessRole

# Derived parameters 
OZS_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)

# Option parameters
__OZS_ACCOUNT_EMAIL= $(if $(OZS_ACCOUNT_EMAIL), --email $(OZS_ACCOUNT_EMAIL))
__OZS_ACCOUNT_ID= $(if $(OZS_ACCOUNT_ID), --account-id $(OZS_ACCOUNT_ID))
__OZS_ACCOUNT_NAME= $(if $(OZS_ACCOUNT_NAME), --account-name $(OZS_ACCOUNT_NAME))
__OZS_IAM_USER_ACCESS_TO_BILLING= $(if $(filter false, $(OZS_OZS_ACCOUNT_BILLING_ACCESS)), --iam-user-access-to-billing DENY, --iam-user-access-to-billing ALLOW)
__OZS_ROLE_NAME= $(if $(OZS_ACCOUNT_ROLE_NAME), --role-name $(OZS_ACCOUNT_ROLE_NAME))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ozs_view_framework_macros ::
	@#echo 'AWS::OrganiZationS::Account ($(_AWS_ORGANIZATIONS_ACCOUNT_MK_VERSION)) targets:'
	@#echo

_ozs_view_framework_parameters ::
	@echo 'AWS::OrganiZationS::Account ($(_AWS_ORGANIZATIONS_ACCOUNT_MK_VERSION)) parameters:'
	@echo '    OZS_ACCOUNT_BILLING_ACCESS=$(OZS_ACCOUNT_BILLING_ACCESS)'
	@echo '    OZS_ACCOUNT_EMAIL=$(OZS_ACCOUNT_EMAIL)'
	@echo '    OZS_ACCOUNT_ID=$(OZS_ACCOUNT_ID)'
	@echo '    OZS_ACCOUNT_NAME=$(OZS_ACCOUNT_NAME)'
	@echo '    OZS_ACCOUNT_ROLE_NAME=$(OZS_ACCOUNT_ROLE_NAME)'
	@echo

_ozs_view_framework_targets ::
	@echo 'AWS::OrganiZationS::Account ($(_AWS_ORGANIZATIONS_ACCOUNT_MK_VERSION)) targets:'
	@echo '    _ozs_create_account             - Create a new account in the organization'
	@echo '    _ozs_delete_account             - Delete an existing account'
	@echo '    _ozs_show_account               - Show details of a linked account'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_ozs_create_account:
	@$(INFO) '$(AWS_LABEL)Creating new linked account "$(OZS_ACCOUNT_NAME)" ...'; $(NORMAL)
	$(AWS) organizations create-account $(__OZS_ACOUNT_NAME) $(__OZS_EMAIL) $(__OZS_IAM_USER_ACCESS_TO_BILLING) $(__OZS_ROLE_NAME)

_ozs_delete_account:
	@$(INFO) '$(AWS_LABEL)Deleting an existing linked account "$(OZS_ACCOUNT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This oporeation cannot be executed through the API'; $(NORMAL)

_ozs_show_account:
	@$(INFO) '$(AWS_LABEL)Showing linked account "$(OZS_ACCOUNT_NAME)" ...'; $(NORMAL)
	$(AWS) organizations describe-account $(__OZS_ACOUNT_NAME) $(__OZS_EMAIL) $(__OZS_IAM_USER_ACCESS_TO_BILLING) $(__OZS_ROLE_NAME)

