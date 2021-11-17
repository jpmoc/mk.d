_AWS_CONFIGURE_AWSPROFILE_MK_VERSION= $(_AWS_CONFIGURE_MK_VERSION)

# CFE_AWSPROFILE_COPY_NAME?= default
# CFE_AWSPROFILE_CREDENTIALS_FILEPATH?= $(HOME)/.aws/credentials
# CFE_AWSPROFILE_NAME?= default
# CFE_AWSPROFILE_PARAMETER_AWSACCESSKEYID?=
# CFE_AWSPROFILE_PARAMETER_AWSDEFAULTREGION?= us-west-2
# CFE_AWSPROFILE_PARAMETER_AWSSECRETACCESSKEY?=
# CFE_AWSPROFILE_PARAMETER_AWSSESSIONTOKEN?=
# CFE_AWSPROFILE_PARAMETER_NAME?=
# CFE_AWSPROFILE_PARAMETER_VALUE?=
# CFE_AWSPROFILES_FILEPATH?= ~/.aws/credentials
CFE_AWSPROFILES_REGEX?= '.*'
# CFE_AWSPROFILES_SET_NAME?= aws-profiles@desktop

# Derived parameters
CFE_AWSPROFILE_COPY_NAME?= $(CFE_AWSPROFILE_NAME)-copy
CFE_AWSPROFILE_CREDENTIALS_FILEPATH?= $(CFE_AWSPROFILES_CREDENTIALS_FILEPATH)
CFE_AWSPROFILE_NAME?= $(AWS_PROFILE_NAME)
CFE_AWSPROFILE_PARAMETER_AWSACCESSKEYID?= $(AWS_ACCESS_KEY_ID)
CFE_AWSPROFILE_PARAMETER_AWSDEFAULTOUTPUT?= $(AWS_OUTPUT_FORMAT)
CFE_AWSPROFILE_PARAMETER_AWSDEFAULTREGION?= $(AWS_REGION_ID)
CFE_AWSPROFILE_PARAMETER_AWSSECRETACCESSKEY?= $(AWS_SECRET_ACCESS_KEY)
CFE_AWSPROFILE_PARAMETER_AWSSESSIONTOKEN?= $(AWS_SESSION_TOKEN)
CFE_AWSPROFILES_CREDENTIALS_FILEPATH?= $(CFE_CREDENTIALS_FILEPATH)
CFE_AWSPROFILES_SET_NAME?= aws-profiles@$(CFE_AWSPROFILES_REGEX)

# Options
__CFE_PROFILE?= $(if $(CFE_AWSPROFILE_NAME),--profile $(CFE_AWSPROFILE_NAME))

# Customizations
|_CFE_LIST_AWSPROFILES_SET?= | grep $(CFE_AWSPROFILES_REGEX)
|_CFE_SHOW_AWSPROFILE_CREDENTIALS?= | head -1

# Macros
_cfe_get_awsprofile_parameter_awsaccesskeyid= $(call _cfe_get_awsprofile_parameter_awsaccesskeyid_P, $(CFE_AWSPROFILE_NAME))
_cfe_get_awsprofile_parameter_awsaccesskeyid_P= $(shell $(AWS) configure get aws_access_key_id --profile $(1) --output text)

_cfe_get_awsprofile_parameter_awssecretaccesskey= $(call _cfe_get_awsprofile_parameter_awssecretaccesskey_P, $(CFE_AWSPROFILE_NAME))
_cfe_get_awsprofile_parameter_awssecretaccesskey_P= $(shell $(AWS) configure get aws_secret_access_key --profile $(1) --output text)

_cfe_get_awsprofile_parameter_awssessiontoken= $(call _cfe_get_awsprofile_parameter_awssessiontoken_P, $(CFE_AWSPROFILE_NAME))
_cfe_get_awsprofile_parameter_awssessiontoken_P= $(shell $(AWS) configure get aws_session_token --profile $(1) --output text)

_cfe_get_awsprofile_parameter_value= $(call _cfe_get_awsprofile_parameter_value_N, $(CFE_AWSPROFILE_PARAMETER_NAME))
_cfe_get_awsprofile_parameter_value_N= $(call _cfe_get_awsprofile_parameter_value_NP, $(1), $(CFE_AWSPROFILE_NAME))
_cfe_get_awsprofile_parameter_value_NP= $(shell $(AWS) configure get $(1) --profile $(2) --output text)

