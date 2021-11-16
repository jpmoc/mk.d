_HELM_CHARTSOURCE_MK_VERSION= $(_HELM_MK_VERSION)

# HLM_CHARTSOURCE_APPLICATION_VERSION?= 1.16.0
# HLM_CHARTSOURCE_CHART_NAME?= redis
# HLM_CHARTSOURCE_CHART_VERSION?= 0.1.0
# HLM_CHARTSOURCE_CHARTPACKAGE_DIRPATH?= ./
# HLM_CHARTSOURCE_CHARTPACKAGE_FILENAME?= mychart-0.1.0.tgz
# HLM_CHARTSOURCE_CHARTPACKAGE_FILEPATH?= ./mychart-0.1.0.tgz
# HLM_CHARTSOURCE_DEPENDENCIES_DIRPATH?= ./my-chart/charts/
# HLM_CHARTSOURCE_DIRPATH?= ./my-chart-source/
# HLM_CHARTSOURCE_METADATA_DIRPATH?= ./my-chart/
HLM_CHARTSOURCE_METADATA_FILENAME?= Chart.yaml
# HLM_CHARTSOURCE_METADATA_FILEPATH?= ./my-chart/Charts.yaml
# HLM_CHARTSOURCE_NAME?= redis
# HLM_CHARTSOURCE_NOTES_DIRPATH?= ./my-chart/templates/
HLM_CHARTSOURCE_NOTES_FILENAME?= NOTES.txt
# HLM_CHARTSOURCE_NOTES_FILEPATH?= ./my-chart/templates/NOTES.txt
# HLM_CHARTSOURCE_PROVENANCE_FILEPATH?= mychart-0.1.0.tgz.prov
# HLM_CHARTSOURCE_README_DIRPATH?= ./my-chart/templates/
HLM_CHARTSOURCE_README_FILENAME?= README.txt
# HLM_CHARTSOURCE_README_FILEPATH?= ./my-chart/README.txt
# HLM_CHARTSOURCE_STARTER_FILEPATH?=
# HLM_CHARTSOURCE_STARTER_NAME?=
# HLM_CHARTSOURCE_TEMPLATES_DIRPATH?= ./my-chart/templates/
# HLM_CHARTSOURCE_TESTS_DIRPATH?= ./my-chart/templates/tests/
# HLM_CHART_UNTAR_FLAG?= false
# HLM_CHARTSOURCE_VALUES_DIRPATH?= ./my-chart/
HLM_CHARTSOURCE_VALUES_FILENAME?= values.yaml
# HLM_CHARTSOURCE_VALUES_FILEPATH?= ./my-chart/values.yml
# HLM_CHARTSOURCE_VERSION?= 0.10.1
# HLM_CHARTSOURCES_DIRPATH?= ./
HLM_CHARTSOURCES_REGEX?= .*
# HLM_CHARTSOURCES_SET_NAME?= chart-sources@./

