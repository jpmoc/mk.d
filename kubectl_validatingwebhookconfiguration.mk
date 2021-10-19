_KUBECTL_VALIDATINGWEBHOOKCONFIGURATION_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR?= manifest.name=my-deployment
# KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_NAMES?= hello-4111706356-o9qcm ...
# KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR?= app=global-registration-service
# KCL_VALIDATINGWEBHOOKCONFIG_LABELS_KEYVALUES?=
# KCL_VALIDATINGWEBHOOKCONFIG_NAME?= hello
# KCL_VALIDATINGWEBHOOKCONFIG_NAMESPACE_NAME?= default
# KCL_VALIDATINGWEBHOOKCONFIG_OUTPUT_FORMAT?=
# KCL_VALIDATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR?= manifest.name=my-pod
# KCL_VALIDATINGWEBHOOKCONFIG_PODS_NAMES?= hello-4111706356-o9qcm ...
# KCL_VALIDATINGWEBHOOKCONFIG_PODS_SELECTOR?= app=global-registration-service
# KCL_VALIDATINGWEBHOOKCONFIG_REPLICAS_COUNT?= 1
# KCL_VALIDATINGWEBHOOKCONFIG_REPLICASET_NAME?= api-gateway-6f5877798
# KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR?= metadata.name=my-replica-set
# KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_NAMES?= api-gateway-6f5877798 ...
# KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR?= app=global-registration-service
# KCL_VALIDATINGWEBHOOKCONFIG_SELECTOR?= app=global-registration-service
# KCL_VALIDATINGWEBHOOKCONFIG_SERVICEACCOUNT_NAME?= default
# KCL_VALIDATINGWEBHOOKCONFIGS_CLUSTER_NAME?= my-cluster-name
# KCL_VALIDATINGWEBHOOKCONFIGS_FIELDSELECTOR?= metadata.name=my-validatingwebhookconfig
# KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_DIRPATH?= ./in/
# KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILENAME?= manifest.yaml
# KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_STDINFLAG?= false
# KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_URL?= http://...
# KCL_VALIDATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_VALIDATINGWEBHOOKCONFIGS_OUTPUT_FORMAT?= jsonpath='{.items[0].metadata.name}'
# KCL_VALIDATINGWEBHOOKCONFIGS_SELECTOR?= run=ecr-read-only--renew-token
# KCL_VALIDATINGWEBHOOKCONFIGS_SET_NAME?= my-validatingwebhookconfigs-set

# Derived parameters
KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR?= $(KCL_VALIDATINGWEBHOOKCONFIG_SELECTOR)
KCL_VALIDATINGWEBHOOKCONFIG_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_VALIDATINGWEBHOOKCONFIG_OUTPUT_FORMAT?= $(KCL_OUTPUT_FORMAT)
KCL_VALIDATINGWEBHOOKCONFIG_PODS_SELECTOR?= $(KCL_VALIDATINGWEBHOOKCONFIG_SELECTOR)
KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR?= $(KCL_VALIDATINGWEBHOOKCONFIG_SELECTOR)
KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_SELECTOR?= $(KCL_VALIDATINGWEBHOOKCONFIG_SELECTOR)
KCL_VALIDATINGWEBHOOKCONFIG_SERVICE_NAME?= $(KCL_VALIDATINGWEBHOOKCONFIG_NAME)
KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH?= $(if $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILENAME),$(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_DIRPATH)$(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILENAME))
KCL_VALIDATINGWEBHOOKCONFIGS_SET_NAME?= validating-webhook-config@@$(KCL_VALIDATINGWEBHOOKCONFIGS_SELECTOR)@

