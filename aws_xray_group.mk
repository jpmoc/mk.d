_AWS_XRAY_GROUP_MK_VERSION= $(_AWS_XRAY_MK_VERSION)

# XRY_GROUP_ARN?=
# XRY_GROUP_FILTER_EXPRESSION?=
# XRY_GROUP_NAME?= Default

# Derived parameters

# Option parameters
__XRY_GROUP_ARN= $(if $(XRY_GROUP_ARN),--group-arn $(XRY_GROUP_ARN))
__XRY_GROUP_NAME= $(if $(XRY_GROUP_NAME),--group-name $(XRY_GROUP_NAME))
__XRY_FILTER_EXPRESSION= $(if $(XRY_GROUP_FILTER_EXPRESSION),--filter-expression $(XRY_GROUP_FILTER_EXPRESSION))

# UI parameters
XRY_UI_VIEW_GROUPS_FIELDS?=
XRY_UI_VIEW_GROUPS_SET_FIELDS?= $(XRY_UI_VIEW_GROUPS_FIELDS)
XRY_UI_VIEW_GROUPS_SET_SLICE?=

#--- Utilities

#--- MACROS

_xry_get_group_arn= $(call _xry_get_group_arn_N, $(XRY_GROUP_NAME))
_xry_get_group_arn_N= $(shell echo "arn:aws:xray:$(AWS_REGION):$(AWS_ACCOUND_IF):group/$(strip $(1))")

#----------------------------------------------------------------------
# USAGE
#

_xry_view_framework_macros ::
	@echo 'AWS::XRaY::Group ($(_AWS_XRAY_GROUP_MK_VERSION)) macros:'
	@echo '    _xry_get_group_arn_{|N}                      - Get the ARN of the group (Name)'
	@echo

_xry_view_framework_parameters ::
	@echo 'AWS::XRaY::Group ($(_AWS_XRAY_GROUP_MK_VERSION)) parameters:'
	@echo '    XRY_GROUP_ARN=$(XRY_GROUP_ARN)'
	@echo '    XRY_GROUP_FILTER_EXPRESSION=$(XRY_GROUP_FILTER_EXPRESSION)'
	@echo '    XRY_GROUP_NAME=$(XRY_GROUP_NAME)'
	@echo

_xry_view_framework_targets ::
	@echo 'AWS::XRaY::Group ($(_AWS_XRAY_GROUP_MK_VERSION)) targets:'A
	@echo '    _xry_create_group                           - Create a new trace'
	@echo '    _xry_delete_group                           - Delete an existing trace'
	@echo '    _xry_show_group                             - Show everything related to a group'
	@echo '    _xry_show_group_description                 - Show description of a group'
	@echo '    _xry_update_group                           - Update group'
	@echo '    _xry_view_groups                            - View groups'
	@echo '    _xry_view_groups_set                        - View a set of groups'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_xry_create_group:
	@$(INFO) '$(AWS_UI_LABEL)Creating group "$(XRY_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) xray create-group $(__XRY_FILTER_EXPRESSION) $(__XRY_GROUP_NAME)

_xry_delete_group:
	@$(INFO) '$(AWS_UI_LABEL)Deleting group "$(XRY_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) xray delete-group $(__XRY_GROUP_ARN) $(__XRY_GROUP_NAME)

_xry_show_group:: _xry_show_group_description

_xry_show_group_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of group "$(XRY_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) xray get-group $(__XRY_GROUP_ARN) $(__XRY_GROUP_NAME) --query "Group"

_xry_update_group:
	@$(INFO) '$(AWS_UI_LABEL)Updating group "$(XRY_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) xray update-group $(__XRY_FILTER_EXPRESSION) $(__XRY_GROUP_ARN) $(__XRY_GROUP_NAME)

_xry_view_groups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing groups ...'; $(NORMAL)
	$(AWS) xray get-groups --query "Groups[]$(XRY_UI_VIEW_GROUPS_FIELDS)"

_xry_view_groups_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing groups-set "$(XRY_GROUPS_SET_NAME)" ...'; $(NORMAL)
