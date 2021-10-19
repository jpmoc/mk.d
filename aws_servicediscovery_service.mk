_AWS_SERVICEDISCOVERY_SERVICE_MK_VERSION= $(_AWS_SERVICEDISCOVERY_MK_VERSION)

# SDY_SERVICE_DESCRIPTION?= "This is my service"
# SDY_SERVICE_DNS_CONFIG?= NamespaceId=string,RoutingPolicy=string,DnsRecords=[{Type=string,TTL=long},{Type=string,TTL=long}]
# SDY_SERVICE_HEALTHCHECK_CONFIG?= Type=string,ResourcePath=string,FailureThreshold=integer
# SDY_SERVICE_HEALTHCHECK_CUSTOMCONFIG?= FailureThreshold=integer
# SDY_SERVICE_ID?= srv-n5x4ox54zasud6oh
# SDY_SERVICE_NAME?= my-service
# SDY_SERVICE_NAMESPACE_ID?= ns-cxw72pb7q4vw3h7h
# SDY_SERVICE_NAMESPACE_NAME?= my-namespace
SDY_SERVICE_QUERY_HEALTHSTATUS?= ALL
SDY_SERVICE_QUERY_MAXCOUNT?= 100
# SDY_SERVICE_QUERY_PARAMETERS?= KeyName1=string,KeyName2=string
# SDY_SERVICE_REQUEST_ID?= 20191112_170011
# SDY_SERVICES_FILTERS?=
# SDY_SERVICES_SET_NAME?=

# Derived parameters
SDY_SERVICE_NAMESPACE_ID?= $(SDY_NAMESPACE_ID)
SDY_SERVICE_NAMESPACE_NAME?= $(SDY_NAMESPACE_NAME)

# Option parameters
__SDY_CREATOR_REQUEST_ID__SERVICE= $(if $(SDY_SERVICE_REQUEST_ID),--creator-request-id $(SDY_SERVICE_REQUEST_ID))
__SDY_DESCRIPTION__SERVICE= $(if $(SDY_SERVICE_DESCRIPTION),--description $(SDY_SERVICE_DESCRIPTION))
__SDY_DNS_CONFIG= $(if $(SDY_SERVICE_DNS_CONFIG),--dns-config $(SDY_SERVICE_DNS_CONFIG))
__SDY_FILTERS__SERVICES= $(if $(SDY_SERVICES_FILTERS),--filters $(SDY_SERVICES_FILTERS))
__SDY_HEALTH_CHECK_CONFIG= $(if $(SDY_SERVICE_HEALTHCHECK_CONFIG),--health-check-config $(SDY_SERVICE_HEALTHCHECK_CONFIG))
__SDY_HEALTH_CHECK_CUSTOM_CONFIG= $(if $(SDY_SERVICE_HEALTHCHECK_CUSTOMCONFIG),--health-check-custom-config $(SDY_SERVICE_HEALTHCHECK_CUSTOMCONFIG))
__SDY_HEALTH_STATUS= $(if $(SDY_SERVICE_QUERY_HEALTHSTATUS),--health-status $(SDY_SERVICE_QUERY_HEALTHSTATUS))
__SDY_ID__SERVICE= $(if $(SDY_SERVICE_ID),--id $(SDY_SERVICE_ID))
__SDY_MAX_RESULTS= $(if $(SDY_SERVICE_QUERY_MAXCOUNT),--max-results $(SDY_SERVICE_QUERY_MAXCOUNT))
__SDY_NAME__SERVICE= $(if $(SDY_SERVICE_NAME),--name $(SDY_SERVICE_NAME))
__SDY_NAMESPACE_ID__SERVICE= $(if $(SDY_SERVICE_NAMESPACE_ID),--namespace-id $(SDY_SERVICE_NAMESPACE_ID))
__SDY_NAMESPACE_NAME__SERVICE= $(if $(SDY_SERVICE_NAMESPACE_NAME),--namespace-name $(SDY_SERVICE_NAMESPACE_NAME))
__SDY_QUERY_PARAMETERS= $(if $(SDY_SERVICE_QUERY_PARAMETERS),--query-parameters $(SDY_SERVICE_QUERY_PARAMETERS))
__SDY_SERVICE=
__SDY_SERVICE_ID__SERVICE= $(if $(SDY_SERVICE_ID),--service-id $(SDY_SERVICE_ID))
__SDY_SERVICE_NAME__SERVICE= $(if $(SDY_SERVICE_NAME),--service-name $(SDY_SERVICE_NAME))

