_WAYPOINT_SERVER_MK_VERSION= $(_WAYPOINT_MK_VERSION)

WPT_SERVER_ACCEPTTOS_FLAG?= false
WPT_SERVER_AUTHENTICATE_FLAG?= false
WPT_SERVER_NAME?= waypoint-server
# WPT_SERVER_PLATFORM_NAME?= docker
# WPT_SERVER_WEBUI_URL?= https://localhost:9702

# Derived variables

# Option variables
__WPT_ACCEPT_TOS= $(if $(WPT_SERVER_ACCEPTTOS_FLAG),--accept-tos=$(WPT_SERVER_ACCEPTTOS_FLAG))
__WPT_AUTHENTICATE= $(if $(WPT_SERVER_AUTHENTICATE_FLAG),--authenticate=$(WPT_SERVER_AUTHENTICATE_FLAG))
__WPT_PLATFORM= $(if $(WPT_SERVER_PLATFORM_NAME),--platform $(WPT_SERVER_PLATFORM_NAME))

# UI variables

#--- Pipe variables

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_wpt_view_framework_macros ::
	@#echo 'WayPoinT::Server ($(_WAYPOINT_SERVER_MK_VERSION)) macros:'
	@#echo

_wpt_view_framework_parameters ::
	@echo 'WayPoinT::Server ($(_WAYPOINT_SERVER_MK_VERSION)) parameters:'
	@echo '    WPT_SERVER_ACCEPTTOS_FLAG=$(WPT_SERVER_ACCEPTTOS_FLAG)'
	@echo '    WPT_SERVER_AUTHENTICATE_FLAG=$(WPT_SERVER_AUTHENTICATE_FLAG)'
	@echo '    WPT_SERVER_NAME=$(WPT_SERVER_NAME)'
	@echo '    WPT_SERVER_PLATFORM_NAME=$(WPT_SERVER_PLATFORM_NAME)'
	@echo '    WPT_SERVER_WEBUI_URL=$(WPT_SERVER_WEBUI_URL)'
	@echo

_wpt_view_framework_targets ::
	@echo 'WayPoinT::Server ($(_WAYPOINT_SERVER_MK_VERSION)) targets:'
	@echo '    _wpt_install_server            - Install a new server'
	@#echo '    _wpt_create_server             - Create a new server'
	@#echo '    _wpt_delete_server             - Delete an existing server'
	@echo '    _wpt_open_server_webui         - Open web UI of a server'
	@echo '    _wpt_show_server               - Show everything related to a server'
	@echo '    _wpt_show_server_description   - Show the description of a server'
	@echo '    _wpt_uninstall_server             - Un-Ininstall a server'
	@#echo '    _wpt_view_servers              - View servers'
	@#echo '    _wpt_view_servers_set          - View set of servers'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wpt_install_server:
	@$(INFO) '$(WPT_UI_LABEL)Initializing server "$(WPT_SERVER_NAME)" ...'; $(NORMAL)
	$(WAYPOINT) install $(__WPT_ACCEPT_TOS) $(__WPT_PLATFORM)

_wpt_create_server:
	@#$(INFO) '$(WPT_UI_LABEL)Creating server "$(WPT_SERVER_NAME)" ...'; $(NORMAL)
	# Install the server?

_wpt_delete_server:
	@$(INFO) '$(WPT_UI_LABEL)Deleting server "$(WPT_SERVER_NAME)" ...'; $(NORMAL)
	# Un-install the server?

_wpt_open_server_webui:
	@$(INFO) '$(WPT_UI_LABEL)Opening web UI of server "$(WPT_SERVER_NAME)" ...'; $(NORMAL)
	# $(WPT_WEBBROWSER) $(WPT_SERVER_WEBUI_URL)
	$(WAYPOINT) ui $(__WPT_AUTHENTICATE)

_wpt_show_server :: _wpt_show_server_description

_wpt_show_server_description:
	@$(INFO) '$(WPT_UI_LABEL)Showing description of server "$(WPT_SERVER_NAME)" ...'; $(NORMAL)

_wpt_uninstall_server:
	@$(INFO) '$(WPT_UI_LABEL)Un-installing server "$(WPT_SERVER_NAME)" ...'; $(NORMAL)

_wpt_view_servers:
	@$(INFO) '$(WPT_UI_LABEL)Viewing servers ...'; $(NORMAL)

_wpt_view_servers_set:
	@$(INFO) '$(WPT_UI_LABEL)Viewing servers-set "$(WPT_SERVERS_SET_NAME)" ...'; $(NORMAL)
