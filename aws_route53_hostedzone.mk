_AWS_ROUTE53_HOSTEDZONE_MK_VERSION= $(_AWS_ROUTE53_MK_VERSION)

# R53_HOSTEDZONE_CALLER_REFERENCE?=
# R53_HOSTEDZONE_CONFIG?= Comment=string,PrivateZone=boolean
# R53_HOSTEDZONE_ID?=
# R53_HOSTEDZONE_NAME?= domain.com
# R53_HOSTEDZONE_TAGS?= Key=string,Value=string ...
# R53_HOSTEDZONE_VPC?= VPCRegion=us-west-1,VPCId=vpc-12345678
# R53_HOSTEDZONE_VPC_ID?= vpc-12345678
# R53_HOSTEDZONE_VPC_REGION?= us-west-1

# Derived parameters
R53_HOSTEDZONE_VPC?= $(if $(R53_HOSTEDZONE_VPC_ID),VPCRegion=$(R53_HOSTEDZONE_VPC_REGION)$(COMMA)VPCId=$(R53_HOSTEDZONE_VPC_ID))
R53_HOSTEDZONE_VPC_ID?= $(EC2_VPC_ID)
R53_HOSTEDZONE_VPC_REGION?= $(AWS_REGION)

# Option parameters 
__R53_ADD_TAGS__HOSTEDZONE= $(if $(R53_HOSTEDZONE_TAGS), --add-tags $(R53_HOSTEDZONE_TAGS))
__R53_CALLER_REFERENCE= $(if $(R53_HOSTEDZONE_CALLER_REFERENCE), --caller-reference $(R53_HOSTEDZONE_CALLER_REFERENCE))
__R53_COMMENT=
__R53_DELEGATION_SET_ID=
__R53_HOSTED_ZONE_CONFIG= $(if $(R53_HOSTEDZONE_CONFIG), --hosted-zone-config $(R53_HOSTEDZONE_CONFIG))
__R53_HOSTED_ZONE_ID= $(if $(R53_HOSTEDZONE_ID), --hosted-zone-id $(R53_HOSTEDZONE_ID))
__R53_ID__HOSTEDZONE= $(if $(R53_HOSTEDZONE_ID), --id $(R53_HOSTEDZONE_ID))
__R53_NAME__HOSTEDZONE= $(if $(R53_HOSTEDZONE_NAME), --name $(R53_HOSTEDZONE_NAME))
__R53_REMOVE_TAG_KEYS__HOSTEDZONE= $(if $(R53_HOSTEDZONE_TAGS_KEYS), --remove-tag-keys $(R53_HOSTEDZONE_TAGS_KEYS))
__R53_RESOURCE_ID__HOSTEDZONE= $(if $(R53_HOSTEDZONE_ID), --resource-id $(R53_HOSTEDZONE_ID))
__R53_RESOURCE_TYPE__HOSTEDZONE= --resource-type hostedzone
__R53_TRAFFIC_POLICY_INSTANCE_NAME_MARKER=
__R53_TRAFFIC_POLICY_INSTANCE_TYPE_MARKER=
__R53_VPC= $(if $(R53_HOSTEDZONE_VPC), --vpc $(R53_HOSTEDZONE_VPC))

# UI parameters
R53_UI_VIEW_HOSTEDZONES_FIELDS?= .{Id:Id,Name:Name,resourceRecordSetCount:ResourceRecordSetCount,privateZone:Config.PrivateZone,callerReference:CallerReference}

#--- Utilities

#--- Macro
_r53_get_hostedzone_count= $(shell $(AWS) route53 get-hosted-zone-count --query "HostedZoneCount" --output text)

# /hostedzone/XXXXXXXX --> XXXXXXX
_r53_get_hostedzone_id= $(call _r53_get_hostedzone_id_N, $(R53_HOSTEDZONE_NAME))
_r53_get_hostedzone_id_N= $(lastword $(subst /,$(SPACE),$(shell $(AWS) route53 list-hosted-zones --query "HostedZones[?Name=='$(strip $(1)).'].Id" --output text)))

