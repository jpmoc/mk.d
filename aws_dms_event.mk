_AWS_DMS_EVENT_MK_VERSION=$(_AWS_DMS_MK_VERSION)

# DMS_EVENT_DURATION?=
# DMS_EVENT_END_TIME?=
# DMS_EVENT_SOURCE_IDENTIFIER?=
# DMS_EVENT_SOURCE_TYPE?= replication-instance | migration-task

# Option variables
__DMS_DURATION=
__DMS_END_TIME= $(if $(DMS_EVENT_END_TIME), --end-time $(DMS_END_TIME))
__DMS_SOURCE_IDENTIFIER= $(if $(DMS_EVENT_SOURCE_IDENTIFIER), --source-identifier $(DMS_EVENT_SOURCE_IDENTIFIER))
__DMS_SOURCE_TYPE= $(if $(DMS_EVENT_SOURCE_TYPE), --source-type $(DMS_EVENT_SOURCE_TYPE))
__DMS_START_TIME= $(if $(DMS_EVENT_START_TIME), --start-time $(DMS_EVENT_START_TIME))

# UI variables
DMS_UI_EVENT_SLICE?= 0:20:1
DMS_UI_VIEW_EVENTS_FIELDS?= .{Date:Date,Message:Message,SourceIdentifier:SourceIdentifier}

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_dms_view_makefile_macros ::
	@echo "AWS::DMS::Event ($(_AWS_DMS_EVENT_MK_VERSION)) macros:"
	@echo

_dms_view_makefile_targets ::
	@echo "AWS::DMS::Event ($(_AWS_DMS_EVENT_MK_VERSION)) targets:"
	@echo "    _dms_view_event_types                  - View event categories"
	@echo 

_dms_view_makefile_variables ::
	@echo "AWS::DMS::Event ($(_AWS_DMS_EVENT_MK_VERSION)) variables:"
	@echo "    DMS_EVENT_DURATION=$(DMS_EVENT_DURATION)"
	@echo "    DMS_EVENT_END_TIME=$(DMS_EVENT_END_TIME)"
	@echo "    DMS_EVENT_SLICE=$(DMS_EVENT_SLICE)"
	@echo "    DMS_EVENT_SOURCE_IDENTIFIER=$(DMS_EVENT_SOURCE_IDENTIFIER)"
	@echo "    DMS_EVENT_SOURCE_TYPE=$(DMS_EVENT_SOURCE_TYPE)"
	@echo "    DMS_EVENT_START_TIME=$(DMS_EVENT_START_TIME)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dms_show_event_types:
	@$(INFO) "$(AWS_UI_LABEL)Show DMS event categories ..."; $(NORMAL)
	$(AWS) dms describe-event-categories $(__DMS_SOURCE_TYPE)

_dms_view_events:
	@$(INFO) "$(AWS_UI_LABEL)Viewing DMS events ..."; $(NORMAL)
	$(AWS) dms describe-events $(__DMS_DURATION) $(__DMS_END_TIME) $(__DMS_EVENT_CATEGORIES) $(__DMS_FILTERS_EVENT) $(__DMS_SOURCE_IDENTIFIER) $(__DMS_SOURCE_TYPE) $(__DMS_START_TIME) --query "reverse(Events)[$(DMS_UI_EVENT_SLICE)]$(DMS_UI_VIEW_EVENTS_FIELDS)"
