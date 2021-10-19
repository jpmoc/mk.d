_KUBECTL_MANIFEST_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_MANIFEST_DIRPATH?= ./in/
# KCL_MANIFEST_DOWNLOAD_DIRPATH?= ./out/
# KCL_MANIFEST_DOWNLOAD_FILENAME?= manifest.yaml
# KCL_MANIFEST_DOWNLOAD_FILEPATH?= ./out/manifest.yaml
# KCL_MANIFEST_FILENAME?= manifest.yaml
# KCL_MANIFEST_FILEPATH?= ./manifest.yaml
# KCL_MANIFEST_MD5SUM?=
# KCL_MANIFEST_NAME?= my-manifest
# KCL_MANIFEST_NAMESPACE_NAME?= default
KCL_MANIFEST_STDIN_FLAG?= false
# KCL_MANIFEST_SELECTOR?= app=nginx
# KCL_MANIFEST_URL?= https://...
KCL_MANIFEST_VALIDATE_FLAG?= true
# KCL_MANIFESTS_DIRPATH?= ./in/
# KCL_MANIFESTS_NAME?= my-manifests
# KCL_MANIFESTS_NAMESPACE_NAME?= default
KCL_MANIFESTS_REGEX?= *.yaml
# KCL_MANIFESTS_SELECTOR?= app=nginx
# KCL_MANIFESTS_SET_NAME?= my-manifests-set

# Derived parameters
KCL_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_MANIFEST_DOWNLOAD_DIRPATH?= $(KCL_OUTPUTS_DIRPATH)
KCL_MANIFEST_DOWNLOAD_FILENAME?= $(KCL_MANIFEST_FILENAME)
KCL_MANIFEST_DOWNLOAD_FILEPATH?= $(KCL_MANIFEST_DOWNLOAD_DIRPATH)$(KCL_MANIFEST_DOWNLOAD_FILENAME)
KCL_MANIFEST_FILEPATH?= $(if $(KCL_MANIFEST_FILENAME),$(KCL_MANIFEST_DIRPATH)$(KCL_MANIFEST_FILENAME))
# A manifest can deploy several microservices to different namespaces, if so set this parameter to 'blank'
KCL_MANIFEST_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_MANIFESTS_DIRPATH?= $(KCL_MANIFEST_DIRPATH)
KCL_MANIFESTS_NAMESPACE_NAME?= $(KCL_MANIFEST_NAMESPACE_NAME)
KCL_MANIFESTS_SELECTOR?= $(KCL_MANIFEST_SELECTOR)

