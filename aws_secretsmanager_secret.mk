_AWS_SECRETSMANAGER_SECRET_MK_VERSION= $(_AWS_SECRETSMANAGER_MK_VERSION)

# SMR_SECRET_ARN?=
# SMR_SECRET_ARN_OR_NAME?=
# SMR_SECRET_BINARY?=
# SMR_SECRET_BINARY_FILEPATH?= secret-string.json
# SMR_SECRET_DESCRIPTION?= "My test database secret created with the CLI"
# SMR_SECRET_ID?=
# SMR_SECRET_INCLUDEDEPRECATED_FLAG?= true
# SMR_SECRET_KMSKEY_ID?= /aws/secretsmanager
# SMR_SECRET_NAME?=
SMR_SECRET_RECOVERY_WINDOW?= 30
# SMR_SECRET_STRING?=
# SMR_SECRET_STRING_FILEPATH?= secret-string.json
# SMR_SECRET_TAGS?= Key=string,Value=string ...
# SMR_SECRET_VERSION_ID?= 1968bd52-4e2b-4e0a-b67b-f2ae0ad37553
SMR_SECRET_VERSION_STAGE?= AWSCURRENT
# SMR_SECRETS_SET_NAME?= my-secret-sets

# Derived parameters
SMR_SECRET_ARN_OR_NAME?= $(if $(SMR_SECRET_ARN),$(SMR_SECRET_ARN),$(SMR_SECRET_NAME))
SMR_SECRET_BINARY?= $(if $(SMR_SECRET_BINARY_FILEPATH),file://$(SMR_SECRET_BINARY_FILEPATH))
SMR_SECRET_ID?= $(SMR_SECRET_ARN_OR_NAME)
SMR_SECRET_STRING?= $(if $(SMR_SECRET_STRING_FILEPATH),file://$(SMR_SECRET_STRING_FILEPATH))

# Options parameters
__SMR_CLIENT_REQUEST_TOKEN=
__SMR_DESCRIPTION_SECRET= $(if $(SMR_SECRET_DESCRIPTION),--description $(SMR_SECRET_DESCRIPTION))
__SMR_INCLUDE_DEPRECATED= $(if $(filter true, $(SMR_SECRET_INCLUDEDEPRECATED_FLAG)),--include-deprecated, --no-include-deprecated)
__SMR_KMS_KEY_ID= $(if $(SMR_SECRET_KMSKEY_ID),--kms-key-id $(SMR_SECRET_KMSKEY_ID))
__SMR_MOVE_TO_VERSION_ID=
__SMR_NAME_SECRET= $(if $(SMR_SECRET_NAME),--name $(SMR_SECRET_NAME))
__SMR_RECOVERY_WINDOW_IN_DAYS= $(if $(SMR_SECRET_RECOVERY_WINDOW),--recovery-window-in-days $(SMR_SECRET_RECOVERY_WINDOW))
__SMR_REMOVE_FROM_VERSION_ID=
__SMR_ROTATION_LAMBDA_ARN=
__SMR_ROTATION_RULES=
__SMR_SECRET_BINARY= $(if $(SMR_SECRET_BINARY),--secret-binary $(SMR_SECRET_BINARY))
__SMR_SECRET_ID= $(if $(SMR_SECRET_ID),--secret-id $(SMR_SECRET_ID))
__SMR_SECRET_STRING= $(if $(SMR_SECRET_STRING),--secret-string $(SMR_SECRET_STRING))
__SMR_TAG_KEYS_SECRET= $(if $(SMR_SECRET_TAGS_KEYS),--tag-keys $(SMR_SECRET_TAGS_KEYS))
__SMR_TAGS_SECRET= $(if $(SMR_SECRET_TAGS),--tags $(SMR_SECRET_TAGS))
__SMR_VERSION_ID= $(if $(SMR_SECRET_VERSION_ID),--version-id $(SMR_SECRET_VERSION_ID))
__SMR_VERSION_STAGE= $(if $(SMR_SECRET_VERSION_STAGE),--version-stage $(SMR_SECRET_VERSION_STAGE))

# UI parameters
SMR_UI_VIEW_SECRETS_FIELDS?= .{ARN:ARN,Name:Name,lastAccessedDate:LastAccessedDate,lastChangedDate:LastChangedDate}
SMR_UI_VIEW_SECRETS_SET_FIELDS?= $(SMR_UI_VIEW_SECRETS_FIELDS)
SMR_UI_VIEW_SECRETS_SET_QUERYFILTER?=

#--- Utilities

#--- MACROS
_smr_get_secret_arn= $(call _smr_get_secret_arn_N, $(SMR_SECRET_NAME))
_smr_get_secret_arn_N= $(shell $(AWS) secretsmanager describe-secret --secret-id $(1) --query "ARN" --output text)

_smr_get_secret_deletion_date= $(call _smr_get_secret_deletion_date_I, $(SMR_SECRET_ID))
_smr_get_secret_deletion_date_I= $(shell $(AWS) secretsmanager describe-secret  --secret-id $(1) --query "DeletedDate || ''" --output text)

#----------------------------------------------------------------------
# USAGE
#

_smr_view_framework_macros ::
	@echo 'AWS::SecretsManager::Secret ($(_AWS_SECRETSMANAGER_SECRET_MK_VERSION)) macros:'
	@echo '    _smr_get_secret_arn_{|N}              - Get ARN of a secret (Name)'
	@echo '    _smr_get_secret_deletion_date_{|I}    - Get deletion date of a secret (Id)'
	@echo

_smr_view_framework_parameters ::
	@echo 'AWS::SecretsManager::Secret ($(_AWS_SECRETSMANAGER_SECRET_MK_VERSION)) parameters:'
	@echo '    SMR_SECRET_ARN=$(SMR_SECRET_ARN)'
	@echo '    SMR_SECRET_ARN_OR_NAME=$(SMR_SECRET_ARN_OR_NAME)'
	@echo '    SMR_SECRET_BINARY=$(SMR_SECRET_BINARY)'
	@echo '    SMR_SECRET_BINARY_FILEPATH=$(SMR_SECRET_BINARY_FILEPATH)'
	@echo '    SMR_SECRET_DELETION_DATE=$(SMR_SECRET_DELETION_DATE)'
	@echo '    SMR_SECRET_DESCRIPTION=$(SMR_SECRET_DESCRIPTION)'
	@echo '    SMR_SECRET_ID=$(SMR_SECRET_ID)'
	@echo '    SMR_SECRET_INCLUDEDEPRECATED_FLAG=$(SMR_SECRET_INCLUDEDEPRECATED_FLAG)'
	@echo '    SMR_SECRET_KMSKEY_ID=$(SMR_SECRET_KMSKEY_ID)'
	@echo '    SMR_SECRET_NAME=$(SMR_SECRET_NAME)'
	@echo '    SMR_SECRET_RECOVERY_WINDOW=$(SMR_SECRET_RECOVERY_WINDOW)'
	@echo '    SMR_SECRET_STRING=$(SMR_SECRET_STRING)'
	@echo '    SMR_SECRET_STRING_FILEPATH=$(SMR_SECRET_STRING_FILEPATH)'
	@echo '    SMR_SECRET_TAGS=$(SMR_SECRET_TAGS)'
	@echo '    SMR_SECRET_TAGS_KEYS=$(SMR_SECRET_TAGS_KEYS)'
	@echo '    SMR_SECRET_VERSION_ID=$(SMR_SECRET_VERSION_ID)'
	@echo '    SMR_SECRET_VERSION_STAGE=$(SMR_SECRET_VERSION_STAGE)'
	@echo '    SMR_SECRETS_SET_NAME=$(SMR_SECRETS_SET_NAME)'
	@echo

_smr_view_framework_targets ::
	@echo 'AWS::SecretsManager::Secret ($(_AWS_SECRETSMANAGER_SECRET_MK_VERSION)) targets:'
	@echo '    _smr_add_secret_value             - Add a value to the secret'
	@echo '    _smr_cancel_rotate_secret         - Cancel value rotation of the secret'
	@echo '    _smr_create_secret                - Create a secret'
	@echo '    _smr_delete_secret                - Delete a secret'
	@echo '    _smr_restore_secret               - Restore of a secret'
	@echo '    _smr_rotate_secret                - Rotate the value of a secret'
	@echo '    _smr_show_secret                  - Show everything related to a secret'
	@echo '    _smr_show_secret_description      - Show description of a secret'
	@echo '    _smr_show_secret_value            - Show the value of a secret'
	@echo '    _smr_show_secret_versions         - Show versions of a secret'
	@echo '    _smr_tag_secret                   - Tag a secret'
	@echo '    _smr_untag_secret                 - Untag a secret'
	@echo '    _smr_update_secret                - Update a secret'
	@echo '    _smr_view_secrets                 - View secrets'
	@echo '    _smr_view_secrets_set             - View set of secrets'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_smr_add_secret_value:
	@$(INFO) '$(SMR_UI_LABEL)Adding a value to the rotation of secret "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'A new version ID is created, but the stage tags are not moved unless explicitly stated'; $(NORMAL)
	@$(if $(SMR_SECRET_FILEPATH), cat $(SMR_SECRET_FILEPATH))
	$(AWS) secretsmanager put-secret-value $(__SMR_SECRET_BINARY) $(__SMR_SECRET_STRING) $(__SMR_SECRET_ID) $(__SMR_VERSION_STAGES)

_smr_cancel_rorate_secret:
	@$(INFO) '$(SMR_UI_LABEL)Cancel value roration of secret "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	$(AWS) secretsmanager cancel-rotate-secret $(__SMR_SECRET_ID)

_smr_create_secret:
	@$(INFO) '$(SMR_UI_LABEL)Creating secret "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	@$(if $(SMR_STRING_FILEPATH), cat $(SMR_STRING_FILEPATH))
	$(AWS) secretsmanager create-secret $(__SMR_DESCRIPTION_SECRET) $(__SMR_KMS_KEY_ID) $(__SMR_NAME_SECRET) $(__SMR_SECRET_BINARY) $(__SMR_SECRET_STRING) $(__SMR_TAGS_SECRET)

_smr_delete_secret:
	@$(INFO) '$(SMR_UI_LABEL)Scheduling deletion of secret "$(SMR_SECRET_NAME)" in $(SMR_SECRET_RECOVERY_WINDOW) days ...'; $(NORMAL)
	@$(WARN) 'Looking forward, query for this secret will fail unless secret is restored before deletion'; $(NORMAL)
	$(AWS) secretsmanager delete-secret $(__SMR_RECOVERY_WINDOW_IN_DAYS) $(__SMR_SECRET_ID)

_smr_restore_secret:
	@$(INFO) '$(SMR_UI_LABEL)Cancelling scheduled-deletion of secret "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	$(AWS) secretsmanager restore-secret $(__SMR_SECRET_ID)

_smr_rotate_secret:
	@$(INFO) '$(SMR_UI_LABEL)Initiating a rotation of values of secret "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	$(AWS) secretsmanager rotate-secret $(__SMR_CLIENT_REQUEST_TOKEN) $(__SMR_ROTATION_LAMBDA_ARN) $(__SMR_ROTATION_RULES) $(__SMR_SECRET_ID)

_smr_show_secret: _smr_show_secret_resourcepolicy _smr_show_secret_value _smr_show_secret_versions _smr_show_secret_description

_smr_show_secret_description:
	@$(INFO) '$(SMR_UI_LABEL)Showing description of secret "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	@$(if $(SMR_SECRET_DELETION_DATE),$(WARN) 'This secret is scheduled for deletion!'; $(NORMAL))
	$(AWS) secretsmanager describe-secret $(__SMR_SECRET_ID)

_smr_show_secret_resourcepolicy:
	@$(INFO) '$(SMR_UI_LABEL)Showing resource-policy attached to secret "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	$(AWS) secretsmanager get-resource-policy $(__SMR_SECRET_ID)

_smr_show_secret_value:
	@$(INFO) '$(SMR_UI_LABEL)Showing value of secret "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Fetch the current, previous, or a much older value of the secret using its version id'; $(NORMAL)
	$(AWS) secretsmanager get-secret-value $(__SMR_SECRET_ID) $(__SMR_VERSION_ID) $(__SMR_VERSION_STAGE) --query "SecretString" --output text

_smr_show_secret_versions:
	@$(INFO) '$(SMR_UI_LABEL)Showing versions of secret "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns only versions that have at least one staging label in VersionStage attached'; $(NORMAL)
	@$(WARN) 'To return all versions, use the include-deprecated flag'; $(NORMAL)
	$(AWS) secretsmanager list-secret-version-ids $(__SMR_INCLUDE_DEPRECATED) $(__SMR_SECRET_ID)

_smr_tag_secret:
	@$(INFO) '$(SMR_UI_LABEL)Tagging secret "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	$(AWS) secretsmanager tag-resource $(__SMR_SECRET_ID) $(__SMR_TAGS_SECRET)

_smr_untag_secret:
	@$(INFO) '$(SMR_UI_LABEL)Untagging secret "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	$(AWS) secretsmanager untag-resource $(__SMR_SECRET_ID) $(__SMR_TAG_KEYS_SECRET)

_smr_update_secret:
	@$(INFO) '$(SMR_UI_LABEL)Updating secret "$(SMR_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a new version of the secret even if the secret-content is the same'; $(NORMAL)
	@$(if $(SMR_STRING_FILEPATH), cat $(SMR_STRING_FILEPATH))
	$(AWS) secretsmanager update-secret $(__SMR_DESCRIPTION_SECRET) $(__SMR_KMS_KEY_ID) $(__SMR_SECRET_BINARY) $(__SMR_SECRET_ID) $(__SMR_SECRET_STRING)

_smr_view_secrets:
	@$(INFO) '$(SMR_UI_LABEL)Viewing secrets ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT return secrets that are scheduled for deletion'; $(NORMAL)
	$(AWS) secretsmanager list-secrets --query "SecretList[]$(SMR_UI_VIEW_SECRETS_FIELDS)"

_smr_view_secrets_set:
	@$(INFO) '$(SMR_UI_LABEL)Viewing secrets-set "$(SMR_SECRETS_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Secrets are grouped based on the provided query-filter'; $(NORMAL)
	$(AWS) secretsmanager list-secrets --query "SecretList[$(SMR_UI_VIEW_SECRETS_SET_QUERYFILTER)]$(SMR_UI_VIEW_SECRETS_SET_FIELDS)"
