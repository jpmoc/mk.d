_AWS_STS_MK_VERSION= 0.99.7

# STS_ASSUMECREDENTIALS_DIRPATH?= ./out/
# STS_ASSUMECREDENTIALS_FILENAME?= credentials.json
# STS_ASSUMECREDENTIALS_FILEPATH?= ./out/credentials.json
# STS_AWSPROFILE_NAME?=
# STS_CALLERIDENTITY_ACCOUNT?=
# STS_CALLERIDENTITY_USER_ARN?=
# STS_CALLERIDENTITY_USER_ID?=
# STS_FEDERATEDUSER_NAME?= EmmanuelMayssat
# STS_INPUTS_DIRPATH?= ./in/
# STS_OUTPUTS_DIRPATH?= ./out/
# STS_USER_NAME?= emayssat
# STS_PROVIDER_ID?= www.amazon.com
# STS_ROLE_ARN?=
# STS_ROLE_NAME?=
STS_ROLESESSION_DURATION_SECONDS?= 3600

# Derived parameters
STS_ASSUMECREDENTIALS_DIRPATH?= $(STS_OUTPUTS_DIRPATH)
STS_ASSUMECREDENTIALS_FILEPATH?= $(STS_ASSUMECREDENTIALS_DIRPATH)$(STS_ASSUMECREDENTIALS_FILENAME)
STS_AWSPROFILE_NAME?= $(AWS_PROFILE_NAME)
STS_IAMUSER_MFADEVICE_ARN?= $(IAM_USER_MFADEVICE_ARN)
STS_INPUTS_DIRPATH?= $(AWS_INPUTS_DIRPATH)
STS_OUTPUTS_DIRPATH?= $(AWS_OUTPUTS_DIRPATH)
STS_ROLE_ARN?= $(IAM_ROLE_ARN)
STS_ROLE_NAME?= $(IAM_ROLE_NAME)
STS_ROLESESSION_NAME?= $(STS_ROLE_NAME)-session
STS_USER_NAME?= $(IAM_USER_NAME)

# Options parameters
__STS_DURATION_SECONDS= $(if $(STS_ROLESESSION_DURATION_SECONDS),--duration-seconds $(STS_ROLESESSION_DURATION_SECONDS))
__STS_DURATION_TOKEN=
__STS_ENCODED_MESSAGE=
__STS_EXTERNAL_ID=
__STS_NAME=
__STS_POLICY=
__STS_PROVIDER_ID=
__STS_ROLE_ARN= $(if $(STS_ROLE_ARN),--role-arn $(STS_ROLE_ARN))
__STS_ROLE_SESSION_NAME= $(if $(STS_ROLESESSION_NAME),--role-session-name $(STS_ROLESESSION_NAME))
__STS_SAML_ASSERTION=
__STS_SERIAL_NUMBER= $(if $(STS_USER_MFADEVICE_ARN),--serial-number $(STS_USER_MFADEVICE_ARN))
__STS_TOKEN_CODE= $(if $(STS_USER_MFADEVICE_TOKENCODE),--token-code $(STS_USER_MFADEVICE_TOKENCODE))
__STS_WEB_IDENTITY_TOKEN=

# Pipe parameters
|_STS_ASSUME_ROLE?= $(if $(STS_ASSUMECREDENTIALS_FILEPATH),| tee $(STS_ASSUMECREDENTIALS_FILEPATH))
|_STS_ASSUME_ROLE_WITH_SAML?= $(if $(STS_ASSUMECREDENTIALS_FILEPATH),| tee $(STS_ASSUMECREDENTIALS_FILEPATH))
|_STS_ASSUME_ROLE_WITH_WEBIDENTITY?= $(if $(STS_ASSUMECREDENTIALS_FILEPATH),| tee $(STS_ASSUMECREDENTIALS_FILEPATH))

