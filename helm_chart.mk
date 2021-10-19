_HELM_CHART_MK_VERSION= $(_HELM_MK_VERSION)

# HLM_CHART_CNAME?= stable/redis
# HLM_CHART_DIRPATH?= ./my-chart/
HLM_CHART_KEYRING_FILEPATH?= $(HOME)/.gnupg/pubring.gpg
# HLM_CHART_NAME?= redis
# HLM_CHART_PROVENANCE_FILEPATH?= mychart-0.1.0.tgz.prov
# HLM_CHART_RELEASEPARAMETERS_FILEPATH?= ./values.yml
# HLM_CHART_RELEASEPARAMETERS_SET?= key1=val1 key2=val2
# HLM_CHART_RELEASE_NAME?= my-release
# HLM_CHART_REPOSITORY_NAME?= stable
# HLM_CHART_STARTED?= <scaffold>
# HLM_CHART_TGZ_DIRPATH?= ./
# HLM_CHART_TGZ_FILENAME?= mychart-0.1.0.tgz
# HLM_CHART_TGZ_FILEPATH?= ./mychart-0.1.0.tgz
# HLM_CHART_UNTAR_ENABLE?= false
# HLM_CHART_VALUES_DIRPATH?= ./my-chart/
# HLM_CHART_VALUES_FILENAME?= values.yml
# HLM_CHART_VALUES_FILEPATH?= ./my-chart/values.yml
# HLM_CHART_VERSION?= 0.10.1
# HLM_CHARTS_DIRPATH?= ./
# HLM_CHARTS_REPOSITORY_NAME?= bitnami
# HLM_CHARTS_SEARCH_VERSION?= 0.10.1
# HLM_CHARTS_SET_NAME?= my-charts-set

# Derived parameters
HLM_CHART_CNAME?= $(HLM_CHART_DIRPATH)
HLM_CHART_NAME?= $(lastword $(subst /,$(SPACE),$(HLM_CHART_CNAME)))
HLM_CHART_REPOSITORY_NAME?= $(word 1, $(subst /,$(SPACE),$(HLM_CHART_CNAME)))
HLM_CHART_DIRPATH?= $(if $(HLM_CHARTS_DIRPATH),$(HLM_CHARTS_DIRPATH)$(HLM_CHART_NAME)/)
HLM_CHART_TGZ_FILENAME?= $(HLM_CHART_NAME)-$(HLM_CHART_VERSION).tgz
HLM_CHART_TGZ_FILEPATH?= $(HLM_CHART_TGZ_DIRPATH)$(HLM_CHART_TGZ_FILENAME)
HLM_CHART_PROVENANCE_FILEPATH?= $(HLM_CHART_TGZ_FILEPATH).prov
HLM_CHART_VALUES_DIRPATH?= $(HLM_CHART_DIRPATH)
HLM_CHART_VALUES_FILEPATH?= $(HLM_CHART_VALUES_DIRPATH)$(HLM_CHART_VALUES_FILENAME)
HLM_CHARTS_REPOSITORY_NAME?= $(HLM_CHART_REPOSITORY_NAME)
HLM_CHARTS_SET_NAME?= charts@$(HLM_CHARTS_REPOSITORY_NAME)

# Option parameters
__HLM_CA_FILE=
__HLM_CERT_FILE=
__HLM_DESTINATION= $(if $(HLM_CHARTS_DIRPATH),--destination $(HLM_CHARTS_DIRPATH))
__HLM_KEY_FILE=
__HLM_KEYRING= $(if $(HLM_CHART_KEYRING_FILEPATH),--keyring $(HLM_CHART_KEYRING_FILEPATH))
__HLM_NAME= $(if $(HLM_CHART_RELEASE_NAME),--name $(HLM_CHART_RELEASE_NAME))
__HLM_PASSWORD=
__HLM_PROV= $(if $(filter true, $(HLM_CHART_PROV_ENABLE)),--prov)
__HLM_REGEXP=
__HLM_REPO=
__HLM_SET= $(if $(HLM_CHART_PARAMETERS_SET),--set $(subst $(SPACE),$(COMMA),$(strip $(HLM_CHART_RELEASEPARAMETERS_SET))))
__HLM_STARTER=
__HLM_UNTAR= $(if $(filter true, $(HLM_CHART_UNTAR_ENABLE)),--untar)
__HLM_UNTARDIR= $(if $(HLM_CHART_UNTAR_DIRPATH),--untardir $(HLM_CHART_UNTAR_DIRPATH))
__HLM_USERNAME=
__HLM_VERSION__CHART= $(if $(HLM_CHART_VERSION),--version $(HLM_CHART_VERSION))

