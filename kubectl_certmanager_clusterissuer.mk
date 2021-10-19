_KUBECTL_CERTMANAGER_CLUSTERISSUER_MK_VERSION= $(_KUBECTL_CERTMANAGER_MK_VERSION)

# KCL_CLUSTERISSUER_LABELS_KEYVALUES?= key=value ...
# KCL_CLUSTERISSUER_NAME?= my-issuer 
# KCL_CLUSTERISSUER_NAMESPACE_NAME?= default
# KCL_CLUSTERISSUERS_FIELDSELECTOR?= metadata.name=my-issuer
# KCL_CLUSTERISSUERS_MANIFEST_DIRPATH?= ./in/
# KCL_CLUSTERISSUERS_MANIFEST_FILENAME?= manifest.yaml 
# KCL_CLUSTERISSUERS_MANIFEST_FILEPATH?= ./in/manifest.yaml 
# KCL_CLUSTERISSUERS_MANIFEST_URL?= http://...
# KCL_CLUSTERISSUERS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_CLUSTERISSUERS_NAMESPACE_NAME?= default
# KCL_CLUSTERISSUERS_SELECTOR?=
# KCL_CLUSTERISSUERS_SET_NAME?= my-issuersigningrequests-set

# Derived parameters
KCL_CLUSTERISSUER_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_CLUSTERISSUERS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CLUSTERISSUERS_MANIFEST_FILEPATH?= $(if $(KCL_CLUSTERISSUERS_MANIFEST_FILENAME),$(KCL_CLUSTERISSUERS_MANIFEST_DIRPATH)$(KCL_CLUSTERISSUERS_MANIFEST_FILENAME))
KCL_CLUSTERISSUERS_NAMESPACE_NAME?= $(KCL_CLUSTERISSUER_NAMESPACE_NAME)
KCL_CLUSTERISSUERS_SET_NAME?= cluster-issuers@@@$(KCL_CLUSTERISSUERS_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__CLUSTERISSUERS+= $(if $(KCL_CLUSTERISSUERS_MANIFEST_FILEPATH),--filename $(KCL_CLUSTERISSUERS_MANIFEST_FILEPATH))
__KCL_FILENAME__CLUSTERISSUERS+= $(if $(KCL_CLUSTERISSUERS_MANIFEST_URL),--filename $(KCL_CLUSTERISSUERS_MANIFEST_URL))
__KCL_FILENAME__CLUSTERISSUERS+= $(if $(KCL_CLUSTERISSUERS_MANIFESTS_DIRPATH),--filename $(KCL_CLUSTERISSUERS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__CLUSTERISSUER+= $(if $(KCL_CLUSTERISSUER_NAMESPACE_NAME),--namespace $(KCL_CLUSTERISSUER_NAMESPACE_NAME))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::CertManager::ClusterIssuer ($(_KUBECTL_CERTMANAGER_CLUSTERISSUER_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::CertManager::ClusterIssuer ($(_KUBECTL_CERTMANAGER_CLUSTERISSUER_MK_VERSION)) parameters:'
	@echo '    KCL_CLUSTERISSUER_LABELS_KEYVALUES=$(KCL_CLUSTERISSUER_LABELS_KEYVALUES)'
	@echo '    KCL_CLUSTERISSUER_NAME=$(KCL_CLUSTERISSUER_NAME)'
	@echo '    KCL_CLUSTERISSUER_NAMESPACE_NAME=$(KCL_CLUSTERISSUER_NAMESPACE_NAME)'
	@echo '    KCL_CLUSTERISSUERS_FIELDSELECTOR=$(KCL_CLUSTERISSUERS_FIELDSELECTOR)'
	@echo '    KCL_CLUSTERISSUERS_MANIFEST_DIRPATH=$(KCL_CLUSTERISSUERS_MANIFEST_DIRPATH)'
	@echo '    KCL_CLUSTERISSUERS_MANIFEST_FILENAME=$(KCL_CLUSTERISSUERS_MANIFEST_FILENAME)'
	@echo '    KCL_CLUSTERISSUERS_MANIFEST_FILEPATH=$(KCL_CLUSTERISSUERS_MANIFEST_FILEPATH)'
	@echo '    KCL_CLUSTERISSUERS_MANIFEST_URL=$(KCL_CLUSTERISSUERS_MANIFEST_URL)'
	@echo '    KCL_CLUSTERISSUERS_MANIFESTS_DIRPATH=$(KCL_CLUSTERISSUERS_MANIFESTS_DIRPATH)'
	@echo '    KCL_CLUSTERISSUERS_NAMESPACE_NAME=$(KCL_CLUSTERISSUERS_NAMESPACE_NAME)'
	@echo '    KCL_CLUSTERISSUERS_SELECTOR=$(KCL_CLUSTERISSUERS_SELECTOR)'
	@echo '    KCL_CLUSTERISSUERS_SET_NAME=$(KCL_CLUSTERISSUERS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::CertManager::ClusterIssuer ($(_KUBECTL_CERTMANAGER_CLUSTERISSUER_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_clusterissuer               - Annotate a cluster-issuer'
	@echo '    _kcl_apply_clusterissuers                 - Apply a manifest for one-or-more cluster-issuers'
	@echo '    _kcl_create_clusterissuer                 - Create a new cluster-issuer'
	@echo '    _kcl_delete_clusterissuer                 - Delete an existing cluster-issuer'
	@echo '    _kcl_diff_clusterissuers                  - Diff a manifest for one-or-more cluster-issuers'
	@echo '    _kcl_edit_clusterissuer                   - Edit a cluster-issuer'
	@echo '    _kcl_explain_clusterissuer                - Explain the cluster-issuer object'
	@echo '    _kcl_show_clusterissuer                   - Show everything related to a cluster-issuer'
	@echo '    _kcl_show_clusterissuer_description       - Show description of a cluster-issuer'
	@echo '    _kcl_show_clusterissuer_state             - Show state of a cluster-issuer'
	@echo '    _kcl_unapply_clusterissuers               - Un-apply a manifest for one-or-more cluster-issuers'
	@echo '    _kcl_unlabel_clusterissuer                - Un-label a cluster-issuer'
	@echo '    _kcl_update_clusterissuer                 - Update a cluster-issuer'
	@echo '    _kcl_view_clusterissuers                  - View ALL cluster-issuers'
	@echo '    _kcl_view_clusterissuers_set              - View set of cluster-issuers'
	@echo '    _kcl_watch_clusterissuers                 - Watch ALL cluster-issuers'
	@echo '    _kcl_watch_clusterissuers_set             - Watch a set of cluster-issuers'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_clusterissuer:
	@$(INFO) '$(KCL_UI_LABEL)Annotating cluster-issuer "$(KCL_CLUSTERISSUER_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate $(__KCL_NAMESPACE__CLUSTERISSUER) $(KCL_CLUSTERISSUER_NAME)

_kcl_apply_clusterissuer: _kcl_apply_clusterissuers
_kcl_apply_clusterissuers:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more cluster-issuers ...'; $(NORMAL)
	$(if $(KCL_CLUSTERISSUERS_MANIFEST_FILEPATH), cat $(KCL_CLUSTERISSUERS_MANIFEST_FILEPATH); echo)
	$(if $(KCL_CLUSTERISSUERS_MANIFEST_URL), curl -L $(KCL_CLUSTERISSUERS_MANIFEST_URL); echo)
	$(if $(KCL_CLUSTERISSUERS_MANIFESTS_DIRPATH), ls -al $(KCL_CLUSTERISSUERS_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__CLUSTERISSUERS) $(__KCL_NAMESPACE__CLUSTERISSUERS)

_kcl_create_clusterissuer:
	@$(INFO) '$(KCL_UI_LABEL)Creating cluster-issuer "$(KCL_CLUSTERISSUER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create clusterissuer $(__KCL_NAMESPACE__CLUSTERISSUER) $(KCL_CLUSTERISSUER_NAME)

_kcl_delete_clusterissuer:
	@$(INFO) '$(KCL_UI_LABEL)Deleting cluster-issuer "$(KCL_CLUSTERISSUER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete clusterissuer $(__KCL_NAMESPACE__CLUSTERISSUER) $(KCL_CLUSTERISSUER_NAME)

_kcl_diff_clusterissuer: _kcl_diff_clusterissuers
_kcl_diff_clusterissuers:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more cluster-issuers ...'; $(NORMAL)
	# cat $(KCL_CLUSTERISSUERS_MANIFEST_FILEPATH)
	# curl -L $(KCL_CLUSTERISSUERS_MANIFEST_URL)
	# ls -al $(KCL_CLUSTERISSUERS_MANIFESTS_DIRPATH)
	$(KUBECTL) diff $(__KCL_FILENAME__CLUSTERISSUERS) $(__KCL_NAMESPACE__CLUSTERISSUERS)

_kcl_edit_clusterissuer:
	@$(INFO) '$(KCL_UI_LABEL)Editing cluster-issuer "$(KCL_CLUSTERISSUER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit clusterissuer $(__KCL_NAMESPACE__CLUSTERISSUER) $(KCL_CLUSTERISSUER_NAME)

_kcl_explain_clusterissuer:
	@$(INFO) '$(KCL_UI_LABEL)Explaining cluster-issuer object ...'; $(NORMAL)
	$(KUBECTL) explain clusterissuer

_kcl_label_clusterissuer:
	@$(INFO) '$(KCL_UI_LABEL)Labelling cluster-issuer "$(KCL_CLUSTERISSUER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label clusterissuer $(__KCL_NAMESPACE__CLUSTERISSUER) $(KCL_CLUSTERISSUER_NAME) $(KCL_CLUSTERISSUER_LABELS_KEYVALUES)

_kcl_show_clusterissuer :: _kcl_show_clusterissuer_state _kcl_show_clusterissuer_description

_kcl_show_clusterissuer_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of cluster-issuer "$(KCL_CLUSTERISSUER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe clusterissuer $(__KCL_NAMESPACE__CLUSTERISSUER) $(KCL_CLUSTERISSUER_NAME) 

_kcl_show_clusterissuer_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of cluster-issuer "$(KCL_CLUSTERISSUER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get clusterissuer $(__KCL_NAMESPACE__CLUSTERISSUER) $(KCL_CLUSTERISSUER_NAME) 

_kcl_unapply_clusterissuer: _kcl_unapply_clusterissuers
_kcl_unapply_clusterissuers:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more cluster-issuers ...'; $(NORMAL)
	# cat $(KCL_CLUSTERISSUERS_MANIFEST_FILEPATH)
	# curl -L $(KCL_CLUSTERISSUERS_MANIFEST_URL)
	# ls -al $(KCL_CLUSTERISSUERS_MANIFESTS_DIRPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__CLUSTERISSUERS) $(__KCL_NAMESPACE__CLUSTERISSUERS)

_kcl_unlabel_clusterissuer:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling cluster-issuer "$(KCL_CLUSTERISSUER_NAME)" ...'; $(NORMAL)

_kcl_update_clusterissuer:
	@$(INFO) '$(KCL_UI_LABEL)Updating cluster-issuer "$(KCL_CLUSTERISSUER_NAME)" ...'; $(NORMAL)

_kcl_view_clusterissuers:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL cluster-issuers ...'; $(NORMAL)
	$(KUBECTL) get clusterissuers --all-namespaces=true $(_X__KCL_NAMESPACE__CLUSTERISSUERS) $(_X__KCL_SELECTOR_CLUSTERISSUERS)

_kcl_view_clusterissuers_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing cluster-issuers-set "$(KCL_CLUSTERISSUERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Issuers are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
	$(KUBECTL) get clusterissuers --all-namespaces=false $(__KCL_FIELD_SELECTOR__CLUSTERISSUERS) $(__KCL_NAMESPACE__CLUSTERISSUERS) $(__KCL_SELECTOR__CLUSTERISSUERS)

_kcl_watch_clusterissuers:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL cluster-issuers ...'; $(NORMAL)

_kcl_watch_clusterissuers_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching cluster-issuers-set "$(KCL_CLUSTERISSUERS_SET_NAME)" ...'; $(NORMAL)