#----------------------------------------------------------------------
# USAGE
#

_r53_view_framework_macros ::
	@echo 'AWS::Route53::HostedZone ($(_AWS_ROUTE53_HOSTEDZONE_MK_VERSION)) macros:'
	@echo '    _r53_get_hostedzone_count                 - Get the number of hosted-zones'
	@echo '    _r53_get_hostedzone_id_{|N}               - Get the ID of a hosted-zone (Name)'
	@echo

_r53_view_framework_parameters ::
	@echo 'AWS::Route53::HostedZone ($(_AWS_ROUTE53_HOSTEDZONE_MK_VERSION)) parameters:'
	@echo '    R53_HOSTEDZONE_CALLER_REFERENCE=$(R53_HOSTEDZONE_CALLER_REFERENCE)'
	@echo '    R53_HOSTEDZONE_CONFIG=$(R53_HOSTEDZONE_CONFIG)'
	@echo '    R53_HOSTEDZONE_NAME=$(R53_HOSTEDZONE_NAME)'
	@echo '    R53_HOSTEDZONE_ID=$(R53_HOSTEDZONE_ID)'
	@echo '    R53_HOSTEDZONE_TAGS=$(R53_HOSTEDZONE_TAGS)'
	@echo '    R53_HOSTEDZONE_TAGS_KEYS=$(R53_HOSTEDZONE_TAGS_KEYS)'
	@echo '    R53_HOSTEDZONE_VPC=$(R53_HOSTEDZONE_VPC)'
	@echo '    R53_HOSTEDZONE_VPC_ID=$(R53_HOSTEDZONE_VPC_ID)'
	@echo '    R53_HOSTEDZONE_VPC_REGION=$(R53_HOSTEDZONE_VPC_REGION)'
	@echo

_r53_view_framework_targets ::
	@echo 'AWS::Route53::HostedZone ($(_AWS_ROUTE53_HOSTEDZONE_MK_VERSION)) targets:'
	@echo '    _r53_associate_vpc_to_hostedzone           - Associate a VPC to a hosted-zone'
	@echo '    _r53_create_hostedzone                     - Create a hosted-zone'
	@echo '    _r53_delete_hostedzone                     - Delete a hosted-zone'
	@echo '    _r53_disassociate_vpc_from_hostedzone      - Disassociate a VPC to a hosted-zone'
	@echo '    _r53_show_hostedzone                       - Show details of a hosted-zone'
	@echo '    _r53_show_hostedzone_description           - Show description of a hosted-zone'
	@echo '    _r53_show_hostedzone_limits                - Show limits of a hosted-zone'
	@echo '    _r53_show_hostedzone_localhost             - Show hosted-zone from localhost'
	@echo '    _r53_tag_hostedzone                        - Tag a hosted-zone'
	@echo '    _r53_untag_hostedzone                      - Untag a hosted-zone'
	@echo '    _r53_update_hostedzone_comment             - Update comment of a hosted-zone'
	@echo '    _r53_view_hostedzones                      - View the hosted-zones'
	@echo '    _r53_view_hostedzones_set                  - View a set of hosted-zones'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_r53_associate_vpc_with_hostedzone:
	@$(INFO) '$(AWS_UI_LABEL)Associating VPC to hosted-zone "$(R53_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	$(AWS) route53 associate-vpc-with-hosted-zone $(__R53_COMMENT) $(__R53_HOSTED_ZONE_ID) $(__R53_VPC)

_r53_create_hostedzone:
	@$(INFO) '$(AWS_UI_LABEL)Creating hosted-zone "$(R53_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the hosted-zone already exist'; $(NORMAL)
	@$(WARN) 'This operation fails if the caller-reference has previously been used'; $(NORMAL)
	$(AWS) route53 create-hosted-zone $(__R53_CALLER_REFERENCE) $(__R53_DELEGATION_SET_ID) $(__R53_HOSTED_ZONE_CONFIG) $(__R53_NAME__HOSTEDZONE) $(__R53_VPC)

