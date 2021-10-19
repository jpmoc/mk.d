_ASK_SKILL_MK_VERSION= $(_ASK_MK_VERSION)

# ASK_SKILL_ACCOUNT_ID?= 123456789012
# ASK_SKILL_DEVICE_LOCALE?= en-US
# ASK_SKILL_ENDPOINT_TYPE?=
# ASK_SKILL_ENDPOINT_URI?= arn:aws:lambda:us-west-2:123456789012:function:ask-custom-hello-ask-1234-me_domain_com
# ASK_SKILL_ID?= amzn1.ask.skill.12345678-1234-1234-123456789123
# ASK_SKILL_NAME?= hello-ask
# ASK_SKILL_PROFILE_NAME?= 1234-me@domain.com
# ASK_SKILL_PROJECT_DIRPATH?= ./skills/ask-app/
# ASK_SKILLS_NAME_REGEX=
# ASK_SKILLS_SET_NAME=

# Derived parameters
ASK_SKILL_ACCOUNT_ID?= $(ASK_ACCOUNT_ID)
ASK_SKILL_ENDPOINT_URI?= $(ASK_FUNCTION_ARN)
ASK_SKILL_NAME?= $(ASK_PROJECT_NAME)
ASK_SKILL_PROFILE_NAME?= $(ASK_PROFILE_NAME)
ASK_SKILL_PROJECT_DIRPATH?= $(ASK_PROJECT_DIRPATH)

# Options parameters
__ASK_DEBUG__SKILL= $(if $(filter true, $(ASK_MODE_DEBUG)),--debug)
__ASK_LOCALE= $(if $(ASK_SKILL_DEVICE_LOCALE),--locale $(ASK_SKILL_DEVICE_LOCALE))
__ASK_PROFILE__SKILL= $(if $(ASK_SKILL_PROFILE_NAME),--profile $(ASK_SKILL_PROFILE_NAME))
__ASK_SKILL_ID= $(if $(ASK_SKILL_ID),--skill-id $(ASK_SKILL_ID))
__ASK_SKILL_NAME= $(if $(ASK_SKILL_NAME),--skill-name $(ASK_SKILL_NAME))

# Pipe parameters
_ASK_CREATE_SKILL_|?= cd $(ASK_SKILL_PROJECT_DIRPATH) && 
_ASK_DELETE_SKILL_|?= cd $(ASK_SKILL_PROJECT_DIRPATH) && 
|_ASK_SHOW_SKILL_DESCRIPTION?= | jq '.'
|_ASK_VIEW_SKILLS?= | jq '.'

# UI parameters

#--- Utilities

#--- MACROS

_ask_get_skill_endpoint_uri= $(call _ask_get_skill_endpoint_uri_I, $(ASK_SKILL_ID))
_ask_get_skill_endpoint_uri_I= $(call _ask_get_skill_endpoint_uri_IP, $(1), $(ASK_SKILL_ASKPROFILE_NAME))
_ask_get_skill_endpoint_uri_IP= $(shell $(ASK) get-still --profile $(2) --skill-id $(1) | jq -r '.manifest.apis.custom.endpoint.uri')

# _ask_get_skill_id= $(call _ask_get_skill_id_N, $(ASK_SKILL_NAME))
_ask_get_skill_id= $(call _ask_get_skill_id_N, hello-ask)
_ask_get_skill_id_N= $(call _ask_get_skill_id_NL, $(1), $(ASK_SKILL_DEVICE_LOCALE))
_ask_get_skill_id_NL= $(call _ask_get_skill_id_NLP, $(1), $(2), $(ASK_SKILL_ASKPROFILE_NAME))
# _ask_get_skill_id_NLP= $(shell $(ASK) api list-skills --profile $(3) | jq -r '.skills[] | select(.nameByLocale."$(strip $(2))"=="$(strip $(3))") | .skillId')
_ask_get_skill_id_NLP= $(shell ask api list-skills --profile $(3) | jq -r '.skills[] | select(.nameByLocale."$(strip $(2))"=="$(strip hello-ask)") | .skillId')
# _ask_get_skill_id_NLP= $(shell ask api list-skills --profile $(3) | jq -r '.skills[] | select(.nameByLocale."$(strip $(2))"=="$(strip $(1))") | .skillId')

#----------------------------------------------------------------------
# USAGE
#