#----------------------------------------------------------------------
# USAGE
#

_cfe_list_macros ::
	@echo 'AWS::ConFigurE::AwsProfile ($(_AWS_CONFIGURE_AWSPROFILE_MK_VERSION)) macros:'
	@echo '    _cfe_get_awsprofile_parameter_awsaccesskeyid_{|P}      - Get the access-key-id of an AWS-profile (Profile)'
	@echo '    _cfe_get_awsprofile_parameter_awssecretaccesskey_{|P}  - Get the secret-access-key of an AWS-profile (Profile)'
	@echo '    _cfe_get_awsprofile_parameter_awssessiontoken_{|P}     - Get the aws-session-token of an AWS-profile (Profile)'
	@echo '    _cfe_get_awsprofile_parameter_value_{|N|NP}            - Get the parameter value in an AWS-profile (Name,Profile)'
	@echo

_cfe_list_parameters ::
	@echo 'AWS::ConFigurE::AwsProfile ($(_AWS_CONFIGURE_AWSPROFILE_MK_VERSION)) parameters:'
	@echo '    CFE_AWSPROFILE_COPY_NAME=$(CFE_AWSPROFILE_COPY_NAME)'
	@echo '    CFE_AWSPROFILE_NAME=$(CFE_AWSPROFILE_NAME)'
	@echo '    CFE_AWSPROFILE_PARAMETER_AWSACCESSKEYID=$(CFE_AWSPROFILE_PARAMETER_AWSACCESSKEYID)'
	@echo '    CFE_AWSPROFILE_PARAMETER_AWSDEFAULTOUTPUT=$(CFE_AWSPROFILE_PARAMETER_AWSDEFAULTOUTPUT)'
	@echo '    CFE_AWSPROFILE_PARAMETER_AWSDEFAULTREGION=$(CFE_AWSPROFILE_PARAMETER_AWSDEFAULTREGION)'
	@echo '    CFE_AWSPROFILE_PARAMETER_AWSSECRETACCESSKEY=$(CFE_AWSPROFILE_PARAMETER_AWSSECRETACCESSKEY)'
	@echo '    CFE_AWSPROFILE_PARAMETER_AWSSESSIONTOKEN=$(CFE_AWSPROFILE_PARAMETER_AWSSESSIONTOKEN)'
	@echo '    CFE_AWSPROFILE_PARAMETER_NAME=$(CFE_AWSPROFILE_PARAMETER_NAME)'
	@echo '    CFE_AWSPROFILE_PARAMETER_NAME=$(CFE_AWSPROFILE_PARAMETER_NAME)'
	@echo '    CFE_AWSPROFILE_PARAMETER_VALUE=$(CFE_AWSPROFILE_PARAMETER_VALUE)'
	@echo '    CFE_AWSPROFILES_CREDENTIALS_FILEPATH=$(CFE_AWSPROFILES_CREDENTIALS_FILEPATH)'
	@echo '    CFE_AWSPROFILES_REGEX=$(CFE_AWSPROFILES_REGEX)'
	@echo '    CFE_AWSPROFILES_SET_NAME=$(CFE_AWSPROFILES_SET_NAME)'
	@echo

_cfe_list_targets ::
	@echo 'AWS::ConFigurE::AwsProfile ($(_AWS_CONFIGURE_AWSPROFILE_MK_VERSION)) targets:'
	@echo '    _cfe_copy_awsprofile                      - Copy an AWS-profile'
	@echo '    _cfe_create_awsprofile                    - Create an AWS-profile'
	@echo '    _cfe_delete_awsprofile                    - Delete an AWS-profile'
	@echo '    _cfe_list_awsprofiles                     - List all AWS-profiles'
	@echo '    _cfe_list_awsprofiles_set                 - List a set of AWS-profiles'
	@echo '    _cfe_get_awsprofile_parametervalue        - Get the value of a parameter in an AWS-profile'
	@echo '    _cfe_set_awsprofile_parametervalue        - Set the value of a parameter in an AWS-profile'
	@echo '    _cfe_show_awsprofile                      - Show everything related to an AWS-profile'
	@echo '    _cfe_show_awsprofile_configuration        - Show configuration of an AWS-profile'
	@echo '    _cfe_show_awsprofile_environment          - Show environment of an AWS-profile'
	@echo '    _cfe_show_awsprofile_shellexports         - Show shell-exports for an AWS-profile'
	@echo '    _cfe_update_awsprofile                    - Update the content of an AWS-profile'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cfe_copy_awsprofile:
	@$(INFO) '$(CFE_UI_LABEL)Copying AWS-profile "$(CFE_AWSPROFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates the copy-profile "$(CFE_AWSPROFILE_COPY_NAME)"'; $(NORMAL)
	$(foreach K, aws_access_key_id aws_secret_access_key aws_session_token output region, \
		V=`$(AWS) configure get $(__CFE_PROFILE) $(K)`; \
		[ -z "$${V}" ] || $(AWS) configure --profile $(CFE_AWSPROFILE_COPY_NAME) set $(K) $${V}; \
	)

