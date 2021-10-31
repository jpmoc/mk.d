_KUBECTL_CALICO_GLOBALNETWORKPOLICY_MK_VERSION= $(_KUBECTL_CALICO_MK_VERSION)

# KCL_GLOBALNETWORKPOLICY_IMAGE_CNAME?= datawire/qotm:1.3
# KCL_GLOBALNETWORKPOLICY_KUSTOMIZATION_DIRPATH?= ./
# KCL_GLOBALNETWORKPOLICY_LABELS_KEYVALUES?=
# KCL_GLOBALNETWORKPOLICY_NAME?= hello
# KCL_GLOBALNETWORKPOLICY_NAMESPACE_NAME?= default
# KCL_GLOBALNETWORKPOLICY_OUTPUT_FORMAT?=
# KCL_GLOBALNETWORKPOLICY_SELECTOR?= app=global-registration-service
# KCL_GLOBALNETWORKPOLICIES_CLUSTER_NAME?= my-cluster-name
# KCL_GLOBALNETWORKPOLICIES_FIELDSELECTOR?= metadata.name=my-global-network-policy
# KCL_GLOBALNETWORKPOLICIES_MANIFEST_DIRPATH?= ./in/
# KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILENAME?= global-network-policy-manifest.yaml
# KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILEPATH?= ./in/global-network-policy-manifest.yaml
# KCL_GLOBALNETWORKPOLICIES_MANIFEST_URL?= http://
# KCL_GLOBALNETWORKPOLICIES_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_GLOBALNETWORKPOLICIES_NAMESPACE_NAME?= default
# KCL_GLOBALNETWORKPOLICIES_OUTPUT_FORMAT?= jsonpath='{.items[0].metadata.name}'
# KCL_GLOBALNETWORKPOLICIES_SELECTOR?= run=ecr-read-only--renew-token
# KCL_GLOBALNETWORKPOLICIES_SET_NAME?= my-globalnetworkpolicies-set
# KCL_GLOBALNETWORKPOLICIES_SORT_BY?= status.completionTime

