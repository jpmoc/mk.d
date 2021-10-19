_AWS_LEX_SLOTTYPE_MK_VERSION= $(_AWS_LEX_MK_VERSION)

# LEX_SLOTTYPE_CHECKSUM?= c51826f1-2a6c-4f99-90d9-91bc3deadca3
LEX_SLOTTYPE_CREATEVERSION_ENABLE?= false
# LEX_SLOTTYPE_DESCRIPTION?= "This is my slottype"
# LEX_SLOTTYPE_NAME?= my-slottype-name
# LEX_SLOTTYPE_VALUES_CONFIGS?= value=string,synonyms=string,string ...
LEX_SLOTTYPE_VALUES_STRATEGY?= ORIGINAL_VALUE
# LEX_SLOTTYPE_VERSION_ID?= 1
# LEX_SLOTTYPES_REGEX?=
# LEX_SLOTTYPES_SET_NAME?= my-slot-types-set

# Derived parameters
LEX_SLOTTYPE_VERSION_ID?= $(LEX_SLOTTYPEVERSION_ID)

# Option parameters
__LEX_CHECKSUM__SLOTTYPE= $(if $(LEX_SLOTTYPE_CHECKSUM),--checksum $(LEX_SLOTTYPE_CHECKSUM))
__LEX_CREATE_VERSION__SLOTTYPE= $(if $(filter true, $(LEX_SLOTTYPE_CREATEVERSION_ENABLE)),--create-version, --no-create-version)
__LEX_DESCRIPTION__SLOTTYPE= $(if $(LEX_SLOTTYPE_DESCRIPTION),--description $(LEX_SLOTTYPE_DESCRIPTION))
__LEX_EXPORT_TYPE__SLOTTYPE=
__LEX_ENUMERATION_VALUES= $(if $(LEX_SLOTTYPE_VALUES_CONFIGS),--enumeration-values $(LEX_SLOTTYPE_VALUES_CONFIGS))
__LEX_NAME__SLOTTYPE= $(if $(LEX_SLOTTYPE_NAME),--name $(LEX_SLOTTYPE_NAME))
__LEX_NAME_CONTAINS__SLOTTYPES= $(if $(LEX_SLOTTYPES_REGEX),--name-contains $(LEX_SLOTTYPES_REGEX))
__LEX_RESOURCE_TYPE__SLOTTYPE=
__LEX_RESOURCE_VERSION__SLOTTYPE= $(if $(LEX_SLOTTYPE_VERSION_ID),--resource-version $(LEX_SLOTTYPE_VERSION_ID))
__LEX_SLOT_TYPE_VERSION= $(if $(LEX_SLOTTYPE_VERSION_ID),--slot-type-version $(LEX_SLOTTYPE_VERSION_ID))
__LEX_VALUE_SELECTION_STRATEGY= $(if $(LEX_SLOTTYPE_VALUES_STRATEGY),--value-selection-strategy $(LEX_SLOTTYPE_VALUES_STRATEGY))

# UI parameters
LEX_UI_VIEW_SLOTTYPES_FIELDS?=
LEX_UI_VIEW_SLOTTYPES_SET_FIELDS?= $(LEX_UI_VIEW_SLOTTYPES_FIELDS)
LEX_UI_VIEW_SLOTTYPES_SET_QUERYFILTER?=

#--- Utilities

#--- Macros
_lex_get_slottype_checksum= $(call _lex_get_slottype_checksum_V, $(LEX_SLOTTYPE_VERSION_ID))
_lex_get_slottype_checksum_V= $(call _lex_get_slottype_checksum_VN, $(1), $(LEX_SLOTTYPE_NAME))
_lex_get_slottype_checksum_VN= $(shell $(AWS) lex-models get-slot-type --slot-type-version $(1) --name $(2) --query 'checksum' --output text)

#----------------------------------------------------------------------
# USAGE
#

_lex_view_framework_macros ::
	@echo 'AWS::LEX::SlotType ($(_AWS_LEX_SLOTTYPE_MK_VERSION)) macros:'
	@echo '    _lex_get_slottype_checksum_{|V|VN}      - Get the checksum of an slot-type (Version,botName)'
	@echo

_lex_view_framework_parameters ::
	@echo 'AWS::LEX::SlotType ($(_AWS_LEX_SLOTTYPE_MK_VERSION)) parameters:'
	@echo '    LEX_SLOTTYPE_CHECKSUM=$(LEX_SLOTTYPE_CHECKSUM)'
	@echo '    LEX_SLOTTYPE_CREATEVERSION_ENABLE=$(LEX_SLOTTYPE_CREATEVERSION_ENABLE)'
	@echo '    LEX_SLOTTYPE_DESCRIPTION=$(LEX_SLOTTYPE_DESCRIPTION)'
	@echo '    LEX_SLOTTYPE_NAME=$(LEX_SLOTTYPE_NAME)'
	@echo '    LEX_SLOTTYPE_VALUES_CONFIGS=$(LEX_SLOTTYPE_VALUES_CONFIGS)'
	@echo '    LEX_SLOTTYPE_VALUES_STRATEGY=$(LEX_SLOTTYPE_VALUES_STRATEGY)'
	@echo '    LEX_SLOTTYPE_VERSION_ID=$(LEX_SLOTTYPE_VERSION_ID)'
	@echo '    LEX_SLOTTYPES_REGEX=$(LEX_SLOTTYPES_REGEX)'
	@echo '    LEX_SLOTTYPES_SET_NAME=$(LEX_SLOTTYPES_SET_NAME)'
	@echo

