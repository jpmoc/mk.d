_AWS_DIRECTCONNECT_LAG_MK_VERSION = $(_AWS_DIRECTCONNECT_MK_VERSION)

# DCT_LAG_CONNECTION_ID?=
# DCT_LAG_CONNECTIONS_BANDWIDTH?=
# DCT_LAG_ID?=
# DCT_LAG_LOCATION?=
# DCT_LAG_NAME?=
# DCT_LAG_NUMBEROF_CONNECTIONS?=

# Derived parameters
DCT_LAG_CONNECTION_ID?= $(DCT_CONNECTION_ID)
DCT_LAG_NAMES?= $(DCT_LAG_NAME)

# Option parameters
__DCT_CONNECTION_ID__LAG= $(if $(DCT_LAG_CONNECTION_ID), --connection-id $(DCT_LAG_CONNECTION_ID))
__DCT_CONNECTIONS_BANDWIDTH= $(if $(DCT_LAG_CONNECTIONS_BANDWIDTH), --connections-bandwidth $(DCT_LAG_CONNECTIONS_BANDWIDTH))
__DCT_LAG_NAME= $(if $(DCT_LAG_NAME), --lag-name $(DCT_LAG_NAME))
__DCT_LOCATION= $(if $(DCT_LAG_LOCATION), --location $(DCT_LAG_LOCATION))
__DCT_MINIMUM_LINKS=
__DCT_NUMBER_OF_CONNECTIONS= $(if $(DCT_LAG_NUMBEROF_CONNECTIONS), --number-of-connections $(DCT_LAG_NUMBEROF_CONNECTIONS))

# UI parameters

#--- MACRO
_dct_get_lag_id=

#----------------------------------------------------------------------
# USAGE
#

_dct_view_framework_macros ::
	@echo 'AWS::DirectConnecT::LAG ($(_AWS_DIRECTCONNECT_LAG_MK_VERSION)) macros:'
	@echo '    _dct_get_lag_id_                      - Get the ID of a LAG'
	@echo

_dct_view_framework_parameters ::
	@echo 'AWS::DirectConnecT::LAG ($(_AWS_DIRECTCONNECT_LAG_MK_VERSION)) parameters:'
	@echo '    DCT_LAG_CONNECTION_ID=$(DCT_LAG_CONNECTION_ID)'
	@echo '    DCT_LAG_CONNECTIONS_BANDWIDTH=$(DCT_LAG_CONNECTIONS_BANDWIDTH)'
	@echo '    DCT_LAG_LOCATION=$(DCT_LAG_LOCATION)'
	@echo '    DCT_LAG_NAME=$(DCT_LAG_NAME)'
	@echo '    DCT_LAG_NUMBEROF_CONNECTIONS=$(DCT_LAG_NUMBEROF_CONNECTIONS)'
	@echo

_dct_view_framework_targets ::
	@echo 'AWS::DirectConnecT::LAG ($(_AWS_DIRECTCONNECT_LAG_MK_VERSION)) targets:'
	@echo '    _dct_create_lag                       - Create a lag'
	@echo '    _dct_delete_lag                       - Delete a lag'
	@echo '    _dct_show_lag                         - Show everything related to a lag'
	@echo '    _dct_update_lag                       - Update a lag'
	@echo '    _dct_view_lags                        - View existing lags'
	@echo '    _dct_view_lags_set                    - View a set of lags'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_dct_create_lag:
	@$(INFO) '$(AWS_UI_LABEL)Creating lag "$(DCT_LAG_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect create-lag $(__DCT_CONNECTION_ID__LAG) $(__DCT_CONNECTIONS_BANDWIDTH) $(__DCT_LAG_NAME) $(__DCT_LOCATION) $(__DCT_NUMBER_OF_CONNECTIONS)

_dct_delete_lag:
	@$(INFO) '$(AWS_UI_LABEL)Deleting lag "$(DCT_LAG_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect delete-lag $(__DCT_LAG_ID)

_dct_show_lag:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of lag "$(DCT_LAG_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect describe-lags $(__DCT_LAG_ID)

_dct_update_lag:
	@$(INFO) '$(AWS_UI_LABEL)Updating lag "$(DCT_LAG_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect update-lag $(__DCT_LAG_ID) $(__DCT_LAG_NAME) $(__DCT_MINIMUM_LINKS)

_dct_view_lags:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL lags ...'; $(NORMAL)
	$(AWS) directconnect describe-lags $(__DCT_LAG_ID) 

_dct_view_lags_set:
