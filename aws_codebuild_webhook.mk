_AWS_CODEBUILD_WEBHOOK_MK_VERSION= $(_AWS_CODEBUILD_MK_VERSION)

# CBD_WEBHOOK_BRANCH_FILTER?= master*
# CBD_WEBHOOK_NAME?=
# CBD_WEBHOOK_PROJECT_NAME?=
# CBD_WEBHOOK_ROTATE_SECRET?= false

# Derived parameters

# Options parameters
__CBD_BRANCH_FILTER= $(if $(CBD_WEBHOOK_BRANCH_FILTER), --branch-filter $(CBD_WEBHOOK_BRANCH_FILTER))
__CBD_PROJECT_NAME__WEBHOOK= $(if $(CBD_WEBHOOK_PROJECT_NAME), --project-name $(CBD_WEBHOOK_PROJECT_NAME))
__CBD_ROTATE_SECRET= $(if $(filter true, $(CBD_WEBHOOK_ROTATE_SECRET)), --rotate-secret $(CBD_WEBHOOK_ROTATE_SECRET))

# UI parameters
CBD_UI_VIEW_WEBHOOKS_FIELDS?=
CBD_UI_VIEW_WEBHOOKS_SET_FIELDS?= $(CBD_UI_VIEW_WEBHOOKS_FIELDS)
CBD_UI_VIEW_WEBHOOKS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cbd_view_framework_macros ::
	@echo 'AWS::CodeBuilD::Webhook ($(_AWS_CODEBUILD_WEBHOOK_MK_VERSION)) macros:'
	@echo

_cbd_view_framework_parameters ::
	@echo 'AWS::CodeBuilD::Webhook ($(_AWS_CODEBUILD_WEBHOOK_MK_VERSION)) parameters:'
	@echo '    CBD_WEBHOOK_NAME=$(CBD_WEBHOOK_NAME)'
	@echo '    CBD_WEBHOOK_NAME=$(CBD_WEBHOOK_NAME)'
	@echo '    CBD_WEBHOOK_PROJECT_NAME=$(CBD_WEBHOOK_PROJECT_NAME)'
	@echo '    CBD_WEBHOOK_ROTATE_SECRET=$(CBD_WEBHOOK_ROTATE_SECRET)'
	@echo

_cbd_view_framework_targets ::
	@echo 'AWS::CodeBuilD::Webhook ($(_AWS_CODEBUILD_WEBHOOK_MK_VERSION)) targets:'
	@echo '    _cbd_create_webhook                   - Create a new webhook'
	@echo '    _cbd_delete_webhook                   - Delete an existing webhook'
	@echo '    _cbd_update_webhook                   - Update an existing webhook'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cbd_create_webhook:
	@$(INFO) '$(AWS_UI_LABEL)Creating webhook "$(CBD_WEBHOOK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If you are using CodeBuild with CodePipeline, do not use webhooks or multiple build will trigger for same commit!'; $(NORMAL)
	$(AWS)  codebuild create-webhook $(__CBD_BRANCH_FILTER) $(__CBD_PROJECT_NAME__WEBHOOK)

_cbd_delete_webhook:
	@$(INFO) '$(AWS_UI_LABEL)Deleting webhook "$(CBD_WEBHOOK_NAME)" ...'; $(NORMAL)
	$(AWS)  codebuild delete-webhook $(__CBD_PROJECT_NAME__WEBHOOK)

_X_cbd_show_webhook:

_cbd_update_webhook:
	@$(INFO) '$(AWS_UI_LABEL)Updating webhook "$(CBD_WEBHOOK_NAME)" ...'; $(NORMAL)
	$(AWS)  codebuild update-webhook $(__CBD_BRANCH_FILTER) $(__CBD_ROTATE_SECRET) $(__CBD_PROJECT_NAME__WEBHOOK)

_X_cbd_view_webhooks:

_X_cbd_view_webhooks_set:
