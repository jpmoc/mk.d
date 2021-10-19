_KUBECTL_CERTMANAGER_CERTIFICATEREQUEST_MK_VERSION= $(_KUBECTL_CERTMANAGER_MK_VERSION)

# KCL_CERTIFICATEREQUEST_ISSUER_NAME?= my-issuer
# KCL_CERTIFICATEREQUEST_LABELS_KEYVALUES?= key=value ...
# KCL_CERTIFICATEREQUEST_MANIFEST_DIRPATH?= ./in/
# KCL_CERTIFICATEREQUEST_MANIFEST_FILENAME?= certificate-request.yaml 
# KCL_CERTIFICATEREQUEST_MANIFEST_FILEPATH?= ./in/certificate-request.yaml 
# KCL_CERTIFICATEREQUEST_MANIFEST_URL?= http://...
# KCL_CERTIFICATEREQUEST_NAME?= 
# KCL_CERTIFICATEREQUEST_NAMESPACE_NAME?= default
# KCL_CERTIFICATEREQUESTS_FIELDSELECTOR?= metadata.name=my-certificate-request
# KCL_CERTIFICATEREQUESTS_NAMESPACE_NAME?= default
# KCL_CERTIFICATEREQUESTS_SELECTOR?=
# KCL_CERTIFICATEREQUESTS_SET_NAME?= my-certificate-requestsigningrequests-set

