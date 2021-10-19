_KOPS_MK_VERSION= 0.99.4

# KOPS_ALSOLOGTOSTDERR?= true
# KOPS_CONFIG?= $HOME/.kops.yaml
# KOPS_DEBUG_MODE?= true
# KOPS_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config
# KOPS_LOG_ALSOTOSTDERR?= true
# KOPS_LOG_BACKTRACE_AT?= :0
# KOPS_LOG_DIRPATH?= /tmp
# KOPS_LOG_STDERR_THRESHOLD?= 2
# KOPS_LOG_TOSTDERR?= true
# KOPS_STATE_STORE?= s3://emayssat-allspark-kops-state-store
# KOPS_VERBOSITY_LEVEL?=
# KOPS_VMODULE?=
KOPS_UI_LABEL?= [kops] #

# Derived parameters
KOPS_DEBUG_MODE?= $(CMN_DEBUG_MODE)
KOPS_KUBECONFIG_FILEPATH?= $(KCL_KUBECONFIG_FILEPATH)
KOPS_VERBOSITY_LEVEL?= $(if $(filter true, $(KOPS_DEBUG_MODE)),10)

# Option parameters
__KOPS_STATE= $(if $(KOPS_STATE_STORE),--state $(KOPS_STATE_STORE))

#--- Utilities
__KOPS_ENVIRONMENT+= $(if $(KOPS_KUBECONFIG_FILEPATH), KUBECONFIG=$(KOPS_KUBECONFIG_FILEPATH))

__KOPS_OPTIONS+= $(if $(filter true, $(KOPS_LOG_ALSOTOSTDERR)),--alsologtostderr)
__KOPS_OPTIONS+= $(if $(KOPS_CONFIG),--config $(KOPS_CONFIG))
__KOPS_OPTIONS+= $(if $(KOPS_LOG_BACKTRACE_AT),--log-backtrace-at $(KOPS_LOG_BACKTRACE_AT))
__KOPS_OPTIONS+= $(if $(KOPS_LOG_DIRPATH),--log-dir $(KOPS_LOG_DIRPATH))
__KOPS_OPTIONS+= $(if $(filter true, $(KOPS_LOG_TOSTDERR)),--logtostderr)
__KOPS_OPTIONS+= $(if $(KOPS_STATE_STORE),--state $(KOPS_STATE_STORE))
__KOPS_OPTIONS+= $(if $(KOPS_VERBOSITY_LEVEL),--v $(KOPS_VERBOSITY_LEVEL))
__KOPS_OPTIONS+= $(if $(KOPS_VMODULE),--vmodule $(KOPS_VMODULE))

KOPS_BIN?= kops
KOPS?= $(strip $(__KOPS_ENVIRONMENT) $(KOPS_ENVIRONMENT) $(KOPS_BIN) $(__KOPS_OPTIONS) $(KOPS_OPTIONS))

#--- Macros
_kops_get_version= $(call $(KOPS) version)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _kops_view_framework_macros
_kops_view_framework_macros ::
	@echo 'KOPS ($(_KOPS_MK_VERSION)) macros:'
	@echo '    _kops_get_version                  - Get the version of kops'
	@echo

_view_framework_parameters :: _kops_view_framework_parameters
_kops_view_framework_parameters ::
	@echo 'KOPS ($(_KOPS_MK_VERSION)) parameters:'
	@echo '    KOPS=$(KOPS)'
	@echo '    KOPS_CONFIG=$(KOPS_CONFIG)'
	@echo '    KOPS_DEBUG_MODE=$(KOPS_DEBUG_MODE)'
	@echo '    KOPS_LOG_ALSOTOSTDERR=$(KOPS_LOG_ALSOTOSTDERR)'
	@echo '    KOPS_LOG_BACKTRACE_AT=$(KOPS_LOG_BACKTRACE_AT)'
	@echo '    KOPS_LOG_DIRPATH=$(KOPS_LOG_DIRPATH)'
	@echo '    KOPS_LOG_STDERR_THRESDHOL=$(KOPS_LOG_STDERR_THRESHOLD)'
	@echo '    KOPS_LOG_TOSTDERR=$(KOPS_LOG_TOSTDERR)'
	@echo '    KOPS_STATE_STORE=$(KOPS_STATE_STORE)'
	@echo '    KOPS_VERBOSITY_LEVEL=$(KOPS_VERBOSITY_LEVEL)'
	@echo '    KOPS_VMODULE=$(KOPS_VMODULE)'
	@echo

_view_framework_targets :: _kops_view_framework_targets
_kops_view_framework_targets ::
	@echo 'KOPS ($(_KOPS_MK_VERSION)) targets:'
	@echo '    _kops_install_dependencies         - Install the dependencies'
	@echo '    _kops_show_version                 - Show version of utilities'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/kops_bastion.mk
-include $(MK_DIR)/kops_cluster.mk
-include $(MK_DIR)/kops_kubeconfig.mk
-include $(MK_DIR)/kops_master.mk
-include $(MK_DIR)/kops_worker.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _kops_install_dependencies
_kops_install_dependencies ::
	@$(INFO) '$(KOPS_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs at https://github.com/kubernetes/kops#installing'; $(NORMAL)
	wget https://github.com/kubernetes/kops/releases/download/1.11.1/kops-linux-amd64
	chmod +x kops-linux-amd64
	sudo mv kops-linux-amd64 /usr/local/bin/kops

_kops_show_version:
	@$(INFO) '$(KOPS_UI_LABEL)Showing version ...'; $(NORMAL)
	$(KOPS) version
	@$(INFO) '$(KOPS_UI_LABEL)Showing latest version available ...'; $(NORMAL)
	curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4
