_GOMPLATE_MK_VERSION= 0.99.4

GPE_DELIMINATOR_LEFT?= "{{"
GPE_DELIMINATOR_RIGHT?= "}}"
# GPE_INPUTS_DIRPATH?= ./in/
# GPE_OUTFILE_DIRPATH?= ./out/
# GPE_OUTFILE_FILENAME?= file.txt
# GPE_OUTFILE_FILEPATH?= ./out/file.txt
# GPE_OUTPUTS_DIRPATH?= ./out/
# GPE_TEMPLATE_DATASOURCES?= "weather=https://wttr.in/?0" ...
# GPE_TEMPLATE_DATASOURCES_HEADERS?= "weather=User-Agent: curl" ...
# GPE_TEMPLATE_DIRPATH?= ./in/
# GPE_TEMPLATE_ENVIRONMENT_KEYVALUES?= FOO=hello ...
# GPE_TEMPLATE_FILENAME?= file.txt.gpe
# GPE_TEMPLATE_FILEPATH?= ./in/file.txt.gpe
# GPE_TEMPLATE_STRING?= "the answer is: {{ mul 6 7 }}"

# Derived parameters
GPE_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
GPE_OUTFILE_DIRPATH?= $(GPE_OUTPUTS_DIRPATH)
GPE_OUTFILE_FILEPATH?= $(if $(GPE_OUTFILE_FILENAME),$(GPE_OUTFILE_DIRPATH)$(GPE_OUTFILE_FILENAME))
GPE_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
GPE_TEMPLATE_DIRPATH?= $(GPE_INPUTS_DIRPATH)
GPE_TEMPLATE_FILEPATH?= $(if $(GPE_TEMPLATE_FILENAME),$(GPE_TEMPLATE_DIRPATH)$(GPE_TEMPLATE_FILENAME))

# Option parameters
__GPE_CHMOD=
__GPE_CONTEXT=
__GPE_DATASOURCE= $(foreach D, $(GPE_TEMPLATE_DATASOURCES),--datasource $(D))
__GPE_DATASOURCE_HEADER= $(foreach H, $(GPE_TEMPLATE_DATASOURCES_HEADERS),--datasource-header $(H))
__GPE_EXCLUDE=
__GPE_EXEC_PIPE=
__GPE_FILE= $(if $(GPE_TEMPLATE_FILEPATH),--file $(GPE_TEMPLATE_FILEPATH))
__GPE_IN= $(if $(GPE_TEMPLATE_STRING),--in $(GPE_TEMPLATE_STRING))
__GPE_INCLUDE=
__GPE_INPUT_DIR=
__GPE_LEFT_DELIM= $(if $(GPE_DELIMINATOR_LEFT),--left-delim $(GPE_DELIMINATOR_LEFT))
__GPE_OUT= $(if $(X_GPE_OUTFILE_FILEPATH),--out $(GPE_OUTFILE_FILEPATH),--out -)
__GPE_OUTPUT_DIR=
__GPE_OUTPUT_MAP=
__GPE_RIGHT_DELIM= $(if $(GPE_DELIMINATOR_RIGHT),--right-delim $(GPE_DELIMINATOR_RIGHT))

# Pipe
|_GPE_EXPAND_TEMPLATE?= | tee $(GPE_OUTFILE_FILEPATH)

# UI parameters
GPE_UI_LABEL?= [gomplate] #

#--- Utilities

__GOMPLATE_ENVIRONMENT+=
__GOMPLATE_OPTIONS+=

GOMPLATE_BIN?= gomplate
GOMPLATE?= $(strip $(__GOMPLATE_ENVIRONMENT) $(GOMPLATE_ENVIRONMENT) $(GOMPLATE_BIN) $(__GOMPLATE_OPTIONS) $(GOMPLATE_OPTIONS))
GOMPLATE_VERSION?= v3.6.0

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _gpe_view_framework_macros
_gpe_view_framework_macros ::
	@echo 'GomPlatE ($(_GOMPLATE_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _gpe_view_framework_parameters
