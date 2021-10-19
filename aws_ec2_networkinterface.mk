_AWS_EC2_NETWORKINTERFACE_MK_VERSION= $(_AWS_EC2_MK_VERSION)

# EC2_NETWORKINTERFACE_ATTACHMENT_ID?= eni-attach-66c4350a
# EC2_NETWORKINTERFACE_ATTRIBUTES?= attachment
# EC2_NETWORKINTERFACE_DEVICE_INDEX?=1
# EC2_NETWORKINTERFACE_DESCRIPTION?=
# EC2_NETWORKINTERFACE_SUBNET_ID?=
# EC2_NETWORKINTERFACE_GROUPS?=
# EC2_NETWORKINTERFACE_ID?= eni-5ad7e90c
# EC2_NETWORKINTERFACE_NAME?= my-network-interface
# EC2_NETWORKINTERFACE_PRIVATE_IP?=
# EC2_NETWORKINTERFACE_PRIVATE_IP_COUNT?=
# EC2_NETWORKINTERFACE_PRIVATE_IPS?=
# EC2_NETWORKINTERFACE_PUBLIC_IP?=
# EC2_NETWORKINTERFACE_SECONDARYPRIVATEIP_COUNT?=
# EC2_NETWORKINTERFACE_SUBNET_ID?= subnet-12345678
# EC2_NETWORKINTERFACES_IDS?= eni-5ad7e90c ...
# EC2_NETWORKINTERFACES_SET_NAME?= my-network-interfaces-set

#--- Derived parameters
EC2_NETWORKINTERFACE_NAME?= $(EC2_NETWORKINTERFACE_ID)
EC2_NETWORKINTERFACE_SUBNET_ID?= $(EC2_SUBNET_ID)

#--- Option parameters
__EC2_ATTACHMENT_ID?= $(if $(EC2_NETWORKINTERFACE_ATTACHMENT_ID),--attachment-id $(EC2_NETWORKINTERFACE_ATTACHMENT_ID))
__EC2_ATTRIBUTE?= $(if $(EC2_NETWORKINTERFACE_ATTRIBUTE),--attribute $(EC2_NETWORKINTERFACE_ATTRIBUTE))
__EC2_DEVICE_INDEX?= $(if $(EC2_NETWORKINTERFACE_DEVICE_INDEX),--device-index $(EC2_NETWORKINTERFACE_DEVICE_INDEX))
__EC2_DESCRIPTION__NETWORKINTERFACE= $(if $(EC2_NETWORKINTERFACE_DESCRIPTION),--description $(EC2_NETWORKINTERFACE_DESCRIPTION))
__EC2_FILTER__NETWORKINTERFACES= $(if $(EC2_NETWORKINTERFACES_FILTER),--filter $(EC2_NETWORKINTERFACE_FILTER))
__EC2_GROUPS= $(if $(EC2_NETWORKINTERFACE_GROUPS),--groups $(EC2_NETWORKINTERFACE_GROUPS))
__EC2_IPV6_ADDRESS_COUNT=
__EC2_IPV6_ADDRESSES=
__EC2_NETWORK_INTERFACE_ID= $(if $(EC2_NETWORKINTERFACE_ID),--network-interface-id $(EC2_NETWORKINTERFACE_ID))
__EC2_NETWORK_INTERFACE_IDS__NETWORKINTERFACE= $(if $(EC2_NETWORKINTERFACE_ID),--network-interface-ids $(EC2_NETWORKINTERFACE_ID))
__EC2_NETWORK_INTERFACE_IDS__NETWORKINTERFACES= $(if $(EC2_NETWORKINTERFACES_IDS),--network-interface-ids $(EC2_NETWORKINTERFACES_IDS))
__EC2_PRIVATE_IP_ADDRESS= $(if $(EC2_NETWORKINTERFACE_PRIVATE_IP),--private-ip-address $(EC2_NETWORKINTERFACE_PRIVATE_IP))
__EC2_PRIVATE_IP_ADDRESSES= $(if $(EC2_NETWORKINTERFACE_PRIVATE_IPS),--private-ip-addresses $(EC2_NETWORKINTERFACE_PRIVATE_IPS))
__EC2_SECONDARY_PRIVATE_IP_ADDRESS_COUNT= $(if $(EC2_NETWORKINTERFACE_SECONDARYPRIVATEIP_COUNT),--secondary-private-address-count $(EC2_NETWORKINTERFACE_SECONDARYPRIVATEIP_COUNT))
__EC2_SUBNET_ID__NETWORKINTERFACE= $(if $(EC2_NETWORKINTERFACE_SUBNET_ID),--subnet-id $(EC2_NETWORKINTERFACE_SUBNET_ID))

