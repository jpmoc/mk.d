_VAULT_AUTHMETHOD_MK_VERSION= $(_VAULT_MK_VERSION)

# VLT_AUTHMETHOD_JWT?=
# VLT_AUTHMETHOD_JWT_DIRPATH?= ./in/
# VLT_AUTHMETHOD_JWT_FILENAME?= my.jwt
# VLT_AUTHMETHOD_JWT_FILEPATH?= ./in/my.jwt
# VLT_AUTHMETHOD_CONFIG_DIRECTIVE?= "aws/config organization=hashicorp"
# VLT_AUTHMETHOD_CONFIG_DIRECTIVES?= "aws/config organization=hashicorp" ...
# VLT_AUTHMETHOD_DESCRIPTION?= "This is my description"
# VLT_AUTHMETHOD_ENDPOINT_URL?=
# VLT_AUTHMETHOD_LOGIN_DIRECTIVES?= "username=hashicorp password=foo" ...
# VLT_AUTHMETHOD_NAME?= my-authentication-method
# VLT_AUTHMETHOD_PATH?= userpass
# VLT_AUTHMETHOD_ROLE_NAME?=
# VLT_AUTHMETHOD_TOKEN?= s.CLnwMcT6pWXK63wGXy4n3dmG
# VLT_AUTHMETHOD_TOKEN_TTL?= 24h
# VLT_AUTHMETHOD_TYPE?= secret
# VLT_AUTHMETHOD_UPDATE_CONFIG?= kv
VLT_AUTHMETHODS_DETAILED_FLAG?= false
# VLT_AUTHMETHODS_SET_NAME?= my-secrets-set

# Derived variables
VLT_AUTHMETHOD_CONFIG_DIRECTIVES?= $(VLT_AUTHMETHOD_CONFIG_DIRECTIVE)
VLT_AUTHMETHOD_ENDPOINT_URL?= $(VLT_ENDPOINT_URL)
VLT_AUTHMETHOD_JWT?= $(if $(VLT_AUTHMETHOD_JWT_FILEPATH),@$(VLT_AUTHMETHOD_JWT_FILEPATH))
VLT_AUTHMETHOD_JWT_DIRPATH?= $(VLT_INPUTS_DIRPATH)
VLT_AUTHMETHOD_JWT_FILEPATH?= $(if $(VLT_AUTHMETHOD_JWT_FILENAME),$(VLT_AUTHMETHOD_JWT_DIRPATH)$(VLT_AUTHMETHOD_JWT_FILENAME))
VLT_AUTHMETHOD_NAME?= $(VLT_AUTHMETHOD_TYPE)@$(VLT_AUTHMETHOD_PATH)
VLT_AUTHMETHOD_PATH?= $(if $(VLT_AUTHMETHOD_TYPE),$(VLT_AUTHMETHOD_TYPE)/)
VLT_AUTHMETHOD_ROLE_NAME?= $(VLT_AUTHMETHODROLE_NAME)

# Options variables
__VLT_ADDRESS__AUTHMETHOD= $(if $(VLT_AUTHMETHOD_ENDPOINT_URL),--address $(VLT_AUTHMETHOD_ENDPOINT_URL))
__VLT_DESCRIPTION__AUTHMETHOD= $(if $(VLT_AUTHMETHOD_DESCRIPTION),--description $(VLT_AUTHMETHOD_DESCRIPTION))
__VLT_DETAILED__AUTHMETHODS= $(if $(VLT_AUTHMETHODS_DETAILED_FLAG),--detailed=$(VLT_AUTHMETHODS_DETAILED_FLAG))
__VLT_LOCAL=
__VLT_METHOD__AUTHMETHOD= $(if $(VLT_AUTHMETHOD_TYPE),--method $(VLT_AUTHMETHOD_TYPE))
__VLT_PATH__AUTHMETHOD= $(if $(VLT_AUTHMETHOD_PATH),--path $(VLT_AUTHMETHOD_PATH))

