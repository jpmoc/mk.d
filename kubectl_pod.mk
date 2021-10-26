_KUBECTL_POD_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_POD_ANNOTATIONS_KEYVALUES?= icon-url=http://goo.gl/XXBTWq ...
# KCL_POD_COMMAND_ARGS?= -- <cmd> <arg1> ... <argN>
KCL_POD_COMMAND_FLAG?= false
# KCL_POD_CONTAINER_IMAGE?= nginx
# KCL_POD_CONTAINER_NAME?= istio-proxy
# KCL_POD_CONTAINER_PORT?= 80
# KCL_POD_CONTAINERS_NAMES?= container1 ...
# KCL_POD_DNS?=
# KCL_POD_DNS_HOSTNAME?=
# KCL_POD_DNS_SUBDOMAIN?=
# KCL_POD_EXEC_COMMAND?= ls /
KCL_POD_GENERATOR_NAME?= run-pod/v1
# KCL_POD_LABELS_KEYS?= new-label ...
# KCL_POD_LABELS_KEYVALUES?= new-label=awesome ...
# KCL_POD_LOCALFILE_DIRPATH?= ./in/
# KCL_POD_LOCALFILE_FILENAME?= script.sh
# KCL_POD_LOCALFILE_FILEPATH?= ./in/script.sh
# KCL_POD_NAME?= hello
# KCL_POD_NAMESPACE_NAME?= default
# KCL_POD_PATCH?= "$(cat ./in/patch.yaml)"
# KCL_POD_PATCH_DIRPATH?= ./in/
# KCL_POD_PATCH_FILENAME?= patch.yaml
# KCL_POD_PATCH_FILEPATH?= ./in/patch.yaml
# KCL_POD_PORTFORWARD_ADDRESS?= localhost,10.19.21.23
# KCL_POD_PORTFORWARD_PORTMAPPINGS?= 8443:8443 local-port:target-port ...
# KCL_POD_PORTFORWARD_TIMEOUT?= 1m0s
KCL_POD_PRESERVE_FLAG?=true
KCL_POD_PREVIOUS?= false
KCL_POD_REMOTEFILE_DIRPATH?= ./
# KCL_POD_REMOTEFILE_FILENAME?= script.sh
# KCL_POD_REMOTEFILE_FILEPATH?= ~/script.sh
KCL_POD_RESTARTPOLICY_ENUM?= Never
# KCL_POD_SERVICE_NAME?=
KCL_POD_SERVICEACCOUNT_NAME?= default
KCL_POD_SNIFF_COMMAND?= sudo tcpdump -i any -U -w -
# KCL_POD_SNIFF_FILTER?= '(host 8.8.8.8 and port 80)'
KCL_POD_SSH_SHELL?= /bin/sh
KCL_POD_TAILFOLLOW_FLAG?= false
# KCL_PODS_CONTAINER_NAME?= istio-proxy
# KCL_PODS_FIELDSELECTOR?=
KCL_PODS_LABELS_FLAG?= false
# KCL_PODS_MANIFEST_DIRPATH?= ./in/
# KCL_PODS_MANIFEST_FILENAME?= pod.yaml
# KCL_PODS_MANIFEST_FILEPATH?= ./in/pod.yaml
KCL_PODS_MANIFEST_STDINFLAG?= false
# KCL_PODS_MANIFEST_URL?= http://...
# KCL_PODS_MANIFESTS_DIRPATH?= ./in/
# KCL_PODS_NAMES?= 
# KCL_PODS_NAMESPACE_NAME?= default
# KCL_PODS_OUTPUT_FORMAT?= wide
# KCL_PODS_SELECTOR?=
# KCL_PODS_SET_NAME?= my-pods-set
KCL_PODS_TAILFOLLOW_FLAG?= false
# KCL_PODS_WATCH_ONLY?= true

