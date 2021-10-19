_KUBECTL_AZUREIDENTITYBINDING_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_AZUREIDENTITYBINDING_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_AZUREIDENTITYBINDING_MANIFEST_DIRPATH?=
# KCL_AZUREIDENTITYBINDING_MANIFEST_FILENAME?=
# KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH?=
# KCL_AZUREIDENTITYBINDING_MANIFEST_URL?= https://raw.githubusercontent.com/aad-pod-identity/master/deployment-rbac.yaml
# KCL_AZUREIDENTITYBINDING_NAME?= 
# KCL_AZUREIDENTITYBINDING_NAMESPACE_NAME?= 
# KCL_AZUREIDENTITYBINDING_SELECTOR?= release=istio
# KCL_AZUREIDENTITYBINDINGS_SELECTOR?= release=istio
# KCL_AZUREIDENTITYBINDINGS_SET_NAME?= my-azure-identity-bindings-set

# Derived parameters
KCL_AZUREIDENTITYBINDING_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH?= $(if $(KCL_AZUREIDENTITYBINDING_MANIFEST_FILENAME),$(KCL_AZUREIDENTITYBINDING_MANIFEST_DIRPATH)$(KCL_AZUREIDENTITYBINDING_MANIFEST_FILENAME))
KCL_AZUREIDENTITYBINDING_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_AZUREIDENTITYBINDINGS_SET_NAME?= $(KCL_AZUREIDENTITYBINDINGS_SELECTOR)

# Option parameters
__KCL_ALL_NAMESPACES__AZUREIDENTITYBINDINGS?=
__KCL_FILENAME__AZUREIDENTITYBINDING= $(if $(KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH),--filename $(KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH))
__KCL_NAMESPACE__AZUREIDENTITYBINDING?= $(if $(KCL_AZUREIDENTITYBINDING_NAMESPACE_NAME),--namespace $(KCL_AZUREIDENTITYBINDING_NAMESPACE_NAME))
__KCL_NAMESPACE__AZUREIDENTITYBINDINGS?= $(if $(KCL_AZUREIDENTITYBINDINGS_NAMESPACE_NAME),--namespace $(KCL_AZUREIDENTITYBINDINGS_NAMESPACE_NAME))
__KCL_SELECTOR__AZUREIDENTITYBINDING= $(if $(KCL_AZUREIDENTITYBINDING_SELECTOR),--selector $(KCL_AZUREIDENTITYBINDING_SELECTOR))
__KCL_SELECTOR__AZUREIDENTITYBINDINGS= $(if $(KCL_AZUREIDENTITYBINDINGS_SELECTOR),--selector $(KCL_AZUREIDENTITYBINDINGS_SELECTOR))

