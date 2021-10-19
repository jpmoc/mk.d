_AWS_FIREHOSE_MK_VERSION=0.99.6

# FHE_FIREHOSE_DESTINATION_ELASTICSEARCH_CONFIG?=
# FHE_FIREHOSE_DESTINATION_ELASTICSEARCH_UPDATE?=
# FHE_FIREHOSE_DESTINATION_ID?=
# FHE_FIREHOSE_DESTINATION_REDSHIFT_CONFIG?=
# FHE_FIREHOSE_DESTINATION_REDSHIFT_UPDATE?=
# FHE_FIREHOSE_DESTINATION_S3_CONFIG?=
# FHE_FIREHOSE_DESTINATION_S3_UPDATE?=
# FHE_FIREHOSE_DESTINATION_SPLUNK_CONFIG?=
# FHE_FIREHOSE_DESTINATION_SPLUNK_UPDATE?=
# FHE_FIREHOSE_NAME?= my-firehose
# FHE_FIREHOSE_SOURCE_KINESIS_CONFIG?= KinesisStreamARN=string,RoleARN=string
# FHE_FIREHOSE_TYPE?= KinesisStreamAsSource
# FHE_FIREHOSE_VERSION_ID?= 
# FHE_RECORD_FILEPATH?= ./record.json
# FHE_RECORD?= Data=blob
# FHE_RECORDS_FILEPATH?= ./records.json
# FHE_RECORDS?= Data1 Data2 Data3