# Derived parameters
KCL_POD_FOLLOW_LOGS?= $(KCL_INTERACTIVE_MODE)
KCL_POD_DNS_CNAME?= $(KCL_POD_DNS_HOSTNAME).$(KCL_POD_DNS_SUBDOMAIN).$(KCL_POD_NAMESPACE_NAME).svc.cluster.local
KCL_POD_DNS_HOSTNAME?= $(KCL_POD_NAME)
KCL_POD_DNS_SUBDOMAIN?= $(KCL_POD_SERVICE_NAME)
KCL_POD_LOCALFILE_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_POD_LOCALFILE_FILEPATH?= $(KCL_POD_LOCALFILE_DIRPATH)$(KCL_POD_LOCALFILE_FILENAME)
KCL_POD_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_POD_PATCH?= $(if $(KCL_POD_PATCH_FILEPATH),"$$(cat $(KCL_POD_PATCH_FILEPATH))")
KCL_POD_PATCH_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_POD_PATCH_FILEPATH?= $(if $(KCL_POD_PATCH_FILENAME),$(KCL_POD_PATCH_DIRPATH)$(KCL_POD_PATCH_FILENAME))
# KCL_POD_REMOTEFILE_DIRPATH?= $(KCL_INPUTS_DIRPATH)# May not exist!
KCL_POD_REMOTEFILE_FILENAME?= $(KCL_POD_LOCALFILE_FILENAME)
KCL_POD_REMOTEFILE_FILEPATH?= $(KCL_POD_REMOTEFILE_DIRPATH)$(KCL_POD_REMOTEFILE_FILENAME)
KCL_POD_SERVICE_NAME?= $(KCL_SERVICE_NAME)
KCL_PODS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_PODS_MANIFEST_FILEPATH?= $(KCL_PODS_MANIFEST_DIRPATH)$(KCL_PODS_MANIFEST_FILENAME)
KCL_PODS_NAMESPACE_NAME?= $(KCL_POD_NAMESPACE_NAME)
KCL_PODS_OUTPUT_FORMAT?= $(KCL_OUTPUT_FORMAT)
KCL_PODS_SET_NAME?= pods@$(KCL_PODS_FIELDSELECTOR)@$(KCL_PODS_SELECTOR)@$(KCL_PODS_NAMESPACE_NAME)
KCL_PODS_WATCH_ONLY?= $(KCL_WATCH_ONLY)

