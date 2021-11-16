_HELM_CHARTPACKAGE_MK_VERSION= $(_HELM_MK_VERSION)

# HLM_CHARTPACKAGE_CHART_NAME?= redis
# HLM_CHARTPACKAGE_CHART_VERSION?= 0.1.0
# HLM_CHARTPACKAGE_CHARTSOURCE_DIRPATH?= ./my-chart/
# HLM_CHARTPACKAGE_DIRPATH?= ./
# HLM_CHARTPACKAGE_FILENAME?= mychart-0.1.0.tgz
# HLM_CHARTPACKAGE_FILEPATH?= ./mychart-0.1.0.tgz
# HLM_CHARTPACKAGE_NAME?= redis
# HLM_CHARTPACKAGE_PROVENANCE_FILENAME?= mychart-0.1.0.tgz.prov
# HLM_CHARTPACKAGES_RELEASE_NAME?= my-release
# HLM_CHARTPACKAGES_REPOSITORY_NAME?= stable
HLM_CHARTPACKAGES_DIRPATH?= ./
HLM_CHARTPACKAGES_REGEX?= 'tgz$$'
# HLM_CHARTPACKAGES_SET_NAME?= chart-packages@./packages

# Derived parameters
HLM_CHARTPACKAGE_CHART_NAME?= $(HLM_CHART_NAME)
HLM_CHARTPACKAGE_CHART_VERSION?= $(HLM_CHART_VERSION)
HLM_CHARTPACKAGE_CHARTSOURCE_DIRPATH?= $(HLM_CHARTSOURCE_DIRPATH)
HLM_CHARTPACKAGE_DIRPATH?= $(HLM_CHARTPACKAGES_DIRPATH)
HLM_CHARTPACKAGE_RELEASE_NAME?= $(HLM_RELEASE_NAME)
HLM_CHARTPACKAGE_REPOSITORY_NAME?= $(HLM_REPOSITORY_NAME)
HLM_CHARTPACKAGE_FILENAME?= $(HLM_CHARTPACKAGE_CHART_NAME)-$(HLM_CHARTPACKAGE_CHART_VERSION).tgz
HLM_CHARTPACKAGE_FILEPATH?= $(HLM_CHARTPACKAGE_DIRPATH)$(HLM_CHARTPACKAGE_FILENAME)
HLM_CHARTPACKAGE_NAME?= $(HLM_CHARTPACKAGE_CHART_NAME)
HLM_CHARTPACKAGES_REPOSITORY_NAME?= $(HLM_CHARTPACKAGE_REPOSITORY_NAME)
HLM_CHARTPACKAGES_SET_NAME?= chart-packages@$(HLM_CHARTPACKAGES_DIRPATH)

# Options
__HLM_DESTINATION__CHARTPACKAGE?= --destination $(HLM_CHARTPACKAGE_DIRPATH)

# Customizations
|_HLM_LIST_CHARTPACKAGES?= | grep -E 'tgz$$'
|_HLM_LIST_CHARTPACKAGES_SET?= | grep -E $(HLM_CHARTPACKAGES_REGEX)#

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_hlm_list_macros ::
	@#echo 'HeLM::ChartPackage ($(_HELM_CHARTPACKAGE_MK_VERSION)) macros:'
	@#echo

_hlm_list_parameters ::
	@echo 'HeLM::ChartPackage ($(_HELM_CHARTPACKAGE_MK_VERSION)) parameters:'
	@echo '    HLM_CHARTPACKAGE_CHART_NAME=$(HLM_CHARTPACKAGE_CHART_NAME)'
	@echo '    HLM_CHARTPACKAGE_CHART_VERSION=$(HLM_CHARTPACKAGE_CHART_VERSION)'
	@echo '    HLM_CHARTPACKAGE_CHARTSOURCE_DIRPATH=$(HLM_CHARTPACKAGE_CHARTSORUCE_DIRPATH)'
	@echo '    HLM_CHARTPACKAGE_DIRPATH=$(HLM_CHARTPACKAGE_DIRPATH)'
	@echo '    HLM_CHARTPACKAGE_NAME=$(HLM_CHARTPACKAGE_NAME)'
	@echo '    HLM_CHARTPACKAGE_RELEASE_NAME=$(HLM_CHARTPACKAGE_RELEASE_NAME)'
	@echo '    HLM_CHARTPACKAGE_REPOSITORY_NAME=$(HLM_CHARTPACKAGE_REPOSITORY_NAME)'
	@echo '    HLM_CHARTPACKAGES_DIRPATH=$(HLM_CHARTPACKAGES_DIRPATH)'
	@echo '    HLM_CHARTPACKAGES_REGEX=$(HLM_CHARTPACKAGES_REGEX)'
	@echo

_hlm_list_targets ::
	@echo 'HeLM::ChartPackage ($(_HELM_CHARTPACKAGE_MK_VERSION)) targets:'
	@echo '    _hlm_create_chartpackage            - Create a chart-package'
	@echo '    _hlm_delete_chartpackage            - Create a chart-package'
	@echo '    _hlm_download_chartpackage          - Download a chart-package'
	@echo '    _hlm_index_chartpackages            - Index all the chart-packages'
	@echo '    _hlm_list_chartpackages             - List all chart-packages' 
	@echo '    _hlm_list_chartpackages_set         - List a set of chart-packages' 
	@echo '    _hlm_publish_chartpackage           - Publish a chart-package' 
	@echo '    _hlm_render_chartpackage            - Render a chart-package' 
	@echo '    _hlm_show_chartpackage              - Show everything related to a chart-package' 
	@echo '    _hlm_show_chartpackage_description  - Show the Charts.yaml file of a chart-package' 
	@echo '    _hlm_unpublish_chartpackage         - un-publish a chart-package' 
	@echo '    _hlm_unzip_chartpackage             - Un-zip a chart-package'
	@echo '    _hlm_verify_chartpackage            - Verify the provenance of a chart-package' 
	@echo '    _hlm_zip_chartpackage               - Zip a chart-package'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_hlm_create_chartpackage:
	@$(INFO) '$(HLM_UI_LABEL)Creating chart-package "$(HLM_CHARTPACKAGE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a tarball using Metadata from the Chart.yaml such as name and version of the chart'; $(NORMAL)
	@$(WARN) 'The resulting tarball can be published in a chart repository'; $(NORMAL)
	$(HELM) package $(__HLM_DESTINATION__CHARTPACKAGE) $(HLM_CHARTPACKAGE_CHARTSOURCE_DIRPATH)

