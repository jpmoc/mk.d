_AWS_APPSYNC_DATASOURCE_MK_VERSION= $(_AWS_APPSYNC_MK_VERSION)

# ASC_DATASOURCE_DESCRIPTION?= "This is my data-source"
# ASC_DATASOURCE_DYNAMODB_CONFIG?= tableName=string,awsRegion=string,useCallerCredentials=boolean
# ASC_DATASOURCE_ELASTICSEARCH_CONFIG?= endpoint=string,awsRegion=string
# ASC_DATASOURCE_GRAPHQLAPI_ID?= 6hd24t42afh4ngzfuwjw2bhkfy
# ASC_DATASOURCE_LAMBDA_CONFIG?= lambdaFunctionArn=string
# ASC_DATASOURCE_NAME?= my-data-source
# ASC_DATASOURCE_SERVICEROLE_ARN?=
# ASC_DATASOURCE_TYPE?= AMAZON_DYNAMODB

# Derived parameters
ASC_DATASOURCE_GRAPHQLAPI_ID= $(ASC_GRAPHQLAPI_ID)

# Option parameters
__ASC_API_ID__DATASOURCE= $(if $(ASC_DATASOURCE_GRAPHQLAPI_ID), --api-id $(ASC_DATASOURCE_GRAPHQLAPI_ID))
__ASC_DESRIPTION__DATASOURCE= $(if $(ASC_DATASOURCE_DESCRIPTION), --description $(ASC_DATASOURCE_DESCRIPTION))
__ASC_DYNAMODB_CONFIG= $(if $(ASC_DATASOURCE_DYNAMODB_CONFIG), --dynamodb-config $(ASC_DATASOURCE_DYNAMODB_CONFIG))
__ASC_ELASTICSEARCH_CONFIG= $(if $(ASC_DATASOURCE_ELASTICSEARCH_CONFIG), --elasticsearch-config $(ASC_DATASOURCE_ELASTICSEARCH_CONFIG))
__ASC_LAMBDA_CONFIG= $(if $(ASC_DATASOURCE_LAMBDA_CONFIG), --lambda-config $(ASC_DATASOURCE_LAMBDA_CONFIG))
__ASC_NAME__DATASOURCE= $(if $(ASC_DATASOURCE_NAME), --name $(ASC_DATASOURCE_NAME))
__ASC_SERVICE_ROLE_ARN= $(if $(ASC_DATASOURCE_SERVICEROLE_ARN), --service-role-arn $(ASC_DATASOURCE_SERVICEROLE_ARN))
__ASC_TYPE__DATASOURCE= $(if $(ASC_DATASOURCE_TYPE), --type $(ASC_DATASOURCE_TYPE))

# UI parameters
ASC_UI_VIEW_DATASOURCES_FIELDS?=
ASC_UI_VIEW_DATASOURCES_SET_FIELDS?= $(ASC_UI_VIEW_DATASOURCES_FIELDS)
ASC_UI_VIEW_DATASOURCES_SET_SLICE?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_asc_view_framework_macros ::
	@echo 'AWS::AppSynC::DataSource ($(_AWS_APPSYNC_DATASOURCE_MK_VERSION)) macros:'
	@echo

_asc_view_framework_parameters ::
	@echo 'AWS::AppSynC::DataSource ($(_AWS_APPSYNC_DATASOURCE_MK_VERSION)) parameters:'
	@echo '    ASC_DATASOURCE_DESCRIPTION=$(ASC_DATASOURCE_DESCRIPTION)'
	@echo '    ASC_DATASOURCE_DYNAMODB_CONFIG=$(ASC_DATASOURCE_DYNAMODB_CONFIG)'
	@echo '    ASC_DATASOURCE_ELASTICSEARCH_CONFIG=$(ASC_DATASOURCE_ELASTICSEARCH_CONFIG)'
	@echo '    ASC_DATASOURCE_GRAPHQLAPI_ID=$(ASC_DATASOURCE_GRAPHQLAPI_ID)'
	@echo '    ASC_DATASOURCE_LAMBDA_CONFIG=$(ASC_DATASOURCE_LAMBDA_CONFIG)'
	@echo '    ASC_DATASOURCE_NAME=$(ASC_DATASOURCE_NAME)'
	@echo '    ASC_DATASOURCE_SERVICEROLE_ARN=$(ASC_DATASOURCE_SERVICEROLE_ARN)'
	@echo '    ASC_DATASOURCE_TYPE=$(ASC_DATASOURCE_TYPE)'
	@echo '    ASC_DATASOURCES_SET_NAME=$(ASC_DATASOURCES_SET_NAME)'
	@echo