# Option parameters
__KCL_ALL_NAMESPACES=
__KCL_ADDRESS__POD= $(if $(KCL_POD_PORTFORWARD_ADDRESS),--address $(KCL_POD_PORTFORWARD_ADDRESS))
__KCL_COMMAND__POD= $(if $(filter true,$(KCL_POD_COMMAND_FLAG)),--command)
__KCL_CONTAINER__POD= $(if $(KCL_POD_CONTAINER_NAME),--container $(KCL_POD_CONTAINER_NAME))
__KCL_CONTAINER__PODS= $(if $(KCL_PODS_CONTAINER_NAME),--container $(KCL_PODS_CONTAINER_NAME))
__KCL_FIELD_SELECTOR__PODS= $(if $(KCL_PODS_FIELDSELECTOR),--field-selector $(KCL_PODS_FIELDSELECTOR))
__KCL_FILENAME__PODS+= $(if $(KCL_PODS_MANIFEST_FILEPATH),--filename $(KCL_PODS_MANIFEST_FILEPATH))
__KCL_FILENAME__PODS+= $(if $(filter true,$(KCL_PODS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__PODS+= $(if $(KCL_PODS_MANIFEST_URL),--filename $(KCL_PODS_MANIFEST_URL))
__KCL_FILENAME__PODS+= $(if $(KCL_PODS_MANIFESTS_DIRPATH),--filename $(KCL_PODS_MANIFESTS_DIRPATH))
__KCL_FOLLOW__POD= $(if $(KCL_POD_TAILFOLLOW_FLAG),--follow=$(KCL_POD_TAILFOLLOW_FLAG))
__KCL_FOLLOW__PODS= $(if $(KCL_PODS_TAILFOLLOW_FLAG),--follow=$(KCL_PODS_TAILFOLLOW_FLAG))
__KCL_GENERATOR__POD= $(if $(KCL_POD_GENERATOR_NAME),--generator=$(KCL_POD_GENERATOR_NAME))
__KCL_IMAGE__POD= $(if $(KCL_POD_CONTAINER_IMAGE),--image=$(KCL_POD_CONTAINER_IMAGE))
__KCL_LABELS__POD= $(if $(KCL_POD_LABELS_KEYVALUES),--labels="$(subst $(SPACE),$(COMMA),$(KCL_POD_LABELS_KEYVALUES))")
__KCL_NAMESPACE__POD= $(if $(KCL_POD_NAMESPACE_NAME),--namespace $(KCL_POD_NAMESPACE_NAME))
__KCL_NAMESPACE__PODS= $(if $(KCL_PODS_NAMESPACE_NAME),--namespace $(KCL_PODS_NAMESPACE_NAME))
__KCL_NO_PRESERVE= $(if $(filter true,$(KCL_POD_PRESERVE_FLAG)),--no-preserve=false,--no-preserve=true)
__KCL_OUTPUT__PODS= $(if $(KCL_PODS_OUTPUT_FORMAT),--output $(KCL_PODS_OUTPUT_FORMAT))
__KCL_PATCH__POD= $(if $(KCL_POD_PATCH),--patch $(KCL_POD_PATCH))
__KCL_PORT__POD= $(if $(KCL_POD_CONTAINER_PORT),--port $(KCL_POD_CONTAINER_PORT))
__KCL_PREVIOUS__PODS= $(if $(filter true,$(KCL_POD_PREVIOUS)),--previous)
__KCL_POD_RUNNING_TIMEOUT= $(if $(KCL_POD_PORTFORWARD_TIMEOUT),--pod-running-timeout=$(KCL_POD_PORTFORWARD_TIMEOUT))
__KCL_RESTART__POD= $(if $(KCL_POD_RESTARTPOLICY_ENUM),--restart=$(KCL_POD_RESTARTPOLICY_ENUM))
__KCL_RM__POD=
__KCL_SELECTOR__PODS= $(if $(KCL_PODS_SELECTOR),--selector=$(KCL_PODS_SELECTOR))
__KCL_SERVICEACCOUNT__POD= $(if $(KCL_POD_SERVICEACCOUNT_NAME),--serviceaccount=$(KCL_POD_SERVICEACCOUNT_NAME))
__KCL_SHOW_LABELS__PODS= $(if $(filter true,$(KCL_PODS_LABELS_FLAG)),--show-labels)
__KCL_STDIN__POD=
__KCL_TTY__POD=
__KCL_WATCH__PODS=
__KCL_WATCH_ONLY__PODS= $(if $(KCL_PODS_WATCH_ONLY),--watch-only=$(KCL_PODS_WATCH_ONLY))

# UI parameters
# Pipe parameters
_KCL_APPLY_PODS_|?= #
_KCL_DIFF_PODS_|?= $(_KCL_APPLY_PODS_|)
_KCL_PORTFORWARD_POD_|?= while true; do #
_KCL_TAIL_POD_|?= $(_KCL_TAIL_PODS_|) 
_KCL_TAIL_PODS_|?= 
_KCL_UNAPPLY_PODS_|?= $(_KCL_APPLY_PODS_|)
|_KCL_EXEC_POD?=
|_KCL_PORTFORWARD_POD?= || sleep 10; date; done
|_KCL_SHOW_POD_CURRENTLOGS?= | tail -20
|_KCL_SHOW_POD_PREVIOUSLOGS?= $(|_KCL_SHOW_POD_CURRENTLOGS)
|_KCL_SNIFF_POD?= | wireshark -k -i -
|_KCL_TAIL_POD?= $(|_KCL_TAIL_PODS)
|_KCL_TAIL_PODS?= 

#--- MACROS
_kcl_get_pod_containers_names= $(call _kcl_get_pod_containers_names_I,$(KCL_POD_NAME))
_kcl_get_pod_containers_names_I= $(call _kcl_get_pod_containers_names_IN, $(1), $(KCL_POD_NAMESPACE_NAME))
_kcl_get_pod_containers_names_IN= $(shell $(KUBECTL) get pod --all-namespaces=false  --namespace $(2) --output jsonpath='{.spec.containers[*].name}' $(1))

_kcl_get_pods_names= $(call _kcl_get_pods_names_S, $(KCL_PODS_SELECTOR))
_kcl_get_pods_names_S= $(call _kcl_get_pods_names_SN, $(1), $(KCL_PODS_NAMESPACE_NAME))
_kcl_get_pods_names_SN= $(shell $(KUBECTL) get pod --namespace $(2) --selector $(1) --output jsonpath="{.items[*].metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Pod ($(_KUBECTL_POD_MK_VERSION)) macros:'
	@echo '    _kcl_get_pod_containers_names_{|I|IN}  - Get container names in a pod (Id,Namespace)'
	@echo '    _kcl_get_pods_names_{|S|SN}            - Get names of pods (Selector,Namespace)'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Pod ($(_KUBECTL_POD_MK_VERSION)) parameters:'
	@echo '    KCL_POD_ANNOTATIONS_KEYVALUES=$(KCL_POD_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_POD_COMMAND_ARGS=$(KCL_POD_COMMAND_ARGS)'
	@echo '    KCL_POD_COMMAND_FLAG=$(KCL_POD_COMMAND_FLAG)'
	@echo '    KCL_POD_CONTAINER_IMAGE=$(KCL_POD_CONTAINER_IMAGE)'
	@echo '    KCL_POD_CONTAINER_NAME=$(KCL_POD_CONTAINER_NAME)'
	@echo '    KCL_POD_CONTAINER_PORT=$(KCL_POD_CONTAINER_PORT)'
	@echo '    KCL_POD_CONTAINERS_NAMES=$(KCL_POD_CONTAINERS_NAMES)'
	@echo '    KCL_POD_DNS_CNAME=$(KCL_POD_DNS_CNAME)'
	@echo '    KCL_POD_DNS_HOSTNAME=$(KCL_POD_DNS_HOSTNAME)'
	@echo '    KCL_POD_DNS_SUBDOMAIN=$(KCL_POD_DNS_SUBDOMAIN)'
	@echo '    KCL_POD_EXEC_COMMAND=$(KCL_POD_EXEC_COMMAND)'
	@echo '    KCL_POD_GENERATOR_NAME=$(KCL_POD_GENERATOR_NAME)'
	@echo '    KCL_POD_LABELS_KEYVALUES=$(KCL_POD_LABELS_KEYVALUES)'
	@echo '    KCL_POD_LOCALFILE_DIRPATH=$(KCL_POD_LOCALFILE_DIRPATH)'
	@echo '    KCL_POD_LOCALFILE_FILENAME=$(KCL_POD_LOCALFILE_FILENAME)'
	@echo '    KCL_POD_LOCALFILE_FILEPATH=$(KCL_POD_LOCALFILE_FILEPATH)'
	@echo '    KCL_POD_NAME=$(KCL_POD_NAME)'
	@echo '    KCL_POD_NAMESPACE_NAME=$(KCL_POD_NAMESPACE_NAME)'
	@echo '    KCL_POD_PATCH=$(KCL_POD_PATCH)'
	@echo '    KCL_POD_PATCH_DIRPATH=$(KCL_POD_PATCH_DIRPATH)'
	@echo '    KCL_POD_PATCH_FILENAME=$(KCL_POD_PATCH_FILENAME)'
	@echo '    KCL_POD_PATCH_FILEPATH=$(KCL_POD_PATCH_FILEPATH)'
	@echo '    KCL_POD_PORTFORWARD_ADDRESS=$(KCL_POD_PORTFORWARD_ADDRESS)'
	@echo '    KCL_POD_PORTFORWARD_PORTMAPPINGS=$(KCL_POD_PORTFORWARD_PORTMAPPINGS)'
	@echo '    KCL_POD_PORTFORWARD_TIMEOUT=$(KCL_POD_PORTFORWARD_TIMEOUT)'
	@echo '    KCL_POD_PRESERVE_FLAG=$(KCL_POD_PRESERVE_FLAG)'
	@echo '    KCL_POD_PREVIOUS=$(KCL_POD_PREVIOUS)'
	@echo '    KCL_POD_REMOTEFILE_DIRPATH=$(KCL_POD_REMOTEFILE_DIRPATH)'
	@echo '    KCL_POD_REMOTEFILE_FILENAME=$(KCL_POD_REMOTEFILE_FILENAME)'
	@echo '    KCL_POD_REMOTEFILE_FILEPATH=$(KCL_POD_REMOTEFILE_FILEPATH)'
	@echo '    KCL_POD_RESTARTPOLICY_ENUM=$(KCL_POD_RESTARTPOLICY_ENUM)'
	@echo '    KCL_POD_SERVICE_NAME=$(KCL_POD_SERVICE_NAME)'
	@echo '    KCL_POD_SERVICEACCOUNT_NAME=$(KCL_POD_SERVICEACCOUNT_NAME)'
	@echo '    KCL_POD_SNIFF_COMMAND=$(KCL_POD_SNIFF_COMMAND)'
	@echo '    KCL_POD_SNIFF_FILTER=$(KCL_POD_SNIFF_FILTER)'
	@echo '    KCL_POD_SSH_SHELL=$(KCL_POD_SSH_SHELL)'
	@echo '    KCL_POD_TAILFOLLOW_FLAG=$(KCL_POD_TAILFOLLOW_FLAG)'
	@echo '    KCL_PODS_CONTAINER_NAME=$(KCL_PODS_CONTAINER_NAME)'
	@echo '    KCL_PODS_FIELDSELECTOR=$(KCL_PODS_FIELDSELECTOR)'
	@echo '    KCL_PODS_MANIFEST_DIRPATH=$(KCL_PODS_MANIFEST_DIRPATH)'
	@echo '    KCL_PODS_MANIFEST_FILENAME=$(KCL_PODS_MANIFEST_FILENAME)'
	@echo '    KCL_PODS_MANIFEST_FILEPATH=$(KCL_PODS_MANIFEST_FILEPATH)'
	@echo '    KCL_PODS_MANIFEST_STDINFLAG=$(KCL_PODS_MANIFEST_STDINFLAG)'
	@echo '    KCL_PODS_MANIFEST_URL=$(KCL_PODS_MANIFEST_URL)'
	@echo '    KCL_PODS_MANIFESTS_DIRPATH=$(KCL_PODS_MANIFESTS_DIRPATH)'
	@echo '    KCL_PODS_NAMES=$(KCL_PODS_NAMES)'
	@echo '    KCL_PODS_NAMESPACE_NAME=$(KCL_PODS_NAMESPACE_NAME)'
	@echo '    KCL_PODS_LABELS_FLAG=$(KCL_PODS_LABELS_FLAG)'
	@echo '    KCL_PODS_OUTPUT_FORMAT=$(KCL_PODS_OUTPUT_FORMAT)'
	@echo '    KCL_PODS_SELECTOR=$(KCL_PODS_SELECTOR)'
	@echo '    KCL_PODS_SET_NAME=$(KCL_PODS_SET_NAME)'
	@echo '    KCL_PODS_TAILFOLLOW_FLAG=$(KCL_POD_TAILFOLLOW_FLAG)'
	@echo '    KCL_PODS_WATCH_ONLY=$(KCL_PODS_WATCH_ONLY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Pod ($(_KUBECTL_POD_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_pod                     - Annotate a pod'
	@echo '    _kcl_apply_pods                       - Apply a manifest for one-or-more pods'
	@echo '    _kcl_attach_pod                       - Attach to a pod'
	@echo '    _kcl_copyfrom_pod                     - Copy a file from a new pod'
	@echo '    _kcl_copyto_pod                       - Copy a file to a pod'
	@echo '    _kcl_create_pod                       - Create a new pod'
	@echo '    _kcl_delete_pod                       - Delete an existing pod'
	@echo '    _kcl_diff_pod                         - Diff a manifest for one-or-more pods'
	@echo '    _kcl_edit_pod                         - Edit a pod'
	@echo '    _kcl_explain_pod                      - Explain the pod object'
	@echo '    _kcl_exec_pod                         - Execute a command on a pod'
	@echo '    _kcl_kill_pod                         - Kill a running pod'
	@echo '    _kcl_label_pod                        - Label a pod'
	@echo '    _kcl_portforward_pod                  - Forward one or more ports of a pod'
	@echo '    _kcl_show_pod                         - Show everything related to a pod'
	@echo '    _kcl_show_pod_allocatedresouces       - Show allocated-resource for a pod'
	@echo '    _kcl_show_pod_description             - Show the description of a pod'
	@echo '    _kcl_show_pod_logs                    - Show the previous and current logs of a pod'
	@echo '    _kcl_show_pod_state                   - Show the previous and current state of a pod'
	@echo '    _kcl_sniff_pod                        - Sniff network in a pod'
	@echo '    _kcl_ssh_pod                          - Ssh in a pod'
	@echo '    _kcl_tail_pod                         - Tail logs of a pod'
	@echo '    _kcl_tail_pods_set                    - Tail logs of a pods-set'
	@echo '    _kcl_unapply_pods                     - Un-apply a manifest for one-or-more pods'
	@echo '    _kcl_unlabel_pod                      - Un-label a key from a pod'
	@echo '    _kcl_update_pod                       - Update a pod'
	@echo '    _kcl_view_pods                        - View all pods'
	@echo '    _kcl_view_pods_set                    - View a set of pods'
	@echo '    _kcl_watch_pods                       - Watching pods'
	@echo '    _kcl_watch_pods_set                   - Watching a set of pods'
	@echo '    _kcl_write_pods                       - Write manifest for one-or-more pods'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_pod:
	@$(INFO) '$(KCL_UI_LABEL)Annotating pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME) $(KCL_POD_ANNOTATIONS_KEYVALUES)

_kcl_apply_pod: _kcl_apply_pods
_kcl_apply_pods:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more pods ...'; $(NORMAL)
	$(if $(KCL_PODS_MANIFEST_FILEPATH),cat $(KCL_PODS_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_PODS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_PODS_|)cat)
	$(if $(KCL_PODS_MANIFEST_URL),curl -L $(KCL_PODS_MANIFEST_URL))
	$(if $(KCL_PODS_MANIFESTS_DIRPATH),ls -al $(KCL_PODS_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_PODS_|)$(KUBECTL) apply $(__KCL_FILENAME__PODS) $(__KCL_NAMESPACE__PODS) --validate=true

_kcl_attach_pod:
	@$(INFO) '$(KCL_UI_LABEL)Attaching to pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) attach $(__KCL_NAMESPACE__POD) $(__KCL_STDIN) $(KCL_POD_NAME)

_kcl_copyfrom_pod:
	@$(INFO) '$(KCL_UI_LABEL)Copying-from pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) cp $(__KCL_CONTAINER__POD) $(__KCL_NAMESPACE__POD) $(__KCL_NO_PRESERVE) $(KCL_POD_NAME):$(KCL_POD_REMOTEFILE_FILEPATH) $(KCL_POD_LOCALFILE_FILEPATH)

_kcl_copyto_pod:
	@$(INFO) '$(KCL_UI_LABEL)Copying-to pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) cp $(__KCL_CONTAINER__POD) $(__KCL_NAMESPACE__POD) $(__KCL_NO_PRESERVE) $(KCL_POD_LOCALFILE_FILEPATH) $(KCL_POD_NAME):$(KCL_POD_REMOTEFILE_FILEPATH)

_kcl_create_pod:
	@$(INFO) '$(KCL_UI_LABEL)Creating pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) run $(__KCL_COMMAND__POD) $(__KCL_GENERATOR__POD) $(__KCL_IMAGE__POD) $(__KCL_LABELS__POD) $(__KCL_NAMESPACE__POD) $(__KCL_PORT__POD) $(__KCL_RESTART__POD) $(__KCL_RM__POD) $(__KCL_SERVICEACCOUNT__POD) $(__KCL_STDIN__POD) $(__KCL_TTY__POD) $(KCL_POD_NAME) $(KCL_POD_COMMAND_ARGS)

_kcl_delete_pod:
	@$(INFO) '$(KCL_UI_LABEL)Deleting pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If the deleted pod is part of a deployment/replica-set, another one will be respawned'; $(NORMAL)
	$(KUBECTL) delete pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME)

_kcl_diff_pod: _kcl_diff_pods
_kcl_diff_pods:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more pods ...'; $(NORMAL)
	# cat $(KCL_PODS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_PODS_|)cat
	# curl -L $(KCL_PODS_MANIFEST_FILEPATH)
	# ls -al $(KCL_PODS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_PODS_|)$(KUBECTL) diff $(__KCL_FILENAME__PODS) $(__KCL_NAMESPACE__PODS)

_kcl_edit_pod:
	@$(INFO) '$(KCL_UI_LABEL)Editing pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME)

_kcl_explain_pod:
	@$(INFO) '$(KCL_UI_LABEL)Explaining pod object ...'; $(NORMAL)
	$(KUBECTL) explain pod

_kcl_exec_pod:
	@$(INFO) '$(KCL_UI_LABEL)Execute a command on pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) exec $(__KCL_CONTAINER__POD) $(__KCL_NAMESPACE__POD) $(__KCL_STDIN) $(__KCL_TTY) $(KCL_POD_NAME) -- $(KCL_POD_EXEC_COMMAND) $(|_KCL_EXEC_POD)

_kcl_kill_pod: _kcl_delete_pod

_kcl_label_pod:
	@$(INFO) '$(KCL_UI_LABEL)Labeling pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME) $(KCL_POD_LABELS_KEYVALUES)

_kcl_portforward_pod:
	@$(INFO) '$(KCL_UI_LABEL)Forwarding ports of pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation binds ports to 127.0.0.1 (host-port:container-port) but does NOT allow for bind addresses'; $(NORMAL)
	@$(WARN) 'This operation times out after a few minutes, if the connection is idle'; $(NORMAL)
	@$(WARN) 'This operation binds to the network namespace of the pod, that is all of its containers'; $(NORMAL)
	$(_KCL_PORTFORWARD_POD_|)$(KUBECTL) port-forward $(__KCL_ADDRESS__POD) $(__KCL_NAMESPACE__POD) $(__KCL_POD_RUNNING_TIMEOUT) pod/$(KCL_POD_NAME) $(KCL_POD_PORTFORWARD_PORTMAPPINGS) $(|_KCL_PORTFORWARD_POD)

_KCL_SHOW_POD_TARGETS?= _kcl_show_pod_allocatedresources _kcl_show_pod_logs _kcl_show_pod_object _kcl_show_pod_state _kcl_show_pod_description
_kcl_show_pod :: $(_KCL_SHOW_POD_TARGETS)

_kcl_show_pod_allocatedresources:
	@$(INFO) '$(KCL_UI_LABEL)Showing allocated-resources for pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the pod is not already running'; $(NORMAL)
	-$(KUBECTL) top pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME)

_kcl_show_pod_currentlogs:
	@$(INFO) '$(KCL_UI_LABEL)Showing current-logs of pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Logs of current pod'; $(NORMAL)
	$(KUBECTL) logs $(__KCL_CONTAINER__POD) $(_X__KCL_FOLLOW__POD) $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME) $(|_KCL_SHOW_POD_CURRENTLOGS)

_kcl_show_pod_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this pod is reachable at "$(KCL_POD_DNS_CNAME)"'; $(NORMAL)
	@$(WARN) 'More on POD DNS entry @ https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pods'; $(NORMAL)
	$(KUBECTL) describe pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME)

_kcl_show_pod_logs: _kcl_show_pod_previouslogs _kcl_show_pod_currentlogs

_kcl_show_pod_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME) -o yaml

