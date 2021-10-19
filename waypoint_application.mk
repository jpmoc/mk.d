_WAYPOINT_APPLICATION_MK_VERSION= $(_WAYPOINT_MK_VERSION)

# WPT_APPLICATION_CONFIG_DIRPATH?= ./
WPT_APPLICATION_CONFIG_FILENAME?= waypoint.hcl
# WPT_APPLICATION_CONFIG_FILEPATH?= ./waypoint.hcl
# WPT_APPLICATION_NAME?= app
# WPT_APPLICATION_PROJECT_DIRPATH?= ./
WPT_APPLICATION_WORKSPACE_NAME?= default
WPT_APPLICATIONS_REGEX?= *
WPT_APPLICATIONS_SET_NAME?= my-applications-set@
WPT_APPLICATIONS_PROJECTS_DIRPATH?= ../

# Derived variables
WPT_APPLICATION_CONFIG_DIRPATH?= $(WPT_APPLICATION_PROJECT_DIRPATH)
WPT_APPLICATION_CONFIG_FILEPATH?= $(WPT_APPLICATION_CONFIG_DIRPATH)$(WPT_APPLICATION_CONFIG_FILENAME)
WPT_APPLICATION_PROJECT_DIRPATH?= $(WPT_PROJECT_DIRPATH)

# Option variables
__WPT_APP__APPLICATION= $(if $(WPT_APPLICATION_NAME),--app $(WPT_APPLICATION_NAME))
__WPT_WORKSPACE__APPLICATION= $(if $(WPT_APPLICATION_WORKSPACE_NAME),--workspace $(WPT_APPLICATION_WORKSPACE_NAME))

# UI variables

#--- Pipe variables
WPT_CREATE_APPLICATION_|?= cd $(WPT_APPLICATION_PROJECT_DIRPATH) &&
WPT_DELETE_APPLICATION_|?= cd $(WPT_APPLICATION_PROJECT_DIRPATH) &&
WPT_RELEASE_APPLICATION_|?= cd $(WPT_APPLICATION_PROJECT_DIRPATH) &&
WPT_VIEW_APPLICATIONS_|?= cd $(WPT_APPLICATIONS_PROJECTS_DIRPATH) &&
WPT_VIEW_APPLICATIONS_SET_|?= cd $(WPT_APPLICATIONS_PROJECTS_DIRPATH) &&
|_WPT_VIEW_APPLICATIONS?= | grep -v README
|_WPT_VIEW_APPLICATIONS_SET?= | grep -v README

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_wpt_view_framework_macros ::
	@#echo 'WayPoinT::Application ($(_WAYPOINT_APPLICATION_MK_VERSION)) macros:'
	@#echo

_wpt_view_framework_parameters ::
	@echo 'WayPoinT::Application ($(_WAYPOINT_APPLICATION_MK_VERSION)) parameters:'
	@echo '    WPT_APPLICATION_CONFIG_DIRPATH=$(WPT_APPLICATION_CONFIG_DIRPATH)'
	@echo '    WPT_APPLICATION_CONFIG_FILENAME=$(WPT_APPLICATION_CONFIG_FILENAME)'
	@echo '    WPT_APPLICATION_CONFIG_FILEPATH=$(WPT_APPLICATION_CONFIG_FILEPATH)'
	@echo '    WPT_APPLICATION_NAME=$(WPT_APPLICATION_NAME)'
	@echo '    WPT_APPLICATION_PROJECT_DIRPATH=$(WPT_APPLICATION_PROJECT_DIRPATH)'
	@echo '    WPT_APPLICATION_WORKSPACE_NAME=$(WPT_APPLICATION_WORKSPACE_NAME)'
	@echo '    WPT_APPLICATIONS_SET_NAME=$(WPT_APPLICATIONS_SET_NAME)'
	@echo '    WPT_APPLICATIONS_PROJECTS_DIRPATH=$(WPT_APPLICATIONS_PROJECTS_DIRPATH)'
	@echo '    WPT_APPLICATIONS_REGEX=$(WPT_APPLICATIONS_REGEX)'
	@echo

_wpt_view_framework_targets ::
	@echo 'WayPoinT::Application ($(_WAYPOINT_APPLICATION_MK_VERSION)) targets:'
	@echo '    _wpt_create_application             - Create a new application'
	@echo '    _wpt_delete_application             - Delete an existing application'
	@echo '    _wpt_release_application            - Release an application'
	@echo '    _wpt_show_application               - Show everything related to an application'
	@echo '    _wpt_show_application_description   - Show the description of an application'
	@echo '    _wpt_view_applications              - View applications'
	@echo '    _wpt_view_applications_set          - View set of applications'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wpt_create_application:
	@$(INFO) '$(WPT_UI_LABEL)Creating application "$(WPT_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the artifact was not first created/built'; $(NORMAL)
	$(WPT_CREATE_APPLICATION_|) $(WAYPOINT) deploy $(__WPT_APP__APPLICATION) $(__WPT_WORKSPACE__APPLICATION)

_wpt_delete_application:
	@$(INFO) '$(WPT_UI_LABEL)Deleting application "$(WPT_APPLICATION_NAME)" ...'; $(NORMAL)
	$(WPT_DELETE_APPLICATION_|) $(WAYPOINT) destroy $(__WPT_APP__APPLICATION) $(__WPT_WORKSPACE__APPLICATION)

_wpt_release_application:
	@$(INFO) '$(WPT_UI_LABEL)Releasing application "$(WPT_APPLICATION_NAME)" ...'; $(NORMAL)
	$(WPT_RELEASE_APPLICATION_|) $(WAYPOINT) release $(__WPT_APP__APPLICATION) $(__WPT_WORKSPACE__APPLICATION)

_wpt_show_application :: _wpt_show_application_config _wpt_show_application_description

_wpt_show_application_config:
	@$(INFO) '$(WPT_UI_LABEL)Showing config of application "$(WPT_APPLICATION_NAME)" ...'; $(NORMAL)
	cat $(WPT_APPLICATION_CONFIG_FILEPATH)

_wpt_show_application_description:
	@$(INFO) '$(WPT_UI_LABEL)Showing description of application "$(WPT_APPLICATION_NAME)" ...'; $(NORMAL)

_wpt_view_applications:
	@$(INFO) '$(WPT_UI_LABEL)Viewing applications ...'; $(NORMAL)
	$(WPT_VIEW_APPLICATIONS_SET_|) ls -dl * $(|_WPT_VIEW_APPLICATIONS)

_wpt_view_applications_set:
	@$(INFO) '$(WPT_UI_LABEL)Viewing applications-set "$(WPT_APPLICATIONS_SET_NAME)" ...'; $(NORMAL)
	$(WPT_VIEW_APPLICATIONS_SET_|) ls -dl $(WPT_APPLICATIONS_REGEX) $(|_WPT_VIEW_APPLICATIONS_SET)
