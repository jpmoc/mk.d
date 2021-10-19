_VMC_MK_VERSION= 0.99.0

# VMC_PARAMETER?= value

# Derived parameters

# Option parameters

# UI parameters
VMC_UI_LABEL?= [vmcloud] #
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _vmc_view_framework_macros
_vmc_view_framework_macros ::
	@#echo 'VMC:: ($(_VMC_MK_VERSION)) targets:'
	@#echo

_view_framework_parameters :: _vmc_view_framework_parameters
_vmc_view_framework_parameters ::
	@echo 'VMC:: ($(_VMC_MK_VERSION)) parameters:'
	@echo '    VMC_UI_LABEL=$(VMW_UI_LABEL)'
	@echo

_view_framework_targets :: _vmc_view_framework_targets
_vmc_view_framework_targets ::
	@#echo 'VMC:: ($(_VMC_MK_VERSION)) targets:'
	@#echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/vmc_csp.mk
-include $(MK_DIR)/vmc_vdp.mk
-include $(MK_DIR)/vmc_vke.mk
-include $(MK_DIR)/vmc_vsm.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

