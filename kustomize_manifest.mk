_KUSTOMIZE_MANIFEST_MK_VERSION= $(_KUSTOMIZE_MK_VERSION)

# KZE_MANIFEST_DIRPATH?= ./out/
# KZE_MANIFEST_FILENAME?= manifest.yaml
# KZE_MANIFEST_FILEPATH?= ./out/manifest.yaml
# KZE_MANIFEST_KUSTOMIZATION_DIRPATH?= ./in/
# KZE_MANIFEST_KUSTOMIZATION_FILENAME?= kustomization.yaml
# KZE_MANIFEST_KUSTOMIZATION_FILEPATH?= ./in/kustomization.yaml
# KZE_MANIFEST_NAME?= manifest
# KZE_MANIFEST_NAMESPACE_NAME?= manifest
# KZE_MANIFEST_SELECTOR?= app=toto

# Derived parameters
KZE_MANIFEST_DIRPATH?= $(KZE_OUTPUTS_DIRPATH)
KZE_MANIFEST_FILEPATH?= $(if $(KZE_MANIFEST_FILENAME),$(KZE_MANIFEST_DIRPATH)$(KZE_MANIFEST_FILENAME))
KZE_MANIFEST_KUSTOMIZATION_DIRPATH?= $(KZE_KUSTOMIZATION_DIRPATH)
KZE_MANIFEST_KUSTOMIZATION_FILENAME?= $(KZE_KUSTOMIZATION_FILENAME)
KZE_MANIFEST_KUSTOMIZATION_FILEPATH?= $(KZE_KUSTOMIZATION_FILEPATH)
KZE_MANIFEST_NAME?= $(KZE_KUSTOMIZATION_NAME)

# Options
__KZE_FILENAME= $(if $(KZE_MANIFEST_FILEPATH),--filename $(KZE_MANIFEST_FILEPATH))
__KZE_SELECTOR= $(if $(KZE_MANIFEST_SELECTOR),--selector $(KZE_MANIFEST_SELECTOR))

# Customizations
|_KZE_CREATE_MANIFEST?= | tee $(KZE_MANIFEST_FILEPATH)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kze_list_macros ::
	@#echo 'KustomiZE::Manifest ($(_KUSTOMIZE_MANIFEST_MK_VERSION)) macros:'
	@#echo

_kze_list_parameters ::
	@echo 'KustomiZE::Manifest ($(_KUSTOMIZE_MANIFEST_MK_VERSION)) parameters:'
	@echo '    KZE_MANIFEST_DIRPATH=$(KZE_MANIFEST_DIRPATH)'
	@echo '    KZE_MANIFEST_FILENAME=$(KZE_MANIFEST_FILENAME)'
	@echo '    KZE_MANIFEST_FILEPATH=$(KZE_MANIFEST_FILEPATH)'
	@echo '    KZE_MANIFEST_INPUTS_DIRPATH=$(KZE_MANIFEST_INPUTS_DIRPATH)'
	@echo '    KZE_MANIFEST_KUSTOMIZATION_FILEPATH=$(KZE_MANIFEST_KUSTOMIZATION_FILEPATH)'
	@echo '    KZE_MANIFEST_NAME=$(KZE_MANIFEST_NAME)'
	@echo '    KZE_MANIFEST_NAMESPACE_NAME=$(KZE_MANIFEST_NAMESPACE_NAME)'
	@echo '    KZE_MANIFEST_SELECTOR=$(KZE_MANIFEST_SELECTOR)'
	@#echo '    KZE_MANIFESTS_DIRPATH=$(KZE_MANIFESTS_DIRPATH)'
	@#echo '    KZE_MANIFESTS_REGEX=$(KZE_MANIFESTS_REGEX)'
	@#echo '    KZE_MANIFESTS_SET_NAME=$(KZE_MANIFESTS_SET_NAME)'
	@echo

_kze_list_targets ::
	@echo 'KustomiZE::Manifest ($(_KUSTOMIZE_MANIFEST_MK_VERSION)) targets:'
	@echo '    _kze_apply_manifest                   - Create resources in a manifest'
	@echo '    _kze_create_manifest                  - Create resources in a manifest'
	@echo '    _kze_delete_manifest                  - Delete resources in a manifest'
	@#echo '    _kze_list_manifests                   - List all manifests'
	@#echo '    _kze_list_manifests_set               - List a set of manifests'
	@echo '    _kze_show_manifest                    - Show everything related to a manifest'
	@echo '    _kze_show_manifest_content            - Show everything related to a manifest'
	@echo '    _kze_show_manifest_description        - Show description of manifest'
	@echo '    _kze_show_manifest_kustomization      - Show kustomization of a manifest'
	@echo '    _kze_unapply_manifest                 - Unapply a manifest'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kze_apply_manifest:
	@$(INFO) '$(KZE_UI_LABEL)Applying manifest "$(KZE_MANIFEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) apply $(__KZE_FILENAME) $(__KZE_NAMESPACE) $(__KZE_SELECTOR)

_kze_create_manifest:
	@$(INFO) '$(KZE_UI_LABEL)Creating manifest "$(KZE_MANIFEST_NAME)" ...'; $(NORMAL)
	cat $(KZE_MANIFEST_KUSTOMIZATION_FILEPATH); echo
	$(KUSTOMIZE) build $(KZE_MANIFEST_KUSTOMIZATION_DIRPATH) $(|_KZE_CREATE_MANIFEST)

_kze_delete_manifest:
	@$(INFO) '$(KZE_UI_LABEL)Deleting manifest "$(KZE_MANIFEST_NAME)" ...'; $(NORMAL)
	rm $(KZE_MANIFEST_FILEPATH)	

_kze_list_manifests:
	@$(INFO) '$(KZE_UI_LABEL)Listing manifests ...'; $(NORMAL)

_kze_list_manifests_set:
	@$(INFO) '$(KZE_UI_LABEL)Listing manifests-set "$(KZE_MANIFESTS_SET_NAME)" ...'; $(NORMAL)

_kze_show_manifest :: _kze_show_manifest_content _kze_show_manifest_kustomization _kze_show_manifest_description

_kze_show_manifest_content:
	@$(INFO) '$(KZE_UI_LABEL)Showing content of manifest "$(KZE_MANIFEST_NAME)" ...'; $(NORMAL)
	-cat $(KZE_MANIFEST_FILEPATH)
	
_kze_show_manifest_description:
	@$(INFO) '$(KZE_UI_LABEL)Showing description of manifest "$(KZE_MANIFEST_NAME)" ...'; $(NORMAL)
	-ls -al $(KZE_MANIFEST_FILEPATH)

_kze_show_manifest_kustomization:
	@$(INFO) '$(KZE_UI_LABEL)Showing kustomization of manifest "$(KZE_MANIFEST_NAME)" ...'; $(NORMAL)
	-cat $(KZE_MANIFEST_KUSTOMIZATION_FILEPATH)
	
_kze_unapply_manifest:
	@$(INFO) '$(KZE_UI_LABEL)Un-applying manifest "$(KZE_MANIFEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete $(__KZE_FILENAME) $(__KZE_NAMESPACE) $(__KZE_SELECTOR)
