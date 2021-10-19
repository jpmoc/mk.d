_VMC_VSM_MK_VERSION= 0.99.0

# CSP_ACCESS_TOKEN?=

# Derived variables

# Option variables

# UI variables
VSM_UI_LABEL?= $(VMC_UI_LABEL)
 
#--- Utilities
VSM_BIN?= flash
VSM?= $(strip $(__VSM_ENVIRONMENT) $(VSM_ENVIRONMENT) $(VSM_BIN) $(__VSM_OPTIONS) $(VSM_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _vsm_view_framework_macros
_vsm_view_framework_macros ::
	@echo 'VmwareCloud::VSM ($(_VMC_VSM_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _vsm_view_framework_parameters
_vsm_view_framework_parameters ::
	@echo 'VmwareCloud::VSM ($(_VMC_VSM_MK_VERSION)) parameters:'
	@echo '    VSM=$(VSM)'
	@echo

_view_framework_targets :: _vsm_view_framework_targets
_vsm_view_framework_targets ::
	@echo 'VmwareCloud::VSM ($(_VMC_VSM_MK_VERSION)) targets:'
	@echo '    _vsm_install_dependencies              - Install the dependencies'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/vmc_vsm_profile.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _vsm_install_dependencies
_vsm_install_dependencies:
	@$(INFO) '$(VSM_UI_LABEL)Installing flash ....'; $(NORMAL)
	which flash
	flash --help

