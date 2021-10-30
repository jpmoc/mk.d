_KUBECTL_NODE_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_NODE_DRYRUN_ENABLE?= false
# KCL_NODE_HEAPSTER_NAMESPACE?= kube-system
# KCL_NODE_HEAPSTER_PORT?=
# KCL_NODE_HEAPSTER_SCHEME?= http
# KCL_NODE_HEAPSTER_SERVICE?= heapster
# KCL_NODE_NAME?= ip-172-20-33-0.us-west-2.compute.internal
# KCL_NODE_NO_HEADERS?= true
# KCL_NODE_OUTPUT_FORMAT?= wide
# KCL_NODE_SHOW_KIND?= true
# KCL_NODE_SHOW_LABELS?= true
# KCL_NODE_TAINTS_KEYS?= dedicated ...
# KCL_NODE_TAINTS_KEYVALUES?= dedicated=foo:PreferNoSchedule ...
# KCL_NODE_YAML_FILEPATH?= ./node.yml
# KCL_NODES_CLUSTER_NAME?= my-cluster
# KCL_NODES_NAMES?= ip-172-20-33-0.us-west-2.compute.internal ...
# KCL_NODES_OUTPUT_FORMAT?= wide
# KCL_NODES_SELECTOR?=
# KCL_NODES_SET_NAME?= my-nodes-set
# KCL_NODES_SORT_BY?= '{.metadata.name}'
# KCL_NODES_WATCH_ONLY?= true

# Derived parameters
KCL_NODES_NAMES?= $(KCL_NODE_NAME)
KCL_NODES_OUTPUT_FORMAT?= $(KCL_NODE_OUTPUT_FORMAT)