_lex_view_framework_targets ::
	@echo 'AWS::LEX::SlotType ($(_AWS_LEX_SLOTTYPE_MK_VERSION)) targets:'
	@echo '    _lex_create_slottype                  - Create a new slot-type'
	@echo '    _lex_delete_slottype                  - Delete an existing slot-type'
	@echo '    _lex_export_slottype                  - Export a slot-type'
	@echo '    _lex_import_slottype                  - Import a slot-type'
	@echo '    _lex_show_slottype                    - Show everything related to an slot-type'
	@echo '    _lex_show_slottype_description        - Show description of an slot-type'
	@echo '    _lex_show_slottype_versions           - Show versions of an slot-type'
	@echo '    _lex_update_slottype                  - Update an existing slot-type'
	@echo '    _lex_view_slottypes                   - View existing slot-types'
	@echo '    _lex_view_slottypes_set               - View a set of slot-types' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lex_create_slottype:
	@$(INFO) '$(LEX_UI_LABEL)Creating slot-type "$(LEX_SLOTTYPE_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models put-slot-type $(strip $(_X__LEX_CHECKSUM__SLOTTYPE) $(__LEX_CREATE_VERSION__SLOTTYPE) $(__LEX_DESCRIPTION__SLOTTYPE) $(__LEX_ENUMERATION_VALUES) $(__LEX_NAME__SLOTTYPE) $(__LEX_VALUE_SELECTION_STRATEGY))

_lex_delete_slottype:
	@$(INFO) '$(LEX_UI_LABEL)Deleting an existing slot-type "$(LEX_SLOTTYPE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation deletes a slot-type and all its versions'; $(NORMAL)
	-$(AWS) lex-models delete-slot-type $(__LEX_NAME__SLOTTYPE)

_lex_export_slottype:
	@$(INFO) '$(LEX_UI_LABEL)Exporting slot-type "$(LEX_SLOTTYPE_NAME)" ...'; $(NORMAL)
	# To implement

_lex_import_slottype:
	@$(INFO) '$(LEX_UI_LABEL)Importing slot-type "$(LEX_SLOTTYPE_NAME)" ...'; $(NORMAL)
	# To implement

_lex_show_slottype:: _lex_show_slottype_versions _lex_show_slottype_description

_lex_show_slottype_description:
	@$(INFO) '$(LEX_UI_LABEL)Showing description of version "$(LEX_SLOTTYPE_VERSION_ID)" of slot-type "$(LEX_SLOTTYPE_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-slot-type $(__LEX_NAME__SLOTTYPE) $(__LEX_SLOT_TYPE_VERSION)

_lex_show_slottype_versions:
	@$(INFO) '$(LEX_UI_LABEL)Showing versions of slot-type "$(LEX_SLOTTYPE_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-slot-type-versions $(__LEX_NAME__SLOTTYPE) --query "slotTypes[]"

_lex_update_slottype:
	@$(INFO) '$(LEX_UI_LABEL)Updating slot-type "$(LEX_SLOTTYPE_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models put-slot-type $(strip $(__LEX_CHECKSUM__SLOTTYPE) $(__LEX_CREATE_VERSION) $(__LEX_DESCRIPTION__SLOTTYPE) $(__LEX_ENUMERATION_VALUES) $(__LEX_NAME__SLOTTYPE) $(__LEX_VALUE_SELECTION_STRATEGY))

_lex_view_slottypes:
	@$(INFO) '$(LEX_UI_LABEL)Viewing all slot-types ...'; $(NORMAL)
	$(AWS) lex-models get-slot-types $(_X__LEX_NAME_CONTAINS__SLOTTYPES) --query 'slotTypes[]$(LEX_UI_VIEW_SLOTTYPES_FIELDS)'

_lex_view_slottypes_set:
	@$(INFO) '$(LEX_UI_LABEL)Viewing slot-types-set "$(LEX_SLOTTYPES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Slot-types are grouped based on a slot-type substring and query-filter'; $(NORMAL)
	$(AWS) lex-models get-slot-types $(__LEX_NAME_CONTAINS__SLOTTYPES) --query 'slotTypes[$(LEX_UI_VIEW_SLOTTYPES_SET_QUERYFILTER)]$(LEX_UI_VIEW_SLOTTYPES_SET_FIELDS)'
