_AWS_DMS_ENDPOINT_MK_VERSION=$(_AWS_DMS_MK_VERSION)

# DMS_ENDPOINT_ARN?= 
# DMS_ENDPOINT_DATABASE_NAME?= dms_sample
# DMS_ENDPOINT_DYNAMODB_SETTINGS?= ServiceAccessRoleArn=arn:aws:iam::123456789012:role/dmsTest/dms-access-for-dynamo-role
# DMS_ENDPOINT_ENGINE_NAME?= mongodb
# DMS_ENDPOINT_EXTRA_CONNECTION_ATTRIBUTES?=
# DMS_ENDPOINT_IDENTIFIER?= my_endpoint
# DMS_ENDPOINT_KMS_KEY_ID?=
# DMS_ENDPOINT_MONGODB_SETTINGS?= Username=string,Password=string,ServerName=string,Port=integer,DatabaseName=string,AuthType=string,AuthMechanism=string,NestingLevel=string,ExtractDocId=string,DocsToInvestigate=string,AuthSource=string
# DMS_ENDPOINT_PORT?= 27017
# DMS_ENDPOINT_S3_SETTINGS?= ServiceAccessRoleArn=string,ExternalTableDefinition=string,CsvRowDelimiter=string,CsvDelimiter=string,BucketFolder=string,BucketName=string,CompressionType=string
# DMS_ENDPOINT_SERVER_NAME?= 18.188.2.83
DMS_ENDPOINT_SSL_MODE?= none
# DMS_ENDPOINT_TAGS?= Key=string,Value=string ...
# DMS_ENDPOINT_TYPE?= source
# DMS_ENDPOINT_USER_NAME?= admin
# DMS_ENDPOINT_USER_PASSWORD?= my_password


# Derived variables

# Options
__DMS_DATABASE_NAME= $(if $(DMS_ENDPOINT_DATABASE_NAME), --database-name $(DMS_ENDPOINT_DATABASE_NAME))
__DMS_DYNAMO_DB_SETTINGS= $(if $(DMS_ENDPOINT_DYNAMODB_SETTINGS), --dynamo-db-settings $(DMS_ENDPOINT_DYNAMODB_SETTINGS))
__DMS_ENDPOINT_ARN= $(if $(DMS_ENDPOINT_ARN), --endpoint-arn $(DMS_ENDPOINT_ARN))
__DMS_ENDPOINT_IDENTIFIER= $(if $(DMS_ENDPOINT_IDENTIFIER), --endpoint-identifier $(DMS_ENDPOINT_IDENTIFIER))
__DMS_ENDPOINT_TYPE= $(if $(DMS_ENDPOINT_TYPE), --endpoint-type $(DMS_ENDPOINT_TYPE))
__DMS_ENGINE_NAME= $(if $(DMS_ENDPOINT_ENGINE_NAME), --engine-name $(DMS_ENDPOINT_ENGINE_NAME))
__DMS_EXTRA_CONNECTION_ATTRIBUTES= $(if $(DMS_ENDPOINT_EXTRA_CONNECTION_ATTRIBUTES), --extra-connection-attributes '$(DMS_ENDPOINT_EXTRA_CONNECTION_ATTRIBUTES)')
__DMS_KMS_KEY_ID= $(if $(DMS_ENDPOINT_KMS_KEY_ID), --kms-key-id $(DMS_ENDPOINT_KMS_KEY_ID))
__DMS_MONGO_DB_SETTINGS= $(if $(DMS_ENDPOINT_MONGODB_SETTINGS), --mongo-db-settings $(DMS_ENDPOINT_MONGODB_SETTINGS))
__DMS_PASSWORD= $(if $(DMS_ENDPOINT_USER_PASSWORD), --password $(DMS_ENDPOINT_USER_PASSWORD))
__DMS_PORT= $(if $(DMS_ENDPOINT_PORT), --port $(DMS_ENDPOINT_PORT))
__DMS_S3_SETTINGS= $(if $(DMS_ENDPOINT_S3_SETTINGS), --s3-settings $(DMS_ENDPOINT_S3_SETTINGS))
__DMS_SERVER_NAME= $(if $(DMS_ENDPOINT_SERVER_NAME), --server-name $(DMS_ENDPOINT_SERVER_NAME))
__DMS_SSL_MODE?= $(if $(DMS_ENDPOINT_SSL_MODE), --ssl-mode $(DMS_ENDPOINT_SSL_MODE))
__DMS_TAGS_ENDPOINT?= $(if $(DMS_ENDPOINT_TAGS), --tags $(DMS_ENDPOINT_TAGS))
__DMS_USERNAME= $(if $(DMS_ENDPOINT_USER_NAME), --username $(DMS_ENDPOINT_USER_NAME))

