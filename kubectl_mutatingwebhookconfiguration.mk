_KUBECTL_MUTATINGWEBHOOKCONFIGURATION_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR?= manifest.name=my-name
# KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_NAMES?= hello-4111706356-o9qcm ...
# KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR?= app=global-registration-service
# KCL_MUTATINGWEBHOOKCONFIG_LABELS_KEYVALUES?=
# KCL_MUTATINGWEBHOOKCONFIG_NAME?= my-name
# KCL_MUTATINGWEBHOOKCONFIG_NAMESPACE_NAME?= default
# KCL_MUTATINGWEBHOOKCONFIG_OUTPUT_FORMAT?=
# KCL_MUTATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR?= manifest.name=my-pod
# KCL_MUTATINGWEBHOOKCONFIG_PODS_NAMES?= hello-4111706356-o9qcm ...
# KCL_MUTATINGWEBHOOKCONFIG_PODS_SELECTOR?= app=global-registration-service
# KCL_MUTATINGWEBHOOKCONFIG_REPLICAS_COUNT?= 1
# KCL_MUTATINGWEBHOOKCONFIG_REPLICASET_NAME?= api-gateway-6f5877798
# KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR?= metadata.name=my-replica-set
# KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_NAMES?= api-gateway-6f5877798 ...
# KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR?= app=global-registration-service
# KCL_MUTATINGWEBHOOKCONFIG_SELECTOR?= app=global-registration-service
# KCL_MUTATINGWEBHOOKCONFIG_SERVICEACCOUNT_NAME?= default
# KCL_MUTATINGWEBHOOKCONFIGS_CLUSTER_NAME?= my-cluster-name
# KCL_MUTATINGWEBHOOKCONFIGS_FIELDSELECTOR?= metadata.name=my-mutatingwebhookconfig
# KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_DIRPATH?= ./in/
# KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILENAME?= manifest.yaml
# KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_STDINFLAG?= false
# KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_URL?= http://...
# KCL_MUTATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_MUTATINGWEBHOOKCONFIGS_OUTPUT_FORMAT?= jsonpath='{.items[0].metadata.name}'
# KCL_MUTATINGWEBHOOKCONFIGS_SELECTOR?= run=ecr-read-only--renew-token
# KCL_MUTATINGWEBHOOKCONFIGS_SET_NAME?= my-mutatingwebhookconfigs-set

# Derived parameters
KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR?= $(KCL_MUTATINGWEBHOOKCONFIG_SELECTOR)
KCL_MUTATINGWEBHOOKCONFIG_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_MUTATINGWEBHOOKCONFIG_OUTPUT_FORMAT?= $(KCL_OUTPUT_FORMAT)
KCL_MUTATINGWEBHOOKCONFIG_PODS_SELECTOR?= $(KCL_MUTATINGWEBHOOKCONFIG_SELECTOR)
KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR?= $(KCL_MUTATINGWEBHOOKCONFIG_SELECTOR)
KCL_MUTATINGWEBHOOKCONFIG_SERVICES_SELECTOR?= $(KCL_MUTATINGWEBHOOKCONFIG_SELECTOR)
KCL_MUTATINGWEBHOOKCONFIG_SERVICE_NAME?= $(KCL_MUTATINGWEBHOOKCONFIG_NAME)
KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH?= $(if $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILENAME),$(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_DIRPATH)$(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILENAME))
KCL_MUTATINGWEBHOOKCONFIGS_SET_NAME?= mutating-webhook-config@@$(KCL_MUTATINGWEBHOOKCONFIGS_SELECTOR)@