_cfe_create_awsprofile:
	@$(INFO) '$(CFE_UI_LABEL)Creating AWS-profile "$(CFE_AWSPROFILE_NAME)" ...'; $(NORMAL)
	$(AWS) configure $(__CFE_PROFILE)

_cfe_delete_awsprofile:
	@$(INFO) '$(CFE_UI_LABEL)Deleting AWS-profile "$(CFE_AWSPROFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is dangerous and can only be executed mannually'; $(NORMAL)
	# crudini --del $(CFE_AWSPROFILE_CREDENTIALS_FILEPATH) $(CFE_AWSPROFILE_NAME)

_cfe_get_awsprofile_parametervalue:
	@$(INFO) '$(CFE_UI_LABEL)Fetching value of parameter "$(CFE_AWSPROFILE_PARAMETER_NAME)" in AWS-profile "$(CFE_AWSPROFILE_NAME)" ...'; $(NORMAL)
	$(AWS) configure get $(CFE_AWSPROFILE_PARAMETER_NAME) $(__CFE_PROFILE)

_cfe_set_awsprofile_parametervalue:
	@$(INFO) '$(CFE_UI_LABEL)Setting value of parameter "$(CFE_AWSPROFILE_PARAMETER_NAME)" in AWS-profile "$(CFE_AWSPROFILE_NAME)" ...'; $(NORMAL)
	$(AWS) configure set $(CFE_AWSPROFILE_PARAMETER_NAME) $(CFE_AWSPROFILE_PARAMETER_VALUE) $(__CFE_PROFILE)

_cfe_show_awsprofile :: _cfe_show_awsprofile_credentials _cfe_show_awsprofile_environment _cfe_show_awsprofile_shellexports _cfe_show_awsprofile_description

_cfe_show_awsprofile_credentials:
	@$(INFO) '$(CFE_UI_LABEL)Showing credentails for AWS-profile "$(CFE_AWSPROFILE_NAME)" ...'; $(NORMAL)
	crudini --get --format=sh $(CFE_AWSPROFILE_CREDENTIALS_FILEPATH) $(CFE_AWSPROFILE_NAME) $(|_CFE_SHOW_AWSPROFILE_CREDENTIALS)

_cfe_show_awsprofile_description:
	@$(INFO) '$(CFE_UI_LABEL)Showing configuration for AWS-profile "$(CFE_AWSPROFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operaton fails if the profile includes only partial credentials'; $(NORMAL)
	@$(WARN) 'This operation only displays for the selected profile, the corrseponding credentials and default region!'; $(NORMAL)
	$(AWS) configure list $(__CFE_PROFILE)

_cfe_show_awsprofile_environment:
	@$(INFO) '$(CFE_UI_LABEL)Showing environment for AWS-profile "$(CFE_AWSPROFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns key environment variables, which may or may not be initialized'; $(NORMAL)
	@echo 'AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID)'
	@echo 'AWS_DEFAULT_OUTPUT=$(AWS_DEFAULT_OUTPUT)'
	@echo 'AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION)'
	@echo 'AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY)'
	@echo 'AWS_SESSION_TOKEN=$(AWS_SESSION_TOKEN)'