# UI parameters
SDY_UI_QUERY_SERVICE_FIELDS?= .{InstanceId:InstanceId,HealthStatus:HealthStatus,Keys:join(' ',keys(Attributes)),Values:join(' ',values(Attributes))}
SDY_UI_SHOW_SERVICE_FIELDS?=
SDY_UI_SHOW_SERVICE_INSTANCES_FIELDS?= .{Id:Id,Keys:join(' ',keys(Attributes)),Values:join(' ',values(Attributes))}
SDY_UI_VIEW_SERVICES_FIELDS?=
SDY_UI_VIEW_SERVICES_SET_FIELDS?= $(SDY_UI_VIEW_SERVICES_FIELDS)
SDY_UI_VIEW_SERVICES_SET_QUERYFILTER?=

#--- MACROS

_sdy_get_service_arn= $(call _sdy_get_service_arn_I, $(SDY_SERVICE_ID))
_sdy_get_service_arn_I= $(shell echo "arn:aws:servicediscovery:$(AWSS_REGION):$(AWS_ACCOUNT_ID):service/$(strip $(1))")

_sdy_get_service_id= $(call  _sdy_get_service_id_N, $(SDY_SERVICE_NAME))
_sdy_get_service_id_N= $(shell $(AWS) servicediscovery list-services --query "Services[?Name=='$(strip $(1))'].Id" --output text )

#--- Utilities

#----------------------------------------------------------------------
# USAGE
#

_sdy_view_framework_macros ::
	@echo 'AWS::ServiceDiscoverY::Service ($(_AWS_SERVICEDISCOVERY_SERVICE_MK_VERSION)) macros:'
	@echo '    _sdy_get_service_arn_{|I}            - Get the ARN of a service (Id)'
	@echo '    _sdy_get_service_id_{|N}             - Get the ID of a service (Name)'
	@echo

_sdy_view_framework_parameters ::
	@echo 'AWS::ServiceDiscoverY::Service ($(_AWS_SERVICEDISCOVERY_SERVICE_MK_VERSION)) parameters:'
	@echo '    SDY_SERVICE_DESCRIPTION=$(SDY_SERVICE_DESCRIPTION)'
	@echo '    SDY_SERVICE_DNS_CONFIG=$(SDY_SERVICE_DNS_CONFIG)'
	@echo '    SDY_SERVICE_HEALTHCHECK_CONFIG=$(SDY_SERVICE_HEALTHCHECK_CONFIG)'
	@echo '    SDY_SERVICE_HEALTHCHECK_CUSTOMCONFIG=$(SDY_SERVICE_HEALTHCHECK_CUSTOMCONFIG)'
	@echo '    SDY_SERVICE_ID=$(SDY_SERVICE_ID)'
	@echo '    SDY_SERVICE_NAME=$(SDY_SERVICE_NAME)'
	@echo '    SDY_SERVICE_NAMESPACE_ID=$(SDY_SERVICE_NAMESPACE_ID)'
	@echo '    SDY_SERVICE_NAMESPACE_NAME=$(SDY_SERVICE_NAMESPACE_NAME)'
	@echo '    SDY_SERVICE_QUERY_HEALTHSTATUS=$(SDY_SERVICE_QUERY_HEALTHSTATUS)'
	@echo '    SDY_SERVICE_QUERY_MAXCOUNT=$(SDY_SERVICE_QUERY_MAXCOUNT)'
	@echo '    SDY_SERVICE_QUERY_PARAMETERS=$(SDY_SERVICE_QUERY_PARAMETERS)'
	@echo '    SDY_SERVICE_REQUEST_ID=$(SDY_SERVICE_REQUEST_ID)'
	@echo '    SDY_SERVICES_FILTERS=$(SDY_SERVICES_FILTERS)'
	@echo '    SDY_SERVICES_SET_NAME=$(SDY_SERVICES_SET_NAME)'
	@echo

_sdy_view_framework_targets ::
	@echo 'AWS::ServiceDiscoverY::Service ($(_AWS_SERVICEDISCOVERY_SERVICE_MK_VERSION)) targets:'
	@echo '    _sdy_create_service                  - Create a new service'
	@echo '    _sdy_delete_service                  - Delete an existing service'
	@echo '    _sdy_show_service                    - Show everything related to a service'
	@echo '    _sdy_show_service_description        - Show description of a service'
	@echo '    _sdy_show_service_instances          - Show instances of a service'
	@echo '    _sdy_show_service_operations         - Show operations of a service'
	@echo '    _sdy_show_query_service              - Query a service'
	@echo '    _sdy_update_service                  - Update an existing service'
	@echo '    _sdy_view_services                   - View services'
	@echo '    _sdy_view_services_set               - View a set of services'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sdy_create_service:
	@$(INFO) '$(AWS_UI_LABEL)Creating a new service "$(SDY_SERVICE_NAME)" ...'; $(NORMAL)
	$(AWS) servicediscovery create-service $(strip $(__SDY_CREATOR_REQUEST_ID__SERVICE) $(__SDY_DESCRIPTION__SERVICE) $(__SDY_DNS_CONFIG) $(__SDY_HEALTH_CHECK_CONFIG) $(__SDY_HEALTH_CHECK_CUSTOM_CONFIG) $(__SDY_NAME__SERVICE) $(__SDY_NAMESPACE_ID__SERVICE) )

