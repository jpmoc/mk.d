_AWS_KINESIS_STREAM_MK_VERSION= $(_AWS_KINESIS_MK_VERSION)

# KSS_STREAM_ARN?= arn:aws:kinesis:us-east-1:123456789012:stream/my-stream
# KSS_STREAM_CREATION_DATE?=
# KSS_STREAM_CREATION_TIMEPSTAMP?=
# KSS_STREAM_ENCRYPTION_TYPE?= KMS
KSS_STREAM_INDEX?= 0
# KSS_STREAM_KMSKEY_ID?= arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012
# KSS_STREAM_NAME?= my-stream 
# KSS_STREAM_RETENTIONPERIOD?= 24
KSS_STREAM_SCALING_TYPE?= UNIFORM_SCALING
# KSS_STREAM_SHARD_COUNT?= 1
# KSS_STREAM_SHARD_IDS?= shardId-000000000000 ...
# KSS_STREAM_SHARD_METRICS?= ALL
# KSS_STREAM_SHARD_TARGETCOUNT?= 1
# KSS_STREAM_SHARDITERATOR?=
# KSS_STREAM_SHARDITERATOR_TYPE?=
# KSS_STREAM_TAGS?= KeyName1=string,KeyName2=string
# KSS_STREAM_TAGS_KEY?= KeyName1 KeyName2 ...
# KSS_STREAMS_MAX_ITEMS?= 10
# KSS_STREAMS_SET_NAME?= my-streams-set 

# Derived parameters
KSS_STREAM_ARN?= arn:aws:kinesis:$(AWS_REGION):$(AWS_ACCOUNT_ID):stream/$(KSS_STREAM_NAME)
KSS_STREAM_CREATION_DATE?= $(if $(KSS_STREAM_CREATION_TIMESTAMP),$(shell $(DATE) -d @$(KSS_STREAM_CREATION_TIMESTAMP)))
KSS_STREAM_KMSKEY_ID?= $(KMS_KEY_ID)
KSS_STREAM_SHARDITERATOR?= $(KSS_SHARD_ITERATOR)
KSS_STREAM_SHARDITERATOR_TYPE?= $(KSS_SHARD_ITERATOR_TYPE)

# Option parameters
__KSS_ENCRYPTION_TYPE= $(if $(KSS_STREAM_ENCRYPTION_TYPE),--encryption-type $(KSS_STREAM_ENCRYPTION_TYPE))
__KSS_EXCLUSIVE_START_TAG_KEY=
__KSS_KEY_ID= $(if $(KSS_STREAM_KMSKEY_ID),--key-id $(KSS_STREAM_KMSKEY_ID))
__KSS_LIMIT__STREAM=
__KSS_MAX_ITEMS__STREAMS= $(if $(KSS_STREAMS_MAX_ITEMS),--max-items $(KSS_STREAMS_MAX_ITEMS))
__KSS_RETENTION_PERIOD_HOURS= $(if $(KSS_STREAM_RETENTIONPERIOD),--retention-period-hours $(KSS_STREAM_RETENTIONPERIOD))
__KSS_SHARD_COUNT= $(if $(KSS_STREAM_SHARD_COUNT),--shard-count $(KSS_STREAM_SHARD_COUNT))
__KSS_SHARD_ITERATOR__STREAM= $(if $(KSS_STREAM_SHARDITERATOR),--shard-iterator $(KSS_STREAM_SHARDITERATOR))
__KSS_SHARD_LEVEL_METRICS= $(if $(KSS_STREAM_SHARD_METRICS),--shard-level-metrics $(KSS_STREAM_SHARD_METRICS))
__KSS_SCALING_TYPE= $(if $(KSS_STREAM_SCALING_TYPE),--scaling-type $(KSS_STREAM_SCALING_TYPE))
__KSS_STREAM_NAME= $(if $(KSS_STREAM_NAME),--stream-name $(KSS_STREAM_NAME))
__KSS_TAG_KEYS__STREAM= $(if $(KSS_STREAM_TAGS_KEYS),--tag-keys $(KSS_STREAM_TAGS_KEYS))
__KSS_TAGS__STREAM= $(if $(KSS_STREAM_TAGS),--tags $(KSS_STREAM_TAGS))
__KSS_TARGET_SHARD_COUNT= $(if $(KSS_STREAM_SHARD_TARGETCOUNT),--target-shard-count $(KSS_STREAM_SHARD_TARGETCOUNT))

