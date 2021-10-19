_AWS_EC2_VPCENDPOINT_MK_VERSION= $(_AWS_EC2_MK_VERSION)

# EC2_VPCENDPOINT_FILTER?=
# EC2_VPCENDPOINT_ID?= vpce-svc-0fa4333b251b442ce
# EC2_VPCENDPOINT_NAME?= com.amazonaws.us-west-2.secretsmanager
# EC2_VPCENDPOINT_POLICYDOCUMENT?=
# EC2_VPCENDPOINT_POLICYDOCUMENT_DIRPATH?=
# EC2_VPCENDPOINT_POLICYDOCUMENT_FILENAME?=
# EC2_VPCENDPOINT_POLICYDOCUMENT_FILEPATH?=
EC2_VPCENDPOINT_PRIVATEDNS_FLAG?= true
# EC2_VPCENDPOINT_ROUTETABLE_IDS?=
# EC2_VPCENDPOINT_SECURITYGROUP_IDS?=
# EC2_VPCENDPOINT_SUBNET_IDS?=
EC2_VPCENDPOINT_TYPE?= Gateway
# EC2_VPCENDPOINT_VPCENDPOINTSERVICE_NAME?=
# EC2_VPCENDPOINTS_FILTER?=
# EC2_VPCENDPOINTS_IDS?=
# EC2_VPCENDPOINTS_NAMES?=
# EC2_VPCENDPOINTS_SET_NAME?=

