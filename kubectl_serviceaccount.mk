_KUBECTL_SERVICEACCOUNT_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_SERVICEACCOUNT_ANNOTATION_KEY?= key1
# KCL_SERVICEACCOUNT_ANNOTATION_VALUE?= value1
# KCL_SERVICEACCOUNT_ANNOTATIONS_KEYS?= key1 ...
# KCL_SERVICEACCOUNT_ANNOTATIONS_KEYVALUES?= key1=value1 ...
# KCL_SERVICEACCOUNT_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_SERVICEACCOUNT_NAME?= 
# KCL_SERVICEACCOUNT_NAMESPACE_NAME?= kube-system
# KCL_SERVICEACCOUNT_PATCH_CONTENT?= '{\"imagePullSecrets\": [{\"name\": \"myregistrykey\"}]}'
# KCL_SERVICEACCOUNT_SECRET_NAME?= my-vault-token-gnvjc
# KCL_SERVICEACCOUNTS_MANIFEST_DIRPATH?= ./in/
# KCL_SERVICEACCOUNTS_MANIFEST_FILENAME?= manifest.yaml 
# KCL_SERVICEACCOUNTS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_SERVICEACCOUNTS_MANIFEST_STDINFLAG?= false
# KCL_SERVICEACCOUNTS_MANIFEST_URL?= http://...
# KCL_SERVICEACCOUNTS_MANIFESTS_DIRPATH?= ./in/
# KCL_SERVICEACCOUNTS_NAMESPACE_NAME?= kube-system
# KCL_SERVICEACCOUNTS_SET_NAME?= my-serviceaccounts-set

# Derived parameters
KCL_SERVICEACCOUNT_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_SERVICEACCOUNTS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SERVICEACCOUNTS_MANIFEST_FILEPATH?= $(if $(KCL_SERVICEACCOUNTS_MANIFEST_FILENAME),$(KCL_SERVICEACCOUNTS_MANIFEST_DIRPATH)$(KCL_SERVICEACCOUNTS_MANIFEST_FILENAME))
KCL_SERVICEACCOUNTS_NAMESPACE_NAME?= $(KCL_SERVICEACCOUNT_NAMESPACE_NAME)
KCL_SERVICEACCOUNTS_SET_NAME?= $(KCL_SERVICEACCOUNTS_NAMESPACE_NAME)