# UI parameters
KSS_GET_STREAM_NAME_QUERYFILTER?= $(KSS_UI_VIEW_STREAMS_SET_QUERYFILTER)
KSS_UI_SHOW_STREAM_RECORDS_QUERYFILTER?= 0:10
# KSS_UI_SHOW_STREAM_RECORDS_FIELDS?= .{ApproximateArrivalTimestamp:ApproximateArrivalTimestamp,PartitionKey:PartitionKey,SequenceNumber:SequenceNumber,data:Data}
KSS_UI_SHOW_STREAM_RECORDS_FIELDS?= .{ApproximateArrivalTimestamp:ApproximateArrivalTimestamp,PartitionKey:PartitionKey,SequenceNumber:SequenceNumber}
KSS_UI_VIEW_STREAMS_FIELDS?=
KSS_UI_VIEW_STREAMS_SET_FIELDS?= $(KSS_UI_VIEW_STREAMS_FIELDS)
KSS_UI_VIEW_STREAMS_SET_QUERYFILTER?=

#--- Utilities

#--- MACROS
_kss_get_stream_arn= $(call _kss_get_stream_arn_N, $(KSS_STREAM_NAME))
_kss_get_stream_arn_N= $(shell echo arn:aws:kinesis:$(AWS_REGION):$(AWS_ACCOUNT_ID):stream/$(strip $(1)))

_kss_get_stream_creation_timestamp= $(call _kss_get_stream_creation_timestamp_N, $(KSS_STREAM_NAME))
_kss_get_stream_creation_timestamp_N= $(shell $(AWS) kinesis describe-stream-summary --stream-name $(1) --query "StreamDescriptionSummary.StreamCreationTimestamp" --output text)

_kss_get_stream_name= $(call _kss_get_stream_name_I, $(KSS_STREAM_INDEX))
_kss_get_stream_name_I= $(call  _kss_get_stream_name_IF, $(1), $(KSS_GET_STREAM_NAME_QUERYFILTER))
# _kss_get_stream_name_IF= $(shell $(AWS) kinesis list-streams --query "StreamNames[$(strip $(2))] | [$(1)]" --output text)
_kss_get_stream_name_IF= $(shell $(AWS) kinesis list-streams $(__KSS_MAX_ITEMS__STREAMS) --query "StreamNames[$(strip $(2))]"  --output json | jq -r '.[$(strip $(1))]' )

_kss_get_stream_shard_ids= $(call _kss_get_stream_shard_ids_N, $(KSS_STREAM_NAME))
_kss_get_stream_shard_ids_N= $(shell $(AWS) kinesis describe-stream --stream-name $(1) --query "StreamDescription.Shards[].ShardId" --output text) 

#----------------------------------------------------------------------
# USAGE
#

_kss_view_framework_macros ::
	@echo 'AWS::KineSiS::Stream ($(_AWS_KINESIS_STREAM_MK_VERSION)) macros:'
	@echo '    _kss_get_stream_arn_{|N}                     - Get the ARM of a stream (Name)'
	@echo '    _kss_get_stream_creation_timestamp_{|N}          - Get the creation-timestamp of a stream (Name)'
	@echo '    _kss_get_stream_name_{|I|IF}                 - Get the name of a stream (Index,queryFilter)'
	@echo '    _kss_get_stream_shard_ids_{|N}               - Get the shard-ids of a stream (Name)'
	@echo

_kss_view_framework_parameters ::
	@echo 'AWS::KineSiS::Stream ($(_AWS_KINESIS_STREAM_MK_VERSION)) parameters:'
	@echo '    KSS_STREAM_ARN=$(KSS_STREAM_ARN)'
	@echo '    KSS_STREAM_CREATION_DATE=$(KSS_STREAM_CREATION_DATE)'
	@echo '    KSS_STREAM_CREATION_TIMESTAMP=$(KSS_STREAM_CREATION_TIMESTAMP)'
	@echo '    KSS_STREAM_ENCRYPTION_TYPE=$(KSS_STREAM_ENCRYPTION_TYPE)'
	@echo '    KSS_STREAM_INDEX=$(KSS_STREAM_INDEX)'
	@echo '    KSS_STREAM_KMSKEY_ID=$(KSS_STREAM_KMSKEY_ID)'
	@echo '    KSS_STREAM_NAME=$(KSS_STREAM_NAME)'
	@echo '    KSS_STREAM_RETENTIONPERIOD=$(KSS_STREAM_RETENTIONPERIOD)'
	@echo '    KSS_STREAM_SCALING_TYPE=$(KSS_STREAM_SCALING_TYPE)'
	@echo '    KSS_STREAM_SHARD_COUNT=$(KSS_STREAM_SHARD_COUNT)'
	@echo '    KSS_STREAM_SHARD_IDS=$(KSS_STREAM_SHARD_IDS)'
	@echo '    KSS_STREAM_SHARDITERATOR=$(KSS_STREAM_SHARDITERATOR)'
	@echo '    KSS_STREAM_SHARDITERATOR_TYPE=$(KSS_STREAM_SHARDITERATOR_TYPE)'
	@echo '    KSS_STREAM_SHARD_METRICS=$(KSS_STREAM_SHARD_METRICS)'
	@echo '    KSS_STREAM_TAGS=$(KSS_STREAM_TAGS)'
	@echo '    KSS_STREAM_TAGS_KEYS=$(KSS_STREAM_TAGS_KEYS)'
	@echo '    KSS_STREAMS_MAX_ITEMS=$(KSS_STREAMS_MAX_ITEMS)'
	@echo '    KSS_STREAMS_SET_NAME=$(KSS_STREAMS_SET_NAME)'
	@echo

