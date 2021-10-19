_AWS_LEX_BOT_MK_VERSION= $(_AWS_LEX_MK_VERSION)

# LEX_BOT_ABORT_STATEMENT?=
# LEX_BOT_ALIAS_NAME?=
# LEX_BOT_ALIASES_REGEX?=
# LEX_BOT_AUDIOINPUT_FILEPATH?= ./out/lex-input.mpg
# LEX_BOT_AUDIOINPUT_FORMAT?= "audio/l16; rate=16000; channels=1"
# LEX_BOT_AUDIOOUTPUT_FILEPATH?= ./out/lex-output.mpg
# LEX_BOT_CHECKSUM?= 535a8638-dc82-4fde-abce-8bc44829dc6e
# LEX_BOT_CHILD_DIRECTED?= false
# LEX_BOT_CLARIFICATION_PROMT?=
LEX_BOT_CREATEVERSION_ENABLE?= false
# LEX_BOT_DESCRIPTION?= "This is my bot!"
# LEX_BOT_EXPORT_TYPE?= LEX
# LEX_BOT_INTENTS_CONFIGS?= intentName=string,intentVersion=string ...
# LEX_BOT_LOCALE?= en-US
# LEX_BOT_NAME?= bot-name
LEX_BOT_PROCESS_BEHAVIOR?= BUILD
LEX_BOT_SESSION_TTL?= 300
# LEX_BOT_TALK_INPUT?= "I would like to order flowers"
# LEX_BOT_TALK_INPUTS?= "I would like to order flowers" ...
# LEX_BOT_TEXT_INPUT?= "I would like to order flowers"
# LEX_BOT_TEXT_INPUTS?= "I would like to order flowers" ...
# LEX_BOT_USER_ID?= UserOne
# LEX_BOT_VERSION_ID?= 1
# LEX_BOT_VERSION_OR_ALIAS?= 1
# LEX_BOT_VOICE_ID?= Matthew
# LEX_BOTS_REGEX?=
# LEX_BOTS_SET_NAME?= my-bots-set

# Derived parameters
LEX_BOT_ALIAS_NAME?= $(LEX_BOTALIAS_NAME)
LEX_BOT_TEXT_INPUTS?= $(LEX_BOT_TEXT_INPUT)
LEX_BOT_VERSION_ID?= $(LEX_BOTVERSION_ID)
LEX_BOT_VERSION_OR_ALIAS?= $(if $(LEX_BOT_VERSION_ID),$(LEX_BOT_VERSION_ID),$(LEX_BOT_ALIAS_NAME))
LEX_BOT_VOICE_ID?= $(LEX_VOICE_ID)

# Option parameters
__LEX_ABORT_STATEMENT= $(if $(LEX_BOT_ABORT_STATEMENT),--abort-statement $(LEX_BOT_ABORT_STATEMENT))
__LEX_BOT_ALIAS__BOT= $(if $(LEX_BOT_ALIAS_NAME),--bot-alias $(LEX_BOT_ALIAS_NAME))
__LEX_BOT_NAME__BOT= $(if $(LEX_BOT_NAME),--bot-name $(LEX_BOT_NAME))
__LEX_BOT_VERSIONS__BOT= $(if $(LEX_BOT_VERSION_ID),--bot-versions $(LEX_BOT_VERSION_ID))
__LEX_CHECKSUM__BOT= $(if $(LEX_BOT_CHECKSUM),--checksum $(LEX_BOT_CHECKSUM))
__LEX_CHILD_DIRECTED= $(if $(filter true,$(LEX_BOT_CHILD_DIRECTED)),--child-directed,--no-child-directed)
__LEX_CLARIFICATION_PROMT= $(if $(LEX_BOT_CLARIFICATION_PROMPT),--clarification-prompt $(LEX_BOT_CLARIFICATION_PROMT))
__LEX_CONTENT_TYPE= $(if $(LEX_BOT_AUDIOINPUT_FORMAT),--content-type $(LEX_BOT_AUDIOINPUT_FORMAT))
__LEX_CREATE_VERSION__BOT= $(if $(filter true, $(LEX_BOT_CREATEVERSION_ENABLE)),--create-version,--no-create-version)
__LEX_EXPORT_TYPE__BOT= $(if $(LEX_BOT_EXPORT_TYPE),--export-type $(LEX_BOT_EXPORT_TYPE))
__LEX_DESCRIPTION__BOT= $(if $(LEX_BOT_DESCRIPTION),--description $(LEX_BOT_DESCRIPTION))
__LEX_IDLE_SESSION_TTL_IN_SECONDS= $(if $(LEX_BOT_SESSION_TTL),--idle-session-ttl-in-seconds $(LEX_BOT_SESSION_TTL))
__LEX_INPUT_STREAM= $(if $(LEX_BOT_AUDIOINPUT_FILEPATH),--input-stream $(LEX_BOT_AUDIOINPUT_FILEPATH))
__LEX_INPUT_TEXT= $(if $(LEX_BOT_TEXT_INPUT),--input-text $(LEX_BOT_TEXT_INPUT))
__LEX_INTENTS= $(if $(LEX_BOT_INTENTS_CONFIGS),--intents $(LEX_BOT_INTENTS_CONFIGS))
__LEX_LOCALE__BOT= $(if $(LEX_BOT_LOCALE),--locale $(LEX_BOT_LOCALE))
__LEX_NAME__BOT= $(if $(LEX_BOT_NAME),--name $(LEX_BOT_NAME))
__LEX_NAME_CONTAINS__BOT= $(if $(LEX_BOT_ALIASES_REGEX),--name-contains $(LEX_BOT_ALIASES_REGEX))
__LEX_NAME_CONTAINS__BOTS= $(if $(LEX_BOTS_REGEX),--name-contains $(LEX_BOTS_REGEX))
__LEX_PROCESS_BEHAVIOR= $(if $(LEX_BOT_PROCESS_BEHAVIOR),--process-behavior $(LEX_BOT_PROCESS_BEHAVIOR))
__LEX_RESOURCE_TYPE__BOT= --resource-type BOT
__LEX_RESOURCE_VERSION__BOT= $(if $(LEX_BOT_VERSION_ID),--resource-version $(LEX_BOT_VERSION_ID))
__LEX_USER_ID= $(if $(LEX_BOT_USER_ID),--user-id $(LEX_BOT_USER_ID))
__LEX_VERSION_OR_ALIAS= $(if $(LEX_BOT_VERSION_OR_ALIAS),--version-or-alias $(LEX_BOT_VERSION_OR_ALIAS))
__LEX_VOICE_ID__BOT= $(if $(LEX_BOT_VOICE_ID),--user-id $(LEX_BOT_VOICE_ID))

