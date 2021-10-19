_AWS_CLOUDWATCH_DASHBOARD_MK_VERSION= $(_AWS_CLOUDWATCH_MK_VERSION)

# CWH_DASHBOARD_ARN?=i arn:aws:cloudwatch::123456789012:dashboard/sample_dashboard
# CWH_DASHBOARD_NAME?= sample_dashboard
# CWH_DASHBOARD_NAME_PREFIX?= sample

# Derived parameters

# Option parameters
__CWH_DASHBOARD_NAME_PREFIX= $(if $(CWH_DASHBAORD_NAME_PREFIX),--dashboard-name-prefix $(CWT_DASHBOARD_NAME_PREFIX))
__CWH_DASHBOARD_NAMES__DASHBOARD= $(if $(CWH_DASHBAORD_NAME),--dashboard-names $(CWT_DASHBOARD_NAME))

# UI parameters
CWH_UI_VIEW_DASHBOARDS_FIELDS?=
CWH_UI_VIEW_DASHBOARDS_QUERYFILTER?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cwh_view_framework__macros:
	@echo 'AWS::CloudWatcH::Dashboard ($(_AWS_CLOUDWATCH_DASHBOARD_MK_VERSION)) macros:'
	@echo

_cwh_view_frameowkr_parameters:
	@echo 'AWS::CloudWatcH::Dashboard ($(_AWS_CLOUDWATCH_DASHBOARD_MK_VERSION)) variables:'
	@echo '    CWH_DASHBOARD_ARN=$(CWH_DASHBOARD_ARN)'
	@echo '    CWH_DASHBOARD_NAME=$(CWH_DASHBOARD_NAME)'
	@echo '    CWH_DASHBOARD_NAME_PREFIX=$(CWH_DASHBOARD_NAME_PREFIX)'
	@echo

_cwh_view_makefile_targets:
	@echo 'AWS::CloudWatcH::Dashboard ($(_AWS_CLOUDWATCH_DASHBOARD_MK_VERSION)) targets:'
	@echo '    _cwh_create_dashboard        - Create a dashboard'
	@echo '    _cwh_delete_dashboard        - Delete a dashboard'
	@echo '    _cwh_show_dashboard          - Show everything related to a dashboard'
	@echo '    _cwh_view_dashboards         - View dashboards'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cwh_create_dashboard:
	@$(INFO) '$(AWS_LABEL)Creating dashboard "$(CWH_DASHBOARD_NAME)" ...'; $(NORMAL)
	$(AWS) cloudwatch put-metric-alarm $(__ALARM_NAME) $(__ALARM_DESCRIPTION) $(__ACTION_ENABLED) $(__ACTIONS) $(__METRIC) $(__PERIOD) $(__UNIT) $(__EVALUATION_PERIODS) $(__THRESHOLD) $(__COMPARISON_OPERATOR)

_cwh_delete_dashboard:
	@$(INFO) '$(AWS_LABEL)Deleting dashboard "$(CWH_DASHBAORD_NAME)" ...'; $(NORMAL)
	$(AWS) cloudwatch delete-dashboards $(__CWT_DASHBOARDS_NAMES__DASHBOARD)

_cwh_show_dashboard :: _cwh_show_dashboard_description

_cwh_show_dashboard_description:
	@$(INFO) '$(AWS_LABEL)Setting alarm '$(CWH_ALARM_NAME)' to state '$(CWH_STATE_VALUE)' ...'; $(NORMAL)
	$(AWS) cloudwatch set-alarm-state $(__ALARM_NAME) $(__STATE)

_cwh_view_dashboards:
	@$(INFO) '$(AWS_LABEL)View dashboards ...'; $(NORMAL)
	$(AWS) cloudwatch list-dashboards $(__CWT_DASHBOARD_NAME_PREFIX) --query 'DashboardEntries[]$(CWH_UI_VIEW_DASHBOARDS_FIELDS)'

_cwh_view_dashboards_set:
	@$(INFO) '$(AWS_LABEL)View dashboards-set "XXX" ...'; $(NORMAL)
	$(AWS) cloudwatch list-dashboards $(__CWT_DASHBOARD_NAME_PREFIX) --query 'DashboardEntries[$(CWH_UI_VIEW_DASHBOARD_QUERYFILTER)]$(CWH_UI_VIEW_DASHBOARDS_FIELDS)'