# Derived parameters
KCL_CERTIFICATEREQUEST_CERTIFICATE_NAME?= $(KCL_CERTIFICATE_NAME)
KCL_CERTIFICATEREQUEST_ISSUER_NAME?= $(KCL_ISSUER_NAME)
KCL_CERTIFICATEREQUEST_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CERTIFICATEREQUEST_MANIFEST_FILEPATH?= $(if $(KCL_CERTIFICATEREQUEST_MANIFEST_FILENAME),$(KCL_CERTIFICATEREQUEST_MANIFEST_DIRPATH)$(KCL_CERTIFICATEREQUEST_MANIFEST_FILENAME))
KCL_CERTIFICATEREQUEST_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_CERTIFICATEREQUESTS_NAMESPACE_NAME?= $(KCL_CERTIFICATEREQUEST_NAMESPACE_NAME)
KCL_CERTIFICATEREQUESTS_SET_NAME?= certificate-requests@@@$(KCL_CERTIFICATEREQUESTS_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__CERTIFICATEREQUEST+= $(if $(KCL_CERTIFICATEREQUEST_MANIFEST_FILEPATH),--filename $(KCL_CERTIFICATEREQUEST_MANIFEST_FILEPATH))
__KCL_FILENAME__CERTIFICATEREQUEST+= $(if $(KCL_CERTIFICATEREQUEST_MANIFEST_URL),--filename $(KCL_CERTIFICATEREQUEST_MANIFEST_URL))
__KCL_NAMESPACE__CERTIFICATEREQUEST= $(if $(KCL_CERTIFICATEREQUEST_NAMESPACE_NAME),--namespace $(KCL_CERTIFICATEREQUEST_NAMESPACE_NAME))
__KCL_NAMESPACE__CERTIFICATEREQUESTS= $(if $(KCL_CERTIFICATEREQUESTS_NAMESPACE_NAME),--namespace $(KCL_CERTIFICATEREQUESTS_NAMESPACE_NAME))

# Pipe parameters
|_KCL_SHOW_CERTIFICATEREQUEST_CERTIFICATESIGNINGREQUEST?= --output json | jq -r '.spec.csr' | base64 --decode

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::CertManager::Certificate-requestRequest ($(_KUBECTL_CERTMANAGER_CERTIFICATEREQUEST_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::CertManager::CertificateRequest ($(_KUBECTL_CERTMANAGER_CERTIFICATEREQUEST_MK_VERSION)) parameters:'
	@echo '    KCL_CERTIFICATEREQUEST_CERTIFICATE_NAME=$(KCL_CERTIFICATEREQUEST_CERTIFICATE_NAME)'
	@echo '    KCL_CERTIFICATEREQUEST_ISSUER_NAME=$(KCL_CERTIFICATEREQUEST_ISSUER_NAME)'
	@echo '    KCL_CERTIFICATEREQUEST_LABELS_KEYVALUES=$(KCL_CERTIFICATEREQUEST_LABELS_KEYVALUES)'
	@echo '    KCL_CERTIFICATEREQUEST_MANIFEST_DIRPATH=$(KCL_CERTIFICATEREQUEST_MANIFEST_DIRPATH)'
	@echo '    KCL_CERTIFICATEREQUEST_MANIFEST_FILENAME=$(KCL_CERTIFICATEREQUEST_MANIFEST_FILENAME)'
	@echo '    KCL_CERTIFICATEREQUEST_MANIFEST_FILEPATH=$(KCL_CERTIFICATEREQUEST_MANIFEST_FILEPATH)'
	@echo '    KCL_CERTIFICATEREQUEST_MANIFEST_URL=$(KCL_CERTIFICATEREQUEST_MANIFEST_URL)'
	@echo '    KCL_CERTIFICATEREQUEST_NAME=$(KCL_CERTIFICATEREQUEST_NAME)'
	@echo '    KCL_CERTIFICATEREQUEST_NAMESPACE_NAME=$(KCL_CERTIFICATEREQUEST_NAMESPACE_NAME)'
	@echo '    KCL_CERTIFICATEREQUESTS_FIELDSELECTOR=$(KCL_CERTIFICATEREQUESTS_FIELDSELECTOR)'
	@echo '    KCL_CERTIFICATEREQUESTS_NAMESPACE_NAME=$(KCL_CERTIFICATEREQUESTS_NAMESPACE_NAME)'
	@echo '    KCL_CERTIFICATEREQUESTS_SELECTOR=$(KCL_CERTIFICATEREQUESTS_SELECTOR)'
	@echo '    KCL_CERTIFICATEREQUESTS_SET_NAME=$(KCL_CERTIFICATEREQUESTS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::CertManager::CertificateRequest ($(_KUBECTL_CERTMANAGER_CERTIFICATEREQUEST_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_certificaterequest         - Annotate a certificate-request'
	@echo '    _kcl_apply_certificaterequest            - Apply a manifest for one-or-more certificate-requests'
	@echo '    _kcl_create_certificaterequest           - Create a new certificate-request'
	@echo '    _kcl_delete_certificaterequest           - Delete an existing certificate-request'
	@echo '    _kcl_diff_certificaterequest             - Diff a manifest for one or more certificate-requests'
	@echo '    _kcl_edit_certificaterequest             - Edit a certificate-request'
	@echo '    _kcl_explain_certificaterequest          - Explain the certificate-request object'
	@echo '    _kcl_show_certificaterequest             - Show everything related to a certificate-request'
	@echo '    _kcl_show_certificaterequest_certificate - Show certificate of a certificate-request'
	@echo '    _kcl_show_certificaterequest_description - Show description of a certificate-request'
	@echo '    _kcl_show_certificaterequest_issuer      - Show issuer of a certificate-request'
	@echo '    _kcl_show_certificaterequest_state       - Show state of a certificate-request'
	@echo '    _kcl_unapply_certificaterequest          - Un-apply a manifest for a certificate-request'
	@echo '    _kcl_unlabel_certificaterequest          - Un-label a certificate-request'
	@echo '    _kcl_update_certificaterequest           - Update a certificate-request'
	@echo '    _kcl_view_certificaterequests            - View certificate-requests'
	@echo '    _kcl_view_certificaterequests_set        - View set of certificate-requests'
	@echo '    _kcl_watch_certificaterequests           - Watch certificate-requests'
	@echo '    _kcl_watch_certificaterequests_set       - Watch a set of certificate-requests'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_certificaterequest:
	@$(INFO) '$(KCL_UI_LABEL)Annotating certificate-request "$(KCL_CERTIFICATEREQUEST_NAME)" ...'; $(NORMAL)

_kcl_apply_certificaterequest: _kcl_apply_certificaterequests
_kcl_apply_certificaterequests:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more certificate-requests ...'; $(NORMAL)
	$(if $(KCL_CERTIFICATEREQUEST_MANIFEST_FILEPATH), cat $(KCL_CERTIFICATEREQUEST_MANIFEST_FILEPATH); echo)
	$(if $(KCL_CERTIFICATEREQUEST_MANIFEST_URL), curl -L $(KCL_CERTIFICATEREQUEST_MANIFEST_URL); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__CERTIFICATEREQUEST) $(__KCL_NAMESPACE__CERTIFICATEREQUEST)

_kcl_create_certificaterequest:
	@$(INFO) '$(KCL_UI_LABEL)Creating certificate-request "$(KCL_CERTIFICATEREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create certificaterequest $(__KCL_NAMESPACE__CERTIFICATEREQUEST) $(KCL_CERTIFICATEREQUEST_NAME)

_kcl_delete_certificaterequest:
	@$(INFO) '$(KCL_UI_LABEL)Deleting certificate-request "$(KCL_CERTIFICATEREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete certificaterequest $(__KCL_NAMESPACE__CERTIFICATEREQUEST) $(KCL_CERTIFICATEREQUEST_NAME)

_kcl_diff_certificaterequest: _kcl_diff_certificaterequests
_kcl_diff_certificaterequests:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more certificate-requests ...'; $(NORMAL)
	# cat $(KCL_CERTIFICATEREQUEST_MANIFEST_FILEPATH); echo
	# curl -L $(KCL_CERTIFICATEREQUEST_MANIFEST_URL); echo
	$(KUBECTL) diff $(__KCL_FILENAME__CERTIFICATEREQUEST) $(__KCL_NAMESPACE__CERTIFICATEREQUEST)

_kcl_edit_certificaterequest:
	@$(INFO) '$(KCL_UI_LABEL)Editing certificate-request "$(KCL_CERTIFICATEREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit certificaterequest $(__KCL_NAMESPACE__CERTIFICATEREQUEST) $(KCL_CERTIFICATEREQUEST_NAME)

_kcl_explain_certificaterequest:
	@$(INFO) '$(KCL_UI_LABEL)Explaining certificate-request object ...'; $(NORMAL)
	$(KUBECTL) explain certificaterequest

_kcl_label_certificaterequest:
	@$(INFO) '$(KCL_UI_LABEL)Labelling certificate-request "$(KCL_CERTIFICATEREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label certificaterequest $(__KCL_NAMESPACE__CERTIFICATEREQUEST) $(KCL_CERTIFICATEREQUEST_NAME) $(KCL_CERTIFICATEREQUEST_LABELS_KEYVALUES)

_kcl_show_certificaterequest :: _kcl_show_certificaterequest_certificate _kcl_show_certificaterequest_certificatesigningrequest _kcl_show_certificaterequest_issuer _kcl_show_certificaterequest_state _kcl_show_certificaterequest_description

_kcl_show_certificaterequest_certificate:
	@$(INFO) '$(KCL_UI_LABEL)Showing certificate of certificate-request "$(KCL_CERTIFICATEREQUEST_NAME)" ...'; $(NORMAL)
	$(if $(KCL_CERTIFICATEREQUEST_CERTIFICATE_NAME), \
		$(KUBECTL) get certificate $(__KCL_NAMESPACE__CERTIFICATEREQUEST) $(KCL_CERTIFICATEREQUEST_CERTIFICATE_NAME); \
	, @\
		echo 'KCL_CERTIFICATEREQUEST_CERTIFICATE_NAME not set ...'; \
	)

_kcl_show_certificaterequest_certificatesigningrequest:
	@$(INFO) '$(KCL_UI_LABEL)Showing certificate-signing-request of certificate-request "$(KCL_CERTIFICATEREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get certificaterequest $(__KCL_NAMESPACE__CERTIFICATEREQUEST) $(KCL_CERTIFICATEREQUEST_NAME) $(|_KCL_SHOW_CERTIFICATEREQUEST_CERTIFICATESIGNINGREQUEST)

_kcl_show_certificaterequest_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of certificate-request "$(KCL_CERTIFICATEREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe certificaterequest $(__KCL_NAMESPACE__CERTIFICATEREQUEST) $(KCL_CERTIFICATEREQUEST_NAME) 

_kcl_show_certificaterequest_issuer:
	@$(INFO) '$(KCL_UI_LABEL)Showing issuer of certificate-request "$(KCL_CERTIFICATEREQUEST_NAME)" ...'; $(NORMAL)
	$(if $(KCL_CERTIFICATEREQUEST_ISSUER_NAME), \
		$(KUBECTL) get issuer $(__KCL_NAMESPACE__CERTIFICATEREQUEST) $(KCL_CERTIFICATEREQUEST_ISSUER_NAME); \
	, @\
		echo 'KCL_CERTIFICATEREQUEST_ISSUER_NAME not set ...'; \
	)

_kcl_show_certificaterequest_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of certificate-request "$(KCL_CERTIFICATEREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get certificaterequest $(__KCL_NAMESPACE__CERTIFICATEREQUEST) $(KCL_CERTIFICATEREQUEST_NAME) 

_kcl_unapply_certificaterequest: _kcl_unapply_certificaterequests
_kcl_unapply_certificaterequests:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more certificate-requests ...'; $(NORMAL)
	# cat $(KCL_CERTIFICATEREQUEST_MANIFEST_FILEPATH); echo
	# curl -L $(KCL_CERTIFICATEREQUEST_MANIFEST_URL); echo
	$(KUBECTL) delete $(__KCL_FILENAME__CERTIFICATEREQUEST) $(__KCL_NAMESPACE__CERTIFICATEREQUEST)

_kcl_unlabel_certificaterequest:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling certificate-request "$(KCL_CERTIFICATEREQUEST_NAME)" ...'; $(NORMAL)

_kcl_update_certificaterequest:
	@$(INFO) '$(KCL_UI_LABEL)Updating certificate-request "$(KCL_CERTIFICATEREQUEST_NAME)" ...'; $(NORMAL)

_kcl_view_certificaterequests:
	@$(INFO) '$(KCL_UI_LABEL)Viewing certificate-requests ...'; $(NORMAL)
	$(KUBECTL) get certificaterequests --all-namespaces=true $(_X__KCL_NAMESPACE__CERTIFICATEREQUESTS) $(_X__KCL_SELECTOR_CERTIFICATEREQUESTS)

_kcl_view_certificaterequests_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing certificate-requests-set "$(KCL_CERTIFICATEREQUESTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Certificate-requests are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
	$(KUBECTL) get certificaterequests --all-namespaces=false $(__KCL_FIELD_SELECTOR__CERTIFICATEREQUESTS) $(__KCL_NAMESPACE__CERTIFICATEREQUESTS) $(__KCL_SELECTOR__CERTIFICATEREQUESTS)

_kcl_watch_certificaterequests:
	@$(INFO) '$(KCL_UI_LABEL)Watching certificate-requests ...'; $(NORMAL)

_kcl_watch_certificaterequests_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching certificate-requests-set "$(KCL_CERTIFICATEREQUESTS_SET_NAME)" ...'; $(NORMAL)
