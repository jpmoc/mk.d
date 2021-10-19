_VAULT_OPERATOR_MK_VERSION= $(_VAULT_MK_VERSION)

VLT_OPERATOR_NAME?= root
VLT_OPERATOR_RECOVERYKEY?= XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# VLT_OPERATOR_RECOVERYKEYS?= +Vk/awQSUlZf5HTOWKpBgCHIWEsU6m9vQzF9lccSfYJP ...
VLT_OPERATOR_RECOVERYKEYS_COUNT?= 5
VLT_OPERATOR_RECOVERYKEYS_THRESHOLD?= 3
# VLT_OPERATOR_TOKEN?= s.cM0snmQv1zWzy02PsIHBU8KW
VLT_OPERATOR_UNSEALKEY?= XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
VLT_OPERATOR_UNSEALKEYS_COUNT?= 5
VLT_OPERATOR_UNSEALKEYS_THRESHOLD?= 3
# VLT_OPERATOR_UNSEALKEYS?= woGFO/CaRbtGaIUjblsJhGMKk95rLhmAUgar7+mMpjI/ ...

# Derived variables
VLT_OPERATOR_NAME?= $(USER)
VLT_OPERATOR_RECOVERYKEYS?= $(VLT_OPERATOR_RECOVERYKEY)
VLT_OPERATOR_UNSEALKEYS?= $(VLT_OPERATOR_UNSEALKEY)

# Options variables
__VLT_KEY_SHARES= $(if $(VLT_OPERATOR_UNSEALKEYS_COUNT),--key-shares $(VLT_OPERATOR_UNSEALKEYS_COUNT))
__VLT_KEY_THRESHOLD= $(if $(VLT_OPERATOR_UNSEALKEYS_THRESHOLD),--key-threshold $(VLT_OPERATOR_UNSEALKEYS_THRESHOLD))
__VLT_MIGRATION=
__VLT_OTP= $(if $(VLT_OPERATOR_OTP),--otp $(VLT_OPERATOR_OTP))
__VLT_PGP_KEYS=
__VLT_RECOVERY_SHARES= $(if $(VLT_OPERATOR_RECOVERYKEYS_COUNT),--recovery-shares $(VLT_OPERATOR_RECOVERYKEYS_COUNT))
__VLT_RECOVERY_THRESHOLD= $(if $(VLT_OPERATOR_RECOVERYKEYS_THRESHOLD),--recovery-threshold $(VLT_OPERATOR_RECOVERYKEYS_THRESHOLD))
__VLT_ROOT_TOKEN_PGP_KEY=
__VLT_STATUS=

# Pipe

# UI parameters

# Utilities

#--- MACROS

_vlt_get_operator_otp= $(shell $(VAULT) operator generate-root $(__VLT_ADDRESS) --generate-otp)

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::Operator ($(_VAULT_OPERATOR_MK_VERSION)) macros:'
	@echo '    _vlt_get_operator_otp               - Get a one-time password'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::Operator ($(_VAULT_OPERATOR_MK_VERSION)) parameters:'
	@echo '    VLT_OPERATOR_NAME=$(VLT_OPERATOR_NAME)'
	@echo '    VLT_OPERATOR_OTP=$(VLT_OPERATOR_OTP)'
	@echo '    VLT_OPERATOR_RECOVERYKEY=$(VLT_OPERATOR_RECOVERYKEY)'
	@echo '    VLT_OPERATOR_RECOVERYKEYS=$(VLT_OPERATOR_RECOVERYKEYS)'
	@echo '    VLT_OPERATOR_RECOVERYKEYS_COUNT=$(VLT_OPERATOR_RECOVERYKEYS_COUNT)'
	@echo '    VLT_OPERATOR_RECOVERYKEYS_THRESHOLD=$(VLT_OPERATOR_RECOVERYKEYS_THRESHOLD)'
	@echo '    VLT_OPERATOR_TOKEN=$(VLT_OPERATOR_TOKEN)'
	@echo '    VLT_OPERATOR_UNSEALKEY=$(VLT_OPERATOR_UNSEALKEY)'
	@echo '    VLT_OPERATOR_UNSEALKEYS=$(VLT_OPERATOR_UNSEALKEYS)'
	@echo '    VLT_OPERATOR_UNSEALKEYS_COUNT=$(VLT_OPERATOR_UNSEALKEYS_COUNT)'
	@echo '    VLT_OPERATOR_UNSEALKEYS_THRESHOLD=$(VLT_OPERATOR_UNSEALKEYS_THRESHOLD)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::Operator ($(_VAULT_OPERATOR_MK_VERSION)) targets:'
	@echo '    _vlt_create_operator_token       - Create a new operator token'
	@echo '    _vlt_init_operator               - Initialize operator'
	@echo '    _vlt_login_operator              - Log in as operator'
	@echo '    _vlt_recover_operator            - Unseal a vault using a recovery-key from an operator'
	@echo '    _vlt_show_operator               - Show operator'
	@echo '    _vlt_show_operator_keystatus     - Show kwy-status of the operator'
	@echo '    _vlt_unseal_operator             - Unseal a vault using a unseal-key from an operator'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_create_operator_token:
	@$(INFO) '$(VLT_UI_LABEL)Getting a new one-time password for operator "$(VLT_OPERATOR_NAME)" ...'; $(NORMAL)
	$(VAULT) operator generate-root $(__VLT_ADDRESS) $(__VLT_CA_CERT) --generate-otp | tee ./otp; echo

	@$(INFO) '$(VLT_UI_LABEL)Initializing generation of new operator token ...'; $(NORMAL)
	@$(WARN) 'The  "Nonce" value should be distributed to all unseal key holders'; $(NORMAL)
	OTP=$$(cat ./otp);  $(VAULT) operator generate-root $(__VLT_ADDRESS) $(__VLT_CA_CERT) --init --otp $${OTP} | tee /dev/tty | awk '/Nonce/ {print $$2}' > ./nonce

	@$(INFO) '$(VLT_UI_LABEL)Generating a new ENCODED operator token ...'; $(NORMAL)
	NONCE=$$(cat ./nonce); $(foreach K, $(VLT_OPERATOR_RECOVERYKEYS), $(VAULT) operator generate-root $(__VLT_ADDRESS) $(__VLT_CA_CERT) --nonce $${NONCE} $(K)  | tee /dev/tty | awk '/Token/ {print $$3}' > ./encoded_token;)

	@$(INFO) '$(VLT_UI_LABEL)Decoding the encoded token ...'; $(NORMAL)
	OTP=$$(cat ./otp); ETOKEN=$$(cat ./encoded_token); $(VAULT) operator generate-root $(__VLT_ADDRESS) $(__VLT_CA_CERT) --decode $${ETOKEN}  --otp $${OTP}
	@$(INFO) '$(VLT_UI_LABEL)Cleaning up ...'; $(NORMAL)
	rm -f ./otp ./encoded_token ./nonce

