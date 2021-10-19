_AWS_KINESIS_RECORD_MK_VERSION= $(_AWS_KINESIS_MK_VERSION)

# KSS_RECORD_CONTENT?=
# KSS_RECORD_CONTENT_FILEPATH?=
# KSS_RECORD_DATA?=
# KSS_RECORD_HASHKEY?=
# KSS_RECORD_PARTITIONKEY?=
# KSS_RECORD_STREAM_NAME?= my-stream 
# KSS_RECORDS_CONTENT?= Data=blob,ExplicitHashKey=string,PartitionKey=string ...
# KSS_RECORDS_CONTENT_FILEPATH?= ./records-content.json
# KSS_RECORDS_SHARDITERATOR?=
# KSS_RECORDS_SHARDITERATOR_TYPE?= LATEST
# KSS_RECORDS_STREAM_NAME?= my-stream

# Derived parameters
KSS_RECORD_STREAM_NAME?= $(KSS_STREAM_NAME)
KSS_RECORDS_CONTENT?= $(if $(KSS_RECORDS_CONTENT_FILEPATH),file://$(KSS_RECORDS_CONTENT_FILEPATH))
KSS_RECORDS_SHARDITERATOR?= $(KSS_SHARD_ITERATOR)
KSS_RECORDS_SHARDITERATOR_TYPE?= $(KSS_SHARD_ITERATOR_TYPE)
KSS_RECORDS_STREAM_NAME?= $(KSS_RECORD_STREAM_NAME)

# Option parameters
__KSS_DATA= $(if $(KSS_RECORD_DATA),--data $(KSS_RECORD_DATA))
__KSS_EXPLICIT_HASH_KEY= $(if $(KSS_RECORD_HASHKEY),--explicit-hash-key $(KSS_RECORD_HASHKEY))
__KSS_LIMIT__RECORD= $(if $(KSS_RECORDS_COUNT_LIMIT),--limit $(KSS_RECORDS_COUNT_LIMIT))
__KSS_PARTITION_KEY= $(if $(KSS_RECORD_PARTITIONKEY),--partition-key $(KSS_RECORD_PARTITIONKEY))
__KSS_RECORDS= $(if $(KSS_RECORDS_CONTENT),--records $(KSS_RECORDS_CONTENT))
__KSS_SHARD_ITERATOR__RECORDS= $(if $(KSS_RECORDS_SHARDITERATOR),--shard-iterator $(KSS_RECORDS_SHARDITERATOR))
__KSS_STREAM_NAME__RECORD= $(if $(KSS_RECORD_STREAM_NAME),--stream-name $(KSS_RECORD_STREAM_NAME))

# UI parameters
KSS_UI_READ_RECORDS_FIELDS?= .{ApproximateArrivalTimestamp:ApproximateArrivalTimestamp,PartitionKey:PartitionKey,SequenceNumber:SequenceNumber,data:Data}
KSS_UI_READ_RECORD_QUERYFILTER?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kss_view_framework_macros ::
	@echo 'AWS::KineSiS::Record ($(_AWS_KINESIS_RECORD_MK_VERSION)) macros:'
	@echo

_kss_view_framework_parameters ::
	@echo 'AWS::KineSiS::Record ($(_AWS_KINESIS_RECORD_MK_VERSION)) parameters:'
	@echo '    KSS_RECORD_CONTENT=$(KSS_RECORD_CONTENT)'
	@echo '    KSS_RECORD_CONTENT_FILEPATH=$(KSS_RECORD_CONTENT_FILEPATH)'
	@echo '    KSS_RECORD_DATA=$(KSS_RECORD_DATA)'
	@echo '    KSS_RECORD_HASHKEY=$(KSS_RECORD_HASHKEY)'
	@echo '    KSS_RECORD_PARTITIONKEY=$(KSS_RECORD_PARTITIONKEY)'
	@echo '    KSS_RECORD_STREAM_NAME=$(KSS_RECORD_STREAM_NAME)'
	@echo '    KSS_RECORDS_CONTENT=$(KSS_RECORDS_CONTENT)'
	@echo '    KSS_RECORDS_CONTENT_FILEPATH=$(KSS_RECORDS_CONTENT_FILEPATH)'
	@echo '    KSS_RECORDS_SHARDITERATOR=$(KSS_RECORDS_SHARDITERATOR)'
	@echo '    KSS_RECORDS_SHARDITERATOR_TYPE=$(KSS_RECORDS_SHARDITERATOR_TYPE)'
	@echo '    KSS_RECORDS_STREAM_NAME=$(KSS_RECORDS_STREAM_NAME)'
	@echo

_kss_view_framework_targets ::
	@echo 'AWS::KineSiS::Record ($(_AWS_KINESIS_RECORD_MK_VERSION)) targets:'A
	@echo '    _kss_read_records                            - Read records from a streams'
	@echo '    _kss_write_record                            - Write 1 record to a streams'
	@echo '    _kss_write_records                           - Write records to a streams'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kss_read_records:
	@$(INFO) '$(AWS_UI_LABEL)Reading records from stream "$(KSS_RECORD_STREAM_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the shard-iterator is older than 5 minutes or 300 000 millisec!'; $(NORMAL)
	@$(WARN) 'By default, the returned records are ordered from oldest to newest'; $(NORMAL)
	@$(WARN) 'Rereading a shard with the same shard-iterator will read from the same initial record and onward'; $(NORMAL)
	$(AWS) kinesis get-records $(__KSS_LIMIT__RECORD) $(__KSS_SHARD_ITERATOR__RECORDS) --query "Records[$(KSS_UI_READ_RECORDS_QUERYFILTER)]$(KSS_UI_READ_RECORDS_FIELDS)"

_kss_write_record:
	@$(INFO) '$(AWS_UI_LABEL)Writing 1 record to stream "$(KSS_RECORD_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis put-record $(__KSS_DATA) $(__KSS_EXPLICIT_HASH_KEY) $(__KSS_PARTITION_KEY) $(__KSS_STREAM_NAME__RECORD)

_kss_write_records:
	@$(INFO) '$(AWS_UI_LABEL)Writing X records to stream "$(KSS_RECORD_STREAM_NAME)" ...'; $(NORMAL)
	$(AWS) kinesis put-records $(__KSS_RECORDS) $(__KSS_STREAM_NAME__RECORD)
