_KUBECTL_POD_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_POD_ANNOTATIONS_KEYS?= key1 ...
# KCL_POD_ANNOTATIONS_KEYVALUES?= key1=value1 ...
# KCL_POD_COMMAND_ARGS?= -- <arg1> ... <argN>
KCL_POD_COMMAND_FLAG?= false
# KCL_POD_CONTAINER_NAME?= istio-proxy
# KCL_POD_CONTAINER_PORT?= 80
# KCL_POD_CONTAINERIMAGE?= busybox:1.34.0
# KCL_POD_CONTAINERS_NAMES?= container1 ...
# KCL_POD_DNSNAME?= 10-0-0-11.ns1.pod.cluster.local
KCL_POD_DNSNAME_DOMAIN?= pod.cluster.local
# KCL_POD_DNSNAME_HOSTNAME?= 10-0-0-11
# KCL_POD_DNSNAME_SUBDOMAIN?= ns1.pod.cluster.local
# KCL_POD_DRYRUN_MODE?= client
# KCL_POD_EXEC_COMMAND?= pkill httpd
# KCL_POD_FIELD_JSONPATH?= .spec.containers
KCL_POD_GENERATOR_NAME?= run-pod/v1
# KCL_POD_IPADDRESS?= 10.0.0.11
# KCL_POD_LABELS_KEYS?= new-label ...
# KCL_POD_LABELS_KEYVALUES?= new-label=awesome ...
# KCL_POD_LOCALFILE_DIRPATH?= ./in/
# KCL_POD_LOCALFILE_FILENAME?= script.sh
# KCL_POD_LOCALFILE_FILEPATH?= ./in/script.sh
# KCL_POD_NAME?= hello
# KCL_POD_NAMESPACE_NAME?= default
# KCL_POD_OUTPUT_FORMAT?= yaml
KCL_POD_OVERWRITE_FLAG?= false
# KCL_POD_PATCH?= "$(cat ./in/patch.yaml)"
# KCL_POD_PATCH_DIRPATH?= ./in/
# KCL_POD_PATCH_FILENAME?= patch.yaml
# KCL_POD_PATCH_FILEPATH?= ./in/patch.yaml
# KCL_POD_PORTFORWARD_ADDRESS?= localhost,10.19.21.23,0.0.0.0
# KCL_POD_PORTFORWARD_PORTMAPPINGS?= 8443:8443 local-port:target-port ...
# KCL_POD_PORTFORWARD_TIMEOUT?= 1m0s
KCL_POD_PRESERVE_FLAG?=true
KCL_POD_PREVIOUS?= false
KCL_POD_REMOTEFILE_DIRPATH?= ./
# KCL_POD_REMOTEFILE_FILENAME?= script.sh
# KCL_POD_REMOTEFILE_FILEPATH?= ~/script.sh
KCL_POD_RESTARTPOLICY_ENUM?= Never
# KCL_POD_SERVICE_NAME?= pod-svc
# KCL_POD_SERVICE_PORT?= 8080
# KCL_POD_SERVICE_TARGETPORT?= 80
KCL_POD_SERVICE_TYPE?= ClusterIP
KCL_POD_SERVICEACCOUNT_NAME?= default
KCL_POD_SNIFF_COMMAND?= sudo tcpdump -i any -U -w -
# KCL_POD_SNIFF_FILTER?= '(host 8.8.8.8 and port 80)'
KCL_POD_SSH_SHELL?= /bin/sh
KCL_POD_TAILFOLLOW_FLAG?= false
# KCL_PODS_CONTAINER_NAME?= istio-proxy
# KCL_PODS_FIELDSELECTOR?=
KCL_PODS_LABELS_FLAG?= false
# KCL_PODS_LABELCOLUMNS?= label1,label2
# KCL_PODS_MANIFEST_DIRPATH?= ./in/
# KCL_PODS_MANIFEST_FILENAME?= pod.yaml
# KCL_PODS_MANIFEST_FILEPATH?= ./in/pod.yaml
KCL_PODS_MANIFEST_STDINFLAG?= false
# KCL_PODS_MANIFEST_URL?= http://...
# KCL_PODS_MANIFESTS_DIRPATH?= ./in/
# KCL_PODS_NAMES?= 
# KCL_PODS_NAMESPACE_NAME?= default
# KCL_PODS_OUTPUT_FORMAT?= wide
# KCL_PODS_SELECTOR?= label=value,tier!=frontend
# KCL_PODS_SET_NAME?= my-pods-set
# KCL_PODS_SORTBY_JSONPATH?= {.metadata.creationTimestamp}
KCL_PODS_TAILFOLLOW_FLAG?= false
# KCL_PODS_WATCH_ONLY?= true

