_KUBECTL_KNATIVE_KINGRESS_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# KCL_KINGRESS_ISTIOINGRESSGATEWAY_NAME?= knative-ingress-gateway
# KCL_KINGRESS_ISTIOINGRESSGATEWAY_NAMESPACE?= knative-serving
# KCL_KINGRESS_KSERVICE_NAME?= go-helloworld
# KCL_KINGRESS_KUSTOMIZATION_DIRPATH?= ./in/
# KCL_KINGRESS_NAME?= go-helloworld-00001
# KCL_KINGRESS_NAMESPACE_NAME?= default
# KCL_KINGRESS_ROUTE_NAME?= go-helloworld
# KCL_KINGRESS_VIRTUALSERVICES_NAMES?= go-helloworld-ingress go-helloworld-mesh
# KCL_KINGRESS_VIRTUALSERVICES_SELECTOR?= networking.internal.knative.dev/ingress=go-helloworld
# KCL_KINGRESSES_FIELDSELECTOR?= metadata.name=my-kingress
# KCL_KINGRESSES_MANIFEST_DIRPATH?= ./in/
# KCL_KINGRESSES_MANIFEST_FILENAME?= manifest.yaml
# KCL_KINGRESSES_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_KINGRESSES_MANIFEST_STDINFLAG?= false
# KCL_KINGRESSES_MANIFEST_URL?= http://...
# KCL_KINGRESSES_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_KINGRESSES_NAMESPACE_NAME?= default
# KCL_KINGRESSES_OUTPUT?= wide
# KCL_KINGRESSES_SELECTOR?=
# KCL_KINGRESSES_SET_NAME?= my-set
# KCL_KINGRESSES_SHOW_LABELS?= true
# KCL_KINGRESSES_WATCH_ONLY?= true

# Derived parameters
KCL_KINGRESS_ISTIOINGRESSGATEWAY_NAME?= $(KCL_KNATIVESERVING_ISTIOINGRESSGATEWAY_NAME)
KCL_KINGRESS_ISTIOINGRESSGATEWAY_NAMESPACE?= $(KCL_KNATIVESERVING_ISTIOINGRESSGATEWAY_NAMESPACE)
KCL_KINGRESS_KSERVICE_NAME?= $(KCL_KSERVICE_NAME)
KCL_KINGRESS_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_KINGRESS_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_KINGRESS_NAME?= $(KCL_KINGRESS_KSERVICE_NAME)
KCL_KINGRESS_ROUTE_NAME?= $(KCL_KSERVICE_KSERVICE_NAME)
KCL_KINGRESS_VIRTUALSERVICES_NAMES?= $(KCL_KINGRESS_KSERVICE_NAME)-ingress $(KCL_KINGRESS_KSERVICE_NAME)-mesh
KCL_KINGRESS_VIRTUALSERVICES_SELECTOR?= networking.internal.knative.dev/ingress=$(KCL_KINGRESS_NAME)
KCL_KINGRESSES_KSERVICE_NAME?= $(KCL_KINGRESS_KSERVICE_NAME)
KCL_KINGRESSES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_KINGRESSES_MANIFEST_FILEPATH?= $(if $(KCL_KINGRESSES_MANIFEST_FILENAME),$(KCL_KINGRESSES_MANIFEST_DIRPATH)$(KCL_KINGRESSES_MANIFEST_FILENAME))
KCL_KINGRESSES_NAMESPACE_NAME?= $(KCL_KINGRESS_NAMESPACE_NAME)
KCL_KINGRESSES_SET_NAME?= kingresses@$(KCL_KINGRESSES_FIELDSELECTOR)@$(KCL_KINGRESSES_SELECTOR)@$(KCL_KINGRESSES_NAMESPACE_NAME)

