_AWS_ECR_IMAGE_MK_VERSION= $(_AWS_ECR_MK_VERSION)

# ECR_IMAGE_REGISTRY_ID?= 123456789012
# ECR_IMAGE_REPOSITORY_NAME?= allspark-template
# ECR_IMAGES_FILTER?= tagStatus=TAGGED
# ECR_IMAGES_REGISTRY_ID?= 123456789012
# ECR_IMAGES_REPOSITORY_NAME?= allspark-template
# ECR_IMAGES_SET_NAME?=

# Derived parameters
ECR_IMAGE_REGISTRY_ID?= $(ECR_REGISTRY_ID)
ECR_IMAGE_REPOSITORY_NAME?= $(ECR_REPOSITORY_NAME)
ECR_IMAGES_REGISTRY_ID?= $(ECR_IMAGE_REGISTRY_ID)
ECR_IMAGES_REPOSITORY_NAME?= $(ECR_IMAGE_REPOSITORY_NAME)
ECR_IMAGES_SET_NAME?= $(ECR_IMAGES_REPOSITORY_NAME)

# Options parameters
__ECR_FILTER__IMAGES= $(if $(ECR_IMAGES_FILTER), --filter $(ECR_IMAGES_FILTER))
__ECR_REGISTRY_ID__IMAGES= $(if $(ECR_IMAGES_REGISTRY_ID), --registry-id $(ECR_IMAGES_REGISTRY_ID))
__ECR_REPOSITORY_NAME__IMAGES= $(if $(ECR_IMAGES_REPOSITORY_NAME), --repository-name $(ECR_IMAGES_REPOSITORY_NAME))

# UI parameters
ECR_UI_VIEW_IMAGES_FIELDS?=
ECR_UI_VIEW_IMAGES_SET_FIELDS?= $(ECR_UI_VIEW_IMAGES_FIELDS)
ECR_UI_VIEW_IMAGES_SET_SLICE?= # ?contains(imageTag,'v2018')
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ecr_view_framework_macros ::
	@echo 'AWS::ECR::Image ($(_AWS_ECR_REGISTRY_MK_VERSION)) macros:'
	@echo

_ecr_view_framework_parameters ::
	@echo 'AWS::ECR::Image ($(_AWS_ECR_REGISTRY_MK_VERSION)) parameters:'
	@echo '    ECR_IMAGE_REGISTRY_ID=$(ECR_IMAGE_REGISTRY_ID)'
	@echo '    ECR_IMAGE_REPOSITORY_NAME=$(ECR_IMAGE_REPOSITORY_NAME)'
	@echo '    ECR_IMAGES_FILTER=$(ECR_IMAGES_FILTER)'
	@echo '    ECR_IMAGES_REGISTRY_ID=$(ECR_IMAGES_REGISTRY_ID)'
	@echo '    ECR_IMAGES_REPOSITORY_NAME=$(ECR_IMAGES_REPOSITORY_NAME)'
	@echo '    ECR_IMAGES_SET_NAME=$(ECR_IMAGES_SET_NAME)'
	@echo

_ecr_view_framework_targets ::
	@echo 'AWS::ECR::Image ($(_AWS_ECR_REGISTRY_MK_VERSION)) targets:'
	@echo '    _ecr_view_images                    - View images'
	@echo '    _ecr_view_images_set                - View a set of images'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ecr_view_images:
	@$(INFO) '$(ECR_UI_LABEL)Viewing images in repository "$(ECR_IMAGES_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) ecr list-images $(_X_ECR_FILTER__IMAGES) $(__ECR_REGISTRY_ID__IMAGES) $(__ECR_REPOSITORY_NAME__IMAGES) --query "imageIds[]$(ECR_UI_VIEW_IMAGES_FIELDS)"

_ecr_view_images_set:
	@$(INFO) '$(ECR_UI_LABEL)Viewing images-set "$(ECR_IMAGES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Images are grouped based on provided repository, filter, slice'; $(NORMAL)
	$(AWS) ecr list-images $(__ECR_FILTER__IMAGES) $(__ECR_REGISTRY_ID__IMAGES) $(__ECR_REPOSITORY_NAME__IMAGES) --query "imageIds[$(ECR_UI_VIEW_IMAGES_SET_SLICE)]$(ECR_UI_VIEW_IMAGES_SET_FIELDS)"
