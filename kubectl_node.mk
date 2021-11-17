_KUBECTL_NODE_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_NODE_DRYRUN_FALSE?= false
# KCL_NODE_FIELD_JSONPATH?= .spec.metadata
# KCL_NODE_NAME?= ip-172-20-33-0.us-west-2.compute.internal
# KCL_NODE_NOHEADERS_FLAG?= true
# KCL_NODE_OUTPUT_FORMAT?= wide
# KCL_NODE_SHOWKIND_FLAG?= true
# KCL_NODE_SHOWLABELS_FLAG?= true
# KCL_NODE_TAINTS_KEYS?= dedicated ...
# KCL_NODE_TAINTS_KEYVALUES?= dedicated=foo:PreferNoSchedule ...
# KCL_NODES_CLUSTER_NAME?= my-cluster
# KCL_NODES_NAMES?= ip-172-20-33-0.us-west-2.compute.internal ...
# KCL_NODES_OUTPUT_FORMAT?= wide
# KCL_NODES_SELECTOR?=
# KCL_NODES_SET_NAME?= my-nodes-set
# KCL_NODES_SORTBY_JSONPATH?= '{.metadata.name}'
# KCL_NODES_WATCHONLY_FLAG?= true

# Derived parameters
KCL_NODES_NAMES?= $(KCL_NODE_NAME)
KCL_NODES_OUTPUT_FORMAT?= $(KCL_NODE_OUTPUT_FORMAT)

# Options
__KCL_ALL__NODE=
__KCL_DRY_RUN__NODE= $(if $(KCL_NODE_DRYRUN_FLAG),--dry-run=$(KCL_NODE_DRYRUN_FLAG))
__KCL_FORCE__NODE= $(if $(KCL_NODE_FORCE_FLAG),--filename $(KCL_NODE_FORCE_FLAG))
__KCL_OUTPUT__NODE= $(if $(KCL_NODE_OUTPUT_FORMAT),--output $(KCL_NODE_OUTPUT_FORMAT))
__KCL_OUTPUT__NODES= $(if $(KCL_NODES_OUTPUT_FORMAT),--output $(KCL_NODES_OUTPUT_FORMAT))
__KCL_OVERWRITE_NODE=
__KCL_RECORD__NODE=
__KCL_RECURSIVE__NODE=
__KCL_SELECTOR__NODE= $(if $(KCL_NODES_SELECTOR),--selector=$(KCL_NODES_SELECTOR))
__KCL_SHOW_KIND__NODES= $(if $(filter true, $(KCL_NODE_SHOWKIND_FLAG)),--show-kind=$(KCL_NODE_SHOWKIND_FLAG))
__KCL_SHOW_LABELS__NODES= $(if $(KCL_NODE_SHOWLABELS_FLAG),--show-labels=$(KCL_NODE_SHOWLABELS_FLAG))
__KCL_SORT_BY__NODES= $(if $(KCL_NODES_SORTBY_JSONPATH),--sort-by=$(KCL_NODES_SORTBY_JSONPATH))
__KCL_WATCH__NODES=
__KCL_WATCH_ONLY__NODES= $(if $(KCL_NODES_WATCHONLY_FLAG),--watch-only=$(KCL_NODES_WATCHONLY_FLAG))