# Derived variables
FHE_RECORD?= $(if $(FHE_RECORD_FILEPATH), file://$(FHE_RECORD_FILEPATH))
FHE_RECORDS?= $(if $(FHE_RECORDS_FILEPATH), file://$(FHE_RECORDS_FILEPATH))

# Options variables
__FHE_CURRENT_DELIVERY_STREAM_VERSION_ID= $(if $(FHE_FIREHOSE_VERSION_ID), --current-delivery-stream-version-id $(FHE_FIREHOSE_VERSION_ID))
__FHE_DELIVERY_STREAM_NAME= $(if $(FHE_FIREHOSE_NAME), --delivery-stream-name $(FHE_FIREHOSE_NAME))
__FHE_DELIVERY_STREAM_TYPE= $(if $(FHE_FIREHOSE_TYPE), --delivery-stream-type $(FHE_FIREHOSE_TYPE))
__FHE_DESTINATION_ID= $(if $(FHE_FIREHOSE_DESTINATION_ID), --destination-id $(FHE_FIREHOSE_DESTINATION_ID))
__FHE_ELASTICSEARCH_DESTINATION_CONFIGURATION=
__FHE_ELASTICSEARCH_DESTINATION_UPDATE=
__FHE_EXCLUSIVE_START_DESTINATION_ID=
__FHE_EXCLUSIVE_START_DELIVERY_STREAM_NAME=
__FHE_EXTENDED_S3_DESTINATION_CONFIGURATION=
__FHE_EXTENDED_S3_DESTINATION_UPDATE=
__FHE_KINESIS_STREAM_SOURCE_CONFIGURATION=
__FHE_RECORD= $(if $(FHE_RECORD), --record $(FHE_RECORD))
__FHE_RECORDS= $(if $(FHE_RECORDS), --records $(FHE_RECORDS))
__FHE_REDSHIFT_DESTINATION_CONFIGURATION=
__FHE_REDSHIFT_DESTINATION_UPDATE=
__FHE_S3_DESTINATION_CONFIGURATION=
__FHE_S3_DESTINATION_UPDATE=
__FHE_SPLUNK_DESTINATION_CONFIGURATION=
__FHE_SPLUNK_DESTINATION_UPDATE=
__FHE_LIMIT=

# UI variables
FHE_VIEW_FIREHOSES_FIELDS?=

#--- Utilities

#--- MACROS
_fhe_get_firehose_version_id=$(call _fhe_geet_firehose_version_id_N, $(FHE_FIREHOSE_NAME))
_fhe_get_firehose_version_id_N=$(shell $(AWS) firehose describe-delivery-stream ... --query  "DeliveryStreams[?Name=$(strip$(1))].VersionId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _dss_view_makefile_macros
_dss_view_makefile_macros:
	@echo "AWS::FireHosE ($(_AWS_FIREHOSE_MK_VERSION)) macros:"
	@echo "    - fhe_get_firehose_version_id_{|N}   - Get the current version ID of the firehose"
	@echo

_aws_view_makefile_targets :: _dss_view_makefile_targets
_dss_view_makefile_targets:
	@echo "AWS::FireHosE ($(_AWS_FIREHOSE_MK_VERSION)) targets:"
	@echo "    _fhe_create_firehose                 - Create a firehose"
	@echo "    _fhe_delete_firehose                 - Delete a firehose"
	@echo "    _fhe_put_record                      - Write single record into a firehose"
	@echo "    _fhe_put_record_batch                - Write a batch of records into a firehose"
	@echo "    _fhe_show_firehose                   - Show a firehose"
	@echo "    _fhe_update_firehose_destination     - Update a firehose's destination"
	@echo "    _fhe_view_firehoses                  - View firehoses"
	@echo 

_aws_view_makefile_variables :: _dss_view_makefile_variables
_dss_view_makefile_variables:
	@echo "AWS::FireHosE ($(_AWS_FIREHOSE_MK_VERSION)) variables:"
	@echo "    FHE_FIREHOSE_DESTINATION_ID=$(FHE_FIREHOSE_DESTINATION_ID)"
	@echo "    FHE_FIREHOSE_DESTINATION_ELASTICSEARCH_CONFIG=$(FHE_FIREHOSE_DESTINATION_ELASTICSEARCH_CONFIG)"
	@echo "    FHE_FIREHOSE_DESTINATION_ELASTICSEARCH_UPDATE=$(FHE_FIREHOSE_DESTINATION_ELASTICSEARCH_UPDATE)"
	@echo "    FHE_FIREHOSE_DESTINATION_REDSHIFT_CONFIG=$(FHE_FIREHOSE_DESTINATION_REDSHIFT_CONFIG)"
	@echo "    FHE_FIREHOSE_DESTINATION_REDSHIFT_UPDATE=$(FHE_FIREHOSE_DESTINATION_REDSHIFT_UPDATE)"
	@echo "    FHE_FIREHOSE_DESTINATION_S3_CONFIG=$(FHE_FIREHOSE_DESTINATION_S3_CONFIG)"
	@echo "    FHE_FIREHOSE_DESTINATION_S3_UPDATE=$(FHE_FIREHOSE_DESTINATION_S3_UPDATE)"
	@echo "    FHE_FIREHOSE_DESTINATION_SPLUNK_CONFIG=$(FHE_FIREHOSE_DESTINATION_SPLUNK_CONFIG)"
	@echo "    FHE_FIREHOSE_DESTINATION_SPLUNK_UPDATE=$(FHE_FIREHOSE_DESTINATION_SPLUNK_UPDATE)"
	@echo "    FHE_FIREHOSE_NAME=$(FHE_FIREHOSE_NAME)"
	@echo "    FHE_FIREHOSE_SOURCE_KINESIS_CONFIG=$(FHE_FIREHOSE_SOURCE_KINESIS_CONFIG)"
	@echo "    FHE_FIREHOSE_TYPE=$(FHE_FIREHOSE_TYPE)"
	@echo "    FHE_FIREHOSE_VERSION_ID=$(FHE_FIREHOSE_VERSION_ID)"
	@echo "    FHE_RECORD_FILEPATH=$(FHE_RECORD_FILEPATH)"
	@echo "    FHE_RECORD=$(FHE_RECORD)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_fhe_create_firehose:
	@$(INFO) "$(AWS_LABEL)Creating the delivery stream '$(FHE_FIREHOSE_NAME)' ..."; $(NORMAL)
	$(AWS) firehose create-delivery-stream $(__FHE_DELIVERY_STREAM_NAME) $(__FHE_DELIVERY_STREAM_TYPE) $(__FHE_ELASTICSEARCH_DESTINATION_CONFIGURATION) $(__FHE_EXTENDED_S3_DESTINATION_CONFIGURATION) $(__FHE_KINESIS_STREAM_SOURCE_CONFIGURATION) $(__FHE_REDSHIFT_DESTINATION_CONFIGURATION) $(__FHE_S3_DESTINATION_CONFIGURATION) $(__FHE_SPLUNK_DESTINATION_CONFIGURATION)

_fhe_delete_firehose:
	@$(INFO) "$(AWS_LABEL)Deleting the delivery stream '$(FHE_FIREHOSE_NAME)' ..."; $(NORMAL)
	$(AWS) firehose delete-delivery-stream $(__FHE_DELIVERY_STREAM_NAME)

_fhe_put_record:
	@$(INFO) "$(AWS_LABEL)Writing a single record into delivery stream '$(FHE_FIREHOSE_NAME)' ..."; $(NORMAL)
	$(AWS) firehose put-record $(__FHE_DELIVERY_STREAM_NAME) $(__FHE_RECORD)

_fhe_put_record_batch:
	@$(INFO) "$(AWS_LABEL)Writing a batch of records into delivery stream '$(FHE_FIREHOSE_NAME)' ..."; $(NORMAL)
	$(AWS) firehose put-record-batch $(__FHE_DELIVERY_STREAM_NAME) $(__FHE_RECORDS)

_fhe_show_firehose:
	@$(INFO) "$(AWS_LABEL)Showing details of the delivery stream '$(FHE_FIREHOSE_NAME)' ..."; $(NORMAL)
	$(AWS) firehose describe-delivery-stream $(__FHE_DELIVERY_STREAM_NAME) $(__FHE_EXCLUSIVE_START_DESTINATION_ID)

_fhe_update_firehose_destination:
	@$(INFO) "$(AWS_LABEL)Updating the destination of the delivery stream '$(FHE_FIREHOSE_NAME)' ..."; $(NORMAL)
	$(AWS) firehose update-destiation $(__FHE_CURRENT_DELIVERY_STREAM_VERSION_ID) $(__FHE_DELIVERY_STREAM_NAME) $(__FHE_DESTINATION_ID) $(__FHE_EXTENDED_S3_DESTINATION_UPDATE) $(__FHE_ELASTICSEARCH_DESTINATION_UPDATE) $(__FHE_REDSHIFT_DESTINATION_UPDATE) $(__FHE_S3_DESTINATION_UPDATE) $(__FHE_SPLUNK_DESTINATION_UPDATE)

_fhe_view_firehoses:
	@$(INFO) "$(AWS_LABEL)Viewing delivery stream ..."; $(NORMAL)
	$(AWS) firehose list-delivery-streams $(__FHE_DELIVERY_STREAM_TYPE) $(__FHE_EXCLUSIVE_START_DELIVERY_STREAM_NAME) $(__FHE_LIMIT)
