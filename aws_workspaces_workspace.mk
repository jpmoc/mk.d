_AWS_WORKSPACES_WORKSPACE_MK_VERSION= $(_AWS_WORKSPACES_MK_VERSION)

# WSS_WORKSPACE_CONFIGURATION?= DirectoryId=string,UserName=string,BundleId=string,VolumeEncryptionKey=string,UserVolumeEncryptionEnabled=boolean,RootVolumeEncryptionEnabled=boolean,WorkspaceProperties={RunningMode=string,RunningModeAutoStopTimeoutInMinutes=integer,RootVolumeSizeGib=integer,UserVolumeSizeGib=integer,ComputeTypeName=string},Tags=[{Key=string,Value=string},{Key=string,Value=string}] ...
# WSS_WORKSPACE_CONFIGURATION_FILEPATH?= ./workspace-configuration.json
# WSS_WORKSPACE_ID?=
# WSS_WORKSPACE_IDS?=
# WSS_WORSKAPCE_NAME?=
# WSS_WORKSPACE_PROPERTIES?= RunningMode=string,RunningModeAutoStopTimeoutInMinutes=integer,RootVolumeSizeGib=integer,UserVolumeSizeGib=integer,ComputeTypeName=string
# WSS_WORKSPACE_PROPERTIES_FILEPATH?= ./workspace-properties.json
# WSS_WORKSPACE_STATE?= ADMIN_MAINTENANCE
# WSS_WORKSPACES_SET_NAME?= my-worpsaces-set

