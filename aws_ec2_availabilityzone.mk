_AWS_EC2_AVAILABILITYZONE_MK_VERSION= $(_AWS_EC2_MK_VERSION)

# EC2_AVAILABILITYZONE_NAME?= us-east-1a
# EC2_AVAILABILITYZONES_IDS?= 
# EC2_AVAILABILITYZONES_NAMES?= us-east-1a

# Derived parameters

# Options
# __EC2_VPC_PEERING_CONNECTION_ID= $(if $(EC2_VPCPEERING_ID), --vpc-peering-connection-id $(EC2_VPCPEERING_ID))

# Customizations
_EC2_LIST_AVAILABILITYZONES_FIELDS?= .{ZoneId:ZoneId,ZoneName:ZoneName,state:State}
_EC2_LIST_AVAILABILITYZONES_SET_FIELDS?= $(EC2_LIST_AVAILABILITYZONES_FIELDS)

#--- MACROS

_ec2_get_availabilityzones_names= $(strip $(shell $(AWS) ec2 describe-availability-zones --query "AvailabilityZones[].ZoneName" --output text))

#----------------------------------------------------------------------
# USAGE
#

_ec2_list_macros ::
	@echo 'AWS::EC2::AvailabilityZone ($(_AWS_EC2_AVAILABILITYZONE_MK_VERSION)) macros:'
	@echo '    _ec2_get_availabilityzones_names         - Get the names of the availability-zones'
	@echo

_ec2_list_parameters ::
	@echo 'AWS::EC2::AvailabilityZone ($(_AWS_EC2_AVAILAVILITYZONE_MK_VERSION)) parameters:'
	@echo '    EC2_AVAILABILITYZONE_ID=$(EC2_AVAILABILITYZONE_ID)'
	@echo '    EC2_AVAILABILITYZONE_NAME=$(EC2_AVAILABILITYZONE_NAME)'
	@echo '    EC2_AVAILABILITYZONES_IDS=$(EC2_AVAILABILITYZONES_IDS)'
	@echo '    EC2_AVAILABILITYZONES_NAMES=$(EC2_AVAILABILITYZONES_NAMES)'
	@echo '    EC2_AVAILABILITYZONES_SET_NAME=$(EC2_AVAILABILITYZONES_SET_NAME)'
	@echo

_ec2_list_targets ::
	@echo 'AWS::EC2::VpcPeering ($(_AWS_EC2_AVAILABILITYZONE_MK_VERSION)) targets:'
	@echo '    _ec2_list_availabilityzones                   - List all availability-zones'
	@echo '    _ec2_list_availabilityzones_set               - List a set of availability-zones'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_create_availabilityzone:
	@# If implemented the normal way, the tag_peering cannot get the resource that wasn't yet created!

_ec2_delete_availabilityzone:

_ec2_show_availabilityzone: 

_ec2_list_availabilityzones:
	@$(INFO) '$(EC2_UI_LABEL)Listing ALL availability-zones ...'; $(NORMAL)
	$(AWS) ec2 describe-availability-zones $(_X__EC2_FILTERS__AVAILABILITYZONES) $(_X__EC2_ZONE_IDS) $(_X__EC2_ZONE_NAMES) --query "AvailabilityZones[]$(_EC2_LIST_AVAILABILITYZONES_FIELDS)"

_ec2_list_availabilityzones_set:
	@$(INFO) '$(EC2_UI_LABEL)Listing availability-zones-set "$(EC2_AVAILABILITYZONES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Availability-zones are grouped based on the provided filter, ids, names'; $(NORMAL)
	$(AWS) ec2 describe-availability-zones $(__EC2_FILTERS__AVAILABILITYZONES) $(__EC2_ZONE_IDS) $(__EC2_ZONE_NAMES) --query "AvailabilityZones[]$(_EC2_LIST_AVAILABILITYZONES_SET_FIELDS)"
