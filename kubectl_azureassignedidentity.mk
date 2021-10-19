_KUBECTL_AZUREASSIGNEDIDENTITY_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_AZUREASSIGNEDIDENTITY_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_AZUREASSIGNEDIDENTITY_MANIFEST_DIRPATH?=
# KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILENAME?=
# KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH?=
# KCL_AZUREASSIGNEDIDENTITY_MANIFEST_URL?= https://raw.githubusercontent.com/aad-pod-identity/master/deployment-rbac.yaml
# KCL_AZUREASSIGNEDIDENTITY_NAME?= 
# KCL_AZUREASSIGNEDIDENTITY_NAMESPACE_NAME?= 
# KCL_AZUREASSIGNEDIDENTITY_SELECTOR?= release=istio
# KCL_AZUREASSIGNEDIDENTITIES_SELECTOR?= release=istio
# KCL_AZUREASSIGNEDIDENTITIES_SET_NAME?= my-azure-assigned-identities-set

# Derived parameters
KCL_AZUREASSIGNEDIDENTITY_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH?= $(if $(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILENAME),$(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_DIRPATH)$(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILENAME))
KCL_AZUREASSIGNEDIDENTITY_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_AZUREASSIGNEDIDENTITIES_SET_NAME?= $(KCL_AZUREASSIGNEDIDENTITIES_SELECTOR)

# Option parameters
__KCL_ALL_NAMESPACES__AZUREASSIGNEDIDENTITIES?=
__KCL_FILENAME__AZUREASSIGNEDIDENTITY= $(if $(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH),--filename $(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH))
__KCL_NAMESPACE__AZUREASSIGNEDIDENTITY?= $(if $(KCL_AZUREASSIGNEDIDENTITY_NAMESPACE_NAME),--namespace $(KCL_AZUREASSIGNEDIDENTITY_NAMESPACE_NAME))
__KCL_NAMESPACE__AZUREASSIGNEDIDENTITIES?= $(if $(KCL_AZUREASSIGNEDIDENTITIES_NAMESPACE_NAME),--namespace $(KCL_AZUREASSIGNEDIDENTITIES_NAMESPACE_NAME))
__KCL_SELECTOR__AZUREASSIGNEDIDENTITY= $(if $(KCL_AZUREASSIGNEDIDENTITY_SELECTOR),--selector $(KCL_AZUREASSIGNEDIDENTITY_SELECTOR))
__KCL_SELECTOR__AZUREASSIGNEDIDENTITIES= $(if $(KCL_AZUREASSIGNEDIDENTITIES_SELECTOR),--selector $(KCL_AZUREASSIGNEDIDENTITIES_SELECTOR))