# Pipe

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::AuthMethod ($(_VAULT_AUTHMETHOD_MK_VERSION)) macros:'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::AuthMethod ($(_VAULT_AUTHMETHOD_MK_VERSION)) parameters:'
	@echo '    VLT_AUTHMETHOD_CONFIG_DIRECTIVE=$(VLT_AUTHMETHOD_CONFIG_DIRECTIVE)'
	@echo '    VLT_AUTHMETHOD_CONFIG_DIRECTIVES=$(VLT_AUTHMETHOD_CONFIG_DIRECTIVES)'
	@echo '    VLT_AUTHMETHOD_DESCRIPTION=$(VLT_AUTHMETHOD_DESCRIPTION)'
	@echo '    VLT_AUTHMETHOD_ENDPOINT_URL=$(VLT_AUTHMETHOD_ENDPOINT_URL)'
	@echo '    VLT_AUTHMETHOD_JWT=$(VLT_AUTHMETHOD_JWT)'
	@echo '    VLT_AUTHMETHOD_JWT_DIRPATH=$(VLT_AUTHMETHOD_JWT_DIRPATH)'
	@echo '    VLT_AUTHMETHOD_JWT_FILENAME=$(VLT_AUTHMETHOD_JWT_FILENAME)'
	@echo '    VLT_AUTHMETHOD_JWT_FILEPATH=$(VLT_AUTHMETHOD_JWT_FILEPATH)'
	@echo '    VLT_AUTHMETHOD_LOGIN_DIRECTIVES=$(VLT_AUTHMETHOD_LOGIN_DIRECTIVES)'
	@echo '    VLT_AUTHMETHOD_NAME=$(VLT_AUTHMETHOD_NAME)'
	@echo '    VLT_AUTHMETHOD_PATH=$(VLT_AUTHMETHOD_PATH)'
	@echo '    VLT_AUTHMETHOD_ROLE_NAME=$(VLT_AUTHMETHOD_ROLE_NAME)'
	@echo '    VLT_AUTHMETHOD_TOKEN=$(VLT_AUTHMETHOD_TOKEN)'
	@echo '    VLT_AUTHMETHOD_TOKEN_TTL=$(VLT_AUTHMETHOD_TOKEN_TTL)'
	@echo '    VLT_AUTHMETHOD_TYPE=$(VLT_AUTHMETHOD_TYPE)'
	@echo '    VLT_AUTHMETHODS_DETAILED_FLAG=$(VLT_AUTHMETHODS_DETAILED_FLAG)'
	@echo '    VLT_AUTHMETHODS_SET_NAME=$(VLT_AUTHMETHODS_SET_NAME)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::AuthMethod ($(_VAULT_AUTHMETHOD_MK_VERSION)) targets:'
	@echo '    _vlt_configure_authmethod               - Configure an authentication-method'
	@echo '    _vlt_create_authmethod                  - Create an authentication-method'
	@echo '    _vlt_delete_authmethod                  - Delete an authentication-method'
	@echo '    _vlt_enable_authmethod                  - Enable an authentication-method'
	@echo '    _vlt_disable_authmethod                 - Disable an authentication-method'
	@echo '    _vlt_get_authmethod_token               - Get a token using an authentication-method'
	@echo '    _vlt_login_authmethod                   - Log in using the authentication-method'
	@echo '    _vlt_revoke_authmethod_tokens           - Revoke ALL tokens from an authentication-method'
	@echo '    _vlt_show_authmethod                    - Show everything related to an authentication-method'
	@echo '    _vlt_show_authmethod_certificates       - Show certificates used by an authentication-method'
	@echo '    _vlt_show_authmethod_config             - Show the config used by an authentication-method'
	@echo '    _vlt_show_authmethod_description        - Show desription of an authentication-method'
	@echo '    _vlt_show_authmethod_roles              - Show the roles used by an authentication-method'
	@echo '    _vlt_show_authmethod_stsroles           - Show the STS-roles used by an authentication-method'
	@echo '    _vlt_update_authmethod                  - Update the authentication-methods'
	@echo '    _vlt_validate_authmethod_token          - Validate token from an authentication-methods'
	@echo '    _vlt_view_authmethods                   - View authentication-methods'
	@echo '    _vlt_view_authmethods_set               - View set of authentication-methods'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_configure_authmethod:
	@$(INFO) '$(VLT_UI_LABEL)Configuring authentication-method "$(VLT_AUTHMETHOD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation uses one or more directives to configure authentication'; $(NORMAL)
	@$(WARN) 'For userpass authmethod, create users and password pairs'; $(NORMAL)
	@$(WARN) 'For kubernetes authmethod, configure connection to k8s API server to validate JWT of potential clients'; $(NORMAL)
	@for D in  $(VLT_AUTHMETHOD_CONFIG_DIRECTIVES); do \
		echo "\n$(VAULT) write $(__VLT_ADDRESS) $(__VLT_CA_CERT)" $${D}; \
		echo $${D} | xargs $(VAULT) write $(__VLT_ADDRESS) ; \
	done 