# Option parameters
__KCL_AS__SERVICEACCOUNT?= --as system:serviceaccount:$(KCL_SERVICEACCOUNT_NAMESPACE_NAME):$(KCL_SERVICEACCOUNT_NAME)
__KCL_FILENAME__SERVICEACCOUNTS+= $(if $(KCL_SERVICEACCOUNTS_MANIFEST_FILEPATH),--filename $(KCL_SERVICEACCOUNTS_MANIFEST_FILEPATH))
__KCL_FILENAME__SERVICEACCOUNTS+= $(if $(filter true,$(KCL_SERVICEACCOUNTS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__SERVICEACCOUNTS+= $(if $(KCL_SERVICEACCOUNTS_MANIFEST_URL),--filename $(KCL_SERVICEACCOUNTS_MANIFEST_URL))
__KCL_FILENAME__SERVICEACCOUNTS+= $(if $(KCL_SERVICEACCOUNTS_MANIFESTS_DIRPATH),--filename $(KCL_SERVICEACCOUNTS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__SERVICEACCOUNT?= $(if $(KCL_SERVICEACCOUNT_NAMESPACE_NAME),--namespace $(KCL_SERVICEACCOUNT_NAMESPACE_NAME))
__KCL_NAMESPACE__SERVICEACCOUNTS?= $(if $(KCL_SERVICEACCOUNTS_NAMESPACE_NAME),--namespace $(KCL_SERVICEACCOUNTS_NAMESPACE_NAME))
__KCL_PATCH__SERVICEACCOUNT?= $(if $(KCL_SERVICEACCOUNT_PATCH_CONTENT),--patch $(KCL_SERVICEACCOUNT_PATCH_CONTENT))

# Pipes and UI parameters
_KCL_APPLY_SERVICEACCOUNTS_|?= #
_KCL_DIFF_SERVICEACCOUNTS_|?= $(_KCL_APPLY_SERVICEACCOUNTS_|)
_KCL_UNAPPLY_SERVICEACCOUNTS_|?= $(_KCL_APPLY_SERVICEACCOUNTS_|)
|_KCL_SHOW_SERVICEACCOUNT_RBACRULES?=

#--- MACROS
_kcl_get_serviceaccount_annotation_value= $(call _kcl_get_serviceaccount_annotation_value_K, $(KCL_SERVICEACCOUNT_ANNOTATION_KEY))
_kcl_get_serviceaccount_annotation_value_K= $(call _kcl_get_serviceaccount_annotation_value_KN, $(1), $(KCL_SERVICEACCOUNT_NAME))
_kcl_get_serviceaccount_annotation_value_KN= $(call _kcl_get_serviceaccount_annotation_value_KNN, $(1), $(2), $(KCL_SERVICEACCOUNT_NAMESPACE_NAME))
_kcl_get_serviceaccount_annotation_value_KNN= $(shell $(KUBECTL) get serviceaccount --namespace $(3) $(2) --output jsonpath='{.metadata.annotations.$(strip $(1))}')

_kcl_get_serviceaccount_secret_name= $(call _kcl_get_serviceaccount_secret_name_N, $(KCL_SERVICEACCOUNT_NAME))
_kcl_get_serviceaccount_secret_name_N= $(call _kcl_get_serviceaccount_secret_name_NN, $(1), $(KCL_SERVICEACCOUNT_NAMESPACE_NAME))
_kcl_get_serviceaccount_secret_name_NN= $(shell $(KUBECTL) get serviceaccount --namespace $(2) $(1) --output jsonpath="{.secrets[*]['name']}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::ServiceAccount ($(_KUBECTL_SERVICEACCOUNT_MK_VERSION)) macros:'
	@echo '    _kcl_get_serviceaccount_annotation_value_{|K|KN|KNN}  - Get the value of a service-account annotation (Key,Name,Namespace)'
	@echo '    _kcl_get_serviceaccount_secret_name_{|N|NN}           - Get the name of a service-account secret (Name,Namespace)'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::ServiceAccount ($(_KUBECTL_SERVICEACCOUNT_MK_VERSION)) parameters:'
	@echo '    KCL_SERVICEACCOUNT_ANNOTATION_KEY=$(KCL_SERVICEACCOUNT_ANNOTATION_KEY)'
	@echo '    KCL_SERVICEACCOUNT_ANNOTATION_VALUE=$(KCL_SERVICEACCOUNT_ANNOTATION_VALUE)'
	@echo '    KCL_SERVICEACCOUNT_ANNOTATIONS_KEYS=$(KCL_SERVICEACCOUNT_ANNOTATIONS_KEYS)'
	@echo '    KCL_SERVICEACCOUNT_ANNOTATIONS_KEYVALUES=$(KCL_SERVICEACCOUNT_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_SERVICEACCOUNT_LABELS_KEYVALUES=$(KCL_SERVICEACCOUNT_LABELS_KEYVALUES)'
	@echo '    KCL_SERVICEACCOUNT_NAME=$(KCL_SERVICEACCOUNT_NAME)'
	@echo '    KCL_SERVICEACCOUNT_NAMESPACE_NAME=$(KCL_SERVICEACCOUNT_NAMESPACE_NAME)'
	@echo '    KCL_SERVICEACCOUNT_SECRET_NAME=$(KCL_SERVICEACCOUNT_SECRET_NAME)'
	@echo '    KCL_SERVICEACCOUNTS_MANIFEST_DIRPATH=$(KCL_SERVICEACCOUNTS_MANIFEST_DIRPATH)'
	@echo '    KCL_SERVICEACCOUNTS_MANIFEST_FILENAME=$(KCL_SERVICEACCOUNTS_MANIFEST_FILENAME)'
	@echo '    KCL_SERVICEACCOUNTS_MANIFEST_FILEPATH=$(KCL_SERVICEACCOUNTS_MANIFEST_FILEPATH)'
	@echo '    KCL_SERVICEACCOUNTS_MANIFEST_STDINFLAG=$(KCL_SERVICEACCOUNTS_MANIFEST_STDINFLAG)'
	@echo '    KCL_SERVICEACCOUNTS_MANIFEST_URL=$(KCL_SERVICEACCOUNTS_MANIFEST_URL)'
	@echo '    KCL_SERVICEACCOUNTS_MANIFESTS_DIRPATH=$(KCL_SERVICEACCOUNTS_MANIFESTS_DIRPATH)'
	@echo '    KCL_SERVICEACCOUNTS_NAMESPACE_NAME=$(KCL_SERVICEACCOUNTS_NAMESPACE_NAME)'
	@echo '    KCL_SERVICEACCOUNTS_SET_NAME=$(KCL_SERVICEACCOUNTS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::ServiceAccount ($(_KUBECTL_SERVICEACCOUNT_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_serviceaccount                    - Annotate a service-account'
	@echo '    _kcl_apply_serviceaccount                       - Apply a manifest for one-or-more service-accounts'
	@echo '    _kcl_check_serviceaccount                       - Check everything related to a service-account'
	@echo '    _kcl_check_serviceaccount_apicall               - Check a given API call by a service-account'
	@echo '    _kcl_create_serviceaccount                      - Create a new service-account'
	@echo '    _kcl_delete_serviceaccount                      - Delete an existing service-account'
	@echo '    _kcl_diff_serviceaccount                        - Diff a manifest for one-or-more service-accounts'
	@echo '    _kcl_edit_serviceaccount                        - Edit a service-account'
	@echo '    _kcl_explain_serviceaccount                     - Explain the service-account object'
	@echo '    _kcl_label_serviceaccount                       - Label a service-accounts'
	@echo '    _kcl_patch_serviceaccount                       - Patch a service-account'
	@echo '    _kcl_show_serviceaccount                        - Show everything related to a service-account'
	@echo '    _kcl_show_serviceaccount_clusterrolebindings    - Show cluster-role-bindings referring to a service-account'
	@echo '    _kcl_show_serviceaccount_description            - Show description of a service-account'
	@echo '    _kcl_show_serviceaccount_pods                   - Show pods using a service-account'
	@echo '    _kcl_show_serviceaccount_rights                 - Show rights of a service-account'
	@echo '    _kcl_show_serviceaccount_secrets                - Show the secret of a service-account'
	@echo '    _kcl_unapply_serviceaccount                     - Un-apply a manifest for one-or-more service-accounts'
	@echo '    _kcl_unlabel_serviceaccount                     - Un-label a service-accounts'
	@echo '    _kcl_view_serviceaccounts                       - View service-accounts'
	@echo '    _kcl_view_serviceaccounts_set                   - View a set of service-accounts'
	@echo '    _kcl_watch_serviceaccounts                      - Watch all service-accounts'
	@echo '    _kcl_watch_serviceaccounts_set                  - Watch a set of service-accounts'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_serviceaccount:
	@$(INFO) '$(KCL_UI_LABEL)Annotating service-account "$(KCL_SERVICEACCOUNT_NAME)"  ...'; $(NORMAL)

_kcl_apply_serviceaccount: _kcl_apply_serviceaccounts
_kcl_apply_serviceaccounts:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more service-accounts ...'; $(NORMAL)
	$(if $(KCL_SERVICEACCOUNTS_MANIFEST_FILEPATH),cat $(KCL_SERVICEACCOUNTS_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_SERVICEACCOUNTS_MANIFEST_URL)),$(_KCL_APPLY_SERVICEACCOUNTS_|)cat)
	$(if $(KCL_SERVICEACCOUNTS_MANIFEST_URL),curl -L $(KCL_SERVICEACCOUNTS_MANIFEST_URL))
	$(if $(KCL_SERVICEACCOUNTS_MANIFESTS_DIRPATH),ls -al $(KCL_SERVICEACCOUNTS_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_SERVICEACCOUNTS_|)$(KUBECT) apply $(__KCL_FILENAME__SERVICEACCOUNTS) $(__KCL_NAMESPACE__SERVICEACCOUNTS)

_kcl_check_serviceaccount: _kcl_check_serviceaccount_role

_kcl_check_serviceaccount_role:
	@$(INFO) '$(KCL_UI_LABEL)Checking role for service-account "$(KCL_SERVICEACCOUNT_NAME)"  ...'; $(NORMAL)
	# More @ https://medium.com/better-programming/k8s-tips-using-a-serviceaccount-801c433d0023
	# curl -H “Authorization: Bearer $$TOKEN” https://kubernetes/api/v1/namespaces/default/pods/ --insecure

_kcl_create_serviceaccount:
	@$(INFO) '$(KCL_UI_LABEL)Creating service-account "$(KCL_SERVICEACCOUNT_NAME)"  ...'; $(NORMAL)
	$(KUBECTL) create serviceaccount $(__KCL_NAMESPACE__SERVICEACCOUNT) $(KCL_SERVICEACCOUNT_NAME)

_kcl_delete_serviceaccount:
	@$(INFO) '$(KCL_UI_LABEL)Deleting service-account "$(KCL_SERVICEACCOUNT_NAME)"  ...'; $(NORMAL)
	$(KUBECTL) delete serviceaccount $(__KCL_NAMESPACE__SERVICEACCOUNT) $(KCL_SERVICEACCOUNT_NAME)

_kcl_diff_serviceaccount: _kcl_diff_serviceaccounts
_kcl_diff_serviceaccounts:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more service-accounts ...'; $(NORMAL)
	@$(WARN) 'This operation submits the manifest to the cluster to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_SERVICEACCOUNTS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_SERVICEACCOUNTS_|)cat
	# curl $(KCL_SERVICEACCOUNTS_MANIFEST_URL)
	# ls -al $(KCL_SERVICEACCOUNTS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_SERVICEACCOUNTS_|)$(KUBECTL) diff $(__KCL_FILENAME__SERVICEACCOUNTS) $(__KCL_NAMESPACE__SERVICEACCOUNTS)

_kcl_edit_serviceaccount:
	@$(INFO) '$(KCL_UI_LABEL)Editing service-account "$(KCL_SERVICEACCOUNT_NAME)"  ...'; $(NORMAL)
	$(KUBECTL) edit serviceaccount $(__KCL_NAMESPACE__SERVICEACCOUNT) $(KCL_SERVICEACCOUNT_NAME)

_kcl_explain_serviceaccount:
	@$(INFO) '$(KCL_UI_LABEL)Explaining service-account object ...'; $(NORMAL)
	$(KUBECTL) explain serviceaccount

_kcl_label_serviceaccount:
	@$(INFO) '$(KCL_UI_LABEL)Labelling service-account "$(KCL_SERVICEACCOUNT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label serviceaccount $(__KCL_NAMESPACE__SERVICEACCOUNT) $(KCL_SERVICEACCOUNT_NAME) $(KCL_SERVICEACCOUNT_LABELS_KEYVALUES)

_kcl_patch_serviceaccount:
	@$(INFO) '$(KCL_UI_LABEL)Patching service-account "$(KCL_SERVICEACCOUNT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) patch serviceaccount $(__KCL_PATCH__SERVICEACCOUNT) $(KCL_SERVICEACCOUNT_NAME)

_KCL_SHOW_SERVICEACCOUNT_TARGETS?= _kcl_show_serviceaccount_clusterrolebindings _kcl_show_serviceaccount_pods _kcl_show_serviceaccount_rbacrules _kcl_show_serviceaccount_secret _kcl_show_serviceaccount_description
_kcl_show_serviceaccount: $(_KCL_SHOW_SERVICEACCOUNT_TARGETS)

_kcl_show_serviceaccount_clusterrolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Showing cluster-role-bindings refering to service-account "$(KCL_SERVICEACCOUNT_NAME)" ...'; $(NORMAL)
	# To be implemented!

_kcl_show_serviceaccount_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of service-account "$(KCL_SERVICEACCOUNT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'In a running container, the service-account secret is mounted on "/var/run/secrets/kubernetes.io/serviceaccount/"'; $(NORMAL)
	$(KUBECTL) describe serviceaccount $(__KCL_NAMESPACE__SERVICEACCOUNT) $(KCL_SERVICEACCOUNT_NAME) 

_kcl_show_serviceaccount_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods using service-account "$(KCL_SERVICEACCOUNT_NAME)" ...'; $(NORMAL)
	# To be implemented!

_kcl_show_serviceaccount_rbacrules:
	@$(INFO) '$(KCL_UI_LABEL)Showing RBAC-rules of service-account "$(KCL_SERVICEACCOUNT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) auth can-i $(__KCL_AS_SERVICEACCOUNT_NAMESPACE_NAME) --list $(|_KCL_SHOW_SERVICEACCOUNT_RBACRULES)

_kcl_show_serviceaccount_secret:
	@$(INFO) '$(KCL_UI_LABEL)Showing JWT from secret in service-account "$(KCL_SERVICEACCOUNT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation displays a clear, base64-decoded token (JWT)'; $(NORMAL)
	@$(WARN) 'To display the full content of the secret, or the CAcert, get the yaml formatted output!'; $(NORMAL)
	$(if $(KCL_SERVICEACCOUNT_SECRET_NAME), $(KUBECTL) describe secret $(__KCL_NAMESPACE__SERVICEACCOUNT) $(KCL_SERVICEACCOUNT_SECRET_NAME), @echo 'KCL_SERVICEACCOUNT_SECRET_NAME not set') 

_kcl_unapply_serviceaccount: _kcl_unapply_serviceaccounts
_kcl_unapply_serviceaccounts:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more service-accounts ...'; $(NORMAL)
	# cat $(KCL_SERVICEACCOUNTS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_SERVICEACCOUNTS_|)cat
	# curl -L $(KCL_SERVICEACCOUNTS_MANIFEST_URL)
	# ls -al $(KCL_SERVICEACCOUNTS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_SERVICEACCOUNTS_|)$(KUBECT) delete $(__KCL_FILENAME__SERVICEACCOUNTS) $(__KCL_NAMESPACE__SERVICEACCOUNTS)

_kcl_unlabel_serviceaccount:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling service-account "$(KCL_SERVICEACCOUNT_NAME)" ...'; $(NORMAL)

_kcl_view_serviceaccounts:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL service-accounts ...'; $(NORMAL)
	$(KUBECTL) get serviceaccounts --all-namespaces=true $(_X__KCL_SERVICEACCOUNTS_NAMESPACE_NAME)

_kcl_view_serviceaccounts_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing service-accounts-set "$(KCL_SERVICEACCOUNTS_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Service-accounts are grouped based on namespace, ...'; $(NORMAL)
	$(KUBECTL) get serviceaccounts --all-namespaces=false $(__KCL_NAMESPACE__SERVICEACCOUNTS)

_kcl_watch_serviceaccounts:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL service-accounts ...'; $(NORMAL)

_kcl_watch_serviceaccounts_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching service-accounts-set "$(KCL_SERVICEACCOUNTS_SET_NAME)"  ...'; $(NORMAL)
