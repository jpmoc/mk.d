_AWSLOGS_LOGGROUP_MK_VERSION= $(_AWSLOGS_MK_VERSION)

# ALS_LOGGROUP_NAME?= allspark-vke
ALS_LOGGROUP_SHOW_GROUP?= false
ALS_LOGGROUP_SHOW_INGESTIONTIME?= false
ALS_LOGGROUP_SHOW_STREAM?= true
ALS_LOGGROUP_SHOW_TIMESTAMP?= false
# ALS_LOGGROUP_SLICE_END?= 
# ALS_LOGGROUP_SLICE_FILTERPATTERN?= 
ALS_LOGGROUP_SLICE_QUERY?= *
# ALS_LOGGROUP_SLICE_START?=
# ALS_LOGGROUP_WATCH_INTERVAL?=
# ALS_LOGGROUPS_NAME_PREFIX?= /aws/
# ALS_LOGGROUPS_SET_NAME?= my-loggroups-set

# Derived parameters
ALS_LOGGROUPS_SET_NAME?= $(ALS_LOGGROUPS_NAME_PREFIX)

# Option parameters
__ALS_END__LOGGROUP= $(if $(ALS_LOGGROUP_SLICE_END),--end $(ALS_LOGGROUP_SLICE_END))
__ALS_FILTER_PATTERN__LOGGROUP= $(if $(ALS_LOGGROUP_SLICE_FILTERPATTERN),--filter-pattern $(ALS_LOGGROUP_SLICE_FILTERPATTERN))
__ALS_INGESTION_TIME__LOGGROUP= $(if $(filter true, $(ALS_LOGGROUP_SHOW_INGESTIONTIME)),--ingestion-time)
__ALS_LOG_GROUP_PREFIX= $(if $(ALS_LOGGROUPS_NAME_PREFIX),--log-group-prefix $(ALS_LOGGROUPS_NAME_PREFIX))
__ALS_NO_GROUP__LOGGROUP= $(if $(filter false, $(ALS_LOGGROUP_SHOW_GROUP)),--no-group)
__ALS_QUERY__LOGGROUP= $(if $(ALS_LOGGROUP_SLICE_QUERY),--query='$(ALS_LOGGROUP_SLICE_QUERY)')
__ALS_START__LOGGROUP= $(if $(ALS_LOGGROUP_SLICE_START),--start $(ALS_LOGGROUP_SLICE_START))
__ALS_TIMESTAMP__LOGGROUP= $(if $(filter true, $(ALS_LOGGROUP_SHOW_TIMESTAMP)),--timestamp)
__ALS_WATCH_INTERVAL__LOGGROUP= $(if $(ALS_LOGGROUP_WATCH_INTERVAL),--watch-interval $(ALS_LOGGROUP_WATCH_INTERVAL))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_als_view_framework_macros ::
	@#echo 'AwsLogS::LogGroup ($(_AWSLOGS_LOGGROUP_MK_VERSION)) macros:'
	@#echo

_als_view_framework_parameters ::
	@echo 'AwsLogS::LogGroup ($(_AWSLOGS_LOGGROUP_MK_VERSION)) parameters:'
	@echo '    ALS_LOGGROUP_NAME=$(ALS_LOGGROUP_NAME)'
	@echo '    ALS_LOGGROUP_SHOW_GROUP=$(ALS_LOGGROUP_SHOW_GROUP)'
	@echo '    ALS_LOGGROUP_SHOW_INGESTIONTIME=$(ALS_LOGGROUP_SHOW_INGESTIONTIME)'
	@echo '    ALS_LOGGROUP_SHOW_STREAM=$(ALS_LOGGROUP_SHOW_STREAM)'
	@echo '    ALS_LOGGROUP_SHOW_TIMESTAMP=$(ALS_LOGGROUP_SHOW_TIMESTAMP)'
	@echo '    ALS_LOGGROUP_SLICE_END=$(ALS_LOGGROUP_SLICE_END)'
	@echo '    ALS_LOGGROUP_SLICE_FILTERPATTERN=$(ALS_LOGGROUP_SLICE_FILTERPATTERN)'
	@echo '    ALS_LOGGROUP_SLICE_START=$(ALS_LOGGROUP_SLICE_START)'
	@echo '    ALS_LOGGROUP_WATCH_INTERVAL=$(ALS_LOGGROUP_WATCH_INTERVAL)'
	@echo '    ALS_LOGGROUPS_NAME_PREFIX=$(ALS_LOGGROUPS_NAME_PREFIX)'
	@echo '    ALS_LOGGROUPS_SET_NAME=$(ALS_LOGGROUPS_SET_NAME)'
	@echo

_als_view_framework_targets ::
	@echo 'AwsLogS::LogGroup ($(_AWSLOGS_LOGGROUP_MK_VERSION)) targets:'
	@echo '    _als_show_loggroup                   - Show everything related to a log-group'
	@echo '    _als_show_loggroup_streams           - Show streams in a log-group'
	@echo '    _als_slice_loggroup                  - Slice a log-group'
	@echo '    _als_view_loggroups                  - View log-groups'
	@echo '    _als_view_loggroups_set              - View set of log-groups'
	@echo '    _als_watch_loggroup                  - Watch loggroup'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_als_show_loggroup: _als_show_loggroup_1m _als_show_loggroup_streams

_als_show_loggroup_1m:
	@$(INFO) '$(ALS_UI_LABEL)Showing events from last minute in loggroup "$(ALS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWSLOGS) get $(strip $(_X__ALS_END__LOGGROUP) $(_X__ALS_FILTER_PATTERN__LOGGROUP) $(__ALS_NO_GROUP__LOGGROUP) $(__ALS_QUERY__LOGGROUP) $(_X__ALS_START__LOGGROUP) --start='1 minute' $(ALS_LOGGROUP_NAME) ALL)

_als_show_loggroup_streams:
	@$(INFO) '$(ALS_UI_LABEL)Showing streams in loggroup "$(ALS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWSLOGS) streams $(ALS_LOGGROUP_NAME)

_als_slice_loggroup:
	@$(INFO) '$(ALS_UI_LABEL)Slicing loggroup "$(ALS_LOGGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Filter-patterns @ https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html'; $(NORMAL)
	$(AWSLOGS) get $(strip $(__ALS_END__LOGGROUP) $(__ALS_FILTER_PATTERN__LOGGROUP) $(__ALS_NO_GROUP__LOGGROUP) $(__ALS_QUERY__LOGGROUP) $(__ALS_START__LOGGROUP) $(ALS_LOGGROUP_NAME) ALL)

_als_view_loggroups:
	@$(INFO) '$(ALS_UI_LABEL)Viewing log-groups ...'; $(NORMAL)
	$(AWSLOGS) groups $(_X__ALS_LOG_GROUP_PREFIX)

_als_view_loggroups_set:
	@$(INFO) '$(ALS_UI_LABEL)Viewing log-groups-set "$(ALS_LOGGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Log-groups are grouped based on the provided name prefix'; $(NORMAL)
	$(AWSLOGS) groups $(__ALS_LOG_GROUP_PREFIX)

_als_watch_loggroup:
	@$(INFO) '$(ALS_UI_LABEL)Watch slice of loggroup "$(ALS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWSLOGS) get $(strip $(_X__ALS_END__LOGGROUP) $(__ALS_FILTER_PATTERN__LOGGROUP) $(__ALS_NO_GROUP__LOGGROUP) $(__ALS_QUERY__LOGGROUP) $(_X__ALS_START__LOGGROUP) --watch $(__ALS_WATCH_INTERVAL__LOGGROUP) $(ALS_LOGGROUP_NAME) ALL)
