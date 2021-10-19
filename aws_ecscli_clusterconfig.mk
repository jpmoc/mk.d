_AWS_ECSCLI_CLUSTERCONFIG_MK_VERSION= $(_AWS_ECSCLI_MK_VERSION)

# ECI_CLUSTERCONFIG_CLUSTER_NAME?=
# ECI_CLUSTERCONFIG_LAUNCH_TYPE?= FARGATE
# ECI_CLUSTERCONFIG_NAME?=
# ECI_CLUSTERCONFIG_REGION_ID?= us-west-1
# ECI_CLUSTERCONFIG_STACK_NAME?=
ECI_CLUSTERCONFIGS_FILEPATH?= $(HOME)/.ecs/config
# ECI_CLUSTERCONFIGS_SET_NAME?=

# Derived parameters
ECI_CLUSTERCONFIG_CLUSTER_NAME?= $(ECI_CLUSTER_NAME)
ECI_CLUSTERCONFIG_LAUNCH_TYPE?= $(ECI_LAUNCH_TYPE)
ECI_CLUSTERCONFIG_REGION_ID?= $(ECI_REGION_ID)
ECI_CLUSTERCONFIG_STACK_NAME?= $(ECI_CLUSTER_STACK_NAME)

# Options parameters
__ECI_CFN_STACK_NAME= $(if $(ECI_CLUSTERCONFIG_STACK_NAME),--cfn-stack-name $(ECI_CLUSTERCONFIG_STACK_NAME))
__ECI_CLUSTER__CLUSTERCONFIG= $(if $(ECI_CLUSTERCONFIG_CLUSTER_NAME),--cluster $(ECI_CLUSTERCONFIG_CLUSTER_NAME))
__ECI_CONFIG_NAME= $(if $(ECI_CLUSTERCONFIG_NAME),--config-name $(ECI_CLUSTERCONFIG_NAME))
__ECI_DEFAULT_LAUNCH_TYPE= $(if $(ECI_CLUSTERCONFIG_LAUNCH_TYPE),--default-launch-type $(ECI_CLUSTERCONFIG_LAUNCH_TYPE))
__ECI_REGION__CLUSTERCONFIG= $(if $(ECI_CLUSTERCONFIG_REGION_ID),--region $(ECI_CLUSTERCONFIG_REGION_ID))

# Pipe parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_eci_view_framework_macros ::
	@echo 'AWS::EcsClI::ClusterConfig ($(_AWS_ECSCLI_CLUSTERCONFIG_MK_VERSION)) macros:'
	@echo

_eci_view_framework_parameters ::
	@echo 'AWS::EcsClI::ClusterConfig ($(_AWS_ECSCLI_CLUSTERCONFIG_MK_VERSION)) parameters:'
	@echo '    ECI_CLUSTERCONFIG_CLUSTER_NAME=$(ECI_CLUSTERCONFIG_CLUSTER_NAME)'
	@echo '    ECI_CLUSTERCONFIG_LAUNCH_TYPE=$(ECI_CLUSTERCONFIG_LAUNCH_TYPE)'
	@echo '    ECI_CLUSTERCONFIG_NAME=$(ECI_CLUSTERCONFIG_NAME)'
	@echo '    ECI_CLUSTERCONFIG_REGION_ID=$(ECI_CLUSTERCONFIG_REGION_ID)'
	@echo '    ECI_CLUSTERCONFIG_STACK_NAME=$(ECI_CLUSTERCONFIG_STACK_NAME)'
	@echo '    ECI_CLUSTERCONFIGS_SET_NAME=$(ECI_CLUSTERCONFIGS_SET_NAME)'
	@echo

_eci_view_framework_targets ::
	@echo 'AWS::EcsClI::ClusterConfig ($(_AWS_ECSCLI_CLUSTERCONFIG_MK_VERSION)) targets:'
	@echo '    _eci_create_clusterconfig                  - Create a cluster-config'
	@echo '    _eci_delete_clusterconfig                  - Delete an existing cluster-config'
	@echo '    _eci_setdefault_clusterconfig              - Set cluster-config'
	@echo '    _eci_show_clusterconfig                    - Show everything related to a cluster-config'
	@echo '    _eci_show_clusterconfig_description        - Show the description of a cluster-config'
	@echo '    _eci_view_clusterconfigs                   - View cluster-configs'
	@echo '    _eci_view_clusterconfigs_set               - View a set of cluster-configs'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_eci_create_clusterconfig:
	@$(INFO) '$(ECI_UI_LABEL)Creating cluster-config "$(ECI_CLUSTERCONFIG_NAME)" ...'; $(NORMAL)
	$(ECSCLI) configure $(__ECI_CFN_STACK_NAME) $(__ECI_CONFIG_NAME) $(__ECI_DEFAULT_LAUNCH_TYPE) $(__ECI_CLUSTER__CLUSTERCONFIG) $(__ECI_REGION__CLUSTERCONFIG)

_eci_delete_clusterconfig:
	@$(INFO) '$(ECI_UI_LABEL)Deleting cluster-config "$(ECI_CLUSTERCONFIG_NAME)" ...'; $(NORMAL)
	# $(ECSCLI) down $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER) $(__ECI_FORCE) $(__ECI_REGION) $(__ECI_VERBOSE)

_eci_setdefault_clusterconfig:
	@$(INFO) '$(ECI_UI_LABEL)Setting default cluster-config to cluster-config "$(ECI_CLUSTERCONFIG_NAME)" ...'; $(NORMAL)
	$(ECSCLI) configure default $(__ECI_CONFIG_NAME)

_eci_show_clusterconfig :: _eci_show_clusterconfig_description

_eci_show_clusterconfig_description: 
	@$(INFO) '$(ECI_UI_LABEL)Showing description of cluster-config "$(ECI_CLUSTERCONFIG_NAME)" ...'; $(NORMAL)

_eci_view_clusterconfigs:
	@$(INFO) '$(ECI_UI_LABEL)Viewing cluster-configs ...'; $(NORMAL)
	cat $(ECI_CLUSTERCONFIGS_FILEPATH)

_eci_view_clusterconfigs_set:
	@$(INFO) '$(ECI_UI_LABEL)Viewing cluster-configs-set "$(ECI_CLUSTERCONFIGS_SET_NAME)" ...'; $(NORMAL)
