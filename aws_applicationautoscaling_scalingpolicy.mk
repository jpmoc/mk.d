_AWS_APPLICATIONAUTOSCALING_SCALINGPOLICY_MK_VERSION= $(_AWS_APPLICATIONAUTOSCALING_MK_VERSION)

# AAG_SCALINGPOLICY_NAME?= 
# AAG_SCALINGPOLICY_NAMES?= 
# AAG_SCALINGPOLICY_RESOURCE_ID?= 
# AAG_SCALINGPOLICY_SCALABLE_DIMENSION?= 
# AAG_SCALINGPOLICY_SERVICE_NAMESPACE?= ec2
# AAG_SCALINGPOLICIES_SET_NAME?= 

# Derived parameters
AAG_SCALINGPOLICY_NAMES?= $(AAG_SCALINGPOLICY_NAME)
AAG_SCALINGPOLICY_SERVICE_NAMESPACE?= $(AAG_SERVICE_NAMESPACE)

# Option parameters
__AAG_POLICY_NAMES= $(if $(AAG_SCALINGPOLICY_NAMES), --policy-names $(AAG_SCALINGPOLICY_NAMES))
__AAG_RESOURCE_ID__SCALINGPOLICY=
__AAG_SCALABLE_DIMENSION__SCALINGPOLICY=
__AAG_SERVICE_NAMESPACE__SCALINGPOLICY= $(if $(AAG_SCALINGPOLICY_SERVICE_NAMESPACE), --service-namespace $(AAG_SCALINGPOLICY_SERVICE_NAMESPACE))

# UI parameters
AAG_UI_VIEW_SCALINGPOLICIES_FIELDS?=
AAG_UI_VIEW_SCALINGPOLICIES_SET_FIELDS?= $(AAG_UI_VIEW_SCALINGPOLICIES_FIELDS)
AAG_UI_VIEW_SCALINGPOLICIES_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aag_view_framework_macros ::
	@echo 'AWS::ApplicationAutoscalinG::ScalingPolicy ($(_AWS_APPLICATIONAUTOSCALING_SCALINGPOLICY_MK_VERSION)) macros:'
	@echo

_aag_view_framework_parameters ::
	@echo 'AWS::ApplicationAutoscalinG::ScalingPolicy ($(_AWS_APPLICATIONAUTOSCALING_SCALINGPOLICY_MK_VERSION)) parameters:'
	@echo '    AAG_SCALINGPOLICY_NAME=$(AAG_SCALINGPOLICY_NAME)'
	@echo '    AAG_SCALINGPOLICY_NAMES=$(AAG_SCALINGPOLICY_NAMES)'
	@echo '    AAG_SCALINGPOLICY_RESOURCE_ID=$(AAG_SCALINGPOLICY_RESOURCE_ID)'
	@echo '    AAG_SCALINGPOLICY_SCALABLE_DIMENSION=$(AAG_SCALINGPOLICY_SCALABLE_DIMENSION)'
	@echo '    AAG_SCALINGPOLICY_SERVICE_NAMESPACE=$(AAG_SCALINGPOLICY_SERVICE_NAMESPACE)'
	@echo '    AAG_SCALINGPOLICIES_SET_NAME=$(AAG_SCALINGPOLICIES_SET_NAME)'
	@echo

_aag_view_framework_targets ::
	@echo 'AWS::ApplicationAutoscalinG::ScalingPolicy ($(_AWS_APPLICATIONAUTOSCALING_SCALINGPOLICY_MK_VERSION)) targets:'A
	@echo '    _aag_create_scalingpolicy               - Create a new scaling-policy'
	@echo '    _aag_delete_scalingpolicy               - Delete an existing scaling-policy'
	@echo '    _aag_show_scalingpolicy                 - Show everything related to a scaling-policy'
	@echo '    _aag_view_scalingpolicies                - View scaling-policies'
	@echo '    _aag_view_scalingpolicies_set            - View a set of scaling-policies'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aag_create_scalingpolicy:

_aag_delete_scalingpolicy:

_aag_show_scalingpolicy:

_aag_view_scalingpolicies:
	@$(INFO) '$(AWS_UI_LABEL)Viewing scaling-policies ...'; $(NORMAL)
	$(AWS) application-autoscaling describe-scaling-policies $(_X__AAG_POLICY_NAMES) $(__AAG_RESOURCE_ID__SCALINGPOLICY) $(__AAG_SCALABLE_DIMENSION__SCALINGPOLICY) $(__AAG_SERVICE_NAMESPACE__SCALINGPOLICY)

_aag_view_scalingpolicies_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing scaling-policies-set "$(AAG_SCALINGPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Scaling-policies are grouped based on the provided scaling-policy-names, resource-ids, ... and/or slice'; $(NORMAL)
	$(AWS) application-autoscaling describe-scaling-policies $(__AAG_POLICY_NAMES) $(__AAG_RESOURCE_ID__SCALINGPOLICY) $(__AAG_SCALABLE_DIMENSION__SCALINGPOLICY) $(__AAG_SERVICE_NAMESPACE__SCALINGPOLICY)
