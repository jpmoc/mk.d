_AWS_IOT1CLICK_DEVICE_MK_VERSION= $(_AWS_IOT1CLICK_MK_VERSION)

# I1K_DEVICE_ACCOUNT_ID?= 012345678901
# I1K_DEVICE_ARN?= arn:aws:iot1click:us-west-2:012345678901:devices/G030PM0123456789
# I1K_DEVICE_EVENTS_FROM?= 2019-07-17T15:45:12.880Z
# I1K_DEVICE_EVENTS_TO?= 2019-07-19T15:45:12.880Z
# I1K_DEVICE_ID?= G030PM037143BD5E
# I1K_DEVICE_METHOD_NAME?= DeviceType=device,MethodName=getDeviceHealthParameters
# I1K_DEVICE_METHOD_PARAMETERS?=
# I1K_DEVICE_NAME?=
# I1K_DEVICE_REGION_NAME?= us-west-2
# I1K_DEVICE_TAGS_KEYVALUES?= KeyName1=string KeyName2=string
# I1K_DEVICE_TAGS_KEYS?= KeyName1 KeyName2

# Derived parameters
I1K_DEVICE_ACCOUNT_ID?= $(I1K_ACCOUNT_ID)
I1K_DEVICE_REGION_NAME?= $(I1K_REGION_NAME)

# Options parameters
__I1K_DEVICE_ID= $(if $(I1K_DEVICE_ID),--device-id $(I1K_DEVICE_ID))
__I1K_DEVICE_METHOD= $(if $(I1K_DEVICE_METHOD_NAME),--device-method $(I1K_DEVICE_METHOD_NAME))
__I1K_DEVICE_METHOD_PARAMETERS= $(if $(I1K_DEVICE_METHOD_PARAMETERS),--device-method-parameters $(I1K_DEVICE_METHOD_PARAMETERS))
__I1K_FROM_TIME_STAMP= $(if $(I1K_DEVICE_EVENTS_FROM),--from-time-stamp $(I1K_DEVICE_EVENTS_FROM))
__I1K_RESOURCE_ARN__DEVICE= $(if $(I1K_DEVICE_ARN),--resource-arn $(I1K_DEVICE_ARN))
__I1K_TAGS__DEVICE= $(if $(I1K_DEVICE_TAGS_KEYVALUES),--tags $(subst $(SPACE),$(COMMA),$(I1K_DEVICE_TAGS_KEYVALUES)))
__I1K_TAG_KEYS__DEVICE= $(if $(I1K_DEVICE_TAGS_KEYS),--tag-keys $(I1K_DEVICE_TAGS_KEYS))
__I1K_TO_TIME_STAMP= $(if $(I1K_DEVICE_EVENTS_TO),--to-time-stamp $(I1K_DEVICE_EVENTS_TO))

# Pipe parameters
|_I1K_SHOW_DEVICE_EVENTS?=

# UI parameters
I1K_UI_SHOW_DEVICE_EVENTS_FIELDS?= .StdEvent
I1K_UI_SHOW_DEVICE_EVENTS_QUERYFILTER?= -5:
I1K_UI_VIEW_DEVICES_FIELDS?= .{DeviceId:DeviceId,enabled:Enabled,remainingLife:RemainingLife,type:Type}
I1K_UI_VIEW_DEVICES_SET_FIELDS?= $(I1K_UI_VIEW_DEVICES_FIELDS)

#--- Utilities

#--- MACRO
_i1k_get_device_arn= $(call _i1k_get_device_arn_I, $(I1K_DEVICE_ID))
_i1k_get_device_arn_I= $(shell echo 'arn:aws:iot1click:$(I1K_DEVICE_REGION_NAME):$(I1K_DEVICE_ACCOUNT_ID):devices/$(strip $(1))')

#----------------------------------------------------------------------
# USAGE
#

_i1k_view_framework_macros ::
	@echo 'AWS::Iot1clicK::Device ($(_AWS_IOT1CLICK_DEVICE_MK_VERSION)) macros:'
	@echo '    _i1k_get_device_arn_{|I}           - Get the ARN of the device (Id)'
	@echo

_i1k_view_framework_parameters ::
	@echo 'AWS::Iot1clicK::Device ($(_AWS_IOT1CLICK_DEVICE_MK_VERSION)) parameters:'
	@echo '    I1K_DEVICE_ACCOUNT_ID=$(I1K_DEVICE_ACCOUNT_ID)'
	@echo '    I1K_DEVICE_ARN=$(I1K_DEVICE_ARN)'
	@echo '    I1K_DEVICE_EVENTS_FROM=$(I1K_DEVICE_EVENTS_FROM)'
	@echo '    I1K_DEVICE_EVENTS_TO=$(I1K_DEVICE_EVENTS_TO)'
	@echo '    I1K_DEVICE_ID=$(I1K_DEVICE_ID)'
	@echo '    I1K_DEVICE_METHOD_NAME=$(I1K_DEVICE_METHOD_NAME)'
	@echo '    I1K_DEVICE_METHOD_PARAMETERS=$(I1K_DEVICE_METHOD_PARAMETERS)'
	@echo '    I1K_DEVICE_NAME=$(I1K_DEVICE_NAME)'
	@echo '    I1K_DEVICE_REGION_NAME=$(I1K_DEVICE_REGION_NAME)'
	@echo '    I1K_DEVICE_TAGS_KEYVALUES=$(I1K_DEVICE_TAGS_KEYVALUES)'
	@echo '    I1K_DEVICE_TAGS_KEYS=$(I1K_DEVICE_TAGS_KEYS)'
	@echo '    I1K_DEVICES_SET_NAME=$(I1K_DEVICES_SET_NAME)'
	@echo

