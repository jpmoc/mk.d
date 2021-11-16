_HELM_CHART_MK_VERSION= $(_HELM_MK_VERSION)

# HLM_CHART_APPLICATION_VERSION?= 1.16.0
# HLM_CHART_CNAME?= stable/redis
# HLM_CHART_NAME?= redis
# HLM_CHART_RELEASE_NAME?= my-release
# HLM_CHART_REPOSITORY_NAME?= stable
HLM_CHART_VERSION?= latest
# HLM_CHARTS_DIRPATH?= ./
# HLM_CHARTS_REPOSITORY_NAME?= bitnami
# HLM_CHARTS_SET_NAME?= my-charts-set

# Derived parameters
HLM_CHART_CNAME?= $(HLM_CHART_REPOSITORY_NAME)/$(HLM_CHART_NAME)
HLM_CHART_REPOSITORY_NAME?= $(HLM_REPOSITORY_NAME)
HLM_CHARTS_REPOSITORY_NAME?= $(HLM_CHART_REPOSITORY_NAME)
HLM_CHARTS_SET_NAME?= charts@$(HLM_CHARTS_REPOSITORY_NAME)

# Options
__HLM_CA_FILE=
__HLM_CERT_FILE=
__HLM_DESTINATION= $(if $(HLM_CHARTS_DIRPATH),--destination $(HLM_CHARTS_DIRPATH))
__HLM_KEY_FILE=
__HLM_KEYRING= $(if $(HLM_CHART_KEYRING_FILEPATH),--keyring $(HLM_CHART_KEYRING_FILEPATH))
__HLM_NAME= $(if $(HLM_CHART_RELEASE_NAME),--name $(HLM_CHART_RELEASE_NAME))
__HLM_PASSWORD=
__HLM_REGEXP__CHARTS= $(if $(HLM_CHARTS_REGEX),--regexp $(HLM_CHARTS_REGEX))
__HLM_REPO=
__HLM_SET= $(if $(HLM_CHART_PARAMETERS_SET),--set $(subst $(SPACE),$(COMMA),$(strip $(HLM_CHART_RELEASEPARAMETERS_SET))))
__HLM_UNTAR= $(if $(filter true, $(HLM_CHART_UNTAR_FLAG)),--untar)
__HLM_UNTARDIR= $(if $(HLM_CHART_UNTAR_DIRPATH),--untardir $(HLM_CHART_UNTAR_DIRPATH))
__HLM_USERNAME=
__HLM_VERSION__CHART= $(if $(filter-out latest,$(HLM_CHART_VERSION)),--version $(HLM_CHART_VERSION))

# Customizations
|_HLM_LIST_CHARTS?= #
|_HLM_LIST_CHARTS_SET?= #
|_HLM_SHOW_CHART_DEPENDENCIES?= | yq eval --no-colors '.dependencies' -
|_HLM_SHOW_CHART_HUB?= | head -15; echo '...'
|_HLM_SHOW_CHART_README?= | head -15; echo '...'
|_HLM_SHOW_CHART_VALUES?= | head -15; echo '...'
|_HLM_SHOW_CHART_VERSIONS?= | head -15; echo '...'

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_hlm_list_macros ::
	@#echo 'HeLM::Chart ($(_HELM_CHART_MK_VERSION)) macros:'
	@#echo

_hlm_list_parameters ::
	@echo 'HeLM::Chart ($(_HELM_CHART_MK_VERSION)) parameters:'
	@echo '    HLM_CHART_APPLICATION_VERSION=$(HLM_CHART_APPLICATION_VERSION)'
	@echo '    HLM_CHART_CNAME=$(HLM_CHART_CNAME)'
	@echo '    HLM_CHART_NAME=$(HLM_CHART_NAME)'
	@echo '    HLM_CHART_RELEASE_NAME=$(HLM_CHART_RELEASE_NAME)'
	@echo '    HLM_CHART_REPOSITORY_NAME=$(HLM_CHART_REPOSITORY_NAME)'
	@echo '    HLM_CHART_VERSION=$(HLM_CHART_VERSION)'
	@echo '    HLM_CHARTS_REPOSITORY_NAME=$(HLM_CHARTS_REPOSITORY_NAME)'
	@echo '    HLM_CHARTS_SET_NAME=$(HLM_CHARTS_SET_NAME)'
	@echo

_hlm_list_targets ::
	@echo 'HeLM::Chart ($(_HELM_CHART_MK_VERSION)) targets:'
	@#echo '    _hlm_create_charts            - Create a charts' 
	@#echo '    _hlm_delete_charts            - Delete a charts' 
	@echo '    _hlm_list_charts              - List all charts' 
	@echo '    _hlm_list_charts              - List all charts' 
	@echo '    _hlm_list_charts_set          - List a set of charts' 
	@echo '    _hlm_show_chart               - Show everything related to a chart' 
	@echo '    _hlm_show_chart_description   - Show the Charts.yaml file of a chart' 
	@echo '    _hlm_show_chart_hub           - Show the possible location of a chart' 
	@echo '    _hlm_show_chart_notes         - Show the templates/NOTES.txt of a chart' 
	@echo '    _hlm_show_chart_values        - Show the values.yaml of a chart' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_hlm_create_chart: # _hlm_create_chartsource

