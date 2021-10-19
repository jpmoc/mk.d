_AWS_APPLICATIONAUTOSCALING_SCALABLETARGET_MK_VERSION= $(_AWS_APPLICATIONAUTOSCALING_MK_VERSION)

# AAG_SCALABLETARGET_RESOURCE_ID?= 
# AAG_SCALABLETARGET_SCALABLE_DIMENSION?= 
# AAG_SCALABLETARGET_SERVICE_NAMESPACE?= ec2
# AAG_SCALABLETARGETS_SET_NAME?= 

# Derived parameters
AAG_SCALABLETARGET_SERVICE_NAMESPACE?= $(AAG_SERVICE_NAMESPACE)

# Option parameters
__AAG_RESOURCE_ID__SCALABLETARGET= $(if $(AAG_SCALABLETARGET_RESOURCE_ID), --resource-id $(AAG_SCALABLETARGET_RESOURCE_ID))
__AAG_SCALABLE_DIMENSION__SCALABLETARGET= $(if $(AAG_SCALABLETARGET_SCALABLE_DIMENSION), --scalable-dimension $(AAG_SCALABLETARGET_SCALABLE_DIMENSION))
__AAG_SERVICE_NAMESPACE__SCALABLETARGET= $(if $(AAG_SCALABLETARGET_SERVICE_NAMESPACE), --service-namespace $(AAG_SCALABLETARGET_SERVICE_NAMESPACE))

# UI parameters
AAG_UI_VIEW_SCALABLETARGETS_FIELDS?=
AAG_UI_VIEW_SCALABLETARGETS_SET_FIELDS?= $(AAG_UI_VIEW_SCALABLETARGETS_FIELDS)
AAG_UI_VIEW_SCALABLETARGETS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aag_view_framework_macros ::
	@echo 'AWS::ApplicationAutoscalinG::ScheduledAction ($(_AWS_APPLICATIONAUTOSCALING_SCALABLETARGET_MK_VERSION)) macros:'
	@echo

_aag_view_framework_parameters ::
	@echo 'AWS::ApplicationAutoscalinG::ScheduledAction ($(_AWS_APPLICATIONAUTOSCALING_SCALABLETARGET_MK_VERSION)) parameters:'
	@echo '    AAG_SCALABLETARGET_RESOURCE_ID=$(AAG_SCALABLETARGET_RESOURCE_ID)'
	@echo '    AAG_SCALABLETARGET_SCALABLE_DIMENSION=$(AAG_SCALABLETARGET_SCALABLE_DIMENSION)'
	@echo '    AAG_SCALABLETARGET_SERVICE_NAMESPACE=$(AAG_SCALABLETARGET_SERVICE_NAMESPACE)'
	@echo '    AAG_SCALABLETARGETS_SET_NAME=$(AAG_SCALABLETARGETS_SET_NAME)'
	@echo

_aag_view_framework_targets ::
	@echo 'AWS::ApplicationAutoscalinG::ScheduledAction ($(_AWS_APPLICATIONAUTOSCALING_SCALABLETARGET_MK_VERSION)) targets:'A
	@echo '    _aag_create_scalabletarget               - Create a new scalable-target'
	@echo '    _aag_delete_scalabletarget               - Delete an existing scalable-target'
	@echo '    _aag_show_scalabletarget                 - Show everything related to a scalable-target'
	@echo '    _aag_view_scalabletargets                - View scalable-targets'
	@echo '    _aag_view_scalabletargets_set            - View a set of scalable-targets'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aag_create_scalabletarget:

_aag_delete_scalabletarget:

_aag_show_scalabletarget:

_aag_view_scalabletargets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing scalable-targets ...'; $(NORMAL)
	$(AWS) application-autoscaling describe-scalable-targets $(__AAG_RESOURCE_ID__SCALABLETARGET) $(__AAG_SCALABLE_DIMENSION__SCALABLETARGET) $(__AAG_SERVICE_NAMESPACE__SCALABLETARGET)

_aag_view_scalabletargets_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing scalable-targets-set "$(AAG_SCALABLETARGETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Scaling-policies are grouped based on the provided resource-ids, ... and/or slice'; $(NORMAL)
	$(AWS) application-autoscaling describe-scalable-targets $(__AAG_RESOURCE_ID__SCALABLETARGET) $(__AAG_SCALABLE_DIMENSION__SCALABLETARGET) $(__AAG_SERVICE_NAMESPACE__SCALABLETARGET)
