_KUBECTL_CERTMANAGER_CERTIFICATE_MK_VERSION= $(_KUBECTL_CERTMANAGER_MK_VERSION)

# KCL_CERTIFICATE_ISSUER_NAME?= my-issuer
# KCL_CERTIFICATE_LABELS_KEYVALUES?= key=value ...
# KCL_CERTIFICATE_NAME?= 
# KCL_CERTIFICATE_NAMESPACE_NAME?= default
# KCL_CERTIFICATE_SECRET_NAME?= my-certificate-tls
# KCL_CERTIFICATES_FIELDSELECTOR?= metadata.name=my-certificate
# KCL_CERTIFICATES_MANIFEST_DIRPATH?= ./in/
# KCL_CERTIFICATES_MANIFEST_FILENAME?= certificate.yaml 
# KCL_CERTIFICATES_MANIFEST_FILEPATH?= ./in/certificate.yaml 
# KCL_CERTIFICATES_MANIFEST_URL?= http://domain.com/manifest.yaml
# KCL_CERTIFICATES_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_CERTIFICATES_NAMESPACE_NAME?= default
# KCL_CERTIFICATES_SELECTOR?=
# KCL_CERTIFICATES_SET_NAME?= my-certificatesigningrequests-set

# Derived parameters
KCL_CERTIFICATE_ISSUER_NAME?= $(KCL_ISSUER_NAME)
KCL_CERTIFICATE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_CERTIFICATE_SECRET_NAME?= $(KCL_SECRET_NAME)
KCL_CERTIFICATES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CERTIFICATES_MANIFEST_FILEPATH?= $(if $(KCL_CERTIFICATES_MANIFEST_FILENAME),$(KCL_CERTIFICATES_MANIFEST_DIRPATH)$(KCL_CERTIFICATES_MANIFEST_FILENAME))
KCL_CERTIFICATES_NAMESPACE_NAME?= $(KCL_CERTIFICATE_NAMESPACE_NAME)
KCL_CERTIFICATES_SET_NAME?= certificates@@@$(KCL_CERTIFICATES_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__CERTIFICATES+= $(if $(KCL_CERTIFICATES_MANIFEST_FILEPATH),--filename $(KCL_CERTIFICATES_MANIFEST_FILEPATH))
__KCL_FILENAME__CERTIFICATES+= $(if $(KCL_CERTIFICATES_MANIFEST_URL),--filename $(KCL_CERTIFICATES_MANIFEST_URL))
__KCL_FILENAME__CERTIFICATES+= $(if $(KCL_CERTIFICATES_MANIFEST_URL),--filename $(KCL_CERTIFICATES_MANIFEST_URL))
__KCL_FILENAME__CERTIFICATES+= $(if $(KCL_CERTIFICATES_MANIFESTS_DIRPATH),--filename $(KCL_CERTIFICATES_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__CERTIFICATE= $(if $(KCL_CERTIFICATE_NAMESPACE_NAME),--namespace $(KCL_CERTIFICATE_NAMESPACE_NAME))
__KCL_NAMESPACE__CERTIFICATES= $(if $(KCL_CERTIFICATES_NAMESPACE_NAME),--namespace $(KCL_CERTIFICATES_NAMESPACE_NAME))

# Pipe parameters
|_KCL_SHOW_CERTIFICATE_SECRETCACERT?= --output json | jq -r '.data."ca.crt"' | base64 --decode | openssl x509 -text; echo
|_KCL_SHOW_CERTIFICATE_SECRETCERTIFICATE?= --output json | jq -r '.data."tls.crt"' | base64 --decode | openssl x509 -text; echo
|_KCL_SHOW_CERTIFICATE_SECRETPRIVATEKEY?= --output json | jq -r '.data."tls.key"' | base64 --decode | head -3; echo '...'

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::CertManager::Certificate ($(_KUBECTL_CERTMANAGER_CERTIFICATE_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::CertManager::Certificate ($(_KUBECTL_CERTMANAGER_CERTIFICATE_MK_VERSION)) parameters:'
	@echo '    KCL_CERTIFICATE_ISSUER_NAME=$(KCL_CERTIFICATE_ISSUER_NAME)'
	@echo '    KCL_CERTIFICATE_LABELS_KEYVALUES=$(KCL_CERTIFICATE_LABELS_KEYVALUES)'
	@echo '    KCL_CERTIFICATE_NAME=$(KCL_CERTIFICATE_NAME)'
	@echo '    KCL_CERTIFICATE_NAMESPACE_NAME=$(KCL_CERTIFICATE_NAMESPACE_NAME)'
	@echo '    KCL_CERTIFICATE_SECRET_NAME=$(KCL_CERTIFICATE_SECRET_NAME)'
	@echo '    KCL_CERTIFICATES_FIELDSELECTOR=$(KCL_CERTIFICATES_FIELDSELECTOR)'
	@echo '    KCL_CERTIFICATES_MANIFEST_DIRPATH=$(KCL_CERTIFICATES_MANIFEST_DIRPATH)'
	@echo '    KCL_CERTIFICATES_MANIFEST_FILENAME=$(KCL_CERTIFICATES_MANIFEST_FILENAME)'
	@echo '    KCL_CERTIFICATES_MANIFEST_FILEPATH=$(KCL_CERTIFICATES_MANIFEST_FILEPATH)'
	@echo '    KCL_CERTIFICATES_MANIFEST_URL=$(KCL_CERTIFICATES_MANIFEST_URL)'
	@echo '    KCL_CERTIFICATES_MANIFESTS_DIRPATH=$(KCL_CERTIFICATES_MANIFESTS_DIRPATH)'
	@echo '    KCL_CERTIFICATES_NAMESPACE_NAME=$(KCL_CERTIFICATES_NAMESPACE_NAME)'
	@echo '    KCL_CERTIFICATES_SELECTOR=$(KCL_CERTIFICATES_SELECTOR)'
	@echo '    KCL_CERTIFICATES_SET_NAME=$(KCL_CERTIFICATES_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::CertManager::Certificate ($(_KUBECTL_CERTMANAGER_CERTIFICATE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_certificate                 - Annotate a certificate'
	@echo '    _kcl_apply_certificates                   - Apply a manifest for one-or-more certificates'
	@echo '    _kcl_create_certificate                   - Create a new certificate'
	@echo '    _kcl_delete_certificate                   - Delete an existing certificate'
	@echo '    _kcl_diff_certificate                     - Diff a manifest for one or more certificates'
	@echo '    _kcl_edit_certificate                     - Edit a certificate'
	@echo '    _kcl_explain_certificate                  - Explain the certificate object'
	@echo '    _kcl_show_certificate                     - Show everything related to a certificate'
	@echo '    _kcl_show_certificate_description         - Show description of a certificate'
	@echo '    _kcl_show_certificate_issuer              - Show issuer of a certificate'
	@echo '    _kcl_show_certificate_secret              - Show secret of a certificate'
	@echo '    _kcl_show_certificate_state               - Show state of a certificate'
	@echo '    _kcl_unapply_certificates                 - Un-apply a manifest for a certificate'
	@echo '    _kcl_unlabel_certificate                  - Un-label a certificate'
	@echo '    _kcl_update_certificate                   - Update a certificate'
	@echo '    _kcl_view_certificates                    - View certificates'
	@echo '    _kcl_view_certificates_set                - View set of certificates'
	@echo '    _kcl_watch_certificates                   - Watch certificates'
	@echo '    _kcl_watch_certificates_set               - Watch a set of certificates'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_certificate:
	@$(INFO) '$(KCL_UI_LABEL)Annotating certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)

_kcl_apply_certificate: _kcl_apply_certificates
_kcl_apply_certificates:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more certificates ...'; $(NORMAL)
	$(if $(KCL_CERTIFICATES_MANIFEST_FILEPATH), cat $(KCL_CERTIFICATES_MANIFEST_FILEPATH); echo)
	$(if $(KCL_CERTIFICATES_MANIFEST_URL), curl -L $(KCL_CERTIFICATES_MANIFEST_URL); echo)
	$(if $(KCL_CERTIFICATES_MANIFESTS_DIRPATH), ls -al $(KCL_CERTIFICATES_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__CERTIFICATES) $(__KCL_NAMESPACE__CERTIFICATES)

_kcl_create_certificate:
	@$(INFO) '$(KCL_UI_LABEL)Creating certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create certificate $(__KCL_NAMESPACE__CERTIFICATE) $(KCL_CERTIFICATE_NAME)

_kcl_delete_certificate:
	@$(INFO) '$(KCL_UI_LABEL)Deleting certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete certificate $(__KCL_NAMESPACE__CERTIFICATE) $(KCL_CERTIFICATE_NAME)

_kcl_diff_certificate: _kcl_diff_certificates
_kcl_diff_certificates:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more certificates ...'; $(NORMAL)
	# cat $(KCL_CERTIFICATES_MANIFEST_FILEPATH)
	# curl -L $(KCL_CERTIFICATES_MANIFEST_URL)
	# ls -al $(KCL_CERTIFICATES_MANIFESTS_DIRPATH)
	$(KUBECTL) diff $(__KCL_FILENAME__CERTIFICATES) $(__KCL_NAMESPACE__CERTIFICATES)

_kcl_edit_certificate:
	@$(INFO) '$(KCL_UI_LABEL)Editing certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit certificate $(__KCL_NAMESPACE__CERTIFICATE) $(KCL_CERTIFICATE_NAME)

_kcl_explain_certificate:
	@$(INFO) '$(KCL_UI_LABEL)Explaining certificate object ...'; $(NORMAL)
	$(KUBECTL) explain certificate

_kcl_label_certificate:
	@$(INFO) '$(KCL_UI_LABEL)Labelling certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label certificate $(__KCL_NAMESPACE__CERTIFICATE) $(KCL_CERTIFICATE_NAME) $(KCL_CERTIFICATE_LABELS_KEYVALUES)

_kcl_show_certificate :: _kcl_show_certificate_issuer _kcl_show_certificate_secret _kcl_show_certificate_state _kcl_show_certificate_description

_kcl_show_certificate_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe certificate $(__KCL_NAMESPACE__CERTIFICATE) $(KCL_CERTIFICATE_NAME) 

_kcl_show_certificate_issuer:
	@$(INFO) '$(KCL_UI_LABEL)Showing issuer of certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(if $(KCL_CERTIFICATE_ISSUER_NAME), \
		$(KUBECTL) get issuer  $(__KCL_NAMESPACE__CERTIFICATE) $(KCL_CERTIFICATE_ISSUER_NAME); \
	, @\
		echo 'KCL_CERTIFICATE_ISSUER_NAME not set ...'; \
	)

_kcl_show_certificate_secret:
	@$(INFO) '$(KCL_UI_LABEL)Showing secret of certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(if $(KCL_CERTIFICATE_SECRET_NAME), \
		$(KUBECTL) get secret $(__KCL_NAMESPACE__CERTIFICATE) $(KCL_CERTIFICATE_SECRET_NAME); \
	, @\
		echo 'KCL_CERTIFICATE_SECRET_NAME not set ...'; \
	)

_kcl_show_certificate_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get certificate $(__KCL_NAMESPACE__CERTIFICATE) $(KCL_CERTIFICATE_NAME) 

_kcl_unapply_certificate: _kcl_unapply_certificates
_kcl_unapply_certificates:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more certificates ...'; $(NORMAL)
	# cat $(KCL_CERTIFICATES_MANIFEST_FILEPATH)
	# curl -L $(KCL_CERTIFICATES_MANIFEST_URL)
	# ls -al $(KCL_CERTIFICATES_MANIFESTS_DIRPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__CERTIFICATES) $(__KCL_NAMESPACE__CERTIFICATES)

_kcl_unlabel_certificate:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)

_kcl_update_certificate:
	@$(INFO) '$(KCL_UI_LABEL)Updating certificate "$(KCL_CERTIFICATE_NAME)" ...'; $(NORMAL)

_kcl_view_certificates:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL certificates ...'; $(NORMAL)
	$(KUBECTL) get certificates --all-namespaces=true $(_X__KCL_NAMESPACE__CERTIFICATES) $(_X__KCL_SELECTOR_CERTIFICATES)

_kcl_view_certificates_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing certificates-set "$(KCL_CERTIFICATES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Certificates are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
	$(KUBECTL) get certificates --all-namespaces=false $(__KCL_FIELD_SELECTOR__CERTIFICATES) $(__KCL_NAMESPACE__CERTIFICATES) $(__KCL_SELECTOR__CERTIFICATES)

_kcl_watch_certificates:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL certificates ...'; $(NORMAL)

_kcl_watch_certificates_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching certificates-set "$(KCL_CERTIFICATES_SET_NAME)" ...'; $(NORMAL)
