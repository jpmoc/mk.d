_YTT_MK_VERSION= 0.99.0

# YTT_INPUTS_DIRPATH?= ./in/
# YTT_OUTPUTS_DIRPATH?= ./out/

# Derived parameters
YTT_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
YTT_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Option parameters

# UI parameters
YTT_UI_LABEL?= [ytt] #

#--- Utilities
YTT_BIN?= ytt
YTT?= $(strip $(__YTT_ENVIRONMENT) $(YTT_ENVIRONMENT) $(YTT_BIN) $(__YTT_OPTIONS) $(YTT_OPTIONS))
YTT_VERSION?= v0.28.0

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _ytt_view_framework_macros
_ytt_view_framework_macros ::
	@echo 'YTT::: ($(_YTT_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _ytt_view_framework_parameters
_ytt_view_framework_parameters ::
	@echo 'YTT:: ($(_YTT_MK_VERSION)) parameters:'
	@echo '    YTT_INPUTS_DIRPATH=$(YTT_INPUTS_DIRPATH)'
	@echo '    YTT_OUTPUTS_DIRPATH=$(YTT_OUTPUTS_DIRPATH)'
	@echo

_view_framework_targets :: _ytt_view_framework_targets
_ytt_view_framework_targets ::
	@echo 'YTT:: ($(_YTT_MK_VERSION)) targets:'
	@echo '    _ytt_install_dependencoes        - Install the dependencies'
	@echo '    _ytt_view_versions               - View versions of dependencies'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/ytt_file.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _ytt_install_dependencies
_ytt_install_dependencies:
	@$(INFO) '$(YTT_UI_LABEL)Showing version ...'; $(NORMAL)
	@$(WARN) 'Installation docs @ https://github.com/k14s/ytt/release'; $(NORMAL)
	wget https://github.com/k14s/ytt/releases/download/$(YTT_VERSION)/ytt-linux-amd64
	$(SUDO) mv ytt-linux-amd64 /usr/local/bin/ytt
	which ytt
	ytt version

_view_versions :: _ytt_view_versions
_ytt_view_versions:
	@$(INFO) '$(YQ_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(YTT) version
