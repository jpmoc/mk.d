_KUBECTL_DEPLOYMENT_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_DEPLOYMENT_ANNOTATIONS_KEYS?= key1 ...
# KCL_DEPLOYMENT_ANNOTATIONS_KEYVALUES?= key1=values1 ...
# KCL_DEPLOYMENT_CONTAINER_NAME?= istio-proxy
# KCL_DEPLOYMENT_CONTAINERS_NAMES?= istio-proxy ...
KCL_DEPLOYMENT_DRYRUN_MODE?= none
KCL_DEPLOYMENT_EXPOSE_FLAG?= false
# KCL_DEPLOYMENT_FIELD_JSONPATH?= .spec.strategy.rollingUpdate
# KCL_DEPLOYMENT_HORIZONTALPODAUTOSCALER_NAME?= my-hpa
# KCL_DEPLOYMENT_IMAGE_CNAME?= datawire/qotm:1.3
# KCL_DEPLOYMENT_KUSTOMIZATION_DIRPATH?= ./
# KCL_DEPLOYMENT_LABELS_KEYVALUES?=
# KCL_DEPLOYMENT_NAME?= hello
# KCL_DEPLOYMENT_NAMESPACE_NAME?= default
# KCL_DEPLOYMENT_OUTPUT_FORMAT?=
# KCL_DEPLOYMENT_PATCH?= "$(cat patch.yaml)"
# KCL_DEPLOYMENT_PATCH_DIRPATH?= "$(cat patch.yaml)"
# KCL_DEPLOYMENT_PATCH_FILENAME?= patch.yaml
# KCL_DEPLOYMENT_PATCH_FILEPATH?= ./in/patch.yaml
# KCL_DEPLOYMENT_POD_NAME?= hello-4111706356-o9qcm
# KCL_DEPLOYMENT_PODCONTAINER_NAME?= nginx
# KCL_DEPLOYMENT_PODCONTAINERIMAGE_NAME?= nginx:1.2.0
# KCL_DEPLOYMENT_PODS_NAMES?= hello-4111706356-o9qcm ...
# KCL_DEPLOYMENT_PODS_FIELDSELECTOR?= manifest.name=my-pod
# KCL_DEPLOYMENT_PODS_SELECTOR?= app=global-registration-service
# KCL_DEPLOYMENT_PORTFORWARD_ADDRESS?= localhost,10.19.21.23,0.0.0.0
# KCL_DEPLOYMENT_PORTFORWARD_PORTMAPINGS?= 80:8080 local:pod-port ...
# KCL_DEPLOYMENT_PORTFORWARD_TIMEOUT?= 1m0s
KCL_DEPLOYMENT_RECORD_FLAG?= false
KCL_DEPLOYMENT_REPLICAS_COUNT?= 1
# KCL_DEPLOYMENT_REPLICASET_NAME?= api-gateway-6f5877798
# KCL_DEPLOYMENT_REPLICASETS_NAMES?= api-gateway-6f5877798 ...
# KCL_DEPLOYMENT_REPLICASETS_FIELDSELECTOR?= metadata.name=my-replica-set
# KCL_DEPLOYMENT_REPLICASETS_SELECTOR?= app=global-registration-service
# KCL_DEPLOYMENT_RESTART?= OnFailure
# KCL_DEPLOYMENT_SCHEDULE?= "*/1 * * * *"
# KCL_DEPLOYMENT_SELECTOR?= app=global-registration-service
# KCL_DEPLOYMENT_SERVICE_NAME?= my-exposeddeployment-service
KCL_DEPLOYMENT_SERVICE_PORT?= 80# Yes, default to 80!
KCL_DEPLOYMENT_SERVICE_TYPE?= ClusterIP
KCL_DEPLOYMENT_SERVICEACCOUNT_NAME?= default
# KCL_DEPLOYMENT_SERVICES_FIELDSELECTOR?= app=global-registration-service
# KCL_DEPLOYMENT_SERVICES_NAMES?= my-exposeddeployment-service ...
# KCL_DEPLOYMENT_SERVICES_SELECTOR?= app=global-registration-service
KCL_DEPLOYMENT_SSH_SHELL?= /bin/bash
# KCL_DEPLOYMENT_TAILCONTAINER_NAME?= istio-proxy
KCL_DEPLOYMENT_TAILFOLLOW_FLAG?= false
# KCL_DEPLOYMENT_TAILHISTORY_COUNT?= 10
# KCL_DEPLOYMENTS_CLUSTER_NAME?= my-cluster-name
# KCL_DEPLOYMENTS_FIELDSELECTOR?= metadata.name=my-deployment
# KCL_DEPLOYMENTS_MANIFEST_DIRPATH?= ./in/
# KCL_DEPLOYMENTS_MANIFEST_FILENAME?= deployment-manifest.yaml
# KCL_DEPLOYMENTS_MANIFEST_FILEPATH?= ./in/deployment-manifest.yaml
KCL_DEPLOYMENTS_MANIFEST_STDINFLAG?= false
# KCL_DEPLOYMENTS_MANIFEST_URL?= http://
# KCL_DEPLOYMENTS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_DEPLOYMENTS_NAMESPACE_NAME?= default
# KCL_DEPLOYMENTS_OUTPUT_FORMAT?= jsonpath='{.items[0].metadata.name}'
# KCL_DEPLOYMENTS_SELECTOR?= run=ecr-read-only--renew-token
# KCL_DEPLOYMENTS_SET_NAME?= my-deployments-set
# KCL_DEPLOYMENTS_SORTBY_JSONPATH?= status.completionTime

# Derived parameters
KCL_DEPLOYMENT_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_DEPLOYMENT_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_DEPLOYMENT_NAMES?= $(KCL_DEPLOYMENT_NAME)
KCL_DEPLOYMENT_OUTPUT_FORMAT?= $(KCL_OUTPUT_FORMAT)
KCL_DEPLOYMENT_PATCH_FILEPATH?= $(KCL_DEPLOYMENT_PATCH_DIRPATH)$(KCL_DEPLOYMENT_PATCH_FILENAME)
KCL_DEPLOYMENT_PODS_SELECTOR?= $(KCL_DEPLOYMENTS_SELECTOR)
KCL_DEPLOYMENT_REPLICASETS_SELECTOR?= $(KCL_DEPLOYMENTS_SELECTOR)
KCL_DEPLOYMENT_SERVICES_SELECTOR?= $(KCL_DEPLOYMENTS_SELECTOR)
KCL_DEPLOYMENT_SERVICE_NAME?= $(KCL_DEPLOYMENT_NAME)
# KCL_DEPLOYMENT_SERVICE_TARGETPORT?= $(KCL_DEPLOYMENT_SERVICE_PORT)
KCL_DEPLOYMENTS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_DEPLOYMENTS_MANIFEST_FILEPATH?= $(KCL_DEPLOYMENTS_MANIFEST_DIRPATH)$(KCL_DEPLOYMENTS_MANIFEST_FILENAME)
KCL_DEPLOYMENTS_NAMESPACE_NAME?= $(KCL_DEPLOYMENT_NAMESPACE_NAME)
KCL_DEPLOYMENTS_SET_NAME?= $(KCL_DEPLOYMENTS_NAMESPACE_NAME)

# Options
__KCL_ADDRESS__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_PORTFORWARD_ADDRESS),--address $(KCL_DEPLOYMENT_PORTFORWARD_ADDRESS))
__KCL_CONTAINER__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_TAILCONTAINER_NAME),--container $(KCL_DEPLOYMENT_TAILCONTAINER_NAME))
__KCL_DRY_RUN__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_DRYRUN_MODE),--dry-run=$(KCL_DEPLOYMENT_DRYRUN_MODE))
__KCL_EXPORT__DEPLOYMENT?= # dry-run to manifest without object metadata fields
__KCL_EXPOSE__DEPLOYMENT= $(if $(filter true, $(KCL_DEPLOYMENT_EXPOSE_FLAG)),--expose)
__KCL_FILENAME__DEPLOYMENTS+= $(if $(KCL_DEPLOYMENTS_MANIFEST_FILEPATH),--filename $(KCL_DEPLOYMENTS_MANIFEST_FILEPATH))
__KCL_FILENAME__DEPLOYMENTS+= $(if $(filter true,$(KCL_DEPLOYMENTS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__DEPLOYMENTS+= $(if $(KCL_DEPLOYMENTS_MANIFEST_URL),--filename $(KCL_DEPLOYMENTS_MANIFEST_URL))
__KCL_FILENAME__DEPLOYMENTS+= $(if $(KCL_DEPLOYMENTS_MANIFESTS_DIRPATH),--filename $(KCL_DEPLOYMENTS_MANIFESTS_DIRPATH))
__KCL_FOLLOW__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_TAILFOLLOW_FLAG),--follow=$(KCL_DEPLOYMENT_TAILFOLLOW_FLAG))
__KCL_IMAGE__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_IMAGE_CNAME),--image=$(KCL_DEPLOYMENT_IMAGE_CNAME))
__KCL_KUSTOMIZE__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_DEPLOYMENT_KUSTOMIZATION_DIRPATH))
__KCL_LABELS__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_LABELS_KEYVALUES),--labels $(KCL_DEPLOYMENT_LABELS_KEYVALUES))
__KCL_NAME__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_SERVICE_NAME),--name $(KCL_DEPLOYMENT_SERVICE_NAME))
__KCL_NAMESPACE__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_NAMESPACE_NAME),--namespace $(KCL_DEPLOYMENT_NAMESPACE_NAME))
__KCL_NAMESPACE__DEPLOYMENTS= $(if $(KCL_DEPLOYMENTS_NAMESPACE_NAME),--namespace $(KCL_DEPLOYMENTS_NAMESPACE_NAME))
__KCL_OUTPUT__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_OUTPUT_FORMAT),--output $(KCL_DEPLOYMENT_OUTPUT_FORMAT))
__KCL_OUTPUT__DEPLOYMENTS= $(if $(KCL_DEPLOYMENTS_OUTPUT_FORMAT),--output $(KCL_DEPLOYMENTS_OUTPUT_FORMAT))
__KCL_PATCH__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_PATCH),--patch=$(KCL_DEPLOYMENT_PATCH))
__KCL_PATCH_FILE__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_PATCH_FILEPATH),--patch-file=$(KCL_DEPLOYMENT_PATCH_FILEPATH))
__KCL_POD_RUNNING_TIMEOUT__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_PORTFORWARD_TIMEOUT),--pod-running-timeout=$(KCL_DEPLOYMENT_PORTFORWARD_TIMEOUT))
__KCL_PORT__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_SERVICE_PORT),--port=$(KCL_DEPLOYMENT_SERVICE_PORT))
__KCL_RECORD__DEPLOYMENT= $(if $(filter true,$(KCL_DEPLOYMENT_RECORD_FLAG)),--record)
__KCL_RECURSIVE__DEPLOYMENT=
__KCL_REPLICAS__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_REPLICAS_COUNT),--replicas=$(KCL_DEPLOYMENT_REPLICAS_COUNT))
__KCL_RESTART__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_RESTART),--restart=$(KCL_DEPLOYMENT_RESTART))
__KCL_SELECTOR__DEPLOYMENTS= $(if $(KCL_DEPLOYMENTS_SELECTOR),--selector=$(KCL_DEPLOYMENTS_SELECTOR))
__KCL_SERVICEACCOUNT__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_SERVICEACCOUNT_NAME),--serviceaccount=$(KCL_DEPLOYMENT_SERVICEACCOUNT_NAME))
__KCL_SORT_BY__DEPLOYMENTS= $(if $(KCL_DEPLOYMENTS_SORTBY_JSONPATH),--sort-by=$(KCL_DEPLOYMENTS_SORTBY_JSONPATH))
__KCL_TAIL__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_TAILHISTORY_COUNT),--tail $(KCL_DEPLOYMENT_TAILHISTORY_COUNT))
__KCL_TARGET_PORT__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_SERVICE_TARGETPORT),--target-port $(KCL_DEPLOYMENT_SERVICE_TARGETPORT))
__KCL_TYPE__DEPLOYMENT= $(if $(KCL_DEPLOYMENT_SERVICE_TYPE),--type $(KCL_DEPLOYMENT_SERVICE_TYPE))

