_ISTIOCTL_ISTIOMANIFEST_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

# ICL_ISTIOMANIFEST_COMPONENT_NAME?= IngressGateways
# ICL_ISTIOMANIFEST_CONFIG_DIRPATH?=
# ICL_ISTIOMANIFEST_CONFIG_FILENAME?=
# ICL_ISTIOMANIFEST_CONFIG_FILEPATH?=
# ICL_ISTIOMANIFEST_CONFIG_KEYVALUES?= profile=demo values.global.controlPlaneSecurityEnabled=true values.global.mtls.enabled=true
# ICL_ISTIOMANIFEST_DIRPATH?= ./out/
# ICL_ISTIOMANIFEST_FILENAME?= manifest.yaml
# ICL_ISTIOMANIFEST_FILEPATH?= ./out/manifest.yaml
# ICL_ISTIOMANIFEST_NAME?=
# ICL_ISTIOMANIFEST_NAMESPACE_NAME?=
# ICL_ISTIOMANIFEST_REVISION?=
# ICL_ISTIOMANIFESTS_DIRPATH?= ./out/
# ICL_ISTIOMANIFESTS_REGEX?= *
# ICL_ISTIOMANIFESTS_SET_NAME?= my-manifests-set

# Derived parameters
ICL_ISTIOMANIFEST_DIRPATH?= $(ICL_OUTPUTS_DIRPATH)
ICL_ISTIOMANIFEST_FILEPATH?= $(ICL_ISTIOMANIFEST_DIRPATH)$(ICL_ISTIOMANIFEST_FILENAME)
ICL_ISTIOMANIFEST_NAME?= $(basename $(ICL_ISTIOMANIFEST_FILENAME))
ICL_ISTIOMANIFEST_CONFIG_DIRPATH?= $(ICL_INPUTS_DIRPATH)
ICL_ISTIOMANIFEST_CONFIG_FILEPATH?= $(if $(ICL_ISTIOMANIFEST_CONFIG_FILENAME),$(ICL_ISTIOMANIFEST_CONFIG_DIRPATH)$(ICL_ISTIOMANIFEST_CONFIG_FILENAME))
ICL_ISTIOMANIFEST_CONFIG_KEYVALUES?= profile=$(ICL_ISTIOPROFILE_NAME)
ICL_ISTIOMANIFESTS_DIRPATH?= $(ICL_ISTIOMANIFEST_DIRPATH)
ICL_ISTIOMANIFESTS_SET_NAME?= $(ICL_ISTIOMANIFESTS_REGEX)

# Options
__ICL_COMPONENT?= $(if $(ICL_ISTIOMANIFEST_COMPONENT_NAME),--component $(ICL_ISTIOMANIFEST_COMPONENT_NAME))
__ICL_CONFIG_FILENAME?= $(if $(ICL_ISTIOMANIFEST_CONFIG_FILEPATH),--filename $(ICL_ISTIOMANIFEST_CONFIG_FILEPATH))
__ICL_FILENAME__ISTIOMANIFEST?= $(if $(ICL_ISTIOMANIFEST_FILEPATH),--filename $(ICL_ISTIOMANIFEST_FILEPATH))
__ICL_NAMESPACE__ISTIOMANIFEST?= $(if $(ICL_ISTIOMANIFEST_NAMESPACE_NAME),--namespace $(ICL_ISTIOMANIFEST_NAMESPACE_NAME))
__ICL_REVISION?=
__ICL_SET?= $(foreach KV, $(ICL_ISTIOMANIFEST_CONFIG_KEYVALUES),--set $(KV))
# __ICL_SET?= $(if $(ICL_ISTIOMANIFEST_CONFIG_KEYVALUES),--set $(subst $(SPACE),$(COMMA),$(ICL_ISTIOMANIFEST_CONFIG_KEYVALUES)))