# Derived parameters
KCL_GLOBALNETWORKPOLICY_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_GLOBALNETWORKPOLICY_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_GLOBALNETWORKPOLICY_NAMES?= $(KCL_GLOBALNETWORKPOLICY_NAME)
KCL_GLOBALNETWORKPOLICY_OUTPUT_FORMAT?= $(KCL_OUTPUT_FORMAT)
KCL_GLOBALNETWORKPOLICIES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILEPATH?= $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_DIRPATH)$(KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILENAME)
KCL_GLOBALNETWORKPOLICIES_NAMESPACE_NAME?= $(KCL_GLOBALNETWORKPOLICY_NAMESPACE_NAME)
KCL_GLOBALNETWORKPOLICIES_SET_NAME?= $(KCL_GLOBALNETWORKPOLICIES_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__GLOBALNETWORKPOLICIES+= $(if $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILEPATH),--filename $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILEPATH))
__KCL_FILENAME__GLOBALNETWORKPOLICIES+= $(if $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_URL),--filename $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_URL))
__KCL_FILENAME__GLOBALNETWORKPOLICIES+= $(if $(KCL_GLOBALNETWORKPOLICIES_MANIFESTS_DIRPATH),--filename $(KCL_GLOBALNETWORKPOLICIES_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__GLOBALNETWORKPOLICY= $(if $(KCL_GLOBALNETWORKPOLICY_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_GLOBALNETWORKPOLICY_KUSTOMIZATION_DIRPATH))
__KCL_LABELS__GLOBALNETWORKPOLICY= $(if $(KCL_GLOBALNETWORKPOLICY_LABELS_KEYVALUES),--labels $(KCL_GLOBALNETWORKPOLICY_LABELS_KEYVALUES))
__KCL_NAME__GLOBALNETWORKPOLICY= $(if $(KCL_GLOBALNETWORKPOLICY_SERVICE_NAME),--name $(KCL_GLOBALNETWORKPOLICY_SERVICE_NAME))
__KCL_NAMESPACE__GLOBALNETWORKPOLICY= $(if $(KCL_GLOBALNETWORKPOLICY_NAMESPACE_NAME),--namespace $(KCL_GLOBALNETWORKPOLICY_NAMESPACE_NAME))
__KCL_NAMESPACE__GLOBALNETWORKPOLICIES= $(if $(KCL_GLOBALNETWORKPOLICIES_NAMESPACE_NAME),--namespace $(KCL_GLOBALNETWORKPOLICIES_NAMESPACE_NAME))
__KCL_OUTPUT__GLOBALNETWORKPOLICY= $(if $(KCL_GLOBALNETWORKPOLICY_OUTPUT_FORMAT),--output $(KCL_GLOBALNETWORKPOLICY_OUTPUT_FORMAT))
__KCL_OUTPUT__GLOBALNETWORKPOLICIES= $(if $(KCL_GLOBALNETWORKPOLICIES_OUTPUT_FORMAT),--output $(KCL_GLOBALNETWORKPOLICIES_OUTPUT_FORMAT))
__KCL_SELECTOR__GLOBALNETWORKPOLICIES= $(if $(KCL_GLOBALNETWORKPOLICIES_SELECTOR),--selector=$(KCL_GLOBALNETWORKPOLICIES_SELECTOR))
__KCL_SORT_BY__GLOBALNETWORKPOLICIES= $(if $(KCL_GLOBALNETWORKPOLICIES_SORT_BY),--sort-by=$(KCL_GLOBALNETWORKPOLICIES_SORT_BY))

# Pipe parameters
|_KCL_KUSTOMIZE_GLOBALNETWORKPOLICY?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Calico:;GlobalNetworkPolicy ($(_KUBECTL_CALICO_GLOBALNETWORKPOLICY_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Calico::GlobalNetworkPolicy ($(_KUBECTL_CALICO_GLOBALNETWORKPOLICY_MK_VERSION)) parameters:'
	@echo '    KCL_GLOBALNETWORKPOLICY_KUSTOMIZATION_DIRPATH=$(KCL_GLOBALNETWORKPOLICY_KUSTOMIZATION_DIRPATH)'
	@echo '    KCL_GLOBALNETWORKPOLICY_LABELS_KEYS=$(KCL_GLOBALNETWORKPOLICY_LABELS_KEYS)'
	@echo '    KCL_GLOBALNETWORKPOLICY_LABELS_KEYVALUES=$(KCL_GLOBALNETWORKPOLICY_LABELS_KEYVALUES)'
	@echo '    KCL_GLOBALNETWORKPOLICY_NAME=$(KCL_GLOBALNETWORKPOLICY_NAME)'
	@echo '    KCL_GLOBALNETWORKPOLICY_NAMESPACE_NAME=$(KCL_GLOBALNETWORKPOLICY_NAMESPACE_NAME)'
	@echo '    KCL_GLOBALNETWORKPOLICY_OUTPUT_FORMAT=$(KCL_GLOBALNETWORKPOLICY_OUTPUT_FORMAT)'
	@echo '    KCL_GLOBALNETWORKPOLICY_SELECTOR=$(KCL_GLOBALNETWORKPOLICY_SELECTOR)'
	@echo '    KCL_GLOBALNETWORKPOLICIES_FIELDSELECTOR=$(KCL_GLOBALNETWORKPOLICIES_FIELDSELECTOR)'
	@echo '    KCL_GLOBALNETWORKPOLICIES_MANIFEST_DIRPATH=$(KCL_GLOBALNETWORKPOLICIES_MANIFEST_DIRPATH)'
	@echo '    KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILENAME=$(KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILENAME)'
	@echo '    KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILEPATH=$(KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILEPATH)'
	@echo '    KCL_GLOBALNETWORKPOLICIES_MANIFEST_URL=$(KCL_GLOBALNETWORKPOLICIES_MANIFEST_URL)'
	@echo '    KCL_GLOBALNETWORKPOLICIES_MANIFESTS_DIRPATH=$(KCL_GLOBALNETWORKPOLICIES_MANIFESTS_DIRPATH)'
	@echo '    KCL_GLOBALNETWORKPOLICIES_NAMESPACE_NAME=$(KCL_GLOBALNETWORKPOLICIES_NAMESPACE_NAME)'
	@echo '    KCL_GLOBALNETWORKPOLICIES_OUTPUT_FORMAT=$(KCL_GLOBALNETWORKPOLICIES_OUTPUT_FORMAT)'
	@echo '    KCL_GLOBALNETWORKPOLICIES_SELECTOR=$(KCL_GLOBALNETWORKPOLICIES_SELECTOR)'
	@echo '    KCL_GLOBALNETWORKPOLICIES_SET_NAME=$(KCL_GLOBALNETWORKPOLICIES_SET_NAME)'
	@echo '    KCL_GLOBALNETWORKPOLICIES_SORT_BY=$(KCL_GLOBALNETWORKPOLICIES_SORT_BY)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Calico::GlobalNetworkPolicy ($(_KUBECTL_CALICO_GLOBALNETWORKPOLICY_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_globalnetworkpolicy                - Annotate a global-network-policy'
	@echo '    _kcl_apply_globalnetworkpolicies                 - Apply manifest for one-or-more global-network-policies'
	@echo '    _kcl_create_globalnetworkpolicy                  - Create a new global-network-policy'
	@echo '    _kcl_delete_globalnetworkpolicy                  - Delete an existing global-network-policy'
	@echo '    _kcl_diff_globalnetworkpolicies                  - Diff a manifest with one-or-more existing global-network-policies'
	@echo '    _kcl_edit_globalnetworkpolicy                    - Edit a global-network-policy'
	@echo '    _kcl_explain_globalnetworkpolicy                 - Explain the global-network-policy object'
	@echo '    _kcl_kustomize_globalnetworkpolicy               - Kustomize one-or-more global-network-policies'
	@echo '    _kcl_label_globalnetworkpolicy                   - Label a global-network-policy'
	@echo '    _kcl_list_globalnetworkpolicies                  - List all global-network-policies'
	@echo '    _kcl_list_globalnetworkpolicies_set              - List a set of global-network-policies'
	@echo '    _kcl_show_globalnetworkpolicy                    - Show everything related to a global-network-policy'
	@echo '    _kcl_show_globalnetworkpolicy_description        - Show the description of a global-network-policy'
	@echo '    _kcl_show_globalnetworkpolicy_object             - Show the object of a global-network-policy'
	@echo '    _kcl_show_globalnetworkpolicy_state              - Show state of a global-network-policy'
	@echo '    _kcl_unapply_globalnetworkpolicies               - Un-apply manifest for one-or-more global-network-policies'
	@echo '    _kcl_unlabel_globalnetworkpolicy                 - Un-label manifest for a global-network-policy'
	@echo '    _kcl_update_globalnetworkpolicy                  - Update a global-network-policy'
	@echo '    _kcl_watch_globalnetworkpolicies                 - Watching global-network-policies'
	@echo '    _kcl_watch_globalnetworkpolicies_set             - Watching a set of global-network-policies'
	@echo '    _kcl_write_globalnetworkpolicies                 - Write manifest for one-or-more global-network-policies'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_globalnetworkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Annotating global-network-policy "$(KCL_GLOBALNETWORKPOLICY_NAME)" ...'; $(NORMAL)

_kcl_apply_globalnetworkpolicy: _kcl_apply_globalnetworkpolicies
_kcl_apply_globalnetworkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more global-network-policies ...'; $(NORMAL)
	$(if $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILEPATH), cat $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILEPATH); echo)
	$(if $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_URL), curl -L $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_URL); echo )
	$(if $(KCL_GLOBALNETWORKPOLICIES_MANIFESTS_DIRPATH), ls -al $(KCL_GLOBALNETWORKPOLICIES_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__GLOBALNETWORKPOLICIES) $(__KCL_NAMESPACE__GLOBALNETWORKPOLICIES)

_kcl_create_globalnetworkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Creating global-network-policy "$(KCL_GLOBALNETWORKPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) run $(__KCL_IMAGE__GLOBALNETWORKPOLICY) $(__KCL_EXPOSE__GLOBALNETWORKPOLICY) $(__KCL_LABELS__GLOBALNETWORKPOLICY) $(__KCL_NAMESPACE__GLOBALNETWORKPOLICY) $(__KCL_PORT__GLOBALNETWORKPOLICY) $(__KCL_REPLICAS__GLOBALNETWORKPOLICY) $(__KCL_RESTART__GLOBALNETWORKPOLICY) $(__KCL_SERVICEACCOUNT__GLOBALNETWORKPOLICY) $(KCL_GLOBALNETWORKPOLICY_NAME)

_kcl_delete_globalnetworkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Deleting global-network-policy "$(KCL_GLOBALNETWORKPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete globalnetworkpolicy $(__KCL_NAMESPACE__GLOBALNETWORKPOLICY) $(KCL_GLOBALNETWORKPOLICY_NAME)

_kcl_diff_globalnetworkpolicy: _kcl_diff_globalnetworkpolicies
_kcl_diff_globalnetworkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster state with manifest for one-or-more global-network-policies ...'; $(NORMAL)
	# cat $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILEPATH)
	# curl -L $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_URL)
	# ls -al $(KCL_GLOBALNETWORKPOLICIES_MANIFESTS_DIRPATH)
	$(KUBECTL) diff $(__KCL_FILENAME__GLOBALNETWORKPOLICIES) $(__KCL_NAMESPACE__GLOBALNETWORKPOLICIES)

_kcl_edit_globalnetworkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Editing global-network-policy "$(KCL_GLOBALNETWORKPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit globalnetworkpolicy $(__KCL_NAMESPACE__GLOBALNETWORKPOLICY) $(KCL_GLOBALNETWORKPOLICY_NAME)

_kcl_explain_globalnetworkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Explaining global-network-policy object ...'; $(NORMAL)
	$(KUBECTL) explain globalnetworkpolicy

_kcl_kustomize_globalnetworkpolicy: _kcl_kustomize_globalnetworkpolicies
_kcl_kustomize_globalnetworkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more global-network-policies ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_GLOBALNETWORKPOLICY_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_GLOBALNETWORKPOLICY)

