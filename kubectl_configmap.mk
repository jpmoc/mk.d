_KUBECTL_CONFIGMAP_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_CONFIGMAP_DIR_DIRNAME?= my-configmap-files
# KCL_CONFIGMAP_DIR_DIRPATH?= ./in/my-configmap-files
# KCL_CONFIGMAP_DIRS_DIRPATHS?= ./in/ ...
# KCL_CONFIGMAP_ENVFILE_DIRPATH?= ./in/
# KCL_CONFIGMAP_ENVFILE_FILENAME?= configmap.kv
# KCL_CONFIGMAP_ENVFILE_FILEPATH?= ./in/configmpa.kv
# KCL_CONFIGMAP_ENVFILES_FILEPATHS?= ./in/configmpa.kv ...
# KCL_CONFIGMAP_FILE_DIRPATH?= ./in/
# KCL_CONFIGMAP_FILE_FILENAME?= file.json
# KCL_CONFIGMAP_FILE_FILEPATH?= ./in/file.json
# KCL_CONFIGMAP_FILES_FILEPATHS?= ./in/file.json ...
# KCL_CONFIGMAP_KUSTOMIZATION_DIRPATH?= ./
# KCL_CONFIGMAP_LITERALS_KEYVALUES?= address=$VAULT_ADDR ...
# KCL_CONFIGMAP_NAME?= my-name
# KCL_CONFIGMAP_NAMESPACE_NAME?= default
# KCL_CONFIGMAP_PATCH_CONTENT?= ''
# KCL_CONFIGMAP_PATCH_TYPE?= merge
# KCL_CONFIGMAPS_FIELDSELECTOR?= metadata.name=my-name
# KCL_CONFIGMAPS_MANIFEST_DIRPATH?= ./in/
# KCL_CONFIGMAPS_MANIFEST_FILENAME?= manifest.yaml
# KCL_CONFIGMAPS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_CONFIGMAPS_MANIFEST_STDINFLAG?= false
# KCL_CONFIGMAPS_MANIFEST_URL?= http://...
# KCL_CONFIGMAPS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_CONFIGMAPS_NAMESPACE_NAME?= default
# KCL_CONFIGMAPS_SELECTOR?= label=value
# KCL_CONFIGMAPS_SET_NAME?= my-set

# Derived parameters
KCL_CONFIGMAP_DIR_DIRPATH?= $(if $(KCL_CONFIGMAP_DIR_DIRNAME),$(KCL_INPUTS_DIRPATH)$(KCL_CONFIGMAP_DIR_DIRNAME)/)
KCL_CONFIGMAP_DIRS_DIRPATHS?= $(KCL_CONFIGMAP_DIR_DIRPATH)
KCL_CONFIGMAP_FILE_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CONFIGMAP_FILE_FILEPATH?= $(if $(KCL_CONFIGMAP_FILE_FILENAME),$(KCL_CONFIGMAP_FILE_DIRPATH)$(KCL_CONFIGMAP_FILE_FILENAME))
KCL_CONFIGMAP_FILES_FILEPATHS?= $(KCL_CONFIGMAP_FILE_FILEPATH)
KCL_CONFIGMAP_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CONFIGMAP_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_CONFIGMAPS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CONFIGMAPS_MANIFEST_FILEPATH?= $(KCL_CONFIGMAPS_MANIFEST_DIRPATH)$(KCL_CONFIGMAPS_MANIFEST_FILENAME)
KCL_CONFIGMAPS_NAMESPACE_NAME?= $(KCL_CONFIGMAP_NAMESPACE_NAME)
KCL_CONFIGMAPS_SET_NAME?= config-maps@$(KCL_CONFIGMAPS_FIELDSELECTOR)@$(KCL_CONFIGMAPS_SELECTOR)@$(KCL_CONFIGMAPS_NAMESPACE_NAME)

