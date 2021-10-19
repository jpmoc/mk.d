_OPENSTACK_IMAGE_MK_VERSION= 0.99.3

OSI_CONTAINER_FORMAT?= bare # ami, ari, aki, bare, docker, ova, ovf
# OSI_DOWNLOAD_URL?= https://download.fedoraproject.org/pub/fedora/linux/releases/25/CloudImages/x86_64/images/Fedora-Cloud-Base-25-1.3.x86_64.qcow2
OSI_IMAGE_DIR?= /tmp/images
# OSI_IMAGE_ID?= f2d480d5-c5d8-42eb-8a02-a30dd5577e8e
OSI_IMAGE_IS_PROTECTED?= false
OSI_IMAGE_IS_PUBLIC?= false
# OSI_IMAGE_NAME?= ubuntu_1204_server_cloudimg_amd64
# OSI_IMAGE_PROPERTIES?= name=ubuntu_1204_server_cloudimg_amd64
# OSI_IMAGE_TAGS?=
OSI_LONG_OUTPUT?=$(OS_LONG_OUTPUT)

# DErived parameters
OSI_DOWNLOAD_FILENAME?= $(lastword $(subst /, $(SPACE), $(OSI_DOWNLOAD_URL)))
OSI_DOWNLOAD_FILEPATH?= $(subst $(SPACE),/,$(OSI_IMAGE_DIR) $(OSI_DOWNLOAD_FILENAME))
OSI_DOWNLOAD_FILE_EXTENSION?= $(lastword $(subst ., $(SPACE), $(OSI_DOWNLOAD_FILENAME)))
OSI_DOWNLOAD_FILE_BASENAME?= $(firstword $(subst ., $(SPACE), $(OSI_DOWNLOAD_FILENAME)))
OSI_DOWNLOAD_FORMAT?= $(OSI_DOWNLOAD_FILE_EXTENSION)
OSI_IMAGE_FILENAME?= $(OSI_DOWNLOAD_FILENAME)
OSI_IMAGE_FILEPATH?= $(subst $(SPACE),/,$(OSI_IMAGE_DIR) $(OSI_IMAGE_FILENAME))
OSI_IMAGE_FILE_EXTENSION?= $(lastword $(subst ., $(SPACE), $(OSI_IMAGE_FILENAME)))
OSI_IMAGE_FILE_BASENAME?= $(firstword $(subst ., $(SPACE), $(OSI_IMAGE_FILENAME)))
OSI_IMAGE_FORMAT?= $(OSI_IMAGE_FILE_EXTENSION)
OSI_DISK_FORMAT?= $(OSI_IMAGE_FILE_EXTENSION)
OSI_IMAGE_NAME_OR_ID?= $(if $(OSI_IMAGE_ID),$(OSI_IMAGE_ID),$(OSI_IMAGE_NAME))

# Option parameters
__OSI_CONTAINER_FORMAT?= $(if $(OSI_CONTAINER_FORMAT), --container-format $(OSI_CONTAINER_FORMAT))
__OSI_DISK_FORMAT?= $(if $(OSI_DISK_FORMAT), --disk-format $(OSI_DISK_FORMAT))
__OSI_FILE?= $(if $(OSI_IMAGE_FILEPATH), --file $(OSI_IMAGE_FILEPATH))
__OSI_LONG?= $(if $(filter true, $(OSI_LONG_OUTPUT)), --long)
__OSI_PROPERTY?= $(foreach P, $(OSI_IMAGE_PROPERTIES), --property $(P))
__OSI_PROTECTED?= $(if $(filter true, $(OSI_IMAGE_IS_PROTECTED)), --protected, --unprotected)
__OSI_PUBLIC?= $(if $(filter true, $(OSI_IMAGE_IS_PUBLIC)), --public, --private)
__OSI_TAG?= $(foreach T, $(OSI_IMAGE_TAGS), --tag $(T))

