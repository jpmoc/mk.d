_KUBECTL_ENDPOINT_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_ENDPOINT_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_ENDPOINT_NAME?= 
# KCL_ENDPOINT_NAMESPACE_NAME?= kube-system
# KCL_ENDPOINT_PATCH_CONTENT?= '{\"imagePullSecrets\": [{\"name\": \"myregistrykey\"}]}'
# KCL_ENDPOINT_PODS_FIELDSELECTOR?= metadata.name=my-pod
# KCL_ENDPOINT_PODS_SELECTOR?= app=api-gateway
# KCL_ENDPOINT_SERVICES_FIELDSELECTOR?= metadata.name=my-service
# KCL_ENDPOINT_SERVICES_SELECTOR?= app=api-gateway
# KCL_ENDPOINTS_FIELDSELECTOR?=  metadata.name=my-endpoint
# KCL_ENDPOINTS_MANIFEST_DIRPATH?= ./in/
# KCL_ENDPOINTS_MANIFEST_FILENAME?= manifest.yaml
# KCL_ENDPOINTS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_ENDPOINTS_MANIFEST_STDINFLAG?= false
# KCL_ENDPOINTS_MANIFEST_URL?= http://...
# KCL_ENDPOINTS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_ENDPOINTS_NAMESPACE_NAME?= kube-system
# KCL_ENDPOINTS_SELECTOR?=  app=api-gateway
# KCL_ENDPOINTS_SET_NAME?= my-endpoints-set

# Derived parameters
KCL_ENDPOINT_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_ENDPOINTS_NAMESPACE_NAME?= $(KCL_ENDPOINT_NAMESPACE_NAME)
KCL_ENDPOINTS_SET_NAME?= endpoints@$(KCL_ENDPOINTS_NAMESPACE_NAME)@$(KCL_ENDPOINTS_SELECTOR)

