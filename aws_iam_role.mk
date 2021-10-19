_AWS_IAM_ROLE_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_ROLE_ACCOUNT_ID?=
# IAM_ROLE_ARN?= arn:aws:iam::123456789012:role/xaccounts3access
IAM_ROLE_PATH?= /
# IAM_ROLE_ASSUMEPOLICYDOCUMENT?=
# IAM_ROLE_ASSUMEPOLICYDOCUMENT_DIRPATH?= ./in/
# IAM_ROLE_ASSUMEPOLICYDOCUMENT_FILENAME?= role-assume-policy-document.json
# IAM_ROLE_ASSUMEPOLICYDOCUMENT_FILEPATH?= ./in/role-assume-policy-document.json
# IAM_ROLE_INSTANCEPROFILE_NAME?=
# IAM_ROLE_NAME?= my-role
# IAM_ROLE_TAGS_KEYS?= string ...
# IAM_ROLE_TAGS_KEYVALUES?= Key=string,Value=string ...
# IAM_ROLES_PATH_PREFIX?= /my/role/path/
# IAM_ROLES_SET_NAME?= my-roles-set

# Derived parameters
IAM_ROLE_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
# IAM_ROLE_ARN?= $(if $(IAM_ROLE_NAME),arn:aws:iam::$(IAM_ROLE_ACCOUNT_ID):role/$(IAM_ROLE_NAME))
IAM_ROLE_ARN?= arn:aws:iam::$(IAM_ROLE_ACCOUNT_ID):role$(IAM_ROLE_PATH)$(IAM_ROLE_NAME)
IAM_ROLE_ASSUMEPOLICYDOCUMENT?= $(if $(IAM_ROLE_ASSUMEPOLICYDOCUMENT_FILEPATH),file://$(IAM_ROLE_ASSUMEPOLICYDOCUMENT_FILEPATH))
IAM_ROLE_ASSUMEPOLICYDOCUMENT_DIRPATH?= $(IAM_INPUTS_DIRPATH)
IAM_ROLE_ASSUMEPOLICYDOCUMENT_FILEPATH?= $(IAM_ROLE_ASSUMEPOLICYDOCUMENT_DIRPATH)$(IAM_ROLE_ASSUMEPOLICYDOCUMENT_FILENAME)
IAM_ROLE_INSTANCEPROFILE_NAME?= $(IAM_INSTANCEPROFILE_NAME)
IAM_ROLES_PATH_PREFIX?= $(IAM_ROLE_PATH)
IAM_ROLES_SET_NAME?= $(subst /,,$(IAM_ROLES_PATH_PREFIX))

# Options parameters
__IAM_ASSUME_ROLE_POLICY_DOCUMENT?= $(if $(IAM_ROLE_ASSUMEPOLICYDOCUMENT),--assume-role-policy-document $(IAM_ROLE_ASSUMEPOLICYDOCUMENT))
__IAM_DESCRIPTION__ROLE= $(if $(IAM_ROLE_DESCRIPTION),--description $(IAM_ROLE_DESCRIPTION))
__IAM_INSTANCE_PROFILE_NAME__ROLE= $(if $(IAM_ROLE_INSTANCEPROFILE_NAME),--instance-profile-name $(IAM_ROLE_INSTANCEPROFILE_NAME))
__IAM_PATH_PREFIX__ROLES= $(if $(IAM_ROLES_PATH_PREFIX),--path-prefix $(IAM_ROLES_PATH_PREFIX))
__IAM_PATH__ROLE= $(if $(IAM_ROLE_PATH),--path $(IAM_ROLE_PATH))
__IAM_ROLE_NAME?= $(if $(IAM_ROLE_NAME),--role-name $(IAM_ROLE_NAME))
__IAM_TAGS__ROLE?= $(if $(IAM_ROLE_TAGS_KEYVALUES),--tags $(IAM_ROLE_TAGS_KEYVALUES))
__IAM_TAG_KEYS__ROLE?= $(if $(IAM_ROLE_TAGS_KEYS),--tag-keys $(IAM_ROLE_TAGS_KEYS))

# UI parameters
IAM_UI_SHOW_ROLE_FIELDS?=
IAM_UI_VIEW_ROLES_FIELDS?= .{createDate:CreateDate,RoleId:RoleId,RoleName:RoleName,path:Path}
IAM_UI_VIEW_ROLES_SET_FIELDS?= $(IAM_UI_VIEW_ROLES_FIELDS)
IAM_UI_VIEW_ROLES_SET_QUERYFILTER?=

#--- MACROS
_iam_get_role_arn= $(call _iam_get_role_arn_N, $(IAM_ROLE_NAME))
_iam_get_role_arn_N= $(shell $(AWS) iam list-roles --query "Roles[?RoleName=='$(strip $(1))'].Arn" --output text)

_iam_get_role_name= $(call _iam_get_role_name_A, $(IAM_ROLE_ARN))
_iam_get_role_name_A= $(shell $(AWS) iam list-roles --query "Roles[?Arn=='$(strip $(1))'].RoleName" --output text)

#----------------------------------------------------------------------
# USAGE
#

_iam_view_framework_macros ::
	@echo 'AWS::IAM::Role ($(_AWS_IAM_ROLE_MK_VERSION)) macros:'
	@echo '    _iam_get_role_arn_{|N}                   - Get the ARN of a role (Name)'
	@echo '    _iam_get_role_name_{|A}                  - Get the name of a role (Arn)'
	@echo

_iam_view_framework_parameters ::
	@echo 'AWS::IAM::Role ($(_AWS_IAM_ROLE_MK_VERSION)) parameters:'
	@echo '    IAM_ROLE_ACCOUNT_ID=$(IAM_ROLE_ACCOUNT_ID)'
	@echo '    IAM_ROLE_ARN=$(IAM_ROLE_ARN)'
	@echo '    IAM_ROLE_ASSUMEPOLICYDOCUMENT=$(IAM_ROLE_ASSUMEPOLICYDOCUMENT)'
	@echo '    IAM_ROLE_ASSUMEPOLICYDOCUMENT_DIRPATH=$(IAM_ROLE_ASSUMEPOLICYDOCUMENT_DIRPATH)'
	@echo '    IAM_ROLE_ASSUMEPOLICYDOCUMENT_FILENAME=$(IAM_ROLE_ASSUMEPOLICYDOCUMENT_FILENAME)'
	@echo '    IAM_ROLE_ASSUMEPOLICYDOCUMENT_FILEPATH=$(IAM_ROLE_ASSUMEPOLICYDOCUMENT_FILEPATH)'
	@echo '    IAM_ROLE_INSTANCEPROFILE_NAME=$(IAM_ROLE_INSTANCEPROFILE_NAME)'
	@echo '    IAM_ROLE_PATH=$(IAM_ROLE_PATH)'
	@echo '    IAM_ROLE_NAME=$(IAM_ROLE_NAME)'
	@echo '    IAM_ROLE_TAGS_KEYS=$(IAM_ROLE_TAGS_KEYS)'
	@echo '    IAM_ROLE_TAGS_KEYVALUES=$(IAM_ROLE_TAGS_KEYVALUES)'
	@echo '    IAM_ROLES_PATH_PREFIX=$(IAM_ROLES_PATH_PREFIX)'
	@echo '    IAM_ROLES_SET_NAME=$(IAM_ROLES_SET_NAME)'
	@echo

_iam_view_framework_targets ::
	@echo 'AWS::IAM::Role ($(_AWS_IAM_ROLE_MK_VERSION)) targets:'
	@echo '    _iam_attach_role                         - Attach a role to an instance-profile'
	@echo '    _iam_create_role                         - Create a role'
	@echo '    _iam_delete_role                         - Delete an existing role'
	@echo '    _iam_detach_role                         - Detach a role from an instance-profile'
	@echo '    _iam_show_role                           - Show everything related to a role'
	@echo '    _iam_show_role_assumepolicydocument      - Show the assume-policy document of a role'
	@echo '    _iam_show_role_description               - Show description of a role'
	@echo '    _iam_show_role_managedpolicies           - Show managed-policies attached to a role'
	@echo '    _iam_show_role_inlinepolicies            - Show inline-policies in a role'
	@echo '    _iam_show_role_policies                  - Show all policies in a role'
	@echo '    _iam_view_roles                          - View all roles for this account'
	@echo '    _iam_view_roles_set                      - View a set of roles'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_iam_attach_role:
	@$(INFO) '$(IAM_UI_LABEL)Attaching/Add role "$(IAM_ROLE_NAME)" ...'; $(NORMAL)
	$(AWS) iam add-role-to-instance-profile $(__IAM_INSTANCE_PROFILE_NAME__ROLE) $(__IAM_ROLE_NAME)

_iam_create_role:
	@$(INFO) '$(IAM_UI_LABEL)Creating role "$(IAM_ROLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the provided role-name is already used (regardless of the path)'; $(NORMAL)
	$(if $(IAM_ROLE_ASSUME_POLICY_DOCUMENT_FILEPATH), cat $(IAM_ROLE_ASSUME_POLICY_DOCUMENT_FILEPATH))
	$(AWS) iam create-role $(__IAM_DESCRIPTION__ROLE) $(__IAM_PATH__ROLE) $(__IAM_ROLE_NAME) $(__IAM_ASSUME_ROLE_POLICY_DOCUMENT) --query "Role"

_iam_delete_role:
	@$(INFO) '$(IAM_UI_LABEL)Deleting role "$(IAM_ROLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'To delete a role, attached policies must first be detached'; $(NORMAL)
	-$(AWS) iam delete-role $(__IAM_ROLE_NAME)

_iam_detach_role:
	@$(INFO) '$(IAM_UI_LABEL)Detaching/Removing role "$(IAM_ROLE_NAME)" ...'; $(NORMAL)
	$(AWS) iam remove-role-from-instance-profile $(__IAM_INSTANCE_PROFILE_NAME__ROLE) $(__IAM_ROLE_NAME)

_iam_show_role:: _iam_show_role_assumepolicydocument _iam_show_role_policies _iam_show_role_description

_iam_show_role_assumepolicydocument:
	@$(INFO) '$(IAM_UI_LABEL)Showing assume-policy document for role "$(IAM_ROLE_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-role $(__IAM_ROLE_NAME) --query "Role.AssumeRolePolicyDocument" --output json

_iam_show_role_description:
	@$(INFO) '$(IAM_UI_LABEL)Showing description of role "$(IAM_ROLE_NAME)" ...'; $(NORMAL)
	$(AWS) iam list-roles --query "Roles[?RoleName=='$(IAM_ROLE_NAME)']$(IAM_UI_SHOW_ROLE_FIELDS)"

_iam_show_role_inlinepolicies:
	@$(INFO) '$(IAM_UI_LABEL)Showing inline-policies of role "$(IAM_ROLE_NAME)" ...'; $(NORMAL)
	$(AWS) iam list-role-policies $(__IAM_ROLE_NAME) --query "PolicyNames[*]"

_iam_show_role_managedpolicies:
	@$(INFO) '$(IAM_UI_LABEL)Showing managed-policies attached to role "$(IAM_ROLE_NAME)" ...'; $(NORMAL)
	$(AWS) iam list-attached-role-policies $(__IAM_ROLE_NAME) --query "AttachedPolicies[*]"

_iam_show_role_policies: _iam_show_role_inlinepolicies _iam_show_role_managedpolicies

_iam_tag_role:
	@$(INFO) '$(IAM_UI_LABEL)Tagging role "$(IAM_ROLE_NAME)" ...'; $(NORMAL)
	$(AWS) iam tag-role $(__IAM_ROLE_NAME) $(__IAM_TAGS__ROLE)

_iam_untag_role:
	@$(INFO) '$(IAM_UI_LABEL)Untagging role "$(IAM_ROLE_NAME)" ...'; $(NORMAL)
	$(AWS) iam untag-role $(__IAM_ROLE_NAME) $(__IAM_TAG_KEYS__ROLE)

_iam_view_roles:
	@$(INFO) '$(IAM_UI_LABEL)Viewing roles ...'; $(NORMAL)
	$(AWS) iam list-roles $(_X__IAM_PATH_PREFIX__ROLES) --query "Roles[]$(IAM_UI_VIEW_ROLES_FIELDS)"

_iam_view_roles_set:
	@$(INFO) '$(IAM_UI_LABEL)Showing roles-set "$(IAM_ROLES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Roles are grouped based on the proviced path-prefix and query-filter'; $(NORMAL)
	$(AWS) iam list-roles $(__IAM_PATH_PREFIX__ROLES) --query "Roles[$(IAM_UI_VIEW_ROLES_SET_QUERYFILTER)]$(IAM_UI_VIEW_ROLES_SET_FIELDS)"
