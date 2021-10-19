_KUSTOMIZE_KUSTOMIZATION_MK_VERSION= $(_KUSTOMIZE_MK_VERSION)

# KZE_KUSTOMIZATION_DIRPATH?= ./in/
KZE_KUSTOMIZATION_FILENAME?= kustomization.yaml
# KZE_KUSTOMIZATION_FILEPATH?= ./in/kustomization.yaml
# KZE_KUSTOMIZATION_MANIFEST_FILEPATH?= ./out/manifest.yaml
# KZE_KUSTOMIZATION_NAME?= my-kustomization
# KZE_KUSTOMIZATION_RESOURCES_URIS?= deployment.yaml http://github.com/service.yaml ...
# KZE_KUSTOMIZATION_TRANSFORMERS_KEYVALUES?= nameprefix='prod-'
# KZE_KUSTOMIZATIONS_DIRPATH?= ./in/kustomizations/
KZE_KUSTOMIZATIONS_REGEX?= *
# KZE_KUSTOMIZATIONS_SET_NAME?= my-kustomizations-set

# Derived parameters
KZE_KUSTOMIZATION_DIRPATH?= $(if $(KZE_KUSTOMIZATIONS_DIRPATH),$(KZE_KUSTOMIZATIONS_DIRPATH)$(KZE_KUSTOMIZATION_NAME)/,./)
KZE_KUSTOMIZATION_FILEPATH?= $(KZE_KUSTOMIZATION_DIRPATH)$(KZE_KUSTOMIZATION_FILENAME)
KZE_KUSTOMIZATION_MANIFEST_FILEPATH?= $(KZE_MANIFEST_FILEPATH)
KZE_KUSTOMIZATIONS_DIRPATH?= $(KZE_INPUTS_DIRPATH)

# Option parameters
# __KZE_FILENAME__KUSTOMIZATION= $(if $(KZE_KUSTOMIZATION_FILEPATH),--filename $(KZE_KUSTOMIZATION_FILEPATH))
# __KZE_SELECTOR__KUSTOMIZATION= $(if $(KZE_KUSTOMIZATION_SELECTOR),--selector $(KZE_KUSTOMIZATION_SELECTOR))

# Pipe
|_KZE_CREATE_KUSTOMIZATION?= | tee $(KZE_KUSTOMIZATION_MANIFEST_FILEPATH)
|_KZE_VIEW_KUSTOMIZATIONS_SET?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kze_view_framework_macros ::
	@echo 'KustomiZE::kustomization ($(_KUSTOMIZE_KUSTOMIZATION_MK_VERSION)) macros:'
	@echo

_kze_view_framework_parameters ::
	@echo 'KustomiZE::kustomization ($(_KUSTOMIZE_KUSTOMIZATION_MK_VERSION)) parameters:'
	@echo '    KZE_KUSTOMIZATION_DIRPATH=$(KZE_KUSTOMIZATION_DIRPATH)'
	@echo '    KZE_KUSTOMIZATION_FILENAME=$(KZE_KUSTOMIZATION_FILENAME)'
	@echo '    KZE_KUSTOMIZATION_FILEPATH=$(KZE_KUSTOMIZATION_FILEPATH)'
	@echo '    KZE_KUSTOMIZATION_INPUTS_DIRPATH=$(KZE_KUSTOMIZATION_INPUTS_DIRPATH)'
	@echo '    KZE_KUSTOMIZATION_MANIFEST_FILEPATH=$(KZE_KUSTOMIZATION_MANIFEST_FILEPATH)'
	@echo '    KZE_KUSTOMIZATION_NAME=$(KZE_KUSTOMIZATION_NAME)'
	@echo '    KZE_KUSTOMIZATION_RESOURCES_URIS=$(KZE_KUSTOMIZATION_RESOURCES_URIS)'
	@echo '    KZE_KUSTOMIZATION_TRANSFORMERS_KEYVALUES=$(KZE_KUSTOMIZATION_TRANSFORMERS_KEYVALUES)'
	@echo '    KZE_KUSTOMIZATIONS_DIRPATH=$(KZE_KUSTOMIZATIONS_DIRPATH)'
	@echo '    KZE_KUSTOMIZATIONS_REGEX=$(KZE_KUSTOMIZATIONS_REGEX)'
	@echo '    KZE_KUSTOMIZATIONS_SET_NAME=$(KZE_KUSTOMIZATIONS_SET_NAME)'
	@echo

