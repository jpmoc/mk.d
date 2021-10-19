_CHARTMUSEUM_HELM_MK_VERSION= $(_CHARTMUSEUM_MK_VERSION)

# CMM_HELM_CHART_DIRPATH?= mychart/
CMM_HELM_REPOSITORY_URL?= http://localhost:8080
CMN_HELM_REPOSITORY_NAME?= chartmuseum

# Derived parameters

# Option parameters
__CMM_VERSION= $(if $(CMM_HELM_CHART_VERSION), --version $(CMM_HELM_CHART_VERSION))

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_cmm_view_framework_macros ::
	@echo 'ChartMuseuM::Helm ($(_CHARTMUSEUM_HELM_MK_VERSION)) macros:'
	@echo

_cmm_view_framework_parameters ::
	@echo 'ChartMuseuM::Helm ($(_CHARTMUSEUM_HELM_MK_VERSION)) variables:'
	@echo '    CMM_HELM_CHART_DIRPATH=$(CMM_HELM_CHART_DIRPATH)'
	@echo '    CMM_HELM_CHART_VERSION=$(CMM_HELM_CHART_VERSION)'
	@echo '    CMM_HELM_REPOSITORY_NAME=$(CMM_HELM_REPOSITORY_NAME)'
	@echo '    CMM_HELM_REPOSITORY_URL=$(CMM_HELM_REPOSITORY_URL)'
	@echo

_cmm_view_framework_targets ::
	@echo 'ChartMuseuM::Helm ($(_CHARTMUSEUM_HELM_MK_VERSION)) targets:'
	@echo '    _cmm_add_helm_repository            - Add helm repository'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cmm_add_helm_repository:
	@$(INFO) '$(CMM_UI_LABEL)Adding helm repository "$(CMM_HELM_REPOSITORY_NAME)"  ...'; $(NORMAL)
	$(HELM) $(strip $(__CMM_PORT) $(__CMM_STORAGE) $(__CMM_STORAGE_AMAZON_BUCKET) $(__CMM_STORAGE_AMAZON_PREFIX) $(__CMM_STORAGE_AMAZONREGION) $(__CMM_STORAGE_LOCAL_ROOTDIR) )


_cmn_install_helm_plugin:
	@$(INFO) '$(CMM_UI_LABEL)Installing helm plugins  ...'; $(NORMAL)
	$(HELM) plugin install https://github.com/chartmuseum/helm-push

_cmn_push_helm_chart:
	@$(INFO) '$(CMM_UI_LABEL)Pushing content of directory "$(CMM_HELP_CHART_DIRPATH)" to helm repository ...'; $(NORMAL)
	$(HELM) push $(__CMM_VERSION) $(CMM_HELM_CHART_DIRPATH) $(CMM_HELM_CHART_REPOSITORY_NAME)
