_KUBECTL_ISTIO_AUTHENTICATIONPOLICY_MK_VERSION= $(_KUBECTL_ISTIO_MK_VERSION)

# KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_FIELDSELECTOR?= metadata.name=toto
# KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_SELECTOR?= app=vault
# KCL_AUTHENTICATIONPOLICY_LABELS_KEYVALUES?=
# KCL_AUTHENTICATIONPOLICY_MANIFEST_DIRPATH?=
# KCL_AUTHENTICATIONPOLICY_MANIFEST_FILENAME?=
# KCL_AUTHENTICATIONPOLICY_MANIFEST_FILEPATH?=
# KCL_AUTHENTICATIONPOLICY_NAME?=
# KCL_AUTHENTICATIONPOLICY_NAMESPACE_NAME?=
# KCL_AUTHENTICATIONPOLICY_OUTPUT?=
# KCL_AUTHENTICATIONPOLICIES_NAMESPACE_NAME?=
# KCL_AUTHENTICATIONPOLICIES_OUTPUT?=
# KCL_AUTHENTICATIONPOLICIES_SELECTOR?=
# KCL_AUTHENTICATIONPOLICIES_SET_NAME?=
# KCL_AUTHENTICATIONPOLICIES_SORTBY?=

# Derived parameters
KCL_AUTHENTICATIONPOLICY_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_AUTHENTICATIONPOLICY_MANIFEST_FILEPATH?= $(KCL_AUTHENTICATIONPOLICY_MANIFEST_DIRPATH)$(KCL_AUTHENTICATIONPOLICY_MANIFEST_FILENAME)
KCL_AUTHENTICATIONPOLICY_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_AUTHENTICATIONPOLICIES_NAMESPACE_NAME?= $(KCL_AUTHENTICATIONPOLICY_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__AUTHENTICATIONPOLICY= $(if $(KCL_AUTHENTICATIONPOLICY_MANIFEST_FILEPATH),--filename $(KCL_AUTHENTICATIONPOLICY_MANIFEST_FILEPATH))
__KCL_LABELS__AUTHENTICATIONPOLICY= $(if $(KCL_AUTHENTICATIONPOLICY_LABELS_KEYVALUES),--labels $(KCL_AUTHENTICATIONPOLICY_LABELS_KEYVALUES))
__KCL_NAMESPACE__AUTHENTICATIONPOLICY= $(if $(KCL_AUTHENTICATIONPOLICY_NAMESPACE_NAME),--namespace $(KCL_AUTHENTICATIONPOLICY_NAMESPACE_NAME))
__KCL_NAMESPACE__AUTHENTICATIONPOLICIES= $(if $(KCL_AUTHENTICATIONPOLICIES_NAMESPACE_NAME),--namespace $(KCL_AUTHENTICATIONPOLICIES_NAMESPACE_NAME))
__KCL_OUTPUT__AUTHENTICATIONPOLICY= $(if $(KCL_AUTHENTICATIONPOLICY_OUTPUT),--output $(KCL_AUTHENTICATIONPOLICY_OUTPUT))
__KCL_OUTPUT__AUTHENTICATIONPOLICIES= $(if $(KCL_AUTHENTICATIONPOLICIES_OUTPUT),--output $(KCL_AUTHENTICATIONPOLICIES_OUTPUT))
__KCL_SELECTOR__AUTHENTICATIONPOLICIES= $(if $(KCL_AUTHENTICATIONPOLICIES_SELECTOR),--selector=$(KCL_AUTHENTICATIONPOLICIES_SELECTOR))
__KCL_SORT_BY__AUTHENTICATIONPOLICIES= $(if $(KCL_AUTHENTICATIONPOLICIES_SORTBY),--sort-by=$(KCL_AUTHENTICATIONPOLICIES_SORTBY))

# UI parameters

#--- MACROS

_kcl_get_authenticationpolicy_destinationrules_names= $(call _kcl_get_authenticationpolicy_destinationrules_names_S, $(KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_SELECTOR))
_kcl_get_authenticationpolicy_destinationrules_names_S= $(call _kcl_get_authenticationpolicy_destinationrules_names_SN, $(1), $(KCL_AUTHENTICATIONPOLICY_NAMESPACE_NAME))
_kcl_get_authenticationpolicy_destinationrules_names_SN= $(shell $(KUBECTL) get destinationrules --namespace $(2) --selector $(1) --output jsonpath="{.items[*].metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Istio::AuthenticationPolicy ($(_KUBECTL_ISTIO_AUTHENTICATIONPOLICY_MK_VERSION)) macros:'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Istio::AuthenticationPolicy ($(_KUBECTL_ISTIO_AUTHENTICATIONPOLICY_MK_VERSION)) parameters:'
	@echo '    KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_FIELDSELECTOR=$(KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_FIELDSELECTOR)'
	@echo '    KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_NAMES=$(KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_NAMES)'
	@echo '    KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_SELECTOR=$(KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_SELECTOR)'
	@echo '    KCL_AUTHENTICATIONPOLICY_LABELS_KEYVALUES=$(KCL_AUTHENTICATIONPOLICY_LABELS_KEYVALUES)'
	@echo '    KCL_AUTHENTICATIONPOLICY_MANIFEST_DIRPATH=$(KCL_AUTHENTICATIONPOLICY_MANIFEST_DIRPATH)'
	@echo '    KCL_AUTHENTICATIONPOLICY_MANIFEST_FILENAME=$(KCL_AUTHENTICATIONPOLICY_MANIFEST_FILENAME)'
	@echo '    KCL_AUTHENTICATIONPOLICY_MANIFEST_FILEPATH=$(KCL_AUTHENTICATIONPOLICY_MANIFEST_FILEPATH)'
	@echo '    KCL_AUTHENTICATIONPOLICY_NAME=$(KCL_AUTHENTICATIONPOLICY_NAME)'
	@echo '    KCL_AUTHENTICATIONPOLICY_NAMESPACE_NAME=$(KCL_AUTHENTICATIONPOLICY_NAMESPACE_NAME)'
	@echo '    KCL_AUTHENTICATIONPOLICY_OUTPUT=$(KCL_AUTHENTICATIONPOLICY_OUTPUT)'
	@echo '    KCL_AUTHENTICATIONPOLICIES_NAMESPACE_NAME=$(KCL_AUTHENTICATIONPOLICIES_NAMESPACE_NAME)'
	@echo '    KCL_AUTHENTICATIONPOLICIES_OUTPUT=$(KCL_AUTHENTICATIONPOLICIES_OUTPUT)'
	@echo '    KCL_AUTHENTICATIONPOLICIES_SELECTOR=$(KCL_AUTHENTICATIONPOLICIES_SELECTOR)'
	@echo '    KCL_AUTHENTICATIONPOLICIES_SET_NAME=$(KCL_AUTHENTICATIONPOLICIES_SET_NAME)'
	@echo '    KCL_AUTHENTICATIONPOLICIES_SORTBY=$(KCL_AUTHENTICATIONPOLICIES_SORTBY)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Istio::AuthenticationPolicy ($(_KUBECTL_ISTIO_AUTHENTICATIONPOLICY_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_authenticationpolicy                - Annotate an authentication-policy'
	@echo '    _kcl_apply_authenticationpolicy                   - Apply a manifest for an authentication-policy'
	@echo '    _kcl_create_authenticationpolicy                  - Create an authentication-policy'
	@echo '    _kcl_delete_authenticationpolicy                  - Delete an authentication-policy'
	@echo '    _kcl_edit_authenticationpolicy                    - Edit an authentication-policy'
	@echo '    _kcl_explain_authenticationpolicy                 - Explain authentication-policy'
	@echo '    _kcl_label_authenticationpolicy                   - Label an authentication-policy'
	@echo '    _kcl_list_authenticationpolicies                  - List all authentication-policies'
	@echo '    _kcl_list_authenticationpolicies_set              - List a set of authentication-policies'
	@echo '    _kcl_show_authenticationpolicy                    - Show everything related to an authentication-policy'
	@echo '    _kcl_show_authenticationpolicy_description        - Show description of an authentication-policy'
	@echo '    _kcl_show_authenticationpolicy_destinationrules   - Show destination-rules of an authentication-policy'
	@echo '    _kcl_show_authenticationpolicy_object             - Show object of an authentication-policy'
	@echo '    _kcl_show_authenticationpolicy_state              - Show state of an authentication-policy'
	@echo '    _kcl_unapply_authenticationpolicy                 - Unapply a manifest for an authentication-policy'
	@echo '    _kcl_unlabel_authenticationpolicy                 - Unlabel an authentication-policy'
	@echo '    _kcl_update_authenticationpolicy                  - Update an authentication-policy'
	@echo '    _kcl_watch_authenticationpolicies                 - Watch authentication-policies'
	@echo '    _kcl_watch_authenticationpolicies_set             - Watch a set of authentication-policies'
	@echo '    _kcl_write_authenticationpolicies                 - Write manifest for one-or-more authentication-policies'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_authenticationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Annotating authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)

_kcl_apply_authenticationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)
	cat $(KCL_AUTHENTICATIONPOLICY_MANIFEST_FILEPATH); echo
	$(KUBECTL) apply $(__KCL_FILENAME__AUTHENTICATIONPOLICY) $(__KCL_NAMESPACE__AUTHENTICATIONPOLICY)

