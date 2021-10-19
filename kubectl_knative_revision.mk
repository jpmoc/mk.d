_KUBECTL_KNATIVE_REVISION_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# KCL_REVISION_CONFIGURATION_NAME?= go-helloworld
# KCL_REVISION_CONFIGURATIONS_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_REVISION_CURL?= time curl
# KCL_REVISION_DEPLOYMENT_NAME?= go-helloworld-00001-deployment
# KCL_REVISION_DEPLOYMENTS_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_REVISION_DIG?= time dig +short
# KCL_REVISION_DNSNAME?=
# KCL_REVISION_DNSNAME_DOMAIN?= example.com
# KCL_REVISION_DNSNAME_SUBDOMAIN?= go-helloworld.default.example.com
# KCL_REVISION_FAMILY_NAME?= go-helloworld
# KCL_REVISION_ID?= 00001
# KCL_REVISION_IMAGE_NAME?= go-helloworld-00001-cache-user-container
# KCL_REVISION_IMAGES_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_REVISION_KSERVICE_NAME?= go-helloworld
# KCL_REVISION_KUSTOMIZATION_DIRPATH?= ./in/
# KCL_REVISION_METRIC_NAME?= go-helloworld-00001
# KCL_REVISION_METRICS_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_REVISION_NAME?= go-helloworld-00001
# KCL_REVISION_NAMESPACE_NAME?= default
# KCL_REVISION_PODAUTOSCALER_NAME?= go-helloworld-00001
# KCL_REVISION_PODAUTOSCALERS_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_REVISION_PODS_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_REVISION_REPLICASET_NAME?= go-helloworld-00001-deployment-5d45ff55fc
# KCL_REVISION_REPLICASETS_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_REVISION_REVISIONS_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_REVISION_SERVERLESSSERVICES_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_REVISION_SERVICES_NAMES?= go-helloworld-00001 go-helloworld-00001-private
# KCL_REVISION_SERVICES_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_REVISION_UID?=bdd9a590-9fa1-4b93-9cd7-76b6d26e7056
# KCL_REVISION_URL?= http://v1.go-helloworld.default.example.com:80/
# KCL_REVISION_URL_DNSNAME?= v1.go-helloworld.default.example.com
# KCL_REVISION_URL_PATH?= /
# KCL_REVISION_URL_PORT?= :80
# KCL_REVISION_URL_PROTOCOL?= http://
# KCL_REVISIONS_FAMILY_NAME?= go-helloworld
# KCL_REVISIONS_FIELDSELECTOR?= metadata.name=my-revision
# KCL_REVISIONS_MANIFEST_DIRPATH?= ./in/
# KCL_REVISIONS_MANIFEST_FILENAME?= manifest.yaml
# KCL_REVISIONS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_REVISIONS_MANIFEST_STDINFLAG?= false
# KCL_REVISIONS_MANIFEST_URL?= http://...
# KCL_REVISIONS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_REVISIONS_NAMESPACE_NAME?= default
# KCL_REVISIONS_OUTPUT?= wide
# KCL_REVISIONS_SELECTOR?=
# KCL_REVISIONS_SET_NAME?= my-set
# KCL_REVISIONS_SHOW_LABELS?= true
# KCL_REVISIONS_WATCH_ONLY?= true

