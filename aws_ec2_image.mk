_AWS_EC2_IMAGE_MK_VERSION=$(_AWS_EC2_MK_VERSION) 

# EC2_ENCRYPTED_IMAGE?=
EC2_IMAGE_ATTRIBUTES?= description kernel ramdisk launchPermission productCodes blockDeviceMapping sriovNetSupport
# EC2_IMAGE_BASENAME?=ImageBasename
# EC2_IMAGE_DESCRIPTION?= "This is my image description"
# EC2_IMAGE_EXPORT_ACCOUNTS?=
# EC2_IMAGE_EXPORT_REGIONS?=
# EC2_IMAGE_ID?=
# EC2_IMAGE_LAUNCH_PERMISSION_ADD?= [{"UserId": "$(EC2_IMAGE_DESTINATION_ACCOUNT)"}]
# EC2_IMAGE_LAUNCH_PERMISSION_REMOVE?= [{"UserId": "$(EC2_IMAGE_DESTINATION_ACCOUNT)"}]
EC2_IMAGE_LAUNCH_PERMISSION?= '{"Add":$(EC2_IMAGE_LAUNCH_PERMISSION_ADD)}'
# EC2_IMAGE_NAME?=
EC2_IMAGE_OWNER?= self
# EC2_IMAGE_PREFIX?=
# EC2_IMAGE_PRODUCT_CODE?= aw0evgkw8e5c1q413zgy5pjce
# EC2_IMAGE_SUFFIX?=
# EC2_IMAGE_TAGS?=
# EC2_SOURCE_IMAGE_ID?=
# EC2_SOURCE_IMAGE_REGION?=


# Derived parameters 
EC2_IMAGE_FILTERS+= $(if $(EC2_IMAGE_PRODUCT_CODE), Name=product-code$(COMMA)Values=$(EC2_IMAGE_PRODUCT_CODE))
EC2_IMAGE_IDS?= $(EC2_IMAGE_ID)
EC2_IMAGE_NAME?= $(EC2_IMAGE_PREFIX)$(EC2_IMAGE_BASENAME)$(EC2_IMAGE_SUFFIX)
EC2_IMAGE_NAMES?= $(EC2_IMAGE_NAME)
EC2_IMAGE_OWNERS?= $(EC2_IMAGE_OWNER)
EC2_SOURCE_IMAGE_NAME?= $(EC2_IMAGE_NAME)
EC2_SOURCE_IMAGE_OWNER?= $(EC2_IMAGE_OWNER)

# Option parameters
__EC2_DESCRIPTION_IMAGE= $(if $(EC2_IMAGE_DESCRIPTION),--description $(EC2_IMAGE_DESCRIPTION))
__EC2_ENCRYPTED= $(if $(EC2_ENCRYPTED_IMAGE),--encrypted,--no-encrypted)
__EC2_IMAGE_FILTERS= $(if $(EC2_IMAGE_FILTERS),--filters $(EC2_IMAGE_FILTERS))
__EC2_IMAGE_ID= $(if $(EC2_IMAGE_ID),--image-id $(EC2_IMAGE_ID))
__EC2_IMAGE_IDS__IMAGE= $(if $(EC2_IMAGE_IDS),--image-ids $(EC2_IMAGE_ID))
__EC2_IMAGE_IDS__IMAGES= $(if $(EC2_IMAGE_IDS),--image-ids $(EC2_IMAGE_IDS))
__EC2_LAUNCH_PERMISSION= $(if $(EC2_IMAGE_LAUNCH_PERMISSION),--launch-permission $(EC2_IMAGE_LAUNCH_PERMISSION))
__EC2I_NAME= $(if $(EC2_IMAGE_NAME),--name $(EC2_IMAGE_NAME))
__EC2_OWNER= $(if $(EC2_IMAGE_OWNER),--owner $(EC2_IMAGE_OWNER))
__EC2_OWNERS= $(if $(EC2_IMAGE_OWNERS),--owners $(EC2_IMAGE_OWNERS))
__EC2_SOURCE_IMAGE_ID= $(if $(EC2_SOURCE_IMAGE_ID),--source-image-id $(EC2_SOURCE_IMAGE_ID))
__EC2_SOURCE_REGION= $(if $(EC2_SOURCE_IMAGE_REGION),--source-region $(EC2_SOURCE_IMAGE_REGION))
__EC2_IMAGE_TAGS= $(if $(EC2_IMAGE_TAGS),--tags $(EC2_IMAGE_TAGS))