# Option parameters
__KCL_FILENAME__VALIDATINGWEBHOOKCONFIGS+= $(if $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH),--filename $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH))
__KCL_FILENAME__VALIDATINGWEBHOOKCONFIGS+= $(if $(filter true,$(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__VALIDATINGWEBHOOKCONFIGS+= $(if $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_URL),--filename $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_URL))
__KCL_FILENAME__VALIDATINGWEBHOOKCONFIGS+= $(if $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH),--filename $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH))
__KCL_LABELS__VALIDATINGWEBHOOKCONFIG= $(if $(KCL_VALIDATINGWEBHOOKCONFIG_LABELS_KEYVALUES),--labels $(KCL_VALIDATINGWEBHOOKCONFIG_LABELS_KEYVALUES))
__KCL_NAME__VALIDATINGWEBHOOKCONFIG= $(if $(KCL_VALIDATINGWEBHOOKCONFIG_SERVICE_NAME),--name $(KCL_VALIDATINGWEBHOOKCONFIG_SERVICE_NAME))
__KCL_NAMESPACE__VALIDATINGWEBHOOKCONFIG= $(if $(KCL_VALIDATINGWEBHOOKCONFIG_NAMESPACE_NAME),--namespace $(KCL_VALIDATINGWEBHOOKCONFIG_NAMESPACE_NAME))
__KCL_OUTPUT__VALIDATINGWEBHOOKCONFIG= $(if $(KCL_VALIDATINGWEBHOOKCONFIG_OUTPUT_FORMAT),--output $(KCL_VALIDATINGWEBHOOKCONFIG_OUTPUT_FORMAT))
__KCL_OUTPUT__VALIDATINGWEBHOOKCONFIGS= $(if $(KCL_VALIDATINGWEBHOOKCONFIGS_OUTPUT_FORMAT),--output $(KCL_VALIDATINGWEBHOOKCONFIGS_OUTPUT_FORMAT))
__KCL_SELECTOR__VALIDATINGWEBHOOKCONFIGS= $(if $(KCL_VALIDATINGWEBHOOKCONFIGS_SELECTOR),--selector=$(KCL_VALIDATINGWEBHOOKCONFIGS_SELECTOR))

# UI parameters
_KCL_APPLY_VALIDATINGWEBHOOKCONFIGS_|?= #
_KCL_DIFF_VALIDATINGWEBHOOKCONFIGS_|?= $(_KCL_APPLY_VALIDATINGWEBHOOKCONFIGS_|)
_KCL_UNAPPLY_VALIDATINGWEBHOOKCONFIGS_|?= $(_KCL_APPLY_VALIDATINGWEBHOOKCONFIGS_|)

#--- MACROS
_kcl_get_validatingwebhookconfig_deployments_names= $(call _kcl_get_validatingwebhookconfig_deployments_names_S, $(KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR))
_kcl_get_validatingwebhookconfig_dpeloyments_names_S= $(call _kcl_get_validatingwebhookconfig_deployments_names_SN, $(1), $(KCL_VALIDATINGWEBHOOKCONFIG_NAMESPACE_NAME))
_kcl_get_validatingwebhookconfig_deployments_names_SN= $(shell $(KUBECTL) get deployments --namespace $(2) --selector=$(strip $(1)) --output=jsonpath="{.items..metadata.name}")

_kcl_get_validatingwebhookconfig_pods_names= $(call _kcl_get_validatingwebhookconfig_pods_names_S, $(KCL_VALIDATINGWEBHOOKCONFIG_PODS_SELECTOR))
_kcl_get_validatingwebhookconfig_pods_names_S= $(call _kcl_get_validatingwebhookconfig_pods_names_SN, $(1), $(KCL_VALIDATINGWEBHOOKCONFIG_NAMESPACE_NAME))
_kcl_get_validatingwebhookconfig_pods_names_SN= $(shell $(KUBECTL) get pods --namespace $(2) --selector=$(strip $(1)) --output=jsonpath="{.items..metadata.name}")

