_WAYPOINT_ARTIFACT_MK_VERSION= $(_WAYPOINT_MK_VERSION)

# WPT_ARTIFACT_APPLICATION_NAME?= my-app
# WPT_ARTIFACT_NAME?= app
# WPT_ARTIFACT_PROJECT_DIRPATH?= ./src/project/
WPT_ARTIFACTS_REGEX?= *
WPT_ARTIFACTS_SET_NAME?= my-artifacts-set@

# Derived variables
WPT_ARTIFACT_APPLICATION_NAME?= $(WPT_APPLICATION_NAME)
WPT_ARTIFACT_PROJECT_DIRPATH?= $(WPT_PROJECT_DIRPATH)

# Option variables
__WPT_APP__ARTIFACT= $(if $(WPT_ARTIFACT_APPLICATION_NAME),--app $(WPT_ARTIFACT_APPLICATION_NAME))
__WPT_WORKSPACE__ARTIFACT= $(if $(WPT_ARTIFACT_WORKSPACE_NAME),--workspace $(WPT_ARTIFACT_WORKSPACE_NAME))

# UI variables

#--- Pipe variables
WPT_CREATE_ARTIFACT_|?= cd $(WPT_ARTIFACT_PROJECT_DIRPATH) &&
WPT_DELETE_ARTIFACT_|?= cd $(WPT_ARTIFACT_PROJECT_DIRPATH) &&

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_wpt_view_framework_macros ::
	@#echo 'WayPoinT::Artifact ($(_WAYPOINT_ARTIFACT_MK_VERSION)) macros:'
	@#echo

_wpt_view_framework_parameters ::
	@echo 'WayPoinT::Artifact ($(_WAYPOINT_ARTIFACT_MK_VERSION)) parameters:'
	@echo '    WPT_ARTIFACT_APPLICATION_NAME=$(WPT_ARTIFACT_APPLICATION_NAME)'
	@echo '    WPT_ARTIFACT_NAME=$(WPT_ARTIFACT_NAME)'
	@echo '    WPT_ARTIFACT_PROJECT_DIRPATH=$(WPT_ARTIFACT_PROJECT_DIRPATH)'
	@echo '    WPT_ARTIFACTS_SET_NAME=$(WPT_ARTIFACTS_SET_NAME)'
	@echo '    WPT_ARTIFACTS_REGEX=$(WPT_ARTIFACTS_REGEX)'
	@echo

_wpt_view_framework_targets ::
	@echo 'WayPoinT::Artifact ($(_WAYPOINT_ARTIFACT_MK_VERSION)) targets:'
	@echo '    _wpt_create_artifact             - Create a new artifact'
	@echo '    _wpt_delete_artifact             - Delete an existing artifact'
	@echo '    _wpt_show_artifact               - Show everything related to an artifact'
	@echo '    _wpt_show_artifact_description   - Show the description of an artifact'
	@echo '    _wpt_view_artifacts              - View artifacts'
	@echo '    _wpt_view_artifacts_set          - View set of artifacts'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wpt_create_artifact:
	@$(INFO) '$(WPT_UI_LABEL)Creating artifact "$(WPT_ARTIFACT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the project was not first initialized'; $(NORMAL)
	$(WPT_CREATE_ARTIFACT_|) $(WAYPOINT) build $(__WPT_APP__ARTIFACT) $(__WPT_WORKSPACE__ARTIFACT)

_wpt_delete_artifact:
	@$(INFO) '$(WPT_UI_LABEL)Deleting artifact "$(WPT_ARTIFACT_NAME)" ...'; $(NORMAL)

_wpt_show_artifact :: _wpt_show_artifact_description

_wpt_show_artifact_description:
	@$(INFO) '$(WPT_UI_LABEL)Showing description of artifact "$(WPT_ARTIFACT_NAME)" ...'; $(NORMAL)

_wpt_view_artifacts:
	@$(INFO) '$(WPT_UI_LABEL)Viewing artifacts ...'; $(NORMAL)

_wpt_view_artifacts_set:
	@$(INFO) '$(WPT_UI_LABEL)Viewing artifacts-set "$(WPT_ARTIFACTS_SET_NAME)" ...'; $(NORMAL)