_cfe_show_awsprofile_shellexports:
	@$(INFO) '$(CFE_UI_LABEL)Showing the shell-exports for AWS-profile "$(CFE_AWSPROFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the shell-exports to override the default AWS-profile'; $(NORMAL)
	@echo 'unset AWS_ACCESS_KEY_ID AWS_DEFAULT_OUTPUT AWS_DEFAULT_REGION AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN'
	@echo $(if $(CFE_AWSPROFILE_PARAMETER_AWSACCESSKEYID), 'export AWS_ACCESS_KEY_ID=$(CFE_AWSPROFILE_PARAMETER_AWSACCESSKEYID)','CFE_AWSPROFILE_PARAMETER_AWSACCESSKEYID not set')
	@echo $(if $(CFE_AWSPROFILE_PARAMETER_AWSDEFAULTOUTPUT), 'export AWS_DEFAULT_OUTPUT=$(CFE_AWSPROFILE_PARAMETER_AWSDEFAULTOUTPUT)','CFE_AWSPROFILE_PARAMETER_AWSDEFAULTOUTPUT not set')
	@echo $(if $(CFE_AWSPROFILE_PARAMETER_AWSDEFAULTREGION), 'export AWS_DEFAULT_REGION=$(CFE_AWSPROFILE_PARAMETER_AWSDEFAULTREGION)','CFE_AWSPROFILE_PARAMETER_AWSDEFAULTREGION not set')
	@echo $(if $(CFE_AWSPROFILE_PARAMETER_AWSSECRETACCESSKEY), 'export AWS_SECRET_ACCESS_KEY=$(CFE_AWSPROFILE_PARAMETER_AWSSECRETACCESSKEY)', 'CFE_AWSPROFILE_PARAMETER_AWSSECRETACCESSKEY not set')
	@echo $(if $(CFE_AWSPROFILE_PARAMETER_AWSSESSIONTOKEN), 'export AWS_SESSION_TOKEN=$(CFE_AWSPROFILE_PARAMETER_AWSSESSIONTOKEN)', 'CFE_AWSPROFILE_PARAMETER_AWSSESSIONTOKEN not set')

_cfe_update_awsprofile:
	@$(INFO) '$(CFE_UI_LABEL)Resetting AWS-profile "$(CFE_AWSPROFILE_NAME)" ...'; $(NORMAL)
	@read -p 'You are about to reset the AWS-profile "$(CFE_AWSPROFILE_NAME)". Are you sure? [Ctrl-C to break]' yesNo
	$(AWS) configure set aws_access_key_id $(CFE_AWSPROFILE_PARAMETER_AWSACCESSKEYID) $(__CFE_PROFILE)
	$(if $(CFE_AWSPROFILE_PARAMETER_AWSDEFAULTOUTPUT), \
		$(AWS) configure set output $(CFE_AWSPROFILE_PARAMETER_AWSDEFAULTOUTPUT) $(__CFE_PROFILE) \
	, @echo 'CFE_AWSPROFILE_PARAMETER_AWSDEFAULTOUTPUT not set'; \
	)
	$(if $(CFE_AWSPROFILE_PARAMETER_AWSDEFAULTREGION), \
		$(AWS) configure set region $(CFE_AWSPROFILE_PARAMETER_AWSDEFAULTREGION) $(__CFE_PROFILE) \
	, @echo 'CFE_AWSPROFILE_PARAMETER_AWSDEFAULTREGION not set'; \
	)
	$(AWS) configure set aws_secret_access_key $(CFE_AWSPROFILE_PARAMETER_AWSSECRETACCESSKEY) $(__CFE_PROFILE)
	$(AWS) configure set aws_session_token $(CFE_AWSPROFILE_PARAMETER_AWSSESSIONTOKEN) $(__CFE_PROFILE)

_cfe_list_awsprofiles:
	@$(INFO) '$(CFE_UI_LABEL)Listing ALL AWS-profiles ...'; $(NORMAL)
	crudini --get $(CFE_AWSPROFILES_CREDENTIALS_FILEPATH)

_cfe_list_awsprofiles_set:
	@$(INFO) '$(CFE_UI_LABEL)Listing AWS-profiles-set "$(CFE_AWSPROFILES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'AWS_profiles are grouped basd on the regex'; $(NORMAL)
	crudini --get $(CFE_AWSPROFILES_CREDENTIALS_FILEPATH) $(|_CFE_LIST_AWSPROFILES_SET)
