_YQ_CONTEXT_MK_VERSION= $(_YQ_MK_VERSION)

# YQ_CONTEXT_FILEPATH?= ./context.yaml
YQ_CONTEXT_NAME?= _active_context
YQ_CONTEXT_PARAMETER_PATH?= _description
# YQ_CONTEXT_PARAMETER_QUERY?= path.to.section.path.to.parameter[]
YQ_CONTEXT_RAWOUTPUT_FLAG?= true#false
# YQ_CONTEXT_SECTION_PATH?= section.path
# YQ_CONTEXT_SECTION_QUERY?= .section.path
# YQ_CONTEXT_VALUE?=
YQ_CONTEXT_VALUE_DEFAULT?= ""
YQ_CONTEXTS_DIRPATH?= ./
YQ_CONTEXTS_FILENAME?= contexts.yaml
# YQ_CONTEXTS_FILEPATH?= ./contexts.yaml
# YQ_CONTEXTS_REGEX?= *
# YQ_CONTEXTS_SET_NAME?= contexts@context.yaml

# Derived parameters
YQ_CONTEXT_FILEPATH?= $(YQ_CONTEXTS_FILEPATH)
YQ_CONTEXT_PARAMETER_QUERY?= '$(if $(YQ_CONTEXT_SECTION_PATH),.$(YQ_CONTEXT_SECTION_PATH)).$(YQ_CONTEXT_PARAMETER_PATH) // $(YQ_CONTEXT_VALUE_DEFAULT)'
YQ_CONTEXT_SECTION_PATH?= $(YQ_CONTEXT_NAME)
YQ_CONTEXT_SECTION_QUERY?= '$(if $(YQ_CONTEXT_SECTION_PATH),.$(YQ_CONTEXT_SECTION_PATH)) // $(YQ_CONTEXT_VALUE_DEFAULT)'
YQ_CONTEXTS_FILEPATH?= $(if $(YQ_CONTEXTS_FILENAME),$(YQ_CONTEXTS_DIRPATH)$(YQ_CONTEXTS_FILENAME))
YQ_CONTEXTS_SET_NAME?= contexts@$(YQ_CONTEXTS_FILEPATH)

# Options

# Customizations
_YQ_QUERY_CONTEXT_|?=
_YQ_SHOW_CONTEXT_|?=

# Macros
_yq_get_context_name= $(call _yq_get_context_name_F, $(YQ_CONTEXT_FILEPATH))
_yq_get_context_name_F= $(shell $(YQ_BIN) eval '.default._context_name // ""' $(1))

_yq_get_context_rawvalue= $(call _yq_get_context_rawvalue_P, $(YQ_CONTEXT_PARAMETER_PATH))
_yq_get_context_rawvalue_P= $(call _yq_get_context_rawvalue_PD, $(1), $(YQ_CONTEXT_VALUE_DEFAULT))
_yq_get_context_rawvalue_PD= $(call _yq_get_context_rawvalue_PDS, $(1), $(2), $(YQ_CONTEXT_SECTION_PATH))
_yq_get_context_rawvalue_PDS= $(call _yq_get_context_rawvalue_PDSF, $(1), $(2), $(3), $(YQ_CONTEXT_FILEPATH))
_yq_get_context_rawvalue_PDSF= $(shell $(YQ_BIN) eval '$(if $(3),.$(strip $(3))).$(strip $(1)) // $(2)' $(4))

_yq_get_context_value= $(call _yq_get_context_value_P, $(YQ_CONTEXT_PARAMETER_PATH))
_yq_get_context_value_P= $(call _yq_get_context_value_PD, $(1), $(YQ_CONTEXT_VALUE_DEFAULT))
_yq_get_context_value_PD= $(call _yq_get_context_value_PDS, $(1), $(2), $(YQ_CONTEXT_SECTION_PATH))
_yq_get_context_value_PDS= $(call _yq_get_context_value_PDSF, $(1), $(2), $(3), $(YQ_CONTEXT_FILEPATH))
_yq_get_context_value_PDSF= $(shell $(YQ_BIN) eval '$(if $(3),.$(strip $(3))).$(strip $(1)) // $(2)' $(4))

#----------------------------------------------------------------------
# USAGE
#

_yq_list_macros ::
	@echo 'YQ::Context ($(_YQ_CONTEXT_MK_VERSION)) macros:'
	@echo '    _yq_get_context_name_{|F}                 - Get the name of the context (Filepath)'
	@echo '    _yq_get_context_rawvalue_{P|PD|PDS|PDSF}  - Get a raw value from a config-file (Parameter,Default,Section,Filepath)'
	@echo '    _yq_get_context_value_{P|PD|PDS|PDSF}     - Get a value from a config-file (Parameter,Default,Section,Filepath)'
	@echo

