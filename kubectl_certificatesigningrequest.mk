_KUBECTL_CERTIFICATESIGNINGREQUEST_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_CERTIFICATESIGNINGREQUEST_CONFIG_DIRPATH?= ./in/
# KCL_CERTIFICATESIGNINGREQUEST_CONFIG_FILENAME?= csr-config.json
# KCL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH?= ./in/csr-config.json
# KCL_CERTIFICATESIGNINGREQUEST_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_CERTIFICATESIGNINGREQUEST_NAME?= 
# KCL_CERTIFICATESIGNINGREQUESTS_FIELDSELECTOR?= metadata.name=my-certificate-signing-request
# KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_DIRPATH?= ./in/
# KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILENAME?= manifest.yaml 
# KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILEPATH?= ./in/manifest.yaml
# KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_URL?= http://...
# KCL_CERTIFICATESIGNINGREQUESTS_MANIFESTS_DIRPATH?= ./in/
# KCL_CERTIFICATESIGNINGREQUESTS_SELECTOR?=
# KCL_CERTIFICATESIGNINGREQUESTS_SET_NAME?= my-certificatesigningrequests-set
KCL_CERTIFICATESIGNINGREQUESTS_STDIN_FLAG?= false

# Derived parameters
KCL_CERTIFICATESIGNINGREQUEST_CONFIG_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH?= $(KCL_CERTIFICATESIGNINGREQUEST_CONFIG_DIRPATH)$(KCL_CERTIFICATESIGNINGREQUEST_CONFIG_FILENAME)
KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILEPATH?= $(if $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILENAME),$(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_DIRPATH)$(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILENAME))
KCL_CERTIFICATESIGNINGREQUESTS_SET_NAME?= $(HOSTNAME)

# Options
__KCL_FILENAME__CERTIFICATESIGNINGREQUESTS+= $(if $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILEPATH),--filename $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILEPATH))
__KCL_FILENAME__CERTIFICATESIGNINGREQUESTS+= $(if $(filter true, $(KCL_CERTIFICATESIGNINGREQUESTS_STDINFLAG)),--filename -)
__KCL_FILENAME__CERTIFICATESIGNINGREQUESTS+= $(if $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_URL),--filename $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_URL))
__KCL_FILENAME__CERTIFICATESIGNINGREQUESTS+= $(if $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFESTS_DIRPATH),--filename $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFESTS_DIRPATH))

