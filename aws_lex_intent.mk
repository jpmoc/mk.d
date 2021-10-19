_AWS_LEX_INTENT_MK_VERSION= $(_AWS_LEX_MK_VERSION)

# LEX_INTENT_CHECKSUM?= c51826f1-2a6c-4f99-90d9-91bc3deadca3
# LEX_INTENT_CONFIRMATION_PROMPT?= "So you want to know if your cat can go out today in {city_str}?"
# LEX_INTENT_CONCLUSION_STATEMENT?=
# LEX_INTENT_CONFIRMATION_PROMPT?=
LEX_INTENT_CREATEVERSION_ENABLE?= false
# LEX_INTENT_DESCRIPTION?= "This is my intent"
# LEX_INTENT_DIALOGCODE_HOOK?= uri=string,messageVersion=string
# LEX_INTENT_FOLLOWUP_PROMPT?=
# LEX_INTENT_FULFILLMENT_ACTIVITY?= type=string,codeHook={uri=string,messageVersion=string}
# LEX_INTENT_NAME?= my-intent-name
# LEX_INTENT_PARENT_SIGNATURE?=
# LEX_INTENT_REJECTION_STATEMENT?= "Sorry, could you repeast your question so I can try to find your intent again?"
# LEX_INTENT_UTTERANCES?= "Computer not working" ...
# LEX_INTENT_VERSION_ID?= 1
# LEX_INTENTS_REGEX?=
# LEX_INTENTS_SET_NAME?= my-intents-set

# Derived parameters
LEX_INTENT_VERSION_ID?= $(LEX_INTENTVERSION_ID)

# Option parameters
__LEX_CHECKSUM__INTENT= $(if $(LEX_INTENT_CHECKSUM),--checksum $(LEX_INTENT_CHECKSUM))
__LEX_CONCLUSION_STATEMENT= $(if $(LEX_INTENT_CONCLUSION_STATEMENT),--conclusion-statement $(LEX_INTENT_CONCLUSION_STATEMENT))
__LEX_CONFIRMATION_PROMPT= $(if $(LEX_INTENT_CONFIRMATION_PROMPT),--confirmation-prompt $(LEX_INTENT_CONFIRMATION_PROMPT))
__LEX_CREATE_VERSION__INTENT= $(if $(filter true, $(LEX_INTENT_CREATEVERSION_ENABLE)),--create-version, --no-create-version)
__LEX_DESCRIPTION__INTENT= $(if $(LEX_INTENT_DESCRIPTION),--description $(LEX_INTENT_DESCRIPTION))
__LEX_DIALOG_CODE_HOOK= $(if $(LEX_INTENT_DIALOGCODE_HOOK),--dialog-code-hook $(LEX_INTENT_DIALOGCODE_HOOK))
__LEX_FOLLOW_UP_PROMPT= $(if $(LEX_INTENT_FOLLOWUP_PROMPT),--follow-up-prompt $(LEX_INTENT_FOLLOWUP_PROMPT))
__LEX_FULFILLMENT_ACTIVITY= $(if $(LEX_INTENT_FULFILLMENT_ACTIVITY),--fulfillment-activity $(LEX_INTENT_FULFILLMENT_ACTIVITY))
__LEX_INTENT_VERSION= $(if $(LEX_INTENT_VERSION_ID),--intent-version $(LEX_INTENT_VERSION_ID))
__LEX_NAME__INTENT= $(if $(LEX_INTENT_NAME),--name $(LEX_INTENT_NAME))
__LEX_NAME_CONTAINS__INTENTS= $(if $(LEX_INTENTS_REGEX),--name-contains $(LEX_INTENTS_REGEX))
__LEX_PARENT_INTENT_SIGNATURE= $(if $(LEX_INTENTS_PARENT_SIGNATURE),--parent-intent-signature $(LEX_INTENT_PARENT_SIGNATURE))
__LEX_REJECTION_STATEMENT= $(if $(LEX_INTENT_REJECTION_STATEMENT),--rejection-statement $(LEX_INTENT_REJECTION_STATEMENT))
__LEX_SAMPLE_UTTERANCES= $(if $(LEX_INTENT_UTTERANCES),--sample-utterance $(LEX_INTENT_UTTERANCES))
__LEX_SLOTS= $(if $(LEX_INTENT_SLOTS),--slots $(LEX_INTENT_SLOTS))

