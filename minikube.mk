_MINIKUBE_MK_VERSION= 0.99.0

# MINIKUBE_ALSOLOGTOSTDERR?=
MINIKUBE_BOOTSTRAPPER?= kubeadm
# MINIKUBE_LOG_BACKTRACEAT?= :0
# MINIKUBE_LOG_DIRPATH?=
# MINIKUBE_LOGTOSTDERR?=
MINIKUBE_PROFILE_NAME?= minikube
MINIKUBE_STDERRTHRESHOLD_LEVEL?= 2
MINIKUBE_VERBOSITY_LEVEL?= 0
# MINIKUBE_VMODULE?=
MKE_MINIKUBE_ISO_URL?= https://github.com/kubernetes/minikube/releases/download/$(MINIKUBE_VERSION)/minikube-$(MINIKUBE_VERSION).iso
# MKE_PARAMETER?= value

# Derived parameters

# Option parameters

# UI parameters
MKE_UI_LABEL?= [minikube] #
 
#--- Utilities
__MINIKUBE_OPTIONS+= $(if $(filter true, $(MINIKUBE_ASLOLOGTOSTDERR)),--alsologtostderr)
__MINIKUBE_OPTIONS+= $(if $(MINIKUBE_BOOTSTRAPPER),--bootstrapper $(MINIKUBE_BOOTSTRAPPER))
__MINIKUBE_OPTIONS+= $(if $(MINIKUBE_LOG_BACKTRACEAT),--log_backtrace_at $(MINIKUBE_LOG_BACKTRACEAT))
__MINIKUBE_OPTIONS+= $(if $(MINIKUBE_LOG_DIRPATH),--log-dir $(MINIKUBE_LOG_DIRPATH))
__MINIKUBE_OPTIONS+= $(if $(filter true, $(MINIKUBE_LOGTOSTDERR)), --logtostderr)
__MINIKUBE_OPTIONS+= $(if $(MINIKUBE_PROFILE_NAME),--profile $(MINIKUBE_PROFILE_NAME))
__MINIKUBE_OPTIONS+= $(if $(MINIKUBE_STDERRTHRESHOLD_LEVEL),--stderrthreshold $(MINIKUBE_STDERRTHRESHOLD_LEVEL))
__MINIKUBE_OPTIONS+= $(if $(MINIKUBE_VERBOSITY_LEVEL),--v $(MINIKUBE_VERBOSITY_LEVEL))
__MINIKUBE_OPTIONS+= $(if $(MINIKUBE_VMODULE),--vmodule $(MINIKUBE_VMODULE))

MINIKUBE_BIN?= minikube
MINIKUBE?= $(strip $(__MINIKUBE_ENVIRONMENT) $(MINIKUBE_ENVIRONMENT) $(MINIKUBE_BIN) $(__MINIKUBE_OPTIONS) $(MINIKUBE_OPTIONS))
MINIKUBE_VERSION?= v1.20.0
# MINIKUBE_VERSION?= v1.16.0

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _mke_list_macros
_mke_list_macros ::
	@#echo 'MiniKubE ($(_MINIKUBE_MK_VERSION)) targets:'
	@#echo

_list_parameters :: _mke_list_parameters
_mke_list_parameters ::
	@echo 'MiniKubE ($(_MINIKUBE_MK_VERSION)) parameters:'
	@echo '    MINIKUBE=$(MINIKUBE)'
	@echo '    MINIKUBE_ALSOLOGTOSTDERR=$(MINIKUBE_ALSOLOGTOSTDERR)'
	@echo '    MINIKUBE_BOOTSTRAPPER=$(MINIKUBE_BOOTSTRAPPER)'
	@echo '    MINIKUBE_LOG_BACKTRACEAT=$(MINIKUBE_LOG_BACKTRACEAT)'
	@echo '    MINIKUBE_LOG_DIRPATH=$(MINIKUBE_LOG_DIRPATH)'
	@echo '    MINIKUBE_LOGTOSTDERR=$(MINIKUBE_LOGTOSTDERR)'
	@echo '    MINIKUBE_PROFILE_NAME=$(MINIKUBE_PROFILE_NAME)'
	@echo '    MINIKUBE_STDERRTHRESHOLD_LEVEL=$(MINIKUBE_STDERRTHRESHOLD_LEVEL)'
	@echo '    MINIKUBE_VERBOSITY_LEVEL=$(MINIKUBE_VERBOSITY_LEVEL)'
	@echo '    MINIKUBE_VMODULE=$(MINIKUBE_VMODULE)'
	@echo '    MKE_MINIKUBE_ISO_URL=$(MKE_MINIKUBE_ISO_URL)'
	@echo

_list_targets :: _mke_list_targets
_mke_list_targets ::
	@echo 'MiniKubE ($(_MINIKUBE_MK_VERSION)) targets:'
	@echo '    _mke_install_dependencies        - Install depedencies'
	@echo '    _mke_view_versions               - View versions'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/minikube_addon.mk
-include $(MK_DIR)/minikube_cluster.mk
-include $(MK_DIR)/minikube_config.mk
-include $(MK_DIR)/minikube_dashboard.mk
-include $(MK_DIR)/minikube_externalregistry.mk
-include $(MK_DIR)/minikube_imagecache.mk
-include $(MK_DIR)/minikube_internalregistry.mk
-include $(MK_DIR)/minikube_mount.mk
-include $(MK_DIR)/minikube_node.mk
-include $(MK_DIR)/minikube_profile.mk
-include $(MK_DIR)/minikube_service.mk
-include $(MK_DIR)/minikube_tunnel.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS

_install_framework_dependencies :: _mke_install_depedencies
_mke_install_dependencies:
	@$(INFO) '$(MKE_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://minikube.sigs.k8s.io/docs/start/macos/'; $(NORMAL)
	brew update
	brew upgrade minikube
	brew install hyperkit
	brew install tree
	brew install helm@2# Otherwise helm3 will be installed!

_view_versions :: _mke_show_versions
_mke_show_versions:
	@$(INFO) '$(MKE_UI_LABEL)Showing versions of dependencies ...'; $(NORMAL)
	minikube version