# Derived
EC2_VPCENDPOINT_NAME?= $(EC2_VPCENDPOINTSERVICE_SHORTNAME)
EC2_VPCENDPOINT_POLICYDOCUMENT?= $(if $(EC2_VPCENDPOINT_POLICYDOCUMENT_FILEPATH),file://$(EC2_VPCENDPOINT_POLICYDOCUMENT_FILEPATH))
EC2_VPCENDPOINT_POLICYDOCUMENT_DIRPATH?= $(EC2_INPUTS_DIRPATH)
EC2_VPCENDPOINT_POLICYDOCUMENT_FILEPATH?= $(if $(EC2_VPCENDPOINT_POLICYDOCUMENT_FILENAME),$(EC2_VPCENDPOINT_POLICYDOCUMENT_DIRPATH)$(EC2_VPCENDPOINT_POLICYDOCUMENT_FILENAME))
EC2_VPCENDPOINT_VPC_ID?= $(EC2_VPC_ID)
EC2_VPCENDPOINT_VPCENDPOINTSERVICE_NAME?= $(EC2_VPCENDPOINTSERVICE_NAME)

# Options
__EC2_CLIENT_TOKEN=
__EC2_DRY_RUN__VPCENDPOINT=
__EC2_FILTER__VPCENDPOINT= $(if $(EC2_VPCENDPOINT_FILTER),--filter $(EC2_VPCENDPOINT_FILTER))
__EC2_FILTER__VPCENDPOINTS= $(if $(EC2_VPCENDPOINTS_FILTER),--filter $(EC2_VPCENDPOINTS_FILTER))
__EC2_POLICY_DOCUMENT= $(if $(EC2_VPCENDPOINT_POLICYDOCUMENT),--policy-document $(EC2_VPCENDPOINT_POLICYDOCUMENT))
__EC2_PRIVATE_DNS_ENABLED= $(if $(filter false, $(EC2_VPCENDPOINT_PRIVATEDNS_FLAG)),--no-private-dns-enabled,--private-dns-enabled)
__EC2_ROUTE_TABLE_IDS__VPCENDPOINT= $(if $(EC2_VPCENDPOINT_ROUTETABLE_IDS),--route-table-ids $(EC2_VPCENDPOINT_ROUTETABLE_IDS))
__EC2_SECURITY_GROUP_IDS__VPCENDPOINT= $(if $(EC2_VPCENDPOINT_SECURITYGROUP_IDS),--security-group-ids $(EC2_VPCENDPOINT_SECURITYGROUP_IDS))
__EC2_SERVICE_NAME__VPCENDPOINT= $(if $(EC2_VPCENDPOINT_VPCENDPOINTSERVICE_NAME),--service-name $(EC2_VPCENDPOINT_VPCENDPOINTSERVICE_NAME))
__EC2_SUBNET_IDS__VPCENDPOINT= $(if $(EC2_VPCENDPOINT_SUBNET_IDS),--subnet-ids $(EC2_VPCENDPOINT_SUBNET_IDS))
__EC2_VPC_ENDPOINT_IDS__VPCENDPOINT= $(if $(EC2_VPCENDPOINT_ID),--vpc-endpoint-ids $(EC2_VPCENDPOINT_ID))
__EC2_VPC_ENDPOINT_IDS__VPCENDPOINTS= $(if $(EC2_VPCENDPOINTS_IDS),--vpc-endpoint-ids $(EC2_VPCENDPOINTS_IDS))
__EC2_VPC_ENDPOINT_TYPE= $(if $(EC2_VPCENDPOINT_TYPE),--vpc-endpoint-type $(EC2_VPCENDPOINT_TYPE))
__EC2_VPC_ID__VPCENDPOINT= $(if $(EC2_VPCENDPOINT_VPC_ID),--vpc-id $(EC2_VPCENDPOINT_VPC_ID))

# UI parameters
# EC2_UI_SHOW_VPCENDPOINTSERVICE_QUERYFILTER?= ?ServiceName=='$(strip $(EC2_VPCENDPOINTSERVICE_NAME))'
EC2_UI_VIEW_VPCENDPOINTSERVICES_FIELDS?=
EC2_UI_VIEW_VPCENDPOINTSERVICES_SET_FIELDS?=
EC2_UI_VIEW_VPCENDPOINTSERVICES_SET_QUERYFILTER?=

#--- MACROS
# _ec2_get_vpcendpoint_id= $(call _ec2_get_vpcendpointservice_id_N, $(EC2_VPCENDPOINTSERVICE_NAME))
# _ec2_get_vpcendpoint_id_N= $(shell $(AWS) ec2 describe-vpc-endpoint-services --filter Name=service-name,Values=$(strip $(1)) --query "ServiceDetails[].ServiceId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ec2_view_framework_macros ::
	@echo 'AWS::EC2::VpcEndpoint ($(_AWS_EC2_VPCENDPOINT_MK_VERSION)) macros:'
	@#echo '    _ec2_get_vpcendpointservice_id_{|N}                 - Get the id of a VPC-endpoint-service (Name)'
	@#echo '    _ec2_get_vpcendpointservice_name_{|S|SR}            - Get the name of a VPC-endpoint-service (ShortName,Region)'
	@#echo '    _ec2_get_vpcendpointservice_showname_{|N}           - Get the short-name of a VPC-endpoint-service (Name)'
	@echo

_ec2_view_framework_parameters ::
	@echo 'AWS::EC2::VpcEndpoint ($(_AWS_EC2_VPCENDPOINT_MK_VERSION)) parameters:'
	@echo '    EC2_VPCENDPOINT_FILTER=$(EC2_VPCENDPOINT_FILTER)'
	@echo '    EC2_VPCENDPOINT_ID=$(EC2_VPCENDPOINT_ID)'
	@echo '    EC2_VPCENDPOINT_FILTER=$(EC2_VPCENDPOINT_FILTER)'
	@echo '    EC2_VPCENDPOINT_NAME=$(EC2_VPCENDPOINT_NAME)'
	@echo '    EC2_VPCENDPOINT_POLICYDOCUMENT=$(EC2_VPCENDPOINT_POLICYDOCUMENT)'
	@echo '    EC2_VPCENDPOINT_POLICYDOCUMENT_DIRPATH=$(EC2_VPCENDPOINT_POLICYDOCUMENT_DIRPATH)'
	@echo '    EC2_VPCENDPOINT_POLICYDOCUMENT_FILENAME=$(EC2_VPCENDPOINT_POLICYDOCUMENT_FILENAME)'
	@echo '    EC2_VPCENDPOINT_POLICYDOCUMENT_FILEPATH=$(EC2_VPCENDPOINT_POLICYDOCUMENT_FILEPATH)'
	@echo '    EC2_VPCENDPOINT_PRIVATEDNS_FLAG=$(EC2_VPCENDPOINT_PRIVATEDNS_FLAG)'
	@echo '    EC2_VPCENDPOINT_ROUTETABLE_IDS=$(EC2_VPCENDPOINT_ROUTETABLE_IDS)'
	@echo '    EC2_VPCENDPOINT_SECURITYGROUP_IDS=$(EC2_VPCENDPOINT_SECURITYGROUP_IDS)'
	@echo '    EC2_VPCENDPOINT_SUBNET_IDS=$(EC2_VPCENDPOINT_SUBNET_IDS)'
	@echo '    EC2_VPCENDPOINT_TYPE=$(EC2_VPCENDPOINT_TYPE)'
	@echo '    EC2_VPCENDPOINT_VPC_ID=$(EC2_VPCENDPOINT_VPC_ID)'
	@echo '    EC2_VPCENDPOINT_VPCENDPOINTSERVICE_NAME=$(EC2_VPCENDPOINT_VPCENDPOINTSERVICE_NAME)'
	@echo '    EC2_VPCENDPOINTS_IDS=$(EC2_VPCENDPOINTS_IDS)'
	@echo '    EC2_VPCENDPOINTS_NAMES=$(EC2_VPCENDPOINTS_NAMES)'
	@echo '    EC2_VPCENDPOINTS_SET_NAME=$(EC2_VPCENDPOINTS_SET_NAME)'
	@echo

_ec2_view_framework_targets ::
	@echo 'AWS::EC2::VpcEndpoint ($(_AWS_EC2_VPCENDPOINT_MK_VERSION)) targets:'
	@echo '    _ec2_create_vpcendpoint                     - Create a VPC-endpoint'
	@echo '    _ec2_delete_vpcendpoint                     - Delete an existing VPC-endpoint'
	@echo '    _ec2_show_vpcendpoint                       - Show everything related to a VPC-endpoint'
	@echo '    _ec2_show_vpcendpoint_description           - Show description of a VPC-endpoint'
	@echo '    _ec2_view_vpcendpoints                      - View VPC-endpoints'
	@echo '    _ec2_view_vpcendpoints_set                  - View set of VPC-endpoints'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_create_vpcendpoint:
	@$(INFO) '$(EC2_UI_LABEL)Creating vpc-endpoint "$(EC2_VPCENDPOINT_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 create-vpc-endpoint $(strip $(__EC2_CLIENT_TOKEN) $(__EC2_POLICY_DOCUMENT) $(__EC2_PRIVATE_DNS_ENABLED) $(__EC2_ROUTE_TABLE_IDS__VPCENDPOINT) $(__EC2_SECURITY_GROUP_IDS__VPCENDPOINT) $(__EC2_SERVICE_NAME__VPCENDPOINT) $(__EC2_SUBNET_IDS__VPCENDPOINT) $(__EC2_VPC_ENDPOINT_TYPE) $(__EC2_VPC_ID__VPCENDPOINT))


_ec2_delete_vpcendpoint:
	@$(INFO) '$(EC2_UI_LABEL)Deleting vpc-endpoint "$(EC2_VPCENDPOINT_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 delete-vpc-endpoint $(__EC2_DRY_RUN__VPCENDPOINT) $(__EC2_VPC_ENDPOINT_IDS__VPCENDPOINT)

_ec2_show_vpcendpoint: _ec2_show_vpcendpoint_description

_ec2_show_vpcendpoint_description:
	@$(INFO) '$(EC2_UI_LABEL)Showing description of vpc-endpoint "$(EC2_VPCENDPOINT_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-vpc-endpoints $(__EC2_FILTER__VPCENDPOINTS) $(__EC2_VPC_ENDPOINT_IDS__VPCENDPOINT) # --query "ServiceDetails[$(EC2_UI_SHOW_VPCENDPOINTSERVICE_QUERYFILTER)]"

_ec2_view_vpcendpoints:
	@$(INFO) '$(EC2_UI_LABEL)View vpc-endpoints ...'; $(NORMAL)
	$(AWS) ec2 describe-vpc-endpoints $(_X__EC2_FILTER__VPCENDPOINTS) $(_X__EC2_VPC_ENDPOINT_IDS__VPCENDPOINTS)# --query "ServiceNames[]$((EC2_UI_VIEW_VPCENDPOINTSERVICES_FIELDS)"

_ec2_view_vpcendpoints_set:
	@$(INFO) '$(EC2_UI_LABEL)View vpc-endpoints-set "$(EC2_VPCENDPOINTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'VPC-endpoints are grouped based on filter, ids, and query-filter'; $(NORMAL)
	$(AWS) ec2 describe-vpc-endpoints $(__EC2_FILTER__VPCENDPOINTS) $(__EC2_VPC_ENDPOINT_IDS__VPCENDPOINTS)# --query "ServiceNames[$(_EC2_UI_VIEW_VPCENDPOINTSERVICES_SET_QUERYFILTER)]$(EC2_UI_VIEW_VPCENDPOINTSERVICES_SET_FIELDS)"
