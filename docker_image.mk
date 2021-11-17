_DOCKER_IMAGE_MK_VERSION= $(_DOCKER_MK_VERSION)

# DKR_IMAGE_BUILD_ENVVARS?= HTTP_PROXY FTP_PROXY=http://40.50.60.5:4567 ...
# DKR_IMAGE_DELETE_FORCE?= false
# DKR_IMAGE_DIGEST?= sha256:cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf
# DKR_IMAGE_DOCKERFILE_DIRPATH?= ./in/
DKR_IMAGE_DOCKERFILE_FILENAME?= Dockerfile
# DKR_IMAGE_DOCKERFILE_FILEPATH?= ./Dockerfile
# DKR_IMAGE_DOCKERFILE_STDIN?= false
# DKR_IMAGE_DOCKERFILE_URL?=
# DKR_IMAGE_FAMILY_NAME?= localhost:5000/test/busybox
# DKR_IMAGE_ID?= fbb64f80360b
# DKR_IMAGE_ID_OR_NAME?=
# DKR_IMAGE_NAME?= localhost:5000/test/busybox@sha256:cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf
# DKR_IMAGE_REPOSITORY_CNAME?= myregistryhost:5000/emayssatware/pilot
# DKR_IMAGE_REPOSITORY_NAME?= emayssatware/pilot
# DKR_IMAGE_SHA256?= cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf
# DKR_IMAGE_TAG?= 14.04
# DKR_IMAGE_TAR_FILEPATH?= ./myimage.tar
# DKR_IMAGES_FILTER?=
# DKR_IMAGES_SET_NAME?= my-images-set

# Derived parameters
DKR_IMAGE_NAME?= $(DKR_IMAGE_FAMILY_NAME)$(if $(DKR_IMAGE_TAG),:$(DKR_IMAGE_TAG))$(if $(DKR_IMAGE_DIGEST),@$(DKR_IMAGE_DIGEST))#
DKR_IMAGE_DIGEST?= sha256:$(DKR_IMAGE_SHA256)
DKR_IMAGE_DOCKERFILE_DIRPATH?= $(DKR_INPUTS_DIRPATH)
DKR_IMAGE_DOCKERFILE_FILEPATH?= $(DKR_IMAGE_DOCKERFILE_DIRPATH)$(DKR_IMAGE_DOCKERFILE_FILENAME)
DKR_IMAGE_ID?= $(DKR_IMAGE_SHA256)#
DKR_IMAGE_ID_OR_NAME?= $(if $(DKR_IMAGE_ID),$(DKR_IMAGE_ID),$(DKR_IMAGE_NAME))#
DKR_IMAGE_FAMILY_NAME?= $(DKR_IMAGE_REPOSITORY_CNAME)
DKR_IMAGE_REPOSITORY_CNAME?= $(DKR_REPOSITORY_CNAME)
DKR_IMAGE_REPOSITORY_NAME?= $(DKR_REPOSITORY_NAME)

# Options
__DKR_BEFORE=
__DKR_BUILD_ARG= $(foreach V,$(DKR_IMAGE_BUILD_ENVVARS),--build-arg $(V) )
__DKR_DIGESTS= $(if $(filter true, $(DKR_IMAGE_LISTDIGESTS_FLAG)),--digests)
__DKR_FILE= $(if $(DKR_IMAGE_DOCKERFILE_FILEPATH),--file $(DKR_IMAGE_DOCKERFILE_FILEPATH))
__DKR_FILTER__IMAGES= $(if $(DKR_IMAGES_FILTER),--filter $(DKR_IMAGES_FILTER))
__DKR_FORCE__IMAGE= $(if $(filter true, $(DKR_IMAGE_DELETE_FORCE)),--force)
__DKR_INPUT= $(if $(DKR_IMAGE_TAR_FILEPATH),--input $(DKR_IMAGE_TAR_FILEPATH))
__DKR_LATEST= --latest $(DKR_PS_LATEST)
__DKR_OUTPUT= $(if $(DKR_IMAGE_TAR_FILEPATH),--output $(DKR_IMAGE_TAR_FILEPATH))
__DKR_PRUNE=
__DKR_SINCE=
__DKR_SIZE=
__DKR_TAG= $(if $(DKR_IMAGE_NAME),--tag=$(DKR_IMAGE_NAME))# The tag is in the image name!

# Customizations
_DKR_RESTORE_IMAGE_|?=
|_DKR_RESTORE_IMAGE?=
|_DKR_SAVE_IMAGE?= # | gzip > myimage_latest.tar.gz

