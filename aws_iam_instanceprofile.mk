_AWS_IAM_INSTANCEPROFILE_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_INSTANCEPROFILE_ARN?= arn:aws:iam::123456789012:instance-profile/S3AccessInstanceProfile
# IAM_INSTANCEPROFILE_NAME?= my-instance-profile
IAM_INSTANCEPROFILE_PATH?= /
# IAM_INSTANCEPROFILE_ROLE_NAME?= /my/path/my-instance-profile-role
# IAM_INSTANCEPROFILES_PATHPREFIX?= /
# IAM_INSTANCEPROFILES_SET_NAME?= my-instance-profiles-set

# Derived parameters
IAM_INSTANCEPROFILE_ARN?= arn:aws:iam::$(AWS_ACCOUNT_ID):instance-profile/$(IAM_INSTANCEPROFILE_NAME)
IAM_INSTANCEPROFILE_ROLE_NAME?= $(IAM_ROLE_NAME)
IAM_INSTANCEPROFILES_SET_PATHPREFIX?= $(IAM_INSTANCEPATH_PATH)
IAM_INSTANCEPROFILES_SET_NAME?= $(IAM_INSTANCEPROFILES_SET_PATHPREFIX)

# Options parameters
__IAM_INSTANCE_PROFILE_NAME?= $(if $(IAM_INSTANCEPROFILE_NAME), --instance-profile-name $(IAM_INSTANCEPROFILE_NAME))
__IAM_PATH__INSTANCEPROFILE?= $(if $(IAM_INSTANCEPROFILES_PATH), --path $(IAM_INSTANCEPROFILES_PATH))
__IAM_PATH_PREFIX__INSTANCEPROFILE?= $(if $(IAM_INSTANCEPROFILES_SET_PATHPREFIX), --path-prefix $(IAM_INSTANCEPROFILES_SET_PATHPREFIX))

# UI parameters
IAM_UI_SHOW_INSTANCEPROFILE_DESCRIPTION_FIELDS?=
IAM_UI_SHOW_INSTANCEPROFILE_ROLES_FIELDS?= .{RoleId:RoleId,RoleName:RoleName,createDate:CreateDate,path:Path}
IAM_UI_VIEW_INSTANCEPROFILES_FIELDS?= .{InstanceProfileId:InstanceProfileId,InstanceProfileName:InstanceProfileName,path:Path,roleCount:length(Roles)}
IAM_UI_VIEW_INSTANCEPROFILES_SET_FIELDS?= $(IAM_UI_VIEW_INSTANCEPROFILES_FIELDS)

#--- MACROS
_iam_get_instanceprofile_arn= $(call _iam_get_instanceprofile_arn_N, $(IAM_INSTANCEPROFILE_NAME))
_iam_get_instanceprofile_arn_N= $(call _iam_get_instanceprofile_arn_NP, $(1), $(IAM_INSTANCEPROFILE_PATH))
_iam_get_instanceprofile_arn_NP= $(shell echo arn:aws:iam::$(AWS_ACCOUNT_ID):instance-profile$(strip $(2))$(strip $(1)))

_iam_get_instanceprofile_name= $(call _iam_get_instanceprofile_name_A, $(IAM_INSTANCEPROFILE_ARN))
_iam_get_instanceprofile_name_A= $(lastword $(subst /,$(SPACE),$(1)))

_iam_get_instanceprofile_role_name= $(call _iam_get_instanceprofile_role_name_N, $(IAM_INSTANCEPROFILE_NAME))
_iam_get_instanceprofile_role_name_N= $(shell $(AWS) iam get-instance-profile --instance-profile-name $(1) --query "InstanceProfile.Roles[].RoleName" --output text)

#----------------------------------------------------------------------
# USAGE
#

_iam_view_framework_macros ::
	@echo 'AWS::IAM::InstanceProfile ($(_AWS_IAM_INSTANCEPROFILE_MK_VERSION)) macros:'
	@echo '    _iam_get_instanceprofile_arn_{|N|NP}            - Get the ARN of an instance-profile (Name,Path)'
	@echo '    _iam_get_instanceprofile_name_{|A}              - Get the name of an instance-profile (Arn)'
	@echo '    _iam_get_instanceprofile_role_name_{|N}         - Get the name of the role of an instance-profile (Name)'
	@echo

