_KUBECTL_STORAGECLASS_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_STORAGECLASS_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_STORAGECLASS_MANIFEST_DIRPATH?= ./in/
# KCL_STORAGECLASS_MANIFEST_FILENAME?= storage-class.yml
# KCL_STORAGECLASS_MANIFEST_FILEPATH?= ./in/stoage-class.yml
# KCL_STORAGECLASS_NAME?= 
# KCL_STORAGECLASSES_SELECTOR?=
# KCL_STORAGECLASSES_SET_NAME?= my-storageclasses-set

# Derived parameters
KCL_STORAGECLASS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_STORAGECLASS_MANIFEST_FILEPATH?= $(KCL_STORAGECLASS_MANIFEST_DIRPATH)$(KCL_STORAGECLASS_MANIFEST_FILENAME)
KCL_STORAGECLASSES_SET_NAME?= $(KCL_CLUSTER_NAME)

# Option parameters
__KCL_FILENAME__STORAGECLASS= $(if $(KCL_STORAGECLASS_MANIFEST_FILEPATH),--filename $(KCL_STORAGECLASS_MANIFEST_FILEPATH))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::StorageClass ($(_KUBECTL_STORAGECLASS_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::StorageClass ($(_KUBECTL_STORAGECLASS_MK_VERSION)) parameters:'
	@echo '    KCL_STORAGECLASS_LABELS_KEYVALUES=$(KCL_STORAGECLASS_LABELS_KEYVALUES)'
	@echo '    KCL_STORAGECLASS_MANIFEST_DIRPATH=$(KCL_STORAGECLASS_MANIFEST_DIRPATH)'
	@echo '    KCL_STORAGECLASS_MANIFEST_FILENAME=$(KCL_STORAGECLASS_MANIFEST_FILENAME)'
	@echo '    KCL_STORAGECLASS_MANIFEST_FILEPATH=$(KCL_STORAGECLASS_MANIFEST_FILEPATH)'
	@echo '    KCL_STORAGECLASS_NAME=$(KCL_STORAGECLASS_NAME)'
	@echo '    KCL_STORAGECLASSES_SELECTOR=$(KCL_STORAGECLASSES_SELECTOR)'
	@echo '    KCL_STORAGECLASSES_SET_NAME=$(KCL_STORAGECLASSES_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::StorageClass ($(_KUBECTL_STORAGECLASS_MK_VERSION)) targets:'
	@echo '    _kcl_apply_storageclass                  - Apply a manifest for a storage-class'
	@echo '    _kcl_create_storageclass                 - Create a new storage-class'
	@echo '    _kcl_delete_storageclass                 - Delete an existing storage-class'
	@echo '    _kcl_edit_storageclass                   - Edit a storage-class'
	@echo '    _kcl_explain_storageclass                - Explain the storage-class object'
	@echo '    _kcl_show_storageclass                   - Show everything related to a storage-class'
	@echo '    _kcl_unapply_storageclass                - Unapply a manifest of a storage-class'
	@echo '    _kcl_view_storageclasses                 - View storage-classes'
	@echo '    _kcl_view_storageclasses_set             - View set of storage-classes'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_apply_storageclass:
	@$(INFO) '$(KCL_UI_LABEL)Applying storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) apply $(__KCL_FILENAME__STORAGECLASS)

_kcl_create_storageclass:

_kcl_delete_storageclass:
	@$(INFO) '$(KCL_UI_LABEL)Deleting storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete storageclass $(KCL_STORAGECLASS_NAME)

_kcl_edit_storageclass:
	@$(INFO) '$(KCL_UI_LABEL)Editing storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit storageclass $(KCL_STORAGECLASS_NAME)

_kcl_explain_storageclass:
	@$(INFO) '$(KCL_UI_LABEL)Explaining storage-class object ...'; $(NORMAL)
	$(KUBECTL) explain storageclass

_kcl_label_storageclass:
	@$(INFO) '$(KCL_UI_LABEL)Labelling storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label storageclass $(KCL_STORAGECLASS_NAME) $(KCL_STORAGECLASS_LABELS_KEYVALUES)

_kcl_show_storageclass:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe storageclass $(KCL_STORAGECLASS_NAME) 

_kcl_unapply_storage_class:
	@$(INFO) '$(KCL_UI_LABEL)Unapplying storage-class "$(KCL_STORAGECLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete $(__KCL_FILENAME__STORAGECLASS)

_kcl_view_storageclasses:
	@$(INFO) '$(KCL_UI_LABEL)Viewing storage-classes ...'; $(NORMAL)
	$(KUBECTL) get storageclasses $(_X__KCL_SELECTOR_STORAGECLASSES)

_kcl_view_storageclasses_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing storage-classes-set "$(KCL_STORAGECLASSS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Storage-classes are NOT namespaced!'; $(NORMAL)
	@$(WARN) 'Storage-classes are grouped based on selector, ...'; $(NORMAL)
	$(KUBECTL) get storageclasses $(__KCL_SELECTOR_STORAGECLASSES)