_ask_view_framework_macros ::
	@echo 'ASK::Skill ($(_ASK_SKILL_MK_VERSION)) macros:'
	@echo '    _sdk_get_skill_endpoint_uri_{|I|IP}     - Get the endpoint uri for the skill (skillId,askProfile)'
	@echo '    _sdk_get_skill_id_{|N|NL|NLP}           - Get the ID of a skill (Name,Locale,askProfile)'
	@echo

_ask_view_framework_parameters ::
	@echo 'ASK::Skill ($(_ASK_SKILL_MK_VERSION)) parameters:'
	@echo '    ASK_SKILL_ACCOUNT_ID=$(ASK_SKILL_ACCOUNT_ID)'
	@echo '    ASK_SKILL_DEVICE_LOCALE=$(ASK_SKILL_DEVICE_LOCALE)'
	@echo '    ASK_SKILL_ENDPOINT_TYPE=$(ASK_SKILL_ENDPOINT_TYPE)'
	@echo '    ASK_SKILL_ENDPOINT_URI=$(ASK_SKILL_ENDPOINT_URI)'
	@echo '    ASK_SKILL_ID=$(ASK_SKILL_ID)'
	@echo '    ASK_SKILL_NAME=$(ASK_SKILL_NAME)'
	@echo '    ASK_SKILL_PROFILE_NAME=$(ASK_SKILL_PROFILE_NAME)'
	@echo '    ASK_SKILL_PROJECT_DIRPATH=$(ASK_SKILL_PROJECT_DIRPATH)'
	@echo '    ASK_SKILLS_NAME_REGEX=$(ASK_SKILLS_NAME_REGEX)'
	@echo '    ASK_SKILLS_SET_NAME=$(ASK_SKILLS_SET_NAME)'
	@echo

_ask_view_framework_targets ::
	@echo 'ASK::Skill ($(_ASK_SKILL_MK_SKILL_VERSION)) targets:'
	@echo '    _ask_create_skill                  - Create a new skill'
	@echo '    _ask_delete_skill                  - Delete a skill'
	@echo '    _ask_show_skill                    - Show everything related to a skill'
	@echo '    _ask_show_skill_files              - Show files of a skill'
	@echo '    _ask_view_skills                   - View skills'
	@echo '    _ask_view_skills_set               - View a set of skills'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ask_create_skill:
	@$(INFO) '$(ASK_UI_LABEL)Creating skill "$(ASK_SKILL_NAME)" ...'; $(NORMAL)
	$(_ASK_CREATE_SKILL_|) $(ASK) deploy $(__ASK_DEBUG__SKILL) $(__ASK_PROFILE__SKILL)

_ask_delete_skill:
	@$(INFO) '$(ASK_UI_LABEL)Deleting skill "$(ASK_SKILL_NAME)" ...'; $(NORMAL)
	$(_ASK_DELETE_SKILL_|) $(ASK) delete $(__ASK_PROFILE__SKILL) $(__ASK_STAGE__SKILL)

_ask_show_skill :: _ask_show_skill_description

_ask_show_skill_description: 
	@$(INFO) '$(ASK_UI_LABEL)Showing description of skill "$(ASK_SKILL_NAME)" ...'; $(NORMAL)
	$(ASK) api get-skill $(__ASK_PROFILE__SKILL) $(__ASK_SKILL_ID) $(|_ASK_SHOW_SKILL_DESCRIPTION)

_ask_simulate_skill:
	@$(INFO) '$(ASK_UI_LABEL)Simulating interaction with skill "$(ASK_SKILL_NAME)" ...'; $(NORMAL)
	$(_ASK_SIMULATE_SKILL_|) $(ASK) simulate $(__ASK_LOCALE) $(__ASK_PROFILE__SKILL) $(__ASK_SKILL_ID) $(__ASK_STAGE__SKILL)

_ask_view_skills:
	@$(INFO) '$(ASK_UI_LABEL)Viewing skills ...'; $(NORMAL)
	$(ASK) api $(__ASK_PROFILE__SKILL) list-skills $(|_ASK_VIEW_SKILLS)

_ask_view_skills_set:
	@$(INFO) '$(ASK_UI_LABEL)Viewing skills-set "$(ASK_SKILLS_SET_NAME)" ...'; $(NORMAL)