# Derived parameters
KCL_POD_FOLLOW_LOGS?= $(KCL_INTERACTIVE_MODE)
KCL_POD_DNSNAME?= $(KCL_POD_DNSNAME_HOSTNAME).$(KCL_POD_DNSNAME_SUBDOMAIN)
KCL_POD_DNSNAME_HOSTNAME?= $(subst .,-,$(KCL_POD_IPADDRESS))# 10.0.0.11 --> 10-0-0-11
KCL_POD_DNSNAME_SUBDOMAIN?= $(KCL_POD_NAMESPACE_NAME).$(KCL_POD_DOMAIN_NAME)
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
KCL_POD_SERVICE_PORT?= $(KCL_POD_SERVICE_TARGETPORT)
KCL_POD_SERVICE_TARGETPORT?= $(KCL_POD_CONTAINER_PORT)
KCL_PODS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_PODS_MANIFEST_FILEPATH?= $(KCL_PODS_MANIFEST_DIRPATH)$(KCL_PODS_MANIFEST_FILENAME)
KCL_PODS_NAMESPACE_NAME?= $(KCL_POD_NAMESPACE_NAME)
KCL_PODS_OUTPUT_FORMAT?= $(KCL_OUTPUT_FORMAT)
KCL_PODS_SET_NAME?= pods@$(KCL_PODS_FIELDSELECTOR)@$(KCL_PODS_SELECTOR)@$(KCL_PODS_NAMESPACE_NAME)
KCL_PODS_WATCH_ONLY?= $(KCL_WATCH_ONLY)

