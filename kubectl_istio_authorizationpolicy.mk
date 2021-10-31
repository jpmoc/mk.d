_KUBECTL_ISTIO_AUTHORIZATIONPOLICY_MK_VERSION= $(_KUBECTL_ISTIO_MK_VERSION)

# KCL_AUTHORIZATIONPOLICY_LABELS_KEYVALUES?=
# KCL_AUTHORIZATIONPOLICY_MANIFEST_DIRPATH?=
# KCL_AUTHORIZATIONPOLICY_MANIFEST_FILENAME?=
# KCL_AUTHORIZATIONPOLICY_MANIFEST_FILEPATH?=
# KCL_AUTHORIZATIONPOLICY_NAME?=
# KCL_AUTHORIZATIONPOLICY_NAMESPACE_NAME?=
# KCL_AUTHORIZATIONPOLICY_OUTPUT?=
# KCL_AUTHORIZATIONPOLICY_SERVICE_HOST?= grafana.istio-system.svc.cluster.local
# KCL_AUTHORIZATIONPOLICIES_NAMESPACE_NAME?=
# KCL_AUTHORIZATIONPOLICIES_OUTPUT?=
# KCL_AUTHORIZATIONPOLICIES_SELECTOR?=
# KCL_AUTHORIZATIONPOLICIES_SET_NAME?=
# KCL_AUTHORIZATIONPOLICIES_SORTBY?=