_kcl_create_authenticationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Creating authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)

_kcl_delete_authenticationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Deleting authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete policy $(__KCL_NAMESPACE__AUTHENTICATIONPOLICY) $(KCL_AUTHENTICATIONPOLICY_NAME)

_kcl_edit_authenticationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Editing authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit policy $(__KCL_NAMESPACE__AUTHENTICATIONPOLICY) $(KCL_AUTHENTICATIONPOLICY_NAME)

_kcl_explain_authenticationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Explaining authentication-policy object ...'; $(NORMAL)
	$(KUBECTL) explain policy

_kcl_label_authenticationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Labeling authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)

_kcl_show_authenticationpolicy: _kcl_show_authenticationpolicy_destinationrules _kcl_show_authenticationpolicy_object _kcl_show_authenticationpolicy_state _kcl_show_authenticationpolicy_description

_kcl_show_authenticationpolicy_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe policy $(__KCL_NAMESPACE__AUTHENTICATIONPOLICY) $(KCL_AUTHENTICATIONPOLICY_NAME)

_kcl_show_authenticationpolicy_destinationrules:
	@$(INFO) '$(KCL_UI_LABEL)Showing destination-rules of authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)
	$(if $(KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_FIELDSELECTOR)$(KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_SELECTOR), \
		$(KUBECTL) get destinationrules $(__KCL_NAMESPACE__AUTHENTICATIONPOLICY) \
			$(if $(KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_FIELDSELECTOR),--field-selector $(KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_FIELDSELECTOR)) \
			$(if $(KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_SELECTOR),--selector $(KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_SELECTOR)) \
	, @\
		echo 'KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_FIELDSELECTOR not set'; \
		echo 'KCL_AUTHENTICATIONPOLICY_DESTINATIONRULES_SELECTOR not set'; \
	)

