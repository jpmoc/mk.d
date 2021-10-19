_AWS_CHALICE_LOCALFUNCTION_MK_VERSION= $(_AWS_CHALICE_MK_VERSION)

# CLE_LOCALFUNCTION_API_PATH?= /hello
CLE_LOCALFUNCTION_CURL_METHOD?= GET
# CLE_LOCALFUNCTION_EVENT_FILENAME?= event.json
# CLE_LOCALFUNCTION_EVENT_FILEPATH?= ./sam-app/events/event.json
# CLE_LOCALFUNCTION_EVENTS_DIRPATH?= ./projects/sam-app/events
# CLE_LOCALFUNCTION_NAME?= simulator::sam-app
# CLE_LOCALFUNCTION_LOCALAPI_URL?= http://127.0.0.1:3000
# CLE_LOCALFUNCTION_PROJECT_DIRPATH?= ./projects/sam-app/
# CLE_LOCALFUNCTION_URL?= http://127.0.0.1:3000/hello

# Derived parameters
CLE_LOCALFUNCTION_LOCALAPI_URL?= $(CLE_LOCALAPI_URL)
CLE_LOCALFUNCTION_EVENT_FILENAME?= $(CLE_EVENT_FILENAME)
CLE_LOCALFUNCTION_EVENT_FILEPATH?= $(CLE_EVENT_FILEPATH)
CLE_LOCALFUNCTION_EVENTS_DIRPATH?= $(CLE_EVENTS_DIRPATH)
CLE_LOCALFUNCTION_PROJECT_DIRPATH?= $(CLE_PROJECT_DIRPATH)
CLE_LOCALFUNCTION_PROJECT_NAME?= $(CLE_PROJECT_NAME)
CLE_LOCALFUNCTION_URL?= $(CLE_LOCALFUNCTION_LOCALAPI_URL)$(CLE_LOCALFUNCTION_API_PATH)

# Options parameters
__CLE_DATA= $(if $(CLE_LOCALFUNCTION_CURL_DATA),--data $(CLE_LOCALFUNCTION_CURL_DATA))
__CLE_EVENT__LOCALFUNCTION= $(if $(CLE_LOCALFUNCTION_EVENT_FILEPATH),--event $(CLE_LOCALFUNCTION_EVENT_FILEPATH),--no-event)
__CLE_NAME__LOCALFUNCTION= $(if $(CLE_LOCALFUNCTION_NAME),--name $(CLE_LOCALFUNCTION_NAME))
__CLE_REQUEST= $(if $(CLE_LOCALFUNCTION_CURL_METHOD),--request $(CLE_LOCALFUNCTION_CURL_METHOD))

# Pipe parameters
_CLE_INVOKE_LOCALFUNCTION_|?= cd $(CLE_LOCALFUNCTION_PROJECT_DIRPATH) && 
|_CLE_INVOKE_LOCALFUNCTION?= $(if $(CLE_LOCALFUNCTION_EVENT_FILEPATH), < $(CLE_LOCALFUNCTION_EVENT_FILEPATH))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cle_view_framework_macros ::
	@echo 'AWS::Chalice::LocalFunction ($(_AWS_CHALICE_LOCALFUNCTION_MK_VERSION)) macros:'
	@echo

_cle_view_framework_parameters ::
	@echo 'AWS::Chalice::LocalFunction ($(_AWS_CHALICE_LOCALFUNCTION_MK_VERSION)) parameters:'
	@echo '    CLE_LOCALFUNCTION_API_PATH=$(CLE_LOCALFUNCTION_API_PATH)'
	@echo '    CLE_LOCALFUNCTION_EVENT_FILENAME=$(CLE_LOCALFUNCTION_EVENT_FILENAME)'
	@echo '    CLE_LOCALFUNCTION_EVENT_FILEPATH=$(CLE_LOCALFUNCTION_EVENT_FILEPATH)'
	@echo '    CLE_LOCALFUNCTION_LOCALAPI_URL=$(CLE_LOCALFUNCTION_LOCALAPI_URL)'
	@echo '    CLE_LOCALFUNCTION_NAME=$(CLE_LOCALFUNCTION_NAME)'
	@echo '    CLE_LOCALFUNCTION_PROJECT_DIRPATH=$(CLE_LOCALFUNCTION_PROJECT_DIRPATH)'
	@echo '    CLE_LOCALFUNCTION_PROJECT_NAME=$(CLE_LOCALFUNCTION_PROJECT_NAME)'
	@echo '    CLE_LOCALFUNCTION_URL=$(CLE_LOCALFUNCTION_URL)'
	@echo

_cle_view_framework_targets ::
	@echo 'AWS::Chalice::LocalFunction ($(_AWS_CHALICE_LOCALFUNCTION_MK_PROJECT_VERSION)) targets:'
	@echo '    _cle_curl_localfunction                   - Curl a local-function'
	@echo '    _cle_invoke_localfunction                 - Invoke a local-function'
	@echo '    _cle_view_localfunctions                  - View local-functions'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cle_curl_localfunction:
	@$(INFO) '$(CLE_UI_LABEL)Curling local-function "$(CLE_LOCALFUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This command works best when the local-api is running in the background of the same terminal'; $(NORMAL)
	curl $(__CLE_DATA) $(__CLE_REQUEST) $(CLE_LOCALFUNCTION_URL)

_cle_invoke_localfunction:
	@$(INFO) '$(CLE_UI_LABEL)Invoking local-function "$(CLE_LOCALFUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation bypasses the API-gateway'; $(NORMAL)
	@$(WARN) 'This operation is similar to a AWS-sig4-signed event-loaded curl request sent directly to function!'; $(NORMAL)
	$(if $(CLE_LOCALFUNCTION_EVENT_FILEPATH),cat $(CLE_LOCALFUNCTION_EVENT_FILEPATH))
	$(_CLE_INVOKE_LOCALFUNCTION_|) $(CHALICE) invoke $(__CLE_NAME__LOCALFUNCTION) $(|_CLE_INVOKE_LOCALFUNCTION) 

_cle_view_localfunctions:
	@$(INFO) '$(CLE_UI_LABEL)Viewing local-functions ...'; $(NORMAL)
