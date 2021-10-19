_AWS_LEX_MK_VERSION= 0.99.0

# LEX_PARAMETER?= value

# Derived parameters

# Option parameters

# Pipe parameters

# UI parameters
LEX_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _lex_view_framework_macros
_lex_view_framework_macros ::
	@#echo 'AWS::LEX:: ($(_AWS_LEX_MK_VERSION)) targets:'
	@#echo

_aws_view_framework_parameters :: _lex_view_framework_parameters
_lex_view_framework_parameters ::
	@echo 'AWS::LEX:: ($(_AWS_LEX_MK_VERSION)) parameters:'
	@echo '    LEX_UI_LABEL=$(LEX_UI_LABEL)'
	@echo

_aws_view_framework_targets :: _lex_view_framework_targets
_lex_view_framework_targets ::
	@echo 'AWS::LEX:: ($(_AWS_LEX_MK_VERSION)) targets:'
	@echo '    _lex_install_dependencies           - Installing service dependencies'
	@echo '    _lex_view_account_limits            - Retrieve lambda-service limits information'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

MK_DIR?= .
-include $(MK_DIR)/aws_lex_bot.mk
-include $(MK_DIR)/aws_lex_botalias.mk
-include $(MK_DIR)/aws_lex_botchannelassociation.mk
-include $(MK_DIR)/aws_lex_botversion.mk
-include $(MK_DIR)/aws_lex_builtinintent.mk
-include $(MK_DIR)/aws_lex_intent.mk
-include $(MK_DIR)/aws_lex_intentversion.mk
-include $(MK_DIR)/aws_lex_slottype.mk
-include $(MK_DIR)/aws_lex_slottypeversion.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_aws_install_software_dependencies :: _lex_install_dependencies
_lex_install_dependencies ::
	@$(INFO) '$(LEX_UI_LABEL)Retrieving limits for LEX service ...'; $(NORMAL)

_aws_view_account_limits :: _lex_view_account_limits
_lex_view_account_limits:
	@$(INFO) '$(LEX_UI_LABEL)Retrieving limits for LEX service ...'; $(NORMAL)
