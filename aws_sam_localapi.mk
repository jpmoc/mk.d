_AWS_SAM_LOCALAPI_MK_VERSION= $(_AWS_SAM_MK_VERSION)

SAM_LOCALAPI_DOCKERIMAGE_FAMILY?= lambci/lambda
# SAM_LOCALAPI_DOCKERIMAGE_NAME?= lambci/lambda:python3.7
# SAM_LOCALAPI_NAME?= localapi::sam-app
# SAM_LOCALAPI_PROJECT_DIRPATH?= ./projects/sam-app/
# SAM_LOCALAPI_PROJECT_NAME?= sam-app
# SAM_LOCALAPI_PROJECT_RUNTIME?= python3.7
SAM_LOCALAPI_URL?= http://127.0.0.1:3000

# Derived parameters
SAM_LOCALAPI_DOCKERIMAGE_NAME?= $(SAM_LOCALAPI_DOCKERIMAGE_FAMILY):$(SAM_LOCALAPI_PROJECT_RUNTIME)
SAM_LOCALAPI_NAME?= $(SAM_PROJECT_NAME)
SAM_LOCALAPI_PROJECT_DIRPATH?= $(SAM_PROJECT_DIRPATH)
SAM_LOCALAPI_PROJECT_NAME?= $(SAM_PROJECT_NAME)
SAM_LOCALAPI_PROJECT_RUNTIME?= $(SAM_PROJECT_RUNTIME)

# Options parameters

# Pipe parameters
_SAM_START_LOCALAPI_|?= cd $(SAM_LOCALAPI_PROJECT_DIRPATH) && 

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sam_view_framework_macros ::
	@echo 'AWS::SAM::Simulator ($(_AWS_SAM_LOCALAPI_MK_VERSION)) macros:'
	@echo

_sam_view_framework_parameters ::
	@echo 'AWS::SAM::Simulator ($(_AWS_SAM_LOCALAPI_MK_VERSION)) parameters:'
	@echo '    SAM_LOCALAPI_DOCKERIMAGE_FAMILY=$(SAM_LOCALAPI_DOCKERIMAGE_FAMILY)'
	@echo '    SAM_LOCALAPI_DOCKERIMAGE_NAME=$(SAM_LOCALAPI_DOCKERIMAGE_NAME)'
	@echo '    SAM_LOCALAPI_NAME=$(SAM_LOCALAPI_NAME)'
	@echo '    SAM_LOCALAPI_PROJECT_DIRPATH=$(SAM_LOCALAPI_PROJECT_DIRPATH)'
	@echo '    SAM_LOCALAPI_PROJECT_NAME=$(SAM_LOCALAPI_PROJECT_NAME)'
	@echo '    SAM_LOCALAPI_PROJECT_RUNTIME=$(SAM_LOCALAPI_PROJECT_RUNTIME)'
	@echo '    SAM_LOCALAPI_URL=$(SAM_LOCALAPI_URL)'
	@echo

_sam_view_framework_targets ::
	@echo 'AWS::SAM::Simulator ($(_AWS_SAM_LOCALAPI_MK_PROJECT_VERSION)) targets:'
	@echo '    _sam_show_localapi                 - Show everything related to a local-api'
	@echo '    _sam_show_localapi_dockerimage     - Show docker-image used by a local-api'
	@echo '    _sam_show_localapi_localdynamodb   - Show local-dynamodb used by a local-api'
	@echo '    _sam_show_localapi_process         - Show process of a local-api'
	@echo '    _sam_start_localapi                - Start local-api'
	@echo '    _sam_stop_localapi                 - Stop local-api'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sam_show_localapi:: _sam_show_localapi_dockerimage _sam_show_localapi_localdynamodb _sam_show_localapi_process

_sam_show_localapi_dockerimage::
	@$(INFO) '$(SAM_UI_LABEL)Showing docker-image for localapi "$(SAM_LOCALAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The local-api uses a runtime specific docker image: $(SAM_LOCALAPI_DOCKERIMAGE_NAME)'; $(NORMAL)
	docker image list $(SAM_LOCALAPI_DOCKERIMAGE_FAMILY) 
	@$(WARN) 'More info @ https://github.com/lambci/docker-lambda'; $(NORMAL)

_sam_show_localapi_localdynamodb:
	@$(INFO) '$(SAM_UI_LABEL)Showing local-dynamodb for local-api "$(SAM_LOCALAPI_NAME)" ...'; $(NORMAL)
	# https://github.com/aws-samples/aws-sam-java-rest
	# https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html
	
_sam_show_localapi_process:
	@$(INFO) '$(SAM_UI_LABEL)Showing process of local-api "$(SAM_LOCALAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If no process found, the local-api is not running!'; $(NORMAL)
	ps -lef | grep -v grep | grep start-api || true

_sam_start_localapi:
	@$(INFO) '$(SAM_UI_LABEL)Starting local-api "$(SAM_LOCALAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation starts a local API gateway at URL $(SAM_LOCALAPI_URL)'; $(NORMAL)
	@$(WARN) 'This operation mounts the endpoints of discovered functions under that.'; $(NORMAL)
	@$(WARN) 'Check output below for local-function endpoints'; $(NORMAL)
	$(_SAM_START_LOCALAPI_|) $(SAM) local start-api

_sam_stop_localapi:
	@$(INFO) '$(SAM_UI_LABEL)Stopping local-api "$(SAM_LOCALAPI_NAME)" ...'; $(NORMAL)
