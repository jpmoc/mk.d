YAML_CONFIG_MK_VERSION=0.99.0

CFG_INPUT_SEPARATOR?=/#
CFG_LABEL?=[config] #
CFG_OUTPUT_SEPARATOR?= #
CFG_TOP_SECTION?=/#
CFG_CONFIGURATION_FILE?=$(realpath ./configs/default.yml)
CFG_CONFIGURATION_NAME?=default
CFG_CONFIGURATION_PATH?=$(CFG_INPUT_SEPARATOR)$(CFG_CONFIGURATION_NAME)
# CFG_CONFIGURATION_NAMES?=default
CFG_MAX_DEPTH?= 1
# CFG_PARAMETER_PATH?= my_parameter
CFG_SECTION_PATH?=$(CFG_TOP_SECTION)$(CFG_INPUT_SEPARATOR)$(CFG_CONFIGURATION_NAME)
# CFG_SPACED_OUTPUT?=false
CFG_VALUE_DEFAULT?= default_value


__CFG_DEFAULT_VALUE?= $(if $(CFG_VALUE_DEFAULT), --default-value $(CFG_VALUE_DEFAULT))
__CFG_INPUT_SEPARATOR?= $(if $(CFG_INPUT_SEPARATOR), --input-separator $(CFG_INPUT_SEPARATOR))
__CFG_MAX_DEPTH?= $(if $(CFG_MAX_DEPTH), --max-depth $(CFG_MAX_DEPTH))
__CFG_OUTPUT_SEPARATOR?= $(if $(CFG_OUTPUT_SEPARATOR), --output-separator $(CFG_OUTPUT_SEPARATOR))
__CFG_PARAMETER_PATH?= $(if $(CFG_PARAMETER_PATH), --parameter-path $(CFG_PARAMETER_PATH))
__CFG_SECTION_PATH?= $(if $(CFG_SECTION_PATH), --section-path $(CFG_SECTION_PATH))
__CFG_SPACED_OUTPUT?= $(if $(filter true, $(CFG_SPACED_OUTPUT)), --spaced-output)



#--- MACROS
get_configuration_names?=$(shell yaml_walk $(CFG_CONFIGURATION_FILE) $(__CFG_INPUT_SEPARATOR) --section-path $(CFG_TOP_SECTION) --max-depth 1 $(__CFG_SPACED_OUTPUT))

yaml_get_SPD=$(shell $(YAML_GET) $(CFG_CONFIGURATION_FILE) --input-separator $(CFG_INPUT_SEPARATOR) --spaced-output --section-path $(1) --parameter-path $(2) --default $(3))

yaml_walk_SLM=$(shell yaml_walk $(CFG_CONFIGURATION_FILE) --input-separator $(CFG_INPUT_SEPARATOR) --spaced-output --section-path $(1) --min-depth $(2) --max-depth $(3))

configuration_get_PD=$(call yaml_get_SPD, $(CFG_CONFIGURATION_PATH), $(1), $(2))


YAML_EXTRACT?=yaml_extract $(__YAML_EXTRACT_OPTIONS) $(YAML_EXTRACT_OPTIONS)
YAML_GET?=yaml_get $(__YAML_GET_OPTIONS) $(YAML_GET_OPTIONS)
YAML_VALIDATE?=yaml_validate $(__YAML_VALIDATE_OPTIONS) $(YAML_VALIDATE_OPTIONS)

#----------------------------------------------------------------------
# USAGE
#

_view_makefile_macros :: _cfg_view_makefile_macros
_cfg_view_makefile_macros:
	@echo "Yaml:::ConFiG ($(YAML_CONFIG_MK_VERSION)) targets:"
	@echo "    get_configuration_names              - Get a list of available configurations"
	@echo "    yaml_get_SPD                         - Get the value of an entry in a yaml file"
	@echo

