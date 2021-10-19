_AWS_KMS_KEY_MK_VERSION = $(_AWS_KMS_MK_VERSION)

# KMS_KEY_ACCOUNT_ID?=
# KMS_KEY_ARN?= arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab
# KMS_KEY_CREATE_POLICY_NAME?=
KMS_KEY_DELETE_PENDINGWINDOW?= 30
# KMS_KEY_DESCRIPTION?= "my_key"
# KMS_KEY_ID?= 1234abcd-12ab-34cd-56ef-1234567890ab
# KMS_KEY_NAME?= my-key
KMS_KEY_ORIGIN_TYPE?= AWS_KMS
# KMS_KEY_POLICY?=
# KMS_KEY_REGION_ID?= us-west-2
KMS_KEY_SAFETYCHECK_FLAG?= false
# KMS_KEY_TAGS?= TagKey=string,TagValue=string
KMS_KEY_POLICY_NAME?= default
KMS_KEY_USAGE_TYPE?= ENCRYPT_DECRYPT
# KMS_KEYS_SET_NAME?= my-keys-set

# Derived parameters
KMS_KEY_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
KMS_KEY_ARN?= arn:aws:kms:$(KMS_KEY_REGION_ID):$(KMS_KEY_ACCOUNT_ID):key/$(KMS_KEY_ID)
KMS_KEY_DESCRIPTION?= $(KMS_KEY_NAME)
KMS_KEY_NAME?= $(KMS_KEY_ID)
KMS_KEY_REGION_ID?= $(AWS_REGION_ID)

# Options parameters
__KMS_BYPASS_POLICY_LOCKOUT_SAFETY_CHECK= $(if $(filter false, $(KMS_KEY_SAFETYCHECK_FLAG)),--no-bypass-policy-lockout-safety-check, --bypass-policy-lockout-safety-check)
__KMS_DESCRIPTION__KEY= $(if $(KMS_KEY_DESCRIPTION),--description $(KMS_KEY_DESCRIPTION))
__KMS_KEY_ID= $(if $(KMS_KEY_ID),--key-id $(KMS_KEY_ID))
__KMS_KEY_USAGE= $(if $(KMS_KEY_USAGE_TYPE),--key-usage $(KMS_KEY_USAGE_TYPE))
__KMS_ORIGIN= $(if $(KMS_KEY_ORIGIN_TYPE), --origin $(KMS_KEY_ORIGIN_TYPE))
__KMS_PENDING_WINDOW_IN_DAYS= $(if $(KMS_KEY_DELETE_PENDINGWINDOW), --pending-window-in-days $(KMS_KEY_DELETE_PENDINGWINDOW))
__KMS_POLICY_NAME= $(if $(KMS_KEY_POLICY_NAME),--policy-name $(KMS_KEY_POLICY_NAME))
__KMS_POLICY= $(if $(KMS_KEY_CREATE_POLICYNAME),--policy $(KMS_KEY_CREATE_POLICY_NAME))
__KMS_TAGS= $(if $(KMS_KEY_TAGS), --tags $(KMS_KEY_TAGS))

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_kms_view_framework_macros ::
	@echo 'AWS::KMS::Key ($(_AWS_KMS_KEY_MK_VERSION)) macros:'
	@echo

_kms_view_framework_parameters ::
	@echo 'AWS::KMS::Key ($(_AWS_kMS_KEY_MK_VERSION)) parameters:'
	@echo '    KMS_KEY_ACCOUNT_ID=$(KMS_KEY_ACCOUNT_ID)'
	@echo '    KMS_KEY_ARN=$(KMS_KEY_ARN)'
	@echo '    KMS_KEY_CREATE_POLICYNAME=$(KMS_KEY_CREATE_POLICYNAME)'
	@echo '    KMS_KEY_DELETE_PENDINGWINDOW=$(KMS_KEY_DELETE_PENDINGWINDOW)'
	@echo '    KMS_KEY_DESCRIPTION=$(KMS_KEY_DESCRIPTION)'
	@echo '    KMS_KEY_ID=$(KMS_KEY_ID)'
	@echo '    KMS_KEY_NAME=$(KMS_KEY_NAME)'
	@echo '    KMS_KEY_ORIGIN_TYPE=$(KMS_KEY_ORIGIN_TYPE)'
	@echo '    KMS_KEY_POLICY_NAME=$(KMS_KEY_POLICY_NAME)'
	@echo '    KMS_KEY_REGION_ID=$(KMS_KEY_REGION_ID)'
	@echo '    KMS_KEY_TAGS=$(KMS_KEY_TAGS)'
	@echo '    KMS_KEY_USAGE_TYPE=$(KMS_KEY_USAGE_TYPE)'
	@echo '    KMS_KEYS_SET_NAME=$(KMS_KEYS_SET_NAME)'
	@echo

_kms_view_framework_targets ::
	@echo 'AWS::KMS::Key ($(_AWS_KMS_KEY_MK_VERSION)) targets:'
	@echo '    _kms_create_key                    - Create a key'
	@echo '    _kms_delete_key                    - Delete a Customer Master Key (CMK)'
	@echo '    _kms_disable_key                   - Disable an existing key from being used'
	@echo '    _kms_disable_key_rotation          - Disable the rotation of a given key'
	@echo '    _kms_enable_key                    - Enable a disabled key to be used'
	@echo '    _kms_enable_key_rotation           - Enable the rotation of a given key'
	@echo '    _kms_show_key                      - Show everything related to a key'
	@echo '    _kms_show_key_description          - Show the description of a key'
	@echo '    _kms_show_key_policies             - Show the IAM policies attached to a key'
	@echo '    _kms_show_key_policy               - Show the IAM policy attached to a key'
	@echo '    _kms_show_key_rotationstatus       - Show key-rotation status for a given key'
	@echo '    _kms_show_key_tags                 - Show tags of a key'
	@echo '    _kms_update_key                    - Update a key'
	@echo '    _kms_view_keys                     - View keys'
	@echo '    _kms_view_keys_set                 - View a set of keys'
	@echo

