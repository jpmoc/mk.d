_AWS_IAM_USER_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_USER_ARN?= arn:aws:iam::123456789012:user/saanvi
# IAM_USER_AWSACCOUNT_ID?= 123456789012
# IAM_USER_GROUP_NAME?=
# IAM_USER_INLINEPOLICYDOCUMENT?= file://velero-policy.json
# IAM_USER_INLINEPOLICYDOCUMENT_DIRPATH?= ./in/
# IAM_USER_INLINEPOLICYDOCUMENT_FILENAME?= velero-policy.json
# IAM_USER_INLINEPOLICYDOCUMENT_FILEPATH?= ./in/velero-policy.json
# IAM_USER_INLINEPOLICY_NAME?= velero
# IAM_USER_NAME?= FirstnameLastname
# IAM_USER_PATH?= /
# IAM_USER_TAGS_KEYS?= string ...
# IAM_USER_TAGS_KEYVALUES?= Key=string,Value=string ...
# IAM_USER_USERNAME?=
# IAM_USERS_SET_NAME?= my-users-set

# Derived variables
IAM_USER_ARN?= $(if $(IAM_USER_NAME),arn:aws:iam::$(IAM_USER_AWSACCOUNT_ID):user/$(IAM_USER_NAME))
IAM_USER_AWSACCOUNT_ID?= $(IAM_AWSACCOUNT_ID)
IAM_USER_GROUP_NAME?= $(IAM_GROUP_NAME)
IAM_USER_INLINEPOLICYDOCUMENT?= $(if $(IAM_USER_INLINEPOLICYDOCUMENT_FILEPATH),file://$(IAM_USER_INLINEPOLICYDOCUMENT_FILEPATH))
IAM_USER_INLINEPOLICYDOCUMENT_DIRPATH?= $(IAM_INPUTS_DIRPATH)	
IAM_USER_INLINEPOLICYDOCUMENT_FILEPATH?= $(IAM_USER_INLINEPOLICYDOCUMENT_DIRPATH)$(IAM_USER_INLINEPOLICYDOCUMENT_FILENAME)
IAM_USERS_NAMES?= $(IAM_USER_NAME)

# Options
__IAM_GROUP_NAME__USER= $(if $(IAM_USER_GROUP_NAME),--group-name $(IAM_USER_GROUP_NAME))
__IAM_NEW_USER_NAME= $(if $(IAM_USER_USERNAME),--new-user-name $(IAM_USER_USERNAME))
__IAM_PATH_USER= $(if $(IAM_USER_PATH), --path $(IAM_USER_PATH))
__IAM_POLICY_DOCUMENT__USER= $(if $(IAM_USER_INLINEPOLICYDOCUMENT),--policy-document $(IAM_USER_INLINEPOLICYDOCUMENT))
__IAM_POLICY_SOURCE_ARN__USER= $(if $(IAM_USER_ARN),--policy-soruce-arn $(IAM_USER_ARN))
__IAM_POLICY_NAME__USER= $(if $(IAM_USER_INLINEPOLICY_NAME),--policy-name $(IAM_USER_INLINEPOLICY_NAME))
__IAM_SSH_PUBLIC_KEY_ID= $(if $(IAM_USER_SSHPUBLICKEY_ID),--ssh-public-key-id $(IAM_USER_SSHPUBLICKEY_ID))
__IAM_TAGS__USER= $(if $(IAM_USER_TAGS_KEYVALUES),--tags $(IAM_USER_TAGS_KEYVALUES))
__IAM_TAG_KEYS__USER= $(if $(IAM_USER_TAGS_KEYS),--tag-keys $(IAM_USER_TAGS_KEYS))
__IAM_USER_NAME= $(if $(IAM_USER_NAME),--user-name $(IAM_USER_NAME))

# Customizations
_IAM_LIST_USERS_FIELDS?= .{path:Path,UserId:UserId,UserName:UserName,createDate:CreateDate,passwordLastUsed:PasswordLastUsed}
_IAM_LIST_USERS_SET_FIELDS?= $(_IAM_LIST_USERS_FIELDS)
_IAM_LIST_USERS_SET_QUERYFILTER?=
_IAM_SHOW_USER_ACCESSKEYS_FIELDS?= 

# Macros
_iam_get_user_arn= $(call _iam_get_user_arn_N, $(IAM_USER_NAME))
_iam_get_user_arn_N= $(shell $(AWS) iam get-user --user-name $(1) --query "User.Arn" --output text)

_iam_get_user_name= $(shell $(AWS) iam get-user --query "User.[UserName]" --output text)

_iam_get_all_user_names= $(shell $(AWS) iam list-users --query "Users[].UserName" --output text)

#----------------------------------------------------------------------
# USAGE
#

_iam_list_macros ::
	@echo 'AWS::IAM::User ($(_AWS_IAM_USER_MK_VERSION)) macros:'
	@echo '    _iam_get_user_arn_{|N}               - Get the ARN of a user (Name)'
	@echo '    _iam_get_user_name                   - Get the current username'
	@echo '    _iam_get_all_user_names              - Get the name of all users in this AWS account'
	@echo

_iam_list_parameters ::
	@echo 'AWS::IAM::User ($(_AWS_IAM_USER_MK_VERSION)) parameters:'
	@echo '    IAM_USER_ARN=$(IAM_USER_ARN)'
	@echo '    IAM_USER_AWSACCOUNT_ID=$(IAM_USER_AWSACCOUNT_ID)'
	@echo '    IAM_USER_GROUP_NAME=$(IAM_USER_GROUP_NAME)'
	@echo '    IAM_USER_NAME=$(IAM_USER_NAME)'
	@echo '    IAM_USER_PATH=$(IAM_USER_PATH)'
	@echo '    IAM_USER_TAGS_KEYS=$(IAM_USER_TAGS_KEYS)'
	@echo '    IAM_USER_TAGS_KEYVALUES=$(IAM_USER_TAGS_KEYVALUES)'
	@echo '    IAM_USER_USERNAME=$(IAM_USER_USERNAME)'
	@echo '    IAM_USERS_NAMES=$(IAM_USERS_NAMES)'
	@echo '    IAM_USERS_SET_NAME=$(IAM_USERS_SET_NAME)'
	@echo

_iam_list_targets ::
	@echo 'AWS::IAM::User ($(_AWS_IAM_USER_MK_VERSION)) targets:'
	@echo '    _iam_create_user                     - Create a new user'
	@echo '    _iam_delete_user                     - Delete an existing user'
	@echo '    _iam_groupadd_user                   - Add a user to a group'
	@echo '    _iam_groupdel_user                   - Remove a user from a group'
	@echo '    _iam_list_users                      - List all users'
	@echo '    _iam_list_users_set                  - List a set of users'
	@echo '    _iam_show_user                       - Show everythign related to a user'
	@echo '    _iam_show_user_accesskeys            - Show access-keys of a user'
	@echo '    _iam_show_user_contextkeys           - Show context-keys for principal policy'
	@echo '    _iam_show_user_description           - Show description of a user'
	@echo '    _iam_show_user_groups                - Show groups attached to a user'
	@echo '    _iam_show_user_inlinepolicies        - Show inline-policies of a IAM user'
	@echo '    _iam_show_user_mfadevices            - Show MFA-devices attached to a user'
	@echo '    _iam_show_user_managedpolicies       - Show managed-policies attached to a user'
	@echo '    _iam_show_user_policies              - Show all policies attached to a user'
	@echo '    _iam_show_user_sshpublickey          - Show 1 SSH-public-key of a user'
	@echo '    _iam_show_user_sshpublickeys         - Show SSH-public-keys of a user'
	@echo '    _iam_tag_user                        - Tag a user'
	@echo '    _iam_untag_user                      - Remove one or more tags from a user'
	@echo '    _iam_update_user_username            - Update username of a given user'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_iam_create_user:
	@$(INFO) '$(IAM_UI_LABEL)Creating user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam create-user $(__IAM_PATH_USER) $(__IAM_USER_NAME)

_iam_delete_user:
	@$(INFO) '$(IAM_UI_LABEL)Deleting user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam delete-user $(__IAM_USER_NAME)

_iam_groupadd_user:
	@$(INFO) '$(IAM_UI_LABEL)Adding user "$(IAM_USER_NAME)" to group "$(IAM_USER_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) iam add-user-to-group $(__IAM_GROUP_NAME__USER) $(__IAM_USER_NAME)

_iam_groupdel_user:
	@$(INFO) '$(IAM_UI_LABEL)Removing user "$(IAM_USER_NAME)" from group "$(IAM_USER_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) iam remove-user-from-group $(__IAM_GROUP_NAME__USER) $(__IAM_USER_NAME)

_iam_list_users:
	@$(INFO) '$(IAM_UI_LABEL)Listing ALL IAM users ...'; $(NORMAL)
	$(AWS) iam list-users --query "Users[]$(_IAM_LIST_USERS_FIELDS)"

_iam_list_users_set:
	@$(INFO) '$(IAM_UI_LABEL)Listing IAM users-set "$(IAM_USERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Users are grouped based on provided query-filter'; $(NORMAL)
	$(AWS) iam list-users --query "Users[$(_IAM_LIST_USERS_QUERYFILTER)]$(_IAM_LIST_USERS_SET_FIELDS)"

_IAM_SHOW_USER_TARGETS?= _iam_show_user_accesskeys _iam_show_user_contextkeys _iam_show_user_groups _iam_show_user_inlinepolicies _iam_show_user_managedpolicies _iam_show_user_mfadevices  _iam_show_user_sshpublickeys _iam_show_user_description
_iam_show_user: $(_IAM_SHOW_USER_TARGETS)

_iam_show_user_accesskeys:
	@$(INFO) '$(IAM_UI_LABEL)Showing access-keys of user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam list-access-keys $(__IAM_USER_NAME) --query "AccessKeyMetadata[]$(_IAM_SHOW_USER_ACCESSKEYS_FIELDS)"

_iam_show_user_contextkeys:
	@$(INFO) '$(IAM_UI_LABEL)Showing context-key for user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-context-keys-for-principal-policy  --policy-source-arn arn:aws:iam::123456789012:user/me@domain.com --query ContextKeyNames

_iam_show_user_description:
	@$(INFO) '$(IAM_UI_LABEL)Showing description of user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-user $(__IAM_USER_NAME) --query "User"

_iam_show_user_groups:
	@$(INFO) '$(IAM_UI_LABEL)Showing groups of user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam list-groups-for-user $(__IAM_USER_NAME) --query "Groups[]"

_iam_show_user_inlinepolicies:
	@$(INFO) '$(IAM_UI_LABEL)Showing inline-policies of user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam list-user-policies $(__IAM_USER_NAME)

_iam_show_user_mfadevices:
	@$(INFO) '$(IAM_UI_LABEL)Showing MFA-devices attached to user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam list-mfa-devices $(__IAM_USER_NAME)

_iam_show_user_managedpolicies:
	@$(INFO) '$(IAM_UI_LABEL)Showing managed-policies attached to user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam list-attached-user-policies $(___IAM_PATH_PREFIX_USER) $(__IAM_USER_NAME)

_iam_show_user_policies: _iam_show_user_inlinepolicies _iam_show_user_managedpolicies

_iam_show_user_sshpublickey:
	@$(INFO) '$(IAM_UI_LABEL)Showing SSH-public-key of user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-ssh-public-key $(__IAM_SSH_PUBLIC_KEY_ID) $(__IAM_USER_NAME)

_iam_show_user_sshpublickeys:
	@$(INFO) '$(IAM_UI_LABEL)Showing SSH-public-keys of user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam list-ssh-public-keys $(__IAM_USER_NAME) --query "SSHPublicKeys[]"

_iam_tag_user:
	@$(INFO) '$(IAM_UI_LABEL)Tagging user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam tag-user $(__IAM_USER_NAME) $(__IAM_TAGS__USER)

_iam_untag_user:
	@$(INFO) '$(IAM_UI_LABEL)Untagging user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam untag-user $(__IAM_USER_NAME) $(__IAM_TAG_KEYS__USER)

_iam_update_user_username:
	@$(INFO) '$(IAM_UI_LABEL)Updating username of user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam update-user $(__IAM_NEW_USER_NAME) $(__IAM_USER_NAME)
