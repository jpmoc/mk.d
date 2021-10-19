_VAULT_AUTHMETHODROLE_MK_VERSION= $(_VAULT_MK_VERSION)

# VLT_AUTHMETHODROLE_AUTHMETHOD_PATH?= kubernetes/
# VLT_AUTHMETHODROLE_NAME?= my-auth-method-role
# VLT_AUTHMETHODROLE_PATH?=
# VLT_AUTHMETHODROLE_PERIOD?= 60s
# VLT_AUTHMETHODROLE_POLICIES_NAMES?=
# VLT_AUTHMETHODROLE_POLICY_NAME?=
# VLT_AUTHMETHODROLE_SERVICEACCOUNTS_NAMES?= k8s-service-account
# VLT_AUTHMETHODROLE_SERVICEACCOUNTS_NAMESPACES?= k8s-namespaces
# VLT_AUTHMETHODROLE_TOKEN_TTL?= 24h
# VLT_AUTHMETHODROLES_SET_NAME?= my-auth-method-roles-set

# Derived variables
VLT_AUTHMETHODROLE_AUTHMETHOD_PATH?= $(VLT_AUTHMETHOD_PATH)
VLT_AUTHMETHODROLE_PATH?= $(if $(VLT_AUTHMETHODROLE_NAME),$(VLT_AUTHMETHODROLE_AUTHMETHOD_PATH)role/$(VLT_AUTHMETHODROLE_NAME))
VLT_AUTHMETHODROLE_POLICY_NAME?= $(VLT_POLICY_NAME)
VLT_AUTHMETHODROLE_POLICIES_NAMES?= $(VLT_AUTHMETHODROLE_POLICY_NAME)

# Options variables
__VLT_BOUND_SERVICE_ACCOUNT_NAMES= $(if $(VLT_AUTHMETHODROLE_SERVICEACCOUNTS_NAMES),bound_service_account_names=$(VLT_AUTHMETHODROLE_SERVICEACCOUNTS_NAMES))
__VLT_BOUND_SERVICE_ACCOUNT_NAMESPACES= $(if $(VLT_AUTHMETHODROLE_SERVICEACCOUNTS_NAMESPACES),bound_service_account_namespaces=$(VLT_AUTHMETHODROLE_SERVICEACCOUNTS_NAMESPACES))
__VLT_PERIOD= $(if $(VLT_AUTHMETHODROLE_PERIOD),period=$(VLT_AUTHMETHODROLE_PERIOD))
__VLT_POLICIES__AUTHMETHODROLE= $(if $(VLT_AUTHMETHODROLE_POLICIES_NAMES),policies=$(VLT_AUTHMETHODROLE_POLICIES_NAMES))
__VLT_TTL= $(if $(VLT_AUTHMETHODROLE_TOKEN_TTL),ttl=$(VLT_AUTHMETHODROLE_TOKEN_TTL))

