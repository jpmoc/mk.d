_YQ_MK_VERSION= 0.99.0

YQ_DOWNLOAD_BINARY?= yq_linux_amd64
YQ_DOWNLOAD_VERSION?= 4.2.1

# Derived parameters

# Option parameters

# UI parameters
YQ_UI_LABEL?= [yq] #

#--- Utilities
YQ_BIN?= yq
YQ?= $(strip $(__YQ_ENVIRONMENT) $(YQ_ENVIRONMENT) $(YQ_BIN) $(__YQ_OPTIONS) $(YQ_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _yq_view_framework_macros
_yq_view_framework_macros ::
	@echo 'YQ:: ($(_YQ_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _yq_view_framework_parameters
_yq_view_framework_parameters ::
	@echo 'YQ:: ($(_YQ_MK_VERSION)) parameters:'
	@echo '    YQ_OUTPUT_FORMAT=$(YQ_OUTPUT_FORMAT)'
	@echo

_view_framework_targets :: _yq_view_framework_targets
_yq_view_framework_targets ::
	@echo 'YQ:: ($(_YQ_MK_VERSION)) targets:'
	@echo '    _yq_install_dependencoes        - Install the dependencies'
	@echo '    _yq_view_versions               - View versions of dependencies'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/yq_context.mk
-include $(MK_DIR)/yq_file.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _yq_install_dependencies
_yq_install_dependencies:
	@$(INFO) '$(YQ_UI_LABEL)Showing version ...'; $(NORMAL)
	@$(WARN) 'Installation docs @ https://mikefarah.gitbook.io/yq/'; $(NORMAL)
	wget https://github.com/mikefarah/yq/releases/download/$(YQ_DOWNLOAD_VERSION)/$(YQ_DOWNDLOAD_BINARY) -O ./yq
	chmod +x yq && sudo mv yq /usr/local/bin
	which yq
	yq --version

_view_versions :: _yq_view_versions
_yq_view_versions:
	@$(INFO) '$(YQ_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(YQ) --version
