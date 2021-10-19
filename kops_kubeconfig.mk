_KOPS_KUBECONFIG_MK_VERSION= $(_KOPS_MK_VERSION)

# KOPS_KUBECONFIG_CLUSTER_NAME?= kops-master-head.k8s.local
# KOPS_KUBECONFIG_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config
# KOPS_KUBECONFIG_STATE_STORE?= s3://emayssat-allspark-kops-state-store

# Derived parameters
KOPS_KUBECONFIG_CLUSTER_NAME?= $(KOPS_CLUSTER_NAME)
KOPS_KUBECONFIG_KUBECONFIG_FILEPATH?= $(KOPS_KUBECONFIG_FILEPATH)
KOPS_KUBECONFIG_STATE_STORE?= $(KOPS_STATE_STORE)

# Option parameters
__KOPS_NAME__KUBECONFIG= $(if $(KOPS_KUBECONFIG_CLUSTER_NAME),--name $(KOPS_KUBECONFIG_CLUSTER_NAME))
__KOPS_STATE__KUBECONFIG= $(if $(KOPS_KUBECONFIG_STATE_STORE),--state $(KOPS_KUBECONFIG_STATE_STORE))

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_kops_view_framework_macros ::
	@echo 'KOPS::Kubeconfig ($(_KOPS_WORKER_MK_VERSION)) macros:'
	@echo

_kops_view_framework_parameters ::
	@echo 'KOPS::Kubeconfig ($(_KOPS_WORKER_MK_VERSION)) parameters:'
	@echo '    KOPS_KUBECONFIG_CLUSTER_NAME=$(KOPS_KUBECONFIG_CLUSTER_NAME)'
	@echo '    KOPS_KUBECONFIG_KUBECONFIG_FILEPATH=$(KOPS_KUBECONFIG_KUBECONFIG_FILEPATH)'
	@echo '    KOPS_KUBECONFIG_STATE_STORE=$(KOPS_KUBECONFIG_STATE_STORE)'
	@echo

_kops_view_framework_targets ::
	@echo 'KOPS::Kubeconfig ($(_KOPS_WORKER_MK_VERSION)) targets:'
	@echo '    _kops_recreate_kubeconfig         - REcreate a kubeconfig file'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kops_recreate_kubeconfig:
	@$(INFO) '$(KOPS_UI_LABEL)Create a new kubeconfig for cluster "$(KOPS_KUBECONFIG_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT run the command to not accidently override an existing kubeconfig'; $(NORMAL) 
	@$(WARN) 'Check the kubeconfig filepath before running this command manually!'; $(NORMAL)
	@# $(KOPS) export kubecfg $(__KOPS_NAME__KUBECONFIG)
	# KUBECONFIG=$(KOPS_KUBECONFIG_KUBECONFIG_FILEPATH) $(KOPS_BIN) $(__KOPS_STATE__KUBECONFIG) export kubecfg $(__KOPS_NAME__KUBECONFIG)
