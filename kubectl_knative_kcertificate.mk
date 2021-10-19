_KUBECTL_KNATIVE_KCERTIFICATE_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# JUST A DUMP! FEEL FREE TO MODIFY!

# KCL_KCERTIFICATE_DIG?= time dig +short
# KCL_KCERTIFICATE_DNSNAME?=
# KCL_KCERTIFICATE_DNSNAME_DOMAIN?= example.com
# KCL_KCERTIFICATE_DNSNAME_SUBDOMAIN?= go-helloworld.default.example.com
# KCL_KCERTIFICATE_KSERVICE_NAME?= go-helloworld
# KCL_KCERTIFICATE_KUSTOMIZATION_DIRPATH?= ./in/
# KCL_KCERTIFICATE_NAME?= go-helloworld-00001
# KCL_KCERTIFICATE_NAMESPACE_NAME?= default
# KCL_KCERTIFICATE_KCERTIFICATES_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_KCERTIFICATE_URL?= http://v1.go-helloworld.default.example.com
# KCL_KCERTIFICATE_URL_DNSNAME?= v1.go-helloworld.default.example.com
# KCL_KCERTIFICATE_URL_PATH?= /my/path
# KCL_KCERTIFICATE_URL_PROTOCOL?= http://
# KCL_KCERTIFICATE_URL_PORT?= :80
# KCL_KCERTIFICATES_FIELDSELECTOR?= metadata.name=my-kcertificate
# KCL_KCERTIFICATES_MANIFEST_DIRPATH?= ./in/
# KCL_KCERTIFICATES_MANIFEST_FILENAME?= manifest.yaml
# KCL_KCERTIFICATES_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_KCERTIFICATES_MANIFEST_STDINFLAG?= false
# KCL_KCERTIFICATES_MANIFEST_URL?= http://...
# KCL_KCERTIFICATES_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_KCERTIFICATES_NAMESPACE_NAME?= default
# KCL_KCERTIFICATES_OUTPUT?= wide
# KCL_KCERTIFICATES_SELECTOR?=
# KCL_KCERTIFICATES_SET_NAME?= my-set
# KCL_KCERTIFICATES_SHOW_LABELS?= true
# KCL_KCERTIFICATES_WATCH_ONLY?= true

# Derived parameters
KCL_KCERTIFICATE_CURL= $(KCL_KNATIVESERVING_CURL)
KCL_KCERTIFICATE_DIG= $(KCL_KNATIVESERVING_DIG)
KCL_KCERTIFICATE_DNSNAME?= $(KCL_KCERTIFICATE_NAME).$(KCL_KCERTIFICATE_DNSNAME_SUBDOMAIN)
KCL_KCERTIFICATE_DNSNAME_DOMAIN?= $(KCL_KNATIVESERVING_DNSNAME_DOMAIN)
KCL_KCERTIFICATE_DNSNAME_HOSTNAME?= $(KCL_KCERTIFICATE_NAME)
KCL_KCERTIFICATE_DNSNAME_SUBDOMAIN?= $(KCL_KCERTIFICATE_KSERVICE_NAME).$(KCL_KCERTIFICATE_NAMESPACE_NAME).$(KCL_KCERTIFICATE_DNSNAME_DOMAIN)
KCL_KCERTIFICATE_KSERVICE_NAME?= $(KCL_KSERVICE_NAME)
KCL_KCERTIFICATE_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_KCERTIFICATE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_KCERTIFICATE_NAME?= $(if $(KCL_KCERTIFICATE_ID),$(KCL_KCERTIFICATE_KSERVICE_NAME)-$(KCL_KCERTIFICATE_ID))
KCL_KCERTIFICATE_URL?= $(KCL_KCERTIFICATE_URL_PROTOCOL)$(KCL_KCERTIFICATE_URL_DNSNAME)$(KCL_KCERTIFICATE_URL_PORT)$(KCL_KCERTIFICATE_URL_PATH)
KCL_KCERTIFICATE_URL_DNSNAME?= $(KCL_KCERTIFICATE_DNSNAME)
KCL_KCERTIFICATES_DNSNAME_DOMAIN?= $(KCL_KCERTIFICATE_DNSNAME_DOMAIN)
KCL_KCERTIFICATES_DNSNAME_SUBDOMAIN?= $(KCL_KCERTIFICATES_KSERVICE_NAME).$(KCL_KCERTIFICATES_NAMESPACE_NAME).$(KCL_KCERTIFICATES_DNSNAME_DOMAIN)
KCL_KCERTIFICATES_KSERVICE_NAME?= $(KCL_KCERTIFICATE_KSERVICE_NAME)
KCL_KCERTIFICATES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_KCERTIFICATES_MANIFEST_FILEPATH?= $(if $(KCL_KCERTIFICATES_MANIFEST_FILENAME),$(KCL_KCERTIFICATES_MANIFEST_DIRPATH)$(KCL_KCERTIFICATES_MANIFEST_FILENAME))
KCL_KCERTIFICATES_NAMESPACE_NAME?= $(KCL_KCERTIFICATE_NAMESPACE_NAME)
KCL_KCERTIFICATES_SET_NAME?= kcertificates@$(KCL_KCERTIFICATES_FIELDSELECTOR)@$(KCL_KCERTIFICATES_SELECTOR)@$(KCL_KCERTIFICATES_NAMESPACE_NAME)