# UI variables
DMS_UI_VIEW_CONNECTIONS_FIELDS?= .{Status:Status,ReplicationInstanceIdentifier:ReplicationInstanceIdentifier,EndpointIdentifier:EndpointIdentifier}
DMS_UI_VIEW_ENDPOINTS_FIELDS?= .{_EndpointArn:EndpointArn, EndpointIdentifier:EndpointIdentifier, EndpointType:EndpointType, EngineName:EngineName, _Status:Status}

#--- Utilities

#--- MACROS
_dms_get_endpoint_arn=$(call _dms_get_endpoint_arn_I, $(DMS_ENDPOINT_IDENTIFIER))
_dms_get_endpoint_arn_I=$(shell $(AWS) dms describe-endpoints --query "Endpoints[?EndpointIdentifier=='$(strip $(1))'].EndpointArn" --output text)

_dms_get_endpoint_identifier=$(call _dms_get_endpoint_identifier_A, $(DMS_ENDPOINT_ARN))
_dms_get_endpoint_identifier_A=$(shell $(AWS) dms describe-endpoints --query "Endpoints[?EndpointArn=='$(strip $(1))'].EndpointIdentifier" --output text

#----------------------------------------------------------------------
# USAGE
#

_dms_view_makefile_macros ::
	@echo "AWS::DMS::Endpoint ($(_AWS_DMS_ENDPOINT_MK_VERSION)) macros:"
	@echo

_dms_view_makefile_targets ::
	@echo "AWS::DMS::Endpoint ($(_AWS_DMS_ENDPOINT_MK_VERSION)) targets:"
	@echo "    _dms_create_endpoint                   - Create and configure an endpoint"
	@echo "    _dms_delete_endpoint                   - Delete an endpoint"
	@echo "    _dms_refresh_endpoint_schemas          - Refresh the schema of the endpoint by instance"
	@echo "    _dms_show_endpoint                     - Show details of an endpoint"
	@echo "    _dms_show_endpoint_connection          - Show details of the connection"
	@echo "    _dms_show_endpoint_schemas_status      - Show status of schema for an endpoint"
	@echo "    _dms_show_endpoint_schemas             - Show schemas of an endpoint"
	@echo "    _dms_test_endpoint_connection          - Test connection between DMS instance and endpoint"
	@echo "    _dms_view_connections                  - View connections between endpoints and instances"
	@echo "    _dms_view_endpoints                    - View configured endpoints"
	@echo 

_dms_view_makefile_variables ::
	@echo "AWS::DMS::Endpoint ($(_AWS_DMS_ENDPOINT_MK_VERSION)) variables:"
	@echo "    DMS_ENDPOINT_ARN=$(DMS_ENDPOINT_ARN)"
	@echo "    DMS_ENDPOINT_DATABASE_NAME=$(DMS_ENDPOINT_DATABASE_NAME)"
	@echo "    DMS_ENDPOINT_ENGINE_NAME=$(DMS_ENDPOINT_ENGINE_NAME)"
	@echo "    DMS_ENDPOINT_EXTRA_CONNECTION_ATTRIBUTES=$(DMS_ENDPOINT_EXTRA_CONNECTION_ATTRIBUTES)"
	@echo "    DMS_ENDPOINT_IDENTIFIER=$(DMS_ENDPOINT_IDENTIFIER)"
	@echo "    DMS_ENDPOINT_KMS_KEY_ID=$(DMS_ENDPOINT_KMS_KEY_ID)"
	@echo "    DMS_ENDPOINT_PORT=$(DMS_ENDPOINT_PORT)"
	@echo "    DMS_ENDPOINT_SERVER_NAME=$(DMS_ENDPOINT_SERVER_NAME)"
	@echo "    DMS_ENDPOINT_SSL_MODE=$(DMS_ENDPOINT_SSL_MODE)"
	@echo "    DMS_ENDPOINT_TAGS=$(DMS_ENDPOINT_TAGS)"
	@echo "    DMS_ENDPOINT_TYPE=$(DMS_ENDPOINT_TYPE)"
	@echo "    DMS_ENDPOINT_USER_NAME=$(DMS_ENDPOINT_USER_NAME)"
	@echo "    DMS_ENDPOINT_USER_PASSWORD=$(DMS_ENDPOINT_USER_PASSWORD)"
	@echo "    DMS_ENDPOINT_DYNAMODB_SETTINGS=$(DMS_ENDPOINT_DYNAMODB_SETTINGS)"
	@echo "    DMS_ENDPOINT_MONGODB_SETTINGS=$(DMS_ENDPOINT_MONGODB_SETTINGS)"
	@echo "    DMS_ENDPOINT_S3_SETTINGS=$(DMS_ENDPOINT_S3_SETTINGS)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= ./mk.d
-include $(MK_DIR)/aws_dms_endpoint_source.mk
-include $(MK_DIR)/aws_dms_endpoint_target.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dms_create_endpoint:
	@$(INFO) "$(AWS_UI_LABEL)Creating DMS endpoint '$(DMS_ENDPOINT_IDENTIFIER)' ..."; $(NORMAL)
	$(AWS) dms create-endpoint $(__DMS_DATABASE_NAME) $(__DMS_DYNAMO_DB_SETTINGS) $(__DMS_ENDPOINT_IDENTIFIER) $(__DMS_KMS_KEY_ID) $(__DMS_ENDPOINT_TYPE) $(__DMS_ENGINE_NAME) $(__DMS_EXTRA_CONNECTION_ATTRIBUTES) $(__DMS_MONGO_DB_SETTINGS) $(__DMS_PASSWORD) $(__DMS_PORT) $(__DMS_S3_SETTINGS) $(__DMS_SERVER_NAME) $(__DMS_SSL_MODE) $(__DMS_TAGS_ENDPOINT) $(__DMS_USERNAME)
 
_dms_delete_endpoint:
	@$(INFO) "$(AWS_UI_LABEL)Deleting DMS endpoint '$(DMS_ENDPOINT_IDENTIFIER)' ..."; $(NORMAL)
	$(AWS) dms delete-endpoint $(__DMS_ENDPOINT_ARN)

_dms_refresh_endpoint_schemas:
	@$(INFO) "$(AWS_UI_LABEL)Refreshing schemas of an endpoint by a DMS replication instance ..."; $(NORMAL)
	$(AWS) dms refresh-schemas $(__DMS_ENDPOINT_ARN) $(__DMS_REPLICATION_INSTANCE_ARN)

_dms_show_endpoint:
	@$(INFO) "$(AWS_UI_LABEL)Showing DMS endpoint '$(DMS_ENDPOINT_IDENTIFIER)' ..."; $(NORMAL)
	$(AWS) dms describe-endpoints --query "Endpoints[?EndpointIdentifier=='$(DMS_ENDPOINT_IDENTIFIER)']"

_dms_show_endpoint_connection:
	@$(INFO) "$(AWS_UI_LABEL)Showing connection between instance '$(DMS_INSTANCE_IDENTIFIER)' and endpoint '$(DMS_ENDPOINT_IDENTIFIER)' ..."; $(NORMAL)
	$(AWS) dms describe-connections --query "Connections[?EndpointIdentifier=='$(DMS_ENDPOINT_IDENTIFIER)' && ReplicationInstanceIdentifier=='$(DMS_INSTANCE_IDENTIFIER)']"

_dms_show_endpoint_schemas:
	@$(INFO) "$(AWS_UI_LABEL)Showing schema of a DMS endpoint ..."; $(NORMAL)
	@$(WARN) "The schema must previously have been refreshed by DMS instance"; $(NORMAL)
	$(AWS) dms describe-schemas $(__DMS_ENDPOINT_ARN)

_dms_show_endpoint_schemas_status:
	@$(INFO) "$(AWS_UI_LABEL)Showing status of schema for a DMS endpoint ..."; $(NORMAL)
	$(AWS) dms describe-refresh-schemas-status $(__DMS_ENDPOINT_ARN)

_dms_test_endpoint_connection:
	@$(INFO) "$(AWS_UI_LABEL)Testing connection from instance to endpoint ..."; $(NORMAL)
	@$(WARN) "For test to be successful, make sure that VPC-peering, routing tables, security groups are set correctly!"; $(NORMAL)
	$(AWS) dms test-connection $(__DMS_ENDPOINT_ARN) $(__DMS_REPLICATION_INSTANCE_ARN)

_dms_view_connections:
	@$(INFO) "$(AWS_UI_LABEL)Viewing DMS connections between replication instances and endpoints ..."; $(NORMAL)
	@$(WARN) "For connections with 'failed' status, review configuration of VPC-peering, routing tables, and security groups!"; $(NORMAL)
	$(AWS) dms describe-connections --query "Connections[]$(DMS_UI_VIEW_CONNECTIONS_FIELDS)"

_dms_view_endpoints:
	@$(INFO) "$(AWS_UI_LABEL)Viewing DMS endpoints ..."; $(NORMAL)
	$(AWS) dms describe-endpoints --query "Endpoints[]$(DMS_UI_VIEW_ENDPOINTS_FIELDS)"
