_AWSLOGS_STREAM_MK_VERSION= $(_AWSLOGS_MK_VERSION)

# ALS_STREAM_LOGGROUP_NAME?= allspark-vke
# ASL_STREAM_NAME?= my-stream
# ALS_STREAM_PROFILE?= <aws-profile>
ALS_STREAM_SHOW_INGESTIONTIME?= false
ALS_STREAM_SHOW_GROUP?= true
ALS_STREAM_SHOW_STREAM?= true
ALS_STREAM_SHOW_TIMESTAMP?= false
# ALS_STREAM_SLICE_END?= '5 weeks'
ALS_STREAM_SLICE_QUERY?= *
# ALS_STREAM_SLICE_START?= 1 minute
# ALS_STREAM_WATCH_INTERVAL?= 5

# Derived parameters
ALS_STREAM_LOGGROUP_NAME?= $(ALS_LOGGROUP_NAME)

# Option parameters
__ALS_END__STREAM?= $(if $(ALS_STREAM_SLICE_END),--end '$(ALS_STREAM_SLICE_END)')
__ALS_INGESTION_TIME__STREAM?= $(if $(filter true, $(ALS_STREAM_SHOW_INGESTIONTIME)),--ingestion-time)
__ALS_FILTER_PATTERN__STREAM?= $(if $(ALS_STREAM_SLICE_FILTERPATTERN),--format-pattern '$(ALS_STREAM_SLICE_FILTERPATTERN)')
__ALS_NO_GROUP__STREAM?= $(if $(filter false, $(ALS_STREAM_SHOW_GROUP)),--no-group)
__ALS_NO_STREAM__STREAM?= $(if $(filter false, $(ALS_STREAM_SHOW_STREAM)),--no-stream)
__ALS_QUERY__STREAM?= $(if $(ALS_STREAM_SLICE_QUERY),--query '$(ALS_STREAM_SLICE_QUERY)')
__ALS_START__STREAM?= $(if $(ALS_STREAM_SLICE_START),--start '$(ALS_STREAM_SLICE_START)')
__ALS_TIMESTAMP__STREAM?= $(if $(filter true, $(ALS_STREAM_SHOW_TIMESTAMP)),--timestamp)
__ALS_WATCH_INTERVAL__STREAM?= $(if $(ALS_STREAM_WATCH_INTERVAL),--watch-interval $(ALS_STREAM_WATCH_INTERVAL))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_als_view_framework_macros ::
	@#echo 'AwsLogS::Stream ($(_AWSLOGS_STREAM_MK_VERSION)) macros:'
	@#echo

_als_view_framework_parameters ::
	@echo 'AwsLogS::Stream ($(_AWSLOGS_STREAM_MK_VERSION)) parameters:'
	@echo '    ALS_STREAM_LOGGROUP_NAME=$(ALS_STREAM_LOGGROUP_NAME)'
	@echo '    ALS_STREAM_NAME=$(ALS_STREAMP_NAME)'
	@echo '    ALS_STREAM_PROFILE=$(ALS_STREAMP_PROFILE)'
	@echo '    ALS_STREAM_SHOW_INGESTIONTIME=$(ALS_STREAMP_SHOW_INGESTIONTIME)'
	@echo '    ALS_STREAM_SHOW_TIMESTAMP=$(ALS_STREAMP_SHOW_TIMESTAMP)'
	@echo '    ALS_STREAM_WATCH_INTERVAL=$(ALS_STREAMP_WATCH_INTERVAL)'
	@echo

_als_view_framework_targets ::
	@echo 'AwsLogS::Stream ($(_AWSLOGS_STREAM_MK_VERSION)) targets:'
	@echo '    _als_show_stream                     - Show everything related to a stream'
	@echo '    _als_show_stream_1m                  - Show events of last minute published in stream'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_als_show_stream: _als_show_stream_1m

_als_show_stream_1m:
	@$(INFO) '$(ALS_UI_LABEL)Showing content of stream "$(ALS_STREAM_NAME)" in loggroup "$(ALS_STREAM_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWSLOGS) get $(strip $(_X_ALS_END__STREAM) $(__ALS_FILTER_PATTERN__STREAM) $(__ALS_INGESTION_TIME__STREAM) $(__ALS_QUERY__STREAM) $(_X_ALS_START__STREAM) --start='1 minute' $(__ALS_TIMESTAMP__STREAM) $(ALS_STREAM_LOGGROUP_NAME) $(ALS_STREAM_NAME))

_als_slice_stream:

_als_watch_stream:
	@$(INFO) '$(ALS_UI_LABEL)Watching stream "$(ALS_STREAM_NAME)" in loggroup "$(ALS_STREAM_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWSLOGS) get $(strip $(_X__ALS_END__STREAM) $(__ALS_FILTER_PATTERN__STREAM) $(__ALS_INGESTION_TIME__STREAM) $(__ALS_QUERY__STREAM) $(_X__ALS_START_STREAM) $(__ALS_TIMESTAMP__STREAM) --watch $(__ALS_WATCH_INTERVAL__STREAM) $(ALS_STREAM_LOGGROUP_NAME) $(ALS_STREAM_NAME))

