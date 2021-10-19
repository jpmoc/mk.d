_MINIKUBE_MOUNT_MK_VERSION= $(_MINIKUBE_MK_VERSION)

# MKE_MOUNT_MAP?= $${HOME}:/host
# MKE_MOUNT_NAME?=

# Derived variables
MKE_MOUNT_NAME?= $(lastword $(subst :,$(SPACE),$(MKE_MOUNT_MAP)))

# Option variables

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_mke_view_framework_macros ::
	@#echo 'MiniKubE::Mount ($(_MINIKUBE_MOUNT_MK_VERSION)) macros:'
	@#echo

_mke_view_framework_parameters ::
	@echo 'MiniKubE::Mount ($(_MINIKUBE_MOUNT_MK_VERSION)) parameters:'
	@echo '    MKE_MOUNT_MAP=$(MKE_MOUNT_MAP)'
	@echo '    MKE_MOUNT_NAME=$(MKE_MOUNT_NAME)'
	@echo

_mke_view_framework_targets ::
	@echo 'MiniKubE::Mount ($(_MINIKUBE_MOUNT_MK_VERSION)) targets:'
	@echo '    _mke_create_mount               - Create a mount'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mke_create_mount:
	@$(INFO) '$(MKE_UI_LABEL)Creating mount "$(MKE_MOUNT_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) mount $(MKE_MOUNT_MAP)
