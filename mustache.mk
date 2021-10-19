_MUSTACHE_MK_VERSION= 0.99.4

# MTE_INPUTS_DIRPATH?= ./in/
# MTE_OUTFILE_DIRPATH?= ./out/
# MTE_OUTFILE_FILENAME?= file.txt
# MTE_OUTFILE_FILEPATH?= ./out/file.txt
# MTE_OUTPUTS_DIRPATH?= ./out/
# MTE_TEMPLATE_DIRPATH= ./in/
# MTE_TEMPLATE_FILENAME= file.txt.mo
# MTE_TEMPLATE_FILEPATH= ./in/file.txt.mo
# MTE_TEMPLATE_PARAMETERS_KEYVALUES= FOO=hello ...

# Derived parameters
MTE_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
MTE_OUTFILE_DIRPATH?= $(MTE_OUTPUTS_DIRPATH)
MTE_OUTFILE_FILENAME?= $(patsubst %.mo,%,$(MTE_TEMPLATE_FILENAME))
MTE_OUTFILE_FILEPATH?= $(MTE_OUTFILE_DIRPATH)$(MTE_OUTFILE_FILENAME)
MTE_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
MTE_TEMPLATE_DIRPATH?= $(MTE_INPUTS_DIRPATH)
MTE_TEMPLATE_FILEPATH?= $(MTE_TEMPLATE_DIRPATH)$(MTE_TEMPLATE_FILENAME)

# Option parameters

# Pipe
|_MTE_EXPAND_TEMPLATE?= | tee $(MTE_OUTFILE_FILEPATH)

# UI parameters
MTE_UI_LABEL?= [mustache] #

#--- Utilities

__MUSTACHE_ENVIRONMENT+=
__MUSTACHE_OPTIONS+=

MUSTACHE_BIN?= mo
MUSTACHE?= $(strip $(__MUSTACHE_ENVIRONMENT) $(MUSTACHE_ENVIRONMENT) $(MUSTACHE_BIN) $(__MUSTACHE_OPTIONS) $(MUSTACHE_OPTIONS))

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _mte_view_framework_macros
_mte_view_framework_macros ::
	@echo 'MusTachE ($(_MUSTACHE_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _mte_view_framework_parameters
_mte_view_framework_parameters ::
	@echo 'MusTachE ($(_MUSTACHE_MK_VERSION)) parameters:'
	@echo '    MTE_INPUTS_DIRPATH=$(MTE_INPUTS_DIRPATH)'
	@echo '    MTE_OUTFILE_DIRPATH=$(MTE_OUTFILE_DIRPATH)'
	@echo '    MTE_OUTFILE_FILENAME=$(MTE_OUTFILE_FILENAME)'
	@echo '    MTE_OUTFILE_FILEPATH=$(MTE_OUTFILE_FILEPATH)'
	@echo '    MTE_OUTPUTS_DIRPATH=$(MTE_OUTPUTS_DIRPATH)'
	@echo '    MTE_TEMPLATE_DIRPATH=$(MTE_TEMPLATE_DIRPATH)'
	@echo '    MTE_TEMPLATE_FILENAME=$(MTE_TEMPLATE_FILENAME)'
	@echo '    MTE_TEMPLATE_FILEPATH=$(MTE_TEMPLATE_FILEPATH)'
	@echo '    MTE_TEMPLATE_PARAMETERS_KEYVALUES=$(MTE_TEMPLATE_PARAMETERS_KEYVALUES)'
	@echo '    MUSTACHE=$(MUSTACHE)'
	@echo

_view_framework_targets :: _mte_view_framework_targets
_mte_view_framework_targets ::
	@echo 'MusTachE ($(_MUSTACHE_MK_VERSION)) targets:'
	@echo '    _mte_install_dependencies       - Install dependencies'
	@echo '    _mte_expand_template            - Expand a template'
	@echo '    _mte_show_version               - Show version'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
# -include $(MK_DIR)/mustache_template.mk


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mte_expand_template:
	@$(INFO) '$(MTE_UI_LABEL)Expanding template ...'; $(NORMAL)
	[ ! -f $(MTE_TEMPLATE_FILEPATH) ] || cat $(MTE_TEMPLATE_FILEPATH)
	$(strip $(MTE_TEMPLATE_PARAMETERS_KEYVALUES) $(MUSTACHE) $(MTE_TEMPLATE_FILEPATH)) $(|_MTE_EXPAND_TEMPLATE)

_install_framework_dependencies :: _mte_install_dependencies
_mte_install_dependencies ::
	@$(INFO) '$(MTE_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://github.com/tests-always-included/mo'; $(NORMAL)
	curl -sSL https://git.io/get-mo -o mo
	chmod +x mo
	sudo mv mo /usr/local/bin
	which mo

_view_versions:: _mte_view_versions
_mte_view_versions:
	@$(INFO) '$(MTE_UI_LABEL)Viewing versions of dependencies...'; $(NORMAL)
	$(MUSTACHE) --help | tail -1