# UI parameters
LEX_UI_VIEW_BOTS_FIELDS?=
LEX_UI_VIEW_BOTS_SET_FIELDS?= $(LEX_UI_VIEW_BOTS_FIELDS)
LEX_UI_VIEW_BOTS_SET_QUERYFILTER?=

#--- Utilities

#--- Macros
_lex_get_bot_checksum= $(call _lex_get_bot_checksum_V, $(LEX_BOT_VERSION_OR_ALIAS))
_lex_get_bot_checksum_V= $(call _lex_get_bot_checksum_VN, $(1), $(LEX_BOT_NAME))
_lex_get_bot_checksum_VN= $(shell $(AWS) lex-models get-bot --name $(2) --version-or-alias $(1) --query 'checksum' --output text)

#----------------------------------------------------------------------
# USAGE
#

_lex_view_framework_macros ::
	@echo 'AWS::LEX::Bot ($(_AWS_LEX_BOT_MK_VERSION)) macros:'
	@echo '    _lex_get_bot_checksum_{V|VN}        - Get the checksum of a bot (Version,Name)'
	@echo

_lex_view_framework_parameters ::
	@echo 'AWS::LEX::Bot ($(_AWS_LEX_BOT_MK_VERSION)) parameters:'
	@echo '    LEX_BOT_ALIAS_NAME=$(LEX_BOT_ALIAS_NAME)'
	@echo '    LEX_BOT_ALIASES_REGEX=$(LEX_BOT_ALIASES_REGEX)'
	@echo '    LEX_BOT_AUDIOINPUT_FILEPATH=$(LEX_BOT_AUDIOINPUT_FILEPATH)'
	@echo '    LEX_BOT_AUDIOINPUT_FORMAT=$(LEX_BOT_AUDIOINPUT_FORMAT)'
	@echo '    LEX_BOT_AUDIOOUTPUT_FILEPATH=$(LEX_BOT_AUDIOOUTPUT_FILEPATH)'
	@echo '    LEX_BOT_CHECKSUM=$(LEX_BOT_CHECKSUM)'
	@echo '    LEX_BOT_CHILD_DIRECTED=$(LEX_BOT_CHILD_DIRECTED)'
	@echo '    LEX_BOT_CLARIFICATION_PROMT=$(LEX_BOT_CLARIFICATION_PROMT)'
	@echo '    LEX_BOT_CREATEVERSION_ENABLE=$(LEX_BOT_CREATEVERSION_ENABLE)'
	@echo '    LEX_BOT_DESCRIPTION=$(LEX_BOT_DESCRIPTION)'
	@echo '    LEX_BOT_EXPORT_TYPE=$(LEX_BOT_EXPORT_TYPE)'
	@echo '    LEX_BOT_INTENTS_CONFIGS=$(LEX_BOT_INTENTS_CONFIGS)'
	@echo '    LEX_BOT_LOCALE=$(LEX_BOT_LOCALE)'
	@echo '    LEX_BOT_NAME=$(LEX_BOT_NAME)'
	@echo '    LEX_BOT_PROCESS_BEHAVIOR=$(LEX_BOT_PROCESS_BEHAVIOR)'
	@echo '    LEX_BOT_SESSION_TTL=$(LEX_BOT_SESSION_TTL)'
	@echo '    LEX_BOT_TALK_INPUT=$(LEX_BOT_TALK_INPUT)'
	@echo '    LEX_BOT_TALK_INPUTS=$(LEX_BOT_TALK_INPUTS)'
	@echo '    LEX_BOT_TEXT_INPUT=$(LEX_BOT_TEXT_INPUT)'
	@echo '    LEX_BOT_TEXT_INPUTS=$(LEX_BOT_TEXT_INPUTS)'
	@echo '    LEX_BOT_USER_ID=$(LEX_BOT_USER_ID)'
	@echo '    LEX_BOT_VERSION_ID=$(LEX_BOT_VERSION_ID)'
	@echo '    LEX_BOT_VERSION_OR_ALIAS=$(LEX_BOT_VERSION_OR_ALIAS)'
	@echo '    LEX_BOT_VOICE_ID=$(LEX_BOT_VOICE_ID)'
	@echo '    LEX_BOTS_REGEX=$(LEX_BOTS_REGEX)'
	@echo '    LEX_BOTS_SET_NAME=$(LEX_BOTS_SET_NAME)'
	@echo

