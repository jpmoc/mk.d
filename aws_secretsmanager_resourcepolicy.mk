_AWS_SECRETSMANAGER_RESOURCEPOLICY_MK_VERSION= $(_AWS_SECRETSMANAGER_MK_VERSION)

# SMR_RESOURCEPOLICY_DIRNAME?= ./.in/
# SMR_RESOURCEPOLICY_FILENAME?= resource-policy.json
# SMR_RESOURCEPOLICY_FILEPATH?= ./in/resource-policy.json
# SMR_RESOURCEPOLICY_SECRET_ID?=
# SMR_RESOURCEPOLICIES_SET_NAME?= my-resource-policies-sets

# Derived parameters
SMR_RESOURCEPOLICY_DIRPATH?= $(SMR_INPUTS_DIRPATH)
SMR_RESOURCEPOLICY_FILEPATH?= $(SMR_RESOURCEPOLICY_DIRPATH)$(SMR_RESOURCEPOLICY_FILENAME)
SMR_RESOURCEPOLICY_SECRET_ID?= $(SMR_SECRET_ID)

# Options parameters
__SMR_RESOURCE_POLICY= $(if $(SMR_RESOURCEPOLICY_FILEPATH),--resource-policy $(SMR_RESOURCEPOLICY_FILEPATH))
__SMR_SECRET_ID__RESOURCEPOLICY= $(if $(SMR_SECRET_ID),--secret-id $(SMR_SECRET_ID))

# UI parameters
SMR_UI_VIEW_RESOURCEPOLICIES_FIELDS?=
SMR_UI_VIEW_RESOURCEPOLICIES_SET_FIELDS?= $(SMR_UI_VIEW_RESOURCEPOLICIES_FIELDS)
SMR_UI_VIEW_RESOURCEPOLICIES_SET_QUERYFILTER?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_smr_view_framework_macros ::
	@echo 'AWS::SecretsManager::ResourcePolicy ($(_AWS_SECRETSMANAGER_RESOURCEPOLICY_MK_VERSION)) macros:'
	@echo

_smr_view_framework_parameters ::
	@echo 'AWS::SecretsManager::ResourcePolicy ($(_AWS_SECRETSMANAGER_RESOURCEPOLICY_MK_VERSION)) parameters:'
	@echo '    SMR_RESOURCEPOLICY_DIRPATH=$(SMR_RESOURCEPOLICY_DIRPATH)'
	@echo '    SMR_RESOURCEPOLICY_FILENAME=$(SMR_RESOURCEPOLICY_FILENAME)'
	@echo '    SMR_RESOURCEPOLICY_FILEPATH=$(SMR_RESOURCEPOLICY_FILEPATH)'
	@echo '    SMR_RESOURCEPOLICY_NAME=$(SMR_RESOURCEPOLICY_NAME)'
	@echo '    SMR_RESOURCEPOLICY_SECRET_ID=$(SMR_RESOURCEPOLICY_SECRET_ID)'
	@echo '    SMR_RESOURCEPOLICIES_SET_NAME=$(SMR_RESOURCEPOLICIES_SET_NAME)'
	@echo

_smr_view_framework_targets ::
	@echo 'AWS::SecretsManager::ResourcePolicy ($(_AWS_SECRETSMANAGER_RESOURCEPOLICY_MK_VERSION)) targets:'
	@echo '    _smr_create_resourcepolicy                - Create a resource-policy'
	@echo '    _smr_delete_resourcepolicy                - Delete a resource-policy'
	@echo '    _smr_show_resourcepolicy                  - Show everything related to a resource-policy'
	@echo '    _smr_show_resourcepolicy_description      - Show description of a resource-policy'
	@echo '    _smr_update_resourcepolicy                - Update a resource-policy'
	@echo '    _smr_view_resourcepolicies                - View resource-policies'
	@echo '    _smr_view_resourcepolicies_set            - View set of resource-policies'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_smr_create_resourcepolicy:
	@$(INFO) '$(SMR_UI_LABEL)Creating/Updating a resource-policy "$(SMR_RESOURCEPOLICY_NAME)" ...'; $(NORMAL)
	@$(if $(SMR_RESOURCEPOLICY_FILEPATH), cat $(SMR_RESOURCEPOLICY_FILEPATH))
	$(AWS) secretsmanager put-resource-policy $(__SMR_RESOURCE_POLICY) $(__SMR_SECRET_ID__RESOURCEPOLICY)

_smr_delete_resourcepolicy:
	@$(INFO) '$(SMR_UI_LABEL)Deleting resource-policy "$(SMR_RESOURCEPOLICY_NAME)" ...'; $(NORMAL)
	$(AWS) secretsmanager delete-resource-policy $(__SMR_SECRET_ID__RESOURCEPOLICY)

_smr_show_resourcepolicy: _smr_show_resourcepolicy_description

_smr_show_resourcepolicy_description:
	@$(INFO) '$(SMR_UI_LABEL)Showing description of resource-policy "$(SMR_RESOURCEPOLICY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation shows the content of the resource-policy that is empty when the secret is created'; $(NORMAL)
	$(AWS) secretsmanager get-resource-policy $(__SMR_SECRET_ID__RESOURCEPOLICY)

_smr_update_resourcepolicy: _smr_create_resourcepolicy

_smr_view_resourcepolicies:
	@$(INFO) '$(SMR_UI_LABEL)Viewing resource-policies ...'; $(NORMAL)
	# $(AWS) secretsmanager list-secrets --query "SecretList[]$(SMR_UI_VIEW_SECRETS_FIELDS)"

_smr_view_resourcepolicies_set:
	@$(INFO) '$(SMR_UI_LABEL)Viewing resource-policies-set "$(SMR_RESOURCEPOLICIES_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Resource-policies are grouped based on the provided query-filter'; $(NORMAL)
	# $(AWS) secretsmanager list-secrets --query "SecretList[$(SMR_UI_VIEW_SECRETS_SET_QUERYFILTER)]$(SMR_UI_VIEW_SECRETS_SET_FIELDS)"
