_KUBECTL_KNATIVE_ROUTE_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# KCL_ROUTE_ISTIOINGRESSGATEWAY_NAME?= knative-ingress-gateway
# KCL_ROUTE_ISTIOINGRESSGATEWAY_NAMESPACE?= knative-serving
# KCL_ROUTE_KINGRESSES_SELECTOR?= serving.knative.dev/route=go-helloworld
# KCL_ROUTE_KINGRESS_NAME?= go-helloworld
# KCL_ROUTE_KSERVICE_NAME?= go-helloworld
# KCL_ROUTE_KUSTOMIZATION_DIRPATH?= ./in/
# KCL_ROUTE_MANIFEST_DIRPATH?= ./in/
# KCL_ROUTE_NAME?= go-helloworld
# KCL_ROUTE_NAMESPACE_NAME?= default
# KCL_ROUTE_SERVICES_SELECTOR?= serving.knative.dev/route=go-helloworld
# KCL_ROUTE_VIRTUALSERVICES_NAMES?= go-helloworld-ingress ...
# KCL_ROUTE_VIRTUALSERVICES_SELECTOR?= serving.knative.dev/route=go-helloworld
# KCL_ROUTES_FIELDSELECTOR?= metadata.name=my-route
# KCL_ROUTES_MANIFEST_DIRPATH?= ./in/
# KCL_ROUTES_MANIFEST_FILENAME?= manifest.yaml
# KCL_ROUTES_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_ROUTES_MANIFEST_STDINFLAG?= false
# KCL_ROUTES_MANIFEST_URL?= http://...
# KCL_ROUTES_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_ROUTES_NAMESPACE_NAME?= default
# KCL_ROUTES_OUTPUT?= wide
# KCL_ROUTES_SELECTOR?=
# KCL_ROUTES_SET_NAME?= my-set
# KCL_ROUTES_SHOW_LABELS?= true
# KCL_ROUTES_WATCH_ONLY?= true

# Derived parameters
KCL_ROUTE_ISTIOINGRESSGATEWAY_NAME?= $(KCL_KNATIVESERVING_ISTIOINGRESSGATEWAY_NAME)
KCL_ROUTE_ISTIOINGRESSGATEWAY_NAMESPACE?= $(KCL_KNATIVESERVING_ISTIOINGRESSGATEWAY_NAMESPACE)
KCL_ROUTE_KINGRESSES_SELECTOR?= serving.knative.dev/route=$(KCL_ROUTE_NAME)
KCL_ROUTE_KINGRESS_NAME?= $(KCL_ROUTE_NAME)
KCL_ROUTE_KSERVICE_NAME?= $(KCL_KSERVICE_NAME)
KCL_ROUTE_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_ROUTE_NAME?= $(KCL_ROUTE_KSERVICE_NAME)
KCL_ROUTE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_ROUTE_SERVICES_SELECTOR?= serving.knative.dev/route=$(KCL_ROUTE_NAME)
KCL_ROUTE_VIRTUALSERVICES_NAMES?= $(KCL_ROUTE_NAME)-ingress $(KCL_ROUTE_NAME)-mesh
KCL_ROUTE_VIRTUALSERVICES_SELECTOR?= serving.knative.dev/route=$(KCL_ROUTE_NAME)
KCL_ROUTES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_ROUTES_MANIFEST_FILEPATH?= $(if $(KCL_ROUTES_MANIFEST_FILENAME),$(KCL_ROUTES_MANIFEST_DIRPATH)$(KCL_ROUTES_MANIFEST_FILENAME))
KCL_ROUTES_NAMESPACE_NAME?= $(KCL_ROUTE_NAMESPACE_NAME)
KCL_ROUTES_SET_NAME?= routes@$(KCL_ROUTES_FIELDSELECTOR)@$(KCL_ROUTES_SELECTOR)@$(KCL_ROUTES_NAMESPACE_NAME)

# Option parameters
__KCL_ALL_NAMESPACES__ROUTES=
__KCL_FIELD_SELECTOR__ROUTES= $(if $(KCL_ROUTES_FIELDSELECTOR),--field-selector $(KCL_ROUTES_FIELDSELECTOR))
__KCL_KUSTOMIZE__ROUTE= $(if $(KCL_ROUTE_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_ROUTE_KUSTOMIZATION_DIRPATH))
__KCL_FILENAME__ROUTES+= $(if $(KCL_ROUTES_MANIFEST_FILEPATH),--filename $(KCL_ROUTES_MANIFEST_FILEPATH))
__KCL_FILENAME__ROUTES+= $(if $(filter true,$(KCL_ROUTES_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__ROUTES+= $(if $(KCL_ROUTES_MANIFEST_URL),--filename $(KCL_ROUTES_MANIFEST_URL))
__KCL_FILENAME__ROUTES+= $(if $(KCL_ROUTES_MANIFESTS_DIRPATH),--filename $(KCL_ROUTES_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__ROUTE= $(if $(KCL_ROUTE_NAMESPACE_NAME),--namespace $(KCL_ROUTE_NAMESPACE_NAME))
__KCL_NAMESPACE__ROUTES= $(if $(KCL_ROUTES_NAMESPACE_NAME),--namespace $(KCL_ROUTES_NAMESPACE_NAME))
__KCL_OUTPUT__ROUTES= $(if $(KCL_ROUTES_OUTPUT),--output $(KCL_ROUTES_OUTPUT))
__KCL_SELECTOR__ROUTES= $(if $(KCL_ROUTES_SELECTOR),--selector=$(KCL_ROUTES_SELECTOR))
__KCL_SHOW_LABELS__ROUTE= $(if $(filter true, $(KCL_ROUTE_SHOW_LABELS)),--show-labels)
__KCL_WATCH_ONLY__ROUTES= $(if $(KCL_ROUTES_WATCH_ONLY),--watch-only=$(KCL_ROUTES_WATCH_ONLY))

# Pipe parameters
_KCL_APPLY_ROUTES_|?= #
_KCL_DIFF_ROUTES_|?= $(_KCL_APPLY_ROUTES_|)
_KCL_UNAPPLY_ROUTES_|?= $(_KCL_APPLY_ROUTES_|)
|_KCL_KUSTOMIZE_ROUTE?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Knative::Route ($(_KUBECTL_KNATIVE_ROUTE_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Knative::Route ($(_KUBECTL_KNATIVE_ROUTE_MK_VERSION)) parameters:'
	@echo '    KCL_ROUTE_ISTIOINGRESSGATEWAY_NAME=$(KCL_ROUTE_ISTIOINGRESSGATEWAY_NAME)'
	@echo '    KCL_ROUTE_ISTIOINGRESSGATEWAY_NAMESPACE=$(KCL_ROUTE_ISTIOINGRESSGATEWAY_NAMESPACE)'
	@echo '    KCL_ROUTE_KINGRESSES_SELECTOR=$(KCL_ROUTE_KINGRESSES_SELECTOR)'
	@echo '    KCL_ROUTE_KINGRESS_NAME=$(KCL_ROUTE_KINGRESS_NAME)'
	@echo '    KCL_ROUTE_KSERVICE_NAME=$(KCL_ROUTE_KSERVICE_NAME)'
	@echo '    KCL_ROUTE_NAME=$(KCL_ROUTE_NAME)'
	@echo '    KCL_ROUTE_NAMESPACE_NAME=$(KCL_ROUTE_NAMESPACE_NAME)'
	@echo '    KCL_ROUTE_VIRTUALSERVICES_NAMES=$(KCL_ROUTE_VIRTUALSERVICES_NAMES)'
	@echo '    KCL_ROUTE_VIRTUALSERVICES_SELECTOR=$(KCL_ROUTE_VIRTUALSERVICES_SELECTOR)'
	@echo '    KCL_ROUTES_FIELDSELECTOR=$(KCL_ROUTES_FIELDSELECTOR)'
	@echo '    KCL_ROUTES_MANIFEST_DIRPATH=$(KCL_ROUTES_MANIFEST_DIRPATH)'
	@echo '    KCL_ROUTES_MANIFEST_FILENAME=$(KCL_ROUTES_MANIFEST_FILENAME)'
	@echo '    KCL_ROUTES_MANIFEST_FILEPATH=$(KCL_ROUTES_MANIFEST_FILEPATH)'
	@echo '    KCL_ROUTES_MANIFEST_URL=$(KCL_ROUTES_MANIFEST_URL)'
	@echo '    KCL_ROUTES_MANIFESTS_DIRPATH=$(KCL_ROUTES_MANIFESTS_DIRPATH)'
	@echo '    KCL_ROUTES_NAMESPACE_NAME=$(KCL_ROUTES_NAMESPACE_NAME)'
	@echo '    KCL_ROUTES_OUTPUT=$(KCL_ROUTES_OUTPUT)'
	@echo '    KCL_ROUTES_SELECTOR=$(KCL_ROUTES_SELECTOR)'
	@echo '    KCL_ROUTES_SET_NAME=$(KCL_ROUTES_SET_NAME)'
	@echo '    KCL_ROUTES_SHOW_LABELS=$(KCL_ROUTES_SHOW_LABELS)'
	@echo '    KCL_ROUTES_WATCH_ONLY=$(KCL_ROUTES_WATCH_ONLY)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Knative::Route ($(_KUBECTL_KNATIVE_ROUTE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_route                 - Annotate a knative-route'
	@echo '    _kcl_apply_routes                   - Apply manifest for one-or-more knative-routes'
	@echo '    _kcl_create_route                   - Create a new knative-route'
	@echo '    _kcl_curl_route                     - Curl a knative-route'
	@echo '    _kcl_delete_route                   - Delete an existing knative-route'
	@echo '    _kcl_diff_routes                    - Diff manifest for one-or-more knative-routes'
	@echo '    _kcl_edit_route                     - Edit a knative-route'
	@echo '    _kcl_explain_route                  - Explain the knative-route object'
	@echo '    _kcl_kustomize_routes               - Kustomize one-or-more knative-routes'
	@echo '    _kcl_label_route                    - Label a knative-route'
	@echo '    _kcl_show_route                     - Show everything related to a knative-route'
	@echo '    _kcl_show_route_description         - Show the description of a knative-route'
	@echo '    _kcl_show_route_istioingressgateway - Show the istio-ingress-gateway of a knative-route'
	@echo '    _kcl_show_route_kingress            - Show the knative-ingress of a knative-route'
	@echo '    _kcl_show_route_kservice            - Show the knative-service of a knative-route'
	@echo '    _kcl_show_route_object              - Show the object of a knative-route'
	@echo '    _kcl_show_route_services            - Show the services of a knative-route'
	@echo '    _kcl_show_route_state               - Show the state of a knative-route'
	@echo '    _kcl_show_route_virtualservices     - Show the istio virtual-services of a knative-route'
	@echo '    _kcl_unapply_routes                 - Unapply a manifest for one-or-more knative-route'
	@echo '    _kcl_update_route                   - Update a knative-route'
	@echo '    _kcl_list_routes                    - List all knative-routes'
	@echo '    _kcl_list_routes_set                - List a set of knative-routes'
	@echo '    _kcl_watch_routes                   - Watch knative-routes'
	@echo '    _kcl_watch_routes_set               - Watch a set of knative-routes'
	@echo '    _kcl_write_routes                   - Write a manifest for one-or-more knative-routes'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_route:
	@$(INFO) '$(KCL_UI_LABEL)Annotating knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)

_kcl_apply_route: _kcl_apply_routes
_kcl_apply_routes:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more knative-routes ...'; $(NORMAL)
	$(if $(KCL_ROUTES_MANIFEST_FILEPATH),cat $(KCL_ROUTES_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_ROUTES_MANIFEST_STDINFLAG)),$(_KCL_APPLY_ROUTES_|)cat)
	$(if $(KCL_ROUTES_MANIFEST_URL),curl -L $(KCL_ROUTES_MANIFEST_URL))
	$(if $(KCL_ROUTES_MANIFESTS_DIRPATH),ls -al $(KCL_ROUTES_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_ROUTES_|)$(KUBECTL) apply $(__KCL_FILENAME__ROUTES) $(__KCL_NAMESPACE__ROUTES)

_kcl_create_route:
	@$(INFO) '$(KCL_UI_LABEL)Creating knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)

_kcl_curl_route:
	@$(INFO) '$(KCL_UI_LABEL)Curling knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)
	$(KCL_ROUTE_CURL_BIN) $(KCL_ROUTE_EXTERNAL_URL) 

_kcl_delete_route:
	@$(INFO) '$(KCL_UI_LABEL)Deleting knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)

_kcl_diff_route: _kcl_diff_routes
_kcl_diff_routes:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more knative-routes ...'; $(NORMAL)
	# cat $(KCL_ROUTES_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_ROUTES_|)cat
	# curl -L $(KCL_ROUTES_MANIFEST_URL)
	# ls -al $(KCL_ROUTES_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_ROUTES_|)$(KUBECTL) diff $(__KCL_FILENAME__ROUTES) $(__KCL_NAMESPACE__ROUTES)

_kcl_edit_route:
	@$(INFO) '$(KCL_UI_LABEL)Editing knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit route $(__KCL_NAMESPACE__ROUTE) $(KCL_ROUTE_NAME)

_kcl_explain_route:
	@$(INFO) '$(KCL_UI_LABEL)Explaining knative-route object ...'; $(NORMAL)
	$(KUBECTL) explain route

_kcl_kustomize_route: _kcl_kustomize_routes
_kcl_kustomize_routes:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more knative-routes ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_ROUTE_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_ROUTE)

_kcl_label_route:
	@$(INFO) '$(KCL_UI_LABEL)Labeling knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_list_routes:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL knative-routes ...'; $(NORMAL)
	$(KUBECTL) get route --all-namespaces=true $(_X__KCL_NAMESPACE__ROUTES) $(__KCL_OUTPUT__ROUTES) $(_X__KCL_SELECTOR__ROUTES)$(__KCL_SHOW_LABELS__ROUTES)

_kcl_list_routes_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing knative-routes-set "$(KCL_ROUTES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Knative-routes are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get route --all-namespaces=false $(__KCL_FIELD_SELECTOR__ROUTES) $(__KCL_NAMESPACE__ROUTES) $(__KCL_OUTPUT__ROUTES) $(__KCL_SELECTOR__ROUTES) $(__KCL_SHOW_LABELS__ROUTES)

# ifeq (KN_KNATIVESERVING_NETWORKLAYER_TYPE, istio)
_KCL_SHOW_ROUTE_TARGETS?= _kcl_show_route_istioingressgateway _kcl_show_route_kingress _kcl_show_route_kservice _kcl_show_route_object _kcl_show_route_state _kcl_show_route_virtualservices  _kcl_show_route_description
_kcl_show_route: $(_KCL_SHOW_ROUTE_TARGETS)
# endif

_kcl_show_route_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this service is accessible at $(KCL_ROUTE_NAME).$(KCL_ROUTE_NAMESPACE_NAME).svc.cluster.local'; $(NORMAL)
	$(KUBECTL) describe route $(__KCL_NAMESPACE__ROUTE) $(KCL_ROUTE_NAME)

_kcl_show_route_istioingressgateway:
	@$(INFO) '$(KCL_UI_LABEL)Showing the istio-ingress-gateway of knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This istio-ingress-gateway is created when installing the knative network-layer'; $(NORMAL)
	@$(WARN) 'This operation is expected to return only one istio-gateway: $(KCL_ROUTE_ISTIOINGRESSGATEWAY_NAME)'; $(NORMAL)
	@$(WARN) 'This istio-ingress-gateway is expected to be found in the namespace: $(KCL_ROUTE_ISTIOINGRESSGATEWAY_NAMESPACE)'; $(NORMAL)
	$(KUBECTL) get gateway --all-namespaces=true 

_kcl_show_route_kingress:
	@$(INFO) '$(KCL_UI_LABEL)Showing the knative-ingress of knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return only one ingress: $(KCL_ROUTE_KINGRESS_NAME)'; $(NORMAL)
	$(KUBECTL) get kingress $(__KCL_NAMESPACE__ROUTE) --selector $(KCL_ROUTE_KINGRESSES_SELECTOR)

_kcl_show_route_kservice:
	@$(INFO) '$(KCL_UI_LABEL)Showing the knative-service of knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)
	$(if $(KCL_ROUTE_KSERVICE_NAME), \
		$(KUBECTL) get kservice $(__KCL_NAMESPACE__ROUTE) $(KCL_ROUTE_KSERVICE_NAME), \
		@echo 'KCL_ROUTE_KSERVICE_NAME not set!' \
	)

_kcl_show_route_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing the object of knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get route $(__KCL_NAMESPACE__ROUTE) --output yaml $(KCL_ROUTE_NAME)

_kcl_show_route_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get route $(__KCL_NAMESPACE__ROUTE) $(KCL_ROUTE_NAME) 

_kcl_show_route_virtualservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing istio-virtual-services of knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return 2 virtual-services: $(KCL_ROUTE_VIRTUALSERVICES_NAME)'; $(NORMAL)
	@$(WAR) 'Those virtual-services are managed by the knative-ingress controller'; $(NORMAL)
	$(KUBECTL) get virtualservices $(__KCL_NAMESPACE__ROUTE) --selector $(KCL_ROUTE_VIRTUALSERVICES_SELECTOR)

_kcl_unapply_route: _kcl_unapply_routes
_kcl_unapply_routes:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more knative-routes ...'; $(NORMAL)
	# cat $(KCL_ROUTES_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_ROUTES_|)cat
	# curl -L $(KCL_ROUTES_MANIFEST_FILEPATH)
	# ls -al $(KCL_ROUTES_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_ROUTES_|)$(KUBECTL) delete $(__KCL_FILENAME__ROUTES) $(__KCL_NAMESPACE__ROUTES)

_kcl_unlabel_route:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_update_route:
	@$(INFO) '$(KCL_UI_LABEL)Updating knative-route "$(KCL_ROUTE_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) patch ...

_kcl_watch_routes:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL knative-routes ...'; $(NORMAL)
	$(KUBECTL) get route $(strip $(_X__KCL_ALL_NAMESPACES__ROUTES) --all-namespaces=true $(_X__KCL_NAMESPACE__ROUTES) $(__KCL_OUTPUT__ROUTES) $(_X__KCL_SELECTOR__ROUTES) $(_X__KCL_WATCH__ROUTES) --watch=true $(__KCL_WATCH_ONLY__ROUTES) )

_kcl_watch_routes_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching knative-routes-set "$(KCL_ROUTES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Knative-routes are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get route $(strip $(__KCL_ALL_NAMESPACES__ROUTES) $(__KCL_NAMESPACE__ROUTES) $(__KCL_OUTPUT__ROUTES) $(__KCL_SELECTOR__ROUTES) $(_X__KCL_WATCH__ROUTES) --watch=true $(__KCL_WATCH_ONLY__ROUTES) )

_kcl_write_route: _kcl_write_routes
_kcl_write_routes:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more knative-routes ...'; $(NORMAL)
	$(WRITER) $(KCL_ROUTES_MANIFEST_FILEPATH)