# Options
__KCL_ALL_NAMESPACES=
__KCL_ADDRESS__POD= $(if $(KCL_POD_PORTFORWARD_ADDRESS),--address $(KCL_POD_PORTFORWARD_ADDRESS))
__KCL_COMMAND__POD= $(if $(filter true,$(KCL_POD_COMMAND_FLAG)),--command)
__KCL_CONTAINER__POD= $(if $(KCL_POD_CONTAINER_NAME),--container $(KCL_POD_CONTAINER_NAME))
__KCL_CONTAINER__PODS= $(if $(KCL_PODS_CONTAINER_NAME),--container $(KCL_PODS_CONTAINER_NAME))
__KCL_CONTAINERS__POD= --containers
__KCL_CONTAINERS__PODS= --containers
__KCL_DRY_RUN__POD= $(if $(filter true,$(KCL_POD_DRYRUN_MODE)),--dry-run=$(KCL_POD_DRYRUN_MODE))
__KCL_FIELD_SELECTOR__PODS= $(if $(KCL_PODS_FIELDSELECTOR),--field-selector $(KCL_PODS_FIELDSELECTOR))
__KCL_FILENAME__PODS+= $(if $(KCL_PODS_MANIFEST_FILEPATH),--filename $(KCL_PODS_MANIFEST_FILEPATH))
__KCL_FILENAME__PODS+= $(if $(filter true,$(KCL_PODS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__PODS+= $(if $(KCL_PODS_MANIFEST_URL),--filename $(KCL_PODS_MANIFEST_URL))
__KCL_FILENAME__PODS+= $(if $(KCL_PODS_MANIFESTS_DIRPATH),--filename $(KCL_PODS_MANIFESTS_DIRPATH))
__KCL_FOLLOW__POD= $(if $(KCL_POD_TAILFOLLOW_FLAG),--follow=$(KCL_POD_TAILFOLLOW_FLAG))
__KCL_FOLLOW__PODS= $(if $(KCL_PODS_TAILFOLLOW_FLAG),--follow=$(KCL_PODS_TAILFOLLOW_FLAG))
__KCL_GENERATOR__POD= $(if $(KCL_POD_GENERATOR_NAME),--generator=$(KCL_POD_GENERATOR_NAME))
__KCL_IMAGE__POD= $(if $(KCL_POD_CONTAINERIMAGE_NAME),--image=$(KCL_POD_CONTAINERIMAGE_NAME))
__KCL_LABEL_COLUMNS__POD= $(if $(KCL_PODS_LABELCOLUMNS),--label-columns=$(KCL_PODS_LABELCOLUMNS))
__KCL_LABELS__POD= $(if $(KCL_POD_LABELS_KEYVALUES),--labels="$(subst $(SPACE),$(COMMA),$(KCL_POD_LABELS_KEYVALUES))")
__KCL_NAME__POD= $(if $(KCL_POD_SERVICE_NAME),--name $(KCL_POD_SERVICE_NAME))
__KCL_NAMESPACE__POD= $(if $(KCL_POD_NAMESPACE_NAME),--namespace $(KCL_POD_NAMESPACE_NAME))
__KCL_NAMESPACE__PODS= $(if $(KCL_PODS_NAMESPACE_NAME),--namespace $(KCL_PODS_NAMESPACE_NAME))
__KCL_NO_PRESERVE= $(if $(filter true,$(KCL_POD_PRESERVE_FLAG)),--no-preserve=false,--no-preserve=true)
__KCL_OUTPUT__POD= $(if $(KCL_POD_OUTPUT_FORMAT),--output $(KCL_POD_OUTPUT_FORMAT))
__KCL_OUTPUT__PODS= $(if $(KCL_PODS_OUTPUT_FORMAT),--output $(KCL_PODS_OUTPUT_FORMAT))
__KCL_OVERWRITE__POD= $(if $(filter true,$(KCL_POD_OVERWRITE_FLAG)),--overwrite)
__KCL_PATCH__POD= $(if $(KCL_POD_PATCH),--patch $(KCL_POD_PATCH))
__KCL_PORT__POD= $(if $(KCL_POD_CONTAINER_PORT),--port $(KCL_POD_CONTAINER_PORT))
__KCL_PORT__POD_= $(if $(KCL_POD_SERVICE_PORT),--port $(KCL_POD_SERVICE_PORT))
__KCL_PREVIOUS__PODS= $(if $(filter true,$(KCL_POD_PREVIOUS)),--previous)
__KCL_POD_RUNNING_TIMEOUT= $(if $(KCL_POD_PORTFORWARD_TIMEOUT),--pod-running-timeout=$(KCL_POD_PORTFORWARD_TIMEOUT))
__KCL_RECURSIVE__POD=
__KCL_RESTART__POD= $(if $(KCL_POD_RESTARTPOLICY_ENUM),--restart=$(KCL_POD_RESTARTPOLICY_ENUM))
__KCL_RM__POD=
__KCL_SELECTOR__PODS= $(if $(KCL_PODS_SELECTOR),--selector=$(KCL_PODS_SELECTOR))
__KCL_SERVICEACCOUNT__POD= $(if $(KCL_POD_SERVICEACCOUNT_NAME),--serviceaccount=$(KCL_POD_SERVICEACCOUNT_NAME))
__KCL_SHOW_LABELS__PODS= $(if $(filter true,$(KCL_PODS_LABELS_FLAG)),--show-labels)
__KCL_SORT_BY__PODS= $(if $(KCL_PODS_SORTBY_JSONPATH),--sort-by='$(KCL_PODS_SORTBY_JSONPATH)')
__KCL_STDIN__POD=
__KCL_TARGET_PORT__POD= $(if $(KCL_POD_SERVICE_TARGETPORT),--target-port $(KCL_POD_SERVICE_TARGETPORT))
__KCL_TTY__POD=
__KCL_TYPE__POD= $(if $(KCL_POD_SERVICE_TYPE),--type $(KCL_POD_SERVICE_TYPE))
__KCL_WATCH__PODS=
__KCL_WATCH_ONLY__PODS= $(if $(KCL_PODS_WATCH_ONLY),--watch-only=$(KCL_PODS_WATCH_ONLY))

# Customizations
_KCL_APPLY_PODS_|?= #
_KCL_DIFF_PODS_|?= $(_KCL_APPLY_PODS_|)
_KCL_PORTFORWARD_POD_|?= while true; do #
_KCL_REPLACE_POD_|?= #
_KCL_SHOW_POD_ALLOCATEDRESOURCES_|?= -#
_KCL_TAIL_POD_|?= $(_KCL_TAIL_PODS_|) 
_KCL_TAIL_PODS_|?= 
_KCL_UNAPPLY_PODS_|?= $(_KCL_APPLY_PODS_|)
|_KCL_CREATE_POD?= # | tee pod.yaml
|_KCL_EXEC_POD?=
|_KCL_PORTFORWARD_POD?= || sleep 10; date; done
|_KCL_SHOW_POD_CURRENTLOGS?= | tail -20
|_KCL_SHOW_POD_PREVIOUSLOGS?= $(|_KCL_SHOW_POD_CURRENTLOGS)
|_KCL_SNIFF_POD?= | wireshark -k -i -
|_KCL_TAIL_POD?= $(|_KCL_TAIL_PODS)
|_KCL_TAIL_PODS?= 

# Macros
_kcl_get_pod_containers_names= $(call _kcl_get_pod_containers_names_N,$(KCL_POD_NAME))
_kcl_get_pod_containers_names_N= $(call _kcl_get_pod_containers_names_NN, $(1), $(KCL_POD_NAMESPACE_NAME))
_kcl_get_pod_containers_names_NN= $(shell $(KUBECTL) get pod --namespace $(2) $(1) --output jsonpath='{.spec.containers[*].name}')

_kcl_get_pod_ipaddress= $(call _kcl_get_pod_ipaddress_N,$(KCL_POD_NAME))
_kcl_get_pod_ipaddress_N= $(call _kcl_get_pod_ipaddress_NN, $(1) , $(KCL_POD_NAMESPACE_NAME))
_kcl_get_pod_ipaddress_NN= $(shell $(KUBECTL) get pod --namespace $(2) $(1) --output jsonpath='{.status.podIP}')

_kcl_get_pods_names= $(call _kcl_get_pods_names_S, $(KCL_PODS_SELECTOR))
_kcl_get_pods_names_S= $(call _kcl_get_pods_names_SN, $(1), $(KCL_PODS_NAMESPACE_NAME))
_kcl_get_pods_names_SN= $(shell $(KUBECTL) get pod --namespace $(2) --selector $(1) --output jsonpath="{.items[*].metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Pod ($(_KUBECTL_POD_MK_VERSION)) macros:'
	@echo '    _kcl_get_pod_containers_names_{|N|NN}  - Get container names in a pod (Name,Namespace)'
	@echo '    _kcl_get_pod_ipaddress_{|N|NN}         - Get the IP address of a  pod (Name,Namespace)'
	@echo '    _kcl_get_pods_names_{|S|SN}            - Get names of pods (Selector,Namespace)'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Pod ($(_KUBECTL_POD_MK_VERSION)) parameters:'
	@echo '    KCL_POD_ANNOTATIONS_KEYS=$(KCL_POD_ANNOTATIONS_KEYS)'
	@echo '    KCL_POD_ANNOTATIONS_KEYVALUES=$(KCL_POD_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_POD_COMMAND_ARGS=$(KCL_POD_COMMAND_ARGS)'
	@echo '    KCL_POD_COMMAND_FLAG=$(KCL_POD_COMMAND_FLAG)'
	@echo '    KCL_POD_CONTAINER_NAME=$(KCL_POD_CONTAINER_NAME)'
	@echo '    KCL_POD_CONTAINER_PORT=$(KCL_POD_CONTAINER_PORT)'
	@echo '    KCL_POD_CONTAINERIMAGE_NAME=$(KCL_POD_CONTAINERIMAGE_NAME)'
	@echo '    KCL_POD_CONTAINERS_NAMES=$(KCL_POD_CONTAINERS_NAMES)'
	@echo '    KCL_POD_DNSNAME=$(KCL_POD_DNSNAME)'
	@echo '    KCL_POD_DNSNAME_DOMAIN=$(KCL_POD_DNSNAME_DOMAIN)'
	@echo '    KCL_POD_DNSNAME_HOSTNAME=$(KCL_POD_DNSNAME_HOSTNAME)'
	@echo '    KCL_POD_DNSNAME_SUBDOMAIN=$(KCL_POD_DNSNAME_SUBDOMAIN)'
	@echo '    KCL_POD_DRYRUN_FLAG=$(KCL_POD_DRYRUN_FLAG)'
	@echo '    KCL_POD_EXEC_COMMAND=$(KCL_POD_EXEC_COMMAND)'
	@echo '    KCL_POD_FIELD_JSONPATH=$(KCL_POD_FIELD_JSONPATH)'
	@echo '    KCL_POD_GENERATOR_NAME=$(KCL_POD_GENERATOR_NAME)'
	@echo '    KCL_POD_IPADDRESS=$(KCL_POD_IPADDRESS)'
	@echo '    KCL_POD_LABELS_KEYS=$(KCL_POD_LABELS_KEYS)'
	@echo '    KCL_POD_LABELS_KEYVALUES=$(KCL_POD_LABELS_KEYVALUES)'
	@echo '    KCL_POD_LOCALFILE_DIRPATH=$(KCL_POD_LOCALFILE_DIRPATH)'
	@echo '    KCL_POD_LOCALFILE_FILENAME=$(KCL_POD_LOCALFILE_FILENAME)'
	@echo '    KCL_POD_LOCALFILE_FILEPATH=$(KCL_POD_LOCALFILE_FILEPATH)'
	@echo '    KCL_POD_NAME=$(KCL_POD_NAME)'
	@echo '    KCL_POD_NAMESPACE_NAME=$(KCL_POD_NAMESPACE_NAME)'
	@echo '    KCL_POD_OVERWRITE_FLAG=$(KCL_POD_OVERWRITE_FLAG)'
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
	@echo '    KCL_POD_SERVICE_PORT=$(KCL_POD_SERVICE_PORT)'
	@echo '    KCL_POD_SERVICE_TARGETPORT=$(KCL_POD_SERVICE_TARGETPORT)'
	@echo '    KCL_POD_SERVICE_TYPE=$(KCL_POD_SERVICE_TYPE)'
	@echo '    KCL_POD_SERVICEACCOUNT_NAME=$(KCL_POD_SERVICEACCOUNT_NAME)'
	@echo '    KCL_POD_SNIFF_COMMAND=$(KCL_POD_SNIFF_COMMAND)'
	@echo '    KCL_POD_SNIFF_FILTER=$(KCL_POD_SNIFF_FILTER)'
	@echo '    KCL_POD_SSH_SHELL=$(KCL_POD_SSH_SHELL)'
	@echo '    KCL_POD_TAILFOLLOW_FLAG=$(KCL_POD_TAILFOLLOW_FLAG)'
	@echo '    KCL_PODS_CONTAINER_NAME=$(KCL_PODS_CONTAINER_NAME)'
	@echo '    KCL_PODS_FIELDSELECTOR=$(KCL_PODS_FIELDSELECTOR)'
	@echo '    KCL_PODS_LABELCOLUMNS=$(KCL_PODS_LABELCOLUMNS)'
	@echo '    KCL_PODS_LABELS_FLAG=$(KCL_PODS_LABELS_FLAG)'
	@echo '    KCL_PODS_MANIFEST_DIRPATH=$(KCL_PODS_MANIFEST_DIRPATH)'
	@echo '    KCL_PODS_MANIFEST_FILENAME=$(KCL_PODS_MANIFEST_FILENAME)'
	@echo '    KCL_PODS_MANIFEST_FILEPATH=$(KCL_PODS_MANIFEST_FILEPATH)'
	@echo '    KCL_PODS_MANIFEST_STDINFLAG=$(KCL_PODS_MANIFEST_STDINFLAG)'
	@echo '    KCL_PODS_MANIFEST_URL=$(KCL_PODS_MANIFEST_URL)'
	@echo '    KCL_PODS_MANIFESTS_DIRPATH=$(KCL_PODS_MANIFESTS_DIRPATH)'
	@echo '    KCL_PODS_NAMES=$(KCL_PODS_NAMES)'
	@echo '    KCL_PODS_NAMESPACE_NAME=$(KCL_PODS_NAMESPACE_NAME)'
	@echo '    KCL_PODS_OUTPUT_FORMAT=$(KCL_PODS_OUTPUT_FORMAT)'
	@echo '    KCL_PODS_SELECTOR=$(KCL_PODS_SELECTOR)'
	@echo '    KCL_PODS_SET_NAME=$(KCL_PODS_SET_NAME)'
	@echo '    KCL_PODS_SORTBY_JSONPATH=$(KCL_PODS_SORTBY_JSONPATH)'
	@echo '    KCL_PODS_TAILFOLLOW_FLAG=$(KCL_POD_TAILFOLLOW_FLAG)'
	@echo '    KCL_PODS_WATCH_ONLY=$(KCL_PODS_WATCH_ONLY)'
	@echo

_kcl_list_targets ::
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
	@echo '    _kcl_list_pods                        - List all pods'
	@echo '    _kcl_list_pods_set                    - List a set of pods'
	@echo '    _kcl_patch_pod                        - Patch a pod'
	@echo '    _kcl_portforward_pod                  - Forward one or more ports of a pod'
	@echo '    _kcl_replace_pod                      - Replace a pod'
	@echo '    _kcl_reset_pod                        - Reset a pod'
	@echo '    _kcl_reset_pod_environment            - Reset the environment used by a pod'
	@echo '    _kcl_reset_pod_image                  - Reset the image used by a pod'
	@echo '    _kcl_reset_pod_resources              - Reset the resources used by a pod'
	@echo '    _kcl_reset_pod_serviceaccount         - Reset the service-account used by a pod'
	@echo '    _kcl_show_pod                         - Show everything related to a pod'
	@echo '    _kcl_show_pod_allocatedresources      - Show allocated-resource for a pod'
	@echo '    _kcl_show_pod_description             - Show the description of a pod'
	@echo '    _kcl_show_pod_logs                    - Show the previous and current logs of a pod'
	@echo '    _kcl_show_pod_state                   - Show the previous and current state of a pod'
	@echo '    _kcl_sniff_pod                        - Sniff network in a pod'
	@echo '    _kcl_ssh_pod                          - Ssh in a pod'
	@echo '    _kcl_tail_pod                         - Tail logs of a pod'
	@echo '    _kcl_tail_pods_set                    - Tail logs of a pods-set'
	@echo '    _kcl_top_pod                          - Top a pod'
	@echo '    _kcl_unannotate_pod                   - Un-annotate a pod'
	@echo '    _kcl_unapply_pods                     - Un-apply a manifest for one-or-more pods'
	@echo '    _kcl_unlabel_pod                      - Un-label a key from a pod'
	@echo '    _kcl_watch_pods                       - Watching pods'
	@echo '    _kcl_watch_pods_set                   - Watching a set of pods'
	@echo '    _kcl_write_pods                       - Write manifest for one-or-more pods'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_pod:
	@$(INFO) '$(KCL_UI_LABEL)Annotating pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate pod $(__KCL_NAMESPACE__POD) $(__KCL_OVERWRITE__POD) $(KCL_POD_NAME) $(KCL_POD_ANNOTATIONS_KEYVALUES)

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
	$(KUBECTL) run $(strip $(__KCL_COMMAND__POD) $(__KLC_DRY_RUN__POD) $(__KCL_GENERATOR__POD) $(__KCL_IMAGE__POD) $(__KCL_LABELS__POD) $(__KCL_NAMESPACE__POD) $(__KCL_OUTPUT__POD) $(__KCL_PORT__POD) $(__KCL_RESTART__POD) $(__KCL_RM__POD) $(__KCL_SERVICEACCOUNT__POD) $(__KCL_STDIN__POD) $(__KCL_TTY__POD) )  $(KCL_POD_NAME) $(KCL_POD_COMMAND_ARGS) $(|_KCL_CREATE_POD})

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
	$(KUBECTL) explain pod$(KCL_POD_FIELD_JSONPATH) $(__KCL_RECURSIVE__POD)

_kcl_expose_pod:
	@$(INFO) '$(KCL_UI_LABEL)Exposing pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation allows a pod to be directly reachable'; $(NORMAL)
	$(KUBECTL) expose pod $(__KCL_NAME__POD) $(__KCL_NAMESPACE__POD) $(__KCL_PORT__POD_) $(__KCL_TARGET_PORT__POD) $(__KCL_TYPE__POD) $(KCL_POD_NAME) 

_kcl_exec_pod:
	@$(INFO) '$(KCL_UI_LABEL)Execute a command on pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) exec $(__KCL_CONTAINER__POD) $(__KCL_NAMESPACE__POD) $(__KCL_STDIN) $(__KCL_TTY) $(KCL_POD_NAME) -- $(KCL_POD_EXEC_COMMAND) $(|_KCL_EXEC_POD)

_kcl_kill_pod: _kcl_delete_pod

_kcl_label_pod:
	@$(INFO) '$(KCL_UI_LABEL)Labeling pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label pod $(__KCL_NAMESPACE__POD) $(__KCL_OVERWRITE__POD) $(KCL_POD_NAME) $(KCL_POD_LABELS_KEYVALUES)

_kcl_list_pods:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL pods ...'; $(NORMAL)
	$(KUBECTL) get pod --all-namespaces=true $(__KCL_LABEL_COLUMNS__PODS) $(_X__KCL_NAMESPACE__PODS) $(__KCL_OUTPUT__PODS) $(_X__KCL_SELECTOR__PODS) $(__KCL_SHOW_LABELS__PODS) $(_X_KCL_WATCH__PODS) $(_X_KCL_WATCH_ONLY__PODS)
	# kubectl describe nodes | grep --after-context=5 "Non-terminated Pods"

_kcl_list_pods_set:
	@$(INFO) '$(KCL_UI_LABEL)Listingg pods-set "$(KCL_PODS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Pods are grouped based on the provided namespace, field-selector, and selector'; $(NORMAL)
	$(KUBECTL) get pod --all-namespaces=false $(__KCL_FIELD_SELECTOR__PODS) $(__KCL_NAMESPACE__PODS) $(__KCL_OUTPUT__PODS) $(__KCL_SHOW_LABELS__PODS) $(__KCL_SELECTOR__PODS) $(_X_KCL_WATCH__PODS) $(_X_KCL__WATCH_ONLY__PODS)

_kcl_patch_pod:
	@$(INFO) '$(KCL_UI_LABEL)Patching pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if pod updates trigger an addition or removal of one or more container'; $(NORMAL)
	$(if $(KCL_POD_PATCH_FILEPATH), cat $(KCL_POD_PATCH_FILEPATH))
	$(KUBECTL) patch pod $(__KCL_NAMESPACE__POD) $(__KCL_PATCH__POD) $(KCL_POD_NAME)

_kcl_portforward_pod:
	@$(INFO) '$(KCL_UI_LABEL)Forwarding ports of pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation binds ports to 127.0.0.1 (host-port:container-port) but does NOT allow for bind addresses(?)'; $(NORMAL)
	@$(WARN) 'This operation binds to the network namespace of the pod, that is all of its containers'; $(NORMAL)
	$(_KCL_PORTFORWARD_POD_|)$(KUBECTL) port-forward $(__KCL_ADDRESS__POD) $(__KCL_NAMESPACE__POD) $(__KCL_POD_RUNNING_TIMEOUT) pod/$(KCL_POD_NAME) $(KCL_POD_PORTFORWARD_PORTMAPPINGS) $(|_KCL_PORTFORWARD_POD)

_kcl_replace_pod:
	@$(INFO) '$(KCL_UI_LABEL)Replacing pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation deletes and recreate a resource with the same name'; $(NORMAL)
	$(_KCL_REPLACE_POD_|)$(KUBECTL) replace pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME)

_KCL_RESET_POD_TARGETS?= _kcl_reset_pod_environment _kcl_reset_pod_image _kcl_reset_pod_resources _kcl_reset_pod_selector _kcl_reset_pod_serviceaccount
_kcl_reset_pod: $(_KCL_RESET_POD_TARGETS)

_kcl_reset_pod_environment:
	@$(INFO) '$(KCL_UI_LABEL)Resetting environment used by pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) set env pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME) ...

_kcl_reset_pod_image:
	@$(INFO) '$(KCL_UI_LABEL)Resetting image used by pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) set image pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME) $(KCL_POD_CONTAINER_NAME)=$(KCL_POD_CONTAINERIMAGE_NAME)

_kcl_reset_pod_resources:
	@$(INFO) '$(KCL_UI_LABEL)Resetting resources used by pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) set resources pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME) ...

_kcl_reset_pod_selector:

_kcl_reset_pod_serviceaccount:
	@$(INFO) '$(KCL_UI_LABEL)Resetting service-account used by pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) set serviceaccount pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME) ...
	#
_KCL_SHOW_POD_TARGETS?= _kcl_show_pod_allocatedresources _kcl_show_pod_logs _kcl_show_pod_object _kcl_show_pod_state _kcl_show_pod_description
_kcl_show_pod :: $(_KCL_SHOW_POD_TARGETS)

_kcl_show_pod_allocatedresources:
	@$(INFO) '$(KCL_UI_LABEL)Showing allocated-resources for pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation requires the metrics-server to be running and the pod to have CPU requests'; $(NORMAL)
	@$(WARN) 'This operation fails if the pod is not in the running state'; $(NORMAL)
	$(_KCL_SHOW_POD_ALLOCATEDRESOURCES_|)$(KUBECTL) top pod $(__KCL_CONTAINERS__POD) $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME)

_kcl_show_pod_currentlogs:
	@$(INFO) '$(KCL_UI_LABEL)Showing current-logs of pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Logs of current pod'; $(NORMAL)
	$(KUBECTL) logs $(__KCL_CONTAINER__POD) $(_X__KCL_FOLLOW__POD) $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME) $(|_KCL_SHOW_POD_CURRENTLOGS)