#--- UI
EC2_UI_VIEW_NETWORKINTERFACES_FIELDS?= .[TagSet[?Key=='Name']|[0].Value,NetworkInterfaceId,VpcId,SubnetId,AvailabilityZone,PrivateIpAddress,Status,Attachment.InstanceId]

#--- Utilities

#--- Macros
_ec2_get_networkinterface_public_ip?= $(call _ec2_get_networkinterface_public_ip_I, $(EC2_NETWORKINTERFACE_ID))
_ec2_get_networkinterface_public_ip_I= $(shell $(AWS) ec2 describe-network-interfaces  --network-interface-ids $(1) --query "NetworkInterfaces[].Association.PublicIp" --output text)

_ec2_get_networkinterface_securitygroup_ids= $(call _ec2_get_netowkrinterface_securitygroup_id_I, $(EC2_NETWORKINTERFACE_ID))
_ec2_get_networkinterface_securitygroup_ids_I= $(shell $(AWS) ec2 describe-network-interfaces --network-interface-ids $(1) --query "NetworkInterfaces[].Groups[].GroupId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ec2_view_framework_macros ::
	@echo 'AWS::EC2::NetworkInterface ($(_AWS_EC2_NETWORKINTERFACE_MK_VERSION)) macros:'
	@echo '    _ec2_get_networkinterface_public_ip_{|I}          - Get the public IP of a network-interface (Id)'
	@echo '    _ec2_get_networkinterface_securitygroup_ids_{|I}  - Get the IDS of security-groups on a network-interface (Id)'
	@echo

_ec2_view_framework_parameters ::
	@echo 'AWS::EC2::NetworkInterface ($(_AWS_EC2_NETWORKINTERFACE_MK_VERSION)) parameters:'
	@echo '    EC2_NETWORKINTERFACE_ATTACHMENT_ID=$(EC2_NETWORKINTERFACE_ATTACHMENT_ID)'
	@echo '    EC2_NETWORKINTERFACE_ATTRIBUTES=$(EC2_NETWORKINTERFACE_ATTRIBUTES)'
	@echo '    EC2_NETWORKINTERFACE_DESCRIPTION=$(EC2_NETWORKINTERFACE_DESCRIPTION)'
	@echo '    EC2_NETWORKINTERFACE_DEVICE_INDEX=$(EC2_NETWORKINTERFACE_DEVICE_INDEX)'
	@echo '    EC2_NETWORKINTERFACE_GROUPS=$(EC2_NETWORKINTERFACE_GROUPS)'
	@echo '    EC2_NETWORKINTERFACE_ID=$(EC2_NETWORKINTERFACE_ID)'
	@echo '    EC2_NETWORKINTERFACE_NAME=$(EC2_NETWORKINTERFACE_NAME)'
	@echo '    EC2_NETWORKINTERFACE_PRIVATE_IP=$(EC2_NETWORKINTERFACE_PRIVATE_IP)'
	@echo '    EC2_NETWORKINTERFACE_PRIVATE_IP_COUNT=$(EC2_NETWORKINTERFACE_PRIVATE_IP_COUNT)'
	@echo '    EC2_NETWORKINTERFACE_PRIVATE_IPS=$(EC2_NETWORKINTERFACE_PRIVATE_IPS)'
	@echo '    EC2_NETWORKINTERFACE_SUBNET_ID=$(EC2_NETWORKINTERFACE_SUBNET_ID)'
	@echo '    EC2_NETWORKINTERFACES_FILTER=$(EC2_NETWORKINTERFACES_FILTER)'
	@echo '    EC2_NETWORKINTERFACES_IDS=$(EC2_NETWORKINTERFACES_IDS)'
	@echo '    EC2_NETWORKINTERFACES_SET_NAME=$(EC2_NETWORKINTERFACES_SET_NAME)'
	@echo

_ec2_view_framework_targets ::
	@echo 'AWS::EC2::NetworkInterface ($(_AWS_EC2_NETWORKINTERFACE_MK_VERSION)) targets:'
	@echo '    _ec2_attach_networkinterface               - Attach a network-interface'
	@echo '    _ec2_create_networkinterface               - Create a network-interface'
	@echo '    _ec2_detach_networkinterface               - Detach a network-interface'
	@echo '    _ec2_show_networkinterface                 - Show everything related to a network-interface'
	@echo '    _ec2_show_networkinterface_attributes      - Show network-interfaces attributes'
	@echo '    _ec2_show_networkinterface_description     - Show network-interfaces attributes'
	@echo '    _ec2_view_networkinterfaces                - View all network-interfaces'
	@echo '    _ec2_view_networkinterfaces_set            - View set of network-interfaces'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_attach_networkinterface:
	@$(INFO) '$(EC2_UI_LABEL)Attaching network-interface "$(EC2_NETWORKINTERFACE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 attach-network-interface $(__EC2_NETWORK_INTERFACE_ID) $(__EC2_INSTANCE_ID) $(__EC2_DEVICE_INDEX)

_ec2_create_networkinterface:
	@$(INFO) '$(EC2_UI_LABEL)Creating a new network-interface "$(EC2_NETWORKINTERFACE_NAME)" ...'; $(NORMAL)
	$(AWS) create-network-interface $(__EC2_DESCRIPTION__NETWORKINTERFACE) $(__EC2_GROUPS) $(__EC2_IPV6_ADDRESS_COUNT) $(__EC2_IPV6_ADDRESSES) $(__EC2_PRIVATE_IP_ADDRESS) $(__EC2_PRIVATE_IP_ADDRESSES) $(__EC2_SECONDARY_PRIVATE_IP_ADDRESS_COUNT) $(__EC2_SUBNET_ID__NETWORKINTERFACE)

_ec2_detach_networkinterface:
	@$(INFO) '$(EC2_UI_LABEL)Detaching network-interface "$(EC2_NETWORKINTERFACE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 detach-network-interface $(__EC2_ATTACHMENT_ID)

_ec2_show_networkinterface: _ec2_show_networkinterface_attributes _ec2_show_networkinterface_securitygroups _ec2_show_networkinterface_description

_ec2_show_networkinterface_attributes:
	@$(INFO) '$(EC2_UI_LABEL)Showing attributes of network-interface "$(EC2_NETWORKINTERFACE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-network-interface-attribute $(__EC2_NETWORK_INTERFACE_ID) --attribute attachment
	$(AWS) ec2 describe-network-interface-attribute $(__EC2_NETWORK_INTERFACE_ID) --attribute description
	$(AWS) ec2 describe-network-interface-attribute $(__EC2_NETWORK_INTERFACE_ID) --attribute groupSet
	$(AWS) ec2 describe-network-interface-attribute $(__EC2_NETWORK_INTERFACE_ID) --attribute sourceDestCheck

_ec2_show_networkinterface_description:
	@$(INFO) '$(EC2_UI_LABEL)Showing description of network-interface "$(EC2_NETWORKINTERFACE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-network-interfaces $(_X__EC2_FILTER) $(__EC2_NETWORK_INTERFACE_IDS__NETWORKINTERFACE) --query "NetworkInterfaces[]"

_ec2_show_networkinterface_securitygroups ::
	@$(INFO) '$(EC2_UI_LABEL)Showing security-groups of network-interface "$(EC2_NETWORKINTERFACE_NAME)" ...'; $(NORMAL)

_ec2_view_networkinterfaces:
	@$(INFO) '$(EC2_UI_LABEL)Viewing network-interfaces...'; $(NORMAL)
	$(AWS) ec2 describe-network-interfaces $(_X__EC2_FILTER) $(__EC2_NETWORK_INTERFACE_IDS__NETWORKINTERFACES) --query "NetworkInterfaces[$(EC2_UI_VIEW_NETWORKINTERFACES_QUERYFILTER)]$(EC2_UI_VIEW_NETWORKINTERFACES_FIELDS)"

_ec2_view_networkinterfaces_set:
	@$(INFO) '$(EC2_UI_LABEL)Viewing network-interfaces-set "$(EC2_NETWORKINTERFACES_SET_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-network-interfaces $(__EC2_NETWORK_INTERFACE_IDS__NETWORKINTERFACES) $(__EC2_FILTERS__NETWORKINTERFACES) --query "NetworkInterfaces[$(EC2_UI_VIEW_NETWORKINTERFACES_QUERYFILTER)]$(EC2_UI_VIEW_NETWORKINTERFACES_FIELDS)"
