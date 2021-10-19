_AWS_TRANSCRIBE_VOCABULARY_MK_VERSION = $(_AWS_TRANSCRIBE_MK_VERSION)

# TSE_VOCABULARY_LANGUAGE_CODE?=
# TSE_VOCABULARY_PHRASES?=
# TSE_VOCABULARY_NAME?=
# TSE_VOCABULARIES_SET_NAME?=

# Derived parameters
TSE_VOCABULARY_NAMES?= $(TSE_VOCABULARY_NAME)

# Option parameters
__TSE_LANGUAGE_CODE= $(if $(TSE_VOCABULARY_LANGUAGE_CODE),--language-code $(TSE_VOCABULARY_LANGUAGE_CODE))
__TSE_PHRASES= $(if $(TSE_VOCABULARY_PHRASES),--phrases $(TSE_VOCABULARY_PHRASES))
__TSE_VOCABULARY_NAME= $(if $(TSE_VOCABULARY_NAME),--vocabulary-name $(TSE_VOCABULARY_NAME))

# UI parameters

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_tse_view_framework_macros ::
	@echo 'AWS::TranScribE::Vocabulary ($(_AWS_TRANSCRIBE_VOCABULARY_MK_VERSION)) macros:'
	@echo

_tse_view_framework_parameters ::
	@echo 'AWS::TranScribE::Vocabulary ($(_AWS_TRANSCRIBE_VOCABULARY_MK_VERSION)) parameters:'
	@echo '    TSE_VOCABULARY_LANGUAGE_CODE=$(TSE_VOCABULARY_LANGUAGE_CODE)'
	@echo '    TSE_VOCABULARY_PHRASES=$(TSE_VOCABULARY_PHRASES)'
	@echo '    TSE_VOCABULARY_NAME=$(TSE_VOCABULARY_NAME)'
	@echo

_tse_view_framework_targets ::
	@echo 'AWS::TranScribE::Vocabulary ($(_AWS_TRANSCRIBE_VOCABULARY_MK_VERSION)) targets:'
	@echo '    _tse_create_vocabulary                       - Create a vocabulary'
	@echo '    _tse_delete_vocabulary                       - Delete a vocabulary'
	@echo '    _tse_show_vocabulary                         - Show everything related to a vocabulary'
	@echo '    _tse_show_vocabulary_description             - Show description of a vocabulary'
	@echo '    _tse_update_vocabulary                       - Update a vocabulary'
	@echo '    _tse_view_vocabularies                       - View existing vocabularies'
	@echo '    _tse_view_vocabularies_set                   - View a set of vocabularies'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_tse_create_vocabulary:
	@$(INFO) '$(TSE_UI_LABEL)Creating vocabulary "$(TSE_VOCABULARY_NAME)" ...'; $(NORMAL)
	$(AWS) transcribe create-vocabulary $(__TSE_LANGUAGE_CODE) $(__TSE_PHRASES) $(__TSE_VOCABULARY_NAME)

_tse_delete_vocabulary:
	@$(INFO) '$(TSE_UI_LABEL)Deleting vocabulary "$(TSE_VOCABULARY_NAME)" ...'; $(NORMAL)
	$(AWS) transcribe delete-vocabulary $(__TSE_VOCABULARY_NAME)

_tse_show_vocabulary :: _tse_show_vocabulary_description

_tse_show_vocabulary_description:
	@$(INFO) '$(TSE_UI_LABEL)Showing description of vocabulary "$(TSE_VOCABULARY_NAME)" ...'; $(NORMAL)
	$(AWS) transcribe get-vocabulary $(__TSE_VOCABULARY_NAME)

_tse_update_vocabulary:
	@$(INFO) '$(TSE_UI_LABEL)Updating vocabulary "$(TSE_VOCABULARY_NAME)" ...'; $(NORMAL)
	$(AWS) transcribe update-vocabulary $(__TSE_LANGUAGE_CODE) $(__TSE_PHRASES) $(__TSE_VOCABULARY_NAME)

_tse_view_vocabularies:
	@$(INFO) '$(TSE_UI_LABEL)Viewing ALL vocabularies ...'; $(NORMAL)
	$(AWS) transcribe list-vocabularies $(__TSE_NAME_CONTAINS) $(__TSE_STATE_EQUALS)

_tse_view_vocabularies_set:
	@$(INFO) '$(TSE_UI_LABEL)Viewing vocabularies-set "$(TSE_VOCABULARIES_SET_NAME)" ...'; $(NORMAL)