_lex_view_framework_targets ::
	@echo 'AWS::LEX::Bot ($(_AWS_LEX_BOT_MK_VERSION)) targets:'
	@echo '    _lex_create_bot                    - Create a new bot'
	@echo '    _lex_delete_bot                    - Delete an existing bot'
	@echo '    _lex_show_bot                      - Show everything related to a bot'
	@echo '    _lex_show_bot_description          - Show description of a bot'
	@echo '    _lex_show_bot_detectedutterances   - Show detected-utterances of a bot'
	@echo '    _lex_show_bot_missedutterances     - Show missed-utterances of a bot'
	@echo '    _lex_show_bot_utterances           - Show utterances of a bot'
	@echo '    _lex_show_bot_versions             - Show versions of a bot'
	@echo '    _lex_talk_bot                      - Talk to a bot once'
	@echo '    _lex_talkN_bot                     - Talk to a bot multi-times'
	@echo '    _lex_text_bot                      - Text a bot once'
	@echo '    _lex_textN_bot                     - Text a bot multi-times'
	@echo '    _lex_view_bots                     - View existing bots'
	@echo '    _lex_view_bots_set                 - View a set of bots' 
	@echo

#----------------------------------------------------------------------
# PRIVATE_TARGETS
# 

__lex_talkN_bot: PLY_AUDIOFILE_TEXTINPUT_RAW="$(LEX_BOT_TEXT_INPUT)"
__lex_talkN_bot: _ply_update_audiofile
	@$(WARN) 'This operation returns the input-transcript which is the text that was extracted from the audio'; $(NORMAL)
	$(AWS) lex-runtime post-content $(__LEX_BOT_ALIAS__BOT) $(__LEX_BOT_NAME__BOT) $(__LEX_CONTENT_TYPE) $(__LEX_INPUT_STREAM) $(__LEX_USER_ID) $(LEX_BOT_AUDIOOUTPUT_FILEPATH)

__lex_textN_bot:
	$(AWS) lex-runtime post-text $(__LEX_BOT_ALIAS__BOT) $(__LEX_BOT_NAME__BOT) $(_X__LEX_INPUT_TEXT) --input-text "$(LEX_BOT_TEXT_INPUT)" $(__LEX_USER_ID)

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lex_create_bot:
	@$(INFO) '$(LEX_UI_LABEL)Creating bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models put-bot $(strip $(__ABORT_STATEMENT) $(_X__LEX_CHECKSUM__BOT) $(__LEX_CHILD_DIRECTED) $(__LEX_CLARIFICATION_PROMPT) $(__LEX_CREATE_VERSION__BOT) $(__LEX_IDLE_SESSION_TTL_IN_SECONDS) $(__LEX_INTENTS) $(__LEX_LOCALE__BOT) $(__LEX_NAME__BOT) $(__LEX_PROCESS_BEHAVIOR) $(__LEX_VOICE_ID__BOT))

_lex_delete_bot:
	@$(INFO) '$(LEX_UI_LABEL)Deleting an existing bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models delete-bot $(__LEX_NAME__BOT)

_lex_export_bot:
	@$(INFO) '$(LEX_UI_LABEL)Exporting bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models $(__LEX_EXPORT_TYPE__BOT) $(__LEX_NAME__BOT) $(__LEX_RESOURCE_TYPE__BOT) $(__LEX_RESOURCE_VERSION__BOT)