_kcl_show_pod_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
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

_kcl_top_pods:
	@$(INFO) '$(KCL_UI_LABEL)Top-ing pods ...'; $(NORMAL)
	$(KUBECTL) top pods $(__KCL_CONTAINERS__PODS) $(__KCL_NAMESPACE__PODS)

_kcl_unannotate_pod:
	@$(INFO) '$(KCL_UI_LABEL)Un-annotating pod "$(KCL_POD_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate pod $(__KCL_NAMESPACE__POD) $(KCL_POD_NAME) $(foreach K, $(KCL_POD_ANNOTATIONS_KEYS), $(K)-)

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

_kcl_watch_pods:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL pods ...'; $(NORMAL)
	$(KUBECTL) get pods $(strip $(_X__KCL_ALL_NAMESPACES__PODS) --all-namespaces=true $(_X__KCL_NAMESPACE__PODS) $(_X__KCL_SELECTOR__PODS) $(__KCL_SHOW_LABELS__PODS) $(_X__KCL_WATCH__PODS) --watch=true $(__KCL_WATCH_ONLY__PODS) )

_kcl_watch_pods_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching pods-set "$(KCL_PODS_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pods $(strip $(__KCL_ALL_NAMESPACES__PODS) $(__KCL_FIELD_SELECTOR__PODS) $(__KCL_NAMESPACE__PODS) $(__KCL_SELECTOR__PODS) $(__KCL_SHOW_LABELS__PODS) $(_X__KCL_WATCH__PODS) --watch=true $(__KCL_WATCH_ONLY__PODS) )

_kcl_write_pod: _kcl_write_pods
_kcl_write_pods:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more pods ...'; $(NORMAL)
	$(WRITER) $(KCL_PODS_MANIFEST_FILEPATH)
