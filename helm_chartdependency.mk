_HELM_CHARTDEPENDENCY_MK_VERSION= $(_HELM_MK_VERSION)

# HLM_CHARTDEPENDENCIES_CHART_NAME?= my-chart
# HLM_CHARTDEPENDENCIES_CHARTSOURCE_DIRPATH?= ./my-chart

# Derived parameters
HLM_CHARTDEPENDENCIES_CHART_NAME?= $(HLM_CHART_NAME)
HLM_CHARTDEPENDENCIES_CHARTSOURCE_DIRPATH?= $(HLM_CHART_SOURCE_DIRPATH)

# Options

# Customizations

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_hlm_list_macros ::
	@echo 'HeLM::ChartDependency ($(_HELM_CHARTDEPENDENCY_MK_VERSION)) macros:'
	@echo

_hlm_list_parameters ::
	@echo 'HeLM::Chart ($(_HELM_CHARTDEPENDENCY_MK_VERSION)) parameters:'
	@echo '    HLM_CHARTDEPENDENCIES_CHART_NAME=$(HLM_CHARTDEPENCIES_CHART_NAME)'
	@echo '    HLM_CHARTDEPENDENCIES_CHARTSOURCE_DIRPATH=$(HLM_CHARTDEPENCIES_CHARTSOURCE_DIRPATH)'
	@echo

_hlm_list_targets ::
	@echo 'HeLM::Chart ($(_HELM_CHARTDEPENDENCY_MK_VERSION)) targets:'
	@echo '    _hlm_list_chartdependencies           - List all the dependencies of a chart' 
	@echo '    _hlm_update_chartdependencies         - Update the dependencies of a chart' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_hlm_list_chartdependencies:
	@$(INFO) '$(HLM_UI_LABEL)Listing ALL dependencies of chart "$(HLM_CHARTDEPENDENCIES_CHART_NAME)" ...'; $(NORMAL)
	$(HELM) dependencies list $(HLM_CHARTDEPENDENCIES_CHARTSOURCE_DIRPATH)

_hlm_update_chartdependencies:
	@$(INFO) '$(HLM_UI_LABEL)Updating dependencies of chart "$(HLM_CHARTDEPENDENCIES_CHART_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will use the already-configured chart repositories to find the dependencies'; $(NORMAL)
	$(HELM) dependencies update $(HLM_CHARTDEPENDENCIES_CHARTSOURCE_DIRPATH)
