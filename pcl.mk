_PCL_MK_VERSION= 0.99.6

# PCL_AWSACCOUNT_ID?= 123456789012
PCL_AWSPROFILE_NAME?= adfs
# PCL_IAMROLE_ARN?= arn:aws:iam::123456789012:role/tfe-module-pave
# PCL_IAMROLE_NAME?= tfe-module-pave
PCL_UI_LABEL?= [pcl] #
PCL_USER_DOMAIN_NAME?= NAEAST
PCL_USER_SANDBOX_FLAG?= false
# PCL_USER_SID?= A123456

# Derived parameters
PCL_AWSACCOUNT_ID?= $(AWS_ACCOUNT_ID)
PCL_AWSPROFILE_NAME?= $(AWS_PROFILE_NAME)
PCL_IAMROLE_ARN?= $(if $(PCL_IAMROLE_NAME),arn:aws:iam::$(PCL_AWSACCOUNT_ID):role/$(PCL_IAMROLE_NAME))

# Options
__PCL_DOMAIN= $(if $(PCL_USER_DOMAIN_NAME),--domain $(PCL_USER_DOMAIN_NAME))
__PCL_PROFILE_NAME= $(if $(PCL_AWSPROFILE_NAME),--profile-name $(PCL_AWSPROFILE_NAME))
__PCL_ROLE_ARN= $(if $(PCL_IAMROLE_ARN),--role-arn $(PCL_IAMROLE_ARN))
__PCL_SANDBOX_USER= $(if $(filter true, $(PCL_USER_SANDBOX_FLAG)),--sandbox-user)
__PCL_SID= $(if $(PCL_USER_SID),--sid $(PCL_USER_SID))

# Customizations
_PCL_REFRESH_PROFILE_|?= # while true; do
|_PCL_REFRESH_PROFILE?= # ; sleep 60; done

# Macros

# Utilities
# _PCL_ENVIRONMENT+= AWS_CA_BUNDLE=''
PCL_BIN?= pcl
PCL?= $(strip $(_PCL_ENVIRONMENT) $(PCL_ENVIRONMENT) $(PCL_BIN) $(_PCL_OPTIONS) $(PCL_OPTIONS))

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _pcl_list_macros
_pcl_list_macros ::
	@echo 'PCL ($(_PCL_MK_VERSION)) macros:'
	@echo

_list_parameters :: _pcl_list_parameters
_pcl_list_parameters ::
	@echo 'PCL ($(_PCL_MK_VERSION)) parameters:'
	@echo '    PCL_AWSACCOUNT_ID=$(PCL_AWSACCOUNT_ID)'
	@echo '    PCL_AWSPROFILE_NAME=$(PCL_AWSPROFILE_NAME)'
	@echo '    PCL_IAMROLE_ARN=$(PCL_IAMROLE_ARN)'
	@echo '    PCL_IAMROLE_NAME=$(PCL_IAMROLE_NAME)'
	@echo '    PCL_USER_DOMAIN_NAME=$(PCL_USER_DOMAIN_NAME)'
	@echo '    PCL_USER_SANDBOX_FLAG=$(PCL_USER_SANDBOX_FLAG)'
	@echo '    PCL_USER_SID=$(PCL_USER_SID)'
	@echo '    PCL=$(PCL)'
	@echo

_list_targets :: _pcl_list_targets
_pcl_list_targets ::
	@echo 'PCL ($(_PCL_MK_VERSION)) targets:'
	@echo '    _pcl_refresh_awsprofile              - Refresh credentials in AWS-profile'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_pcl_refresh_awsprofile:
	@$(INFO) '$(PCL_UI_LABEL)Refreshing credentials stored in AWS-profile "$(PCL_AWSPROFILE_NAME)" ...'; $(NORMAL)
	$(_PCL_REFRESH_AWSPROFILE_|)$(PCL) aws login $(__PCL_DOMAIN) $(__PCL_PROFILE_NAME) $(__PCL_ROLE_ARN) $(__PCL_SANDBOX_USER) $(__PCL_SID) $(|_PCL_REFRESH_AWSPROFILE)