# Option parameters
__KCL_FILENAME__MUTATINGWEBHOOKCONFIGS+= $(if $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH),--filename $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH))
__KCL_FILENAME__MUTATINGWEBHOOKCONFIGS+= $(if $(filter true,$(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__MUTATINGWEBHOOKCONFIGS+= $(if $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_URL),--filename $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_URL))
__KCL_FILENAME__MUTATINGWEBHOOKCONFIGS+= $(if $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH),--filename $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH))
__KCL_LABELS__MUTATINGWEBHOOKCONFIG= $(if $(KCL_MUTATINGWEBHOOKCONFIG_LABELS_KEYVALUES),--labels $(KCL_MUTATINGWEBHOOKCONFIG_LABELS_KEYVALUES))
__KCL_NAME__MUTATINGWEBHOOKCONFIG= $(if $(KCL_MUTATINGWEBHOOKCONFIG_SERVICE_NAME),--name $(KCL_MUTATINGWEBHOOKCONFIG_SERVICE_NAME))
__KCL_NAMESPACE__MUTATINGWEBHOOKCONFIG= $(if $(KCL_MUTATINGWEBHOOKCONFIG_NAMESPACE_NAME),--namespace $(KCL_MUTATINGWEBHOOKCONFIG_NAMESPACE_NAME))
__KCL_OUTPUT__MUTATINGWEBHOOKCONFIG= $(if $(KCL_MUTATINGWEBHOOKCONFIG_OUTPUT_FORMAT),--output $(KCL_MUTATINGWEBHOOKCONFIG_OUTPUT_FORMAT))
__KCL_OUTPUT__MUTATINGWEBHOOKCONFIGS= $(if $(KCL_MUTATINGWEBHOOKCONFIGS_OUTPUT_FORMAT),--output $(KCL_MUTATINGWEBHOOKCONFIGS_OUTPUT_FORMAT))
__KCL_SELECTOR__MUTATINGWEBHOOKCONFIGS= $(if $(KCL_MUTATINGWEBHOOKCONFIGS_SELECTOR),--selector=$(KCL_MUTATINGWEBHOOKCONFIGS_SELECTOR))

# UI parameters

#--- MACROS
_kcl_get_mutatingwebhookconfig_deployments_names= $(call _kcl_get_mutatingwebhookconfig_deployments_names_S, $(KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR))
_kcl_get_mutatingwebhookconfig_dpeloyments_names_S= $(call _kcl_get_mutatingwebhookconfig_deployments_names_SN, $(1), $(KCL_MUTATINGWEBHOOKCONFIG_NAMESPACE_NAME))
_kcl_get_mutatingwebhookconfig_deployments_names_SN= $(shell $(KUBECTL) get deployments --namespace $(2) --selector=$(strip $(1)) --output=jsonpath="{.items..metadata.name}")

_kcl_get_mutatingwebhookconfig_pods_names= $(call _kcl_get_mutatingwebhookconfig_pods_names_S, $(KCL_MUTATINGWEBHOOKCONFIG_PODS_SELECTOR))
_kcl_get_mutatingwebhookconfig_pods_names_S= $(call _kcl_get_mutatingwebhookconfig_pods_names_SN, $(1), $(KCL_MUTATINGWEBHOOKCONFIG_NAMESPACE_NAME))
_kcl_get_mutatingwebhookconfig_pods_names_SN= $(shell $(KUBECTL) get pods --namespace $(2) --selector=$(strip $(1)) --output=jsonpath="{.items..metadata.name}")