# Derived parameters
KCL_REVISION_CONFIGURATION_NAME?= $(KCL_REVISION_FAMILY_NAME)
KCL_REVISION_CONFIGURATIONS_SELECTOR?= serving.knative.dev/revision=$(KCL_REVISION_NAME)
KCL_REVISION_CURL= $(KCL_KNATIVESERVING_CURL)
KCL_REVISION_DEPLOYMENT_NAME?= $(if $(KCL_REVISION_NAME),$(KCL_REVISION_NAME)-deployment)
KCL_REVISION_DEPLOYMENTS_SELECTOR?= serving.knative.dev/revision=$(KCL_REVISION_NAME)
KCL_REVISION_DIG= $(KCL_KNATIVESERVING_DIG)
KCL_REVISION_DNSNAME?= $(KCL_REVISION_NAME).$(KCL_REVISION_DNSNAME_SUBDOMAIN)
KCL_REVISION_DNSNAME_DOMAIN?= $(KCL_KNATIVESERVING_DNSNAME_DOMAIN)
KCL_REVISION_DNSNAME_HOSTNAME?= $(KCL_REVISION_NAME)
KCL_REVISION_DNSNAME_SUBDOMAIN?= $(KCL_REVISION_KSERVICE_NAME).$(KCL_REVISION_NAMESPACE_NAME).$(KCL_REVISION_DNSNAME_DOMAIN)
KCL_REVISION_FAMILY_NAME?= $(KCL_KSERVICE_NAME)
KCL_REVISION_IMAGE_NAME?= $(if $(KCL_REVISION_NAME),$(KCL_REVISION_NAME)-cache-user-container)
KCL_REVISION_IMAGES_SELECTOR?= serving.knative.dev/revision=$(KCL_REVISION_NAME)
KCL_REVISION_KSERVICE_NAME?= $(KCL_REVISION_FAMILY_NAME)
KCL_REVISION_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_REVISION_METRIC_NAME?= $(KCL_REVISION_NAME)
KCL_REVISION_METRICS_SELECTOR?= serving.knative.dev/revision=$(KCL_REVISION_NAME)
KCL_REVISION_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_REVISION_NAME?= $(if $(KCL_REVISION_ID),$(KCL_REVISION_FAMILY_NAME)-$(KCL_REVISION_ID))
KCL_REVISION_PODAUTOSCALER_NAME?= $(KCL_REVISION_NAME)
KCL_REVISION_PODAUTOSCALERS_SELECTOR?= serving.knative.dev/revision=$(KCL_REVISION_NAME)
KCL_REVISION_PODS_SELECTOR?= serving.knative.dev/revision=$(KCL_REVISION_NAME)
KCL_REVISION_REPLICASET_NAME?= $(if $(KCL_REVISION_DEPLOYMENT_NAME),$(KCL_REVISION_DEPLOYMENT_NAME)-XXXXXXXXXX)
KCL_REVISION_REPLICASETS_SELECTOR?= serving.knative.dev/revision=$(KCL_REVISION_NAME)
KCL_REVISION_SERVERLESSSERVICES_SELECTOR?= serving.knative.dev/revision=$(KCL_REVISION_NAME)
KCL_REVISION_SERVICES_NAMES?= $(KCL_REVISION_NAME) $(KCL_REVISION_NAME)-private
KCL_REVISION_SERVICES_SELECTOR?= serving.knative.dev/revision=$(KCL_REVISION_NAME)
KCL_REVISION_URL?= $(KCL_REVISION_URL_PROTOCOL)$(KCL_REVISION_URL_DNSNAME)$(KCL_REVISION_URL_PORT)$(KCL_REVISION_URL_PATH)
KCL_REVISION_URL_DNSNAME?= $(KCL_REVISION_DNSNAME)
KCL_REVISIONS_DNSNAME_DOMAIN?= $(KCL_REVISION_DNSNAME_DOMAIN)
KCL_REVISIONS_DNSNAME_SUBDOMAIN?= $(KCL_REVISIONS_KSERVICE_NAME).$(KCL_REVISIONS_NAMESPACE_NAME).$(KCL_REVISIONS_DNSNAME_DOMAIN)
KCL_REVISIONS_FAMILY_NAME?= $(KCL_REVISIONS_KSERVICE_NAME)
KCL_REVISIONS_KSERVICE_NAME?= $(KCL_REVISION_KSERVICE_NAME)
KCL_REVISIONS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_REVISIONS_MANIFEST_FILEPATH?= $(if $(KCL_REVISIONS_MANIFEST_FILENAME),$(KCL_REVISIONS_MANIFEST_DIRPATH)$(KCL_REVISIONS_MANIFEST_FILENAME))
KCL_REVISIONS_NAMESPACE_NAME?= $(KCL_REVISION_NAMESPACE_NAME)
KCL_REVISIONS_SET_NAME?= revisions@$(KCL_REVISIONS_FIELDSELECTOR)@$(KCL_REVISIONS_SELECTOR)@$(KCL_REVISIONS_NAMESPACE_NAME)