# UI parameters
LEX_UI_VIEW_INTENTS_FIELDS?=
LEX_UI_VIEW_INTENTS_SET_FIELDS?= $(LEX_UI_VIEW_INTENTS_FIELDS)
LEX_UI_VIEW_INTENTS_SET_QUERYFILTER?=

#--- Utilities

#--- Macros
_lex_get_intent_checksum= $(call _lex_get_intent_checksum_V, $(LEX_INTENT_VERSION_ID))
_lex_get_intent_checksum_V= $(call _lex_get_intent_checksum_VN, $(1), $(LEX_INTENT_NAME))
_lex_get_intent_checksum_VN= $(shell $(AWS) lex-models get-intent --intent-version $(1) --name $(2) --query 'checksum' --output text)

#----------------------------------------------------------------------
# USAGE
#

_lex_view_framework_macros ::
	@echo 'AWS::LEX::Intent ($(_AWS_LEX_INTENT_MK_VERSION)) macros:'
	@echo '    _lex_get_intent_checksum_{|V|VN}      - Get the checksum of an intent (Version,botName)'
	@echo

_lex_view_framework_parameters ::
	@echo 'AWS::LEX::Intent ($(_AWS_LEX_INTENT_MK_VERSION)) parameters:'
	@echo '    LEX_INTENT_CHECKSUM=$(LEX_INTENT_CHECKSUM)'
	@echo '    LEX_INTENT_CONCLUSION_STATEMENT=$(LEX_INTENT_CONCLUSION_STATEMENT)'
	@echo '    LEX_INTENT_CONFIRMATION_PROMPT=$(LEX_INTENT_CONFIRMATION_PROMPT)'
	@echo '    LEX_INTENT_CREATEVERSION_ENABLE=$(LEX_INTENT_CREATEVERSION_ENABLE)'
	@echo '    LEX_INTENT_DESCRIPTION=$(LEX_INTENT_DESCRIPTION)'
	@echo '    LEX_INTENT_DIALOGCODE_HOOK=$(LEX_INTENT_DIALOGCODE_HOOK)'
	@echo '    LEX_INTENT_FOLLOWUP_PROMPT=$(LEX_INTENT_FOLLOWUP_PROMPT)'
	@echo '    LEX_INTENT_FULFILLMENT_ACTIVITY=$(LEX_INTENT_FULFILLMENT_ACTIVITY)'
	@echo '    LEX_INTENT_NAME=$(LEX_INTENT_NAME)'
	@echo '    LEX_INTENT_PARENT_SIGNATURE=$(LEX_INTENT_PARENT_SIGNATURE)'
	@echo '    LEX_INTENT_REJECTION_STATEMENT=$(LEX_INTENT_REJECTION_STATEMENT)'
	@echo '    LEX_INTENT_SLOTS=$(LEX_INTENT_SLOTS)'
	-@echo '    LEX_INTENT_UTTERANCES=$(LEX_INTENT_UTTERANCES)'   # May contain single quote!!!
	@echo '    LEX_INTENT_VERSION_ID=$(LEX_INTENT_VERSION_ID)'
	@echo '    LEX_INTENTS_REGEX=$(LEX_INTENTS_REGEX)'
	@echo '    LEX_INTENTS_SET_NAME=$(LEX_INTENTS_SET_NAME)'
	@echo

