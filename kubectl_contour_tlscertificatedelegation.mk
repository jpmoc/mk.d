_KUBECTL_CONTOUR_TLSCERTIFICATEDELEGATION_MK_VERSION= $(_KUBECTL_CONTOUR_MK_VERSION)

# KCL_TLSCERTIFICATEDELEGATION_LABELS_KEYVALUES?= key=value ...
# KCL_TLSCERTIFICATEDELEGATION_NAME?= my-name 
# KCL_TLSCERTIFICATEDELEGATION_NAMESPACE_NAME?= default
# KCL_TLSCERTIFICATEDELEGATIONS_FIELDSELECTOR?= metadata.name=my-name
# KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_DIRPATH?= ./in/
# KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILENAME?= manifest.yaml 
# KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILEPATH?= ./in/manifest.yaml 
# KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_URL?= http://...
# KCL_TLSCERTIFICATEDELEGATIONS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_TLSCERTIFICATEDELEGATIONS_NAMESPACE_NAME?= default
# KCL_TLSCERTIFICATEDELEGATIONS_SELECTOR?=
# KCL_TLSCERTIFICATEDELEGATIONS_SET_NAME?= my-tls-certificate-delegations-set

# Derived parameters
KCL_TLSCERTIFICATEDELEGATION_ISSUER_NAME?= $(KCL_ISSUER_NAME)
KCL_TLSCERTIFICATEDELEGATION_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_TLSCERTIFICATEDELEGATION_SECRET_NAME?= $(KCL_SECRET_NAME)
KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILEPATH?= $(if $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILENAME),$(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_DIRPATH)$(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILENAME))
KCL_TLSCERTIFICATEDELEGATIONS_NAMESPACE_NAME?= $(KCL_TLSCERTIFICATEDELEGATION_NAMESPACE_NAME)
KCL_TLSCERTIFICATEDELEGATIONS_SET_NAME?= tlscertificatedelegations@@@$(KCL_TLSCERTIFICATEDELEGATIONS_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__TLSCERTIFICATEDELEGATIONS+= $(if $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILEPATH),--filename $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILEPATH))
__KCL_FILENAME__TLSCERTIFICATEDELEGATIONS+= $(if $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_URL),--filename $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_URL))
__KCL_FILENAME__TLSCERTIFICATEDELEGATIONS+= $(if $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFESTS_DIRPATH),--filename $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__TLSCERTIFICATEDELEGATION= $(if $(KCL_TLSCERTIFICATEDELEGATION_NAMESPACE_NAME),--namespace $(KCL_TLSCERTIFICATEDELEGATION_NAMESPACE_NAME))
__KCL_NAMESPACE__TLSCERTIFICATEDELEGATIONS= $(if $(KCL_TLSCERTIFICATEDELEGATIONS_NAMESPACE_NAME),--namespace $(KCL_TLSCERTIFICATEDELEGATIONS_NAMESPACE_NAME))

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Contour::TlsCertificateDelegation ($(_KUBECTL_CONTOUR_TLSCERTIFICATEDELEGATION_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Contour::TlsCertificateDelegation ($(_KUBECTL_CONTOUR_TLSCERTIFICATEDELEGATION_MK_VERSION)) parameters:'
	@echo '    KCL_TLSCERTIFICATEDELEGATION_LABELS_KEYVALUES=$(KCL_TLSCERTIFICATEDELEGATION_LABELS_KEYVALUES)'
	@echo '    KCL_TLSCERTIFICATEDELEGATION_NAME=$(KCL_TLSCERTIFICATEDELEGATION_NAME)'
	@echo '    KCL_TLSCERTIFICATEDELEGATION_NAMESPACE_NAME=$(KCL_TLSCERTIFICATEDELEGATION_NAMESPACE_NAME)'
	@echo '    KCL_TLSCERTIFICATEDELEGATION_SECRET_NAME=$(KCL_TLSCERTIFICATEDELEGATION_SECRET_NAME)'
	@echo '    KCL_TLSCERTIFICATEDELEGATIONS_FIELDSELECTOR=$(KCL_TLSCERTIFICATEDELEGATIONS_FIELDSELECTOR)'
	@echo '    KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_DIRPATH=$(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_DIRPATH)'
	@echo '    KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILENAME=$(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILENAME)'
	@echo '    KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILEPATH=$(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILEPATH)'
	@echo '    KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_URL=$(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_URL)'
	@echo '    KCL_TLSCERTIFICATEDELEGATIONS_MANIFESTS_DIRPATH=$(KCL_TLSCERTIFICATEDELEGATIONS_MANIFESTS_DIRPATH)'
	@echo '    KCL_TLSCERTIFICATEDELEGATIONS_NAMESPACE_NAME=$(KCL_TLSCERTIFICATEDELEGATIONS_NAMESPACE_NAME)'
	@echo '    KCL_TLSCERTIFICATEDELEGATIONS_SELECTOR=$(KCL_TLSCERTIFICATEDELEGATIONS_SELECTOR)'
	@echo '    KCL_TLSCERTIFICATEDELEGATIONS_SET_NAME=$(KCL_TLSCERTIFICATEDELEGATIONS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Contour::TlsCertificateDelegation ($(_KUBECTL_CONTOUR_TLSCERTIFICATEDELEGATION_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_tlscertificatedelegation                  - Annotate a http-proxy'
	@echo '    _kcl_apply_tlscertificatedelegations                    - Apply a manifest for one-or-more tls-certificate-delegations'
	@echo '    _kcl_create_tlscertificatedelegation                    - Create a new http-proxy'
	@echo '    _kcl_delete_tlscertificatedelegation                    - Delete an existing http-proxy'
	@echo '    _kcl_diff_tlscertificatedelegations                     - Diff a manifest for one or more tls-certificate-delegations'
	@echo '    _kcl_edit_tlscertificatedelegation                      - Edit a http-proxy'
	@echo '    _kcl_explain_tlscertificatedelegation                   - Explain the http-proxy object'
	@echo '    _kcl_show_tlscertificatedelegation                      - Show everything related to a http-proxy'
	@echo '    _kcl_show_tlscertificatedelegation_description          - Show description of a http-proxy'
	@echo '    _kcl_show_tlscertificatedelegation_issuer               - Show issuer of a http-proxy'
	@echo '    _kcl_show_tlscertificatedelegation_secret               - Show secret of a http-proxy'
	@echo '    _kcl_show_tlscertificatedelegation_state                - Show state of a http-proxy'
	@echo '    _kcl_unapply_tlscertificatedelegations                  - Un-apply a manifest for one-or-more http-proxy'
	@echo '    _kcl_unlabel_tlscertificatedelegation                   - Un-label a http-proxy'
	@echo '    _kcl_view_tlscertificatedelegations                     - View ALL tls-certificate-delegations'
	@echo '    _kcl_view_tlscertificatedelegations_set                 - View set of tls-certificate-delegations'
	@echo '    _kcl_watch_tlscertificatedelegations                    - Watch ALL tls-certificate-delegations'
	@echo '    _kcl_watch_tlscertificatedelegations_set                - Watch a set of tls-certificate-delegations'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_tlscertificatedelegation:
	@$(INFO) '$(KCL_UI_LABEL)Annotating http-proxy "$(KCL_TLSCERTIFICATEDELEGATION_NAME)" ...'; $(NORMAL)

_kcl_apply_tlscertificatedelegation: _kcl_apply_tlscertificatedelegations
_kcl_apply_tlscertificatedelegations:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more tls-certificate-delegations ...'; $(NORMAL)
	$(if $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILEPATH), cat $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILEPATH); echo)
	$(if $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_URL), curl -L $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_URL); echo)
	$(if $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFESTS_DIRPATH), ls -al $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__TLSCERTIFICATEDELEGATIONS) $(__KCL_NAMESPACE__TLSCERTIFICATEDELEGATIONS)

