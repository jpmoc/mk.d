_OPENSSL_PRIVATEKEY_MK_VERSION= $(_OPENSSL_MK_VERSION)

# OSL_PRIVATEKEY_CIPHER_ALGORITHM?= aes256
# OSL_PRIVATEKEY_DIRPATH?= ./in/
# OSL_PRIVATEKEY_ENCRYPTION_TYPE?= aes256
# OSL_PRIVATEKEY_FILENAME?= privatekey.pem
# OSL_PRIVATEKEY_FILEPATH?= ./in/privatekey.pem
OSL_PRIVATEKEY_FORMAT?= PEM
# OSL_PRIVATEKEY_NAME?= my-privatekey
# OSL_PRIVATEKEY_PASSPHRASE?=  pass:my-passphrase
# OSL_PRIVATEKEY_PASSPHRASE_FILEPATH?= ./passphrase.txt 
# OSL_PRIVATEKEY_PASSPHRASE_STRING?= my-passphrase 
OSL_PRIVATEKEY_SIZE?= 4096
# OSL_PRIVATEKEYS_DIRPATH?= ./in/
# OSL_PRIVATEKEYS_REGEX?= *
# OSL_PRIVATEKEYS_SET_NAME?= private-keys@dir

# Derived parameters
OSL_PRIVATEKEY_DIRPATH?= $(OSL_OUTPUTS_DIRPATH)
OSL_PRIVATEKEY_FILEPATH?= $(OSL_PRIVATEKEY_DIRPATH)$(OSL_PRIVATEKEY_FILENAME)
OSL_PRIVATEKEY_NAME?= $(patsubst %.pem,%,$(OSL_PRIVATEKEY_FILENAME))
OSL_PRIVATEKEY_PASSPHRASE?= $(if $(OSL_PRIVATEKEY_PASSPHRASE_FILEPATH),file:$(OSL_PRIVATEKEY_PASSPHRASE_FILEPATH))$(if $(OSL_PRIVATEKEY_PASSPHRASE_STRING),pass:$(OSL_PRIVATEKEY_PASSPHRASE_STRING))
OSL_PRIVATEKEYS_DIRPATH?= $(OSL_PRIVATEKEY_DIRPATH)

# Option parameters
__OSL_AES128= $(if $(filter aes128, $(OSL_PRIVATEKEY_CIPHER_ALGORITHM)),-aes128)
__OSL_AES256= $(if $(filter aes256, $(OSL_PRIVATEKEY_CIPHER_ALGORITHM)),-aes256)
__OSL_IN__PRIVATEKEY= $(if $(OSL_PRIVATEKEY_FILEPATH),-in $(OSL_PRIVATEKEY_FILEPATH))
__OSL_OUT__PRIVATEKEY= $(if $(OSL_PRIVATEKEY_FILEPATH),-out $(OSL_PRIVATEKEY_FILEPATH))
__OSL_PASSIN__PRIVATEKEY= $(if $(OSL_PRIVATEKEY_PASSPHRASE),-passin $(OSL_PRIVATEKEY_PASSPHRASE))
__OSL_PASSOUT__PRIVATEKEY= $(if $(OSL_PRIVATEKEY_PASSPHRASE),-passout pass:$(OSL_PRIVATEKEY_PASSPHRASE))

#--- Utilities

|_OSL_CHECK_PRIVATEKEY_INTEGRITY?= | head -1; echo '...'
|_OSL_SHOW_PRIVATEKEY_COMPONENTS?= | head -5; echo '...'
|_OSL_SHOW_PRIVATEKEY_MODULUS?= | sed 's/^Modulus=//'
|_OSL_SHOW_PRIVATEKEY_RAWCONTENT?= | head -5; echo '...'

#--- MACROS

_osl_get_privatekey_modulus= $(call _osl_get_privatekey_modulus_F, $(OSL_PRIVATEKEY_FILEPATH))
_osl_get_privatekey_modulus_F= $(call _osl_get_privatekey_modulus_FP, $(1), $(OSL_PRIVATEKEY_PASSPHRASE))
_osl_get_privatekey_modulus_FP= $(shell openssl rsa -modulus -noout -in $(1) -passin $(2) | sed 's/Modulus=//')

#----------------------------------------------------------------------
# INTERFACE
#

