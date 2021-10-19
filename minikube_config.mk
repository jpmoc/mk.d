_MINIKUBE_CONFIG_MK_VERSION= $(_MINIKUBE_MK_VERSION)

# MKE_CONFIG_DIRECTIVE?=
# MKE_CONFIG_DIRECTIVES?=
MKE_CONFIG_DIRPATH?= $(HOME)/.minikube
MKE_CONFIG_NAME?= minikube

# Derived variables

# Option variables

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_mke_view_framework_macros ::
	@#echo 'MiniKubE::Config ($(_MINIKUBE_CONFIG_MK_VERSION)) macros:'
	@#echo

_mke_view_framework_parameters ::
	@echo 'MiniKubE::Config ($(_MINIKUBE_CONFIG_MK_VERSION)) parameters:'
	@echo '    MKE_CONFIG_DIRECTIVE=$(MKE_CONFIG_DIRECTIVE)'
	@echo '    MKE_CONFIG_DIRECTIVES=$(MKE_CONFIG_DIRECTIVES)'
	@echo '    MKE_CONFIG_DIRPATH=$(MKE_CONFIG_DIRPATH)'
	@echo '    MKE_CONFIG_NAME=$(MKE_CONFIG_NAME)'
	@echo

_mke_view_framework_targets ::
	@echo 'MiniKubE::Config ($(_MINIKUBE_CONFIG_MK_VERSION)) targets:'
	@echo '    _mke_show_config                - Show everything related to minikube-configuration'
	@echo '    _mke_show_config_description    - Show description of minikube-configuration'
	@echo '    _mke_update_config              - Update the minikube-configuration'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mke_show_config:: _mke_show_config_description

_mke_show_config_description:
	@$(INFO) '$(MKE_UI_LABEL)Showing files for configuration "$(MKE_CONFIG_NAME)" ...'; $(NORMAL)
	tree $(MKE_CONFIG_DIRPATH)

_mke_update_config:
	@$(INFO) '$(MKE_UI_LABEL)Updating configuration "$(MKE_CONFIG_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation sets the default values for key-parameters'; $(NORMAL)
	# minikube config set memory 4096
	# minikube config set vm-driver hyperkit
