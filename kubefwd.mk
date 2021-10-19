_KUBEFWD_MK_VERSION= 0.99.4

# KFD_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config

# Derived parameters
KFD_KUBECONFIG_FILEPATH?= $(KCL_KUBECONFIG_FILEPATH)

# Option parameters

# UI parameters
KFD_UI_LABEL?= [kubefwd] #

#--- Utilities
__KUBEFWD_OPTIONS+= $(if $(KFD_KUBECONFIG_FILEPATH),--kubeconfig=$(KCL_KUBECONFIG_FILEPATH))

KUBEFWD_BIN?= sudo kubefwd
KUBEFWD?= $(strip $(__KUBEFWD_ENVIRONMENT) $(KUBEFWD_ENVIRONMENT) $(KUBEFWD_BIN) $(__KUBEFWD_OPTIONS) $(KUBEFWD_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _kfd_install_framework_dependencies
_kfd_install_framework_dependencies ::
	# Install docs @ https://github.com/txn2/kubefwd/releases
	#                https://kubefwd.com/
	cd /tmp; wget https://github.com/txn2/kubefwd/releases/kubefwd_amd64.deb
	cd /tmp; sudo dpkg --install kubefwd_amd64.deb
	which kubefwd

_view_framework_macros :: _kfd_view_framework_macros
_kfd_view_framework_macros ::
	@#echo 'KubeFwD ($(_KUBEFWD_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _kfd_view_framework_parameters
_kfd_view_framework_parameters ::
	@echo 'KubeFwD ($(_KUBEFWD_MK_VERSION)) parameters:'
	@echo '    KFD_KUBECONFIG_FILEPATH=$(KFD_KUBECONFIG_FILEPATH)'
	@echo '    KUBEFWD=$(KUBEFWD)'
	@echo

_view_framework_targets :: _kfd_view_framework_targets
_kfd_view_framework_targets ::
	@echo 'KubeFwD ($(_KUBEFWD_MK_VERSION)) targets:'
	@echo '    _kfd_show_version               - Show current version of kubefwd'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

# sudo kubefwd --kubeconfig=/home/vagrant/.kube/config.cpks-saas-kops services -n allspark --help

MK_DIR?= .
-include $(MK_DIR)/kubefwd_service.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kfd_show_version:
	@$(INFO) '$(KCL_UI_LABEL)Showing version of kubefwd ...'; $(NORMAL)
	kubefwd version