_kcl_get_mutatingwebhookconfig_replicasets_names= $(call _kcl_get_mutatingwebhookconfig_replicasets_names_S, $(KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR))
_kcl_get_mutatingwebhookconfig_replicasets_names_S= $(call _kcl_get_mutatingwebhookconfig_replicasets_names_SN, $(1), $(KCL_MUTATINGWEBHOOKCONFIG_NAMESPACE_NAME))
_kcl_get_mutatingwebhookconfig_replicasets_names_SN= $(shell $(KUBECTL) get replicasets --namespace $(2) --selector $(1) --output=jsonpath="{.items..metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::MutatingWebhookConfiguration ($(_KUBECTL_MUTATINGWEBHOOKCONFIGURATION_MK_VERSION)) macros:'
	@echo '    _kcl_get_mutatingwebhookconfig_deployments_names_{|S|SN}      - Get the name of deployments used by a mutatingwebhookconfig (Selector,Namespace)'
	@echo '    _kcl_get_mutatingwebhookconfig_pods_names_{|S|SN}             - Get the name of pods used by a mutatingwebhookconfig (Selector,Namespace)'
	@echo '    _kcl_get_mutatingwebhookconfig_replicasets_name_{|S|SN}       - Get the name of the replica-sets used by a mutatingwebhookconfig (Selector,Namespace)'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::MutatingWebhookConfiguration ($(_KUBECTL_MUTATINGWEBHOOKCONFIGURATION_MK_VERSION)) parameters:'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_NAMES=$(KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_NAMES)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR=$(KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR=$(KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_LABELS_KEYS=$(KCL_MUTATINGWEBHOOKCONFIG_LABELS_KEYS)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_LABELS_KEYVALUES=$(KCL_MUTATINGWEBHOOKCONFIG_LABELS_KEYVALUES)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_NAME=$(KCL_MUTATINGWEBHOOKCONFIG_NAME)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_NAMESPACE_NAME=$(KCL_MUTATINGWEBHOOKCONFIG_NAMESPACE_NAME)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_OUTPUT_FORMAT=$(KCL_MUTATINGWEBHOOKCONFIG_OUTPUT_FORMAT)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_POD_NAME=$(KCL_MUTATINGWEBHOOKCONFIG_POD_NAME)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_PODS_NAMES=$(KCL_MUTATINGWEBHOOKCONFIG_PODS_NAMES)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR=$(KCL_MUTATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_PODS_SELECTOR=$(KCL_MUTATINGWEBHOOKCONFIG_PODS_SELECTOR)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_PORT=$(KCL_MUTATINGWEBHOOKCONFIG_PORT)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_PORTFORWARD_PORTS=$(KCL_MUTATINGWEBHOOKCONFIG_PORTFORWARD_PORTS)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_REPLICASET_NAME=$(KCL_MUTATINGWEBHOOKCONFIG_REPLICASET_NAME)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR=$(KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_NAMES=$(KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_NAMES)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR=$(KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_SELECTOR=$(KCL_MUTATINGWEBHOOKCONFIG_SELECTOR)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_SERVICE_NAME=$(KCL_MUTATINGWEBHOOKCONFIG_SERVICE_NAME)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_SERVICES_NAMES=$(KCL_MUTATINGWEBHOOKCONFIG_SERVICES_NAMES)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_SERVICES_FIELDSELECTOR=$(KCL_MUTATINGWEBHOOKCONFIG_SERVICES_FIELDSELECTOR)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_SERVICES_SELECTOR=$(KCL_MUTATINGWEBHOOKCONFIG_SERVICES_SELECTOR)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_SERVICE_TYPE=$(KCL_MUTATINGWEBHOOKCONFIG_SERVICE_TYPE)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_SERVICEACCOUNT_NAME=$(KCL_MUTATINGWEBHOOKCONFIG_SERVICEACCOUNT_NAME)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIG_SSH_SHELL=$(KCL_MUTATINGWEBHOOKCONFIG_SSH_SHELL)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIGS_FIELDSELECTOR=$(KCL_MUTATINGWEBHOOKCONFIGS_FIELDSELECTOR)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_DIRPATH=$(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_DIRPATH)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILENAME=$(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILENAME)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH=$(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_STDINFLAG=$(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_STDINFLAG)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_URL=$(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_URL)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH=$(KCL_MUTATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIGS_OUTPUT_FORMAT=$(KCL_MUTATINGWEBHOOKCONFIGS_OUTPUT_FORMAT)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIGS_SELECTOR=$(KCL_MUTATINGWEBHOOKCONFIGS_SELECTOR)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIGS_SET_NAME=$(KCL_MUTATINGWEBHOOKCONFIGS_SET_NAME)'
	@echo '    KCL_MUTATINGWEBHOOKCONFIGS_SORT_BY=$(KCL_MUTATINGWEBHOOKCONFIGS_SORT_BY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::MutatingWebhookConfiguration ($(_KUBECTL_MUTATINGWEBHOOKCONFIGURATION_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_mutatingwebhookconfig                - Annotate a mutating-webhook-config'
	@echo '    _kcl_apply_mutatingwebhookconfigs                  - Apply manifest for one-or-more mutating-webhook-configs'
	@echo '    _kcl_create_mutatingwebhookconfig                  - Create a new mutating-webhook-config'
	@echo '    _kcl_delete_mutatingwebhookconfig                  - Delete an existing mutating-webhook-config'
	@echo '    _kcl_diff_mutatingwebhookconfigs                   - Diff manifest for one-or-more mutating-webhook-configs'
	@echo '    _kcl_edit_mutatingwebhookconfig                    - Edit a mutating-webhook-config'
	@echo '    _kcl_explain_mutatingwebhookconfig                 - Explain the mutating-webhook-config object'
	@echo '    _kcl_label_mutatingwebhookconfig                   - Label a mutating-webhook-config'
	@echo '    _kcl_portforward_mutatingwebhookconfig             - Port-forward local ports to a mutating-webhook-config'
	@echo '    _kcl_show_mutatingwebhookconfig                    - Show everything related to a mutating-webhook-config'
	@echo '    _kcl_show_mutatingwebhookconfig_description        - Show the description of a mutating-webhook-config'
	@echo '    _kcl_show_mutatingwebhookconfig_object             - Show the object of a mutating-webhook-config'
	@echo '    _kcl_show_mutatingwebhookconfig_pods               - Show pods of a mutating-webhook-config'
	@echo '    _kcl_show_mutatingwebhookconfig_replicasets        - Show replicasets of a mutating-webhook-config'
	@echo '    _kcl_show_mutatingwebhookconfig_services           - Show services of a mutating-webhook-config'
	@echo '    _kcl_show_mutatingwebhookconfig_state              - Show state of a mutating-webhook-config'
	@echo '    _kcl_unapply_mutatingwebhookconfigs                - Un-apply manifest for one-or-more mutating-webhook-configs'
	@echo '    _kcl_unlabel_mutatingwebhookconfig                 - Un-label manifest for a mutating-webhook-config'
	@echo '    _kcl_update_mutatingwebhookconfig                  - Update a mutating-webhook-config'
	@echo '    _kcl_view_mutatingwebhookconfigs                   - View all mutating-webhook-configs'
	@echo '    _kcl_view_mutatingwebhookconfigs_set               - View a set of mutating-webhook-configs'
	@echo '    _kcl_watch_mutatingwebhookconfigs                  - Watching mutating-webhook-configs'
	@echo '    _kcl_watch_mutatingwebhookconfigs_set              - Watching a set of mutating-webhook-configs'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_mutatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Annotating mutating-webhook-config "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)

_kcl_apply_mutatingwebhookconfig: _kcl_apply_mutatingwebhookconfigs
_kcl_apply_mutatingwebhookconfigs:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more mutating-webhook-configs ...'; $(NORMAL)
	$(if $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH),cat $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_MUTATINGWEBHOOKCONFIGS_|)cat)
	$(if $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_URL),curl -L $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_URL))
	$(if $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH),ls -al $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_MUTATINGWEBHOOKCONFIGS_|)$(KUBECTL) apply $(__KCL_FILENAME__MUTATINGWEBHOOKCONFIGS)