# Derived parameters
WSS_WORKSPACE_IDS?= $(WSS_WORSPACE_ID)
WSS_WORKSPACE_CONFIGURATION?= $(if $(WSS_WORKSPACE_CONFIGURATION_FILEPATH),file://$(WSS_WORKSPACE_CONFIGURATION_FILEPATH))
WSS_WORKSPACE_PROPERTIES?= $(if $(WSS_WORKSPACE_PROPERTIES_FILEPATH),file://$(WSS_WORKSPACE_PROPERTIES_FILEPATH))

# Option parameters
__WSS_BUNDLE_ID=
__WSS_DIRECTORY_ID=
__WSS_REBOOT_WORKSPACE_REQUESTS=
__WSS_START_WORKSPACE_REQUESTS=
__WSS_STOP_WORKSPACE_REQUESTS=
__WSS_TERMINATE_WORKSPACE_REQUESTS=
__WSS_USER_NAME=
__WSS_WORKSPACE_ID= $(if $(WSS_WORKSPACE_ID), --workspace-id $(WSS_WORSPACE_ID))
__WSS_WORKSPACE_PROPERTIES= $(if $(WSS_WORKSPACE_PROPERTIES), --workspace-properties $(WSS_WORSPACE_PROPERTIES))
__WSS_WORKSPACE_STATE= $(if $(WSS_WORKSPACE_STATE), --workspace-state $(WSS_WORSPACE_STATE))
__WSS_WORKSPACES= $(if $(WSS_WORKSPACE_CONFIGURATION), --workspaces $(WSS_WORKSPACE_CONFIGURATION))
__WSS_WORKSPACES_IDS= $(if $(WSS_WORKSPACE_IDS), --workspace-ids $(WSS_WORKSPACE_IDS))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_wss_view_framework_macros ::
	@#echo 'AWS::WorkSpaceS::workspace ($(_AWS_WORKSPACES_WORKSPACE_MK_VERSION)) macros:'
	@#echo

_wss_view_framework_parameters ::
	@echo 'AWS::WorkSpaceS::workspace ($(_AWS_WORKSPACES_WORKSPACE_MK_VERSION)) parameters:'
	@echo '    WSS_WORKSPACE_CONFIGURATION=$(WSS_WORKSPACE_CONFIGURATION)'
	@echo '    WSS_WORKSPACE_CONFIGURATION_FILEPATH=$(WSS_WORKSPACE_CONFIGURATION_FILEPATH)'
	@echo '    WSS_WORKSPACE_ID=$(WSS_WORKSPACE_ID)'
	@echo '    WSS_WORKSPACE_IDS=$(WSS_WORKSPACE_IDS)'
	@echo '    WSS_WORKSPACE_NAME=$(WSS_WORKSPACE_NAME)'
	@echo '    WSS_WORKSPACE_PROPERTIES=$(WSS_WORKSPACE_PROPERTIES)'
	@echo '    WSS_WORKSPACE_PROPERTIES_FILEPATH=$(WSS_WORKSPACE_PROPERTIES_FILEPATH)'
	@echo '    WSS_WORKSPACE_STATE=$(WSS_WORKSPACE_STATE)'
	@echo '    WSS_WORKSPACES_SET_MAME=$(WSS_WORKSPACES_SET_NAME)'
	@echo

_wss_view_framework_targets ::
	@echo 'AWS::WorkSpaceS::workspace ($(_AWS_WORKSPACES_WORKSPACE_MK_VERSION)) targets:'
	@echo '    _wss_create_workspace                       - Create a new workspace'
	@echo '    _wss_delete_workspace                       - Delete an existing workspace'
	@echo '    _wss_reboot_workspace                       - Reboot a workspace'
	@echo '    _wss_start_workspace                        - Start a workspace'
	@echo '    _wss_stop_workspace                         - Stop a workspace'
	@echo '    _wss_terminate_workspace                    - Terminate a workspace'
	@echo '    _wss_update_workspace_properties            - Update properties of a workspace'
	@echo '    _wss_update_workspace_state                 - Update the state of a workspace'
	@echo '    _wss_view_workspaces                        - View existing workspaces'
	@echo '    _wss_view_workspaces_set                    - View a set of workspaces'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wss_create_workspace:
	@$(INFO) '$(AWS_UI_LABEL)Creqting workspace "$(WSS_WORKSPACE_NAME)" ...'; $(NORMAL)
	$(AWS) workspaces create-workspaces $(__WSS_WORKSPACES)

_wss_delete_workspace:
	@$(INFO) '$(AWS_UI_LABEL)Deleting/terminating workspace "$(WSS_WORKSPACE_NAME)" ...'; $(NORMAL)
	$(AWS) workspaces terminate-workspaces $(__WSS_TERMINATE_WORKSPACE_REQUESTS)

_wss_reboot_workspace:
	@$(INFO) '$(AWS_UI_LABEL)Rebooting workspace "$(WSS_WORKSPACE_NAME)" ...'; $(NORMAL)
	$(AWS) workspaces reboot-workspaces $(__WSS_REBOOT_WORKSPACE_REQUESTS)

_wss_rebuild_workspace:
	@$(INFO) '$(AWS_UI_LABEL)Rebuilding workspace "$(WSS_WORKSPACE_NAME)" ...'; $(NORMAL)
	$(AWS) workspaces rebuild-workspaces $(__WSS_REBOOT_WORKSPACE_REQUESTS)

_wss_start_workspace:
	@$(INFO) '$(AWS_UI_LABEL)Starting workspace "$(WSS_WORKSPACE_NAME)" ...'; $(NORMAL)
	$(AWS) workspaces start-workspaces $(__WSS_START_WORKSPACE_REQUESTS)

_wss_stop_workspace:
	@$(INFO) '$(AWS_UI_LABEL)Stopping workspace "$(WSS_WORKSPACE_NAME)" ...'; $(NORMAL)
	$(AWS) workspaces stop-workspaces $(__WSS_STOP_WORKSPACE_REQUESTS)

_wss_terminate_workspace: _wss_delete_workspace

_wss_update_workspace_properties:
	@$(INFO) '$(AWS_UI_LABEL)Updating/modifying properties of workspace "$(WSS_WORKSPACE_NAME)" ...'; $(NORMAL)
	$(AWS) workspaces modigy-workspace-properties $(__WSS_WORKSPACE_ID) $(__WSS_WORKSPACE_PROPERTIES)

_wss_update_workspace_state:
	@$(INFO) '$(AWS_UI_LABEL)Updating/modifying state of workspace "$(WSS_WORKSPACE_NAME)" ...'; $(NORMAL)
	$(AWS) workspaces modigy-workspace-state $(__WSS_WORKSPACE_ID) $(__WSS_WORKSPACE_STATE)

_wss_view_workspaces:
	@$(INFO) '$(AWS_UI_LABEL)Viewing workspaces ...'; $(NORMAL)
	$(AWS) workspaces describe-workspaces $(__WSS_BUNDLE_ID) $(__WSS_DIRECTORY_ID) $(__WSS_USER_NAME) $(_X__WSS_WORKSPACE_IDS)

_wss_view_workspaces_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing workspaces-set "$(WSS_WORKSPACES_SET_NAME)" ...'; $(NORMAL)
	$(AWS) workspaces describe-workspaces $(__WSS_BUNDLE_ID) $(__WSS_DIRECTORY_ID) $(__WSS_USER_NAME) $(__WSS_WORKSPACE_IDS)
