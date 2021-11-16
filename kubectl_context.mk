_KUBECTL_CONTEXT_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_CONTEXT_CLUSTER_NAME?= 
# KCL_CONTEXT_NAME?= 
# KCL_CONTEXT_NAME_NEW?= 
# KCL_CONTEXT_NAME_OLD?= 
# KCL_CONTEXT_NO_HEADER?= true
# KCL_CONTEXT_OUTPUT_FORMAT?=
# KCL_CONTEXT_USER?=

# Derived parameters
KCL_CONTEXT_CLUSTER_NAME?= $(KCL_CONTEXT_NAME)
KCL_CONTEXT_NAME_OLD?= $(KCL_CONTEXT_NAME)
KCL_CONTEXT_USER?= $(KCL_CONTEXT_NAME)

# Options
__KCL_CLUSTER__CONTEXT= $(if $(KCL_CONTEXT_CLUSTER_NAME),--cluster $(KCL_CONTEXT_CLUSTER_NAME))
__KCL_NAMESPACE__CONTEXT= $(if $(KCL_CONTEXT_NAMESPACE),--namespace $(KCL_CONTEXT_NAMESPACE))
__KCL_NO_HEADER__CONTEXT= $(if $(KCL_CONTEXT_NO_HEADER),--no-header=$(KCL_CONTEXT_NO_HEADER))
__KCL_OUTPUT__CONTEXT= $(if $(KCL_CONTEXT_OUTPUT_FORMAT),--output=$(KCL_CONTEXT_OUTPUT_FORMAT))
__KCL_USER__CONTEXT= $(if $(KCL_CONTEXT_USER),--user $(KCL_CONTEXT_USER))

# Customizations

#--- MACROS
_kcl_get_current_context= $(shell kubectl config current-context)

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Context ($(_KUBECTL_CONTEXT_MK_VERSION)) macros:'
	@echo '    _kcl_get_current_context              - Get the current context'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Context ($(_KUBECTL_CONTEXT_MK_VERSION)) parameters:'
	@echo '    KCL_CONTEXT_CLUSTER_NAME=$(KCL_CONTEXT_CLUSTER_NAME)'
	@echo '    KCL_CONTEXT_NAME=$(KCL_CONTEXT_NAME)'
	@echo '    KCL_CONTEXT_NAME_NEW=$(KCL_CONTEXT_NAME_NEW)'
	@echo '    KCL_CONTEXT_NAME_OLD=$(KCL_CONTEXT_NAME_OLD)'
	@echo '    KCL_CONTEXT_NAMESPACE=$(KCL_CONTEXT_NAMESPACE)'
	@echo '    KCL_CONTEXT_NO_HEADER=$(KCL_CONTEXT_NO_HEADER)'
	@echo '    KCL_CONTEXT_OUTPUT_FORMAT=$(KCL_CONTEXT_OUTPUT_FORMAT)'
	@echo '    KCL_CONTEXT_USER=$(KCL_CONTEXT_USER)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Context ($(_KUBECTL_CONTEXT_MK_VERSION)) targets:'
	@echo '    _kcl_delete_context                  - Delete an existing context'
	@echo '    _kcl_list_contexts                   - List all contexts'
	@echo '    _kcl_rename_context                  - Rename a context'
	@echo '    _kcl_show_context                    - Show everything related to a context'
	@echo '    _kcl_show_context_description        - Show the description of a context'
	@echo '    _kcl_update_context                  - Update a context'
	@echo '    _kcl_use_context                     - Use a context'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_delete_context:
	@$(INFO) '$(KCL_UI_LABEL)Deleting context "$(KCL_CONTEXT_NAME)"  ...'; $(NORMAL)
	$(KUBECTL) config delete-context $(KCL_CONTEXT_NAME)

_kcl_list_contexts:
	@$(INFO) '$(KCL_UI_LABEL)Listing all contexts ...'; $(NORMAL)
	@$(WARN) 'Context = a user + a cluster + a namespace'; $(NORMAL)
	$(KUBECTL) config get-contexts $(__KCL_NO_HEADER__CONTEXT) $(__KCL_OUTPUT__CONTEXT) $(_X_KCL_CONTEXT_NAME) 

_kcl_rename_context:
	@$(INFO) '$(KCL_UI_LABEL)Renaming context "$(KCL_CONTEXT_NAME)"  ...'; $(NORMAL)
	$(KUBECTL) config rename-context $(KCL_CONTEXT_NAME_OLD)  $(KCL_CONTEXT_NAME_NEW)

_KCL_SHOW_CONTEXT_TARGETS?= _kcl_show_context_description
_kcl_show_context: $(_KCL_SHOW_CONTEXT_TARGETS)

_kcl_show_context_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of context "$(KCL_CONTEXT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) config get-contexts $(__KCL_NO_HEADER__CONTEXT) $(__KCL_OUTPUT__CONTEXT) $(KCL_CONTEXT_NAME) 
	@#$(KUBECTL) config view | yq '.contexts[]|select(.name=="$(KCL_CONTEXT_NAME)")' --yaml-output

_kcl_update_context:
	@$(INFO) '$(KCL_UI_LABEL)Updating context "$(KCL_CONTEXT_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'This operation update the context in kubeconfig including cluster, namespace, user'; $(NORMAL)
	$(KUBECTL) config set-context $(__KCL_CLUSTER__CONTEXT) $(__KCL_NAMESPACE__CONTEXT) $(__KCL_USER__CONTEXT) $(KCL_CONTEXT_NAME)

_kcl_use_context:
	@$(INFO) '$(KCL_UI_LABEL)Using context "$(KCL_CONTEXT_NAME)"  ...'; $(NORMAL)
	$(KUBECTL) config use-context $(KCL_CONTEXT_NAME) 
