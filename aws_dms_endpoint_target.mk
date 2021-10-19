_AWS_DMS_ENDPOINT_TARGET_MK_VERSION=$(_AWS_DMS_ENDPOINT_MK_VERSION)

# DMS_TARGET_ARN?= 
# DMS_TARGET_DATABASE_NAME?= dms_sample
# DMS_TARGET_DYNAMODB_SETTINGS?= ServiceAccessRoleArn=arn:aws:iam::123456789012:role/dmsTest/dms-access-for-dynamo-role
# DMS_TARGET_ENGINE_NAME?= dynamodb
# DMS_TARGET_EXTRA_CONNECTION_ATTRIBUTES?=
# DMS_TARGET_IDENTIFIER?= my_target
# DMS_TARGET_KMS_KEY_ID?=
# DMS_TARGET_PORT?= 27017
# DMS_TARGET_S3_SETTINGS?=
# DMS_TARGET_SERVER_NAME?= 18.188.2.83
DMS_TARGET_SSL_MODE?= none
# DMS_TARGET_TAGS?= Key=string,Value=string ...
DMS_TARGET_TYPE?= target
# DMS_TARGET_USER_NAME?= admin
# DMS_TARGET_USER_PASSWORD?= my_password

# Derived variables

# Options variables

# UI variables

#--- Utilities

#--- MACROS
_dms_get_target_arn=$(call _dms_get_endpoint_arn_I, $(DMS_TARGET_IDENTIFIER))
_dms_get_endpoint_identifier=$(call _dms_get_endpoint_identifier_A, $(DMS_TARGET_ARN))

#----------------------------------------------------------------------
# USAGE
#

_dms_view_makefile_macros ::
	@echo "AWS::DMS::Endpoint::Target ($(_AWS_DMS_ENDPOINT_TARGET_MK_VERSION)) macros:"
	@echo "    _dms_get_target_arn                    - Get the ARN of a target endpoint identifier"
	@echo "    _dms_get_target_identifier             - Get the identifier of a target endpoint arn"
	@echo

_dms_view_makefile_targets ::
	@echo "AWS::DMS::Endpoint::Target ($(_AWS_DMS_ENDPOINT_TARGET_MK_VERSION)) targets:"
	@echo "    _dms_create_target                     - Create and configure a target endpoint"
	@echo "    _dms_delete_target                     - Delete a target endpoint"
	@echo "    _dms_refresh_target_schemas            - Refresh the schema of the target endpoint by instance"
	@echo "    _dms_show_target                       - Show details of a target endpoint"
	@echo "    _dms_show_target_connection            - Show details of a connection to a target endpoint"
	@echo "    _dms_show_target_schemas               - Show schemas of a target endpoint"
	@echo "    _dms_show_target_schemas_status        - Show status of schema for a target endpoint"
	@echo "    _dms_test_target_connection            - Test the endpoint configuration parameters"
	@echo 

_dms_view_makefile_variables ::
	@echo "AWS::DMS::Endpoint::Target ($(_AWS_DMS_ENDPOINT_TARGET_MK_VERSION)) variables:"
	@echo "    DMS_TARGET_ARN=$(DMS_TARGET_ARN)"
	@echo "    DMS_TARGET_DATABASE_NAME=$(DMS_TARGET_DATABASE_NAME)"
	@echo "    DMS_TARGET_DYNAMODB_SETTINGS=$(DMS_TARGET_DYNAMODB_SETTINGS)"
	@echo "    DMS_TARGET_ENGINE_NAME=$(DMS_TARGET_ENGINE_NAME)"
	@echo "    DMS_TARGET_EXTRA_CONNECTION_ATTRIBUTES=$(DMS_TARGET_EXTRA_CONNECTION_ATTRIBUTES)"
	@echo "    DMS_TARGET_IDENTIFIER=$(DMS_TARGET_IDENTIFIER)"
	@echo "    DMS_TARGET_KMS_KEY_ID=$(DMS_TARGET_KMS_KEY_ID)"
	@echo "    DMS_TARGET_PORT=$(DMS_TARGET_PORT)"
	@echo "    DMS_TARGET_S3_SETTINGS=$(DMS_TARGET_S3_SETTINGS)"
	@echo "    DMS_TARGET_SERVER_NAME=$(DMS_TARGET_SERVER_NAME)"
	@echo "    DMS_TARGET_SSL_MODE=$(DMS_TARGET_SSL_MODE)"
	@echo "    DMS_TARGET_TAGS=$(DMS_TARGET_TAGS)"
	@echo "    DMS_TARGET_TYPE=$(DMS_TARGET_TYPE)"
	@echo "    DMS_TARGET_USER_NAME=$(DMS_TARGET_USER_NAME)"
	@echo "    DMS_TARGET_USER_PASSWORD=$(DMS_TARGET_USER_PASSWORD)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dms_create_target: DMS_ENDPOINT_DATABASE_NAME=$(DMS_TARGET_DATABASE_NAME)#
_dms_create_target: DMS_ENDPOINT_DYNAMODB_SETTINGS=$(DMS_TARGET_DYNAMODB_SETTINGS)#
_dms_create_target: DMS_ENDPOINT_ENGINE_NAME=$(DMS_TARGET_ENGINE_NAME)#
_dms_create_target: DMS_ENDPOINT_EXTRA_CONNECTION_ATTRIBUTES=$(DMS_TARGET_EXTRA_CONNECTION_ATTRIBUTES)#
_dms_create_target: DMS_ENDPOINT_IDENTIFIER=$(DMS_TARGET_IDENTIFIER)#
_dms_create_target: DMS_ENDPOINT_KMS_KEY_ID=$(DMS_TARGET_KMS_KEY_ID)#
_dms_create_target: DMS_ENDPOINT_PORT=$(DMS_TARGET_PORT)#
_dms_create_target: DMS_ENDPOINT_SERVER_NAME=$(DMS_TARGET_SERVER_NAME)#
_dms_create_target: DMS_ENDPOINT_S3_SETTINGS=$(DMS_TARGET_S3_SETTINGS)#
_dms_create_target: DMS_ENDPOINT_SSL_MODE=$(DMS_TARGET_SSL_MODE)#
_dms_create_target: DMS_ENDPOINT_TAGS=$(DMS_TARGET_TAGS)#
_dms_create_target: DMS_ENDPOINT_TYPE=$(DMS_TARGET_TYPE)#
_dms_create_target: DMS_ENDPOINT_USER_NAME=$(DMS_TARGET_USER_NAME)#
_dms_create_target: DMS_ENDPOINT_USER_PASSWORD=$(DMS_TARGET_USER_PASSWORD)#
_dms_create_target: _dms_create_endpoint

_dms_delete_target: DMS_ENDPOINT_ARN=$(DMS_TARGET_ARN)#
_dms_delete_target: DMS_ENDPOINT_IDENTIFIER=$(DMS_TARGET_IDENTIFIER)#
_dms_delete_target: _dms_delete_endpoint

_dms_refresh_target_schemas: DMS_ENDPOINT_ARN=$(DMS_TARGET_ARN)#
_dms_refresh_target_schemas: _dms_refresh_endpoint_schemas

_dms_show_target: DMS_ENDPOINT_IDENTIFIER=$(DMS_TARGET_IDENTIFIER)#
_dms_show_target: _dms_show_endpoint

_dms_show_target_connection: DMS_ENDPOINT_IDENTIFIER=$(DMS_TARGET_IDENTIFIER)
_dms_show_target_connection: _dms_show_endpoint_connection

_dms_show_target_schemas: DMS_ENDPOINT_ARN=$(DMS_TARGET_ARN)#
_dms_show_target_schemas: _dms_show_endpoint_schemas

_dms_show_target_schemas_status: DMS_ENDPOINT_ARN=$(DMS_TARGET_ARN)#
_dms_show_target_schemas_status: _dms_show_endpoint_schemas_status

_dms_test_target_connection: DMS_ENDPOINT_ARN=$(DMS_TARGET_ARN)#
_dms_test_target_connection: _dms_test_endpoint_connection
