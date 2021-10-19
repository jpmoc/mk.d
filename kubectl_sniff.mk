_KUBECTL_SNIFF_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KSF_CONTAINER_NAME?=
# KSF_TCPDUMP_BINPATH?= $(HOME)/.krew/store/sniff/v1.3.1/static-tcpdump
# KSF_TCPDUMP_FILTER?= '((tcp) and (net $$PREF_POD_IP))'
KSF_INTERFACE_NAME?= any
KSF_MODE_DEBUG?= false
# KSF_NAMESPACE_NAME?=
# KSF_OUTPUT_DIRPATH?= ./out/
# KSF_OUTPUT_FILENAME?= tcpdump.pcap
# KSF_OUTPUT_FILEPATH?= ./out/tcpdump.pcap
# KSF_POD_NAME?=
KSF_PRIVILEGED_FLAG?= false

# Derived parameters
# KSF_CONTAINER_NAME?= $(KCL_POD_CONTAINER_NAME)
KSF_MODE_DEBUG?= $(CMN_MODE_DEBUG)
KSF_NAMESPACE_NAME?= $(KCL_POD_NAMESPACE_NAME)
KSF_OUTPUT_DIRPATH?= $(KCL_OUTPUTS_DIRPATH)
KSF_OUTPUT_FILEPATH?= $(KSF_OUTPUT_DIRPATH)$(KSF_OUTPUT_FILENAME)
KSF_POD_NAME?= $(KCL_POD_NAME)

# Option parameters
__KSF_CONTAINER__KSNIFF= $(if $(KSF_CONTAINER_NAME),--container $(KSF_CONTAINER_NAME))
__KSF_FILTER__KSNIFF= $(if $(KSF_TCPDUMP_FILTER),--filter $(KSF_TCPDUMP_FILTER))
__KSF_INTERFACE= $(if $(KSF_INTERFACE_NAME),--interface $(KSF_INTERFACE_NAME))
__KSF_LOCAL_TCPDUMP_PATH= $(if $(KSF_TCPDUMP_BINPATH),--local-tcpdump-path $(KSF_TCPDUMP_BINPATH))
__KSF_NAMESPACE__KSNIFF= $(if $(KSF_NAMESPACE_NAME),--namespace $(KSF_NAMESPACE_NAME))
__KSF_OUTPUT_FILE__KSNIFF= $(if $(KSF_OUTPUT_FILEPATH),--output-file $(KSF_OUTPUT_FILE))
__KSF_REMOTE_TCPDUMP_PATH= --remote-tcpdump-path /tmp/static-tcpdump
__KSF_PRIVILEGED__KSNIFF= $(if $(filter true, $(KSF_PRIVILEGED_FLAG)),--privileged)
__KSF_VERBOSE__KSNIFF= $(if $(filter true, $(KSF_MODE_DEBUG)),--verbose)

# UI parameters
KSF_UI_LABEL?= [kubectl-sniff] #

# Utility
__KUBECTL_SNIFF_ENVIRONMENT?= $(if $(KUBECTL_KUBECONFIG_FILEPATH),KUBECONFIG=$(KUBECTL_KUBECONFIG_FILEPATH))

KUBECTL_SNIFF_BIN?= $(HOME)/.krew/bin/kubectl-sniff
KUBECTL_SNIFF?= $(strip $(__KUBECTL_SNIFF_ENVIRONMENT) $(KUBECTL_SNIFF_ENVIRONMENT) $(KUBECTL_SNIFF_BIN) $(__KUBECTL_SNIFF_OPTIONS) $(KUBECTL_SNIFF_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ksf_view_framework_macros ::
	@echo 'KubeCtL::Sniff ($(_KUBECTL_SNIFF_MK_VERSION)) macros:'
	@echo

_ksf_view_framework_parameters ::
	@echo 'KubeCtL::Sniff ($(_KUBECTL_SNIFF_MK_VERSION)) parameters:'
	@echo '    KSF_CONTAINER_NAME=$(KSF_CONTAINER_NAME)'
	@echo '    KSF_TCPDUMP_BINPATH=$(KSF_TCPDUMP_BINPATH)'
	@echo '    KSF_TCPDUMP_FILTER=$(KSF_TCPDUMP_FILTER)'
	@echo '    KSF_INTERFACE_NAME=$(KSF_INTERFACE_NAME)'
	@echo '    KSF_MODE_DEBUG=$(KSF_MODE_DEBUG)'
	@echo '    KSF_NAMESPACE_NAME=$(KSF_NAMESPACE_NAME)'
	@echo '    KSF_OUTPUT_DIRPATH=$(KSF_OUTPUT_DIRPATH)'
	@echo '    KSF_OUTPUT_FILENAME=$(KSF_OUTPUT_FILENAME)'
	@echo '    KSF_OUTPUT_FILEPATH=$(KSF_OUTPUT_FILEPATH)'
	@echo '    KSF_POD_NAME=$(KSF_POD_NAME)'
	@echo '    KSF_PRIVILEGED_FLAG=$(KSF_PRIVILEGED_FLAG)'
	@echo '    KUBECTL_SNIFF=$(KUBECTL_SNIFF)'
	@echo

_ksf_view_framework_targets ::
	@echo 'KubeCtL::Sniff ($(_KUBECTL_SNIFF_MK_VERSION)) targets:'
	@echo '    _ksl_sniff_pod                        - Sniff a pod'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

__ksf_show_version_ksniff:
	@$(INFO) '$(KSF_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	@$(WARN) 'This operation fails as this plugin does NOT support the version parameter'; $(NORMAL)
	# $(KUBECTL_SNIFF_BIN) version
	which $(KUBECTL_SNIFF_BIN)

__ksf_show_version_tcpdump:
	@$(INFO) '$(KSF_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	tcpdump --version && which tcpdump

__ksf_show_version_wireshark:
	@$(INFO) '$(KSF_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	@$(WARN) 'This operation fails if wireshark is not installed'; $(NORMAL)
	-wireshark version && which wireshark

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ksf_install_dependencies ::
	@$(INFO) '$(KSF_UI_LABEL)Installing dependencies ...'; $(NORMAL)

_ksf_sniff_pod:
	@$(INFO) '$(KSF_UI_LABEL)Sniffing pod "$(KSF_POD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will fail if wireshark is not installed'; $(NORMAL)
	@$(WARN) 'If privileged mode is set, this operation will create a new pod attached to the container defined network'
	@$(WARN) 'If not privileged mode, a static-compiled tcpdump is copied and run on destination container'; $(NORMAL)
	$(KUBECTL_SNIFF) $(__KSF_CONTAINER) $(__KSF_FILTER) $(__KSF_INTERFACE) $(__KSF_NAMESPACE) $(__KSF_REMOTE_TCPDUMP_PATH) $(__KSF_VERBOSE) $(KSF_POD_NAME)

_ksf_view_versions :: __ksf_show_version_ksniff __ksf_show_version_tcpdump __ksf_show_version_wireshark