# Derived parameters
HLM_CHARTSOURCE_CHARTPACKAGE_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
HLM_CHARTSOURCE_CHARTPACKAGE_FILEPATH?= $(HLM_CHARTPACKAGE_FILEPATH)
HLM_CHARTSOURCE_DEPENDENCIES_DIRPATH?= $(HLM_CHARTSOURCE_DIRPATH)charts/
HLM_CHARTSOURCE_DIRPATH?= $(HLM_CHARTSOURCES_DIRPATH)$(HLM_CHARTSOURCE_NAME)/
HLM_CHARTSOURCE_METADATA_DIRPATH?= $(HLM_CHARTSOURCE_DIRPATH)
HLM_CHARTSOURCE_METADATA_FILEPATH?= $(HLM_CHARTSOURCE_METADATA_DIRPATH)$(HLM_CHARTSOURCE_METADATA_FILENAME)
HLM_CHARTSOURCE_NAME?= $(HLM_CHART_NAME)
HLM_CHARTSOURCE_NOTES_DIRPATH?= $(HLM_CHARTSOURCE_TEMPLATES_DIRPATH)
HLM_CHARTSOURCE_NOTES_FILEPATH?= $(HLM_CHARTSOURCE_NOTES_DIRPATH)$(HLM_CHARTSOURCE_NOTES_FILENAME)
HLM_CHARTSOURCE_README_DIRPATH?= $(HLM_CHARTSOURCE_DIRPATH)
HLM_CHARTSOURCE_README_FILEPATH?= $(HLM_CHARTSOURCE_README_DIRPATH)$(HLM_CHARTSOURCE_README_FILENAME)
HLM_CHARTSOURCE_TEMPLATES_DIRPATH?= $(HLM_CHARTSOURCE_DIRPATH)templates/
HLM_CHARTSOURCE_TESTS_DIRPATH?= $(HLM_CHARTSOURCE_TEMPLATES_DIRPATH)tests
HLM_CHARTSOURCE_VALUES_DIRPATH?= $(HLM_CHARTSOURCE_DIRPATH)
HLM_CHARTSOURCE_VALUES_FILEPATH?= $(HLM_CHARTSOURCE_VALUES_DIRPATH)$(HLM_CHARTSOURCE_VALUES_FILENAME)
HLM_CHARTSOURCES_SET_NAME?= chart-sources@$(HLM_CHARTSOURCES_DIRPATH)

# Options
__HLM_DESTINATION__CHARTSOURCE= $(if $(HLM_CHARTSOURCE_CHARTPACKAGE_DIRPATH),--destination $(HLM_CHARTSOURCE_CHARTPACKAGE_DIRPATH))
__HLM_STARTER= $(if $(HLM_CHARTSOURCE_STARTER_NAME),--starter $(HLM_CHARTSOURCE_STRATER_NAME))

# Customizations
_HLM_CREATE_CHARTSOURCE_|?=
_HLM_DOWNLOAD_CHARTSOURCE_|?= $(_HLM_CREATE_CHARTSOURCE_|)
_HLM_SHOW_CHARTSOURCE_CHARTPACKAGE_|?= [ ! -f $(HLM_CHARTSOURCE_CHARTPACKAGE_FILEPATH) ] || #
_HLM_SHOW_CHARTSOURCE_NOTES_|?= [ ! -f $(HLM_CHARTSOURCE_NOTES_FILEPATH) ] || #
_HLM_SHOW_CHARTSOURCE_README_|?= [ ! -f $(HLM_CHARTSOURCE_README_FILEPATH) ] || #
|_HLM_LIST_CHARTSOURCES?= #
|_HLM_LIST_CHARTSOURCES_SET?= | grep $(HLM_CHARTSOURCES_REGEX)#
|_HLM_SHOW_CHARTSOURCE_DEPENDENCIES?= | yq eval '.dependencies // ""' -
|_HLM_SHOW_CHARTSOURCE_MANIFEST?= | head -15; echo '...' 
|_HLM_SHOW_CHARTSOURCE_NOTES?= | head -15; echo '...'
|_HLM_SHOW_CHARTSOURCE_README?= | head -15; echo '...'
|_HLM_SHOW_CHARTSOURCE_VALUES?= | head -15; echo '...' 

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_hlm_list_macros ::
	@#echo 'HeLM::ChartSource ($(_HELM_CHARTSOURCE_MK_VERSION)) macros:'
	@#echo