_kcl_show_pod_previouslogs:
	@$(INFO) '$(KCL_UI_LABEL)Showing previous-logs of pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Logs of previous pod, if any'; $(NORMAL)
	$(KUBECTL) logs $(__KCL_CONTAINER__POD) $(_X__KCL_FOLLOW__POD) $(__KCL_NAMESPACE__POD) --previous $(KCL_POD_NAME) $(|_KCL_SHOW_POD_PREVIOUSLOGS)

_kcl_show_pod_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'State of previous pod, if any'; $(NORMAL)
	#$(KUBECTL) describe pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME)
	# State:          Running
	#   Started:      Thu, 20 Jun 2019 07:04:37 -0700
	# Last State:     Terminated
	#   Reason:       OOMKilled
	#   Exit Code:    137
	#   Started:      Thu, 20 Jun 2019 07:01:09 -0700
	#   Finished:     Thu, 20 Jun 2019 07:01:49 -0700
	@$(WARN) 'State of current pod'; $(NORMAL)
	#$(KUBECTL) describe pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME)
	$(KUBECTL) get pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME)

_kcl_sniff_pod:
	@$(INFO) '$(KCL_UI_LABEL)Sniffing network in pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'By default, this operation fails if tcpdump cannot be found in the target container'; $(NORMAL)
	@$(WARN) 'By default, this operation fails if wireshark cannot be found in or open on your local desktop'; $(NORMAL)
	$(KUBECTL) exec $(__KCL_CONTAINER__POD) $(__KCL_NAMESPACE__POD) $(__KCL_STDIN) $(__KCL_TTY) $(KCL_POD_NAME) -- $(KCL_POD_SNIFF_COMMAND) $(KCL_POD_SNIFF_FILTER) $(|_KCL_SNIFF_POD)

