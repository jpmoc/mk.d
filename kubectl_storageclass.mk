_KUBECTL_STORAGECLASS_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_STORAGECLASS_ANNOTATIONS_KEYS?= key1 ...
# KCL_STORAGECLASS_ANNOTATIONS_KEYVALUES?= key1=value1 ...
# KCL_STORAGECLASS_FIELD_JSONPATH?= .spec
# KCL_STORAGECLASS_LABELS_KEYS?= key1 ...
# KCL_STORAGECLASS_LABELS_KEYVALUES?= key1=value1 ...
# KCL_STORAGECLASS_NAME?= 
# KCL_STORAGECLASSES_MANIFEST_DIRPATH?= ./in/
# KCL_STORAGECLASSES_MANIFEST_FILENAME?= manifest.yaml
# KCL_STORAGECLASSES_MANIFEST_FILEPATH?= ./in/manifest.yaml
# KCL_STORAGECLASSES_SELECTOR?=
# KCL_STORAGECLASSES_SET_NAME?= my-storageclasses-set

# Derived parameters
KCL_STORAGECLASSES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_STORAGECLASSES_MANIFEST_FILEPATH?= $(KCL_STORAGECLASSES_MANIFEST_DIRPATH)$(KCL_STORAGECLASSES_MANIFEST_FILENAME)
KCL_STORAGECLASSES_SET_NAME?= $(KCL_CLUSTER_NAME)

# Options
__KCL_FILENAME__STORAGECLASSES= $(if $(KCL_STORAGECLASSES_MANIFEST_FILEPATH),--filename $(KCL_STORAGECLASSES_MANIFEST_FILEPATH))