_kcl_label_globalnetworkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Labeling global-network-policy "$(KCL_GLOBALNETWORKPOLICY_NAME)" ...'; $(NORMAL)

_kcl_list_globalnetworkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL global-network-policies ...'; $(NORMAL)
	$(KUBECTL) get globalnetworkpolicies --all-namespaces=true $(_X__KCL_NAMESPACE__GLOBALNETWORKPOLICIES) $(__KCL_OUTPUT_GLOBALNETWORKPOLICIES) $(_X__KCL_SELECTOR__GLOBALNETWORKPOLICIES) $(__KCL_SORT_BY__GLOBALNETWORKPOLICIES)

_kcl_list_globalnetworkpolicies_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing global-network-policies-set "$(KCL_GLOBALNETWORKPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Global-network-policies are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get globalnetworkpolicies --all-namespaces=false $(__KCL_NAMESPACE__GLOBALNETWORKPOLICIES) $(__KCL_OUTPUT__GLOBALNETWORKPOLICIES) $(__KCL_SELECTOR__GLOBALNETWORKPOLICIES) $(__KCL_SORT_BY__GLOBALNETWORKPOLICIES)

_kcl_show_globalnetworkpolicy: _kcl_show_globalnetworkpolicy_object _kcl_show_globalnetworkpolicy_state _kcl_show_globalnetworkpolicy_description

