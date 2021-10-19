_TQ_MK_VERSION= 0.99.0

TQ_OUTPUT_TOML?= false
TQ_OUTPUT_YAML?= false

# Derived parameters

# Option parameters

# UI parameters
TQ_UI_LABEL?= [tq] #

#--- Utilities
TQ_BIN?= tq
TQ?= $(strip $(__TQ_ENVIRONMENT) $(TQ_ENVIRONMENT) $(TQ_BIN) $(__TQ_OPTIONS) $(TQ_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _tq_view_framework_macros
_tq_view_framework_macros ::
	@echo 'TQ:: ($(_TQ_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _tq_view_framework_parameters
_tq_view_framework_parameters ::
	@echo 'TQ:: ($(_TQ_MK_VERSION)) parameters:'
	@echo '    TQ_OUTPUT_TOML=$(TQ_OUTPUT_TOML)'
	@echo '    TQ_OUTPUT_YAML=$(TQ_OUTPUT_YAML)'
	@echo

_view_framework_targets :: _tq_view_framework_targets
_tq_view_framework_targets ::
	@echo 'TQ:: ($(_TQ_MK_VERSION)) targets:'
	@echo '    _tq_install_dependencies        - install dependencies'
	@echo '    _tq_show_version                - show version of utility'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


MK_DIR?= .
-include $(MK_DIR)/tq_conffile.mk
-include $(MK_DIR)/tq_file.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _tq_install_dependencies
_tq_install_dependencies:
	@$(INFO) '$(TQ_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	sudo -H pip install yq
	which tq 
	tq --version

_tq_show_version:
	@$(INFO) '$(TQ_UI_LABEL)Showing version ...'; $(NORMAL)
	$(TQ) --version
