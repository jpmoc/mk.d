_KUBECTL_KUSTOMIZATION_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_KUSTOMIZATION_DIRPATH?= ./in/my-kustomization/
KCL_KUSTOMIZATION_FILENAME?= kustomization.yaml
# KCL_KUSTOMIZATION_FILEPATH?= ./in/my-kustomization/kustomization.yaml
# KCL_KUSTOMIZATION_NAME?= my-kustomization
# KCL_KUSTOMIZATION_NAMESPACE_NAME?= my-namespace
# KCL_KUSTOMIZATION_SELECTOR?= app=nginx
# KCL_KUSTOMIZATION_URL?= https://github.com/jetstack/cert-manager/releases/dir/
KCL_KUSTOMIZATION_VALIDATE_FLAG?= true
# KCL_KUSTOMIZATIONS_DIRPATH?= ./in/
KCL_KUSTOMIZATIONS_REGEX?= *
# KCL_KUSTOMIZATIONS_SET_NAME?= my-kustomizations-set

# Derived parameters
KCL_KUSTOMIZATION_DIRPATH?= $(KCL_KUSTOMIZATIONS_DIRPATH)$(KCL_KUSTOMIZATION_NAME)/
KCL_KUSTOMIZATION_FILEPATH?= $(if $(KCL_KUSTOMIZATION_FILENAME),$(KCL_KUSTOMIZATION_DIRPATH)$(KCL_KUSTOMIZATION_FILENAME))
KCL_KUSTOMIZATION_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_KUSTOMIZATIONS_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_KUSTOMIZATIONS_SET_NAME?= kustomizations@$(KCL_KUSTOMIZATIONS_DIRPATH)

# Option parameters
__KCL_KUSTOMIZE__KUSTOMIZATION+= $(if $(KCL_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_KUSTOMIZATION_DIRPATH))
# __KCL_KUSTOMIZE__KUSTOMIZATION+= $(if $(KCL_KUSTOMIZATION_URL),--kustomize $(KCL_KUSTOMIZATION_URL))
__KCL_NAMESPACE__KUSTOMIZATION= $(if $(KCL_KUSTOMIZATION_NAMESPACE_NAME),--namespace $(KCL_KUSTOMIZATION_NAMESPACE_NAME))
__KCL_SELECTOR__KUSTOMIZATION= $(if $(KCL_KUSTOMIZATION_SELECTOR),--selector $(KCL_KUSTOMIZATION_SELECTOR))
__KCL_VALIDATE__KUSTOMIZATION= $(if $(KCL_KUSTOMIZATION_VALIDATE_FLAG),--validate=$(KCL_KUSTOMIZATION_VALIDATE_FLAG))