# Customizations

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::StorageClass ($(_KUBECTL_STORAGECLASS_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::StorageClass ($(_KUBECTL_STORAGECLASS_MK_VERSION)) parameters:'
	@echo '    KCL_STORAGECLASS_ANNOTATIONS_KEYS=$(KCL_STORAGECLASS_ANNOTATIONS_KEYS)'
	@echo '    KCL_STORAGECLASS_ANNOTATIONS_KEYVALUES=$(KCL_STORAGECLASS_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_STORAGECLASS_FIELD_JSONPATH=$(KCL_STORAGECLASS_FIELD_JSONPATH)'
	@echo '    KCL_STORAGECLASS_LABELS_KEYS=$(KCL_STORAGECLASS_LABELS_KEYS)'
	@echo '    KCL_STORAGECLASS_LABELS_KEYVALUES=$(KCL_STORAGECLASS_LABELS_KEYVALUES)'
	@echo '    KCL_STORAGECLASS_NAME=$(KCL_STORAGECLASS_NAME)'
	@echo '    KCL_STORAGECLASSES_MANIFEST_DIRPATH=$(KCL_STORAGECLASSES_MANIFEST_DIRPATH)'
	@echo '    KCL_STORAGECLASSES_MANIFEST_FILENAME=$(KCL_STORAGECLASSES_MANIFEST_FILENAME)'
	@echo '    KCL_STORAGECLASSES_MANIFEST_FILEPATH=$(KCL_STORAGECLASSES_MANIFEST_FILEPATH)'
	@echo '    KCL_STORAGECLASSES_SELECTOR=$(KCL_STORAGECLASSES_SELECTOR)'
	@echo '    KCL_STORAGECLASSES_SET_NAME=$(KCL_STORAGECLASSES_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::StorageClass ($(_KUBECTL_STORAGECLASS_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_storageclass               - Annotate a storage-class'
	@echo '    _kcl_apply_storageclasses                - Apply a manifest for one-or-more storage-classes'
	@echo '    _kcl_create_storageclass                 - Create a new storage-class'
	@echo '    _kcl_delete_storageclass                 - Delete an existing storage-class'
	@echo '    _kcl_edit_storageclass                   - Edit a storage-class'
	@echo '    _kcl_explain_storageclass                - Explain the storage-class object'
	@echo '    _kcl_show_storageclass                   - Show everything related to a storage-class'
	@echo '    _kcl_unapply_storageclass                - Unapply a manifest of a storage-class'
	@echo '    _kcl_label_storageclass                  - Label a storage-class'
	@echo '    _kcl_list_storageclasses                 - List all storage-classes'
	@echo '    _kcl_list_storageclasses_set             - List a set of storage-classes'
	@echo '    _kcl_unannotate_storageclass             - Un-annotate a storage-class'
	@echo '    _kcl_unapply_storageclasses              - Un-apply a manifest for one-or-more storage-classes'
	@echo '    _kcl_unlabel_storageclass                - Un-label a storage-class'
	@echo '    _kcl_watch_storageclasses                - Watch all storage-classes'
	@echo '    _kcl_watch_storageclasses_set            - Watch a set of storage-classes'
	@echo '    _kcl_write_storageclasses                - Write manifest for one-or-more storage-classes'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_apply_storageclass: _kcl_apply_storageclasses
_kcl_apply_storageclasses:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more storage-classes ...'; $(NORMAL)
	$(KUBECTL) apply $(__KCL_FILENAME__STORAGECLASSES)

_kcl_create_storageclass:
	@$(INFO) '$(KCL_UI_LABEL)Creating storage-class "$(KCL_STORAGECLASS_NAME)"...'; $(NORMAL)
	# $(KUBECTL) create storageclass $(KCL_STORAGECLASS_NAME)

_kcl_delete_storageclass:
	@$(INFO) '$(KCL_UI_LABEL)Deleting storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete storageclass $(KCL_STORAGECLASS_NAME)

_kcl_edit_storageclass:
	@$(INFO) '$(KCL_UI_LABEL)Editing storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit storageclass $(KCL_STORAGECLASS_NAME)

_kcl_explain_storageclass:
	@$(INFO) '$(KCL_UI_LABEL)Explaining storage-class object ...'; $(NORMAL)
	$(KUBECTL) explain storageclass$(KCL_STORAGECLASS_FIELD_JSONPATH)

_kcl_label_storageclass:
	@$(INFO) '$(KCL_UI_LABEL)Labelling storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label storageclass $(KCL_STORAGECLASS_NAME) $(KCL_STORAGECLASS_LABELS_KEYVALUES)

_kcl_list_storageclasses:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL storage-classes ...'; $(NORMAL)
	$(KUBECTL) get storageclasses $(_X__KCL_SELECTOR_STORAGECLASSES)

_kcl_list_storageclasses_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing storage-classes-set "$(KCL_STORAGECLASSS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Storage-classes are NOT namespaced!'; $(NORMAL)
	@$(WARN) 'Storage-classes are grouped based on selector, ...'; $(NORMAL)
	$(KUBECTL) get storageclasses $(__KCL_SELECTOR_STORAGECLASSES)

_KCL_SHOW_STORAGECLASS_TARGETS?= _kcl_show_storageclass_description
_kcl_show_storageclass: $(_KCL_SHOW_STORAGECLASS_TARGETS)

_kcl_show_storageclass_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe storageclass $(KCL_STORAGECLASS_NAME) 

_kcl_unannotate_storage_class:
	@$(INFO) '$(KCL_UI_LABEL)Un-annotating storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)

_kcl_unapply_storage_class:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete $(__KCL_FILENAME__STORAGECLASS)

_kcl_unlabel_storage_class:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)

_kcl_watch_storageclasses:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL storage-classes ...'; $(NORMAL)
	$(KUBECTL) get storageclasses $(_X__KCL_SELECTOR_STORAGECLASSES)

_kcl_watch_storageclasses_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching storage-classes-set "$(KCL_STORAGECLASSS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Storage-classes are NOT namespaced!'; $(NORMAL)
	@$(WARN) 'Storage-classes are grouped based on selector, ...'; $(NORMAL)
	$(KUBECTL) get storageclasses $(__KCL_SELECTOR_STORAGECLASSES)

_kcl_write_storageclass: _kcl_write_storageclasses
_kcl_write_storageclasses:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more storage-classes ...'; $(NORMAL)
	$(WRITER) $(KCL_STORAGECLASSES_MANIFEST_FILEPATH)