_yq_list_parameters ::
	@echo 'YQ::Context ($(_YQ_CONTEXT_MK_VERSION)) parameters:'
	@echo '    YQ_CONTEXT_FILEPATH=$(YQ_CONTEXT_FILEPATH)'
	@echo '    YQ_CONTEXT_NAME=$(YQ_CONTEXT_NAME)'
	@echo '    YQ_CONTEXT_PARAMETER_PATH=$(YQ_CONTEXT_PARAMETER_PATH)'
	@echo '    YQ_CONTEXT_PARAMETER_QUERY=$(YQ_CONTEXT_PARAMETER_QUERY)'
	@echo '    YQ_CONTEXT_SECTION_PATH=$(YQ_CONTEXT_SECTION_PATH)'
	@echo '    YQ_CONTEXT_SECTION_QUERY=$(YQ_CONTEXT_SECTION_QUERY)'
	@echo '    YQ_CONTEXT_VALUE=$(YQ_CONTEXT_VALUE)'
	@echo '    YQ_CONTEXT_VALUE_DEFAULT=$(YQ_CONTEXT_VALUE_DEFAULT)'
	@echo '    YQ_CONTEXTS_DIRPATH=$(YQ_CONTEXTS_DIRPATH)'
	@echo '    YQ_CONTEXTS_FILENAME=$(YQ_CONTEXTS_FILENAME)'
	@echo '    YQ_CONTEXTS_FILEPATH=$(YQ_CONTEXTS_FILEPATH)'
	@echo '    YQ_CONTEXTS_REGEX=$(YQ_CONTEXTS_REGEX)'
	@echo '    YQ_CONTEXTS_SET_NAME=$(YQ_CONTEXTS_SET_NAME)'
	@echo

_yq_list_targets ::
	@echo 'YQ::Context ($(_YQ_CONTEXT_MK_VERSION)) targets:'
	@echo '    _yq_list_contexts                      - List all contexts'
	@echo '    _yq_list_contexts_set                  - List a set of contexts'
	@echo '    _yq_query_context                      - Query for a parameter in a context'
	@echo '    _yq_show_context                       - Show everything related to the context'
	@echo '    _yq_show_context_description           - Show description of the context'
	@echo '    _yq_show_context_parameters            - Show the parameters in the context'
	@echo '    _yq_writing_contexts                   - Writing manifest for one-o-rmore contexts'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_yq_list_contexts:
	@$(INFO) '$(YQ_UI_LABEL)Listing ALL contexts ...'; $(NORMAL)
	grep -E '^[a-zA-Z0-9]' $(YQ_CONTEXTS_FILEPATH) | sed -e 's/:.*//'

_yq_list_contexts_set:
	@$(INFO) '$(YQ_UI_LABEL)Listing contexts-set "$(YQ_CONTEXTS_SET_NAME)" ...'; $(NORMAL)
	grep -E '^[a-zA-Z0-9]' $(YQ_CONTEXTS_FILEPATH) | sed -e 's/:.*//' | grep -E '$(YQ_CONTEXTS_REGEX)'

_yq_query_context:
	@$(INFO) '$(YQ_UI_LABEL)Quering context "$(YQ_CONTEXT_NAME)" ...'; $(NORMAL)
	$(_YQ_QUERY_CONTEXT_|) $(YQ) eval $(YQ_CONTEXT_PARAMETER_QUERY) $(YQ_CONTEXT_FILEPATH)

_yq_show_context: _yq_show_context_parameters _yq_show_context_description

_yq_show_context_description:
	@$(INFO) '$(YQ_UI_LABEL)Showing description of configuration-file "$(YQ_CONTEXT_NAME)" ...'; $(NORMAL)
	$(if $(YQ_CONTEXT_FILEPATH), \
		ls -al $(YQ_CONTEXT_FILEPATH) \
	, @\
		echo 'YQ_CONTEXT_FILEPATH not set'; \
	)

_yq_show_context_parameters:
	@$(INFO) '$(YQ_UI_LABEL)Showing parameters of configuration-file "$(YQ_CONTEXT_NAME)" ...'; $(NORMAL)
	$(_YQ_SHOW_CONTEXT_PARAMETERS_|) $(YQ) eval '.$(YQ_CONTEXT_SECTION_PATH)' $(YQ_CONTEXT_FILEPATH)

_yq_write_context: _yq_write_contexts
_yq_write_contexts:
	@$(INFO) '$(YQ_UI_LABEL)Writing manifest for one-or-more contexts ...'; $(NORMAL)
	$(WRITER) $(YQ_CONTEXTS_FILEPATH)