# Option parameters
__KCL_ALL_NAMESPACES__KCERTIFICATES=
__KCL_FIELD_SELECTOR__KCERTIFICATES= $(if $(KCL_KCERTIFICATES_FIELDSELECTOR),--field-selector $(KCL_KCERTIFICATES_FIELDSELECTOR))
__KCL_FILENAME__KCERTIFICATES+= $(if $(KCL_KCERTIFICATES_MANIFEST_FILEPATH),--filename $(KCL_KCERTIFICATES_MANIFEST_FILEPATH))
__KCL_FILENAME__KCERTIFICATES+= $(if $(filter true,$(KCL_KCERTIFICATES_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__KCERTIFICATES+= $(if $(KCL_KCERTIFICATES_MANIFEST_URL),--filename $(KCL_KCERTIFICATES_MANIFEST_URL))
__KCL_FILENAME__KCERTIFICATES+= $(if $(KCL_KCERTIFICATES_MANIFESTS_DIRPATH),--filename $(KCL_KCERTIFICATES_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__KCERTIFICATE= $(if $(KCL_KCERTIFICATE_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_KCERTIFICATE_KUSTOMIZATION_DIRPATH))
__KCL_NAMESPACE__KCERTIFICATE= $(if $(KCL_KCERTIFICATE_NAMESPACE_NAME),--namespace $(KCL_KCERTIFICATE_NAMESPACE_NAME))
__KCL_NAMESPACE__KCERTIFICATES= $(if $(KCL_KCERTIFICATES_NAMESPACE_NAME),--namespace $(KCL_KCERTIFICATES_NAMESPACE_NAME))
__KCL_OUTPUT__KCERTIFICATES= $(if $(KCL_KCERTIFICATES_OUTPUT),--output $(KCL_KCERTIFICATES_OUTPUT))
__KCL_SELECTOR__KCERTIFICATES= $(if $(KCL_KCERTIFICATES_SELECTOR),--selector=$(KCL_KCERTIFICATES_SELECTOR))
__KCL_SHOW_LABELS__KCERTIFICATE= $(if $(filter true, $(KCL_KCERTIFICATE_SHOW_LABELS)),--show-labels)
__KCL_WATCH_ONLY__KCERTIFICATES= $(if $(KCL_KCERTIFICATES_WATCH_ONLY),--watch-only=$(KCL_KCERTIFICATES_WATCH_ONLY))

# Pipe parameters
|_KCL_KUSTOMIZE_KCERTIFICATE?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Knative::KCertificate ($(_KUBECTL_KNATIVE_KCERTIFICATE_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Knative::KCertificate ($(_KUBECTL_KNATIVE_KCERTIFICATE_MK_VERSION)) parameters:'
	@echo '    KCL_KCERTIFICATE_DNSNAME=$(KCL_KCERTIFICATE_DNSNAME)'
	@echo '    KCL_KCERTIFICATE_DNSNAME_DOMAIN=$(KCL_KCERTIFICATE_DNSNAME_DOMAIN)'
	@echo '    KCL_KCERTIFICATE_DNSNAME_HOSTNAME=$(KCL_KCERTIFICATE_DNSNAME_HOSTNAME)'
	@echo '    KCL_KCERTIFICATE_DNSNAME_SUBDOMAIN=$(KCL_KCERTIFICATE_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_KCERTIFICATE_KSERVICE_NAME=$(KCL_KCERTIFICATE_KSERVICE_NAME)'
	@echo '    KCL_KCERTIFICATE_NAME=$(KCL_KCERTIFICATE_NAME)'
	@echo '    KCL_KCERTIFICATE_NAMESPACE_NAME=$(KCL_KCERTIFICATE_NAMESPACE_NAME)'
	@echo '    KCL_KCERTIFICATE_URL=$(KCL_KCERTIFICATE_URL)'
	@echo '    KCL_KCERTIFICATE_URL_DNSNAME=$(KCL_KCERTIFICATE_URL_DNSNAME)'
	@echo '    KCL_KCERTIFICATE_URL_PATH=$(KCL_KCERTIFICATE_URL_PATH)'
	@echo '    KCL_KCERTIFICATE_URL_PORT=$(KCL_KCERTIFICATE_URL_PORT)'
	@echo '    KCL_KCERTIFICATE_URL_PROTOCOL=$(KCL_KCERTIFICATE_URL_PROTOCOL)'
	@echo '    KCL_KCERTIFICATES_DNSNAME_DOMAIN=$(KCL_KCERTIFICATES_DNSNAME_DOMAIN)'
	@echo '    KCL_KCERTIFICATES_DNSNAME_SUBDOMAIN=$(KCL_KCERTIFICATES_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_KCERTIFICATES_FIELDSELECTOR=$(KCL_KCERTIFICATES_FIELDSELECTOR)'
	@echo '    KCL_KCERTIFICATES_KSERVICE_NAME=$(KCL_KCERTIFICATES_KSERVICE_NAME)'
	@echo '    KCL_KCERTIFICATES_MANIFEST_DIRPATH=$(KCL_KCERTIFICATES_MANIFEST_DIRPATH)'
	@echo '    KCL_KCERTIFICATES_MANIFEST_FILENAME=$(KCL_KCERTIFICATES_MANIFEST_FILENAME)'
	@echo '    KCL_KCERTIFICATES_MANIFEST_FILEPATH=$(KCL_KCERTIFICATES_MANIFEST_FILEPATH)'
	@echo '    KCL_KCERTIFICATES_MANIFEST_STDINFLAG=$(KCL_KCERTIFICATES_MANIFEST_STDINFLAG)'
	@echo '    KCL_KCERTIFICATES_MANIFEST_URL=$(KCL_KCERTIFICATES_MANIFEST_URL)'
	@echo '    KCL_KCERTIFICATES_MANIFESTS_DIRPATH=$(KCL_KCERTIFICATES_MANIFESTS_DIRPATH)'
	@echo '    KCL_KCERTIFICATES_NAMESPACE_NAME=$(KCL_KCERTIFICATES_NAMESPACE_NAME)'
	@echo '    KCL_KCERTIFICATES_OUTPUT=$(KCL_KCERTIFICATES_OUTPUT)'
	@echo '    KCL_KCERTIFICATES_SELECTOR=$(KCL_KCERTIFICATES_SELECTOR)'
	@echo '    KCL_KCERTIFICATES_SET_NAME=$(KCL_KCERTIFICATES_SET_NAME)'
	@echo '    KCL_KCERTIFICATES_SHOW_LABELS=$(KCL_KCERTIFICATES_SHOW_LABELS)'
	@echo '    KCL_KCERTIFICATES_WATCH_ONLY=$(KCL_KCERTIFICATES_WATCH_ONLY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Knative::KCertificate ($(_KUBECTL_KNATIVE_KCERTIFICATE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_kcertificate                 - Annotate a knative-certificate'
	@echo '    _kcl_apply_kcertificates                   - Apply manifest for one-or-more knative-certificates'
	@echo '    _kcl_create_kcertificate                   - Create a new knative-certificate'
	@echo '    _kcl_curl_kcertificate                     - Curl a knative-certificate'
	@echo '    _kcl_delete_kcertificate                   - Delete an existing knative-certificate'
	@echo '    _kcl_diff_kcertificate                     - Diff manifest for one-or-more knative-certificates'
	@echo '    _kcl_dig_kcertificate                      - Dig a knative-certificate'
	@echo '    _kcl_edit_kcertificate                     - Edit a knative-certificate'
	@echo '    _kcl_explain_kcertificate                  - Explain the knative-certificate object'
	@echo '    _kcl_kustomize_kcertificate                - Kustomize one-or-more knative-certificates'
	@echo '    _kcl_label_kcertificate                    - Label a knative-certificate'
	@echo '    _kcl_show_kcertificate                     - Show everything related to a knative-certificate'
	@echo '    _kcl_show_kcertificate_configurations      - Show the configurations of a knative-certificate'
	@echo '    _kcl_show_kcertificate_deployments         - Show the deployments of a knative-certificate'
	@echo '    _kcl_show_kcertificate_description         - Show the description of a knative-certificate'
	@echo '    _kcl_show_kcertificate_object              - Show the object of a knative-certificate'
	@echo '    _kcl_show_kcertificate_pods                - Show the pods of a knative-certificate'
	@echo '    _kcl_show_kcertificate_replicasets         - Show the replica-sets of a knative-certificate'
	@echo '    _kcl_show_kcertificate_revisions           - Show the revisions of a knative-certificate'
	@echo '    _kcl_show_kcertificate_serverlessservices  - Show the serverless-services of a knative-certificate'
	@echo '    _kcl_show_kcertificate_services            - Show the services of a knative-certificate'
	@echo '    _kcl_show_kcertificate_state               - Show the state of a knative-certificate'
	@echo '    _kcl_unapply_kcertificates                 - Unapply amnifest for one-or-more knative-certificates'
	@echo '    _kcl_update_kcertificate                   - Update a knative-certificate'
	@echo '    _kcl_view_kcertificates                    - View all knative-certificates'
	@echo '    _kcl_view_kcertificates_set                - View a set of knative-certificates'
	@echo '    _kcl_watch_kcertificates                   - Watch knative-certificates'
	@echo '    _kcl_watch_kcertificates_set               - Watch a set of knative-certificates'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_kcertificate:
	@$(INFO) '$(KCL_UI_LABEL)Annotating knative-certificate "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate ...

_kcl_apply_kcertificate: _kcl_apply_kcertificates
_kcl_apply_kcertificates:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more knative-certificates ...'; $(NORMAL)
	$(if $(KCL_KCERTIFICATES_MANIFEST_FILEPATH),cat $(KCL_KCERTIFICATES_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_KCERTIFICATES_MANIFEST_STDINFLAG)),$(_KCL_APPLY_KCERTIFICATES_|)cat)
	$(if $(KCL_KCERTIFICATES_MANIFEST_URL),curl -L $(KCL_KCERTIFICATES_MANIFEST_URL))
	$(if $(KCL_KCERTIFICATES_MANIFESTS_DIRPATH),ls -al $(KCL_KCERTIFICATES_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_KCERTIFICATES_|)$(KUBECTL) apply $(__KCL_FILENAME__KCERTIFICATES) $(__KCL_NAMESPACE__KCERTIFICATES)

_kcl_create_kcertificate:
	@$(INFO) '$(KCL_UI_LABEL)Creating knative-certificate "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)

_kcl_curl_kcertificate:
	@$(INFO) '$(KCL_UI_LABEL)Curling knative-certificate "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails of the revision is not mentioned in the route'; $(NORMAL)
	@$(WARN) 'In the route, the name of the revision should be specified'; $(NORMAL)
	$(KCL_KCERTIFICATE_CURL) $(KCL_KCERTIFICATE_URL) 

_kcl_delete_kcertificate:
	@$(INFO) '$(KCL_UI_LABEL)Deleting knative-certificate "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)

_kcl_diff_kcertificate: _kcl_diff_kcertificates
_kcl_diff_kcertificates:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more knative-kcertificates ...'; $(NORMAL)
	# cat $(KCL_KCERTIFICATES_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_KCERTIFICATES_|)cat
	# curl -L $(KCL_KCERTIFICATES_MANIFEST_URL)
	# ls -al $(KCL_KCERTIFICATES_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_KCERTIFICATES_|)$(KUBECTL) diff $(__KCL_FILENAME__KCERTIFICATES) $(__KCL_NAMESPACE__KCERTIFICATES)

_kcl_dig_kcertificate:
	@$(INFO) '$(KCL_UI_LABEL)Dig-ing knative-certificate "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation validates the DNS resolution of the kservice-certificate'; $(NORMAL)
	$(KCL_KCERTIFICATE_DIG) $(KCL_KCERTIFICATE_DNSNAME) 

_kcl_edit_kcertificate:
	@$(INFO) '$(KCL_UI_LABEL)Editing knative-certificate "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit rev $(__KCL_NAMESPACE__KCERTIFICATE) $(KCL_KCERTIFICATE_NAME)

_kcl_explain_kcertificate:
	@$(INFO) '$(KCL_UI_LABEL)Explaining knative-certificate object ...'; $(NORMAL)
	$(KUBECTL) explain kcertificate

_kcl_kustomize_kcertificate: _kcl_kustomize_kcertificates
_kcl_kustomize_kcertificates:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more knative-certificates ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_KCERTIFICATE_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_KCERTIFICATE)

_kcl_label_kcertificate:
	@$(INFO) '$(KCL_UI_LABEL)Labeling knative-certificate "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)

_KCL_SHOW_KCERTIFICATE_TARGETS?= _kcl_show_kcertificate_deployments _kcl_show_kcertificate_object _kcl_show_kcertificate_pods _kcl_show_kcertificate_replicasets _kcl_show_kcertificate_kingress _kcl_show_kcertificate_services _kcl_show_kcertificate_state _kcl_show_kcertificate_description
_kcl_show_kcertificate :: $(_KCL_SHOW_KCERTIFICATE_TARGETS)

_kcl_show_kcertificate_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Showing deployments of knative-serverless-service "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get deploy $(__KCL_NAMESPACE__KCERTIFICATE) --selector $(KCL_KCERTIFICATE_DEPLOYMENTS_SELECTOR)

_kcl_show_kcertificate_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description knative-serverless-service "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this service is accessible at $(KCL_KCERTIFICATE_NAME).$(KCL_KCERTIFICATE_NAMESPACE_NAME).svc.cluster.local'; $(NORMAL)
	$(KUBECTL) describe rev $(__KCL_NAMESPACE__KCERTIFICATE) $(KCL_KCERTIFICATE_NAME)

_kcl_show_kcertificate_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of knative-serverless-service "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get rev $(__KCL_NAMESPACE__KCERTIFICATE) --output yaml $(KCL_KCERTIFICATE_NAME) 

_kcl_show_kcertificate_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods of knative-serverless-service "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get pods $(__KCL_NAMESPACE__KCERTIFICATE) --selector $(KCL_KCERTIFICATE_PODS_SELECTOR)

_kcl_show_kcertificate_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Showing replica-sets of knative-serverless-service "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get replicasets $(__KCL_NAMESPACE__KCERTIFICATE) --selector $(KCL_KCERTIFICATE_REPLICASETS_SELECTOR)

_kcl_show_kcertificate_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing serverless-services of knative-serverless-service "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get serverlessservices $(__KCL_NAMESPACE__KCERTIFICATE) --selector $(KCL_KCERTIFICATE_KCERTIFICATES_SELECTOR)

_kcl_show_kcertificate_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing services of knative-serverless-service "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Exactly 2 services should be returned'
	@$(WARN) ' * PublicIP ... is to go to a specific serverless-service'
	@$(WARN) ' * PublicIP and private ... is internal to a serverless-service?'; $(NORMAL)
	$(KUBECTL) get services $(__KCL_NAMESPACE__KCERTIFICATE) --selector $(KCL_KCERTIFICATE_SERVICES_SELECTOR)

_kcl_show_kcertificate_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of knative-serverless-service "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get rev $(__KCL_NAMESPACE__KCERTIFICATE) $(KCL_KCERTIFICATE_NAME) 

_kcl_unapply_kcertificate: _kcl_unapply_kcertificates
_kcl_unapply_kcertificates:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more knative-serverless-services ...'; $(NORMAL)
	# cat $(KCL_KCERTIFICATES_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_KCERTIFICATES_|)cat
	# curl -L $(KCL_KCERTIFICATES_MANIFEST_FILEPATH)
	# curl -L $(KCL_KCERTIFICATES_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_KCERTIFICATES_|)$(KUBECTL) delete $(__KCL_FILENAME__KCERTIFICATES) $(__KCL_NAMESPACE__KCERTIFICATES)

_kcl_unlabel_kcertificate:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for knative-serverless-service "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)

_kcl_update_kcertificate:
	@$(INFO) '$(KCL_UI_LABEL)Updating knative-serverless-service "$(KCL_KCERTIFICATE_NAME)" ...'; $(NORMAL)

_kcl_view_kcertificates:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL knative-certificates ...'; $(NORMAL)
	$(KUBECTL) get king --all-namespaces=true $(_X__KCL_NAMESPACE__KCERTIFICATES) $(__KCL_OUTPUT__KCERTIFICATES) $(_X__KCL_SELECTOR__KCERTIFICATES)$(__KCL_SHOW_LABELS__KCERTIFICATES)

_kcl_view_kcertificates_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing knative-certificates-set "$(KCL_KCERTIFICATES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Knative-serverless-services are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get king --all-namespaces=false $(__KCL_FIELD_SELECTOR__KCERTIFICATES) $(__KCL_NAMESPACE__KCERTIFICATES) $(__KCL_OUTPUT__KCERTIFICATES) $(__KCL_SELECTOR__KCERTIFICATES) $(__KCL_SHOW_LABELS__KCERTIFICATES)

_kcl_watch__kcertificates:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL knative-certificates ...'; $(NORMAL)
	$(KUBECTL) get king $(strip $(_X__KCL_ALL_NAMESPACES__KCERTIFICATES) --all-namespaces=true $(_X__KCL_NAMESPACE__KCERTIFICATES) $(__KCL_OUTPUT__KCERTIFICATES) $(_X__KCL_SELECTOR__KCERTIFICATES) $(_X__KCL_WATCH__KCERTIFICATES) --watch=true $(__KCL_WATCH_ONLY__KCERTIFICATES) )

_kcl_watch_kcertificates_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching knative-certificates-set "$(KCL_KCERTIFICATES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get king $(strip $(__KCL_ALL_NAMESPACES__KCERTIFICATES) $(__KCL_NAMESPACE__KCERTIFICATES) $(__KCL_OUTPUT__KCERTIFICATES) $(__KCL_SELECTOR__KCERTIFICATES) $(_X__KCL_WATCH__KCERTIFICATES) --watch=true $(__KCL_WATCH_ONLY__KCERTIFICATES) )