_hlm_delete_chart: # _hlm_unpublish_chartpackage _hlm_delete_chartsource

_hlm_download_chart: # _hlm_download_chartsource

_hlm_expend_chart:
	@$(INFO) '$(HLM_UI_LABEL)Expending chart ...'; $(NORMAL)
	# $(HELM) template NAME $(HLM_CHART_NAME)

_hlm_list_charts:
	@$(INFO) '$(HLM_UI_LABEL)Listing ALL charts ...'; $(NORMAL)
	$(HELM) search repo $(_X__HLM_REGEXP__CHARTS) --versions $(|_HLM_LIST_CHARTS)

_hlm_list_charts_set:
	@$(INFO) '$(HLM_UI_LABEL)Listing charts-set "$(HLM_CHARTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Charts are grouped based on provided repository, regex, pipe'; $(NORMAL)
	$(HELM) search repo $(__HLM_REGEXP__CHARTS) --versions $(HLM_CHARTS_REPOSITORY_NAME) $(|_HLM_LIST_CHARTS_SET)

_HLM_SHOW_CHART_TARGETS?= _hlm_show_chart_dependencies _hlm_show_chart_hub _hlm_show_chart_readme _hlm_show_chart_values _hlm_show_chart_versions _hlm_show_chart_description
_hlm_show_chart: $(_HLM_SHOW_CHART_TARGETS)

_hlm_show_chart_dependencies ::
	@$(INFO) '$(HLM_UI_LABEL)Showing dependencies of chart "$(HLM_CHART_NAME)" ...'; $(NORMAL)
	$(HELM) inspect chart $(strip $(__HLM_CERT_FILE) $(__HLM_KEY_FILE) $(__HLM_KEYRING) $(__HLM_PASSWORD) $(__HLM_REPO) $(__HLM_USERNAME) $(__HLM_VERIFY) $(__HLM_VERSION__CHART)) $(HLM_CHART_CNAME) | yq eval --no-colors '.dependencies' - 

_hlm_show_chart_description:
	@$(INFO) '$(HLM_UI_LABEL)Showing description of chart "$(HLM_CHART_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation displays the content of the Chart.yaml file in the chart-source'; $(NORMAL)
	@$(WARN) 'If the chart-version is not specified, the latest version is assumed'; $(NORMAL)
	$(HELM) inspect chart $(strip $(__HLM_CERT_FILE) $(__HLM_KEY_FILE) $(__HLM_KEYRING) $(__HLM_PASSWORD) $(__HLM_REPO) $(__HLM_USERNAME) $(__HLM_VERIFY) $(__HLM_VERSION__CHART) ) $(HLM_CHART_CNAME) $(|_SHOW_CHART_DESCRIPTION)

_hlm_show_chart_hub:
	@$(INFO) '$(HLM_UI_LABEL)Showing community-hub for chart "$(HLM_CHART_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is looking at the community repository, aka hub'; $(NORMAL)
	$(HELM) search hub $(HLM_CHART_NAME) $(|_HLM_SHOW_CHART_HUB)

_hlm_show_chart_readme:
	@$(INFO) '$(HLM_UI_LABEL)Showing readme in chart "$(HLM_CHART_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation displays the content of the README.md file'; $(NORMAL)
	@$(WARN) 'If the chart-version is not specified, the latest version is assumed'; $(NORMAL)
	$(HELM) inspect readme $(strip $(__HLM_CERT_FILE) $(__HLM_KEY_FILE) $(__HLM_KEYRING) $(__HLM_PASSWORD) $(__HLM_REPO) $(__HLM_USERNAME) $(__HLM_VERIFY) $(__HLM_VERSION__CHART) ) $(HLM_CHART_CNAME) $(|_HLM_SHOW_CHART_README)
	
_hlm_show_chart_values:
	@$(INFO) '$(HLM_UI_LABEL)Showing parameters/values to configure chart "$(HLM_CHART_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation displays the content of the default values.yaml file'; $(NORMAL)
	@$(WARN) 'If the chart-version is not specified, the latest version is assumed'; $(NORMAL)
	$(HELM) inspect values $(strip $(__HLM_CERT_FILE) $(__HLM_KEY_FILE) $(__HLM_KEYRING) $(__HLM_PASSWORD) $(__HLM_REPO) $(__HLM_USERNAME) $(__HLM_VERIFY) $(__HLM_VERSION__CHART) ) $(HLM_CHART_CNAME) $(|_HLM_SHOW_CHART_VALUES)

_hlm_show_chart_versions:
	@$(INFO) '$(HLM_UI_LABEL)Showing chart-versions of chart "$(HLM_CHART_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is looking at ALL the registered/added repositories'; $(NORMAL)
	$(HELM) search repo --versions --regexp "$(HLM_CHART_NAME)" $(|_HLM_SHOW_CHART_VERSIONS)

_hlm_watch_charts:
	@$(INFO) '$(HLM_UI_LABEL)Watching ALL charts ...'; $(NORMAL)

_hlm_watch_charts_set:
	@$(INFO) '$(HLM_UI_LABEL)Watching charts-set "$(HLM_CHARTS_SET_NAME)" ...'; $(NORMAL)