# Option parameters
__KCL_ALL_NAMESPACES__KINGRESSES=
__KCL_FIELD_SELECTOR__KINGRESSES= $(if $(KCL_KINGRESSES_FIELDSELECTOR),--field-selector $(KCL_KINGRESSES_FIELDSELECTOR))
__KCL_FILENAME__KINGRESSES+= $(if $(KCL_KINGRESSES_MANIFEST_FILEPATH),--filename $(KCL_KINGRESSES_MANIFEST_FILEPATH))
__KCL_FILENAME__KINGRESSES+= $(if $(filter true,$(KCL_KINGRESSES_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__KINGRESSES+= $(if $(KCL_KINGRESSES_MANIFEST_URL),--filename $(KCL_KINGRESSES_MANIFEST_URL))
__KCL_FILENAME__KINGRESSES+= $(if $(KCL_KINGRESSES_MANIFESTS_DIRPATH),--filename $(KCL_KINGRESSES_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__KINGRESS= $(if $(KCL_KINGRESS_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_KINGRESS_KUSTOMIZATION_DIRPATH))
__KCL_NAMESPACE__KINGRESS= $(if $(KCL_KINGRESS_NAMESPACE_NAME),--namespace $(KCL_KINGRESS_NAMESPACE_NAME))
__KCL_NAMESPACE__KINGRESSES= $(if $(KCL_KINGRESSES_NAMESPACE_NAME),--namespace $(KCL_KINGRESSES_NAMESPACE_NAME))
__KCL_OUTPUT__KINGRESSES= $(if $(KCL_KINGRESSES_OUTPUT),--output $(KCL_KINGRESSES_OUTPUT))
__KCL_SELECTOR__KINGRESSES= $(if $(KCL_KINGRESSES_SELECTOR),--selector=$(KCL_KINGRESSES_SELECTOR))
__KCL_SHOW_LABELS__KINGRESS= $(if $(filter true, $(KCL_KINGRESS_SHOW_LABELS)),--show-labels)
__KCL_WATCH_ONLY__KINGRESSES= $(if $(KCL_KINGRESSES_WATCH_ONLY),--watch-only=$(KCL_KINGRESSES_WATCH_ONLY))

# Pipe parameters
|_KCL_KUSTOMIZE_KINGRESS?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Knative::KIngress ($(_KUBECTL_KNATIVE_KINGRESS_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Knative::KIngress ($(_KUBECTL_KNATIVE_KINGRESS_MK_VERSION)) parameters:'
	@echo '    KCL_KINGRESS_ISTIOGATEWAY_NAME=$(KCL_KINGRESS_ISTIOGATEWAY_NAME)'
	@echo '    KCL_KINGRESS_ISTIOGATEWAY_NAMESPACE=$(KCL_KINGRESS_ISTIOGATEWAY_NAMESPACE)'
	@echo '    KCL_KINGRESS_KSERVICE_NAME=$(KCL_KINGRESS_KSERVICE_NAME)'
	@echo '    KCL_KINGRESS_NAME=$(KCL_KINGRESS_NAME)'
	@echo '    KCL_KINGRESS_NAMESPACE_NAME=$(KCL_KINGRESS_NAMESPACE_NAME)'
	@echo '    KCL_KINGRESS_VIRTUALSERVICES_NAMES=$(KCL_KINGRESS_VIRTUALSERVICES_NAMES)'
	@echo '    KCL_KINGRESS_VIRTUALSERVICES_SELECTOR=$(KCL_KINGRESS_VIRTUALSERVICES_SELECTOR)'
	@echo '    KCL_KINGRESSES_FIELDSELECTOR=$(KCL_KINGRESSES_FIELDSELECTOR)'
	@echo '    KCL_KINGRESSES_KSERVICE_NAME=$(KCL_KINGRESSES_KSERVICE_NAME)'
	@echo '    KCL_KINGRESSES_MANIFEST_DIRPATH=$(KCL_KINGRESSES_MANIFEST_DIRPATH)'
	@echo '    KCL_KINGRESSES_MANIFEST_FILENAME=$(KCL_KINGRESSES_MANIFEST_FILENAME)'
	@echo '    KCL_KINGRESSES_MANIFEST_FILEPATH=$(KCL_KINGRESSES_MANIFEST_FILEPATH)'
	@echo '    KCL_KINGRESSES_MANIFEST_STDINFLAG=$(KCL_KINGRESSES_MANIFEST_STDINFLAG)'
	@echo '    KCL_KINGRESSES_MANIFEST_URL=$(KCL_KINGRESSES_MANIFEST_URL)'
	@echo '    KCL_KINGRESSES_MANIFESTS_DIRPATH=$(KCL_KINGRESSES_MANIFESTS_DIRPATH)'
	@echo '    KCL_KINGRESSES_NAMESPACE_NAME=$(KCL_KINGRESSES_NAMESPACE_NAME)'
	@echo '    KCL_KINGRESSES_OUTPUT=$(KCL_KINGRESSES_OUTPUT)'
	@echo '    KCL_KINGRESSES_SELECTOR=$(KCL_KINGRESSES_SELECTOR)'
	@echo '    KCL_KINGRESSES_SET_NAME=$(KCL_KINGRESSES_SET_NAME)'
	@echo '    KCL_KINGRESSES_SHOW_LABELS=$(KCL_KINGRESSES_SHOW_LABELS)'
	@echo '    KCL_KINGRESSES_WATCH_ONLY=$(KCL_KINGRESSES_WATCH_ONLY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Knative::KIngress ($(_KUBECTL_KNATIVE_KINGRESS_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_kingress                 - Annotate a knative-ingress'
	@echo '    _kcl_apply_kingresses                  - Apply manifest for one-or-more knative-ingresses'
	@echo '    _kcl_create_kingress                   - Create a new knative-ingress'
	@echo '    _kcl_delete_kingress                   - Delete an existing knative-ingress'
	@echo '    _kcl_diff_kingress                     - Diff manifest for one-or-more knative-ingresses'
	@echo '    _kcl_edit_kingress                     - Edit a knative-ingress'
	@echo '    _kcl_explain_kingress                  - Explain the knative-ingress object'
	@echo '    _kcl_kustomize_kingresses              - Kustomize one-or-more knative-ingresses'
	@echo '    _kcl_label_kingress                    - Label a knative-ingress'
	@echo '    _kcl_show_kingress                     - Show everything related to a knative-ingress'
	@echo '    _kcl_show_kingress_description         - Show the description of a knative-ingress'
	@echo '    _kcl_show_kingress_istioingressgateway - Show the istio-ingress-gateway of a knative-ingress'
	@echo '    _kcl_show_kingress_object              - Show the object of a knative-ingress'
	@echo '    _kcl_show_kingress_state               - Show the state of a knative-ingress'
	@echo '    _kcl_show_kingress_virtualservices     - Show the virtual-services of a knative-ingress'
	@echo '    _kcl_unapply_kingresses                - Unapply manifest for one-or-more knative-ingresses'
	@echo '    _kcl_update_kingress                   - Update a knative-ingress'
	@echo '    _kcl_view_kingresses                   - View all knative-revisions'
	@echo '    _kcl_view_kingresses_set               - View a set of knative-ingresses'
	@echo '    _kcl_watch_kingresses                  - Watch knative-ingresses'
	@echo '    _kcl_watch_kingresses_set              - Watch a set of knative-ingresses'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_kingress:
	@$(INFO) '$(KCL_UI_LABEL)Annotating knative-ingress "$(KCL_KINGRESS_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate ...

_kcl_apply_kingress: _kcl_apply_kingresses
_kcl_apply_kingresses:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more knative-ingresses ...'; $(NORMAL)
	$(if $(KCL_KINGRESSES_MANIFEST_FILEPATH),cat $(KCL_KINGRESSES_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_KINGRESSES_MANIFEST_STDINFLAG)),$(_KCL_APPLY_KINGRESSES_|)cat)
	$(if $(KCL_KINGRESSES_MANIFEST_URL),curl -L $(KCL_KINGRESSES_MANIFEST_URL))
	$(if $(KCL_KINGRESSES_MANIFESTS_DIRPATH),ls -al $(KCL_KINGRESSES_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_KINGRESSES_|)$(KUBECTL) apply $(__KCL_FILENAME__KINGRESSES) $(__KCL_NAMESPACE__KINGRESSES)

_kcl_create_kingress:
	@$(INFO) '$(KCL_UI_LABEL)Creating knative-ingress "$(KCL_KINGRESS_NAME)" ...'; $(NORMAL)

_kcl_delete_kingress:
	@$(INFO) '$(KCL_UI_LABEL)Deleting knative-ingress "$(KCL_KINGRESS_NAME)" ...'; $(NORMAL)

_kcl_diff_kingress: _kcl_diff_kingresses
_kcl_diff_kingresses:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more knative-kingresses ...'; $(NORMAL)
	# cat $(KCL_KINGRESSES_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_KINGRESSES_|)cat
	# curl -L $(KCL_KINGRESSES_MANIFEST_URL)
	# ls -al $(KCL_KINGRESSES_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_KINGRESSES_|)$(KUBECTL) diff $(__KCL_FILENAME__KINGRESSES) $(__KCL_NAMESPACE__KINGRESSES)

_kcl_edit_kingress:
	@$(INFO) '$(KCL_UI_LABEL)Editing knative-ingress "$(KCL_KINGRESS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit kingress $(__KCL_NAMESPACE__KINGRESS) $(KCL_KINGRESS_NAME)

_kcl_explain_kingress:
	@$(INFO) '$(KCL_UI_LABEL)Explaining knative-ingress object ...'; $(NORMAL)
	$(KUBECTL) explain kingress

_kcl_kustomize_kingress: _kcl_kustomize_kingresses
_kcl_kustomize_kingresses:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more knative-ingresses ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_KINGRESS_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_KINGRESS)

_kcl_label_kingress:
	@$(INFO) '$(KCL_UI_LABEL)Labeling knative-ingress "$(KCL_KINGRESS_NAME)" ...'; $(NORMAL)

# ifeq (KCL_KNATIVE_NETWORLLAYER_TYPE,istio)
_KCL_SHOW_KINGRESS_TARGETS?= _kcl_kingress_istioingressgateway _kcl_show_kingress_object _kcl_show_kingress_state _kcl_show_kingress_virtualservices _kcl_show_kingress_description
# endif
_kcl_show_kingress :: $(_KCL_SHOW_KINGRESS_TARGETS)

_kcl_show_kingress_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description knative-ingress "$(KCL_KINGRESS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe kingress $(__KCL_NAMESPACE__KINGRESS) $(KCL_KINGRESS_NAME)

_kcl_show_kingress_istioingressgateway:
	@$(INFO) '$(KCL_UI_LABEL)Showing the istio-ingress-gateway of knative-ingress "$(KCL_KINGRESS_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This istio-ingress-gateway is created when installing the knative network-layer'; $(NORMAL)
	@$(WARN) 'This operation is expected to return only one gateway: $(KCL_KINGRESS_ISTIOINGRESSGATEWAY_NAME)'; $(NORMAL)
	@$(WARN) 'This istio-ingress-gateway is expected to be found in the namespace: $(KCL_KINGRESS_ISTIOINGRESSGATEWAY_NAMESPACE)'; $(NORMAL)
	$(KUBECTL) get gateway --all-namespaces=true

_kcl_show_kingress_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of knative-ingress "$(KCL_KINGRESS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get kingress $(__KCL_NAMESPACE__KINGRESS) --output yaml $(KCL_KINGRESS_NAME) 

_kcl_show_kingress_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of knative-ingress "$(KCL_KINGRESS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get kingress $(__KCL_NAMESPACE__KINGRESS) $(KCL_KINGRESS_NAME) 

_kcl_show_kingress_virtualservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing the virtual-services of knative-ingress "$(KCL_KINGRESS_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return 2 virtual-services: $(KCL_KINGRESS_VIRTUALSERVICES_NAMES)'; $(NAME)
	@$(WARN) 'The returned resources are managed by the knative-ingress controller'; $(NORMAL)
	$(KUBECTL) get virtualservices $(__KCL_NAMESPACE__KINGRESS) --selector $(KCL_KINGRESS_VIRTUALSERVICES_SELECTOR)

_kcl_unapply_kingress: _kcl_unapply_kingresses
_kcl_unapply_kingresses:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more knative-ingresses ...'; $(NORMAL)
	# cat $(KCL_KINGRESSES_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_KINGRESSES_|)cat
	# curl -L $(KCL_KINGRESSES_MANIFEST_FILEPATH)
	# curl -L $(KCL_KINGRESSES_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_KINGRESSES_|)$(KUBECTL) delete $(__KCL_FILENAME__KINGRESSES) $(__KCL_NAMESPACE__KINGRESSES)

_kcl_unlabel_kingress:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for knative-ingress "$(KCL_KINGRESS_NAME)" ...'; $(NORMAL)

_kcl_update_kingress:
	@$(INFO) '$(KCL_UI_LABEL)Updating knative-ingress "$(KCL_KINGRESS_NAME)" ...'; $(NORMAL)

_kcl_view_kingresses:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL knative-ingresses ...'; $(NORMAL)
	$(KUBECTL) get kingress --all-namespaces=true $(_X__KCL_NAMESPACE__KINGRESSES) $(__KCL_OUTPUT__KINGRESSES) $(_X__KCL_SELECTOR__KINGRESSES)$(__KCL_SHOW_LABELS__KINGRESSES)

_kcl_view_kingresses_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing knative-ingresses-set "$(KCL_KINGRESSES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Knative-ingresses are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get kingress --all-namespaces=false $(__KCL_FIELD_SELECTOR__KINGRESSES) $(__KCL_NAMESPACE__KINGRESSES) $(__KCL_OUTPUT__KINGRESSES) $(__KCL_SELECTOR__KINGRESSES) $(__KCL_SHOW_LABELS__KINGRESSES)

_kcl_watch__kingresses:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL knative-ingresses ...'; $(NORMAL)
	$(KUBECTL) get kingress $(strip $(_X__KCL_ALL_NAMESPACES__KINGRESSES) --all-namespaces=true $(_X__KCL_NAMESPACE__KINGRESSES) $(__KCL_OUTPUT__KINGRESSES) $(_X__KCL_SELECTOR__KINGRESSES) $(_X__KCL_WATCH__KINGRESSES) --watch=true $(__KCL_WATCH_ONLY__KINGRESSES) )

_kcl_watch_kingresses_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching knative-ingresses-set "$(KCL_KINGRESSES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get kingress $(strip $(__KCL_ALL_NAMESPACES__KINGRESSES) $(__KCL_NAMESPACE__KINGRESSES) $(__KCL_OUTPUT__KINGRESSES) $(__KCL_SELECTOR__KINGRESSES) $(_X__KCL_WATCH__KINGRESSES) --watch=true $(__KCL_WATCH_ONLY__KINGRESSES) )
