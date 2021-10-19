_HELM_MANIFEST_MK_VERSION= $(_HELM_MK_VERSION)

# HLM_MANIFEST_CHART_NAME?= my-chart
# HLM_MANIFEST_CHARTSOURCE_DIRPATH?= ./my-chart
# HLM_MANIFEST_NAMESPACE_NAME?= my-namespace
HLM_MANIFEST_RELEASE_NAME?= release-name
# HLM_MANIFEST_TEMPLATES_FILEPATHS?= templates/deployment.yml ...
# HLM_MANIFEST_VALUES_FILEPATH?= ./chart-values.yml
HLM_MANIFEST_BUILD_|CAT?= | cat

# Derived parameters
HLM_MANIFEST_CHARTSOURCE_DIRPATH?= $(HLM_CHART_SOURCE_DIRPATH)
HLM_MANIFEST_NAMESPACE_NAME?= $(HLM_RELEASE_NAMESPACE_NAME)
HLM_MANIFEST_RELEASE_NAME?= $(HLM_RELEASE_NAME)
HLM_MANIFEST_VALUES_FILEPATH?= $(HLM_RELEASE_VALUES_FILEPATH)

# Option parameters
__HLM_EXECUTE=
__HLM_NAME__MANIFEST= $(if $(HLM_MANIFEST_RELEASE_NAME),--name $(HLM_MANIFEST_RELEASE_NAME))
__HLM_NAMESPACE__MANIFEST= $(if $(HLM_MANIFEST_NAMESPACE_NAME),--namespace $(HLM_MANIFEST_NAMESPACE_NAME))
__HLM_SET__MANIFEST= $(if $(HLM_MANIFEST_VALUES_SET),--set $(subst $(SPACE),$(COMMA),$(strip $(HLM_MANIFEST_VALUES_SET))))
__HLM_VALUES__MANIFEST= $(if $(HLM_MANIFEST_VALUES_FILEPATH),--values $(HLM_MANIFEST_VALUES_FILEPATH))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_hlm_view_framework_macros ::
	@echo 'HeLM::Manifest ($(_HELM_MANIFEST_MK_VERSION)) macros:'
	@echo

_hlm_view_framework_parameters ::
	@echo 'HeLM::Manifest ($(_HELM_MANIFEST_MK_VERSION)) parameters:'
	@echo '    HLM_MANIFEST_CHART_NAME=$(HLM_MANIFEST_CHART_NAME)'
	@echo '    HLM_MANIFEST_CHARTSOURCE_DIRPATH=$(HLM_MANIFEST_CHARTSOURCE_DIRPATH)'
	@echo '    HLM_MANIFEST_NAMESPACE_NAME=$(HLM_MANIFEST_NAMESPACE_NAME)'
	@echo '    HLM_MANIFEST_RELEASE_NAME=$(HLM_MANIFEST_RELEASE_NAME)'
	@echo '    HLM_MANIFEST_TEMPLATES_FILEPATHS=$(HLM_MANIFEST_TEMPLATES_FILEPATHS)'
	@echo '    HLM_MANIFEST_VALUES_FILEPATH=$(HLM_MANIFEST_VALUES_FILEPATH)'
	@echo '    HLM_MANIFEST_VALUES_SET=$(HLM_MANIFEST_VALUES_SET)'
	@echo '    HLM_MANIFEST_|_CAT=$(HLM_MANIFEST_|_CAT)'
	@echo

_hlm_view_framework_targets ::
	@echo 'HeLM::Manifest ($(_HELM_MANIFEST_MK_VERSION)) targets:'
	@echo '    _hlm_build_manifest          - Build a releaase-manifest' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_hlm_build_manifest:
	@$(INFO) '$(HLM_UI_LABEL)Building manifest based on chart "$(HLM_MANIFEST_CHART_NAME)" ...'; $(NORMAL)
	$(HELM) template $(strip $(__HLM_EXECUTE) $(__HLM_NAME__MANIFEST) $(__HLM_NAMESPACE__MANIFEST) $(__HLM_SET__MANIFEST) $(__HLM_VALUES__MANIFEST) $(__HLM_VALUES_SET__MANIFEST) $(HLM_MANIFEST_CHARTSOURCE_DIRPATH) ) $(HLM_MANIFEST_BUILD_|CAT)

_hlm_show_manifest:
	@# See kubectl_manifest !
