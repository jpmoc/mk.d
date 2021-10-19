_APPCHECK_GROUP_MK_VERSION= $(_APPCHECK_MK_VERSION)

# ACK_GROUP_API_URL?= https://appcheck.eng.vmware.com/api
# ACK_GROUP_ENDPOINT_URL?= https://appcheck.eng.vmware.com/group/
# ACK_GROUP_DESCRIPTION?= 'This is my group'
# ACK_GROUP_ID?= 4
# ACK_GROUP_NAME?= NSBU

# Derived parameters
ACK_GROUP_API_URL?= $(ACK_API_URL)
ACK_GROUP_ENDPOINT_URL?= $(ACK_ENDPOINT_URL)/group
ACK_GROUP_REPORT_URL?= $(ACK_GROUP_ENDPOINT_URL)/$(ACK_GROUP_ID)/

# Option parameters
__ACK_HEADERS__GROUP+= $(if $(ACK_GROUP_DESCRIPTION),--header 'Desription: $(ACK_GROUP_DESCRIPTION)')
__ACK_HEADERS__GROUP+= $(if $(ACK_GROUP_NAME),--header 'Name: $(ACK_GROUP_NAME)')

# Pipe parameters
|_ACK_CREATE_GROUP?=
|_ACK_SHOW_GROUP_USERS?= | jq '.'
|_ACK_VIEW_GROUPS?= | jq '.'

# UI parameters
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ack_view_framework_macros ::
	@echo 'AppChecK::Group ($(_APPCHECK_GROUP_MK_VERSION)) macros:'
	@echo

_ack_view_framework_parameters ::
	@echo 'AppChecK::Group ($(_APPCHECK_GROUP_MK_VERSION)) parameters:'
	@echo '    ACK_GROUP_API_URL=$(ACK_GROUP_API_URL)'
	@echo '    ACK_GROUP_DESCRIPTION=$(ACK_GROUP_DESCRIPTION)'
	@echo '    ACK_GROUP_ENDPOINT_URL=$(ACK_GROUP_ENDPOINT_URL)'
	@echo '    ACK_GROUP_ID=$(ACK_GROUP_ID)'
	@echo '    ACK_GROUP_NAME=$(ACK_GROUP_NAME)'
	@echo '    ACK_GROUP_REPORT_URL=$(ACK_GROUP_REPORT_URL)'
	@echo

_ack_view_framework_targets ::
	@echo 'AppChecK::Group ($(_APPCHECK_GROUP_MK_VERSION)) targets:'
	@echo '    _ack_create_group              - Create a group'
	@echo '    _ack_delete_group              - Delete a group'
	@echo '    _ack_show_group                - Show everything related to a group'
	@echo '    _ack_show_group_audit          - Show audit of a group'
	@echo '    _ack_show_group_description    - Show description of a group'
	@echo '    _ack_show_group_users          - Show users of a group'
	@echo '    _ack_view_groups               - View groups'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ack_create_group:
	@$(INFO) '$(ACK_UI_LABEL)Creating group "$(ACK_GROUP_NAME)" ...'; $(NORMAL)
	$(APPCHECK) -s -X POST $(__ACK_HEADERS__GROUP) $(ACK_GROUP_API_URL)/groups $(|_ACK_CREATE_GROUP)

_ack_delete_group:
	@$(INFO) '$(ACK_UI_LABEL)Delete group "$(ACK_GROUP_NAME)" ...'; $(NORMAL)
	# $(APPCHECK) -s -X DELETE $(ACK_GROUP_API_URL)/groups/$(ACK_GROUP_ID) $(|_ACK_DELETE_GROUP)

_ack_show_group: _ack_show_group_audit _ack_show_group_users _ack_show_group_description

_ack_show_group_audit:
	@$(INFO) '$(ACK_UI_LABEL)Showing audit of group "$(ACK_GROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the credentials are not ...'; $(NORMAL)
	-$(APPCHECK) -s -X GET $(ACK_GROUP_API_URL)/audit/$(ACK_GROUP_ID)/csv $(|_ACK_SHOW_GROUP_AUDIT)
	@echo

_ack_show_group_description:
	@$(INFO) '$(ACK_UI_LABEL)Showing description of group "$(ACK_GROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Web UI @ $(ACK_GROUP_REPORT_URL)'; $(NORMAL)

_ack_show_group_users:
	@$(INFO) '$(ACK_UI_LABEL)Showing users of group "$(ACK_GROUP_NAME)" ...'; $(NORMAL)
	$(APPCHECK) -s -X GET $(ACK_GROUP_API_URL)/groups/$(ACK_GROUP_ID)/users $(|_ACK_SHOW_GROUP_USERS)

_ack_view_groups:
	@$(INFO) '$(ACK_UI_LABEL)Viewing groups ...'; $(NORMAL)
	$(APPCHECK) -X GET $(ACK_GROUP_API_URL)/groups $(|_ACK_VIEW_GROUPS)
