_AWS_LEX_BOTCHANNELASSOCIATION_MK_VERSION= $(_AWS_LEX_MK_VERSION)

# LEX_BOTCHANNELASSOCIATION_BOT_NAME?= bot-name
# LEX_BOTCHANNELASSOCIATION_BOTALIAS_NAME?= bot-name
# LEX_BOTCHANNELASSOCIATION_NAME?= bot-name
# LEX_BOTCHANNELASSOCIATIONS_REGEX?=
# LEX_BOTCHANNELASSOCIATIONS_SET_NAME?= my-bots-set

# Derived parameters
LEX_BOTCHANNELASSOCIATION_BOT_NAME?= $(LEX_BOT_NAME)
LEX_BOTCHANNELASSOCIATION_BOTALIAS_NAME?= $(LEX_BOTALIAS_NAME)
LEX_BOTCHANNELASSOCIATIONS_BOT_NAME?= $(LEX_BOTCHANNELASSOCIATION_BOT_NAME)
LEX_BOTCHANNELASSOCIATIONS_BOTALIAS_NAME?= $(LEX_BOTCHANNELASSOCIATION_BOTALIAS_NAME)

# Option parameters
__LEX_BOT_ALIAS__BOTCHANNELASSOCIATION= $(if $(LEX_BOTCHANNELASSOCIATION_BOTALIAS_NAME),--bot-alias $(LEX_BOTCHANNELASSOCIATION_BOTALIAS_NAME))
__LEX_BOT_ALIAS__BOTCHANNELASSOCIATIONS= $(if $(LEX_BOTCHANNELASSOCIATIONS_BOTALIAS_NAME),--bot-alias $(LEX_BOTCHANNELASSOCIATIONS_BOTALIAS_NAME))
__LEX_BOT_NAME__BOTCHANNELASSOCIATION= $(if $(LEX_BOTCHANNELASSOCIATION_BOT_NAME),--bot-name $(LEX_BOTCHANNELASSOCIATION_BOT_NAME))
__LEX_BOT_NAME__BOTCHANNELASSOCIATIONS= $(if $(LEX_BOTCHANNELASSOCIATIONS_BOT_NAME),--bot-name $(LEX_BOTCHANNELASSOCIATIONS_BOT_NAME))
__LEX_NAME__BOTCHANNELASSOCIATION= $(if $(LEX_BOTCHANNELASSOCIATION_NAME),--name $(LEX_BOTCHANNELASSOCIATION_NAME))
__LEX_NAME_CONTAINS__BOTCHANNELASSOCIATIONS= $(if $(LEX_BOTCHANNELASSOCIATIONS_REGEX),--name-contains $(LEX_BOTCHANNELASSOCIATIONS_REGEX))

# UI parameters
LEX_UI_VIEW_BOTCHANNELASSOCIATIONS_FIELDS?=
LEX_UI_VIEW_BOTCHANNELASSOCIATIONS_SET_FIELDS?= $(LEX_UI_VIEW_BOTCHANNELASSOCIATIONS_FIELDS)
LEX_UI_VIEW_BOTCHANNELASSOCIATIONS_SET_QUERYFILTER?=

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_lex_view_framework_macros ::
	@echo 'AWS::LEX::BotChannelAssociation ($(_AWS_LEX_BOTCHANNELASSOCIATION_MK_VERSION)) macros:'
	@echo

_lex_view_framework_parameters ::
	@echo 'AWS::LEX::BotChannelAssociation ($(_AWS_LEX_BOTCHANNELASSOCIATION_MK_VERSION)) parameters:'
	@echo '    LEX_BOTCHANNELASSOCIATION_BOT_NAME=$(LEX_BOTCHANNELASSOCIATION_BOT_NAME)'
	@echo '    LEX_BOTCHANNELASSOCIATION_BOTALIAS_NAME=$(LEX_BOTCHANNELASSOCIATION_BOTALIAS_NAME)'
	@echo '    LEX_BOTCHANNELASSOCIATION_NAME=$(LEX_BOTCHANNELASSOCIATION_NAME)'
	@echo '    LEX_BOTCHANNELASSOCIATIONS_BOT_NAME=$(LEX_BOTCHANNELASSOCIATIONS_BOT_NAME)'
	@echo '    LEX_BOTCHANNELASSOCIATIONS_BOTALIAS_NAME=$(LEX_BOTCHANNELASSOCIATIONS_BOTALIAS_NAME)'
	@echo '    LEX_BOTCHANNELASSOCIATIONS_REGEX=$(LEX_BOTCHANNELASSOCIATIONS_REGEX)'
	@echo '    LEX_BOTCHANNELASSOCIATIONS_SET_NAME=$(LEX_BOTCHANNELASSOCIATIONS_SET_NAME)'
	@echo

