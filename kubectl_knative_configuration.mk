_KUBECTL_KNATIVE_CONFIGURATION_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# KCL_CONFIGURATION_DEPLOYMENTS_SELECTOR?= serving.knative.dev/configuration=go-helloworld
# KCL_CONFIGURATION_IMAGES_SELECTOR?= serving.knative.dev/configuration=go-helloworld
# KCL_CONFIGURATION_KSERVICE_NAME?= go-helloworld
# KCL_CONFIGURATION_KUSTOMIZATION_DIRPATH?= ./in/
# KCL_CONFIGURATION_METRICS_SELECTOR?= serving.knative.dev/configuration=go-helloworld
# KCL_CONFIGURATION_NAME?= go-helloworld
# KCL_CONFIGURATION_NAMESPACE_NAME?= default
# KCL_CONFIGURATION_PODAUTOSCALERS_SELECTOR?= serving.knative.dev/configuration=go-helloworld
# KCL_CONFIGURATION_PODS_SELECTOR?= serving.knative.dev/configuration=go-helloworld
# KCL_CONFIGURATION_REPLICASETS_SELECTOR?= serving.knative.dev/configuration=go-helloworld
# KCL_CONFIGURATION_REVISIONS_SELECTOR?= serving.knative.dev/configuration=go-helloworld
# KCL_CONFIGURATION_SERVERLESSSERVICES_SELECTOR?= serving.knative.dev/configuration=go-helloworld
# KCL_CONFIGURATION_SERVICES_SELECTOR?= serving.knative.dev/configuration=go-helloworld
# KCL_CONFIGURATIONS_MANIFEST_DIRPATH?= ./in/
# KCL_CONFIGURATIONS_FIELDSELECTOR?= metadata.name=my-configuration
# KCL_CONFIGURATIONS_MANIFEST_FILENAME?= manifest.yaml
# KCL_CONFIGURATIONS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_CONFIGURATIONS_MANIFEST_STDINFLAG?= false
# KCL_CONFIGURATIONS_MANIFEST_URL?= http://...
# KCL_CONFIGURATIONS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_CONFIGURATIONS_NAMESPACE_NAME?= default
# KCL_CONFIGURATIONS_OUTPUT?= wide
# KCL_CONFIGURATIONS_SELECTOR?=
# KCL_CONFIGURATIONS_SET_NAME?= my-configurations-set
# KCL_CONFIGURATIONS_SHOW_LABELS?= true
# KCL_CONFIGURATIONS_WATCH_ONLY?= true

# Derived parameters
KCL_CONFIGURATION_DEPLOYMENTS_SELECTOR?= serving.knative.dev/configuration=$(KCL_CONFIGURATION_NAME)
KCL_CONFIGURATION_IMAGES_SELECTOR?= serving.knative.dev/configuration=$(KCL_CONFIGURATION_NAME)
KCL_CONFIGURATION_KSERVICE_NAME?= $(KCL_KSERVICE_NAME)
KCL_CONFIGURATION_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CONFIGURATION_METRICS_SELECTOR?= serving.knative.dev/configuration=$(KCL_CONFIGURATION_NAME)
KCL_CONFIGURATION_NAME?= $(KCL_CONFIGURATION_KSERVICE_NAME)
KCL_CONFIGURATION_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_CONFIGURATION_PODAUTOSCALERS_SELECTOR?= serving.knative.dev/configuration=$(KCL_CONFIGURATION_NAME)
KCL_CONFIGURATION_PODS_SELECTOR?= serving.knative.dev/configuration=$(KCL_CONFIGURATION_NAME)
KCL_CONFIGURATION_REPLICASETS_SELECTOR?= serving.knative.dev/configuration=$(KCL_CONFIGURATION_NAME)
KCL_CONFIGURATION_REVISIONS_SELECTOR?= serving.knative.dev/configuration=$(KCL_CONFIGURATION_NAME)
KCL_CONFIGURATION_SERVERLESSSERVICES_SELECTOR?= serving.knative.dev/configuration=$(KCL_CONFIGURATION_NAME)
KCL_CONFIGURATION_SERVICES_SELECTOR?= serving.knative.dev/configuration=$(KCL_CONFIGURATION_NAME)
KCL_CONFIGURATIONS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CONFIGURATIONS_MANIFEST_FILEPATH?= $(if $(KCL_CONFIGURATIONS_MANIFEST_FILENAME),$(KCL_CONFIGURATIONS_MANIFEST_DIRPATH)$(KCL_CONFIGURATIONS_MANIFEST_FILENAME))
KCL_CONFIGURATIONS_NAMESPACE_NAME?= $(KCL_CONFIGURATION_NAMESPACE_NAME)
KCL_CONFIGURATIONS_SET_NAME?= configurations@$(KCL_CONFIGURATIONS_FIELDSELECTOR)@$(KCL_CONFIGURATIONS_SELECTOR)@$(KCL_CONFIGURATIONS_NAMESPACE_NAME)

