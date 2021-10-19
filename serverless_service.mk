_SERVERLESS_SERVICE_MK_VERSION= $(_SERVERLESS_MK_VERSION)

# SLS_SERVICE_ARTIFACTS_DIRPATH= ./service/name/.serverless
# SLS_SERVICE_AWS_REGION= us-west-1
# SLS_SERVICE_BUCKET_NAME= dev
# SLS_SERVICE_CODE_URL= https://github.com/serverless/examples/tree/master/aws-python-simple-http-endpoint
# SLS_SERVICE_DASHBOARD_URL?= https://dashboard.serverless.com/tenants/emmanuelmayssat/applications/aws-python-simple-http-endpoint-app/services/aws-python-simple-http-endpoint/stage/dev/region/us-east-1#service-overview=overview
# SLS_SERVICE_DIRPATH= ./services/helloworld
# SLS_SERVICE_ENDPOINT_URL= https://kn19qvmqf4.execute-api.us-east-1.amazonaws.com/dev
# SLS_SERVICE_NAME= aws-python-simple-http-endpoint
# SLS_SERVICE_STACK_NAME= aws-python-simple-http-endpoint-dev
# SLS_SERVICE_STAGE_NAME= dev
# SLS_SERVICES_DIRPATH= ./services
SLS_SERVICES_NAME_REGEX= */
SLS_SERVICES_SET_NAME= all-services

# Derived parameters
SLS_SERVICE_ARTIFACTS_DIRPATH?= $(SLS_SERVICE_DIRPATH)/.serverless
SLS_SERVICE_AWS_REGION?= $(SLS_AWS_REGION)
SLS_SERVICE_COLOR_ENABLE?= $(SLS_COLOR_ENABLE)
SLS_SERVICE_DASHBOARD_URL?= $(SLS_DASHBOARD_APPLICATIONS_URL)/$(SLS_SERVICE_NAME)-app/services/$(SLS_SERVICE_NAME)/stage/$(SLS_SERVICE_STAGE_NAME)/region/$(SLS_SERVICE_AWS_REGION)
SLS_SERVICE_DIRPATH?= $(SLS_SERVICES_DIRPATH)/$(SLS_SERVICE_NAME)
SLS_SERVICE_MODE_DEBUG?= $(SLS_MODE_DEBUG)
SLS_SERVICE_STACK_NAME?= $(SLS_SERVICE_NAME)-$(SLS_SERVICE_STAGE_NAME)
SLS_SERVICE_STAGE_NAME?= $(SLS_STAGE_NAME)

# Options parameters
__SLS_NAME__SERVICE= $(if $(SLS_SERVICE_NAME),--name $(SLS_SERVICE_NAME))
__SLS_NO_COLOR__SERVICE= $(if $(filter false, $(SLS_SERVICE_COLOR_ENABLE)),--no-color)
__SLS_STAGE__SERVICE= $(if $(SLS_SERVICE_STAGE_NAME),--stage $(SLS_SERVICE_STAGE_NAME))
__SLS_REGION__SERVICE= $(if $(SLS_SERVICE_AWS_REGION),--region $(SLS_SERVICE_AWS_REGION))
__SLS_URL= $(if $(SLS_SERVICE_CODE_URL),--url $(SLS_SERVICE_CODE_URL))
__SLS_VERBOSE__SERVICE= $(if $(filter true, $(SLS_SERVICE_MODE_DEBUG)),--verbose)

# Pipe parameters
_SLS_CREATE_SERVICE_|?= cd $(SLS_SERVICES_DIRPATH) && 
_SLS_DEPLOY_SERVICE_|?= cd $(SLS_SERVICE_DIRPATH) && 
_SLS_DOWNLOAD_SERVICE_|?= cd $(SLS_SERVICES_DIRPATH) && 
_SLS_ENABLE_SERVICE_MONITORING_|?= cd $(SLS_SERVICE_DIRPATH) && 
_SLS_SHOW_SERVICE_DEPLOYMENTS_|?= cd $(SLS_SERVICE_DIRPATH) && 
_SLS_SHOW_SERVICE_DESCRIPTION_|?= cd $(SLS_SERVICE_DIRPATH) && 
_SLS_SHOW_SERVICE_FUNCTIONS_|?= cd $(SLS_SERVICE_DIRPATH) && 
_SLS_SHOW_SERVICE_PACKAGES_|?= cd $(SLS_SERVICE_DIRPATH)/.serverless && 
_SLS_SHOW_SERVICE_TEMPLATE_|?= cd $(SLS_SERVICE_DIRPATH)/.serverless && 
_SLS_UNDEPLOY_SERVICE_|?= cd $(SLS_SERVICE_DIRPATH) && 
_SLS_VIEW_SERVICES_|?= cd $(SLS_SERVICES_DIRPATH) && 
_SLS_VIEW_SERVICES_SET_|?= cd $(SLS_SERVICES_DIRPATH) && 

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sls_view_framework_macros ::
	@echo 'ServerLesS::Service ($(_SERVERLESS_SERVICE_MK_VERSION)) macros:'
	@echo

