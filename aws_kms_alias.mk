_AWS_KMS_KEY_MK_VERSION= $(_AWS_KMS_MK_VERSION)

# KMS_ALIAS_KEY_ID?=
# KMS_ALIAS_NAME?= alias/lti
# KMS_ALIASES_SET_NAME?= my-aliases-set

# Derived parmeters
KMS_ALIAS_KEY_ID?= $(KMS_KEY_ID)

# Options parmeters
__KMS_ALIAS_NAME= $(if $(KMS_ALIAS_NAME),--alias-name $(KMS_ALIAS_NAME))
__KMS_TARGET_KEY_ID= $(if $(KMS_ALIAS_KEY_ID),--target-key-id $(KMS_ALIAS_KEY_ID))

#--- MACRO

_kms_get_alias_key_id= $(call _kms_get_alias_key_id_N, $(KMS_ALIAS_NAME))
_kms_get_alias_key_id_N= $(shell $(AWS) kms list-aliases --query "Aliases[?AliasName=='$(strip $(1))'].TargetKeyId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_kms_view_framework_macros ::
	@echo 'AWS::KMS::Alias ($(_AWS_KMS_ALIAS_MK_VERSION)) macros:'
	@echo '    _kms_get_alias_key_id_{|A}      - Get the key-id referenced by the alias (Alias)'
	@echo

_kms_view_framework_parmeters ::
	@echo 'AWS::KMS::Alias ($(_AWS_kMS_ALIAS_MK_VERSION)) parmeters:'
	@echo '    KMS_ALIAS_KEY_ID=$(KMS_ALIAS_KEY_ID))'
	@echo '    KMS_ALIAS_NAME=$(KMS_ALIAS_NAME))'
	@echo '    KMS_ALIASES_SET_NAME=$(KMS_ALIASES_SET_NAME)'
	@echo

_kms_view_framework_targets ::
	@echo 'AWS::KMS::Alias ($(_AWS_KMS_ALIAS_MK_VERSION)) targets:'
	@echo '    _kms_create_alias            - Create an alias to a KMS key'
	@echo '    _kms_delete_alias            - Delete an alias'
	@echo '    _kms_show_alias              - Show everything related to an alias'
	@echo '    _kms_show_alias_description  - Show the description of an alias'
	@echo '    _kms_update_alias            - Update where an alias is pointing to'
	@echo '    _kms_view_aliases            - View aliases'
	@echo '    _kms_view_aliases_set        - View set of aliases'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kms_create_alias:
	@$(INFO) '$(kMS_UI_LABEL)Aliasing "$(KMS_ALIAS_NAME)" to KMS key "$(KMS_KEY_ID)" ...'; $(NORMAL)
	$(AWS) kms create-alias $(__KMS_ALIAS_NAME) $(__KMS_TARGET_KEY_ID)

_kms_delete_alias:
	@$(INFO) '$(KMS_UI_LABEL)Deleting alias "$(KMS_ALIAS_NAME)" ...'; $(NORMAL)
	$(AWS) kms delete-alias $(__KMS_ALIAS_NAME)

_kms_show_alias :: _kms_show_alias_description

_kms_show_alias_description:
	@$(INFO) '$(KMS_UI_LABEL)Showing dscription of alias "$(KMS_ALIAS_NAME)" ...'; $(NORMAL)

_kms_update_alias:
	@$(INFO) '$(KMS_UI_LABEL)Updating alias "$(KMS_ALIAS_NAME)" ...'; $(NORMAL)
	$(AWS) kms update-alias $(__KMS_DESCRIPTION) $(__KMS_TARGET_KEY_ID)

_kms_view_aliases:
	@$(INFO) '$(KMS_UI_LABEL)Viewing key-aliases ...'; $(NORMAL)
	$(AWS) kms list-aliases

_kms_view_aliases_set:
	@$(INFO) '$(KMS_UI_LABEL)Viewing aliases-set "$(KMS_ALIAS_SET)" ...'; $(NORMAL)
	#$(AWS) kms list-keys
