_AWS_DIRECTCONNECT_CONNECTION_MK_VERSION = $(_AWS_DIRECTCONNECT_MK_VERSION)

# DCT_CONNECTION_BANDWIDTH?= 1Gbps
# DCT_CONNECTION_ID?= dxcon-fh7u7if4
# DCT_CONNECTION_LOCATION?= SNAP
# DCT_CONNECTION_NAME?=
# DCT_CONNECTIONS_SET_NAME?= my-connections-set

# Derived parameters
DCT_CONNECTION_NAMES?= $(DCT_CONNECTION_NAME)

# Option parameters
__DCT_BANDWIDTH= $(if $(DCT_CONNECTION_BANDWIDTH), --bandwidth $(DCT_CONNECTION_BANDWIDTH))
__DCT_CONNECTION_ID= $(if $(DCT_CONNECTION_ID), --connection-id $(DCT_CONNECTION_ID))
__DCT_CONNECTION_NAME= $(if $(DCT_CONNECTION_NAME), --connection-name $(DCT_CONNECTION_NAME))
__DCT_LAG_ID= $(if $(DCT_CONNECTION_LAG_ID), --lab-id $(DCT_CONNECTION_LAG_ID))
__DCT_LOCATION= $(if $(DCT_CONNECTION_LOCATION), --location $(DCT_CONNECTION_LOCATION))

# UI parameters
DCT_UI_VIEW_CONNECTIONS_FIELDS?= .{ConnectionId:connectionId,ConnectionName:connectionName,awsDevice:awsDevice,bandwidth:bandwidth,connectionState:connectionState,location:location}
DCT_UI_VIEW_CONNECTIONS_SET_FIELDS?= $(DCT_UI_VIEW_CONNECTIONS_FIELDS)
DCT_UI_VIEW_CONNECTIONS_SET_SLICE?=

#--- MACRO
_dct_get_connection_id= $(call _dct_get_connection_id_N, $(DCT_CONNECTION_NAME))
_dct_get_connection_id_N= $(shell $(AWS) directconnect describe-connections  --query "connections[?connectionName=='$(strip $(1))'].connectionId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_dct_view_framework_macros ::
	@echo 'AWS::DirectConnecT::Connection ($(_AWS_DIRECTCONNECT_CONNECTION_MK_VERSION)) macros:'
	@echo '    _dct_get_connection_id_{|N}                   - Get the ID of a connection (Name)'
	@echo

_dct_view_framework_parameters ::
	@echo 'AWS::DirectConnecT::Connection ($(_AWS_DIRECTCONNECT_CONNECTION_MK_VERSION)) parameters:'
	@echo '    DCT_CONNECTION_BANDWIDTH=$(DCT_CONNECTION_BANDWIDTH)'
	@echo '    DCT_CONNECTION_ID=$(DCT_CONNECTION_ID)'
	@echo '    DCT_CONNECTION_LOCATION=$(DCT_CONNECTION_LOCATION)'
	@echo '    DCT_CONNECTION_NAME=$(DCT_CONNECTION_NAME)'
	@echo '    DCT_CONNECTIONS_SET_NAME=$(DCT_CONNECTIONS_SET_NAME)'
	@echo

_dct_view_framework_targets ::
	@echo 'AWS::DirectConnecT::Connection ($(_AWS_DIRECTCONNECT_CONNECTION_MK_VERSION)) targets:'
	@echo '    _dct_create_connection                       - Create a connection'
	@echo '    _dct_delete_connection                       - Delete a connection'
	@echo '    _dct_show_connection                         - Show everything related to a connection'
	@echo '    _dct_view_connections                        - View existing connections'
	@echo '    _dct_view_connections_set                    - View a set of connections'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_dct_create_connection:
	@$(INFO) '$(AWS_UI_LABEL)Creating connection "$(DCT_CONNECTION_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect create-connection $(__DCT_BANDWIDTH) $(__DCT_CONNECTION_NAME) $(__DCT_LOCATION)

_dct_delete_connection:
	@$(INFO) '$(AWS_UI_LABEL)Deleting connection "$(DCT_CONNECTION_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect delete-connection $(__DCT_CONNECTION_ID)

_dct_show_connection:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of connection "$(DCT_CONNECTION_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect describe-connections $(__DCT_CONNECTION_ID) --query "connections[]"

_dct_view_connections:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL connections ...'; $(NORMAL)
	$(AWS) directconnect describe-connections $(_X__DCT_CONNECTION_ID) --query "connections[]$(DCT_UI_VIEW_CONNECTIONS_FIELDS)"

_dct_view_connections_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing connections-set "$(DCT_CONNECTIONS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect describe-connections $(_X__DCT_CONNECTION_ID) --query "connections[$(DCT_UI_VIEW_CONNECTIONS_SET_SLICE)]$(DCT_UI_VIEW_CONNECTIONS_FIELDS)"