# Customizations
_KCL_APPLY_DEPLOYMENTS_|?= #
_KCL_CREATE_DEPLOYMENT_|?=
_KCL_DIFF_DEPLOYMENTS_|?= $(_KCL_APPLY_DEPLOYMENTS_|)
_KCL_PORTFORWARD_DEPLOYMENT_|?= while true; do #
_KCL_REPLACE_DEPLOYMENT_|?=
_KCL_TAIL_DEPLOYMENT_|?=
_KCL_UNAPPLY_DEPLOYMENTS_|?= $(_KCL_APPLY_DEPLOYMENTS_|)
|_KCL_CREATE_DEPLOYMENT?= # | tee deployment.yaml
|_KCL_KUSTOMIZE_DEPLOYMENT?=
|_KCL_PORTFORWARD_DEPLOYMENT?= || sleep 10; date; done
|_KCL_TAIL_DEPLOYMENT?= # | tee deployment.log

# Macros
_kcl_get_deployment_pods_names= $(call _kcl_get_deployment_pods_names_S, $(KCL_DEPLOYMENT_PODS_SELECTOR))
_kcl_get_deployment_pods_names_S= $(call _kcl_get_deployment_pods_names_SN, $(1), $(KCL_DEPLOYMENT_NAMESPACE_NAME))
_kcl_get_deployment_pods_names_SN= $(shell $(KUBECTL) get pods --namespace $(2) --selector=$(strip $(1)) --output=jsonpath="{.items..metadata.name}")

