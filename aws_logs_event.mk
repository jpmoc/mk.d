_AWS_LOGS_EVENT_MK_VERSION= $(_AWS_LOGS_MK_VERSION)

# LGS_EVENTS?= timestamp=1433190184356,message='Message 1' timestamp=1433190184356,message='Message 2'
# LGS_EVENTS_FILEPATH?= ./events.json
# LGS_EVENTS_LOGGROUP_NAME?=
# LGS_EVENTS_SEQUENCE_TOKEN?= 49582689015377701995042593465576097785575323120487641522
# LGS_EVENTS_STREAM_NAME?=
# LGS_EVENTS_STARTFROMHEAD_ENABLE?= false

# Derived parameters
LGS_EVENTS?= $(if $(LGS_EVENTS_FILEPATH), file://$(LGS_EVENTS_FILEPATH))
LGS_EVENTS_LOGGROUP_NAME?= $(LGS_STREAM_LOGGROUP_NAME)
LGS_EVENTS_STREAM_NAME?= $(LGS_STREAM_NAME)

# Options
__LGS_LOG_EVENTS__EVENTS= $(if $(LGS_EVENTS), --log-events $(LGS_EVENTS))
__LGS_LOG_GROUP_NAME__EVENTS= $(if $(LGS_EVENTS_LOGGROUP_NAME), --log-group-name $(LGS_EVENTS_LOGGROUP_NAME))
__LGS_LOG_STREAM_NAME__EVENTS= $(if $(LGS_EVENTS_STREAM_NAME), --log-stream-name $(LGS_EVENTS_STREAM_NAME))
__LGS_SEQUENCE_TOKEN= $(if $(LGS_EVENTS_SEQUENCE_TOKEN), --sequence-token $(LGS_EVENTS_SEQUENCE_TOKEN))
__LGS_START_TIME__EVENTS=

# Customizations
_LGS_LIST_EVENTS_QUERYFILTER?= -30::1
_LGS_LIST_EVENTS_FIELDS?= .[message]# Not rendered the same as .message in text format!

#--- MACRO
_lgs_get_events_sequence_token= $(call _lgs_get_events_sequence_token_S, $(LGS_EVENTS_STREAM_NAME))
_lgs_get_events_sequence_token_S= $(call _lgs_get_events_sequence_token_SG, $(1), $(LGS_EVENTS_LOGGROUP_NAME))
_lgs_get_events_sequence_token_SG= $(shell $(AWS) logs describe-log-streams  --log-group-name $(2) --query "logStreams[?logStreamName=='$(strip $(1))'].uploadSequenceToken" --output text)

#----------------------------------------------------------------------
# USAGE
#

_lgs_list_macros ::
	@echo 'AWS::LoGS::Event ($(_AWS_LOGS_EVENT_MK_VERSION)) macros:'
	@echo '    _lgs_get_sequence_token_{|S|SG}     - Get the sequence token (Stream,logGroup)'
	@echo

_lgs_list_parameters ::
	@echo 'AWS::LoGS::Event ($(_AWS_LOGS_EVENT_MK_VERSION)) parameters:'
	@echo '    LGS_EVENTS=$(LGS_EVENTS)'
	@echo '    LGS_EVENTS_FILEPATH=$(LGS_EVENTS_FILEPATH)'
	@echo '    LGS_EVENTS_LOGGROUP_NAME=$(LGS_EVENTS_LOGGROUP_NAME)'
	@echo '    LGS_EVENTS_SEQUENCE_TOKEN=$(LGS_EVENTS_SEQUENCE_TOKEN)'
	@echo '    LGS_EVENTS_STREAM_NAME=$(LGS_EVENTS_STREAM_NAME)'
	@echo

_lgs_list_targets ::
	@echo 'AWS::LoGS::Event ($(_AWS_LOGS_EVENT_MK_VERSION)) targets:'
	@echo '    _lgs_put_events                      - Insert/add/put events in an existing stream in a log-group'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_lgs_put_events:
	@$(INFO) '$(LGS_UI_LABEL)Putting events in stream "$(LGS_EVENTS_STREAM_NAME)" in log group "$(LGS_EVENTS_LOGGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'In a stream, events are ordered based on event-timestamp parameter'
	@$(WARN) 'Interspacing events is therefore possible'
	@$(WARN) 'A sequence token must be provided if you write at a non-t0'; $(NORMAL)
	$(AWS) logs put-log-events $(__LGS_LOG_EVENTS__EVENTS) $(__LGS_LOG_GROUP_NAME__EVENTS) $(__LGS_LOG_STREAM_NAME__EVENTS) $(__LGS_SEQUENCE_TOKEN)
	@$(WARN) 'Events that are too old may be rejected!'; $(NORMAL)
