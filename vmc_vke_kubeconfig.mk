_VMC_VKE_KUBECONFIG_MK_VERSION= $(_VMC_VKE_MK_VERSION)

# VKE_KUBECONFIG_EMBED_CACERT?= false
# VKE_KUBECONFIG_CLUSTER_NAME?- my-cluster-name
# VKE_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config
VKE_KUBECONFIG_FILEPATH_TMP?= /tmp/vke_kubeconfig.tmp
# VKE_KUBECONFIG_FOLDER_NAME?- SharedFolder
# VKE_KUBECONFIG_PROJECT_NAME?- SharedProject
# VKE_KUBECONFIG_USER_NAME?=
# VKE_KUBECONFIG_USER_PASSWORD?=

# Derived variables
VKE_KUBECONFIG_CLUSTER_NAME?= $(VKE_CLUSTER_NAME)
VKE_KUBECONFIG_FOLDER_NAME?= $(VKE_CLUSTER_FOLDER_NAME)
VKE_KUBECONFIG_PROJECT_NAME?= $(VKE_CLUSTER_PROJECT_NAME)

# Option variables
__VKE_EMBED_CA= $(if $(filter true, $(VKE_KUBECONFIG_CACERT)),--embed-ca)
__VKE_FOLDER__KUBECONFIG= $(if $(VKE_KUBECONFIG_FOLDER_NAME),--folder $(VKE_KUBECONFIG_FOLDER_NAME))
__VKE_PASSWORD= $(if $(VKE_KUBECONFIG_USER_PASSWORD),-p $(VKE_KUBECONFIG_USER_PASSWORD))
__VKE_PROJECT__KUBECONFIG= $(if $(VKE_KUBECONFIG_PROJECT_NAME),--project $(VKE_KUBECONFIG_PROJECT_NAME))
__VKE_USERNAME= $(if $(VKE_KUBECONFIG_USER_NAME),-u $(VKE_KUBECONFIG_USER_NAME))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_vke_view_framework_macros ::
	@#echo 'VMC::VKE::Kubeconfig ($(_VMC_VKE_KUBECONFIG_MK_VERSION)) macros:'
	@#echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::Kubeconfig ($(_VMC_VKE_KUBECONFIG_MK_VERSION)) parameters:'
	@echo '    VKE_KUBECONFIG_CLUSTER_NAME=$(VKE_KUBECONFIG_CLUSTER_NAME)'
	@echo '    VKE_KUBECONFIG_EMBED_CACERT=$(VKE_KUBECONFIG_EMBED_CACERT)'
	@echo '    VKE_KUBECONFIG_FILEPATH=$(VKE_KUBECONFIG_FILEPATH)'
	@#echo '    VKE_KUBECONFIG_FILEPATH_TMP=$(VKE_KUBECONFIG_FILEPATH_TMP)'
	@echo '    VKE_KUBECONFIG_FOLDER_NAME=$(VKE_KUBECONFIG_FOLDER_NAME)'
	@echo '    VKE_KUBECONFIG_PROJECT_NAME=$(VKE_KUBECONFIG_PROJECT_NAME)'
	@echo '    VKE_KUBECONFIG_USER_NAME=$(VKE_KUBECONFIG_USER_NAME)'
	@echo '    VKE_KUBECONFIG_USER_PASSWORD=$(VKE_KUBECONFIG_USER_PASSWORD)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::Kubeconfig ($(_VMC_VKE_KUBECONFIG_MK_VERSION)) targets:'A
	@echo '    _vke_create_kubeconfig           - Create kubeconfig'
	@echo '    _vke_delete_kubeconfig           - Delete kubeconfig'
	@echo '    _vke_refresh_kubeconfig          - Refresh kubeconfig'
	@echo '    _vke_show_kubeconfig             - Show everything related to a kubeconfig'
	@echo '    _vke_show_kubeconfig_caommands   - Show commands to update kubeconfig'
	@echo '    _vke_show_kubeconfig_yaml        - Show YAML for kubeconfig'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_create_kubeconfig:
	@$(INFO) '$(VKE_UI_LABEL)Creating a kubeconfig for "$(VKE_KUBECONFIG_CLUSTER_NAME)" ...'; $(NORMAL)
	KUBECONFIG=$(VKE_KUBECONFIG_FILEPATH) $(VKE) cluster auth setup $(__VKE_FOLDER__KUBECONFIG) $(__VKE_PROJECT__KUBECONFIG) $(VKE_KUBECONFIG_CLUSTER_NAME)

_vke_delete_kubeconfig:
	@$(INFO) '$(VKE_UI_LABEL)Deleting kubecongi for cluster "$(VKE_KUBECONFIG_CLUSTER_NAME)" ...'; $(NORMAL)
	KUBECONFIG=$(VKE_KUBECONFIG_FILEPATH) $(VKE) cluster auth delete $(__VKE_FOLDER__KUBECONFIG) $(__VKE_PROJECT__KUBECONFIG) $(VKE_KUBECONFIG_CLUSTER_NAME)

_vke_refresh_kubeconfig:
	@$(INFO) '$(VKE_UI_LABEL)Refreshing credentials in kubeconfig for cluster "$(VKE_KUBECONFIG_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The certificate issued in the kubeconfig is only valid for 24h'; $(NORMAL)
	 KUBECONFIG=$(VKE_KUBECONFIG_FILEPATH) $(VKE) cluster auth setup $(__VKE_FOLDER__KUBECONFIG) $(__VKE_PROJECT__KUBECONFIG) $(VKE_KUBECONFIG_CLUSTER_NAME)

_vke_show_kubeconfig: _vke_show_kubeconfig_commands _vke_show_kubeconfig_yaml

_vke_show_kubeconfig_commands:
	@$(INFO) '$(VKE_UI_LABEL)Showing commands for kubeconfig of cluster "$(VKE_KUBECONFIG_CLUSTER_NAME)" ...'; $(NORMAL)
	$(VKE) cluster get-kubectl-auth $(__VKE_FOLDER__KUBECONFIG) $(__VKE_PROJECT__KUBECONFIG) $(_X__VKE_CONFIGFILE) $(VKE_KUBECONFIG_CLUSTER_NAME)

_vke_show_kubeconfig_yaml:
	@$(INFO) '$(VKE_UI_LABEL)Showing YAML for kubeconfig of cluster "$(VKE_KUBECONFIG_CLUSTER_NAME)" ...'; $(NORMAL)
	rm -f $(VKE_KUBECONFIG_FILEPATH_TMP)
	KUBECONFIG=$(VKE_KUBECONFIG_FILEPATH_TMP) $(VKE) cluster auth setup $(__VKE_FOLDER__KUBECONFIG) $(__VKE_PROJECT__KUBECONFIG) $(VKE_KUBECONFIG_CLUSTER_NAME)
	cat $(VKE_KUBECONFIG_FILEPATH_TMP)
