_AWS_SAM_EVENT_MK_VERSION= $(_AWS_SAM_MK_VERSION)

# SAM_EVENT_COMMAND_ARGUMENTS?= --bucket example-bucket --key test/key --region us-east-1
# SAM_EVENT_COMMAND_NAME?= put
# SAM_EVENT_DIRPATH?= ./projects/name/events/
# SAM_EVENT_FILENAME?= my-event.json
# SAM_EVENT_FILEPATH?= ./events/my-event.json
# SAM_EVENT_NAME?= my-event
# SAM_EVENT_SOURCE_NAME?= s3
# SAM_EVENTS_DIRPATH?= ./projects/name/events/
# SAM_EVENTS_SET_NAME?= my-events-set

# Derived parameters
SAM_EVENT_DIRPATH?= $(SAM_EVENTS_DIRPATH)
SAM_EVENT_FILENAME?= $(SAM_EVENT_NAME).json
SAM_EVENT_FILEPATH?= $(realpath $(SAM_EVENT_DIRPATH)$(SAM_EVENT_FILENAME))
SAM_EVENTS_DIRPATH?= $(SAM_PROJECT_DIRPATH)events/

# Options parameters

# Pipe parameters
|_SAM_CREATE_EVENT?=
_SAM_CREATE_EVENT_|?= cd $(SAM_EVENT_DIRPATH) && 
_SAM_SHOW_EVENT_DESCRIPTION_|?= cd $(SAM_EVENT_DIRPATH) && 
_SAM_VIEW_EVENTS_|?= cd $(SAM_EVENTS_DIRPATH) && 

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sam_view_framework_macros ::
	@echo 'AWS::SAM::Event ($(_AWS_SAM_EVENT_MK_VERSION)) macros:'
	@echo

_sam_view_framework_parameters ::
	@echo 'AWS::SAM::Event ($(_AWS_SAM_EVENT_MK_VERSION)) parameters:'
	@echo '    SAM_EVENT_COMMAND_ARGUMENTS=$(SAM_EVENT_COMMAND_ARGUMENTS)'
	@echo '    SAM_EVENT_COMMAND_NAME=$(SAM_EVENT_COMMAND_NAME)'
	@echo '    SAM_EVENT_DIRPATH=$(SAM_EVENT_DIRPATH)'
	@echo '    SAM_EVENT_FILENAME=$(SAM_EVENT_FILENAME)'
	@echo '    SAM_EVENT_FILEPATH=$(SAM_EVENT_FILEPATH)'
	@echo '    SAM_EVENT_NAME=$(SAM_EVENT_NAME)'
	@echo '    SAM_EVENT_SOURCE_NAME=$(SAM_EVENT_SOURCE_NAME)'
	@echo '    SAM_EVENTS_DIRPATH=$(SAM_EVENTS_DIRPATH)'
	@echo '    SAM_EVENTS_SET_NAME=$(SAM_EVENTS_SET_NAME)'
	@echo

_sam_view_framework_targets ::
	@echo 'AWS::SAM::Event ($(_AWS_SAM_EVENT_MK_PROJECT_VERSION)) targets:'
	@echo '    _sam_create_event                 - Create an event'
	@echo '    _sam_delete_event                 - Delete an event'
	@echo '    _sam_show_event                   - Show everything related to an event'
	@echo '    _sam_show_event_content           - Show content of an event'
	@echo '    _sam_show_event_description       - Show content of an event'
	@echo '    _sam_view_events                  - View events'
	@echo '    _sam_view_events_set              - View set of events'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sam_create_event:
	@$(INFO) '$(SAM_UI_LABEL)Creating event "$(SAM_EVENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'To see supported event-source     : sam local generate-event --help'; $(NORMAL)
	@$(WARN) 'To see supported commands         : sam local generate-event <event-source> --help'; $(NORMAL)
	@$(WARN) 'To see supported command-arguments: sam local generate-event <event-source> <command> --help'; $(NORMAL)
	$(_SAM_CREATE_EVENT_|) $(SAM) local generate-event $(SAM_EVENT_SOURCE_NAME) $(SAM_EVENT_COMMAND_NAME) $(SAM_EVENT_COMMAND_ARGUMENTS) $(|_SAM_CREATE_EVENT)

_sam_delete_event:
	@$(INFO) '$(SAM_UI_LABEL)Deleting event "$(SAM_EVENT_NAME)" ...'; $(NORMAL)

_sam_show_event: _sam_show_event_content _sam_show_event_description

_sam_show_event_content:
	@$(INFO) '$(SAM_UI_LABEL)Showing content of event "$(SAM_EVENT_NAME)" ...'; $(NORMAL)
	$(_SAM_SHOW_EVENT_DESCRIPTION_|) cat $(SAM_EVENT_FILENAME)

_sam_show_event_description:
	@$(INFO) '$(SAM_UI_LABEL)Showing description of event "$(SAM_EVENT_NAME)" ...'; $(NORMAL)
	$(_SAM_SHOW_EVENT_DESCRIPTION_|) ls -al $(SAM_EVENT_FILENAME)

_sam_view_events:
	@$(INFO) '$(SAM_UI_LABEL)Viewing events ...'; $(NORMAL)
	$(_SAM_VIEW_EVENTS_|) ls -l *

_sam_view_events_set:
	@$(INFO) '$(SAM_UI_LABEL)Viewing events-set "$(SAM_EVENTS_SET_NAME)" ...'; $(NORMAL)