_kcl_create_mutatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Creating mutating-webhook-config "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)

_kcl_delete_mutatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Deleting mutating-webhook-config "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT delete services of exposed mutatingwebhookconfigs'; $(NORMAL)
	$(KUBECTL) delete mutatingwebhookconfiguration $(KCL_MUTATINGWEBHOOKCONFIG_NAME)

_kcl_diff_mutatingwebhookconfig: _kcl_diff_mutatingwebhookconfigs
_kcl_diff_mutatingwebhookconfigs:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more mutating-webhook-configs ...'; $(NORMAL)
	# cat $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_MUTATINGWEBHOOKCONFIGS_|)cat
	# curl -L $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_URL)
	# ls -al $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_MUTATINGWEBHOOKCONFIGS_|)$(KUBECTL) diff $(__KCL_FILENAME__MUTATINGWEBHOOKCONFIGS)

_kcl_edit_mutatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Editing mutating-webhook-config "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit mutatingwebhookconfiguration $(KCL_MUTATINGWEBHOOKCONFIG_NAME)

_kcl_explain_mutatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Explaining mutating-webhook-config object ...'; $(NORMAL)
	$(KUBECTL) explain mutatingwebhookconfiguration

_kcl_label_mutatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Labeling mutating-webhook-config "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)

_kcl_show_mutatingwebhookconfig: _kcl_show_mutatingwebhookconfig_deployments _kcl_show_mutatingwebhookconfig_object _kcl_show_mutatingwebhookconfig_pods _kcl_show_mutatingwebhookconfig_replicasets _kcl_show_mutatingwebhookconfig_services _kcl_show_mutatingwebhookconfig_description

_kcl_show_mutatingwebhookconfig_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Showing deployments used by mutating-webhook-config "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(if $(KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR)$(KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR), \
		$(KUBECTL) get deployments $(__KCL_NAMESPACE__MUTATINGWEBHOOKCONFIG) \
			$(if $(KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR),--field-selector $(KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR)) \
			$(if $(KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR),--selector $(KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR)) \
	, @\
		echo 'KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR not set'; \
		echo 'KCL_MUTATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR not set'; \
	)

_kcl_show_mutatingwebhookconfig_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description mutating-webhook-config "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe mutatingwebhookconfiguration $(KCL_MUTATINGWEBHOOKCONFIG_NAME)

_kcl_show_mutatingwebhookconfig_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of mutating-webhook-config "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get mutatingwebhookconfiguration $(_X__KCL_OUTPUT__MUTATINGWEBHOOKCONFIG) --output yaml $(KCL_MUTATINGWEBHOOKCONFIG_NAME)

