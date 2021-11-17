_KUBECTL_DNSCLIENT_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_DNSCLIENT_EXEC_COMMAND?= ls /
# KCL_DNSCLIENT_MANIFEST_DIRPATH?= ./in/
KCL_DNSCLIENT_MANIFEST_FILENAME?= dns-client.yml
# KCL_DNSCLIENT_MANIFEST_FILEPATH?= ./in/dns-client.yml
KCL_DNSCLIENT_NAME?= dns-client
# KCL_DNSCLIENT_NAMESPACE_NAME?= default
KCL_DNSCLIENT_SSH_SHELL?= /bin/sh
KCL_DNSCLIENT_TAILFOLLOW_FLAG?= false

# Derived parameters
KCL_DNSCLIENT_FOLLOW_LOGS?= $(KCL_INTERACTIVE_MODE)
KCL_DNSCLIENT_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_DNSCLIENT_MANIFEST_FILEPATH?= $(KCL_DNSCLIENT_MANIFEST_DIRPATH)$(KCL_DNSCLIENT_MANIFEST_FILENAME)
KCL_DNSCLIENT_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)

# Options
__KCL_FILENAME__DNSCLIENT= $(if $(KCL_DNSCLIENT_MANIFEST_FILEPATH),--filename $(KCL_DNSCLIENT_MANIFEST_FILEPATH))
__KCL_NAMESPACE__DNSCLIENT= $(if $(KCL_DNSCLIENT_NAMESPACE_NAME),--namespace $(KCL_DNSCLIENT_NAMESPACE_NAME))
__KCL_NAMESPACE__DNSCLIENTS= $(if $(KCL_DNSCLIENTS_NAMESPACE_NAME),--namespace $(KCL_DNSCLIENTS_NAMESPACE_NAME))
__KCL_OUTPUT__DNSCLIENTS= $(if $(KCL_DNSCLIENTS_OUTPUT_FORMAT),--output $(KCL_DNSCLIENTS_OUTPUT_FORMAT))
__KCL_STDIN=
__KCL_TTY=

