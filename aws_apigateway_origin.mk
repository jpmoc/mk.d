_AWS_API_GATEWAY_MK_VERSION=0.99.0

# AGW_CLIENT_CERTIFICATE_ID=
# AGW_CUSTOMER_ID=
# AGW_DEPLOYMENT_ID?=
# AGW_DOCUMENTATION_PART_ID?=
# AGW_DOMAIN_NAME=
# AGW_GATEWAY_NAME?=WildRydes
# AGW_GATEWAY_ID?=76gorv5cz6
# AGW_HTTP_METHOD?=76gorv5cz6
# AGW_RESOURCE_ID?=
# AGW_RESOURCE_PATH?= /unicorns
# AGW_RESPONSE_TYPE?=
# AGW_SDK_TYPE_ID?= java
# AGW_STAGE_DESCRIPTION?=
# AGW_STAGE_NAME?= Prod
# AGW_STATUS_CODE?= 200

# Derived varaibles

# Options
__AGW_CACHE_CLUSTER_ENABLED=
__AGW_CACHE_CLUSTER_SIZE=
__AGW_CANARY_SETTINGS=
__AGW_CLIENT_CERTIFICATE_ID= $(if $(AGW_CLIENT_CERTIFICATE_ID), --client-certificate-id $(AGW_CLIENT_CERTIFICATE_ID))
__AGW_CUSTOMER_ID=
__AGW_DEPLOYMENT_ID= $(if $(AGW_DEPLOYMENT_ID), --deployment-id $(AGW_DEPLOYMENT_ID))
__AGW_DESCRIPTION= $(if $(AGW_STAGE_DESCRIPTION), --description $(AGW_STAGE_DESCRIPTION))
__AGW_DOCUMENTATION_PART_ID= $(if $(AGW_DOCUMENTATION_PART_ID), -documentation-part-id $(AGW_DOCUMENTATION_PART_ID))
__AGW_DOCUMENTATION_VERSION=
__AGW_DOMAIN_NAME= $(if $(AGW_DOMAIN_NAME), --domain-name $(AGW_DOMAIN_NAME))
__AGW_EMBED=
__AGW_ENABLED=
__AGW_HTTP_METHOD= $(if $(AGW_HTTP_METHOD), --http-method $(AGW_HTTP_METHOD))
__AGW_ID= $(if $(AGW_SDK_TYPE_ID), --id $(AGW_SDK_TYPE_ID))
__AGW_INCLUDE_VALUES=
__AGW_NAME_QUERY=
__AGW_RESOURCE_ID= $(if $(AGW_RESOURCE_ID), --resource-id $(AGW_RESOURCE_ID))
__AGW_RESPONSE_TYPE= $(if $(AGW_RESPONSE_TYPE), --response-type $(AGW_RESPONSE_TYPE))
__AGW_REST_API_ID= $(if $(AGW_GATEWAY_ID), --rest-api-id $(AGW_GATEWAY_ID))
__AGW_STAGE_NAME= $(if $(AGW_STAGE_NAME), --stage-name $(AGW_STAGE_NAME))
__AGW_STATUS_CODE= $(if $(AGW_STATUS_CODE), --status-code $(AGW_STATUS_CODE))
__AGW_TAGS=

# Display
AGW_VIEW_API_GATEWAYS_FIELDS?=.{_name:name,apiKeySource:apiKeySource,version:version,createdDate:createdDate,_id:id}

#--- MACROS
_agw_get_deployment_id=$(call _agw_get_deployment_id_I, 0)
_agw_get_deployment_id_I=$(call _agw_get_deployment_id_AI, $(AGW_GATEWAY_ID), $(1))
_agw_get_deployment_id_AI=$(shell $(AWS) apigateway get-deployments --rest-api-id $(1) --query "items[$(2)].id" --output text)

#----------------------------------------------------------------------
# USAGE
#
_aws_view_makefile_macros :: _agw_user_view_makefile_macros
_agw_view_makefile_macros ::
	@echo "AWS::ApiGateWay ($(_AWS_API_GATEWAY_MK_VERSION)) targets:"
	@echo "    _agw_get_deployment_id_{|I|AI}     - Get a deployment ID (API gateway ID, Index)"
	@echo

