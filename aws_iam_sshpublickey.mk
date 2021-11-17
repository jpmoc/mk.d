_AWS_IAM_SSHPUBLICKEY_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_SSHPUBLICKEY_BODY?=
# IAM_SSHPUBLICKEY_BODY_DIRPATH?= $(HOME)/.ssh/
# IAM_SSHPUBLICKEY_BODY_FILENAME?= id_rsa.pub
# IAM_SSHPUBLICKEY_BODY_FILEPATH?= $(HOME)/.ssh/id_rsa.pub
# IAM_SSHPUBLICKEY_ID?= APKAJZB6SMMWWSENEEFQ
# IAM_SSHPUBLICKEY_USER_NAME?=
# IAM_SSHPUBLICKEYS_SET_NAME?= my-ssh-public-keys-set
# IAM_SSHPUBLICKEYS_USER_NAME?=

# Derived variables
IAM_SSHPUBLICKEY_BODY?= $(if $(IAM_USER_SSHPUBLICKEY_BODY_FILEPATH),file://$(IAM_SSHPUBLICKEY_BODY_FILEPATH))
IAM_SSHPUBLICKEY_BODY_DIRPATH?= $(IAM_INPUTS_DIRPATH)
IAM_SSHPUBLICKEY_BODY_FILEPATH?= $(IAM_SSHPUBLICKEY_BODY_DIRPATH)$(IAM_SSHPUBLICKEY_BODY_FILENAME)
IAM_SSHPUBLICKEY_USER_NAME?= $(IAM_USER_NAME)
IAM_SSHPUBLICKEYS_USER_NAME?= $(IAM_SSHPUBLICKEY_USER_NAME)

# Options
__IAM_SSH_PUBLIC_KEY_BODY= $(if $(IAM_SSHPUBLICKEY_BODY),--ssh-public-key-body $(IAM_SSHPUBLICKEY_BODY))
__IAM_SSH_PUBLIC_KEY_ID= $(if $(IAM_SSHPUBLICKEY_ID),--ssh-public-key-id $(IAM_SSHPUBLICKEY_ID))
__IAM_USER_NAME__SSHPUBLICKEY= $(if $(IAM_SSHPUBLICKEY_USER_NAME),--user-name $(IAM_SSHPUBLICKEY_USER_NAME))
__IAM_USER_NAME__SSHPUBLICKEYS= $(if $(IAM_SSHPUBLICKEYS_USER_NAME),--user-name $(IAM_SSHPUBLICKEYS_USER_NAME))

# Customizations
_IAM_LIST_SSHPUBLICKEYS_FIELDS?=
_IAM_LIST_SSHPUBLICKEYS_SET_FIELDS?= $(_IAM_LIST_SSHPUBLICKEYS_FIELDS)
_IAM_LIST_SSHPUBLICKEYS_SET_QUERYFILTER?=

# Macros
_iam_get_sshpublickey_id= $(call _iam_get_sshpublickey_id_U, $(IAM_SSHPUBLICKEY_USER_NAME))
_iam_get_sshpublickey_id_U= $(shell $(AWS) iam list-ssh-public-keys --user-name $(1) --query "SSHPublicKeys[?Status=='Active'] | [0].SSHPublicKeyId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_iam_list_macros ::
	@echo 'AWS::IAM::SshPublicKey ($(_AWS_IAM_SSHPUBLICKEY_MK_VERSION)) macros:'
	@echo '    _iam_get_sshpublickey_id_{U}               - Get an active SSH public key (Username)'
	@echo

_iam_list_parameters ::
	@echo 'AWS::IAM::SshPublicKey ($(_AWS_IAM_SSHPUBLICKEY_MK_VERSION)) parameters:'
	@echo '    IAM_SSHPUBLICKEY_BODY=$(IAM_SSHPUBLICKEY_BODY)'
	@echo '    IAM_SSHPUBLICKEY_BODY_DIRPATH=$(IAM_SSHPUBLICKEY_BODY_DIRPATH)'
	@echo '    IAM_SSHPUBLICKEY_BODY_FILENAME=$(IAM_SSHPUBLICKEY_BODY_FILENAME)'
	@echo '    IAM_SSHPUBLICKEY_BODY_FILEPATH=$(IAM_SSHPUBLICKEY_BODY_FILEPATH)'
	@echo '    IAM_SSHPUBLICKEY_ID=$(IAM_SSHPUBLICKEY_ID)'
	@echo '    IAM_SSHPUBLICKEY_USER=$(IAM_SSHPUBLICKEY_USER)'
	@echo '    IAM_SSHPUBLICKEYS_SET_NAME=$(IAM_SSHPUBLICKEYS_SET_NAME)'
	@echo '    IAM_SSHPUBLICKEYS_USER_NAME=$(IAM_SSHPUBLICKEYS_USER_NAME)'
	@echo

_iam_list_targets ::
	@echo 'AWS::IAM::SshPublicKey ($(_AWS_IAM_SSHPUBLICKEY_MK_VERSION)) targets:'
	@echo '    _iam_create_sshpublickey                   - Create a new ssh-public-key'
	@echo '    _iam_delete_sshpublickey                   - Delete an existing ssh-public-key'
	@echo '    _iam_list_sshpublickeys                    - List all ssh-public-keys'
	@echo '    _iam_list_sshpublickeys_set                - List a set of ssh-public-keys'
	@echo '    _iam_show_sshpublickeys                    - Show everything related to a ssh-public-key'
	@echo '    _iam_show_sshpublickeys_description        - Show the description of a ssh-public-key'
	@echo '    _iam_upload_sshpublickey                   - Upload a ssh-public-key to a user'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_iam_create_sshpublickey: _iam_upload_sshpublickey

_iam_delete_sshpublickey:
	@$(INFO) '$(IAM_UI_LABEL)Deleting SSH-public-key of user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam deleting-ssh-public-key $(__IAM_SSH_PUBLIC_KEY_ID) $(__IAM_USER_NAME__SSHPUBLICKEY)

_iam_list_sshpublickeys:
	@$(INFO) '$(IAM_UI_LABEL)Listing ALL SSH-public-keys of all users ...'; $(NORMAL)
	$(AWS) iam list-ssh-public-keys $(_X__IAM_USER_NAME__SSHPUBLICKEYS) --query "SSHPublicKeys[]"

_iam_list_sshpublickeys_set:
	@$(INFO) '$(IAM_UI_LABEL)Listing SSH-public-keys-set "$(IAM_SSHPUBLICKEYS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) iam list-ssh-public-keys $(__IAM_USER_NAME__SSHPUBLICKEYS) --query "SSHPublicKeys[]"

_iam_show_sshpublickey: _iam_show_sshpublickey_description

_iam_show_sshpublickey_description:
	@$(INFO) '$(IAM_UI_LABEL)Showing description of SSH-public-key of user "$(IAM_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-ssh-public-key $(__IAM_SSH_PUBLIC_KEY_ID) $(__IAM_USER_NAME__SSHPUBLICKEY)

_iam_upload_sshpublickey:
	@$(INFO) '$(IAM_UI_LABEL)Uploading SSH-public-keys of user "$(IAM_SSHPUBLICKEY_USER_NAME)" ...'; $(NORMAL)
	$(AWS) iam upload-ssh-public-key $(__IAM_SSH_PUBLIC_KEY_BODY) $(__IAM_USER_NAME__SSHPUBLICKEYS)