_hlm_list_parameters ::
	@echo 'HeLM::ChartSource ($(_HELM_CHARTSOURCE_MK_VERSION)) parameters:'
	@echo '    HLM_CHARTSOURCE_APPLICATION_VERSION=$(HLM_CHARTSOURCE_APPLICATION_VERSION)'
	@echo '    HLM_CHARTSOURCE_CHART_NAME=$(HLM_CHARTSOURCE_CHART_NAME)'
	@echo '    HLM_CHARTSOURCE_CHART_VERSION=$(HLM_CHARTSOURCE_CHART_VERSION)'
	@echo '    HLM_CHARTSOURCE_CHARTPACKAGE_DIRPATH=$(HLM_CHARTSOURCE_CHARTPACKAGE_DIRPATH)'
	@echo '    HLM_CHARTSOURCE_CHARTPACKAGE_FILENAME=$(HLM_CHARTSOURCE_CHARTPACKAGE_FILENAME)'
	@echo '    HLM_CHARTSOURCE_CHARTPACKAGE_FILEPATH=$(HLM_CHARTSOURCE_CHARTPACKAGE_FILEPATH)'
	@echo '    HLM_CHARTSOURCE_DEPENDENCIES_DIRPATH=$(HLM_CHARTSOURCE_DEPENDENCIES_DIRPATH)'
	@echo '    HLM_CHARTSOURCE_DIRPATH=$(HLM_CHARTSOURCE_DIRPATH)'
	@echo '    HLM_CHARTSOURCE_METADATA_DIRPATH=$(HLM_CHARTSOURCE_METADATA_DIRPATH)'
	@echo '    HLM_CHARTSOURCE_METADATA_FILENAME=$(HLM_CHARTSOURCE_METADATA_FILENAME)'
	@echo '    HLM_CHARTSOURCE_METADATA_FILEPATH=$(HLM_CHARTSOURCE_METADATA_FILEPATH)'
	@echo '    HLM_CHARTSOURCE_NAME=$(HLM_CHARTSOURCE_NAME)'
	@echo '    HLM_CHARTSOURCE_NOTES_DIRPATH=$(HLM_CHARTSOURCE_NOTES_DIRPATH)'
	@echo '    HLM_CHARTSOURCE_NOTES_FILENAME=$(HLM_CHARTSOURCE_NOTES_FILENAME)'
	@echo '    HLM_CHARTSOURCE_NOTES_FILEPATH=$(HLM_CHARTSOURCE_NOTES_FILEPATH)'
	@echo '    HLM_CHARTSOURCE_README_DIRPATH=$(HLM_CHARTSOURCE_README_DIRPATH)'
	@echo '    HLM_CHARTSOURCE_README_FILENAME=$(HLM_CHARTSOURCE_README_FILENAME)'
	@echo '    HLM_CHARTSOURCE_README_FILEPATH=$(HLM_CHARTSOURCE_README_FILEPATH)'
	@echo '    HLM_CHARTSOURCE_STARTER_FILEPATH=$(HLM_CHARTSOURCE_STARTER_FILEPATH)'
	@echo '    HLM_CHARTSOURCE_STARTER_NAME=$(HLM_CHARTSOURCE_STARTER_NAME)'
	@echo '    HLM_CHARTSOURCE_TEMPLATES_DIRPATH=$(HLM_CHARTSOURCE_TEMPLATES_DIRPATH)'
	@echo '    HLM_CHARTSOURCE_TESTS_DIRPATH=$(HLM_CHARTSOURCE_TESTS_DIRPATH)'
	@echo '    HLM_CHARTSOURCE_VALUES_DIRPATH=$(HLM_CHARTSOURCE_VALUES_DIRPATH)'
	@echo '    HLM_CHARTSOURCE_VALUES_FILENAME=$(HLM_CHARTSOURCE_VALUES_FILENAME)'
	@echo '    HLM_CHARTSOURCE_VALUES_FILEPATH=$(HLM_CHARTSOURCE_VALUES_FILEPATH)'
	@echo '    HLM_CHARTSOURCES_DIRPATH=$(HLM_CHARTSOURCES_DIRPATH)'
	@echo '    HLM_CHARTSOURCES_REGEX=$(HLM_CHARTSOURCES_REGEX)'
	@echo '    HLM_CHARTSOURCES_SET_NAME=$(HLM_CHARTSOURCES_SET_NAME)'
	@echo

