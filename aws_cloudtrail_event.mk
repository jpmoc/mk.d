_AWS_CLOUDTRAIL_EVENT_MK_VERSION=$(_AWS_CLOUDTRAIL_MK_VERSION)

# CTL_EVENT_ID?= 77de436d-157b-4a9a-9875-a5c083294356
CTL_EVENT_INDEX?= 0
# CTL_EVENT_LOOKUP_ATTRIBUTES?= AttributeKey=string,AttributeValue=string ...
# CTL_EVENT_LOOKUP_ENDTIME?=
# CTL_EVENT_LOOKUP_STARTTIME?=
# CTL_EVENT_NAME?= ConsoleLogin
# CTL_EVENT_RESOURCE_NAME?=
# CTL_EVENT_RESOURCE_TYPE?=
# CTL_EVENT_SOURCE?=
# CTL_EVENT_USERNAME?=
#
# CTL_EVENTS_LOOKUP_ATTRIBUTES?= AttributeKey=string,AttributeValue=string ...
# CTL_EVENTS_LOOKUP_ENDTIME?=
# CTL_EVENTS_LOOKUP_STARTTIME?=
# CTL_EVENTS_NAME?= ConsoleLogin
# CTL_EVENTS_RESOURCE_NAME?=
# CTL_EVENTS_RESOURCE_TYPE?=
# CTL_EVENTS_SOURCE?=
# CTL_EVENTS_USERNAME?=

# Derived variables
CTL_EVENT_LOOKUP_ATTRIBUTES+= $(if $(CTL_EVENT_ID), AttributeKey=EventId$(COMMA)AttributeValue=$(CTL_EVENT_ID))
CTL_EVENT_LOOKUP_ATTRIBUTES+= $(if $(CTL_EVENT_NAME), AttributeKey=EventName$(COMMA)AttributeValue=$(CTL_EVENT_NAME))
CTL_EVENT_LOOKUP_ATTRIBUTES+= $(if $(CTL_EVENT_RESOURCE_NAME), AttributeKey=ResourceName$(COMMA)AttributeValue=$(CTL_EVENT_RESOURCE_NAME))
CTL_EVENT_LOOKUP_ATTRIBUTES+= $(if $(CTL_EVENT_RESOURCE_TYPE), AttributeKey=ResourceType$(COMMA)AttributeValue=$(CTL_EVENT_RESOURCE_TYPE))
CTL_EVENT_LOOKUP_ATTRIBUTES+= $(if $(CTL_EVENT_SOURCE), AttributeKey=EventSource$(COMMA)AttributeValue=$(CTL_EVENT_SOURCE))
CTL_EVENT_LOOKUP_ATTRIBUTES+= $(if $(CTL_EVENT_USERNAME), AttributeKey=Username$(COMMA)AttributeValue=$(CTL_EVENT_USERNAME))
#
CTL_EVENTS_LOOKUP_ATTRIBUTES+= $(if $(CTL_EVENTS_NAME), AttributeKey=EventName$(COMMA)AttributeValue=$(CTL_EVENTS_NAME))
CTL_EVENTS_LOOKUP_ATTRIBUTES+= $(if $(CTL_EVENTS_RESOURCE_NAME), AttributeKey=ResourceName$(COMMA)AttributeValue=$(CTL_EVENTS_RESOURCE_NAME))
CTL_EVENTS_LOOKUP_ATTRIBUTES+= $(if $(CTL_EVENTS_RESOURCE_TYPE), AttributeKey=ResourceType$(COMMA)AttributeValue=$(CTL_EVENTS_RESOURCE_TYPE))
CTL_EVENTS_LOOKUP_ATTRIBUTES+= $(if $(CTL_EVENTS_SOURCE), AttributeKey=EventSource$(COMMA)AttributeValue=$(CTL_EVENTS_SOURCE))
CTL_EVENTS_LOOKUP_ATTRIBUTES+= $(if $(CTL_EVENTS_USERNAME), AttributeKey=Username$(COMMA)AttributeValue=$(CTL_EVENTS_USERNAME))

# Options variables
__CTL_END_TIME_EVENT?= $(if $(CTL_EVENT_LOOKUP_ENDTIME), --start-time $(CTL_EVENT_LOOKUP_ENDTIME))
__CTL_LOOKUP_ATTRIBUTES?= $(if $(CTL_EVENTS_LOOKUP_ATTRIBUTES), --lookup-attributes $(CTL_EVENTS_LOOKUP_ATTRIBUTES))
__CTL_START_TIME_EVENT?= $(if $(CTL_EVENT_LOOKUP_STARTTIME), --start-time $(CTL_EVENT_LOOKUP_STARTTIME))

# UI variables
CTL_UI_EVENT_SLICE?= 0:10
CTL_UI_SHOW_EVENT_FIELDS?= .{EventId:EventId,EventName:EventName,EventTime:EventTime,Username:Username,Resources:Resources}
CTL_UI_VIEW_EVENTS_FIELDS?= .{EventId:EventId,EventName:EventName,EventTime:EventTime,username:Username}
CTL_UI_VIEW_EVENTS_SET_FIELDS?= $(CTL_UI_VIEW_EVENTS_FIELDS)

#--- Utilities

#--- MACROS

_ctl_get_event_id_by_name= $(call _ctl_get_event_id_by_name_N, $(CTL_EVENT_NAME))
_ctl_get_event_id_by_name_N= $(call _ctl_get_event_id_by_name_NI, $(1), $(CTL_EVENT_INDEX))
_ctl_get_event_id_by_name_NI= $(shell $(AWS) cloudtrail lookup-events --lookup-attributes AttributeKey=EventName,AttributeValue=$(strip $(1)) --query "Events[$(2)].EventId" --output text)