_lex_view_framework_targets ::
	@echo 'AWS::LEX::Intent ($(_AWS_LEX_INTENT_MK_VERSION)) targets:'
	@echo '    _lex_create_intent                  - Create a new intent'
	@echo '    _lex_delete_intent                  - Delete an existing intent'
	@echo '    _lex_export_intent                  - Export an intent'
	@echo '    _lex_import_intent                  - Import an intent'
	@echo '    _lex_show_intent                    - Show everything related to an intent'
	@echo '    _lex_show_intent_description        - Show description of an intent'
	@echo '    _lex_show_intent_versions           - Show versions of an intent'
	@echo '    _lex_update_intent                  - Update an existing intent'
	@echo '    _lex_view_intents                   - View existing intents'
	@echo '    _lex_view_intents_set               - View a set of intents' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lex_create_intent:
	@$(INFO) '$(LEX_UI_LABEL)Creating intent "$(LEX_INTENT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models put-intent $(strip $(_X__LEX_CHECKSUM__INTENT) $(__LEX_CONCLUSION_STATEMENT) $(__LEX_CONFIRMATION_PROMPT) $(__LEX_CREATE_VERSION__INTENT) $(__LEX_DESCRIPTION__INTENT) $(__LEX_DIALOG_CODE_HOOK) $(__LEX_FOLLOW_UP_PROMPT) $(__LEX_FULFILLMENT_ACTIVITY) $(__LEX_NAME__INTENT) $(__LEX_PARENT_INTENT_SIGNATURE) $(__LEX_REJECTION_STATEMENT) $(__LEX_SAMPLE_UTTERANCES) $(__LEX_SLOTS))

_lex_delete_intent:
	@$(INFO) '$(LEX_UI_LABEL)Deleting an existing intent "$(LEX_INTENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation deletes an intent and all its versions'; $(NORMAL)
	-$(AWS) lex-models delete-intent $(__LEX_NAME__INTENT)

_lex_export_intent:
	@$(INFO) '$(LEX_UI_LABEL)Exporting intent "$(LEX_INTENT_NAME)" ...'; $(NORMAL)
	# To implement

_lex_import_intent:
	@$(INFO) '$(LEX_UI_LABEL)Importing intent "$(LEX_INTENT_NAME)" ...'; $(NORMAL)
	# To implement

_lex_show_intent:: _lex_show_intent_versions _lex_show_intent_description

_lex_show_intent_description:
	@$(INFO) '$(LEX_UI_LABEL)Showing description of version "$(LEX_INTENT_VERSION_ID)" of intent "$(LEX_INTENT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-intent $(__LEX_INTENT_VERSION) $(__LEX_NAME__INTENT)

_lex_show_intent_versions:
	@$(INFO) '$(LEX_UI_LABEL)Showing versions of intent "$(LEX_INTENT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-intent-versions $(__LEX_NAME__INTENT) --query "intents[]"

_lex_update_intent:
	@$(INFO) '$(LEX_UI_LABEL)Updating intent "$(LEX_INTENT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models put-intent $(strip $(__LEX_CHECKSUM__INTENT) $(__LEX_CONCLUSION_STATEMENT) $(__LEX_CONFIRMATION_PROMPT) $(__LEX_CREATE_VERSION__INTENT) $(__LEX_DESCRIPTION__INTENT) $(__LEX_DIALOG_CODE_HOOK) $(__LEX_FOLLOW_UP_PROMPT) $(__LEX_FULFILLMENT_ACTIVITY) $(__LEX_NAME__INTENT) $(__LEX_PARENT_INTENT_SIGNATURE) $(__LEX_REJECTION_STATEMENT) $(__LEX_SAMPLE_UTTERANCES) $(__LEX_SLOTS))

_lex_view_intents:
	@$(INFO) '$(LEX_UI_LABEL)Viewing all intents ...'; $(NORMAL)
	$(AWS) lex-models get-intents $(_X__LEX_NAME_CONTAINS__INTENTS) --query 'intents[]$(LEX_UI_VIEW_INTENTS_FIELDS)'

_lex_view_intents_set:
	@$(INFO) '$(LEX_UI_LABEL)Viewing intents-set "$(LEX_INTENTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Bots are grouped based on query filter, substring ...'; $(NORMAL)
	$(AWS) lex-models get-intents $(__LEX_NAME_CONTAINS__INTENTS) --query 'intents[$(LEX_UI_VIEW_INTENTS_SET_QUERYFILTER)]$(LEX_UI_VIEW_INTENTS_SET_FIELDS)'
