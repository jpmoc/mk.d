_KUBECTL_PERSISTENTVOLUME_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_PERSISTENTVOLUME_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_PERSISTENTVOLUME_ID?= aws://us-east-2a/vol-0375848103d6d426d
# KCL_PERSISTENTVOLUME_NAME?= 
# KCL_PERSISTENTVOLUMES_MANIFEST_DIRPATH?= ./in/
# KCL_PERSISTENTVOLUMES_MANIFEST_FILENAME?= persistent-volume-manifest.yaml
# KCL_PERSISTENTVOLUMES_MANIFEST_FILEPATH?= ./in/persistent-volume-manifest.yaml
# KCL_PERSISTENTVOLUMES_MANIFEST_URL?= http://
# KCL_PERSISTENTVOLUMES_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_PERSISTENTVOLUMES_SELECTOR?=
# KCL_PERSISTENTVOLUMES_SET_NAME?= my-persistentvolume-set

# Derived parameters
KCL_PERSISTENTVOLUMES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_PERSISTENTVOLUMES_MANIFEST_FILEPATH?= $(KCL_PERSISTENTVOLUMES_MANIFEST_DIRPATH)$(KCL_PERSISTENTVOLUMES_MANIFEST_FILENAME)
KCL_PERSISTENTVOLUMES_SET_NAME?= $(KCL_CLUSTER_NAME)

# Options
__KCL_FILENAME__PERSISTENTVOLUMES+= $(if $(KCL_PERSISTENTVOLUMES_MANIFEST_FILEPATH),--filename $(KCL_PERSISTENTVOLUMES_MANIFEST_FILEPATH))
__KCL_FILENAME__PERSISTENTVOLUMES+= $(if $(KCL_PERSISTENTVOLUMES_MANIFEST_URL),--filename $(KCL_PERSISTENTVOLUMES_MANIFEST_URL))
__KCL_FILENAME__PERSISTENTVOLUMES+= $(if $(KCL_PERSISTENTVOLUMES_MANIFESTS_DIRPATH),--filename $(KCL_PERSISTENTVOLUMES_MANIFESTS_DIRPATH))

