_ASK_MK_VERSION= 0.99.3

# ASK_ACCOUNT_ID?= 123456789012
ASK_PROFILE_NAME?= default
# ASK_MODE_DEBUG?= false
# ASK_REGION_NAME= us-east-1
# ASK_VERSION?= 1.9.0

# Derived parameters
ASK_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
ASK_REGION_NAME?= $(AWS_REGION_NAME)
ASK_MODE_DEBUG?= $(CMN_MODE_DEBUG)

# Options parameters

# UI parameters
ASK_UI_LABEL?= [ask] #

#--- Utilities

# __ASK_OPTIONS+= $(if $(ASK_PROFILE),--profile $(ASK_PROFILE))
ASK_BIN?= ask
ASK?= $(strip $(__ASK_ENVIRONMENT) $(ASK_ENVIRONMENT) $(ASK_BIN) $(__ASK_OPTIONS) $(ASK_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _ask_view_framework_macros
_ask_view_framework_macros ::
	@echo 'ASK:: ($(_ASK_MK_VERSION)) macros:'
	@echo


_view_framework_parameters :: _ask_view_framework_parameters
_ask_view_framework_parameters ::
	@echo 'ASK:: ($(_ASK_MK_VERSION)) parameters:'
	@echo '    ASK=$(ASK)'
	@echo '    ASK_ACCOUNT_ID=$(ASK_ACCOUNT_ID)'
	@echo '    ASK_MODE_DEBUG=$(ASK_MODE_DEBUG)'
	@echo '    ASK_PROFILE_NAME=$(ASK_PROFILE_NAME)'
	@echo '    ASK_REGION_NAME=$(ASK_REGION_NAME)'
	@echo

_view_framework_targets :: _ask_view_framework_targets
_ask_view_framework_targets ::
	@echo 'ASK:: ($(_ASK_MK_VERSION)) targets:'
	@echo '    _ask_install_dependencies              - Install dependencies'
	@echo '    _ask_show_version                      - Show versions of utilities '
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/ask_askprofile.mk
-include $(MK_DIR)/ask_function.mk
-include $(MK_DIR)/ask_project.mk
-include $(MK_DIR)/ask_skill.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _ask_install_dependencies
_ask_install_dependencies ::
	@$(INFO) '$(ASK_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	node --version
	npm --version
	$(SUDO) npm install --global ask-cli
	# $(SUDO) pip3 install ask-sdk

_view_versions :: _ask_show_version
_ask_show_version ::
	@$(INFO) '$(ASK_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	ask --version
