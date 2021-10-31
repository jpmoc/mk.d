_KUBECTL_NETWORKPOLICY_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_NETWORKPOLICY_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_NETWORKPOLICY_NAME?= my-name 
# KCL_NETWORKPOLICY_NAMESPACE_NAME?= default
# KCL_NETWORKPOLICIES_MANIFEST_DIRPATH?= ./in/
# KCL_NETWORKPOLICIES_MANIFEST_FILENAME?= manifest.yml
# KCL_NETWORKPOLICIES_MANIFEST_FILEPATH?= ./in/manifest.yml
KCL_NETWORKPOLICIES_MANIFEST_STDINFLAG?= false
# KCL_NETWORKPOLICIES_MANIFEST_URL?= http://...
# KCL_NETWORKPOLICIES_MANIFESTS_DIRPATH?= ./in/netpols/
# KCL_NETWORKPOLICIES_NAMESPACE_NAME?= default
# KCL_NETWORKPOLICIES_SELECTOR?=
# KCL_NETWORKPOLICIES_SET_NAME?= my-network-policies-set

# Derived parameters
KCL_NETWORKPOLICIES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_NETWORKPOLICIES_MANIFEST_FILEPATH?= $(if $(KCL_NETWORKPOLICIES_MANIFEST_FILENAME),$(KCL_NETWORKPOLICIES_MANIFEST_DIRPATH)$(KCL_NETWORKPOLICIES_MANIFEST_FILENAME))
KCL_NETWORKPOLICY_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_NETWORKPOLICIES_NAMESPACE_NAME?= $(KCL_NETWORKPOLICY_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__NETWORKPOLICIES+= $(if $(KCL_NETWORKPOLICIES_MANIFEST_FILEPATH),--filename $(KCL_NETWORKPOLICIES_MANIFEST_FILEPATH))
__KCL_FILENAME__NETWORKPOLICIES+= $(if $(filter true,$(KCL_NETWORKPOLICIES_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__NETWORKPOLICIES+= $(if $(KCL_NETWORKPOLICIES_MANIFEST_URL),--filename $(KCL_NETWORKPOLICIES_MANIFEST_URL))
__KCL_FILENAME__NETWORKPOLICIES+= $(if $(KCL_NETWORKPOLICIES_MANIFESTS_DIRPATH),--filename $(KCL_NETWORKPOLICIES_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__NETWORKPOLICY= $(if $(KCL_NETWORKPOLICY_NAMESPACE_NAME),--namespace $(KCL_NETWORKPOLICY_NAMESPACE_NAME))
__KCL_NAMESPACE__NETWORKPOLICIES= $(if $(KCL_NETWORKPOLICIES_NAMESPACE_NAME),--namespace $(KCL_NETWORKPOLICIES_NAMESPACE_NAME))

# UI parameters
_KCL_APPLY_NETWORKPOLICIES_|?= #
_KCL_DIFF_NETWORKPOLICIES_|?= $(_KCL_APPLY_NETWORKPOLICIES_|)
_KCL_UNAPPLY_NETWORKPOLICIES_|?= $(_KCL_APPLY_NETWORKPOLICIES_|)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::NetworkPolicy ($(_KUBECTL_NETWORKPOLICY_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::NetworkPolicy ($(_KUBECTL_NETWORKPOLICY_MK_VERSION)) parameters:'
	@echo '    KCL_NETWORKPOLICY_LABELS_KEYVALUES=$(KCL_NETWORKPOLICY_LABELS_KEYVALUES)'
	@echo '    KCL_NETWORKPOLICY_NAME=$(KCL_NETWORKPOLICY_NAME)'
	@echo '    KCL_NETWORKPOLICY_NAMESPACE_NAME=$(KCL_NETWORKPOLICY_NAMESPACE_NAME)'
	@echo '    KCL_NETWORKPOLICIES_MANIFEST_DIRPATH=$(KCL_NETWORKPOLICIES_MANIFEST_DIRPATH)'
	@echo '    KCL_NETWORKPOLICIES_MANIFEST_FILENAME=$(KCL_NETWORKPOLICIES_MANIFEST_FILENAME)'
	@echo '    KCL_NETWORKPOLICIES_MANIFEST_FILEPATH=$(KCL_NETWORKPOLICIES_MANIFEST_FILEPATH)'
	@echo '    KCL_NETWORKPOLICIES_MANIFEST_STDINFLAG=$(KCL_NETWORKPOLICIES_MANIFEST_STDINFLAG)'
	@echo '    KCL_NETWORKPOLICIES_MANIFEST_URL=$(KCL_NETWORKPOLICIES_MANIFEST_URL)'
	@echo '    KCL_NETWORKPOLICIES_MANIFESTS_DIRPATH=$(KCL_NETWORKPOLICIES_MANIFESTS_DIRPATH)'
	@echo '    KCL_NETWORKPOLICIES_NAMESPACE_NAME=$(KCL_NETWORKPOLICIES_NAMESPACE_NAME)'
	@echo '    KCL_NETWORKPOLICIES_SELECTOR=$(KCL_NETWORKPOLICIES_SELECTOR)'
	@echo '    KCL_NETWORKPOLICIES_SET_NAME=$(KCL_NETWORKPOLICIES_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::NetworkPolicy ($(_KUBECTL_NETWORKPOLICY_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_networkpolicies                  - Annotate a network-policy'
	@echo '    _kcl_apply_networkpolicies                     - Apply a manifest for one-or-more network-policies'
	@echo '    _kcl_create_networkpolicy                      - Create a new network-policy'
	@echo '    _kcl_delete_networkpolicy                      - Delete an existing network-policy'
	@echo '    _kcl_diff_networkpolicies                      - Diff one or more network-policies'
	@echo '    _kcl_edit_networkpolicy                        - Edit a network-policy'
	@echo '    _kcl_explain_networkpolicy                     - Explain the network-policy object'
	@echo '    _kcl_list_networkpolicies                      - List network-policies'
	@echo '    _kcl_list_networkpolicies_set                  - List a set of network-policies'
	@echo '    _kcl_show_networkpolicy                        - Show everything related to a network-policy'
	@echo '    _kcl_show_networkpolicy_description            - Show desription of a network-policy'
	@echo '    _kcl_unapply_networkpolicies                   - Un-apply a manifest for one-or-more network-policies'
	@echo '    _kcl_watch_networkpolicies                     - Watch network-policies'
	@echo '    _kcl_watch_networkpolicies_set                 - Watch a set of network-policies'
	@echo '    _kcl_write_networkpolicies                     - Write a manifest for one-or-more network-policies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_networkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Annotating network-policy "$(KCL_NETWORKPOLICY_NAME)" ...'; $(NORMAL)

_kcl_apply_networkpolicy: _kcl_apply_networkpolicies
_kcl_apply_networkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Applying one-or-more network-policies ...'; $(NORMAL)
	$(if $(KCL_NETWORKPOLICIES_MANIFEST_FILEPATH),cat $(KCL_NETWORKPOLICIES_MANIFEST_FILEPATH); echo)
	$(if $(filter true,$(KCL_NETWORKPOLICIES_MANIFEST_STDINFLAG)),$(_KCL_APPLY_NETWORKPOLICIES_|)cat)
	$(if $(KCL_NETWORKPOLICIES_MANIFEST_URL),curl -L $(KCL_NETWORKPOLICIES_MANIFEST_URL); echo )
	$(if $(KCL_NETWORKPOLICIES_MANIFESTS_DIRPATH),ls -al $(KCL_NETWORKPOLICIES_MANIFESTS_DIRPATH); echo)
	$(_KCL_APPLY_NETWORKPOLICIES_|)$(KUBECTL) apply $(__KCL_FILENAME__NETWORKPOLICIES) $(__KCL_NAMESPACE__NETWORKPOLICIES)

_kcl_create_networkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Creating network-policy "$(KCL_NETWORKPOLICY_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) create networkpolicy $(__KCL_DESCRIPTION__NETWORKPOLICY) $(KCL_NETWORKPOLICY_NAME)

_kcl_delete_networkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Deleting network-policy "$(KCL_NETWORKPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete networkpolicy $(KCL_NETWORKPOLICY_NAME)

_kcl_diff_networkpolicy: _kcl_diff_networkpolicies
_kcl_diff_networkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing one-or-more network-policies ...'; $(NORMAL)
	# cat $(KCL_NETWORKPOLICIES_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_NETWORKPOLICIES_|)cat
	# curl -L $(KCL_NETWORKPOLICIES_MANIFEST_URL)
	# ls -al $(KCL_NETWORKPOLICIES_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_NETWORKPOLICIES_|)$(KUBECTL) diff $(__KCL_FILENAME__NETWORKPOLICIES) $(__KCL_NAMESPACE__NETWORKPOLICIES)

_kcl_edit_networkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Editing network-policy "$(KCL_NETWORKPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit networkpolicy $(__KCL_NAMESPACE__NETWORKPOLICY) $(KCL_NETWORKPOLICY_NAME)

_kcl_explain_networkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Explaining network-policy object ...'; $(NORMAL)
	$(KUBECTL) explain networkpolicy

_kcl_label_networkpolicy:
	@$(INFO) '$(KCL_UI_LABEL)Labelling network-policy "$(KCL_NETWORKPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label networkpolicy $(__KCL_NAMESPACE__NETWORKPOLICY) $(KCL_NETWORKPOLICY_NAME) $(KCL_NETWORKPOLICY_LABELS_KEYVALUES)

_kcl_list_networkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL network-policies ...'; $(NORMAL)
	$(KUBECTL) get networkpolicies --all-namespaces=true $(_X__KCL_NAMESPACE__NETWORKPOLICIES) $(_X__KCL_SELECTOR_NETWORKPOLICIES)

_kcl_list_networkpolicies_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing network-policies-set "$(KCL_NETWORKPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Network-policies are grouped based on provided namespace, selector, ...'; $(NORMAL)
	$(KUBECTL) get networkpolicies $(__KCL_NAMESPACE__NETWORKPOLICIES) $(__KCL_SELECTOR_NETWORKPOLICIES)

_KCL_SHOW_NETWORKPOLICY_TARGETS?= _kcl_show_networkpolicy_description
_kcl_show_networkpolicy: $(_KCL_SHOW_NETWORKPOLICY_TARGETS)

_kcl_show_networkpolicy_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of network-policy "$(KCL_NETWORKPOLICY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe networkpolicy $(__KCL_NAMESPACE__NETWORKPOLICY) $(KCL_NETWORKPOLICY_NAME) 

_kcl_unapply_networkpolicy: _kcl_unapply_networkpolicies
_kcl_unapply_networkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Unapplying one-or-more network-policies ...'; $(NORMAL)
	# cat $(KCL_NETWORKPOLICIES_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_NETWORKPOLICIES_|)cat
	# curl -L $(KCL_NETWORKPOLICIES_MANIFEST_URL)
	# ls -al $(KCL_NETWORKPOLICIES_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_NETWORKPOLICIES_|)$(KUBECTL) delete $(__KCL_FILENAME__NETWORKPOLICIES) $(__KCL_NAMESPACE__NETWORKPOLICIES)

_kcl_watch_networkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL network-policies ...'; $(NORMAL)

_kcl_watch_networkpolicies_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching network-policies-set "$(KCL_NETWORKPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Network-policies are grouped based on provided namespace, selector, ...'; $(NORMAL)

_kcl_write_networkpolicy: _kcl_write_networkpolicies
_kcl_write_networkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more network-policies ...'; $(NORMAL)
	$(WRITE) $(KCL_NETWORKPOLICIES_MANIFEST_FILEPATH)