_kss_view_framework_targets ::
	@echo 'AWS::KineSiS::Stream ($(_AWS_KINESIS_STREAM_MK_VERSION)) targets:'A
	@echo '    _kss_create_stream                           - Create a new stream'
	@echo '    _kss_decrease_stream_retention               - Decrease retention-period of a stream'
	@echo '    _kss_delete_stream                           - Delete an existing stream'
	@echo '    _kss_disable_stream_monitoring               - Disable monitoring of a stream'
	@echo '    _kss_enable_stream_monitoring                - Enable monitoring of a stream'
	@echo '    _kss_increase_stream_retention               - Increase retention-period of a stream'
	@echo '    _kss_show_stream                             - Show everything related to a stream'
	@echo '    _kss_show_stream_description                 - Show description of a stream'
	@echo '    _kss_show_stream_monitoring                  - Show monitoring of a stream'
	@echo '    _kss_show_stream_records                     - Show records in a shard of a stream'
	@echo '    _kss_show_stream_shards                      - Show shards of a stream'
	@echo '    _kss_show_stream_tags                        - Show tags of a stream'
	@echo '    _kss_start_stream_encryption                 - Start encrypting a stream'
	@echo '    _kss_stop_stream_encryption                  - Stop encrypting a stream'
	@echo '    _kss_tag_stream                              - Tag a stream'
	@echo '    _kss_untag_stream                            - Untag a stream'
	@echo '    _kss_update_stream_shardcount                - Update shard-count of a stream'
	@echo '    _kss_view_streams                            - View streams'
	@echo '    _kss_view_streams_set                        - View a set of streams'
	@echo '    _kss_wait_stream_exists                      - Wait until a stream exists'
	@echo '    _kss_wait_stream_exists                      - Wait until a stream exists'
	@echo '    _kss_wait_stream_notexists                   - Wait until a stream does not exists'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kss_create_stream:
	@$(INFO) '$(AWS_UI_LABEL)Creating stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The default retention period is set to 24 hours'; $(NORMAL)
	@$(WARN) 'This operation fails if a stream with that name already exists!'; $(NORMAL)
	$(AWS) kinesis create-stream $(__KSS_SHARD_COUNT) $(__KSS_STREAM_NAME)

_kss_decrease_stream_retention:
	@$(INFO) '$(AWS_UI_LABEL)Decreasing retention-period of stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The retention-period cannot be less than 24 hour'; $(NORMAL)
	@$(WARN) 'This operation may result in lost data'; $(NORMAL)
	$(AWS) kinesis decrease-stream-retention-period $(__KSS_RETENTION_PERIOD_HOURS) $(__KSS_STREAM_NAME)

_kss_delete_stream:
	@$(INFO) '$(AWS_UI_LABEL)Deleting stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis delete-stream $(__KSS_STREAM_NAME)

_kss_disable_stream_monitoring:
	@$(INFO) '$(AWS_UI_LABEL)Disabling monitoring of stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis disable-enhanced-monitoring $(__KSS_SHARD_LEVEL_METRICS) $(__KSS_STREAM_NAME)

_kss_enable_stream_monitoring:
	@$(INFO) '$(AWS_UI_LABEL)Enabling monitoring of stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis enable-enhanced-monitoring $(__KSS_SHARD_LEVEL_METRICS) $(__KSS_STREAM_NAME)

_kss_increase_stream_retention:
	@$(INFO) '$(AWS_UI_LABEL)Increasing the retention-period of stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The data retention period can be increased from 24 hours up to 168 hours'; $(NORMAL)
	$(AWS) kinesis increase-stream-retention-period $(__KSS_RETENTION_PERIOD_HOURS) $(__KSS_STREAM_NAME)

_kss_show_stream: _kss_show_stream_monitoring _kss_show_stream_records _kss_show_stream_shards _kss_show_stream_tags _kss_show_stream_description

_kss_show_stream_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis describe-stream-summary $(__KSS_STREAM_NAME) --query "StreamDescriptionSummary"
	@$(WARN) 'KSS_STREAM_CREATION_DATE=$(KSS_STREAM_CREATION_DATE)'; $(NORMAL)