# Customizations

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::DnsClient ($(_KUBECTL_DNSCLIENT_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::DnsClient ($(_KUBECTL_DNSCLIENT_MK_VERSION)) parameters:'
	@echo '    KCL_DNSCLIENT_EXEC_COMMAND=$(KCL_DNSCLIENT_EXEC_COMMAND)'
	@echo '    KCL_DNSCLIENT_MANIFEST_DIRPATH=$(KCL_DNSCLIENT_MANIFEST_DIRPATH)'
	@echo '    KCL_DNSCLIENT_MANIFEST_FILENAME=$(KCL_DNSCLIENT_MANIFEST_FILENAME)'
	@echo '    KCL_DNSCLIENT_MANIFEST_FILEPATH=$(KCL_DNSCLIENT_MANIFEST_FILEPATH)'
	@echo '    KCL_DNSCLIENT_NAME=$(KCL_DNSCLIENT_NAME)'
	@echo '    KCL_DNSCLIENT_NAMESPACE_NAME=$(KCL_DNSCLIENT_NAMESPACE_NAME)'
	@echo '    KCL_DNSCLIENT_SSH_SHELL=$(KCL_DNSCLIENT_SSH_SHELL)'
	@echo '    KCL_DNSCLIENT_TAILFOLLOW_FLAG=$(KCL_DNSCLIENT_TAILFOLLOW_FLAG)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::DnsClient ($(_KUBECTL_DNSCLIENT_MK_VERSION)) targets:'
	@echo '    _kcl_apply_dnsclient                        - Apply a manifest for a dns-client'
	@echo '    _kcl_create_dnsclient                       - Create a new dns-client'
	@echo '    _kcl_delete_dnsclient                       - Delete an existing dns-client'
	@echo '    _kcl_exec_dnsclient                         - Execute a command on a dns-client'
	@echo '    _kcl_kill_dnsclient                         - Kill a running dns-client'
	@echo '    _kcl_show_dnsclient                         - Show everything related to a dns-client'
	@echo '    _kcl_show_dnsclient_description             - Show the description of a dns-client'
	@echo '    _kcl_show_dnsclient_state                   - Show the previous and current state of a dns-client'
	@echo '    _kcl_ssh_dnsclient                          - Ssh in a dns-client'
	@echo '    _kcl_unapply_dnsclient                      - Unapply a manifest for a dns-client'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_apply_dnsclient:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for dns-client "$(KCL_DNSCLIENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Pulled from https://k8s.io/examples/admin/dns/dnsutils.yaml'; $(NORMAL)
	$(KUBECTL) apply $(__KCL_FILENAME__DNSCLIENT) $(__KCL_NAMESPACE__DNSCLIENT) --validate=true

_kcl_create_dnsclient:
	@$(INFO) '$(KCL_UI_LABEL)Creating dns-client "$(KCL_DNSCLIENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) run --command --generator=run-pod/v1 --image=gcr.io/kubernetes-e2e-test-images/dnsutils:1.3 --labels="app=web,env=dev" $(__KCL_NAMESPACE__DNSCLIENT) --restart=Never  --serviceaccount=default dns-client -- sleep 3600

_kcl_delete_dnsclient:
	@$(INFO) '$(KCL_UI_LABEL)Deleting dns-client "$(KCL_DNSCLIENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If the deleted dns-client is part of a deployment/replica-set, another one will be respawned'; $(NORMAL)
	$(KUBECTL) delete pod $(__KCL_NAMESPACE__DNSCLIENT) $(KCL_DNSCLIENT_NAME)

_kcl_exec_dnsclient:
	@$(INFO) '$(KCL_UI_LABEL)Execute a command on dns-client "$(KCL_DNSCLIENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) exec $(__KCL_CONTAINER__DNSCLIENT) $(__KCL_NAMESPACE__DNSCLIENT) $(__KCL_STDIN) $(__KCL_TTY) $(KCL_DNSCLIENT_NAME) -- $(KCL_DNSCLIENT_EXEC_COMMAND)

_kcl_kill_dnsclient: _kcl_delete_dnsclient

_KCL_SHOW_DNSCLIENT_TARGETS?= _kcl_show_dnsclient_object _kcl_show_dnsclient_state _kcl_show_dnsclient_description
_kcl_show_dnsclient: $(_KCL_SHOW_DNSCLIENT_TARGETS)

_kcl_show_dnsclient_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of dns-client "$(KCL_DNSCLIENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this dns-client is reachable at "$(KCL_DNSCLIENT_DNS_CNAME)"'; $(NORMAL)
	@$(WARN) 'More on DNSCLIENT DNS entry @ https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pods'; $(NORMAL)
	$(KUBECTL) describe pod $(__KCL_NAMESPACE__DNSCLIENT) $(KCL_DNSCLIENT_NAME)

_kcl_show_dnsclient_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of dns-client "$(KCL_DNSCLIENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pod $(__KCL_NAMESPACE__DNSCLIENT) $(KCL_DNSCLIENT_NAME) -o yaml

_kcl_show_dnsclient_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of dns-client "$(KCL_DNSCLIENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'State of previous dns-client, if any'; $(NORMAL)
	#$(KUBECTL) describe pod $(__KCL_NAMESPACE__DNSCLIENT) $(KCL_DNSCLIENT_NAME)
	# State:          Running
	#   Started:      Thu, 20 Jun 2019 07:04:37 -0700
	# Last State:     Terminated
	#   Reason:       OOMKilled
	#   Exit Code:    137
	#   Started:      Thu, 20 Jun 2019 07:01:09 -0700
	#   Finished:     Thu, 20 Jun 2019 07:01:49 -0700
	@$(WARN) 'State of current dns-client'; $(NORMAL)
	#$(KUBECTL) describe pod $(__KCL_NAMESPACE__DNSCLIENT) $(KCL_DNSCLIENT_NAME)
	$(KUBECTL) get pod $(__KCL_NAMESPACE__DNSCLIENT) $(KCL_DNSCLIENT_NAME)

_kcl_ssh_dnsclient:
	@$(INFO) '$(KCL_UI_LABEL)Sshing into dns-client "$(KCL_DNSCLIENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) exec $(__KCL_CONTAINER__DNSCLIENT) $(__KCL_NAMESPACE__DNSCLIENT) $(KCL_DNSCLIENT_NAME) -i -t -- $(KCL_DNSCLIENT_SSH_SHELL)

_kcl_unapply_dnsclient:
	@$(INFO) '$(KCL_UI_LABEL)Unapplying manifest for dns-client "$(KCL_DNSCLIENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the resources in the manifests are not  found'; $(NORMAL)
	cat $(KCL_DNSCLIENT_MANIFEST_FILEPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__DNSCLIENT) $(__KCL_NAMESPACE__DNSCLIENT)