_aws_view_makefile_targets :: _agw_view_makefile_targets
_agw_view_makefile_targets ::
	@echo "AWS::ApiGateWay ($(_AWS_API_GATEWAY_MK_VERSION)) targets:"
	@echo "    _agw_create_stage                  - Create a stage for a given gateway"
	@echo "    _agw_show_authorizer               - Show details for a authorizer on a gateways"
	@echo "    _agw_show_client_certificate       - Show details for a client certificate"
	@echo "    _agw_show_deployment               - Show details for a deployment on a gateways"
	@echo "    _agw_show_domain                   - Show details for a domain"
	@echo "    _agw_show_gateway                  - Show details of a gateway"
	@echo "    _agw_show_gateway_reponse          - Show details of a gateway response"
	@echo "    _agw_show_integration              - Show details of an integration "
	@echo "    _agw_show_integration_response     - Show details of an integration reponse"
	@echo "    _agw_show_method                   - Show details of a method"
	@echo "    _agw_show_method_reponse           - Show details of a method reponse"
	@echo "    _agw_show_sdk_type                 - Show details of a SDK type"
	@echo "    _agw_show_stage                    - Show details of a stage on a gateways"
	@echo "    _agw_view_account_limits           - View account limits on this service"
	@echo "    _agw_view_authorizers              - View all authorizers of a gateway"
	@echo "    _agw_view_client_certificates      - View all client certificates"
	@echo "    _agw_view_deployments              - View all deployments on a gateway"
	@echo "    _agw_view_documentation_parts      - View all documentation parts for a gateway"
	@echo "    _agw_view_domains                  - View all domain names"
	@echo "    _agw_view_gateway_responses        - View error messages when query is not htting a resouce"
	@echo "    _agw_view_gateways                 - View all the existing gateways"
	@echo "    _agw_view_resources                - View all the resources of an existing gateway"
	@echo "    _agw_view_sdk_types                - View all supported SDK types"
	@echo "    _agw_view_stages                   - View all the stages of an existing gateway"
	@echo

_aws_view_makefile_variables :: _agw_view_makefile_variables
_agw_view_makefile_variables ::
	@echo "AWS::ApiGateWay ($(_AWS_API_GATEWAY_MK_VERSION)) variables:"
	@echo "    AGW_CLIENT_CERTIFICATE_ID=$(AGW_CLIENT_CERTIFICATE_ID)"
	@echo "    AGW_CUSTOMER_ID=$(AGW_CUSTOMER_ID)"
	@echo "    AGW_DEPLOYMENT_ID=$(AGW_DEPLOYMENT_ID)"
	@echo "    AGW_DOCUMENTATION_PART_ID=$(AGW_DOCUMENTATION_PART_ID)"
	@echo "    AGW_DOMAIN_NAME=$(AGW_DOMAIN_NAME)"
	@echo "    AGW_GATEWAY_NAME=$(AGW_GATEWAY_NAME)"
	@echo "    AGW_RESOURCE_ID=$(AGW_RESOURCE_ID)"
	@echo "    AGW_RESOURCE_PATH=$(AGW_RESOURCE_PATH)"
	@echo "    AGW_RESPONSE_TYPE=$(AGW_RESPONSE_TYPE)"
	@echo "    AGW_SDK_TYPE_ID=$(AGW_SDK_TYPE_ID)"
	@echo "    AGW_STAGE_DESCRIPTION=$(AGW_STAGE_DESCRIPTION)"
	@echo "    AGW_STAGE_NAME=$(AGW_STAGE_NAME)"
	@echo "    AGW_STATUS_CODE=$(AGW_STATUS_CODE)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agw_show_sdk_type:
	@$(INFO) "$(AWS_LABEL)Show SDK type '$(AGW_SDK_TYPE_ID)' ..."; $(NORMAL)
	$(AWS) apigateway get-sdk-type $(__AGW_ID)

_agw_show_integration:
	@$(INFO) "$(AWS_LABEL)Show details on integration for path '$(AGW_RESOURCE_PATH)' on API gateways '$(AGW_GATEWAY_NAME)' ..."; $(NORMAL)
	@$(WARN) "Path '$(AGW_RESOURCE_PATH)' ----> Id '$(AGW_RESOURCE_ID))'"; $(NORMAL)
	$(AWS) apigateway get-integration $(__AGW_HTTP_METHOD) $(__AGW_RESOURCE_ID) $(__AGW_REST_API_ID)

_agw_show_integration_response:
	@$(INFO) "$(AWS_LABEL)Show details on integration response for path '$(AGW_RESOURCE_PATH)' on API gateways '$(AGW_GATEWAY_NAME)' ..."; $(NORMAL)
	$(AWS) apigateway get-integration-response $(__AGW_HTTP_METHOD) $(__AGW_RESOURCE_ID) $(__AGW_REST_API_ID) $(__AGW_STATUS_CODE)

_agw_show_method:
	@$(INFO) "$(AWS_LABEL)Show details for method '$(AGW_HTP_METHOD)' on path '$(AGW_RESOURCE_PATH)' on API gateways '$(AGW_GATEWAY_NAME)' ..."; $(NORMAL)
	$(AWS) apigateway get-method $(__AGW_HTTP_METHOD) $(__AGW_RESOURCE_ID) $(__AGW_REST_API_ID)

_agw_show_method_response:
	@$(INFO) "$(AWS_LABEL)Show details for method reponse '$(AGW_HTP_METHOD)' on path '$(AGW_RESOURCE_PATH)' on API gateways '$(AGW_GATEWAY_NAME)' ..."; $(NORMAL)
	$(AWS) apigateway get-method-response $(__AGW_HTTP_METHOD) $(__AGW_RESOURCE_ID) $(__AGW_REST_API_ID) $(__AGW_STATUS_CODE)

_agw_view_sdk_types:
	@$(INFO) "$(AWS_LABEL)Viewing supported SDK types ..."; $(NORMAL)
	$(AWS) apigateway get-sdk-types
