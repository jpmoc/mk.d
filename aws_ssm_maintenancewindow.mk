_AWS_SSM_MAINTENANCEWINDOW_MK_VERSION =$(_AWS_SSM_MK_VERSION)

# SSM_MAINTENANCEWINDOW_CUTOFF?= 1 
# SSM_MAINTENANCEWINDOW_DESCRIPTION?= "This is my maintenance-window description"
# SSM_MAINTENANCEWINDOW_DURATION?= 4
# SSM_MAINTENANCEWINDOW_ID?= mw-0dee1788aef5312b6
# SSM_MAINTENANCEWINDOW_NAME?=
# SSM_MAINTENANCEWINDOW_SCHEDULE?= "cron(0 16 ? * TUE *)"
# SSM_MAINTENANCEWINDOW_TARGET?= Key=InstanceIds,Values=i-0000293ffd8c57862
# SSM_MAINTENANCEWINDOW_TARGET_CLOUDWATCHTAG?= "Single instance"
# SSM_MAINTENANCEWINDOW_TARGET_DESCRIPTION?= "This is my target description"
# SSM_MAINTENANCEWINDOW_TARGET_ID?=
# SSM_MAINTENANCEWINDOW_TARGET_NAME?= my-target
# SSM_MAINTENANCEWINDOW_TARGET_SAFE?= false
# SSM_MAINTENANCEWINDOW_TARGET_TYPE?= INSTANCE
# SSM_MAINTENANCEWINDOW_UNASSOCIATED_TARGETS?= true
# SSM_MAINTENANCEWINDOWS_SET_NAME?= my-maintenance-window

# Derived variables

# Option variables
__SSM_ALLOW_UNASSOCIATED_TARGETS= $(if $(filter true, $(SSM_MAINTENANCE_UNASSOCIATED_TARGETS)), --allow-unassociated-targets, --no-allow-unassociated-targets)
__SSM_CUTOFF= $(if $(SSM_MAINTENANCEWINDOW_CUTOFF), --cutoff $(SSM_MAINTENANCEWINDOW_CUTOFF))
__SSM_DESCRIPTION_MAINTENANCEWINDOW= $(if $(SSM_MAINTENANCEWINDOW_DESCRIPTION), --description $(SSM_MAINTENANCEWINDOW_DESCRIPTION))
__SSM_DESCRIPTION_TARGET= $(if $(SSM_MAINTENANCEWINDOW_TARGET_DESCRIPTION), --description $(SSM_MAINTANCEWINDOW_TARGET_DESCRIPTION))
__SSM_DURATION= $(if $(SSM_MAINTENANCEWINDOW_DURATION), --duration $(SSM_MAINTENANCEWINDOW_DURATION))
__SSM_FILTERS_MAINTENANCEWINDOW=
__SSM_FILTERS_TARGETS=
__SSM_FILTERS_TASK=
__SSM_NAME_MAINTENANCEWINDOW= $(if $(SSM_MAINTENANCEWINDOW_NAME), --name $(SSM_MAINTENANCEWINDOW_NAME))
__SSM_NAME_TARGET= $(if $(SSM_MAINTENANCEWINDOW_TARGET_NAME), --name $(SSM_MAINTANCEWINDOW_TARGET_NAME))
__SSM_OWNER_INFORMATION= $(if $(SSM_MAINTENANCEWINDOW_TARGET_CLOUDWATCHTAG), --owner-information $(SSM_MAINTANCEWINDOW_TARGET_CLOUDWATCHTAG))
__SSM_RESOURCE_TYPE= $(if $(SSM_MAINTENANCEWINDOW_TARGET_TYPE), --resource-type $(SSM_MAINTANCEWINDOW_TARGET_TYPE))
__SSM_SAFE= $(if $(filter false, $(SSM_MAINTENANCEWINDOW_TARGET_SAFE)), --no-safe, --safe)
__SSM_SCHEDULE= $(if $(SSM_MAINTENANCEWINDOW_SCHEDULE), --schedule $(SSM_MAINTENANCEWINDOW_SCHEDULE))
__SSM_TARGET= $(if $(SSM_MAINTENANCEWINDOW_TARGET), --target $(SSM_MAINTANCEWINDOW_TARGET))
__SSM_WINDOW_ID= $(if $(SSM_MAINTENANCEWINDOW_ID), --window-id $(SSM_MAINTENANCEWINDOW_ID))
__SSM_WINDOW_TARGET_ID= $(if $(SSM_MAINTENANCEWINDOW_TARGET_ID), --window-target-id $(SSM_MAINTENANCEWINDOW_TARGET_ID))

