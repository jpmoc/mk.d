_MINIKUBE_ADDON_MK_VERSION= $(_MINIKUBE_MK_VERSION)

# MKE_ADDON_NAME?= heapster
# MKE_ADDONS_SET_NAME?= my-addons-set

# Derived variables

# Option variables

# Pipe parameters
|_MKE_VIEW_ADDONS_SET?=# | grep enabled

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_mke_view_framework_macros ::
	@#echo 'MiniKubE::AddOn ($(_MINIKUBE_ADDON_MK_VERSION)) macros:'
	@#echo

_mke_view_framework_parameters ::
	@echo 'MiniKubE::AddOn ($(_MINIKUBE_ADDON_MK_VERSION)) parameters:'
	@echo '    MKE_ADDON_NAME=$(MKE_ADDON_NAME)'
	@echo '    MKE_ADDONS_SET_NAME=$(MKE_ADDONS_SET_NAME)'
	@echo

_mke_view_framework_targets ::
	@echo 'MiniKubE::AddOn ($(_MINIKUBE_ADDON_MK_VERSION)) targets:'
	@echo '    _mke_disable_addon              - Disable add-on'
	@echo '    _mke_enable_addon               - Enable add-on'
	@echo '    _mke_view_addons                - View add-ons'
	@echo '    _mke_view_addons_set            - View set of add-ons'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mke_disable_addon:
	@$(INFO) '$(MKE_UI_LABEL)Disabling add-on "$(MKE_ADDON_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) addons disable $(MKE_ADDON_NAME)

_mke_enable_addon:
	@$(INFO) '$(MKE_UI_LABEL)Enabling add-on "$(MKE_ADDON_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) addons enable $(MKE_ADDON_NAME)

_mke_view_addons:
	@$(INFO) '$(MKE_UI_LABEL)Viewing add-ons ...'; $(NORMAL)
	$(MINIKUBE) addons list

_mke_view_addons_set:
	@$(INFO) '$(MKE_UI_LABEL)Viewing add-ons-set "$(MKE_ADDONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Add-ons are grouped based on filtering in output-pipe'; $(NORMAL)
	$(MINIKUBE) addons list $(|_MKE_VIEW_ADDONS_SET)