_lex_view_framework_targets ::
	@echo 'AWS::LEX::BotChannelAssociation ($(_AWS_LEX_BOTCHANNELASSOCIATION_MK_VERSION)) targets:'
	@echo '    _lex_create_botchannelassociation            - Create a new bot-channel-association'
	@echo '    _lex_delete_botchannelassociation            - Delete an existing bot-channel-association'
	@echo '    _lex_show_botchannelassociation              - Show everything related to a bot-channel-association'
	@echo '    _lex_show_botchannelassociation_description  - Show description of a bot-channel-association'
	@echo '    _lex_view_botchannelassociations             - View existing bot-channel-associations'
	@echo '    _lex_view_botchannelassociations_set         - View a set of bot-channel-associations' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lex_create_botchannelassociation:
	@$(INFO) '$(LEX_UI_LABEL)Creating bot-channel-association "$(LEX_BOTCHANNELASSOCIATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This opeation is not supported!'; $(NORMAL)

_lex_delete_botchannelassociation:
	@$(INFO) '$(LEX_UI_LABEL)Deleting bot-channel-association "$(LEX_BOTCHANNELASSOCIATION_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models delete-bot-channel-association $(__LEX_BOT_ALIAS__BOTCHANNELASSOCIATION) $(__LEX_BOT_NAME__BOTCHANNELASSOIATION) $(__LEX_NAME__BOTCHANNELASSOCIATION)

_lex_show_botchannelassociation:: _lex_show_botchannelassociation_description

_lex_show_botchannelassociation_description:
	@$(INFO) '$(LEX_UI_LABEL)Showing description of bot-channel-association "$(LEX_BOTCHANNELASSOCIATION_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-bot $(__LEX_NAME__BOTCHANNELASSOCIATION) $(__LEX_VERSION_OR_ALIAS) # --query 'bots[]$(LEX_UI_VIEW_BOTCHANNELASSOCIATIONS_FIELDS)'

_lex_view_botchannelassociations:
	@$(INFO) '$(LEX_UI_LABEL)Viewing all bot-channel-associations ...'; $(NORMAL)
	$(AWS) lex-models get-bot-channel-associations $(__LEX_BOT_ALIAS__BOTCHANNELASSOCIATIONS) $(__LEX_BOT_NAME__BOTCHANNELASSOCIATIONS) $(_X__LEX_NAME_CONTAINS__BOTCHANNELASSOCIATIONS) # --query 'bots[]$(LEX_UI_VIEW_BOTCHANNELASSOCIATIONS_FIELDS)'

_lex_view_botchannelassociations_set:
	@$(INFO) '$(LEX_UI_LABEL)Viewing bot-channel-associations-set "$(LEX_BOTCHANNELASSOCIATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Bots are grouped based on query filter, substring ...'; $(NORMAL)
	$(AWS) lex-models get-bot-channel-associations $(__LEX_BOT_ALIAS__BOTCHANNELASSOCIATIONS) $(__LEX_BOT_NAME__BOTCHANNELASSOCIATIONS) $(__LEX_NAME_CONTAINS__BOTCHANNELASSOCIATIONS) # --query 'bots[$(LEX_UI_VIEW_BOTCHANNELASSOCIATIONS_SET_QUERYFILTER)]$(LEX_UI_VIEW_BOTCHANNELASSOCIATIONS_SET_FIELDS)'
