_AWS_POLLY_LEXICON_MK_VERSION= $(_AWS_POLLY_MK_VERRSION)

# PLY_LEXICON_CONTENT?=
# PLY_LEXICON_CONTENT_FILEPATH?= ./in/lexicon.pls
# PLY_LEXICON_NAME?= w3c
# PLY_LEXICONS_DIRPATH?= ./lexicons.d/
# PLY_LEXICONS_REGEX?= *
# PLY_LEXICONS_SET_NAME?= my-lexicons-set

# Derived variables
PLY_LEXICON_CONTENT?= $(if $(PLY_LEXICON_CONTENT_FILEPATH),file://$(PLY_LEXICON_CONTENT_FILEPATH))
PLY_LEXICONS_SET_NAME?= $(PLY_LEXICONS_REGEX)

# Options variables
__PLY_CONTENT= $(if $(PLY_LEXICON_CONTENT),--content $(PLY_LEXICON_CONTENT))
__PLY_NAME__LEXICON= $(if $(PLY_LEXICON_NAME),--name $(PLY_LEXICON_NAME))

# UI variables
PLY_UI_VIEW_LEXICONS_FIELDS?= .{Name:Name,_LanguageCode:Attributes.LanguageCode,_Alphabet:Attributes.Alphabet,_LexemesCount:Attributes.LexemesCount,_Size:Attributes.Size}
PLY_UI_VIEW_LEXICONS_SET_FIELDS?= $(PLY_UI_VIEW_LEXICONS_FIELDS)
PLY_UI_VIEW_LEXICONS_SET_QUERYFILTER?=

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_ply_view_framework_macros ::  
	@echo 'AWS::PoLlY::Lexicon ($(_AWS_POLLY_LEXICON_MK_VERSION)) macros:'
	@echo

_ply_view_framework_parameters ::
	@echo 'AWS::PoLly::Lexicon ($(_AWS_POLLY_MK_VERSION)) parameters:'
	@echo '    PLY_LEXICON_CONTENT=$(PLY_LEXICON_CONTENT)'
	@echo '    PLY_LEXICON_CONTENT_FILEPATH=$(PLY_LEXICON_CONTENT_FILEPATH)'
	@echo '    PLY_LEXICON_NAME=$(PLY_LEXICON_NAME)'
	@echo '    PLY_LEXICONS_DIRPATH=$(PLY_LEXICONS_DIRPATH)'
	@echo '    PLY_LEXICONS_REGEX=$(PLY_LEXICONS_REGEX)'
	@echo '    PLY_LEXICONS_SET_NAME=$(PLY_LEXICONS_SET_NAME)'
	@echo

_ply_view_framework_targets ::
	@echo 'AWS::PoLly::Lexicon ($(_AWS_POLLY_LEXICON_MK_VERSION)) targets:'
	@echo '    _ply_create_lexicon                 - Create a new lexicon'
	@echo '    _ply_delete_lexicon                 - Delete an existing lexicon'
	@echo '    _ply_show_lexicon                   - Show details of a lexicon'
	@echo '    _ply_show_lexicon_attributes        - Show attribtues of a lexicon'
	@echo '    _ply_show_lexicon_content           - Show content of a lexicon'
	@echo '    _ply_show_lexicon_contentfile       - Show content-file of a lexicon'
	@echo '    _ply_view_lexicons                  - View lexicons'
	@echo '    _ply_view_lexicons_set              - View set of lexicons'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ply_create_lexicon:
	@$(INFO) '$(PLY_UI_LABEL)Creating lexicon "$(PLY_LEXICON_NAME)" ...'; $(NORMAL)
	$(if $(PLY_LEXICON_CONTENT_FILEPATH), cat $(PLY_LEXICON_CONTENT_FILEPATH))
	$(AWS) polly put-lexicon $(__PLY_CONTENT) $(__PLY_NAME__LEXICON)

_ply_delete_lexicon:
	@$(INFO) '$(PLY_UI_LABEL)Deleting lexicon "$(PLY_LEXICON_NAME)" ...'; $(NORMAL)
	$(AWS) polly delete-lexicon $(__PLY_NAME__LEXICON)

_ply_show_lexicon: _ply_show_lexicon_content _ply_show_lexicon_attributes

_ply_show_lexicon_attributes:
	@$(INFO) '$(PLY_UI_LABEL)Showing attributes of lexicon "$(PLY_LEXICON_NAME)" ...'; $(NORMAL)
	$(AWS) polly get-lexicon $(__PLY_NAME__LEXICON) --query "LexiconAttributes"

_ply_show_lexicon_content:
	@$(INFO) '$(PLY_UI_LABEL)Showing content of lexicon "$(PLY_LEXICON_NAME)" ...'; $(NORMAL)
	$(AWS)  polly get-lexicon $(__PLY_NAME__LEXICON) --query "Lexicon.Content" --output text

_ply_show_lexicon_contentfile:
	@$(INFO) '$(PLY_UI_LABEL)Showing content-file of lexicon "$(PLY_LEXICON_NAME)" ...'; $(NORMAL)
	$(if $(PLY_LEXICON_CONTENT_FILEPATH), cat $(PLY_LEXICON_CONTENT_FILEPATH))
	$(if $(PLY_LEXICON_CONTENT_FILEPATH), ls -l $(PLY_LEXICON_CONTENT_FILEPATH))

_ply_view_lexicons:
	@$(INFO) '$(PLY_UI_LABEL)Viewing lexicons ...'; $(NORMAL)
	$(AWS) polly list-lexicons --query "Lexicons[]$(PLY_UI_VIEW_LEXICONS_FIELDS)"

_ply_view_lexicons_set:
	@$(INFO) '$(PLY_UI_LABEL)Viewing lexicons-set "$(PLY_LEXICONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Lexicons are grouped based on query-filter'; $(NORMAL)
	$(AWS) polly list-lexicons --query "Lexicons[$(PLY_UI_VIEW_LEXICONS_SET_QUERYFILTER)]$(PLY_UI_VIEW_LEXICONS_SET_FIELDS)"
