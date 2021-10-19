_AWS_LOGS_LOGGROUP_MK_VERSION= $(_AWS_LOGS_MK_VERSION)

# LGS_LOGGROUP_KMS_KEY_ID?=
# LGS_LOGGROUP_NAME?= /vsm/staging/client-vke
# LGS_LOGGROUP_SLICE_ENDTIME?=
# LGS_LOGGROUP_SLICE_FILTERPATTERN?=
LGS_LOGGROUP_SLICE_INTERLEAVED?= false
LGS_LOGGROUP_SLICE_MAXITEMS?= 2
# LGS_LOGGROUP_SLICE_STARTTIME?=
# LGS_LOGGROUP_STREAM_NAME?=
# LGS_LOGGROUP_SUBSCRIPTIONFILTER_NAMES?=
# LGS_LOGGROUP_TAGS_KEYS?= KeyName1 KeyName2
# LGS_LOGGROUP_TAGS_KEYVALUES?= KeyName1=string KeyName2=string
# LGS_LOGGROUPS_NAME_PREFIX?= /vsm/staging
# LGS_LOGGROUPS_SET_NAME?= my-loggroup-name

# Derived parameters
LGS_LOGGROUPS_SET_NAME?= $(LGS_LOGGROUPS_NAME_PREFIX)

# Options parameters
__LGS_END_TIME= $(if $(LGS_LOGGROUP_SLICE_ENDTIME),--end-time $(LGS_LOGGROUP_SLICE_ENDTIME))
__LGS_FILTER_PATTERN= $(if $(LGS_LOGGROUP_SLICE_FILTERPATTERN),--filter-pattern $(LGS_LOGGROUP_SLICE_FILTERPATTERN))
__LGS_INTERLEAVED= $(if $(filter true,$(LGS_LOGGROUP_SLICE_INTERLEAVED)),--interleaved,--no-interleaved)
__LGS_KMS_KEY_ID= $(if $(LGS_LOGGROUP_KMS_KEY_ID),--kms-key-id $(LGS_LOGGROUP_KMS_KEY_ID))
__LGS_LOG_GROUP_NAME= $(if $(LGS_LOGGROUP_NAME),--log-group-name $(LGS_LOGGROUP_NAME))
__LGS_LOG_GROUP_NAME_PREFIX= $(if $(LGS_LOGGROUPS_NAME_PREFIX),--log-group-name-prefix $(LGS_LOGGROUPS_NAME_PREFIX))
__LGS_MAX_ITEMS__LOGGROUP= $(if $(LGS_LOGGROUP_SLICE_MAXITEMS),--max-items $(LGS_LOGGROUP_SLICE_MAXITEMS))
__LGS_START_TIME= $(if $(LGS_LOGGROUP_SLICE_STARTTIME),--start-time $(LGS_LOGGROUP_SLICE_STARTTIME))
__LGS_STREAM_NAMES__LOGGROUP= $(if $(LGS_LOGGROUP_SLICE_STREAMNAMES),--stream-names $(LGS_LOGGROUP_SLICE_STREAMNAMES))
__LGS_TAGS__LOGGROUP= $(if $(LGS_LOGGROUP_TAGS_KEYVALUES),--tags $(subst $(SPACE),$(COMMA),$(LGS_LOGGROUP_TAGS_KEYVALUES)))
__LGS_TAGS_KEYS__LOGGROUP= $(if $(LGS_LOGGROUP_TAGS_KEYS),--tags $(LGS_LOGGROUP_TAGS_KEYS))

# UI parameters
LGS_UI_SHOW_LOGGROUP_EVENTS_FIELDS?= .{IngestionTime:ingestionTime,message:message,Timestamp:timestamp,LogStreamName:logStreamName}
LGS_UI_SHOW_LOGGROUP_STREAMS_FIELDS?= .{arn:arn,creationTime:creationTime,logStreamName:logStreamName,storedBytes:storedBytes}
LGS_UI_VIEW_LOGGROUPS_FIELDS?= .{creationTime:creationTime,logGroupName:logGroupName}
LGS_UI_VIEW_LOGGROUPS_SET_FIELDS?= $(LGS_UI_VIEW_LOGGROUPS_FIELDS)
LGS_UI_VIEW_LOGGROUPS_SET_QUERYFILTER?=
LGS_UI_WATCH_LOGGROUP_INTERVAL?= 5