_kcl_show_globalnetworkpolicy_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description global-network-policy "$(KCL_GLOBALNETWORKPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe globalnetworkpolicy $(__KCL_NAMESPACE__GLOBALNETWORKPOLICY) $(KCL_GLOBALNETWORKPOLICY_NAME)

_kcl_show_globalnetworkpolicy_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of global-network-policy "$(KCL_GLOBALNETWORKPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get globalnetworkpolicy $(__KCL_NAMESPACE__GLOBALNETWORKPOLICY) $(_X__KCL_OUTPUT__GLOBALNETWORKPOLICY) --output yaml $(KCL_GLOBALNETWORKPOLICY_NAME)

_kcl_show_globalnetworkpolicy_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of global-network-policy "$(KCL_GLOBALNETWORKPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get globalnetworkpolicy $(__KCL_NAMESPACE__GLOBALNETWORKPOLICY) $(KCL_GLOBALNETWORKPOLICY_NAME) 

_kcl_unapply_globalnetworkpolicy: _kcl_unapply_globalnetworkpolicies
_kcl_unapply_globalnetworkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more global-network-policies ...'; $(NORMAL)
	# cat $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILEPATH)
	# curl -L $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_URL)
	# ls -al $(KCL_GLOBALNETWORKPOLICIES_MANIFESTS_DIRPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__GLOBALNETWORKPOLICIES) $(__KCL_NAMESPACE__GLOBALNETWORKPOLICIES)

_kcl_unlabel_globalnetworkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Removing labels from global-network-policy "$(KCL_GLOBALNETWORKPOLICY_NAME)" ...'; $(NORMAL)

_kcl_update_globalnetworkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Updating global-network-policy "$(KCL_GLOBALNETWORKPOLICY_NAME)" ...'; $(NORMAL)

_kcl_watch_globalnetworkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Watching global-network-policies ...'; $(NORMAL)
	$(KUBECTL) get globalnetworkpolicies --all-namespaces=true --watch 

_kcl_watch_globalnetworkpolicies_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching global-network-policies-set "$(KCL_GLOBALNETWORKPOLICIES_SET_NAME)" ...'; $(NORMAL)

_kcl_write_globalnetworkpolicy: _kcl_write_globalnetworkpolicies
_kcl_write_globalnetworkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more global-network-policies ...'; $(NORMAL)
	$(WRITER) $(KCL_GLOBALNETWORKPOLICIES_MANIFEST_FILEPATH)
