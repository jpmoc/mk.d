_WAYPOINT_PROJECT_MK_VERSION= $(_WAYPOINT_MK_VERSION)

# WPT_PROJECT_CONFIG_DIRPATH?= ./
WPT_PROJECT_CONFIG_FILENAME?= waypoint.hcl
# WPT_PROJECT_CONFIG_FILEPATH?= ./waypoint.hcl
WPT_PROJECT_DIRPATH?= ./
# WPT_PROJECT_NAME?= my-project
# WPT_PROJECT_README_DIRPATH?= ./
WPT_PROJECT_README_FILENAME?= README
# WPT_PROJECT_README_FILEPATH?= ./waypoint.hcl
WPT_PROJECT_WORKSPACE_NAME?= default
WPT_PROJECTS_REGEX?= *
WPT_PROJECTS_SET_NAME?= my-projects-set@
WPT_PROJECTS_DIRPATH?= ../

# Derived variables
WPT_PROJECT_CONFIG_DIRPATH?= $(WPT_PROJECT_DIRPATH)
WPT_PROJECT_CONFIG_FILEPATH?= $(WPT_PROJECT_CONFIG_DIRPATH)$(WPT_PROJECT_CONFIG_FILENAME)
WPT_PROJECT_README_DIRPATH?= $(WPT_PROJECT_DIRPATH)
WPT_PROJECT_README_FILEPATH?= $(WPT_PROJECT_README_DIRPATH)$(WPT_PROJECT_README_FILENAME)

# Option variables
__WPT_WORKSPACE= $(if $(WPT_PROJECT_WORKSPACE_NAME),--workspace $(WPT_PROJECT_WORKSPACE_NAME))

# UI variables

#--- Pipe variables
WPT_INIT_PROJECT_|?= cd $(WPT_PROJECT_DIRPATH) &&
WPT_VIEW_PROJECTS_|?= cd $(WPT_PROJECTS_DIRPATH) &&
WPT_VIEW_PROJECTS_SET_|?= cd $(WPT_PROJECTS_SOURCES_DIRPATH) &&
|_WPT_VIEW_PROJECTS?= | grep -v README
|_WPT_VIEW_PROJECTS_SET?= | grep -v README

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_wpt_view_framework_macros ::
	@#echo 'WayPoinT::Project ($(_WAYPOINT_PROJECT_MK_VERSION)) macros:'
	@#echo

_wpt_view_framework_parameters ::
	@echo 'WayPoinT::Project ($(_WAYPOINT_PROJECT_MK_VERSION)) parameters:'
	@echo '    WPT_PROJECT_CONFIG_DIRPATH=$(WPT_PROJECT_CONFIG_DIRPATH)'
	@echo '    WPT_PROJECT_CONFIG_FILENAME=$(WPT_PROJECT_CONFIG_FILENAME)'
	@echo '    WPT_PROJECT_CONFIG_FILEPATH=$(WPT_PROJECT_CONFIG_FILEPATH)'
	@echo '    WPT_PROJECT_DIRPATH=$(WPT_PROJECT_DIRPATH)'
	@echo '    WPT_PROJECT_NAME=$(WPT_PROJECT_NAME)'
	@echo '    WPT_PROJECT_README_DIRPATH=$(WPT_PROJECT_README_DIRPATH)'
	@echo '    WPT_PROJECT_README_FILENAME=$(WPT_PROJECT_README_FILENAME)'
	@echo '    WPT_PROJECT_README_FILEPATH=$(WPT_PROJECT_README_FILEPATH)'
	@echo '    WPT_PROJECT_WORKSPACE_NAME=$(WPT_PROJECT_WORKSPACE_NAME)'
	@echo '    WPT_PROJECTS_SET_NAME=$(WPT_PROJECTS_SET_NAME)'
	@echo '    WPT_PROJECTS_SOURCES_DIRPATH=$(WPT_PROJECTS_SOURCES_DIRPATH)'
	@echo '    WPT_PROJECTS_REGEX=$(WPT_PROJECTS_REGEX)'
	@echo

_wpt_view_framework_targets ::
	@echo 'WayPoinT::Project ($(_WAYPOINT_PROJECT_MK_VERSION)) targets:'
	@echo '    _wpt_init_project               - Initialize a new project'
	@echo '    _wpt_create_project             - Create a new project'
	@echo '    _wpt_delete_project             - Delete an existing project'
	@echo '    _wpt_show_project               - Show everything related to an project'
	@echo '    _wpt_show_project_description   - Show the description of an project'
	@echo '    _wpt_uninit_project             - Un-Initialize a project'
	@echo '    _wpt_view_projects              - View projects'
	@echo '    _wpt_view_projects_set          - View set of projects'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wpt_init_project:
	@$(INFO) '$(WPT_UI_LABEL)Initializing project "$(WPT_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the waypoint server was not first deployed'; $(NORMAL)
	$(WPT_INIT_PROJECT_|) $(WAYPOINT) init

_wpt_create_project:
	@$(INFO) '$(WPT_UI_LABEL)Creating project "$(WPT_PROJECT_NAME)" ...'; $(NORMAL)

_wpt_delete_project:
	@$(INFO) '$(WPT_UI_LABEL)Deleting project "$(WPT_PROJECT_NAME)" ...'; $(NORMAL)

_wpt_show_project :: _wpt_show_project_config _wpt_show_project_content _wpt_show_project_description

_wpt_show_project_config:
	@$(INFO) '$(WPT_UI_LABEL)Showing config of project "$(WPT_PROJECT_NAME)" ...'; $(NORMAL)
	cat $(WPT_PROJECT_CONFIG_FILEPATH)

_wpt_show_project_content:
	@$(INFO) '$(WPT_UI_LABEL)Showing content of project "$(WPT_PROJECT_NAME)" ...'; $(NORMAL)
	tree -la $(WPT_PROJECT_DIRPATH)

_wpt_show_project_description:
	@$(INFO) '$(WPT_UI_LABEL)Showing description of project "$(WPT_PROJECT_NAME)" ...'; $(NORMAL)
	[ -f $(WPT_PROJECT_README_FILEPATH) ] && cat $(WPT_PROJECT_README_FILEPATH) || true

_wpt_uninit_project:
	@$(INFO) '$(WPT_UI_LABEL)Un-initializing project "$(WPT_PROJECT_NAME)" ...'; $(NORMAL)
	rm -rf $(WPT_PROJECT_DIRPATH).waypoint

_wpt_view_projects:
	@$(INFO) '$(WPT_UI_LABEL)Viewing projects ...'; $(NORMAL)
	$(WPT_VIEW_PROJECTS_SET_|) ls -dl * $(|_WPT_VIEW_PROJECTS)

_wpt_view_projects_set:
	@$(INFO) '$(WPT_UI_LABEL)Viewing projects-set "$(WPT_PROJECTS_SET_NAME)" ...'; $(NORMAL)
	$(WPT_VIEW_PROJECTS_SET_|) ls -dl $(WPT_PROJECTS_REGEX) $(|_WPT_VIEW_PROJECTS_SET)