# Customizations

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Node ($(_KUBECTL_NODE_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Node ($(_KUBECTL_NODE_MK_VERSION)) parameters:'
	@echo '    KCL_NODE_ANNOTATIONS_KEYS=$(KCL_NODE_ANNOTATIONS_KEYS)'
	@echo '    KCL_NODE_ANNOTATIONS_KEYVALUES=$(KCL_NODE_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_NODE_DRYRUN_FLAG=$(KCL_NODE_DRYRUN_FLAG)'
	@echo '    KCL_NODE_FIELD_JSONPATH=$(KCL_NODE_FIELD_JSONPATH)'
	@echo '    KCL_NODE_LABELS_KEYS=$(KCL_NODE_LABELS_KEYS)'
	@echo '    KCL_NODE_LABELS_KEYVALUES=$(KCL_NODE_LABELS_KEYVALUES)'
	@echo '    KCL_NODE_NAME=$(KCL_NODE_NAME)'
	@echo '    KCL_NODE_OUTPUT_FORMAT=$(KCL_NODE_OUTPUT_FORMAT)'
	@echo '    KCL_NODE_SELECTOR=$(KCL_NODE_SELECTOR)'
	@echo '    KCL_NODE_SHOWKIND_FLAG=$(KCL_NODE_SHOWKIND_FLAG)'
	@echo '    KCL_NODE_SHOWLABELS_FLAG=$(KCL_NODE_SHOWLABELS_FLAG)'
	@echo '    KCL_NODE_TAINTS_KEYS=$(KCL_NODE_TAINTS_KEYS)'
	@echo '    KCL_NODE_TAINTS_KEYVALUES=$(KCL_NODE_TAINTS_KEYVALUES)'
	@echo '    KCL_NODES_NAMES=$(KCL_NODES_NAMES)'
	@echo '    KCL_NODES_OUTPUT_FORMAT=$(KCL_NODES_OUTPUT_FORMAT)'
	@echo '    KCL_NODES_SELECTOR=$(KCL_NODES_SELECTOR)'
	@echo '    KCL_NODES_SET_NAME=$(KCL_NODES_SET_NAME)'
	@echo '    KCL_NODES_WATCHONLY_FLAG=$(KCL_NODES_WATCHONLY_FLAG)'
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
	@echo '    _kcl_patch_node                        - Patch a node'
	@echo '    _kcl_show_node                         - Show everything related to a node'
	@echo '    _kcl_show_node_consumedresources       - Show consumed-resources on a node'
	@echo '    _kcl_show_node_description             - Show description of a node'
	@echo '    _kcl_taint_node                        - Taint a node'
	@echo '    _kcl_unannotate_node                   - Un-annotate a node'
	@echo '    _kcl_uncordon_node                     - Un-cordon a node'
	@echo '    _kcl_unlabel_node                      - Un-label a node'
	@echo '    _kcl_untaint_node                      - Un-taint a node'
	@echo '    _kcl_watch_nodes                       - Watch nodes'
	@echo '    _kcl_watch_nodes_set                   - Watch a set of nodes'
	@#echo '    _kcl_write_nodes                       - Write manifest for one-or-more nodes'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_node:
	@$(INFO) '$(KCL_UI_LABEL)Annotating node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate node ...

_kcl_cordon_node:
	@$(INFO) '$(KCL_UI_LABEL)Cordoning node "$(KCL_NODES_NAMES)" ...'; $(NORMAL)
	@$(WARN) 'This operation prevents pods from being scheduled on this node'; $(NORMAL)
	$(KUBECTL) cordon $(__KCL_SELECTOR__NODE) $(KCL_NODE_NAME)

_X_kcl_create_node:
	@$(INFO) '$(KCL_UI_LABEL)Create node "$(KCL_NODES_NAMES)" ...'; $(NORMAL)
	# To create a node, you may need to autoscale and register the node to the cluster!

_X_kcl_delete_node:
	@$(INFO) '$(KCL_UI_LABEL)Delete node "$(KCL_NODES_NAMES)" ...'; $(NORMAL)
	# To create a node, you may need to deregister iand/or downscale the node from the cluster!

_kcl_drain_node:
	@$(INFO) '$(KCL_UI_LABEL)Draining connections on node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation deletes all the pods running on the node'
	$(KUBECTL) drain $(__KCL_FORCE__NODE) $(KCL_NODE_NAME)

_kcl_edit_node:
	@$(INFO) '$(KCL_UI_LABEL)Editing node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit node $(KCL_NODE_NAME)

_kcl_explain_node:
	@$(INFO) '$(KCL_UI_LABEL)Explaining node object or field ...'; $(NORMAL)
	$(KUBECTL) explain node$(KCL_NODE_FIELD_JSONPATH) $(__KCL_RECURSIVE__NODE)

_kcl_label_node:
	@$(INFO) '$(KCL_UI_LABEL)Labeling node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label nodes $(KCL_NODE_NAME) $(KCL_NODE_LABELS_KEYVALUES)

_kcl_list_nodes:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL nodes ...'; $(NORMAL)
	$(KUBECTL) get nodes $(strip $(__KCL_FIELD_SELECTOR) $(__KCL_OUTPUT__NODES) $(_X__KCL_SELECTOR__NODES) $(__KCL_SHOW_KIND__NODES) $(__KCL_SHOW_LABELS__NODES) $(__KCL_SORT_BY__NODES) $(_X__KCL_WATCH__NODES) $(_X__KCL_WATCH_ONLY__NODES) )

_kcl_list_nodes_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing nodes-set "$(KCL_NODES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get nodes $(strip $(__KCL_OUTPUT__NODES) $(__KCL_SELECTOR__NODES) $(__KCL_SHOW_KIND__NODES) $(__KCL_SHOW_LABELS__NODES) $(__KCL_SORT_BY__NODES) $(_X__KCL_WATCH__NODES) $(_X__KCL_WATCH_ONLY__NODES) )

_kcl_patch_node:
	@$(INFO) '$(KCL_UI_LABEL)Patching node "$(KCL_NODE_NAME)" ...'; $(NORMAL)

_KCL_SHOW_NODE_TARGETS?= _kcl_show_node_consumedresources _kcl_show_node_objectrepresentation _kcl_show_node_description
_kcl_show_node: $(_KCL_SHOW_NODE_TARGETS)

_kcl_show_node_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe node $(KCL_NODE_NAME)

_kcl_show_node_consumedresources:
	@$(INFO) '$(KCL_UI_LABEL)Showing consumed-resources on node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation requires the metrics-server to be running and CPU requests to be set on pods'; $(NORMAL)
	-$(KUBECTL) top node $(KCL_NODE_NAME)

_kcl_show_node_objectrepresentation:
	@$(INFO) '$(KCL_UI_LABEL)Showing object-representation of node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get node --output yaml $(KCL_NODE_NAME)

_kcl_taint_node:
	@$(INFO) '$(KCL_UI_LABEL)Tainting node "$(KCL_NODES_NAMES)" ...'; $(NORMAL)
	$(KUBECTL) taint node $(__KCL_ALL__NODE) $(__KCL_ALLOW_MISSING_TEMPLATE_KEYS) $(__KCL_OUTPUT__NODE) $(__KCL_OVERWRITE) $(__KCL_SELECTOR__NODE) $(__KCL_TEMPLATE) $(__KCL_VALIDATE) $(KCL_NODE_NAME) $(KCL_NODE_TAINTS_KEYVALUES)

_kcl_top_node: _kcl_show_node_consumedresources
	
_kcl_unannotate_node:
	@$(INFO) '$(KCL_UI_LABEL)Un-annotating node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate nodes $(KCL_NODE_NAME) $(foreach K,$(KCL_NODE_ANNOTATIONS_KEYS),$(K)- )

_kcl_uncordon_node:
	@$(INFO) '$(KCL_UI_LABEL)Un-cordoning node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) uncordon $(KCL_NODE_NAME)
	
_kcl_unlabel_node:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling node "$(KCL_NODE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label nodes $(KCL_NODE_NAME) $(foreach K,$(KCL_NODE_LABELS_KEYS),$(K)- )

_kcl_untaint_node:
	@$(INFO) '$(KCL_UI_LABEL)Un-tainting node "$(KCL_NODES_NAMES)" ...'; $(NORMAL)
	$(KUBECTL) taint node $(__KCL_ALL__NODE) $(__KCL_ALLOW_MISSING_TEMPLATE_KEYS) $(__KCL_OUTPUT__NODE) $(__KCL_OVERWRITE) $(__KCL_SELECTOR__NODE) $(__KCL_TEMPLATE) $(__KCL_VALIDATE) $(KCL_NODE_NAME) $(foreach K, $(KCL_NODE_TAINTS_KEYS), $(K)-)

_kcl_watch_nodes:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL nodes ...'; $(NORMAL)
	$(KUBECTL) get nodes $(strip $(__KCL_FIELD_SELECTOR__NODES) $(__KCL_OUTPUT__NODES) $(_X__KCL_SELECTOR__NODES) $(__KCL_SHOW_KIND__NODES) $(__KCL_SHOW_LABELS__NODES) $(__KCL_SORT_BY__NODES) $(_X__KCL_WATCH__NODES) --watch=true $(__KCL_WATCH_ONLY__NODES) )

_kcl_watch_nodes_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching nodes-set "$(KCL_NODES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get nodes $(strip $(__KCL_FIELD_SELECTOR__NODES) $(__KCL_OUTPUT__NODES) $(__KCL_SELECTOR__NODES) $(__KCL_SHOW_KIND__NODES) $(__KCL_SHOW_LABELS__NODES) $(__KCL_SORT_BY__NODES) $(_X__KCL_WATCH__NODES) --watch=true $(__KCL_WATCH_ONLY__NODES) )

_kcl_write_nodes:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more nodes ...'; $(NORMAL)
