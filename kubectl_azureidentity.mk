_KUBECTL_AZUREIDENTITY_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_AZUREIDENTITY_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_AZUREIDENTITY_MANIFEST_DIRPATH?=
# KCL_AZUREIDENTITY_MANIFEST_FILENAME?=
# KCL_AZUREIDENTITY_MANIFEST_FILEPATH?=
# KCL_AZUREIDENTITY_MANIFEST_URL?= https://raw.githubusercontent.com/aad-pod-identity/master/deployment-rbac.yaml
# KCL_AZUREIDENTITY_NAME?= 
# KCL_AZUREIDENTITY_NAMESPACE_NAME?= 
# KCL_AZUREIDENTITY_SELECTOR?= release=istio
# KCL_AZUREIDENTITIES_SELECTOR?= release=istio
# KCL_AZUREIDENTITIES_SET_NAME?= my-azure-identities-set

# Derived parameters
KCL_AZUREIDENTITY_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_AZUREIDENTITY_MANIFEST_FILEPATH?= $(if $(KCL_AZUREIDENTITY_MANIFEST_FILENAME),$(KCL_AZUREIDENTITY_MANIFEST_DIRPATH)$(KCL_AZUREIDENTITY_MANIFEST_FILENAME))
KCL_AZUREIDENTITY_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_AZUREIDENTITIES_SET_NAME?= $(KCL_AZUREIDENTITIES_SELECTOR)

# Option parameters
__KCL_ALL_NAMESPACES__AZUREIDENTITIES?=
__KCL_FILENAME__AZUREIDENTITY= $(if $(KCL_AZUREIDENTITY_MANIFEST_FILEPATH),--filename $(KCL_AZUREIDENTITY_MANIFEST_FILEPATH))
__KCL_NAMESPACE__AZUREIDENTITY?= $(if $(KCL_AZUREIDENTITY_NAMESPACE_NAME),--namespace $(KCL_AZUREIDENTITY_NAMESPACE_NAME))
__KCL_NAMESPACE__AZUREIDENTITIES?= $(if $(KCL_AZUREIDENTITIES_NAMESPACE_NAME),--namespace $(KCL_AZUREIDENTITIES_NAMESPACE_NAME))
__KCL_SELECTOR__AZUREIDENTITY= $(if $(KCL_AZUREIDENTITY_SELECTOR),--selector $(KCL_AZUREIDENTITY_SELECTOR))
__KCL_SELECTOR__AZUREIDENTITIES= $(if $(KCL_AZUREIDENTITIES_SELECTOR),--selector $(KCL_AZUREIDENTITIES_SELECTOR))

