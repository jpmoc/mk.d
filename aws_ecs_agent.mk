_AWS_ECS_AGENT_MK_VERSION= $(_AWS_ECS_MK_VERSION)

# ECS_AGENT_CLUSTER_ARN?=
# ECS_AGENT_CLUSTER_ARN_OR_NAME?=
# ECS_AGENT_CLUSTER_NAME?=
# ECS_AGENT_CONTAINERINSTANCE_ARN?= arn:aws:ecs:us-east-1:123456789012:container-instance/f6bbb147-5370-4ace-8c73-c7181ded911f
# ECS_AGENT_CONTAINERINSTANCE_ARN_OR_ID?=
# ECS_AGENT_CONTAINERINSTANCE_ID?= f6bbb147-5370-4ace-8c73-c7181ded911f
# ECS_AGENT_CONTAINERINSTANCE_NAME my-ec2-instance-name
# ECS_AGENTS_CLUSTER_ARN?=
# ECS_AGENTS_CLUSTER_ARN_OR_NAME?=
# ECS_AGENTS_CLUSTER_NAME?=
# ECS_AGENTS_CONTAINERINSTANCES_ARNS?=
# ECS_AGENTS_CONTAINERINSTANCES_ARNS_OR_IDS?=
# ECS_AGENTS_CONTAINERINSTANCES_IDS?=
# ECS_AGENTS_SET_NAME?= my-agents-set

# Derived parameters
ECS_AGENT_CLUSTER_ARN?= $(ECS_CLUSTER_ARN)
ECS_AGENT_CLUSTER_ARN_OR_NAME?= $(ECS_CLUSTER_ARN_OR_NAME)
ECS_AGENT_CLUSTER_NAME?= $(ECS_CLUSTER_NAME)
ECS_AGENT_CONTAINERINSTANCE_ARN?= $(ECS_CONTAINERINSTANCE_ARN)
ECS_AGENT_CONTAINERINSTANCE_ARN_OR_ID?= $(if $(ECS_AGENT_CONTAINERINSTANCE_ARN),$(ECS_AGENT_CONTAINERINSTANCE_ARN),$(ECS_AGENT_CONTAINERINSTANCE_ID))
ECS_AGENT_CONTAINERINSTANCE_ID?= $(ECS_CONTAINERINSTANCE_ID)
ECS_AGENT_CONTAINERINSTANCE_NAME?= $(ECS_CONTAINERINSTANCE_NAME)
ECS_AGENTS_CLUSTER_ARN?= $(ECS_AGENT_CLUSTER_ARN)
ECS_AGENTS_CLUSTER_ARN_OR_NAME?= $(if $(ECS_AGENTS_CLUSTER_ARN),$(ECS_AGENTS_CLUSTER_ARN),$(ECS_AGENTS_CLUSTER_NAME))
ECS_AGENTS_CLUSTER_NAME?= $(ECS_AGENT_CLUSTER_NAME)
ECS_AGENTS_CONTAINERINSTANCES_ARNS?= $(ECS_CONTAINERINSTANCES_ARNS)
ECS_AGENTS_CONTAINERINSTANCES_ARNS_OR_IDS?= $(if $(ECS_AGENTS_CONTAINERINSTANCES_ARNS),$(ECS_AGENTS_CONTAINERINSTANCES_ARNS),$(ECS_AGENTS_CONTAINERINSTANCES_IDS))
ECS_AGENTS_CONTAINERINSTANCES_IDS?= $(ECS_CONTAINERINSTANCES_IDS)

