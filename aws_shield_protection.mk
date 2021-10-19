_AWS_SHIELD_PROTECTION_MK_VERSION= $(_AWS_SHIELD_MK_VERSION)

# SHD_PROTECTION_ID?=
# SHD_PROTECTION_NAME?=
# SHD_PROTECTION_RESOURCE_ARN?=
# SHD_PROTECTIONS_SET_NAME?=

# Derived parameters

# Option parameters
__SHD_PROTECTION_ID= $(if $(SHD_PROTECTION_ID), --protection-id $(SHD_PROTECTION_ID))
__SHD_NAME_PROTECTION= $(if $(SHD_PROTECTION_NAME), --protection-name $(SHD_PROTECTION_NAME))
__SHD_RESOURCE_ARN= $(if $(SHD_PROTECTION_RESOURCE_ARN), --resource-arn $(SHD_PROTECTION_RESOURCE_ARN))

# UI parameters
SHD_UI_VIEW_PROTECTIONS_FIELDS?=
SHD_UI_VIEW_PROTECTIONS_SET_FIELDS?= $(SHD_UI_VIEW_PROTECTIONS_FIELDS)
SHD_UI_VIEW_PROTECTIONS_SET_SLICE?=

#--- Utilities

#--- MACROS

_shd_get_protection_id= $(call _shd_get_protection_id_N, $(SHD_PROTECTION_NAME))
_shd_get_protection_id_N= "$(shell $(AWS) shield list-protections--query "Protections[?Name=='$(strip $(1))'].Id" --output text)"

#----------------------------------------------------------------------
# USAGE
#

_shd_view_framework_macros ::
	@echo 'AWS::SHielD::Protection ($(_AWS_SHIELD_PROTECTION_MK_VERSION)) macros:'
	@echo '    _shd_get_protection_id_{|N|NO}                     - Get the ID of a protection (Name,OrganizationId)'
	@echo

_shd_view_framework_parameters ::
	@echo 'AWS::SHielD::Protection ($(_AWS_SHIELD_PROTECTION_MK_VERSION)) parameters:'
	@echo '    SHD_PROTECTION_ID=$(SHD_PROTECTION_ID)'
	@echo '    SHD_PROTECTION_NAME=$(SHD_PROTECTION_NAME)'
	@echo '    SHD_PROTECTION_RESOURCE_ARN=$(SHD_PROTECTION_RESOURCE_ARN)'
	@echo '    SHD_PROTECTIONS_SET_NAME=$(SHD_PROTECTIONS_SET_NAME)'
	@echo

_shd_view_framework_targets ::
	@echo 'AWS::SHielD::Protection ($(_AWS_SHIELD_PROTECTION_MK_VERSION)) targets:'A
	@echo '    _shd_create_protection                           - Create a new protection'
	@echo '    _shd_delete_protection                           - Delete an existing protection'
	@echo '    _shd_show_protection                             - Show everything related to a protection'
	@echo '    _shd_show_protection_description                 - Show description of a protection'
	@echo '    _shd_view_protections                            - View protections'
	@echo '    _shd_view_protections_set                        - View a set of protections'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_shd_create_protection:
	@$(INFO) '$(AWS_UI_LABEL)Creating protection "$(SHD_PROTECTION_NAME)" ...'; $(NORMAL)
	$(AWS) shield create-protection $(__SHD_NAME_PROTECTION) $(__SHD_RESOURCE_ARN)

_shd_delete_protection:
	@$(INFO) '$(AWS_UI_LABEL)Deleting protection "$(SHD_PROTECTION_NAME)" ...'; $(NORMAL)
	$(AWS) shield delete-protection $(__SHD_PROTECTION_ID)

_shd_show_protection: _shd_show_protection_description

_shd_show_protection_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of protection "$(SHD_PROTECTION_NAME)" ...'; $(NORMAL)
	$(AWS) shield describe-protection $(__SHD_PROTECTION_ID) # --query "Protection"

_shd_view_protections:
	@$(INFO) '$(AWS_UI_LABEL)Viewing protections ...'; $(NORMAL)
	$(AWS) shield list-protections # --query "Streams[]$(SHD_UI_VIEW_PROTECTIONS_FIELDS)"

_shd_view_protections_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing protections-set "$(SHD_PROTECTIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Protections are grouped based on the provided slice'; $(NORMAL)
	$(AWS) shield list-protections # --query "Streams[$(SHD_UI_VIEW_PROTECTIONS_SET_SLICE)]$(SHD_UI_VIEW_PROTECTIONS_SET_FIELDS)"
