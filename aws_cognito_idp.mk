_AWS_COGNITO_IDP_MK_VERSION=0.99.0

IDP_MAX_RESULTS?=10
# IDP_POOL_ID?= 
# IDP_POOL_NAME?= MyUserPoolA
# IDP_POOL_CLIENT_ID?= 3urcblgf2nokfvhsukdcfoht5t
# IDP_POOL_CLIENT_NAME?= WildRydesWeb
# IDP_TEMPORARY_PASSWORD?= 12345678
# IDP_USER_ATTRIBUTES?= Name=nickname,Value=Toto
# IDP_USER_NAME?= MyUsername

# DErived varaibles

# Options
__IDP_ATTRIBUTE_TO_GET?=
__IDP_CLIENT_ID?= $(if $(IDP_POOL_CLIENT_ID), --client-id $(IDP_POOL_CLIENT_ID))
__IDP_DESIRED_DELIVERY_MEDIUMS?=
__IDP_FORCE_ALIAS_CREATION?=
__IDP_MAX_RESULTS?= $(if $(IDP_MAX_RESULTS), --max-results $(IDP_MAX_RESULTS))
__IDP_MESSAGE_ACTION?=
__IDP_POOL_NAME?= $(if $(IDP_POOL_NAME), --pool-name $(IDP_POOL_NAME))
__IDP_TEMPORARY_PASSWORD?= $(if $(IDP_TEMPORARY_PASSWORD), --temporary-password $(IDP_TEMPORARY_PASSWORD))
__IDP_USER_ATTRIBUTES?= $(if $(IDP_USER_ATTRIBUTES), --user-attributes $(IDP_USER_ATTRIBUTES))
__IDP_USER_POOL_ID?= $(if $(IDP_POOL_ID), --user-pool-id $(IDP_POOL_ID))
__IDP_USERNAME= $(if $(IDP_USER_NAME), --username $(IDP_USER_NAME))
__IDP_VALIDATION_DATA=

# Display
IDP_SHOW_USER_SCHEMA_FIELDS?=.{Name:Name,_Mutable:Mutable,_Required:Required,_DeveloperOnlyAttribute:DeveloperOnlyAttribute,_AttributeDataType:AttributeDataType}
IDP_VIEW_USERS_FIELDS?=.{Username:Username,_Enabled:Enabled,_UserStatus:UserStatus,_LastModified:UserLastModifiedDate,_UserCreatedDate:UserCreateDate}

#--- MACROS
_idp_get_pool_id=$(call _idp_get_pool_id_N, $(IDP_POOL_NAME))
_idp_get_pool_id_N=$(call _idp_get_pool_id_NI, $(1), 0)
_idp_get_pool_id_NI=$(shell $(AWS) cognito-idp list-user-pools --max-results 10 --query "UserPools[?Name=='$(strip $(1))']|[$(2)].Id" --output text)