_kcl_ssh_pod:
	@$(INFO) '$(KCL_UI_LABEL)Sshing into pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) exec $(__KCL_CONTAINER__POD) $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME) -i -t -- $(KCL_POD_SSH_SHELL)

_kcl_tail_pod:
	@$(INFO) '$(KCL_UI_LABEL)Tailing logs of pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(_KCL_TAIL_POD_|)$(KUBECTL) logs $(__KCL_CONTAINER__POD) $(__KCL_FOLLOW__POD) $(__KCL_NAMESPACE__POD) $(__KCL_PREVIOUS__POD) $(_X__KCL_SELECTOR__POD) $(KCL_POD_NAME) $(|_KCL_TAIL_POD)

_kcl_tail_pods:
	@$(INFO) '$(KCL_UI_LABEL)Tailing logs of pods-set "$(KCL_PODS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Pods are grouped based on the provided namespace, field-selector, and selector'; $(NORMAL)
	$(_KCL_TAIL_PODS_|)$(KUBECTL) logs $(__KCL_CONTAINER__PODS) $(__KCL_FOLLOW__PODS) $(__KCL_NAMESPACE__PODS) $(_X__KCL_PREVIOUS__PODS) $(__KCL_SELECTOR_PODS) $(|_KCL_TAIL_PODS)