# UI parameters
EC2_UI_SHOW_IMAGE_OVERVIEW_FIELDS?=
EC2_UI_SHOW_IMAGE_USAGE_FIELDS?= .{Name:Tags[?Key=='Name'] | [0].Value, InstanceType:InstanceType}
EC2_UI_VIEW_IMAGES_FIELDS?= .{creationDate:CreationDate,ImageId:ImageId,Name:Name}
EC2_UI_VIEW_IMAGE_STATES_FIELDS?= .{CreationDate:CreationDate,ImageId:ImageId,Name:Name,_State:State}

#--- Macros

_ec2_get_image_id= $(call _ec2_get_image_id_N, $(EC2_IMAGE_NAME))
_ec2_get_image_id_N= $(call _ec2_get_image_id_VF, $(1), name)
_ec2_get_image_id_VF= $(shell $(AWS) ec2 describe-images --filters "Name=$(strip $(2)),Values=$(strip $(1))" --query 'Images[].ImageId' --output text)

_ec2_get_image_name= $(call _ec2_get_image_name_I, $(EC2_IMAGE_ID))
_ec2_get_image_name_I= $(shell $(AWS) ec2 describe-images --image-ids $(1) --query 'Images[].Name' --output text)

_ec2_get_source_image_id_D= $(call _ec2_get_source_image_id_NORD,$(EC2_SOURCE_IMAGE_NAME),$(EC2_SOURCE_IMAGE_OWNER),$(EC2_SOURCE_IMAGE_REGION),$(1))

_ec2_get_source_image_id_NORD= $(if $(1),$(shell $(AWS) ec2 describe-images --filters "Name=name,Values=$(1)" --owners $(2) --query 'Images[].ImageId' --region $(3) --output text),$(4))

_ec2_get_snapshot_id_ID= $(if $(1),$(shell $(AWS) ec2 describe-images --query 'Images[0].BlockDeviceMappings[0].Ebs.SnapshotId' --image-ids $(1) --output text,$(2)))

#----------------------------------------------------------------------
# USAGE
#

_ec2_view_framework_macros ::
	@echo 'AWS::EC2::Image ($(_AWS_EC2_IMAGE_MK_VERSION)) macros:'
	@echo '    _ec2_get_image_id_{|N|VF}               - Get an Image ID (Name,Value,Field)'
	@echo '    _ec2_get_image_name_{|I}                - Get an Image name (Id)'
	@echo '    _ec2_get_source_image_id_NORD           - Get the source image ID (Name, Owner, Region, Default)'
	@echo '    _ec2_get_snapshot_id_ID                 - Get a snapshot ID (Image Id, Default)'
	@echo

_ec2_view_framework_targets ::
	@echo 'AWS::EC2::Image ($(_AWS_EC2_IMAGE_MK_VERSION)) targets:'
	@echo '    _ec2_create_image                - Create an image from a running instance'
	@echo '    _ec2_deregister_image            - Deregister an existing image'
	@echo '    _ec2_tag_image                   - Tag an existing image'
	@echo '    _ec2_update_image                - Replace an existing image'
	@echo '    _ec2_show_image                  - Show everything related to  an image'
	@echo '    _ec2_show_image_attribute        - Show the attributes of an images'
	@echo '    _ec2_show_image_description      - Show description of an image'
	@echo '    _ec2_show_image_instances        - Show instances with an image'
	@echo '    _ec2_show_image_tags             - Show tags of an image'
	@echo '    _ec2_view_images                 - Display the list of image with same basename'
	@echo '    _ec2_view_image_set              - View a set/famliy of images'
	@echo 