# Option parameters
__KCL_FIELD_SELECTOR__ENDPOINTS?= $(if $(KCL_ENDPOINTS_FIELDSELECTOR),--field-selector $(KCL_ENDPOINT_FIELDSELECTOR))
__KCL_FILENAME__ENDPOINTS= $(if $(KCL_ENDPOINTS_MANIFEST_FILEPATH),--filename $(KCL_ENDPOINTS_MANIFEST_FILEPATH))
__KCL_FILENAME__ENDPOINTS= $(if $(filter true,$(KCL_ENDPOINTS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__ENDPOINTS= $(if $(KCL_ENDPOINTS_MANIFEST_URL),--filename $(KCL_ENDPOINTS_MANIFEST_URL))
__KCL_FILENAME__ENDPOINTS= $(if $(KCL_ENDPOINTS_MANIFESTS_DIRPATH),--filename $(KCL_ENDPOINTS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__ENDPOINT?= $(if $(KCL_ENDPOINT_NAMESPACE_NAME),--namespace $(KCL_ENDPOINT_NAMESPACE_NAME))
__KCL_NAMESPACE__ENDPOINTS?= $(if $(KCL_ENDPOINTS_NAMESPACE_NAME),--namespace $(KCL_ENDPOINTS_NAMESPACE_NAME))
__KCL_PATCH__ENDPOINT?= $(if $(KCL_ENDPOINT_PATCH_CONTENT),--patch $(KCL_ENDPOINT_PATCH_CONTENT))
__KCL_SELECTOR__ENDPOINTS?= $(if $(KCL_ENDPOINTS_SELECTOR),--selector $(KCL_ENDPOINT_SELECTOR))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Endpoint ($(_KUBECTL_ENDPOINT_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Endpoint ($(_KUBECTL_ENDPOINT_MK_VERSION)) parameters:'
	@echo '    KCL_ENDPOINT_LABELS_KEYVALUES=$(KCL_ENDPOINT_LABELS_KEYVALUES)'
	@echo '    KCL_ENDPOINT_NAME=$(KCL_ENDPOINT_NAME)'
	@echo '    KCL_ENDPOINT_NAMESPACE_NAME=$(KCL_ENDPOINT_NAMESPACE_NAME)'
	@echo '    KCL_ENDPOINT_PODS_FIELDSELECTOR=$(KCL_ENDPOINT_PODS_FIELDSELECTOR)'
	@echo '    KCL_ENDPOINT_PODS_SELECTOR=$(KCL_ENDPOINT_PODS_SELECTOR)'
	@echo '    KCL_ENDPOINT_SERVICES_FIELDSELECTOR=$(KCL_ENDPOINT_SERVICES_FIELDSELECTOR)'
	@echo '    KCL_ENDPOINT_SERVICES_SELECTOR=$(KCL_ENDPOINT_SERVICES_SELECTOR)'
	@echo '    KCL_ENDPOINTS_FIELDSELECTOR=$(KCL_ENDPOINTS_FIELDSELECTOR)'
	@echo '    KCL_ENDPOINTS_MANIFEST_DIRPATH=$(KCL_ENDPOINTS_MANIFEST_DIRPATH)'
	@echo '    KCL_ENDPOINTS_MANIFEST_FILENAME=$(KCL_ENDPOINTS_MANIFEST_FILENAME)'
	@echo '    KCL_ENDPOINTS_MANIFEST_FILEPATH=$(KCL_ENDPOINTS_MANIFEST_FILEPATH)'
	@echo '    KCL_ENDPOINTS_MANIFEST_STDINFLAG=$(KCL_ENDPOINTS_MANIFEST_STDINFLAG)'
	@echo '    KCL_ENDPOINTS_MANIFEST_URL=$(KCL_ENDPOINTS_MANIFEST_URL)'
	@echo '    KCL_ENDPOINTS_MANIFESTS_DIRPATH=$(KCL_ENDPOINTS_MANIFESTS_DIRPATH)'
	@echo '    KCL_ENDPOINTS_NAMESPACE_NAME=$(KCL_ENDPOINTS_NAMESPACE_NAME)'
	@echo '    KCL_ENDPOINTS_SELECTOR=$(KCL_ENDPOINTS_SELECTOR)'
	@echo '    KCL_ENDPOINTS_SET_NAME=$(KCL_ENDPOINTS_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Endpoint ($(_KUBECTL_ENDPOINT_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_endpoint               - Annotate an endpoint'
	@echo '    _kcl_apply_endpoints                 - Apply manifest for one-or-more endpoints'
	@echo '    _kcl_create_endpoint                 - Create a new endpoint'
	@echo '    _kcl_delete_endpoint                 - Delete an existing endpoint'
	@echo '    _kcl_diff_endpoints                  - Diff manifest for one-or-more endpoints'
	@echo '    _kcl_edit_endpoint                   - Edit an endpoint'
	@echo '    _kcl_explain_endpoint                - Explain the endpoint object'
	@echo '    _kcl_label_endpoint                  - Label an endpoint'
	@echo '    _kcl_show_endpoint                   - Show everything related to an endpoint'
	@echo '    _kcl_show_endpoint_description       - Show description of an endpoint'
	@echo '    _kcl_show_endpoint_object            - Show object of an endpoint'
	@echo '    _kcl_show_endpoint_pods              - Show pods of an endpoint'
	@echo '    _kcl_show_endpoint_services          - Show services of an endpoint'
	@echo '    _kcl_show_endpoint_state             - Show state of an endpoint'
	@echo '    _kcl_unapply_endpoints               - Unapply manifest for one-or-more endpoint'
	@echo '    _kcl_unlabel_endpoint                - Unlabel an endpoint'
	@echo '    _kcl_update_endpoint                 - Update an endpoint'
	@echo '    _kcl_list_endpoints                  - List endpoints'
	@echo '    _kcl_list_endpoints_set              - List a set of endpoints'
	@echo '    _kcl_watch_endpoints                 - Watch endpoints'
	@echo '    _kcl_watch_endpoints_set             - Watch a set of endpoints'
	@#echo '    _kcl_write_endpoints                 - Write manifest for one-or-more endpoints'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_endpoint:
	@$(INFO) '$(KCL_UI_LABEL)Creating endpoint "$(KCL_ENDPOINT_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate ...

_kcl_apply_endpoint: _kcl_apply_endpoints
_kcl_apply_endpoints:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more endpoints ...'; $(NORMAL)
	# cat $(KCL_ENDPOINTS_MANIFEST_FILEPATH)
	# $(_KCL_APPLY_ENDPOINTS_|)cat
	# curl -L $(KCL_ENDPOINTS_MANIFEST_URL)
	# ls -al $(KCL_ENDPOINTS_MANIFESTS_DIRPATH)
	$(_KCL_APPLY_ENDPOINTS_|)$(KUBECTL) apply $(__KCL_FILENAME__ENDPOINTS) $(__KCL_NAMESPACE__ENDPOINTS)

_kcl_create_endpoint:
	@$(INFO) '$(KCL_UI_LABEL)Creating endpoint "$(KCL_ENDPOINT_NAME)" ...'; $(NORMAL)

_kcl_delete_endpoint:
	@$(INFO) '$(KCL_UI_LABEL)Deleting endpoint "$(KCL_ENDPOINT_NAME)" ...'; $(NORMAL)

_kcl_diff_endpoint: _kcl_diff_endpoints
_kcl_diff_endpoints:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more endpoints ...'; $(NORMAL)
	# cat $(KCL_ENDPOINTS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_ENDPOINTS_|)cat
	# curl -L $(KCL_ENDPOINTS_MANIFEST_URL)
	# ls -al $(KCL_ENDPOINTS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_ENDPOINTS_|)$(KUBECTL) diff $(__KCL_FILENAME__ENDPOINTS) $(__KCL_NAMESPACE__ENDPOINTS)

_kcl_edit_endpoint:
	@$(INFO) '$(KCL_UI_LABEL)Editing endpoint "$(KCL_ENDPOINT_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) edit ...

_kcl_explain_endpoint:
	@$(INFO) '$(KCL_UI_LABEL)Explaining endpoint object ...'; $(NORMAL)
	$(KUBECTL) explain endpoint

_kcl_label_endpoint:
	@$(INFO) '$(KCL_UI_LABEL)Labeling endpoint "$(KCL_ENDPOINT_NAME)" ...'; $(NORMAL)
	#$(KUBECTL) label endpoint $(__KCL_NAMESPACE__ENDPOINT) $(KCL_ENDPOINT_NAME) $(KCL_ENDPOINT_LABELS_KEYVALUES)

_kcl_list_endpoints:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL endpoints ...'; $(NORMAL)
	$(KUBECTL) get endpoints --all-namespaces=true $(_X__KCL_FIELD_SELECTOR__ENDPOINTS) $(_X__KCL_NAMESPACE__ENDPOINTS) $(_X__KCL_SELECTOR__ENDPOINTS)

_kcl_list_endpoints_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing endpoints-set "$(KCL_ENDPOINTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Endpoints are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
	$(KUBECTL) get endpoints --all-namespaces=false $(__KCL_FIELD_SELECTOR__ENDPOINTS) $(__KCL_NAMESPACE__ENDPOINTS) $(__KCL_SELECTOR__ENDPOINTS)

_KCL_SHOW_ENDPOINT_TARGETS?= _kcl_show_endpoint_object _kcl_show_endpoint_pods _kcl_show_endpoint_services _kcl_show_endpoint_state _kcl_show_endpoint_description
_kcl_show_endpoint: $(_KCL_SHOW_ENDPOINT_TARGETS)

_kcl_show_endpoint_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of endpoint "$(KCL_ENDPOINT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe endpoints $(__KCL_NAMESPACE__ENDPOINT) $(KCL_ENDPOINT_NAME) 

_kcl_show_endpoint_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of endpoint "$(KCL_ENDPOINT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get endpoints $(__KCL_NAMESPACE__ENDPOINT) --output yaml $(KCL_ENDPOINT_NAME) 

_kcl_show_endpoint_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods of endpoint "$(KCL_ENDPOINT_NAME)" ...'; $(NORMAL)
	$(if $(KCL_ENDPOINT_PODS_FIELDSELECTOR)$(KCL_ENDPOINT_PODS_SELECTOR), \
		$(KUBECTL) get pods $(__KCL_NAMESPACE__ENDPOINT) \
			$(if $(KCL_ENDPOINT_PODS_FIELDSELECTOR),--field-selector $(KCL_ENDPOINT_PODS_FIELDSELECTOR)) \
			$(if $(KCL_ENDPOINT_PODS_SELECTOR),--selector $(KCL_ENDPOINT_PODS_SELECTOR)) \
	, @\
		echo 'KCL_ENDPOINT_PODS_FIELDSELECTOR not set'; \
		echo 'KCL_ENDPOINT_PODS_SELECTOR not set'; \
	)

_kcl_show_endpoint_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing services of endpoint "$(KCL_ENDPOINT_NAME)" ...'; $(NORMAL)
	$(if $(KCL_ENDPOINT_SERVICES_FIELDSELECTOR)$(KCL_ENDPOINT_SERVICES_SELECTOR), \
		$(KUBECTL) get service $(__KCL_NAMESPACE__ENDPOINT) \
			$(if $(KCL_ENDPOINT_SERVICES_FIELDSELECTOR),--field-selector $(KCL_ENDPOINT_SERVICES_FIELDSELECTOR)) \
			$(if $(KCL_ENDPOINT_SERVICES_SELECTOR),--selector $(KCL_ENDPOINT_SERVICES_SELECTOR)) \
	, @\
		echo 'KCL_ENDPOINT_SERVICES_FIELDSELECTOR not set'; \
		echo 'KCL_ENDPOINT_SERVICES_SELECTOR not set'; \
	)

_kcl_show_endpoint_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of endpoint "$(KCL_ENDPOINT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get endpoints $(__KCL_NAMESPACE__ENDPOINT) $(_X__KCL_OUTPUT__ENDPOINT) $(KCL_ENDPOINT_NAME) 

_kcl_unapply_endpoint: _kcl_unapply_endpoints
_kcl_unapply_endpoints:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more endpoints ...'; $(NORMAL)
	# cat $(KCL_ENDPOINTS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_ENDPOINTS_|)cat
	# curl -L $(KCL_ENDPOINTS_MANIFEST_URL)
	# ls -al $(KCL_ENDPOINTS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_ENDPOINTS_|)$(KUBECTL) delete $(__KCL_FILENAME__ENDPOINTS) $(__KCL_NAMESPACE__ENDPOINTS)#

_kcl_unlabel_endpoint:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for endpoint "$(KCL_ENDPOINT_NAME)" ...'; $(NORMAL)

_kcl_update_endpoint:
	@$(INFO) '$(KCL_UI_LABEL)Updating endpoint "$(KCL_ENDPOINT_NAME)" ...'; $(NORMAL)
	#$(KUBECTL) patch endpoints $(__KCL_PATCH__ENDPOINT) $(KCL_ENDPOINT_NAME)

_kcl_watch_endpoints:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL endpoints ...'; $(NORMAL)

_kcl_watch_endpoints_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching endpoints-set "$(KCL_ENDPOINTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Endpoints are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)

_kcl_write_endpoints:
