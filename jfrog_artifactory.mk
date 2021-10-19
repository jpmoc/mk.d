_JFRGO_ARTIFCACTORY_MK_VERSION= $(_JFROG_MK_VERSION)

# JFG_PARAMETER?= VALUE

# Derived parameters

# Option parameters

# UI variables

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_jfg_view_framework_macros ::
	@echo 'JFroG::Artifactory ($(_JFROG_ARTIFACTORY_MK_VERSION)) macros:' 
	@echo

_jfg_view_framework_parameters ::
	@echo 'JFroG::Artifactory ($(_JFROG_ARTIFACTORY_MK_VERSION)) parameters:'
	@echo

_jfg_view_framework_targets ::
	@echo 'JFroG::Artifactory ($(_JFROG_ARTIFACTORY_MK_VERSION)) targets:' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/jfrog_artifactory_configuration.mk
-include $(MK_DIR)/jfrog_artifactory_artifact.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

