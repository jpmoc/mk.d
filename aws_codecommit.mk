_AWS_CODECOMMIT_MK_VERSION= 0.99.6

CCT_PROFILE?= $(AWS_PROFILE)

# Derived parameters

# Option parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _cct_view_framework_macros
_cct_view_framework_macros ::
	@echo 'AWS::CodeCommiT ($(_AWS_CODECOMMIT_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _cct_view_framework_parameters
_cct_view_framework_parameters ::
	@echo 'AWS::CodeCommiT ($(_AWS_CODECOMMIT_MK_VERSION)) parameters:'
	@echo '    CCT_PROFILE=$(CCT_PROFILE)'
	@echo

_aws_view_framework_targets :: _cct_view_framework_targets
_cct_view_framework_targets ::
	@echo 'AWS::CodeCommiT ($(_AWS_CODECOMMIT_MK_VERSION)) targets:'
	@echo '    _cct_configure_git                 - Configure git utility'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/aws_codecommit_branch.mk
-include $(MK_DIR)/aws_codecommit_repository.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cct_configure_git:
	@$(INFO) '$(AWS_LABEL)Configure local repo to work with AWS CodeCommit ...'; $(NORMAL)
	@$(WARN) 'Only this repository is affected as this is a LOCAL configuration change'; $(NORMAL)
	git config --local credential.helper '!aws --profile $(CCT_PROFILE) codecommit credential-helper $$@'
	git config --local credential.UseHttpPath true
