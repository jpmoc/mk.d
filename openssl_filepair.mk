_OPENSSL_FILEPAIR_MK_VERSION= $(_OPENSSL_MK_VERSION)

# OSL_FILEPAIR_DECRYPTED_FILENAME?= file.txt
# OSL_FILEPAIR_DECRYPTED_FILEPATH?= ./in/file.txt
# OSL_FILEPAIR_DIRPATH?= ./in/
# OSL_FILEPAIR_ENCRYPTED_FILENAME?= file.txt
# OSL_FILEPAIR_ENCRYPTED_FILEPATH?= ./out/file.txt
# OSL_FILEPAIR_NAME?= 
# OSL_FILEPAIRS_DIRPATH?= ./out/
# OSL_FILEPAIRS_SET_NAME?= files@./out/

# Derived parameters
OSL_FILEPAIR_DECRYPTED_DIRPATH?= $(OSL_FILEPATH_DIRPATH)
OSL_FILEPAIR_DECRYPTED_FILEPATH?= $(OSL_FILEPAIR_DECRYPTED_DIRPATH)$(OSL_FILEPATH_DECRYPTED_FILENAME)
OSL_FILEPAIR_DIRPATH?= $(OSL_INPUTS_DIRPATH)
OSL_FILEPAIR_ENCRYPTED_DIRPATH?= $(OSL_FILEPATH_DIRPATH)
OSL_FILEPAIR_ENCRYPTED_FILEPATH?= $(OSL_FILEPAIR_ENCRYPTED_DIRPATH)$(OSL_FILEPATH_ENCRYPTED_FILENAME)

# Option parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# INTERFACE
#

_ssl_view_framework_macros ::
	@echo 'OpenSSL::FilePair ($(_OPENSSL_FILEPAIR_MK_VERSION)) parameters:'
	@echo

_ssl_view_framework_parameters ::
	@echo 'OpenSSL::FilePair ($(_OPENSSL_FILEPAIR_MK_VERSION)) parameters:'
	@echo '    OSL_FILEPAIR_DECRYPTED_DIRPATH=$(OSL_FILEPAIR_DECRYPTED_DIRPATH)'
	@echo '    OSL_FILEPAIR_DECRYPTED_FILENAME=$(OSL_FILEPAIR_DECRYPTED_FILENAME)'
	@echo '    OSL_FILEPAIR_DECRYPTED_FILEPATH=$(OSL_FILEPAIR_DECRYPTED_FILEPATH)'
	@echo '    OSL_FILEPAIR_ENCRYPTED_DIRPATH=$(OSL_FILEPAIR_ENCRYPTED_DIRPATH)'
	@echo '    OSL_FILEPAIR_ENCRYPTED_FILENAME=$(OSL_FILEPAIR_ENCRYPTED_FILENAME)'
	@echo '    OSL_FILEPAIR_ENCRYPTED_FILEPATH=$(OSL_FILEPAIR_ENCRYPTED_FILEPATH)'
	@echo '    OSL_FILEPAIR_NAME=$(OSL_FILEPAIR_NAME)'
	@echo '    OSL_FILEPAIRS_DIRPATH=$(OSL_FILEPAIRS_DIRPATH)'
	@echo '    OSL_FILEPAIRS_SET_NAME=$(OSL_FILEPAIRS_SET_NAME)'
	@echo

_ssl_view_framework_targets ::
	@echo 'OpenSSL::FilePair ($(_OPENSSL_FILEPAIR_MK_VERSION)) targets:'
	@echo '    _ssl_decrypt_file                        - Decrypt an encrypted file'
	@echo '    _ssl_encrypt_file                        - Encrypt a file with SSL'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS 
#

_ssl_decrypt_file:
	@$(INFO) '$(OSL_UI_LABEL)Decrypt file "$(OSL_FILEPAIR_NAME)" ...'; $(NORMAL)
	$(OPENSSL) -d -in $(OSL_FILEPAIR_ENCRYPTED_FILEPATH) -out $(OSL_FILEPAIR_DECRYPTED_FILEPATH) 

_ssl_encrypt_file:
	@$(INFO) '$(OSL_UI_LABEL)Encrypt file "$(OSL_FILEPAIR_NAME)" ...'; $(NORMAL)
	$(OPENSSL) -e -in $(OSL_FILEPAIR_DECRYPTED_FILEPATH) -out $(OSL_FILEPAIR_ENCRYPTED_FILEPATH) 