#--- MACROS
_osi_get_image_id_N=$(call _osi_get_image_id_P, name=$(1))
_osi_get_image_id_P=$(shell $(OPENSTACK) image list --property $(1) --column ID --format value)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _osi_view_framework_macros
_osi_view_framework_macros ::
	@echo "OpenStack::Image ($(_OPENSTACK_IMAGE_MK_VERSION)) macros:"
	@echo "    _osi_get_image_id_{N,P}      - Return an image ID based on a name or given property"
	@echo

_view_framework_parameters :: _osi_view_framework_parameters
_osi_view_framework_parameters ::
	@echo "OpenStack::Image ($(_OPENSTACK_IMAGE_MK_VERSION)) parameters:"
	@echo "    OSI_CONTAINER_FORMAT=$(OSI_CONTAINER_FORMAT)"
	@echo "    OSI_DISK_FORMAT=$(OSI_DISK_FORMAT)"
	@echo "    OSI_DOWNLOAD_FILENAME=$(OSI_DOWNLOAD_FILENAME)"
	@echo "    OSI_DOWNLOAD_FORMAT=$(OSI_DOWNLOAD_FORMAT)"
	@echo "    OSI_DOWNLOAD_URL=$(OSI_IMAGE_URL)"
	@echo "    OSI_IMAGE_DIR=$(OSI_IMAGE_DIR)"
	@echo "    OSI_IMAGE_ID=$(OSI_IMAGE_ID)"
	@echo "    OSI_IMAGE_IS_PROTECTED=$(OSI_IMAGE_IS_PROTECTED)"
	@echo "    OSI_IMAGE_IS_PUBLIC=$(OSI_IMAGE_IS_PUBLIC)"
	@echo "    OSI_IMAGE_FILENAME=$(OSI_IMAGE_FILENAME)"
	@echo "    OSI_IMAGE_FILEPATH=$(OSI_IMAGE_FILEPATH)"
	@echo "    OSI_IMAGE_FILE_BASENAME=$(OSI_IMAGE_FILE_BASENAME)"
	@echo "    OSI_IMAGE_FILE_EXTENSION=$(OSI_IMAGE_FILE_EXTENSION)"
	@echo "    OSI_IMAGE_FORMAT=$(OSI_IMAGE_FORMAT)"
	@echo "    OSI_IMAGE_NAME=$(OSI_IMAGE_NAME)"
	@echo "    OSI_IMAGE_NAME_OR_ID=$(OSI_IMAGE_NAME_OR_ID)"
	@echo "    OSI_IMAGE_PROPERTIES=$(OSI_IMAGE_PROPERTIES)"
	@echo "    OSI_IMAGE_TAGS=$(OSI_IMAGE_TAGS)"
	@echo

_view_framework_targets :: _osi_view_framework_targets
_osi_view_framework_targets ::
	@echo "OpensStack::Image ($(_OPENSTACK_IMAGE_MK_VERSION)) targets:"
	@echo "    _osi_convert_download        - Convert the downloaded image"
	@echo "    _osi_delete_image            - Delete an existing image"
	@echo "    _osi_download_image          - Download an image from a remote location"
	@echo "    _osi_export_image            - Export an image to a local image file"
	@echo "    _osi_import_image            - Import image file"
	@echo "    _osi_list_images             - List image files"
	@echo "    _osi_show_image              - Show details of an existing image"
	@echo "    _osi_tag_image               - Tag an existing image"
	@echo "    _osi_untargz_download        - Untargz downloaded image"
	@echo "    _osi_view_images             - View existing images"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_osi_convert_download:
	@$(INFO) "$(OS_UI_LABEL)Converting image from '$(OSI_DOWNLOAD_FORMAT)' to '$(OSI_IMAGE_FORMAT)' ..."; $(NORMAL)
	@$(WARN) "Source file:      $(OSI_DOWNLOAD_FILEPATH)"; $(NORMAL)
	@$(WARN) "Destination file: $(OSI_IMAGE_FILEPATH)"; $(NORMAL)
	ls -al $(OSI_DOWNLOAD_FILEPATH)
	qemu-img convert -O $(OSI_IMAGE_FORMAT) $(OSI_DOWNLOAD_FILEPATH) $(OSI_IMAGE_FILEPATH)
	ls -al $(OSI_IMAGE_FILEPATH)