_kcl_create_tlscertificatedelegation:
	@$(INFO) '$(KCL_UI_LABEL)Creating http-proxy "$(KCL_TLSCERTIFICATEDELEGATION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create tlscertificatedelegation $(__KCL_NAMESPACE__TLSCERTIFICATEDELEGATION) $(KCL_TLSCERTIFICATEDELEGATION_NAME)

_kcl_delete_tlscertificatedelegation:
	@$(INFO) '$(KCL_UI_LABEL)Deleting http-proxy "$(KCL_TLSCERTIFICATEDELEGATION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete tlscertificatedelegation $(__KCL_NAMESPACE__TLSCERTIFICATEDELEGATION) $(KCL_TLSCERTIFICATEDELEGATION_NAME)

_kcl_diff_tlscertificatedelegation: _kcl_diff_tlscertificatedelegations
_kcl_diff_tlscertificatedelegations:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more tls-certificate-delegations ...'; $(NORMAL)
	# cat $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILEPATH)
	# curl -L $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_URL)
	# ls -al $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFESTS_DIRPATH)
	$(KUBECTL) diff $(__KCL_FILENAME__TLSCERTIFICATEDELEGATIONS) $(__KCL_NAMESPACE__TLSCERTIFICATEDELEGATIONS)

_kcl_edit_tlscertificatedelegation:
	@$(INFO) '$(KCL_UI_LABEL)Editing http-proxy "$(KCL_TLSCERTIFICATEDELEGATION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit tlscertificatedelegation $(__KCL_NAMESPACE__TLSCERTIFICATEDELEGATION) $(KCL_TLSCERTIFICATEDELEGATION_NAME)

