_KLOGIN_MK_VERSION= 0.99.6

# KLN_APISERVICE_URL?= https://...
# KLN_CLUSTER_NAME?= my-cluster
KLN_KUBECONFIG_DIRPATH?= $(HOME)/.kube/
KLN_KUBECONFIG_FILENAME?= config
# KLN_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config
# KLN_USER?= A123456@ad.domain.com
# KLN_USER_ADDOMAIN_NAME?= ad.domain.com
# KLN_USER_SID?= A123456

# Derived parameters
KLN_KUBECONFIG_FILEPATH?= $(KLN_KUBECONFIG_DIRPATH)$(KLN_KUBECONFIG_FILENAME)
KLN_USER?= $(KLN_USER_SID)@$(KLN_USER_ADDOMAIN_NAME)

# Options
__KLN_APISERVICE= $(if $(KLN_APISERVICE_URL),--apiservice $(KLN_APISERVICE_URL))
__KLN_KUBECONFIG= $(if $(KLN_KUBECONFIG_FILEPATH),--kubeconfig $(KLN_KUBECONFIG_FILEPATH))
__KLN_USER= $(if $(KLN_USER),--user $(KLN_USER))

# Customizations

# Macros

# Utilities
# _KLOGIN_ENVIRONMENT+=
KLOGIN_BIN?= klogin
KLOGIN?= $(strip $(_KLOGIN_ENVIRONMENT) $(KLOGIN_ENVIRONMENT) $(KLOGIN_BIN) $(_KLOGIN_OPTIONS) $(KLOGIN_OPTIONS))

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _kln_list_macros
_kln_list_macros ::
	@#echo 'KLogiN ($(_KLOGIN_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _kln_list_parameters
_kln_list_parameters ::
	@echo 'KLogiN ($(_KLOGIN_MK_VERSION)) parameters:'
	@echo '    KLN_APISERVICE_URL=$(KLN_APISERVICE_URL)'
	@echo '    KLN_CLUSTER_NAME=$(KLN_CLUSTER_NAME)'
	@echo '    KLN_KUBECONFIG_DIRPATH=$(KLN_KUBECONFIG_DIRPATH)'
	@echo '    KLN_KUBECONFIG_FILENAME=$(KLN_KUBECONFIG_FILENAME)'
	@echo '    KLN_KUBECONFIG_FILEPATH=$(KLN_KUBECONFIG_FILEPATH)'
	@echo '    KLN_USER=$(KLN_USER)'
	@echo '    KLN_USER_ADDOMAIN_NAME=$(KLN_USER_ADDOMAIN_NAME)'
	@echo '    KLN_USER_SID=$(KLN_USER_SID)'
	@echo '    KLOGIN=$(KLOGIN)'
	@echo

_list_targets :: _kln_list_targets
_kln_list_targets ::
	@echo 'KLogiN ($(_KLN_MK_VERSION)) targets:'
	@echo '    _kln_update_kubeconfig         - Update the kubeconfig'
	@echo '    _kln_view_versions             - View versions of dependencies'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kln_update_kubeconfig:
	@$(INFO) '$(PCL_UI_LABEL)Updating kubeconfig to access "$(KLN_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KLOGIN) $(__KLN_APISERVICE) $(__KLN_KUBECONFIG) $(__KLN_PASSWORD) $(__KLN_USER)

_view_versions :: _kln_view_versions
_kln_view_versions:
	@$(INFO) '$(PCL_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	klogin --version
