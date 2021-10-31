_KUBECTL_ISTIO_MESHPOLICY_MK_VERSION= $(_KUBECTL_ISTIO_MK_VERSION)

# KCL_MESHPOLICY_MANIFEST_DIRPATH?=
# KCL_MESHPOLICY_MANIFEST_FILENAME?=
# KCL_MESHPOLICY_MANIFEST_FILEPATH?=
KCL_MESHPOLICY_NAME?= default
# KCL_MESHPOLICY_OUTPUT_FORMAT?=
# KCL_MESHPOLICIES_OUTPUT_FORMAT?=
# KCL_MESHPOLICIES_SELECTOR?=
# KCL_MESHPOLICIES_SET_NAME?=
# KCL_MESHPOLICIES_SORTBY?=

# Derived parameters
KCL_MESHPOLICY_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_MESHPOLICY_MANIFEST_FILEPATH?= $(KCL_MESHPOLICY_MANIFEST_DIRPATH)$(KCL_MESHPOLICY_MANIFEST_FILENAME)

# Option parameters
__KCL_FILENAME__MESHPOLICY= $(if $(KCL_MESHPOLICY_MANIFEST_FILEPATH),--filename $(KCL_MESHPOLICY_MANIFEST_FILEPATH))
__KCL_LABELS__MESHPOLICY= $(if $(KCL_MESHPOLICY_LABELS_KEYVALUES),--labels $(KCL_MESHPOLICY_LABELS_KEYVALUES))
__KCL_OUTPUT__MESHPOLICY= $(if $(KCL_MESHPOLICY_OUTPUT_FORMAT),--output $(KCL_MESHPOLICY_OUTPUT_FORMAT))
__KCL_OUTPUT__MESHPOLICIES= $(if $(KCL_MESHPOLICIES_OUTPUT_FORMAT),--output $(KCL_MESHPOLICIES_OUTPUT_FORMAT))
__KCL_SELECTOR__MESHPOLICIES= $(if $(KCL_MESHPOLICIES_SELECTOR),--selector=$(KCL_MESHPOLICIES_SELECTOR))
__KCL_SORT_BY__MESHPOLICIES= $(if $(KCL_MESHPOLICIES_SORTBY),--sort-by=$(KCL_MESHPOLICIES_SORTBY))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Istio::MeshPolicy ($(_KUBECTL_ISTIO_MESHPOLICY_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Istio::MeshPolicy ($(_KUBECTL_ISTIO_MESHPOLICY_MK_VERSION)) parameters:'
	@echo '    KCL_MESHPOLICY_LABELS_KEYVALUES=$(KCL_MESHPOLICY_LABELS_KEYVALUES)'
	@echo '    KCL_MESHPOLICY_MANIFEST_DIRPATH=$(KCL_MESHPOLICY_MANIFEST_DIRPATH)'
	@echo '    KCL_MESHPOLICY_MANIFEST_FILENAME=$(KCL_MESHPOLICY_MANIFEST_FILENAME)'
	@echo '    KCL_MESHPOLICY_MANIFEST_FILEPATH=$(KCL_MESHPOLICY_MANIFEST_FILEPATH)'
	@echo '    KCL_MESHPOLICY_NAME=$(KCL_MESHPOLICY_NAME)'
	@echo '    KCL_MESHPOLICIES_OUTPUT_FORMAT=$(KCL_MESHPOLICIES_OUTPUT_FORMAT)'
	@echo '    KCL_MESHPOLICIES_SELECTOR=$(KCL_MESHPOLICIES_SELECTOR)'
	@echo '    KCL_MESHPOLICIES_SET_NAME=$(KCL_MESHPOLICIES_SET_NAME)'
	@echo '    KCL_MESHPOLICIES_SORTBY=$(KCL_MESHPOLICIES_SORTBY)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Istio::MeshPolicy ($(_KUBECTL_ISTIO_MESHPOLICY_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_meshpolicy                - Annotate a mesh-policy'
	@echo '    _kcl_apply_meshpolicy                   - Apply a mesh-policy'
	@echo '    _kcl_create_meshpolicy                  - Create a mesh-policy'
	@echo '    _kcl_delete_meshpolicy                  - Delete a mesh-policy'
	@echo '    _kcl_label_meshpolicy                   - Label a mesh-policy'
	@echo '    _kcl_list_meshpolicies                  - List all mesh-policies'
	@echo '    _kcl_list_meshpolicies_set              - List a set of mesh-policies'
	@echo '    _kcl_show_meshpolicy                    - Show everything related to a mesh-policy'
	@echo '    _kcl_show_meshpolicy_description        - Show description of a mesh-policy'
	@echo '    _kcl_show_meshpolicy_object             - Show object of a mesh-policy'
	@echo '    _kcl_show_meshpolicy_state              - Show state of a mesh-policy'
	@echo '    _kcl_unapply_meshpolicy                 - Unapply a manifest for a mesh-policy'
	@echo '    _kcl_unlabel_meshpolicy                 - Unlabel a mesh-policy'
	@echo '    _kcl_update_meshpolicy                  - Update a mesh-policy'
	@echo '    _kcl_watch_meshpolicies                 - Watch mesh-policies'
	@echo '    _kcl_watch_meshpolicies_set             - Watch a set of mesh-policies'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_meshpolicy:

_kcl_apply_meshpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for mesh-policy "$(KCL_MESHPOLICY_NAME)" ...'; $(NORMAL)
	cat $(KCL_MESHPOLICY_MANIFEST_FILEPATH)
	$(KUBECTL) apply $(__KCL_FILENAME__MESHPOLICY)

_kcl_create_meshpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Creating mesh-policy "$(KCL_MESHPOLICY_NAME)" ...'; $(NORMAL)

_kcl_delete_meshpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Deleting mesh-policy "$(KCL_MESHPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete meshpolicy $(KCL_MESHPOLICY_NAME)

_kcl_edit_meshpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Editing mesh-policy "$(KCL_MESHPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit meshpolicy $(KCL_MESHPOLICY_NAME)

_kcl_explain_meshpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Explaining mesh-policy object ...'; $(NORMAL)
	$(KUBECTL) explain meshpolicy

_kcl_list_meshpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL mesh-policies ...'; $(NORMAL)
	$(KUBECTL) get meshpolicies --all-namespaces=true $(__KCL_OUTPUT_MESHPOLICIES) $(_X__KCL_SELECTOR__MESHPOLICIES) $(__KCL_SORT_BY__MESHPOLICIES)

_kcl_list_meshpolicies_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing mesh-policies-set "$(KCL_MESHPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Mesh-policies are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get meshpolicies --all-namespaces=false $(__KCL_OUTPUT__MESHPOLICIES) $(__KCL_SELECTOR__MESHPOLICIES) $(__KCL_SORT_BY__MESHPOLICIES)

_KCL_SHOW_MESHPOLICY_TARGETS?= _kcl_show_meshpolicy_object _kcl_show_meshpolicy_state _kcl_show_meshpolicy_description
_kcl_show_meshpolicy: $(_KCL_SHOW_MESHPOLICY_TARGETS)

_kcl_show_meshpolicy_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description mesh-policy "$(KCL_MESHPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe meshpolicy $(KCL_MESHPOLICY_NAME)

_kcl_show_meshpolicy_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of mesh-policy "$(KCL_MESHPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get meshpolicy $(_X__KCL_OUTPUT__MESHPOLICY) -o yaml $(KCL_MESHPOLICY_NAME)

_kcl_show_meshpolicy_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of mesh-policy "$(KCL_MESHPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get meshpolicy $(_X__KCL_OUTPUT__MESHPOLICY) $(KCL_MESHPOLICY_NAME)

_kcl_unapply_meshpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for mesh-policy "$(KCL_MESHPOLICY_NAME)" ...'; $(NORMAL)
	cat $(KCL_MESHPOLICY_MANIFEST_FILEPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__MESHPOLICY)

_kcl_unlabel_meshpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Un-labling mesh-policy "$(KCL_MESHPOLICY_NAME)" ...'; $(NORMAL)

_kcl_update_meshpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Updating mesh-policy "$(KCL_MESHPOLICY_NAME)" ...'; $(NORMAL)

_kcl_watch_meshpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL mesh-policies ...'; $(NORMAL)
	$(KUBECTL) get meshpolicies --all-namespaces=true --watch 

_kcl_watch_meshpolicies_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching mesh-policies-set "$(KCL_MESHPOLICIES_SET_NAME)" ...'; $(NORMAL)