_hlm_delete_chartpackage:
	@$(INFO) '$(HLM_UI_LABEL)Deleting chart-package "$(HLM_CHARTPACKAGE_NAME)" ...'; $(NORMAL)
	rm -rf $(HLM_CHARTPACKAGE_FILEPATH) 

_hlm_download_chartpackage:
	@$(INFO) '$(HLM_UI_LABEL)Downloading chart-package "$(HLM_CHARTPACKAGE_NAME)"...'; $(NORMAL)
	$(_HLM_DOWNLOAD_CHARTPACKAGE_|)$(HELM) pull $(__HLM_CA_FILE) $(__HLM_CERT_FILE) $(__HLM_DESTINATION) $(__DEVEL) $(__HLM_KEY_FILE) $(__HLM_KEYRING) $(__HLM_PASSWORD) $(__HLM_PROV) $(__HLM_REPO) $(__HLM_UNTAR) $(__HLM_UNTARDIR) $(__HLM_USERNAME) $(__HLM_VERIFY) $(__HLM_VERSION__CHART) $(HLM_CHARTSOURCE_CHART_CNAME)

_hlm_index_chartpackages:
	@$(INFO) '$(HLM_UI_LABEL)Indexing ALL chart-packages ...'; $(NORMAL)
	@$(WARN) 'This operation creates an index.yaml file in the provided directory'; $(NORMAL)
	@$(WARN) 'This command executes a recursive directory scan for any chart-packages'; $(NORMAL)
	@$(WARN) 'The index with its referenced chart-packages is all what is needed to be hosted on a chart-server'; $(NORMAL)
	$(HELM) repo index $(HLM_CHARTPACKAGES_DIRPATH)

_hlm_install_chartpackage:
	@$(INFO) '$(HLM_UI_LABEL)Installing chart-package "$(HLM_CHARTPACKAGE_NAME)"...'; $(NORMAL)
	# This operation creates a release
	# $(HELM) install $(HLM_CHARTPACKAGE_RELEASE_NAME) $(HLM_CHARTPACKAGE_FILEPATH)

_hlm_list_chartpackages:
	@$(INFO) '$(HLM_UI_LABEL)Listing ALL chart-packages ...'; $(NORMAL)
	ls -al $(HLM_CHARTPACKAGES_DIRPATH) $(|_HLM_LIST_CHARTPACKAGES)

_hlm_list_chartpackages_set:
	@$(INFO) '$(HLM_UI_LABEL)Listing chart-packages-set "$(HLM_CHARTSOURCES_SET_NAME)" ...'; $(NORMAL)
	ls -al $(HLM_CHARTPACKAGES_DIRPATH) $(|_HLM_LIST_CHARTPACKAGES_SET)

_hlm_publish_chartpackage:
	@$(INFO) '$(HLM_UI_LABEL)Publishing chart-package "$(HLM_CHARTPACKAGE_NAME)" ...'; $(NORMAL)
	# To implement ...

_HLM_SHOW_CHARTPACKAGE_TARGETS?= _hlm_show_chartpackage_chartsource _hlm_show_chartpackage_description
_hlm_show_chartpackage: $(_HLM_SHOW_CHARTPACKAGE_TARGETS)

_hlm_show_chartpackage_chartsource:
	@$(INFO) '$(HLM_UI_LABEL)Showing chart-source of chart-package "$(HLM_CHARTPACKAGE_NAME)" ...'; $(NORMAL)
	ls -alR $(HLM_CHARTPACKAGE_CHARTSOURCE_DIRPATH)

_hlm_show_chartpackage_description:
	@$(INFO) '$(HLM_UI_LABEL)Showing description of chart-source "$(HLM_CHARTSOURCE_NAME)" ...'; $(NORMAL)
	ls -al $(HLM_CHARTPACKAGE_FILEPATH)

_hlm_unzip_chartpackage: # _hlm_unpackage_chartsource

_hlm_verify_chartpackage:
	@$(INFO) '$(HLM_UI_LABEL)Verifying the chart-package "$(HLM_CHARTPACKAGE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation requires a tarball and a provenance file'; $(NORMAL)
	$(HELM) verify $(HLM_CHARTSOURCE_PACKAGE_FILEPATH)

_hlm_watch_chartpackages:
	@$(INFO) '$(HLM_UI_LABEL)Watching ALL chart-packages ...'; $(NORMAL)

_hlm_watch_chartpackages_set:
	@$(INFO) '$(HLM_UI_LABEL)Watching chart-packages-set "$(HLM_CHARTPACKAGES_SET_NAME)" ...'; $(NORMAL)

_hlm_zip_chartpackage:
	@$(INFO) '$(HLM_UI_LABEL)Zip-ping chart-package "$(HLM_CHARTPACKAGE_NAME)" ...'; $(NORMAL)