# Pipe
_KCL_APPLY_KUSTOMIZATION_|?= #
_KCL_DIFF_KUSTOMIZATION_|?= $(_KCL_APPLY_KUSTOMIZATION_|)
_KCL_UNAPPLY_KUSTOMIZATION_|?= $(_KCL_APPLY_KUSTOMIZATION_|)
|_KCL_DOWNLOAD_KUSTOMIZATION?= | tee $(KCL_KUSTOMIZATION_DOWNLOAD_FILEPATH)
|_KCL_VIEW_KUSTOMIZATIONS_SET?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Kustomization ($(_KUBECTL_KUSTOMIZATION_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Kustomization ($(_KUBECTL_KUSTOMIZATION_MK_VERSION)) parameters:'
	@echo '    KCL_KUSTOMIZATION_DIRPATH=$(KCL_KUSTOMIZATION_DIRPATH)'
	@echo '    KCL_KUSTOMIZATION_FILENAME=$(KCL_KUSTOMIZATION_FILENAME)'
	@echo '    KCL_KUSTOMIZATION_FILEPATH=$(KCL_KUSTOMIZATION_FILEPATH)'
	@echo '    KCL_KUSTOMIZATION_NAME=$(KCL_KUSTOMIZATION_NAME)'
	@echo '    KCL_KUSTOMIZATION_NAMESPACE_NAME=$(KCL_KUSTOMIZATION_NAMESPACE_NAME)'
	@echo '    KCL_KUSTOMIZATION_SELECTOR=$(KCL_KUSTOMIZATION_SELECTOR)'
	@echo '    KCL_KUSTOMIZATION_VALIDATE_FLAG=$(KCL_KUSTOMIZATION_VALIDATE_FLAG)'
	@echo '    KCL_KUSTOMIZATIONS_DIRPATH=$(KCL_KUSTOMIZATIONS_DIRPATH)'
	@echo '    KCL_KUSTOMIZATIONS_REGEX=$(KCL_KUSTOMIZATIONS_REGEX)'
	@echo '    KCL_KUSTOMIZATIONS_SET_NAME=$(KCL_KUSTOMIZATIONS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Kustomization ($(_KUBECTL_KUSTOMIZATION_MK_VERSION)) targets:'
	@echo '    _kcl_apply_kustomization                   - Apply a kustomization'
	@echo '    _kcl_create_kustomization                  - Create resources in a kustomization'
	@echo '    _kcl_delete_kustomization                  - Delete resources in a kustomization'
	@echo '    _kcl_diff_kustomization                    - Diff current state with kustomization'
	@echo '    _kcl_edit_kustomization                    - Edit a kustomization'
	@echo '    _kcl_show_kustomization                    - Show everything related to a kustomization'
	@echo '    _kcl_show_kustomization_content            - Show everything related to a kustomization'
	@echo '    _kcl_show_kustomization_description        - Show description of a kustomization'
	@echo '    _kcl_unapply_kustomization                 - Unapply a kustomization'
	@echo '    _kcl_view_kustomizations                   - View all kustomizations'
	@echo '    _kcl_view_kustomizations_set               - View set of kustomizations'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_apply_kustomization:
	@$(INFO) '$(KCL_UI_LABEL)Applying kustomization "$(KCL_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	$(if $(KCL_KUSTOMIZATION_FILEPATH), cat $(KCL_KUSTOMIZATION_FILEPATH))
	$(_KCL_APPLY_KUSTOMIZAITON_|)$(KUBECTL) apply $(__KCL_KUSTOMIZE__KUSTOMIZATION) $(__KCL_NAMESPACE__KUSTOMIZATION) $(__KCL_SELECTOR__KUSTOMIZATION) $(__KCL_VALIDATE__KUSTOMIZATION)

_kcl_create_kustomization:
	@$(INFO) '$(KCL_UI_LABEL)Creating resources declared in kustomization "$(KCL_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	$(if $(KCL_KUSTOMIZATION_FILEPATH), cat $(KCL_KUSTOMIZATION_FILEPATH))
	$(KUBECTL) create $(__KCL_KUSTOMIZE__KUSTOMIZATION) $(__KCL_NAMESPACE__KUSTOMIZATION) $(__KCL_SELECTOR__KUSTOMIZATION)

_kcl_delete_kustomization: _kcl_unapply_kustomization

_kcl_diff_kustomization:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing current state with kustomization "$(KCL_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation submits the manifest to the cluster to take webhooks into consideration'; $(NORMAL)
	$(_KCL_DIFF_KUSTOMIZATION_|)$(KUBECTL) diff $(__KCL_KUSTOMIZE__KUSTOMIZATION) $(__KCL_NAMESPACE__KUSTOMIZATION) $(__KCL_SELECTOR__KUSTOMIZATION)

_kcl_edit_kustomization:
	@$(INFO) '$(KCL_UI_LABEL)Editing kustomization "$(KCL_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(KCL_KUSTOMIZATION_FILEPATH)

_kcl_show_kustomization: _kcl_show_kustomization_content _kcl_show_kustomization_description

_kcl_show_kustomization_content:
	@$(INFO) '$(KCL_UI_LABEL)Showing content of kustomization "$(KCL_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	$(if $(KCL_KUSTOMIZATION_FILEPATH), cat $(KCL_KUSTOMIZATION_FILEPATH))
	@#$(if $(KCL_KUSTOMIZATION_URL), curl -L $(KCL_KUSTOMIZATION_URL))
	
_kcl_show_kustomization_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of kustomization "$(KCL_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	$(if $(KCL_KUSTOMIZATION_FILEPATH), ls -al $(KCL_KUSTOMIZATION_FILEPATH))
	@#$(if $(KCL_KUSTOMIZATION_URL), echo 'KCL_KUSTOMIZATION_URL=$(KCL_KUSTOMIZATION_URL)')

_kcl_unapply_kustomization:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying kustomization "$(KCL_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the kustomization has not been previously applied'; $(NORMAL)
	# cat $(KCL_KUSTOMIZATION_FILEPATH)
	$(_KCL_UNAPPLY_KUSTOMIZATION_|)$(KUBECTL) delete $(__KCL_KUSTOMIZE__KUSTOMIZATION) $(__KCL_NAMESPACE__KUSTOMIZATION)

_kcl_view_kustomizations:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL kustomizations ...'; $(NORMAL)
	cd $(KCL_KUSTOMIZATIONS_DIRPATH); ls -ald *

_kcl_view_kustomizations_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing kustomizations-set "$(KCL_KUSTOMIZATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Kustomizations are grouped based on directory, regex, and pipe-filter'; $(NORMAL)
	cd $(KCL_KUSTOMIZATIONS_DIRPATH); ls -ald $(KCL_KUSTOMIZATIONS_REGEX) $(|_KCL_VIEW_KUSTOMIZATIONS_SET)