_sls_view_framework_parameters ::
	@echo 'ServerLesS::Service ($(_SERVERLESS_SERVICE_MK_VERSION)) parameters:'
	@echo '    SLS_SERVICE_ARTIFACT_DIRPATH=$(SLS_SERVICE_ARTIFACT_DIRPATH)'
	@echo '    SLS_SERVICE_AWS_REGION=$(SLS_SERVICE_AWS_REGION)'
	@echo '    SLS_SERVICE_BUCKET_NAME=$(SLS_SERVICE_BUCKET_NAME)'
	@echo '    SLS_SERVICE_CODE_URL=$(SLS_SERVICE_CODE_URL)'
	@echo '    SLS_SERVICE_COLOR_ENABLE=$(SLS_SERVICE_COLOR_ENABLE)'
	@echo '    SLS_SERVICE_DASHBOARD_URL=$(SLS_SERVICE_DASHBOARD_URL)'
	@echo '    SLS_SERVICE_DIRPATH=$(SLS_SERVICE_DIRPATH)'
	@echo '    SLS_SERVICE_ENDPOINT_URL=$(SLS_SERVICE_ENDPOINT_URL)'
	@echo '    SLS_SERVICE_MODE_DEBUG=$(SLS_SERVICE_MODE_DEBUG)'
	@echo '    SLS_SERVICE_NAME=$(SLS_SERVICE_NAME)'
	@echo '    SLS_SERVICE_STACK_NAME=$(SLS_SERVICE_STACK_NAME)'
	@echo '    SLS_SERVICE_STAGE_NAME=$(SLS_SERVICE_STAGE_NAME)'
	@echo '    SLS_SERVICES_DIRPATH=$(SLS_SERVICES_DIRPATH)'
	@echo '    SLS_SERVICES_NAME_REGEX=$(SLS_SERVICES_NAME_REGEX)'
	@echo '    SLS_SERVICES_SET_NAME=$(SLS_SERVICES_SET_NAME)'
	@echo

_sls_view_framework_targets ::
	@echo 'ServerLesS::Service ($(_SERVERLESS_MK_SERVICE_VERSION)) targets:'
	@echo '    _sls_create_service                  - Create a new service'
	@echo '    _sls_delete_service                  - Delete an existing service'
	@echo '    _sls_deploy_service                  - Deploy service'
	@echo '    _sls_download_service                - Download a service'
	@echo '    _sls_enable_service_monitoring       - Enable monitoring for a service'
	@echo '    _sls_show_service                    - Show everything related to a service'
	@echo '    _sls_show_service_artifacts          - Show artifacts of a service'
	@echo '    _sls_show_service_deployments        - Show deployments of a service'
	@echo '    _sls_show_service_description        - Show the description of a service'
	@echo '    _sls_show_service_functions          - Show functions of a service'
	@echo '    _sls_show_service_manifest           - Show manifest of a service'
	@echo '    _sls_show_service_packages           - Show packages of a service'
	@echo '    _sls_show_service_template           - Show templates of a service'
	@echo '    _sls_show_service_urls               - Show urls of a service'
	@echo '    _sls_update_service                  - Update an service'
	@echo '    _sls_undeploy_service                - Undeploy an service'
	@echo '    _sls_view_services                   - View services'
	@echo '    _sls_view_services_set               - View a set of services'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sls_create_service:
	@$(INFO) '$(SLS_UI_LABEL)Creating service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	$(_SLS_CREATE_SERVICE_|) $(SERVERLESS) $(__SLS_NO_COLOR__SERVICE) $(__SLS_VERBOSE__SERVICE)

_sls_delete_service:
	@$(INFO) '$(SLS_UI_LABEL)Deleting service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	@read -p 'You are about to delete the service directory "$(SLS_SERVICE_DIRPATH)". Are you sure?' yesNo
	rm -r $(SLS_SERVICE_DIRPATH)

_sls_deploy_service:
	@$(INFO) '$(SLS_UI_LABEL)Deploying service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	$(_SLS_DEPLOY_SERVICE_|) $(SERVERLESS) deploy $(__SLS_NO_COLOR__SERVICE) $(__SLS_REGION__SERVICE) $(__SLS_STAGE__SERVICE) $(__SLS_VERBOSE__SERVICE)