# UI parameters
STS_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- MACROS
_sts_get_calleridentity_account_id= $(shell $(AWS) sts get-caller-identity --query Account --output text)
_sts_get_calleridentity_user_arn= $(shell $(AWS) sts get-caller-identity --query Arn --output text)
_sts_get_calleridentity_user_id= $(shell $(AWS) sts get-caller-identity --query UserId --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_list_macros :: _sts_list_macros
_sts_list_macros ::
	@echo 'AWS::STS ($(_AWS_STS_MK_VERSION)) macros:'
	@echo '    _sts_get_calleridentity_account_id       - Get the account ID of the user who made the API call'
	@echo '    _sts_get_calleridentity_user_arn         - Get the ARN of the user who made this API call'
	@echo '    _sts_get_calleridentity_user_id          - Get the ID of the user who made this API call'
	@echo

_aws_list_parameters :: _sts_list_parameters
_sts_list_parameters ::
	@echo 'AWS::STS ($(_AWS_STS_MK_VERSION)) parameters:'
	@echo '    STS_ASSUMECREDENTIALS_DIRPATH=$(STS_ASSUMECREDENTIALS_DIRPATH)'
	@echo '    STS_ASSUMECREDENTIALS_FILENAME=$(STS_ASSUMECREDENTIALS_FILENAME)'
	@echo '    STS_ASSUMECREDENTIALS_FILEPATH=$(STS_ASSUMECREDENTIALS_FILEPATH)'
	@echo '    STS_AWSPROFILE_NAME=$(STS_AWSPROFILE_NAME)'
	@echo '    STS_CALLERIDENTITY_ACCOUNT_ID=$(STS_CALLERIDENTITY_ACCOUNT_ID)'
	@echo '    STS_CALLERIDENTITY_USER_ARN=$(STS_CALLERIDENTITY_USER_ARN)'
	@echo '    STS_CALLERIDENTITY_USER_ID=$(STS_CALLERIDENTITY_USER_ID)'
	@echo '    STS_DURATION_TOKEN=$(STS_DURATION_TOKEN)'
	@echo '    STS_FEDERATEDUSER_NAME=$(STS_FEDERATEDUSER_NAME)'
	@echo '    STS_INPUTS_DIRPATH=$(STS_INPUTS_DIRPATH)'
	@echo '    STS_OUTPUTS_DIRPATH=$(STS_OUTPUTS_DIRPATH)'
	@echo '    STS_USER_MFADEVICE_ARN=$(STS_USER_MFADEVICE_ARN)'
	@echo '    STS_USER_MFADEVICE_TOKENCODE=$(STS_USER_MFADEVICE_TOKENCODE)'
	@echo '    STS_USER_NAME=$(STS_USER_NAME)'
	@echo '    STS_PROVIDER_ID=$(STS_PROVIDER_ID)'
	@echo '    STS_ROLE_ARN=$(STS_ROLE_ARN)'
	@echo '    STS_ROLE_NAME=$(STS_ROLE_NAME)'
	@echo '    STS_ROLESESSION_DURATION_SECONDS=$(STS_ROLESESSION_DURATION_SECONDS)'
	@echo '    STS_ROLESESSION_NAME=$(STS_ROLESESSION_NAME)'
	@echo

_aws_list_targets :: _sts_list_targets
_sts_list_targets ::
	@echo 'AWS::STS ($(_AWS_STS_MK_VERSION)) targets:'
	@echo '    _sts_assume_role                   - Assume a role with IAM'
	@echo '    _sts_assume_role_with_iam          - Alias to above target'
	@echo '    _sts_assume_role_with_saml         - Assume a role with SAML provider'
	@echo '    _sts_assume_role_with_webidentity  - Assume a role with web-identity provider'
	@echo '    _sts_decode_authorizationmessage   - Decode the authorization message'
	@echo '    _sts_get_federationtoken           - Get a federation token'
	@echo '    _sts_get_sessiontoken              - Get a session token'
	@echo '    _sts_show_calleridentity           - Show the identity of the caller, i.e  user or ...'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sts_assume_role:
	@$(INFO) '$(STS_UI_LABEL)Get temporary credentials for users who have been authenticated by the AWS IAM service'; $(NORMAL)
	@#$(if $(STS_USER_MFADEVICE_ARN), $(WARN) 'Provided MFA device token-code is "$(STS_USER_MFADEVICE_TOKENCODE)" '; $(NORMAL))
	@#$(if $(STS_USER_MFADEVICE_TOKENCODE), $(WARN) 'The last 5 token-code are valid, but a toekn-code can only be used once!'; $(NORMAL))
	$(AWS) sts assume-role $(__STS_DURATION_SECONDS) $(__STS_EXTERNAL_ID) $(__STS_POLICY) $(__STS_ROLE_ARN) $(__STS_ROLE_SESSION_NAME) $(__STS_SERIAL_NUMBER) $(__STS_TOKEN_CODE) --output json $(|_STS_ASSUME_ROLE)
	# Command to cut and past in your terminal to assume the role
	@$(if $(STS_ASSUMECREDENTIALS_FILEPATH), \
		$(WARN) 'Cut-and-paste the command below in your terminal'; $(NORMAL); \
		export AWS_ACCESS_KEY_ID=$$(jq -r '.Credentials.AccessKeyId' $(STS_ASSUMECREDENTIALS_FILEPATH)); \
	        export AWS_SECRET_ACCESS_KEY=$$(jq -r '.Credentials.SecretAccessKey' $(STS_ASSUMECREDENTIALS_FILEPATH)); \
	        export AWS_SESSION_TOKEN=$$(jq -r '.Credentials.SessionToken' $(STS_ASSUMECREDENTIALS_FILEPATH)); \
		env | grep AWS_ | sort; \
		echo "export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN"; \
		echo "aws sts get-caller-identity"; \
		$(WARN) 'To disable the assume-role'; $(NORMAL); \
		echo "unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN"; \
		echo "aws sts get-caller-identity" \
	)	

_sts_assume_role_with_iam: _sts_assume_role

_sts_assume_role_with_saml:
	@$(INFO) '$(STS_UI_LABEL)Get temporary credentials for users who have been authenticated with a SAML provider'; $(NORMAL)
	$(AWS) assume-role-with-saml $(__STS_DURATION_SECONDS) $(__STS_POLICY) $(__STS_PRINCIPAL_ARN) $(__STS_ROLE_ARN) $(__STS_SAML_ASSERTION) $(|_STS_ASSUME_ROLE_WITH_SAML)

_sts_assume_role_with_webidentity:
	@$(INFO) '$(STS_UI_LABEL)Get temporary credentials for users who have been authenticated with a web-identity provider'; $(NORMAL)
	@$(WARN) 'Example of web-identity providers: cognito, facebook. google. or any OpenID Connect-compatible identity provider'; $(NORMAL)
	$(AWS) assume-role-with-web-identity $(__STS_DURATION_SECONDS) $(__STS_POLICY) $(__STS_PROVIDER_ID) $(__STS_ROLE_ARN) $(__STS_ROLE_SESSION_NAME) $(__STS_WEB_IDENTITY_TOKEN) $(|_STS_ASSUME_ROLE_WITH_WEBIDENTITY)

_sts_decode_autorizationmessage:
	@$(INFO) '$(STS_UI_LABEL)Decoding additional info about the authorization status'; $(NORMAL)
	$(AWS) sts decode-authorization-message $(__STS_ENCODED_MESSAGE)

_sts_get_federationtoken:
	@$(INFO) '$(STS_UI_LABEL)Fetching temporary credentials for federated-user "$(STS_FEDERATEDUSER_NAME)" ...'; $(NORMAL)
	$(AWS) sts get-federation-token $(__STS_DURATION_SECONDS) $(__STS_NAME) $(__STS_POLICY)

_sts_get_sessiontoken:
	@$(INFO) '$(STS_UI_LABEL)Fetching temporary credentials for user "$(STS_USER_NAME)" ...'; $(NORMAL)
	@#$(if $(STS_USER_MFADEVICE_ARN), $(WARN) 'Provided MFA device token-code is "$(STS_USER_MFADEVICE_TOKENCODE)" '; $(NORMAL))
	@#$(if $(STS_USER_MFADEVICE_TOKENCODE), $(WARN) 'The last 5 token-code are valid, but a token-code can only be used once!'; $(NORMAL))
	$(AWS) sts get-session-token $(__STS_DURATION_SECONDS) $(__STS_SERIAL_NUMBER) $(__STS_TOKEN_CODE)

_sts_show_calleridentity:
	@$(INFO) '$(STS_UI_LABEL)Identifying user in AWS-profile "$(STS_AWSPROFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the current -user based on used credentials'; $(NORMAL)
	$(AWS) sts get-caller-identity
