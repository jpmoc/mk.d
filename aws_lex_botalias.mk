_AWS_LEX_BOTALIAS_MK_VERSION= $(_AWS_LEX_MK_VERSION)

# LEX_BOTALIAS_BOT_NAME?= my-bot-name
# LEX_BOTALIAS_BOTVERSION_ID?= 1
# LEX_BOTALIAS_DESCRIPTION?= "This is my bot-alias"
# LEX_BOTALIAS_NAME?= prod
# LEX_BOTALIASES_BOT_NAME?= my-bot-name
# LEX_BOTALIASES_REGEX?= prod
# LEX_BOTALIASES_SET_NAME?= my-botaliases-set

# Derived parameters
LEX_BOTALIAS_BOT_NAME?= $(LEX_BOT_NAME)
LEX_BOTALIAS_BOTVERSION_ID?= $(LEX_BOTVERSION_ID)
LEX_BOTALIASES_BOT_NAME?= $(LEX_BOTALIAS_BOT_NAME)

# Option parameters
__LEX_BOT_ALIAS__BOTALIAS= $(if $(LEX_BOTALIAS_NAME),--bot-alias $(LEX_BOTALIAS_NAME))
__LEX_BOT_NAME__BOTALIAS= $(if $(LEX_BOTALIAS_BOT_NAME),--bot-name $(LEX_BOTALIAS_BOT_NAME))
__LEX_BOT_NAME__BOTALIASES= $(if $(LEX_BOTALIASES_BOT_NAME),--bot-name $(LEX_BOTALIASES_BOT_NAME))
__LEX_BOT_VERSION__BOTALIAS= $(if $(LEX_BOTALIAS_BOTVERSION_ID),--bot-version $(LEX_BOTALIAS_BOTVERSION_ID))
__LEX_DESCRIPTION__BOTALIAS= $(if $(LEX_BOTALIAS_DESCRIPTION),--description $(LEX_BOTALIAS_DESCRIPTION))
__LEX_NAME__BOTALIAS= $(if $(LEX_BOTALIAS_NAME),--name $(LEX_BOTALIAS_NAME))
__LEX_NAME_CONTAINS__BOTALIASES= $(if $(LEX_BOTALIASES_REGEX),--name-contains $(LEX_BOTALIASES_REGEX))

# UI parameters
LEX_UI_VIEW_BOTALIASES_FIELDS?=
LEX_UI_VIEW_BOTALIASES_SET_FIELDS?= $(LEX_UI_VIEW_BOTALIASES_FIELDS)
LEX_UI_VIEW_BOTALIASES_SET_QUERYFILTER?=

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_lex_view_framework_macros ::
	@echo 'AWS::LEX::BotAlias ($(_AWS_LEX_BOTALIAS_MK_ALIAS)) macros:'
	@echo

_lex_view_framework_parameters ::
	@echo 'AWS::LEX::BotAlias ($(_AWS_LEX_BOTALIAS_MK_ALIAS)) parameters:'
	@echo '    LEX_BOTALIAS_BOT_NAME=$(LEX_BOTALIAS_BOT_NAME)'
	@echo '    LEX_BOTALIAS_BOTVERSION_ID=$(LEX_BOTALIAS_BOTVERSION_ID)'
	@echo '    LEX_BOTALIAS_DESCRIPTION=$(LEX_BOTALIAS_DESCRIPTION)'
	@echo '    LEX_BOTALIAS_NAME=$(LEX_BOTALIAS_NAME)'
	@echo '    LEX_BOTALIASES_BOT_NAME=$(LEX_BOTALIASES_BOT_NAME)'
	@echo '    LEX_BOTALIASES_REGEX=$(LEX_BOTALIASES_REGEX)'
	@echo '    LEX_BOTALIASES_SET_NAME=$(LEX_BOTALIASES_SET_NAME)'
	@echo

_lex_view_framework_targets ::
	@echo 'AWS::LEX::BotAlias ($(_AWS_LEX_BOTALIAS_MK_ALIAS)) targets:'
	@echo '    _lex_create_botalias                  - Create a new bot-alias'
	@echo '    _lex_delete_botalias                  - Delete an existing bot-alias'
	@echo '    _lex_show_botalias                    - Show everything related to a bot-alias'
	@echo '    _lex_show_botalias_description        - Show description of a bot-alias'
	@echo '    _lex_update_botalias                  - Update a bot-alias'
	@echo '    _lex_view_botaliases                  - View existing bot-aliases for a bot'
	@echo '    _lex_view_botaliases_set              - View a set of bot-aliases for a bot' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lex_create_botalias:
	@$(INFO) '$(LEX_UI_LABEL)Creating/updating bot-alias "$(LEX_BOTALIAS_NAME)" to version "$(LEX_BOTALIAS_BOTVERSION_ID)" of bot "$(LEX_BOTALIAS_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models put-bot-alias $(__LEX_BOT_NAME__BOTALIAS) $(__LEX_BOT_VERSION__BOTALIAS) $(__LEX_DESCRIPTION__BOTALIAS) $(__LEX_NAME__BOTALIAS)

_lex_delete_botalias:
	@$(INFO) '$(LEX_UI_LABEL)Deleting bot-alias "$(LEX_BOTALIAS_NAME)" of bot "$(LEX_BOTALIAS_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models delete-bot-alias $(__LEX_BOT_NAME__BOTALIAS) $(__LEX_NAME__BOTALIAS) # --query "BotAliases[]"

_lex_show_botalias: _lex_show_botalias_channels _lex_show_botalias_description

_lex_show_botalias_channels:
	@$(INFO) '$(LEX_UI_LABEL)Showing channel-associations of bot-alias "$(LEX_BOTALIAS_NAME)" of bot "$(LEX_BOTALIAS_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-bot-channel-associations $(__LEX_BOT_NAME__BOTALIAS) $(__LEX_BOT_ALIAS__BOTALIAS)

_lex_show_botalias_description:
	@$(INFO) '$(LEX_UI_LABEL)Showing description of bot-alias "$(LEX_BOTALIAS_NAME)" of bot "$(LEX_BOTALIAS_BOT_NAME)" ...'; $(NORMAL)
	@#$(AWS) lex-models get-bot $(__LEX_NAME__BOTALIAS) $(__LEX_ALIAS_OR_ALIAS) # --query 'bots[]$(LEX_UI_VIEW_BOTALIASS_FIELDS)'

_lex_update_botaliases: _lex_create_botaliases

_lex_view_botaliases:
	@$(INFO) '$(LEX_UI_LABEL)Viewing all bot-aliass of bot "$(LEX_BOTALIASES_BOT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-bot-aliases $(__LEX_BOT_NAME__BOTALIASES) $(_X__LEX_NAME_CONTAINS__BOTALIASES) --query 'BotAliases[]$(LEX_UI_VIEW_BOTALIASES_FIELDS)'

_lex_view_botaliases_set:
	@$(INFO) '$(LEX_UI_LABEL)Viewing bot-aliases-set "$(LEX_BOTALIASES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Bot-aliasess are grouped based on query filter, substring ...'; $(NORMAL)
	$(AWS) lex-models get-bot-aliases $(__LEX_BOT_NAME__BOTALIASES) $(__LEX_NAME_CONTAINS__BOTALIASES) --query 'BotAliases[$(LEX_UI_VIEW_BOTALIASES_SET_QUERYFILTER)]$(LEX_UI_VIEW_BOTALIASS_SET_FIELDS)'
