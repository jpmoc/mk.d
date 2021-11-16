_AWS_LOGS_STREAM_MK_VERSION= $(_AWS_LOGS_MK_VERSION)

# LGS_STREAM_LOGGROUP_NAME?=
# LGS_STREAM_NAME?=
# LGS_STREAM_STARTFROMHEAD_ENABLE?= false
# LGS_STREAMS_SET_NAME?=

# Derived parameters
LGS_STREAM_LOGGROUP_NAME?= $(LGS_LOGGROUP_NAME)
LGS_STREAMS_SET_NAME?= $(LGS_STREAM_LOGGROUP_NAME)

# Options
__LGS_END_TIME__STREAM=
__LGS_LOG_GROUP_NAME__STREAM= $(if $(LGS_STREAM_LOGGROUP_NAME), --log-group-name $(LGS_STREAM_LOGGROUP_NAME))
__LGS_LOG_STREAM_NAME= $(if $(LGS_STREAM_NAME), --log-stream-name $(LGS_STREAM_NAME))
__LGS_START_FROM_HEAD__STREAM= $(if $(filter true, $(LGS_STREAM_STARTFROMHEAD_ENABLE)), --start-from-head, --no-start-from-head)
__LGS_START_TIME__STREAM=

# Customizations
_LGS_LIST_STREAMS_SET_FIELDS?=
_LGS_SHOW_STREAM_EVENTS_FIELDS?= .[message]# Not rendered the same as .message in text format!
_LGS_SHOW_STREAM_EVENTS_QUERYFILTER?= -30::1
_LGS_WATCH_STREAM_INTERVAL?= 5

#--- Utilities
COLOURISER_BIN?= cat
COLOURISER_INPUT_FILEPATH?=/tmp/show_stream_events.log
COLOURISER?= $(__COLOURISER_ENVIRONMENT) $(COLOURISER_ENVIRONMENT) $(COLOURISER_BIN) $(__COLOURISER_OPTIONS) $(COLOURISER_OPTIONS)
__>_COLOURISER_INPUT_FILEPATH?= $(if $(COLOURISER_INPUT_FILEPATH), > $(COLOURISER_INPUT_FILEPATH))

#--- MACRO
_lgs_get_last_modified_log_steam=$(call _lgs_last_modified_log_stream_G, $(LGS_LOGGROUP_NAME))
_lgs_get_last_modified_log_stream_G=$(shell $(AWS) logs describe-log-streams --log-group-name $(1) --query 'reverse(sort_by(logStreams,&lastEventTimestamp))[0].logStreamName' --output text)

#----------------------------------------------------------------------
# USAGE
#

_lgs_list_macros ::
	@echo 'AWS::LoGS::Stream ($(_AWS_LOGS_STREAM_MK_VERSION)) macros:'
	@echo '    _lgs_get_last_modified_log_stream_{|G}   - Get the last stream for a given log group (GROUP)'
	@echo

_lgs_list_parameters ::
	@echo 'AWS::LoGS::Stream ($(_AWS_LOGS_STREAM_MK_VERSION)) parameters:'
	@echo '    LGS_STREAM_LOGGROUP_NAME=$(LGS_STREAM_LOGGROUP_NAME)'
	@echo '    LGS_STREAM_NAME=$(LGS_STREAM_NAME)'
	@echo '    LGS_STREAM_STARTFROMHEAD_ENABLE=$(LGS_STREAM_STARTFROMHEAD_ENABLE)'
	@echo '    LGS_STREAMS_SET_NAME=$(LGS_STREAMS_SET_NAME)'
	@echo

