_AWS_EC2_VPCENDPOINTSERVICE_MK_VERSION= $(_AWS_EC2_MK_VERSION)

# EC2_VPCENDPOINTSERVICE_FILTER?=
# EC2_VPCENDPOINTSERVICE_ID?= vpce-svc-0fa4333b251b442ce
# EC2_VPCENDPOINTSERVICE_NAME?= com.amazonaws.us-west-2.secretsmanager
# EC2_VPCENDPOINTSERVICE_SHORTNAME?= secretsmanager
# EC2_VPCENDPOINTSERVICE_REGION_ID?= us-west-2
# EC2_VPCENDPOINTSERVICES_FILTER?=
# EC2_VPCENDPOINTSERVICES_IDS?=
# EC2_VPCENDPOINTSERVICES_NAMES?=
# EC2_VPCENDPOINTSERVICES_SHORTNAMES?=
# EC2_VPCENDPOINTSERVICES_SET_NAME?=

# Derived parameters
EC2_VPCENDPOINTSERVICE_REGION_ID?= $(AWS_REGION_ID)

# Options
__EC2_FILTER__VPCENDPOINTSERVICE= $(if $(EC2_VPCENDPOINTSERVICE_FILTER),--filter $(EC2_VPCENDPOINTSERVICE_FILTER))
__EC2_FILTER__VPCENDPOINTSERVICES= $(if $(EC2_VPCENDPOINTSERVICES_FILTER),--filter $(EC2_VPCENDPOINTSERVICES_FILTER))
__EC2_SERVICE_NAMES__VPCENDPOINTSERVICES= $(if $(EC2_VPCENDPOINTSERVICES_NAMES),--vpc-endpoint-services $(EC2_VPCENDPOINTSERVICES_NAMES))

# Customization parameters
_EC2_LIST_VPCENDPOINTSERVICES_FIELDS?=
_EC2_LIST_VPCENDPOINTSERVICES_SET_FIELDS?=
_EC2_LIST_VPCENDPOINTSERVICES_SET_QUERYFILTER?=
_EC2_SHOW_VPCENDPOINTSERVICE_QUERYFILTER?= ?ServiceName=='$(strip $(EC2_VPCENDPOINTSERVICE_NAME))'

# Macros
_ec2_get_vpcendpointservice_id= $(call _ec2_get_vpcendpointservice_id_N, $(EC2_VPCENDPOINTSERVICE_NAME))
_ec2_get_vpcendpointservice_id_N= $(shell $(AWS) ec2 describe-vpc-endpoint-services --filter Name=service-name,Values=$(strip $(1)) --query "ServiceDetails[].ServiceId" --output text)

_ec2_get_vpcendpointservice_name= $(call _ec2_get_vpcendpointservice_name_S, $(EC2_VPCENDPOINTSERVICE_SHORTNAME))
_ec2_get_vpcendpointservice_name_S= $(call _ec2_get_vpcendpointservice_name_SR, $(1), $(EC2_VPCENDPOINTSERVICE_REGION_ID))
_ec2_get_vpcendpointservice_name_SR= $(shell echo "com.amazonaws.$(strip $(2)).$(strip $(1))")

_ec2_get_vpcendpointservice_shortname= $(call _ec2_get_vpcendpointservice_shortname_N, $(EC2_VPCENDPOINTSERVICE_NAME))
_ec2_get_vpcendpointservice_shortname_N= $(lastword $(substr .,$(SPACE), $(1)))

#----------------------------------------------------------------------
# USAGE
#

_ec2_list_macros ::
	@echo 'AWS::EC2::VpcEndpointService ($(_AWS_EC2_VPCENDPOINTSERVICE_MK_VERSION)) macros:'
	@echo '    _ec2_get_vpcendpointservice_id_{|N}                 - Get the id of a VPC-endpoint-service (Name)'
	@echo '    _ec2_get_vpcendpointservice_name_{|S|SR}            - Get the name of a VPC-endpoint-service (ShortName,Region)'
	@echo '    _ec2_get_vpcendpointservice_showname_{|N}           - Get the short-name of a VPC-endpoint-service (Name)'
	@echo

