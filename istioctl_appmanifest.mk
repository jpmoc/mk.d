_ISTIOCTL_APPMANIFEST_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

# ICL_APPMANIFEST_DIRPATH?= ./out/
# ICL_APPMANIFEST_FILENAME?= app.yaml
# ICL_APPMANIFEST_FILEPATH?= ./out/app.yaml
# ICL_APPMANIFEST_INFILE_DIRPATH?= ./in/
# ICL_APPMANIFEST_INFILE_FILENAME?= app.yaml
# ICL_APPMANIFEST_INFILE_FILEPATH?= ./in/app.yaml
# ICL_APPMANIFEST_NAME?=
# ICL_APPMANIFEST_NAMESPACE_NAME?=
# ICL_APPMANIFESTS_REGEX?= *
# ICL_APPMANIFESTS_SET_NAME?= my-manifests-set

# Derived parameters
ICL_APPMANIFEST_DIRPATH?= $(ICL_OUTPUTS_DIRPATH)
ICL_APPMANIFEST_FILENAME?= $(ICL_APPMANIFEST_INFILE_FILENAME)
ICL_APPMANIFEST_FILEPATH?= $(ICL_APPMANIFEST_DIRPATH)$(ICL_APPMANIFEST_FILENAME)
ICL_APPMANIFEST_INFILE_DIRPATH?= $(ICL_INPUTS_DIRPATH)
ICL_APPMANIFEST_INFILE_FILEPATH?= $(ICL_APPMANIFEST_INFILE_DIRPATH)$(ICL_APPMANIFEST_INFILE_FILENAME)
ICL_APPMANIFEST_NAME?= $(basename $(ICL_APPMANIFEST_FILENAME))
# ICL_APPMANIFEST_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
ICL_APPMANIFESTS_DIRPATH?= $(ICL_APPMANIFEST_DIRPATH)
ICL_APPMANIFESTS_SET_NAME?= $(ICL_APPMANIFESTS_REGEX)

# Option parameters
__ICL_FILENAME__APPMANIFEST?= $(if $(ICL_APPMANIFEST_INFILE_FILEPATH),--filename $(ICL_APPMANIFEST_INFILE_FILEPATH))
__ICL_NAMESPACE__APPMANIFEST?= $(if $(ICL_APPMANIFEST_NAMESPACE_NAME),--namespace $(ICL_APPMANIFEST_NAMESPACE_NAME))

# UI parameters

#--- Utilities


#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_icl_view_framework_macros ::
	@echo 'IstioCtL::AppManifest ($(_ISTIOCTL_APPMANIFEST_MK_VERSION)) macros:'
	@echo

_icl_view_framework_parameters ::
	@echo 'IstioCtl::AppManifest ($(_ISTIOCTL_APPMANIFEST_MK_VERSION)) variables:'
	@echo '    ICL_APPMANIFEST_DIRPATH=$(ICL_APPMANIFEST_DIRPATH)'
	@echo '    ICL_APPMANIFEST_FILENAME=$(ICL_APPMANIFEST_FILENAME)'
	@echo '    ICL_APPMANIFEST_FILEPATH=$(ICL_APPMANIFEST_FILEPATH)'
	@echo '    ICL_APPMANIFEST_INFILE_DIRPATH=$(ICL_APPMANIFEST_INFILE_DIRPATH)'
	@echo '    ICL_APPMANIFEST_INFILE_FILENAME=$(ICL_APPMANIFEST_INFILE_FILENAME)'
	@echo '    ICL_APPMANIFEST_INFILE_FILEPATH=$(ICL_APPMANIFEST_INFILE_FILEPATH)'
	@echo '    ICL_APPMANIFEST_NAME=$(ICL_APPMANIFEST_NAME)'
	@echo '    ICL_APPMANIFEST_NAMESPACE_NAME=$(ICL_APPMANIFEST_NAMESPACE_NAME)'
	@echo '    ICL_APPMANIFESTS_DIRPATH=$(ICL_APPMANIFESTS_DIRPATH)'
	@echo '    ICL_APPMANIFESTS_REGEX=$(ICL_APPMANIFESTS_REGEX)'
	@echo '    ICL_APPMANIFESTS_SET_NAME=$(ICL_APPMANIFESTS_SET_NAME)'
	@echo

_icl_view_framework_targets ::
	@echo 'IstioCtl::AppManifest ($(_ISTIOCTL_APPMANIFEST_MK_VERSION)) targets:'
	@echo '    _icl_apply_appmanifest          - Apply an app-manifest'
	@echo '    _icl_create_appmanifest         - Create app-manifest'
	@echo '    _icl_delete_appmanifest         - Delete app-manifest'
	@echo '    _icl_show_appmanifest           - Show app-manifest'
	@echo '    _icl_unapply_appmanifest        - Unapply an app-manifest'
	@echo '    _icl_view_appmanifests          - View app-manifests'
	@echo '    _icl_view_appmanifests_set      - View set of app-manifests'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_apply_appmanifest:
	@$(INFO) '$(ICL_UI_LABEL)Applying app-manifest "$(ICL_APPMANIFEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) apply $(__ICL_FILENAME__APPMANIFEST) $(__ICL_NAMESPACE__APPMANIFEST)

_icl_create_appmanifest:
	@$(INFO) '$(ICL_UI_LABEL)Creating app-manifest "$(ICL_APPMANIFEST_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation modifies an input manifest by injecting envoy proxies in pod definitions'; $(NORMAL)
	$(ISTIOCTL) kube-inject $(__ICL_FILENAME__APPMANIFEST) | tee $(ICL_APPMANIFEST_FILEPATH)

_icl_delete_appmanifest:
	@$(INFO) '$(ICL_UI_LABEL)Deleting app-manifest "$(ICL_APPMANIFEST_NAME)" ...'; $(NORMAL)
	rm -rf $(ICL_APPMANIFEST_FILEPATH)

_icl_show_appmanifest: _icl_show_appmanifest_content _icl_show_appmanifest_description

_icl_show_appmanifest_content:
	@$(INFO) '$(ICL_UI_LABEL)Showing content of app-manifest "$(ICL_APPMANIFEST_NAME)" ...'; $(NORMAL)
	[ ! -f $(ICL_APPMANIFEST_FILEPATH) ] || cat $(ICL_APPMANIFEST_FILEPATH)

_icl_show_appmanifest_description:
	@$(INFO) '$(ICL_UI_LABEL)Show description of app-manifest "$(ICL_APPMANIFEST_NAME)" ...'; $(NORMAL)
	[ ! -f $(ICL_APPMANIFEST_FILEPATH) ] || ls -la $(ICL_APPMANIFEST_FILEPATH)

_icl_unapply_appmanifest:
	@$(INFO) '$(ICL_UI_LABEL)Unapplying app-manifest "$(ICL_APPMANIFEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) apply $(__ICL_FILENAME__APPMANIFEST) $(__ICL_NAMESPACE__APPMANIFEST)

_icl_view_appmanifests:
	@$(INFO) '$(ICL_UI_LABEL)Viewing app-manifests ...'; $(NORMAL)
	ls -ls $(ICL_APPMANIFESTS_DIRPATH)

_icl_view_appmanifests_set:
	@$(INFO) '$(ICL_UI_LABEL)Viewing app-manifests-set "$(ICL_APPMANIFESTS_SET_NAME)" ...'; $(NORMAL)
	ls -ls $(ICL_APPMANIFESTS_DIRPATH)$(ICL_APPMANIFESTS_REGEX)