_lgs_list_targets ::
	@echo 'AWS::LoGS::Stream ($(_AWS_LOGS_STREAM_MK_VERSION)) targets:'
	@echo '    _lgs_create_stream                   - Create a stream in a log-group'
	@echo '    _lgs_delete_stream                   - Delete an existing stream'
	@echo '    _lgs_list_streams                    - List all streams in a log-group'
	@echo '    _lgs_list_streams_set                - List a set of streams'
	@echo '    _lgs_show_stream                     - Show everything relatead to a stream in a log-group'
	@echo '    _lgs_show_stream_events              - Show all events in a stream'
	@echo '    _lgs_tail_stream                     - Tail the logs in stream'
	@echo '    _lgs_tail_stream_footer              - Footer for tail target'
	@echo '    _lgs_tail_stream_header              - Header for tail target'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_lgs_create_stream:
	@$(INFO) '$(LGS_UI_LABEL)Creating stream "$(LGS_STREAM_NAME)" in log-group "$(LGS_STREAM_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs create-log-stream $(__LGS_LOG_GROUP_NAME__STREAM) $(__LGS_LOG_STREAM_NAME)

_lgs_delete_stream:
	@$(INFO) '$(LGS_UI_LABEL)Deleting stream "$(LGS_STREAM_NAME)" in log-group "$(LGS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs delete-log-steam $(__LGS_LOG_GROUP_NAME__STREAM) $(__LGS_LOG_STREAM_NAME)

_lgs_list_streams:
	@$(INFO) '$(LGS_UI_LABEL)Listing ALL streams ...'; $(NORMAL)

_lgs_list_streams_set:
	@$(INFO) '$(LGS_UI_LABEL)Listing streams-set "$(LGS_STREAMS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Streams are grouped by log-group, ...'; $(NORMAL)
	$(AWS) logs describe-log-streams $(__LGS_LOG_GROUP_NAME__STREAM) --query 'logStreams[]$(_LGS_LIST_STREAMS_SET_FIELDS)'

_LGS_SHOW_STREAM_TARGETS?= _lgs_show_stream_events _lgs_show_stream_description
_lgs_show_stream: $(_LGS_SHOW_STREAM_TARGETS)

_lgs_show_stream_description:
	@$(INFO) '$(LGS_UI_LABEL)Showing description of stream "$(LGS_STREAM_NAME)" of log-group "$(LGS_STREAM_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs describe-log-streams $(__LGS_LOG_GROUP_NAME) --query "logStreams[?logStreamName=='$(strip $(LGS_STREAM_NAME))']"

# Do not use := otherwise is processed at every pass and not when needed!
_lgs_show_stream_events: NOW_UTC=$(shell date --utc +'%Y-%m-%dT%H:%M:%S UTC')
_lgs_show_stream_events:
	@$(INFO) '$(LGS_UI_LABEL)Showing events in stream "$(LGS_STREAM_NAME)" of log-group "$(LGS_STREAM_LOGGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Now: $(NOW_UTC)'; $(NORMAL)
	@# We echo the command below so it can be clearly separater from the log events
	@# We do not execute it in silent mode (used by watch)
	$(AWS) logs get-log-events $(__LGS_END_TIME__STREAM) $(__LGS_LOG_GROUP_NAME__STREAM) $(__LGS_LOG_STREAM_NAME) $(__LGS_START_FROM_HEAD__STREAM) $(__LGS_START_TIME__STREAM) --query "events[$(_LGS_SHOW_STREAM_EVENTS_QUERYFILTER)]$(_LGS_SHOW_STREAM_EVENTS_FIELDS)" --output text $(__>_COLOURISER_INPUT_FILEPATH)
	@echo; echo; $(COLOURISER) $(COLOURISER_INPUT_FILEPATH)
	@$(WARN) '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
	@$(WARN) 'Now: $(NOW_UTC)'
	@#$(WARN) 'Last entry is$(if $(filter true, $(LGS_START_FROM_HEAD)), the oldest, the most recent)'
	@$(WARN) 'Last entry is the most recent'
	@$(WARN) 'Log group: $(LGS_STREAM_LOGGROUP_NAME)'
	@$(WARN) 'Stream: $(LGS_STREAM_NAME)'
	@$(WARN) '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
	@$(NORMAL)

_lgs_tail_stream:
	watch -n $(LGS_WATCH_STREAM_INTERVAL) --color  'make -e --quiet _lgs_tail_stream_header _lgs_show_stream_events'

_lgs_tail_stream_footer ::

_lgs_tail_stream_header ::
