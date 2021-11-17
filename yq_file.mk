_YQ_FILE_MK_VERSION= $(_YQ_MK_VERSION)

# YQ_FILE_NAME?= file.yaml
# YQ_FILE_FILEPATH?= ./file.yaml
# YQ_FILE_OUTPUT_YAML?= true
YQ_FILE_QUERY?= .
# YQ_FILE_RAWVALUE?= my value
# YQ_FILE_VALUE?= "my value"

# Derived parameters
YQ_FILE_NAME?= $(notdir $(YQ_FILE_FILEPATH))
YQ_FILE_OUTPUT_TOML?= $(YQ_OUTPUT_TOML)
YQ_FILE_OUTPUT_YAML?= $(YQ_OUTPUT_YAML)

# Options
__YQ_TOML_OUTPUT__FILE= $(if $(filter true,$(YQ_FILE_OUTPUT_TOML)),--toml-output)
__YQ_YAML_OUTPUT__FILE= $(if $(filter true,$(YQ_FILE_OUTPUT_YAML)),--yaml-output)

# Customizations

# Macros
_yq_get_file_rawvalue= $(call _yq_get_file_rawvalue_Q, $(YQ_FILE_QUERY))
_yq_get_file_rawvalue_Q= $(call _yq_get_file_rawvalue_QF, $(1), $(YQ_FILE_FILEPATH))
_yq_get_file_rawvalue_QF= $(shell $(YQ_BIN) -a -r $(1) $(2))

_yq_get_file_value= $(call _yq_get_file_value_Q, $(YQ_FILE_QUERY))
_yq_get_file_value_Q= $(call _yq_get_file_value_QF, $(1), $(YQ_FILE_FILEPATH))
_yq_get_file_value_QF= $(shell $(YQ_BIN) -a $(1) $(2))

#----------------------------------------------------------------------
# USAGE
#

_yq_list_macros ::
	@echo 'YQ:::File ($(_YQ_FILE_MK_VERSION)) macros:'
	@echo '    _yq_get_file_rawvalue_{|Q|QF}   - Get a raw value using a query on a yaml file (Query,File)'
	@echo '    _yq_get_file_value_{|Q|QF}      - Get a value using a query on a yaml file (Query,File)'
	@echo

_yq_list_parameters ::
	@echo 'YQ:File: ($(_YQ_FILE_MK_VERSION)) parameters:'
	@echo '    YQ_FILE_FILEPATH=$(YQ_FILE_FILEPATH)'
	@echo '    YQ_FILE_NAME=$(YQ_FILE_NAME)'
	@echo '    YQ_FILE_OUTPUT_TOML=$(YQ_FILE_OUTPUT_TOML)'
	@echo '    YQ_FILE_OUTPUT_YAML=$(YQ_FILE_OUTPUT_YAML)'
	@echo '    YQ_FILE_QUERY=$(YQ_FILE_QUERY)'
	@echo '    YQ_FILE_RAWVALUE=$(YQ_FILE_RAWVALUE)'
	@echo '    YQ_FILE_VALUE=$(YQ_FILE_VALUE)'
	@echo

_yq_list_targets ::
	@echo 'YQ::File ($(_YQ_FILE_MK_VERSION)) targets:'
	@echo '    _yq_query_file                  - Query a file'
	@echo '    _yq_show_file                   - Show everything related to a file'
	@echo '    _yq_show_file_content           - Show content of a file'
	@echo '    _yq_show_file_description       - Show description of a file'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_yq_query_file:
	@$(INFO) '$(YQ_UI_LABEL)Quering file "$(YQ_FILE_NAME)" ...'; $(NORMAL)
	$(YQ) $(__YQ_TOML_OUTPUT__FILE) $(__YQ_YAML_OUTPUT__FILE) $(YQ_FILE_QUERY) $(YQ_FILE_FILEPATH) 

_yq_show_file: _yq_show_file_content _yq_show_file_description

_yq_show_file_content:
	@$(INFO) '$(YQ_UI_LABEL)Showing content of file "$(YQ_FILE_NAME)" ...'; $(NORMAL)
	$(YQ) $(__YQ_TOML_OUTPUT__FILE) $(__YQ_YAML_OUTPUT__FILE) '.' $(YQ_FILE_FILEPATH)

_yq_show_file_description:
	@$(INFO) '$(YQ_UI_LABEL)Showing content of file "$(YQ_FILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Real path: $(realpath $(YQ_FILE_FILEPATH))'; $(NORMAL)
	ls -al $(YQ_FILE_FILEPATH)

_yq_write_file:
	@$(INFO) '$(YQ_UI_LABEL)Writing file "$(YQ_FILE_NAME)" ...'; $(NORMAL)
	$(WRITER) $(YQ_FILE_FILEPATH)