# Pipe

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::AuthMethodiRole ($(_VAULT_AUTHMETHODROLE_MK_VERSION)) macros:'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::AuthMethodiRole ($(_VAULT_AUTHMETHODROLE_MK_VERSION)) parameters:'
	@echo '    VLT_AUTHMETHODROLE_AUTHMETHOD_PATH=$(VLT_AUTHMETHODROLE_AUTHMETHOD_PATH)'
	@echo '    VLT_AUTHMETHODROLE_NAME=$(VLT_AUTHMETHODROLE_NAME)'
	@echo '    VLT_AUTHMETHODROLE_PATH=$(VLT_AUTHMETHODROLE_PATH)'
	@echo '    VLT_AUTHMETHODROLE_PERIOD=$(VLT_AUTHMETHODROLE_PERIOD)'
	@echo '    VLT_AUTHMETHODROLE_POLICIES_NAMES=$(VLT_AUTHMETHODROLE_POLICIES_NAMES)'
	@echo '    VLT_AUTHMETHODROLE_POLICY_NAME=$(VLT_AUTHMETHODROLE_POLICY_NAME)'
	@echo '    VLT_AUTHMETHODROLE_SERVICEACCOUNTS_NAMES=$(VLT_AUTHMETHODROLE_SERVICEACCOUNTS_NAMES)'
	@echo '    VLT_AUTHMETHODROLE_SERVICEACCOUNTS_NAMESPACES=$(VLT_AUTHMETHODROLE_SERVICEACCOUNTS_NAMESPACES)'
	@echo '    VLT_AUTHMETHODROLE_TOKEN_TTL=$(VLT_AUTHMETHOD_TOKEN_TTL)'
	@echo '    VLT_AUTHMETHODROLES_SET_NAME=$(VLT_AUTHMETHODS_SET_NAME)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::AuthMethodiRole ($(_VAULT_AUTHMETHODROLE_MK_VERSION)) targets:'
	@echo '    _vlt_create_authmethorrole                  - Create an authentication-method-role'
	@echo '    _vlt_delete_authmethorrole                  - Delete an authentication-method-role'
	@echo '    _vlt_show_authmethorrole                    - Show everything related to an authentication-method-role'
	@echo '    _vlt_show_authmethorrole_description        - Show desription of an authentication-method-role'
	@echo '    _vlt_show_authmethorrole_policies           - Show policies of an authentication-method-role'
	@echo '    _vlt_update_authmethorrole                  - Update the authentication-method-roles'
	@echo '    _vlt_view_authmethorroles                   - View authentication-method-roles'
	@echo '    _vlt_view_authmethorroles_set               - View set of authentication-method-roles'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_create_authmethodrole:
	@$(INFO) '$(VLT_UI_LABEL)Creating/updating authentication-method-role "$(VLT_AUTHMETHODROLE_NAME)" ...'; $(NORMAL)
	$(VAULT) write $(__VLT_ADDRESS) $(__VLT_CA_CERT) auth/$(VLT_AUTHMETHODROLE_PATH) $(strip $(__VLT_BOUND_SERVICE_ACCOUNT_NAMES) $(__VLT_BOUND_SERVICE_ACCOUNT_NAMESPACES) $(__VLT_PERIOD) $(__VLT_POLICIES__AUTHMETHODROLE) $(__VLT_TTL) )

_vlt_delete_authmethodrole:
	@$(INFO) '$(VLT_UI_LABEL)Deleting authentication-method-role "$(VLT_AUTHMETHODROLE_NAME)" ...'; $(NORMAL)
	$(VAULT) delete $(__VLT_ADDRESS) $(__VLT_CA_CERT) auth/$(VLT_AUTHMETHODROLE_PATH)

_vlt_show_authmethodrole: _vlt_show_authmethodrole_policies _vlt_show_authmethodrole_description

_vlt_show_authmethodrole_description:
	@$(INFO) '$(VLT_UI_LABEL)Showing description of authentication-method-role "$(VLT_AUTHMETHODROLE_NAME)" ...'; $(NORMAL)
	$(VAULT) read $(__VLT_ADDRESS) $(__VLT_CA_CERT) auth/$(VLT_AUTHMETHODROLE_AUTHMETHOD_PATH)role/$(VLT_AUTHMETHODROLE_NAME)

_vlt_show_authmethodrole_policies:
	@$(INFO) '$(VLT_UI_LABEL)Showing policies of authentication-method-role "$(VLT_AUTHMETHODROLE_NAME)" ...'; $(NORMAL)
	$(foreach D, $(VLT_AUTHMETHODROLE_POLICIES_NAMES), @/bin/echo $(D); $(VAULT) policy read $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(D);)

_vlt_update_authmethodrole: _vlt_create_authmethodrole

_vlt_view_authmethodroles:
	@$(INFO) '$(VLT_UI_LABEL)Viewing authentication-method-roles ...'; $(NORMAL)
	@$(WARN) 'This operation returns vault-internal roles which are attached to secret access-policies'; $(NORMAL)
	$(VAULT) list $(__VLT_ADDRESS) $(__VLT_CA_CERT) auth/$(VLT_AUTHMETHODROLE_AUTHMETHOD_PATH)role

_vlt_view_authmethodroles_set:
	@$(INFO) '$(VLT_UI_LABEL)Viewing authentication-method-roles-set "$(VLT_AUTHMETHODROLES_SET_NAME)" ...'; $(NORMAL)
	# $(VAULT) list $(__VLT_ADDRESS) $(__VLT_CA_CERT) auth/$(VLT_AUTHMETHODROLE_PATH)role
