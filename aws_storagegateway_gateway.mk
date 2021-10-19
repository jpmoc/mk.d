_AWS_STORAGEGATEWAY_GATEWAY_MK_VERSION= $(_AWS_STORAGEGATEWAY_MK_VERSION)

# SGY_GATEWAY_ACTIVATION_KEY?=
# SGY_GATEWAY_ARN?=
# SGY_GATEWAY_MEDIUMCHANGER_TYPE?=
# SGY_GATEWAY_NAME?=
# SGY_GATEWAY_TAPEDRIVE_TYPE?=
# SGY_GATEWAY_TIMEZONE?=
# SGY_GATEWAYS_SET_NAME?=

# Derived parameters
SGY_GATEWAYS_NAMES?= $(SGY_GATEWAY_NAME)

# Option parameters
__SGY_ACTIVATION_KEY= $(if $(SGY_GATEWAY_ACTIVATION_KEY), --activation-key-arn $(SGY_GATEWAY_ACTIVATION_KEY))
__SGY_GATEWAY_ARN= $(if $(SGY_GATEWAY_ARN), --gateway-arn $(SGY_GATEWAY_ARN))
__SGY_GATEWAY_NAME= $(if $(SGY_GATEWAY_NAME), --gateway-name $(SGY_GATEWAY_NAME))
__SGY_GATEWAY_TIMEZONE= $(if $(SGY_GATEWAY_TIMEZONE), --gateway-timezone $(SGY_GATEWAY_TIMEZONE))
__SGY_MEDIUM_CHANGER_TYPE= $(if $(SGY_GATEWAY_MEDIUMCHANGER_TYPE), --medium-changer-type $(SGY_GATEWAY_MEDIUMCHANGER_TYPE))
__SGY_TAPE_DRIVE_TYPE= $(if $(SGY_GATEWAY_TAPEDRIVE_TYPE), --tape-drive-type $(SGY_GATEWAY_TAPEDRIVE_TYPE))

# UI parameters
SGY_UI_VIEW_GATEWAYS_FIELDS?=
SGY_UI_VIEW_GATEWAYS_SET_FIELDS?= $(SGY_UI_VIEW_GATEWAYS_FIELDS)
SGY_UI_VIEW_GATEWAYS_SET_SLICE?=

#--- Utilities

#--- MACROS

_sgy_get_gateway_arn= $(call _sgy_get_gateway_arn_N, $(SGY_GATEWAY_NAME))
_sgy_get_gateway_arn_N= "$(shell $(AWS) storagegateway list-gateways --query "Users[?Name=='$(strip $(1))'].Id" --output text)"

#----------------------------------------------------------------------
# USAGE
#

_sgy_view_framework_macros ::
	@echo 'AWS::StorageGatewaY::Gateway ($(_AWS_STORAGEGATEWAY_GATEWAY_MK_VERSION)) macros:'
	@echo '    _sgy_get_gateway_id_{|N|NO}                     - Get the ID of a gateway (Name,OrganizationId)'
	@echo

_sgy_view_framework_parameters ::
	@echo 'AWS::StorageGatewaY::Gateway ($(_AWS_STORAGEGATEWAY_GATEWAY_MK_VERSION)) parameters:'
	@echo '    SGY_GATEWAY_ACTIVATION_KEY=$(SGY_GATEWAY_ACTIVATION_KEY)'
	@echo '    SGY_GATEWAY_ARN=$(SGY_GATEWAY_ARN)'
	@echo '    SGY_GATEWAY_MEDIUMCHANGER_TYPE=$(SGY_GATEWAY_MEDIUMCHANGER_TYPE)'
	@echo '    SGY_GATEWAY_NAME=$(SGY_GATEWAY_NAME)'
	@echo '    SGY_GATEWAY_TAPEDRIVE_TYPE=$(SGY_GATEWAY_TAPEDRIVE_TYPE)'
	@echo '    SGY_GATEWAY_TIMEZONE=$(SGY_GATEWAY_TIMEZONE)'
	@echo '    SGY_GATEWAYS_SET_NAME=$(SGY_GATEWAYS_SET_NAME)'
	@echo

