_TQ_CONFFILE_MK_VERSION= $(_TQ_MK_VERSION)

TQ_CONFFILE_FILEPATH?= ./conffile.yml
# TQ_CONFFILE_NAME?= my-config
# TQ_CONFFILE_OUTPUT_YAML?= true
# TQ_CONFFILE_PARAMETER_PATH?= path.to.parameter[]
# TQ_CONFFILE_QUERY?= path.to.section.path.to.parameter[]
# TQ_CONFFILE_RAWVALUE?=
# TQ_CONFFILE_SECTION_PATH?= .section.path
# TQ_CONFFILE_VALUE?=

# Derived parameter
TQ_CONFFILE_NAME?= $(notdir $(TQ_CONFFILE_FILEPATH))
TQ_CONFFILE_OUTPUT_YAML?= $(TQ_OUTPUT_YAML)
TQ_CONFFILE_QUERY?= $(if $(TQ_CONFFILE_SECTION_PATH),.$(TQ_CONFFILE_SECTION_PATH)).$(TQ_CONFFILE_PARAMETER_PATH)

# Option parameters
__TQ_YAML_OUTPUT__CONFFILE= $(if $(filter true,$(TQ_CONFFILE_OUTPUT_YAML)),--yaml-output)

#--- MACROS
_tq_get_conffile_rawvalue= $(call _tq_get_conffile_rawvalue_P, $(TQ_CONFFILE_PARAMETER_PATH))
_tq_get_conffile_rawvalue_P= $(call _tq_get_conffile_rawvalue_PS, $(1), $(TQ_CONFFILE_SECTION_PATH))
_tq_get_conffile_rawvalue_PS= $(call _tq_get_conffile_rawvalue_PSF, $(1), $(2), $(TQ_CONFFILE_FILEPATH))
_tq_get_conffile_rawvalue_PSF= $(shell $(TQ_BIN) -a -r $(if $(2),.$(strip $(2))).$(strip $(1)) $(3))

_tq_get_conffile_value= $(call _tq_get_conffile_value_P, $(TQ_CONFFILE_PARAMETER_PATH))
_tq_get_conffile_value_P= $(call _tq_get_conffile_value_PS, $(1), $(TQ_CONFFILE_SECTION_PATH))
_tq_get_conffile_value_PS= $(call _tq_get_conffile_value_PSF, $(1), $(2), $(TQ_CONFFILE_FILEPATH))
_tq_get_conffile_value_PSF= $(shell $(TQ_BIN) -a $(if $(2),.$(strip $(2))).$(strip $(1)) $(3))

#----------------------------------------------------------------------
# USAGE
#

_tq_view_framework_macros ::
	@echo 'TQ::ConfigurationFile ($(_TQ_CONFFILE_MK_VERSION)) macros:'
	@echo '    _tq_get_conffile_rawvalue_{P|PS|PSF}     - Get a raw value from a configuration-file (Parameter,Section,Filepath)'
	@echo '    _tq_get_conffile_value_{P|PS|PSF}        - Get a value from a configuration-file (Parameter,Section,Filepath)'
	@echo

_tq_view_framework_parameters ::
	@echo 'TQ::ConfigurationFile ($(_TQ_CONFFILE_MK_VERSION)) parameters:'
	@echo '    TQ_CONFFILE_FILEPATH=$(TQ_CONFFILE_FILEPATH)'
	@echo '    TQ_CONFFILE_NAME=$(TQ_CONFFILE_FILEPATH)'
	@echo '    TQ_CONFFILE_OUTPUT_YAML=$(TQ_CONFFILE_OUTPUT_YAML)'
	@echo '    TQ_CONFFILE_PARAMETER_PATH=$(TQ_CONFFILE_PARAMETER_PATH)'
	@echo '    TQ_CONFFILE_QUERY=$(TQ_CONFFILE_QUERY)'
	@echo '    TQ_CONFFILE_RAWVALUE=$(TQ_CONFFILE_RAWVALUE)'
	@echo '    TQ_CONFFILE_SECTION_PATH=$(TQ_CONFFILE_SECTION_PATH)'
	@echo '    TQ_CONFFILE_VALUE=$(TQ_CONFFILE_VALUE)'
	@echo

_tq_view_framework_targets ::
	@echo 'TQ::ConfiguratoinFile ($(_TQ_CONFFILE_MK_VERSION)) targets:'
	@echo '    _tq_print_conffile_sectiondescription   - Print the description of a section in a configuration-file'
	@echo '    _tq_query_conffile                      - Query a configuration-file'
	@echo '    _tq_show_conffile                       - Show everything related to the configuration-file'
	@echo '    _tq_show_conffile_content               - Show content of the configuration-file'
	@echo '    _tq_show_conffile_dewscription          - Show description of the configuration-file'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tq_print_conffile_sectiondescription:
	@$(PURPLE)
	@tq -r .$(TQ_CONFFILE_SECTION_PATH).description ./conffile.yml
	@$(NORMAL)

_tq_query_conffile:
		@$(INFO) '$(TQ_UI_LABEL)Quering configuration-file "$(TQ_CONFFILE_NAME)" ...'; $(NORMAL)
		$(TQ) $(__TQ_YAML_OUTPUT__CONFFILE) $(TQ_CONFFILE_QUERY) $(TQ_CONFFILE_FILEPATH)

_tq_show_conffile: _tq_show_conffile_content _tq_show_conffile_description

_tq_show_conffile_content:
		@$(INFO) '$(TQ_UI_LABEL)Showing content of configuration-file "$(TQ_CONFFILE_NAME)" ...'; $(NORMAL)
		$(TQ) $(__TQ_YAML_OUTPUT__CONFFILE) '.' $(TQ_CONFFILE_FILEPATH)

_tq_show_conffile_description:
		@$(INFO) '$(TQ_UI_LABEL)Showing description of configuration-file "$(TQ_CONFFILE_NAME)" ...'; $(NORMAL)
		@$(WARN) 'Real path: $(realpath $(TQ_CONFFILE_FILEPATH))'; $(NORMAL)
		ls -al $(TQ_CONFFILE_FILEPATH)