# Pipe
|_KCL_WGET_AZUREIDENTITYBINDING?= | tee $(KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH)

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::AzureIdentityBinding ($(_KUBECTL_AZUREIDENTITYBINDING_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::AzureIdentityBinding ($(_KUBECTL_AZUREIDENTITYBINDING_MK_VERSION)) parameters:'
	@echo '    KCL_AZUREIDENTITYBINDING_LABELS_KEYVALUES=$(KCL_AZUREIDENTITYBINDING_LABELS_KEYVALUES)'
	@echo '    KCL_AZUREIDENTITYBINDING_MANIFEST_DIRPATH=$(KCL_AZUREIDENTITYBINDING_MANIFEST_DIRPATH)'
	@echo '    KCL_AZUREIDENTITYBINDING_MANIFEST_FILENAME=$(KCL_AZUREIDENTITYBINDING_MANIFEST_FILENAME)'
	@echo '    KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH=$(KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH)'
	@echo '    KCL_AZUREIDENTITYBINDING_NAME=$(KCL_AZUREIDENTITYBINDING_NAME)'
	@echo '    KCL_AZUREIDENTITYBINDING_NAMESPACE_NAME=$(KCL_AZUREIDENTITYBINDING_NAMESPACE_NAME)'
	@echo '    KCL_AZUREIDENTITYBINDING_SELECTOR=$(KCL_AZUREIDENTITYBINDING_SELECTOR)'
	@echo '    KCL_AZUREIDENTITYBINDINGS_NAMESPACE_NAME=$(KCL_AZUREIDENTITYBINDINGS_NAMESPACE_NAME)'
	@echo '    KCL_AZUREIDENTITYBINDINGS_SELECTOR=$(KCL_AZUREIDENTITYBINDINGS_SELECTOR)'
	@echo '    KCL_AZUREIDENTITYBINDINGS_SET_NAME=$(KCL_AZUREIDENTITYBINDINGS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::AzureIdentityBinding ($(_KUBECTL_AZUREIDENTITYBINDING_MK_VERSION)) targets:'
	@echo '    _kcl_apply_azureidentitybinding              - Apply the azure-identity-binding manifest'
	@echo '    _kcl_create_azureidentitybinding             - Create a new azure-identity-binding using a manifest'
	@echo '    _kcl_delete_azureidentitybinding             - Delete an existing azure-identity-binding'
	@echo '    _kcl_edit_azureidentitybinding               - Edit a azure-identity-binding'
	@echo '    _kcl_explain_azureidentitybinding            - Explain the azure-identity-binding object'
	@echo '    _kcl_show_azureidentitybinding               - Show everything related to a azure-identity-binding'
	@echo '    _kcl_show_azureidentitybinding_description   - Show description of a azure-identity-binding'
	@echo '    _kcl_show_azureidentitybinding_instances     - Show instances of a azure-identity-binding'
	@echo '    _kcl_show_azureidentitybinding_object        - Show object of a azure-identity-binding'
	@echo '    _kcl_unapply_azureidentitybinding            - Unapply a azure-identity-binding'
	@echo '    _kcl_view_azureidentitybindings              - View azure-identity-bindings'
	@echo '    _kcl_view_azureidentitybindings_set          - View a set of azure-identity-bindings'
	@echo '    _kcl_wget_azureidentitybinding               - Wget a manifest for a azure-identity-binding'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_apply_azureidentitybinding:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest with azure-identity-binding "$(KCL_AZUREIDENTITYBINDING_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation applies the entire or selected content of the manifest'; $(NORMAL)
	# [ ! -f $(KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH) ] || cat $(KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH)
	# $(KUBECTL) apply $(__KCL_FILENAME__AZUREIDENTITYBINDING) $(__KCL_SELECTOR__AZUREIDENTITYBINDING)

_kcl_create_azureidentitybinding:
	@$(INFO) '$(KCL_UI_LABEL)Creating manifest with azure-identity-binding "$(KCL_AZUREIDENTITYBINDING_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates the entire or selected content of the manifest'; $(NORMAL)
	# [ ! -f $(KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH) ] || cat $(KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH)
	# $(KUBECTL) create $(__KCL_FILENAME__AZUREIDENTITYBINDING) $(__KCL_SELECTOR__AZUREIDENTITYBINDING)

_kcl_delete_azureidentitybinding:
	@$(INFO) '$(KCL_UI_LABEL)Deleting manifest with azure-identity-binding "$(KCL_AZUREIDENTITYBINDING_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the manifest has not been previously applied'; $(NORMAL)
	@$(WARN) 'This operation deletes the entire or selected content of the manifest'; $(NORMAL)
	# [ ! -f $(KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH) ] || cat $(KCL_AZUREIDENTITYBINDING_MANIFEST_FILEPATH)
	# -$(KUBECTL) delete $(__KCL_FILENAME__AZUREIDENTITYBINDING) $(__KCL_SELECTOR__AZUREIDENTITYBINDING)

_kcl_edit_azureidentitybinding:

_kcl_explain_azureidentitybinding:
	@$(INFO) '$(KCL_UI_LABEL)Explaining azure-identity-binding object ...'; $(NORMAL)
	# $(KUBECTL) explain azureidentitybinding

_kcl_label_azureidentitybinding:
	@$(INFO) '$(KCL_UI_LABEL)Labelling azure-identity-binding "$(KCL_AZUREIDENTITYBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label azureidentitybinding $(__KCL_NAMESPACE__AZUREIDENTITYBINDING) $(KCL_AZUREIDENTITYBINDING_NAME) $(KCL_AZUREIDENTITYBINDING_LABELS_KEYVALUES)

_kcl_show_azureidentitybinding: _kcl_show_azureidentitybinding_instances _kcl_show_azureidentitybinding_object _kcl_show_azureidentitybinding_description

_kcl_show_azureidentitybinding_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of azure-identity-binding "$(KCL_AZUREIDENTITYBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get azureidentitybinding $(__KCL_NAMESPACE__AZUREIDENTITYBINDING) $(KCL_AZUREIDENTITYBINDING_NAME)

_kcl_show_azureidentitybinding_instances:
	@$(INFO) '$(KCL_UI_LABEL)Showing instances of azure-identity-binding "$(KCL_AZUREIDENTITYBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get azureidentitybinding $(__KCL_NAMESPACE__AZUREIDENTITYBINDING) $(KCL_AZUREIDENTITYBINDING_NAME)

_kcl_show_azureidentitybinding_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of azure-identity-binding "$(KCL_AZUREIDENTITYBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe azureidentitybinding $(__KCL_NAMESPACE__AZUREIDENTITYBINDING) $(KCL_AZUREIDENTITYBINDING_NAME) 

_kcl_unapply_azureidentitybinding: _kcl_delete_azureidentitybinding

_kcl_view_azureidentitybindings:
	@$(INFO) '$(KCL_UI_LABEL)Viewing azure-identity-bindings ...'; $(NORMAL)
	$(KUBECTL) get azureidentitybindings $(_X__KCL_NAMESPACE_ALL___AZUREIDENTITYBINDINGS) --all-namespaces=true $(_X__KCL_NAMESPACE__AZUREIDENTITYBINDINGS)

_kcl_view_azureidentitybindings_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing azure-identity-bindings-set "$(KCL_AZUREIDENTITYBINDINGS_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Azure-identity-bindings are grouped based on selector ...'; $(NORMAL)
	$(KUBECTL) get azureidentitybindings $(__KCL_NAMESPACE_ALL__AZUREIDENTITYBINDINGS) $(__KCL_NAMESPACE__AZUREIDENTITYBINDINGS) $(__KCL_SELECTOR__AZUREIDENTITYBINDINGS)

_kcl_wget_azureidentitybinding:
	@$(INFO) '$(KCL_UI_LABEL)Wget-ing manifest for azure-identity-binding "$(KCL_AZUREIDENTITYBINDING_NAME)"  ...'; $(NORMAL)
	wget --quiet --show-progress $(KCL_AZUREIDENTITYBINDING_MANIFEST_URL) -O - $(|_KCL_WGET_AZUREIDENTITYBINDING)
