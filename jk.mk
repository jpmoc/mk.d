_JK_MK_VERSION= 0.99.4

# JK_INPUTS_DIRPATH= ./in/
# JK_MODE_DEBUG= false
# JK_MODE_VERBOSE= false
# JK_OUTPUTS_DIRPATH= ./out/
# JK_PARAMETERS_FILEPATH= parameters.yaml
# JK_PARAMETERS_KEYVALUES= name=value ..

# Derived parameters
JK_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
JK_MODE_DEBUG?= $(CMN_MODE_DEBUG)
JK_MODE_VERBOSE?= $(CMN_MODE_VERBOSE)
JK_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Option parameters
__JK_INPUT_DIRECTORY= $(if $(JK_INPUTS_DIRPATH),--input-directory $(JK_INPUTS_DIRPATH))
__JK_OUTPUT_DIRECTORY= $(if $(JK_OUTPUTS_DIRPATH),--output-directory $(JK_OUTPUTS_DIRPATH))
__JK_PARAMETER= $(if $(JK_PARAMETERS_KEYVALUES),--parameter $(JK_PARAMETERS_KEYVALUES))
__JK_VERBOSE= $(if $(filter true,$(JK_MODE_VERBOSE)),--verbose)

# UI parameters
JK_UI_LABEL?= [jk] #

#--- Utilities

# __JK_ENVIRONMENT+=

__JK_OPTIONS+=

JK_BIN?= jk
JK?= $(strip $(__JK_ENVIRONMENT) $(JK_ENVIRONMENT) $(JK_BIN) $(__JK_OPTIONS) $(JK_OPTIONS))

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _jk_view_framework_macros
_jk_view_framework_macros ::
	@echo 'JK:: ($(_JK_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _jk_view_framework_parameters
_jk_view_framework_parameters ::
	@echo 'JK:: ($(_JK_MK_VERSION)) parameters:'
	@echo '    JK=$(JK)'
	@echo '    JK_INPUTS_DIRPATH=$(JK_INPUTS_DIRPATH)'
	@echo '    JK_MODE_DEBUG=$(JK_MODE_DEBUG)'
	@echo '    JK_MODE_VERBOSE=$(JK_MODE_VERBOSE)'
	@echo '    JK_OUTPUTS_DIRPATH=$(JK_OUTPUTS_DIRPATH)'
	@echo '    JK_PARAMETERS_FILEPATH=$(JK_PARAMETERS_FILEPATH)'
	@echo '    JK_PARAMETERS_KEYVALUES=$(JK_PARAMETERS_KEYVALUES)'
	@echo

_view_framework_targets :: _jk_view_framework_targets
_jk_view_framework_targets ::
	@echo 'JK:: ($(_JK_MK_VERSION)) targets:'
	@echo '    _jk_install_dependencies       - Install dependencies'
	@echo '    _jk_show_version               - Show version'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/jk_kubernetes.mk


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _jk_install_dependencies
_jk_install_dependencies ::
	@$(INFO) '$(JK_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://jkcfg.github.io/#/documentation/quick-start'; $(NORMAL)
	curl -Lo jk https://github.com/jkcfg/jk/releases/download/0.2.3/jk-linux-amd64
	chmod +x jk
	sudo mv jk /usr/local/bin/
	which jk

_jk_build_template:
	@$(INFO) '$(JK_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	$(JK) run $(__JK_INPUT_DIRECTORY) $(__JK_OUTPUT_DIRECTORY) $(__JK_PARAMETER) $(__JK_PARAMETERS) $(__JK_VERBOSE) $(JK_FILEPATH) 

_jk_show_version:
	@$(INFO) '$(JK_UI_LABEL)Showing version ...'; $(NORMAL)
	$(JK) version