_ctl_get_event_id_by_username= $(call _ctl_get_event_id_by_username_U, $(CTL_EVENT_USERNAME))
_ctl_get_event_id_by_username_U= $(call _ctl_get_event_id_by_username_UI, $(1), $(CTL_EVENT_INDEX))
_ctl_get_event_id_by_username_UI= $(shell $(AWS) cloudtrail lookup-events --lookup-attributes AttributeKey=Username,AttributeValue=$(strip $(1)) --query "Events[$(2)].EventId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ctl_view_makefile_macros ::
	@echo 'AWS::CloudTraiL::Event ($(_AWS_CLOUDTRAIL_EVENT_MK_VERSION)) macros:'
	@echo '    _ctl_get_event_id_by_name_{|N|NI}       - Get event id (Name)'
	@echo '    _ctl_get_event_id_by_username_{|U|UI}   - Get event id (Username)'
	@echo

_ctl_view_makefile_targets ::
	@echo 'AWS::CloudTraiL::Event ($(_AWS_CLOUDTRAIL_EVENT_MK_VERSION)) targets:'
	@echo '    _ctl_show_event                         - Show details of an event'
	@echo '    _ctl_show_event_content                 - Show the content of an event'
	@echo '    _ctl_show_event_description             - Show the description of an event'
	@echo '    _ctl_view_events                        - View events'
	@echo '    _ctl_view_events_set                    - View a set of events'
	@echo 

_ctl_view_makefile_variables ::
	@echo 'AWS::CloudTraiL::Event ($(_AWS_CLOUDTRAIL_EVENTL_MK_VERSION)) variables:'
	@echo '    CTL_EVENT_ID=$(CTL_EVENT_ID)'
	@echo '    CTL_EVENT_INDEX=$(CTL_EVENT_INDEX)'
	@echo '    CTL_EVENT_LOOKUP_ATTRIBUTE=$(CTL_EVENT_LOOKUP_ATTRIBUTE)'
	@echo '    CTL_EVENT_LOOKUP_ENDTIME=$(CTL_EVENT_LOOKUP_ENDTIME)'
	@echo '    CTL_EVENT_LOOKUP_STARTTIME=$(CTL_EVENT_LOOKUP_STARTTIME)'
	@echo '    CTL_EVENT_NAME=$(CTL_EVENT_NAME)'
	@echo '    CTL_EVENT_USERNAME=$(CTL_EVENT_USERNAME)'
	@echo '    CTL_EVENT_RESOURCE_NAME=$(CTL_EVENT_RESOURCE_NAME)'
	@echo '    CTL_EVENT_RESOURCE_TYPE=$(CTL_EVENT_RESOURCE_TYPE)'
	@echo '    CTL_EVENT_SOURCE=$(CTL_EVENT_SOURCE)'
	@echo '    CTL_EVENTS_LOOKUP_ATTRIBUTE=$(CTL_EVENTS_LOOKUP_ATTRIBUTE)'
	@echo '    CTL_EVENTS_LOOKUP_ENDTIME=$(CTL_EVENTS_LOOKUP_ENDTIME)'
	@echo '    CTL_EVENTS_LOOKUP_STARTTIME=$(CTL_EVENTS_LOOKUP_STARTTIME)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ctl_show_event: _ctl_show_event_content _ctl_show_event_description

_ctl_show_event_content:
	@$(INFO) '$(AWS_UI_LABEL)Showing content of event "$(CTL_EVENT_ID)" ...'; $(NORMAL)
	$(AWS) cloudtrail lookup-events $(_X__CTL_END_TIME_EVENT) $(_X__CTL_LOOKUP_ATTRIBUTES) --lookup-attributes AttributeKey=EventId,AttributeValue=$(CTL_EVENT_ID) $(_X_CTL_START_TIME_EVENT) --query "Events[0].CloudTrailEvent" --output text | jq '.'

_ctl_show_event_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing content of event "$(CTL_EVENT_ID)" ...'; $(NORMAL)
	$(AWS) cloudtrail lookup-events $(_X__CTL_END_TIME_EVENT) $(_X__CTL_LOOKUP_ATTRIBUTES) --lookup-attributes AttributeKey=EventId,AttributeValue=$(CTL_EVENT_ID) $(_X_CTL_START_TIME_EVENT) --query "Events[$(CTL_UI_EVENT_SLICE)]$(CTL_UI_SHOW_EVENT_FIELDS)"

_ctl_view_events:
	@$(INFO) '$(AWS_UI_LABEL)Looking up events in trail logs ...'; $(NORMAL)
	@$(WARN) 'This operation takes some time. To speed it up, use lookup-attributes!'; $(NORMAL)
	$(AWS) cloudtrail lookup-events $(__CTL_END_TIME_EVENT) $(_X__CTL_LOOKUP_ATTRIBUTES) $(__CTL_START_TIME_EVENT) --query "Events[$(CTL_UI_EVENT_SLICE)]$(CTL_UI_VIEW_EVENTS_FIELDS)"

_ctl_view_events_set:
	@$(INFO) '$(AWS_UI_LABEL)Looking up set of events in trail logs ...'; $(NORMAL)
	@$(WARN) 'Currently the API does NOT supports event-lookups based on more than one  attribute!  :-( '; $(NORMAL)
	$(AWS) cloudtrail lookup-events $(__CTL_END_TIME_EVENT) $(__CTL_LOOKUP_ATTRIBUTES) $(__CTL_START_TIME_EVENT) --query "Events[$(CTL_UI_EVENT_SLICE)]$(CTL_UI_VIEW_EVENTS_SET_FIELDS)"