_kcl_top_pod: _kcl_show_pod_allocatedresources

_kcl_unapply_pod: _kcl_unapply_pods
_kcl_unapply_pods:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more pods ...'; $(NORMAL)
	# cat $(KCL_PODS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_PODS_|)cat
	# curl -L $(KCL_PODS_MANIFEST_URL)
	# ls -al $(KCL_PODS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_PODS_|)$(KUBECTL) delete $(__KCL_FILENAME__PODS) $(__KCL_NAMESPACE__PODS)

_kcl_unlabel_pod:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME) $(_X_KCL_POD_LABELS_KEYVALUES) $(foreach K,$(KCL_POD_LABELS_KEYS),$(K)- )

_kcl_update_pod:
	@$(INFO) '$(KCL_UI_LABEL)Updating pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if pod updates trigger an addition or removal of one or more container'; $(NORMAL)
	$(if $(KCL_POD_PATCH_FILEPATH), cat $(KCL_POD_PATCH_FILEPATH))
	$(KUBECTL) patch pod $(__KCL_NAMESPACE__POD) $(__KCL_PATCH__POD) $(KCL_POD_NAME)

_kcl_view_pods:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL pods ...'; $(NORMAL)
	$(KUBECTL) get pod --all-namespaces=true $(_X__KCL_NAMESPACE__PODS) $(__KCL_OUTPUT__PODS) $(_X__KCL_SELECTOR__PODS) $(__KCL_SHOW_LABELS__PODS) $(_X_KCL_WATCH__PODS) $(_X_KCL_WATCH_ONLY__PODS)

