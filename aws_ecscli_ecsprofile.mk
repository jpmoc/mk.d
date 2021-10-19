_AWS_ECSCLI_ECSPROFILE_MK_VERSION= $(_AWS_ECSCLI_MK_VERSION)

# ECI_ECSPROFILE_ACCESS_KEY?=
ECI_ECSPROFILE_NAME?= default
# ECI_ECSPROFILE_SECRET_KEY?=
# ECI_ECSPROFILE_SESSION_TOKEN?=
# ECI_ECSPROFILES_SET_NAME?=

# Derived parameters

# Options parameters
__ECI_ACCESS_KEY= $(if $(ECI_ECSPROFILE_ACCESS_KEY),--access-key $(ECS_ECSPROFILE_ACCESS_KEY))
__ECI_PROFILE_NAME= $(if $(ECI_ECSPROFILE_NAME),--profile-name $(ECI_ECSPROFILE_NAME))
__ECI_SECRET_KEY= $(if $(ECI_ECSPROFILE_SECRET_KEY),--secret-key $(ECS_ECSPROFILE_SECRET_KEY))
__ECI_SESSION_TOKEN= $(if $(ECI_ECSPROFILE_SESSION_TOKEN),--session-token $(ECS_ECSPROFILE_SESSION_TOKEN))

# Pipe parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_eci_view_framework_macros ::
	@echo 'AWS::EcsClI::EcsProfile ($(_AWS_ECSCLI_ECSPROFILE_MK_VERSION)) macros:'
	@echo

_eci_view_framework_parameters ::
	@echo 'AWS::EcsClI::EcsProfile ($(_AWS_ECSCLI_ECSPROFILE_MK_VERSION)) parameters:'
	@echo '    ECI_ECSPROFILE_ACCESS_KEY=$(ECI_ECSPROFILE_ACCESS_KEY)'
	@echo '    ECI_ECSPROFILE_NAME=$(ECI_ECSPROFILE_NAME)'
	@echo '    ECI_ECSPROFILE_SECRET_KEY=$(ECI_ECSPROFILE_SECRET_KEY)'
	@echo '    ECI_ECSPROFILE_SESSION_TOKEN=$(ECI_ECSPROFILE_SESSION_TOKEN)'
	@echo '    ECI_ECSPROFILES_SET_NAME=$(ECI_ECSPROFILES_SET_NAME)'
	@echo

_eci_view_framework_targets ::
	@echo 'AWS::EcsClI::EcsProfile ($(_AWS_ECSCLI_ECSPROFILE_MK_VERSION)) targets:'
	@echo '    _eci_create_ecsprofile                  - Create a ecs-profile'
	@echo '    _eci_delete_ecsprofile                  - Delete an existing ecs-profile'
	@echo '    _eci_setdefault_ecsprofile              - Set ecs-profile'
	@echo '    _eci_show_ecsprofile                    - Show everything related to a ecs-profile'
	@echo '    _eci_show_ecsprofile_description        - Show the description of a ecs-profile'
	@echo '    _eci_view_ecsprofiles                   - View ecs-profiles'
	@echo '    _eci_view_ecsprofiles_set               - View a set of ecs-profiles'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_eci_create_ecsprofile:
	@$(INFO) '$(ECI_UI_LABEL)Creating ecs-profile "$(ECI_ECSPROFILE_NAME)" ...'; $(NORMAL)
	$(ECSCLI) configure $(__ECI_ACCESS_KEY) $(__ECI_PROFILE_NAME) $(__ECI_SECRET_KEY) $(__ECI_SESSION_TOKEN)

_eci_delete_ecsprofile:
	@$(INFO) '$(ECI_UI_LABEL)Deleting ecs-profile "$(ECI_ECSPROFILE_NAME)" ...'; $(NORMAL)
	# $(ECSCLI) down $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER) $(__ECI_FORCE) $(__ECI_REGION) $(__ECI_VERBOSE)

_eci_setdefault_ecsprofile:
	@$(INFO) '$(ECI_UI_LABEL)Setting default to ecs-profile "$(ECI_ECSPROFILE_NAME)" ...'; $(NORMAL)
	$(ECSCLI) configure profile default $(__ECI_PROFILE_NAME)

_eci_show_ecsprofile :: _eci_show_ecsprofile_description

_eci_show_ecsprofile_description: 
	@$(INFO) '$(ECI_UI_LABEL)Showing description of ecs-profile "$(ECI_ECSPROFILE_NAME)" ...'; $(NORMAL)

_eci_view_ecsprofiles:
	@$(INFO) '$(ECI_UI_LABEL)Viewing ecs-profiles ...'; $(NORMAL)
	cat $(ECI_ECSPROFILES_FILEPATH)

_eci_view_ecsprofiles_set:
	@$(INFO) '$(ECI_UI_LABEL)Viewing ecs-profiles-set "$(ECI_ECSPROFILES_SET_NAME)" ...'; $(NORMAL)