_view_makefile_targets :: _cfg_view_makefile_targets
_cfg_view_makefile_targets:
	@echo "Yaml::ConFiG ($(YAML_CONFIG_MK_VERSION)) targets:"
	@echo "    _cfg_view_configuration_parameter    - Fetch a configuration parameter"
	@echo "    _cfg_validate_configuration_file     - Validates the syntax of a configuration file"
	@echo "    _cfg_view_active_configuration       - Displays the active configuration"
	@echo "    _cfg_view_configuration              - Displays the content of the configuration content"
	@echo "    _cfg_view_available_configurations   - List available configurations"
	@echo


_view_makefile_variables :: _cfg_view_makefile_variables
_cfg_view_makefile_variables:
	@echo "Yaml::ConFiG ($(YAML_CONFIG_MK_VERSION)) variables:"
	@echo "    CFG_CONFIGURATION_FILE=$(CFG_CONFIGURATION_FILE)"
	@echo "    CFG_CONFIGURATION_NAME=$(CFG_CONFIGURATION_NAME)"
	@echo "    CFG_CONFIGURATION_NAMES=$(CFG_CONFIGURATION_NAMES)"
	@echo "    CFG_CONFIGURATION_PATH=$(CFG_CONFIGURATION_PATH)"
	@echo "    CFG_INPUT_SEPARATOR=$(CFG_INPUT_SEPARATOR)"
	@echo "    CFG_LABEL=$(CFG_LABEL)"
	@echo "    CFG_OUTPUT_SEPARATOR=$(CFG_OUTPUT_SEPARATOR)"
	@echo "    CFG_PARAMETER_PATH=$(CFG_PARAMETER_PATH)"
	@echo "    CFG_SECTION_PATH=$(CFG_SECTION_PATH)"
	@echo "    CFG_SPACED_OUTPUT=$(CFG_SPACED_OUTPUT)"
	@echo "    CFG_TOP_SECTION=$(CFG_TOP_SECTION)"
	@echo "    CFG_VALUE_DEFAULT=$(CFG_VALUE_DEFAULT)"
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

__cfg_view_configuration_name:
	@$(INFO) $(CFG_CONFIGURATION_NAME); $(NORMAL)
	@$(YAML_GET) $(__CFG_INPUT_SEPARATOR) $(__CFG_SECTION_PATH) -P description $(CFG_CONFIGURATION_FILE) | cat

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cfg_validate_configuration_syntax:
	@$(INFO) "$(CFG_LABEL)Validating configuration file ..."; $(NORMAL)
	$(YAML_VALIDATE)  $(CFG_CONFIGURATION_FILE)

_cfg_view_active_configuration:
	@echo "---"
	@echo -n "Active configuration: "
	@$(INFO) "$(CFG_CONFIGURATION_NAME)"; $(NORMAL)
	@echo "---"

_cfg_view_configuration:
	@$(INFO) "$(CFG_LABEL)Extracting configuration from file ..."; $(NORMAL)
	$(YAML_EXTRACT) -S $(CFG_SECTION_PATH) -O /tmp/config.yml $(CFG_CONFIGURATION_FILE)
  ifeq ($(CMN_INTERACTIVE_MODE), true)
	less /tmp/config.yml
  else
	cat /tmp/config.yml
  endif

_cfg_view_parameter_value:
	@$(INFO) "$(CFG_LABEL)Extracting parameter value from file ..."; $(NORMAL)
	$(YAML_GET) $(CFG_CONFIGURATION_FILE) $(__CFG_INPUT_SEPARATOR) $(__CFG_SECTION_PATH) $(__CFG_PARAMETER_PATH) $(__CFG_DEFAULT_VALUE)

_cfg_view_configuration_file:
	@$(INFO) "$(CFG_LABEL)Displaying configuration file ..."; $(NORMAL)
  ifeq ($(CMN_INTERACTIVE_MODE), true)
	less $(CFG_CONFIGURATION_FILE)
  else
	cat $(CFG_CONFIGURATION_FILE)
  endif

_cfg_view_configuration_names: CFG_CONFIGURATION_NAMES?=$(call get_configuration_names)
_cfg_view_configuration_names: _cfg_view_active_configuration
	@$(foreach N, $(sort $(CFG_CONFIGURATION_NAMES)), \
		make -s CFG_CONFIGURATION_NAME=$(N) __cfg_view_configuration_name; \
	)
