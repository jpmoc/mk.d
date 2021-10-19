_AWS_SAM_LOCALFUNCTION_MK_VERSION= $(_AWS_SAM_MK_VERSION)

# SAM_LOCALFUNCTION_API_PATH?= /hello
SAM_LOCALFUNCTION_CURL_METHOD?= GET
# SAM_LOCALFUNCTION_EVENT_FILENAME?= event.json
# SAM_LOCALFUNCTION_EVENT_FILEPATH?= ./sam-app/events/event.json
# SAM_LOCALFUNCTION_EVENTS_DIRPATH?= ./projects/sam-app/events
# SAM_LOCALFUNCTION_NAME?= simulator::sam-app
# SAM_LOCALFUNCTION_LOCALAPI_URL?= http://127.0.0.1:3000
# SAM_LOCALFUNCTION_PROJECT_DIRPATH?= ./projects/sam-app/
# SAM_LOCALFUNCTION_URL?= http://127.0.0.1:3000/hello

# Derived parameters
SAM_LOCALFUNCTION_LOCALAPI_URL?= $(SAM_LOCALAPI_URL)
SAM_LOCALFUNCTION_EVENT_FILENAME?= $(SAM_EVENT_FILENAME)
SAM_LOCALFUNCTION_EVENT_FILEPATH?= $(SAM_EVENT_FILEPATH)
SAM_LOCALFUNCTION_EVENTS_DIRPATH?= $(SAM_EVENTS_DIRPATH)
SAM_LOCALFUNCTION_PROJECT_DIRPATH?= $(SAM_PROJECT_DIRPATH)
SAM_LOCALFUNCTION_PROJECT_NAME?= $(SAM_PROJECT_NAME)
SAM_LOCALFUNCTION_URL?= $(SAM_LOCALFUNCTION_LOCALAPI_URL)$(SAM_LOCALFUNCTION_API_PATH)

# Options parameters
__SAM_DATA= $(if $(SAM_LOCALFUNCTION_CURL_DATA),--data $(SAM_LOCALFUNCTION_CURL_DATA))
__SAM_EVENT__LOCALFUNCTION= $(if $(SAM_LOCALFUNCTION_EVENT_FILEPATH),--event $(SAM_LOCALFUNCTION_EVENT_FILEPATH),--no-event)
__SAM_REQUEST= $(if $(SAM_LOCALFUNCTION_CURL_METHOD),--request $(SAM_LOCALFUNCTION_CURL_METHOD))

# Pipe parameters
_SAM_INVOKE_LOCALFUNCTION_|?= cd $(SAM_LOCALFUNCTION_PROJECT_DIRPATH) && 

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sam_view_framework_macros ::
	@echo 'AWS::SAM::LocalFunction ($(_AWS_SAM_LOCALFUNCTION_MK_VERSION)) macros:'
	@echo

_sam_view_framework_parameters ::
	@echo 'AWS::SAM::LocalFunction ($(_AWS_SAM_LOCALFUNCTION_MK_VERSION)) parameters:'
	@echo '    SAM_LOCALFUNCTION_API_PATH=$(SAM_LOCALFUNCTION_API_PATH)'
	@echo '    SAM_LOCALFUNCTION_EVENT_FILENAME=$(SAM_LOCALFUNCTION_EVENT_FILENAME)'
	@echo '    SAM_LOCALFUNCTION_EVENT_FILEPATH=$(SAM_LOCALFUNCTION_EVENT_FILEPATH)'
	@echo '    SAM_LOCALFUNCTION_LOCALAPI_URL=$(SAM_LOCALFUNCTION_LOCALAPI_URL)'
	@echo '    SAM_LOCALFUNCTION_NAME=$(SAM_LOCALFUNCTION_NAME)'
	@echo '    SAM_LOCALFUNCTION_PROJECT_DIRPATH=$(SAM_LOCALFUNCTION_PROJECT_DIRPATH)'
	@echo '    SAM_LOCALFUNCTION_PROJECT_NAME=$(SAM_LOCALFUNCTION_PROJECT_NAME)'
	@echo '    SAM_LOCALFUNCTION_URL=$(SAM_LOCALFUNCTION_URL)'
	@echo

_sam_view_framework_targets ::
	@echo 'AWS::SAM::LocalFunction ($(_AWS_SAM_LOCALFUNCTION_MK_PROJECT_VERSION)) targets:'
	@echo '    _sam_curl_localfunction                   - Curl a local-function'
	@echo '    _sam_invoke_localfunction                 - Invoke a local-function'
	@echo '    _sam_view_localfunctions                  - View local-functions'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sam_curl_localfunction:
	@$(INFO) '$(SAM_UI_LABEL)Curling local-function "$(SAM_LOCALFUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This command works best when the local-api is running in the background of the same terminal'; $(NORMAL)
	curl $(__SAM_DATA) $(__SAM_REQUEST) $(SAM_LOCALFUNCTION_URL)

_sam_invoke_localfunction:
	@$(INFO) '$(SAM_UI_LABEL)Invoking local-function "$(SAM_LOCALFUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation bypasses the API-gateway'; $(NORMAL)
	@$(WARN) 'This operation is similar to a AWS-sig4-signed event-loaded curl request sent directly to function!'; $(NORMAL)
	$(if $(SAM_LOCALFUNCTION_EVENT_FILEPATH),cat $(SAM_LOCALFUNCTION_EVENT_FILEPATH))
	$(_SAM_INVOKE_LOCALFUNCTION_|) $(SAM) local invoke $(__SAM_EVENT__LOCALFUNCTION) $(__SAM_NO_EVENT) $(SAM_LOCALFUNCTION_NAME)

_sam_view_localfunctions:
	@$(INFO) '$(SAM_UI_LABEL)Viewing local-functions ...'; $(NORMAL)
