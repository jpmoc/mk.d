_KUBECTL_PERSISTENTVOLUMECLAIM_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_PERSISTENTVOLUMECLAIM_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_PERSISTENTVOLUMECLAIM_NAME?= 
# KCL_PERSISTENTVOLUMECLAIM_NAMESPACE_NAME?= default
# KCL_PERSISTENTVOLUMECLAIM_PERSISTENTVOLUME_NAME?= pvc-05927e9c-18ad-11ea-86f1-6e86a0f32ea2
# KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_DIRPATH?= ./in/
# KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILENAME?= persisten-volume-claim-manifest.yaml
# KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILEPATH?= ./in/persistent-volume-claim-manifest.yaml
# KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_URL?= http://
# KCL_PERSISTENTVOLUMECLAIMS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_PERSISTENTVOLUMECLAIMS_NAMESPACE_NAME?= default
# KCL_PERSISTENTVOLUMECLAIMS_SELECTOR?=
# KCL_PERSISTENTVOLUMECLAIMS_SET_NAME?= my-persistentvolume-set

# Derived parameters
KCL_PERSISTENTVOLUMECLAIM_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_PERSISTENTVOLUMECLAIM_PERSISTENTVOLUME_NAME?= $(KCL_PERSISTENTVOLUME_NAME)
KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILEPATH?= $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_DIRPATH)$(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILENAME)
KCL_PERSISTENTVOLUMECLAIMS_NAMESPACE_NAME?= $(KCL_PERSISTENTVOLUMECLAIM_NAMESPACE_NAME)
KCL_PERSISTENTVOLUMECLAIMS_SET_NAME?= $(KCL_CLUSTER_NAME)