_ec2_view_framework_parameters ::
	@echo 'AWS::EC2::Image ($(_AWS_EC2_IMAGE_MK_VERSION)) parameters:'
	@echo '    EC2_IMAGE_ATTRIBUTES=$(EC2_IMAGE_ATTRIBUTES)'
	@echo '    EC2_IMAGE_BASENAME=$(EC2_IMAGE_BASENAME)'
	@echo '    EC2_IMAGE_DESTINATION_ACCOUNT=$(EC2_IMAGE_DESTINATION_ACCOUNT)'
	@echo '    EC2_IMAGE_EXPORT_ACCOUNTS=$(EC2_IMAGE_EXPORT_ACCOUNT)'
	@echo '    EC2_IMAGE_EXPORT_REGIONS=$(EC2_IMAGE_EXPORT_REGIONS)'
	@echo '    EC2_IMAGE_ID=$(EC2_IMAGE_ID)'
	@echo '    EC2_IMAGE_IDS=$(EC2_IMAGE_IDS)'
	@echo '    EC2_IMAGE_LAUNCH_PERMISSION=$(EC2_IMAGE_LAUNCH_PERMISSION)'
	@echo '    EC2_IMAGE_NAME=$(EC2_IMAGE_NAME)'
	@echo '    EC2_IMAGE_NAMES=$(EC2_IMAGE_NAMES)'
	@echo '    EC2_IMAGE_OWNER=$(EC2_IMAGE_OWNER)'
	@echo '    EC2_IMAGE_OWNERS=$(EC2_IMAGE_OWNERS)'
	@echo '    EC2_IMAGE_PREFIX=$(EC2_IMAGE_PREFIX)'
	@echo '    EC2_IMAGE_SUFFIX=$(EC2_IMAGE_SUFFIX)'
	@echo '    EC2_IMAGE_TAGS=$(EC2_IMAGE_TAGS)'
	@echo '    EC2_SOURCE_IMAGE_ID=$(EC2_SOURCE_IMAGE_ID)'
	@echo '    EC2_SOURCE_IMAGE_NAME=$(EC2_SOURCE_IMAGE_NAME)'
	@echo '    EC2_SOURCE_IMAGE_REGION=$(EC2_SOURCE_IMAGE_REGION)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_create_image:
	@$(INFO) '$(EC2_UI_LABEL)Creating an image "$(EC2_IMAGE_NAME)" based on instance "$(EC2_INSTANCE_ID)" ...'
	@$(WARN) 'If you want to replace an existing image, deregisted it first!'
	@$(NORMAL)
	$(AWS) ec2 create-image --instance-id $(EC2_INSTANCE_ID) $(__EC2I_NAME) $(__EC2_DESCRIPTION_IMAGE)
	@$(WARN) 'The image creation process forces a REBOOT of the host that is being imaged.'
	@$(WARN) -n 'The image creation process can take a few minutes ...'; 
	@while [ -z $${_IMAGE_ID} ]; do \
		_IMAGE_ID=`$(AWS) ec2 describe-images $(__EC2_OWNERS)  --filters "Name=name,Values=$(EC2_IMAGE_NAME)" --query 'Images[].ImageId' --output text`; \
        echo -n "." ; sleep 1 ; \
        done; $(INFO) '\n$(EC2_UI_LABEL)Newly created image is: $(EC2_IMAGE_NAME) ($${_IMAGE_ID})'; $(NORMAL)

_ec2_deregister_image:
	@$(INFO) '$(EC2_UI_LABEL)Deregistering image "$(EC2_IMAGE_NAME)/$(EC2_IMAGE_ID)" ...'; $(NORMAL)
	@$(WARN) 'Autoscale groups that use this image will NOT be able to scale out!' 
	@$(WARN) 'Scripts that are referencing this image will NOT work until another one is available' 
	@$(NORMAL)
	$(if $(EC2_IMAGE_ID), $(AWS) ec2 deregister-image $(__EC2_IMAGE_ID))
	@$(WARN) -n 'The deregistration of an image takes a few minutes ...'; 
	@_IMAGE_ID=$(EC2_IMAGE_ID); while [ ! -z $${_IMAGE_ID} ]; do \
		_IMAGE_ID=`$(AWS) ec2 describe-images $(__EC2_OWNERS)  --filters "Name=name,Values=$(EC2_IMAGE_NAME)" --query 'Images[].ImageId' --output text`; \
        echo -n "." ; sleep 1 ; \
        done; echo
	@$(INFO) '$(EC2_UI_LABEL)Deregistration complete!'; $(NORMAL)

_ec2_change_launch_permission:
	@$(INFO) '$(EC2_UI_LABEL)Changing launch permission image attribute for image "$(EC2_IMAGE_ID)" ...'; $(NORMAL)
	@$(WARN) -n 'Waiting for image to be "available" ...';
	@while [ "$${_IMAGE_STATE}" != "available" ]; do \
		_IMAGE_STATE=`$(AWS) ec2 describe-images $(__EC2_OWNERS)  --filters "Name=name,Values=$(EC2_IMAGE_NAME)" --query 'Images[].State' --output text`; \
        echo -n "." ; sleep 1 ; \
        done; $(NORMAL); echo
	$(AWS) ec2 modify-image-attribute $(__EC2_IMAGE_ID) $(__EC2_LAUNCH_PERMISSION)

