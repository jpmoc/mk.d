_KUBECTL_INGRESS_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_INGRESS_CURL?= curl
# KCL_INGRESS_DNSNAME?= a4d6dd3895fd643ecb2a5469011add69-1354106678.us-east-1.elb.amazonaws.com
# KCL_INGRESS_DNSNAME_DOMAIN?= domain.com
# KCL_INGRESS_DNSNAME_HOSTNAME?= hostname
# KCL_INGRESS_DNSNAME_SUBDOMAIN?= sub.domain.com
# KCL_INGRESS_NAME?= hello
# KCL_INGRESS_NAMESPACE_NAME?= default
KCL_INGRESS_PORT?= 80
KCL_INGRESS_PROTOCOL?= http://
# KCL_INGRESS_SERVICES_SELECTOR?=
# KCL_INGRESS_URL?= http://127.0.0.1:80
# KCL_INGRESS_URL_DNSNAME?= hostname.sub.domain.com 
# KCL_INGRESS_URL_PATH?= /my/path
# KCL_INGRESS_URL_PORT?= :443
# KCL_INGRESS_URL_PROTOCOL?= https://
# KCL_INGRESSES_MANIFEST_DIRPATH?= ./in/
# KCL_INGRESSES_MANIFEST_FILENAME?= manifest.yaml
# KCL_INGRESSES_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_INGRESSES_MANIFEST_STDINFLAG?= false
# KCL_INGRESSES_MANIFEST_URL?= http://domain.com/manifest.yaml
# KCL_INGRESSES_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_INGRESSES_NAMESPACE_NAME?= default
# KCL_INGRESSES_SELECTOR?=
# KCL_INGRESSES_SET_NAME?= my-ingresses-set

# Derived parameters
KCL_INGRESS_CURL?= $(KCL_CURL)
KCL_INGRESS_DNSNAME?= $(KCL_INGRESS_DNSNAME_HOSTNAME).$(KCL_INGRESS_DNSNAME_SUBDOMAIN)
KCL_INGRESS_DNSNAME_SUBDOMAIN?= $(KCL_INGRESS_DNSNAME_DOMAIN)
KCL_INGRESS_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_INGRESS_URL?= $(KCL_INGRESS_PROTOCOL)$(KCL_INGRESS_URL_DNSNAME)$(KCL_INGRESS_URL_PORT)$(KCL_INGRESS_URL_PATH)
KCL_INGRESS_URL_DNSNAME?= $(KCL_INGRESS_DNSNAME)
KCL_INGRESSES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_INGRESSES_MANIFEST_FILEPATH?= $(if $(KCL_INGRESSES_MANIFEST_FILENAME),$(KCL_INGRESSES_MANIFEST_DIRPATH)$(KCL_INGRESSES_MANIFEST_FILENAME))
KCL_INGRESSES_NAMESPACE_NAME?= $(KCL_INGRESS_NAMESPACE_NAME)
KCL_INGRESSES_SET_NAME?= $(KCL_INGRESSES_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__INGRESSES+= $(if $(KCL_INGRESSES_MANIFEST_FILEPATH),--filename $(KCL_INGRESSES_MANIFEST_FILEPATH))
__KCL_FILENAME__INGRESSES+= $(if $(filter true,$(KCL_INGRESSES_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__INGRESSES+= $(if $(KCL_INGRESSES_MANIFEST_URL),--filename $(KCL_INGRESSES_MANIFEST_URL))
__KCL_FILENAME__INGRESSES+= $(if $(KCL_INGRESSES_MANIFESTS_DIRPATH),--filename $(KCL_INGRESSES_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__INGRESS= $(if $(KCL_INGRESS_NAMESPACE_NAME),--namespace $(KCL_INGRESS_NAMESPACE_NAME))
__KCL_NAMESPACE__INGRESSES= $(if $(KCL_INGRESSES_NAMESPACE_NAME),--namespace $(KCL_INGRESSES_NAMESPACE_NAME))
__KCL_SELECTOR__INGRESSES= $(if $(KCL_INGRESSES_SELECTOR),--selector=$(KCL_INGRESSES_SELECTOR))

# UI parameters
_KCL_APPLY_INGRESSES_|?= #
_KCL_CURL_INGRESS_|?= #
_KCL_DIFF_INGRESSES_|?= $(_KCL_APPLY_INGRESSES_|)
_KCL_DIG_INGRESS_|?= #
_KCL_UNAPPLY_INGRESSES_|?= $(_KCL_APPLY_INGRESSES_|)
|_KCL_CURL_INGRESS?= #
|_KCL_DIG_INGRESS?= #

#--- MACROS

_kcl_get_ingress_ip_or_dnsname= $(call _kcl_get_ingress_ip_or_dnsname_N, $(KCL_INGRESS_NAME))
_kcl_get_ingress_ip_or_dnsname_N= $(call _kcl_get_ingress_ip_or_dnsname_NN, $(1), $(KCL_INGRESS_NAMESPACE_NAME))
_kcl_get_ingress_ip_or_dnsname_NN= $(shell $(KUBECTL) get ingress --namespace $(2) $(1) --output jsonpath='{.status.loadBalancer.ingress[*].hostname}')

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Ingress ($(_KUBECTL_INGRESS_MK_VERSION)) macros:'
	@echo '    _kcl_get_ingress_address_{N|NN}        - Get the address of a ingress (Name,Namespace)'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Ingress ($(_KUBECTL_INGRESS_MK_VERSION)) parameters:'
	@echo '    KCL_INGRESS_DNSNAME=$(KCL_INGRESS_DNSNAME)'
	@echo '    KCL_INGRESS_DNSNAME_DOMAIN=$(KCL_INGRESS_DNSNAME_DOMAIN)'
	@echo '    KCL_INGRESS_DNSNAME_HOSTNAME=$(KCL_INGRESS_DNSNAME_HOSTNAME)'
	@echo '    KCL_INGRESS_DNSNAME_SUBDOMAIN=$(KCL_INGRESS_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_INGRESS_NAME=$(KCL_INGRESS_NAME)'
	@echo '    KCL_INGRESS_NAMESPACE_NAME=$(KCL_INGRESS_NAMESPACE_NAME)'
	@echo '    KCL_INGRESS_SERVICES_SELECTOR=$(KCL_INGRESSES_SERVICES_SELECTOR)'
	@echo '    KCL_INGRESS_URL=$(KCL_INGRESS_URL)'
	@echo '    KCL_INGRESS_URL_DNSNAME=$(KCL_INGRESS_URL_DNSNAME)'
	@echo '    KCL_INGRESS_URL_PATH=$(KCL_INGRESS_URL_PATH)'
	@echo '    KCL_INGRESS_URL_PORT=$(KCL_INGRESS_URL_PORT)'
	@echo '    KCL_INGRESS_URL_PROTOCOL=$(KCL_INGRESS_URL_PROTOCOL)'
	@echo '    KCL_INGRESSES_MANIFEST_DIRPATH=$(KCL_INGRESSES_MANIFEST_DIRPATH)'
	@echo '    KCL_INGRESSES_MANIFEST_FILENAME=$(KCL_INGRESSES_MANIFEST_FILENAME)'
	@echo '    KCL_INGRESSES_MANIFEST_FILEPATH=$(KCL_INGRESSES_MANIFEST_FILEPATH)'
	@echo '    KCL_INGRESSES_MANIFEST_STDINFLAG=$(KCL_INGRESSES_MANIFEST_STDINFLAG)'
	@echo '    KCL_INGRESSES_MANIFEST_URL=$(KCL_INGRESSES_MANIFEST_URL)'
	@echo '    KCL_INGRESSES_MANIFESTS_DIRPATH=$(KCL_INGRESSES_MANIFESTS_DIRPATH)'
	@echo '    KCL_INGRESSES_NAMESPACE_NAME=$(KCL_INGRESSES_NAMESPACE_NAME)'
	@echo '    KCL_INGRESSES_SELECTOR=$(KCL_INGRESSES_SELECTOR)'
	@echo '    KCL_INGRESSES_SET_NAME=$(KCL_INGRESSES_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Ingress ($(_KUBECTL_INGRESS_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_ingress                - Annotate a ingress'
	@echo '    _kcl_apply_ingresses                 - Apply a manifest for one-or-more ingresses'
	@echo '    _kcl_create_ingress                  - Create a ingress'
	@echo '    _kcl_curl_ingress                    - Curl an ingress'
	@echo '    _kcl_delete_ingress                  - Delete an ingress'
	@echo '    _kcl_diff_ingresses                  - Diff a manifest for one-or-more ingresses'
	@echo '    _kcl_dig_ingress                     - Dig an ingress'
	@echo '    _kcl_edit_ingress                    - Edit a ingress'
	@echo '    _kcl_explain_ingress                 - Explain the ingress object'
	@echo '    _kcl_label_ingress                   - Label a ingress'
	@echo '    _kcl_show_ingress                    - Show everything related to a ingress'
	@echo '    _kcl_show_ingress_certificates       - Show the certificates of a ingress'
	@echo '    _kcl_show_ingress_description        - Show the description of a ingress'
	@echo '    _kcl_show_ingress_services           - Show the services of a ingress'
	@echo '    _kcl_unapply_ingresses               - Un-apply a manifest for one-or-more ingresses'
	@echo '    _kcl_list_ingresses                  - List all ingresses'
	@echo '    _kcl_list_ingresses_set              - List set of ingresses'
	@echo '    _kcl_watch_ingresses                 - Watch all ingresses'
	@echo '    _kcl_watch_ingresses_set             - Watch set of ingresses'
	@echo '    _kcl_wirte_ingresses                 - Write manifest for one-or-more ingresses'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_ingress:

_kcl_apply_ingress: _kcl_apply_ingresses
_kcl_apply_ingresses:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifests for one-or-more ingresses ...'; $(NORMAL)
	$(if $(KCL_INGRESSES_MANIFEST_FILEPATH),cat $(KCL_INGRESSES_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_INGRESSES_MANIFEST_STDINFLAG)),$(_KCL_APPLY_INGRESSES_|)cat)
	$(if $(KCL_INGRESSES_MANIFEST_URL),curl -L $(KCL_INGRESSES_MANIFEST_URL))
	$(if $(KCL_INGRESSES_MANIFESTS_DIRPATH),ls -al $(KCL_INGRESSES_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_INGRESSES_|)$(KUBECTL) apply $(__KCL_FILENAME__INGRESSES) $(__KCL_NAMESPACE__INGRESSES) --validate=true

_kcl_create_ingress:
	@$(INFO) '$(KCL_UI_LABEL)Creating ingress "$(KCL_INGRESS_NAME)" ...'; $(NORMAL)
	#$(KUBECTL) run $(KCL_INGRESS_NAME) $(__KCL_IMAGE__INGRESS) $(__KCL_NAMESPACE__INGRESS) $(__KCL_RESTART__INGRESS) -- $(KCL_INGRESS_COMMAND)

_kcl_curl_ingress:
	@$(INFO) '$(KCL_UI_LABEL)Curl ingress "$(KCL_INGRESS_NAME)" ...'; $(NORMAL)
	$(_KCL_CURL_INGRESS_|)$(KCL_INGRESS_CURL) $(KCL_INGRESS_URL) $(|_KCL_CURL_INGRESS)

_kcl_delete_ingress:
	@$(INFO) '$(KCL_UI_LABEL)Deleting ingress "$(KCL_INGRESS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete ingress $(__KCL_NAMESPACE__INGRESS) $(KCL_INGRESS_NAME)

_kcl_diff_ingress: _kcl_diff_ingresses
_kcl_diff_ingresses:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more ingresses ...'; $(NORMAL)
	@$(WARN) 'This operation submits the manifest to the cluster to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_INGRESSES_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_INGRESSES_|)cat
	# curl -L $(KCL_INGRESSES_MANIFEST_URL)
	# ls -al $(KCL_INGRESSES_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_INGRESSES_|)$(KUBECTL) diff $(__KCL_FILENAME__INGRESSES) $(__KCL_NAMESPACE__INGRESSES)

_kcl_edit_ingress:
	@$(INFO) '$(KCL_UI_LABEL)Editing ingress "$(KCL_INGRESS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit ingress $(__KCL_NAMESPACE__INGRESS) $(KCL_INGRESS_NAME)

_kcl_explain_ingress:
	@$(INFO) '$(KCL_UI_LABEL)Explaining ingress object ...'; $(NORMAL)
	$(KUBECTL) explain ingress

_kcl_label_ingress:
	@$(INFO) '$(KCL_UI_LABEL)Labeling ingress "$(KCL_INGRESS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label ingress $(__KCL_NAMESPACE__INGRESS) $(KCL_INGRESS_NAME)

_kcl_list_ingresses:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL ingresses ...'; $(NORMAL)
	$(KUBECTL) get ingress --all-namespaces=true $(_X__KCL_NAMESPACE__INGRESSES) $(_X__KCL_SELECTOR__INGRESSES)

_kcl_list_ingresses_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing ingresses-set "$(KCL_INGRESSS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Ingresses are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get ingress --all-namespaces=false $(__KCL_NAMESPACE__INGRESSES) $(__KCL_SELECTOR__INGRESSES)

_KCL_SHOW_INGRESS_TARGETS?= _kcl_show_ingress_certificates _kcl_show_ingress_services _kcl_show_ingress_description
_kcl_show_ingress: $(_KCL_SHOW_INGRESS_TARGETS)

_kcl_show_ingress_certificates:
	@$(INFO) '$(KCL_UI_LABEL)Showing certificates for ingress "$(KCL_INGRESS_NAME)" ...'; $(NORMAL)

_kcl_show_ingress_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description ingress "$(KCL_INGRESS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe ingress $(__KCL_NAMESPACE__INGRESS) $(KCL_INGRESS_NAME)

_kcl_show_ingress_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing services for ingress "$(KCL_INGRESS_NAME)" ...'; $(NORMAL)
	$(if $(KCL_INGRESS_SERVICE_SELECTOR), \
		$(KUBECTL) get services $(__KCL_NAMESPACE__INGRESS) --selector $(KCL_INGRESS_SERVICE_SELECTOR), \
		@echo 'KCL_INGRESS_SERVICE_SELECTOR not set' \
	)

_kcl_unapply_ingress: _kcl_unapply_ingresses
_kcl_unapply_ingresses:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifests for one-or-more ingress ...'; $(NORMAL)
	# cat $(KCL_INGRESSES_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_INGRESSES_|)cat
	# curl -L $(KCL_INGRESSES_MANIFEST_URL)
	# ls -al $(KCL_INGRESSES_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_INGRESSES_|)$(KUBECTL) apply $(__KCL_FILENAME__INGRESSES) $(__KCL_NAMESPACE__INGRESSES) --validate=true

_kcl_update_ingress:
	@$(INFO) '$(KCL_UI_LABEL)Updating ingress "$(KCL_INGRESS_NAME)" ...'; $(NORMAL)

_kcl_watch_ingresses:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL ingresses ...'; $(NORMAL)
	$(KUBECTL) get ingresss --all-namespaces=true --watch 

_kcl_watching_ingresses_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching ingresses-set "$(KCL_INGRESSS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Ingresses are grouped based on the provided namespace, selector, and ...'; $(NORMAL)

_kcl_write_ingress: _kcl_write_ingresses
_kcl_write_ingresses:
	@$(INFO) '$(KCL_UI_LABEL)Writing amnifest for one-or-more ingresses ...'; $(NORMAL)
	$(WRITE) $(KCL_INGRESSES_MANIFEST_FILEPATH)