_vlt_create_authmethod:
	# See enable authmethod

_vlt_delete_authmethod:
	# See disable authmethod

_vlt_disable_authmethod:
	@$(INFO) '$(VLT_UI_LABEL)Disabling authentication-method "$(VLT_AUTHMETHOD_NAME)" ...'; $(NORMAL)
	$(VAULT) auth disable $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_AUTHMETHOD_PATH)

_vlt_enable_authmethod:
	@$(INFO) '$(VLT_UI_LABEL)Enabling authentication-method "$(VLT_AUTHMETHOD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if an auth-method is already enabled on that path'; $(NORMAL)
	-$(VAULT) auth enable $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_DESCRIPTION__AUTHMETHOD) $(__VLT_LOCAL) $(__VLT_PATH__AUTHMETHOD) $(VLT_AUTHMETHOD_TYPE)

_vlt_get_authmethod_token:
	@$(INFO) '$(VLT_UI_LABEL)Get a token using authentication-method "$(VLT_AUTHMETHOD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a vault token that can be subsequently used to read secrets'; $(NORMAL)
	@$(WARN) 'This operation returns a different token each time it is executed'; $(NORMAL)
	$(if $(filter kubernetes, $(VLT_AUTHMETHOD_TYPE)), \
		$(VAULT) write $(__VLT_ADDRESS) $(__VLT_CA_CERT) auth/$(VLT_AUTHMETHOD_PATH)login role=$(VLT_AUTHMETHOD_ROLE_NAME) jwt=$(VLT_AUTHMETHOD_JWT); \
	, @ \
		echo 'This VLT_AUTHMETHOD_TYPE does NOT support this operation'; \
	)

_vlt_login_authmethod:
	@$(INFO) '$(VLT_UI_LABEL)Logging in using token obtained form authentication-method "$(VLT_AUTHMETHOD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation logs out the current user and logs in a new user'; $(NORMAL)
	$(if $(VLT_AUTHMETHOD_TOKEN), \
		$(VAULT) login $(__VLT_ADDRESS) $(__VLT_CA_CERT) --method token $(VLT_AUTHMETHOD_TOKEN); \
	, @ \
		for D in  $(VLT_AUTHMETHOD_LOGIN_DIRECTIVES); do \
			echo "\n$(VAULT) login $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_METHOD__AUTHMETHOD)" $${D}; \
			echo $${D} | xargs $(VAULT) login $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_METHOD__AUTHMETHOD) ; \
		done; \
	) echo
	cat $(HOME)/.vault-token


_vlt_revoke_authmethod_tokens:
	@$(INFO) '$(VLT_UI_LABEL)Revoking ALL tokens generated against authentication-method "$(VLT_AUTHMETHOD_NAME)" ...'; $(NORMAL)
	$(VAULT) token revoke $(__VLT_ADDRESS) $(__VLT_CA_CERT) -mode path $(VLT_AUTHMETHOD_PATH)

_vlt_show_authmethod: _vlt_show_authmethod_certificates _vlt_show_authmethod_config _vlt_show_authmethod_roles _vlt_show_authmethod_stsroles _vlt_show_authmethod_description

