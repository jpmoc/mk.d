_VAULT_ENCRYPTIONKEY_MK_VERSION= $(_VAULT_MK_VERSION)

# Options variables

# Pipe

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::EncryptionKey ($(_VAULT_ENCRYPTIONKEY_MK_VERSION)) macros:'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::EncryptionKey ($(_VAULT_ENCRYPTIONKEY_MK_VERSION)) parameters:'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::EncryptionKey ($(_VAULT_ENCRYPTIONKEY_MK_VERSION)) targets:'
	@echo '    _vlt_rotate_encryptionkey       - Rptate the encryption key'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_rotate_encryptionkey:
	@$(INFO) '$(VLT_UI_LABEL)Rotating the vault-internal encryption-key ...'; $(NORMAL)
	$(VAULT) operator rotate $(__VLT_ADDRESS) $(__VLT_CA_CERT)
