_YQ_MK_VERSION= 1.0.0

YQ_DOWNLOAD_BINARY?= yq_linux_amd64
YQ_DOWNLOAD_VERSION?= 4.2.1
YQ_UI_LABEL?= [yq] #

# Derived parameters

# Options

# Customizations

# Utilities
YQ_BIN?= yq
YQ?= $(strip $(__YQ_ENVIRONMENT) $(YQ_ENVIRONMENT) $(YQ_BIN) $(__YQ_OPTIONS) $(YQ_OPTIONS))

# Macros

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _yq_list_macros
_yq_list_macros ::
	@#echo 'YQ:: ($(_YQ_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _yq_list_parameters
_yq_list_parameters ::
	@echo 'YQ:: ($(_YQ_MK_VERSION)) parameters:'
	@echo '    YQ_OUTPUT_FORMAT=$(YQ_OUTPUT_FORMAT)'
	@echo '    YQ_UI_LABEL=$(YQ_UI_LABEL)'
	@echo

_list_targets :: _yq_list_targets
_yq_list_targets ::
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
