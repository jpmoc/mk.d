_VMC_VDP_MK_VERSION= 0.99.0

# VDP_DEBUG_MODE?= true
VDP_OUTPUT?= text
# VDP_VERBOSITY_LEVEL?= 0

# Derived variables
VDP_DEBUG_MODE?= $(CMN_DEBUG_MODE)
VDP_VERBOSITY_LEVEL?= $(CMN_VERBOSITY_LEVEL)

# Option variables

# UI variables
VDP_UI_LABEL?= $(VMC_UI_LABEL)
 
#--- Utilities
__VDP_OPTIONS+= $(if $(filter true, $(VDP_DEBUG_MODE)), --debug)
__VDP_OPTIONS+= $(if $(filter-out 0, $(VDP_VERBOSITY_LEVEL)), --verbose)

VDP_BIN?= vdp
VDP?= $(strip $(__VDP_ENVIRONMENT) $(VDP_ENVIRONMENT) $(VDP_BIN) $(__VDP_OPTIONS) $(VDP_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _vdp_view_framework_macros
_vdp_view_framework_macros ::
	@#echo 'VmwareCloud::VDP ($(_VMC_VDP_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _vdp_view_framework_parameters
_vdp_view_framework_parameters ::
	@echo 'VmwareCloud::VDP ($(_VMC_VDP_MK_VERSION)) parameters:'
	@echo '    VDP=$(VDP)'
	@echo '    VDP_DEBUG_MODE=$(VDP_DEBUG_MODE)'
	@echo '    VDP_OUTPUT=$(VDP_OUTPUT)'
	@echo '    VDP_VERBOSITY_LEVEL=$(VDP_VERBOSITY_LEVEL)'
	@echo

_view_framework_targets :: _vdp_view_framework_targets
_vdp_view_framework_targets ::
	@#echo 'VmwareCloud::VDP ($(_VMC_VDP_MK_VERSION)) targets:'
	@#echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/vmc_vdp_cluster.mk
-include $(MK_DIR)/vmc_vdp_config.mk
-include $(MK_DIR)/vmc_vdp_kubeconfig.mk
-include $(MK_DIR)/vmc_vdp_namespace.mk
-include $(MK_DIR)/vmc_vdp_organization.mk
-include $(MK_DIR)/vmc_vdp_profile.mk
-include $(MK_DIR)/vmc_vdp_project.mk
-include $(MK_DIR)/vmc_vdp_registry.mk
-include $(MK_DIR)/vmc_vdp_role.mk
-include $(MK_DIR)/vmc_vdp_vault.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _vdp_install_dependencies
_vdp_install_dependencies:
	@$(INFO) '$(VDP_UI_LABEL)Installing dependencies ....'; $(NORMAL)
	@$(WARN) 'Installation docs @ https://confluence.eng.vmware.com/display/VDPDOCS/Getting+Started+with+VDP+CLI'; $(NORMAL)
	# https://vmware.zoom.us/recording/play/djVAhdgdBo-LyxKT9cVsUGKuhhugso9IwveL6p-Wll2binJGoSteq8Ih3LQk5yaC?continueMode=true
	wget https://s3-us-west-2.amazonaws.com/vdp-binaries.vdp.vmware.com/cli/setup-vdp.sh -O /tmp/setup-vdp.sh
	# chmod +x ./setup-vdp.sh 
	bash /tmp/setup-vdp.sh	
	which vdp
	vdp --help
	rm /tmp/setup-vdp.sh

_vdp_show_version:
	@$(INFO) '$(VDP_UI_LABEL)Showing version ....'; $(NORMAL)
	$(VDP) version