# UI variables
SSM_UI_VIEW_MAINTENANCEWINDOWS_FIELDS?= .{cutoff:Cutoff,description:Description,duration:Duration,enabled:Enabled,Name:Name,WindowId:WindowId}
SSM_UI_VIEW_MAINTENANCEWINDOWS_SET_FIELDS?= $(SSM_UI_VIEW_MAINTENANCEWINDOWS_FIELDS)

#--- Utilities

#--- MACRO
_ssm_get_maintenancewindow_id= $(call _ssm_get_maintenancewindow_id_N, $(SSM_MAINTENANCEWINDOW_NAME))
_ssm_get_maintenancewindow_id_N= $(shell $(AWS) ssm describe-maintenance-windows --filters Key=Name,Values=$(strip $(1)) --query "WindowIdentities[].WindowId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ssm_view_makefile_macros ::
	@echo 'AWS::SSM::Document ($(_AWS_SSM_MAINTENANCEWINDOW_MK_VERSION)) macros:'
	@echo '    _ssm_get_maintenancewindow_id_{|N}                   - Get a maintenance-window ID (Name)'
	@echo

_ssm_view_makefile_targets ::
	@echo 'AWS::SSM::Document ($(_AWS_SSM_MAINTENANCEWINDOW_MK_VERSION)) targets:'
	@echo '    _ssm_create_maintenancewindows                       - Create a maintenance-windows'
	@echo '    _ssm_delete_maintenancewindows                       - Delete a maintenance-windows'
	@echo '    _ssm_register_target                                 - Register a target with a maintenance-windows'
	@echo '    _ssm_show_maintenancewindow                          - Show details of a maintenance-windows'
	@echo '    _ssm_show_maintenancewindow_overview                 - Show overview of a maintenance-windows'
	@echo '    _ssm_show_maintenancewindow_targets                  - Show targets of a maintenance-windows'
	@echo '    _ssm_show_maintenancewindow_tasks                    - Show tasks of a maintenance-windows'
	@echo '    _ssm_unregister_target                               - Deegister a target with a maintenance-windows'
	@echo '    _ssm_view_maintenancewindows                         - View maintenance-windows'
	@echo '    _ssm_view_maintenancewindows_set                     - View a set of maintenance-windows'
	@echo

_ssm_view_makefile_variables ::
	@echo 'AWS::SSM::Document ($(_AWS_SSM_MAINTENANCEWINDOW_MK_VERSION)) variables:'
	@echo '    SSM_MAINTENANCEWINDOW_CUTOFF=$(SSM_MAINTENANCEWINDOW_CUTOFF)'
	@echo '    SSM_MAINTENANCEWINDOW_DESCRIPTION=$(SSM_MAINTENANCEWINDOW_DESCRIPTION)'
	@echo '    SSM_MAINTENANCEWINDOW_DURATION=$(SSM_MAINTENANCEWINDOW_DURATION)'
	@echo '    SSM_MAINTENANCEWINDOW_ID=$(SSM_MAINTENANCEWINDOW_ID)'
	@echo '    SSM_MAINTENANCEWINDOW_NAME=$(SSM_MAINTENANCEWINDOW_NAME)'
	@echo '    SSM_MAINTENANCEWINDOW_SCHEDULE=$(SSM_MAINTENANCEWINDOW_SCHEDULE)'
	@echo '    SSM_MAINTENANCEWINDOW_TARGET=$(SSM_MAINTENANCEWINDOW_TARGET)'
	@echo '    SSM_MAINTENANCEWINDOW_TARGET_CLOUDWATCHTAG=$(SSM_MAINTENANCEWINDOW_TARGET_CLOUDWATCHTAG)'
	@echo '    SSM_MAINTENANCEWINDOW_TARGET_DESCRIPTION=$(SSM_MAINTENANCEWINDOW_TARGET_DESCRIPTION)'
	@echo '    SSM_MAINTENANCEWINDOW_TARGET_ID=$(SSM_MAINTENANCEWINDOW_TARGET_ID)'
	@echo '    SSM_MAINTENANCEWINDOW_TARGET_NAME=$(SSM_MAINTENANCEWINDOW_TARGET_NAME)'
	@echo '    SSM_MAINTENANCEWINDOW_TARGET_SAFE=$(SSM_MAINTENANCEWINDOW_TARGET_SAFE)'
	@echo '    SSM_MAINTENANCEWINDOW_TARGET_TYPE=$(SSM_MAINTENANCEWINDOW_TARGET_TYPE)'
	@echo '    SSM_MAINTENANCEWINDOWS_SET__NAME=$(SSM_MAINTENANCEWINDOWS_SET_NAME)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ssm_create_maintenancewindow:
	@$(INFO) '$(AWS_UI_LABEL)Creating maintenance-window "$(SSM_MAINTENANCEWINDOW_NAME)" ...'; $(NORMAL)
	$(AWS) ssm create-maintenance-window $(__SSM_ALLOW_UNASSOCIATED_TARGETS) $(__SSM_CUTOFF) $(__SSM_DESCRIPTION_MAINTENANCEWINDOW) $(__SSM_DURATION) $(__SSM_NAME_MAINTENANCEWINDOW) $(__SSM_SCHEDULE)

_ssm_delete_maintenancewindow:
	@$(INFO) '$(AWS_UI_LABEL)Deleting maintenance-window "$(SSM_MAINTENANCEWINDOW_NAME)" ...'; $(NORMAL)
	$(AWS) ssm delete-maintenance-window $(__SSM_WINDOW_ID)

_ssm_register_target:
	@$(INFO) '$(AWS_UI_LABEL)Registering target "$(SSM_MAINTENANCEWINDOW_TARGET_NAME)" with maintenance-window "$(SSM_MAINTENANCEWINDOW_NAME)" ...'; $(NORMAL)
	$(AWS) ssm register-target-with-maintenance-window $(__SSM_DESCRIPTION_TARGET) $(__SSM_NAME_TARGET) $(__SSM_RESOURCE_TYPE) $(__SSM_TARGET) $(__SSM_WINDOW_ID)

_ssm_show_maintenancewindow: _ssm_show_maintenancewindow_targets _ssm_show_maintenancewindow_tasks _ssm_show_maintenancewindow_overview

_ssm_show_maintenancewindow_overview:
	@$(INFO) '$(AWS_UI_LABEL)Showing overview of the maintenance-window "$(SSM_MAINTENANCEWINDOW_NAME)" ...'; $(NORMAL)
	$(AWS) ssm get-maintenance-window $(__SSM_WINDOW_ID)

_ssm_show_maintenancewindow_targets:
	@$(INFO) '$(AWS_UI_LABEL)Showing targets of the maintenance-window "$(SSM_MAINTENANCEWINDOW_NAME)" ...'; $(NORMAL)
	$(AWS) ssm describe-maintenance-window-targets $(__SSM_FILTERS_TARGETS) $(__SSM_WINDOW_ID)

_ssm_show_maintenancewindow_tasks:
	@$(INFO) '$(AWS_UI_LABEL)Showing tasks of the maintenance-window "$(SSM_MAINTENANCEWINDOW_NAME)" ...'; $(NORMAL)
	$(AWS) ssm describe-maintenance-window-tasks $(__SSM_FILTERS_TASK) $(__SSM_WINDOW_ID)

_ssm_unregister_target:
	@$(INFO) '$(AWS_UI_LABEL)Deregistering target "$(SSM_MAINTENANCEWINDOW_TARGET_NAME)" from maintenance-window "$(SSM_MAINTENANCEWINDOW_NAME)" ...'; $(NORMAL)
	$(AWS) ssm deregister-target-from-maintenance-window $(__SSM_SAFE) $(__SSM_WINDOW_ID) $(__SSM_WINDOW_TARGET_ID)

_ssm_view_maintenancewindows:
	@$(INFO) '$(AWS_UI_LABEL)Viewing maintenance-windows ...'; $(NORMAL)
	$(AWS) ssm describe-maintenance-windows $(_X__SSM_FILTERS_MAINTENANCEWINDOW) --query "WindowIdentities[]$(SSM_UI_VIEW_MAINTENANCEWINDOWS_FIELDS)"

_ssm_view_maintenancewindows_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing maintenance-windows-set "$(SSM_MAINTENANCEWINDOWS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) ssm describe-maintenance-windows $(__SSM_FILTERS_MAINTENANCEWINDOW) --query "WindowIdentities[]$(SSM_UI_VIEW_MAINTENANCEWINDOWS_SET_FIELDS)"