# Derived parameters
KCL_AUTHORIZATIONPOLICY_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_AUTHORIZATIONPOLICY_MANIFEST_FILEPATH?= $(KCL_AUTHORIZATIONPOLICY_MANIFEST_DIRPATH)$(KCL_AUTHORIZATIONPOLICY_MANIFEST_FILENAME)
KCL_AUTHORIZATIONPOLICY_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_AUTHORIZATIONPOLICIES_NAMESPACE_NAME?= $(KCL_AUTHORIZATIONPOLICY_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__AUTHORIZATIONPOLICY= $(if $(KCL_AUTHORIZATIONPOLICY_MANIFEST_FILEPATH),--filename $(KCL_AUTHORIZATIONPOLICY_MANIFEST_FILEPATH))
__KCL_LABELS__AUTHORIZATIONPOLICY= $(if $(KCL_AUTHORIZATIONPOLICY_LABELS_KEYVALUES),--labels $(KCL_AUTHORIZATIONPOLICY_LABELS_KEYVALUES))
__KCL_NAMESPACE__AUTHORIZATIONPOLICY= $(if $(KCL_AUTHORIZATIONPOLICY_NAMESPACE_NAME),--namespace $(KCL_AUTHORIZATIONPOLICY_NAMESPACE_NAME))
__KCL_NAMESPACE__AUTHORIZATIONPOLICIES= $(if $(KCL_AUTHORIZATIONPOLICIES_NAMESPACE_NAME),--namespace $(KCL_AUTHORIZATIONPOLICIES_NAMESPACE_NAME))
__KCL_OUTPUT__AUTHORIZATIONPOLICY= $(if $(KCL_AUTHORIZATIONPOLICY_OUTPUT),--output $(KCL_AUTHORIZATIONPOLICY_OUTPUT))
__KCL_OUTPUT__AUTHORIZATIONPOLICIES= $(if $(KCL_AUTHORIZATIONPOLICIES_OUTPUT),--output $(KCL_AUTHORIZATIONPOLICIES_OUTPUT))
__KCL_SELECTOR__AUTHORIZATIONPOLICIES= $(if $(KCL_AUTHORIZATIONPOLICIES_SELECTOR),--selector=$(KCL_AUTHORIZATIONPOLICIES_SELECTOR))
__KCL_SORT_BY__AUTHORIZATIONPOLICIES= $(if $(KCL_AUTHORIZATIONPOLICIES_SORTBY),--sort-by=$(KCL_AUTHORIZATIONPOLICIES_SORTBY))

# UI parameters

#--- MACROS
_kcl_get_authorizationpolicy_destinationrules_names= $(call _kcl_get_authorizationpolicy_destinationrules_names_S, $(KCL_AUTHORIZATIONPOLICY_DESTINATIONRULES_SELECTOR))
_kcl_get_authorizationpolicy_destinationrules_names_S= $(call _kcl_get_authorizationpolicy_destinationrules_names_SN, $(1), $(KCL_AUTHORIZATIONPOLICY_NAMESPACE_NAME))
_kcl_get_authorizationpolicy_destinationrules_names_SN= $(shell $(KUBECTL) get destinationrules --namespace $(2) --selector $(1) --output jsonpath="{.items[*].metadata.name}")


#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Istio::AuthorizationPolicy ($(_KUBECTL_ISTIO_AUTHORIZATIONPOLICY_MK_VERSION)) macros:'
	@echo '    _kcl_get_authorizationpolicy_destinationrules_names_{|S|SN}  - Get the Destination rules for a policy (Selector,Namespace)'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Istio::AuthorizationPolicy ($(_KUBECTL_ISTIO_AUTHORIZATIONPOLICY_MK_VERSION)) parameters:'
	@echo '    KCL_AUTHORIZATIONPOLICY_DESTINATIONRULES_NAMES=$(KCL_AUTHORIZATIONPOLICY_DESTINATIONRULES_NAMES)'
	@echo '    KCL_AUTHORIZATIONPOLICY_DESTINATIONRULES_SELECTOR=$(KCL_AUTHORIZATIONPOLICY_DESTINATIONRULES_SELECTOR)'
	@echo '    KCL_AUTHORIZATIONPOLICY_LABELS_KEYVALUES=$(KCL_AUTHORIZATIONPOLICY_LABELS_KEYVALUES)'
	@echo '    KCL_AUTHORIZATIONPOLICY_MANIFEST_DIRPATH=$(KCL_AUTHORIZATIONPOLICY_MANIFEST_DIRPATH)'
	@echo '    KCL_AUTHORIZATIONPOLICY_MANIFEST_FILENAME=$(KCL_AUTHORIZATIONPOLICY_MANIFEST_FILENAME)'
	@echo '    KCL_AUTHORIZATIONPOLICY_MANIFEST_FILEPATH=$(KCL_AUTHORIZATIONPOLICY_MANIFEST_FILEPATH)'
	@echo '    KCL_AUTHORIZATIONPOLICY_NAME=$(KCL_AUTHORIZATIONPOLICY_NAME)'
	@echo '    KCL_AUTHORIZATIONPOLICY_NAMESPACE_NAME=$(KCL_AUTHORIZATIONPOLICY_NAMESPACE_NAME)'
	@echo '    KCL_AUTHORIZATIONPOLICY_OUTPUT=$(KCL_AUTHORIZATIONPOLICY_OUTPUT)'
	@echo '    KCL_AUTHORIZATIONPOLICY_SERVICE_HOST=$(KCL_AUTHORIZATIONPOLICY_SERVICE_HOST)'
	@echo '    KCL_AUTHORIZATIONPOLICIES_NAMESPACE_NAME=$(KCL_AUTHORIZATIONPOLICIES_NAMESPACE_NAME)'
	@echo '    KCL_AUTHORIZATIONPOLICIES_OUTPUT=$(KCL_AUTHORIZATIONPOLICIES_OUTPUT)'
	@echo '    KCL_AUTHORIZATIONPOLICIES_SELECTOR=$(KCL_AUTHORIZATIONPOLICIES_SELECTOR)'
	@echo '    KCL_AUTHORIZATIONPOLICIES_SET_NAME=$(KCL_AUTHORIZATIONPOLICIES_SET_NAME)'
	@echo '    KCL_AUTHORIZATIONPOLICIES_SORTBY=$(KCL_AUTHORIZATIONPOLICIES_SORTBY)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Istio::AuthorizationPolicy ($(_KUBECTL_ISTIO_AUTHORIZATIONPOLICY_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_authorizationpolicy                - Annotate an authorization-policy'
	@echo '    _kcl_apply_authorizationpolicy                   - Apply a manifest for an authorization-policy'
	@echo '    _kcl_create_authorizationpolicy                  - Create an authorization-policy'
	@echo '    _kcl_delete_authorizationpolicy                  - Delete an authorization-policy'
	@echo '    _kcl_edit_authorizationpolicy                    - Edit an authorization-policy'
	@echo '    _kcl_explain_authorizationpolicy                 - Explain authorization-policy'
	@echo '    _kcl_label_authorizationpolicy                   - Label an authorization-policy'
	@echo '    _kcl_list_authorizationpolicies                  - List all authorization-policies'
	@echo '    _kcl_list_authorizationpolicies_set              - List a set of authorization-policies'
	@echo '    _kcl_show_authorizationpolicy                    - Show everything related to an authorization-policy'
	@echo '    _kcl_show_authorizationpolicy_description        - Show description of an authorization-policy'
	@echo '    _kcl_show_authorizationpolicy_destinationrules   - Show destination-rules of an authorization-policy'
	@echo '    _kcl_show_authorizationpolicy_object             - Show object of an authorization-policy'
	@echo '    _kcl_show_authorizationpolicy_state              - Show state of an authorization-policy'
	@echo '    _kcl_unapply_authorizationpolicy                 - Unapply a manifest for an authorization-policy'
	@echo '    _kcl_unlabel_authorizationpolicy                 - Unlabel an authorization-policy'
	@echo '    _kcl_update_authorizationpolicy                  - Update an authorization-policy'
	@echo '    _kcl_watch_authorizationpolicies                 - Watch authorization-policies'
	@echo '    _kcl_watch_authorizationpolicies_set             - Watch a set of authorization-policies'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_authorizationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Annotating authorization-policy "$(KCL_AUTHORIZATIONPOLICY_NAME)" ...'; $(NORMAL)

_kcl_apply_authorizationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for authorization-policy "$(KCL_AUTHORIZATIONPOLICY_NAME)" ...'; $(NORMAL)
	cat $(KCL_AUTHORIZATIONPOLICY_MANIFEST_FILEPATH)
	$(KUBECTL) apply $(__KCL_FILENAME__AUTHORIZATIONPOLICY) $(__KCL_NAMESPACE__AUTHORIZATIONPOLICY)

_kcl_create_authorizationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Creating authorization-policy "$(KCL_AUTHORIZATIONPOLICY_NAME)" ...'; $(NORMAL)

_kcl_delete_authorizationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Deleting authorization-policy "$(KCL_AUTHORIZATIONPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete authorizationpolicy $(__KCL_NAMESPACE__AUTHORIZATIONPOLICY) $(KCL_AUTHORIZATIONPOLICY_NAME)

_kcl_edit_authorizationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Editing authorization-policy "$(KCL_AUTHORIZATIONPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit authorizationpolicy $(__KCL_NAMESPACE__AUTHORIZATIONPOLICY) $(KCL_AUTHORIZATIONPOLICY_NAME)

_kcl_explain_authorizationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Explaining authorization-policy object ...'; $(NORMAL)
	$(KUBECTL) explain authorizationpolicy

_kcl_label_authorizationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Labeling authorization-policy "$(KCL_AUTHORIZATIONPOLICY_NAME)" ...'; $(NORMAL)

_kcl_list_authorizationpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL authorization-policies ...'; $(NORMAL)
	$(KUBECTL) get authorizationpolicies --all-namespaces=true $(__KCL_OUTPUT_AUTHORIZATIONPOLICIES) $(_X__KCL_SELECTOR__AUTHORIZATIONPOLICIES) $(__KCL_SORT_BY__AUTHORIZATIONPOLICIES)

_kcl_list_authorizationpolicies_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing authorization-policies-set "$(KCL_AUTHORIZATIONPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Authorization-policies are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get authorizationpolicies --all-namespaces=false $(__KCL_NAMESPACE__AUTHORIZATIONPOLICIES) $(__KCL_OUTPUT__AUTHORIZATIONPOLICIES) $(__KCL_SELECTOR__AUTHORIZATIONPOLICIES) $(__KCL_SORT_BY__AUTHORIZATIONPOLICIES)

_KCL_SHOW_AUTHORIZATIONPOLICY_TARGETS?= _kcl_show_authorizationpolicy_object _kcl_show_authorizationpolicy_state _kcl_show_authorizationpolicy_description
_kcl_show_authorizationpolicy: $(_KCL_SHOW_AUTHORIZATIONPOLICY_TARGETS)

_kcl_show_authorizationpolicy_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description authorization-policy "$(KCL_AUTHORIZATIONPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe authorizationpolicy $(__KCL_NAMESPACE__AUTHORIZATIONPOLICY) $(KCL_AUTHORIZATIONPOLICY_NAME)

_kcl_show_authorizationpolicy_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of authorization-policy "$(KCL_AUTHORIZATIONPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get authorizationpolicy $(__KCL_NAMESPACE__AUTHORIZATIONPOLICY) $(_X__KCL_OUTPUT__AUTHORIZATIONPOLICY) --output yaml $(KCL_AUTHORIZATIONPOLICY_NAME)

_kcl_show_authorizationpolicy_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of authorization-policy "$(KCL_AUTHORIZATIONPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get authorizationpolicy $(__KCL_NAMESPACE__AUTHORIZATIONPOLICY) $(_X__KCL_OUTPUT__AUTHORIZATIONPOLICY) $(KCL_AUTHORIZATIONPOLICY_NAME)

_kcl_unapply_authorizationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for authorization-policy "$(KCL_AUTHORIZATIONPOLICY_NAME)" ...'; $(NORMAL)
	cat $(KCL_AUTHORIZATIONPOLICY_MANIFEST_FILEPATH)
	$(KUBECTL) delete $(__KCL_NAMESPACE__AUTHORIZATIONPOLICY) $(__KCL_FILENAME__AUTHORIZATIONPOLICY)

_kcl_unlabel_authorizationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling from authorization-policy "$(KCL_AUTHORIZATIONPOLICY_NAME)" ...'; $(NORMAL)

_kcl_update_authorizationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Updating authorization-policy "$(KCL_AUTHORIZATIONPOLICY_NAME)" ...'; $(NORMAL)

_kcl_watch_authorizationpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Watching authorization-policies ...'; $(NORMAL)
	$(KUBECTL) get authorizationpolicies --all-namespaces=true --watch 

_kcl_watch_authorizationpolicies_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching authorization-policies-set "$(KCL_AUTHORIZATIONPOLICIES_SET_NAME)" ...'; $(NORMAL)
