_AWS_SECRETSMANAGER_VERSIONSTAGE_MK_VERSION= $(_AWS_SECRETSMANAGER_MK_VERSION)

# SMR_VERSIONSTAGE_NAME?=
# SMR_VERSIONSTAGE_SECRET_ID?=
# SMR_VERSIONSTAGE_SECRET_VERSIONID?=
# SMR_VERSIONSTAGES_SET_NAME?= my-version-stage-sets

# Derived parameters
SMR_VERSIONSTAGE_SECRET_ID?= $(SMR_STAGE_ID)
SMR_VERSIONSTAGE_SECRET_VERSIONID?= $(SMR_STAGE_VERSION_ID)

# Options parameters
__SMR_MOVE_TO_VERSION_ID= $(if $(SMR_VERSIONSTAGE_SECRET_VERSIONID),--move-to-version-id $(SMR_VERSIONSTAGE_SECRET_VERSIONID))
__SMR_REMOVE_FROM_VERSION_ID= $(if $(SMR_VERSIONSTAGE_SECRET_VERSIONID),--remove-from-version-id $(SMR_VERSIONSTAGE_SECRET_VERSIONID))
__SMR_SECRET_ID__VERSIONSTAGE= $(if $(SMR_VERSIONSTAGE_SECRET_ID),--secret-id $(SMR_VERSIONSTAGE_SECRET_ID))
__SMR_VERSION_STAGE= $(if $(SMR_VERSIONSTAGE_NAME),--version-stage $(SMR_VERSIONSTAGE_NAME))

# UI parameters
SMR_UI_VIEW_SECRETS_FIELDS?= .{ARN:ARN,Name:Name,lastAccessedDate:LastAccessedDate,lastChangedDate:LastChangedDate}
SMR_UI_VIEW_SECRETS_SET_FIELDS?= $(SMR_UI_VIEW_SECRETS_FIELDS)
SMR_UI_VIEW_SECRETS_SET_QUERYFILTER?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_smr_view_framework_macros ::
	@echo 'AWS::SecretsManager::VersionStage ($(_AWS_SECRETSMANAGER_VERSIONSTAGE_MK_VERSION)) macros:'
	@echo

_smr_view_framework_parameters ::
	@echo 'AWS::SecretsManager::VersionStage ($(_AWS_SECRETSMANAGER_VERSIONSTAGE_MK_VERSION)) parameters:'
	@echo '    SMR_VERSIONSTAGE_SECRET_ID=$(SMR_VERSIONSTAGE_SECRET_ID)'
	@echo '    SMR_VERSIONSTAGE_NAME=$(SMR_VERSIONSTAGE_NAME)'
	@echo '    SMR_SECRETS_SET_NAME=$(SMR_SECRETS_SET_NAME)'
	@echo

_smr_view_framework_targets ::
	@echo 'AWS::SecretsManager::VersionStage ($(_AWS_SECRETSMANAGER_VERSIONSTAGE_MK_VERSION)) targets:'
	@echo '    _smr_create_versionstage                - Create a version-stage'
	@echo '    _smr_delete_versionstage                - Delete a version-stage'
	@echo '    _smr_show_versionstage                  - Show everything related to a version-stage'
	@echo '    _smr_view_versionstages                 - View version-stages'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_smr_create_versionstage:
	@$(INFO) '$(SMR_UI_LABEL)Creating version-stage "$(SMR_VERSIONSTAGE_NAME)" ...'; $(NORMAL)
	$(AWS) secretsmanager update-secret-version-stage $(__SMR_MOVE_TO_VERSION_ID) $(_X__SMR_REMOVE_FROM_VERSION_ID) $(__SMR_SECRET_ID__VERSIONSTAGE) $(__SMR_VERSION_STAGE)

_smr_delete_versionstage:
	@$(INFO) '$(SMR_UI_LABEL)Deleting version-stage "$(SMR_VERSIONSTAGE_NAME)" ...'; $(NORMAL)
	$(AWS) secretsmanager update-secret-version-stage $(_X__SMR_MOVE_TO_VERSION_ID) $(__SMR_REMOVE_FROM_VERSION_ID) $(__SMR_SECRET_ID__VERSIONSTAGE) $(__SMR_VERSION_STAGE)

_smr_show_versionstage: _smr_show_versionstage_description

_smr_show_versionstage_description:
	@$(INFO) '$(SMR_UI_LABEL)Showing description of version-stage "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	$(AWS) secretsmanager list-secret-version-ids $(__SMR_SECRET_ID__VERSIONSTAGE) --query "Versions[XXX]"

_smr_view_versionstages:
	@$(INFO) '$(SMR_UI_LABEL)Viewing secrets ...'; $(NORMAL)
	$(AWS) secretsmanager list-secrets --query "SecretList[]$(SMR_UI_VIEW_SECRETS_FIELDS)"
	$(AWS) secretsmanager list-secret-version-ids $(__SMR_SECRET_ID__VERSIONSTAGE) --query "Versions[]"

_smr_view_versionstages_set:
	@$(INFO) '$(SMR_UI_LABEL)Viewing version-stages-set "$(SMR_SECRETS_SET_NAME)"  ...'; $(NORMAL)
	# $(AWS) secretsmanager list-secret-version-ids $(__SMR_SECRET_ID__VERSIONSTAGE) --query "Versions[]"
