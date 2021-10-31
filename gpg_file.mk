_GPG_FILE_MK_VERSION= $(_GPG_MK_VERSION)

# GPG_FILE_DECRYPTED_FILEPATH?= ./file.txt.gpg
# GPG_FILE_ENCRYPTED_FILEPATH?= ./file.txt
# GPG_FILE_SYMMETRIC_ENABLE?= true

# Derived parameters
GPG_FILE_DECRYPTED_FILEPATH?= $(if $(GPG_FILE_ENCRYPTED_FILEPATH),$(GPG_FILE_ENCRYPTED_FILEPATH).gpg)

# Option parameters
__GPG_SYMMETRIC?= $(if $(filter true, $(GPG_FILE_SYMMETRIC_ENABLE)),--symmetric)

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_gpg_list_macros ::
	@#echo 'GPG::File ($(_GPG_FILE_MK_VERSION)) macros:'
	@#echo

_gpg_list_parameters ::
	@echo 'GPG::File ($(_GPG_FILE_MK_VERSION)) parameters:'
	@echo '    GPG_FILE_DECRYPTED_FILEPATH=$(GPG_FILE_DECRYPTED_FILEPATH)'
	@echo '    GPG_FILE_ENCRYPTED_FILEPATH=$(GPG_FILE_ENCRYPTED_FILEPATH)'
	@echo '    GPG_FILE_SYMMETRIC_ENABLE=$(GPG_FILE_SYMMETRIC_ENABLE)'
	@echo

_gpg_list_targets ::
	@echo 'GPG::File ($(_GPG_FILE_MK_VERSION)) targets:'
	@echo '    _gpg_decrypt_file           - Decrypt an encrypted file'
	@echo '    _gpg_encrypt_file           - Encrypt a clear file'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gpg_decrypt_file:
	@$(INFO) '$(GPG_UI_LABEL)Decrypting file "$(GPG_FILE_NAME)" ...'; $(NORMAL)
	$(GPG) --decrypt $(GPG_FILE_ENCRYPTED_FILEPATH)

_gpg_encrypt_file:
	@$(INFO) '$(GPG_UI_LABEL)Encrypting file "$(GPG_FILE_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'Encrypt  with a symmetric cipher using a passphrase.'; $(NORMAL)
	$(GPG) --encrypt $(__GPG_SYMMETRIC) $(GPG_FILE_DECRYPTED_FILEPATH)