_sdy_delete_service:
	@$(INFO) '$(AWS_UI_LABEL)Deleting service "$(SDY_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is asynchronous, not instantaneous'; $(NORMAL)
	$(AWS) servicediscovery delete-service $(__SDY_ID__SERVICE)

_sdy_query_service:
	@$(INFO) '$(AWS_UI_LABEL)Querying service "$(SDY_SERVICE_NAME)"...'; $(NORMAL)
	$(AWS) servicediscovery discover-instances $(__SDY_HEALTH_STATUS) $(__SDY_NAMESPACE_NAME__SERVICE) $(__SDY_QUERY_PARAMETERS) $(__SDY_SERVICE_NAME__SERVICE) --query "Instances[]$(SDY_UI_QUERY_SERVICE_FIELDS)"

_sdy_show_service: _sdy_show_service_healthstatus _sdy_show_service_instances _sdy_show_service_operations _sdy_show_service_description

_sdy_show_service_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of service "$(SDY_SERVICE_NAME)"...'; $(NORMAL)
	@$(WARN) 'This operation fails if service ID is NOT set'; $(NORMAL)
	-$(AWS) servicediscovery get-service $(__SDY_ID__SERVICE) --query "@.Service$(SDY_UI_SHOW_SERVICE_FIELDS)"

_sdy_show_service_healthstatus:
	@$(INFO) '$(AWS_UI_LABEL)Showing health-status of service "$(SDY_SERVICE_NAME)"...'; $(NORMAL)
	@$(WARN) 'This operation fails if service ID is NOT set'; $(NORMAL)
	-$(AWS) servicediscovery get-instances-health-status $(__SDY_SERVICE_ID__SERVICE) # --query "@.Service$(SDY_UI_SHOW_SERVICE_FIELDS)"

_sdy_show_service_instances:
	@$(INFO) '$(AWS_UI_LABEL)Showing instances of service "$(SDY_SERVICE_NAME)"...'; $(NORMAL)
	@$(WARN) 'This operation fails if service ID is NOT set'; $(NORMAL)
	-$(AWS) servicediscovery list-instances $(__SDY_SERVICE_ID__SERVICE) --query "Instances[]$(SDY_UI_SHOW_SERVICE_INSTANCES_FIELDS)"

_sdy_show_service_operations:
	@$(INFO) '$(AWS_UI_LABEL)Showing operations of service "$(SDY_SERVICE_NAME)"...'; $(NORMAL)
	@$(WARN) 'This operation fails if service ID is NOT set'; $(NORMAL)
	-$(AWS) servicediscovery list-operations --filters Name=SERVICE_ID,Values=$(strip $(SDY_SERVICE_ID)),Condition=EQ --query "Operations[]"

_sdy_update_service:
	@$(INFO) '$(AWS_UI_LABEL)Updating service "$(SDy_SERVICE_NAME)"  ...'; $(NORMAL)
	$(AWS) servicediscovery update-service $(__SDY_ID__SERVICE) $(__SDY_SERVICE)

_sdy_view_services:
	@$(INFO) '$(AWS_UI_LABEL)Viewing services ...'; $(NORMAL)
	$(AWS) servicediscovery list-services $(_X__SDY_FILTERS__SERVICES) $(_X__SDY_MAX_ITEMS__SERVICES) --query "Services[]$(SDY_UI_VIEW_SERVICES_FIELDS)"

_sdy_view_services_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing services-set "$(SDY_SERVICES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Services are grouped based on the provided filters, and/or slice'; $(NORMAL)
	$(AWS) servicediscovery list-services $(__SDY_FILTERS__SERVICES) $(_X__SDY_MAX_ITEMS__SERVICES) --query "Services[$(SDY_UI_VIEW_SERVICES_SET_FIELDS)]$(SDY_UI_VIEW_SERVICES_SET_FIELDS)"
