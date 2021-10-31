_MINIKUBE_PROFILE_MK_VERSION= $(_MINIKUBE_MK_VERSION)

# MKE_PROFILE_DIRPATH?= $(HOME)/.minikube/machines/
MKE_PROFILE_FILENAME?= config.json
# MKE_PROFILE_FILEPATH?=
# MKE_PROFILE_NAME?= minikube

# Derived variables
MKE_PROFILE_DIRPATH= $(MKE_PROFILES_DIRPATH)$(MKE_PROFILE_NAME)/
MKE_PROFILE_FILEPATH?= $(MKE_PROFILE_DIRPATH)$(MKE_PROFILE_FILENAME)
MKE_PROFILE_NAME?= $(MKE_CLUSTER_NAME)
MKE_PROFILES_DIRPATH= $(HOME)/.minikube/machines/

# Option variables

# Pipe parameters
|_MKE_LIST_PROFILES_SET?= # | grep cluster

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_mke_list_macros ::
	@#echo 'MiniKubE::Profile ($(_MINIKUBE_PROFILE_MK_VERSION)) macros:'
	@#echo

_mke_list_parameters ::
	@echo 'MiniKubE::Profile ($(_MINIKUBE_PROFILE_MK_VERSION)) parameters:'
	@echo '    MKE_PROFILE_DIRPATH=$(MKE_PROFILE_DIRPATH)'
	@echo '    MKE_PROFILE_FILENAME=$(MKE_PROFILE_FILENAME)'
	@echo '    MKE_PROFILE_FILEPATH=$(MKE_PROFILE_FILEPATH)'
	@echo '    MKE_PROFILE_NAME=$(MKE_PROFILE_NAME)'
	@echo '    MKE_PROFILES_DIRPATH=$(MKE_PROFILES_DIRPATH)'
	@echo

_mke_list_targets ::
	@echo 'MiniKubE::Profile ($(_MINIKUBE_PROFILE_MK_VERSION)) targets:'
	@echo '    _mke_list_profiles               - List all minikube-profiles'
	@echo '    _mke_list_profiles_set           - List a set of minikube-profiles'
	@echo '    _mke_show_profile                - Show everything related to minikube-profile'
	@echo '    _mke_show_profile_description    - Show description of minikube-profile'
	@echo '    _mke_show_profile_files          - Show files of minikube-profile'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mke_list_profiles:
	@$(INFO) '$(MKE_UI_LABEL)View profiles ...'; $(NORMAL)
	cd $(MKE_PROFILES_DIRPATH) && find * -maxdepth 0 -type d

_mke_list_profiles_set:
	@$(INFO) '$(MKE_UI_LABEL)View profiles-set "$(MKE_PROFILES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Profiles are grouped based on the output-filter'; $(NORMAL)
	cd $(MKE_PROFILES_DIRPATH) && find * -maxdepth 0 -type d $(|_MKE_VIEW_PROFILES_SET)

_mke_show_profile:: _mke_show_profile_filetree _mke_show_profile_description

_mke_show_profile_description:
	@$(INFO) '$(MKE_UI_LABEL)Showing description of profile "$(MKE_PROFILE_NAME)" ...'; $(NORMAL)
	[ ! -d $(MKE_PROFILE_DIRPATH) ] || cat $(MKE_PROFILE_FILEPATH)

_mke_show_profile_filetree:
	@$(INFO) '$(MKE_UI_LABEL)Showing files for profile "$(MKE_PROFILE_NAME)" ...'; $(NORMAL)
	tree $(MKE_PROFILE_DIRPATH)
