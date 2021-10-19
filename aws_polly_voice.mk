_AWS_POLLY_VOICE_MK_VERSION= $(_AWS_POLLY_MK_VERSION)

# PLY_VOICE_GENDER?= Male
# PLY_VOICE_ID?= Celine
PLY_VOICE_INDEX?= 0
# PLY_VOICE_LANGUAGE_CODE?= en-US
# PLY_VOICE_NAME?= Céline
# PLY_VOICES_LANGUAGE_CODE?= en-US
# PLY_VOICES_SET_NAME?= my-voices-set

# Derived variables
PLY_VOICES_LANGUAGE_CODE?= $(PLY_VOICE_LANGUAGE_CODE) 
PLY_VOICE_NAME?= $(PLY_VOICE_ID)

# Options variables
__PLY_LANGUAGE_CODE__VOICES= $(if $(PLY_VOICE_LANGUAGE_CODE),--language-code $(PLY_VOICE_LANGUAGE_CODE))
__PLY_VOICE_ID= $(if $(PLY_VOICE_ID),--voice-id $(PLY_VOICE_ID))

# UI variables
PLY_UI_SHOW_VOICE_FIELDS?=
PLY_UI_VIEW_VOICES_FIELDS?= .{Id:Id,Name:Name,gender:Gender,languageCode:LanguageCode,languageName:LanguageName,supportedEngines:SupportedEngines[*]|join(' ',@)}
PLY_UI_VIEW_VOICES_SET_FIELDS?= $(PLY_UI_VIEW_VOICES_FIELDS)
PLY_UI_VIEW_VOICES_SET_QUERYFILTER?=

#--- Utilities

#--- MACRO
_ply_get_voice_attribute_A= $(call _ply_get_voice_attribute_AI, $(1), $(PLY_VOICE_ID))
_ply_get_voice_attribute_AI= $(shell $(AWS) polly describe-voices --query "Voices[?Id=='$(strip $(2))'].$(strip $(1))" --output text)

_ply_get_voice_id= $(call _ply_get_voice_id_Q, ?Name=='$(strip $(PLY_VOICE_NAME))')
_ply_get_voice_id_Q= $(shell $(AWS) polly describe-voices --query "Voices[$(strip $(1))].Id" --output text)

_ply_get_voice_name= $(call _ply_get_voice_name_I, $(PLY_VOICE_ID))
_ply_get_voice_name_I= $(shell $(AWS) polly describe-voices --query "Voices[?Id=='$(strip $(1))'].Name" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ply_view_framework_macros ::  
	@echo 'AWS::PoLlY::Voice ($(_AWS_POLLY_VOICE_MK_VERSION)) macros:'
	@echo '    _ply_get_voice_attribute_{A|AI}     - Get a voice attribute (Attribute,Id)'
	@echo '    _ply_get_voice_id_{|Q}              - Get a voice ID (Queryfilter)'
	@echo '    _ply_get_voice_name_{|I}            - Get a voice name (Id)'
	@echo

_ply_view_framework_parameters ::
	@echo 'AWS::PoLly::Voice ($(_AWS_POLLY_VOICE_MK_VERSION)) parameters:'
	@echo '    PLY_VOICE_GENDER=$(PLY_VOICE_GENDER)'
	@echo '    PLY_VOICE_ID=$(PLY_VOICE_ID)'
	@echo '    PLY_VOICE_INDEX=$(PLY_VOICE_INDEX)'
	@echo '    PLY_VOICE_LANGUAGE_CODE=$(PLY_VOICE_LANGUAGE_CODE)'
	@echo '    PLY_VOICE_NAME=$(PLY_VOICE_NAME)'
	@echo '    PLY_VOICES_LANGUAGE_CODE=$(PLY_VOICES_LANGUAGE_CODE)'
	@echo '    PLY_VOICES_SET_NAME=$(PLY_VOICES_SET_NAME)'
	@echo

_ply_view_framework_targets ::
	@echo 'AWS::PoLly::Voice ($(_AWS_POLLY_VOICE_MK_VERSION)) targets:'
	@echo '    _ply_show_voice                     - Show everything related to a  voice'
	@echo '    _ply_show_voice                     - Show everything related to a  voice'
	@echo '    _ply_show_voice_description         - Show description of a  voice'
	@echo '    _ply_view_voices                    - View available voices'
	@echo '    _ply_view_voices_set                - View set of voices'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ply_create_voice:

_ply_delete_voice:

_ply_show_voice: _ply_show_voice_description

_ply_show_voice_description:
	@$(INFO) '$(PLY_UI_LABEL)Showing description of voice "$(PLY_VOICE_NAME)" ...'; $(NORMAL)
	$(AWS) polly describe-voices $(_X__PLY_LANGUAGE_CODE) --query "Voices[?Id=='$(PLY_VOICE_ID)']$(PLY_UI_SHOW_VOICES_FIELDS)"

_ply_view_voices:
	@$(INFO) '$(PLY_UI_LABEL)Viewing voices ...'; $(NORMAL)
	$(AWS) polly describe-voices $(_X__PLY_LANGUAGE_CODE__VOICES) --query "Voices[]$(PLY_UI_VIEW_VOICES_FIELDS)"

_ply_view_voices_set:
	@$(INFO) '$(PLY_UI_LABEL)Viewing voices-set "$(PLY_VOICES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Voices are grouped based on provided language-code and query-filter'; $(NORMAL)
	$(AWS) polly describe-voices $(__PLY_LANGUAGE_CODE__VOICES) --query "Voices[$(PLY_UI_VIEW_VOICES_SET_QUERYFILTER)]$(PLY_UI_VIEW_VOICES_SET_FIELDS)"