# Options
__KCL_FILENAME__CONFIGMAPS+= $(if $(KCL_CONFIGMAPS_MANIFEST_FILEPATH),--filename $(KCL_CONFIGMAPS_MANIFEST_FILEPATH))
__KCL_FILENAME__CONFIGMAPS+= $(if $(filter true,$(KCL_CONFIGMAPS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__CONFIGMAPS+= $(if $(KCL_CONFIGMAPS_MANIFEST_URL),--filename $(KCL_CONFIGMAPS_MANIFEST_URL))
__KCL_FILENAME__CONFIGMAPS+= $(if $(KCL_CONFIGMAPS_MANIFESTS_DIRPATH),--filename $(KCL_CONFIGMAPS_MANIFESTS_DIRPATH))
__KCL_FROM_DIR= $(foreach D, $(KCL_CONFIGMAP_DIRS_DIRPATHS),--from-file $(D))
__KCL_FROM_ENV_FILE= $(foreach E, $(KCL_CONFIGMAP_ENVFILES_FILEPATHS),--from-env-file $(E))
__KCL_FROM_FILE__CONFIGMAP= $(foreach F, $(KCL_CONFIGMAP_FILES_FILEPATHS),--from-file $(F))
__KCL_FROM_LITERAL__CONFIGMAP= $(foreach KV, $(KCL_CONFIGMAP_LITERALS_KEYVALUES),--from-literal $(KV))
# __KCL_KUSTOMIZE__CONFIGMAP= $(if $(KCL_CONFIGMAP_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_CONFIGMAP_KUSTOMIZATION_DIRPATH))
__KCL_NAMESPACE__CONFIGMAP= $(if $(KCL_CONFIGMAP_NAMESPACE_NAME),--namespace $(KCL_CONFIGMAP_NAMESPACE_NAME))
__KCL_NAMESPACE__CONFIGMAPS= $(if $(KCL_CONFIGMAPS_NAMESPACE_NAME),--namespace $(KCL_CONFIGMAPS_NAMESPACE_NAME))
__KCL_PATCH__CONFIGMAP= $(if $(KCL_CONFIGMAP_PATCH_CONTENT),--patch $(KCL_CONFIGMAP_PATCH_CONTENT))
__KCL_TYPE__CONFIGMAP= $(if $(KCL_CONFIGMAP_PATCH_TYPE),--type $(KCL_CONFIGMAP_PATCH_TYPE))

# Customizations
_KCL_APPLY_CONFIGMAPS_|?= #
_KCL_DIFF_CONFIGMAPS_|?= $(_KCL_APPLY_CONFIGMAPS_|)
_KCL_PATCH_CONFIGMAP_|?=
_KCL_UNAPPLY_CONFIGMAPS_|?= $(_KCL_APPLY_CONFIGMAPS_|)
|_KCL_KUSTOMIZE_CONFIGMAP?=
|_KCL_PATCH_CONFIGMAP?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::ConfigMap ($(_KUBECTL_CONFIGMAP_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::ConfigMap ($(_KUBECTL_CONFIGMAP_MK_VERSION)) parameters:'
	@echo '    KCL_CONFIGMAP_DIR_DIRNAME=$(KCL_CONFIGMAP_DIR_DIRNAME)'
	@echo '    KCL_CONFIGMAP_DIR_DIRPATH=$(KCL_CONFIGMAP_DIR_DIRPATH)'
	@echo '    KCL_CONFIGMAP_DIRS_DIRPATHS=$(KCL_CONFIGMAP_DIRS_DIRPATHS)'
	@echo '    KCL_CONFIGMAP_ENVFILE_DIRPATH=$(KCL_CONFIGMAP_ENVFILE_DIRPATH)'
	@echo '    KCL_CONFIGMAP_ENVFILE_FILENAME=$(KCL_CONFIGMAP_ENVFILE_FILENAME)'
	@echo '    KCL_CONFIGMAP_ENVFILE_FILEPATH=$(KCL_CONFIGMAP_ENVFILE_FILEPATH)'
	@echo '    KCL_CONFIGMAP_ENVFILES_FILEPATHS=$(KCL_CONFIGMAP_ENVFILES_FILEPATHS)'
	@echo '    KCL_CONFIGMAP_FILE_DIRPATH=$(KCL_CONFIGMAP_FILE_DIRPATH)'
	@echo '    KCL_CONFIGMAP_FILE_FILENAME=$(KCL_CONFIGMAP_FILE_FILENAME)'
	@echo '    KCL_CONFIGMAP_FILE_FILEPATH=$(KCL_CONFIGMAP_FILE_FILEPATH)'
	@echo '    KCL_CONFIGMAP_FILES_FILEPATHS=$(KCL_CONFIGMAP_FILES_FILEPATHS)'
	@echo '    KCL_CONFIGMAP_KUSTOMIZATION_DIRPATH=$(KCL_CONFIGMAP_KUSTOMIZATION_DIRPATH)'
	@echo '    KCL_CONFIGMAP_LITERALS_KEYVALUES=$(KCL_CONFIGMAP_LITERALS_KEYVALUES)'
	@echo '    KCL_CONFIGMAP_NAME=$(KCL_CONFIGMAP_NAME)'
	@echo '    KCL_CONFIGMAP_NAMESPACE_NAME=$(KCL_CONFIGMAP_NAMESPACE_NAME)'
	@echo '    KCL_CONFIGMAP_PATCH_CONTENT=$(KCL_CONFIGMAP_PATCH_CONTENT)'
	@echo '    KCL_CONFIGMAP_PATCH_TYPE=$(KCL_CONFIGMAP_PATCH_TYPE)'
	@echo '    KCL_CONFIGMAPS_FIELDSELECTOR=$(KCL_CONFIGMAPS_FIELDSELECTOR)'
	@echo '    KCL_CONFIGMAPS_MANIFEST_DIRPATH=$(KCL_CONFIGMAPS_MANIFEST_DIRPATH)'
	@echo '    KCL_CONFIGMAPS_MANIFEST_FILENAME=$(KCL_CONFIGMAPS_MANIFEST_FILENAME)'
	@echo '    KCL_CONFIGMAPS_MANIFEST_FILEPATH=$(KCL_CONFIGMAPS_MANIFEST_FILEPATH)'
	@echo '    KCL_CONFIGMAPS_MANIFEST_STDINFLAG=$(KCL_CONFIGMAPS_MANIFEST_STDINFLAG)'
	@echo '    KCL_CONFIGMAPS_MANIFEST_URL=$(KCL_CONFIGMAPS_MANIFEST_URL)'
	@echo '    KCL_CONFIGMAPS_MANIFESTS_DIRPATH=$(KCL_CONFIGMAPS_MANIFESTS_DIRPATH)'
	@echo '    KCL_CONFIGMAPS_NAMESPACE_NAME=$(KCL_CONFIGMAPS_NAMESPACE_NAME)'
	@echo '    KCL_CONFIGMAPS_SELECTOR=$(KCL_CONFIGMAPS_SELECTOR)'
	@echo '    KCL_CONFIGMAPS_SET_NAME=$(KCL_CONFIGMAPS_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::ConfigMap ($(_KUBECTL_CONFIGMAP_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_configmap                - Annotate a config-map'
	@echo '    _kcl_apply_configmaps                  - Apply a manifest for one-or-more config-maps'
	@echo '    _kcl_create_configmap                  - Create a new config-map'
	@echo '    _kcl_delete_configmap                  - Delete an existing config-map'
	@echo '    _kcl_dff_configmaps                    - Diff manifest for one-or-more config-maps'
	@echo '    _kcl_edit_configmap                    - Edit a config-map'
	@echo '    _kcl_explain_configmap                 - Explain the config-map object'
	@echo '    _kcl_kustomize_configmap               - Kustomize one-or-more config-map'
	@echo '    _kcl_label_configmap                   - Label a config-map'
	@echo '    _kcl_list_configmaps                   - List all config-maps'
	@echo '    _kcl_list_configmaps_set               - List a set of config-maps'
	@echo '    _kcl_patch_configmap                   - Patch a config-map'
	@echo '    _kcl_show_configmap                    - Show everything related to a config-map'
	@echo '    _kcl_show_configmap_description        - Show the description of a config-map'
	@echo '    _kcl_show_configmap_object             - Show the object of a config-map'
	@echo '    _kcl_unapply_configmaps                - Un-apply a manifest for one-or-more config-maps'
	@echo '    _kcl_unlabel_configmap                 - Un-label a config-map'
	@echo '    _kcl_watch_configmaps                  - Watch all config-maps'
	@echo '    _kcl_watch_configmaps_set              - Watch a set of config-maps'
	@echo '    _kcl_write_configmaps                  - Write manifest for one-or-more config-maps'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_configmap:
	@$(INFO) '$(KCL_UI_LABEL)Annotating config-map "$(KCL_CONFIGMAP_NAME)" ...'; $(NORMAL)

_kcl_apply_configmap: _kcl_apply_configmaps
_kcl_apply_configmaps:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more config-maps ...'; $(NORMAL)
	$(if $(KCL_CONFIGMAPS_MANIFEST_FILEPATH),cat $(KCL_CONFIGMAPS_MANIFEST_FILEPATH); echo)
	$(if $(filter true,$(KCL_CONFIGMAPS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_CONFIGMAPS_|)cat)
	$(if $(KCL_CONFIGMAPS_MANIFEST_URL),curl -L $(KCL_CONFIGMAPS_MANIFEST_URL); echo)
	$(if $(KCL_CONFIGMAPS_MANIFESTS_DIRPATH),ls -al $(KCL_CONFIGMAPS_MANIFESTS_DIRPATH); echo)
	$(_KCL_APPLY_CONFIGMAPS_|)$(KUBECTL) apply $(__KCL_FILENAME__CONFIGMAPS) $(__KCL_NAMESPACE__CONFIGMAPS)

_kcl_create_configmap:
	@$(INFO) '$(KCL_UI_LABEL)Creating config-map "$(KCL_CONFIGMAP_NAME)" ...'; $(NORMAL)
	$(foreach D, $(KCL_CONFIGMAP_DIRS_DIRPATHS), echo $(D); cat $(D)* ;)
	$(foreach E, $(KCL_CONFIGMAP_ENVFILES_FILEPATHS), echo $(E); cat $(E) ;)
	$(foreach F, $(KCL_CONFIGMAP_FILES_FILEPATHS), echo $(F); cat $(F) ;)
	$(if $(KCL_CONFIGMAP_LITERALS_KEYVALUES), @echo "KCL_CONFIGMAP_LITERALS_KEYVALUES=$(KCL_CONFIGMAP_LITERALS_KEYVALUES)")
	$(KUBECTL) create configmap $(__KCL_FROM_DIR) $(__KCL_FROM_ENV_FILE) $(__KCL_FROM_FILE__CONFIGMAP) $(__KCL_FROM_LITERAL__CONFIGMAP) $(__KCL_NAMESPACE__CONFIGMAP) $(KCL_CONFIGMAP_NAME)

_kcl_delete_configmap:
	@$(INFO) '$(KCL_UI_LABEL)Deleting config-map "$(KCL_CONFIGMAP_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete configmap $(__KCL_NAMESPACE__CONFIGMAP) $(KCL_CONFIGMAP_NAME)

_kcl_diff_configmap: _kcl_diff_configmaps
_kcl_diff_configmaps:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more config-maps ...'; $(NORMAL)
	@$(WARN) 'THis operation submits the manifest to the cluster to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_CONFIGMAPS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_CONFIGMAPS_|)cat
	# curl -L $(KCL_CONFIGMAPS_MANIFEST_URL)
	# ls -al $(KCL_CONFIGMAPS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_CONFIGMAPS_|)$(KUBECTL) diff $(__KCL_FILENAME__CONFIGMAPS) $(__KCL_NAMESPACE__CONFIGMAPS)

_kcl_edit_configmap:
	@$(INFO) '$(KCL_UI_LABEL)Editing config-map "$(KCL_CONFIGMAP_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit configmap $(__KCL_NAMESPACE__CONFIGMAP) $(KCL_CONFIGMAP_NAME)

_kcl_explain_configmap:
	@$(INFO) '$(KCL_UI_LABEL)Explaining config-map object ...'; $(NORMAL)
	$(KUBECTL) explain configmap

_kcl_kustomize_configmap: _kcl_kustomize_configmaps
_kcl_kustomize_configmaps:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more config-map ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_CONFIGMAP_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_CONFIGMAP)

_kcl_label_configmap:
	@$(INFO) '$(KCL_UI_LABEL)Labeling config-map "$(KCL_CONFIGMAP_NAME)" ...'; $(NORMAL)

_kcl_list_configmaps:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL config-maps ...'; $(NORMAL)
	$(KUBECTL) get configmap --all-namespaces=true $(_X__KCL_NAMESPACE__CONFIGMAPS)

_kcl_list_configmaps_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing config-maps-set "$(KCL_CONFIGMAPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Config-maps are grouped based on the provided namespace, ...'; $(NORMAL)
	$(KUBECTL) get configmaps --all-namespaces=false $(__KCL_NAMESPACE__CONFIGMAPS)

_kcl_patch_configmap:
	@$(INFO) '$(KCL_UI_LABEL)Patching config-map "$(KCL_CONFIGMAP_NAME)" ...'; $(NORMAL)
	$(_KCL_PATCH_CONFIGMAP_|) $(KUBECTL) patch configmap $(__KCL_NAMESPACE__CONFIGMAP) $(__KCL_PATCH__CONFIGMAP) $(__KCL_TYPE__CONFIGMAP) $(KCL_CONFIGMAP_NAME) $(|_KCL_PATCH_CONFIGMAP)

_KCL_SHOW_CONFIGMAP_TARGETS?= _kcl_show_configmap_object _kcl_show_configmap_description
_kcl_show_configmap: $(_KCL_SHOW_CONFIGMAP_TARGETS)

_kcl_show_configmap_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of config-map "$(KCL_CONFIGMAP_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe configmap $(__KCL_NAMESPACE__CONFIGMAP) $(KCL_CONFIGMAP_NAME)

_kcl_show_configmap_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of config-map "$(KCL_CONFIGMAP_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get configmap $(__KCL_NAMESPACE__CONFIGMAP) $(KCL_CONFIGMAP_NAME) --output yaml

_kcl_unapply_configmap: _kcl_unapply_configmaps
_kcl_unapply_configmaps:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more config-maps ...'; $(NORMAL)
	# cat $(KCL_CONFIGMAPS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_CONFIGMAPS_|)cat
	# curl -L $(KCL_CONFIGMAPS_MANIFEST_URL)
	# ls -al $(KCL_CONFIGMAPS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_CONFIGMAPS_|)$(KUBECTL) delete $(__KCL_FILENAME__CONFIGMAPS) $(__KCL_NAMESPACE__CONFIGMAPS)

_kcl_watch_configmaps:
	@$(INFO) '$(KCL_UI_LABEL)Watching config-maps ...'; $(NORMAL)

_kcl_watch_configmaps_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching config-maps-set "$(KCL_CONFIGMAPS_SET_NAME)" ...'; $(NORMAL)

_kcl_write_configmaps:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-o-rmore config-maps ...'; $(NORMAL)
	$(WRITER) $(KCL_CONFIGMAPS_MANIFEST_FILEPATH)

