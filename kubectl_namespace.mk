_KUBECTL_NAMESPACE_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_NAMESPACE_ANNOTATIONS_KEYS?=
# KCL_NAMESPACE_ANNOTATIONS_KEYVALUES?=
# KCL_NAMESPACE_CONTEXT_NAME?=
# KCL_NAMESPACE_DRYRUN_MODE?= client
KCL_NAMESPACE_LABELOVERWRITE_FLAG?= false
# KCL_NAMESPACE_LABELS_KEYS?= istio-injection ...
# KCL_NAMESPACE_LABELS_KEYVALUES?= istio-injection=enabled ...
KCL_NAMESPACE_NAME?= default
# KCL_NAMESPACE_PODS_NAMES?= nginx-5d45ff55fc-sgnj7 ...
# KCL_NAMESPACES_FIELDSELECTOR?=
# KCL_NAMESPACES_MANIFEST_DIRPATH?= ./in/
# KCL_NAMESPACES_MANIFEST_FILENAME?= manifest.yaml
# KCL_NAMESPACES_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_NAMESPACES_MANIFEST_STDINFLAG?= false
# KCL_NAMESPACES_MANIFEST_URL?= http://...
# KCL_NAMESPACES_MANIFESTS_DIRPATH?= ./in/
# KCL_NAMESPACES_SELECTOR?=
# KCL_NAMESPACES_SET_NAME?= my-namespaces-set
# KCL_NAMESPACES_SORTBY_JSONPATH?=

# Derived parameters
KCL_NAMESPACE_CONTEXT_NAME?= $(KCL_CONTEXT_NAME)
KCL_NAMESPACES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_NAMESPACES_MANIFEST_FILEPATH?= $(if $(KCL_NAMESPACES_MANIFEST_DIRPATH),$(KCL_NAMESPACES_MANIFEST_DIRPATH)$(KCL_NAMESPACES_MANIFEST_FILENAME))
KCL_NAMESPACES_NAMES?= $(KCL_NAMESPACE_NAME)