_ec2_list_parameters ::
	@echo 'AWS::EC2::VpcEndpointService ($(_AWS_EC2_VPCENDPOINTSERVICE_MK_VERSION)) parameters:'
	@echo '    EC2_VPCENDPOINTSERVICE_FILTER=$(EC2_VPCENDPOINTSERVICE_FILTER)'
	@echo '    EC2_VPCENDPOINTSERVICE_ID=$(EC2_VPCENDPOINTSERVICE_ID)'
	@echo '    EC2_VPCENDPOINTSERVICES_FILTER=$(EC2_VPCENDPOINTSERVICES_FILTER)'
	@echo '    EC2_VPCENDPOINTSERVICE_NAME=$(EC2_VPCENDPOINTSERVICE_NAME)'
	@echo '    EC2_VPCENDPOINTSERVICE_SHORTNAME=$(EC2_VPCENDPOINTSERVICE_SHORTNAME)'
	@echo '    EC2_VPCENDPOINTSERVICES_IDS=$(EC2_VPCENDPOINTSERVICES_IDS)'
	@echo '    EC2_VPCENDPOINTSERVICES_NAMES=$(EC2_VPCENDPOINTSERVICES_NAMES)'
	@echo '    EC2_VPCENDPOINTSERVICES_SHORTNAMES=$(EC2_VPCENDPOINTSERVICES_SHORTNAMES)'
	@echo '    EC2_VPCENDPOINTSERVICES_SET_NAME=$(EC2_VPCENDPOINTSERVICES_SET_NAME)'
	@echo

_ec2_list_targets ::
	@echo 'AWS::EC2::VpcEndpointService ($(_AWS_EC2_VPCENDPOINTSERVICE_MK_VERSION)) targets:'
	@echo '    _ec2_create_vpcendpointservice                     - Create a VPC-endpoint-service'
	@echo '    _ec2_delete_vpcendpointservice                     - Delete an existing VPC-endpoint-service'
	@echo '    _ec2_show_vpcendpointservice                       - Show everything related to a VPC-endpoint-service'
	@echo '    _ec2_show_vpcendpointservice_description           - Show description of a VPC-endpoint-service'
	@echo '    _ec2_list_vpcendpointservices                      - List all VPC-endpoint-services'
	@echo '    _ec2_list_vpcendpointservices_set                  - List a set of VPC-endpoint-services'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_create_vpcendpointservice:
	@$(INFO) '$(EC2_UI_LABEL)Creating vpc-endpoint-service "$(EC2_VPCENDPOINTSERVICE_NAME)" ...'; $(NORMAL)
	# Not allowed

_ec2_delete_vpcendpointservice:
	@$(INFO) '$(EC2_UI_LABEL)Deleting vpc-endpoint-service "$(EC2_VPCENDPOINTSERVICE_NAME)" ...'; $(NORMAL)
	# Not allowed!

_ec2_list_vpcendpointservices:
	@$(INFO) '$(EC2_UI_LABEL)Listing vpc-endpoint-services ...'; $(NORMAL)
	$(AWS) ec2 describe-vpc-endpoint-services $(_X__EC2_FILTER__VPCENDPOINTSERVICES) $(__EC2_SERVICE_NAMES__VPCENDPOINTSERVICES) --query "ServiceNames[]$((_EC2_LIST_VPCENDPOINTSERVICES_FIELDS)"

_ec2_list_vpcendpointservices_set:
	@$(INFO) '$(EC2_UI_LABEL)Listing vpc-endpoint-services-set "$(EC2_VPCENDPOINTSERVICES_SET_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-vpc-endpoint-services $(__EC2_FILTER__VPCENDPOINTSERVICES) $(__EC2_SERVICE_NAMES__VPCENDPOINTSERVICES) --query "ServiceNames[$(__EC2_LIST_VPCENDPOINTSERVICES_SET_QUERYFILTER)]$(_EC2_LIST_VPCENDPOINTSERVICES_SET_FIELDS)"

_EC2_SHOW_VPCENDPOINTSERVICE_TARGETS?= _ec2_show_vpcendpointservice_description
_ec2_show_vpcendpointservice: $(_EC2_SHOW_VPCENDPOINTSERVICE_TARGETS)

_ec2_show_vpcendpointservice_description:
	@$(INFO) '$(EC2_UI_LABEL)Showing description of vpc-endpoint-service "$(EC2_VPCENDPOINTSERVICE_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-vpc-endpoint-services $(__EC2_FILTER__VPCENDPOINTSERVICE) --query "ServiceDetails[$(_EC2_SHOW_VPCENDPOINTSERVICE_QUERYFILTER)]"
