_AWS_CHALICE_LOCALAPI_MK_VERSION= $(_AWS_CHALICE_MK_VERSION)

CLE_LOCALAPI_AUTORELOAD_ENABLE?= true
CLE_LOCALAPI_HOST?= 127.0.0.1
# CLE_LOCALAPI_NAME?= localapi::cle-app
CLE_LOCALAPI_PORT?= 8000
# CLE_LOCALAPI_PROJECT_DIRPATH?= ./projects/hello-chalice/
# CLE_LOCALAPI_PROJECT_NAME?= hello-chalice 
# CLE_LOCALAPI_STAGE_NAME?= dev
# CLE_LOCALAPI_URL?= http://127.0.0.1:8000

# Derived parameters
CLE_LOCALAPI_NAME?= $(CLE_PROJECT_NAME)
CLE_LOCALAPI_PROJECT_DIRPATH?= $(CLE_PROJECT_DIRPATH)
CLE_LOCALAPI_PROJECT_NAME?= $(CLE_PROJECT_NAME)
CLE_LOCALAPI_PROJECT_RUNTIME?= $(CLE_PROJECT_RUNTIME)
CLE_LOCALAPI_STAGE_NAME?= $(CLE_PROJECT_STAGE_NAME)
CLE_LOCALAPI_URL?= http://$(CLE_LOCALAPI_HOST):$(CLE_LOCALAPI_PORT)

# Options parameters
__CLE_AUTORELOAD= $(if $(filter false, $(CLE_LOCALAPI_AUTORELOAD_ENABLE)),--no-autoreload,--autoreload)
__CLE_HOST= $(if $(CLE_LOCALAPI_HOST),--host $(CLE_LOCALAPI_HOST))
__CLE_PORT= $(if $(CLE_LOCALAPI_PORT),--port $(CLE_LOCALAPI_PORT))

# Pipe parameters
_CLE_START_LOCALAPI_|?= cd $(CLE_LOCALAPI_PROJECT_DIRPATH) && 

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sam_view_framework_macros ::
	@echo 'AWS::Chalice::LocalApi ($(_AWS_CHALICE_LOCALAPI_MK_VERSION)) macros:'
	@echo

_sam_view_framework_parameters ::
	@echo 'AWS::Chalice::LocalApi ($(_AWS_CHALICE_LOCALAPI_MK_VERSION)) parameters:'
	@echo '    CLE_LOCALAPI_AUTORELOAD_ENABLE=$(CLE_LOCALAPI_AUTORELOAD_ENABLE)'
	@echo '    CLE_LOCALAPI_HOST=$(CLE_LOCALAPI_HOST)'
	@echo '    CLE_LOCALAPI_NAME=$(CLE_LOCALAPI_NAME)'
	@echo '    CLE_LOCALAPI_PORT=$(CLE_LOCALAPI_PORT)'
	@echo '    CLE_LOCALAPI_PROJECT_DIRPATH=$(CLE_LOCALAPI_PROJECT_DIRPATH)'
	@echo '    CLE_LOCALAPI_PROJECT_NAME=$(CLE_LOCALAPI_PROJECT_NAME)'
	@echo '    CLE_LOCALAPI_PROJECT_RUNTIME=$(CLE_LOCALAPI_PROJECT_RUNTIME)'
	@echo '    CLE_LOCALAPI_STAGE_NAME=$(CLE_LOCALAPI_STAGE_NAME)'
	@echo '    CLE_LOCALAPI_URL=$(CLE_LOCALAPI_URL)'
	@echo

_cle_view_framework_targets ::
	@echo 'AWS::Chalice::LocalApi ($(_AWS_CHALICE_LOCALAPI_MK_PROJECT_VERSION)) targets:'
	@echo '    _cle_show_localapi                 - Show everything related to a local-api'
	@echo '    _cle_show_localapi_localdynamodb   - Show local-dynamodb used by a local-api'
	@echo '    _cle_show_localapi_process         - Show process of a local-api'
	@echo '    _cle_start_localapi                - Start local-api'
	@echo '    _cle_stop_localapi                 - Stop local-api'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cle_show_localapi:: _cle_show_localapi_localdynamodb _cle_show_localapi_process

_cle_show_localapi_localdynamodb:
	@$(INFO) '$(CLE_UI_LABEL)Showing local-dynamodb for local-api "$(CLE_LOCALAPI_NAME)" ...'; $(NORMAL)
	# https://github.com/aws-cleples/aws-cle-java-rest
	# https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html
	
_cle_show_localapi_process:
	@$(INFO) '$(CLE_UI_LABEL)Showing process of local-api "$(CLE_LOCALAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If no process found, the local-api is not running!'; $(NORMAL)
	# ps -lef | grep -v grep | grep start-api || true

_cle_start_localapi:
	@$(INFO) '$(CLE_UI_LABEL)Starting local-api "$(CLE_LOCALAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation starts a local API gateway at URL $(CLE_LOCALAPI_URL)'; $(NORMAL)
	@#$(WARN) 'This operation mounts the endpoints of discovered functions under that.'; $(NORMAL)
	@#$(WARN) 'Check output below for local-function endpoints'; $(NORMAL)
	$(_CLE_START_LOCALAPI_|) $(CHALICE) local $(__CLE_AUTORELOAD) $(__CLE_HOST) $(__CLE_PORT)

_cle_stop_localapi:
	@$(INFO) '$(CLE_UI_LABEL)Stopping local-api "$(CLE_LOCALAPI_NAME)" ...'; $(NORMAL)