_sgy_view_framework_targets ::
	@echo 'AWS::StorageGatewaY::Gateway ($(_AWS_STORAGEGATEWAY_GATEWAY_MK_VERSION)) targets:'A
	@echo '    _sgy_create_gateway                           - Create a new gateway'
	@echo '    _sgy_delete_gateway                           - Delete an existing gateway'
	@echo '    _sgy_show_gateway                             - Show everything related to a gateway'
	@echo '    _sgy_show_gateway_description                 - Show description of a gateway'
	@echo '    _sgy_shutdown_gateway                         - Shutdown a gateway'
	@echo '    _sgy_start_gateway                            - Start a gateway'
	@echo '    _sgy_update_gateway_description               - Update the description of a gateway'
	@echo '    _sgy_view_gateways                            - View gateways'
	@echo '    _sgy_view_gateways_set                        - View a set of gateways'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sgy_create_gateway:
	@$(INFO) '$(AWS_UI_LABEL)Creating gateway "$(SGY_GATEWAY_NAME)" ...'; $(NORMAL)
	$(AWS) storagegateway activate-gateway $(__SGY_ACTIVATION_KEY) $(__SGY_GATEWAY_NAME) $(__SGY_GATEWAY_REGION) $(__SGY_GATEWAY_TIMEZONE) $(__SGY_GATEWAY_TYPE) $(__SGY_MEDIUM_CHANGER_TYPE) $(__SGY_TAPE_DRIVE_TYPE)

_sgy_delete_gateway:
	@$(INFO) '$(AWS_UI_LABEL)Deleting gateway "$(SGY_GATEWAY_NAME)" ...'; $(NORMAL)
	$(AWS) storagegateway delete-gateway $(__SGY_GATEWAY_ARN)

_sgy_show_gateway: _sgy_show_gateway_description

_sgy_show_gateway_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of gateway "$(SGY_GATEWAY_NAME)" ...'; $(NORMAL)
	$(AWS) storagegateway describe-gateway-information $(__SGY_GATEWAY_ARN) # --query "Gateway"

_sgy_start_gateway:
	@$(INFO) '$(AWS_UI_LABEL)Starting gateway "$(SGY_GATEWAY_NAME)" ...'; $(NORMAL)
	$(AWS) storagegateway start-gateway $(__SGY_GATEWAY_ARN)

_sgy_shutdown_gateway:
	@$(INFO) '$(AWS_UI_LABEL)Shutting down gateway "$(SGY_GATEWAY_NAME)" ...'; $(NORMAL)
	$(AWS) storagegateway shutdown-gateway $(__SGY_GATEWAY_ARN)

_sgy_update_gateway_description:
	@$(INFO) '$(AWS_UI_LABEL)Updating gateway "$(SGY_GATEWAY_NAME)" ...'; $(NORMAL)
	$(AWS) storagegateway update-gateway-information $(__SGY_GATEWAY_ARN) $(__SGY_GATEWAY_NAME) $(__SGY_GATEWAY_TIMEZONE)

_sgy_view_gateways:
	@$(INFO) '$(AWS_UI_LABEL)Viewing gateways ...'; $(NORMAL)
	$(AWS) storagegateway list-gateways # --query "Gateways[]$(SGY_UI_VIEW_GATEWAYS_FIELDS)"

_sgy_view_gateways_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing gateways-set "$(SGY_GATEWAYS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Protections are grouped based on the provided slice'; $(NORMAL)
	$(AWS) storagegateway list-gateways # --query "Gateways[$(SGY_UI_VIEW_GATEWAYS_SET_SLICE)]$(SGY_UI_VIEW_GATEWAYS_SET_FIELDS)"
