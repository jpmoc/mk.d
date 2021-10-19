_KUBECTL_ISTIO_INSTANCE_MK_VERSION= $(_KUBECTL_ISTIO_MK_VERSION)

# KCL_INSTANCE_NAME?=
# KCL_INSTANCE_NAMESPACE_NAME?= istio-namespace
# KCL_INSTANCE_OUTPUT?=
# KCL_INSTANCES_NAMESPACE_NAME?= istio-namespace
# KCL_INSTANCES_OUTPUT?=
# KCL_INSTANCES_SELECTOR?=

# Derived parameters
KCL_INSTANCE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_INSTANCES_NAMESPACE_NAME?= $(KCL_INSTANCE_NAMESPACE_NAME)

# Option parameters
__KCL_LABELS__INSTANCE= $(if $(KCL_INSTANCE_LABELS_KEYVALUES),--labels $(KCL_INSTANCE_LABELS_KEYVALUES))
__KCL_NAMESPACE__INSTANCE= $(if $(KCL_INSTANCE_NAMESPACE_NAME),--namespace $(KCL_INSTANCE_NAMESPACE_NAME))
__KCL_NAMESPACE__INSTANCES= $(if $(KCL_INSTANCES_NAMESPACE_NAME),--namespace $(KCL_INSTANCES_NAMESPACE_NAME))
__KCL_OUTPUT__INSTANCE= $(if $(KCL_INSTANCE_OUTPUT),--output $(KCL_INSTANCE_OUTPUT))
__KCL_OUTPUT__INSTANCES= $(if $(KCL_INSTANCES_OUTPUT),--output $(KCL_INSTANCES_OUTPUT))
__KCL_SELECTOR__INSTANCES= $(if $(KCL_INSTANCES_SELECTOR),--selector=$(KCL_INSTANCES_SELECTOR))
__KCL_SORT_BY__INSTANCES= $(if $(KCL_INSTANCES_SORT_BY),--sort-by=$(KCL_INSTANCES_SORT_BY))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Istio::DestinationRule ($(_KUBECTL_ISTIO_INSTANCE_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Istio::DestinationRule ($(_KUBECTL_ISTIO_INSTANCE_MK_VERSION)) parameters:'
	@echo '    KCL_INSTANCE_NAME=$(KCL_INSTANCE_NAME)'
	@echo '    KCL_INSTANCE_NAMESPACE_NAME=$(KCL_INSTANCE_NAMESPACE_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Istio::DestinationRule ($(_KUBECTL_ISTIO_INSTANCE_MK_VERSION)) targets:'
	@echo '    _kcl_create_instance                  - Create a instance'
	@echo '    _kcl_delete_instance                  - Delete a instance'
	@echo '    _kcl_label_instance                   - Label a instance'
	@echo '    _kcl_show_instance                    - Show everything related to a instance'
	@echo '    _kcl_show_instance_description        - Show description of a instance'
	@echo '    _kcl_show_instance_manifest           - Show manifest of a instance'
	@echo '    _kcl_unlabel_instance                 - Unlabel a instance'
	@echo '    _kcl_view_instances                   - View all instances'
	@echo '    _kcl_view_instances_set               - View a set of instances'
	@echo '    _kcl_watch_instances                  - Watch instances'
	@echo '    _kcl_watch_instances_set              - Watch a set of instances'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_instance:

_kcl_create_instance:
	@$(INFO) '$(KCL_UI_LABEL)Creating instance "$(KCL_INSTANCE_NAME)" ...'; $(NORMAL)

_kcl_delete_instance:
	@$(INFO) '$(KCL_UI_LABEL)Deleting instance "$(KCL_INSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT delete services of exposed deployments'; $(NORMAL)
	$(KUBECTL) delete instance $(__KCL_NAMESPACE__INSTANCE) $(KCL_INSTANCE_NAME)

_kcl_edit_instance:
	@$(INFO) '$(KCL_UI_LABEL)Editing instance "$(KCL_INSTANCE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit instance $(__KCL_NAMESPACE__INSTANCE) $(KCL_INSTANCE_NAME)

_kcl_explain_instance:
	@$(INFO) '$(KCL_UI_LABEL)Explaining instance object ...'; $(NORMAL)
	$(KUBECTL) explain instance

_kcl_show_instance: _kcl_show_instance_manifest _kcl_show_instance_description

_kcl_show_instance_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description instance "$(KCL_INSTANCE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe instance $(__KCL_NAMESPACE__INSTANCE) $(KCL_INSTANCE_NAME)

_kcl_show_instance_manifest:
	@$(INFO) '$(KCL_UI_LABEL)Showing manifest of instance "$(KCL_INSTANCE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get instance $(__KCL_NAMESPACE__INSTANCE) $(__KCL_OUTPUT__INSTANCE) $(KCL_INSTANCE_NAME)

_kcl_unlabel_instance:
	@$(INFO) '$(KCL_UI_LABEL)Removing labels from instance "$(KCL_INSTANCE_NAME)" ...'; $(NORMAL)

_kcl_view_instances:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL instances ...'; $(NORMAL)
	$(KUBECTL) get instances --all-namespaces=true $(_X__KCL_NAMESPACE__INSTANCES) $(__KCL_OUTPUT_INSTANCES) $(_X__KCL_SELECTOR__INSTANCES) $(__KCL_SORT_BY__INSTANCES)

_kcl_view_instances_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing instances-set "$(KCL_INSTANCES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Deployments are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get instances --all-namespaces=false $(__KCL_NAMESPACE__INSTANCES) $(__KCL_OUTPUT__INSTANCES) $(__KCL_SELECTOR__INSTANCES) $(__KCL_SORT_BY__INSTANCES)

_kcl_watch_instances:
	@$(INFO) '$(KCL_UI_LABEL)Watching instances ...'; $(NORMAL)
	$(KUBECTL) get instances --all-namespaces=true --watch 

_kcl_watch_instances_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching instances-set "$(KCL_INSTANCES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get instances --all-namespaces=true --watch 