#--- Utilities

#--- MACRO

_lgs_get_loggroup_subscriptionfilter_names= $(call _lgs_get_loggroup_subscriptionfilter_names_N, $(LGS_LOGGROUP_NAME))
_lgs_get_loggroup_subscriptionfilter_names_N= $(shell $(AWS) logs describe-subscription-filters --log-group-name $(1) --query "subscriptionFilters[].filterName" --output text)

#----------------------------------------------------------------------
# USAGE
#

_lgs_view_framework_macros ::
	@echo 'AWS::LoGS::LogGroup ($(_AWS_LOGS_LOGGROUP_MK_VERSION)) macros:'
	@echo '    _lgs_get_loggroup_subscriptionfilter_names_{|N}  - Get subscription-filter-names of a log-group (Name)'
	@echo

_lgs_view_framework_parameters ::
	@echo 'AWS::LoGS::LogGroup ($(_AWS_LOGS_LOGGROUP_MK_VERSION)) parameters:'
	@echo '    LGS_LOGGROUP_KMS_KEY_ID=$(LGS_LOGGROUP_KMS_KEY_ID)'
	@echo '    LGS_LOGGROUP_NAME=$(LGS_LOGGROUP_NAME)'
	@echo '    LGS_LOGGROUP_SLICE_ENDTIME=$(LGS_LOGGROUP_SLICE_ENDTIME)'
	@echo '    LGS_LOGGROUP_SLICE_FITLERPATTERN=$(LGS_LOGGROUP_SLICE_FILTERPATTERN)'
	@echo '    LGS_LOGGROUP_SLICE_INTERLEAVED=$(LGS_LOGGROUP_SLICE_INTERLEAVED)'
	@echo '    LGS_LOGGROUP_SLICE_MAXITEMS=$(LGS_LOGGROUP_SLICE_MAXITEMS)'
	@echo '    LGS_LOGGROUP_SLICE_STARTTIME=$(LGS_LOGGROUP_SLICE_STARTTIME)'
	@echo '    LGS_LOGGROUP_SLICE_STREAMNAMES=$(LGS_LOGGROUP_SLICE_STREAMNAMES)'
	@echo '    LGS_LOGGROUP_SUBSCRIPTIONFILTER_NAMES=$(LGS_LOGGROUP_SUBSCRIPTIONFILTER_NAMES)'
	@echo '    LGS_LOGGROUP_TAGS_KEYS=$(LGS_LOGGROUP_TAGS_KEYS)'
	@echo '    LGS_LOGGROUP_TAGS_KEYVALUES=$(LGS_LOGGROUP_TAGS_KEYVALUES)'
	@echo '    LGS_LOGGROUPS_NAME_PREFIX=$(LGS_LOGGROUPS_NAME_PREFIX)'
	@echo '    LGS_LOGGROUPS_SET_NAME=$(LGS_LOGGROUPS_SET_NAME)'
	@echo

_lgs_view_framework_targets ::
	@echo 'AWS::LoGS::LogGroup ($(_AWS_LOGS_LOGGROUP_MK_VERSION)) targets:'
	@echo '    _lgs_create_loggroup                    - Create a log-group'
	@echo '    _lgs_delete_loggroup                    - Delete an existing log-group'
	@echo '    _lgs_secure_loggroup                    - Secure a log-group'
	@echo '    _lgs_show_loggroup                      - Show everything related to a log-group'
	@echo '    _lgs_show_loggroup_events               - Show events of a log-group'
	@echo '    _lgs_show_loggroup_streams              - Show all streams in a log-group'
	@echo '    _lgs_show_loggroup_tags                 - Show tags of a log-group'
	@echo '    _lgs_tag_loggroup                       - Tag a log-group'
	@echo '    _lgs_unsecure_loggroup                  - Unsecure a log-group'
	@echo '    _lgs_untag_loggroup                     - Untag a log-group'
	@echo '    _lgs_view_loggroups                     - View existing log-groups'
	@echo '    _lgs_view_loggroups_set                 - View a set of existing log-groups'
	@echo '    _lgs_watch_loggroup                     - Watching events on a log-group'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_lgs_create_loggroup:
	@$(INFO) '$(AWS_UI_LABEL)Creating log-group "$(LGS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs create-log-group $(__LGS_KMS_KEY_ID) $(__LGS_LOG_GROUP_NAME)

