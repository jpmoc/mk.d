_AWS_LEX_BUILTININTENT_MK_VERSION= $(_AWS_LEX_MK_VERSION)

# LEX_BUILTININTENT_NAME?= my-intent-name
# LEX_BUILTINTINTENT_SIGNATURE_NAME?= AMAZON.StopIntent
# LEX_BUILTININTENTS_LOCALE?= en-US
# LEX_BUILTININTENTS_SET_NAME?= my-intents-set
# LEX_BUILTININTENTS_SIGNATURE_REGEX?=

# Derived parameters
LEX_BUILTININTENT_NAME?= $(LEX_BUILTININTENT_SIGNATURE_NAME)

# Option parameters
__LEX_NAME__BUILTININTENT= $(if $(LEX_BUILTININTENT_NAME),--name $(LEX_BUILTININTENT_NAME))
__LEX_SIGNATURE__BUILTININTENT= $(if $(LEX_BUILTININTENT_SIGNATURE_NAME),--signature $(LEX_BUILTININTENT_SIGNATURE_NAME))
__LEX_LOCALE__BUILTININTENTS= $(if $(LEX_BUILTININTENTS_LOCALE),--locale $(LEX_BUILTININTENTS_LOCALE))
__LEX_SIGNATURE_CONTAINS__BUILTININTENTS= $(if $(LEX_BUILTININTENTS_SIGNATURE_REGEX),--signature-contains $(LEX_BUILTININTENTS_SIGNATURE_REGEX))

# UI parameters
LEX_UI_VIEW_BUILTININTENTS_FIELDS?=
LEX_UI_VIEW_BUILTININTENTS_SET_FIELDS?= $(LEX_UI_VIEW_BUILTININTENTS_FIELDS)
LEX_UI_VIEW_BUILTININTENTS_SET_QUERYFILTER?=

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_lex_view_framework_macros ::
	@echo 'AWS::LEX::BuiltinIntent ($(_AWS_LEX_BUILTININTENT_MK_VERSION)) macros:'
	@echo

_lex_view_framework_parameters ::
	@echo 'AWS::LEX::BuiltinIntent ($(_AWS_LEX_BUILTININTENT_MK_VERSION)) parameters:'
	@echo '    LEX_BUILTININTENT_NAME=$(LEX_BUILTININTENT_NAME)'
	@echo '    LEX_BUILTININTENT_SIGNATURE_NAME=$(LEX_BUILTININTENT_SIGNATURE_NAME)'
	@echo '    LEX_BUILTININTENTS_LOCALE=$(LEX_BUILTININTENTS_LOCALE)'
	@echo '    LEX_BUILTININTENTS_SIGNATURE_REGEX=$(LEX_BUILTININTENTS_SIGNATURE_REGEX)'
	@echo '    LEX_BUILTININTENTS_SET_NAME=$(LEX_BUILTININTENTS_SET_NAME)'
	@echo

_lex_view_framework_targets ::
	@echo 'AWS::LEX::BuiltinIntent ($(_AWS_LEX_BUILTININTENT_MK_VERSION)) targets:'
	@echo '    _lex_create_builtinintent                  - Create a new intent'
	@echo '    _lex_delete_builtinintent                  - Delete an existing intent'
	@echo '    _lex_show_builtinintent                    - Show everything related to an intent'
	@echo '    _lex_show_builtinintent_description        - Show description of an intent'
	@echo '    _lex_update_builtinintent                  - Update an existing intent'
	@echo '    _lex_view_builtinintents                   - View existing intents'
	@echo '    _lex_view_builtinintents_set               - View a set of intents' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lex_create_builtinintent:
	@$(INFO) '$(LEX_UI_LABEL)Creating builtin-intent "$(LEX_BUILTININTENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is NOT permitted!'; $(NORMAL)

_lex_delete_builtinintent:
	@$(INFO) '$(LEX_UI_LABEL)Deleting an existing builtin-intent "$(LEX_BUILTININTENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is NOT permitted!'; $(NORMAL)

_lex_show_builtinintent:: _lex_show_builtinintent_description

_lex_show_builtinintent_description:
	@$(INFO) '$(LEX_UI_LABEL)Showing description of builtin-intent "$(LEX_BUILTININTENT_NAME)" ...'; $(NORMAL)
	$(AWS) lex-models get-builtin-intent $(__LEX_SIGNATURE__BUILTININTENT)

_lex_update_builtinintent:
	@$(INFO) '$(LEX_UI_LABEL)Updating builtin-intent "$(LEX_BUILTININTENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is NOT permitted!'; $(NORMAL)

_lex_view_builtinintents:
	@$(INFO) '$(LEX_UI_LABEL)Viewing all builtin-intents ...'; $(NORMAL)
	$(AWS) lex-models get-builtin-intents $(_X__LEX_LOCALE__BUILTININTENTS) $(_X__LEX_SIGNATURE_CONTAINS__BUILTININTENTS) --query 'intents[]$(LEX_UI_VIEW_BUILTININTENTS_FIELDS)'

_lex_view_builtinintents_set:
	@$(INFO) '$(LEX_UI_LABEL)Viewing builtin-intents-set "$(LEX_BUILTININTENTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Builtin-intents are grouped based on locale, signature-substring, and query-filter'; $(NORMAL)
	$(AWS) lex-models get-builtin-intents $(__LEX_LOCALE__BUILTININTENTS) $(__LEX_SIGNATURE_CONTAINS__BUILTININTENTS) --query 'intents[$(LEX_UI_VIEW_BUILTININTENTS_SET_QUERYFILTER)]$(LEX_UI_VIEW_BUILTININTENTS_SET_FIELDS)'