_kcl_show_mutatingwebhookconfig_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods spawned by mutating-webhook-config "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(if $(KCL_MUTATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR)$(KCL_MUTATINGWEBHOOKCONFIG_PODS_SELECTOR), \
		$(KUBECTL) get pods $(__KCL_NAMESPACE__MUTATINGWEBHOOKCONFIG) \
			$(if $(KCL_MUTATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR),--field-selector $(KCL_MUTATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR)) \
			$(if $(KCL_MUTATINGWEBHOOKCONFIG_PODS_SELECTOR),--selector $(KCL_MUTATINGWEBHOOKCONFIG_PODS_SELECTOR)) \
	, @\
		echo 'KCL_MUTATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR not set'; \
		echo 'KCL_MUTATINGWEBHOOKCONFIG_PODS_SELECTOR not set'; \
	)

_kcl_show_mutatingwebhookconfig_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Showing replicaset spawned by mutating-webhook-config "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(if $(KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR)$(KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR), \
		$(KUBECTL) get replicaset $(__KCL_NAMESPACE__MUTATINGWEBHOOKCONFIG) \
			$(if $(KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR),--field-selector $(KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR)) \
			$(if $(KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR),--selector $(KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR)) \
	, @\
		echo 'KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR not set' ; \
		echo 'KCL_MUTATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR not set' ; \
	)

_kcl_show_mutatingwebhookconfig_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing service used by mutatingwebhookconfig "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(if $(KCL_MUTATINGWEBHOOKCONFIG_SERVICES_FIELDSELECTOR)$(KCL_MUTATINGWEBHOOKCONFIG_SERVICES_SELECTOR), \
		$(KUBECTL) get services $(__KCL_NAMESPACE__MUTATINGWEBHOOKCONFIG) \
			$(if $(KCL_MUTATINGWEBHOOKCONFIG_SERVICES_FIELDSELECTOR),--field-selector $(KCL_MUTATINGWEBHOOKCONFIG_SERVICES_FIELDSELECTOR)) \
			$(if $(KCL_MUTATINGWEBHOOKCONFIG_SERVICES_SELECTOR),--selector $(KCL_MUTATINGWEBHOOKCONFIG_SERVICES_SELECTOR)) \
	, @\
		echo 'KCL_MUTATINGWEBHOOKCONFIG_SERVICES_FIELDSELECTOR not set' ; \
		echo 'KCL_MUTATINGWEBHOOKCONFIG_SERVICES_SELECTOR not set' ; \
	)

_kcl_unapply_mutatingwebhookconfig: _kcl_unapply_mutatingwebhookconfigs
_kcl_unapply_mutatingwebhookconfigs:
	@$(INFO) '$(KCL_UI_LABEL)Unapplying manifest for one-or-more mutating-webhook-config ...'; $(NORMAL)
	# cat $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_MUTATINGWEBHOOKCONFIGS_|)cat
	# curl -L $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFEST_URL)
	# ls -al $(KCL_MUTATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_MUTATINGWEBHOOKCONFIGS_|)$(KUBECTL) delete $(__KCL_FILENAME__MUTATINGWEBHOOKCONFIGS)

_kcl_unlabel_mutatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Removing labels from mutating-webhook-config "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_update_mutatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Updating mutating-webhook-config "$(KCL_MUTATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) patch ...

_kcl_view_mutatingwebhookconfigs:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL mutating-webhook-configs ...'; $(NORMAL)
	$(KUBECTL) get mutatingwebhookconfigurations $(__KCL_OUTPUT_MUTATINGWEBHOOKCONFIGS) $(_X__KCL_SELECTOR__MUTATINGWEBHOOKCONFIGS) $(__KCL_SORT_BY__MUTATINGWEBHOOKCONFIGS)

_kcl_view_mutatingwebhookconfigs_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing mutating-webhook-configs-set "$(KCL_MUTATINGWEBHOOKCONFIGS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Mutating-webhook-configs are grouped based on the provided selector, and ...'; $(NORMAL)
	$(KUBECTL) get mutatingwebhookconfigurations $(__KCL_OUTPUT__MUTATINGWEBHOOKCONFIGS) $(__KCL_SELECTOR__MUTATINGWEBHOOKCONFIGS)

_kcl_watch_mutatingwebhookconfigs:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL mutating-webhook-configs ...'; $(NORMAL)
	$(KUBECTL) get mutatingwebhookconfigurations --all-namespaces=true --watch 

_kcl_watch_mutatingwebhookconfigs_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching mutating-webhook-configs-set "$(KCL_MUTATINGWEBHOOKCONFIGS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Mutating-webhook-configs are grouped based on the provided selector, and ...'; $(NORMAL)
