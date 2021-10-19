_KUBECTL_CERTMANAGER_ORDER_MK_VERSION= $(_KUBECTL_CERTMANAGER_MK_VERSION)

# KCL_ORDER_LABELS_KEYVALUES?= key=value ...
# KCL_ORDER_NAME?= my-name
# KCL_ORDER_NAMESPACE_NAME?= default
# KCL_ORDERS_FIELDSELECTOR?= metadata.name=my-name
# KCL_ORDERS_MANIFEST_DIRPATH?= ./in/
# KCL_ORDERS_MANIFEST_FILENAME?= manifest.yaml 
# KCL_ORDERS_MANIFEST_FILEPATH?= ./in/manifest.yaml 
# KCL_ORDERS_MANIFEST_URL?= http://...
# KCL_ORDERS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_ORDERS_NAMESPACE_NAME?= default
# KCL_ORDERS_SELECTOR?=
# KCL_ORDERS_SET_NAME?= my-ordersigningrequests-set

# Derived parameters
KCL_ORDER_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_ORDERS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_ORDERS_MANIFEST_FILEPATH?= $(if $(KCL_ORDERS_MANIFEST_FILENAME),$(KCL_ORDERS_MANIFEST_DIRPATH)$(KCL_ORDERS_MANIFEST_FILENAME))
KCL_ORDERS_NAMESPACE_NAME?= $(KCL_ORDER_NAMESPACE_NAME)
KCL_ORDERS_SET_NAME?= orders@@@$(KCL_ORDERS_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__ORDERS+= $(if $(KCL_ORDERS_MANIFEST_FILEPATH),--filename $(KCL_ORDERS_MANIFEST_FILEPATH))
__KCL_FILENAME__ORDERS+= $(if $(KCL_ORDERS_MANIFEST_URL),--filename $(KCL_ORDERS_MANIFEST_URL))
__KCL_FILENAME__ORDERS+= $(if $(KCL_ORDERS_MANIFESTS_DIRPATH),--filename $(KCL_ORDERS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__ORDER= $(if $(KCL_ORDER_NAMESPACE_NAME),--namespace $(KCL_ORDER_NAMESPACE_NAME))
__KCL_NAMESPACE__ORDERS= $(if $(KCL_ORDERS_NAMESPACE_NAME),--namespace $(KCL_ORDERS_NAMESPACE_NAME))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::CertManager::Order ($(_KUBECTL_CERTMANAGER_ORDER_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::CertManager::Order ($(_KUBECTL_CERTMANAGER_ORDER_MK_VERSION)) parameters:'
	@echo '    KCL_ORDER_LABELS_KEYVALUES=$(KCL_ORDER_LABELS_KEYVALUES)'
	@echo '    KCL_ORDER_NAME=$(KCL_ORDER_NAME)'
	@echo '    KCL_ORDER_NAMESPACE_NAME=$(KCL_ORDER_NAMESPACE_NAME)'
	@echo '    KCL_ORDERS_FIELDSELECTOR=$(KCL_ORDERS_FIELDSELECTOR)'
	@echo '    KCL_ORDERS_MANIFEST_DIRPATH=$(KCL_ORDERS_MANIFEST_DIRPATH)'
	@echo '    KCL_ORDERS_MANIFEST_FILENAME=$(KCL_ORDERS_MANIFEST_FILENAME)'
	@echo '    KCL_ORDERS_MANIFEST_FILEPATH=$(KCL_ORDERS_MANIFEST_FILEPATH)'
	@echo '    KCL_ORDERS_MANIFEST_URL=$(KCL_ORDERS_MANIFEST_URL)'
	@echo '    KCL_ORDERS_MANIFESTS_DIRPATH=$(KCL_ORDERS_MANIFESTS_DIRPATH)'
	@echo '    KCL_ORDERS_NAMESPACE_NAME=$(KCL_ORDERS_NAMESPACE_NAME)'
	@echo '    KCL_ORDERS_SELECTOR=$(KCL_ORDERS_SELECTOR)'
	@echo '    KCL_ORDERS_SET_NAME=$(KCL_ORDERS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::CertManager::Order ($(_KUBECTL_CERTMANAGER_ORDER_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_order               - Annotate a order'
	@echo '    _kcl_apply_orders                 - Apply a manifest for one-or-more orders'
	@echo '    _kcl_create_order                 - Create a new order'
	@echo '    _kcl_delete_order                 - Delete an existing order'
	@echo '    _kcl_diff_orders                  - Diff a manifest for one-or-more orders'
	@echo '    _kcl_edit_order                   - Edit a order'
	@echo '    _kcl_explain_order                - Explain the order object'
	@echo '    _kcl_show_order                   - Show everything related to a order'
	@echo '    _kcl_show_order_description       - Show description of a order'
	@echo '    _kcl_show_order_state             - Show state of a order'
	@echo '    _kcl_unapply_orders               - Un-apply a manifest for one-or-more order'
	@echo '    _kcl_unlabel_order                - Un-label a order'
	@echo '    _kcl_update_order                 - Update a order'
	@echo '    _kcl_view_orders                  - View orders'
	@echo '    _kcl_view_orders_set              - View set of orders'
	@echo '    _kcl_watch_orders                 - Watch orders'
	@echo '    _kcl_watch_orders_set             - Watch a set of orders'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_order:
	@$(INFO) '$(KCL_UI_LABEL)Annotating order "$(KCL_ORDER_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate $(__KCL_NAMESPACE__ORDER) $(KCL_ORDER_NAME)

_kcl_apply_order: _kcl_apply_orders
_kcl_apply_orders:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more orders ...'; $(NORMAL)
	$(if $(KCL_ORDERS_MANIFEST_FILEPATH), cat $(KCL_ORDERS_MANIFEST_FILEPATH); echo)
	$(if $(KCL_ORDERS_MANIFEST_URL), curl -L $(KCL_ORDERS_MANIFEST_URL); echo)
	$(if $(KCL_ORDERS_MANIFESTS_DIRPATH), ls -al $(KCL_ORDERS_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__ORDERS) $(__KCL_NAMESPACE__ORDERS)

_kcl_create_order:
	@$(INFO) '$(KCL_UI_LABEL)Creating order "$(KCL_ORDER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create order $(__KCL_NAMESPACE__ORDER) $(KCL_ORDER_NAME)

_kcl_delete_order:
	@$(INFO) '$(KCL_UI_LABEL)Deleting order "$(KCL_ORDER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete order $(__KCL_NAMESPACE__ORDER) $(KCL_ORDER_NAME)

_kcl_diff_order: _kcl_diff_orders
_kcl_diff_orders:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more orders ...'; $(NORMAL)
	# cat $(KCL_ORDERS_MANIFEST_FILEPATH)
	# curl -L $(KCL_ORDERS_MANIFEST_URL)
	# ls -al $(KCL_ORDERS_MANIFESTS_DIRPATH)
	$(KUBECTL) diff $(__KCL_FILENAME__ORDERS) $(__KCL_NAMESPACE__ORDERS)

_kcl_edit_order:
	@$(INFO) '$(KCL_UI_LABEL)Editing order "$(KCL_ORDER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit order $(__KCL_NAMESPACE__ORDER) $(KCL_ORDER_NAME)

_kcl_explain_order:
	@$(INFO) '$(KCL_UI_LABEL)Explaining order object ...'; $(NORMAL)
	$(KUBECTL) explain order

_kcl_label_order:
	@$(INFO) '$(KCL_UI_LABEL)Labelling order "$(KCL_ORDER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label order $(__KCL_NAMESPACE__ORDER) $(KCL_ORDER_NAME) $(KCL_ORDER_LABELS_KEYVALUES)

_kcl_show_order :: _kcl_show_order_state _kcl_show_order_description

_kcl_show_order_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of order "$(KCL_ORDER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe order $(__KCL_NAMESPACE__ORDER) $(KCL_ORDER_NAME) 

_kcl_show_order_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of order "$(KCL_ORDER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get order $(__KCL_NAMESPACE__ORDER) $(KCL_ORDER_NAME) 

_kcl_unapply_order: _kcl_unapply_orders
_kcl_unapply_orders:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more orders ...'; $(NORMAL)
	# cat $(KCL_ORDERS_MANIFEST_FILEPATH)
	# curl -L $(KCL_ORDERS_MANIFEST_URL)
	# ls -al $(KCL_ORDERS_MANIFESTS_DIRPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__ORDERS) $(__KCL_NAMESPACE__ORDERS)

_kcl_unlabel_order:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling order "$(KCL_ORDER_NAME)" ...'; $(NORMAL)

_kcl_update_order:
	@$(INFO) '$(KCL_UI_LABEL)Updating order "$(KCL_ORDER_NAME)" ...'; $(NORMAL)

_kcl_view_orders:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL orders ...'; $(NORMAL)
	$(KUBECTL) get orders --all-namespaces=true $(_X__KCL_NAMESPACE__ORDERS) $(_X__KCL_SELECTOR_ORDERS)

_kcl_view_orders_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing orders-set "$(KCL_ORDERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Orders are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
	$(KUBECTL) get orders --all-namespaces=false $(__KCL_FIELD_SELECTOR__ORDERS) $(__KCL_NAMESPACE__ORDERS) $(__KCL_SELECTOR__ORDERS)

_kcl_watch_orders:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL orders ...'; $(NORMAL)

_kcl_watch_orders_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching orders-set "$(KCL_ORDERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Orders are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