_kcl_get_deployment_replicasets_names= $(call _kcl_get_deployment_replicasets_names_S, $(KCL_DEPLOYMENT_REPLICASETS_SELECTOR))
_kcl_get_deployment_replicasets_names_S= $(call _kcl_get_deployment_replicasets_names_SN, $(1), $(KCL_DEPLOYMENT_NAMESPACE_NAME))
_kcl_get_deployment_replicasets_names_SN= $(shell $(KUBECTL) get replicasets --namespace $(2) --selector $(1) --output=jsonpath="{.items..metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Deployment ($(_KUBECTL_DEPLOYMENT_MK_VERSION)) macros:'
	@echo '    _kcl_get_deployment_pods_names_{|S|SN}             - Get the name of pods spawned by a deployment (Selector,Namespace)'
	@echo '    _kcl_get_deployment_replicasets_name_{|S|SN}       - Get the name of the replica-sets spawned by a deployment (Selector,Namespace)'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Deployment ($(_KUBECTL_DEPLOYMENT_MK_VERSION)) parameters:'
	@echo '    KCL_DEPLOYMENT_ANNOTATIONS_KEYS=$(KCL_DEPLOYMENT_ANNOTATIONS_KEYS)'
	@echo '    KCL_DEPLOYMENT_ANNOTATIONS_KEYVALUES=$(KCL_DEPLOYMENT_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_DEPLOYMENT_CONTAINER_NAME=$(KCL_DEPLOYMENT_CONTAINER_NAME)'
	@echo '    KCL_DEPLOYMENT_CONTAINERS_NAMES=$(KCL_DEPLOYMENT_CONTAINERS_NAMES)'
	@echo '    KCL_DEPLOYMENT_DRYRUN_MODE=$(KCL_DEPLOYMENT_DRYRUN_MODE)'
	@echo '    KCL_DEPLOYMENT_EXPOSE_FLAG=$(KCL_DEPLOYMENT_EXPOSE_FLAG)'
	@echo '    KCL_DEPLOYMENT_FIELD_JSONPATH=$(KCL_DEPLOYMENT_FIELD_JSONPATH)'
	@echo '    KCL_DEPLOYMENT_FOLLOW_LOGS=$(KCL_DEPLOYMENT_FOLLOW_LOGS)'
	@echo '    KCL_DEPLOYMENT_HORIZONTALPODAUTPSCALER_NAME=$(KCL_DEPLOYMENT_HORIZONTALPODAUTOSCALER_NAME)'
	@echo '    KCL_DEPLOYMENT_IMAGE_CNAME=$(KCL_DEPLOYMENT_IMAGE_CNAME)'
	@echo '    KCL_DEPLOYMENT_KUSTOMIZATION_DIRPATH=$(KCL_DEPLOYMENT_KUSTOMIZATION_DIRPATH)'
	@echo '    KCL_DEPLOYMENT_LABELS_KEYS=$(KCL_DEPLOYMENT_LABELS_KEYS)'
	@echo '    KCL_DEPLOYMENT_LABELS_KEYVALUES=$(KCL_DEPLOYMENT_LABELS_KEYVALUES)'
	@echo '    KCL_DEPLOYMENT_NAME=$(KCL_DEPLOYMENT_NAME)'
	@echo '    KCL_DEPLOYMENT_NAMESPACE_NAME=$(KCL_DEPLOYMENT_NAMESPACE_NAME)'
	@echo '    KCL_DEPLOYMENT_OUTPUT_FORMAT=$(KCL_DEPLOYMENT_OUTPUT_FORMAT)'
	@echo '    KCL_DEPLOYMENT_PATCH=$(KCL_DEPLOYMENT_PATCH)'
	@echo '    KCL_DEPLOYMENT_PATCH_DIRPATH=$(KCL_DEPLOYMENT_PATCH_DIRPATH)'
	@echo '    KCL_DEPLOYMENT_PATCH_FILENAME=$(KCL_DEPLOYMENT_PATCH_FILENAME)'
	@echo '    KCL_DEPLOYMENT_PATCH_FILEPATH=$(KCL_DEPLOYMENT_PATCH_FILEPATH)'
	@echo '    KCL_DEPLOYMENT_POD_NAME=$(KCL_DEPLOYMENT_POD_NAME)'
	@echo '    KCL_DEPLOYMENT_PODCONTAINER_NAME=$(KCL_DEPLOYMENT_PODCONTAINER_NAME)'
	@echo '    KCL_DEPLOYMENT_PODCONTAINERIMAGE_NAME=$(KCL_DEPLOYMENT_PODCONTAINERIMAGE_NAME)'
	@echo '    KCL_DEPLOYMENT_PODS_NAMES=$(KCL_DEPLOYMENT_PODS_NAMES)'
	@echo '    KCL_DEPLOYMENT_PODS_FIELDSELECTOR=$(KCL_DEPLOYMENT_PODS_FIELDSELECTOR)'
	@echo '    KCL_DEPLOYMENT_PODS_SELECTOR=$(KCL_DEPLOYMENT_PODS_SELECTOR)'
	@echo '    KCL_DEPLOYMENT_PORTFORWARD_ADDRESS=$(KCL_DEPLOYMENT_PORTFORWARD_ADDRESS)'
	@echo '    KCL_DEPLOYMENT_PORTFORWARD_PORTMAPPINGS=$(KCL_DEPLOYMENT_PORTFORWARD_PORTMAPPINGS)'
	@echo '    KCL_DEPLOYMENT_PORTFORWARD_TIMEOUT=$(KCL_DEPLOYMENT_PORTFORWARD_TIMEOUT)'
	@echo '    KCL_DEPLOYMENT_RECORD_FLAG=$(KCL_DEPLOYMENT_RECORD_FLAG)'
	@echo '    KCL_DEPLOYMENT_REPLICAS_COUNT=$(KCL_DEPLOYMENT_REPLICAS_COUNT)'
	@echo '    KCL_DEPLOYMENT_REPLICASET_NAME=$(KCL_DEPLOYMENT_REPLICASET_NAME)'
	@echo '    KCL_DEPLOYMENT_REPLICASETS_FIELDSELECTOR=$(KCL_DEPLOYMENT_REPLICASETS_FIELDSELECTOR)'
	@echo '    KCL_DEPLOYMENT_REPLICASETS_NAMES=$(KCL_DEPLOYMENT_REPLICASETS_NAMES)'
	@echo '    KCL_DEPLOYMENT_REPLICASETS_SELECTOR=$(KCL_DEPLOYMENT_REPLICASETS_SELECTOR)'
	@echo '    KCL_DEPLOYMENT_SELECTOR=$(KCL_DEPLOYMENT_SELECTOR)'
	@echo '    KCL_DEPLOYMENT_SERVICE_NAME=$(KCL_DEPLOYMENT_SERVICE_NAME)'
	@echo '    KCL_DEPLOYMENT_SERVICE_PORT=$(KCL_DEPLOYMENT_SERVICE_PORT)'
	@echo '    KCL_DEPLOYMENT_SERVICE_TARGETPORT=$(KCL_DEPLOYMENT_SERVICE_TARGETPORT)'
	@echo '    KCL_DEPLOYMENT_SERVICE_TYPE=$(KCL_DEPLOYMENT_SERVICE_TYPE)'
	@echo '    KCL_DEPLOYMENT_SERVICEACCOUNT_NAME=$(KCL_DEPLOYMENT_SERVICEACCOUNT_NAME)'
	@echo '    KCL_DEPLOYMENT_SERVICES_NAMES=$(KCL_DEPLOYMENT_SERVICES_NAMES)'
	@echo '    KCL_DEPLOYMENT_SERVICES_FIELDSELECTOR=$(KCL_DEPLOYMENT_SERVICES_FIELDSELECTOR)'
	@echo '    KCL_DEPLOYMENT_SERVICES_SELECTOR=$(KCL_DEPLOYMENT_SERVICES_SELECTOR)'
	@echo '    KCL_DEPLOYMENT_SSH_SHELL=$(KCL_DEPLOYMENT_SSH_SHELL)'
	@echo '    KCL_DEPLOYMENT_TAILCONTAINER_NAME=$(KCL_DEPLOYMENT_TAILCONTAINER_NAME)'
	@echo '    KCL_DEPLOYMENT_TAILFOLLOW_FLAG=$(KCL_DEPLOYMENT_TAILFOLLOW_FLAG)'
	@echo '    KCL_DEPLOYMENT_TAILHISTORY_COUNT=$(KCL_DEPLOYMENT_TAILHISTORY_COUNT)'
	@echo '    KCL_DEPLOYMENTS_FIELDSELECTOR=$(KCL_DEPLOYMENTS_FIELDSELECTOR)'
	@echo '    KCL_DEPLOYMENTS_MANIFEST_DIRPATH=$(KCL_DEPLOYMENTS_MANIFEST_DIRPATH)'
	@echo '    KCL_DEPLOYMENTS_MANIFEST_FILENAME=$(KCL_DEPLOYMENTS_MANIFEST_FILENAME)'
	@echo '    KCL_DEPLOYMENTS_MANIFEST_FILEPATH=$(KCL_DEPLOYMENTS_MANIFEST_FILEPATH)'
	@echo '    KCL_DEPLOYMENTS_MANIFEST_STDINFLAG=$(KCL_DEPLOYMENTS_MANIFEST_STDINFLAG)'
	@echo '    KCL_DEPLOYMENTS_MANIFEST_URL=$(KCL_DEPLOYMENTS_MANIFEST_URL)'
	@echo '    KCL_DEPLOYMENTS_MANIFESTS_DIRPATH=$(KCL_DEPLOYMENTS_MANIFESTS_DIRPATH)'
	@echo '    KCL_DEPLOYMENTS_NAMESPACE_NAME=$(KCL_DEPLOYMENTS_NAMESPACE_NAME)'
	@echo '    KCL_DEPLOYMENTS_OUTPUT_FORMAT=$(KCL_DEPLOYMENTS_OUTPUT_FORMAT)'
	@echo '    KCL_DEPLOYMENTS_SELECTOR=$(KCL_DEPLOYMENTS_SELECTOR)'
	@echo '    KCL_DEPLOYMENTS_SET_NAME=$(KCL_DEPLOYMENTS_SET_NAME)'
	@echo '    KCL_DEPLOYMENTS_SORTBY_JSONPATH=$(KCL_DEPLOYMENTS_SORTBY_JSONPATH)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Deployment ($(_KUBECTL_DEPLOYMENT_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_deployment                      - Annotate a deployment'
	@echo '    _kcl_apply_deployments                        - Apply manifest for one-por-more deployments'
	@echo '    _kcl_create_deployment                        - Create a new deployment'
	@echo '    _kcl_delete_deployment                        - Delete an existing deployment'
	@echo '    _kcl_diff_deployments                         - Diff a manifest with one-or-more existing deployments'
	@echo '    _kcl_edit_deployment                          - Edit a deployment'
	@echo '    _kcl_explain_deployment                       - Explain the deployment object'
	@echo '    _kcl_expose_deployment                        - Expose deployment by creating a service'
	@echo '    _kcl_kustomize_deployment                     - Kustomize one-or-more deployments'
	@echo '    _kcl_label_deployment                         - Label a deployment'
	@echo '    _kcl_patch_deployment                         - Patch a deployment'
	@echo '    _kcl_pause_deployment                         - Pause the rollout of a deployment'
	@echo '    _kcl_portforward_deployment                   - Port-forward local ports to a deployment'
	@echo '    _kcl_replace_deployment                       - Replace a deployment'
	@echo '    _kcl_reset_deployment                         - Reset a deployment pod-template'
	@echo '    _kcl_reset_deployment_environment             - Reset the environment in a deployment pod-template'
	@echo '    _kcl_reset_deployment_image                   - Reset the image in a deployment pod-template'
	@echo '    _kcl_reset_deployment_serviceaccount          - Reset the service-account in a deployment pod-template'
	@echo '    _kcl_restart_deployment                       - Restart rollout of a deployment'
	@echo '    _kcl_resume_deployment                        - Resume the paused-rollout of a deployment'
	@echo '    _kcl_rollback_deployment                      - Rollback a paused-rollout of a deployment'
	@echo '    _kcl_rollout_deployment                       - Rollout the new versionof a deployment'
	@echo '    _kcl_scale_deployment                         - Scale up or down a deployment'
	@echo '    _kcl_show_deployment                          - Show everything related to a deployment'
	@echo '    _kcl_show_deployment_description              - Show the description of a deployment'
	@echo '    _kcl_show_deployment_horizontalpodautoscaler  - Show the object of a deployment'
	@echo '    _kcl_show_deployment_object                   - Show the object of a deployment'
	@echo '    _kcl_show_deployment_pods                     - Show pods of a deployment'
	@echo '    _kcl_show_deployment_replicasets              - Show replicasets of a deployment'
	@echo '    _kcl_show_deployment_rollouthistory           - Show rollout-history of a deployment'
	@echo '    _kcl_show_deployment_rolloutstatus            - Show rollout-status of a deployment'
	@echo '    _kcl_show_deployment_services                 - Show services of a deployment'
	@echo '    _kcl_show_deployment_state                    - Show state of a deployment'
	@echo '    _kcl_tail_deployment                          - Tail pods of a deployment'
	@echo '    _kcl_unapply_deployments                      - Un-apply manifest for one-or-more deployments'
	@echo '    _kcl_unexpose_deployment                      - Un-expose manifest for a deployment'
	@echo '    _kcl_unlabel_deployment                       - Un-label manifest for a deployment'
	@echo '    _kcl_list_deployments                         - List all deployments'
	@echo '    _kcl_list_deployments_set                     - List a set of deployments'
	@echo '    _kcl_watch_deployments                        - Watching all deployments'
	@echo '    _kcl_watch_deployments_set                    - Watching a set of deployments'
	@echo '    _kcl_write_deployments                        - Write manifest for one-or-more deployments'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Annotating deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME) $(KCL_DEPLOYMENT_ANNOTATIONS_KEYVALUES)