_kcl_show_authenticationpolicy_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get policy $(__KCL_NAMESPACE__AUTHENTICATIONPOLICY) $(_X__KCL_OUTPUT__AUTHENTICATIONPOLICY) --output yaml $(KCL_AUTHENTICATIONPOLICY_NAME)

_kcl_show_authenticationpolicy_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get policy $(__KCL_NAMESPACE__AUTHENTICATIONPOLICY) $(_X__KCL_OUTPUT__AUTHENTICATIONPOLICY) $(KCL_AUTHENTICATIONPOLICY_NAME)

_kcl_unapply_authenticationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)
	cat $(KCL_AUTHENTICATIONPOLICY_MANIFEST_FILEPATH); echo
	$(KUBECTL) delete $(__KCL_NAMESPACE__AUTHENTICATIONPOLICY) $(__KCL_FILENAME__AUTHENTICATIONPOLICY)

_kcl_unlabel_authenticationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling from authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)

_kcl_update_authenticationpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Updating authentication-policy "$(KCL_AUTHENTICATIONPOLICY_NAME)" ...'; $(NORMAL)

_kcl_list_authenticationpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL authentication-policies ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT return the default authentication-policy which is the "default" mesh-policy'; $(NORMAL)
	$(KUBECTL) get policies --all-namespaces=true $(__KCL_OUTPUT_AUTHENTICATIONPOLICIES) $(_X__KCL_SELECTOR__AUTHENTICATIONPOLICIES) $(__KCL_SORT_BY__AUTHENTICATIONPOLICIES)

_kcl_list_authenticationpolicies_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing authentication-policies-set "$(KCL_AUTHENTICATIONPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT return the default authentication-policy which is the "default" mesh-policy'; $(NORMAL)
	@$(WARN) 'Authentication-policies are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get policies --all-namespaces=false $(__KCL_NAMESPACE__AUTHENTICATIONPOLICIES) $(__KCL_OUTPUT__AUTHENTICATIONPOLICIES) $(__KCL_SELECTOR__AUTHENTICATIONPOLICIES) $(__KCL_SORT_BY__AUTHENTICATIONPOLICIES)

_kcl_watch_authenticationpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL authentication-policies ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT return the default authentication-policy which is the "default" mesh-policy'; $(NORMAL)
	$(KUBECTL) get policies --all-namespaces=true --watch 

_kcl_watch_authenticationpolicies_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching authentication-policies-set "$(KCL_AUTHENTICATIONPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT return the default authentication-policy which is the "default" mesh-policy'; $(NORMAL)

_kcl_write_authenticationpolicy: _kcl_write_authenticationpolicies
_kcl_write_authenticationpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more authentication-policies ...'; $(NORMAL)
	$(WRITER) $(KCL_AUTHENTICATIONPOLICIES_MANIFEST_FILEPATH)