# Option parameters
__KCL_FILENAME__MANIFEST+= $(if $(KCL_MANIFEST_FILEPATH),--filename $(KCL_MANIFEST_FILEPATH))
__KCL_FILENAME__MANIFEST+= $(if $(filter true,$(KCL_MANIFEST_STDIN_FLAG)),--filename -)
__KCL_FILENAME__MANIFEST+= $(if $(KCL_MANIFEST_URL),--filename $(KCL_MANIFEST_URL))
__KCL_FILENAME__MANIFESTS= $(if $(KCL_MANIFESTS_DIRPATH),--filename $(KCL_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__MANIFEST= $(if $(KCL_MANIFEST_NAMESPACE_NAME),--namespace $(KCL_MANIFEST_NAMESPACE_NAME))
__KCL_NAMESPACE__MANIFESTS= $(if $(KCL_MANIFESTS_NAMESPACE_NAME),--namespace $(KCL_MANIFESTS_NAMESPACE_NAME))
__KCL_OUTDIR__MANIFEST= $(if $(KCL_MANIFESTS_DIRPATH),--outdir $(KCL_MANIFESTS_DIRPATH))
__KCL_SELECTOR__MANIFEST= $(if $(KCL_MANIFEST_SELECTOR),--selector $(KCL_MANIFEST_SELECTOR))
__KCL_SELECTOR__MANIFESTS= $(if $(KCL_MANIFESTS_SELECTOR),--selector $(KCL_MANIFESTS_SELECTOR))
__KCL_VALIDATE__MANIFEST= $(if $(KCL_MANIFEST_VALIDATE_FLAG),--validate=$(KCL_MANIFEST_VALIDATE_FLAG))
__KCL_VALIDATE__MANIFESTS= $(if $(KCL_MANIFESTS_VALIDATE_FLAG),--validate=$(KCL_MANIFESTS_VALIDATE_FLAG))

# Pipes
_KCL_APPLY_MANIFEST_|?= #
_KCL_APPLY_MANIFESTS_|?= #
_KCL_DIFF_MANIFEST_|?= $(_KCL_APPLY_MANIFEST_|)
_KCL_DIFF_MANIFESTS_|?= $(_KCL_APPLY_MANIFESTS_|)
_KCL_DOWNLOAD_MANIFEST_|?= -#
_KCL_EXPLODE_MANIFEST_|?= -#
_KCL_UNAPPLY_MANIFEST_|?= $(_KCL_APPLY_MANIFEST_|)
_KCL_UNAPPLY_MANIFESTS_|?= $(_KCL_UNAPPLY_MANIFESTS_|)
|_KCL_DOWNLOAD_MANIFEST?= | tee $(KCL_MANIFEST_DOWNLOAD_FILEPATH)
|_KCL_VIEW_MANIFESTS_SET?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Manifest ($(_KUBECTL_MANIFEST_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Manifest ($(_KUBECTL_MANIFEST_MK_VERSION)) parameters:'
	@echo '    KCL_MANIFEST_DIRPATH=$(KCL_MANIFEST_DIRPATH)'
	@echo '    KCL_MANIFEST_DOWNLOAD_DIRPATH=$(KCL_MANIFEST_DOWNLOAD_DIRPATH)'
	@echo '    KCL_MANIFEST_DOWNLOAD_FILENAME=$(KCL_MANIFEST_DOWNLOAD_FILENAME)'
	@echo '    KCL_MANIFEST_DOWNLOAD_FILEPATH=$(KCL_MANIFEST_DOWNLOAD_FILEPATH)'
	@echo '    KCL_MANIFEST_FILENAME=$(KCL_MANIFEST_FILENAME)'
	@echo '    KCL_MANIFEST_FILEPATH=$(KCL_MANIFEST_FILEPATH)'
	@echo '    KCL_MANIFEST_MD5SUM=$(KCL_MANIFEST_MD5SUM)'
	@echo '    KCL_MANIFEST_NAME=$(KCL_MANIFEST_NAME)'
	@echo '    KCL_MANIFEST_NAMESPACE_NAME=$(KCL_MANIFEST_NAMESPACE_NAME)'
	@echo '    KCL_MANIFEST_SELECTOR=$(KCL_MANIFEST_SELECTOR)'
	@echo '    KCL_MANIFEST_STDIN_FLAG=$(KCL_MANIFEST_STDIN_FLAG)'
	@echo '    KCL_MANIFEST_VALIDATE_FLAG=$(KCL_MANIFEST_VALIDATE_FLAG)'
	@echo '    KCL_MANIFEST_URL=$(KCL_MANIFEST_URL)'
	@echo '    KCL_MANIFESTS_DIRPATH=$(KCL_MANIFESTS_DIRPATH)'
	@echo '    KCL_MANIFESTS_NAME=$(KCL_MANIFESTS_NAME)'
	@echo '    KCL_MANIFESTS_REGEX=$(KCL_MANIFESTS_REGEX)'
	@echo '    KCL_MANIFESTS_SELECTOR=$(KCL_MANIFESTS_SELECTOR)'
	@echo '    KCL_MANIFESTS_SET_NAME=$(KCL_MANIFESTS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Manifest ($(_KUBECTL_MANIFEST_MK_VERSION)) targets:'
	@echo '    _kcl_apply_manifest                   - Apply a manifest'
	@echo '    _kcl_apply_manifests                  - Apply one-or-more manifests'
	@echo '    _kcl_create_manifest                  - Create resources in a manifest'
	@echo '    _kcl_delete_manifest                  - Delete resources in a manifest'
	@echo '    _kcl_diff_manifest                    - Diff current state with manifest'
	@echo '    _kcl_diff_manifests                   - Diff current state with one-or-more manifests'
	@echo '    _kcl_download_manifest                - Download a manifest'
	@echo '    _kcl_edit_manifest                    - Edit a manifest'
	@echo '    _kcl_explode_manifest                 - Explode a mutli-document manifest into many single-document ones'
	@echo '    _kcl_show_manifest                    - Show everything related to a manifest'
	@echo '    _kcl_show_manifest_content            - Show everything related to a manifest'
	@echo '    _kcl_show_manifest_description        - Show description of a manifest'
	@echo '    _kcl_show_manifest_md5sum             - Show md5sum of a manifest'
	@echo '    _kcl_unapply_manifest                 - Unapply manifest'
	@echo '    _kcl_unapply_manifests                - Unapply one-or-more manifests'
	@echo '    _kcl_view_manifests                   - View manifests'
	@echo '    _kcl_view_manifests_set               - View set of manifests'
	@echo '    _kcl_watch_manifests                  - Watch manifests'
	@echo '    _kcl_watch_manifests_set              - Watch a set of manifests'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_apply_manifest:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest "$(KCL_MANIFEST_NAME)" ...'; $(NORMAL)
	$(if $(KCL_MANIFEST_FILEPATH),cat $(KCL_MANIFEST_FILEPATH);echo)
	$(if $(filter true,$(KCL_MANIFEST_STDIN_FLAG)),$(_KCL_APPLY_MANIFEST_|)cat)
	$(if $(KCL_MANIFEST_URL),curl -L $(KCL_MANIFEST_URL);echo)
	$(_KCL_APPLY_MANIFEST_|)$(KUBECTL) apply $(__KCL_FILENAME__MANIFEST) $(__KCL_NAMESPACE__MANIFEST) $(__KCL_SELECTOR__MANIFEST) $(__KCL_VALIDATE__MANIFEST)

_kcl_apply_manifests:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifests "$(KCL_MANIFESTS_NAME)" ...'; $(NORMAL)
	$(if $(KCL_MANIFESTS_DIRPATH), ls -al $(KCL_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_MANIFESTS_|)$(KUBECTL) apply $(__KCL_FILENAME__MANIFESTS) $(__KCL_NAMESPACE__MANIFESTS) $(__KCL_SELECTOR__MANIFESTS) $(__KCL_VALIDATE__MANIFESTS)

_kcl_create_manifest:
	@$(INFO) '$(KCL_UI_LABEL)Creating resources declared in manifest "$(KCL_MANIFEST_NAME)" ...'; $(NORMAL)
	$(if $(KCL_MANIFEST_FILEPATH), cat $(KCL_MANIFEST_FILEPATH))
	$(if $(KCL_MANIFEST_URL), curl -L $(KCL_MANIFEST_URL))
	$(KUBECTL) create $(__KCL_FILENAME__MANIFEST) $(__KCL_NAMESPACE__MANIFEST) $(__KCL_SELECTOR__MANIFEST)

_kcl_delete_manifest: _kcl_unapply_manifest
_kcl_delete_manifests: _kcl_unapply_manifests

_kcl_diff_manifest:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing current state with manifest "$(KCL_MANIFEST_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation submits the manifest to the cluster to take the webhooks into consideration'; $(NORMAL)
	# cat $(KCL_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_MANIFEST_|)cat
	# curl -L $(KCL_MANIFEST_URL)
	$(_KCL_DIFF_MANIFEST_|)$(KUBECTL) diff $(__KCL_FILENAME__MANIFEST) $(__KCL_NAMESPACE__MANIFEST) $(__KCL_SELECTOR__MANIFEST)

_kcl_diff_manifests:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing current state with one-or-more manifests ...'; $(NORMAL)
	# $(_KCL_DIFF_MANIFESTS_|)cat
	# ls -al $(KCL_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_MANIFESTS_|)$(KUBECTL) diff $(__KCL_FILENAME__MANIFESTS) $(__KCL_NAMESPACE__MANIFESTS) $(__KCL_SELECTOR__MANIFESTS)

_kcl_download_manifest:
	@$(INFO) '$(KCL_UI_LABEL)Downloading manifest "$(KCL_MANIFEST_NAME)" ...'; $(NORMAL)
	$(_KCL_DOWNLOAD_MANIFEST_|)wget -O - $(KCL_MANIFEST_URL) $(|_KCL_DOWNLOAD_MANIFEST)

_kcl_edit_manifest:
	@$(INFO) '$(KCL_UI_LABEL)Editing manifest "$(KCL_MANIFEST_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(KCL_MANIFEST_FILEPATH)

_kcl_explode_manifest:
	@$(INFO) '$(KCL_UI_LABEL)Exploding manifest "$(KCL_MANIFEST_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation breaks a multi-document manifest into many single-document ones'; $(NORMAL)
	$(_KCL_EXPLODE_MANIFEST_|)k8split $(__KCL_OUTDIR__MANIFEST) $(KCL_MANIFEST_FILEPATH)

_kcl_show_manifest: _kcl_show_manifest_content _kcl_show_manifest_md5sum _kcl_show_manifest_description

_kcl_show_manifest_content:
	@$(INFO) '$(KCL_UI_LABEL)Showing content of manifest "$(KCL_MANIFEST_NAME)" ...'; $(NORMAL)
	$(if $(KCL_MANIFEST_FILEPATH), cat $(KCL_MANIFEST_FILEPATH))
	$(if $(KCL_MANIFEST_URL), curl -L $(KCL_MANIFEST_URL))
	
_kcl_show_manifest_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of manifest "$(KCL_MANIFEST_NAME)" ...'; $(NORMAL)
	$(if $(KCL_MANIFEST_FILEPATH), ls -al $(KCL_MANIFEST_FILEPATH))
	@$(if $(KCL_MANIFEST_URL), echo 'KCL_MANIFEST_URL=$(KCL_MANIFEST_URL)')

_kcl_show_manifest_md5sum:
	@$(INFO) '$(KCL_UI_LABEL)Showing MD5 of manifest "$(KCL_MANIFEST_NAME)" ...'; $(NORMAL)
	$(if $(KCL_MANIFEST_FILEPATH), cat $(KCL_MANIFEST_FILEPATH) | $(MD5SUM) )
	$(if $(KCL_MANIFEST_URL), wget -q -O - $(KCL_MANIFEST_URL) | $(MD5SUM) )

_kcl_unapply_manifest:
	@$(INFO) '$(KCL_UI_LABEL)Deleting resources declared in manifest "$(KCL_MANIFEST_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the manifest has not been previously applied'; $(NORMAL)
	# cat $(KCL_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_MANIFEST_|)cat
	# curl -L $(KCL_MANIFEST_URL)
	$(_KCL_UNAPPLY_MANIFEST_|)$(KUBECTL) delete $(__KCL_FILENAME__MANIFEST) $(__KCL_NAMESPACE__MANIFEST) $(__KCL_SELECTOR__MANIFEST)

_kcl_unapply_manifests:
	@$(INFO) '$(KCL_UI_LABEL)Deleting resources declared in manifest "$(KCL_MANIFEST_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the manifest has not been previously applied'; $(NORMAL)
	# $(_KCL_UNAPPLY_MANIFEST_|)cat
	# ls -al $(KCL_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_MANIFESTS_|)$(KUBECTL) delete $(__KCL_FILENAME__MANIFESTS) $(__KCL_NAMESPACE__MANIFESTS) $(__KCL_SELECTOR__MANIFESTS)

_kcl_view_manifest:
	@$(INFO) '$(KCL_UI_LABEL)Viewing manifests ...'; $(NORMAL)
	cd $(KCL_MANIFESTS_DIRPATH); ls -al ??*

_kcl_view_manifest_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing manifests-set "$(KCL_MANIFESTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Manifests are grouped based on regex and pipe-filter'; $(NORMAL)
	cd $(KCL_MANIFESTS_DIRPATH); ls -al $(KCL_MANIFESTS_REGEX) $(|_KCL_VIEW_MANIFESTS_SET)
