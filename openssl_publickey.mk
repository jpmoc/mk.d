_OPENSSL_PUBLICKEY_MK_VERSION= $(_OPENSSL_MK_VERSION)

# OSL_PUBLICKEY_DIRPATH?= ./in/
# OSL_PUBLICKEY_FILENAME?= publickey.pub
# OSL_PUBLICKEY_FILEPATH?= ./in/publickey.pub
# OSL_PUBLICKEY_NAME?= my-public-key
# OSL_PUBLICKEY_PRIVATEKEY_FILENAME?= ./in/private-key.pem
# OSL_PUBLICKEYS_DIRPATH?= ./in/
OSL_PUBLICKEYS_REGEX?= *
# OSL_PUBLICKEYS_SET_NAME?= my-set

# Derived parameters
OSL_PUBLICKEY_DIRPATH?= $(OSL_OUTPUTS_DIRPATH)
OSL_PUBLICKEY_FILEPATH?= $(OSL_PUBLICKEY_DIRPATH)$(OSL_PUBLICKEY_FILENAME)
OSL_PUBLICKEY_NAME?=$(patsubst %.pub,%,$(OSL_PUBLICKEY_FILENAME))
OSL_PUBLICKEY_PRIVATEKEY_FILEPATH?= $(OSL_PRIVATEKEY_FILEPATH)
OSL_PUBLICKEYS_DIRPATH?= $(OSL_PUBLICKEY_DIRPATH)
OSL_PUBLICKEYS_SET_NAME?= public-keys@$(OSL_PUBLICKEYS_REGEX)@$(OSL_PUBLICKEYS_DIRPATH)

# Options
__OSL_IN__PUBLICKEY?= $(if $(OSL_PUBLICKEY_PRIVATEKEY_FILEPATH),-in $(OSL_PUBLICKEY_PRIVATEKEY_FILEPATH))
__OSL_OUT__PUBLICKEY?= $(if $(OSL_PUBLICKEY_FILEPATH),-out $(OSL_PUBLICKEY_FILEPATH))

# Customizations
|_OSL_SHOW_PUBLICKEY_CONTENT?= | head -5; echo '...'
|_OSL_SHOW_PUBLICKEY_MODULUS?= | sed 's/^Modulus=//'

# Macros
_osl_get_publickey_modulus= $(call _osl_get_publickey_modulus_F, $(OSL_PUBLICKEY_FILEPATH))
_osl_get_publickey_modulus_F= $(shell $(OPENSSL) rsa -in $(1) -modulus -noout -pubin | sed 's/^Modulus=//')

#----------------------------------------------------------------------
# INTERFACE
#

_osl_list_macros ::
	@echo 'OpenSSL::PublicKey ($(_OPENSSL_PUBLICKEY_MK_VERSION)) macros:'
	@echo '    _osl_get_publickey_modulus_{|F}           - Get the modulus of a public-key (Filepath)'
	@echo

_osl_list_parameters :: 
	@echo 'OpenSSL::PublicKey ($(_OPENSSL_PUBLICKEY_MK_VERSION)) parameters:'
	@echo '    OSL_PUBLICKEY_DIRPATH=$(OSL_PUBLICKEY_DIRPATH)'
	@echo '    OSL_PUBLICKEY_FILENAME=$(OSL_PUBLICKEY_FILENAME)'
	@echo '    OSL_PUBLICKEY_FILEPATH=$(OSL_PUBLICKEY_FILEPATH)'
	@echo '    OSL_PUBLICKEY_MODULUS=$(OSL_PUBLICKEY_MODULUS)'
	@echo '    OSL_PUBLICKEY_NAME=$(OSL_PUBLICKEY_NAME)'
	@echo '    OSL_PUBLICKEY_PRIVATEKEY_FILEPATH=$(OSL_PUBLICKEY_PRIVATEKEY_FILEPATH)'
	@echo '    OSL_PUBLICKEYS_DIRPATH=$(OSL_PUBLICKEYS_DIRPATH)'
	@echo '    OSL_PUBLICKEYS_REGEX=$(OSL_PUBLICKEYS_REGEX)'
	@echo '    OSL_PUBLICKEYS_SET_NAME=$(OSL_PUBLICKEYS_SET_NAME)'
	@echo