_asc_view_framework_targets ::
	@echo 'AWS::AppSynC::DataSource ($(_AWS_APPSYNC_DATASOURCE_MK_VERSION)) targets:'
	@echo '    _asc_create_datasource                 - Create a new data-source'
	@echo '    _asc_delete_datasource                 - Delete an existing data-source'
	@echo '    _asc_show_datasource                   - Show everything related to an data-source'
	@echo '    _asc_update_datasource                 - Update an data-source'
	@echo '    _asc_view_datasources                  - View existing data-sources'
	@echo '    _asc_view_datasources_set              - View a set of data-sources'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGET
#
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_asc_create_datasource:
	@$(INFO) '$(AWS_UI_LABEL)Creating data-source "$(ASC_DATASOURCE_NAME)" ...'; $(NORMAL)
	$(AWS) appsync create-data-source $(__ASC_API_ID__DATASOURCE) $(__ASC_DESCRIPTION__DATASOURCE) $(__ASC_DYNAMODB_CONFIG) $(__ASC_ELASTICSEARCH_CONFIG) $(__ASC_LAMBDA_CONFIG) $(__ASC_NAME__DATASOURCE) $(__ASC_SERVICE_ROLE_ARN) $(__ASC_TYPE__DATASOURCE)

_asc_delete_datasource:
	@$(INFO) '$(AWS_UI_LABEL)Deleting data-source "$(ASC_DATASOURCE_NAME)" ...'; $(NORMAL)
	$(AWS) appsync delete-data-source $(__ASC_API_ID__DATASOURCE) $(__ASC_NAME__DATASOURCE)

_asc_show_datasource:
	@$(INFO) '$(AWS_UI_LABEL)Showing data-source "$(ASC_DATASOURCE_NAME)" ...'; $(NORMAL)
	$(AWS) appsync get-data-source $(__ASC_API_ID__DATASOURCE) $(__ASC_NAME__DATASOURCE) #--query "graphqlApi"

_asc_update_datasource:
	@$(INFO) '$(AWS_UI_LABEL)Updating data-source "$(ASC_DATASOURCE_NAME)" ...'; $(NORMAL)
	$(AWS) appsync update-data-source $(__ASC_API_ID__DATASOURCE) $(__ASC_DESCRIPTION__DATASOURCE) $(__ASC_DYNAMODB_CONFIG) $(__ASC_ELASTICSEARCH_CONFIG) $(__ASC_LAMBDA_CONFIG) $(__ASC_NAME__DATASOURCE) $(__ASC_SERVICE_ROLE_ARN) $(__ASC_TYPE__DATASOURCE)

_asc_view_datasources:
	@$(INFO) '$(AWS_UI_LABEL)Viewing data-sources ...'; $(NORMAL)
	$(AWS) appsync list-data-sources $(__ASC_API_ID__DATASOURCE) # --query "graphqlApis[]$(ASC_UI_VIEW_DATASOURCES_FIELDS)"

_asc_view_datasources_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing data-sources-set "$(ASC_DATASOURCES_SET_NAME)" ...'; $(NORMAL)
	$(AWS) appsync list-data-sources $(__ASC_API_ID__DATASOURCE) # --query "graphqlApis[$(ASC_UI_VIEW_DATASOURCES_SET_SLICE)]$(ASC_UI_VIEW_DATASOURCES_SET_FIELDS)"