# Option parameters
__ECS_CLUSTER__AGENT= $(if $(ECS_AGENT_CLUSTER_ARN_OR_NAME),--cluster $(ECS_AGENT_CLUSTER_ARN_OR_NAME))
__ECS_CLUSTER__AGENTS= $(if $(ECS_AGENTS_CLUSTER_ARN_OR_NAME),--cluster $(ECS_AGENTS_CLUSTER_ARN_OR_NAME))
__ECS_CONTAINER_INSTANCE__AGENT= $(if $(ECS_AGENT_CONTAINERINSTANCE_ARN_OR_ID),--container-instance $(ECS_AGENT_CONTAINERINSTANCE_ARN_OR_ID))
__ECS_CONTAINER_INSTANCES__AGENT= $(if $(ECS_AGENT_CONTAINERINSTANCE_ARN_OR_ID),--container-instances $(ECS_AGENT_CONTAINERINSTANCE_ARN_OR_ID))
__ECS_CONTAINER_INSTANCES__AGENTS= $(if $(ECS_AGENTS_CONTAINERINSTANCES_ARNS_OR_IDS),--container-instances $(ECS_AGENTS_CONTAINERINSTANCES_ARNS_OR_IDS))
__ECS_INCLUDE__AGENT=
__ECS_INCLUDE__AGENTS=

# UI parameters
ECS_UI_SHOW_AGENT_FIELDS?= .{UpdateStatus:agentUpdateStatus,containerInstanceArn:containerInstanceArn,Connected:agentConnected,Version:versionInfo.agentVersion,DockerVersion:versionInfo.dockerVersion}
ECS_UI_VIEW_AGENTS_FIELDS?= $(ECS_UI_SHOW_AGENT_FIELDS)
ECS_UI_VIEW_AGENTS_SET_FIELDS?= $(ECS_UI_VIEW_AGENTS_FIELDS)
ECS_UI_VIEW_AGENTS_SET_QUERYFILTER?=

# Pipe parameters
|_ECS_VIEW_AGENTS?=
|_ECS_VIEW_AGENTS_SET?= $(|_ECS_VIEW_AGENTS)

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_ecs_view_framework_macros ::
	@echo 'AWS::ECS::Agent ($(_AWS_ECS_AGENT_MK_VERSION)) macros:'
	@echo

_ecs_view_framework_parameters ::
	@echo 'AWS::ECS::Agent ($(_AWS_ECS_AGENT_MK_VERSION)) parameters:'
	@echo '    ECS_AGENT_CLUSTER_ARN=$(ECS_AGENT_CLUSTER_ARN)'
	@echo '    ECS_AGENT_CLUSTER_ARN_OR_NAME=$(ECS_AGENT_CLUSTER_ARN_OR_NAME)'
	@echo '    ECS_AGENT_CLUSTER_NAME=$(ECS_AGENT_CLUSTER_NAME)'
	@echo '    ECS_AGENT_CONTAINERINSTANCE_ARN=$(ECS_AGENT_CONTAINERINSTANCE_ARN)'
	@echo '    ECS_AGENT_CONTAINERINSTANCE_ARN_OR_ID=$(ECS_AGENT_CONTAINERINSTANCE_ARN_OR_ID)'
	@echo '    ECS_AGENT_CONTAINERINSTANCE_ID=$(ECS_AGENT_CONTAINERINSTANCE_ID)'
	@echo '    ECS_AGENT_CONTAINERINSTANCE_NAME=$(ECS_AGENT_CONTAINERINSTANCE_NAME)'
	@echo '    ECS_AGENT_NAME=$(ECS_AGENT_NAME)'
	@echo '    ECS_AGENT_VERSION_ID=$(ECS_AGENT_VERSION_ID)'
	@echo '    ECS_AGENTS_CLUSTER_ARN=$(ECS_AGENTS_CLUSTER_ARN)'
	@echo '    ECS_AGENTS_CLUSTER_ARN_OR_NAME=$(ECS_AGENTS_CLUSTER_ARN_OR_NAME)'
	@echo '    ECS_AGENTS_CLUSTER_NAME=$(ECS_AGENTS_CLUSTER_NAME)'
	@echo '    ECS_AGENTS_CONTAINERINSTANCES_ARNS=$(ECS_AGENTS_CONTAINERINSTANCES_ARNS)'
	@echo '    ECS_AGENTS_CONTAINERINSTANCES_ARNS_OR_IDS=$(ECS_AGENTS_CONTAINERINSTANCES_ARNS_OR_IDS)'
	@echo '    ECS_AGENTS_CONTAINERINSTANCES_IDS=$(ECS_AGENTS_CONTAINERINSTANCES_IDS)'
	@echo '    ECS_AGENTS_SET_NAME=$(ECS_AGENTS_SET_NAME)'
	@echo

