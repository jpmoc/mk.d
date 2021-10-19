_AWS_LEX_BOTVERSION_MK_VERSION= $(_AWS_LEX_MK_VERSION)

# LEX_BOTVERSION_BOT_NAME?= my-bot-name
# LEX_BOTVERSION_CHECKSUM?= db982235-a5bb-4554-994e-55012f461efc
# LEX_BOTVERSION_ID?= 1
# LEX_BOTVERSION_NAME?= First
# LEX_BOTVERSIONS_BOT_NAME?= my-bot-name
# LEX_BOTVERSIONS_SET_NAME?= my-botversions-set

# Derived parameters
LEX_BOTVERSION_BOT_NAME?= $(LEX_BOT_NAME)
LEX_BOTVERSION_NAME?= $(LEX_BOTVERSION_ID)
LEX_BOTVERSIONS_BOT_NAME?= $(LEX_BOTVERSION_BOT_NAME)

# Option parameters
__LEX_CHECKSUM__BOTVERSION= $(if $(LEX_BOTVERSION_CHECKSUM),--checksum $(LEX_BOTVERSION_CHECKSUM))
__LEX_NAME__BOTVERSION= $(if $(LEX_BOTVERSION_BOT_NAME),--name $(LEX_BOTVERSION_BOT_NAME))
__LEX_NAME__BOTVERSIONS= $(if $(LEX_BOTVERSIONS_BOT_NAME),--name $(LEX_BOTVERSIONS_BOT_NAME))
__LEX_BOT_VERSION= $(if $(LEX_BOTVERSION_ID),--bot-version $(LEX_BOTVERSION_ID))

# UI parameters
LEX_UI_VIEW_BOTVERSIONS_FIELDS?=
LEX_UI_VIEW_BOTVERSIONS_SET_FIELDS?= $(LEX_UI_VIEW_BOTVERSIONS_FIELDS)
LEX_UI_VIEW_BOTVERSIONS_SET_QUERYFILTER?=

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_lex_view_framework_macros ::
	@echo 'AWS::LEX::BotVersion ($(_AWS_LEX_BOTVERSION_MK_VERSION)) macros:'
	@echo

_lex_view_framework_parameters ::
	@echo 'AWS::LEX::BotVersion ($(_AWS_LEX_BOTVERSION_MK_VERSION)) parameters:'
	@echo '    LEX_BOTVERSION_BOT_NAME=$(LEX_BOTVERSION_BOT_NAME)'
	@echo '    LEX_BOTVERSION_CHECKSUM=$(LEX_BOTVERSION_CHECKSUM)'
	@echo '    LEX_BOTVERSION_ID=$(LEX_BOTVERSION_ID)'
	@echo '    LEX_BOTVERSION_NAME=$(LEX_BOTVERSION_NAME)'
	@echo '    LEX_BOTVERSIONS_BOT_NAME=$(LEX_BOTVERSIONS_BOT_NAME)'
	@echo '    LEX_BOTVERSIONS_SET_NAME=$(LEX_BOTVERSIONS_SET_NAME)'
	@echo

_lex_view_framework_targets ::
	@echo 'AWS::LEX::BotVersion ($(_AWS_LEX_BOTVERSION_MK_VERSION)) targets:'
	@echo '    _lex_create_botversion                  - Create a new bot-version'
	@echo '    _lex_delete_botversion                  - Delete an existing bot-version'
	@echo '    _lex_show_botversion                    - Show everything related to a bot-version'
	@echo '    _lex_show_botversion_description        - Show description of a bot-version'
	@echo '    _lex_view_botversions                   - View existing bot-version'
	@echo '    _lex_view_botversions_set               - View a set of bot-version' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lex_create_botversion:
	@$(INFO) '$(LEX_UI_LABEL)Creating bot-version "$(LEX_BOTVERSION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a version that points to LATEST unless a checksum is provided'; $(NORMAL)
	@$(WARN) 'This operation creates a new version only if no other version already points to the provided checksum'; $(NORMAL)
	$(AWS) lex-models create-bot-version $(__LEX_CHECKSUM__BOTVERSION) $(__LEX_NAME__BOTVERSION)

_lex_delete_botversion:
	@$(INFO) '$(LEX_UI_LABEL)Deleting bot-version "$(LEX_BOTVERSION_NAME)" of bot "$(LEX_BOTVERSION_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models delete-bot-version $(__LEX_NAME__BOTVERSION) $(__LEX_BOT_VERSION) # --query "BotAliases[]"

_lex_show_botversion: _lex_show_botversion_aliases _lex_show_botversion_description

_lex_show_botversion_aliases:
	@$(INFO) '$(LEX_UI_LABEL)Showing aliases of bot-version "$(LEX_BOTVERSION_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-bot-aliases $(__LEX_BOTVERSION_NAME) $(__LEX_NAME_CONTAINS__BOTVERSION) --query "BotAliases[]"

_lex_show_botversion_description:
	@$(INFO) '$(LEX_UI_LABEL)Showing description of bot-version "$(LEX_BOTVERSION_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-bot $(__LEX_NAME__BOTVERSION) $(__LEX_VERSION_OR_ALIAS) # --query 'bots[]$(LEX_UI_VIEW_BOTVERSIONS_FIELDS)'

_lex_view_botversions:
	@$(INFO) '$(LEX_UI_LABEL)Viewing all bot-versions of bot "$(LEX_BOTVERSIONS_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-bot-versions $(__LEX_NAME__BOTVERSIONS) --query 'bots[]$(LEX_UI_VIEW_BOTVERSIONS_FIELDS)'

_lex_view_botversions_set:
	@$(INFO) '$(LEX_UI_LABEL)Viewing bot-version-set "$(LEX_BOTVERSIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Bots are grouped based on query filter, substring ...'; $(NORMAL)
	$(AWS) lex-models get-bot-version $(__LEX_NAME_CONTAINS__BOTVERSIONS) --query 'bots[$(LEX_UI_VIEW_BOTVERSIONS_SET_QUERYFILTER)]$(LEX_UI_VIEW_BOTVERSIONS_SET_FIELDS)'
