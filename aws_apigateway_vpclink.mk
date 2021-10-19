_AWS_APIGATEWAY_VPCLINK_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_VPCLINK_ID?= aeds9s0no6
# AGY_VPCLINK_DESCRIPTION?=
# AGY_VPCLINK_NAME?=
# AGY_VPCLINK_PATCH_OPERATIONS?= op=string,path=string,value=string,from=string ...
# AGY_VPCLINK_TARGET_ARNS?=
# AGY_VPCLINKS_SET_NAME?=

# Derived parameters

# Option parameters
__AGY_DESCRIPTION__VPCLINK= $(if $(AGY_VPCLINK_DESCRIPTION), --description $(AGY_VPCLINK_DESCRIPTION))
__AGY_NAME__VPCLINK= $(if $(AGY_VPCLINK_NAME), --name $(AGY_VPCLINK_NAME))
__AGY_PATCH_OPERATIONS__VPCLINK= $(if $(AGY_VPCLINK_PATCH_OPERATIONS), --patch-operations $(AGY_VPCLINK_PATCH_OPEARTIONS))
__AGY_TARGET_ARNS= $(if $(AGY_VPCLINK_TARGET_ARNS), --target-arns $(AGY_VPCLINK_TARGET_ARNS))
__AGY_VPC_LINK_ID= $(if $(AGY_VPCLINK_ID), --vpc-link-id $(AGY_VPCLINK_ID))

# UI parameters
AGY_UI_VIEW_VPCLINKS_FIELDS?=
AGY_UI_VIEW_VPCLINKS_SET_FIELDS?= $(AGY_UI_VIEW_VPCLINKS_FIELDS)
AGY_UI_VIEW_VPCLINKS_SET_SLICE?=

#--- MACROS
_agy_get_vpclink_id= $(call _agy_get_vpclink_id_N, $(AGY_VPCLINK_NAME))
_agy_get_vpclink_id_N= $(shell $(AWS) apigateway get-vpc-link --vpc-link-d $(1) --query "value" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::VpcLink ($(_AWS_APIGATEWAY_VPCLINK_MK_VERSION)) macros:'
	@echo '    _agy_get_vpclink_id_{|N}            - Get the ID of a VPC-link (Name)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::VpcLink ($(_AWS_APIGATEWAY_VPCLINK_MK_VERSION)) parameters:'
	@echo '    AGY_VPCLINK_DESCRIPTION=$(AGY_VPCLINK_DESCRIPTION)'
	@echo '    AGY_VPCLINK_ID=$(AGY_VPCLINK_ID)'
	@echo '    AGY_VPCLINK_NAME=$(AGY_VPCLINK_NAME)'
	@echo '    AGY_VPCLINK_PATCH_OPEATIONS=$(AGY_VPCLINK_PATCH_OPERATIONS)'
	@echo '    AGY_VPCLINK_TARGET_ARNS=$(AGY_VPCLINK_TARGET_ARNS)'
	@echo '    AGY_VPCLINKS_SET_NAME=$(AGY_VPCLINKS_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::VpcLink ($(_AWS_APIGATEWAY_VPCLINK_MK_VERSION)) targets:'
	@echo '    _agy_create_vpclink                   - Create a new API-key'
	@echo '    _agy_delete_vpclink                   - Delete an existing API-key'
	@echo '    _agy_show_vpclink                     - Show everything related to an API-key'
	@echo '    _agy_update_vpclink                   - Update an API-key'
	@echo '    _agy_view_vpclinks                    - View API-keys'
	@echo '    _agy_view_vpclinks_set                - View a set of API-keys'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_vpclink:
	@$(INFO) '$(AWS_UI_LABEL)Creating VPC-link "$(AGY_VPCLINK_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-vpc-link $(__AGY_DESCRIPTION__VPCLINK) $(__AGY_NAME__VPCLINK) $(__AGY_TARGET_ARNS)

_agy_delete_vpclink:
	@$(INFO) '$(AWS_UI_LABEL)Deleting VPC-link "$(AGY_VPCLINK_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-vpc-link $(__AGY_VPC_LINK_ID)

_agy_show_vpclink:: _agy_show_vpclink_description

_agy_show_vpclink_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of VPC-link "$(AGY_VPCLINK_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-vpc-link $(__AGY_VPC_LINK_ID)

_agy_update_vpclink:
	@$(INFO) '$(AWS_UI_LABEL)Updating VPC-link "$(AGY_VPCLINK_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-vpc-link $(__AGY_PATCH_OPERATIONS__VPCLINK) $(__AGY_VPC_LINK_ID)

_agy_view_vpclinks:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all VPC-links ...'; $(NORMAL)
	$(AWS) apigateway get-vpc-links # --query "items[]$(AGY_UI_VIEW_VPCLINKS_FIELDS)"

_agy_view_vpclinks_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing VPC-links-keys-set "$(AGY_VPCLINKS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'VPC-links are grouped based on the provided slice'; $(NORMAL)
	$(AWS) apigateway get-vpc-links # --query "items[$(AGY_UI_VIEW_VPCLINKS_SET_SLICE)]$(AGY_UI_VIEW_VPCLINKS_SET_FIELDS)"