# Option parameters
__KCL_ALL__NODE=
__KCL_ALLOW_MISSING_TEMPLATE_KEYS=
__KCL_CHUNK_SIZE=
__KCL_DRY_RUN__NODE= $(if $(KCL_NODE_DRYRUN_ENABLE),--dry-run=$(KCL_NODE_DRYRUN_ENABLE))
__KCL_EXPORT=
__KCL_FIELD_SELECTOR=
__KCL_FILENAME__NODE= $(if $(KCL_NODE_YAML_FILEPATH),--filename $(KCL_NODE_YAML_FILEPATH))
__KCL_HEAPSTER_NAMESPACE__NODE= $(if $(KCL_NODE_HEAPSTER_NAMESPACE),--heapster-namespace=$(KCL_NODE_HEAPSTER_NAMESPACE))
__KCL_HEAPSTER_PORT__NODE= $(if $(KCL_NODE_HEAPSTER_PORT),--heapster-port=$(KCL_NODE_HEAPSTER_PORT))
__KCL_HEAPSTER_SCHEME__NODE= $(if $(KCL_NODE_HEAPSTER_SCHEME),--heapster-scheme=$(KCL_NODE_HEAPSTER_SCHEME))
__KCL_HEAPSTER_SERVICE__NODE= $(if $(KCL_NODE_HEAPSTER_SERVICE),--heapster-service=$(KCL_NODE_HEAPSTER_SERVICE))
__KCL_IGNORE_NOT_FOUND=
__KCL_INCLUDE_UNINITIALIZED=
__KCL_LABEL_COLUMNS=
__KCL_NO_HEADERS__NODE= $(if $(KCL_NODE_NO_HEADERS),--no-headers=$(KCL_NODE_NO_HEADERS))
__KCL_OUTPUT__NODE= $(if $(KCL_NODE_OUTPUT_FORMAT),--output $(KCL_NODE_OUTPUT_FORMAT))
__KCL_OUTPUT__NODES= $(if $(KCL_NODES_OUTPUT_FORMAT),--output $(KCL_NODES_OUTPUT_FORMAT))
__KCL_OVERWRITE=
__KCL_RAW=
__KCL_RECORD=
__KCL_RECURSIVE=
__KCL_SAVE_CONFIG=
__KCL_SELECTOR__NODE= $(if $(KCL_NODES_SELECTOR),--selector=$(KCL_NODES_SELECTOR))
__KCL_SERVER_PRINT=
__KCL_SHOW_KIND__NODES= $(if $(filter true, $(KCL_NODE_SHOW_KIND)),--show-kind=$(KCL_NODE_SHOW_KIND))
__KCL_SHOW_LABELS__NODES= $(if $(KCL_NODE_SHOW_LABELS),--show-labels=$(KCL_NODE_SHOW_LABELS))
__KCL_SORT_BY__NODES= $(if $(KCL_NODES_SORT_BY),--sort-by=$(KCL_NODES_SORT_BY))
__KCL_TEMPLATE=
__KCL_VALIDATE=
__KCL_WATCH__NODES=
__KCL_WATCH_ONLY__NODES= $(if $(KCL_NODES_WATCH_ONLY),--watch-only=$(KCL_NODES_WATCH_ONLY))
__KCL_WINDOWS_LINE_ENDINGS==

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Node ($(_KUBECTL_NODE_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Node ($(_KUBECTL_NODE_MK_VERSION)) parameters:'
	@echo '    KCL_NODE_DRYRUN_ENABLE=$(KCL_NODE_DRYRUN_ENABLE)'
	@echo '    KCL_NODE_HEAPSTER_NAMESPACE=$(KCL_NODE_HEAPSTER_NAMESPACE)'
	@echo '    KCL_NODE_HEAPSTER_PORT=$(KCL_NODE_HEAPSTER_PORT)'
	@echo '    KCL_NODE_HEAPSTER_SCHEME=$(KCL_NODE_HEAPSTER_SCHEME)'
	@echo '    KCL_NODE_HEAPSTER_SERVICE=$(KCL_NODE_HEAPSTER_SERVICE)'
	@echo '    KCL_NODE_NAME=$(KCL_NODE_NAME)'
	@echo '    KCL_NODE_OUTPUT_FORMAT=$(KCL_NODE_OUTPUT_FORMAT)'
	@echo '    KCL_NODE_SELECTOR=$(KCL_NODE_SELECTOR)'
	@echo '    KCL_NODE_SHOW_KIND=$(KCL_NODE_SHOW_KIND)'
	@echo '    KCL_NODE_SHOW_LABELS=$(KCL_NODE_SHOW_LABELS)'
	@echo '    KCL_NODE_TAINTS_KEYS=$(KCL_NODE_TAINTS_KEYS)'
	@echo '    KCL_NODE_TAINTS_KEYVALUES=$(KCL_NODE_TAINTS_KEYVALUES)'
	@echo '    KCL_NODE_YAML_FILEPATH=$(KCL_NODE_YAML_FILEPATH)'
	@echo '    KCL_NODES_NAMES=$(KCL_NODES_NAMES)'
	@echo '    KCL_NODES_OUTPUT_FORMAT=$(KCL_NODES_OUTPUT_FORMAT)'
	@echo '    KCL_NODES_SELECTOR=$(KCL_NODES_SELECTOR)'
	@echo '    KCL_NODES_SET_NAME=$(KCL_NODES_SET_NAME)'
	@echo '    KCL_NODES_WATCH_ONLY=$(KCL_NODES_WATCH_ONLY)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Node ($(_KUBECTL_NODE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_node                     - Annotate node'
	@echo '    _kcl_cordon_node                       - Cordon a node'
	@echo '    _kcl_drain_node                        - Drain a node'
	@echo '    _kcl_edit_node                         - Edit node object'
	@echo '    _kcl_explain_node                      - Explain node object'
	@echo '    _kcl_label_node                        - Label a node'
	@echo '    _kcl_list_nodes                        - List all nodes'
	@echo '    _kcl_list_nodes_set                    - List a set of nodes'
	@echo '    _kcl_show_node                         - Show everything related to a node'
	@echo '    _kcl_show_node_consumedresources       - Show consumed-resources on a node'
	@echo '    _kcl_show_node_description             - Show description of a node'
	@echo '    _kcl_taint_node                        - Taint a node'
	@echo '    _kcl_uncordon_node                     - Uncordon a node'
	@echo '    _kcl_unlabel_node                      - Remove labels from a node'
	@echo '    _kcl_untaint_node                      - Untaint a node'
	@echo '    _kcl_update_node                       - Update a node'
	@echo '    _kcl_watch_nodes                       - Watch nodes'
	@echo '    _kcl_watch_nodes_set                   - Watch a set of nodes'
	@#echo '    _kcl_write_nodes                       - Write manifest for one-or-more nodes'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_node:
	@$(INFO) '$(KCL_UI_LABEL)Annotating node "$(KCL_NODE_NAME)" ...'; $(NORMAL)

_kcl_cordon_node:
	@$(INFO) '$(KCL_UI_LABEL)Cordon node "$(KCL_NODES_NAMES)" ...'; $(NORMAL)
	@$(WARN) 'This operation marks the node as unschedulable'; $(NORMAL)
	$(KUBECTL) cordon $(__KCL_DRY_RUN__NODE) $(__KCL_SELECTOR__NODE) $(KCL_NODE_NAME)

_X_kcl_create_node:

_X_kcl_delete_node:

_kcl_drain_node:
	@$(INFO) '$(KCL_UI_LABEL)Draining connections on node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) drain $(KCL_NODE_NAME)

_kcl_edit_node:
	@$(INFO) '$(KCL_UI_LABEL)Editing node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit $(__KCL_ALLOW_MISSING_TEMPLATE_KEYS) $(__KCL_FILENAME__NODE) $(__KCL_INCLUDE_UNINITIALIZED) $(__KCL_OUTPUT__NODE) $(__KCL_RECORD) $(__KCL_RECURSIVE) $(__KCL_SAVE_CONFIG) $(__KCL_TEMPLATE) $(__KCL_VALLIDATE) $(__KCL_WINDOWS_LINE_ENDINGS) $(KCL_NODE_NAME)

_kcl_explain_node:
	@$(INFO) '$(KCL_UI_LABEL)Explaining node object ...'; $(NORMAL)
	$(KUBECTL) explain node

_kcl_label_node:
	@$(INFO) '$(KCL_UI_LABEL)Labelling node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label nodes $(KCL_NODE_NAME) $(KCL_NODE_LABELS_KEYVALUES)

_kcl_list_nodes:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL nodes ...'; $(NORMAL)
	$(KUBECTL) get nodes $(strip $(_X__KCL_ALL_NAMESPACES) $(__KCL_ALLOW_MISSING_TEMPLATE_KEYS) $(__KCL_CHUNK_SIZE) $(__KCL_EXPORT) $(__KCL_FIELD_SELECTOR) $(__KCL_FILENAME) $(__KCL_IGNORE_NOT_FOUND) $(__KCL_INCLUDE_UNINITIALIZED) $(__KCL_LABEL_COLUMNS) $(__KCL_NO_HEADERS__NODES) $(__KCL_OUTPUT__NODES) $(__KCL_RAW) $(__KCL_RECURSIVE) $(__KCL_SELECTOR__NODES) $(__KCL_SERVER_PRINT) $(__KCL_SHOW_KIND__NODES) $(__KCL_SHOW_LABELS__NODES) $(__KCL_SORT_BY__NODES) $(__KCL_TEMPLATE) $(__KCL_USE_OPENAPI_PRINT_COLUMNS) $(_X__KCL_WATCH__NODES) $(_X__KCL_WATCH_ONLY__NODES) )

_kcl_list_nodes_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing nodes-set "$(KCL_NODES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get nodes $(strip $(_X__KCL_ALL_NAMESPACES) $(__KCL_ALLOW_MISSING_TEMPLATE_KEYS) $(__KCL_CHUNK_SIZE) $(__KCL_EXPORT) $(__KCL_FIELD_SELECTOR) $(__KCL_FILENAME) $(__KCL_IGNORE_NOT_FOUND) $(__KCL_INCLUDE_UNINITIALIZED) $(__KCL_LABEL_COLUMNS) $(__KCL_NO_HEADERS__NODES) $(__KCL_OUTPUT__NODES) $(__KCL_RAW) $(__KCL_RECURSIVE) $(__KCL_SELECTOR__NODES) $(__KCL_SERVER_PRINT) $(__KCL_SHOW_KIND__NODES) $(__KCL_SHOW_LABELS__NODES) $(__KCL_SORT_BY__NODES) $(__KCL_TEMPLATE) $(__KCL_USE_OPENAPI_PRINT_COLUMNS) $(_X__KCL_WATCH__NODES) $(_X__KCL_WATCH_ONLY__NODES) )

_KCL_SHOW_NODE_TARGETS?= _kcl_show_node_consumedresources _kcl_show_node_objectrepresentation _kcl_show_node_description
_kcl_show_node: $(_KCL_SHOW_NODE_TARGETS)

_kcl_show_node_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe node $(KCL_NODE_NAME)

_kcl_show_node_consumedresources:
	@$(INFO) '$(KCL_UI_LABEL)Showing consumed-resources on node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if heapster is not installed!'; $(NORMAL)
	-$(KUBECTL) top node $(__KCL_HEAPSTER_NAMESPACE__NODE) $(__HEAPSTER_PORT__NODE) $(__KCL_HEAPSTER_SCHEME__NODE) $(__KCL_HEAPSTER_SERVICE__NODE) $(KCL_NODE_NAME)

_kcl_show_node_objectrepresentation:
	@$(INFO) '$(KCL_UI_LABEL)Showing object-representation of node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get node -o yaml $(KCL_NODE_NAME)

_kcl_taint_node:
	@$(INFO) '$(KCL_UI_LABEL)Taint node "$(KCL_NODES_NAMES)" ...'; $(NORMAL)
	$(KUBECTL) taint node $(__KCL_ALL__NODE) $(__KCL_ALLOW_MISSING_TEMPLATE_KEYS) $(__KCL_OUTPUT__NODE) $(__KCL_OVERWRITE) $(__KCL_SELECTOR__NODE) $(__KCL_TEMPLATE) $(__KCL_VALIDATE) $(KCL_NODE_NAME) $(KCL_NODE_TAINTS_KEYVALUES)

_kcl_top_node: _kcl_show_node_consumedresources

_kcl_uncordon_node:
	
_kcl_unlabel_node:
	@$(INFO) '$(KCL_UI_LABEL)Removing labels from node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label nodes $(KCL_NODE_NAME) $(_X_KCL_NODE_LABELS_KEYVALUES) $(foreach K,$(KCL_NODE_LABELS_KEYS),$(K)- )

_kcl_untaint_node:
	# For node with special hardware
	# https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
	@$(INFO) '$(KCL_UI_LABEL)Untaint node "$(KCL_NODES_NAMES)" ...'; $(NORMAL)
	$(KUBECTL) taint node $(__KCL_ALL__NODE) $(__KCL_ALLOW_MISSING_TEMPLATE_KEYS) $(__KCL_OUTPUT__NODE) $(__KCL_OVERWRITE) $(__KCL_SELECTOR__NODE) $(__KCL_TEMPLATE) $(__KCL_VALIDATE) $(KCL_NODE_NAME) $(foreach K, $(KCL_NODE_TAINTS_KEYS), $(K)-)

_kcl_update_node:

_kcl_watch_nodes:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL nodes ...'; $(NORMAL)
	$(KUBECTL) get nodes $(strip $(_X__KCL_ALL_NAMESPACES) $(__KCL_ALLOW_MISSING_TEMPLATE_KEYS) $(__KCL_CHUNK_SIZE) $(__KCL_EXPORT) $(__KCL_FIELD_SELECTOR) $(__KCL_FILENAME) $(__KCL_IGNORE_NOT_FOUND) $(__KCL_INCLUDE_UNINITIALIZED) $(__KCL_LABEL) $(__KCL_NO_HEADERS__NODES) $(__KCL_OUTPUT__NODES) $(__KCL_RAW) $(__KCL_RECURSIVE) $(__KCL_SELECTOR__NODES) $(__KCL_SERVER_PRINT) $(__KCL_SHOW_KIND__NODES) $(__KCL_SHOW_LABELS__NODES) $(__KCL_SORT_BY__NODES) $(__KCL_TEMPLATE) $(__KCL_USE_OPENAPI_PRINT_COLUMNS) $(_X__KCL_WATCH__NODES) --watch=true $(__KCL_WATCH_ONLY__NODES) )

_kcl_watch_nodes_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching nodes-set "$(KCL_NODES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get nodes $(strip $(_X__KCL_ALL_NAMESPACES) $(__KCL_ALLOW_MISSING_TEMPLATE_KEYS) $(__KCL_CHUNK_SIZE) $(__KCL_EXPORT) $(__KCL_FIELD_SELECTOR) $(__KCL_FILENAME) $(__KCL_IGNORE_NOT_FOUND) $(__KCL_INCLUDE_UNINITIALIZED) $(__KCL_LABEL) $(__KCL_NO_HEADERS__NODES) $(__KCL_OUTPUT__NODES) $(__KCL_RAW) $(__KCL_RECURSIVE) $(__KCL_SELECTOR__NODES) $(__KCL_SERVER_PRINT) $(__KCL_SHOW_KIND__NODES) $(__KCL_SHOW_LABELS__NODES) $(__KCL_SORT_BY__NODES) $(__KCL_TEMPLATE) $(__KCL_USE_OPENAPI_PRINT_COLUMNS) $(_X__KCL_WATCH__NODES) --watch=true $(__KCL_WATCH_ONLY__NODES) )

_kcl_write_nodes:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more nodes ...'; $(NORMAL)