_iam_view_framework_parameters ::
	@echo 'AWS::IAM::InstanceProfile ($(_AWS_IAM_INSTANCEPROFILE_MK_VERSION)) parameters:'
	@echo '    IAM_INSTANCEPROFILE_ARN=$(IAM_INSTANCEPROFILE_ARN)'
	@echo '    IAM_INSTANCEPROFILE_NAME=$(IAM_INSTANCEPROFILE_NAME)'
	@echo '    IAM_INSTANCEPROFILE_PATH=$(IAM_INSTANCEPROFILE_PATH)'
	@echo '    IAM_INSTANCEPROFILE_ROLE_NAME=$(IAM_INSTANCEPROFILE_ROLE_NAME)'
	@echo '    IAM_INSTANCEPROFILES_SET_NAME=$(IAM_INSTANCEPROFILES_SET_NAME)'
	@echo '    IAM_INSTANCEPROFILES_SET_PATHPREFIX=$(IAM_INSTANCEPROFILES_SET_PATHPREFIX)'
	@echo

_iam_view_framework_targets ::
	@echo 'AWS::IAM::InstanceProfile ($(_AWS_IAM_INSTANCEPROFILE_MK_VERSION)) targets:'
	@echo '    _iam_create_instanceprofile                    - Create an instance-profile'
	@echo '    _iam_delete_instanceprofile                    - Delete an instance-profile'
	@echo '    _iam_show_instanceprofile                      - Show everything related to an instance-profile'
	@echo '    _iam_show_instanceprofile_description          - Show everything related to an instance-profile'
	@echo '    _iam_view_instanceprofiles                     - View existing instance-profiles'
	@echo '    _iam_view_instanceprofiles_set                 - View a set of instance-profiles'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_iam_create_instanceprofile:
	@$(INFO) '$(IAM_UI_LABEL)Creating instance-profile "$(IAM_INSTANCEPROFILE_NAME)" ...'; $(NORMAL)
	$(AWS) iam create-instance-profile $(__IAM_INSTANCE_PROFILE_NAME) $(__IAM_PATH__INSTANCEPROFILE)

_iam_delete_instanceprofile:
	@$(INFO) '$(IAM_UI_LABEL)Deleting instance-profile "$(IAM_INSTANCEPROFILE_NAME)" ...'; $(NORMAL)
	$(AWS) iam delete-instance-profile $(__IAM_INSTANCE_PROFILE_NAME)

_iam_show_instanceprofile: _iam_show_instanceprofile_roles _iam_show_instanceprofile_description

_iam_show_instanceprofile_description:
	@$(INFO) '$(IAM_UI_LABEL)Showing description of instance-profile "$(IAM_INSTANCEPROFILE_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-instance-profile $(__IAM_INSTANCE_PROFILE_NAME) --query "InstanceProfile$(IAM_UI_SHOW_INSTANCEPROFILE_DESCRIPTION_FIELDS)"

_iam_show_instanceprofile_roles:
	@$(INFO) '$(IAM_UI_LABEL)Showing roles of instance-profile "$(IAM_INSTANCEPROFILE_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-instance-profile  $(__IAM_INSTANCE_PROFILE_NAME) --query "InstanceProfile.Roles[]$(IAM_UI_SHOW_INSTANCEPROFILE_ROLES_FIELDS)"

_iam_view_instanceprofiles:
	@$(INFO) '$(IAM_UI_LABEL)Viewing instance-profiles ...'; $(NORMAL)
	$(AWS) iam list-instance-profiles $(_X__IAM_PATH_PREFIX__INSTANCEPROFILE) --query "InstanceProfiles[]$(IAM_UI_VIEW_INSTANCEPROFILES_FIELDS)"

_iam_view_instanceprofiles_set:
	@$(INFO) '$(IAM_UI_LABEL)Viewing instance-profiles-set "$(IAM_INSTANCEPROFILES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Instance-profiles are grouped based on their paths'; $(NORMAL)
	$(AWS) iam list-instance-profiles $(__IAM_PATH_PREFIX__INSTANCEPROFILE) --query "InstanceProfiles[]$(IAM_UI_VIEW_INSTANCEPROFILES_SET_FIELDS)"