_kcl_view_pods_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing pods-set "$(KCL_PODS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Pods are grouped based on the provided namespace, field-selector, and selector'; $(NORMAL)
	$(KUBECTL) get pod --all-namespaces=false $(__KCL_FIELD_SELECTOR__PODS) $(__KCL_NAMESPACE__PODS) $(__KCL_OUTPUT__PODS) $(__KCL_SHOW_LABELS__PODS) $(__KCL_SELECTOR__PODS) $(_X_KCL_WATCH__PODS) $(_X_KCL__WATCH_ONLY__PODS)

_kcl_watch_pods:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL pods ...'; $(NORMAL)
	$(KUBECTL) get pods $(strip $(_X__KCL_ALL_NAMESPACES__PODS) --all-namespaces=true $(_X__KCL_NAMESPACE__PODS) $(_X__KCL_SELECTOR__PODS) $(__KCL_SHOW_LABELS__PODS) $(_X__KCL_WATCH__PODS) --watch=true $(__KCL_WATCH_ONLY__PODS) )

_kcl_watch_pods_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching pods-set "$(KCL_PODS_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pods $(strip $(__KCL_ALL_NAMESPACES__PODS) $(__KCL_FIELD_SELECTOR__PODS) $(__KCL_NAMESPACE__PODS) $(__KCL_SELECTOR__PODS) $(__KCL_SHOW_LABELS__PODS) $(_X__KCL_WATCH__PODS) --watch=true $(__KCL_WATCH_ONLY__PODS) )

_kcl_write_pod: _kcl_write_pods
_kcl_write_pods:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more pods ...'; $(NORMAL)
	$(EDITOR) $(KCL_PODS_MANIFEST_FILEPATH)
