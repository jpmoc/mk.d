_AWS_ELASTICBEANSTALK_CONFIGURATIONTEMPLATE_MK_VERSION= $(_AWS_ELASTICBEANSTALK_MK_VERSION)

# EBK_CONFIGURATIONTEMPLATE_APPLICATION_NAME?=
# EBK_CONFIGURATIONTEMPLATE_DESCRIPTION?=
# EBK_CONFIGURATIONTEMPLATE_NAME?=
# EBK_CONFIGURATIONTEMPLATE_PLATFORM_ARN?=
# EBK_CONFIGURATIONTEMPLATE_SOLUTIONSTACK_NAME?=

# Derived parameters
EBK_CONFIGURATIONTEMPLATE_APPLICATION_NAME?= $(EBK_APPLICATION_NAME)
EBK_CONFIGURATIONTEMPLATE_ENVIRONMENT_ID?= $(EBK_ENVIRONMENT_ID)
EBK_CONFIGURATIONTEMPLATE_PLATFORM_ARN?= $(EBK_PLATFORM_ARN)
EBK_CONFIGURATIONTEMPLATE_SOLUTIONSTACK_NAME?= $(EBK_SOLUTIONSTACK_NAME)

# Option parameters
__EBK_APPLICATION_NAME__CONFIGURATIONTEMPLATE= $(if $(EBK_CONFIGURATIONTEMPLATE_APPLICATION_NAME), --application-name $(EBK_CONFIGURATIONTEMPLATE_APPLICATION_NAME))
__EBK_DESCRIPTION__CONFIGURATIONTEMPLATE= $(if $(EBK_CONFIGURATIONTEMPLATE_DESCRIPTION), --description $(EBK_CONFIGURATIONTEMPLATE_DESCRIPTION))
__EBK_ENVIRONMENT_ID__CONFIGURATIONTEMPLATE= $(if $(EBK_CONFIGURATIONTEMPLATE_ENVIRONMENT_ID), --environment-id $(EBK_CONFIGURATIONTEMPLATE_ENVIRONMENT_ID))
__EBK_OPTION_SETTINGS=
__EBK_PLATFORM_ARN__CONFIGURATIONTEMPLATE= $(if $(EBK_CONFIGURATIONTEMPLATE_PLATFORM_ARN), --platform-arn $(EBK_CONFIGURATIONTEMPLATE_PLATFORM_ARN))
__EBK_SOLUTION_STACK_NAME__CONFIGURATIONTEMPLATE= $(if $(EBK_CONFIGURATIONTEMPLATE_SOLUTIONSTACK_NAME), --solution-stack-name $(EBK_CONFIGURATIONTEMPLATE_SOLUTIONSTACK_NAME))
__EBK_SOURCE_CONFIGURATION=
__EBK_TEMPLATE_NAME= $(if $(EBK_CONFIGURATIONTEMPLATE_NAME), --template-name $(EBK_CONFIGURATIONTEMPLATE_NAME))

# UI parameters
EBK_UI_VIEW_APPLICATIONS_FIELDS?= .{ApplicationName:ApplicationName,dateCreated:DateCreated,dateUpdated:DateUpdated}
EBK_UI_VIEW_APPLICATIONS_SET_FIELDS?= $(EBK_UI_VIEW_APPLICATIONS_FIELDS)

#--- MACROS
_ebk_get_applicaiton_arn= $(call _ebk_get_application_arn_N, $(EBK_APPLICATION_NAME))
_ebk_get_application_arn_N= $(shell echo arn:aws:elasticbeanstalk:$(AWS_REGION):$(AWS_ACCOUNT_ID):application/$(strip (1)))

#----------------------------------------------------------------------
# USAGE
#

_ebk_view_framework_macros ::
	@echo 'AWS::ElasticBeanstalK::ConfigurationTemplate ($(_AWS_ELASTICBEANSTALK_APPLICATION_MK_VERSION)) macros:'
	@echo

_ebk_view_framework_parameters ::
	@echo 'AWS::ElasticBeanstalK::ConfigurationTemplate ($(_AWS_ELASTICBEANSTALK_APPLICATION_MK_VERSION)) parameters:'
	@echo '    EBK_CONFIGURATIONTEMPLATE_APPLICATION_NAME=$(EBK_CONFIGURATIONTEMPLATE_APPLICATION_NAME)'
	@echo '    EBK_CONFIGURATIONTEMPLATE_NAME=$(EBK_CONFIGURATIONTEMPLATE_NAME)'
	@echo '    EBK_CONFIGURATIONTEMPLATE_PLATFORM_ARN=$(EBK_CONFIGURATIONTEMPLATE_PLATFORM_ARN)'
	@echo '    EBK_CONFIGURATIONTEMPLATE_SOLUTIONSTACK_NAME=$(EBK_CONFIGURATIONTEMPLATE_SOLUTIONSTACK_NAME)'
	@echo

_ebk_view_framework_targets ::
	@echo 'AWS::ElasticBeanstalK::ConfigurationTemplate ($(_AWS_ELASTICBEANSTALK_APPLICATION_MK_VERSION)) targets:'
	@echo '    _ebk_create_configurationtemplate             - Create configuration-template'
	@echo '    _ebk_delete_configurationtemplate             - Delete configuration-template'
	@echo '    _ebk_show_configurationtemplate               - Show everything related to a configuration-template'
	@echo '    _ebk_view_configurationtemplates              - View existing configuration-templates'
	@echo '    _ebk_view_configurationtemplates_set          - View a set of configuration-templates'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ebk_create_configurationtemplate:
	@$(INFO) '$(AWS_UI_LABEL)Creating configuration-template "$(EBK_CONFIGURATIONTEMPLATE_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk create-configuration-template $(__EBK_APPLICATION_NAME__CONFIGURATIONTEMPLATE) $(__EBK_DESCRIPTION_CONFIGURATIONTEMPLATE) $(__EBK_ENVIRONMENT_ID__CONFIGURATIONTEMPLATE) i$(__EBK_OPTION_SETTINGS) $(__EBK_PLATFORM_ARN__CONFIGURATIONTEMPLATE) $(__EBK_SOLUTION_STACK_NAME__CONFIGURATIONTEMPLATE) $(__EBK_SOURCE_CONFIGURATION) $(__EBK_TEMPLATE_NAME)

_ebk_delete_configurationtemplate:
	@$(INFO) '$(AWS_UI_LABEL)Deleting configuration-template "$(EBK_CONFIGURATIONTEMPLATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Environments that use this configurationtemplate must first be deleted!'; $(NORMAL)
	$(AWS) elasticbeanstalk delete-configuration-template $(__EBK_APPLICATION_NAME) $(__EBK_TERMINATE_ENV_BY_FORCE)

_ebk_show_configurationtemplate:
	@$(INFO) '$(AWS_UI_LABEL)Showing configuration-template "$(EBK_CONFIGURATIONTEMPLATE_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-configuration-templates --application-names $(EBK_APPLICATION_NAME) --query "Applications[]"

_ebk_view_configurationtemplates:
	@$(INFO) '$(AWS_UI_LABEL)Viewing configuration-templates ...'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-configuration-templates $(_X__EBK_APPLICATION_NAMES) --query "Applications[]$(EBK_UI_VIEW_APPLICATIONS_FIELDS)"

_ebk_view_configurationtemplates_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing configuration-templates-set "$(EBK_CONFIGURATIONTEMPLATES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This group is defined based on the provided configurationtemplate names'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-configuration-templates $(__EBK_APPLICATION_NAMES) --query "Applications[]$(EBK_UI_VIEW_APPLICATIONS_SET_FIELDS)"
