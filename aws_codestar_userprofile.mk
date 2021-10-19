_AWS_CODESTAR_USERPROFILE_MK_VERSION= $(_AWS_CODESTAR_MK_VERSION)

# CSR_USERPROFILE_NAME?= "Emmanuel Mayssat"
# CSR_USERPROFIEL_EMAIL?= emmanuel.mayssat@gmail.com
# CSR_USERPROFIEL_SSHPUBLICKEY?=
# CSR_USERPROFILE_USER_ARN?= arn:aws:iam:us-west-2:123456789012:user/EmmanuelMayssat

# Derived parameters
CSR_USERPROFILE_NAME?= $(IAM_USER_NAME)
CSR_USERPROFILE_USER_ARN?= $(IAM_USER_ARN)

# Options parameters
__CSR_DISPLAY_NAME= $(if $(CSR_USERPROFILE_NAME), --display-name $(CSR_USERPROFILE_NAME))
__CSR_EMAIL_ADDRESS= $(if $(CSR_USERPROFILE_EMAIL), --email-address $(CSR_USERPROFILE_EMAIL))
__CSR_SSH_PUBLIC_KEY= $(if $(CSR_USERPROFILE_SSHPUBLICKEY), --ssh-public-key $(CSR_USERPROFILE_SSHPUBLICKEY))
__CSR_USER_ARN= $(if $(CSR_USERPROFILE_USER_ARN), --user-arn $(CSR_USERPROFILE_USER_ARN))

# UI parameters
CSR_UI_VIEW_USERPROFILES_FIELDS?=

#--- Utilities

#--- MACROS
_csr_get_userprofile_user_arn= $(call _csr_get_userprofile_user_arn_N, $(CSR_USERPROFILE_ARN))
_csr_get_userprofile_user_arn_N= $(shell $(AWS) codestar list-user-profiles --query "userProfiles[?displayName=='$(strip $(1))'].userArn" --output text)

#----------------------------------------------------------------------
# USAGE
#

_csr_view_framework_macros ::
	@echo 'AWS::CodeStaR::UserProfile ($(_AWS_CODESTAR_USERPROFILE_MK_VERSION)) macros:'
	@echo '    _csr_get_userprofile_user_arn_{|N}         - Get the user ARN associated with user-profile (Name)'
	@echo

_csr_view_framework_parameters ::
	@echo 'AWS::CodeStaR::UserProfile ($(_AWS_CODESTAR_USERPROFILE_MK_VERSION)) parameters:'
	@echo '    CSR_USERPROFILE_NAME=$(CSR_USERPROFILE_NAME)'
	@echo '    CSR_USERPROFILE_EMAIL=$(CSR_USERPROFILE_EMAIL)'
	@echo '    CSR_USERPROFILE_SSHPUBLICKEY=$(CSR_USERPROFILE_SSHPUBLICKEY)'
	@echo '    CSR_USERPROFILE_USER_ARN=$(CSR_USERPROFILE_USER_ARN)'
	@echo

_csr_view_framework_targets ::
	@echo 'AWS::CodeStaR::UserProfile ($(_AWS_CODESTAR_USERPROFILE_MK_VERSION)) targets:'
	@echo '    _csr_create_userprofile                    - Create a new user-profile'
	@echo '    _csr_delete_userprofile                    - Delete an existing user-profile'
	@echo '    _csr_show_userprofile                      - Show details of a user-profile'
	@echo '    _csr_view_userprofiles                     - View existing user-profiles'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csr_create_userprofile:
	@$(INFO) '$(AWS_UI_LABEL)Creating a codestar user-profile "$(CSR_USERPROFILE_NAME)" ...'; $(NORMAL)
	$(AWS) codestar create-user-profile $(__CSR_DISPLAY_NAME) $(__CSR_EMAIL_ADDRESS) $(__CSR_SSH_PUBLIC_KEY) $(__CSR_USER_ARN)

_csr_delete_userprofile:
	@$(INFO) '$(AWS_UI_LABEL)Deleting a codestar user-profile "$(CSR_USERPROFILE_NAME)" ...'; $(NORMAL)
	$(AWS) codestar delete-user-profile $(__CSR_USER_ARN)

_csr_show_userprofile:
	@$(INFO) '$(AWS_UI_LABEL)Showing a codestar user-profile "$(CSR_USERPROFILE_NAME)" ...'; $(NORMAL)
	$(AWS) codestar describe-user-profile $(__CSR_USER_ARN)

_csr_view_userprofiles: 
	@$(INFO) '$(AWS_UI_LABEL)Viewing codestar user-profiles ...'; $(NORMAL)
	$(AWS) codestar list-user-profiles --query "userProfiles[]$(CSR_UI_VIEW_USERPROFILES_FIELDS)"
