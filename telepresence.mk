_TELEPRESENCE_MK_VERSION= 0.99.0

# TPW_DEPLOYMENT_NAME?=
# TPE_KUBECONFIG_FILEPATH?= 
# TPE_LOGFILE_FILEPATH?= /tmp/telepresence.log
# TPE_METHOD?= vpn-tcp
# TPE_MODE_DEBUG?= true
TPE_NAMESPACE_NAME?= default

# Derived parameters
TPE_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config)
TPE_MODE_DEBUG?= $(CMN_MODE_DEBUG)

# Option parameters

# UI parameters
TPE_UI_LABEL?= [telepresence] #
 
#--- Utilities
__TELEPRESENCE_ENVIRONMENT+= $(if $(TPE_KUBECONFIG_FILEPATH),KUBECONFIG=$(TPE_KUBECONFIG_FILEPATH))

__TELEPRESENCE_OPTIONS+= $(if $(TPE_LOGFILE_FILEPATH),--logfile $(TPE_LOGFILE_FILEPATH))
__TELEPRESENCE_OPTIONS+= $(if $(TPE_METHOD),--method $(TPE_METHOD))
__TELEPRESENCE_OPTIONS+= $(if $(filter true,$(TPE_MODE_DEBUG)),--verbose)

TELEPRESENCE_BIN?= telepresence
TELEPRESENCE?= $(strip $(__TELEPRESENCE_ENVIRONMENT) $(TELEPRESENCE_ENVIRONMENT) $(TELEPRESENCE_BIN) $(__TELEPRESENCE_OPTIONS) $(TELEPRESENCE_OPTIONS) )

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies:: _tpe_install_dependencies
_view_framework_macros :: _tpe_view_framework_macros
_tpe_view_framework_macros ::
	@#echo 'TelePresencE:: ($(_TELEPRESENCE_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _tpe_view_framework_parameters
_tpe_view_framework_parameters ::
	@echo 'TelePresencE:: ($(_TELEPRESENCE_MK_VERSION)) parameters:'
	@echo '    TPE_DEPLOYMENT_NAME=$(TPE_DEPLOYMENT_NAME)'
	@echo '    TPE_KUBECONFIG_FILEPATH=$(TPE_KUBECONFIG_FILEPATH)'
	@echo '    TPE_LOGFILE_FILEPATH=$(TPE_LOGFILE_FILEPATH)'
	@echo '    TPE_MODE_DEBUG=$(TPE_MODE_DEBUG)'
	@echo '    TPE_NAMESPACE_NAME=$(TPE_NAMESPACE_NAME)'
	@echo '    TELEPRESENCE=$(TELEPRESENCE)'
	@echo

_view_framework_targets :: _tpe_view_framework_targets
_tpe_view_framework_targets ::
	@echo 'TelePresencS:: ($(_TELEPRESENCE_MK_VERSION)) targets:'
	@echo '    _tpe_install_dependencies           - Install required dependencies'
	@echo '    _tpe_show_version                   - Show utility version'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/telepresence_container.mk
-include $(MK_DIR)/telepresence_process.mk
-include $(MK_DIR)/telepresence_shell.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tpe_install_dependencies:
	@$(INFO) '$(TPE_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs available at https://www.telepresence.io/reference/install'; $(NORMAL)
	curl -s https://packagecloud.io/install/repositories/datawireio/telepresence/script.deb.sh -o /tmp/script.deb.sh
	sudo bash /tmp/script.deb.sh
	# sudo apt install --no-install-recommends telepresence
	sudo apt install -y telepresence
	which telepresence

_tpe_show_version:
	@$(INFO) '$(TPE_UI_LABEL)Showing version ...'; $(NORMAL)
	$(TELEPRESENCE) --version