_hlm_list_targets ::
	@echo 'HeLM::ChartSource ($(_HELM_CHARTSOURCE_MK_VERSION)) targets:'
	@echo '    _hlm_create_chartsource             - Create a chart-source'
	@echo '    _hlm_download_chartsource           - Download a chart-source froma repository'
	@echo '    _hlm_lint_chartsource               - Lint a chart-source' 
	@echo '    _hlm_list_chartsources              - List all chart-sources' 
	@echo '    _hlm_list_chartsources_set          - List a set of chart-sources' 
	@echo '    _hlm_package_chartsource            - Package the chart-source in a chart-package'
	@echo '    _hlm_show_chartsource               - Show everything related to a chart-source' 
	@echo '    _hlm_show_chartsource_description   - Show the Charts.yaml file of a chart-source' 
	@echo '    _hlm_show_chartsource_notes         - Show the templates/NOTES.txt of a chart-source' 
	@echo '    _hlm_show_chartsource_values        - Show the values.yaml of a chart-source' 
	@echo '    _hlm_unpackage_chartsource          - Extract the chart-source from a chart-package'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_hlm_create_chartsource:
	@$(INFO) '$(HLM_UI_LABEL)Creating chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	# $(_HLM_CREATE_CHARTSOURCE_|)$(HELM) create $(__HLM_STARTER) $(HLM_CHARTSOURCE_DIRPATH)
	$(_HLM_CREATE_CHARTSOURCE_|)$(HELM) create $(__HLM_STARTER) $(HLM_CHARTSOURCES_DIRPATH)$(HLM_CHARTSOURCE_NAME)

_hlm_delete_chartsource:
	@$(INFO) '$(HLM_UI_LABEL)Deleting chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	rm -rf $(HLM_CHARTSOURCE_DIRPATH) 

_hlm_lint_chartsource:
	@$(INFO) '$(HLM_UI_LABEL)Linting chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation ascertains that chart-templates can be expended correcty'; $(NORMAL)
	@$(WARN) 'Among others, linting checks for naming requirements, length restriction, and etc.'; $(NORMAL)
	@$(WARN) 'Linting also canmade recommendations.'; $(NORMAL)
	$(HELM) lint $(HLM_CHARTSOURCE_DIRPATH)

_hlm_list_chartsources:
	@$(INFO) '$(HLM_UI_LABEL)Listing ALL chart-sources ...'; $(NORMAL)
	ls -al $(HLM_CHARTSOURCES_DIRPATH)

_hlm_list_chartsources_set:
	@$(INFO) '$(HLM_UI_LABEL)Listing chart-sources-set "$(HLM_CHARTSOURCES_SET_NAME)" ...'; $(NORMAL)
	ls -al $(HLM_CHARTSOURCES_DIRPATH) $(|_HLM_LIST_CHARTSOURCES_SET)

_hlm_package_chartsource:
	@$(INFO) '$(HLM_UI_LABEL)Packaging chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a tarball using Metadata from the Chart.yaml such as name and version of the chart'; $(NORMAL)
	@$(WARN) 'The resulting tarball can be published in a chart repository'; $(NORMAL)
	$(HELM) package $(__HLM_DESTINATION__CHARTSOURCE) $(HLM_CHARTSOURCE_DIRPATH)

_HLM_SHOW_CHARTSOURCE_TARGETS?= _hlm_show_chartsource_chartpackage _hlm_show_chartsource_dependencies _hlm_show_chartsource_lint _hlm_show_chartsource_manifest _hlm_show_chartsource_metadata _hlm_show_chartsource_notes _hlm_show_chartsource_readme _hlm_show_chartsource_tests _hlm_show_chartsource_values _hlm_show_chartsource_description
_hlm_show_chartsource: $(_HLM_SHOW_CHARTSOURCE_TARGETS)

