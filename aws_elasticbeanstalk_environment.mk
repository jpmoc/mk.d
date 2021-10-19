_AWS_ELASTICBEANSTALK_ENVIRONMENT_MK_VERSION= $(_AWS_ELASTICBEANSTALK_MK_VERSION)

# EBK_ENVIRONMENT_APPLICATION_NAME?= my-application-name
# EBK_ENVIRONMENT_APPLICATIONVERSION_LABEL?= v1
EBK_ENVIRONMENT_ATTRIBUTE_NAMES?= All# Not API default, but should be  sense
# EBK_ENVIRONMNET_ARN?= arn:aws:elasticbeanstalk:us-east-1:123456789012:environment/my-application-name/MyApplicationName-env
# EBK_ENVIRONMNET_AUTOSCALINGGROUP_NAMES?= awseb-e-2qbpe7mb93-stack-AWSEBAutoScalingGroup-1WMUHPGZGU8NK ...
# EBK_ENVIRONMENT_CNAME_PREFIX?= my-cname-prefix
# EBK_ENVIRONMENT_DESCRIPTION?= "This is my environment-description"
# EBK_ENVIRONMENT_GROUP_NAME?=
# EBK_ENVIRONMENT_ID?= e-izqpassy4h
# EBK_ENVIRONMENT_IDS?= e-izqpassy4h ...
# EBK_ENVIRONMENT_INSTANCE_IDS?= i-0d6d2d862b5ff7a74 ...
# EBK_ENVIRONMENT_LAUNCHCONFIGURATION_NAMES?= awseb-e-2qbpe7mb93-stack-AWSEBAutoScalingLaunchConfiguration-EM440SA0KN6O ...
# EBK_ENVIRONMENT_NAME?= my-environment-name
# EBK_ENVIRONMENT_QUEUE_NAMES?= ...
# EBK_ENVIRONMENT_SOLUTIONSTACK_NAME?= "64bit Amazon Linux 2015.03 v2.0.0 running Tomcat 8 Java 8"
# EBK_ENVIRONMENT_TAGS?= Key=string,Value=string ...
# EBK_ENVIRONMENT_TERMINATE_FORCE?= false 
EBK_ENVIRONMENT_TERMINATE_RESOURCES?= true
# EBK_ENVIRONMENT_TIER?= Name=WebServer,Type=Standard,Version=1.0
# EBK_ENVIRONMENT_TIER_FILEPATH?= ./environment-tier.json
# EBK_ENVIRONMENT_TRIGGER_NAMES?= ...
# EBK_ENVIRONMENT_URL?= http://myapplicationname-env.gj7ugxrzmd.us-east-1.elasticbeanstalk.com/
# EBK_ENVIRONMNETS_SET_NAME?= my-environments-set

