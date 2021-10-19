_AWS_IAM_PASSWORD_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_PASSWORD_RESETREQUIRED_FLAG?= false
# IAM_PASSWORD_USER_NAME?=
# IAM_PASSWORD_STRING?= my-password
# IAM_PASSWORD_STRING_NEW?= my-password
# IAM_PASSWORD_STRING_OLD?= my-password

# Derived variables
IAM_PASSWORD_USER_NAME?= $(IAM_USER_NAME)
IAM_PASSWORD_STRING_NEW?= $(IAM_PASSWORD_STRING)
IAM_PASSWORD_STRING_OLD?= $(IAM_PASSWORD_STRING)

# Option variables
__IAM_NEW_PASSWORD= $(if $(IAM_PASSWORD_STRING_NEW),--new-password $(IAM_PASSWORD_STRING_NEW))
__IAM_OLD_PASSWORD= $(if $(IAM_PASSWORD_STRING_OLD),--old-password $(IAM_PASSWORD_STRING_OLD))
__IAM_PASSWORD= $(if $(IAM_PASSWORD_STRING),--password $(IAM_PASSWORD_STRING))
__IAM_PASSWORD_RESET_REQUIRED?= $(if $(filter false, $(IAM_PASSWORD_RESETREQUIRED_FLAG)),--no-password-reset-required,--password-reset-required)

# UI variables

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_iam_view_framework_macros ::
	@echo 'AWS::IAM::Password ($(_AWS_IAM_PASSWORD_MK_VERSION)) macros:'
	@echo

_iam_view_framework_parameters ::
	@echo 'AWS::IAM::Password ($(_AWS_IAM_PASSWORD_MK_VERSION)) parameters:'
	@echo '    IAM_PASSWORD_USER_NAME=$(IAM_PASSWORD_USER_NAME)'
	@echo '    IAM_PASSWORD_RESETREQUIRED_FLAG=$(IAM_PASSWORD_RESETREQUIRED_FLAG)'
	@echo '    IAM_PASSWORD_STRING=$(IAM_PASSWORD_STRING)'
	@echo '    IAM_PASSWORD_STRING_NEW=$(IAM_PASSWORD_STRING_NEW)'
	@echo '    IAM_PASSWORD_STRING_OLD=$(IAM_PASSWORD_STRING_OLD)'
	@echo

_iam_view_framework_targets ::
	@echo 'AWS::IAM::Password ($(_AWS_IAM_PASSWORD_MK_VERSION)) targets:'
	@echo '    _iam_reset_password              - Reset the password of a user'
	@echo '    _iam_set_password                - Set the default password for a user'
	@echo '    _iam_show_password               - Show everything related to a password'
	@echo '    _iam_show_password_description   - Show description of a password'
	@echo '    _iam_show_password_policy        - Show account password-policy of a password'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_iam_reset_password:
	@$(INFO) '$(IAM_UI_LABEL)Resetting password of user "$(IAM_PASSWORD_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam change-password $(__IAM_NEW_PASSWORD) $(__IAM_OLD_PASSWORD)

_iam_set_password:
	@$(INFO) '$(IAM_UI_LABEL)Setting password of user "$(IAM_PASSWORD_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam create-login-profile $(__IAM_PASSWORD) $(__IAM_PASSWORD_RESET_REQUIRED) $(__IAM_USER_NAME__PASSWORD)

_iam_show_password: _iam_show_password_policy _iam_show_password_description

_iam_show_password_description:

_iam_show_password_policy:
	@$(INFO) '$(IAM_UI_LABEL)Showing password-policy for this account ...'; $(NORMAL)
	@$(WARN) 'This operation returns the CURRENT policy'; $(NORMAL)
	$(AWS) iam get-account-password-policy
