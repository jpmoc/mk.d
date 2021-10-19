_AWS_LEX_INTENTVERSION_MK_VERSION= $(_AWS_LEX_MK_VERSION)

# LEX_INTENTVERSION_INTENT_NAME?= my-intent-name
# LEX_INTENTVERSION_CHECKSUM?= db982235-a5bb-4554-994e-55012f461efc
# LEX_INTENTVERSION_ID?= 1
# LEX_INTENTVERSION_NAME?= First
# LEX_INTENTVERSIONS_INTENT_NAME?= my-intent-name
# LEX_INTENTVERSIONS_SET_NAME?= my-intentversions-set

# Derived parameters
LEX_INTENTVERSION_INTENT_NAME?= $(LEX_INTENT_NAME)
LEX_INTENTVERSION_NAME?= $(LEX_INTENTVERSION_ID)
LEX_INTENTVERSIONS_INTENT_NAME?= $(LEX_INTENTVERSION_INTENT_NAME)

# Option parameters
__LEX_CHECKSUM__INTENTVERSION= $(if $(LEX_INTENTVERSION_CHECKSUM),--checksum $(LEX_INTENTVERSION_CHECKSUM))
__LEX_NAME__INTENTVERSION= $(if $(LEX_INTENTVERSION_INTENT_NAME),--name $(LEX_INTENTVERSION_INTENT_NAME))
__LEX_NAME__INTENTVERSIONS= $(if $(LEX_INTENTVERSIONS_INTENT_NAME),--name $(LEX_INTENTVERSIONS_INTENT_NAME))
__LEX_INTENT_VERSION= $(if $(LEX_INTENTVERSION_ID),--intent-version $(LEX_INTENTVERSION_ID))

# UI parameters
LEX_UI_VIEW_INTENTVERSIONS_FIELDS?=
LEX_UI_VIEW_INTENTVERSIONS_SET_FIELDS?= $(LEX_UI_VIEW_INTENTVERSIONS_FIELDS)
LEX_UI_VIEW_INTENTVERSIONS_SET_QUERYFILTER?=

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_lex_view_framework_macros ::
	@echo 'AWS::LEX::BotVersion ($(_AWS_LEX_INTENTVERSION_MK_VERSION)) macros:'
	@echo

_lex_view_framework_parameters ::
	@echo 'AWS::LEX::BotVersion ($(_AWS_LEX_INTENTVERSION_MK_VERSION)) parameters:'
	@echo '    LEX_INTENTVERSION_INTENT_NAME=$(LEX_INTENTVERSION_INTENT_NAME)'
	@echo '    LEX_INTENTVERSION_CHECKSUM=$(LEX_INTENTVERSION_CHECKSUM)'
	@echo '    LEX_INTENTVERSION_ID=$(LEX_INTENTVERSION_ID)'
	@echo '    LEX_INTENTVERSION_NAME=$(LEX_INTENTVERSION_NAME)'
	@echo '    LEX_INTENTVERSIONS_INTENT_NAME=$(LEX_INTENTVERSIONS_INTENT_NAME)'
	@echo '    LEX_INTENTVERSIONS_SET_NAME=$(LEX_INTENTVERSIONS_SET_NAME)'
	@echo

_lex_view_framework_targets ::
	@echo 'AWS::LEX::BotVersion ($(_AWS_LEX_INTENTVERSION_MK_VERSION)) targets:'
	@echo '    _lex_create_intentversion                  - Create a new intent-version'
	@echo '    _lex_delete_intentversion                  - Delete an existing intent-version'
	@echo '    _lex_show_intentversion                    - Show everything related to a intent-version'
	@echo '    _lex_show_intentversion_description        - Show description of a intent-version'
	@echo '    _lex_view_intentversions                   - View existing intent-version'
	@echo '    _lex_view_intentversions_set               - View a set of intent-version' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lex_create_intentversion:
	@$(INFO) '$(LEX_UI_LABEL)Creating intent-version "$(LEX_INTENTVERSION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a version that points to LATEST unless a checksum is provided'; $(NORMAL)
	@$(WARN) 'This operation creates a new version only if no other version already points to the provided checksum'; $(NORMAL)
	$(AWS) lex-models create-intent-version $(__LEX_CHECKSUM__INTENTVERSION) $(__LEX_NAME__INTENTVERSION)

_lex_delete_intentversion:
	@$(INFO) '$(LEX_UI_LABEL)Deleting intent-version "$(LEX_INTENTVERSION_NAME)" of intent "$(LEX_INTENTVERSION_INTENT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models delete-intent-version $(__LEX_NAME__INTENTVERSION) $(__LEX_INTENT_VERSION) # --query "BotAliases[]"

_lex_show_intentversion: _lex_show_intentversion_description

_lex_show_intentversion_description:
	@$(INFO) '$(LEX_UI_LABEL)Showing description of intent-version "$(LEX_INTENTVERSION_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-intent $(__LEX_NAME__INTENTVERSION) $(__LEX_VERSION_OR_ALIAS) # --query 'intents[]$(LEX_UI_VIEW_INTENTVERSIONS_FIELDS)'

_lex_view_intentversions:
	@$(INFO) '$(LEX_UI_LABEL)Viewing all intent-versions of intent "$(LEX_INTENTVERSIONS_INTENT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-intent-versions $(__LEX_NAME__INTENTVERSIONS) --query 'intents[]$(LEX_UI_VIEW_INTENTVERSIONS_FIELDS)'

_lex_view_intentversions_set:
	@$(INFO) '$(LEX_UI_LABEL)Viewing intent-version-set "$(LEX_INTENTVERSIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Bots are grouped based on query filter, substring ...'; $(NORMAL)
	$(AWS) lex-models get-intent-version $(__LEX_NAME_CONTAINS__INTENTVERSIONS) --query 'intents[$(LEX_UI_VIEW_INTENTVERSIONS_SET_QUERYFILTER)]$(LEX_UI_VIEW_INTENTVERSIONS_SET_FIELDS)'
