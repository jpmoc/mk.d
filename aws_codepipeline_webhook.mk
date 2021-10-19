_AWS_CODEPIPELINE_WEBHOOK_MK_VERSION= $(_AWS_CODEPIPELINE_MK_VERSION)

# CPE_WEBHOOK_3RDPARTY?=
# CPE_WEBHOOK_CONFIG?= name=string,targetPipeline=string,targetAction=string,filters=[{jsonPath=string,matchEquals=string},{jsonPath=string,matchEquals=string}],authentication=string,authenticationConfiguration={AllowedIPRange=string,SecretToken=string}
# CPE_WEBHOOK_CONFIG_FILEPATH?= ./webhook-config.json
# CPE_WEBHOOK_NAME?=
# CPE_WEBHOOKS_SET_NAME?= my-webhooks-set

# Derived parameters
CPE_WEBHOOK_CONFIG?= $(if $(CPE_WEBHOOK_CONFIG_FILEPATH),file://$(CPE_WEBHOOK_CONFIG_FILEPATH))

# Options parameters
__CPE_NAME__WEBHOOK= $(if $(CPE_WEBHOOK_NAME), --name $(CPE_WEBHOOK_NAME))
__CPE_WEBHOOK= $(if $(CPE_WEBHOOK_CONFIG), --webhook $(CPE_WEBHOOK_CONFIG))
__CPE_WEBHOOK_NAME= $(if $(CPE_WEBHOOK_NAME), --webhook-name $(CPE_WEBHOOK_NAME))

# UI parameters
CPE_UI_VIEW_WEBHOOKS_FIELDS?=
CPE_UI_VIEW_WEBHOOKS_SET_FIELDS?= $(CPE_UI_VIEW_WEBHOOKS_FIELDS)
CPE_UI_VIEW_WEBHOOKS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cpe_view_makefile_macros ::
	@#echo 'AWS::CodePipelinE::Webhook ($(_AWS_CODEPIPELINE_WEBHOOK_MK_VERSION)) macros:'
	@#echo

_cpe_view_makefile_parameters ::
	@echo 'AWS::CodePipelinE::Webhook ($(_AWS_CODEPIPELINE_WEBHOOK_MK_VERSION)) parameters:'
	@echo '    CPE_WEBHOOK_3RDPARTY=$(CPE_WEBHOOK_3RDPARTY)'
	@echo '    CPE_WEBHOOK_CONFIG=$(CPE_WEBHOOK_CONFIG)'
	@echo '    CPE_WEBHOOK_CONFIG_FILEPATH=$(CPE_WEBHOOK_CONFIG_FILEPATH)'
	@echo '    CPE_WEBHOOK_NAME=$(CPE_WEBHOOK_NAME)'
	@echo '    CPE_WEBHOOKS_SET_NAME=$(CPE_WEBHOOKS_SET_NAME)'
	@echo

_cpe_view_makefile_targets ::
	@echo 'AWS::CodePipelinE::Webhook ($(_AWS_CODEPIPELINE_WEBHOOK_MK_VERSION)) targets:'
	@echo '    _cpe_create_webhook              - Create a new webhook'
	@echo '    _cpe_delete_webhook              - Delete an existing webhook'
	@echo '    _cpe_deregister_webhook          - Deregister an existing webhook'
	@echo '    _cpe_register_webhook            - Register an existing webhook'
	@echo '    _cpe_show_webhook                - Show details of an webhook'
	@echo '    _cpe_view_webhooks               - View existing webhooks'
	@echo '    _cpe_view_webhooks_set           - View a set of webhooks'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cpe_create_webhook:
	@$(INFO) '$(AWS_UI_LABEL)Creating webhook "$(CPE_WEBHOOK_NAME)" ...'; $(NORMAL)
	$(AWS) codepipeline put-webhook $(__CPE_WEBHOOK)

_cpe_delete_webhook:
	@$(INFO) '$(AWS_UI_LABEL)Deleting webhook "$(CPE_WEBHOOK_NAME)" ...'; $(NORMAL)
	$(AWS) codepipeline delete-webhook $(__CPE_NAME__WEBHOOK)

_cpe_deregister_webhook:
	@$(INFO) '$(AWS_UI_LABEL)Deregistering webhook "$(CPE_WEBHOOK_NAME)" with 3rd-party "$(CPE_WEBHOOK_3RDPARTY)" ...'; $(NORMAL)
	$(AWS) codepipeline deregister-webhook-with-third-party $(__CPE_WEBHOOK_NAME)

_cpe_register_webhook:
	@$(INFO) '$(AWS_UI_LABEL)Registering webhook "$(CPE_WEBHOOK_NAME)" with 3rd-party "$(CPE_WEBHOOK_3RDPARTY)" ...'; $(NORMAL)
	$(AWS) codepipeline register-webhook-with-third-party $(__CPE_WEBHOOK_NAME)

_cpe_show_webhook:
	@$(INFO) '$(AWS_UI_LABEL)Showing webhook "$(CPE_WEBHOOK_NAME)" ...'; $(NORMAL)
	$(AWS) codepipeline list-webhooks # --query "actionTypes[?id.category=='$(CPE_WEBHOOK_CATEGORY)'&&id.owner=='$(CPE_WEBHOOK_OWNER)'&&id.provider=='$(CPE_WEBHOOK_PROVIDER)'&&id.version=='$(CPE_WEBHOOK_VERSION)']"

_cpe_view_webhooks:
	@$(INFO) '$(AWS_UI_LABEL)Viewing webhooks ...'; $(NORMAL)
	$(AWS) codepipeline list-webhooks # --query "actionTypes[].id[]$(CPE_UI_VIEW_WEBHOOKS_FIELDS)"

_cpe_view_webhooks_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing webhooks-set "$(CPE_WEBHOOKS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Action-types are grouped based on the provided slice'; $(NORMAL)
	$(AWS) codepipeline list-webhooks # --query "actionTypes[$(CPE_UI_VIEW_WEBHOOK_SET_SLICE)]$(CPE_UI_VIEW_WEBHOOK_SET_FIELDS)"