# Options
__KCL_DRY_RUN__NAMESPACE= $(if $(KCL_NAMESPACE_DRYRUN_MODE),--dry-run=$(KCL_NAMESPACE_DRYRUN_MODE))
__KCL_FILENAME__NAMESPACES+= $(if $(KCL_NAMESPACES_MANIFEST_FILEPATH),--filename $(KCL_NAMESPACES_MANIFEST_FILEPATH))
__KCL_FILENAME__NAMESPACES+= $(if $(filter true,$(KCL_NAMESPACES_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__NAMESPACES+= $(if $(KCL_NAMESPACES_MANIFEST_URL),--filename $(KCL_NAMESPACES_MANIFEST_URL))
__KCL_FILENAME__NAMESPACES+= $(if $(KCL_NAMESPACES_MANIFESTS_DIRPATH),--filename $(KCL_NAMESPACES_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__NAMESPACE= $(if $(KCL_NAMESPACE_NAME),--namespace $(KCL_NAMESPACE_NAME))
__KCL_OVERWRITE__NAMESPACE= $(if $(filter true,$(KCL_NAMESPACE_LABELOVERWRITE_FLAG)),--overwrite)
__KCL_RESOURCE_VERSION__NAMESPACE=
__KCL_WATCH_ONLY__NAMESPACES=

# Customizations
_KCL_APPLY_NAMESPACES_|?= #
_KCL_CREATE_NAMESPACE_|?= #
_KCL_DIFF_NAMESPACES_|?= $(_KCL_APPLY_NAMESPACES_|)
_KCL_SHOW_NAMESPACE_ALLOCATEDRESOURCES_|?= -#
_KCL_SHOW_NAMESPACE_DESCRIPTION_|?= #
_KCL_UNAPPLY_NAMESPACES_|?= $(_KCL_APPLY_NAMESPACES_|)
|_KCL_CREATE_NAMESPACE?= # | tee > namespace.yaml
|_KCL_SHOW_NAMESPACE_EVENTS?= # | tail -10

# Macros

_kcl_get_namespace_pod_names= $(call _kcl_get_namespace_pod_names_N, $(KCL_NAMESPACE_NAME))
_kcl_get_namespace_pod_names_N= $(shell $(KUBECTL) get pods --namespace $(1) --output jsonpath="{.items[*].metadata.name}")

_kcl_get_namespaces_names= $(shell $(KUBECTL) get namespaces --output jsonpath="{.items[*].metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Namespace ($(_KUBECTL_NAMESPACE_MK_VERSION)) macros:'
	@echo '    _kcl_get_namespace_pod_names_{N}      - Get the pods in a namespace (Name)'
	@echo '    _kcl_get_namespaces_names             - Get the name of all the namespaces'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Namespace ($(_KUBECTL_NAMESPACE_MK_VERSION)) parameters:'
	@echo '    KCL_NAMESPACE_ANNOTATIONS_KEYS=$(KCL_NAMESPACE_ANNOTATIONS_KEYS)'
	@echo '    KCL_NAMESPACE_ANNOTATIONS_KEYVALUES=$(KCL_NAMESPACE_ANNOTATION_KEYVALUES)'
	@echo '    KCL_NAMESPACE_CONTEXT_NAME=$(KCL_NAMESPACE_CONTEXT_NAME)'
	@echo '    KCL_NAMESPACE_DRYRUN_MODE=$(KCL_NAMESPACE_DRYRUN_MODE)'
	@echo '    KCL_NAMESPACE_LABELOVERWRITE_FLAG=$(KCL_NAMESPACE_LABELOVERWRITE_FLAG)'
	@echo '    KCL_NAMESPACE_LABELS_KEYS=$(KCL_NAMESPACE_LABELS_KEYS)'
	@echo '    KCL_NAMESPACE_LABELS_KEYVALUES=$(KCL_NAMESPACE_LABELS_KEYVALUES)'
	@echo '    KCL_NAMESPACE_NAME=$(KCL_NAMESPACE_NAME)'
	@echo '    KCL_NAMESPACE_PODS_NAMES=$(KCL_NAMESPACE_PODS_NAMES)'
	@echo '    KCL_NAMESPACES_FIELDSELECTOR=$(KCL_NAMESPACES_FIELDSELECTOR)'
	@echo '    KCL_NAMESPACES_MANIFEST_DIRPATH=$(KCL_NAMESPACES_MANIFEST_DIRPATH)'
	@echo '    KCL_NAMESPACES_MANIFEST_FILENAME=$(KCL_NAMESPACES_MANIFEST_FILENAME)'
	@echo '    KCL_NAMESPACES_MANIFEST_FILEPATH=$(KCL_NAMESPACES_MANIFEST_FILEPATH)'
	@echo '    KCL_NAMESPACES_MANIFEST_URL=$(KCL_NAMESPACES_MANIFEST_URL)'
	@echo '    KCL_NAMESPACES_MANIFESTS_DIRPATH=$(KCL_NAMESPACES_MANIFESTS_DIRPATH)'
	@echo '    KCL_NAMESPACES_SELECTOR=$(KCL_NAMESPACES_SELECTOR)'
	@echo '    KCL_NAMESPACES_SET_NAME=$(KCL_NAMESPACES_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Namespace ($(_KUBECTL_NAMESPACE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_namespace                    - Annotate a namespace'
	@echo '    _kcl_apply_namespaces                      - Applying manifest for one-or-more namespaces'
	@echo '    _kcl_contextualize_namespace               - Update the context with a namespace'
	@echo '    _kcl_create_namespace                      - Create a new namespace'
	@echo '    _kcl_delete_namespace                      - Delete an existing namespace'
	@echo '    _kcl_diff_namespaces                       - Diff cluster-state with a manifest of one-or-more namespaces'
	@echo '    _kcl_edit_namespace                        - Edit a namespace'
	@echo '    _kcl_explain_namespace                     - Explain the namespace object'
	@echo '    _kcl_label_namespace                       - Label a namespace'
	@echo '    _kcl_list_namespaces                       - List all namespaces'
	@echo '    _kcl_list_namespaces_set                   - List a set ofnamespaces'
	@echo '    _kcl_patch_namespace                       - Patch namespace'
	@echo '    _kcl_reset_namespace                       - Reset a namespace'
	@echo '    _kcl_show_namespace                        - Show everything related to a namespace'
	@echo '    _kcl_show_namespace_all                    - Show "all" resources in a namespace'
	@echo '    _kcl_show_namespace_allocatedresources     - Show allocated-resources to a namespace'
	@echo '    _kcl_show_namespace_cronjobs               - Show cronjobs in a namespace'
	@echo '    _kcl_show_namespace_daemonsets             - Show daemonsets in a namespace'
	@echo '    _kcl_show_namespace_deployments            - Show deployments in a namespace'
	@echo '    _kcl_show_namespace_description            - Show description of a namespace'
	@echo '    _kcl_show_namespace_events                 - Show events of a namespace'
	@echo '    _kcl_show_namespace_jobs                   - Show jobs in a namespace'
	@echo '    _kcl_show_namespace_limitranges            - Show limit-ranges in a namespace'
	@echo '    _kcl_show_namespace_networkpolicies        - Show netowkr-policies in a namespace'
	@echo '    _kcl_show_namespace_poddisruptionbudgets   - Show pod-disruption-budgets in a namespace'
	@echo '    _kcl_show_namespace_pods                   - Show pods in a namespace'
	@echo '    _kcl_show_namespace_quotas                 - Show quotas in a namespace'
	@echo '    _kcl_show_namespace_replicasets            - Show replica-sets in a namespace'
	@echo '    _kcl_show_namespace_rolebindings           - Show roles-binding in a namespace'
	@echo '    _kcl_show_namespace_roles                  - Show roles in a namespace'
	@echo '    _kcl_show_namespace_secrets                - Show secrets in a namespace'
	@echo '    _kcl_show_namespace_serviceaccounts        - Show service-accounts in a namespace'
	@echo '    _kcl_show_namespace_services               - Show services in a namespace'
	@echo '    _kcl_tail_namespace                        - Tail matched pod in a namespace'
	@echo '    _kcl_top_namespace                         - Top a namespace'
	@echo '    _kcl_unannotate_namespace                  - Un-annotate a namespace'
	@echo '    _kcl_unapply_namespace                     - Un-applying manifest for a namespace'
	@echo '    _kcl_unlabel_namespace                     - Remove labels of a namespace'
	@echo '    _kcl_watch_namespaces                      - Watch namespaces'
	@echo '    _kcl_watch_namespaces_set                  - Watch a set of namespaces'
	@echo '    _kcl_write_namespaces                      - Write manifest for one-or-more namespaces'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_namespace:
	@$(INFO) '$(KCL_UI_LABEL)Annotating namespace "$(KCL_NAMESPACE_NAME)"  ...'; $(NORMAL)
	$(KUBECTL) annotate namespace $(__KCL_OVERWRITE__NAMESPACE) $(KCL_NAMESPACE_NAME) $(KCL_NAMESPACE_ANNOTATIONS_KEYVALUES)

_kcl_apply_namespace: _kcl_apply_namespaces
_kcl_apply_namespaces:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more namespaces ...'; $(NORMAL)
	$(if $(KCL_NAMESPACES_MANIFEST_FILEPATH),cat $(KCL_NAMESPACES_MANIFEST_FILEPATH); echo)
	$(if $(filter true,$(KCL_NAMESPACES_MANIFEST_STDINFLAG)),$(_KCL_APPLY_NAMESPACES_|)cat)
	$(if $(KCL_NAMESPACES_MANIFEST_URL),curl -L $(KCL_NAMESPACES_MANIFEST_URL); echo)
	$(if $(KCL_NAMESPACES_MANIFESTS_DIRPATH),ls -al $(KCL_NAMESPACES_MANIFESTS_DIRPATH); echo)
	$(_KCL_APPLY_NAMESPACES_|)$(KUBECTL) apply $(__KCL_FILENAME__NAMESPACES)

_kcl_contextualize_namespace:
	@$(INFO) '$(KCL_UI_LABEL)Update the context with  namespace "$(KCL_NAMESPACE_NAME)"  ...'; $(NORMAL)
	$(KUBECTL) config set-context $(__KCL_NAMESPACE__NAMESPACE) $(KCL_NAMESPACE_CONTEXT_NAME)

_kcl_create_namespace:
	@$(INFO) '$(KCL_UI_LABEL)Creating namespace "$(KCL_NAMESPACE_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the namespace already exists'; $(NORMAL)
	$(_KCL_CREATE_NAMESPACE_|)$(KUBECTL) create namespace $(__KCL_DRY_RUN__NAMESPACE) $(KCL_NAMESPACE_NAME) $(|_KCL_CREATE_NAMESPACE)

_kcl_delete_namespace:
	@$(INFO) '$(KCL_UI_LABEL)Deleting namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation deletes the namespace and all of its resources'; $(NORMAL)
	$(KUBECTL) delete namespace $(KCL_NAMESPACE_NAME)

_kcl_diff_namespace: _kcl_diff_namespaces
_kcl_diff_namespaces:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more namespaces  ...'; $(NORMAL)
	@$(WARN) 'This operation submits the manifest to the cluster to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_NAMESPACES_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_NAMESPACES_|)cat
	# curl -L $(KCL_NAMESPACES_MANIFEST_URL)
	# ls -al $(KCL_NAMESPACES_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_NAMESPACES_|)$(KUBECTL) diff $(__KCL_FILENAME__NAMESPACES)

_kcl_edit_namespace:
	@$(INFO) '$(KCL_UI_LABEL)Editing namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit namespace $(KCL_NAMESPACE_NAME)

_kcl_explain_namespace:
	@$(INFO) '$(KCL_UI_LABEL)Explaining namespace object ...'; $(NORMAL)
	$(KUBECTL) explain namespace

_kcl_label_namespace:
	@$(INFO) '$(KCL_UI_LABEL)Labeling namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label namespace $(strip $(_X__KCL_DRY_RUN__NAMESPACE) $(__KCL_OVERWRITE__NAMESPACE) $(__KCL_RESOURCE_VERSION__NAMESPACE) $(KCL_NAMESPACE_NAME) $(KCL_NAMESPACE_LABELS_KEYVALUES) )

_kcl_list_namespaces:
	@$(INFO) '$(KCL_UI_LABEL)List ALL namespaces ...'; $(NORMAL)
	$(KUBECTL) get namespaces

_kcl_list_namespaces_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing namespaces-set "$(KCL_NAMESPACES_SET_NAME)" ...'; $(NORMAL)

_kcl_patch_namespace:
	@$(INFO) '$(KCL_UI_LABEL)Patching namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)

_kcl_reset_namespace:
	@$(INFO) '$(KCL_UI_LABEL)Resetting namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete pods $(__KCL_NAMESPACE__NAMESPACE) $(KCL_NAMESPACE_PODS_NAMES)

_KCL_SHOW_NAMESPACE_TARGETS?= _kcl_show_namespace__header _kcl_show_namespace_all _kcl_show_namespace_allocatedresources _kcl_show_namespace_configmaps _kcl_show_namespace_cronjobs _kcl_show_namespace_daemonsets _kcl_show_namespace_deployments _kcl_show_namespace_events _kcl_show_namespace_jobs _kcl_show_namespace_limitranges _kcl_show_namespace_networkpolicies _kcl_show_namespace_podautoscalers _kcl_show_namespace_poddisruptionbudgets _kcl_show_namespace_pods _kcl_show_namespace_quotas _kcl_show_namespace_replicasets _kcl_show_namespace_rolebindings _kcl_show_namespace_roles _kcl_show_namespace_secrets _kcl_show_namespace_serviceaccounts _kcl_show_namespace_services _kcl_show_namespace_description _kcl_show_namespace__footer
_kcl_show_namespace :: $(_KCL_SHOW_NAMESPACE_TARGETS)

_kcl_show_namespace__footer ::

_kcl_show_namespace__header ::

_kcl_show_namespace_all:
	@$(INFO) '$(KCL_UI_LABEL)Showing all in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get $(__KCL_NAMESPACE__NAMESPACE) all

_kcl_show_namespace_allocatedresources:
	@$(INFO) '$(KCL_UI_LABEL)Showing allocated-resources to namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the metrics-server is not running'; $(NORMAL)
	@$(WARN) 'For best results, the CPU requests must be set for all running pods'; $(NORMAL)
	$(_KCL_SHOW_NAMESPACE_ALLOCATEDRESOURCES_|)$(KUBECTL) top pod $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_configmaps:
	@$(INFO) '$(KCL_UI_LABEL)Showing config-maps in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get configmap $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Showing cronjobs in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get cronjobs $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_daemonsets:
	@$(INFO) '$(KCL_UI_LABEL)Showing daemonsets in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get daemonsets $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Showing deployments in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get deployments $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the namespace does NOT exist'; $(NORMAL)
	$(_KCL_SHOW_NAMESPACE_DESCRIPTION_|)$(KUBECTL) describe namespace $(KCL_NAMESPACE_NAME)

_kcl_show_namespace_events:
	@$(INFO) '$(KCL_UI_LABEL)Showing events of namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get events $(__KCL_NAMESPACE__NAMESPACE)$(|_KCL_SHOW_NAMESPACE_EVENTS)

_kcl_show_namespace_horizontalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Showing horizontal-pod-autoscalers in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get horizontalpodautoscalers $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_jobs:
	@$(INFO) '$(KCL_UI_LABEL)Showing jobs in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get jobs $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_limitranges:
	@$(INFO) '$(KCL_UI_LABEL)Showing limit-ranges in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get limitranges $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_networkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Showing network-policies in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL)  get networkpolicies $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_podautoscalers: _kcl_show_namespace_horizontalpodautoscalers _kcl_show_namespace_verticalpodautoscalers

_kcl_show_namespace_poddisruptionbudgets:
	@$(INFO) '$(KCL_UI_LABEL)Showing pod-disruption-budgets in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get poddisruptionbudgets $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pods $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_quotas:
	@$(INFO) '$(KCL_UI_LABEL)Showing quotas in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get quota $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Showing replica-sets in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get replicasets $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_rolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Showing role-bindings in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get rolebindings $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_roles:
	@$(INFO) '$(KCL_UI_LABEL)Showing roles in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get roles $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_secrets:
	@$(INFO) '$(KCL_UI_LABEL)Showing secrets in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'At the minimum, this operation returns the secret used by the default service account'; $(NORMAL)
	$(KUBECTL) get secrets $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_serviceaccounts:
	@$(INFO) '$(KCL_UI_LABEL)Showing service-accounts in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'At the minimum, this operation returns the default service account'; $(NORMAL)
	$(KUBECTL) get serviceaccounts $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing services in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get services $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_verticalpodautoscalers:
	@$(INFO) '$(KCL_UI_LABEL)Showing vertical-pod-autoscalers in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	-$(KUBECTL) get verticalpodautoscalers $(__KCL_NAMESPACE__NAMESPACE)

_kcl_tail_namespace: _stn_tail_namespace

_kcl_top_namespace: _kcl_show_namespace_allocatedresources

_kcl_unannotate_namespace:
	@$(INFO) '$(KCL_UI_LABEL)Un-annotating namespace "$(KCL_NAMESPACE_NAME)"  ...'; $(NORMAL)
	$(KUBECTL) annotate namespace $(__KCL_OVERWRITE__NAMESPACE) $(KCL_NAMESPACE_NAME) $(foreach K,$(KCL_NAMESPACE_ANNOTATIONS_KEYS), $(K)-)


_kcl_unapply_namespace: _kcl_unapply_namespaces
_kcl_unapply_namespaces:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more namespaces ...'; $(NORMAL)
	# cat $(KCL_NAMESPACES_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_NAMESPACES_|)cat
	# curl -L $(KCL_NAMESPACES_MANIFEST_URL)
	# ls -al $(KCL_NAMESPACES_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_NAMESPACES_|)$(KUBECTL) delete $(__KCL_FILENAME__NAMESPACES)

_kcl_unlabel_namespace:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label namespace $(strip $(_X__KCL_DRY_RUN__NAMESPACE) $(_X__KCL_OVERWRITE__NAMESPACE) $(__KCL_RESOURCE_VERSION__NAMESPACE) $(KCL_NAMESPACE_NAME) $(X_KCL_NAMESPACE_LABELS_KEYVALUES) $(foreach K,$(KCL_NAMESPACE_LABELS_KEYS),$(K)- ) )

_kcl_watch_namespaces:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL namespaces ...'; $(NORMAL)
	$(KUBECTL) get namespaces --watch=true $(__KCL_WATCH_ONLY__NAMESPACES)

_kcl_watch_namespaces_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching namespaces-set "$(KCL_NAMESPACES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get namespaces --watch=true $(__KCL_WATCH_ONLY__NAMESPACES)

_kcl_write_namespaces:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more namespaces ...'; $(NORMAL)
	$(WRITER) $(KCL_NAMESPACES_MANNIFEST_FILEPATH)