_hlm_show_chartsource_dependencies:
	@$(INFO) '$(HLM_UI_LABEL)Showing dependencies of chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation looks for dependencies in the chart metadata file and in the chart-source under the charts directory'; $(NORMAL)
	# cat $(HLM_CHARTSOURCE_METADATA_FILEPATH) $(|_HLM_SHOW_CHARTSOURCE_DEPENDENCIES)
	# ls -la $(HLM_CHARTSOURCE_DEPENDENCIES_DIRPATH)
	$(HELM) dependency list $(HLM_CHARTSOURCE_DIRPATH)

_hlm_show_chartsource_description:
	@$(INFO) '$(HLM_UI_LABEL)Showing description of chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	ls -alR $(HLM_CHARTSOURCE_DIRPATH)
	tree $(HLM_CHARTSOURCE_DIRPATH)

_hlm_show_chartsource_chartpackage:
	@$(INFO) '$(HLM_UI_LABEL)Showing chart-package of chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	$(if $(HLM_CHARTSOURCE_CHARTPACKAGE_FILEPATH), \
		$(_HLM_SHOW_CHARTSOURCE_CHARTPACKAGE_|)ls -la $(HLM_CHARTSOURCE_CHARTPACKAGE_FILEPATH)\
	, \
		@echo 'HLM_CHARTSOURCE_CHARTPACKAGE_FILEPATH not set' \
	)

_hlm_show_chartsource_lint:
	@$(INFO) '$(HLM_UI_LABEL)Showing lint-recommendations on chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	$(HELM) lint $(HLM_CHARTSOURCE_DIRPATH)

_hlm_show_chartsource_manifest:
	@$(INFO) '$(HLM_UI_LABEL)Showing manifest generated using the template from chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is using the default values in the templates'; $(NORMAL)
	$(HELM) template $(HLM_CHARTSOURCE_DIRPATH) $(|_HLM_SHOW_CHARTSOURCE_MANIFEST)

_hlm_show_chartsource_metadata:
	@$(INFO) '$(HLM_UI_LABEL)Showing metadata of chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation displays the content of the Chart.yaml file in the chart-source'; $(NORMAL)
	cat $(HLM_CHARTSOURCE_METADATA_FILEPATH)

_hlm_show_chartsource_notes:
	@$(INFO) '$(HLM_UI_LABEL)Showing notes in chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation displays the content of the NOTES.txt file in template directory of the chart-source'; $(NORMAL)
	i$(_HLM_SHOW_CHARTSOURCE_NOTES_|)cat $(HLM_CHARTSOURCE_NOTES_FILEPATH) $(|_HLM_SHOW_CHARTSOURCE_NOTES)
	
_hlm_show_chartsource_readme:
	@$(INFO) '$(HLM_UI_LABEL)Showing readme in chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	$(_HLM_SHOW_CHARTSOURCE_README_|)cat $(HLM_CHARTSOURCE_README_FILEPATH) $(|_HLM_SHOW_CHARTSOURCE_README)

_hlm_show_chartsource_tests:
	@$(INFO) '$(HLM_UI_LABEL)Showing test-files in chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	ls -al $(HLM_CHARTSOURCE_TESTS_DIRPATH)

_hlm_show_chartsource_values:
	@$(INFO) '$(HLM_UI_LABEL)Showing parameters/values of chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation displays the content of the value.yml file in the chart-source'; $(NORMAL)
	cat $(HLM_CHARTSOURCE_VALUES_FILEPATH) $(|_HLM_SHOW_CHARTSOURCE_VALUES)

_hlm_unpackage_chartsource:
	@$(INFO) '$(HLM_UI_LABEL)Un-packaging chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	tar xvzf $(HLM_CHARTSOURCE_CHARTPACKAGE_FILEPATH)

_hlm_watch_chartsources:
	@$(INFO) '$(HLM_UI_LABEL)Watching ALL chart-sources ...'; $(NORMAL)

_hlm_watch_chartsources_set:
	@$(INFO) '$(HLM_UI_LABEL)Watching chart-sources-set "$(HLM_CHARTSOURCES_SET_NAME)" ...'; $(NORMAL)