_ecs_view_framework_targets ::
	@echo 'AWS::ECS::Agent ($(_AWS_ECS_AGENT_MK_VERSION)) targets:'
	@echo '    _ecs_show_agent                                - Show everything related to an agent'
	@echo '    _ecs_show_agent_description                    - Show the description of an agent'
	@echo '    _ecs_show_agent_sshcommand                     - Show the ssh-command of an agent'
	@echo '    _ecs_update_agent                              - Update an agent'
	@echo '    _ecs_view_agents                               - View agents'
	@echo '    _ecs_view_agents_set                           - View a set of agents' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_ecs_show_agent :: _ecs_show_agent_sshcommand _ecs_show_agent_description

_ecs_show_agent_sshcommand:
	@$(INFO) '$(ECS_UI_LABEL)Showing agent of container-instance "$(ECS_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	# ssh in box and then: curl -s http://localhost:51678/v1/metadata | python -mjson.tool
	# {
	#    "Cluster": "myCluster",
	#    "ContainerInstanceArn": "arn:aws:ecs:us-west-2:123456789012:container-instance/99a9383f-be0a-4bfc-aa50-91a5c83c0501",
	#    "Version": "Amazon ECS Agent - v1.32.1 (4285f58f)"
	# }
	
_ecs_show_agent_description:
	@$(INFO) '$(ECS_UI_LABEL)Showing description of container-instance "$(ECS_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ecs describe-container-instances $(__ECS_CLUSTER__AGENT) $(__ECS_CONTAINER_INSTANCES__AGENT) $(__ECS_INCLUDE__AGENT) --query "containerInstances[]$(ECS_UI_SHOW_AGENT_FIELDS)"

_ecs_update_agent:
	@$(INFO) '$(ECS_UI_LABEL)Updating agent on container-instance "$(ECS_AGENT_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the agent is already at the latest version'; $(NORMAL)
	@echo 'You are about to update the agent on $(ECS_AGENT_CONTAINERINSTANCE_ARN_OR_ID)'
	@read -p 'Are you sure you want to proceed? (Ctrl-C to exit)' yesNo
	$(AWS) ecs update-container-agent $(__ECS_CLUSTER__AGENT) $(__ECS_CONTAINER_INSTANCE__AGENT) --query "containerInstance"

_ecs_view_agents:
	@$(INFO) '$(ECS_UI_LABEL)Viewing agents ...'; $(NORMAL)
	$(AWS) ecs describe-container-instances $(__ECS_CLUSTER__CONTAINERINSTANCES) $(__ECS_CONTAINER_INSTANCES__AGENTS) $(_X__ECS_INCLUDE__AGENTS) --query "containerInstances[]$(ECS_UI_VIEW_AGENTS_FIELDS)" $(|_ECS_VIEW_AGENTS)

_ecs_view_agents_set:
	@$(INFO) '$(ECS_UI_LABEL)Viewing agents-set "$(ECS_AGENTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Agents are grouped based on the provided cluster, container-instances, and query-filter'; $(NORMAL)
	$(AWS) ecs describe-container-instances $(__ECS_CLUSTER__CONTAINERINSTANCES) $(__ECS_CONTAINER_INSTANCES__AGENTS) $(_X__ECS_INCLUDE__AGENTS) --query "containerInstances[$(ECS_UI_VIEW_AGENTS_SET_QUERYFILTER)]$(ECS_UI_VIEW_AGENTS_SET_FIELDS)" $(|_ECS_VIEW_AGENTS_SET)