_kcl_explain_tlscertificatedelegation:
	@$(INFO) '$(KCL_UI_LABEL)Explaining http-proxy object ...'; $(NORMAL)
	$(KUBECTL) explain tlscertificatedelegation

_kcl_label_tlscertificatedelegation:
	@$(INFO) '$(KCL_UI_LABEL)Labelling http-proxy "$(KCL_TLSCERTIFICATEDELEGATION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label tlscertificatedelegation $(__KCL_NAMESPACE__TLSCERTIFICATEDELEGATION) $(KCL_TLSCERTIFICATEDELEGATION_NAME) $(KCL_TLSCERTIFICATEDELEGATION_LABELS_KEYVALUES)

_kcl_show_tlscertificatedelegation :: _kcl_show_tlscertificatedelegation_description

_kcl_show_tlscertificatedelegation_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of http-proxy "$(KCL_TLSCERTIFICATEDELEGATION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe tlscertificatedelegation $(__KCL_NAMESPACE__TLSCERTIFICATEDELEGATION) $(KCL_TLSCERTIFICATEDELEGATION_NAME) 

_kcl_unapply_tlscertificatedelegation: _kcl_unapply_tlscertificatedelegations
_kcl_unapply_tlscertificatedelegations:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more tls-certificate-delegations ...'; $(NORMAL)
	# cat $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_FILEPATH)
	# curl -L $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFEST_URL)
	# ls -al $(KCL_TLSCERTIFICATEDELEGATIONS_MANIFESTS_DIRPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__TLSCERTIFICATEDELEGATIONS) $(__KCL_NAMESPACE__TLSCERTIFICATEDELEGATIONS)

_kcl_unlabel_tlscertificatedelegation:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling http-proxy "$(KCL_TLSCERTIFICATEDELEGATION_NAME)" ...'; $(NORMAL)

_kcl_view_tlscertificatedelegations:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL tls-certificate-delegations ...'; $(NORMAL)
	$(KUBECTL) get tlscertificatedelegations --all-namespaces=true $(_X__KCL_NAMESPACE__TLSCERTIFICATEDELEGATIONS) $(_X__KCL_SELECTOR_TLSCERTIFICATEDELEGATIONS)

_kcl_view_tlscertificatedelegations_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing tls-certificate-delegations-set "$(KCL_TLSCERTIFICATEDELEGATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'tls-certificate-delegations are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
	$(KUBECTL) get tlscertificatedelegations --all-namespaces=false $(__KCL_FIELD_SELECTOR__TLSCERTIFICATEDELEGATIONS) $(__KCL_NAMESPACE__TLSCERTIFICATEDELEGATIONS) $(__KCL_SELECTOR__TLSCERTIFICATEDELEGATIONS)

_kcl_watch_tlscertificatedelegations:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL tls-certificate-delegations ...'; $(NORMAL)

_kcl_watch_tlscertificatedelegations_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching tlscertificatedelegations-set "$(KCL_TLSCERTIFICATEDELEGATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'tls-certificate-delegations are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
