_AWS_CLOUDWATCH_ALARM_MK_VERSION= $(_AWS_CLOUDWATCH_MK_VERSION)

# CWH_ALARM_ACTIONS?= arn:aws:sns:us-east-1:123456789012:MyTopic
# CWH_ALARM_DESCRIPTION?=
# CWH_ALARM_METRIC_NAME?= sys.cpu
# CWH_ALARM_NAME_PREFIX?=
# CWH_ALARM_NAME?=
# CWH_ALARM_NAMES?=
# CWH_ALARMS_SET_NAME?= my-alarm-set

# Derived parameters

# Option parameters
__CWH_ALARM_DESCRIPTION?= $(if $(CWH_ALARM_DESCRIPTION), --alarm-description $(CWH_ALARM_DESCRIPTION))
__CWH_ALARM_NAME_PREFIX?= $(if $(CWH_ALARM_NAME_PREFIX), --alarm-name-prefix $(CWH_ALARM_NAME_PREFIX))
__CWH_ALARM_NAME?= $(if $(CWH_ALARM_NAME), --alarm-name $(CWH_ALARM_NAME))
__CWH_ALARM_NAMES?= $(if $(CWH_ALARM_NAMES), --alarm-names $(CWH_ALARM_NAMES))
__CWH_ALARM_ACTIONS?= $(if $(CWH_ALARM_ACTIONS), --alarm-actions $(CWH_ALARM_ACTIONS))

# UI parameters
CWH_UI_VIEW_ALARMS_FIELDS?= .{AlarmName:AlarmName,metricName:MetricName,State:StateValue,threshold:join(' ',[Statistic, ComparisonOperator, to_string(Threshold)]),sampling:join(' ',[to_string(EvaluationPeriods), 'Samples', to_string(Period), 'sec apart'])}
CWH_UI_VIEW_ALARMS_FIELDS?= .{MetricName:MetricName,Namespace:Namespace,Sampling:join(' ',[to_string(EvaluationPeriods), 'Samples', to_string(Period), 'sec apart']),Trigger:join(' ',[Statistic, ComparisonOperator, to_string(Threshold), Unit]),Dimensions:Dimensions}

CWH_UI_VIEW_ALARMS_SET_FIELDS?= $(CWH_UI_VIEW_ALARMS_FIELDS)
CWH_UI_VIEW_ALARMS_SET_QUERYFILTER?=

CWH_VIEW_ALARM_DETAILS_FIELDS?= .{MetricName:MetricName,Namespace:Namespace,Sampling:join(' ',[to_string(EvaluationPeriods), 'Samples', to_string(Period), 'sec apart']),Trigger:join(' ',[Statistic, ComparisonOperator, to_string(Threshold), Unit]),Dimensions:Dimensions}
CWH_VIEW_ALARM_STATE_FIELDS?= .{LastUpdated:StateUpdatedTimestamp,StateReason:StateReason,State:StateValue}
CWH_VIEW_ALARMS_STATUS_FIELDS?= .[AlarmName,StateValue]

#--- MACROS

_cwh_get_alarms_S=$(shell $(AWS) cloudwatch describe-alarms --query "sort_by(MetricAlarms,$(1))[$(CWH_DESCRIBE_ALARMS_QUERY_FILTER)].AlarmName" --output text)
_cwh_get_alarms=$(call get_alarms_S,&AlarmName)
_cwh_get_alarm_I=$(word $(1), $(call get_alarms))

#----------------------------------------------------------------------
# USAGE
#

_cwh_view_framework_macros ::
	@echo 'AWS::CloudWatcH::Alarm ($(_AWS_CLOUDWATCH_ALARM_MK_VERSION)) macros:'
	@echo '   _cwh_get_alarms                           - Returns alarms based on a query filter'
	@echo '   _cwh_get_alarms_S                         - Returns a sorted-list of alarms (SortBy)'
	@echo '   _cwh_get_alarm_I                          - Returns 1 alarm (Index)'
	@echo

_cwh_view_framework_parameters ::
	@echo 'AWS::CloudWatcH::Alarm ($(_AWS_CLOUDWATCH_ALARM_MK_VERSION)) parameters:'
	@echo '    CWH_ALARM_ACTION=$(CWH_ALARM_ACTION)'
	@echo '    CWH_ALARM_DESCRIPTION=$(CWH_ALARM_DESCRIPTION)'
	@echo '    CWH_ALARM_NAME=$(CWH_ALARM_NAME)'
	@echo '    CWH_ALARM_NAME_PREFIX=$(CWH_ALARM_NAME_PREFIX)'
	@echo '    CWH_ALARM_NAMES=$(CWH_ALARM_NAMES)'
	@echo '    CWH_ALARMS_SET_NAME=$(CWH_ALARMS_SET_NAME)'
	@echo

