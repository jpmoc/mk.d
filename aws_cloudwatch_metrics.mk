_AWS_CLOUDWATCH_METRICS_MK_VERSION= $(_AWS_CLOUDWATCH_MK_VERSION)

# CWH_METRIC_DIMENSIONS?=
# CWH_METRIC_NAME?= CPUUtilization
# CWH_METRIC_NAMESPACE?= "AWS/SNS"

# Derived parameters


# Option parameters
__CWH_DIMENSIONS?= $(if $(CWH_METRIC_DIMENSIONS), --dimensions $(CWH_METRIC_DIMENSIONS))
__CWH_NAMESPACE?= $(if $(CWH_METRIC_NAMESPACE), --namespace $(CWH_METRIC_NAMESPACE))
__CWH_METRIC_NAME?= $(if $(CWH_METRIC_NAME), --metric-name $(CWH_METRIC_NAME))

# UI parameters
CWH_UI_VIEW_ALARMS_STATUS_FIELDS?= .[AlarmName,StateValue]

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cwh_view_framework_macros ::
	@echo "AWS::CloudWatcH::Metrics ($(_AWS_CLOUDWATCH_METRICS_MK_VERSION)) macros:"
	@echo

_cwh_view_framework_parameters ::
	@echo "AWS::CloudWatcH::Metrics ($(_AWS_CLOUDWATCH_METRICS_MK_VERSION)) parameters:"
	@echo "    CWH_METRIC_DIMENSIONS=$(CWH_METRIC_DIMENSIONS)"
	@echo "    CWH_METRIC_NAME=$(CWH_METRIC_NAME)"
	@echo "    CWH_METRIC_NAMESPACE=$(CWH_METRIC_NAMESPACE)"
	@echo

_cwh_view_framework_targets ::
	@echo "AWS::CloudWatcH::Metrics ($(_AWS_CLOUDWATCH_METRICS_MK_VERSION)) targets:"
	@echo "    _cwh_view_metrics             - view metrics"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cwh_view_metrics:
	@$(INFO) "$(AWS_LABEL)View metrics ..."; $(NORMAL)
	$(AWS) cloudwatch list-metrics $(__CWH_DIMENSIONS) $(__CWH_METRICS_NAME) $(__CWH_NAMESPACE)