#----------------------------------------------------------------------

_kms_create_key:
	@$(INFO) '$(KMS_UI_LABEL)Creating KMS key "$(KMS_KEY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This opeation attach a defult policy to the key if none are provided'; $(NORMAL)
	$(AWS) kms create-key $(__KMS_BYPASS_POLICY_LOCKOUT_SAFETY_CHECK) $(__KMS_DESCRIPTION__KEY) $(__KMS_KEY_USAGE) $(__KMS_ORIGIN) $(__KMS_POLICY) $(__KMS_TAGS) --query "KeyMetadata"

_kms_delete_key:
	@$(INFO) '$(KMS_UI_LABEL)Scheduling deletion of KMS key "$(KMS_KEY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'THis operation fails if the key is already scheduled for deletion'
	@$(WARN) 'Once a key is deleted, you can no longer decrypt the data that was encrypted under that key'
	@$(WARN) 'Consider disabling instead of deleting a master key'
	@$(WARN) 'This operation can only be cancelled during the $(KMS_KEY_DELETE_PENDINGWINDOW)-day pending window'; $(NORMAL)
	@read -p 'You are about to delete $(KMS_KEY_ID). Are you sure you want to proceed? (ctrl-C to break)' yesNo
	-$(AWS) kms schedule-key-deletion $(__KMS_KEY_ID) $(__KMS_PENDING_WINDOW_IN_DAYS)

_kms_disable_key:
	@$(INFO) '$(KMS_UI_LABEL)Disabling key "$(KMS_KEY_NAME)" ...'; $(NORMAL)
	$(AWS) kms disable-key $(__KMS_KEY_ID)

_kms_disable_key_rotation:
	@$(INFO) '$(KMS_UI_LABEL)Disabling key-rotation for key "$(KMS_KEY_NAME)" ...'; $(NORMAL)
	$(AWS) kms disable-key-rotation $(__KMS_KEY_ID)

_kms_enable_key_rotation:
	@$(INFO) '$(KMS_UI_LABEL)Enabling key-rotation for key "$(KMS_KEY_NAME)" ...'; $(NORMAL)
	$(AWS) kms enable-key-rotation $(__KMS_KEY_ID)

_kms_show_key :: _kms_show_key_policies _kms_show_key_policy _kms_show_key_rotationstatus _kms_show_key_description

_kms_show_key_description:
	@$(INFO) '$(KMS_UI_LABEL)Showing description of key "$(KMS_KEY_NAME)" ...'; $(NORMAL)
	$(AWS) kms describe-key $(__KMS_KEY_ID) --query "KeyMetadata"

_kms_show_key_policies:
	@$(INFO) '$(KMS_UI_LABEL)Showing policies of key "$(KMS_KEY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation should always only return a "default" policy'; $(NORMAL)
	$(AWS) kms list-key-policies $(__KMS_KEY_ID) --query "PolicyNames"

_kms_show_key_policy:
	@$(INFO) '$(KMS_UI_LABEL)Showing policy "$(KMS_KEY_POLICY_NAME)" of key "$(KMS_KEY_NAME)" ...'; $(NORMAL)
	$(AWS) kms get-key-policy $(__KMS_KEY_ID) $(__KMS_POLICY_NAME) --output text

_kms_show_key_rotationstatus:
	@$(INFO) '$(KMS_UI_LABEL)Showing key-rotation status of key "$(KMS_KEY_NAME)" ...'; $(NORMAL)
	$(AWS) kms get-key-rotation-status $(__KMS_KEY_ID)

_kms_show_key_tags:
	@$(INFO) '$(KMS_UI_LABEL)Showing tags of key "$(KMS_KEY_NAME)" ...'; $(NORMAL)
	$(AWS) kms list-resource-tags $(__KMS_KEY_ID)

_kms_undelete_key:
	@$(INFO) '$(KMS_UI_LABEL)Cancelling deletion of key "$(KMS_KEY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is only possible during the pending window'; $(NORMAL)
	@$(WARN) 'Keys which have been already deleted cannot be recovered'; $(NORMAL)
	@$(WARN) 'If the pending window has expired, data encrypted with a deleted key is unrecoverable'; $(NORMAL)
	$(AWS) kms cancel-key-deletion $(__KMS_KEY_ID)

_kms_update_key:
	@$(INFO) '$(KMS_UI_LABEL)Updating key "$(KMS_KEY_ID)" ...'; $(NORMAL)
	$(AWS) kms update-key-description $(__KMS_DESCRIPTION__KEY) $(__KMS_KEY_ID)

_kms_view_keys:
	@$(INFO) '$(KMS_UI_LABEL)Viewing keys ...'; $(NORMAL)
	@$(WARN) 'This operations returns active and to-be-deleted keys'; $(NORMAL)
	$(AWS) kms list-keys --query "Keys"

_kms_view_keys_set:
	@$(INFO) '$(KMS_UI_LABEL)Viewing keys-set "$(KMS_KEYS_SET_NAME)" ...'; $(NORMAL)
	# $(AWS) kms list-keys