_kcl_get_validatingwebhookconfig_replicasets_names= $(call _kcl_get_validatingwebhookconfig_replicasets_names_S, $(KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR))
_kcl_get_validatingwebhookconfig_replicasets_names_S= $(call _kcl_get_validatingwebhookconfig_replicasets_names_SN, $(1), $(KCL_VALIDATINGWEBHOOKCONFIG_NAMESPACE_NAME))
_kcl_get_validatingwebhookconfig_replicasets_names_SN= $(shell $(KUBECTL) get replicasets --namespace $(2) --selector $(1) --output=jsonpath="{.items..metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::MutatingWebhookConfiguration ($(_KUBECTL_VALIDATINGWEBHOOKCONFIGURATION_MK_VERSION)) macros:'
	@echo '    _kcl_get_validatingwebhookconfig_deployments_names_{|S|SN}      - Get the name of deployments used by a validatingwebhookconfig (Selector,Namespace)'
	@echo '    _kcl_get_validatingwebhookconfig_pods_names_{|S|SN}             - Get the name of pods used by a validatingwebhookconfig (Selector,Namespace)'
	@echo '    _kcl_get_validatingwebhookconfig_replicasets_name_{|S|SN}       - Get the name of the replica-sets used by a validatingwebhookconfig (Selector,Namespace)'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::MutatingWebhookConfiguration ($(_KUBECTL_VALIDATINGWEBHOOKCONFIGURATION_MK_VERSION)) parameters:'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_NAMES=$(KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_NAMES)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR=$(KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR=$(KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_LABELS_KEYS=$(KCL_VALIDATINGWEBHOOKCONFIG_LABELS_KEYS)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_LABELS_KEYVALUES=$(KCL_VALIDATINGWEBHOOKCONFIG_LABELS_KEYVALUES)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_NAME=$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_NAMESPACE_NAME=$(KCL_VALIDATINGWEBHOOKCONFIG_NAMESPACE_NAME)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_OUTPUT_FORMAT=$(KCL_VALIDATINGWEBHOOKCONFIG_OUTPUT_FORMAT)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_POD_NAME=$(KCL_VALIDATINGWEBHOOKCONFIG_POD_NAME)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_PODS_NAMES=$(KCL_VALIDATINGWEBHOOKCONFIG_PODS_NAMES)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR=$(KCL_VALIDATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_PODS_SELECTOR=$(KCL_VALIDATINGWEBHOOKCONFIG_PODS_SELECTOR)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_PORT=$(KCL_VALIDATINGWEBHOOKCONFIG_PORT)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_PORTFORWARD_PORTS=$(KCL_VALIDATINGWEBHOOKCONFIG_PORTFORWARD_PORTS)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_REPLICASET_NAME=$(KCL_VALIDATINGWEBHOOKCONFIG_REPLICASET_NAME)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR=$(KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_NAMES=$(KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_NAMES)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR=$(KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_SELECTOR=$(KCL_VALIDATINGWEBHOOKCONFIG_SELECTOR)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_SERVICE_NAME=$(KCL_VALIDATINGWEBHOOKCONFIG_SERVICE_NAME)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_NAMES=$(KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_NAMES)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_FIELDSELECTOR=$(KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_FIELDSELECTOR)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_SELECTOR=$(KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_SELECTOR)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_SERVICE_TYPE=$(KCL_VALIDATINGWEBHOOKCONFIG_SERVICE_TYPE)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_SERVICEACCOUNT_NAME=$(KCL_VALIDATINGWEBHOOKCONFIG_SERVICEACCOUNT_NAME)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIG_SSH_SHELL=$(KCL_VALIDATINGWEBHOOKCONFIG_SSH_SHELL)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIGS_FIELDSELECTOR=$(KCL_VALIDATINGWEBHOOKCONFIGS_FIELDSELECTOR)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_DIRPATH=$(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_DIRPATH)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILENAME=$(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILENAME)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH=$(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_STDINFLAG=$(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_STDINFLAG)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_URL=$(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_URL)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH=$(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIGS_OUTPUT_FORMAT=$(KCL_VALIDATINGWEBHOOKCONFIGS_OUTPUT_FORMAT)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIGS_SELECTOR=$(KCL_VALIDATINGWEBHOOKCONFIGS_SELECTOR)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIGS_SET_NAME=$(KCL_VALIDATINGWEBHOOKCONFIGS_SET_NAME)'
	@echo '    KCL_VALIDATINGWEBHOOKCONFIGS_SORT_BY=$(KCL_VALIDATINGWEBHOOKCONFIGS_SORT_BY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::MutatingWebhookConfiguration ($(_KUBECTL_VALIDATINGWEBHOOKCONFIGURATION_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_validatingwebhookconfig                - Annotate a validating-webhook-config'
	@echo '    _kcl_apply_validatingwebhookconfigs                  - Apply manifest for one-or-more validating-webhook-configs'
	@echo '    _kcl_create_validatingwebhookconfig                  - Create a new validating-webhook-config'
	@echo '    _kcl_delete_validatingwebhookconfig                  - Delete an existing validating-webhook-config'
	@echo '    _kcl_diff_validatingwebhookconfigs                   - Diff manifest for one-or-more validating-webhook-configs'
	@echo '    _kcl_edit_validatingwebhookconfig                    - Edit a validating-webhook-config'
	@echo '    _kcl_explain_validatingwebhookconfig                 - Explain the validating-webhook-config object'
	@echo '    _kcl_label_validatingwebhookconfig                   - Label a validating-webhook-config'
	@echo '    _kcl_portforward_validatingwebhookconfig             - Port-forward local ports to a validating-webhook-config'
	@echo '    _kcl_show_validatingwebhookconfig                    - Show everything related to a validating-webhook-config'
	@echo '    _kcl_show_validatingwebhookconfig_description        - Show the description of a validating-webhook-config'
	@echo '    _kcl_show_validatingwebhookconfig_object             - Show the object of a validating-webhook-config'
	@echo '    _kcl_show_validatingwebhookconfig_pods               - Show pods of a validating-webhook-config'
	@echo '    _kcl_show_validatingwebhookconfig_replicasets        - Show replicasets of a validating-webhook-config'
	@echo '    _kcl_show_validatingwebhookconfig_services           - Show services of a validating-webhook-config'
	@echo '    _kcl_show_validatingwebhookconfig_state              - Show state of a validating-webhook-config'
	@echo '    _kcl_unapply_validatingwebhookconfigs                - Un-apply manifest for one-or-more validating-webhook-configs'
	@echo '    _kcl_unlabel_validatingwebhookconfig                 - Un-label manifest for a validating-webhook-config'
	@echo '    _kcl_update_validatingwebhookconfig                  - Update a validating-webhook-config'
	@echo '    _kcl_view_validatingwebhookconfigs                   - View all validating-webhook-configs'
	@echo '    _kcl_view_validatingwebhookconfigs_set               - View a set of validating-webhook-configs'
	@echo '    _kcl_watch_validatingwebhookconfigs                  - Watching validating-webhook-configs'
	@echo '    _kcl_watch_validatingwebhookconfigs_set              - Watching a set of validating-webhook-configs'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_validatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Annotating validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate ...

_kcl_apply_validatingwebhookconfig: _kcl_apply_validatingwebhookconfigs
_kcl_apply_validatingwebhookconfigs: 
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more validating-webhook-configs ...'; $(NORMAL)
	$(if $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH),cat $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_VALIDATINGWEBHOOKCONFIGS_|)cat)
	$(if $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_URL),curl -L $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_URL))
	$(if $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH),ls -al $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_VALIDATINGWEBHOOKCONFIGS_|)$(KUBECTL) apply $(__KCL_FILENAME__VALIDATINGWEBHOOKCONFIGS)