_r53_delete_hostedzone:
	@$(INFO) '$(AWS_UI_LABEL)Deleting hosted-zone "$(R53_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	$(AWS) route53 delete-hosted-zone $(__R53_ID__HOSTEDZONE)

_r53_disassociate_vpc_from_hostedzone:
	@$(INFO) '$(AWS_UI_LABEL)Disassociating VPC from hosted-zone "$(R53_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	$(AWS) route53 disassociate-vpc-from-hosted-zone $(__R53_COMMENT) $(__R53_HOSTED_ZONE_ID) $(__R53_VPC)

_r53_show_hostedzone: _r53_show_hostedzone_limits _r53_show_hostedzone_localhost _r53_show_hostedzone_description

_r53_show_hostedzone_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of hosted-zone "$(R53_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	$(AWS) route53 get-hosted-zone $(__R53_ID__HOSTEDZONE)

_r53_show_hostedzone_limits:
	@$(INFO) '$(AWS_UI_LABEL)Showing record-limit of hosted-zone "$(R53_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	$(AWS) route53 get-hosted-zone-limit $(__R53_HOSTED_ZONE_ID) $(_X_R53_TYPE) --type MAX_RRSETS_BY_ZONE
	@$(INFO) '$(AWS_UI_LABEL)Showing VPC-limit of hosted-zone "$(R53_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the hosted-zone is not a private one'; $(NORMAL)
	-$(AWS) route53 get-hosted-zone-limit $(__R53_HOSTED_ZONE_ID) $(_X_R53_TYPE) --type MAX_VPCS_ASSOCIATED_BY_ZONE

_r53_show_hostedzone_localhost:
	@$(INFO) '$(CMN_UI_LABEL)Showing from localhost the hosted-zone "$(R53_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails for PRIVATE hosted-zone'; $(NORMAL)
	@$(WARN) 'This operation only returns SOA, NS, and ... records, not the complete zone'; $(NORMAL)
	dig any $(R53_HOSTEDZONE_NAME)

_r53_show_hostedzone_trafficpolicyinstance:
	@$(INFO) '$(AWS_UI_LABEL)Showing traffic-policy-instance of hosted-zone "$(R53_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	$(AWS) route53 list-traffic-policy-instances-by-hosted-zone $(__R53_HOSTEDZONE_ID) $(__R53_TRAFFIC_POLICY_INSTANCE_NAME_MARKER) $(__R53_TRAFFIC_POLICY_INSTANCE_TYPE_MARKER) 

_r53_tag_hostedzone:
	@$(INFO) '$(AWS_UI_LABEL)Tagging hosted-zone "$(R53_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	$(AWS) route53 change-tags-for-resoource $(__R53_ADD_TAGS__HOSTEDZONE) $(_X__R53_REMOVE_TAG_KEYS__HOSTEDZONE) $(__R53_RESOURCE_TYPE__HOSTEDZONE) $(__R53_RESOURCE_ID__HOSTEDZONE)

_r53_untag_hostedzone:
	@$(INFO) '$(AWS_UI_LABEL)Untagging hosted-zone "$(R53_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	$(AWS) route53 change-tags-for-resoource $(_X__R53_ADD_TAGS__HOSTEDZONE) $(__R53_REMOVE_TAG_KEYS__HOSTEDZONE) $(__R53_RESOURCE_TYPE__HOSTEDZONE) $(__R53_RESOURCE_ID_HOSTEDZONE)

_r53_update_hostedzone_comment:
	@$(INFO) '$(AWS_UI_LABEL)Updating comment of hosted-zone "$(R53_HOSTEDZONE_NAME)" ...'; $(NORMAL)
	$(AWS) route53 update-hosted-zone-comment $(__R53_COMMENT) $(__R53_ID__HOSTEDZONE) 

_r53_view_hostedzones:
	@$(INFO) '$(AWS_UI_LABEL)Viewing hosted-zones ...'; $(NORMAL)
	$(AWS) route53 list-hosted-zones --query "HostedZones[]$(R53_UI_VIEW_HOSTEDZONES_FIELDS)"

_r53_view_hostedzones_set:
