_AWS_ECSCLI_SERVICE_MK_VERSION= $(_AWS_ECSCLI_MK_VERSION)

# ECI_SERVICE_CLUSTER_NAME?=
# ECI_SERVICE_DIRPATH?=
# ECI_SERVICE_NAME?=
# ECI_SERVICE_TIMEOUT?=
# ECI_SERVICES_CLUSTER_NAME?=
# ECI_SERVICES_SET_NAME?=

# Derived parameters
ECI_SERVICE_DIRPATH?= $(ECI_INPUTS_DIRPATH)
ECI_SERVICE_CLUSTER_NAME?= $(ECI_CLUSTER_NAME)
ECI_SERVICES_CLUSTER_NAME?= $(ECI_SERVICE_CLUSTER_NAME)

# Options parameters
__ECI_CLUSTER__SERVICE= $(if $(ECI_SERVICE_CLUSTER_NAME),--cluster $(ECI_SERVICE_CLUSTER_NAME))
__ECI_CLUSTER__SERVICES= $(if $(ECI_SERVICES_CLUSTER_NAME),--cluster $(ECI_SERVICES_CLUSTER_NAME))
__ECI_TIMEOUT__SERVICE= $(if $(ECI_SERVICE_TIMEOUT),--timeout $(ECI_SERVICE_TIMEOUT))

# Pipe parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_eci_view_framework_macros ::
	@echo 'AWS::EcsClI::Service ($(_AWS_ECSCLI_SERVICE_MK_VERSION)) macros:'
	@echo

_eci_view_framework_parameters ::
	@echo 'AWS::EcsClI::Service ($(_AWS_ECSCLI_SERVICE_MK_VERSION)) parameters:'
	@echo '    ECI_SERVICE_CLUSTER_NAME=$(ECI_SERVICE_CLUSTER_NAME)'
	@echo '    ECI_SERVICE_DIRPATH=$(ECI_SERVICE_DIRPATH)'
	@echo '    ECI_SERVICE_NAME=$(ECI_SERVICE_NAME)'
	@echo '    ECI_SERVICE_TIMEOUT=$(ECI_SERVICE_TIMEOUT)'
	@echo '    ECI_SERVICES_CLUSTER_NAME=$(ECI_SERVICES_CLUSTER_NAME)'
	@echo '    ECI_SERVICES_SET_NAME=$(ECI_SERVICES_SET_NAME)'
	@echo

_eci_view_framework_targets ::
	@echo 'AWS::EcsClI::Service ($(_AWS_ECSCLI_SERVICE_MK_VERSION)) targets:'
	@echo '    _eci_create_service                  - Create a new service'
	@echo '    _eci_delete_service                  - Delete an existing service'
	@echo '    _eci_show_service                    - Show everything related to a service'
	@echo '    _eci_show_service_containers         - Show the containers of a service'
	@echo '    _eci_show_service_description        - Show the description of a service'
	@echo '    _eci_view_services                   - View services'
	@echo '    _eci_view_services                   - View a set of services'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_eci_create_service:
	@$(INFO) '$(ECI_UI_LABEL)Creating service "$(ECI_SERVICE_NAME)" ...'; $(NORMAL)
	#cd $(ECI_TASKDEFINITION_DIRPATH) && $(ECSCLI) compose create $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER__TASKDEFINITION) $(__ECI_CREATE_LOG_GROUPS__TASKDEFINITION) $(__ECI_LAUNCH_TYPE__TASKDEFINITION) $(__ECI_REGION) $(__ECI_TAGS__TASKDEFINITION) $(_X__ECI_ECS_PARAMS) $(_X__ECI_FILE) $(__ECI_REGION) $(__ECI_TASK_ROLE_ARN)

_eci_delete_service:
	@$(INFO) '$(ECI_UI_LABEL)Deleting service "$(ECI_SERVICE_NAME)" ...'; $(NORMAL)
	# cd $(ECI_SERVICE_DIRPATH) && $(ECSCLI) compose service rm /delete/down $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER__SERVICES) $(__ECI_REGION__SERVICES) $(__ECI_TIMEOUT__SERVICE)

_eci_scale0_service:
	@$(INFO) '$(ECI_UI_LABEL)Scaling to 0 the service "$(ECI_SERVICE_NAME)" ...'; $(NORMAL)
	cd $(ECI_SERVICE_DIRPATH) && $(ECSCLI) compose service stop $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER__SERVICES) $(__ECI_REGION__SERVICES) $(__ECI_TIMEOUT__SERVICE)

_eci_show_service :: _eci_show_service_containers _eci_show_service_description

_eci_show_service_containers:
	@$(INFO) '$(ECI_UI_LABEL)Showing containers of service "$(ECI_SERVICE_NAME)" ...'; $(NORMAL)
	cd $(ECI_SERVICE_DIRPATH) && $(ECSCLI) compose service ps $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER__SERVICES) $(__ECI_DESIRED_STATUS__SERVICE) $(__ECI_REGION__SERVICES)

_eci_show_service_description: 
	@$(INFO) '$(ECI_UI_LABEL)Showing description of service "$(ECI_SERVICE_NAME)" ...'; $(NORMAL)

_eci_view_services:
	@$(INFO) '$(ECI_UI_LABEL)Viewing services ...'; $(NORMAL)

_eci_view_services_set:
	@$(INFO) '$(ECI_UI_LABEL)Viewing services-set "$(ECI_SERVICES_SET_NAME)" ...'; $(NORMAL)