_kcl_autoscale_deployment: # _kcl_create_horizontalpodautoscaler

_kcl_apply_deployment: _kcl_apply_deployments
_kcl_apply_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more deployments ...'; $(NORMAL)
	$(if $(KCL_DEPLOYMENTS_MANIFEST_FILEPATH),cat $(KCL_DEPLOYMENTS_MANIFEST_FILEPATH); echo)
	$(if $(filter true,$(KCL_DEPLOYMENTS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_DEPLOYMENTS_|)cat )
	$(if $(KCL_DEPLOYMENTS_MANIFEST_URL),curl -L $(KCL_DEPLOYMENTS_MANIFEST_URL); echo )
	$(if $(KCL_DEPLOYMENTS_MANIFESTS_DIRPATH),ls -al $(KCL_DEPLOYMENTS_MANIFESTS_DIRPATH); echo)
	$(_KCL_APPLY_DEPLOYMENTS_|)$(KUBECTL) apply $(__KCL_FILENAME__DEPLOYMENTS) $(__KCL_NAMESPACE__DEPLOYMENTS)

_kcl_create_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Creating deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a deployment, and if deployment is exposed, the associated service'; $(NORMAL)
	$(_KCL_CREATE_DEPLOYMENT_|)$(KUBECTL) create deployment $(strip $(__KCL_DRY_RUN__DEPLOYMENT) $(__KCL_EXPOSE__DEPLOYMENT) $(__KCL_IMAGE__DEPLOYMENT) $(__KCL_LABELS__DEPLOYMENT) $(__KCL_NAMESPACE__DEPLOYMENT) $(__KCL_OUTPUT__DEPLOYMENT) $(__KCL_PORT__DEPLOYMENT) $(__KCL_REPLICAS__DEPLOYMENT) $(__KCL_RESTART__DEPLOYMENT) $(__KCL_SERVICEACCOUNT__DEPLOYMENT) ) $(KCL_DEPLOYMENT_NAME) $(|_KCL_CREATE_DEPLOYMENT)

_kcl_delete_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Deleting deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT delete services of exposed deployments'; $(NORMAL)
	$(KUBECTL) delete deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_kcl_diff_deployment: _kcl_diff_deployments
_kcl_diff_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster state with manifest for one-or-more deployments ...'; $(NORMAL)
	@$(WARN) 'This operation submits to the cluster the manifest to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_DEPLOYMENTS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_DEPLOYMENTS_|)cat
	# curl -L $(KCL_DEPLOYMENTS_MANIFEST_URL)
	# ls -al $(KCL_DEPLOYMENTS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_DEPLOYMENTS_|)$(KUBECTL) diff $(__KCL_FILENAME__DEPLOYMENTS) $(__KCL_NAMESPACE__DEPLOYMENTS)

_kcl_edit_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Editing deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation automatically rolls out the new deployment'; $(NORMAL)
	$(KUBECTL) edit deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(__KCL_RECORD__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_kcl_explain_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Explaining the deployment object and its fields ...'; $(NORMAL)
	@$(WARN) 'This operation fails if you do not have access to a cluster'; $(NORMAL)
	$(KUBECTL) explain deployment$(KCL_DEPLOYMENT_FIELD_JSONPATH) $(__KCL_RECURSIVE__DEPLOYMENT)

_kcl_expose_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Exposing deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a service to expose the deployment pods'; $(NORMAL)
	@$(WARN) 'The name of that service is expected to be the same name as the one for the deployment'; $(NORMAL)
	$(KUBECTL) expose deployment $(__KCL_NAME__DEPLOYMENT) $(__KCL_PORT__DEPLOYMENT) $(__KCL_TARGET_PORT__DEPLOYMENT) $(__KCL_TYPE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_kcl_kustomize_deployment: _kcl_kustomize_deployments
_kcl_kustomize_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more deployments ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_DEPLOYMENT_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_DEPLOYMENT)

_kcl_label_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Labeling deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME) $(KCL_DEPLOYMENT_LABELS_KEYVALUES)

_kcl_list_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL deployments ...'; $(NORMAL)
	$(KUBECTL) get deployments --all-namespaces=true $(_X__KCL_NAMESPACE__DEPLOYMENTS) $(__KCL_OUTPUT_DEPLOYMENTS) $(_X__KCL_SELECTOR__DEPLOYMENTS) $(__KCL_SORT_BY__DEPLOYMENTS)

_kcl_list_deployments_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing deployments-set "$(KCL_DEPLOYMENTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Deployments are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get deployments --all-namespaces=false $(__KCL_NAMESPACE__DEPLOYMENTS) $(__KCL_OUTPUT__DEPLOYMENTS) $(__KCL_SELECTOR__DEPLOYMENTS) $(__KCL_SORT_BY__DEPLOYMENTS)

_kcl_patch_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Patching deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) patch deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(__KCL_PATCH__DEPLOYMENT) $(__KCL_PATCH_FILE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_kcl_pause_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Pausing rollout of deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout pause deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_kcl_portforward_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Port-forwarding a pod in deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation binds ports to 127.0.0.1 (host-port:container-port) but does NOT allow for bind addresses'; $(NORMAL)
	@$(WARN) 'If connection is idle, the port-forward will time out after a few minutes'; $(NORMAL)
	$(_KCL_PORTFORWARD_DEPLOYMENT_|)$(KUBECTL) port-forward $(__KCL_ADDRESS__DEPLOYMENT) $(__KCL_NAMESPACE__DEPLOYMENT) $(__KCL_POD_RUNNING_TIMEOUT__DEPLOYMENT) deployment/$(KCL_DEPLOYMENT_NAME) $(KCL_DEPLOYMENT_PORTFORWARD_PORTMAPPINGS) $(|_KCL_PORTFORWARD_DEPLOYMENT)

_kcl_replace_deployment_environment:
	@$(INFO) '$(KCL_UI_LABEL)Replacing deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(_KCL_REPLACE_DEPLOYMENT_|)$(KUBECTL) replace deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_KCL_RESET_DEPLOYMENT_TARGETS?= _kcl_reset_deployment_environment _kcl_reset_deployment_image _kcl_reset_deployment_resources _kcl_reset_deployment_selector _kcl_reset_deployment_serviceaccount
_kcl_reset_deployment: $(_KCL_RESET_DEPLOYMENT_TARGETS)

_kcl_reset_deployment_environment:
	@$(INFO) '$(KCL_UI_LABEL)Resetting environment in pod-template of deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) set env deployment $(__KCL_RECORD__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME) ...

_kcl_reset_deployment_image:
	@$(INFO) '$(KCL_UI_LABEL)Resetting image in pod-template of deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) set image deployment $(__KCL_RECORD__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME) $(KCL_DEPLOYMENT_PODCONTAINER_NAME)=$(KCL_DEPLOYMENT_PODCONTAINERIMAGE_NAME)

_kcl_reset_deployment_resources:
	@$(INFO) '$(KCL_UI_LABEL)Resetting resources in pod-template of deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) set resources deployment $(__KCL_RECORD__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME) ...

_kcl_reset_deployment_selector:

_kcl_reset_deployment_serviceaccount:
	@$(INFO) '$(KCL_UI_LABEL)Resetting service-account in pod-template of deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) set serviceaccount deployment $(__KCL_RECORD__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME) ...

_kcl_restart_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Restarting rollout of deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation forces a roll-out even if the deployment-template has not been changed'; $(NORMAL)
	@$(AWRN) 'This is useful to force pods to restart and read changes in config-maps or secrets'; $(NORMAL)
	$(KUBECTL) rollout restart deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_kcl_resume_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Resuming rollout of deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout resume deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_kcl_rollback_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Rolling-back version-template of deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout undo deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_kcl_rollout_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Rolling-out a new version-template of deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is a NO-OP'; $(NORMAL)
	@$(WARN) 'A deployment-rollout is trigger whenever the deployment template is changed'; $(NORMAL)
	@$(WARN) 'Try applying a new deployment-manifest or edit the deployment directly!'; $(NORMAL)
	@$(WARN) 'To force q rollout without a deployment-template change, use the "restart" command!'; $(NORMAL)

_kcl_scale_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Scaling up or down deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is identical to directly updating/editing the deployment object'; $(NORMAL)
	$(KUBECTL) scale $(__KCL_NAMESPACE__DEPLOYMENT) $(__KCL_REPLICAS__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_KCL_SHOW_DEPLOYMENT_TARGETS?= _kcl_show_deployment_horizontalpodautoscaler _kcl_show_deployment_object _kcl_show_deployment_pods _kcl_show_deployment_replicasets _kcl_show_deployment_rollouthistory _kcl_show_deployment_rolloutstatus _kcl_show_deployment_services _kcl_show_deployment_state _kcl_show_deployment_description
_kcl_show_deployment: $(_KCL_SHOW_DEPLOYMENT_TARGETS)

_kcl_show_deployment_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_kcl_show_deployment_horizontalpodautoscaler:
	@$(INFO) '$(KCL_UI_LABEL)Showing horizotal-pod-autoscaler of deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation requires the metrics-server to be running and the deployment pod template to have a CPU request'; $(NORMAL)
	$(if $(KCL_DEPLOYMENT_HORIZONTALPODAUTOSCALER_NAME), \
		$(KUBECTL) get $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_HORIZONTALPODAUTOSCALER) \
	, \
		@echo 'KCL_DEPLOYMENT_HORIZONTALPODAUTOSCALER_NAME not set' \
	)

_kcl_show_deployment_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(_X__KCL_OUTPUT__DEPLOYMENT) --output yaml $(KCL_DEPLOYMENT_NAME)

_kcl_show_deployment_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods spawned by deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(if $(KCL_DEPLOYMENT_PODS_FIELDSELECTOR)$(KCL_DEPLOYMENT_PODS_SELECTOR), \
		$(KUBECTL) get pods $(__KCL_NAMESPACE__DEPLOYMENT) \
			$(if $(KCL_DEPLOYMENT_PODS_FIELDSELECTOR),--field-selector $(KCL_DEPLOYMENT_PODS_FIELDSELECTOR)) \
			$(if $(KCL_DEPLOYMENT_PODS_SELECTOR),--selector $(KCL_DEPLOYMENT_PODS_SELECTOR)) \
	, @ \
		echo 'KCL_DEPLOYMENT_PODS_FIELDSELECTOR not set'; \
		echo 'KCL_DEPLOYMENT_PODS_SELECTOR not set'; \
	)

_kcl_show_deployment_rollouthistory:
	@$(INFO) '$(KCL_UI_LABEL)Showing rollout-history for deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout history deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_kcl_show_deployment_rolloutstatus:
	@$(INFO) '$(KCL_UI_LABEL)Showing rollout-status for deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) rollout status deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME)

_kcl_show_deployment_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Showing replicaset spawned by deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(if $(KCL_DEPLOYMENT_REPLICASETS_FIELDSELECTOR)$(KCL_DEPLOYMENT_REPLICASETS_SELECTOR), \
		$(KUBECTL) get replicaset $(__KCL_NAMESPACE__DEPLOYMENT) \
			$(if $(KCL_DEPLOYMENT_REPLICASETS_FIELDSELECTOR),--field-selector $(KCL_DEPLOYMENT_REPLICASETS_FIELDSELECTOR)) \
			$(if $(KCL_DEPLOYMENT_REPLICASETS_SELECTOR),--selector $(KCL_DEPLOYMENT_REPLICASETS_SELECTOR)) \
	, @ \
		echo 'KCL_DEPLOYMENT_REPLICASETS_FIELDSELECTOR not set' ; \
		echo 'KCL_DEPLOYMENT_REPLICASETS_SELECTOR not set' ; \
	)

_kcl_show_deployment_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing service spawned by exposing deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a service only if the deployment has been exposed'; $(NORMAL)
	$(if $(KCL_DEPLOYMENT_SERVICES_FIELDSELECTOR)$(KCL_DEPLOYMENT_SERVICES_SELECTOR), \
		$(KUBECTL) get services $(__KCL_NAMESPACE__DEPLOYMENT) \
			$(if $(KCL_DEPLOYMENT_SERVICES_FIELDSELECTOR),--field-selector $(KCL_DEPLOYMENT_SERVICES_FIELDSELECTOR)) \
			$(if $(KCL_DEPLOYMENT_SERVICES_SELECTOR),--selector $(KCL_DEPLOYMENT_SERVICES_SELECTOR)) \
	, @ \
		echo 'KCL_DEPLOYMENT_SERVICES_FIELDSELECTOR not set' ; \
		echo 'KCL_DEPLOYMENT_SERVICES_SELECTOR not set' ; \
	)

_kcl_show_deployment_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get deployment $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME) 