_lex_show_bot:: _lex_show_bot_aliases _lex_show_bot_utterances _lex_show_bot_versions _lex_show_bot_description

_lex_show_bot_aliases:
	@$(INFO) '$(LEX_UI_LABEL)Showing aliases of bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation maps aliases to bot-versions'; $(NORMAL)
	$(AWS) lex-models get-bot-aliases $(__LEX_BOT_NAME__BOT) $(__LEX_NAME_CONTAINS__BOT) --query "BotAliases[]"

_lex_show_bot_description:
	@$(INFO) '$(LEX_UI_LABEL)Showing description of bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-bot $(__LEX_NAME__BOT) $(__LEX_VERSION_OR_ALIAS)

_lex_show_bot_detectedutterances:
	@$(INFO) '$(LEX_UI_LABEL)Showing detected-utterances of bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-utterances-view $(__LEX_BOT_NAME__BOT) $(__LEX_BOT_VERSIONS__BOT) $(_X__LEX_STATUS_TYPE) --status-type Detected --query 'utterances[].utterances[]'

_lex_show_bot_missedutterances:
	@$(INFO) '$(LEX_UI_LABEL)Showing missed-utterances of bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-utterances-view $(__LEX_BOT_NAME__BOT) $(__LEX_BOT_VERSIONS__BOT) $(_X__LEX_STATUS_TYPE) --status-type Missed --query 'utterances[].utterances[]'

_lex_show_bot_utterances: _lex_show_bot_detectedutterances _lex_show_bot_missedutterances

_lex_show_bot_versions:
	@$(INFO) '$(LEX_UI_LABEL)Showing versions of bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-bot-versions $(__LEX_NAME__BOT)

_lex_talk_bot: _ply_update_audiofile
	@$(INFO) '$(LEX_UI_LABEL)Talking to bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the input-transcript which is the text that was extracted from the audio'; $(NORMAL)
	$(AWS) lex-runtime post-content $(__LEX_BOT_ALIAS__BOT) $(__LEX_BOT_NAME__BOT) $(__LEX_CONTENT_TYPE) $(__LEX_INPUT_STREAM) $(__LEX_USER_ID) $(LEX_BOT_AUDIOOUTPUT_FILEPATH)

_lex_talkN_bot:
	@$(INFO) '$(LEX_UI_LABEL)Talking N-times to bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation simulates an interaction between the client and the bot'; $(NORMAL)
	@for I in $(LEX_BOT_TEXT_INPUTS); do $(MAKE) --no-print-directory LEX_BOT_TEXT_INPUT="$$I" _$@; done

_lex_text_bot:
	@$(INFO) '$(LEX_UI_LABEL)Texting bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-runtime post-text $(__LEX_BOT_ALIAS__BOT) $(__LEX_BOT_NAME__BOT) $(__LEX_INPUT_TEXT) $(__LEX_USER_ID)

_lex_textN_bot:
	@$(INFO) '$(LEX_UI_LABEL)Texting N-times to bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	@for I in $(LEX_BOT_TEXT_INPUTS); do $(MAKE) --no-print-directory LEX_BOT_TEXT_INPUT="$$I" _$@; done

_lex_update_bot:
	@$(INFO) '$(LEX_UI_LABEL)Updating bot "$(LEX_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models put-bot $(strip $(__LEX_ABORT_STATEMENT) $(__LEX_CHECKSUM__BOT) $(__LEX_CHILD_DIRECTED) $(__LEX_CLARIFICATION_PROMPT) $(__LEX_CREATE_VERSION__BOT) $(__LEX_IDLE_SESSION_TTL_IN_SECONDS) $(__LEX_INTENTS) $(__LEX_LOCALE__BOT) $(__LEX_NAME__BOT) $(__LEX_PROCESS_BEHAVIOR) $(__LEX_VOICE_ID__BOT))

_lex_view_bots:
	@$(INFO) '$(LEX_UI_LABEL)Viewing all bots ...'; $(NORMAL)
	$(AWS) lex-models get-bots $(_X__LEX_NAME_CONTAINS__BOTS) --query 'bots[]$(LEX_UI_VIEW_BOTS_FIELDS)'

_lex_view_bots_set:
	@$(INFO) '$(LEX_UI_LABEL)Viewing bots-set "$(LEX_BOTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Bots are grouped based on query filter, substring ...'; $(NORMAL)
	$(AWS) lex-models get-bots $(__LEX_NAME_CONTAINS__BOTS) --query 'bots[$(LEX_UI_VIEW_BOTS_SET_QUERYFILTER)]$(LEX_UI_VIEW_BOTS_SET_FIELDS)'
