_MINIKUBE_IMAGECACHE_MK_VERSION= $(_MINIKUBE_MK_VERSION)

# MKE_IMAGECACHE_IMAGE_CNAME?= ubuntu:18.04

# Derived variables

# Option variables

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_mke_view_framework_macros ::
	@#echo 'MiniKubE::ImageCache ($(_MINIKUBE_IMAGECACHE_MK_VERSION)) macros:'
	@#echo

_mke_view_framework_parameters ::
	@echo 'MiniKubE::ImageCache ($(_MINIKUBE_IMAGECACHE_MK_VERSION)) parameters:'
	@echo '    MKE_IMAGECACHE_IMAGE_CNAME=$(MKE_IMAGECACHE_IMAGE_CNAME)'
	@echo

_mke_view_framework_targets ::
	@echo 'MiniKubE::ImageCache ($(_MINIKUBE_IMAGECACHE_MK_VERSION)) targets:'
	@echo '    _mke_add_imagecache_image               - Add image to image-cache'
	@echo '    _mke_remove_imagecache_image            - Remove image to image-cache'
	@echo '    _mke_show_imagecache                    - Show everything related to image-cache'
	@echo '    _mke_show_imagecache_description        - Show description of image-cache'
	@echo '    _mke_show_imagecache_images             - Show images in image-cache'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mke_add_imagecache_image:
	@$(INFO) '$(MKE_UI_LABEL)Adding image "$(MKE_IMAGECACHE_IMAGE_CNAME)" to image-cache ...'; $(NORMAL)
	$(MINIKUBE) cache add $(MKE_IMAGECACHE_IMAGE_CNAME)

_mke_remove_imagecache_image:
	@$(INFO) '$(MKE_UI_LABEL)Removing image "$(MKE_IMAGECACHE_IMAGE_CNAME)" from image-cache ...'; $(NORMAL)
	$(MINIKUBE) cache delete $(MKE_IMAGECACHE_IMAGE_CNAME)

_mke_show_imagecache :: _mke_show_imagecache_images _mke_show_imagecache_description

_mke_show_imagecache_description:
	@$(INFO) '$(MKE_UI_LABEL)Showing decription of image-cache ...'; $(NORMAL)

_mke_show_imagecache_images:
	@$(INFO) '$(MKE_UI_LABEL)Showing images in image-cache ...'; $(NORMAL)
	@$(WARN) 'The cached images are automatically made available to all minikube cluster'; $(NORMAL)
	$(MINIKUBE) cache list

