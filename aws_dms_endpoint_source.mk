_AWS_DMS_END{POINT_SOURCE_MK_VERSION=$(_AWS_DMS_ENDPOINT_MK_VERSION)

# DMS_SOURCE_ARN?= 
# DMS_SOURCE_DATABASE_NAME?= dms_sample
# DMS_SOURCE_ENGINE_NAME?= mongodb
# DMS_SOURCE_EXTRA_CONNECTION_ATTRIBUTES?=
# DMS_SOURCE_IDENTIFIER?= my_source
# DMS_SOURCE_KMS_KEY_ID?=
# DMS_SOURCE_MONGODB_SETTINGS=
# DMS_SOURCE_PORT?= 27017
# DMS_SOURCE_SERVER_NAME?= 18.188.2.83
DMS_SOURCE_SSL_MODE?= none
# DMS_SOURCE_TAGS?= Key=string,Value=string ...
DMS_SOURCE_TYPE?= source
# DMS_SOURCE_USER_NAME?= admin
# DMS_SOURCE_USER_PASSWORD?= my_password

# Derived variables

# Options variables

# UI variables

#--- Utilities

#--- MACROS
_dms_get_source_arn=$(call _dms_get_endpoint_arn_I, $(DMS_SOURCE_IDENTIFIER))
_dms_get_endpoint_identifier=$(call _dms_get_endpoint_identifier_A, $(DMS_SOURCE_ARN))

#----------------------------------------------------------------------
# USAGE
#

_dms_view_makefile_macros ::
	@echo "AWS::DMS::Endpoint::Source ($(_AWS_DMS_ENDPOINT_SOURCE_MK_VERSION)) macros:"
	@echo "    _dms_get_source_arn                    - Get the ARN of a source endpoint identifier"
	@echo "    _dms_get_source_identifier             - Get the identifier of a source endpoint arn"
	@echo

_dms_view_makefile_targets ::
	@echo "AWS::DMS::Endpoint::Source ($(_AWS_DMS_ENDPOINT_SOURCE_MK_VERSION)) targets:"
	@echo "    _dms_create_source                     - Create and configure a source endpoint"
	@echo "    _dms_delete_source                     - Delete a source endpoint"
	@echo "    _dms_refresh_source_schemas            - Refresh the schema of the source endpoint by instance"
	@echo "    _dms_show_source                       - Show details of a source endpoint"
	@echo "    _dms_show_source_connection            - Show details of a connection to a source endpoint"
	@echo "    _dms_show_source_schemas               - Show schemas of a source endpoint"
	@echo "    _dms_show_source_schemas_status        - Show status of schema for a source endpoint"
	@echo "    _dms_test_source_connection            - Test the endpoint configuration parameters"
	@echo 

_dms_view_makefile_variables ::
	@echo "AWS::DMS::Endpoint::Source ($(_AWS_DMS_ENDPOINT_SOURCE_MK_VERSION)) variables:"
	@echo "    DMS_SOURCE_ARN=$(DMS_SOURCE_ARN)"
	@echo "    DMS_SOURCE_DATABASE_NAME=$(DMS_SOURCE_DATABASE_NAME)"
	@echo "    DMS_SOURCE_ENGINE_NAME=$(DMS_SOURCE_ENGINE_NAME)"
	@echo "    DMS_SOURCE_EXTRA_CONNECTION_ATTRIBUTES=$(DMS_SOURCE_EXTRA_CONNECTION_ATTRIBUTES)"
	@echo "    DMS_SOURCE_IDENTIFIER=$(DMS_SOURCE_IDENTIFIER)"
	@echo "    DMS_SOURCE_KSM_KEY_ID=$(DMS_SOURCE_KMS_KEY_ID)"
	@echo "    DMS_SOURCE_MONGODB_SETTINGS=$(DMS_SOURCE_MONGODB_SETTINGS)"
	@echo "    DMS_SOURCE_PORT=$(DMS_SOURCE_PORT)"
	@echo "    DMS_SOURCE_SERVER_NAME=$(DMS_SOURCE_SERVER_NAME)"
	@echo "    DMS_SOURCE_SSL_MODE=$(DMS_SOURCE_SSL_MODE)"
	@echo "    DMS_SOURCE_TAGS=$(DMS_SOURCE_TAGS)"
	@echo "    DMS_SOURCE_TYPE=$(DMS_SOURCE_TYPE)"
	@echo "    DMS_SOURCE_USER_NAME=$(DMS_SOURCE_USER_NAME)"
	@echo "    DMS_SOURCE_USER_PASSWORD=$(DMS_SOURCE_USER_PASSWORD)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dms_create_source: DMS_ENDPOINT_DATABASE_NAME=$(DMS_SOURCE_DATABASE_NAME)#
_dms_create_source: DMS_ENDPOINT_ENGINE_NAME=$(DMS_SOURCE_ENGINE_NAME)#
_dms_create_source: DMS_ENDPOINT_EXTRA_CONNECTION_ATTRIBUTES=$(DMS_SOURCE_EXTRA_CONNECTION_ATTRIBUTES)#
_dms_create_source: DMS_ENDPOINT_IDENTIFIER=$(DMS_SOURCE_IDENTIFIER)#
_dms_create_source: DMS_ENDPOINT_KMS_KEY_ID=$(DMS_SOURCE_KMS_KEY_ID)#
_dms_create_source: DMS_ENDPOINT_MONGODB_SETTINGS=$(DMS_SOURCE_MONGODB_SETTINGS)#
_dms_create_source: DMS_ENDPOINT_PORT=$(DMS_SOURCE_PORT)#
_dms_create_source: DMS_ENDPOINT_SERVER_NAME=$(DMS_SOURCE_SERVER_NAME)#
_dms_create_source: DMS_ENDPOINT_SSL_MODE=$(DMS_SOURCE_SSL_MODE)#
_dms_create_source: DMS_ENDPOINT_TAGS=$(DMS_SOURCE_TAGS)#
_dms_create_source: DMS_ENDPOINT_TYPE=$(DMS_SOURCE_TYPE)#
_dms_create_source: DMS_ENDPOINT_USER_NAME=$(DMS_SOURCE_USER_NAME)#
_dms_create_source: DMS_ENDPOINT_USER_PASSWORD=$(DMS_SOURCE_USER_PASSWORD)#
_dms_create_source: _dms_create_endpoint

_dms_delete_source: DMS_ENDPOINT_ARN=$(DMS_SOURCE_ARN)#
_dms_delete_source: DMS_ENDPOINT_IDENTIFIER=$(DMS_SOURCE_IDENTIFIER)#
_dms_delete_source: _dms_delete_endpoint

_dms_refresh_source_schemas: DMS_ENDPOINT_ARN=$(DMS_SOURCE_ARN)#
_dms_refresh_source_schemas: _dms_refresh_endpoint_schemas

_dms_show_source: DMS_ENDPOINT_IDENTIFIER=$(DMS_SOURCE_IDENTIFIER)#
_dms_show_source: _dms_show_endpoint

_dms_show_source_connection: DMS_ENDPOINT_IDENTIFIER=$(DMS_SOURCE_IDENTIFIER)
_dms_show_source_connection: _dms_show_endpoint_connection

_dms_show_source_schemas: DMS_ENDPOINT_ARN=$(DMS_SOURCE_ARN)#
_dms_show_source_schemas: _dms_show_endpoint_schemas

_dms_show_source_schemas_status: DMS_ENDPOINT_ARN=$(DMS_SOURCE_ARN)#
_dms_show_source_schemas_status: _dms_show_endpoint_schemas_status

_dms_test_source_connection: DMS_ENDPOINT_ARN=$(DMS_SOURCE_ARN)#
_dms_test_source_connection: _dms_test_endpoint_connection