_lgs_delete_loggroup:
	@$(INFO) '$(AWS_UI_LABEL)Deleting log-group "$(LGS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs delete-log-group $(__LGS_LOG_GROUP_NAME)

_lgs_secure_loggroup:
	@$(INFO) '$(AWS_UI_LABEL)Securing log-group "$(LGS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs associate-kms-key $(__LGS_KMS_KEY_ID) $(__LGS_LOG_GROUP_NAME) $(__LGS_TAGS__LOGGROUP)

_lgs_show_loggroup: _lgs_show_loggroup_events _lgs_show_loggroup_streams _lgs_show_loggroup_subscriptionfilters _lgs_show_loggroup_tags

_lgs_show_loggroup_events:
	@$(INFO) '$(AWS_UI_LABEL)Showing events from log-group "$(LGS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs filter-log-events $(strip $(__LGS_END_TIME) $(__LGS_FILTER_PATTERN) $(__LGS_INTERLEAVED) $(__LGS_LOG_GROUP_NAME) $(__LGS_LOG_STREAM_NAME_PREFIX) $(__LGS_MAX_ITEMS__LOGGROUP) $(__LGS_LOG_STREAM_NAMES) $(__LGS_START_TIME) --query 'events[]$(LGS_UI_SHOW_LOGGROUP_EVENTS_FIELDS)' )

_lgs_show_loggroup_streams:
	@$(INFO) '$(AWS_UI_LABEL)Showing streams in log-group "$(LGS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs describe-log-streams $(__LGS_LOG_GROUP_NAME) --query 'logStreams[]$(LGS_UI_SHOW_LOGGROUP_STREAMS_FIELDS)' # LGS_UI_SHOW_LOGGROUP_STREAMS_FIELDS= .{arn:arn,creationTime:creationTime,logStreamName:logStreamName,storedBytes:storedBytes}

_lgs_show_loggroup_subscriptionfilters:
	@$(INFO) '$(AWS_UI_LABEL)Showing subscription-filters for log-group "$(LGS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs describe-subscription-filters $(_X__LGS_FILTER_NAME_PREFIX) $(__LGS_LOG_GROUP_NAME)

_lgs_show_loggroup_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of log-group "$(LGS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs list-tags-log-group $(__LGS_LOG_GROUP_NAME) --query 'tags'

_lgs_tag_loggroup:
	@$(INFO) '$(AWS_UI_LABEL)Tagging log-group "$(LGS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs tag-log-group $(__LGS_LOG_GROUP_NAME) $(__LGS_TAGS__LOGGROUP)

_lgs_unsecure_loggroup:
	@$(INFO) '$(AWS_UI_LABEL)Unsecuring log-group "$(LGS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs disassociate-kms-key $(__LGS_LOG_GROUP_NAME)

_lgs_untag_loggroup:
	@$(INFO) '$(AWS_UI_LABEL)Untagging log-group "$(LGS_LOGGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) logs untag-log-group $(__LGS_LOG_GROUP_NAME) $(__LGS_TAGS_KEYS__LOGGROUP)

_lgs_view_loggroups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing existing log-groups ...'; $(NORMAL)
	$(AWS) logs describe-log-groups $(_X__LGS_LOG_GROUP_NAME_PREFIX) --query "logGroups[]$(LGS_UI_VIEW_LOGGROUPS_FIELDS)"

_lgs_view_loggroups_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing log-groups-set "$(LGS_LOGGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Log-groups are grouped based on the name-prefix, query-filter, ...'; $(NORMAL)
	$(AWS) logs describe-log-groups $(__LGS_LOG_GROUP_NAME_PREFIX) --query "logGroups[$(LGS_UI_VIEW_LOGGROUPS_SET_QUERYFILTER)]$(LGS_UI_VIEW_LOGGROUPS_SET_FIELDS)"

_lgs_watch_loggroup:
	@$(INFO) '$(AWS_UI_LABEL)Watching events published in log-group "$(LGS_LOGGROUP_NAME)" ...'; $(NORMAL)
	watch -n $(LGS_UI_WATCH_LOGGROUP_INTERVAL) --color  'make -e --quiet _lgs_watch_loggroup_header _lgs_show_loggroup_events'

_lgs_watch_loggroup_footer ::

_lgs_watch_loggroup_header ::