# Customizations
_KCL_APPLY_CERTIFICATESIGNINGREQUESTS_|?= #
_KCL_DIFF_CERTIFICATESIGNINGREQUESTS_|?= $(_KCL_APPLY_CERTIFICATESIGNINGREQUESTS_|)
_KCL_UNAPPLY_CERTIFICATESIGNINGREQUESTS_|?= $(_KCL_APPLY_CERTIFICATESIGNINGREQUESTS_|)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::CertificateSigningRequest ($(_KUBECTL_CERTIFICATESIGNINGREQUEST_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::CertificateSigningRequest ($(_KUBECTL_CERTIFICATESIGNINGREQUEST_MK_VERSION)) parameters:'
	@echo '    KCL_CERTIFICATESIGNINGREQUEST_CONFIG_DIRPATH=$(KCL_CERTIFICATESIGNINGREQUEST_CONFIG_DIRPATH)'
	@echo '    KCL_CERTIFICATESIGNINGREQUEST_CONFIG_FILENAME=$(KCL_CERTIFICATESIGNINGREQUEST_CONFIG_FILENAME)'
	@echo '    KCL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH=$(KCL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH)'
	@echo '    KCL_CERTIFICATESIGNINGREQUEST_LABELS_KEYVALUES=$(KCL_CERTIFICATESIGNINGREQUEST_LABELS_KEYVALUES)'
	@echo '    KCL_CERTIFICATESIGNINGREQUEST_NAME=$(KCL_CERTIFICATESIGNINGREQUEST_NAME)'
	@echo '    KCL_CERTIFICATESIGNINGREQUESTS_FIELDSELECTOR=$(KCL_CERTIFICATESIGNINGREQUESTS_FIELDSELECTOR)'
	@echo '    KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_DIRPATH=$(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_DIRPATH)'
	@echo '    KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILENAME=$(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILENAME)'
	@echo '    KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILEPATH=$(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILEPATH)'
	@echo '    KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_URL=$(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_URL)'
	@echo '    KCL_CERTIFICATESIGNINGREQUESTS_MANIFESTS_DIRPATH=$(KCL_CERTIFICATESIGNINGREQUESTS_MANIFESTS_DIRPATH)'
	@echo '    KCL_CERTIFICATESIGNINGREQUESTS_SELECTOR=$(KCL_CERTIFICATESIGNINGREQUESTS_SELECTOR)'
	@echo '    KCL_CERTIFICATESIGNINGREQUESTS_SET_NAME=$(KCL_CERTIFICATESIGNINGREQUESTS_SET_NAME)'
	@echo '    KCL_CERTIFICATESIGNINGREQUESTS_STDIN_FLAG=$(KCL_CERTIFICATESIGNINGREQUESTS_STDIN_FLAG)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::CertificateSigningRequest ($(_KUBECTL_CERTIFICATESIGNINGREQUEST_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_certificatesigningrequest               - Annotate a certificate-signing-request'
	@echo '    _kcl_apply_certificatesigningrequest                  - Apply a manifest for one-or-more certificate-signing-requests'
	@echo '    _kcl_approve_certificatesigningrequest                - Approve a certificate-signing-request'
	@echo '    _kcl_create_certificatesigningrequest                 - Create a new certificate-signing-request'
	@echo '    _kcl_delete_certificatesigningrequest                 - Delete an existing certificate-signing-request'
	@echo '    _kcl_deny_certificatesigningrequest                   - Deny a certificate-signing-request'
	@echo '    _kcl_diff_certificatesigningrequest                   - Diff a manifest for one or more certificate-signing-requests'
	@echo '    _kcl_edit_certificatesigningrequest                   - Edit a certificate-signing-request'
	@echo '    _kcl_explain_certificatesigningrequest                - Explain the certificate-signing-request object'
	@echo '    _kcl_list_certificatesigningrequests                  - List certificate-signing-requests'
	@echo '    _kcl_list_certificatesigningrequests_set              - List set of certificate-signing-requests'
	@echo '    _kcl_show_certificatesigningrequest                   - Show everything related to a certificate-signing-request'
	@echo '    _kcl_show_certificatesigningrequest_description       - Show description of a certificate-signing-request'
	@echo '    _kcl_show_certificatesigningrequest_state             - Show state of a certificate-signing-request'
	@echo '    _kcl_unapply_certificatesigningrequest                - Un-apply a manifest for a certificate-signing-request'
	@echo '    _kcl_unlabel_certificatesigningrequest                - Un-label a certificate-signing-request'
	@echo '    _kcl_patch_certificatesigningrequest                  - Patch a certificate-signing-request'
	@echo '    _kcl_watch_certificatesigningrequests                 - Watch certificate-signing-requests'
	@echo '    _kcl_watch_certificatesigningrequests_set             - Watch a set of certificate-signing-requests'
	@echo '    _kcl_write_certificatesigningrequests                 - Write manifest for one-or-more certificate-signing-requests'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_certificatesigningrequest:
	@$(INFO) '$(KCL_UI_LABEL)Annotating certificate-signing-request "$(KCL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)

_kcl_apply_certificatesigningrequest: _kcl_apply_certificatesigningrequests
_kcl_apply_certificatesigningrequests:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more certificate-signing-requests ...'; $(NORMAL)
	$(if $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILEPATH),cat $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_CERTIFICATESIGNINGREQUESTS_STDIN_FLAG)),$(_KCL_APPLY_CERTIFICATESIGNINGREQUESTS_|)cat)
	$(if $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_URL),curl -L $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_URL))
	$(if $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFESTS_DIRPATH),ls -al $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_CERTIFICATESIGNINGREQUESTS_|)$(KUBECTL) apply $(__KCL_FILENAME__CERTIFICATESIGNINGREQUESTS)

_kcl_approve_certificatesigningrequest:
	@$(INFO) '$(KCL_UI_LABEL)Approving certificate-signing-request "$(KCL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) certificate approve $(KCL_CERTIFICATESIGNINGREQUEST_NAME)

_kcl_create_certificatesigningrequest:
	@$(INFO) '$(KCL_UI_LABEL)Creating certificate-signing-request "$(KCL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create certificatesigningrequest $(KCL_CERTIFICATESIGNINGREQUEST_NAME)

_kcl_delete_certificatesigningrequest:
	@$(INFO) '$(KCL_UI_LABEL)Deleting certificate-signing-request "$(KCL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete certificatesigningrequest $(KCL_CERTIFICATESIGNINGREQUEST_NAME)

