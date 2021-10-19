_AWS_CODESTAR_TEAMMEMBER_MK_VERSION= $(_AWS_CODESTAR_MK_VERSION)

# CSR_TEAMMEMBER_NAME?= "Emmanuel Mayssat"
# CSR_TEAMMEMBER_PROJECT_ID?=
# CSR_TEAMMEMBER_PROJECTROLE?= Viewer
# CSR_TEAMMEMBER_REMOTE_ACCESS?= false
# CSR_TEAMMEMBER_USER_ARN?= arn:aws:iam::123456789012:user/EmmanuelMayssat

# Derived parameters
CSR_TEAMMEMBER_NAME?= $(IAM_USER_NAME)
CSR_TEAMMEMBER_PROJECT_ID?= $(CSR_PROJECT_ID)
CSR_TEAMMEMBER_USER_ARN?= $(IAM_USER_ARN)

# Options parameters
__CSR_PROJECT_ID_TEAMMEMBER= $(if $(CSR_TEAMMEMBER_PROJECT_ID), --project-id $(CSR_TEAMMEMBER_PROJECT_ID))
__CSR_PROJECT_ROLE= $(if $(CSR_TEAMMEMBER_PROJECTROLE), --project-role $(CSR_TEAMMEMBER_PROJECTROLE))
__CSR_REMOTE_ACCESS_ALLOWED= $(if $(filter true, $(CSR_TEAMMEMBER_REMOTE_ACCESS)), --remote-access-allowed, --no-remote-access-allowed)
__CSR_USER_ARN_TEAMMEMBER= $(if $(CSR_TEAMMEMBER_USER_ARN), --user-arn $(CSR_TEAMMEMBER_USER_ARN))

# UI parameters
CSR_UI_VIEW_TEAMMEMBERS_FIELDS?=

#--- Utilities

#--- MACROS
_csr_get_userprofile_user_arn= $(call _csr_get_userprofile_user_arn_N, $(CSR_TEAMMEMBER_ARN))
_csr_get_userprofile_user_arn_N= $(shell $(AWS) codestar list-user-profiles --query "userProfiles[?displayName=='$(strip $(1))'].userArn" --output text)

#----------------------------------------------------------------------
# USAGE
#

_csr_view_framework_macros ::
	@echo 'AWS::CodeStaR::TeamMember ($(_AWS_CODESTAR_TEAMMEMBER_MK_VERSION)) macros:'
	@echo '    _csr_get_userprofile_user_arn_{|N}         - Get the user ARN associated with user-profile (Name)'
	@echo

_csr_view_framework_parameters ::
	@echo 'AWS::CodeStaR::TeamMember ($(_AWS_CODESTAR_TEAMMEMBER_MK_VERSION)) parameters:'
	@echo '    CSR_TEAMMEMBER_NAME=$(CSR_TEAMMEMBER_NAME)'
	@echo '    CSR_TEAMMEMBER_PROJECT_ID=$(CSR_TEAMMEMBER_PROJECT_ID)'
	@echo '    CSR_TEAMMEMBER_PROJECTROLE=$(CSR_TEAMMEMBER_PROJECTROLE)'
	@echo '    CSR_TEAMMEMBER_USER_ARN=$(CSR_TEAMMEMBER_USER_ARN)'
	@echo

_csr_view_framework_targets ::
	@echo 'AWS::CodeStaR::TeamMember ($(_AWS_CODESTAR_TEAMMEMBER_MK_VERSION)) targets:'
	@echo '    _csr_associate_teammember                    - Associate a team-member to a project'
	@echo '    _csr_disassociate_teammember                 - Disassociate a team-member from a project'
	@echo '    _csr_update_teammember                       - Update a team-member in a project'
	@echo '    _csr_view_teammembers                        - View team-members in a project'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csr_associate_teammember:
	@$(INFO) '$(AWS_UI_LABEL)Associating team-member "$(CSR_TEAMMEMBER_NAME)" ...'; $(NORMAL)
	$(AWS) codestar associate-team-member $(__CSR_PROJECT_ID_TEAMMEMBER) $(__CSR_PROJECT_ROLE) $(__CSR_REMOTE_ACCESS_ALLOWED) $(__CSR_USER_ARN_TEAMMEMBER)

_csr_disassociate_teammember:
	@$(INFO) '$(AWS_UI_LABEL)Disassociating team-member "$(CSR_TEAMMEMBER_NAME)" ...'; $(NORMAL)
	$(AWS) codestar disassociate-team-member $(__CSR_PROJECT_ID_TEAMMEMBER) $(__CSR_USER_ARN_TEAMMEMBER)

_csr_update_teammember:
	@$(INFO) '$(AWS_UI_LABEL)Updating team-member "$(CSR_TEAMMEMBER_NAME)" ...'; $(NORMAL)
	$(AWS) codestar update-team-member $(__CSR_PROJECT_ID_TEAMMEMBER) $(__CSR_PROJECT_ROLE) $(__CSR_REMOTE_ACCESS_ALLOWED) $(__CSR_USER_ARN_TEAMMEMBER)

_csr_view_teammembers: 
	@$(INFO) '$(AWS_UI_LABEL)Viewing team-members of project "$(CSR_TEAMMEMBER_PROJECT_ID)" ...'; $(NORMAL)
	$(AWS) codestar list-team-members $(__CSR_PROJECT_ID_TEAMMEMBER) --query "teamMembers[]$(CSR_UI_VIEW_TEAMMEMBERS_FIELDS)"