_ssl_list_macros ::
	@echo 'OpenSSL::PrivateKey ($(_OPENSSL_PRIVATEKEY_MK_VERSION)) parameters:'
	@echo '    _osl_get_privatekey_modulus_{|F|FP}                - Get modulus of private-key (Filepath,Passphrase)'
	@echo

_osl_list_parameters ::
	@echo 'OpenSSL::PrivateKey ($(_OPENSSL_PRIVATEKEY_MK_VERSION)) parameters:'
	@echo '    OSL_PRIVATEKEY_CIPHER_ALGORITHM=$(OSL_PRIVATEKEY_CIPHER_ALGORITHM)'
	@echo '    OSL_PRIVATEKEY_DIRPATH=$(OSL_PRIVATEKEY_DIRPATH)'
	@echo '    OSL_PRIVATEKEY_FILENAME=$(OSL_PRIVATEKEY_FILENAME)'
	@echo '    OSL_PRIVATEKEY_FILEPATH=$(OSL_PRIVATEKEY_FILEPATH)'
	@echo '    OSL_PRIVATEKEY_FORMAT=$(OSL_PRIVATEKEY_FORMAT)'  # Exported to CSR
	@echo '    OSL_PRIVATEKEY_MODULUS=$(OSL_PRIVATEKEY_MODULUS)'
	@echo '    OSL_PRIVATEKEY_NAME=$(OSL_PRIVATEKEY_NAME)'
	@echo '    OSL_PRIVATEKEY_PASSPHRASE=$(OSL_PRIVATEKEY_PASSPHRASE)'
	@echo '    OSL_PRIVATEKEY_PASSPHRASE_FILEPATH=$(OSL_PRIVATEKEY_PASSPHRASE_FILEPATH)'
	@echo '    OSL_PRIVATEKEY_PASSPHRASE_STRING=$(OSL_PRIVATEKEY_PASSPHRASE_STRING)'
	@echo '    OSL_PRIVATEKEY_SIZE=$(OSL_PRIVATEKEY_SIZE)'
	@echo '    OSL_PRIVATEKEYS_DIRPATH=$(OSL_PRIVATEKEYS_DIRPATH)'
	@echo '    OSL_PRIVATEKEYS_REGEX=$(OSL_PRIVATEKEYS_REGEX)'
	@echo '    OSL_PRIVATEKEYS_SET_NAME=$(OSL_PRIVATEKEYS_SET_NAME)'
	@echo

_osl_list_targets ::
	@echo 'OpenSSL::PrivateKey ($(_OPENSSL_PRIVATEKEY_MK_VERSION)) targets:'
	@echo '    _osl_check_privatekey                   - Check everything related to a private-key'
	@echo '    _osl_check_privatekey_integrity         - Check integrity of a private-key'
	@echo '    _osl_check_privatekey_modulus           - Check modulus of a private-key'
	@echo '    _osl_create_privatekey                  - Create a private-key'
	@echo '    _osl_delete_privatekey                  - Delete a private-key'
	@echo '    _osl_list_privatekeys                   - List all private-keys'
	@echo '    _osl_list_privatekeys_set               - List a set of private-keys'
	@echo '    _osl_show_privatekey                    - Show everything related to a private-key'
	@echo '    _osl_show_privatekey_components         - Show components of a private-key'
	@echo '    _osl_show_privatekey_content            - Show content of a private-key'
	@echo '    _osl_show_privatekey_description        - Show description of a private-key'
	@echo '    _osl_show_privatekey_modulus            - Show modulus of a private-key'
	@echo '    _osl_update_privatekey                  - Update a private-key'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS 
#

#----------------------------------------------------------------------
# PUBLIC TARGETS 
#

_osl_check_privatekey: _osl_check_privatekey_integrity _osl_check_privatekey_modulus

_osl_check_privatekey_integrity:
	@$(INFO) '$(OSL_UI_LABEL)Checking integrity of private-key "$(OSL_PRIVATEKEY_NAME)" ...'; $(NORMAL)
	$(OPENSSL) rsa $(__OSL_IN__PRIVATEKEY) -check $(|_OSL_CHECK_PRIVATEKEY_INTEGRITY)

_osl_check_privatekey_modulus: _osl_show_privatekey_modulus

