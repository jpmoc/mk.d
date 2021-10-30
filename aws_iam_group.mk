_AWS_IAM_GROUP_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_GROUP_ARN?= arn:aws:iam::123456789012:group/AdministratorGroup
# IAM_GROUP_AWSACCOUNT_ID?= 123456789012
# IAM_GROUP_NAME?= my-group
IAM_GROUP_PATH?= /
# IAM_GROUPS_PATH_PREFIX?= /
# IAM_GROUPS_SET_NAME?= my-groups-set

# Derived parameters 
IAM_GROUP_ARN?= $(if $(IAM_GROUP_NAME),arn:aws:iam::$(IAM_GROUP_ACCOUNT_ID):group$(IAM_GROUP_PATH)$(IAM_GROUP_NAME))
IAM_GROUP_AWSACCOUNT_ID?= $(IAM_AWSACCOUNT_ID)

# Option parameters
__IAM_GROUP_NAME= $(if $(IAM_GROUP_NAME),--group-name $(IAM_GROUP_NAME))
__IAM_PATH__GROUPS= $(if $(IAM_GROUP_PATH),--path $(IAM_GROUP_PATH))
__IAM_PATH_PREFIX__GROUPS= $(if $(IAM_GROUPS_PATH_PREFIX),--path-prefix $(IAM_GROUPS_PATH_PREFIX))

# UI parameters 
IAM_UI_SHOW_GROUP_USERS_FIELDS?= .{UserId:UserId,UserName:UserName,arn:Arn,createDate:CreateDate,path:Path}
IAM_UI_LIST_GROUPS_FIELDS?= .{GroupId:GroupId,GroupName:GroupName,path:Path,createDate:CreateDate}
IAM_UI_LIST_GROUPS_SET_FIELDS?= $(IAM_UI_LIST_GROUPS_FIELDS)
IAM_UI_LIST_GROUPS_SET_QUERYFILTER?=

#--- MACROS
_iam_get_group_arn= $(call _iam_get_group_arn_N, $(IAM_GROUP_NAME))
_iam_get_group_arn_N= $(shell $(AWS) iam get-group --group-name $(1) --query "Group.Arn" --output text)

#----------------------------------------------------------------------
# USAGE
#

_iam_list_macros ::
	@echo 'AWS::IAM::Group ($(_AWS_IAM_GROUP_MK_VERSION)) macros:'
	@echo '    _iam_get_group_arn_{|N}                     - Get a group ARN'
	@echo

_iam_list_parameters ::
	@echo 'AWS::IAM::Group ($(_AWS_IAM_GROUP_MK_VERSION)) parameters:'
	@echo '    IAM_GROUP_AWSACCOUNT_ID=$(IAM_GROUP_AWSACCOUNT_ID)'
	@echo '    IAM_GROUP_ARN=$(IAM_GROUP_ARN)'
	@echo '    IAM_GROUP_NAME=$(IAM_GROUP_NAME)'
	@echo '    IAM_GROUP_PATH=$(IAM_GROUP_PATH)'
	@echo '    IAM_GROUPS_PATH_PREFIX=$(IAM_GROUPS_PATH_PREFIX)'
	@echo '    IAM_GROUPS_SET_NAME=$(IAM_GROUPS_SET_NAME)'
	@echo

_iam_list_targets ::
	@echo 'AWS::IAM::Group ($(_AWS_IAM_GROUP_MK_VERSION)) targets:'
	@echo '    _iam_create_group                          - Create a new group'
	@echo '    _iam_delete_group                          - Delete an existing group'
	@echo '    _iam_show_group                            - Show everything related to a group'
	@echo '    _iam_show_group_inlinepolicies             - Show the inline-policies of a group'
	@echo '    _iam_show_group_managedpolicies            - Show the managed-policies attached to a group'
	@echo '    _iam_show_group_policies                   - Show the policies of a group'
	@echo '    _iam_show_group_users                      - Show users in a group'
	@echo '    _iam_list_groups                           - List all groups'
	@echo '    _iam_list_groups_set                       - List a set of groups'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_iam_create_group:
	@$(INFO) '$(IAM_UI_LABEL)Creating group "$(IAM_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) iam create-group $(__IAM_GROUP_NAME) $(__IAM_PATH__GROUP) --query "Group"

_iam_delete_group:
	@$(INFO) '$(IAM_UI_LABEL)Deleting group "$(IAM_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) iam delete-group $(__IAM_GROUP_NAME)

_iam_list_groups:
	@$(INFO) '$(IAM_UI_LABEL)Listing ALL groups ...'; $(NORMAL)
	$(AWS) iam list-groups $(_X__IAM_PATH_PREFIX__GROUPS) --query "Groups[]$(IAM_UI_LIST_GROUPS_FIELDS)"

_iam_list_groups_set:
	@$(INFO) '$(IAM_UI_LABEL)Listing groups-set "$(IAM_GROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Groups are grouped based on the provided path-prefix, query-filter'; $(NORMAL)
	$(AWS) iam list-groups $(__IAM_PATH_PREFIX__GROUPS) --query "Groups[$(IAM_UI_LIST_GROUPS_SET_QUERYFILTER)]$(IAM_UI_LIST_GROUPS_SET_FIELDS)"

_IAM_SHOW_GROUP_TARGETS?= _iam_show_group_policies _iam_show_group_users _iam_show_group_description
_iam_show_group: $(_IAM_SHOW_GROUP_TARGETS)

_iam_show_group_description:
	@$(INFO) '$(IAM_UI_LABEL)Showing group "$(IAM_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-group $(__IAM_GROUP_NAME) --query "Group"

_iam_show_group_inlinepolicies:
	@$(INFO) '$(IAM_UI_LABEL)Showing inline-policies of group "$(IAM_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) iam list-group-policies $(__IAM_GROUP_NAME) --query 'PolicyNames[]'

_iam_show_group_managedpolicies:
	@$(INFO) '$(IAM_UI_LABEL)Showing managed-policies attached to group "$(IAM_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) iam list-attached-group-policies $(__IAM_GROUP_NAME) --query 'AttachedPolicies[]'

_iam_show_group_policies: _iam_show_group_inlinepolicies _iam_show_group_managedpolicies

_iam_show_group_users:
	@$(INFO) '$(IAM_UI_LABEL)Showing users in group "$(IAM_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-group $(__IAM_GROUP_NAME) --query "Users[]$(IAM_UI_SHOW_GROUP_USERS_FIELDS)"