_osl_list_targets ::
	@echo 'OpenSSL::PublicKey ($(_OPENSSL_PUBLICKEY_MK_VERSION)) targets:'
	@echo '    _osl_check_publickey                     - Check everything about a public-key'
	@echo '    _osl_check_publickey_modulus             - Check modulus of a public-key'
	@echo '    _osl_create_publickey                    - Create a public-key'
	@echo '    _osl_delete_publickey                    - Delete a public-key'
	@echo '    _osl_list_publickeys                     - List a public-keys'
	@echo '    _osl_list_publickeys_set                 - List a set of public-keys'
	@echo '    _osl_show_publickey                      - Show everything related to a public-key'
	@echo '    _osl_show_publickey_content              - Show content of a public-key'
	@echo '    _osl_show_publickey_description          - Show description of a public-key'
	@echo '    _osl_show_publickey_modulus              - Show modulus of a public-key'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS 
#

#----------------------------------------------------------------------
# PUBLIC TARGETS 
#

_osl_check_publickey: _osl_check_publickey_modulus

_osl_check_publickey_modulus: _osl_show_privatekey_modulus _osl_show_publickey_modulus

_osl_create_publickey:
	@$(INFO) '$(OSL_UI_LABEL)Creating a public-key "$(OSL_PUBLICKEY_NAME)" ...'; $(NORMAL)
	$(OPENSSL) rsa $(__OSL_IN__PUBLICKEY) $(__OSL_OUT__PUBLICKEY) -pubout
	@echo 'Generated public-key file: $(OSL_PUBLICKEY_FILEPATH)'; $(NORMAL)

_osl_delete_publickey:
	@$(INFO) '$(OSL_UI_LABEL)Creating a public-key "$(OSL_PUBLICKEY_NAME)" ...'; $(NORMAL)

_osl_show_publickey: _osl_show_publickey_content _osl_show_publickey_modulus _osl_show_publickey_description

_osl_show_publickey_content:
	@$(INFO) '$(OSL_UI_LABEL)Showing content of public-key "$(OSL_PUBLICKEY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a BEGIN-PUBLIC-KEY file'; $(NORMAL)
	cat $(OSL_PUBLICKEY_FILEPATH) $(|_OSL_SHOW_PUBLICKEY_CONTENT)

_osl_show_publickey_description:
	@$(INFO) '$(OSL_UI_LABEL)Showing description of public-key "$(OSL_PUBLICKEY_NAME)" ...'; $(NORMAL)
	ls -al $(OSL_PUBLICKEY_FILEPATH)

_osl_show_publickey_modulus:
	@$(INFO) '$(OSL_UI_LABEL)Showing modulus of public-key "$(OSL_PUBLICKEY_NAME)" ...'; $(NORMAL)
	$(OPENSSL) rsa -in $(OSL_PUBLICKEY_FILEPATH) -modulus -noout -pubin $(|_OSL_SHOW_PUBLICKEY_MODULUS)

_osl_list_publickeys:
	@$(INFO) '$(OSL_UI_LABEL)Listing ALL public-keys ...'; $(NORMAL)
	ls -la $(OSL_PUBLICKEYS_DIRPATH)*

_osl_list_publickeys_set:
	@$(INFO) '$(OSL_UI_LABEL)Listing public-keys-set "$(OSL_PUBLICKEYS_SET_NAME)" ...'; $(NORMAL)
	ls -la $(OSL_PUBLICKEYS_DIRPATH)$(OSL_PUBLICKEYS_REGEX)