_gpe_view_framework_parameters ::
	@echo 'GomPlatE ($(_GOMPLATE_MK_VERSION)) parameters:'
	@echo '    GPE_DELIMINATOR_LEFT=$(GPE_DELIMINATOR_LEFT)'
	@echo '    GPE_DELIMINATOR_RIGHT=$(GPE_DELIMINATOR_RIGHT)'
	@echo '    GPE_INPUTS_DIRPATH=$(GPE_INPUTS_DIRPATH)'
	@echo '    GPE_OUTFILE_DIRPATH=$(GPE_OUTFILE_DIRPATH)'
	@echo '    GPE_OUTFILE_FILENAME=$(GPE_OUTFILE_FILENAME)'
	@echo '    GPE_OUTFILE_FILEPATH=$(GPE_OUTFILE_FILEPATH)'
	@echo '    GPE_OUTPUTS_DIRPATH=$(GPE_OUTPUTS_DIRPATH)'
	@echo '    GPE_TEMPLATE_DATASOURCES=$(GPE_TEMPLATE_DATASOURCES)'
	@echo '    GPE_TEMPLATE_DATASOURCES_HEADERS=$(GPE_TEMPLATE_DATASOURCES_HEADERS)'
	@echo '    GPE_TEMPLATE_DIRPATH=$(GPE_TEMPLATE_DIRPATH)'
	@echo '    GPE_TEMPLATE_DIRPATH=$(GPE_TEMPLATE_DIRPATH)'
	@echo '    GPE_TEMPLATE_ENVIRONMENT_KEYVALUES=$(GPE_TEMPLATE_PARAMETERS_KEYVALUES)'
	@echo '    GPE_TEMPLATE_FILENAME=$(GPE_TEMPLATE_FILENAME)'
	@echo '    GPE_TEMPLATE_FILEPATH=$(GPE_TEMPLATE_FILEPATH)'
	@echo '    GPE_TEMPLATE_STRING=$(GPE_TEMPLATE_STRING)'
	@echo '    GOMPLATE=$(GOMPLATE)'
	@echo

_view_framework_targets :: _gpe_view_framework_targets
_gpe_view_framework_targets ::
	@echo 'GomPlatE ($(_GOMPLATE_MK_VERSION)) targets:'
	@echo '    _gpe_install_dependencies       - Install dependencies'
	@echo '    _gpe_expand_template            - Expand a template'
	@echo '    _gpe_show_version               - Show version'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
# -include $(MK_DIR)/gomplate_template.mk


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gpe_expand_template:
	@$(INFO) '$(GPE_UI_LABEL)Expanding template ...'; $(NORMAL)
	$(if $(GPE_TEMPLATE_FILEPATH), cat $(GPE_TEMPLATE_FILEPATH))
	$(GPE_TEMPLATE_ENVIRONMENT_KEYVALUES) $(GOMPLATE) $(__GPE_CHMOD) $(__GPE_CONTEXT) $(__GPE_DATASOURCE) $(__GPE_DATASOURCE_HEADER) $(__GPE_EXCLUDE) $(__GPE_EXEC_PIPE) $(__GPE_FILE) $(__GPE_IN) $(__GPE_INCLUDE) $(__GPE_INPUT_DIR) $(__GPE_LEFT_DELIM) $(__GPE_OUT) $(__GPE_OUTPUT_DIR) $(__GPE_OUTPUT_MAP) $(__GPE_RIGHT_DELIM) $(|_GPE_EXPAND_TEMPLATE)

_install_framework_dependencies :: _gpe_install_dependencies
_gpe_install_dependencies ::
	@$(INFO) '$(GPE_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://docs.gomplate.ca/installing/'; $(NORMAL)
	$(SUDO) curl --location --output /usr/local/bin/gomplate --show-error --silent https://github.com/hairyhenderson/gomplate/releases/download/$(GOMPLATE_VERSION)/gomplate_linux-amd64
	$(SUDO) chmod 755 /usr/local/bin/gomplate
	which gomplate
	gomplate --version

_view_versions:: _gpe_view_versions
_gpe_view_versions:
	@$(INFO) '$(GPE_UI_LABEL)Viewing versions of dependencies...'; $(NORMAL)
	$(GOMPLATE_BIN) --version
