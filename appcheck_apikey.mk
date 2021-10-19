_APPCHECK_APIKEY_MK_VERSION= $(_APPCHECK_MK_VERSION)

# ACK_APIKEY_API_URL?=
# ACK_APIKEY_NAME?= my-key
# ACK_APIKEY_TTL?= 86400
# ACK_APIKEY_VALUE?= AAAAAjblWxXhtbia0tT++rpL0IJ6US+hiVnVm/UUs/c9MjyG

# Derived parameters
ACK_APIKEY_API_URL?= $(ACK_API_URL)

# Option parameters
__ACK_DATA__APIKEY+= $(if $(ACL_APIKEY_TTL),--data '{"validity": $(ACK_APIKEY_TTL)}')
__ACK_HEADERS__APIKEY+= $(if $(ACK_APIKEY_VALUE),--header 'Authorization: Bearer $(ACK_APIKEY_VALUE)')

# Pipe parameters
|_ACK_CREATE_APIKEY?=
|_ACK_SHOW_APIKEY_USERS?= | jq '.'

# UI parameters
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ack_view_framework_macros ::
	@echo 'AppChecK::ApiKey ($(_APPCHECK_APIKEY_MK_VERSION)) macros:'
	@echo

_ack_view_framework_parameters ::
	@echo 'AppChecK::ApiKey ($(_APPCHECK_APIKEY_MK_VERSION)) parameters:'
	@echo '    ACK_APIKEY_API_URL=$(ACK_APIKEY_API_URL)'
	@echo '    ACK_APIKEY_NAME=$(ACK_APIKEY_NAME)'
	@echo '    ACK_APIKEY_TTL=$(ACK_APIKEY_TTL)'
	@echo '    ACK_APIKEY_VALUE=$(ACK_APIKEY_VALUE)'
	@echo

_ack_view_framework_targets ::
	@echo 'AppChecK::ApiKey ($(_APPCHECK_APIKEY_MK_VERSION)) targets:'
	@echo '    _ack_create_apikey              - Create a api-key'
	@echo '    _ack_delete_apikey              - Delete a api-key'
	@echo '    _ack_show_apikey                - Show everything related to a api-key'
	@echo '    _ack_validate_apikey            - Validate an api-key'
	@echo '    _ack_view_apikeys               - View api-keys'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ack_create_apikey:
	@$(INFO) '$(ACK_UI_LABEL)Creating api-key "$(ACK_APIKEY_NAME)" ...'; $(NORMAL)
	$(APPCHECK)  -s -X POST $(ACK_APIKEY_API_URL)/key $(|_ACK_CREATE_APIKEY)
	# curl -s -X PUT $(__ACK_DATA__APIKEY) $(__ACK_USER__APIKEY) $(ACK_APIKEY_API_URL)/key $(|_ACK_CREATE_APIKEY)

_ack_delete_apikey:
	@$(INFO) '$(ACK_UI_LABEL)Delete api-key "$(ACK_APIKEY_NAME)" ...'; $(NORMAL)
	# $(APPCHECK) -s -X DELETE $(ACK_APIKEY_API_URL)/key $(|_ACK_DELETE_APIKEY)

_ack_show_apikey: _ack_show_apikey_description

_ack_show_apikey_description:
	@$(INFO) '$(ACK_UI_LABEL)Showing description of api-key "$(ACK_APIKEY_NAME)" ...'; $(NORMAL)

_ack_validate_apikey:
	@$(INFO) '$(ACK_UI_LABEL)Validating api-key "$(ACK_APIKEY_NAME)" ...'; $(NORMAL)
	curl -s -X GET $(__ACK_HEADERS__APIKEY) $(ACK_APIKEY_API_URL)/groups

_ack_view_apikeys:
	@$(INFO) '$(ACK_UI_LABEL)Viewing api-keys ...'; $(NORMAL)
	# $(APPCHECK) -X GET $(ACK_APIKEY_API_URL)/apikeys $(|_ACK_VIEW_APIKEYS)