# Derived parameters
EBK_ENVIRONMENT_APPLICATION_NAME?= $(EBK_APPLICATION_NAME)
EBK_ENVIRONMENT_APPLICATIONVERSION_LABEL?= $(EBK_APPLICATIONVERSION_LABEL)
EBK_ENVIRONMENT_ARN?= arn:aws:elasticbeanstalk:$(AWS_REGION):$(AWS_ACCOUNT_ID):environment/$(EBK_ENVIRONMENT_APPLICATION_NAME)/$(EBK_ENVIRONMENT_NAME)
EBK_ENVIRONMENT_CNAME_PREFIX?= $(EBK_CNAME_PREFIX)
EBK_ENVIRONMENT_CONFIGURATIONTEMPLATE_NAME?= $(EBK_CONFIGURATIONTEMPLATE_NAME)
EBK_ENVIRONMENT_IDS?= $(EBK_ENVIRONMENT_ID)
EBK_ENVIRONMENT_SOLUTIONSTACK_NAME?= $(GEBK_SOLUTIONSTACK_NAME)
EBK_ENVIRONMENT_TIER?= $(if $(EBK_ENVIRONMENT_TIER_FILEPATH), file://$(EBK_ENVIRONMENT_TIER_FILEPATH))

# Option parameters
__EBK_APPLICATION_NAME__ENVIRONMENT=
__EBK_ATTRIBUTE_NAMES= $(if $(EBK_ENVIRONMENT_ATTRIBUTE_NAMES), --attribute-names $(EBK_ENVIRONMENT_ATTRIBUTE_NAMES))
__EBK_CNAME_PREFIX__ENVIRONMENT= $(if $(EBK_ENVIRONMENT_CNAME_PREFIX), --cname-prefix $(EBK_ENVIRONMENT_CNAME_PREFIX))
__EBK_ENVIRONMENT_DESCRIPTION= $(if $(EBK_ENVIRONMENT_DESCRIPTION), --description $(EBK_ENVIRONMENT_DESCRIPTION))
__EBK_ENVIRONMENT_ID= $(if $(EBK_ENVIRONMENT_ID), --environment-id $(EBK_ENVIRONMENT_ID))
__EBK_ENVIRONMENT_IDS= $(if $(EBK_ENVIRONMENT_IDS), --environment-ids $(EBK_ENVIRONMENT_IDS))
__EBK_ENVIRONMENT_NAME= $(if $(EBK_ENVIRONMNET_NAME), --name D$(EBK_ENVIRONMENT_NAME))
__EBK_ENVIRONMENT_NAMES=
__EBK_FORCE_TERMINATE= 
__EBK_GROUP_NAME=
__EBK_INCLUDE_DELETED=
__EBK_INCLUDE_DELETED_BACK_TO=
__EBK_OPTION_SETTINGS=
__EBK_OPTIONS_TO_REMOVE=
__EBK_SOLUTION_STACK_NAME_ENVIRONMENT=
__EBK_TAGS__ENVIRONMENT= $(if $(EBK_ENVIRONMENT_TAGS), --tags $(EBK_ENVIRONMENT_TAGS))=
__EBK_TEMPLATE_NAME__ENVIRONMENT= $(if $(EBK_ENVIRONMENT_CONFIGURATIONTEMPLATE_NAME), --template-name $(EBK_ENVIRONMENT_CONFIGURATIONTEMPLATE_NAME))
__EBK_TERMINATE_RESOURCES= $(if $(filter false, $(EBK_ENVIRONMENT_TERMINATE_RESOURCES)), --not-terminate-resources, --terminate-resources)
__EBK_TIER= $(if $(EBK_ENVIRONMENT_TIER), --tier $(EBK_ENVIRONMENT_TIER))
__EBK_VERSION_LABEL__ENVIRONMENT= $(if $(EBK_ENVIRONMENT_APPLICATIONVERSION_LABEL), --version-label $(EBK_ENVIRONMENT_APPLICATIONVERSION_LABEL))

# UI parameters
EBK_UI_VIEW_ENVIRONMENTS_FIELDS?= .{EnvironmentId:EnvironmentId,EnvironmentName:EnvironmentName,health:Health,healthStatus:HealthStatus,status:Status,cname:CNAME}
EBK_UI_VIEW_ENVIRONMENTS_SET_FIELDS?= $(EBK_UI_VIEW_ENVIRONMENTS_SET_FIELDS)


#--- MACROS
_ebk_get_environment_arn= $(call _ebk_get_environment_arn_N, $(EBK_ENVIRONMENT_NAME))
_ebk_get_environment_arn_N= $(call _ebk_get_environment_arn_NA, $(1), $(EBK_ENVIRONMENT_APPLICATION_NAME))
_ebk_get_environment_arn_NA= $(call _ebk_get_environment_arn_NAA, $(1), $(2), $(EBK_ENVIRONMENT_ACCOUNT_ID))
_ebk_get_environment_arn_NAA= $(shell echo arn:aws:elasticbeanstalk:us-east-1:$(strip $(3)):environment/$(strip $(2))/$(strip $(1)))
# _ebk_get_environment_arn_N= $(shell $(AWS) elasticbeanstalk describe-environments --environment-name $(1) --query "Environments[].EnvironmentArn" --output text)

_ebk_get_environment_id= $(call _ebk_get_environment_id_N, $(EBK_ENVIRONMENT_NAME))
_ebk_get_environment_id_N= $(shell $(AWS) elasticbeanstalk describe-environments --environment-names $(1) --query "Environments[].EnvironmentId" --output text)

_ebk_get_environment_autoscalinggroup_names= $(call _ebk_get_environment_autoscalinggroup_names_I, $(EBK_ENVIRONMENT_ID))
_ebk_get_environment_autoscalinggroup_names_I= $(shell $(AWS) elasticbeanstalk describe-environment-resources  --environment-id $(1) --query "EnvironmentResources.AutoScalingGroups[].Name" --output text)

_ebk_get_environment_instance_ids= $(call _ebk_get_environment_instance_ids_I, $(EBK_ENVIRONMENT_ID))
_ebk_get_environment_instance_ids_I= $(shell $(AWS) elasticbeanstalk describe-environment-resources  --environment-id $(1) --query "EnvironmentResources.Instances[].Id" --output text)

_ebk_get_environment_launchconfiguration_names= $(call _ebk_get_environment_launchconfiguration_names_I, $(EBK_ENVIRONMENT_ID))
_ebk_get_environment_launchconfiguration_names_I= $(shell $(AWS) elasticbeanstalk describe-environment-resources  --environment-id $(1) --query "EnvironmentResources.LaunchConfigurations[].Name" --output text)

_ebk_get_environment_loadbalancer_names= $(call _ebk_get_environment_loadbalancer_names_I, $(EBK_ENVIRONMENT_ID))
_ebk_get_environment_loadbalancer_names_I= $(shell $(AWS) elasticbeanstalk describe-environment-resources  --environment-id $(1) --query "EnvironmentResources.LoadBalancers[].Name" --output text)

_ebk_get_environment_queue_names= $(call _ebk_get_environment_queue_names_I, $(EBK_ENVIRONMENT_ID))
_ebk_get_environment_queue_names_I= $(shell $(AWS) elasticbeanstalk describe-environment-resources  --environment-id $(1) --query "EnvironmentResources.Queues[].Name" --output text)

_ebk_get_environment_trigger_names= $(call _ebk_get_environment_trigger_names_I, $(EBK_ENVIRONMENT_ID))
_ebk_get_environment_trigger_names_I= $(shell $(AWS) elasticbeanstalk describe-environment-resources  --environment-id $(1) --query "EnvironmentResources.Triggers[].Name" --output text)

_ebk_get_environment_url= $(call _ebk_get_environment_url_N, $(EBK_ENVIRONMENT_NAME))
_ebk_get_environment_url_N= $(shell $(AWS) elasticbeanstalk describe-environments --environment-name $(1) --query "Environments[].CNAME" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ebk_view_framework_macros ::
	@echo 'AWS::ElasticBeanstalK::Environment ($(_AWS_ELASTICBEANSTALK_ENVIRONMENT_MK_VERSION)) macros:'
	@echo '    _ebk_get_environment_arn_{|N|NA}                       - Get the ARN of an environmnet (Name,ApplicationName)'
	@echo '    _ebk_get_environment_autoscalinggroup_names_{|I}       - Get the auto-scaling-group names used in an environmnet (Id)'
	@echo '    _ebk_get_environment_id_{|N}                           - Get the ID of an environmnet (Name)'
	@echo '    _ebk_get_environment_instance_ids_{|I}                 - Get the instance IDs of the instances in an environmnet (Id)'
	@echo '    _ebk_get_environment_launchconfiguration_names_{|I}    - Get the launch-configuration names used in an environmnet (Id)'
	@echo '    _ebk_get_environment_queue_names_{|I}                  - Get the queue names used in an environmnet (Id)'
	@echo '    _ebk_get_environment_trigger_names_{|I}                - Get the trigger names used in an environmnet (Id)'
	@echo '    _ebk_get_environment_url_{|N}                          - Get the URL of an environmnet (Name)'
	@echo

_ebk_view_framework_parameters ::
	@echo 'AWS::ElasticBeanstalK::Environment ($(_AWS_ELASTICBEANSTALK_ENVIRONMENT_MK_VERSION)) parameters:'
	@echo '    EBK_ENVIRONMENT_APPLICATION_NAME=$(EBK_ENVIRONMENT_APPLICATION_NAME)'
	@echo '    EBK_ENVIRONMENT_APPLICATIONVERSION_LABEL=$(EBK_ENVIRONMENT_APPLICATIONVERSION_LABEL)'
	@echo '    EBK_ENVIRONMENT_AUTOSCALINGGROUP_NAMES=$(EBK_ENVIRONMENT_AUTOSCALINGGROUP_NAMES)'
	@echo '    EBK_ENVIRONMENT_ATTRIBUTE_NAMES=$(EBK_ENVIRONMENT_ATTRIBUTE_NAMES)'
	@echo '    EBK_ENVIRONMENT_CNAME_PREFIX=$(EBK_ENVIRONMENT_CNAME_PREFIX)'
	@echo '    EBK_ENVIRONMENT_DESCRIPTION=$(EBK_ENVIRONMENT_DESCRIPTION)'
	@echo '    EBK_ENVIRONMENT_GROUP_NAME=$(EBK_ENVIRONMENT_GROUP_NAME)'
	@echo '    EBK_ENVIRONMENT_ID=$(EBK_ENVIRONMENT_ID)'
	@echo '    EBK_ENVIRONMENT_IDS=$(EBK_ENVIRONMENT_IDS)'
	@echo '    EBK_ENVIRONMENT_INSTANCE_IDS=$(EBK_ENVIRONMENT_INSTANCE_IDS)'
	@echo '    EBK_ENVIRONMENT_LAUNCHCONFIGURATION_NAMES=$(EBK_ENVIRONMENT_LAUNCHCONFIGURATION_NAMES)'
	@echo '    EBK_ENVIRONMENT_LOADBALANCER_NAMES=$(EBK_ENVIRONMENT_LOADBALANCER_NAMES)'
	@echo '    EBK_ENVIRONMENT_NAME=$(EBK_ENVIRONMENT_NAME)'
	@echo '    EBK_ENVIRONMENT_OPTION_SETTINGS=$(EBK_ENVIRONMENT_OPTION_SETTINGS)'
	@echo '    EBK_ENVIRONMENT_PLATFORM_ARN=$(EBK_ENVIRONMENT_PLATFORM_ARN)'
	@echo '    EBK_ENVIRONMENT_QUEUE_NAMES=$(EBK_ENVIRONMENT_QUEUE_NAMES)'
	@echo '    EBK_ENVIRONMENT_TAGS=$(EBK_ENVIRONMENT_TAGS)'
	@echo '    EBK_ENVIRONMENT_TERMINATE_FORCE=$(EBK_ENVIRONMENT_TERMINATE_FORCE)'
	@echo '    EBK_ENVIRONMENT_TERMINATE_RESOURCES=$(EBK_ENVIRONMENT_TERMINATE_RESOURCES)'
	@echo '    EBK_ENVIRONMENT_TIER=$(EBK_ENVIRONMENT_TIER)'
	@echo '    EBK_ENVIRONMENT_TIER_FILEPATH=$(EBK_ENVIRONMENT_TIER_FILEPATH)'
	@echo '    EBK_ENVIRONMENT_TRIGGER_NAMES=$(EBK_ENVIRONMENT_TRIGGER_NAMES)'
	@echo '    EBK_ENVIRONMENT_URL=$(EBK_ENVIRONMENT_URL)'
	@echo '    EBK_ENVIRONMENTS_SET_NAME=$(EBK_ENVIRONMENTS_SET_NAME)'
	@echo

_ebk_view_framework_targets ::
	@echo 'AWS::ElasticBeanstalK::Environment ($(_AWS_ELASTICBEANSTALK_ENVIRONMENT_MK_VERSION)) targets:'
	@echo '    _ebk_create_environment             - Create a new environment'
	@echo '    _ebk_delete_environment             - Delete an existing environment'
	@echo '    _ebk_show_environment               - Show everything related to an environment'
	@echo '    _ebk_show_environment_description   - Show description of an environment'
	@echo '    _ebk_show_environment_health        - Show health of an environment'
	@echo '    _ebk_show_environment_resources     - Show resources in an environment'
	@echo '    _ebk_view_environments              - View existing environments'
	@echo '    _ebk_view_environments_set          - View a set of existing environments'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ebk_create_environment:
	@$(INFO) '$(AWS_UI_LABEL)Creating environment "$(EBK_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk create-environment $(__EBK_APPLICATION_NAME__ENVIRONMENT) $(__EBK_CNAME_PREFIX__ENVIRONMENT) $(__EBK_DESCRIPTION__ENVIRONMENT) $(__EBK_ENVIRONMENT_NAME) $(__EBK_GROUP_NAME) $(__EBK_OPTION_SETTINGS) $(__EBK_OPTIONS_TO_REMOVE) $(__EBK_SOLUTION_STACK_NAME__ENVIRONMENT) $(__EBK_TAGS__ENVIRONMENT) $(__EBK_TEMPLATE_NAME__ENVIRONMENT) $(__EBK_TIER) $(__EBK_VERSION_LABEL__ENVIRONMENT)

_ebk_delete_environment:
	@$(INFO) '$(AWS_UI_LABEL)Deleting environment "$(EBK_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk terminate-environment $(__EBK_ENVIRONMENT_ID) $(__EBK_ENVIRONMENT_NAME) $(__EBK_FORCE_TERMINATE) $(__EBK_TERMINATE_RESOURCES)

_ebk_show_environment: _ebk_show_environment_health _ebk_show_environment_resources _ebk_show_environment_description

_ebk_show_environment_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of environment "$(EBK_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-environments $(_X__EBK_APPLICATION_NAME__ENVIRONMENT) $(_X__EBK_ENVIRONMENT_IDS) --environment-ids $(EBK_ENVIRONMENT_ID) $(_X__EBK_ENVIRONMENT_NAMES) $(_X__EBK_INCLUDE_DELETED) $(_X__EBK_INCLUDE_DELETED_BACK_TO) $(_X__EBK_VERSION_LABEL) --query "Environments[]"

_ebk_show_environment_health:
	@$(INFO) '$(AWS_UI_LABEL)Showing health of environment "$(EBK_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-environment-health $(__EBK_ATTRIBUTE_NAMES) $(__EBK_ENVIRONMENT_ID) $(_X__EBK_ENVIRONMENT_NAME)

_ebk_show_environment_resources:
	@$(INFO) '$(AWS_UI_LABEL)Showing resources of environment "$(EBK_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-environment-resources $(__EBK_ENVIRONMENT_ID) $(_X__EBK_ENVIRONMENT_NAME)

_ebk_view_environments:
	@$(INFO) '$(AWS_UI_LABEL)Viewing environments ...'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-environments $(_X__EBK_APPLICATION_NAME__ENVIRONMENT) $(_X__EBK_ENVIRONMENT_IDS) $(_X__EBK_ENVIRONMENT_NAMES) $(__EBK_INCLUDE_DELETED) $(__EBK_INCLUDE_DELETED_BACK_TO) $(_X__EBK_VERSION_LABEL) --query "Environments[]$(EBK_UI_VIEW_ENVIRONMENTS_FIELDS)"

_ebk_view_environments_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing environments-set "$(EBK_ENVIRONMENTS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-environments $(__EBK_APPLICATION_NAME__ENVIRONMENT) $(__EBK_ENVIRONMENT_IDS) $(__EBK_ENVIRONMENT_NAMES) $(__EBK_INCLUDE_DELETED) $(__EBK_INCLUDE_DELETED_BACK_TO) $(_X__EBK_VERSION_LABEL)