_idp_get_pool_client_id=$(call _idp_get_pool_client_id_N, $(IDP_POOL_CLIENT_NAME))
_idp_get_pool_client_id_N=$(call _idp_get_pool_client_id_IN, $(IDP_POOL_ID), $(1))
_idp_get_pool_client_id_IN=$(shell $(AWS) cognito-idp list-user-pool-clients  --user-pool-id $(1) --max-results 10 --query "UserPoolClients[?ClientName=='$(2)'].ClientId" --output text

#----------------------------------------------------------------------
# USAGE
#
_cto_view_makefile_macros :: _idp_user_view_makefile_macros
_idp_user_view_makefile_macros ::
	@echo "AWS::Cognito::Idp ($(_AWS_COGNITO_IDP_MK_VERSION)) targets:"
	@echo "    _idp_get_pool_id_{|N|NI}             - Get the pool ID given a Name and Index"
	@echo

_cto_view_makefile_targets :: _idp_user_view_makefile_targets
_idp_user_view_makefile_targets ::
	@echo "AWS::Cognito::Idp ($(_AWS_COGNITO_IDP_MK_VERSION)) targets:"
	@echo "    _idp_create_user                    - Create a new user"
	@echo "    _idp_create_pool                    - Create a new user pool"
	@echo "    _idp_delete_user                    - Delete an existing user"
	@echo "    _idp_delete_pool                    - Delete an existing user pool"
	@echo "    _idp_disable_user                   - Disable an existing user in a pool"
	@echo "    _idp_enable_user                    - Enable a n existing user in a pool"
	@echo "    _idp_show_pool                      - Show an existing user pool"
	@echo "    _idp_show_user                      - Show ithe profile of a givne user"
	@echo "    _idp_show_user_profile_schema       - Show user profile schema"
	@echo "    _idp_view_groups                    - View groups in the curent user pool"
	@echo "    _idp_view_identity_providrs         - View identity providers for the curent user pool"
	@echo "    _idp_view_resource_servers          - View resource servers in the curent user pool"
	@echo "    _idp_view_pool_clients              - View existing user pools"
	@echo "    _idp_view_pools                     - View existing user pools"
	@echo "    _idp_view_users                     - View users in the curent user pool"
	@echo

_cto_view_makefile_variables :: _idp_certificate_view_makefile_variables
_idp_certificate_view_makefile_variables ::
	@echo "AWS::Cognito::Idp ($(_AWS_COGNITO_IDP_MK_VERSION)) variables:"
	@echo "    IDP_CLIENT_ID=$(IDP_CLIENT_ID)"
	@echo "    IDP_CLIENT_NAME=$(IDP_CLIENT_NAME)"
	@echo "    IDP_MAX_RESULTS=$(IDP_MAX_RESULTS)"
	@echo "    IDP_POOL_ID=$(IDP_POOL_ID)"
	@echo "    IDP_POOL_NAME=$(IDP_POOL_NAME)"
	@echo "    IDP_USER.ATTRIBUTES=$(IDP_USER_ATTRIBUTES)"
	@echo "    IDP_USER.NAME=$(IDP_USER_NAME)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_idp_create_user:
	@$(INFO) "$(AWS_LABEL)Creating user '$(IDP_USER_NAME)' in pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp admin-create-user $(__IDP_DESIRED_DELIVERY_MEDIUMS) $(__IDP_FORCE_ALIAS_CREATION) $(__IDP_MESSAGE_ACTION) $(__IDP_TEMPORARY_PASSWORD) $(__IDP_USER_ATTRIBUTE) $(__IDP_USER_POOL_ID) $(__IDP_USERNAME) $(__IDP_VALIDATION_DATA)

_idp_create_pool:
	@$(INFO) "$(AWS_LABEL)Creating user pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp create-user-pool $(__IDP_ALIAS_ATTRIBUTES) $(__IDP_AUTO_VERIFIED_ATTRIBUTES) $(__IDP_LAMBDA_CONFIG) $(__IDP_POLICIES) $(__IDP_POOL_NAME) $(__IDP_USERNAME_ATTRIBUTE)

_idp_delete_pool:
	@$(INFO) "$(AWS_LABEL)Deleting user pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	@$(WARN) "User pool name: $(IDP_POOL_NAME)"; $(NORMAL)
	$(AWS) cognito-idp delete-user-pool $(__IDP_POOL_ID)

_idp_delete_user:
	@$(INFO) "$(AWS_LABEL)Deleting user '$(IDP_USER_NAME)' in pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp admin-delete-user $(__IDP_USER_POOL_ID) $(__IDP_USERNAME)

_idp_disable_user:
	@$(INFO) "$(AWS_LABEL)Disabling user '$(IDP_USER_NAME)' from pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp admin-disable-user $(__IDP_USER_POOL_ID) $(__IDP_USERNAME)

_idp_enable_user:
	@$(INFO) "$(AWS_LABEL)Enabling user '$(IDP_USER_NAME)' in pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp admin-enable-user $(__IDP_USER_POOL_ID) $(__IDP_USERNAME)

_idp_show_user:
	@$(INFO) "$(AWS_LABEL)Showing profile of user '$(IDP_USER_NAME)' from pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp admin-get-user $(__IDP_USER_POOL_ID) $(__IDP_USERNAME)

_idp_show_pool:
	@$(INFO) "$(AWS_LABEL)Showing user pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp describe-user-pool $(__IDP_USER_POOL_ID)

_idp_show_user_profile_schema:
	@$(INFO) "$(AWS_LABEL)Showing iuser profile schema for pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp describe-user-pool  $(__IDP_USER_POOL_ID) --query "UserPool.SchemaAttributes[]$(IDP_SHOW_USER_SCHEMA_FIELDS)"

_idp_update_user_profile:
	@$(INFO) "$(AWS_LABEL)Updating the profiel of user '$(IDP_USER_NAME)' in pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp admin-update-user-attributes  $(__IDP_USER_ATTRIBUTES) $(__IDP_USER_POOL_ID) $(__IDP_USERNAME) 

_idp_view_groups:
	@$(INFO) "$(AWS_LABEL)View groups in pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp list-groups $(__IDP_LIMIT) $(__IDP_USER_POOL_ID) --query "Groups[]$(IDP_VIEW_GROUPS_FIELDS)"

_idp_view_identity_providers:
	@$(INFO) "$(AWS_LABEL)View identity providers for pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp list-identity-providers $(__IDP_MAX_RESULTS) $(__IDP_USER_POOL_ID) 

_idp_view_resource_servers:
	@$(INFO) "$(AWS_LABEL)View resource servers for pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp list-resource-servers $(__IDP_MAX_RESULTS) $(__IDP_USER_POOL_ID) --query "ResourceServers[]$(IDP_VIEW_RESOURCE_SERVERS_FIELDS)"

_idp_view_pool_clients:
	@$(INFO) "$(AWS_LABEL)View clients of user pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp list-user-pool-clients $(__IDP_USER_POOL_ID) $(__IDP_MAX_RESULTS)

_idp_view_pool_policies:
	@$(INFO) "$(AWS_LABEL)View policies of user pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp describe-user-pool $(__IDP_USER_POOL_ID) --query "UserPool.Policies"

_idp_view_pools:
	@$(INFO) "$(AWS_LABEL)View existing user pools ..."; $(NORMAL)
	$(AWS) cognito-idp list-user-pools $(__IDP_MAX_RESULTS)

_idp_view_users:
	@$(INFO) "$(AWS_LABEL)View users in pool '$(IDP_POOL_NAME)' ..."; $(NORMAL)
	$(AWS) cognito-idp list-users $(__IDP_ATTRIBUTE_TO_GET) $(__IDP_USER_POOL_ID) --query "Users[]$(IDP_VIEW_USERS_FIELDS)"