# UI parameters

# Pipes
|_HLM_SHOW_CHART_VERSIONS?= | head -10; echo '...'

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_hlm_view_framework_macros ::
	@echo 'HeLM::Chart ($(_HELM_CHART_MK_VERSION)) macros:'
	@echo

_hlm_view_framework_parameters ::
	@echo 'HeLM::Chart ($(_HELM_CHART_MK_VERSION)) parameters:'
	@echo '    HLM_CHART_CNAME=$(HLM_CHART_CNAME)'
	@echo '    HLM_CHART_DIRPATH=$(HLM_CHART_DIRPATH)'
	@echo '    HLM_CHART_NAME=$(HLM_CHART_NAME)'
	@echo '    HLM_CHART_PROV_ENABLE=$(HLM_CHART_PROV_ENABLE)'
	@echo '    HLM_CHART_RELEASEPARAMETERS_FILEPATH=$(HLM_CHART_RELEASEPARAMETERS_FILEPATH)'
	@echo '    HLM_CHART_RELEASEPARAMETERS_SET=$(HLM_CHART_RELEASEPARAMETERS_SET)'
	@echo '    HLM_CHART_RELEASE_NAME=$(HLM_CHART_RELEASE_NAME)'
	@echo '    HLM_CHART_REPOSITORY_NAME=$(HLM_CHART_REPOSITORY_NAME)'
	@echo '    HLM_CHART_STARTER=$(HLM_CHART_STARTER)'
	@echo '    HLM_CHART_TGZ_DIRPATH=$(HLM_CHART_TGZ_DIRPATH)'
	@echo '    HLM_CHART_TGZ_FILENAME=$(HLM_CHART_TGZ_FILENAME)'
	@echo '    HLM_CHART_TGZ_FILEPATH=$(HLM_CHART_TGZ_FILEPATH)'
	@echo '    HLM_CHART_UNTAR_DIRPATH=$(HLM_CHART_UNTAR_DIRPATH)'
	@echo '    HLM_CHART_UNTAR_ENABLE=$(HLM_CHART_UNTAR_ENABLE)'
	@echo '    HLM_CHART_VALUES_DIRPATH=$(HLM_CHART_VALUES_DIRPATH)'
	@echo '    HLM_CHART_VALUES_FILENAME=$(HLM_CHART_VALUES_FILENAME)'
	@echo '    HLM_CHART_VALUES_FILEPATH=$(HLM_CHART_VALUES_FILEPATH)'
	@echo '    HLM_CHART_VERSION=$(HLM_CHART_VERSION)'
	@echo '    HLM_CHARTS_DIRPATH=$(HLM_CHARTS_DIRPATH)'
	@echo '    HLM_CHARTS_REPOSITORY_NAME=$(HLM_CHARTS_REPOSITORY_NAME)'
	@echo '    HLM_CHARTS_SEARCH_VERSION=$(HLM_CHARTS_SEARCH_VERSION)'
	@echo '    HLM_CHARTS_SET_NAME=$(HLM_CHARTS_SET_NAME)'
	@echo

_hlm_view_framework_targets ::
	@echo 'HeLM::Chart ($(_HELM_CHART_MK_VERSION)) targets:'
	@echo '    _hlm_download_chart        - Download source code of a chart'
	@echo '    _hlm_seach_chart           - Search for a chart' 
	@echo '    _hlm_show_chart            - Show everything related to a chart' 
	@echo '    _hlm_show_chart_metadata   - Show the metadata of a chart' 
	@echo '    _hlm_show_chart_readme     - Show README of a chart' 
	@echo '    _hlm_show_chart_values     - Show values of a chart' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_hlm_create_chart:
	@$(INFO) '$(HLM_UI_LABEL)Create a chart ...'; $(NORMAL)
	cd $(HLM_CHARTS_DIRPATH); $(HELM) create $(__HLM_STARTER) $(HLM_CHART_NAME)