_osl_create_privatekey:
	@$(INFO) '$(OSL_UI_LABEL)Creating a private-key "$(OSL_PRIVATEKEY_NAME)" ...'; $(NORMAL)
	$(OPENSSL) genrsa $(__OSL_AES128) $(__OSL_AES256) $(__OSL_OUT__PRIVATEKEY) $(__OSL_PASSOUT__PRIVATEKEY) $(OSL_PRIVATEKEY_SIZE)
	@echo 'Generated private-key file: $(OSL_PRIVATEKEY_FILEPATH)'; $(NORMAL)

_osl_delete_privatekey:
	@$(INFO) '$(OSL_UI_LABEL)Deleting private-key "$(OSL_PRIVATEKEY_NAME)" ...'; $(NORMAL)
	rm -rf $(OSL_PRIVATEKEY_FILEPATH)

_osl_list_privatekeys:
	@$(INFO) '$(OSL_UI_LABEL)Listing ALL private-keys ...'; $(NORMAL)
	ls -al $(OSL_PRIVATEKEYS_DIRPATH)*

_osl_list_privatekeys_set:
	@$(INFO) '$(OSL_UI_LABEL)Listing private-keys-set "$(OSL_PRIVATEKEYS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Private-keys are grouped based on the provided regex'; $(NORMAL)
	ls -al $(OSL_PRIVATEKEYS_DIRPATH)$(OSL_PRIVATEKEYS_REGEX)

_OSL_SHOW_PRIVATEKEY_TARGETS?= _osl_show_privatekey_components _osl_show_privatekey_content _osl_show_privatekey_modulus _osl_show_privatekey_description
_osl_show_privatekey: $(_OSL_SHOW_PRIVATEKEY_TARGETS)

_osl_show_privatekey_components:
	@$(INFO) '$(OSL_UI_LABEL)Showing components of private-key "$(OSL_PRIVATEKEY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the modulus, private/publicExponent, prime1/2, exponent1/2, coefficient, among others'; $(NORMAL)
	$(OPENSSL) rsa $(__OSL_IN__PRIVATEKEY) -noout $(__OSL_PASSIN__PRIVATEKEY) -text $(|_OSL_SHOW_PRIVATEKEY_COMPONENTS)

_osl_show_privatekey_content:
	@$(INFO) '$(OSL_UI_LABEL)Showing content of private-key "$(OSL_PRIVATEKEY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a BEGIN-RSA-PRIVATE-KEY file'; $(NORMAL)
	@$(WARN) 'If the key starts with MII, the ASN.1 header, then the key is not encrypted (no passphrase)'; $(NORMAL)
	cat $(OSL_PRIVATEKEY_FILEPATH) $(|_OSL_SHOW_PRIVATEKEY_RAWCONTENT)

_osl_show_privatekey_description:
	@$(INFO) '$(OSL_UI_LABEL)Showing description of private-key "$(OSL_PRIVATEKEY_NAME)" ...'; $(NORMAL)
	ls -al $(OSL_PRIVATEKEY_FILEPATH)

_osl_show_privatekey_modulus:
	@$(INFO) '$(OSL_UI_LABEL)Showing modulus of private-key "$(OSL_PRIVATEKEY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The returned key-modulus matches the modulus of all certificates built with that key'; $(NORMAL)
	$(OPENSSL) rsa $(__OSL_IN__PRIVATEKEY) -modulus -noout $(__OSL_PASSIN__PRIVATEKEY) $(|_OSL_SHOW_PRIVATEKEY_MODULUS)

_osl_update_privatekey:
	@$(INFO) '$(OSL_UI_LABEL)Update private-key "$(OSL_PRIVATEKEY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation can change the format of the private-key, remove/add a passphrase, etc'; $(NORMAL)
	@$(WARN) 'This operation fails if the input file is the same as the output file'; $(NORMAL)
	# Remove passphrase: $(OPENSSL) rsa $(__OSL_IN__PRIVATEKEY) $(__OSL_OUT__PRIVATEKEY) $(__OSL_PASSIN__PRIVATEKEY)
	# Add a passphrase:  $(OPENSSL) rsa $(__OSL_IN__PRIVATEKEY) $(__OSL_OUT__PRIVATEKEY) $(__OSL_PASSOUT__PRIVATEKEY)