# Option parameters
__KCL_ALL_NAMESPACES__CONFIGURATIONS=
__KCL_FIELD_SELECTOR__CONFIGURATIONS= $(if $(KCL_CONFIGURATIONS_FIELDSELECTOR),--field-selector $(KCL_CONFIGURATIONS_FIELDSELECTOR))
__KCL_FILENAME__CONFIGURATIONS+= $(if $(KCL_CONFIGURATIONS_MANIFEST_FILEPATH),--filename $(KCL_CONFIGURATIONS_MANIFEST_FILEPATH))
__KCL_FILENAME__CONFIGURATIONS+= $(if $(filter true,$(KCL_CONFIGURATIONS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__CONFIGURATIONS+= $(if $(KCL_CONFIGURATIONS_MANIFEST_URL),--filename $(KCL_CONFIGURATIONS_MANIFEST_URL))
__KCL_FILENAME__CONFIGURATIONS+= $(if $(KCL_CONFIGURATIONS_MANIFESTS_DIRPATH),--filename $(KCL_CONFIGURATIONS_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__CONFIGURATION= $(if $(KCL_CONFIGURATION_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_CONFIGURATION_KUSTOMIZATION_DIRPATH))
__KCL_NAMESPACE__CONFIGURATION= $(if $(KCL_CONFIGURATION_NAMESPACE_NAME),--namespace $(KCL_CONFIGURATION_NAMESPACE_NAME))
__KCL_NAMESPACE__CONFIGURATIONS= $(if $(KCL_CONFIGURATIONS_NAMESPACE_NAME),--namespace $(KCL_CONFIGURATIONS_NAMESPACE_NAME))
__KCL_OUTPUT__CONFIGURATIONS= $(if $(KCL_CONFIGURATIONS_OUTPUT),--output $(KCL_CONFIGURATIONS_OUTPUT))
__KCL_SELECTOR__CONFIGURATIONS= $(if $(KCL_CONFIGURATIONS_SELECTOR),--selector=$(KCL_CONFIGURATIONS_SELECTOR))
__KCL_SHOW_LABELS__CONFIGURATION= $(if $(filter true, $(KCL_CONFIGURATION_SHOW_LABELS)),--show-labels)
__KCL_WATCH_ONLY__CONFIGURATIONS= $(if $(KCL_CONFIGURATIONS_WATCH_ONLY),--watch-only=$(KCL_CONFIGURATIONS_WATCH_ONLY))

# Pipe parameters
|_KCL_KUSTOMIZE_CONFIGURATION?=


# UI parameters

#--- MACROS
# kubectl get configuration helloworld-python --output jsonpath="{.status.latestCreatedRevisionName}"
_kcl_get_configuration_latestrevision_name= $(call _kcl_get_configuration_latestrevision_name_N, $(KCL_CONFIGURATION_NAME))
_kcl_get_configuration_latestrevision_name_N= $(call _kcl_get_configuration_latestrevision_name_NN, $(1), $(KCL_CONFIGURATION_NAMESPACE_NAME))
_kcl_get_configuration_latestrevision_name_NN= $(shell $(KUBECTL) get configuration --namespace $(2) $(1) --output jsonpath="{.status.latestCreatedRevisionName}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Knative::Configuration ($(_KUBECTL_KNATIVE_CONFIGURATION_MK_VERSION)) macros:'
	@echo '    _kcl_get_configuration_latestrevision_name_{|N|NN}       - Get the latest-revision of a configuration (Name,Namespace)'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Knative::Configuration ($(_KUBECTL_KNATIVE_CONFIGURATION_MK_VERSION)) parameters:'
	@echo '    KCL_CONFIGURATION_DEPLOYMENTS_SELECTOR=$(KCL_CONFIGURATION_DEPLOYMENTS_SELECTOR)'
	@echo '    KCL_CONFIGURATION_IMAGES_SELECTOR=$(KCL_CONFIGURATION_IMAGES_SELECTOR)'
	@echo '    KCL_CONFIGURATION_KSERVICE_NAME=$(KCL_CONFIGURATION_KSERVICE_NAME)'
	@echo '    KCL_CONFIGURATION_METRICS_SELECTOR=$(KCL_CONFIGURATION_METRICS_SELECTOR)'
	@echo '    KCL_CONFIGURATION_NAME=$(KCL_CONFIGURATION_NAME)'
	@echo '    KCL_CONFIGURATION_NAMESPACE_NAME=$(KCL_CONFIGURATION_NAMESPACE_NAME)'
	@echo '    KCL_CONFIGURATION_PODAUTOSCALERS_SELECTOR=$(KCL_CONFIGURATION_PODAUTOSCALERS_SELECTOR)'
	@echo '    KCL_CONFIGURATION_PODS_SELECTOR=$(KCL_CONFIGURATION_PODS_SELECTOR)'
	@echo '    KCL_CONFIGURATION_REPLICASETS_SELECTOR=$(KCL_CONFIGURATION_REPLICASETS_SELECTOR)'
	@echo '    KCL_CONFIGURATION_REVISIONS_SELECTOR=$(KCL_CONFIGURATION_REVISIONS_SELECTOR)'
	@echo '    KCL_CONFIGURATION_SERVERLESSSERVICES_SELECTOR=$(KCL_CONFIGURATION_SERVERLESSSERVICES_SELECTOR)'
	@echo '    KCL_CONFIGURATION_SERVICES_SELECTOR=$(KCL_CONFIGURATION_SERVICES_SELECTOR)'
	@echo '    KCL_CONFIGURATIONS_FIELDSELECTOR=$(KCL_CONFIGURATIONS_FIELDSELECTOR)'
	@echo '    KCL_CONFIGURATIONS_MANIFEST_DIRPATH=$(KCL_CONFIGURATIONS_MANIFEST_DIRPATH)'
	@echo '    KCL_CONFIGURATIONS_MANIFEST_FILENAME=$(KCL_CONFIGURATIONS_MANIFEST_FILENAME)'
	@echo '    KCL_CONFIGURATIONS_MANIFEST_FILEPATH=$(KCL_CONFIGURATIONS_MANIFEST_FILEPATH)'
	@echo '    KCL_CONFIGURATIONS_MANIFEST_STDINFLAG=$(KCL_CONFIGURATIONS_MANIFEST_STDINFLAG)'
	@echo '    KCL_CONFIGURATIONS_MANIFEST_URL=$(KCL_CONFIGURATIONS_MANIFEST_URL)'
	@echo '    KCL_CONFIGURATIONS_MANIFESTS_DIRPATH=$(KCL_CONFIGURATIONS_MANIFESTS_DIRPATH)'
	@echo '    KCL_CONFIGURATIONS_NAMESPACE_NAME=$(KCL_CONFIGURATIONS_NAMESPACE_NAME)'
	@echo '    KCL_CONFIGURATIONS_OUTPUT=$(KCL_CONFIGURATIONS_OUTPUT)'
	@echo '    KCL_CONFIGURATIONS_SELECTOR=$(KCL_CONFIGURATIONS_SELECTOR)'
	@echo '    KCL_CONFIGURATIONS_SET_NAME=$(KCL_CONFIGURATIONS_SET_NAME)'
	@echo '    KCL_CONFIGURATIONS_SHOW_LABELS=$(KCL_CONFIGURATIONS_SHOW_LABELS)'
	@echo '    KCL_CONFIGURATIONS_WATCH_ONLY=$(KCL_CONFIGURATIONS_WATCH_ONLY)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Knative::Configuration ($(_KUBECTL_KNATIVE_CONFIGURATION_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_configuration                - Annotate a knative-configuration'
	@echo '    _kcl_apply_configurations                  - Apply manifest for one-or-more knative-configurations'
	@echo '    _kcl_create_configuration                  - Create a new knative-configuration'
	@echo '    _kcl_curl_configuration                    - Curl a knative-configuration'
	@echo '    _kcl_delete_configuration                  - Delete an existing knative-configuration'
	@echo '    _kcl_diff_configurations                   - Diff manifest for one-or-more knative-configurations'
	@echo '    _kcl_edit_configuration                    - Edit a knative-configuration'
	@echo '    _kcl_explain_configuration                 - Explain the knative-configuration object'
	@echo '    _kcl_kustomize_configurations              - Kustomize one-or-more knative-configurations'
	@echo '    _kcl_label_configuration                   - Label a knative-configuration'
	@echo '    _kcl_list_configurations                   - List all knative-configurations'
	@echo '    _kcl_list_configurations_set               - List a set of knative-configurations'
	@echo '    _kcl_show_configuration                    - Show everything related to a knative-configuration'
	@echo '    _kcl_show_configuration_deployments        - Show the deployments of a knative-configuration'
	@echo '    _kcl_show_configuration_description        - Show the description of a knative-configuration'
	@echo '    _kcl_show_configuration_images             - Show the images of a knative-configuration'
	@echo '    _kcl_show_configuration_metrics            - Show the metrics of a knative-configuration'
	@echo '    _kcl_show_configuration_object             - Show the object of a knative-configuration'
	@echo '    _kcl_show_configuration_podautoscalerss    - Show the pod-autoscalers of a knative-configuration'
	@echo '    _kcl_show_configuration_pods               - Show the pods of a knative-configuration'
	@echo '    _kcl_show_configuration_replicasets        - Show the replica-sets of a knative-configuration'
	@echo '    _kcl_show_configuration_revisions          - Show the revisions of a knative-configuration'
	@echo '    _kcl_show_configuration_serverlessservices - Show the serverless-services of a knative-configuration'
	@echo '    _kcl_show_configuration_services           - Show the services of a knative-configuration'
	@echo '    _kcl_show_configuration_state              - Show the state of a knative-configuration'
	@echo '    _kcl_unapply_configurations                - Un-apply manifest for one-or-more knative-configurations'
	@echo '    _kcl_update_configuration                  - Update a knative-configuration'
	@echo '    _kcl_watch_configurations                  - Watch knative-configurations'
	@echo '    _kcl_watch_configurations_set              - Watch a set of knative-configurations'
	@echo '    _kcl_write_configurations                  - Write manifest for one-or-more knative-configurations'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_configuration:
	@$(INFO) '$(KCL_UI_LABEL)Annotating knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)

_kcl_apply_configuration: _kcl_apply_configurations
_kcl_apply_configurations:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more knative-configurations ...'; $(NORMAL)
	$(if $(KCL_CONFIGURATIONS_MANIFEST_FILEPATH),cat $(KCL_CONFIGURATIONS_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_CONFIGURATIONS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_CONFIGURATIONS_|)cat)
	$(if $(KCL_CONFIGURATIONS_MANIFEST_URL),curl -L $(KCL_CONFIGURATIONS_MANIFEST_URL))
	$(if $(KCL_CONFIGURATIONS_MANIFESTS_DIRPATH),ls -al $(KCL_CONFIGURATIONS_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_CONFIGURATIONS_|)$(KUBECTL) apply $(__KCL_FILENAME__CONFIGURATIONS) $(__KCL_NAMESPACE__CONFIGURATIONS)

_kcl_create_configuration:
	@$(INFO) '$(KCL_UI_LABEL)Creating knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)

_kcl_curl_configuration:
	@$(INFO) '$(KCL_UI_LABEL)Curling knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(KCL_CONFIGURATION_CURL_BIN) $(KCL_CONFIGURATION_EXTERNAL_URL) 

_kcl_delete_configuration:
	@$(INFO) '$(KCL_UI_LABEL)Deleting knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)

_kcl_diff_configuration: _kcl_diff_configurations
_kcl_diff_configurations:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more knative-configurations ...'; $(NORMAL)
	# cat $(KCL_CONFIGURATIONS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_CONFIGURATIONS_|)cat
	# curl -L $(KCL_CONFIGURATIONS_MANIFEST_URL)
	# ls -al $(KCL_CONFIGURATIONS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_CONFIGURATIONS_|)$(KUBECTL) diff $(__KCL_FILENAME__CONFIGURATIONS) $(__KCL_NAMESPACE__CONFIGURATIONS)

_kcl_edit_configuration:
	@$(INFO) '$(KCL_UI_LABEL)Editing knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit config $(__KCL_NAMESPACE__CONFIGURATION) $(KCL_CONFIGURATION_NAME)

_kcl_explain_configuration:
	@$(INFO) '$(KCL_UI_LABEL)Explaining knative-configuration object ...'; $(NORMAL)
	$(KUBECTL) explain config

_kcl_kustomize_configuration: _kcl_kustomize_configurations
_kcl_kustomize_configurations:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more knative-configurations ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_CONFIGURATION_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_CONFIGURATION)

_kcl_label_configuration:
	@$(INFO) '$(KCL_UI_LABEL)Labeling knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_list_configurations:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL knative-configurations ...'; $(NORMAL)
	$(KUBECTL) get config --all-namespaces=true $(_X__KCL_NAMESPACE__CONFIGURATIONS) $(__KCL_OUTPUT__CONFIGURATIONS) $(_X__KCL_SELECTOR__CONFIGURATIONS)$(__KCL_SHOW_LABELS__CONFIGURATIONS)

_kcl_list_configurations_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing knative-configurations-set "$(KCL_CONFIGURATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Configurations are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get config --all-namespaces=false $(__KCL_FIELD_SELECTOR__CONFIGURATIONS) $(__KCL_NAMESPACE__CONFIGURATIONS) $(__KCL_OUTPUT__CONFIGURATIONS) $(__KCL_SELECTOR__CONFIGURATIONS) $(__KCL_SHOW_LABELS__CONFIGURATIONS)

_KCL_SHOW_CONFIGURATION_TARGETS?= _kcl_show_configuration_deployments _kcl_show_configuration_images _kcl_show_configuraion_metrics _kcl_show_configuration_object _kcl_show_configuration_podautoscalers  _kcl_show_configuration_pods _kcl_show_configuration_replicasets _kcl_show_configuration_revisions _kcl_show_configuration_serverlessservices _kcl_show_configuration_services _kcl_show_configuration_state _kcl_show_configuration_description
_kcl_show_configuration :: $(_KCL_SHOW_CONFIGURATION_TARGETS)

_kcl_show_configuration_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Showing deployments of knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Those deployments have been created by the revision controller'; $(NORMAL)
	@$(WARN) 'If there is no traffic, the pod count will drop to 0'; $(NORMAL)
	$(KUBECTL) get deployments $(__KCL_NAMESPACE__CONFIGURATION) --selector $(KCL_CONFIGURATION_PODS_SELECTOR)

_kcl_show_configuration_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this service is accessible at $(KCL_CONFIGURATION_NAME).$(KCL_CONFIGURATION_NAMESPACE_NAME).svc.cluster.local'; $(NORMAL)
	$(KUBECTL) describe config $(__KCL_NAMESPACE__CONFIGURATION) $(KCL_CONFIGURATION_NAME)

_kcl_show_configuration_images:
	@$(INFO) '$(KCL_UI_LABEL)Showing images of knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return one image per revision'; $(NORMAL)
	$(KUBECTL) get image $(__KCL_NAMESPACE__CONFIGURATION) --selector $(KCL_CONFIGURATION_IMAGES_SELECTOR)

_kcl_show_configuration_metrics:
	@$(INFO) '$(KCL_UI_LABEL)Showing metrics of knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return one metric per revision'; $(NORMAL)
	$(KUBECTL) get podautoscalers $(__KCL_NAMESPACE__CONFIGURATION) --selector $(KCL_CONFIGURATION_METRICS_SELECTOR)

_kcl_show_configuration_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get config $(__KCL_NAMESPACE__CONFIGURATION) --output yaml $(KCL_CONFIGURATION_NAME) 

_kcl_show_configuration_podautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Showing pod-autoscalers of knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return one pod-autoscaler per revision'; $(NORMAL)
	$(KUBECTL) get podautoscalers $(__KCL_NAMESPACE__CONFIGURATION) --selector $(KCL_CONFIGURATION_PODAUTOSCALERS_SELECTOR)

_kcl_show_configuration_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods of knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Those pods have been created by the replica-set controller'; $(NORMAL)
	@$(WARN) 'If there is no traffic, the pod count will drop to 0'; $(NORMAL)
	$(KUBECTL) get pods $(__KCL_NAMESPACE__CONFIGURATION) --selector $(KCL_CONFIGURATION_PODS_SELECTOR)

_kcl_show_configuration_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Showing replica-sets of knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Those replica-sets have been created by the deployment controller'; $(NORMAL)
	@$(WARN) 'If there is no traffic, the pod count will drop to 0'; $(NORMAL)
	$(KUBECTL) get replicasets $(__KCL_NAMESPACE__CONFIGURATION) --selector $(KCL_CONFIGURATION_REPLICASETS_SELECTOR)

_kcl_show_configuration_revisions:
	@$(INFO) '$(KCL_UI_LABEL)Showing revisions of knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Those revisions have been created by the configuration controller'; $(NORMAL)
	$(KUBECTL) get rev $(__KCL_NAMESPACE__CONFIGURATION) --selector $(KCL_CONFIGURATION_REVISIONS_SELECTOR)

_kcl_show_configuration_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing serverless-services of knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Those serverless-services have been created by the revision controller'; $(NORMAL)
	$(KUBECTL) get serverlessservices $(__KCL_NAMESPACE__CONFIGURATION) --selector $(KCL_CONFIGURATION_SERVERLESSSERVICES_SELECTOR)

_kcl_show_configuration_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing services of knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return 2 services per revision'; $(NORMAL)
	@$(WARN) 'Those services have been created by the revision controller'; $(NORMAL)
	$(KUBECTL) get services $(__KCL_NAMESPACE__CONFIGURATION) --selector $(KCL_CONFIGURATION_SERVICES_SELECTOR)

_kcl_show_configuration_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get config $(__KCL_NAMESPACE__CONFIGURATION) $(KCL_CONFIGURATION_NAME) 

_kcl_unapply_configuration: _kcl_unapply_configurations
_kcl_unapply_configurations:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more knative-configurations ...'; $(NORMAL)
	# cat $(KCL_CONFIGURATIONS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_CONFIGURATIONS_|)cat
	# curl -L $(KCL_CONFIGURATIONS_MANIFEST_FILEPATH)
	# ls -al $(KCL_CONFIGURATIONS_MANIFESTS_DIRAPTH)
	$(_KCL_UNAPPLY_CONFIGURATIONS_|)$(KUBECTL) delete $(__KCL_FILENAME__CONFIGURATIONS) $(__KCL_NAMESPACE__CONFIGURATIONS)

_kcl_unlabel_configuration:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)

_kcl_update_configuration:
	@$(INFO) '$(KCL_UI_LABEL)Updating knative-configuration "$(KCL_CONFIGURATION_NAME)" ...'; $(NORMAL)

_kcl_watch_configurations:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL knative-configurations ...'; $(NORMAL)
	$(KUBECTL) get config $(strip $(_X__KCL_ALL_NAMESPACES__CONFIGURATIONS) --all-namespaces=true $(_X__KCL_NAMESPACE__CONFIGURATIONS) $(__KCL_OUTPUT__CONFIGURATIONS) $(_X__KCL_SELECTOR__CONFIGURATIONS) $(_X__KCL_WATCH__CONFIGURATIONS) --watch=true $(__KCL_WATCH_ONLY__CONFIGURATIONS) )

_kcl_watch_configurations_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching knative-configurations-set "$(KCL_CONFIGURATIONS_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get config $(strip $(__KCL_ALL_NAMESPACES__CONFIGURATIONS) $(__KCL_NAMESPACE__CONFIGURATIONS) $(__KCL_OUTPUT__CONFIGURATIONS) $(__KCL_SELECTOR__CONFIGURATIONS) $(_X__KCL_WATCH__CONFIGURATIONS) --watch=true $(__KCL_WATCH_ONLY__CONFIGURATIONS) )

_kcl_write_configuration: _kcl_write_configurations
_kcl_write_configurations:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more knative-configurations ...'; $(NORMAL)
	$(WRITER) $(KCL_CONFIGURATIONS_MANIFEST_FILEPATH)
