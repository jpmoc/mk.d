_AWS_LEX_SLOTTYPEVERSION_MK_VERSION= $(_AWS_LEX_MK_VERSION)

# LEX_SLOTTYPEVERSION_SLOTTYPE_NAME?= my-slot-type-name
# LEX_SLOTTYPEVERSION_CHECKSUM?= db982235-a5bb-4554-994e-55012f461efc
# LEX_SLOTTYPEVERSION_ID?= 1
# LEX_SLOTTYPEVERSION_NAME?= First
# LEX_SLOTTYPEVERSIONS_SLOTTYPE_NAME?= my-slot-type-name
# LEX_SLOTTYPEVERSIONS_SET_NAME?= my-slot-typeversions-set

# Derived parameters
LEX_SLOTTYPEVERSION_SLOTTYPE_NAME?= $(LEX_SLOTTYPE_NAME)
LEX_SLOTTYPEVERSION_NAME?= $(LEX_SLOTTYPEVERSION_ID)
LEX_SLOTTYPEVERSIONS_SLOTTYPE_NAME?= $(LEX_SLOTTYPEVERSION_SLOTTYPE_NAME)

# Option parameters
__LEX_CHECKSUM__SLOTTYPEVERSION= $(if $(LEX_SLOTTYPEVERSION_CHECKSUM),--checksum $(LEX_SLOTTYPEVERSION_CHECKSUM))
__LEX_NAME__SLOTTYPEVERSION= $(if $(LEX_SLOTTYPEVERSION_SLOTTYPE_NAME),--name $(LEX_SLOTTYPEVERSION_SLOTTYPE_NAME))
__LEX_NAME__SLOTTYPEVERSIONS= $(if $(LEX_SLOTTYPEVERSIONS_SLOTTYPE_NAME),--name $(LEX_SLOTTYPEVERSIONS_SLOTTYPE_NAME))
__LEX_SLOTTYPE_VERSION= $(if $(LEX_SLOTTYPEVERSION_ID),--slot-type-version $(LEX_SLOTTYPEVERSION_ID))

# UI parameters
LEX_UI_VIEW_SLOTTYPEVERSIONS_FIELDS?=
LEX_UI_VIEW_SLOTTYPEVERSIONS_SET_FIELDS?= $(LEX_UI_VIEW_SLOTTYPEVERSIONS_FIELDS)
LEX_UI_VIEW_SLOTTYPEVERSIONS_SET_QUERYFILTER?=

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_lex_view_framework_macros ::
	@echo 'AWS::LEX::BotVersion ($(_AWS_LEX_SLOTTYPEVERSION_MK_VERSION)) macros:'
	@echo

_lex_view_framework_parameters ::
	@echo 'AWS::LEX::BotVersion ($(_AWS_LEX_SLOTTYPEVERSION_MK_VERSION)) parameters:'
	@echo '    LEX_SLOTTYPEVERSION_SLOTTYPE_NAME=$(LEX_SLOTTYPEVERSION_SLOTTYPE_NAME)'
	@echo '    LEX_SLOTTYPEVERSION_CHECKSUM=$(LEX_SLOTTYPEVERSION_CHECKSUM)'
	@echo '    LEX_SLOTTYPEVERSION_ID=$(LEX_SLOTTYPEVERSION_ID)'
	@echo '    LEX_SLOTTYPEVERSION_NAME=$(LEX_SLOTTYPEVERSION_NAME)'
	@echo '    LEX_SLOTTYPEVERSIONS_SLOTTYPE_NAME=$(LEX_SLOTTYPEVERSIONS_SLOTTYPE_NAME)'
	@echo '    LEX_SLOTTYPEVERSIONS_SET_NAME=$(LEX_SLOTTYPEVERSIONS_SET_NAME)'
	@echo

_lex_view_framework_targets ::
	@echo 'AWS::LEX::BotVersion ($(_AWS_LEX_SLOTTYPEVERSION_MK_VERSION)) targets:'
	@echo '    _lex_create_slottypeversion                  - Create a new slot-type-version'
	@echo '    _lex_delete_slottypeversion                  - Delete an existing slot-type-version'
	@echo '    _lex_show_slottypeversion                    - Show everything related to a slot-type-version'
	@echo '    _lex_show_slottypeversion_description        - Show description of a slot-type-version'
	@#echo '    _lex_update_slottypeversion                  - Update an existingslot-type-version'
	@echo '    _lex_view_slottypeversions                   - View existing slot-type-version'
	@echo '    _lex_view_slottypeversions_set               - View a set of slot-type-version' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lex_create_slottypeversion:
	@$(INFO) '$(LEX_UI_LABEL)Creating slot-type-version "$(LEX_SLOTTYPEVERSION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a new version to LATEST or the slot-type with provided checksum'; $(NORMAL)
	@$(WARN) 'This operation creates a new version only if no other version already points to this checksum'; $(NORMAL)
	$(AWS) lex-models create-slot-type-version $(__LEX_CHECKSUM__SLOTTYPEVERSION) $(__LEX_NAME__SLOTTYPEVERSION)

_lex_delete_slottypeversion:
	@$(INFO) '$(LEX_UI_LABEL)Deleting slot-type-version "$(LEX_SLOTTYPEVERSION_NAME)" of slot-type "$(LEX_SLOTTYPEVERSION_SLOTTYPE_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models delete-slot-type-version $(__LEX_NAME__SLOTTYPEVERSION) $(__LEX_SLOTTYPE_VERSION) # --query "BotAliases[]"

_lex_show_slottypeversion: _lex_show_slottypeversion_description

_lex_show_slottypeversion_description:
	@$(INFO) '$(LEX_UI_LABEL)Showing description of slot-type-version "$(LEX_SLOTTYPEVERSION_NAME)" ...'; $(NORMAL)
	#$(AWS) lex-models get-slot-type-versions $(__LEX_NAME__SLOTTYPEVERSION) $(__LEX_VERSION_OR_ALIAS) # --query 'slot-types[]$(LEX_UI_VIEW_SLOTTYPEVERSIONS_FIELDS)'

_lex_update_slottypeversion:
	@$(INFO) '$(LEX_UI_LABEL)Updating slot-type-version "$(LEX_SLOTTYPEVERSION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is NOT available'; $(NORMAL)

_lex_view_slottypeversions:
	@$(INFO) '$(LEX_UI_LABEL)Viewing all slot-type-versions of slot-type "$(LEX_SLOTTYPEVERSIONS_SLOTTYPE_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-slot-type-versions $(__LEX_NAME__SLOTTYPEVERSIONS) --query 'slotTypes[]$(LEX_UI_VIEW_SLOTTYPEVERSIONS_FIELDS)'

_lex_view_slottypeversions_set:
	@$(INFO) '$(LEX_UI_LABEL)Viewing slot-type-version-set "$(LEX_SLOTTYPEVERSIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Bots are grouped based on query filter, substring ...'; $(NORMAL)
	$(AWS) lex-models get-slot-type-version $(__LEX_NAME_CONTAINS__SLOTTYPEVERSIONS) --query 'slotTypes[$(LEX_UI_VIEW_SLOTTYPEVERSIONS_SET_QUERYFILTER)]$(LEX_UI_VIEW_SLOTTYPEVERSIONS_SET_FIELDS)'