_kcl_create_validatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Creating validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)

_kcl_delete_validatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Deleting validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT delete services of exposed validatingwebhookconfigs'; $(NORMAL)
	$(KUBECTL) delete validatingwebhookconfiguration $(KCL_VALIDATINGWEBHOOKCONFIG_NAME)

_kcl_diff_validatingwebhookconfig: _kcl_diff_validatingwebhookconfigs
_kcl_diff_validatingwebhookconfigs: 
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more validating-webhook-configs ...'; $(NORMAL)
	# cat $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_VALIDATINGWEBHOOKCONFIGS_|)cat
	# curl -L $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_URL)
	# ls -al $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_VALIDATINGWEBHOOKCONFIGS_|)$(KUBECTL) diff $(__KCL_FILENAME__VALIDATINGWEBHOOKCONFIGS)

_kcl_edit_validatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Editing validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit validatingwebhookconfiguration $(KCL_VALIDATINGWEBHOOKCONFIG_NAME)

_kcl_explain_validatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Explaining validating-webhook-config object ...'; $(NORMAL)
	$(KUBECTL) explain validatingwebhookconfiguration

_kcl_label_validatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Labeling validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_show_validatingwebhookconfig: _kcl_show_validatingwebhookconfig_deployments _kcl_show_validatingwebhookconfig_object _kcl_show_validatingwebhookconfig_pods _kcl_show_validatingwebhookconfig_replicasets _kcl_show_validatingwebhookconfig_services _kcl_show_validatingwebhookconfig_description

_kcl_show_validatingwebhookconfig_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Showing deployments used by validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(if $(KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR)$(KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR), \
		$(KUBECTL) get deployments $(__KCL_NAMESPACE__VALIDATINGWEBHOOKCONFIG) \
			$(if $(KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR),--field-selector $(KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR)) \
			$(if $(KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR),--selector $(KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR)) \
	, @\
		echo 'KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_FIELDSELECTOR not set'; \
		echo 'KCL_VALIDATINGWEBHOOKCONFIG_DEPLOYMENTS_SELECTOR not set'; \
	)

_kcl_show_validatingwebhookconfig_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe validatingwebhookconfiguration $(KCL_VALIDATINGWEBHOOKCONFIG_NAME)