_ec2_copy_image:
	@$(INFO) '$(EC2_UI_LABEL)Copying source image "$(EC2_SOURCE_IMAGE_NAME)" ...'
	@$(WARN) '$(EC2_IMAGE_SOURCE_REGION) --> $(AWS_REGION)'
	$(AWS) ec2 copy-image $(__EC2_SOURCE_REGION) $(__EC2_SOURCE_IMAGE_ID) $(__EC2I_NAME) $(__EC2_DESCRIPTION) $(__EC2_ENCRYPTED)
	@$(WARN) -n 'Copying an image takes a few minutes ...'; 
	@_IMAGE_ID=$(EC2_IMAGE_ID); while [ ! -z $${_IMAGE_ID} ]; do \
		_IMAGE_ID=`$(AWS) ec2 describe-images $(__EC2_OWNERS)  --filters "Name=name,Values=$(EC2_IMAGE_NAME)" "Name=state,Values=available" --query 'Images[].ImageId' --output text`; \
        echo -n "." ; sleep 1 ; \
        done; echo
	@$(INFO) '$(EC2_UI_LABEL)Image now available in $(AWS_REGION): $(EC2_IMAGE_NAME) ($(EC2_IMAGE_ID))'; $(NORMAL)

_ec2_show_image:: _ec2_show_image_attributes _ec2_show_image_instances _ec2_show_image_tags _ec2_show_image_description

_ec2_show_image_attributes:
	@$(INFO) '$(EC2_UI_LABEL)Showing attributes for image "$(EC2_IMAGE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will fail if you are not the owner of the image!'; $(NORMAL)
	@$(foreach A, $(EC2_IMAGE_ATTRIBUTES), \
	$(INFO) ' * Attribute: $(A)'; \
	$(AWS) ec2 describe-image-attribute $(__EC2_IMAGE_ID) --attribute $(A) --output json | jq '.' ; \
	)

_ec2_show_image_description:
	@$(INFO) '$(EC2_UI_LABEL)Showing description of image "$(EC2_IMAGE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-images $(__EC2_IMAGE_IDS__IMAGE) --query 'Images[]$(EC2_UI_SHOW_IMAGE_OVERVIEW_FIELDS)'

_ec2_show_image_instances:
	@$(INFO) '$(EC2_UI_LABEL)Showing instances that are using image "$(EC2_IMAGE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The returned instances are in the current account!'; $(NORMAL)
	@$(WARN) 'This operation does NOT return the instances in the other AWS account with which the image was shared'; $(NORMAL)
	$(AWS) ec2 describe-instances --filters "Name=image-id,Values=$(EC2_IMAGE_ID)" --query "Reservations[].Instances[]$(EC2_UI_SHOW_IMAGE_USAGE_FIELDS)"

_ec2_show_image_tags:
	@$(INFO) '$(EC2_UI_LABEL)Showing tags of image "$(EC2_IMAGE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-images $(__EC2_IMAGE_IDS__IMAGE) --query 'Images[].Tags[]'

_ec2_tag_image:
	@$(INFO) '$(EC2_UI_LABEL)Tagging image "$(EC2_IMAGE_ID)" ...'
	@$(WARN) 'The image needs to be available in this region for this operation to complete successfully.'
	@$(WARN) 'If you just created, exported, or copied the image, it may not be accessible yet.'
	@$(NORMAL)
	$(AWS) ec2 create-tags $(__EC2_IMAGE_TAGS) --resources $(EC2_IMAGE_ID)

_ec2_view_images:
	@$(INFO) '$(EC2_UI_LABEL)View images ...'; $(NORMAL)
	@$(WARN) 'Owners: $(EC2_IMAGE_OWNERS)'; $(NORMAL)
	$(AWS) ec2 describe-images $(__EC2_IMAGE_FILTERS) $(__EC2_OWNERS) --query "sort_by(Images,&Name)[]$(EC2_UI_VIEW_IMAGES_FIELDS)"

_ec2_view_images_set:
	@$(INFO) '$(EC2_UI_LABEL)Viewing images-set "$(EC2_IMAGES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Images are grouped based on the provided image-ids'; $(NORMAL)
	$(AWS) ec2 describe-images $(__EC2_IMAGE_IDS__IMAGES)