_i1k_view_framework_targets ::
	@echo 'AWS::Iot1clicK::Device ($(_AWS_IOT1CLICK_DEVICE_MK_VERSION)) targets:'
	@echo '    _i1k_actuate_device               - Actuate a device'
	@echo '    _i1k_create_device                - Create a device'
	@echo '    _i1k_delete_device                - Delete an existing device'
	@echo '    _i1k_disable_device               - Disable a device'
	@echo '    _i1k_enable_device                - Disable a device'
	@echo '    _i1k_show_device                  - Show everything relatead to a device in a log-group'
	@echo '    _i1k_show_device_description      - Show description of a device in a log-group'
	@echo '    _i1k_tag_device                   - Tag a devices'
	@echo '    _i1k_untag_device                 - Remove tags from a devices'
	@echo '    _i1k_view_devices                 - View devices'
	@echo '    _i1k_view_devices_set             - View a set of devices'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_i1k_actuate_device:
	@$(INFO) '$(AWS_UI_LABEL)Actuating device "$(I1K_DEVICE_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-devices invoke-device-method $(__I1K_DEVICE_ID) $(__I1K_DEVICE_METHOD) $(__I1K_DEVICE_METHOD_PARAMETERS)

_i1k_create_device:
	@$(INFO) '$(AWS_UI_LABEL)Creating device "$(I1K_DEVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Claiming a device consists of initiating a claim, then publishing a device event, and finalizing the claim.'
	@$(WARN) 'For a device of type button, a device event can be published by simply clicking the device.	'; $(NORMAL)
	# $(AWS) iot1click-devices initiate-device-claim $(__I1K_DEVICE_ID)
	# Publish a device event by pushing the button
	# $(AWS) iot1click-devices finalize-device-claim $(__I1K_DEVICE_ID) $(__I1K_TAGS__DEVICE)

_i1k_delete_device:
	@$(INFO) '$(AWS_UI_LABEL)Deleting device "$(I1K_DEVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation disassociate a device from this AWS account'; $(NORMAL)
	@read 'To reclaim this device, you need access to the hardware. Are you sure?' yesNo
	$(AWS) iot1click-devices unclaim-device $(__I1K_DEVICE_ID)

_i1k_disable_device:
	@$(INFO) '$(AWS_UI_LABEL)Disabling device "$(I1K_DEVICE_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-devices update-device-state $(__I1K_DEVICE_ID) --no-enable

_i1k_enable_device:
	@$(INFO) '$(AWS_UI_LABEL)Enabling device "$(I1K_DEVICE_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-devices update-device-state $(__I1K_DEVICE_ID) --enable

_i1k_show_device:: _i1k_show_device_events _i1k_show_device_methods _i1k_show_device_tags _i1k_show_device_description

_i1k_show_device_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of device "$(I1K_DEVICE_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-devices describe-device $(__I1K_DEVICE_ID) --query "DeviceDescription"

_i1k_show_device_events:
	@$(INFO) '$(AWS_UI_LABEL)Showing events of device "$(I1K_DEVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns events ordered from the oldest to the most recent'; $(NORMAL)
	$(AWS) iot1click-devices list-device-events $(__I1K_DEVICE_ID) $(__I1K_FROM_TIME_STAMP) $(__I1K_TO_TIME_STAMP) --query "Events[$(I1K_UI_SHOW_DEVICE_EVENTS_QUERYFILTER)]$(I1K_UI_SHOW_DEVICE_EVENTS_FIELDS)" $(|_I1K_SHOW_DEVICE_EVENTS)

_i1k_show_device_methods:
	@$(INFO) '$(AWS_UI_LABEL)Showing methods of device "$(I1K_DEVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the invokable methods associated with the device'; $(NORMAL)
	$(AWS) iot1click-devices get-device-methods $(__I1K_DEVICE_ID) --query 'DeviceMethods[]'

_i1k_show_device_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags for device "$(I1K_DEVICE_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-devices list-tags-for-resource $(__I1K_RESOURCE_ARN__DEVICE) --query 'Tags'

_i1k_tag_device:
	@$(INFO) '$(AWS_UI_LABEL)Tagging device "$(I1K_DEVICE_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-devices tag-resource $(__I1K_RESOURCE_ARN__DEVICE) $(__I1K_TAGS__DEVICE)

_i1k_untag_device:
	@$(INFO) '$(AWS_UI_LABEL)Untagging device "$(I1K_DEVICE_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-devices untag-resource $(__I1K_RESOURCE_ARN__DEVICE) $(__I1K_TAG_KEYS__DEVICE)

_i1k_view_devices:
	@$(INFO) '$(AWS_UI_LABEL)View devices ...'; $(NORMAL)
	$(AWS) iot1click-devices list-devices --query "Devices[]$(I1K_UI_VIEW_DEVICES_FIELDS)"

_i1k_view_devices_set:
	@$(INFO) '$(AWS_UI_LABEL)View devices-set "$(I1K_DEVICES_SET_NAME)" ...'; $(NORMAL)