_kcl_tail_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Tailing pods spawned by deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation tails a single pod in the replica-set of the deployment'; $(NORMAL)
	$(_KCL_TAIL_DEPLOYMENT_|)$(KUBECTL) logs $(__KCL_CONTAINER__DEPLOYMENT) $(__KCL_FOLLOW__DEPLOYMENT) $(__KCL_NAMESPACE__DEPLOYMENT) $(__KCL_TAIL__DEPLOYMENT) deployment/$(strip $(KCL_DEPLOYMENT_NAME)) $(|_KCL_TAIL_DEPLOYMENT)

_kcl_unannotate_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Un-annotating deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME) $(foreach K,$(KCL_DEPLOYMENT_ANNOTATIONS_KEYS), $(K)-)

_kcl_unapply_deployment: _kcl_unapply_deployments
_kcl_unapply_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more deployments ...'; $(NORMAL)
	# cat $(KCL_DEPLOYMENTS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_DEPLOYMENTS_|)cat
	# curl -L $(KCL_DEPLOYMENTS_MANIFEST_URL)
	# ls -al $(KCL_DEPLOYMENTS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_DEPLOYMENTS_|)$(KUBECTL) delete $(__KCL_FILENAME__DEPLOYMENTS) $(__KCL_NAMESPACE__DEPLOYMENTS)