# Macros
_dkr_get_image_id= $(call _dkr_get_image_N, $(DKR_IMAGE_NAME))
_dkr_get_image_id_N= $(shell $(DOCKER) images --filter reference=$(1) --quiet )

#----------------------------------------------------------------------
# USAGE
#

_dkr_list_macros ::
	@echo 'DocKeR::Image ($(_DOCKER_IMAGE_MK_VERSION)) macros:'
	@echo '    _dkr_get_image_id_{|N}        - Get the ID of an image (Name)'
	@echo

_dkr_list_parameters ::
	@echo 'DocKeR::Image ($(_DOCKER_IMAGE_MK_VERSION)) parameters:'
	@echo '    DKR_IMAGE_BUILD_ENVVARS=$(DKR_IMAGE_BUILD_ENVVARS)'
	@echo '    DKR_IMAGE_DELETE_FORCE=$(DKR_IMAGE_DELETE_FORCE)'
	@echo '    DKR_IMAGE_DOCKERFILE_DIRPATH=$(DKR_IMAGE_DOCKERFILE_DIRPATH)'
	@echo '    DKR_IMAGE_DOCKERFILE_FILENAME=$(DKR_IMAGE_DOCKERFILE_FILENAME)'
	@echo '    DKR_IMAGE_DOCKERFILE_FILEPATH=$(DKR_IMAGE_DOCKERFILE_FILEPATH)'
	@echo '    DKR_IMAGE_DOCKERFILE_STDIN=$(DKR_IMAGE_DOCKERFILE_STDIN)'
	@echo '    DKR_IMAGE_DOCKERFILE_URL=$(DKR_IMAGE_DOCKERFILE_URL)'
	@echo '    DKR_IMAGE_FAMILY_NAME=$(DKR_IMAGE_FAMILY_NAME)'
	@echo '    DKR_IMAGE_ID=$(DKR_IMAGE_ID)'
	@echo '    DKR_IMAGE_ID_OR_NAME=$(DKR_IMAGE_ID_OR_NAME)'
	@echo '    DKR_IMAGE_NAME=$(DKR_IMAGE_NAME)'
	@echo '    DKR_IMAGE_REPOSITORY_CNAME=$(DKR_IMAGE_REPOSITORY_CNAME)'
	@echo '    DKR_IMAGE_REPOSITORY_NAME=$(DKR_IMAGE_REPOSITORY_NAME)'
	@echo '    DKR_IMAGE_SHA256=$(DKR_IMAGE_SHA256)'
	@echo '    DKR_IMAGE_TAG=$(DKR_IMAGE_TAG)'
	@echo '    DKR_IMAGE_TAR_FILEPATH=$(DKR_IMAGE_TAR_FILEPATH)'
	@echo '    DKR_IMAGES_FILTER=$(DKR_IMAGES_FILTER)'
	@echo '    DKR_IMAGES_SET_NAME=$(DKR_IMAGES_SET_NAME)'
	@echo

_dkr_list_targets ::
	@echo 'DocKeR::Image ($(_DOCKER_IMAGE_MK_VERSION)) targets:'
	@echo '    _dkr_build_image               - Build an image based on a Dockerfile'
	@echo '    _dkr_clean_images              - Clean dangling/untagged images'
	@echo '    _dkr_delete_image              - Delete an existing image'
	@echo '    _dkr_pull_image                - Pull image from docker registry'
	@echo '    _dkr_purge_images              - Purge entire content of local image-cache'
	@echo '    _dkr_push_image                - Push image to docker registry'
	@echo '    _dkr_restore_image             - Restore a saved image'
	@echo '    _dkr_save_image                - Save an image'
	@echo '    _dkr_show_image                - Show everything related to an image'
	@echo '    _dkr_show_image_object         - Inspect an existing image'
	@echo '    _dkr_list_images               - List all images'
	@echo '    _dkr_list_images_set           - List a set of images'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

_dkr_build_image:
	@$(INFO) '$(DKR_UI_LABEL)Building image ...'; $(NORMAL)
	$(DOCKER) image build $(__DKR_BUILD_ARG) $(__DKR_FILE) $(__DKR_TAG) $(DKR_IMAGE_DOCKERFILE_DIRPATH) $(DKR_DOCKERFILE_URL)

