_AWS_CLOUDTRAIL_TRAIL_MK_VERSION=$(_AWS_CLOUDTRAIL_MK_VERSION)

# CTL_TRAIL_ARN?= arn:aws:cloudtrail:us-east-1:123456789012:trail/my-trail
# CTL_TRAIL_EVENTSELECTORS?= '[{"ReadWriteType": "All","IncludeManagementEvents": true,"DataResources": [{"Type":"AWS::S3::Object", "Values": ["arn:aws:s3:::mybucket/prefix","arn:aws:s3:::mybucket2/prefix2"]},{"Type": "AWS::Lambda::Function","Values": ["arn:aws:lambda:us-east-1:123456789012:function:hello-world-python-function"]}]}]'
# CTL_TRAIL_EVENTSELECTORS_FILEPATH?= ./trail-eventselectors.json
# CTL_TRAIL_GLOBALSERVICE_CAPTURE?= false
# CTL_TRAIL_KMSKEY_ID?=
# CTL_TRAIL_LOGGROUP_ARN?=
# CTL_TRAIL_LOGSROLE_ARN?=
CTL_TRAIL_LOGVALIDATION_ENABLE?= false
# CTL_TRAIL_LOGVALIDATION_ENDTIME?= 20160129T19:00:00Z
# CTL_TRAIL_LOGVALIDATION_STARTTIME?= 20150108T05:21:42Z
# CTL_TRAIL_LOGVALIDATION_VERBOSE?= true
CTL_TRAIL_MULTIREGION_SUPPORT?= false
# CTL_TRAIL_NAME?= Default
# CTL_TRAIL_S3BUCKET_NAME?=
# CTL_TRAIL_S3KEY_PREFIX?=
# CTL_TRAIL_SNSTOPIC_NAME?= my-topic
# CTL_TRAIL_TAGS?= Key=string,Value=string ...
# CTL_TRAILS_ARNS?=
CTL_TRAILS_INCLUDE_SHADOWTRAILS?= true
# CTL_TRAILS_NAMES?=
# CTL_TRAILS_SET_NAME?= my-trails-set

