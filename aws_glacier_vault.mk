_AWS_GLACIER_VAULT_MK_VERSION=$(_AWS_GLACIER_MK_VERSION)

# GCR_JOB_COMPLETED= true
# GCR_JOB_STATUSCODE?= InProgress
# GCR_VAULT_ARN?= arn:aws:glacier:us-east-1:123456789012:vaults/my-vault
# GCR_VAULT_NAME?= my-vault
# GCR_VAULT_TAGS?= KeyName1=string,KeyName2=string,...
# GCR_VAULT_TAGKEYS?= KeyName1 KeyName2 ...

# Derived variables
GCR_VAULT_ARN?= $(if $(GCR_VAULT_NAME),arn:aws:glacier:$(AWS_REGION):$(AWS_ACCOUNT_ID):vaults/$(GCR_VAULT_NAME))

# Options variables
__GCR_COMPLETED= $(if $(GCR_JOB_COMPLETED), --completed $(GCR_JOB_COMPLETED))
__GCR_STATUSCODE= $(if $(GCR_JOB_STATUSCODE), --statuscode $(GCR_JOB_STATUSCODE))
__GCR_TAG_KEYS= $(if $(GCR_VAULT_TAGKEYS), --tag-keys $(GCR_VAULT_TAGKEYS))
__GCR_TAGS_VAULT= $(if $(GCR_VAULT_TAGS), --tags $(GCR_VAULT_TAGS))
__GCR_VAULT_NAME= $(if $(GCR_VAULT_NAME), --vault-name $(GCR_VAULT_NAME))

# UI variables
GCR_UI_SHOW_VAULT_JOBS_FIELDS?=
GCR_UI_VIEW_VAULTS_FIELDS?=


#--- Utilities

#--- MACROS
_gcr_get_vault_arn= $(call _gcr_get_vault_arn_N, $(GCR_VAULT_NAME))
_gcr_get_vault_arn_N= $(call _gcr_get_vault_arn_NA, $(1), $(AWS_ACCOUNT_ID))
_gcr_get_vault_arn_NA=$(shell $(AWS)  glacier describe-vault  --account-id $(2)  --vault-name $(1) --query "VaultARN" --output text)

#----------------------------------------------------------------------
# USAGE
#

_gcr_view_makefile_macros ::
	@echo 'AWS::GlaCieR::Vault ($(_AWS_GLACIER_VAULT_MK_VERSION)) macros:'
	@echo '    _gcr_get_vault_arn_{|N|NA}    - Get the ARN of a vault (Name,AccountId)'
	@echo

_gcr_view_makefile_targets ::
	@echo 'AWS::GlaCieR::Vault ($(_AWS_GLACIER_VAULT_MK_VERSION)) targets:'
	@echo '    _gcr_create_vault             - Create a vault'
	@echo '    _gcr_delete_vault             - Delete a vault'
	@echo '    _gcr_show_vault               - Show details of a vault'
	@echo '    _gcr_tag_vault                - Tag vault'
	@echo '    _gcr_view_vaults              - View all available vaults'
	@echo 

_gcr_view_makefile_variables ::
	@echo 'AWS::GlaCieR::Vault ($(_AWS_GLACIER_VAULT_MK_VERSION)) variables:'
	@echo '    GCR_JOB_COMPLETED=$(GCR_JOB_COMPLETED)'
	@echo '    GCR_JOB_STATUSCODE=$(GCR_JOB_STATUSCODE)'
	@echo '    GCR_VAULT_ARN=$(GCR_VAULT_ARN)'
	@echo '    GCR_VAULT_NAME=$(GCR_VAULT_NAME)'
	@echo '    GCR_VAULT_TAGKEYS=$(GCR_VAULT_TAGKEYS)'
	@echo '    GCR_VAULT_TAGS=$(GCR_VAULT_TAGS)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gcr_create_vault:
	@$(INFO) '$(AWS_UI_LABEL)Creating vault "$(GCR_VAULT_NAME)" ...'; $(NORMAL)
	$(AWS) glacier create-vault $(__GCR_ACCOUNT_ID) $(__GCR_VAULT_NAME)

_gcr_delete_vault:
	@$(INFO) '$(AWS_UI_LABEL)Deleting vault "$(GCR_VAULT_NAME)" ...'; $(NORMAL)
	$(AWS) glacier delete-vault $(__GCR_ACCOUNT_ID) $(__GCR_VAULT_NAME)

_gcr_show_vault: _gcr_show_vault_accesspolicy _gcr_show_vault_jobs _gcr_show_vault_lock _gcr_show_vault_notifications _gcr_show_vault_tags _gcr_show_vault_summary

_gcr_show_vault_accesspolicy:
	@$(INFO) '$(AWS_UI_LABEL)Showing access-policy of vault "$(GCR_VAULT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no access policy on this vault has been set'; $(NORMAL)
	-$(AWS) glacier get-vault-access-policy $(__GCR_ACCOUNT_ID) $(__GCR_VAULT_NAME)

_gcr_show_vault_jobs:
	@$(INFO) '$(AWS_UI_LABEL)Showing jobs of vault "$(GCR_VAULT_NAME)" ...'; $(NORMAL)
	-$(AWS) glacier list-jobs $(__GCR_ACCOUNT_ID) $(__GCR_COMPLETED) $(__GCR_STATUSCODE) $(__GCR_VAULT_NAME)

_gcr_show_vault_lock:
	@$(INFO) '$(AWS_UI_LABEL)Showing lock of vault "$(GCR_VAULT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no lock on this vault has been set'; $(NORMAL)
	-$(AWS) glacier get-vault-lock $(__GCR_ACCOUNT_ID) $(__GCR_VAULT_NAME)

_gcr_show_vault_notifications:
	@$(INFO) '$(AWS_UI_LABEL)Showing notifications of vault "$(GCR_VAULT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no notification on this vault has been set'; $(NORMAL)
	-$(AWS) glacier get-vault-notifications $(__GCR_ACCOUNT_ID) $(__GCR_VAULT_NAME)

_gcr_show_vault_summary:
	@$(INFO) '$(AWS_UI_LABEL)Showing summary of vault "$(GCR_VAULT_NAME)" ...'; $(NORMAL)
	$(AWS) glacier describe-vault $(__GCR_ACCOUNT_ID) $(__GCR_VAULT_NAME)

_gcr_show_vault_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of vault "$(GCR_VAULT_NAME)" ...'; $(NORMAL)
	$(AWS) glacier list-tags-for-vault $(__GCR_ACCOUNT_ID) $(__GCR_VAULT_NAME)

_gcr_tag_vault:
	@$(INFO) '$(AWS_UI_LABEL)Tagging vault "$(GCR_VAULT_NAME)" ...'; $(NORMAL)
	$(AWS) glacier add-tags-to-vault $(__GCR_ACCOUNT_ID) $(__GCR_TAGS_VAULT) $(__GCR_VAULT_NAME)

_gcr_untag_vault:
	@$(INFO) '$(AWS_UI_LABEL)Removing tags from vault "$(GCR_VAULT_NAME)" ...'; $(NORMAL)
	$(AWS) glacier remove-tags-from-vault $(__GCR_ACCOUNT_ID) $(__GCR_TAG_KEYS) $(__GCR_VAULT_NAME)

_gcr_view_vaults:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all existing vaults ...'; $(NORMAL)
	$(AWS) glacier list-vaults $(__GCR_ACCOUNT_ID)  --query "VaultList[]$(GCR_UI_VIEW_VAULTS_FIELDS)"