# Pipe
|_KCL_WGET_AZUREASSIGNEDIDENTITY?= | tee $(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH)

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::AzureAssignedIdentity ($(_KUBECTL_AZUREASSIGNEDIDENTITY_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::AzureAssignedIdentity ($(_KUBECTL_AZUREASSIGNEDIDENTITY_MK_VERSION)) parameters:'
	@echo '    KCL_AZUREASSIGNEDIDENTITY_LABELS_KEYVALUES=$(KCL_AZUREASSIGNEDIDENTITY_LABELS_KEYVALUES)'
	@echo '    KCL_AZUREASSIGNEDIDENTITY_MANIFEST_DIRPATH=$(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_DIRPATH)'
	@echo '    KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILENAME=$(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILENAME)'
	@echo '    KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH=$(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH)'
	@echo '    KCL_AZUREASSIGNEDIDENTITY_NAME=$(KCL_AZUREASSIGNEDIDENTITY_NAME)'
	@echo '    KCL_AZUREASSIGNEDIDENTITY_NAMESPACE_NAME=$(KCL_AZUREASSIGNEDIDENTITY_NAMESPACE_NAME)'
	@echo '    KCL_AZUREASSIGNEDIDENTITY_SELECTOR=$(KCL_AZUREASSIGNEDIDENTITY_SELECTOR)'
	@echo '    KCL_AZUREASSIGNEDIDENTITIES_NAMESPACE_NAME=$(KCL_AZUREASSIGNEDIDENTITIES_NAMESPACE_NAME)'
	@echo '    KCL_AZUREASSIGNEDIDENTITIES_SELECTOR=$(KCL_AZUREASSIGNEDIDENTITIES_SELECTOR)'
	@echo '    KCL_AZUREASSIGNEDIDENTITIES_SET_NAME=$(KCL_AZUREASSIGNEDIDENTITIES_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::AzureAssignedIdentity ($(_KUBECTL_AZUREASSIGNEDIDENTITY_MK_VERSION)) targets:'
	@echo '    _kcl_apply_azureassignedidentity              - Apply the azure-assigned-identity manifest'
	@echo '    _kcl_create_azureassignedidentity             - Create a new azure-assigned-identity using a manifest'
	@echo '    _kcl_delete_azureassignedidentity             - Delete an existing azure-assigned-identity'
	@echo '    _kcl_edit_azureassignedidentity               - Edit a azure-assigned-identity'
	@echo '    _kcl_explain_azureassignedidentity            - Explain the azure-assigned-identity object'
	@echo '    _kcl_show_azureassignedidentity               - Show everything related to a azure-assigned-identity'
	@echo '    _kcl_show_azureassignedidentity_description   - Show description of a azure-assigned-identity'
	@echo '    _kcl_show_azureassignedidentity_instances     - Show instances of a azure-assigned-identity'
	@echo '    _kcl_show_azureassignedidentity_object        - Show object of a azure-assigned-identity'
	@echo '    _kcl_unapply_azureassignedidentity            - Unapply a azure-assigned-identity'
	@echo '    _kcl_view_azureassignedidentities              - View azure-assigned-identities'
	@echo '    _kcl_view_azureassignedidentities_set          - View a set of azure-assigned-identities'
	@echo '    _kcl_wget_azureassignedidentity               - Wget a manifest for a azure-assigned-identity'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_apply_azureassignedidentity:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest with azure-assigned-identity "$(KCL_AZUREASSIGNEDIDENTITY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation applies the entire or selected content of the manifest'; $(NORMAL)
	# [ ! -f $(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH) ] || cat $(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH)
	# $(KUBECTL) apply $(__KCL_FILENAME__AZUREASSIGNEDIDENTITY) $(__KCL_SELECTOR__AZUREASSIGNEDIDENTITY)

_kcl_create_azureassignedidentity:
	@$(INFO) '$(KCL_UI_LABEL)Creating manifest with azure-assigned-identity "$(KCL_AZUREASSIGNEDIDENTITY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates the entire or selected content of the manifest'; $(NORMAL)
	# [ ! -f $(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH) ] || cat $(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH)
	# $(KUBECTL) create $(__KCL_FILENAME__AZUREASSIGNEDIDENTITY) $(__KCL_SELECTOR__AZUREASSIGNEDIDENTITY)

_kcl_delete_azureassignedidentity:
	@$(INFO) '$(KCL_UI_LABEL)Deleting manifest with azure-assigned-identity "$(KCL_AZUREASSIGNEDIDENTITY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the manifest has not been previously applied'; $(NORMAL)
	@$(WARN) 'This operation deletes the entire or selected content of the manifest'; $(NORMAL)
	# [ ! -f $(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH) ] || cat $(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_FILEPATH)
	# -$(KUBECTL) delete $(__KCL_FILENAME__AZUREASSIGNEDIDENTITY) $(__KCL_SELECTOR__AZUREASSIGNEDIDENTITY)

_kcl_edit_azureassignedidentity:

_kcl_explain_azureassignedidentity:
	@$(INFO) '$(KCL_UI_LABEL)Explaining azure-assigned-identity object ...'; $(NORMAL)
	# $(KUBECTL) explain azureassignedidentity

_kcl_label_azureassignedidentity:
	@$(INFO) '$(KCL_UI_LABEL)Labelling azure-assigned-identity "$(KCL_AZUREASSIGNEDIDENTITY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label azureassignedidentity $(__KCL_NAMESPACE__AZUREASSIGNEDIDENTITY) $(KCL_AZUREASSIGNEDIDENTITY_NAME) $(KCL_AZUREASSIGNEDIDENTITY_LABELS_KEYVALUES)

_kcl_show_azureassignedidentity: _kcl_show_azureassignedidentity_instances _kcl_show_azureassignedidentity_object _kcl_show_azureassignedidentity_description

_kcl_show_azureassignedidentity_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of azure-assigned-identity "$(KCL_AZUREASSIGNEDIDENTITY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get azureassignedidentity $(__KCL_NAMESPACE__AZUREASSIGNEDIDENTITY) $(KCL_AZUREASSIGNEDIDENTITY_NAME)

_kcl_show_azureassignedidentity_instances:
	@$(INFO) '$(KCL_UI_LABEL)Showing instances of azure-assigned-identity "$(KCL_AZUREASSIGNEDIDENTITY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get azureassignedidentity $(__KCL_NAMESPACE__AZUREASSIGNEDIDENTITY) $(KCL_AZUREASSIGNEDIDENTITY_NAME)

_kcl_show_azureassignedidentity_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of azure-assigned-identity "$(KCL_AZUREASSIGNEDIDENTITY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe azureassignedidentity $(__KCL_NAMESPACE__AZUREASSIGNEDIDENTITY) $(KCL_AZUREASSIGNEDIDENTITY_NAME) 

_kcl_unapply_azureassignedidentity: _kcl_delete_azureassignedidentity

_kcl_view_azureassignedidentities:
	@$(INFO) '$(KCL_UI_LABEL)Viewing azure-assigned-identities ...'; $(NORMAL)
	$(KUBECTL) get azureassignedidentities $(_X__KCL_NAMESPACE_ALL___AZUREASSIGNEDIDENTITIES) --all-namespaces=true $(_X__KCL_NAMESPACE__AZUREASSIGNEDIDENTITIES)

_kcl_view_azureassignedidentities_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing azure-assigned-identities-set "$(KCL_AZUREASSIGNEDIDENTITIES_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Azure-assigned-identities are grouped based on selector ...'; $(NORMAL)
	$(KUBECTL) get azureassignedidentities $(__KCL_NAMESPACE_ALL__AZUREASSIGNEDIDENTITIES) $(__KCL_NAMESPACE__AZUREASSIGNEDIDENTITIES) $(__KCL_SELECTOR__AZUREASSIGNEDIDENTITIES)

_kcl_wget_azureassignedidentity:
	@$(INFO) '$(KCL_UI_LABEL)Wget-ing manifest for azure-assigned-identity "$(KCL_AZUREASSIGNEDIDENTITY_NAME)"  ...'; $(NORMAL)
	wget --quiet --show-progress $(KCL_AZUREASSIGNEDIDENTITY_MANIFEST_URL) -O - $(|_KCL_WGET_AZUREASSIGNEDIDENTITY)
