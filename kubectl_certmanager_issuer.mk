_KUBECTL_CERTMANAGER_ISSUER_MK_VERSION= $(_KUBECTL_CERTMANAGER_MK_VERSION)

# KCL_ISSUER_LABELS_KEYVALUES?= key=value ...
# KCL_ISSUER_NAME?= my-name 
# KCL_ISSUER_NAMESPACE_NAME?= default
# KCL_ISSUERS_FIELDSELECTOR?= metadata.name=my-name
# KCL_ISSUERS_MANIFEST_DIRPATH?= ./in/
# KCL_ISSUERS_MANIFEST_FILENAME?= manifest.yaml 
# KCL_ISSUERS_MANIFEST_FILEPATH?= ./in/manifest.yaml 
# KCL_ISSUERS_MANIFEST_URL?= http:/n.com/manifest.yaml
# KCL_ISSUERS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_ISSUERS_NAMESPACE_NAME?= default
# KCL_ISSUERS_SELECTOR?=
# KCL_ISSUERS_SET_NAME?= my-set

# Derived parameters
KCL_ISSUER_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_ISSUERS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_ISSUERS_MANIFEST_FILEPATH?= $(if $(KCL_ISSUERS_MANIFEST_FILENAME),$(KCL_ISSUERS_MANIFEST_DIRPATH)$(KCL_ISSUERS_MANIFEST_FILENAME))
KCL_ISSUERS_NAMESPACE_NAME?= $(KCL_ISSUER_NAMESPACE_NAME)
KCL_ISSUERS_SET_NAME?= issuers@@@$(KCL_ISSUERS_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__ISSUERS+= $(if $(KCL_ISSUERS_MANIFEST_FILEPATH),--filename $(KCL_ISSUERS_MANIFEST_FILEPATH))
__KCL_FILENAME__ISSUERS+= $(if $(KCL_ISSUERS_MANIFEST_URL),--filename $(KCL_ISSUERS_MANIFEST_URL))
__KCL_FILENAME__ISSUERS+= $(if $(KCL_ISSUERS_MANIFESTS_DIRPATH),--filename $(KCL_ISSUERS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__ISSUER= $(if $(KCL_ISSUER_NAMESPACE_NAME),--namespace $(KCL_ISSUER_NAMESPACE_NAME))
__KCL_NAMESPACE__ISSUERS= $(if $(KCL_ISSUERS_NAMESPACE_NAME),--namespace $(KCL_ISSUERS_NAMESPACE_NAME))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::CertManager::Issuer ($(_KUBECTL_CERTMANAGER_ISSUER_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::CertManager::Issuer ($(_KUBECTL_CERTMANAGER_ISSUER_MK_VERSION)) parameters:'
	@echo '    KCL_ISSUER_LABELS_KEYVALUES=$(KCL_ISSUER_LABELS_KEYVALUES)'
	@echo '    KCL_ISSUER_NAME=$(KCL_ISSUER_NAME)'
	@echo '    KCL_ISSUER_NAMESPACE_NAME=$(KCL_ISSUER_NAMESPACE_NAME)'
	@echo '    KCL_ISSUERS_FIELDSELECTOR=$(KCL_ISSUERS_FIELDSELECTOR)'
	@echo '    KCL_ISSUERS_MANIFEST_DIRPATH=$(KCL_ISSUERS_MANIFEST_DIRPATH)'
	@echo '    KCL_ISSUERS_MANIFEST_FILENAME=$(KCL_ISSUERS_MANIFEST_FILENAME)'
	@echo '    KCL_ISSUERS_MANIFEST_FILEPATH=$(KCL_ISSUERS_MANIFEST_FILEPATH)'
	@echo '    KCL_ISSUERS_MANIFEST_URL=$(KCL_ISSUERS_MANIFEST_URL)'
	@echo '    KCL_ISSUERS_MANIFESTS_DIRPATH=$(KCL_ISSUERS_MANIFESTS_DIRPATH)'
	@echo '    KCL_ISSUERS_NAMESPACE_NAME=$(KCL_ISSUERS_NAMESPACE_NAME)'
	@echo '    KCL_ISSUERS_SELECTOR=$(KCL_ISSUERS_SELECTOR)'
	@echo '    KCL_ISSUERS_SET_NAME=$(KCL_ISSUERS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::CertManager::Issuer ($(_KUBECTL_CERTMANAGER_ISSUER_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_issuer               - Annotate a issuer'
	@echo '    _kcl_apply_issuers                 - Apply a manifest for one-or-more issuers'
	@echo '    _kcl_create_issuer                 - Create a new issuer'
	@echo '    _kcl_delete_issuer                 - Delete an existing issuer'
	@echo '    _kcl_diff_issuers                  - Diff a manifest for one-or-more issuers'
	@echo '    _kcl_edit_issuer                   - Edit a issuer'
	@echo '    _kcl_explain_issuer                - Explain the issuer object'
	@echo '    _kcl_show_issuer                   - Show everything related to a issuer'
	@echo '    _kcl_show_issuer_description       - Show description of a issuer'
	@echo '    _kcl_show_issuer_state             - Show state of a issuer'
	@echo '    _kcl_unapply_issuers               - Un-apply a manifest for one-or-more issuer'
	@echo '    _kcl_unlabel_issuer                - Un-label a issuer'
	@echo '    _kcl_update_issuer                 - Update a issuer'
	@echo '    _kcl_view_issuers                  - View issuers'
	@echo '    _kcl_view_issuers_set              - View set of issuers'
	@echo '    _kcl_watch_issuers                 - Watch issuers'
	@echo '    _kcl_watch_issuers_set             - Watch a set of issuers'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_issuer:
	@$(INFO) '$(KCL_UI_LABEL)Annotating issuer "$(KCL_ISSUER_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate $(__KCL_NAMESPACE__ISSUER) $(KCL_ISSUER_NAME)

_kcl_apply_issuer: _kcl_apply_issuers
_kcl_apply_issuers:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more issuers ...'; $(NORMAL)
	$(if $(KCL_ISSUERS_MANIFEST_FILEPATH), cat $(KCL_ISSUERS_MANIFEST_FILEPATH); echo)
	$(if $(KCL_ISSUERS_MANIFEST_URL), curl -L $(KCL_ISSUERS_MANIFEST_URL); echo)
	$(if $(KCL_ISSUERS_MANIFESTS_DIRPATH), ls -al $(KCL_ISSUERS_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__ISSUERS) $(__KCL_NAMESPACE__ISSUERS)

_kcl_create_issuer:
	@$(INFO) '$(KCL_UI_LABEL)Creating issuer "$(KCL_ISSUER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create issuer $(__KCL_NAMESPACE__ISSUER) $(KCL_ISSUER_NAME)

_kcl_delete_issuer:
	@$(INFO) '$(KCL_UI_LABEL)Deleting issuer "$(KCL_ISSUER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete issuer $(__KCL_NAMESPACE__ISSUER) $(KCL_ISSUER_NAME)

_kcl_diff_issuer: _kcl_diff_issuers
_kcl_diff_issuers:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more issuers ...'; $(NORMAL)
	# cat $(KCL_ISSUERS_MANIFEST_FILEPATH)
	# curl -L $(KCL_ISSUERS_MANIFEST_URL)
	# ls -al $(KCL_ISSUERS_MANIFESTS_DIRPATH)
	$(KUBECTL) diff $(__KCL_FILENAME__ISSUERS) $(__KCL_NAMESPACE__ISSUERS)

_kcl_edit_issuer:
	@$(INFO) '$(KCL_UI_LABEL)Editing issuer "$(KCL_ISSUER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit issuer $(__KCL_NAMESPACE__ISSUER) $(KCL_ISSUER_NAME)

_kcl_explain_issuer:
	@$(INFO) '$(KCL_UI_LABEL)Explaining issuer object ...'; $(NORMAL)
	$(KUBECTL) explain issuer

_kcl_label_issuer:
	@$(INFO) '$(KCL_UI_LABEL)Labelling issuer "$(KCL_ISSUER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label issuer $(__KCL_NAMESPACE__ISSUER) $(KCL_ISSUER_NAME) $(KCL_ISSUER_LABELS_KEYVALUES)

_kcl_show_issuer :: _kcl_show_issuer_state _kcl_show_issuer_description

_kcl_show_issuer_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of issuer "$(KCL_ISSUER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe issuer $(__KCL_NAMESPACE__ISSUER) $(KCL_ISSUER_NAME) 

_kcl_show_issuer_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of issuer "$(KCL_ISSUER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get issuer $(__KCL_NAMESPACE__ISSUER) $(KCL_ISSUER_NAME) 

_kcl_unapply_issuer: _kcl_unapply_issuers
_kcl_unapply_issuers:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more issuers ...'; $(NORMAL)
	# cat $(KCL_ISSUERS_MANIFEST_FILEPATH)
	# curl -L $(KCL_ISSUERS_MANIFEST_URL)
	# ls -al $(KCL_ISSUERS_MANIFESTS_DIRPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__ISSUERS) $(__KCL_NAMESPACE__ISSUERS)

_kcl_unlabel_issuer:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling issuer "$(KCL_ISSUER_NAME)" ...'; $(NORMAL)

_kcl_update_issuer:
	@$(INFO) '$(KCL_UI_LABEL)Updating issuer "$(KCL_ISSUER_NAME)" ...'; $(NORMAL)

_kcl_view_issuers:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL issuers ...'; $(NORMAL)
	$(KUBECTL) get issuers --all-namespaces=true $(_X__KCL_NAMESPACE__ISSUERS) $(_X__KCL_SELECTOR_ISSUERS)

_kcl_view_issuers_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing issuers-set "$(KCL_ISSUERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Issuers are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
	$(KUBECTL) get issuers --all-namespaces=false $(__KCL_FIELD_SELECTOR__ISSUERS) $(__KCL_NAMESPACE__ISSUERS) $(__KCL_SELECTOR__ISSUERS)

_kcl_watch_issuers:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL issuers ...'; $(NORMAL)

_kcl_watch_issuers_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching issuers-set "$(KCL_ISSUERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Issuers are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
