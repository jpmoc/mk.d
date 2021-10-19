_AWS_ECSCLI_IMAGE_MK_VERSION= $(_AWS_ECSCLI_MK_VERSION)

# ECI_IMAGE_CNAME?=
# ECI_IMAGE_DIGEST?=
# ECI_IMAGE_NAME?=
# ECI_IMAGE_REGION_ID?= us-west-2
# ECI_IMAGE_REGISTRY_ID?=
# ECI_IMAGE_REPOSITORY_NAME?=
# ECI_IMAGE_TAGGED_FLAG?= false
# ECI_IMAGE_TAGS_KEYVALUES?=
# ECI_IMAGE_USEFIPS_FLAG?=
# ECI_IMAGES_SET_NAME?=

# Derived parameters
ECI_IMAGE_REGISTRY_ID= $(ECI_ACCOUNT_ID)

# Options parameters
__ECI_REGION__IMAGE= $(if $(ECI_IMAGE_REGION_ID),--region $(ECS_IMAGE_REGION_ID))
__ECI_REGISTRY_ID=#$(if $(ECI_IMAGE_REGISTRY_ID),--registry-id $(ECI_IMAGE_REGISTRY_ID))
__ECI_TAGGED= $(if $(filter true, $(ECI_IMAGE_TAGGED_FLAG)),--tagged)$(if $(filter false, $(ECI_IMAGE_TAGGED_FLAG)),--untagged)
__ECI_TAGS__IMAGE= $(if $(ECI_IMAGE_TAGS_KEYVALUES),--tags $(ECS_IMAGE_TAGS_KEYVALUES))
__ECI_USE_FIPS=

# Pipe parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_eci_view_framework_macros ::
	@echo 'AWS::EcsClI::Image ($(_AWS_ECSCLI_IMAGE_MK_VERSION)) macros:'
	@echo

_eci_view_framework_parameters ::
	@echo 'AWS::EcsClI::Image ($(_AWS_ECSCLI_IMAGE_MK_VERSION)) parameters:'
	@echo '    ECI_IMAGE_CNAME=$(ECI_IMAGE_CNAME)'
	@echo '    ECI_IMAGE_DIGEST=$(ECI_IMAGE_DIGEST)'
	@echo '    ECI_IMAGE_NAME=$(ECI_IMAGE_NAME)'
	@echo '    ECI_IMAGE_REGION_ID=$(ECI_IMAGE_REGION_ID)'
	@echo '    ECI_IMAGE_REGISTRY_ID=$(ECI_IMAGE_REGISTRY_ID)'
	@echo '    ECI_IMAGE_TAGGED_FLAG=$(ECI_IMAGE_TAGGED_FLAG)'
	@echo '    ECI_IMAGE_TAGS_KEYVALUES=$(ECI_IMAGE_TAGS_KEYVALUES)'
	@echo '    ECI_IMAGE_USEFIPS_FLAG=$(ECI_IMAGE_USEFIPS_FLAG)'
	@echo '    ECI_IMAGES_SET_NAME=$(ECI_IMAGES_SET_NAME)'
	@echo

_eci_view_framework_targets ::
	@echo 'AWS::EcsClI::Image ($(_AWS_ECSCLI_IMAGE_MK_VERSION)) targets:'
	@echo '    _eci_pull_image                         - Pull image'
	@echo '    _eci_push_image                         - Push image'
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

_eci_pull_image:
	@$(INFO) '$(ECI_UI_LABEL)Pulling image "$(ECI_IMAGE_NAME)" ...'; $(NORMAL)
	$(ECSCLI) pull $(__ECI_AWS_PROFILE) $(__ECI_REGION__IMAGE) $(__ECI_REGISTRY_ID) $(__ECI_USE_FIPS) $(__ECI_VERBOSE) $(ECI_IMAGE_CNAME)

_eci_push_image:
	@$(INFO) '$(ECI_UI_LABEL)Pushing image "$(ECI_IMAGE_NAME)" ...'; $(NORMAL)
	$(ECSCLI) push $(__ECI_AWS_PROFILE) $(__ECI_REGION__IMAGE) $(__ECI_REGISTRY_ID) $(__ECI_TAGS__IMAGE) $(__ECI_USE_FIPS) $(__ECI_VERBOSE) $(ECI_IMAGE_CNAME)

_eci_show_image :: _eci_show_image_description

_eci_show_image_description: 
	@$(INFO) '$(ECI_UI_LABEL)Showing description of image "$(ECI_IMAGE_NAME)" ...'; $(NORMAL)

_eci_view_images:
	@$(INFO) '$(ECI_UI_LABEL)Viewing images ...'; $(NORMAL)
	$(ECSCLI) images $(__ECI_AWS_PROFILE) $(__ECI_REGION__IMAGES) $(__ECI_REGISTRY_ID) $(__ECI_TAGGED) $(__ECI_USE_FIPS) $(__ECI_VERBOSE) $(ECI_IMAGE_REPOSITORY_NAME)

_eci_view_images_set:
	@$(INFO) '$(ECI_UI_LABEL)Viewing images-set "$(ECI_IMAGES_SET_NAME)" ...'; $(NORMAL)
