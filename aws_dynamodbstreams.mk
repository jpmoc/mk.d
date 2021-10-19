_AWS_DYNAMODBSTREAMS_MK_VERSION=0.99.6

# DSS_SHARD_ID?=
# DSS_STREAM_ARN?= arn:aws:dynamodb:us-east-1:123456789012:table/TestTable/stream/2015-05-11T21:21:33.291
# DSS_TABLE_NAME?= my-dynamodb-table

# Derived variables

# Options variables
__DSS_EXCLUSIVE_START_STREAM_ARN=
__DSS_LIMIT=
__DSS_SEQUENCE_NUMBER=
__DSS_SHARD_ID= $(if $(DSS_SHARD_ID), --shard-id $(DSS_SHARD_ID))
__DSS_SHARD_ITERATOR_TYPE= $(if $(DSS_SHARD_ITERATOR_TYPE), --shard-iterator-type $(DSS_SHARD_ITERATOR_TYPE))
__DSS_STREAM_ARN= $(if $(DSS_STREAM_ARN), --stream-arn $(DSS_STREAM_ARN))
__DSS_TABLE_NAME= $(if $(DSS_TABLE_NAME), --table-name $(DSS_TABLE_NAME))


# UI variables
DSS_VIEW_STREAMS_FIELDS?=

#--- Utilities

#--- MACROS
_dss_get_stream_arn=$(call _ddb_get_backup_arn_I, 0)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _dss_view_makefile_macros
_dss_view_makefile_macros:
	@echo "AWS::DynamodbStreamS ($(_AWS_DYNAMODBSTREAMS_MK_VERSION)) macros:"
	@echo

_aws_view_makefile_targets :: _dss_view_makefile_targets
_dss_view_makefile_targets:
	@echo "AWS::DynamodbStreamS ($(_AWS_DYNAMODBSTREAMS_MK_VERSION)) targets:"
	@echo "    _dss_get_records                 - Get the stream record for a given shard"
	@echo "    _dss_get_shard_iterator          - Get a shard iterator"
	@echo "    _dss_show_stream                 - Show details of a DynamoDB stream"
	@echo "    _dss_view_stream                 - View DynamoDB streams"
	@echo 

_aws_view_makefile_variables :: _dss_view_makefile_variables
_dss_view_makefile_variables:
	@echo "AWS::DynamodbStreamS ($(_AWS_DYNAMODBSTREAMS_MK_VERSION)) variables:"
	@echo "    DSS_STREAM_ARN=$(DSS_STREAM_ARN)"
	@echo "    DSS_TABLE_NAME=$(DSS_TABLE_NAME)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dss_get_records:
	@$(INFO) "$(AWS_LABEL)Get records ..."; $(NORMAL)
	$(AWS) dynamodbstreams get-records $(__DSS_LIMIT) $(__DSS_SHARD_ITERATOR)

_dss_get_shard_iterator:
	@$(INFO) "$(AWS_LABEL)Get a shard iterator ..."; $(NORMAL)
	$(AWS) dynamodbstreams get-shard-iterator $(__DSS_SEQUENCE_NUMBER) $(__DSS_SHARD_ID) $(__DSS_SHARD_ITERATOR_TYPE) $(__DSS_STREAM_ARN)

_dss_show_stream:
	@$(INFO) "$(AWS_LABEL)Showing dynamodb stream ..."; $(NORMAL)
	$(AWS) dynamodbstreams describe-stream $(__DSS_STREAM_ARN)

_dss_view_streams:
	@$(INFO) "$(AWS_LABEL)Viewing dynamodb stream ..."; $(NORMAL)
	$(AWS) dynamodbstreams list-streams $(__DSS_EXCLUSIVE_START_STREAM_ARN) $(__DSS_LIMIT) $(__DSS_TABLE_NAME)