# Customizations

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::PersistentVolume ($(_KUBECTL_PERSISTENTVOLUME_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::PersistentVolume ($(_KUBECTL_PERSISTENTVOLUME_MK_VERSION)) parameters:'
	@echo '    KCL_PERSISTENTVOLUME_ID=$(KCL_PERSISTENTVOLUME_ID)'
	@echo '    KCL_PERSISTENTVOLUME_LABELS_KEYVALUES=$(KCL_PERSISTENTVOLUME_LABELS_KEYVALUES)'
	@echo '    KCL_PERSISTENTVOLUME_NAME=$(KCL_PERSISTENTVOLUME_NAME)'
	@echo '    KCL_PERSISTENTVOLUMES_MANIFEST_DIRPATH=$(KCL_PERSISTENTVOLUMES_MANIFEST_DIRPATH)'
	@echo '    KCL_PERSISTENTVOLUMES_MANIFEST_FILENAME=$(KCL_PERSISTENTVOLUMES_MANIFEST_FILENAME)'
	@echo '    KCL_PERSISTENTVOLUMES_MANIFEST_FILEPATH=$(KCL_PERSISTENTVOLUMES_MANIFEST_FILEPATH)'
	@echo '    KCL_PERSISTENTVOLUMES_MANIFESTS_DIRPATH=$(KCL_PERSISTENTVOLUMES_MANIFESTS_DIRPATH)'
	@echo '    KCL_PERSISTENTVOLUMES_SELECTOR=$(KCL_PERSISTENTVOLUMES_SELECTOR)'
	@echo '    KCL_PERSISTENTVOLUMES_SET_NAME=$(KCL_PERSISTENTVOLUMES_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::PersistentVolume ($(_KUBECTL_PERSISTENTVOLUME_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_persistentvolume               - Annotate a persistent-volume'
	@echo '    _kcl_apply_persistentvolumes                 - Apply manifest for one or more persistent-volume'
	@echo '    _kcl_create_persistentvolume                 - Create a new persistent-volume'
	@echo '    _kcl_delete_persistentvolume                 - Delete an existing persistent-volume'
	@echo '    _kcl_edit_persistentvolume                   - Edit a persistent-volume'
	@echo '    _kcl_explain_persistentvolume                - Explain the persistent-volume object'
	@echo '    _kcl_show_persistentvolume                   - Show everything related to a persistent-volume'
	@echo '    _kcl_unapply_persistentvolumes               - Un-apply manifest for one or more persistent-volume'
	@echo '    _kcl_list_persistentvolumes                  - List all persistent-volumes'
	@echo '    _kcl_list_persistentvolumes_set              - View set of persistent-volumes'
	@echo '    _kcl_watch_persistentvolumes                 - Watch all persistent-volumes'
	@echo '    _kcl_watch_persistentvolumes_set             - Watch a set of persistent-volumes'
	@echo '    _kcl_write_persistentvolumes                 - Write a manifest for one-or-more persistent-volumes'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_persistentvolume:
	@$(INFO) '$(KCL_UI_LABEL)Annotating persistent-volume "$(KCL_PERSISTENTVOLUME_NAME)" ...'; $(NORMAL)

_kcl_apply_persistentvolume: _kcl_apply_persistentvolumes
_kcl_apply_persistentvolumes:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more persistent-volumes ...'; $(NORMAL)
	$(if $(KCL_PERSISTENTVOLUMES_MANIFEST_FILEPATH), cat $(KCL_PERSISTENTVOLUMES_MANIFEST_FILEPATH); echo)
	$(if $(KCL_PERSISTENTVOLUMES_MANIFEST_URL), curl -L $(KCL_PERSISTENTVOLUMES_MANIFEST_URL); echo )
	$(if $(KCL_PERSISTENTVOLUMES_MANIFESTS_DIRPATH), ls -al $(KCL_PERSISTENTVOLUMES_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__PERSISTENTVOLUMES) $(__KCL_NAMESPACE__PERSISTENTVOLUMES)

_kcl_create_persistentvolume:
	@$(INFO) '$(KCL_UI_LABEL)Creating persistent-volume "$(KCL_PERSISTENTVOLUME_NAME)" ...'; $(NORMAL)

_kcl_delete_persistentvolume:
	@$(INFO) '$(KCL_UI_LABEL)Deleting persistent-volume "$(KCL_PERSISTENTVOLUME_NAME)" ...'; $(NORMAL)

_kcl_edit_persistentvolume:
	@$(INFO) '$(KCL_UI_LABEL)Editing persistent-volume "$(KCL_PERSISTENTVOLUME_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit persistentvolume $(KCL_PERSISTENTVOLUME_NAME)

_kcl_explain_persistentvolume:
	@$(INFO) '$(KCL_UI_LABEL)Explaining persistent-volume object ...'; $(NORMAL)
	$(KUBECTL) explain persistentvolume

_kcl_label_persistentvolume:
	@$(INFO) '$(KCL_UI_LABEL)Labelling persistent-volume "$(KCL_PERSISTENTVOLUME_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label persistentvolume $(KCL_PERSISTENTVOLUME_NAME) $(KCL_PERSISTENTVOLUME_LABELS_KEYVALUES)

_kcl_list_persistentvolumes:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL persistent-volumes ...'; $(NORMAL)
	@$(WARN) 'If the name of the volume starts with "pvc-", then it has been created using dynamic volume provisioning'; $(NORMAL)
	@$(WARN) 'Reclaim policy is "Delete" means the PV is deleted once the PVC is deleted'; $(NORMAL)
	@$(WARN) 'Note that PVs are namespaced because PVCs are and there is a 1-to-1 mapping!'; $(NORMAL)
	$(KUBECTL) get persistentvolumes $(_X__KCL_SELECTOR_PERSISTENTVOLUMES)

_kcl_list_persistentvolumes_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing persistent-volumes-set "$(KCL_PERSISTENTVOLUMES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Persistent-volumes are grouped based on selector, ...'; $(NORMAL)
	$(KUBECTL) get persistentvolumes $(__KCL_SELECTOR_PERSISTENTVOLUMES)

_KCL_SHOW_PERSISTENTVOLUME_TARGETS?= _kcl_show_persistentvolume_description

_kcl_show_persistentvolume: $(_KCL_SHOW_PERSISTENTVOLUME_TARGETS)

_kcl_show_persistentvolume_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of persistent-volume "$(KCL_PERSISTENTVOLUME_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe persistentvolume $(KCL_PERSISTENTVOLUME_NAME) 

_kcl_unapply_persistentvolume: _kcl_unapply_persistentvolumes
_kcl_unapply_persistentvolumes:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more persistent-volumes ...'; $(NORMAL)
	# cat $(KCL_PERSISTENTVOLUMES_MANIFEST_FILEPATH)
	# curl -L $(KCL_PERSISTENTVOLUMES_MANIFEST_URL)
	# ls -al $(KCL_PERSISTENTVOLUMES_MANIFESTS_DIRPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__PERSISTENTVOLUMES) $(__KCL_NAMESPACE__PERSISTENTVOLUMES)

_kcl_watch_persistentvolumes:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL persistent-volumes ...'; $(NORMAL)

_kcl_watch_persistentvolumes_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching persistent-volumes-set "$(KCL_PERSISTENTVOLUMES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Persistent-volumes are grouped based on selector, ...'; $(NORMAL)

_kcl_write_persistentvolume: _kcl_write_persistentvolumes
_kcl_write_persistentvolumes:
	@$(INFO) '$(KCL_UI_LABEL)Write manifest for one-or-more persistent-volumes ...'; $(NORMAL)
	$(WRITER) $(KCL_PERSISTENTVOLUMES_MANIFEST_FILEPATH)