_osi_delete_image:
	@$(INFO) "$(OS_UI_LABEL)Deleting image '$(OSI_IMAGE_NAME_OR_ID)' ..."; $(NORMAL)
	#$(OPENSTACK) image delete $(OSI_IMAGE_NAME_OR_ID)

_osi_download_image:
	@$(INFO) "$(OS_UI_LABEL)Downloading image ..."; $(NORMAL)
	@$(WARN) "Source URL:       $(OSI_DOWNLOAD_URL)"; $(NORMAL)
	@$(WARN) "Destination File: $(OSI_DOWNLOAD_FILEPATH)"; $(NORMAL)
	mkdir -p -v $(OSI_IMAGE_DIR)
	cd $(OSI_IMAGE_DIR); wget -nc $(OSI_DOWNLOAD_URL)
	ls -al $(OSI_DOWNLOAD_FILEPATH)

_osi_export_image:
	@$(INFO) "$(OS_UI_LABEL)Export image '$(OSI_IMAGE_NAME_OR_ID)' ..."; $(NORMAL)
	@$(WARN) "Image name/id:    $(OSI_IMAGE_NAME_OR_ID)"; $(NORMAL)
	@$(WARN) "Destination file: $(OSI_IMAGE_FILEPATH)"; $(NORMAL)
	$(OPENSTACK) image save $(OSI_IMAGE_NAME_OR_ID)
	ls -al $(OSI_IMAGE_FILEPATH)

_osi_import_image:
	@$(INFO) "$(OS_UI_LABEL)Importing image file ..."; $(NORMAL)
	@$(WARN) "Image file: $(OSI_IMAGE_FILEPATH)"; $(NORMAL)
	ls -al $(OSI_IMAGE_FILEPATH)
	$(OPENSTACK) image create $(__OSI_CONTAINER_FORMAT) $(__OSI_DISK_FORMAT) $(__OSI_FILE) $(__OSI_MIN_DISK) $(__OSI_MIN_RAM) $(__OSI_PROTECTED) $(__OSI_PUBLIC) $(__OSI_TAG) $(OSI_IMAGE_NAME)

_osi_list_images:
	@$(INFO) "$(OS_UI_LABEL)Listing image files in '$(OSI_IMAGE_DIR)' ..."; $(NORMAL)
	ls -al $(OSI_IMAGE_DIR)

_osi_show_image:
	@$(INFO) "$(OS_UI_LABEL)Showing details of image '$(OSI_IMAGE_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) image show $(OSI_IMAGE_NAME_OR_ID)

_osi_tag_image:
	@$(INFO) "$(OS_UI_LABEL)Tagging image '$(OSI_IMAGE_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) image set $(__OSI_IMAGE_PROPERTY) $(OSI_IMAGE_NAME_OR_ID)

_osi_untargz_download:
	@$(INFO) "$(OS_UI_LABEL)Untargz'ing the downloaded image ..."; $(NORMAL)
	@$(WARN) "Source file:      $(OSI_DOWNLOAD_FILEPATH)"; $(NORMAL)
	@$(WARN) "Destination file: $(OSI_IMAGE_FILEPATH)"; $(NORMAL)
	ls -al $(OSI_DOWNLOAD_FILEPATH)
	cd $(OSI_IMAGE_DIR); tar -xvzf $(OSI_DOWNLOAD_FILEPATH)
	ls -al $(OSI_IMAGE_FILEPATH)

_osi_view_images:
	@$(INFO) "$(OS_UI_LABEL)View images ..."; $(NORMAL)
	$(OPENSTACK) image list $(__OSI_LONG)