_kss_show_stream_monitoring:
	@$(INFO) '$(AWS_UI_LABEL)Showing monitoring of stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns nothing if enhanced monitoring is not enabled'; $(NORMAL)
	@$(WARN) 'Shard-level metrics are valuable for identifying the distribution of data throughput'
	@$(WARN) 'Data is available in 1-minute periods in cloudwatch'; $(NORMAL)
	$(AWS) kinesis describe-stream $(__KSS_STREAM_NAME) --query "StreamDescription.EnhancedMonitoring" --output json

_kss_show_stream_records:
	@$(INFO) '$(AWS_UI_LABEL)Showing records in shard of stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a few select records since the shard-iteartor'; $(NORMAL)
	@$(WARN) 'Beware: KSS_STREAM_SHARDITERATOR_TYPE=$(KSS_STREAM_SHARDITERATOR_TYPE)'; $(NORMAL)
	$(AWS) kinesis get-records $(__KSS_SHARD_ITERATOR__STREAM) --query "Records[$(KSS_UI_SHOW_STREAM_RECORDS_QUERYFILTER)]$(KSS_UI_SHOW_STREAM_RECORDS_FIELDS)"
	@$(WARN) 'NOW is $(shell date +%s) seconds since 1970-01-01 00:00:00 UTC'; $(NORMAL)

_kss_show_stream_shards:
	@$(INFO) '$(AWS_UI_LABEL)Showing shards of stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis describe-stream $(__KSS_STREAM_NAME) --query "StreamDescription.Shards[]"

_kss_show_stream_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis list-tags-for-stream $(__KSS_EXCLUSIVE_START_TAG_KEY) $(__KSS_LIMIT__STREAM) $(__KSS_STREAM_NAME)

_kss_start_stream_encryption:
	@$(INFO) '$(AWS_UI_LABEL)Starting encryption of stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation enables server-side encryption to encrypt data in the stream with an AWS KMS master key'; $(NORMAL)
	$(AWS) kinesis start-stream-encryption $(__KSS_ENCRYPTION_TYPE) $(__KSS_KEY_ID) $(__KSS_STREAM_NAME)

_kss_stop_stream_encryption:
	@$(INFO) '$(AWS_UI_LABEL)Stopping encryption of stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis stop-stream-encryption $(__KSS_ENCRYPTION_TYPE) $(__KSS_KEY_ID) $(__KSS_STREAM_NAME)

_kss_tag_stream:
	@$(INFO) '$(AWS_UI_LABEL)Adding tags to stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis add-tags-to-stream $(__KSS_STREAM_NAME) $(__KSS_TAGS__STREAM)

_kss_untag_stream:
	@$(INFO) '$(AWS_UI_LABEL)Removing tags from stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis remove-tags-from-stream $(__KSS_STREAM_NAME) $(__KSS_TAG_KEYS__STREAM)

_kss_update_stream_shardcount:
	@$(INFO) '$(AWS_UI_LABEL)Updating shard-count of stream "$(KSS_STREAM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'You can at most increase/decrease your shard-count by a factor of 2 in a 24-hour period'; $(NORMAL)
	$(AWS) kinesis update-shard-count $(__KSS_SCALING_TYPE) $(__KSS_STREAM_NAME) $(__KSS_TARGET_SHARD_COUNT)

_kss_view_streams:
	@$(INFO) '$(AWS_UI_LABEL)Viewing streams ...'; $(NORMAL)
	$(AWS) kinesis list-streams --query "StreamNames[]$(KSS_UI_VIEW_STREAMS_FIELDS)"

_kss_view_streams_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing streams-set "$(KSS_STREAMS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Streams are grouped based on the provided slice'; $(NORMAL)
	$(AWS) kinesis list-streams $(__KSS_MAX_ITEMS__STREAMS) --query "StreamNames[$(KSS_UI_VIEW_STREAMS_SET_QUERYFILTER)]$(KSS_UI_VIEW_STREAMS_SET_FIELDS)"

_kss_wait_stream_active:
	@$(INFO) '$(AWS_UI_LABEL)Waiting for stream "$(KSS_STREAM_NAME)" to be ACTIVE ...'; $(NORMAL)
	@$(WARN) 'The status of the stream is polled every 10 seconds!'; $(NORMAL)
	@$(WARN) 'This operation fails if the stream does NOT already exist!'; $(NORMAL)
	@$(WARN) 'This operation fails if the ACTIVE state has not been reached in less than 3 minutes!'; $(NORMAL)
	$(AWS) kinesis wait stream-exists $(__KSS_STREAM_NAME)

_kss_wait_stream_notfound:
	@$(INFO) '$(AWS_UI_LABEL)Waiting for stream "$(KSS_STREAM_NAME)" to be NOT_FOUND ...'; $(NORMAL)
	$(AWS) kinesis wait stream-not-exists $(__KSS_STREAM_NAME)