_kcl_deny_certificatesigningrequest:
	@$(INFO) '$(KCL_UI_LABEL)Deny certificate-signing-request "$(KCL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) certificate deny $(KCL_CERTIFICATESIGNINGREQUEST_NAME)

_kcl_diff_certificatesigningrequest: _kcl_diff_certificatesigningrequests
_kcl_diff_certificatesigningrequests:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more certificate-signing-requests ...'; $(NORMAL)
	@$(WARN) 'This operation submits the manifest to the cluster to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_CERTIFICATESIGNINGREQUESTS_|)cat
	# curl -L $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_URL)
	# ls -al $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_CERTIFICATESIGNINGREQUESTS)$(KUBECTL) diff $(__KCL_FILENAME__CERTIFICATESIGNINGREQUESTS)

_kcl_edit_certificatesigningrequest:
	@$(INFO) '$(KCL_UI_LABEL)Editing certificate-signing-request "$(KCL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit certificatesigningrequest $(KCL_CERTIFICATESIGNINGREQUEST_NAME)

_kcl_explain_certificatesigningrequest:
	@$(INFO) '$(KCL_UI_LABEL)Explaining certificate-signing-request object ...'; $(NORMAL)
	$(KUBECTL) explain certificatesigningrequest

_kcl_label_certificatesigningrequest:
	@$(INFO) '$(KCL_UI_LABEL)Labelling certificate-signing-request "$(KCL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label certificatesigningrequest $(KCL_CERTIFICATESIGNINGREQUEST_NAME) $(KCL_CERTIFICATESIGNINGREQUEST_LABELS_KEYVALUES)

_kcl_list_certificatesigningrequests:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL certificate-signing-requests ...'; $(NORMAL)
	$(KUBECTL) get certificatesigningrequests $(_X__KCL_SELECTOR_CERTIFICATESIGNINGREQUESTS)

_kcl_list_certificatesigningrequests_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing certificate-signing-requests-set "$(KCL_CERTIFICATESIGNINGREQUESTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Certificate-signing-requests are grouped based on field-selector, selector, ...'; $(NORMAL)
	$(KUBECTL) get certificatesigningrequests $(__KCL_FIELD_SELECTOR__CERTIFICATESIGNINGREQUESTS) $(__KCL_SELECTOR__CERTIFICATESIGNINGREQUESTS)

_kcl_patch_certificatesigningrequest:
	@$(INFO) '$(KCL_UI_LABEL)Patching certificate-signing-request "$(KCL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)

_KCL_SHOW_CERTIFICATESIGNINGREQUEST_TARGETS?= _kcl_show_certificatesigningrequest_state _kcl_show_certificatesigningrequest_description
_kcl_show_certificatesigningrequest: $(_KCL_SHOW_CERTIFICATESIGNINGREQUEST_TARGETS)

_kcl_show_certificatesigningrequest_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of certificate-signing-request "$(KCL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe certificatesigningrequest $(KCL_CERTIFICATESIGNINGREQUEST_NAME) 

_kcl_show_certificatesigningrequest_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of certificate-signing-request "$(KCL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get certificatesigningrequest $(KCL_CERTIFICATESIGNINGREQUEST_NAME) 

_kcl_unapply_certificatesigningrequest: _kcl_unapply_certificatesigningrequests
_kcl_unapply_certificatesigningrequests:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more certificate-signing-requests ...'; $(NORMAL)
	# cat $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_CERTIFICATESIGNINGREQUESTS_|)cat
	# curl -L $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFEST_URL)
	# ls -al $(KCL_CERTIFICATESIGNINGREQUESTS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_CERTIFICATESIGNINGREQUESTS_|)$(KUBECTL) delete $(__KCL_FILENAME__CERTIFICATESIGNINGREQUESTS)

_kcl_unlabel_certificatesigningrequest:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling certificate-signing-request "$(KCL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)

_kcl_watch_certificatesigningrequests:
	@$(INFO) '$(KCL_UI_LABEL)Watching certificate-signing-requests ...'; $(NORMAL)

_kcl_watch_certificatesigningrequests_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching certificate-signing-requests-set "$(KCL_CERTIFICATESIGNINGREQUESTS_SET_NAME)" ...'; $(NORMAL)

_kcl_write_certificatesigningrequests:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more  certificate-signing-requests ...'; $(NORMAL)
	$(WRITER) $(KCL_CERTIFICATESIGNINGREQUETS_MANIFEST_FILEPATH)