_sls_download_service:
	@$(INFO) '$(SLS_UI_LABEL)Downloading service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	$(_SLS_DOWNLOAD_SERVICE_|) $(SERVERLESS) install $(__SLS_NAME__SERVICE) $(__SLS_NO_COLOR__SERVICE) $(__SLS_URL) $(__SLS_VERBOSE__SERVICE)

_sls_enable_service_monitoring:
	@$(INFO) '$(SLS_UI_LABEL)Enabling monitoring for service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation enables monitoring for an existing service'; $(NORMAL)
	$(_SLS_ENABLE_SERVICE_MONITORING_|) $(SERVERLESS) $(__SLS_NO_COLOR__SERVICE) $(__SLS_VERBOSE__SERVICE)

_sls_show_service:: _sls_show_service_artifacts _sls_show_service_deployments _sls_show_service_files _sls_show_service_functions _sls_show_service_manifest _sls_show_service_urls _sls_show_service_description

_sls_show_service_artifacts: _sls_show_service_template _sls_show_service_packages

_sls_show_service_deployments: 
	@$(INFO) '$(SLS_UI_LABEL)Showing deployments of service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Each deployment corresponds to a cloudformation-template and a set of packages stored in S3'; $(NORMAL)
	$(_SLS_SHOW_SERVICE_DEPLOYMENTS_|) $(SERVERLESS) deploy list $(__SLS_NO_COLOR__SERVICE) $(__SLS_REGION__SERVICE) $(__SLS_STAGE__SERVICE) $(__SLS_VERBOSE__SERVICE)

_sls_show_service_description: 
	@$(INFO) '$(SLS_UI_LABEL)Showing description of service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	$(_SLS_SHOW_SERVICE_DESCRIPTION_|) $(SERVERLESS) info $(__SLS_NO_COLOR__SERVICE) $(__SLS_REGION__SERVICE) $(__SLS_STAGE__SERVICE) $(__SLS_VERBOSE__SERVICE)

_sls_show_service_files: 
	@$(INFO) '$(SLS_UI_LABEL)Showing files of service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	ls -al $(SLS_SERVICE_DIRPATH)

_sls_show_service_functions: 
	@$(INFO) '$(SLS_UI_LABEL)Showing functions of service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	$(_SLS_SHOW_SERVICE_FUNCTIONS_|) $(SERVERLESS) deploy list functions $(__SLS_NO_COLOR__SERVICE) $(__SLS_REGION__SERVICE) $(__SLS_STAGE__SERVICE) $(__SLS_VERBOSE__SERVICE)

_sls_show_service_manifest: 
	@$(INFO) '$(SLS_UI_LABEL)Showing manifest of service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	$(_SLS_SHOW_SERVICE_FUNCTIONS_|) $(SERVERLESS) print $(__SLS_NO_COLOR__SERVICE) $(__SLS_REGION__SERVICE) $(__SLS_STAGE__SERVICE) $(__SLS_VERBOSE__SERVICE)

_sls_show_service_packages: 
	@$(INFO) '$(SLS_UI_LABEL)Showing deployment-packages of service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	$(_SLS_SHOW_SERVICE_PACKAGES_|) ls -l *.zip

_sls_show_service_template: 
	@$(INFO) '$(SLS_UI_LABEL)Showing cloudformation-template of service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	$(_SLS_SHOW_SERVICE_TEMPLATE_|) ls -l *.json

_sls_show_service_urls: 
	@$(INFO) '$(SLS_UI_LABEL)Showing URLs of service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Code URL     : $(SLS_SERVICE_CODE_URL)'; $(NORMAL)
	@$(WARN) 'Dashboard URL: $(SLS_SERVICE_DASHBOARD_URL)'; $(NORMAL)
	@$(WARN) 'Endpoint URL : $(SLS_SERVICE_ENDPOINT_URL)'; $(NORMAL)
	

_sls_update_service: _sls_deploy_service

_sls_undeploy_service:
	@$(INFO) '$(SLS_UI_LABEL)Undeploying service "$(SLS_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation deletes the associated cloudformation stack'; $(NORMAL)
	$(_SLS_UNDEPLOY_SERVICE_|) $(SERVERLESS) remove $(__SLS_NO_COLOR__SERVICE) $(__SLS_REGION__SERVICE) $(__SLS_STAGE__SERVICE) $(__SLS_VERBOSE__SERVICE)

_sls_view_services:
	@$(INFO) '$(SLS_UI_LABEL)Viewing services ...'; $(NORMAL)
	$(_SLS_VIEW_SERVICES_|) ls -dl */

_sls_view_services_set:
	@$(INFO) '$(SLS_UI_LABEL)Viewing services-set "$(SLS_SERVICES_SET_NAME)" ...'; $(NORMAL)
	$(_SLS_VIEW_SERVICES_SET_|) ls -dl $(SLS_SERVICES_NAME_REGEX)