# Options
__KCL_FILENAME__PERSISTENTVOLUMECLAIMS+= $(if $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILEPATH),--filename $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILEPATH))
__KCL_FILENAME__PERSISTENTVOLUMECLAIMS+= $(if $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_URL),--filename $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_URL))
__KCL_FILENAME__PERSISTENTVOLUMECLAIMS+= $(if $(KCL_PERSISTENTVOLUMECLAIMS_MANIFESTS_DIRPATH),--filename $(KCL_PERSISTENTVOLUMECLAIMS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__PERSISTENTVOLUMECLAIM= $(if $(KCL_PERSISTENTVOLUMECLAIM_NAMESPACE_NAME),--namespace $(KCL_PERSISTENTVOLUMECLAIM_NAMESPACE_NAME))
__KCL_NAMESPACE__PERSISTENTVOLUMECLAIMS= $(if $(KCL_PERSISTENTVOLUMECLAIMS_NAMESPACE_NAME),--namespace $(KCL_PERSISTENTVOLUMECLAIMS_NAMESPACE_NAME))
__KCL_SELECTOR__PERSISTENTVOLUMECLAIMS= $(if $(KCL_PERSISTENTVOLUMECLAIMS_SELECTOR),--selector $(KCL_PERSISTENTVOLUMECLAIMS_SELECTOR))

# Customizations

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::PersistentVolumeClaim ($(_KUBECTL_PERSISTENTVOLUMECLAIM_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::PersistentVolumeClaim ($(_KUBECTL_PERSISTENTVOLUMECLAIM_MK_VERSION)) parameters:'
	@echo '    KCL_PERSISTENTVOLUMECLAIM_LABELS_KEYVALUES=$(KCL_PERSISTENTVOLUMECLAIM_LABELS_KEYVALUES)'
	@echo '    KCL_PERSISTENTVOLUMECLAIM_NAME=$(KCL_PERSISTENTVOLUMECLAIM_NAME)'
	@echo '    KCL_PERSISTENTVOLUMECLAIM_NAMESPACE_NAME=$(KCL_PERSISTENTVOLUMECLAIM_NAMESPACE_NAME)'
	@echo '    KCL_PERSISTENTVOLUMECLAIM_PERSSTENTVOLUME__NAME=$(KCL_PERSISTENTVOLUMECLAIM_PERSISTENTVOLUME_NAME)'
	@echo '    KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_DIRPATH=$(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_DIRPATH)'
	@echo '    KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILENAME=$(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILENAME)'
	@echo '    KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILEPATH=$(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILEPATH)'
	@echo '    KCL_PERSISTENTVOLUMECLAIMS_MANIFESTS_DIRPATH=$(KCL_PERSISTENTVOLUMECLAIMS_MANIFESTS_DIRPATH)'
	@echo '    KCL_PERSISTENTVOLUMECLAIMS_SELECTOR=$(KCL_PERSISTENTVOLUMECLAIMS_SELECTOR)'
	@echo '    KCL_PERSISTENTVOLUMECLAIMS_SET_NAME=$(KCL_PERSISTENTVOLUMECLAIMS_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::PersistentVolumeClaim ($(_KUBECTL_PERSISTENTVOLUMECLAIM_MK_VERSION)) targets:'
	@echo '    _kcl_apply_persistentvolume                       - Apply a manifest with persistent-volume-claim'
	@echo '    _kcl_create_persistentvolume                      - Create a new persistent-volume-claim'
	@echo '    _kcl_delete_persistentvolumeclaim                 - Delete an existing persistent-volume-claim'
	@echo '    _kcl_edit_persistentvolumeclaim                   - Edit a persistent-volume-claim'
	@echo '    _kcl_explain_persistentvolumeclaim                - Explain the persistent-volume-claim object'
	@echo '    _kcl_list_persistentvolumeclaims                  - List all persistent-volume-claims'
	@echo '    _kcl_list_persistentvolumeclaims_set              - List a set of persistent-volume-claims'
	@echo '    _kcl_show_persistentvolumeclaim                   - Show everything related to a persistent-volume-claim'
	@echo '    _kcl_show_persistentvolumeclaim_description       - Show the description of a persistent-volume-claim'
	@echo '    _kcl_unapply_persistentvolume                     - Unapply a manifest with persistent-volume-claim'
	@echo '    _kcl_watch_persistentvolumeclaims                 - Watch all persistent-volume-claims'
	@echo '    _kcl_watch_persistentvolumeclaims_set             - Watch set of persistent-volume-claims'
	@echo '    _kcl_write_persistentvolumeclaims                 - Write a manifest for one-or-more persistent-volume-claims'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_apply_persistentvolumeclaim: _kcl_apply_persistentvolumeclaims
_kcl_apply_persistentvolumeclaims:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for on-or-more persistent-volume-claims ...'; $(NORMAL)
	$(if $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILEPATH), cat $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILEPATH); echo)
	$(if $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_URL), curl -L $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_URL); echo )
	$(if $(KCL_PERSISTENTVOLUMECLAIMS_MANIFESTS_DIRPATH), ls -al $(KCL_PERSISTENTVOLUMECLAIMS_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__PERSISTENTVOLUMECLAIMS) $(__KCL_NAMESPACE__PERSISTENTVOLUMECLAIMS)

_kcl_create_persistentvolumeclaim:
	@$(INFO) '$(KCL_UI_LABEL)Creating persistent-volume-claim "$(KCL_PERSISTENTVOLUMECLAIM_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) create persistentvolumeclaim $(__KCL_NAMESPACE__PERSISTENTVOLUMECLAIM) $(KCL_PERSISTENTVOLUMECLAIM_NAME)

_kcl_delete_persistentvolumeclaim:
	@$(INFO) '$(KCL_UI_LABEL)Deleting persistent-volume-claim "$(KCL_PERSISTENTVOLUMECLAIM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation deletes not only the PVC, but also the corresponding persistent-volume'; $(NORMAL)
	$(KUBECTL) delete persistentvolumeclaim $(__KCL_NAMESPACE__PERSISTENTVOLUMECLAIM) $(KCL_PERSISTENTVOLUMECLAIM_NAME)

_kcl_edit_persistentvolumeclaim:
	@$(INFO) '$(KCL_UI_LABEL)Editing persistent-volume-claim "$(KCL_PERSISTENTVOLUMECLAIM_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit persistentvolumeclaim $(KCL_PERSISTENTVOLUMECLAIM_NAME)

_kcl_explain_persistentvolumeclaim:
	@$(INFO) '$(KCL_UI_LABEL)Explaining persistent-volume-claim object ...'; $(NORMAL)
	$(KUBECTL) explain persistentvolumeclaim

_kcl_label_persistentvolumeclaim:
	@$(INFO) '$(KCL_UI_LABEL)Labeling persistent-volume-claim "$(KCL_PERSISTENTVOLUMECLAIM_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label persistentvolumeclaim $(KCL_PERSISTENTVOLUMECLAIM_NAME) $(KCL_PERSISTENTVOLUMECLAIM_LABELS_KEYVALUES)

_kcl_list_persistentvolumeclaims:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL persistent-volume-claims ...'; $(NORMAL)
	$(KUBECTL) get persistentvolumeclaims --all-namespaces=true $(_X__KCL_NAMESPACE__PERSISTENTVOLUMECLAIMS) $(_X__KCL_SELECTOR_PERSISTENTVOLUMECLAIMS)

_kcl_list_persistentvolumeclaims_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing persistent-volume-claims-set "$(KCL_PERSISTENTVOLUMECLAIMS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Persistent-volume-claims are grouped based on namespace, selector, ...'; $(NORMAL)
	$(KUBECTL) get persistentvolumeclaims $(__KCL_NAMESPACE__PERSISTENTVOLUMECLAIMS) $(__KCL_SELECTOR__PERSISTENTVOLUMECLAIMS)

_KCL_SHOW_PERSISTENTVOLUMECLAIM_TARGETS?= _kcl_show_persistentvolumeclaim_persistentvolume _kcl_show_persistentvolumeclaim_description
_kcl_show_persistentvolumeclaim: $(_KCL_SHOW_PERSISTENTVOLUMECLAIM_TARGETS)

_kcl_show_persistentvolumeclaim_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of persistent-volume-claim "$(KCL_PERSISTENTVOLUMECLAIM_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe persistentvolumeclaim $(__KCL_NAMESPACE__PERSISTENTVOLUMECLAIM) $(KCL_PERSISTENTVOLUMECLAIM_NAME) 

_kcl_show_persistentvolumeclaim_persistentvolume:
	@$(INFO) '$(KCL_UI_LABEL)Showing persistent-volume of persistent-volume-claim "$(KCL_PERSISTENTVOLUMECLAIM_NAME)" ...'; $(NORMAL)

_kcl_unapply_persistentvolumeclaim: _kcl_unapply_persistentvolumeclaims
_kcl_unapply_persistentvolumeclaims:
	@$(INFO) '$(KCL_UI_LABEL)Unapplying manifest for one-or-more persistent-volume-claims ...'; $(NORMAL)
	$(if $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILEPATH), cat $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILEPATH); echo)
	$(if $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_URL), curl -L $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_URL); echo )
	$(if $(KCL_PERSISTENTVOLUMECLAIMS_MANIFESTS_DIRPATH), ls -al $(KCL_PERSISTENTVOLUMECLAIMS_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__PERSISTENTVOLUMECLAIMS) $(__KCL_NAMESPACE__PERSISTENTVOLUMECLAIMS)

_kcl_watch_persistentvolumeclaims:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL persistent-volume-claims ...'; $(NORMAL)

_kcl_watch_persistentvolumeclaims_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching persistent-volume-claims-set "$(KCL_PERSISTENTVOLUMECLAIMS_SET_NAME)" ...'; $(NORMAL)

_kcl_write_persistentvolumeclaims:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more persistent-volume-claims ...'; $(NORMAL)
	$(WRITER) $(KCL_PERSISTENTVOLUMECLAIMS_MANIFEST_FILEPATH)
