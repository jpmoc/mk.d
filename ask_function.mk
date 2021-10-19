_ASK_FUNCTION_MK_VERSION= $(_ASK_MK_VERSION)

# ASK_FUNCTION_ACCOUNT_ID?= 123456789012
# ASK_FUNCTION_ARN?= arn:aws:lambda:us-west-2:123456789012:function:ask-custom-hello-ask-1234-me_domain_com
# ASK_FUNCTION_NAME?= ask-custom-hello-ask-1234-me_domain_com
# ASK_FUNCTION_PROFILE_NAME?= 1234-me@domain.com
# ASK_FUNCTION_REGION_NAME= us-west-1
# ASK_FUNCTION_ROLE_ARN?= arn:aws:iam::123456789012:role/ask-lambda-hello-ask
# ASK_FUNCTION_ROLE_NAME?= ask-lambda-hello-ask
# ASK_FUNCTION_SKILL_NAME?= hello-ask

# Derived parameters
ASK_FUNCTION_ACCOUNT_ID?= $(ASK_ACCOUNT_ID)
ASK_FUNCTION_ARN?= arn:aws:lambda:$(ASK_FUNCTION_REGION_NAME):$(ASK_FUNCTION_ACCOUNT_ID):function:$(ASK_FUNCTION_NAME)
ASK_FUNCTION_NAME?= ask-custom-$(ASK_FUNCTION_SKILL_NAME)-$(ASK_FUNCTION_PROFILE_NAME)
ASK_FUNCTION_ROLE_ARN?= arn:aws:iam::$(ASK_FUNCTION_ACCOUNT_ID):role/$(ASK_FUNCTION_ROLE_NAME)
ASK_FUNCTION_ROLE_NAME?= ask-lambda-$(ASK_FUNCTION_SKILL_NAME)
ASK_FUNCTION_SKILL_NAME?= $(ASK_SKILL_NAME)
ASK_FUNCTION_PROFILE_NAME?= $(ASK_PROFILE_NAME)
ASK_FUNCTION_REGION_NAME?= $(ASK_REGION_NAME)

# Options parameters

# Pipe parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ask_view_framework_macros ::
	@echo 'ASK::Function ($(_ASK_FUNCTION_MK_VERSION)) macros:'
	@echo

_ask_view_framework_parameters ::
	@echo 'ASK::Function ($(_ASK_FUNCTION_MK_VERSION)) parameters:'
	@echo '    ASK_FUNCTION_ACCOUNT_ID=$(ASK_FUNCTION_ACCOUNT_ID)'
	@echo '    ASK_FUNCTION_ARN=$(ASK_FUNCTION_ARN)'
	@echo '    ASK_FUNCTION_NAME=$(ASK_FUNCTION_NAME)'
	@echo '    ASK_FUNCTION_PROFILE_NAME=$(ASK_FUNCTION_PROFILE_NAME)'
	@echo '    ASK_FUNCTION_REGION_NAME=$(ASK_FUNCTION_REGION_NAME)'
	@echo '    ASK_FUNCTION_ROLE_ARN=$(ASK_FUNCTION_ROLE_ARN)'
	@echo '    ASK_FUNCTION_ROLE_NAME=$(ASK_FUNCTION_ROLE_NAME)'
	@echo '    ASK_FUNCTION_SKILL_NAME=$(ASK_FUNCTION_SKILL_NAME)'
	@echo

_ask_view_framework_targets ::
	@echo 'ASK::Function ($(_ASK_FUNCTION_MK_SKILL_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

# So far this is only an interface to AWS lambda + iam 