# Derived variables
CTL_TRAIL_EVENTSELECTORS?= $(if $(CTL_TRAIL_EVENTSELECTORS_FILEPATH), file://$(CTL_TRAIL_EVENTSELECTORS_FILEPATH))
CTL_TRAILS_ARNS?= $(CTL_TRAIL_ARN)

# Options variables
__CTL_CLOUD_WATCH_LOGS_LOG_GROUP__ARN= $(if $(CTL_TRAIL_LOGGROUP_ARN), --cloud-watch-logs-log-group-arn $(CTL_TRAIL_LOGGROUP_ARN))
__CTL_CLOUD_WATCH_LOGS_ROLE_ARN= $(if $(CTL_TRAIL_LOGSROLE_ARN), --cloud-watch-logs-role-arn $(CTL_TRAIL_LOGSROLE_ARN))
__CTL_ENABLE_LOG_FILE_VALIDATION= $(if $(filter true, $(CTL_TRAIL_LOGVALIDATION_ENABLE)), --enable-log-file-validation, --no-enable-log-file-validation)
__CTL_END_TIME= $(if $(CTL_TRAIL_LOGVALIDATION_ENDTIME), --end-time $(CTL_TRAIL_LOGVALIDATION_ENDTIME))
__CTL_EVENT_SELECTORS= $(if $(CTL_TRAIL_EVENTSELECTORS), --event-selectors $(CTL_TRAIL_EVENTSELECTORS))
__CTL_INCLUDE_GLOBAL_SERVICE_EVENTS= $(if $(filter true, $(CTL_TRAIL_GLOBALSERVICE_CAPTURE)), --include-global-service-events, --no-include-global-service-events)
__CTL_INCLUDE_SHADOW_TRAILS= $(if $(filter false, $(CTL_TRAILS_INCLUDE_SHADOWTRAILS)), --no-include-shadow-trails, --include-shadow-trails)
__CTL_IS_MULTI_REGION_TRAIL= $(if $(filter true, $(CTL_TRAIL_MULTIREGION_SUPPORT)), --is-multi-region-trail, --no-is-multi-region-trail)
__CTL_KMS_KEY_ID= $(if $(CTL_TRAIL_KMSKEY_ID), --kms-key-id $(CTL_TRAIL_KMSKEY_ID))
__CTL_NAME_TRAIL= $(if $(CTL_TRAIL_NAME), --name $(CTL_TRAIL_NAME))
__CTL_RESOURCE_ID= $(if $(CTL_TRAIL_ARN), --resource-id $(CTL_TRAIL_ARN))
__CTL_RESOURCE_ID_LIST= $(if $(CTL_TRAILS_ARNS), --resource-id-list $(CTL_TRAILS_ARNS))
__CTL_S3_BUCKET_NAME= $(if $(CTL_TRAIL_S3BUCKET_NAME), --s3-bucket-name $(CTL_TRAIL_S3BUCKET_NAME))
__CTL_S3_KEY_PREFIX= $(if $(CTL_TRAIL_S3KEY_PREFIX), --s3-key-prefix $(CTL_TRAIL_S3KEY_PREFIX))
__CTL_START_TIME= $(if $(CTL_TRAIL_LOGVALIDATION_STARTTIME), --start-time $(CTL_TRAIL_LOGVALIDATION_STARTTIME))
__CTL_SNS_TOPIC_NAME= $(if $(CTL_TRAIL_SNSTOPIC_NAME), --sns-topic-name $(CTL_TRAIL_SNSTOPIC_NAME))
__CTL_TAGS_LIST= $(if $(CTL_TRAIL_TAGS), --tags-list $(CTL_TRAIL_TAGS))
__CTL_TRAIL_ARN= $(if $(CTL_TRAIL_ARN), --trail-arn $(CTL_TRAIL_ARN)) 
__CTL_TRAIL_NAME= $(if $(CTL_TRAIL_NAME), --trail-name $(CTL_TRAIL_NAME)) 
__CTL_TRAIL_NAME_LIST= $(if $(CTL_TRAILS_NAMES), --trail-name-list $(CTL_TRAILS_NAMES)) 
__CTL_VERBOSE= $(if $(filter true, $(CTL_TRAIL_LOGVALIDATION_VERBOSE)), --verbose)

# UI variables
CTL_UI_VIEW_TRAILS_FIELDS?= .{homeRegion:HomeRegion,Name:Name,s3BucketName:S3BucketName,s3KeyPrefix:S3KeyPrefix,homeRegion:HomeRegion,isMultiRegionTrail:IsMultiRegionTrail}
CTL_UI_VIEW_TRAILS_SET_FIELDS?= $(CTL_UI_VIEW_TRAILS_FIELDS)


#--- Utilities

#--- MACROS
_ctl_get_trail_arn= $(call _ctl_get_trail_arn_N, $(CTL_TRAIL_NAME))
_ctl_get_trail_arn_N= $(shell $(AWS) cloudtrail describe-trails --include-shadow-trails --trail-name-list $(1) --query "trailList[].TrailARN" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ctl_view_makefile_macros ::
	@echo 'AWS::CloudTraiL::Trail ($(_AWS_CLOUDTRAIL_TRAIL_MK_VERSION)) macros:'
	@echo

_ctl_view_makefile_targets ::
	@echo 'AWS::CloudTraiL::Trail ($(_AWS_CLOUDTRAIL_TRAIL_MK_VERSION)) targets:'
	@echo '    _ctl_create_trail                         - Create a new trail'
	@echo '    _ctl_delete_trail                         - Delete an existing trail'
	@echo '    _ctl_show_trail                           - Show details of a trail'
	@echo '    _ctl_show_trail_description               - Show description of a trail'
	@echo '    _ctl_show_trail_eventselector             - Show event-selector of a trail'
	@echo '    _ctl_show_trail_status                    - Show status of a trail'
	@echo '    _ctl_show_trail_tags                      - Show tags of a trail'
	@echo '    _ctl_tag_trail                            - Add one or more tags to a trail'
	@echo '    _ctl_update_trail                         - Update an existing trail'
	@echo '    _ctl_validate_logs                        - Validate logs of trail'
	@echo '    _ctl_view_trails                          - View existing trails'
	@echo '    _ctl_view_trails_set                      - View a set of trails'
	@echo 

_ctl_view_makefile_variables ::
	@echo 'AWS::CloudTraiL::Trail ($(_AWS_CLOUDTRAIL_TRAIL_MK_VERSION)) variables:'
	@echo '    CTL_TRAIL_ARN=$(CTL_TRAIL_ARN)'
	@echo '    CTL_TRAIL_EVENTSELECTORS=$(CTL_TRAIL_EVENTSELECTORS)'
	@echo '    CTL_TRAIL_GLOBALSERVICE_CAPTURE=$(CTL_TRAIL_GLOBALSERVICE_CAPTURE)'
	@echo '    CTL_TRAIL_KEYKMS_ID=$(CTL_TRAIL_KEYKMS_ID)'
	@echo '    CTL_TRAIL_LOGGROUP_ARN=$(CTL_TRAIL_LOGGROUP_ARN)'
	@echo '    CTL_TRAIL_LOGSROLE_ARN=$(CTL_TRAIL_LOGSROLE_ARN)'
	@echo '    CTL_TRAIL_LOGVALIDATION_ENABLE=$(CTL_TRAIL_LOGVALIDATION_ENABLE)'
	@echo '    CTL_TRAIL_LOGVALIDATION_ENDTIME=$(CTL_TRAIL_LOGVALIDATION_ENDTIME)'
	@echo '    CTL_TRAIL_LOGVALIDATION_STARTTIME=$(CTL_TRAIL_LOGVALIDATION_STARTTIME)'
	@echo '    CTL_TRAIL_LOGVALIDATION_VERBOSE=$(CTL_TRAIL_LOGVALIDATION_VERBOSE)'
	@echo '    CTL_TRAIL_MULTIREGION_SUPPORT=$(CTL_TRAIL_MULTIREGION_SUPPORT)'
	@echo '    CTL_TRAIL_NAME=$(CTL_TRAIL_NAME)'
	@echo '    CTL_TRAIL_S3BUCKET_NAME=$(CTL_TRAIL_S3BUCKET_NAME)'
	@echo '    CTL_TRAIL_S3KEY_PREFIX=$(CTL_TRAIL_S3KEY_PREFIX)'
	@echo '    CTL_TRAIL_SNSTOPIC_NAME=$(CTL_TRAIL_SNSTOPIC_NAME)'
	@echo '    CTL_TRAIL_TAGS=$(CTL_TRAIL_TAGS)'
	@echo '    CTL_TRAILS_ARNS=$(CTL_TRAILS_ARNS)'
	@echo '    CTL_TRAILS_INCLUDE_SHADOWTRAILS=$(CTL_TRAILS_INCLUDE_SHADOWTRAILS)'
	@echo '    CTL_TRAILS_NAMES=$(CTL_TRAILS_NAMES)'
	@echo '    CTL_TRAILS_SET_NAME=$(CTL_TRAILS_SET_NAME)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ctl_create_trail:
	@$(INFO) '$(AWS_UI_LABEL)Creating trail "$(CTL_TRAIL_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will fail if the bucket policy is not set and not set according to the bucket name and key prefix'; $(NORMAL)
	$(AWS) cloudtrail create-trail $(__CTL_ENABLE_LOG_FILE_VALIDATION) $(__CTL_CLOUD_WATCH_LOGS_LOG_GROUP_ARN) $(__CTL_CLOUD_WATCH_LOGS_ROLE_ARN) $(__CTL_INCLUDE_GLOBAL_SERVICE_EVENTS) $(__CTL_IS_MULTI_REGION_TRAIL) $(__CTL_KMS_KEY_ID) $(__CTL_NAME_TRAIL) $(__CTL_S3_BUCKET_NAME) $(__CTL_S3_KEY_PREFIX) $(__CTL_SNS_TOPIC_NAME)

_ctl_delete_trail:
	@$(INFO) '$(AWS_UI_LABEL)Deleting trail "$(CTL_TRAIL_NAME)" ...'; $(NORMAL)
	$(AWS) cloudtrail delete-trail $(__CTL_NAME_TRAIL)

_ctl_show_trail: _ctl_show_trail_eventselectors _ctl_show_trail_status _ctl_show_trail_tags _ctl_show_trail_description

_ctl_show_trail_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of trail "$(CTL_TRAIL_NAME)" ...'; $(NORMAL)
	$(AWS) cloudtrail describe-trails $(__CTL_INCLUDE_SHADOW_TRAILS) $(_X__CTL_TRAIL_NAME_LIST) --trail-name-list $(CTL_TRAIL_NAME) --query "trailList[]"

_ctl_show_trail_eventselectors:
	@$(INFO) '$(AWS_UI_LABEL)Showing event-selectors of trail "$(CTL_TRAIL_NAME)" ...'; $(NORMAL)
	$(AWS) cloudtrail get-event-selectors $(__CTL_TRAIL_NAME) --query "EventSelectors" --output json

_ctl_show_trail_status:
	@$(INFO) '$(AWS_UI_LABEL)Showing status of trail "$(CTL_TRAIL_NAME)" ...'; $(NORMAL)
	$(AWS) cloudtrail get-trail-status $(__CTL_NAME_TRAIL)

_ctl_show_trail_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of trail "$(CTL_TRAIL_NAME)" ...'; $(NORMAL)
	$(AWS) cloudtrail list-tags $(__CTL_RESOURCE_ID_LIST) --query "ResourceTagList[0].TagsList"

_ctl_start_logging:
	@$(INFO) '$(AWS_UI_LABEL)Starting logging in trail "$(CTL_TRAIL_NAME)" ...'; $(NORMAL)
	$(AWS) cloudtrail start-logging $(__CTL_NAME_TRAIL)

_ctl_stop_logging:
	@$(INFO) '$(AWS_UI_LABEL)Stopping logging in trail "$(CTL_TRAIL_NAME)" ...'; $(NORMAL)
	$(AWS) cloudtrail stop-logging $(__CTL_NAME_TRAIL)

_ctl_tag_trail:
	@$(INFO) '$(AWS_UI_LABEL)Tagging trail "$(CTL_TRAIL_NAME)" ...'; $(NORMAL)
	$(AWS) cloudtrail add-tags $(__CTL_RESOURCE_ID) $(__CTL_TAGS_LIST)

_ctl_update_trail:
	@$(INFO) '$(AWS_UI_LABEL)Updating trail "$(CTL_TRAIL_NAME)" ...'; $(NORMAL)
	$(AWS) cloudtrail update-trail $(__CTL_ENABLE_LOG_FILE_VALIDATION) $(__CTL_CLOUD_WATCH_LOGS_LOG_GROUP_ARN) $(__CTL_CLOUD_WATCH_LOGS_ROLE_ARN) $(__CTL_INCLUDE_GLOBAL_SERVICE_EVENTS) $(__CTL_IS_MULTI_REGION_TRAIL) $(__CTL_KMS_KEY_ID) $(__CTL_NAME_TRAIL) $(__CTL_S3_BUCKET_NAME) $(__CTL_S3_KEY_PREFIX) $(__CTL_SNS_TOPIC_NAME)

_ctl_update_trail_eventselectors:
	@$(INFO) '$(AWS_UI_LABEL)Updating event-selectors of trail "$(CTL_TRAIL_NAME)" ...'; $(NORMAL)
	$(if $(CTL_TRAIL_EVENTSELECTORS_FILEPATH), cat $(CTL_TRAIL_EVENTSELECTORS_FILEPATH))
	$(AWS) cloudtrail put-event-selectors $(__CTL_EVENT_SELECTORS) $(__CTL_TRAIL_NAME)

_ctl_validate_logs:
	@$(INFO) '$(AWS_UI_LABEL)Validating logs of trail "$(CTL_TRAIL_NAME)" ...'; $(NORMAL)
	$(AWS) cloudtrail validate-logs $(__CTL_END_TIME) $(__CTL_S3_BUCKET) $(__CTL_S3_PREFIX) $(__CTL_START_TIME) $(__CTL_TRAIL_ARN) $(__CTL_VERBOSE)

_ctl_view_trails:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all existing trails ...'; $(NORMAL)
	$(AWS) cloudtrail describe-trails $(__CTL_INCLUDE_SHADOW_TRAILS) $(_X__CTL_TRAIL_NAME_LIST) --query "trailList[]$(CTL_UI_VIEW_TRAILS_FIELDS)"

_ctl_view_trails_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing trails-set "$(CTL_TRAILS_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'The set is built based on the provided trail names'; $(NORMAL)
	$(AWS) cloudtrail describe-trails $(__CTL_INCLUDE_SHADOW_TRAILS) $(__CTL_TRAIL_NAME_LIST) --query "trailList[]$(CTL_UI_VIEW_TRAILS_SET_FIELDS)"
