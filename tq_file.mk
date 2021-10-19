_TQ_FILE_MK_VERSION= $(_TQ_MK_VERSION)

# TQ_FILE_NAME?= file.yaml
# TQ_FILE_FILEPATH?= ./file.yaml
# TQ_FILE_OUTPUT_TOML?= true
# TQ_FILE_OUTPUT_YAML?= true
TQ_FILE_QUERY?= .
# TQ_FILE_RAWVALUE?= my value
# TQ_FILE_VALUE?= "my value"

# Derived parameters
TQ_FILE_NAME?= $(notdir $(TQ_FILE_FILEPATH))
TQ_FILE_OUTPUT_TOML?= $(TQ_OUTPUT_TOML)
TQ_FILE_OUTPUT_YAML?= $(TQ_OUTPUT_YAML)

# Option paramters
__TQ_TOML_OUTPUT__FILE= $(if $(filter true,$(TQ_FILE_OUTPUT_TOML)),--toml-output)
__TQ_YAML_OUTPUT__FILE= $(if $(filter true,$(TQ_FILE_OUTPUT_YAML)),--yaml-output)

# UI parameters

#--- Utilities

#--- MACROS
_tq_get_file_rawvalue= $(call _tq_get_file_rawvalue_Q, $(TQ_FILE_QUERY))
_tq_get_file_rawvalue_Q= $(call _tq_get_file_rawvalue_QF, $(1), $(TQ_FILE_FILEPATH))
_tq_get_file_rawvalue_QF= $(shell $(TQ_BIN) -a -r $(1) $(2))

_tq_get_file_value= $(call _tq_get_file_value_Q, $(TQ_FILE_QUERY))
_tq_get_file_value_Q= $(call _tq_get_file_value_QF, $(1), $(TQ_FILE_FILEPATH))
_tq_get_file_value_QF= $(shell $(TQ_BIN) -a $(1) $(2))

#----------------------------------------------------------------------
# USAGE
#

_tq_view_framework_macros ::
	@echo 'TQ::File ($(_TQ_FILE_MK_VERSION)) macros:'
	@echo '    _tq_get_file_rawvalue_{|Q|QF}   - Get a raw value using a query on a yaml file (Query,File)'
	@echo '    _tq_get_file_value_{|Q|QF}      - Get a value using a query on a yaml file (Query,File)'
	@echo

_tq_view_framework_parameters ::
	@echo 'TQ::File: ($(_TQ_FILE_MK_VERSION)) parameters:'
	@echo '    TQ_FILE_FILEPATH=$(TQ_FILE_FILEPATH)'
	@echo '    TQ_FILE_NAME=$(TQ_FILE_NAME)'
	@echo '    TQ_FILE_OUTPUT_TOML=$(TQ_FILE_OUTPUT_TOML)'
	@echo '    TQ_FILE_OUTPUT_YAML=$(TQ_FILE_OUTPUT_YAML)'
	@echo '    TQ_FILE_QUERY=$(TQ_FILE_QUERY)'
	@echo '    TQ_FILE_RAWVALUE=$(TQ_FILE_RAWVALUE)'
	@echo '    TQ_FILE_VALUE=$(TQ_FILE_VALUE)'
	@echo

_tq_view_framework_targets ::
	@echo 'TQ::File ($(_TQ_FILE_MK_VERSION)) targets:'
	@echo '    _tq_query_file                  - run a query on a file'
	@echo '    _tq_show_file                   - show everything related to a file'
	@echo '    _tq_show_file_content           - show content of a file'
	@echo '    _tq_show_file_description       - show description of a file'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tq_query_file:
	@$(INFO) '$(TQ_UI_LABEL)Quering file "$(TQ_FILE_NAME)" ...'; $(NORMAL)
	$(TQ) $(__TO_TOML_OUTPUT) $(__TQ_YAML_OUTPUT) $(TQ_FILE_QUERY) $(TQ_FILE_FILEPATH) 

_tq_show_file: _tq_show_file_content _tq_show_file_description

_tq_show_file_content:
	@$(INFO) '$(TQ_UI_LABEL)Showing content of file "$(TQ_FILE_NAME)" ...'; $(NORMAL)
	$(TQ) $(__TQ_TOML_OUTPUT) $(__TQ_YAML_OUTPUT) '.' $(TQ_FILE_FILEPATH)

_tq_show_file_description:
	@$(INFO) '$(TQ_UI_LABEL)Showing content of file "$(TQ_FILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Real path: $(realpath $(TQ_FILE_FILEPATH))'; $(NORMAL)
	ls -al $(TQ_FILE_FILEPATH)
