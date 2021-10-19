_SERVERLESS_FUNCTION_MK_VERSION= $(_SERVERLESS_MK_VERSION)

# SLS_FUNCTION_API_PATH?= currentTime
# SLS_FUNCTION_AWS_REGION?= us-west-2
# SLS_FUNCTION_ENDPOINT_URL?= https://kn19qvmqf4.execute-api.us-east-1.amazonaws.com/dev/currentTime
# SLS_FUNCTION_HANDLER_FUNCPATH?= src/functions/fileName.handlerName
SLS_FUNCTION_INVOKE_LOG?= true
# SLS_FUNCTION_NAME?= currentTime
# SLS_FUNCTION_SERVICE_ENDPOINTURL?= https://kn19qvmqf4.execute-api.us-east-1.amazonaws.com/dev 
# SLS_FUNCTION_SERVICE_NAME?= 
# SLS_FUNCTION_STAGE_NAME?= dev

# Derived parameters
SLS_FUNCTION_API_PATH?= $(SLS_FUNCTION_NAME)
SLS_FUNCTION_AWS_REGION?= $(AWS_REGION)
SLS_FUNCTION_ENDPOINT_URL?= $(SLS_FUNCTION_SERVICEENDPOINT_URL)/$(SLS_FUNCTION_API_PATH)
SLS_FUNCTION_LAMBDA_NAME?= $(SLS_FUNCTION_SERVICE_NAME)-$(SLS_FUNCTION_STAGE_NAME)-$(SLS_FUNCTION_NAME)
SLS_FUNCTION_SERVICE_NAME?= $(SLS_SERVICE_NAME)
SLS_FUNCTION_SERVICE_ENDPOINTURL?= $(SLS_SERVICE_ENDPOINT_URL)
SLS_FUNCTION_STAGE_NAME?= $(SLS_STAGE_NAME)

# Options parameters
__SLS_FUNCTION= $(if $(SLS_FUNCTION_NAME),--function $(SLS_FUNCTION_NAME))
__SLS_HANDLER= $(if $(SLS_FUNCTION_HANDLER_FUNCPATH),--handler $(SLS_FUNCTION_HANDLER_FUNCPATH))
__SLS_LOG= $(if $(filter true, $(SLS_FUNCTION_INVOKE_LOG)),--log)
__SLS_PATH= $(if $(SLS_FUNCTION_API_PATH)),--path $(SLS_FUNCTION_API_PATH))
__SLS_REGION__FUNCTION= $(if $(SLS_FUNCTION_AWS_REGION),--region $(SLS_FUNCTION_AWS_REGION))
__SLS_STAGE__FUNCTION= $(if $(SLS_FUNCTION_STAGE_NAME),--stage $(SLS_FUNCTION_STAGE_NAME))

# Pipe parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sls_view_framework_macros ::
	@echo 'ServerLesS::Function ($(_SERVERLESS_FUNCTION_MK_VERSION)) macros:'
	@echo

_sls_view_framework_parameters ::
	@echo 'ServerLesS::Function ($(_SERVERLESS_FUNCTION_MK_VERSION)) parameters:'
	@echo '    SLS_FUNCTION_API_PATH=$(SLS_FUNCTION_API_PATH)'
	@echo '    SLS_FUNCTION_AWS_REGION=$(SLS_FUNCTION_AWS_REGION)'
	@echo '    SLS_FUNCTION_ENDPOINT_URL=$(SLS_FUNCTION_ENDPOINT_URL)'
	@echo '    SLS_FUNCTION_HANDLER_FUNCPATH=$(SLS_FUNCTION_HANDLER_FUNCPATH)'
	@echo '    SLS_FUNCTION_INVOKE_LOG=$(SLS_FUNCTION_INVOKE_LOG)'
	@echo '    SLS_FUNCTION_LAMBDA_NAME=$(SLS_FUNCTION_LAMBDA_NAME)'
	@echo '    SLS_FUNCTION_NAME=$(SLS_FUNCTION_NAME)'
	@echo '    SLS_FUNCTION_SERVICE_ENDPOINTURL=$(SLS_FUNCTION_SERVICE_ENDPOINTURL)'
	@echo '    SLS_FUNCTION_SERVICE_NAME=$(SLS_FUNCTION_SERVICE_NAME)'
	@echo

_sls_view_framework_targets ::
	@echo 'ServerLesS::Function ($(_SERVERLESS_FUNCTION_MK_VERSION)) targets:'
	@echo '    _sls_create_function                 - Create a function'
	@echo '    _sls_curl_function                   - Curl an endpoint of a function'
	@echo '    _sls_invoke_function                 - Invoke a function'
	@echo '    _sls_show_function                   - Show everything related to a function'
	@echo '    _sls_show_function_description       - Show the description of a function'
	@echo '    _sls_view_functions                  - View functions'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sls_create_function:
	@$(INFO) '$(SLS_UI_LABEL)Invoking function "$(SLS_FUNCTION_NAME)" ...'; $(NORMAL)
	$(_SLS_DEPLOY_SERVICE_|) $(SERVERLESS) create function $(__SLS_FUNCTION) $(__SLS_HANDLER) $(__SLS_PATH) $(__SLS_STAGE)


_sls_curl_function:
	@$(INFO) '$(SLS_UI_LABEL)Curling function "$(SLS_FUNCTION_NAME)" ...'; $(NORMAL)
	curl -X GET $(SLS_FUNCTION_ENDPOINT_URL)

_sls_invoke_function:
	@$(INFO) '$(SLS_UI_LABEL)Invoking function "$(SLS_FUNCTION_NAME)" ...'; $(NORMAL)
	$(_SLS_DEPLOY_SERVICE_|) $(SERVERLESS) invoke $(__SLS_FUNCTION) $(__SLS_LOG) $(__SLS_REGION__FUNCTION)

_sls_show_function:: _sls_show__sls_show_function_description

_sls_show_function_description: 
	@$(INFO) '$(SLS_UI_LABEL)Showing description of function "$(SLS_FUNCTION_NAME)" ...'; $(NORMAL)
	$(_SLS_SHOW_SERVICE_DESCRIPTION_|) $(SERVERLESS) info

_sls_tail_function:
	@$(INFO) '$(SLS_UI_LABEL)Tailing logs of function "$(SLS_FUNCTION_NAME)" ...'; $(NORMAL)

_sls_view_functions:
	@$(INFO) '$(SLS_UI_LABEL)Viewing functions ...'; $(NORMAL)