_kcl_unlabel_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_NAME) $(foreach K, $(KCL_DEPLOYMENT_LABELS_KEYS), $(K)-)

_kcl_unexpose_deployment:
	@$(INFO) '$(KCL_UI_LABEL)Unexposing deployment "$(KCL_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation deletes the service that was created to expose the deployment'; $(NORMAL)
	@$(WARN) 'This operation fails if that service does NOT exist'; $(NORMAL)
	-$(KUBECTL) delete service $(__KCL_NAMESPACE__DEPLOYMENT) $(KCL_DEPLOYMENT_SERVICE_NAME)

_kcl_watch_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Watching deployments ...'; $(NORMAL)
	$(KUBECTL) get deployments --all-namespaces=true --watch 

_kcl_watch_deployments_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching deployments-set "$(KCL_DEPLOYMENTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Deployments are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	# $(KUBECTL) get deployments --all-namespaces=false $(__KCL_NAMESPACE__DEPLOYMENTS) $(__KCL_OUTPUT__DEPLOYMENTS) $(__KCL_SELECTOR__DEPLOYMENTS) $(__KCL_SORT_BY__DEPLOYMENTS)

_kcl_write_deployment: _kcl_write_deployments
_kcl_write_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more deployments ...'; $(NORMAL)
	$(WRITER) $(KCL_DEPLOYMENTS_MANIFEST_FILEPATH)