# Pipe
|_KCL_WGET_AZUREIDENTITY?= | tee $(KCL_AZUREIDENTITY_MANIFEST_FILEPATH)

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::AzureIdentity ($(_KUBECTL_AZUREIDENTITY_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::AzureIdentity ($(_KUBECTL_AZUREIDENTITY_MK_VERSION)) parameters:'
	@echo '    KCL_AZUREIDENTITY_LABELS_KEYVALUES=$(KCL_AZUREIDENTITY_LABELS_KEYVALUES)'
	@echo '    KCL_AZUREIDENTITY_MANIFEST_DIRPATH=$(KCL_AZUREIDENTITY_MANIFEST_DIRPATH)'
	@echo '    KCL_AZUREIDENTITY_MANIFEST_FILENAME=$(KCL_AZUREIDENTITY_MANIFEST_FILENAME)'
	@echo '    KCL_AZUREIDENTITY_MANIFEST_FILEPATH=$(KCL_AZUREIDENTITY_MANIFEST_FILEPATH)'
	@echo '    KCL_AZUREIDENTITY_NAME=$(KCL_AZUREIDENTITY_NAME)'
	@echo '    KCL_AZUREIDENTITY_NAMESPACE_NAME=$(KCL_AZUREIDENTITY_NAMESPACE_NAME)'
	@echo '    KCL_AZUREIDENTITY_SELECTOR=$(KCL_AZUREIDENTITY_SELECTOR)'
	@echo '    KCL_AZUREIDENTITIES_NAMESPACE_NAME=$(KCL_AZUREIDENTITIES_NAMESPACE_NAME)'
	@echo '    KCL_AZUREIDENTITIES_SELECTOR=$(KCL_AZUREIDENTITIES_SELECTOR)'
	@echo '    KCL_AZUREIDENTITIES_SET_NAME=$(KCL_AZUREIDENTITIES_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::AzureIdentity ($(_KUBECTL_AZUREIDENTITY_MK_VERSION)) targets:'
	@echo '    _kcl_apply_azureidentity              - Apply the azure-identity manifest'
	@echo '    _kcl_create_azureidentity             - Create a new azure-identity using a manifest'
	@echo '    _kcl_delete_azureidentity             - Delete an existing azure-identity'
	@echo '    _kcl_edit_azureidentity               - Edit a azure-identity'
	@echo '    _kcl_explain_azureidentity            - Explain the azure-identity object'
	@echo '    _kcl_show_azureidentity               - Show everything related to a azure-identity'
	@echo '    _kcl_show_azureidentity_description   - Show description of a azure-identity'
	@echo '    _kcl_show_azureidentity_instances     - Show instances of a azure-identity'
	@echo '    _kcl_show_azureidentity_object        - Show object of a azure-identity'
	@echo '    _kcl_unapply_azureidentity            - Unapply a azure-identity'
	@echo '    _kcl_view_azureidentities              - View azure-identities'
	@echo '    _kcl_view_azureidentities_set          - View a set of azure-identities'
	@echo '    _kcl_wget_azureidentity               - Wget a manifest for a azure-identity'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_apply_azureidentity:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest with azure-identity "$(KCL_AZUREIDENTITY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation applies the entire or selected content of the manifest'; $(NORMAL)
	# [ ! -f $(KCL_AZUREIDENTITY_MANIFEST_FILEPATH) ] || cat $(KCL_AZUREIDENTITY_MANIFEST_FILEPATH)
	# $(KUBECTL) apply $(__KCL_FILENAME__AZUREIDENTITY) $(__KCL_SELECTOR__AZUREIDENTITY)

_kcl_create_azureidentity:
	@$(INFO) '$(KCL_UI_LABEL)Creating manifest with azure-identity "$(KCL_AZUREIDENTITY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates the entire or selected content of the manifest'; $(NORMAL)
	# [ ! -f $(KCL_AZUREIDENTITY_MANIFEST_FILEPATH) ] || cat $(KCL_AZUREIDENTITY_MANIFEST_FILEPATH)
	# $(KUBECTL) create $(__KCL_FILENAME__AZUREIDENTITY) $(__KCL_SELECTOR__AZUREIDENTITY)

_kcl_delete_azureidentity:
	@$(INFO) '$(KCL_UI_LABEL)Deleting manifest with azure-identity "$(KCL_AZUREIDENTITY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the manifest has not been previously applied'; $(NORMAL)
	@$(WARN) 'This operation deletes the entire or selected content of the manifest'; $(NORMAL)
	# [ ! -f $(KCL_AZUREIDENTITY_MANIFEST_FILEPATH) ] || cat $(KCL_AZUREIDENTITY_MANIFEST_FILEPATH)
	# -$(KUBECTL) delete $(__KCL_FILENAME__AZUREIDENTITY) $(__KCL_SELECTOR__AZUREIDENTITY)

_kcl_edit_azureidentity:

_kcl_explain_azureidentity:
	@$(INFO) '$(KCL_UI_LABEL)Explaining azure-identity object ...'; $(NORMAL)
	# $(KUBECTL) explain azureidentity

_kcl_label_azureidentity:
	@$(INFO) '$(KCL_UI_LABEL)Labelling azure-identity "$(KCL_AZUREIDENTITY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label azureidentity $(__KCL_NAMESPACE__AZUREIDENTITY) $(KCL_AZUREIDENTITY_NAME) $(KCL_AZUREIDENTITY_LABELS_KEYVALUES)

_kcl_show_azureidentity: _kcl_show_azureidentity_instances _kcl_show_azureidentity_object _kcl_show_azureidentity_description

_kcl_show_azureidentity_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of azure-identity "$(KCL_AZUREIDENTITY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get azureidentity $(__KCL_NAMESPACE__AZUREIDENTITY) $(KCL_AZUREIDENTITY_NAME)

_kcl_show_azureidentity_instances:
	@$(INFO) '$(KCL_UI_LABEL)Showing instances of azure-identity "$(KCL_AZUREIDENTITY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get azureidentity $(__KCL_NAMESPACE__AZUREIDENTITY) $(KCL_AZUREIDENTITY_NAME)

_kcl_show_azureidentity_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of azure-identity "$(KCL_AZUREIDENTITY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe azureidentity $(__KCL_NAMESPACE__AZUREIDENTITY) $(KCL_AZUREIDENTITY_NAME) 

_kcl_unapply_azureidentity: _kcl_delete_azureidentity

_kcl_view_azureidentities:
	@$(INFO) '$(KCL_UI_LABEL)Viewing azure-identities ...'; $(NORMAL)
	$(KUBECTL) get azureidentities $(_X__KCL_NAMESPACE_ALL___AZUREIDENTITIES) --all-namespaces=true $(_X__KCL_NAMESPACE__AZUREIDENTITIES)

_kcl_view_azureidentities_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing azure-identities-set "$(KCL_AZUREIDENTITIES_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Azure-identities are grouped based on selector ...'; $(NORMAL)
	$(KUBECTL) get azureidentities $(__KCL_NAMESPACE_ALL__AZUREIDENTITIES) $(__KCL_NAMESPACE__AZUREIDENTITIES) $(__KCL_SELECTOR__AZUREIDENTITIES)

_kcl_wget_azureidentity:
	@$(INFO) '$(KCL_UI_LABEL)Wget-ing manifest for azure-identity "$(KCL_AZUREIDENTITY_NAME)"  ...'; $(NORMAL)
	wget --quiet --show-progress $(KCL_AZUREIDENTITY_MANIFEST_URL) -O - $(|_KCL_WGET_AZUREIDENTITY)