_kze_view_framework_targets ::
	@echo 'KustomiZE::kustomization ($(_KUSTOMIZE_KUSTOMIZATION_MK_VERSION)) targets:'
	@echo '    _kze_add_configmaps_kustomization          - Add one or more config-maps in a kustomization'
	@echo '    _kze_add_resources_kustomization           - Add one or more resources in a kustomization'
	@echo '    _kze_add_transformers_kustomization        - Add one or more trsnformers in a kustomization'
	@echo '    _kze_create_kustomization                  - Create resources in a kustomization'
	@echo '    _kze_delete_kustomization                  - Delete resources in a kustomization'
	@echo '    _kze_edit_kustomization                    - Edit a kustomization'
	@echo '    _kze_show_kustomization                    - Show everything related to a kustomization'
	@echo '    _kze_show_kustomization_content            - Show everything related to a kustomization'
	@echo '    _kze_show_kustomization_description        - Show description of kustomization'
	@echo '    _kze_show_kustomization_manifest           - Show manifest of kustomization'
	@echo '    _kze_show_kustomization_resources          - Show resources of a kustomization'
	@echo '    _kze_update_kustomization                  - Update kustomization'
	@echo '    _kze_view_kustomizations                   - View kustomizations'
	@echo '    _kze_view_kustomizations_set               - View set of kustomizations'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kze_add_configmaps_kustomization:
	@$(INFO) '$(KZE_UI_LABEL)Adding config-map-generators to kustomization "$(KZE_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	# $(KUSTOMIZE) edit add configmap demo-configmap --from-file application.properties
	# $(KUSTOMIZE) edit add configmap demo-configmap --from-file application-prod.properties

_kze_add_patchs_kustomization:
	@$(INFO) '$(KZE_UI_LABEL)Adding config-map-generators to kustomization "$(KZE_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	# $(KUSTOMIZE) edit add patch --path patch.yaml --name sbdemo --kind Deployment --group apps --version v1

_kze_add_resources_kustomization:
	@$(INFO) '$(KZE_UI_LABEL)Adding resources to kustomization "$(KZE_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	$(foreach R, $(KZE_KUSTOMIZE_RESOURCES_URIS), \
		$(KUSTOMIZE) edit add resource $(R); \
	)

_kze_add_transformers_kustomization:
	@$(INFO) '$(KZE_UI_LABEL)Adding transformers to kustomization "$(KZE_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	$(foreach KV, $(KZE_KUSTOMIZE_TRANSFORMERS_KEYVALUES), \
		$(KUSTOMIZE) edit set $(subst =,$(SPACE),$(KV)); \
	)

_kze_create_kustomization: _kze_edit_kustomization

_kze_delete_kustomization:
	@$(INFO) '$(KZE_UI_LABEL)Deleting kustomization "$(KZE_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	rm $(KZE_KUSTOMIZATION_FILEPATH)	

_kze_edit_kustomization:
	@$(INFO) '$(KZE_UI_LABEL)Editing kustomization "$(KZE_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(KZE_KUSTOMIZATION_FILEPATH)

_kze_show_kustomization :: _kze_show_kustomization_content _kze_show_kustomization_manifest _kze_show_kustomization_resources _kze_show_kustomization_description

_kze_show_kustomization_content:
	@$(INFO) '$(KZE_UI_LABEL)Showing context of kustomization "$(KZE_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	-cat $(KZE_KUSTOMIZATION_FILEPATH)
	
_kze_show_kustomization_description:
	@$(INFO) '$(KZE_UI_LABEL)Showing description of kustomization "$(KZE_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	-ls -al $(KZE_KUSTOMIZATION_FILEPATH)

_kze_show_kustomization_manifest:
	@$(INFO) '$(KZE_UI_LABEL)Showing manifest of kustomization "$(KZE_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	-ls -la $(KZE_KUSTOMIZATION_MANIFEST_FILEPATH)
	-cat $(KZE_KUSTOMIZATION_MANIFEST_FILEPATH)

_kze_show_kustomization_resources:
	@$(INFO) '$(KZE_UI_LABEL)Showing resources of kustomization "$(KZE_KUSTOMIZATION_NAME)" ...'; $(NORMAL)
	$(if $(KZE_KUSTOMIZATION_RESOURCES),\
		ls -al $(KZE_KUSTOMIZATION_RESOURCES), \
		@echo "KZE_KUSTOMIZATION_RESOURCES not set" \
	)

_kze_update_kustomization: _kze_edit_kustomization

_kze_view_kustomizations:
	@$(INFO) '$(KZE_UI_LABEL)Viewing kustomizations ...'; $(NORMAL)
	ls -al $(KZE_KUSTOMIZATIONS_DIRPATH)

_kze_view_kustomizations_set:
	@$(INFO) '$(KZE_UI_LABEL)Viewing kustomizations-set "$(KZE_KUSTOMIZATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Kustomizations are grouped based on directory, regex, and pipe-filter'; $(NORMAL)
	ls -al $(KZE_KUSTOMIZATIONS_DIRPATH)$(KZE_KUSTOMIZATIONS_REGEX) $(|_KZE_VIEW_KUSTOMIZATIONS_SET)