_vlt_show_authmethod_certificates:
	@$(INFO) '$(VLT_UI_LABEL)Showing certificates of authentication-method "$(VLT_AUTHMETHOD_NAME)" ...'; $(NORMAL)
	-$(if $(filter aws, $(VLT_AUTHMETHOD_TYPE)), \
		vault list $(__VLT_ADDRESS) $(__VLT_CA_CERT) auth/$(VLT_AUTHMETHOD_PATH)config/certificates ; \
	)
	$(if $(filter cert, $(VLT_AUTHMETHOD_TYPE)), \
		vault list $(__VLT_ADDRESS) $(__VLT_CA_CERT) auth/$(VLT_AUTHMETHOD_PATH)certs ; \
	)
	$(if $(filter-out aws cert, $(VLT_AUTHMETHOD_TYPE)), \
		echo 'This VLT_AUTHMETHOD_TYPE does NOT use certificates'; \
	)

_vlt_show_authmethod_config:
	@$(INFO) '$(VLT_UI_LABEL)Showing config of authentication-method "$(VLT_AUTHMETHOD_NAME)" ...'; $(NORMAL)
	$(if $(filter aws, $(VLT_AUTHMETHOD_TYPE)), \
		$(VAULT) read $(__VLT_ADDRESS) $(__VLT_CA_CERT) auth/$(VLT_AUTHMETHOD_PATH)config/client ; \
	)
	$(if $(filter kubernetes, $(VLT_AUTHMETHOD_TYPE)), \
		$(VAULT) read $(__VLT_ADDRESS) $(__VLT_CA_CERT) auth/$(VLT_AUTHMETHOD_PATH)config ; \
	)
	$(if $(filter-out kubernetes aws, $(VLT_AUTHMETHOD_TYPE)), \
		echo 'This VLT_AUTHMETHOD_TYPE does NOT use a config'; \
	)

_vlt_show_authmethod_description:
	@$(INFO) '$(VLT_UI_LABEL)Showing description of authentication-method "$(VLT_AUTHMETHOD_NAME)" ...'; $(NORMAL)
	$(VAULT) auth list $(__VLT_ADDRESS) $(__VLT_CA_CERT) --detailed=true | head -2; \
	$(VAULT) auth list $(__VLT_ADDRESS) $(__VLT_CA_CERT) --detailed=true | grep $(VLT_AUTHMETHOD_TYPE)

_vlt_show_authmethod_roles:
	@$(INFO) '$(VLT_UI_LABEL)Showing roles of authentication-method "$(VLT_AUTHMETHOD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns auth-method-roles which are mapped to a set of secret access-policies'; $(NORMAL)
	$(if $(filter aws kubernetes, $(VLT_AUTHMETHOD_TYPE)), \
		vault list $(__VLT_ADDRESS) $(__VLT_CA_CERT) auth/$(VLT_AUTHMETHOD_PATH)role ; \
	)
	$(if $(filter-out aws kubernetes, $(VLT_AUTHMETHOD_TYPE)), \
		echo 'This VLT_AUTHMETHOD_TYPE does NOT use roles'; \
	)

_vlt_show_authmethod_stsroles:
	@$(INFO) '$(VLT_UI_LABEL)Showing STS-roles of authentication-method "$(VLT_AUTHMETHOD_NAME)" ...'; $(NORMAL)
	-$(if $(filter aws kubernetes, $(VLT_AUTHMETHOD_TYPE)), \
		vault list $(__VLT_ADDRESS) $(__VLT_CA_CERT) auth/$(VLT_AUTHMETHOD_PATH)config/sts ; \
	)
	$(if $(filter-out aws, $(VLT_AUTHMETHOD_TYPE)), \
		echo 'This VLT_AUTHMETHOD_TYPE does NOT use STS-roles'; \
	)


_vlt_update_authmethod: _vlt_configure_authmethod

_vlt_view_authmethods:
	@$(INFO) '$(VLT_UI_LABEL)Viewing authentication-methods ...'; $(NORMAL)
	@$(WARN) 'This operation always returns the token as enabled'; $(NORMAL)
	$(VAULT) auth list $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_DETAILED__AUTHMETHODES)

_vlt_view_authmethods_set:
	@$(INFO) '$(VLT_UI_LABEL)Viewing authentication-methods-set "$(VLT_AUTHMETHODS_SET_NAME)" ...'; $(NORMAL)
	# $(VAULT) auth list $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_DETAILED__AUTHMETHODES)