# Customizations
_ICL_SHOW_ISTIOMANIFEST_CONTENT_|?= [ ! -f $(ICL_ISTIOMANIFEST_FILEPATH) ] ||
_ICL_SHOW_ISTIOMANIFEST_DESCRIPTION_|?= [ ! -f $(ICL_ISTIOMANIFEST_FILEPATH) ] ||
|_ICL_DUMP_ISTIOMANIFEST?= | tee $(ICL_ISTIOMANIFEST_FILEPATH)

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_icl_list_macros ::
	@#echo 'IstioCtL::IstioManifest ($(_ISTIOCTL_ISTIOMANIFEST_MK_VERSION)) macros:'
	@#echo

_icl_list_parameters ::
	@echo 'IstioCtl::IstioManifest ($(_ISTIOCTL_ISTIOMANIFEST_MK_VERSION)) variables:'
	@echo '    ICL_ISTIOMANIFEST_COMPONENT_NAME=$(ICL_ISTIOMANIFEST_COMPONENT_NAME)'
	@echo '    ICL_ISTIOMANIFEST_CONFIG_DIRPATH=$(ICL_ISTIOMANIFEST_CONFIG_DIRPATH)'
	@echo '    ICL_ISTIOMANIFEST_CONFIG_FILENAME=$(ICL_ISTIOMANIFEST_CONFIG_FILENAME)'
	@echo '    ICL_ISTIOMANIFEST_CONFIG_FILEPATH=$(ICL_ISTIOMANIFEST_CONFIG_FILEPATH)'
	@echo '    ICL_ISTIOMANIFEST_CONFIG_KEYVALUES=$(ICL_ISTIOMANIFEST_CONFIG_KEYVALUES)'
	@echo '    ICL_ISTIOMANIFEST_DIRPATH=$(ICL_ISTIOMANIFEST_DIRPATH)'
	@echo '    ICL_ISTIOMANIFEST_FILENAME=$(ICL_ISTIOMANIFEST_FILENAME)'
	@echo '    ICL_ISTIOMANIFEST_FILEPATH=$(ICL_ISTIOMANIFEST_FILEPATH)'
	@echo '    ICL_ISTIOMANIFEST_NAME=$(ICL_ISTIOMANIFEST_NAME)'
	@echo '    ICL_ISTIOMANIFEST_NAMESPACE_NAME=$(ICL_ISTIOMANIFEST_NAMESPACE_NAME)'
	@echo '    ICL_ISTIOMANIFEST_REVISION=$(ICL_ISTIOMANIFEST_REVISION)'
	@echo '    ICL_ISTIOMANIFESTS_DIRPATH=$(ICL_ISTIOMANIFESTS_DIRPATH)'
	@echo '    ICL_ISTIOMANIFESTS_REGEX=$(ICL_ISTIOMANIFESTS_REGEX)'
	@echo '    ICL_ISTIOMANIFESTS_SET_NAME=$(ICL_ISTIOMANIFESTS_SET_NAME)'
	@echo

_icl_list_targets ::
	@echo 'IstioCtl::IstioManifest ($(_ISTIOCTL_ISTIOMANIFEST_MK_VERSION)) targets:'
	@echo '    _icl_apply_istiomanifest              - Apply an istio-manifest'
	@echo '    _icl_check_istiomanifest_install      - Check installation of istio-manifest'
	@echo '    _icl_delete_istiomanifest             - Delete istio-manifest'
	@echo '    _icl_dump_istiomanifest               - Dump istio-manifest'
	@echo '    _icl_list_istiomanifests              - List all istio-manifests'
	@echo '    _icl_list_istiomanifests_set          - List set of istio-manifests'
	@echo '    _icl_show_istiomanifest               - Show everything related to an istio-manifest'
	@echo '    _icl_show_istiomanifest_content       - Show the content of an istio-manifest'
	@echo '    _icl_show_istiomanifest_description   - Show the description of an istio-manifest'
	@echo '    _icl_unapply_istiomanifest            - Un-apply a istio-manifest'
	@echo '    _icl_watch_istiomanifests             - Watch all istio-manifests'
	@echo '    _icl_watch_istiomanifests_set         - Watch set of istio-manifests'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_apply_istiomanifest:
	@$(INFO) '$(ICL_UI_LABEL)Applying the istio-manifest "$(ICL_ISTIOMANIFEST_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) manifest generate $(__ICL_COMPONENT) $(ICL_REVISION) $(__ICL_SET) $(__ICL_CONFIG_FILENAME)
	$(ISTIOCTL) manifest apply $(__ICL_COMPONENT) $(__ICL_REVISION) $(__ICL_SET) $(__ICL_CONFIG_FILENAME)

