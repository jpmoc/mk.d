_WAYPOINT_MK_VERSION= 0.99.4

# WPT_PARAMETER?= value
# WPT_WEBBROWSER?= chrome

# Derived parameters
WPT_WEBBROWSER?= $(WEBBROWSER)

# Option parameters

# UI parameters
WPT_UI_LABEL?= [waypoint] #

#--- Utilities
__WAYPOINT_OPTIONS+=

WAYPOINT_BIN?= waypoint
WAYPOINT?= $(strip $(__WAYPOINT_ENVIRONMENT) $(WAYPOINT_ENVIRONMENT) $(WAYPOINT_BIN) $(__WAYPOINT_OPTIONS) $(WAYPOINT_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _wpt_install_framework_dependencies
_wpt_install_framework_dependencies ::
	# Install docs at https://www.waypointproject.io/downloads
	which waypoint

_view_framework_macros :: _wpt_view_framework_macros
_wpt_view_framework_macros ::
	@#echo 'WayPoinT:: ($(_WAYPOINT_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _wpt_view_framework_parameters
_wpt_view_framework_parameters ::
	@echo 'WayPoinT:: ($(_WAYPOINT_MK_VERSION)) parameters:'
	@echo '    WAYPOINT=$(WAYPOINT)'
	@echo '    WPT_WEBBROWSER=$(WPT_WEBBROWSER)'
	@echo

_view_framework_targets :: _wpt_view_framework_targets
_wpt_view_framework_targets ::
	@echo 'WayPoinT:: ($(_WAYPOINT_MK_VERSION)) targets:'
	@echo '    _wpt_view_versions           - View version of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/waypoint_application.mk
-include $(MK_DIR)/waypoint_artifact.mk
-include $(MK_DIR)/waypoint_project.mk
-include $(MK_DIR)/waypoint_server.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_view_versions :: _wpt_view_versions
_wpt_view_versions:
	@$(INFO) '$(WPT_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	waypoint version