_hlm_download_chart:
	@$(INFO) '$(HLM_UI_LABEL)Downloading chart ...'; $(NORMAL)
	$(HELM) fetch $(__HLM_CA_FILE) $(__HLM_CERT_FILE) $(__HLM_DESTINATION) $(__DEVEL) $(__HLM_KEY_FILE) $(__HLM_KEYRING) $(__HLM_PASSWORD) $(__HLM_PROV) $(__HLM_REPO) $(__HLM_UNTAR) $(__HLM_UNTARDIR) $(__HLM_USERNAME) $(__HLM_VERIFY) $(__HLM_VERSION__CHART) $(HLM_CHART_CNAME)

_hlm_lint_chart:
	@$(INFO) '$(HLM_UI_LABEL)Linting chart-source ...'; $(NORMAL)
	$(HELM) lint $(HLM_CHART_DIRPATH)

_hlm_package_chart:
	@$(INFO) '$(HLM_UI_LABEL)Packaging chart-source ...'; $(NORMAL)
	@$(WARN) 'This operation creates a tarball using Metadata from the Chart.yaml'; $(NORMAL)
	$(HELM) package $(HLM_CHART_DIRPATH)

_hlm_show_chart: _hlm_show_chart_readme _hlm_show_chart_values _hlm_show_chart_versions _hlm_show_chart_description

_hlm_show_chart_dependencies ::
	@# Link to _hlm_view_dependencies

_hlm_show_chart_description:
	@$(INFO) '$(HLM_UI_LABEL)Showing description of chart "$(HLM_CHART_CNAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation displays the content of the Chart.yaml file in the chart-source'; $(NORMAL)
	$(HELM) inspect chart $(__HLM_CERT_FILE) $(__HLM_KEY_FILE) $(__HLME_KEYRING) $(__HLM_PASSWORD) $(__HLM_REPO) $(__HLM_USERNAME) $(__HLM_VERIFY) $(__HLM_VERSION__CHART) $(HLM_CHART_CNAME)

_hlm_show_chart_readme:
	@$(INFO) '$(HLM_UI_LABEL)Showing readme in chart "$(HLM_CHART_CNAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation displays the content of the README.md file in the chart-source'; $(NORMAL)
	$(HELM) inspect readme $(__HLM_CERT_FILE) $(__HLM_KEY_FILE) $(__HLME_KEYRING) $(__HLM_PASSWORD) $(__HLM_REPO) $(__HLM_USERNAME) $(__HLM_VERIFY) $(__HLM_VERSION__CHART) $(HLM_CHART_CNAME)
	
_hlm_show_chart_values:
	@$(INFO) '$(HLM_UI_LABEL)Showing parameters/values of chart "$(HLM_CHART_CNAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation displays the content of the value.yml file in the chart-source'; $(NORMAL)
	$(HELM) inspect values $(__HLM_CERT_FILE) $(__HLM_KEY_FILE) $(__HLME_KEYRING) $(__HLM_PASSWORD) $(__HLM_REPO) $(__HLM_USERNAME) $(__HLM_VERIFY) $(__HLM_VERSION__CHART) $(HLM_CHART_CNAME)

_hlm_show_chart_versions:
	@$(INFO) '$(HLM_UI_LABEL)Showing versions of chart "$(HLM_CHART_CNAME)" ...'; $(NORMAL)
	$(HELM) search repo --versions --regexp "$(HLM_CHART_CNAME)" $(|_HLM_SHOW_CHART_VERSIONS)

_hlm_view_charts:
	@$(INFO) '$(HLM_UI_LABEL)View ALL charts ...'; $(NORMAL)
	$(HELM) search repo --versions $(|_HLM_VIEW_CHARTS)

_hlm_view_charts_set:
	@$(INFO) '$(HLM_UI_LABEL)View charts-set "$(HLM_CHARTS_SET_NAME)" ...'; $(NORMAL)
	$(HELM) search repo --versions --regex '$(HLM_CHARTS_REPOSITORY_NAME)/' $(|_HLM_VIEW_CHARTS_SET)

_hlm_verify_chart:
	@$(INFO) '$(HLM_UI_LABEL)Showing parameters/values of chart "$(HLM_CHART_CNAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation requires a tarball and a provenance file'; $(NORMAL)
	$(HELM) verify $(HLM_CHART_TGZ_FILEPATH)

_hlm_watch_charts:
	@$(INFO) '$(HLM_UI_LABEL)Watching ALL charts ...'; $(NORMAL)

_hlm_watch_charts_set:
	@$(INFO) '$(HLM_UI_LABEL)Watching charts-set "$(HLM_CHARTS_SET_NAME)" ...'; $(NORMAL)