_cwh_view_framework_targets ::
	@echo 'AWS::CloudWatcH::Alarm ($(_AWS_CLOUDWATCH_ALARM_MK_VERSION)) targets:'
	@echo '    _cwh_create_alarm            - Create an alarm'
	@echo '    _cwh_delete_alarms           - Delete alarms'
	@echo '    _cwh_show_alarm              - Show everything related to an alarm'
	@echo '    _cwh_view_alarms             - Describe alarms'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

__cwh_view_alarm_details:
	@echo -n "| "; $(INFO) "$(CWH_ALARM_NAME)"; $(NORMAL)
	$(AWS) cloudwatch describe-alarms --alarm-names $(CWH_ALARM_NAME) --query "MetricAlarms[$(CWH_DESCRIBE_ALARMS_QUERY_FILTER)]$(CWH_VIEW_ALARM_DETAILS_FIELDS)" \
	| tail -n +4

__cwh_view_alarm_state:
	@echo -n "| "; $(INFO) "$(CWH_ALARM_NAME)"; $(NORMAL)
	@$(AWS) cloudwatch describe-alarms --alarm-names $(CWH_ALARM_NAME) --query "MetricAlarms[$(CWH_DESCRIBE_ALARMS_QUERY_FILTER)]$(CWH_VIEW_ALARM_STATE_FIELDS)" \
	| tail -n +4

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cwh_create_alarm:
	@$(INFO) '$(CWH_UI_LABEL)Creating alarm: $(CWH_ALARM_NAME)'; $(NORMAL)
	$(AWS) cloudwatch put-metric-alarm $(__ALARM_NAME) $(__ALARM_DESCRIPTION) $(__ACTION_ENABLED) $(__ACTIONS) $(__METRIC) $(__PERIOD) $(__UNIT) $(__EVALUATION_PERIODS) $(__THRESHOLD) $(__COMPARISON_OPERATOR)

_cwh_delete_alarms:
	@$(INFO) '$(CWH_UI_LABEL)Deleting alarms: $(CWH_ALARM_NAMES)'; $(NORMAL)
	$(AWS) cloudwatch delete-alarms $(__ALARM_NAMES)

_cwh_view_alarms_details: _cwh_view_alarms_status
	@$(foreach N, $(CWH_ALARM_NAMES), \
		make -s CWH_ALARM_NAME=$(N) __cwh_view_alarm_details; \
	)

_cwh_view_alarms_status:
	@$(INFO) '$(CWH_UI_LABEL)Displaying alarm status ...'; $(NORMAL)
	$(AWS) cloudwatch describe-alarms $(__ALARM_NAMES) $(__ALARM_NAME_PREFIX) $(__STATE_VALUE) $(__ACTION_PREFIX) --query 'MetricAlarms[$(CWH_DESCRIBE_ALARMS_QUERY_FILTER)]$(CWH_VIEW_ALARMS_STATUS_FIELDS)'

_cwh_view_alarms_states: _cwh_view_alarms_status
	@$(foreach N, $(CWH_ALARM_NAMES), \
		make -s CWH_ALARM_NAME=$(N) __cwh_view_alarm_state; \
	)

_cwh_set_alarm_state:
	@$(INFO) '$(CWH_UI_LABEL)Setting alarm "$(CWH_ALARM_NAME)" to state "$(CWH_ALARM_STATE_VALUE)" ...'; $(NORMAL)
	$(AWS) cloudwatch set-alarm-state $(__ALARM_NAME) $(__STATE)

_cwh_show_alarm_history:
	@$(INFO) '$(CWH_UI_LABEL)Showing history of alarm "$(CWH_ALARM_NAME)" ...'; $(NORMAL)
	$(AWS) cloudwatch describe-alarm-history $(__CWH_ALARM_NAME) $(__CWH_HISTORY)

_cwh_view_alarms:
	@$(INFO) '$(CWH_UI_LABEL)Viewing alarms ...'; $(NORMAL)
	$(AWS) cloudwatch describe-alarms --query "MetricAlarms[]$(CWH_UI_VIEW_ALARMS_FIELDS)"

_cwh_view_alarms_set:
	@$(INFO) '$(CWH_UI_LABEL)Viewing alarms-set "$(CWT_ALARMS_SET_NAME)"  ...'; $(NORMAL)
	$(AWS) cloudwatch describe-alarms --query "MetricAlarms[$(CWH_UI_VIEW_ALARMS_SET_QUERYFITLER)]$(CWH_UI_VIEW_ALARMS_SET_FIELDS)"