_vlt_init_operator:
	@$(INFO) '$(VLT_UI_LABEL)Fetching credentials for operator "$(VLT_OPERATOR_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the vault has already been initialized'; $(NORMAL)
	$(VAULT) operator init $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_KEY_SHARES) $(__VLT_KEY_THRESHOLD) $(__VLT_PGP_KEYS) $(__VLT_RECOVERY_SHARES) $(__VLT_RECOVERY_THRESHOLD) $(__VLT_ROOT_TOKEN_PGP_KEY) $(__VLT_STATUS)

_vlt_login_operator:
	@$(INFO) '$(VLT_UI_LABEL)Logging in as operator "$(VLT_OPERATOR_NAME)" ...'; $(NORMAL)
	$(VAULT) login $(__VLT_ADDRESS) $(__VLT_CA_CERT) --method token $(VLT_OPERATOR_TOKEN)

_vlt_recover_operator:
	@$(INFO) '$(VLT_UI_LABEL)Partially unsealing vault/master-key using the recovery-key of operator "$(VLT_OPERATOR_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT validate the provided recovery-key'; $(NORMAL)
	@$(WARN) 'This operation completes the vault unsealing process if $(VLT_OPERATOR_RECOVERYKEYS_THRESHOLD) valid recovery-keys have been submitted'; $(NORMAL)
	@$(WARN) 'If the returned sealed-status is set to false, the vault has been unsealed and will allow logins'; $(NORMAL)
	$(VAULT) operator unseal $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_MIGRATION) $(VLT_OPERATOR_RECOVERYKEY)

_vlt_show_operator: _vlt_show_operator_keystatus

_vlt_show_operator_keystatus:
	@$(INFO) '$(VLT_UI_LABEL)Showing key-status of operator "$(VLT_OPERATOR_NAME)" ...'; $(NORMAL)
	$(VAULT) operator key-status $(__VLT_ADDRESS) $(__VLT_CA_CERT)

_vlt_unseal_operator:
	@$(INFO) '$(VLT_UI_LABEL)Partially unsealing vault/master-key using unseal-key of operator "$(VLT_OPERATOR_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT validate the provided unseal-key'; $(NORMAL)
	@$(WARN) 'This operation completes the vault/master-key unsealing process if $(VLT_OPERATOR_UNSEALKEYS_THRESHOLD) valid unseal-keys have been submitted'; $(NORMAL)
	@$(WARN) 'If the returned sealed-status is set to false, the vault has been unsealed and will allow logins'; $(NORMAL)
	$(VAULT) operator unseal $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_MIGRATION) $(VLT_OPERATOR_UNSEALKEY)

_vlt_unseal_operators:
	@$(INFO) '$(VLT_UI_LABEL)Unsealing the vault/master-key using $(VLT_OPERATOR_UNSEALKEYS_THRESHOLD) keys from operator "$(VLT_OPERATOR_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation executes commands that are normally meant to be executed on several hosts'; $(NORMAL)
	$(foreach K, $(VLT_OPERATOR_UNSEALKEYS),$(VAULT) operator unseal $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_MIGRATION) $(K); echo;)