_icl_check_istiomanifest_install:
	@$(INFO) '$(ICL_UI_LABEL)Checking installation of istio-manifest "$(ICL_ISTIOMANIFEST_NAME)" ...'; $(NORMAL)
	cat $(ICL_ISTIOMANIFEST_FILEPATH)
	$(ISTIOCTL) verify-install --filename $(ICL_ISTIOMANIFEST_FILEPATH) 

_icl_create_istiomanifest: _icl_dump_istiomanifest

_icl_delete_istiomanifest:
	@$(INFO) '$(ICL_UI_LABEL)Deleting istio-manifest "$(ICL_ISTIOMANIFEST_NAME)" ...'; $(NORMAL)
	rm -rf $(ICL_ISTIOMANIFEST_FILEPATH)

_icl_dump_istiomanifest:
	@$(INFO) '$(ICL_UI_LABEL)Dumping istio-manifest "$(ICL_ISTIOMANIFEST_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) manifest generate $(__ICL_COMPONENT) $(__ICL_REVISION) $(__ICL_SET) $(__ICL_CONFIG_FILENAME) $(|_ICL_DUMP_ISTIOMANIFEST)

_icl_show_istiomanifest: _icl_show_istiomanifest_content _icl_show_istiomanifest_description

_icl_show_istiomanifest_content:
	@$(INFO) '$(ICL_UI_LABEL)Showing content of istio-manifest "$(ICL_ISTIOMANIFEST_NAME)" ...'; $(NORMAL)
	$(_ICL_SHOW_ISTIOMANIFEST_CONTENT_|) cat $(ICL_ISTIOMANIFEST_FILEPATH)

_icl_show_istiomanifest_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing description of istio-manifest "$(ICL_ISTIOMANIFEST_NAME)" ...'; $(NORMAL)
	$(_ICL_SHOW_ISTIOMANIFEST_DESCRIPTION_|) ls -la $(ICL_ISTIOMANIFEST_FILEPATH)

_icl_unapply_istiomanifest:
	@$(INFO) '$(ICL_UI_LABEL)Un-applying the istio-manifest "$(ICL_ISTIOMANIFEST_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) manifest generate $(__ICL_COMPONENT) $(__ICL_REVISION) $(__ICL_SET) $(__ICL_CONFIG_FILENAME) | $(KUBECTL) delete -f -

_icl_list_istiomanifests:
	@$(INFO) '$(ICL_UI_LABEL)Listing ALL istio-manifests ...'; $(NORMAL)
	ls -ls $(ICL_ISTIOMANIFESTS_DIRPATH)

_icl_list_istiomanifests_set:
	@$(INFO) '$(ICL_UI_LABEL)Listing istio-manifests-set "$(ICL_ISTIOMANIFESTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Istio-manifests are group by directory and regex'; $(NORMAL)
	ls -ls $(ICL_ISTIOMANIFESTS_DIRPATH)$(ICL_ISTIOMANIFESTS_REGEX)

_icl_watch_istiomanifests:
	@$(INFO) '$(ICL_UI_LABEL)Watching ALL istio-manifests ...'; $(NORMAL)

_icl_watching_istiomanifests_set:
	@$(INFO) '$(ICL_UI_LABEL)Watching istio-manifests-set "$(ICL_ISTIOMANIFESTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Istio-manifests are group by directory and regex'; $(NORMAL)
