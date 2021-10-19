_CHARTMUSEUM_MK_VERSION= 0.99.4

# CMM_PARAMETER= value

# Derived parameters
CMM_MODE_DEBUG?= $(CMN_MODE_DEBUG)

# Option parameters

# UI parameters
CMM_UI_LABEL?=[chartmuseum] #

#--- Utilities

# __CHARTMUSEUM_ENVIRONMENT+=

__CHARTMUSEUM_OPTIONS+= $(if $(CMM_MODE_DEBUG), --debug)

CHARTMUSEUM_BIN?= chartmuseum
CHARTMUSEUM?= $(strip $(__CHARTMUSEUM_ENVIRONMENT) $(CHARTMUSEUM_ENVIRONMENT) $(CHARTMUSEUM_BIN) $(__CHARTMUSEUM_OPTIONS) $(CHARTMUSEUM_OPTIONS))

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _cmm_install_framework_dependencies
_cmm_install_framework_dependencies ::
	@# Install docs at https://codefresh-io.github.io/chartmuseum-www/docs/#installation
	curl -LO https://s3.amazonaws.com/chartmuseum/release/latest/bin/linux/amd64/chartmuseum
	chmod +x ./chartmuseum
	sudo mv ./chartmuseum /usr/local/bin
	$(if $(HELM),$(HELM) plugin install https://github.com/chartmuseum/helm-push)

_view_framework_macros :: _cmm_view_framework_macros
_cmm_view_framework_macros ::
	@echo 'ChartMuseuM:: ($(_CHARTMUSEUM_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _cmm_view_framework_parameters
_cmm_view_framework_parameters ::
	@echo 'ChartMuseuM:: ($(_CHARTMUSEUM_MK_VERSION)) variables:'
	@echo '    CHARTMUSEUM=$(CHARTMUSEUM)'
	@echo

_view_framework_targets :: _cmm_view_framework_targets
_cmm_view_framework_targets ::
	@echo 'ChartMuseuM:: ($(_CHARTMUSEUM_MK_VERSION)) targets:'
	@echo '    _cmm_show_version               - Show version of chartmuseum'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/chartmuseum_chart.mk
-include $(MK_DIR)/chartmuseum_server.mk


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cmm_show_version:
	@$(INFO) '$(CMM_UI_LABEL)Showing version of chartmuseum ...'; $(NORMAL)
	$(CHARTMUSEUM) --version