_dkr_clean_images:
	@$(INFO) '$(DKR_UI_LABEL)Cleaning images ...'; $(NORMAL)
	@$(WARN) 'This operation removes dangling/untagged images if any, fails otherwise!'; $(NORMAL)
	$(DOCKER) images --filter dangling=true
	-$(DOCKER) images --filter dangling=true --quiet | xargs $(DOCKER) image rm

_dkr_delete_image:
	@$(INFO) '$(DKR_UI_LABEL)Deleting image "$(DKR_IMAGE_ID_OR_NAME)" ...'; $(NORMAL)
	$(DOCKER) image rm $(__DKR_FORCE__IMAGE) $(__DKR_PRUNE) $(DKR_IMAGE_ID_OR_NAME)

_dkr_list_images:
	@$(INFO) '$(DKR_UI_LABEL)Listing ALL images ...'; $(NORMAL)
	$(DOCKER) images $(__DKR_DIGESTS) $(_X__DKR_FILTER__IMAGES)

_dkr_list_images_set:
	@$(INFO) '$(DKR_UI_LABEL)Listing images-set "$(DKR_IMAGES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Images are grouped based on provided filter'; $(NORMAL)
	$(DOCKER) images $(__DKR_DIGESTS) $(__DKR_FILTER__IMAGES)

_dkr_pull_image:
	@$(INFO) '$(DKR_UI_LABEL)Pulling image "$(DKR_IMAGE_CNAME)" from registry ...'; $(NORMAL)
	@$(WARN) 'Official image-name ubuntu:16.04 ~= registry.hub.docker.com/library/ubuntu:16.04'; $(NORMAL)
	@$(WARN) 'This operation fails if you are pulling from an existing but EMPTY repository!'; $(NORMAL)
	@$(WARN) 'This operation fails if you are required, but not yet logged in the repository!'; $(NORMAL)
	$(DOCKER) image pull $(__DKR_ALL_TAGS) $(__DKR_DISABLE_CONTENT_TRUST) $(DKR_IMAGE_CNAME)

_dkr_purge_images:
	@$(INFO) '$(DKR_UI_LABEL)Deleting local image-cache ...'; $(NORMAL)
	@$(WARN) 'This operation fails if a container is using one of the images. Purge container first!'; $(NORMAL)
	docker rmi $$(docker images -q)

_dkr_push_image:
	@$(INFO) '$(DKR_UI_LABEL)Pushing image "$(DKR_IMAGE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if you are not already logged in the registry where the repo is located'; $(NORMAL)
	@$(WARN) 'This operation creates a repository if it does not already exist, but image push will? fail'; $(NORMAL)
	$(DOCKER) image push $(__DKR_ALL_TAGS) $(__DKR_DISABLE_CONTENT_TRUST) $(DKR_IMAGE_NAME)

_dkr_restore_image:
	@$(INFO) '$(DKR_UI_LABEL)Restoring image "$(DKR_IMAGE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will restore the image content, but not its tags'; $(NORMAL)
	$(_DKR_RESTORE_IMAGE_|) $(DOCKER) load $(__DKR_INPUT) $(|_DKR_RESTORE_IMAGE)

_dkr_save_image:
	@$(INFO) '$(DKR_UI_LABEL)Saving image "$(DKR_IMAGE_NAME)" ...'; $(NORMAL)
	$(DOCKER) save $(__DKR_OUTPUT) $(DKR_IMAGE_NAME) $(|_DKR_SAVE_IMAGE)

_DKR_SHOW_IMAGE_TARGETS?= _dkr_show_image_object _dkr_show_image_tags _dkr_show_image_description
_dkr_show_image: $(_DKR_SHOW_IMAGE_TARGETS)

_dkr_show_image_description:
	@$(INFO) '$(DKR_UI_LABEL)Showing description of image "$(DKR_IMAGE_ID_OR_NAME)" ...'; $(NORMAL)
	$(DOCKER) image list | head -1
	$(DOCKER) image list | grep $(DKR_IMAGE_ID_OR_NAME)

_dkr_show_image_object:
	@$(INFO) '$(DKR_UI_LABEL)Showing object of image "$(DKR_IMAGE_ID_OR_NAME)" ...'; $(NORMAL)
	$(DOCKER) image inspect $(DKR_IMAGE_ID_OR_NAME)

_dkr_show_image_tags:
	@$(INFO) '$(DKR_UI_LABEL)Showing tags of image "$(DKR_IMAGE_ID_OR_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'This operation fails if the image id is not set'; $(NORMAL)
	-#$(DOCKER) image list | grep $(DKR_IMAGE_ID)