# Option parameters
__KCL_ALL_NAMESPACES__REVISIONS=
__KCL_FIELD_SELECTOR__REVISIONS= $(if $(KCL_REVISIONS_FIELDSELECTOR),--field-selector $(KCL_REVISIONS_FIELDSELECTOR))
__KCL_FILENAME__REVISIONS+= $(if $(KCL_REVISIONS_MANIFEST_FILEPATH),--filename $(KCL_REVISIONS_MANIFEST_FILEPATH))
__KCL_FILENAME__REVISIONS+= $(if $(filter true,$(KCL_REVISIONS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__REVISIONS+= $(if $(KCL_REVISIONS_MANIFEST_URL),--filename $(KCL_REVISIONS_MANIFEST_URL))
__KCL_FILENAME__REVISIONS+= $(if $(KCL_REVISIONS_MANIFESTS_DIRPATH),--filename $(KCL_REVISIONS_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__REVISION= $(if $(KCL_REVISION_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_REVISION_KUSTOMIZATION_DIRPATH))
__KCL_NAMESPACE__REVISION= $(if $(KCL_REVISION_NAMESPACE_NAME),--namespace $(KCL_REVISION_NAMESPACE_NAME))
__KCL_NAMESPACE__REVISIONS= $(if $(KCL_REVISIONS_NAMESPACE_NAME),--namespace $(KCL_REVISIONS_NAMESPACE_NAME))
__KCL_OUTPUT__REVISIONS= $(if $(KCL_REVISIONS_OUTPUT),--output $(KCL_REVISIONS_OUTPUT))
__KCL_SELECTOR__REVISIONS= $(if $(KCL_REVISIONS_SELECTOR),--selector=$(KCL_REVISIONS_SELECTOR))
__KCL_SHOW_LABELS__REVISION= $(if $(filter true, $(KCL_REVISION_SHOW_LABELS)),--show-labels)
__KCL_WATCH_ONLY__REVISIONS= $(if $(KCL_REVISIONS_WATCH_ONLY),--watch-only=$(KCL_REVISIONS_WATCH_ONLY))

# Pipe parameters
|_KCL_KUSTOMIZE_REVISION?=

# UI parameters

#--- MACROS
# _kcl_get_revision_pods_names= $(call _kcl_get_revision_pods_names_N, $(KCL_REVISION_NAME))
# _kcl_get_revision_pods_names_N= $(call _kcl_get_revision_pods_names_NN, $(1), $(KCL_REVISION_NAMESPACE_NAME))
# _kcl_get_revision_pods_names_NN= $(shell $(KUBECTL) get pods --namespace $(2) --selector=$(1) -o wide | awk 'NR==2 {print $$7}')

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Knative::Revision ($(_KUBECTL_KNATIVE_REVISION_MK_VERSION)) macros:'
	@#echo '    _kcl_get_revision_pod_selector_{|N|NN}       - Get the pod-selector of a service (Name,Namespace)'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Knative::Revision ($(_KUBECTL_KNATIVE_REVISION_MK_VERSION)) parameters:'
	@echo '    KCL_REVISION_CONFIGURATION_NAME=$(KCL_REVISION_CONFIGURATION_NAME)'
	@echo '    KCL_REVISION_CONFIGURATIONS_SELECTOR=$(KCL_REVISION_CONFIGURATIONS_SELECTOR)'
	@echo '    KCL_REVISION_DEPLOYMENT_NAME=$(KCL_REVISION_DEPLOYMENT_NAME)'
	@echo '    KCL_REVISION_DEPLOYMENTS_SELECTOR=$(KCL_REVISION_DEPLOYMENTS_SELECTOR)'
	@echo '    KCL_REVISION_DNSNAME=$(KCL_REVISION_DNSNAME)'
	@echo '    KCL_REVISION_DNSNAME_DOMAIN=$(KCL_REVISION_DNSNAME_DOMAIN)'
	@echo '    KCL_REVISION_DNSNAME_HOSTNAME=$(KCL_REVISION_DNSNAME_HOSTNAME)'
	@echo '    KCL_REVISION_DNSNAME_SUBDOMAIN=$(KCL_REVISION_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_REVISION_FAMILY_NAME=$(KCL_REVISION_FAMILY_NAME)'
	@echo '    KCL_REVISION_ID=$(KCL_REVISION_ID)'
	@echo '    KCL_REVISION_IMAGE_NAME=$(KCL_REVISION_IMAGE_NAME)'
	@echo '    KCL_REVISION_IMAGES_SELECTOR=$(KCL_REVISION_IMAGES_SELECTOR)'
	@echo '    KCL_REVISION_KSERVICE_NAME=$(KCL_REVISION_KSERVICE_NAME)'
	@echo '    KCL_REVISION_METRIC_NAME=$(KCL_REVISION_METRIC_NAME)'
	@echo '    KCL_REVISION_METRICS_SELECTOR=$(KCL_REVISION_METRICS_SELECTOR)'
	@echo '    KCL_REVISION_NAME=$(KCL_REVISION_NAME)'
	@echo '    KCL_REVISION_NAMESPACE_NAME=$(KCL_REVISION_NAMESPACE_NAME)'
	@echo '    KCL_REVISION_PODAUTOSCALER_NAME=$(KCL_REVISION_PODAUTOSCALER_NAME)'
	@echo '    KCL_REVISION_PODAUTOSCALERS_SELECTOR=$(KCL_REVISION_PODAUTOSCALERS_SELECTOR)'
	@echo '    KCL_REVISION_PODS_SELECTOR=$(KCL_REVISION_PODS_SELECTOR)'
	@echo '    KCL_REVISION_REPLICASET_NAME=$(KCL_REVISION_REPLICASET_NAME)'
	@echo '    KCL_REVISION_REPLICASETS_SELECTOR=$(KCL_REVISION_REPLICASETS_SELECTOR)'
	@echo '    KCL_REVISION_REVISIONS_SELECTOR=$(KCL_REVISION_REVISIONS_SELECTOR)'
	@echo '    KCL_REVISION_SERVERLESSSERVICES_SELECTOR=$(KCL_REVISION_SERVERLESSSERVICES_SELECTOR)'
	@echo '    KCL_REVISION_SERVICES_NAMES=$(KCL_REVISION_SERVICES_NAMES)'
	@echo '    KCL_REVISION_SERVICES_SELECTOR=$(KCL_REVISION_SERVICES_SELECTOR)'
	@echo '    KCL_REVISION_UID=$(KCL_REVISION_UID)'
	@echo '    KCL_REVISION_URL=$(KCL_REVISION_URL)'
	@echo '    KCL_REVISION_URL_DNSNAME=$(KCL_REVISION_URL_DNSNAME)'
	@echo '    KCL_REVISION_URL_PATH=$(KCL_REVISION_URL_PATH)'
	@echo '    KCL_REVISION_URL_PORT=$(KCL_REVISION_URL_PORT)'
	@echo '    KCL_REVISION_URL_PROTOCOL=$(KCL_REVISION_URL_PROTOCOL)'
	@echo '    KCL_REVISIONS_DNSNAME_DOMAIN=$(KCL_REVISIONS_DNSNAME_DOMAIN)'
	@echo '    KCL_REVISIONS_DNSNAME_SUBDOMAIN=$(KCL_REVISIONS_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_REVISIONS_FAMILY_NAME=$(KCL_REVISIONS_FAMILY_NAME)'
	@echo '    KCL_REVISIONS_FIELDSELECTOR=$(KCL_REVISIONS_FIELDSELECTOR)'
	@echo '    KCL_REVISIONS_KSERVICE_NAME=$(KCL_REVISIONS_KSERVICE_NAME)'
	@echo '    KCL_REVISIONS_MANIFEST_DIRPATH=$(KCL_REVISIONS_MANIFEST_DIRPATH)'
	@echo '    KCL_REVISIONS_MANIFEST_FILENAME=$(KCL_REVISIONS_MANIFEST_FILENAME)'
	@echo '    KCL_REVISIONS_MANIFEST_FILEPATH=$(KCL_REVISIONS_MANIFEST_FILEPATH)'
	@echo '    KCL_REVISIONS_MANIFEST_STDINFLAG=$(KCL_REVISIONS_MANIFEST_STDINFLAG)'
	@echo '    KCL_REVISIONS_MANIFEST_URL=$(KCL_REVISIONS_MANIFEST_URL)'
	@echo '    KCL_REVISIONS_MANIFESTS_DIRPATH=$(KCL_REVISIONS_MANIFESTS_DIRPATH)'
	@echo '    KCL_REVISIONS_NAMESPACE_NAME=$(KCL_REVISIONS_NAMESPACE_NAME)'
	@echo '    KCL_REVISIONS_OUTPUT=$(KCL_REVISIONS_OUTPUT)'
	@echo '    KCL_REVISIONS_SELECTOR=$(KCL_REVISIONS_SELECTOR)'
	@echo '    KCL_REVISIONS_SET_NAME=$(KCL_REVISIONS_SET_NAME)'
	@echo '    KCL_REVISIONS_SHOW_LABELS=$(KCL_REVISIONS_SHOW_LABELS)'
	@echo '    KCL_REVISIONS_WATCH_ONLY=$(KCL_REVISIONS_WATCH_ONLY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Knative::Revision ($(_KUBECTL_KNATIVE_REVISION_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_revision                - Annotate a knative-revision'
	@echo '    _kcl_apply_revisions                  - Apply manifest for one-or-more knative-revisions'
	@echo '    _kcl_create_revision                  - Create a new knative-revision'
	@echo '    _kcl_curl_revision                    - Curl a knative-revision'
	@echo '    _kcl_dig_revision                     - Dig a knative-revision'
	@echo '    _kcl_delete_revision                  - Delete an existing knative-revision'
	@echo '    _kcl_diff_revisions                   - Diff manifest for one-or-more knative-revisions'
	@echo '    _kcl_dig_revision                     - Dig a knative-revision'
	@echo '    _kcl_edit_revision                    - Edit a knative-revision'
	@echo '    _kcl_explain_revision                 - Explain the knative-revision object'
	@echo '    _kcl_kustomize_revisions              - Kustomize one-or-more knative-revisions'
	@echo '    _kcl_label_revision                   - Label a knative-revision'
	@echo '    _kcl_show_revision                    - Show everything related to a knative-revision'
	@echo '    _kcl_show_revision_configurations     - Show the configurations of a knative-revision'
	@echo '    _kcl_show_revision_deployments        - Show the deployments of a knative-revision'
	@echo '    _kcl_show_revision_description        - Show the description of a knative-revision'
	@echo '    _kcl_show_revision_image              - Show the image of a knative-revision'
	@echo '    _kcl_show_revision_metric             - Show the metric  of a knative-revision'
	@echo '    _kcl_show_revision_object             - Show the object of a knative-revision'
	@echo '    _kcl_show_revision_podautoscaler      - Show the pod-autoscaler of a knative-revision'
	@echo '    _kcl_show_revision_pods               - Show the pods of a knative-revision'
	@echo '    _kcl_show_revision_replicasets        - Show the replica-sets of a knative-revision'
	@echo '    _kcl_show_revision_revisions          - Show the revisions of a knative-revision'
	@echo '    _kcl_show_revision_serverlessservices - Show the serverless-services of a knative-revision'
	@echo '    _kcl_show_revision_services           - Show the services of a knative-revision'
	@echo '    _kcl_show_revision_state              - Show the state of a knative-revision'
	@echo '    _kcl_unapply_revisions                - Unapply amnifest for one-or-more knative-revisions'
	@echo '    _kcl_update_revision                  - Update a knative-revision'
	@echo '    _kcl_view_revisions                   - View all knative-revisions'
	@echo '    _kcl_view_revisions_set               - View a set of knative-revisions'
	@echo '    _kcl_watch_revisions                  - Watch knative-revisions'
	@echo '    _kcl_watch_revisions_set              - Watch a set of knative-revisions'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_revision:
	@$(INFO) '$(KCL_UI_LABEL)Annotating knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate ...

_kcl_apply_revision: _kcl_apply_revisions
_kcl_apply_revisions:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more knative-revisions ...'; $(NORMAL)
	$(if $(KCL_REVISIONS_MANIFEST_FILEPATH),cat $(KCL_REVISIONS_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_REVISIONS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_REVISIONS_|)cat)
	$(if $(KCL_REVISIONS_MANIFEST_URL),curl -L $(KCL_REVISIONS_MANIFEST_URL))
	$(if $(KCL_REVISIONS_MANIFESTS_DIRPATH),ls -al $(KCL_REVISIONS_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_REVISIONS_|)$(KUBECTL) apply $(__KCL_FILENAME__REVISIONS) $(__KCL_NAMESPACE__REVISIONS)

_kcl_create_revision:
	@$(INFO) '$(KCL_UI_LABEL)Creating knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)

_kcl_curl_revision:
	@$(INFO) '$(KCL_UI_LABEL)Curling knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails of the revision is not mentioned in the route'; $(NORMAL)
	@$(WARN) 'In the route, the name of the revision should be specified'; $(NORMAL)
	$(KCL_REVISION_CURL) $(KCL_REVISION_URL) 

_kcl_delete_revision:
	@$(INFO) '$(KCL_UI_LABEL)Deleting knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)

_kcl_diff_revision: _kcl_diff_revisions
_kcl_diff_revisions:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more knative-revisions ...'; $(NORMAL)
	# cat $(KCL_REVISIONS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_REVISIONS_|)cat
	# curl -L $(KCL_REVISIONS_MANIFEST_URL)
	# ls -al $(KCL_REVISIONS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_REVISIONS_|)$(KUBECTL) diff $(__KCL_FILENAME__REVISIONS) $(__KCL_NAMESPACE__REVISIONS)

_kcl_dig_revision:
	@$(INFO) '$(KCL_UI_LABEL)Dig-ing knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation validates the DNS resolution of the kservice-revision; $(NORMAL)
	$(KCL_REVISION_DIG) $(KCL_REVISION_DNSNAME) 

_kcl_edit_revision:
	@$(INFO) '$(KCL_UI_LABEL)Editing knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit rev $(__KCL_NAMESPACE__REVISION) $(KCL_REVISION_NAME)

_kcl_explain_revision:
	@$(INFO) '$(KCL_UI_LABEL)Explaining knative-revision object ...'; $(NORMAL)
	$(KUBECTL) explain revisions

_kcl_kustomize_revision: _kcl_kustomize_revisions
_kcl_kustomize_revisions:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more knative-revisions ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_REVISION_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_REVISION)

_kcl_label_revision:
	@$(INFO) '$(KCL_UI_LABEL)Labeling knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)

_KCL_SHOW_REVISION_TARGETS?= _kcl_show_revision_deployment _kcl_show_revision_image _kcl_show_revision_metric _kcl_show_revision_object _kcl_show_revision_podautoscaler _kcl_show_revision_pods _kcl_show_revision_replicaset _kcl_show_revision_serverlessservice _kcl_show_revision_services _kcl_show_revision_state _kcl_show_revision_description
_kcl_show_revision :: $(_KCL_SHOW_REVISION_TARGETS)

# _kcl_show_revision_configurations:
# 	@$(INFO) '$(KCL_UI_LABEL)Showing configurations of knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return only one configuration: $(KCL_REVISION_CONFIGURATION_NAME)'; $(NORMAL)
# 	$(KUBECTL) get configuration $(__KCL_NAMESPACE__REVISION) --selector $(KCL_REVISION_CONFIGURATIONS_SELECTOR)

_kcl_show_revision_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Showing the deployment of knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return only one deployment: $(KCL_REVISION_DEPLOYMENT_NAME)'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get deployments $(__KCL_NAMESPACE__REVISION) --selector $(KCL_REVISION_DEPLOYMENTS_SELECTOR)

_kcl_show_revision_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing the description of knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this service is accessible at $(KCL_REVISION_NAME).$(KCL_REVISION_NAMESPACE_NAME).svc.cluster.local'; $(NORMAL)
	$(KUBECTL) describe revision $(__KCL_NAMESPACE__REVISION) $(KCL_REVISION_NAME)

_kcl_show_revision_image:
	@$(INFO) '$(KCL_UI_LABEL)Showing the image of knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return only one function-container image: $(KCL_REVISION_IMAGE_NAME)'; $(NORMAL)
	$(KUBECTL) get images $(__KCL_NAMESPACE__REVISION) --selector $(KCL_REVISION_IMAGES_SELECTOR)

_kcl_show_revision_metric:
	@$(INFO) '$(KCL_UI_LABEL)Showing the metric used by the knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return only one pod-autoscaler: $(KCL_REVISION_METRIC_NAME)'; $(NORMAL)
	$(KUBECTL) get metrics $(__KCL_NAMESPACE__REVISION) --selector $(KCL_REVISION_METRICS_SELECTOR)

_kcl_show_revision_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get revision $(__KCL_NAMESPACE__REVISION) --output yaml $(KCL_REVISION_NAME) 

_kcl_show_revision_podautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Showing the pod-autoscaler of knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return only one pod-autoscaler: $(KCL_REVISION_PODAUTOSCALER_NAME)'; $(NORMAL)
	$(KUBECTL) get podautoscalers $(__KCL_NAMESPACE__REVISION) --selector $(KCL_REVISION_PODAUTOSCALERS_SELECTOR)

_kcl_show_revision_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods of knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get pods $(__KCL_NAMESPACE__REVISION) --selector $(KCL_REVISION_PODS_SELECTOR)

_kcl_show_revision_replicaset:
	@$(INFO) '$(KCL_UI_LABEL)Showing the replica-set of knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return only one replica-set: $(KCL_REVISION_REPLICASET_NAME)'; $(NORMAL)
	@$(WARN) 'If there is no traffic, pod count can drop to 0'; $(NORMAL)
	$(KUBECTL) get replicasets $(__KCL_NAMESPACE__REVISION) --selector $(KCL_REVISION_REPLICASETS_SELECTOR)

_kcl_show_revision_serverlessservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing serverless-services of knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get serverlessservices $(__KCL_NAMESPACE__REVISION) --selector $(KCL_REVISION_SERVERLESSSERVICES_SELECTOR)

_kcl_show_revision_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing services of knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is expected to return 2 services: $(KCL_REVISION_SERVICES_NAMES)'
	@$(WARN) 'Both services are expected to be ClusteIP ones'; $(NORMAL)
	@$(WARN) 'The first service is used when the function has no healthy backend pods to cache the request'; $(NORMAL)
	@$(WARN) ' * Service port 80/TCP   --> activator port 8012/TCP'; $(NORMAL)
	@$(WARN) 'The second service is used to reach a running function-pod if any'; $(NORMAL)
	@$(WARN) ' * Service port 80/TCP   --> endpoint-pod port 8012/TCP (queue-proxy to user-container port 80/TCP)'; $(NORMAL)
	@$(WARN) ' * Service port 8022/TCP --> endpoint-pod port 8022/TCP (queue-adm)'; $(NORMAL)
	@$(WARN) ' * Service port 9090/TCP --> endpoint-pod port 9090/TCP (auto-metric)'; $(NORMAL)
	@$(WARN) ' * Service port 9091/TCP --> endpoint-pod port 9091/TCP (user-metric)'; $(NORMAL)
	@$(WARN) ' * If the function-pods are all downscaled, this service has not endpoint'; $(NORMAL)
	$(KUBECTL) get services $(__KCL_NAMESPACE__REVISION) --selector $(KCL_REVISION_SERVICES_SELECTOR)

_kcl_show_revision_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get revision $(__KCL_NAMESPACE__REVISION) $(KCL_REVISION_NAME) 

_kcl_unapply_revision: _kcl_unapply_revisions
_kcl_unapply_revisions:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more knative-revisions ...'; $(NORMAL)
	# cat $(KCL_REVISIONS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_REVISIONS_|)cat
	# curl -L $(KCL_REVISIONS_MANIFEST_FILEPATH)
	# curl -L $(KCL_REVISIONS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_REVISIONS_|)$(KUBECTL) delete $(__KCL_FILENAME__REVISIONS) $(__KCL_NAMESPACE__REVISIONS)

_kcl_unlabel_revision:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)

_kcl_update_revision:
	@$(INFO) '$(KCL_UI_LABEL)Updating knative-revision "$(KCL_REVISION_NAME)" ...'; $(NORMAL)

_kcl_view_revisions:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL knative-revisions ...'; $(NORMAL)
	$(KUBECTL) get revisions --all-namespaces=true $(_X__KCL_NAMESPACE__REVISIONS) $(__KCL_OUTPUT__REVISIONS) $(_X__KCL_SELECTOR__REVISIONS)$(__KCL_SHOW_LABELS__REVISIONS)

_kcl_view_revisions_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing knative-revisions-set "$(KCL_REVISIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Knative-revisions are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get revisions --all-namespaces=false $(__KCL_FIELD_SELECTOR__REVISIONS) $(__KCL_NAMESPACE__REVISIONS) $(__KCL_OUTPUT__REVISIONS) $(__KCL_SELECTOR__REVISIONS) $(__KCL_SHOW_LABELS__REVISIONS)

_kcl_watch_revisions:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL knative-revisions ...'; $(NORMAL)
	$(KUBECTL) get revisions $(strip $(_X__KCL_ALL_NAMESPACES__REVISIONS) --all-namespaces=true $(_X__KCL_NAMESPACE__REVISIONS) $(__KCL_OUTPUT__REVISIONS) $(_X__KCL_SELECTOR__REVISIONS) $(_X__KCL_WATCH__REVISIONS) --watch=true $(__KCL_WATCH_ONLY__REVISIONS) )

_kcl_watch_revisions_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching knative-revisions-set "$(KCL_REVISIONS_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get revisions $(strip $(__KCL_ALL_NAMESPACES__REVISIONS) $(__KCL_NAMESPACE__REVISIONS) $(__KCL_OUTPUT__REVISIONS) $(__KCL_SELECTOR__REVISIONS) $(_X__KCL_WATCH__REVISIONS) --watch=true $(__KCL_WATCH_ONLY__REVISIONS) )
