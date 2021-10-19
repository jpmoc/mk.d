_ASK_ASKPROFILE_MK_VERSION= $(_ASK_MK_VERSION)

ASK_ASKPROFILE_CREATE_AWSSETUP?= false
ASK_ASKPROFILE_CREATE_NOBROWSER?= true
# ASK_ASKPROFILE_NAME?= default
ASK_ASKPROFILES_CONFIG_FILEPATH?= $(HOME)/.ask/cli_config

# Derived parameters
ASK_ASKPROFILE_NAME?= $(ASK_PROFILE_NAME)

# Options parameters
__ASK_AWS_SETUP?= $(if $(filter true,$(ASK_ASKPROFILE_CREATE_AWSSETUP)),--aws-setup)
__ASK_NO_BROWSER?= --no-browser
__ASK_PROFILE__ASKPROFILE?= $(if $(ASK_ASKPROFILE_NAME),--profile $(ASK_ASKPROFILE_NAME))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ask_view_framework_macros ::
	@echo 'ASK::AskProfile ($(_ASK_ASKPROFILE_MK_VERSION)) macros:'
	@echo


_ask_view_framework_parameters ::
	@echo 'ASK::AskProfile ($(_ASK_ASKPROFILE_MK_VERSION)) parameters:'
	@echo '    ASK_ASKPROFILE_CREATE_AWSSETUP=$(ASK_ASKPROFILE_CREATE_AWSSETUP)'
	@echo '    ASK_ASKPROFILE_CREATE_NOBROWSER=$(ASK_ASKPROFILE_CREATE_NOBROWSER)'
	@echo '    ASK_ASKPROFILE_NAME=$(ASK_ASKPROFILE_NAME)'
	@echo '    ASK_ASKPROFILES_CONFIG_FILEPATH=$(ASK_ASKPROFILES_CONFIG_FILEPATH)'
	@echo

_ask_view_framework_targets ::
	@echo 'ASK::AskProfile ($(_ASK_ASKPROFILE_MK_VERSION)) targets:'
	@echo '    _ask_create_askprofile              - Create an ASK-profile'
	@echo '    _ask_show_askprofile                - Show everything related to an ASK-profiles'
	@echo '    _ask_show_askprofile_description    - Show description of an ASK-profiles'
	@echo '    _ask_view_askprofile                - View ASK-profiles'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ask_create_askprofile:
	@$(INFO) '$(ASK_UI_LABEL)Creating ASK-profile "$(ASK_ASKPROFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operaton will configure the CLI as an OAUTH client'; $(NORMAL)
	$(ASK) init $(__ASK_AWS_SETUP) $(__ASK_NO_BROWSER) $(__ASK_PROFILE__ASKPROFILE)

_ask_show_askprofile: _ask_show_askprofile_description

_ask_show_askprofile_description:
	@$(INFO) '$(ASK_UI_LABEL)Show description of ASK-profile "$(ASK_ASKPROFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation shows the OAUTH credentials'; $(NORMAL)
	-cat $(ASK_ASKPROFILES_CONFIG_FILEPATH) | jq '.profile.$(ASK_ASKPROFILE_NAME)'

_ask_view_askprofiles:
	@$(INFO) '$(ASK_UI_LABEL)View ASK-profiles ...'; $(NORMAL)
	@$(WARN) 'This operation returns the mapping between ASK and AWS profiles'; $(NORMAL)
	$(ASK) init --list-profiles
