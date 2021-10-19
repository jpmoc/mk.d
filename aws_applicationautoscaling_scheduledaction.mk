_AWS_APPLICATIONAUTOSCALING_SCHEDULEDACTION_MK_VERSION= $(_AWS_APPLICATIONAUTOSCALING_MK_VERSION)

# AAG_SCHEDULEDACTION_NAME?= 
# AAG_SCHEDULEDACTION_NAMES?= 
# AAG_SCHEDULEDACTION_RESOURCE_ID?= 
# AAG_SCHEDULEDACTION_SCALABLE_DIMENSION?= 
# AAG_SCHEDULEDACTION_SERVICE_NAMESPACE?= ec2
# AAG_SCHEDULEDACTIONS_SET_NAME?= 

# Derived parameters
AAG_SCHEDULEDACTION_NAMES?= $(AAG_SCHEDULEDACTION_NAME)
AAG_SCHEDULEDACTION_SERVICE_NAMESPACE?= $(AAG_SERVICE_NAMESPACE)

# Option parameters
__AAG_RESOURCE_ID__SCHEDULEDACTION= $(if $(AAG_SCHEDULEDACTION_RESOURCE_ID), --resource-id $(AAG_SCHEDULEDACTION_RESOURCE_ID))
__AAG_SCALABLE_DIMENSION__SCHEDULEDACTION= $(if $(AAG_SCHEDULEDACTION_SCALABLE_DIMENSION), --scalable-dimension $(AAG_SCHEDULEDACTION_SCALABLE_DIMENSION))
__AAG_SCHEDULED_ACTION_NAMES= $(if $(AAG_SCHEDULEDACTION_NAMES), --scheduled-action-names $(AAG_SCHEDULEDACTION_NAMES))
__AAG_SERVICE_NAMESPACE__SCHEDULEDACTION= $(if $(AAG_SCHEDULEDACTION_SERVICE_NAMESPACE), --service-namespace $(AAG_SCHEDULEDACTION_SERVICE_NAMESPACE))

# UI parameters
AAG_UI_VIEW_SCHEDULEDACTIONS_FIELDS?=
AAG_UI_VIEW_SCHEDULEDACTIONS_SET_FIELDS?= $(AAG_UI_VIEW_SCHEDULEDACTIONS_FIELDS)
AAG_UI_VIEW_SCHEDULEDACTIONS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aag_view_framework_macros ::
	@echo 'AWS::ApplicationAutoscalinG::ScheduledAction ($(_AWS_APPLICATIONAUTOSCALING_SCHEDULEDACTION_MK_VERSION)) macros:'
	@echo

_aag_view_framework_parameters ::
	@echo 'AWS::ApplicationAutoscalinG::ScheduledAction ($(_AWS_APPLICATIONAUTOSCALING_SCHEDULEDACTION_MK_VERSION)) parameters:'
	@echo '    AAG_SCHEDULEDACTION_NAME=$(AAG_SCHEDULEDACTION_NAME)'
	@echo '    AAG_SCHEDULEDACTION_NAMES=$(AAG_SCHEDULEDACTION_NAMES)'
	@echo '    AAG_SCHEDULEDACTION_RESOURCE_ID=$(AAG_SCHEDULEDACTION_RESOURCE_ID)'
	@echo '    AAG_SCHEDULEDACTION_SCALABLE_DIMENSION=$(AAG_SCHEDULEDACTION_SCALABLE_DIMENSION)'
	@echo '    AAG_SCHEDULEDACTION_SERVICE_NAMESPACE=$(AAG_SCHEDULEDACTION_SERVICE_NAMESPACE)'
	@echo '    AAG_SCHEDULEDACTIONS_SET_NAME=$(AAG_SCHEDULEDACTIONS_SET_NAME)'
	@echo

_aag_view_framework_targets ::
	@echo 'AWS::ApplicationAutoscalinG::ScheduledAction ($(_AWS_APPLICATIONAUTOSCALING_SCHEDULEDACTION_MK_VERSION)) targets:'A
	@echo '    _aag_create_scheduledaction               - Create a new scheduled-action'
	@echo '    _aag_delete_scheduledaction               - Delete an existing scheduled-action'
	@echo '    _aag_show_scheduledaction                 - Show everything related to a scheduled-action'
	@echo '    _aag_view_scheduledactions                - View scheduled-actions'
	@echo '    _aag_view_scheduledactions_set            - View a set of scheduled-actions'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aag_create_scheduledaction:

_aag_delete_scheduledaction:

_aag_show_scheduledaction:

_aag_view_scheduledactions:
	@$(INFO) '$(AWS_UI_LABEL)Viewing scheduled-actions ...'; $(NORMAL)
	$(AWS) application-autoscaling describe-scheduled-actions $(__AAG_RESOURCE_ID__SCHEDULEDACTION) $(__AAG_SCALABLE_DIMENSION__SCHEDULEDACTION) $(__AAG_SCHEDULED_ACTION_NAMES) $(__AAG_SERVICE_NAMESPACE__SCHEDULEDACTION)

_aag_view_scheduledactions_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing scheduled-actions-set "$(AAG_SCHEDULEDACTIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Scaling-policies are grouped based on the provided scaling-policy-names, resource-ids, ... and/or slice'; $(NORMAL)
	$(AWS) application-autoscaling describe-scheduled-actions $(__AAG_RESOURCE_ID__SCHEDULEDACTION) $(__AAG_SCALABLE_DIMENSION__SCHEDULEDACTION) $(__AAG_SCHEDULED_ACTION_NAMES) $(__AAG_SERVICE_NAMESPACE__SCHEDULEDACTION)