_kcl_show_validatingwebhookconfig_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get validatingwebhookconfiguration $(_X__KCL_OUTPUT__VALIDATINGWEBHOOKCONFIG) --output yaml $(KCL_VALIDATINGWEBHOOKCONFIG_NAME)

_kcl_show_validatingwebhookconfig_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods spawned by validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(if $(KCL_VALIDATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR)$(KCL_VALIDATINGWEBHOOKCONFIG_PODS_SELECTOR), \
		$(KUBECTL) get pods $(__KCL_NAMESPACE__VALIDATINGWEBHOOKCONFIG) \
			$(if $(KCL_VALIDATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR),--field-selector $(KCL_VALIDATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR)) \
			$(if $(KCL_VALIDATINGWEBHOOKCONFIG_PODS_SELECTOR),--selector $(KCL_VALIDATINGWEBHOOKCONFIG_PODS_SELECTOR)) \
	, @\
		echo 'KCL_VALIDATINGWEBHOOKCONFIG_PODS_FIELDSELECTOR not set'; \
		echo 'KCL_VALIDATINGWEBHOOKCONFIG_PODS_SELECTOR not set'; \
	)

_kcl_show_validatingwebhookconfig_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Showing replicaset spawned by validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(if $(KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR)$(KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR), \
		$(KUBECTL) get replicaset $(__KCL_NAMESPACE__VALIDATINGWEBHOOKCONFIG) \
			$(if $(KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR),--field-selector $(KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR)) \
			$(if $(KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR),--selector $(KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR)) \
	, @\
		echo 'KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_FIELDSELECTOR not set' ; \
		echo 'KCL_VALIDATINGWEBHOOKCONFIG_REPLICASETS_SELECTOR not set' ; \
	)

_kcl_show_validatingwebhookconfig_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing service used by validatingwebhookconfig "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	$(if $(KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_FIELDSELECTOR)$(KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_SELECTOR), \
		$(KUBECTL) get services $(__KCL_NAMESPACE__VALIDATINGWEBHOOKCONFIG) \
			$(if $(KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_FIELDSELECTOR),--field-selector $(KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_FIELDSELECTOR)) \
			$(if $(KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_SELECTOR),--selector $(KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_SELECTOR)) \
	, @\
		echo 'KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_FIELDSELECTOR not set' ; \
		echo 'KCL_VALIDATINGWEBHOOKCONFIG_SERVICES_SELECTOR not set' ; \
	)

_kcl_unapply_validatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Unapplying manifest for validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	# cat $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_VALIDATINGWEBHOOKCONFIGS_|)cat
	# curl -L $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFEST_URL)
	# ls -al $(KCL_VALIDATINGWEBHOOKCONFIGS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_VALIDATINGWEBHOOKCONFIGS_|)$(KUBECTL) delete $(__KCL_FILENAME__VALIDATINGWEBHOOKCONFIG)

_kcl_unlabel_validatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Removing labels from validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) label ...

_kcl_update_validatingwebhookconfig:
	@$(INFO) '$(KCL_UI_LABEL)Updating validating-webhook-config "$(KCL_VALIDATINGWEBHOOKCONFIG_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) patch ...

_kcl_view_validatingwebhookconfigs:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL validating-webhook-configs ...'; $(NORMAL)
	$(KUBECTL) get validatingwebhookconfigurations $(__KCL_OUTPUT_VALIDATINGWEBHOOKCONFIGS) $(_X__KCL_SELECTOR__VALIDATINGWEBHOOKCONFIGS) $(__KCL_SORT_BY__VALIDATINGWEBHOOKCONFIGS)

_kcl_view_validatingwebhookconfigs_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing validating-webhook-configs-set "$(KCL_VALIDATINGWEBHOOKCONFIGS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Mutating-webhook-configs are grouped based on the provided filed-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get validatingwebhookconfigurations $(__KCL_OUTPUT__VALIDATINGWEBHOOKCONFIGS) $(__KCL_SELECTOR__VALIDATINGWEBHOOKCONFIGS)

_kcl_watch_validatingwebhookconfigs:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL validating-webhook-configs ...'; $(NORMAL)
	$(KUBECTL) get validatingwebhookconfigurations --watch 

_kcl_watch_validatingwebhookconfigs_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching validating-webhook-configs-set "$(KCL_VALIVALIDINGWEBHOOKCONFIGS_SET_NAME)" ...'; $(NORMAL)
