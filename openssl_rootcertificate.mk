_OPENSSL_ROOTCERTIFICATE_MK_VERSION= $(_OPENSSL_MK_VERSION)

OSL_ROOTCERTIFICATE_CONFIG_DIRPATH?= /etc/ssl/
OSL_ROOTCERTIFICATE_CONFIG_FILENAME?= openssl.cnf
# OSL_ROOTCERTIFICATE_CONFIG_FILEPATH?= /etc/ssl/openssl.cnf
OSL_ROOTCERTIFICATE_DES_FLAG?= true
# OSL_ROOTCERTIFICATE_DIRPATH?= ./in/
# OSL_ROOTCERTIFICATE_EXTENSIONS_NAME?= v3_ca
OSL_ROOTCERTIFICATE_FILENAME?= root.crt
# OSL_ROOTCERTIFICATE_FILEPATH?= ./out/root.crt
OSL_ROOTCERTIFICATE_GENERATEPRIVATEKEY_FLAG?= true
# OSL_ROOTCERTIFICATE_MODULUS?=
# OSL_ROOTCERTIFICATE_NAME?= root
# OSL_ROOTCERTIFICATE_PRIVATEKEY_DIRPATH?= ./out/
OSL_ROOTCERTIFICATE_PRIVATEKEY_FILENAME?= root.pem
# OSL_ROOTCERTIFICATE_PRIVATEKEY_FILEPATH?= ./out/root.pem
# OSL_ROOTCERTIFICATE_SERIAL?= 0xbfbc015b6bb7912e
OSL_ROOTCERTIFICATE_SHA256_FLAG?= true
OSL_ROOTCERTIFICATE_TTL_DAYS?= 30
# OSL_ROOTCERTIFICATES_DIRPATH?=
OSL_ROOTCERTIFICATES_REGEX?= *root.crt
# OSL_ROOTCERTIFICATES_SET_NAME?=

# Derived parameters
OSL_ROOTCERTIFICATE_CONFIG_DIRPATH?= $(OSL_OUTPUTS_DIRPATH)
OSL_ROOTCERTIFICATE_CONFIG_FILEPATH?= $(if $(OSL_ROOTCERTIFICATE_CONFIG_FILENAME),$(OSL_ROOTCERTIFICATE_CONFIG_DIRPATH)$(OSL_ROOTCERTIFICATE_CONFIG_FILENAME))
OSL_ROOTCERTIFICATE_DIRPATH?= $(OSL_OUTPUTS_DIRPATH)
OSL_ROOTCERTIFICATE_FILEPATH?= $(OSL_ROOTCERTIFICATE_DIRPATH)$(OSL_ROOTCERTIFICATE_FILENAME)
OSL_ROOTCERTIFICATE_NAME?= $(patsubst %.crt,%,$(OSL_ROOTCERTIFICATE_FILENAME))
OSL_ROOTCERTIFICATE_PRIVATEKEY_DIRPATH?= $(OSL_OUTPUTS_DIRPATH)
OSL_ROOTCERTIFICATE_PRIVATEKEY_FILEPATH?= $(if $(OSL_ROOTCERTIFICATE_PRIVATEKEY_FILENAME),$(OSL_ROOTCERTIFICATE_PRIVATEKEY_DIRPATH)$(OSL_ROOTCERTIFICATE_PRIVATEKEY_FILENAME))
OSL_ROOTCERTIFICATES_DIRPATH?= $(OSL_ROOTCERTIFICATE_DIRPATH)
OSL_ROOTCERTIFICATES_SET_NAME?= root-certificates@$(OSL_ROOTCERTIFICATES_REGEX)

# Options
# __OSL_CA= $(if $(OSL_CA_CERT_FILEPATH), -CA $(OSL_CA_CERT_FILEPATH))
__OSL_CAFILE__ROOTCERTIFICATE= $(if $(OSL_ROOTCERTIFICATE_FILEPATH),-CAfile $(OSL_ROOTCERTIFICATE_FILEPATH))
# __OSL_CAKEY= $(if $(OSL_CA_KEY_FILEPATH), -CAkey $(OSL_CA_KEY_FILEPATH))
__OSL_CONFIG__ROOTCERTIFICATE= $(if $(OSL_ROOTCERTIFICATE_CONFIG_FILEPATH),-config $(OSL_ROOTCERTIFICATE_CONFIG_FILEPATH))
# __OSL_CREATE_SERIAL__ROOTCERTIFICATE= $(if $(OSL_CERTIFICATE_SERIAL),,-create_serial)
__OSL_DAYS__ROOTCERTIFICATE= $(if $(OSL_ROOTCERTIFICATE_TTL_DAYS),-days $(OSL_ROOTCERTIFICATE_TTL_DAYS))
__OSL_EXTENSIONS__ROOTCERTIFICATE= $(if $(OSL_ROOTCERTIFICATE_EXTENSIONS_NAME),-extensions $(OSL_ROOTCERTIFICATE_EXTENSIONS_NAME))
__OSL_IN__ROOTCERTIFICATE= $(if $(OSL_ROOTCERTIFICATE_FILEPATH),-in $(OSL_ROOTCERTIFICATE_FILEPATH))
__OSL_KEYOUT__ROOTCERTIFICATE= $(if $(OSL_ROOTCERTIFICATE_PRIVATEKEY_FILEPATH),-keyout $(OSL_ROOTCERTIFICATE_PRIVATEKEY_FILEPATH))
__OSL_NEWKEY__ROOTCERTIFICATE= $(if $(filter true,$(OSL_ROOTCERTIFICATE_GENERATEPRIVATEKEY_FLAG)),-newkey rsa:4096)
__OSL_NODES__ROOTCERTIFICATE= $(if $(filter false,$(OSL_ROOTCERTIFICATE_DES_FLAG)),-nodes)
__OSL_OUT__ROOTCERTIFICATE= $(if $(OSL_ROOTCERTIFICATE_FILEPATH),-out $(OSL_ROOTCERTIFICATE_FILEPATH))
__OSL_RAND=
__OSL_SET_SERIAL__ROOTCERTIFICATE= $(if $(OSL_ROOTCERTIFICATE_SERIAL),-set_serial $(OSL_ROOTCERTIFICATE_SERIAL))
__OSL_SHA256__ROOTCERTIFICATE= $(if $(filter false,$(OSL_ROOTCERTIFICATE_SHA256_FLAG)),-sha256)
## __OSL_SIGNKEY= $(if $(OSL_ROOTCERTIFICATE_CAKEY_FILEPATH),-signkey $(OSL_ROOTCERTIFICATE_CAKEY_FILEPATH))
__OSL_SUBJ__ROOTCERTIFICATE= $(if $(OSL_ROOTCERTIFICATE_SUBJECT),-subj $(OSL_ROOTCERTIFICATE_SUBJECT))

# Customizations
|_OSL_CHECK_ROOTCERTIFICATE_MODULUS?= | sed 's/^Modulus=//'
_OSL_CREATE_ROOTCERTIFICATE_|?= touch ~/.rnd &&# 
|_OSL_SHOW_ROOTCERTIFICATE_CONFIG?= | head -5; echo '...'
|_OSL_SHOW_ROOTCERTIFICATE_ENDCODEDCONTENT?= | head -5; echo '...'
|_OSL_SHOW_ROOTCERTIFICATE_MODULUS?= | sed 's/^Modulus=//'

# Macros
_osl_get_rootcertificate_modulus= $(call _osl_get_rootcertificate_modulus_F, $(OSL_ROOTCERTIFICATE_FILEPATH))
_osl_get_rootcertificate_modulus_F= $(shell openssl x509 -modulus -noout -in $(1) | sed 's/^Modulus=//')

#----------------------------------------------------------------------
# INTERFACE
#

_osl_list_macros ::
	@echo 'OpenSSL::RootCertificate ($(_OPENSSL_ROOTCERTIFICATE_MK_VERSION)) macros:'
	@echo '    _osl_get_rootcertificate_modulus_{|F}               - Get modulus of a root-certificate'
	@echo

_osl_list_parameters ::
	@echo 'OpenSSL::RootCertificate ($(_OPENSSL_ROOTCERTIFICATE_MK_VERSION)) parameters:'
	@echo '    OSL_ROOTCERTIFICATE_CONFIG_DIRPATH=$(OSL_ROOTCERTIFICATE_CONFIG_DIRPATH)'
	@echo '    OSL_ROOTCERTIFICATE_CONFIG_FILENAME=$(OSL_ROOTCERTIFICATE_CONFIG_FILENAME)'
	@echo '    OSL_ROOTCERTIFICATE_CONFIG_FILEPATH=$(OSL_ROOTCERTIFICATE_CONFIG_FILEPATH)'
	@echo '    OSL_ROOTCERTIFICATE_DES_FLAG=$(OSL_ROOTCERTIFICATE_DES_FLAG)'
	@echo '    OSL_ROOTCERTIFICATE_DIRPATH=$(OSL_ROOTCERTIFICATE_DIRPATH)'
	@echo '    OSL_ROOTCERTIFICATE_FILENAME=$(OSL_ROOTCERTIFICATE_FILENAME)'
	@echo '    OSL_ROOTCERTIFICATE_FILEPATH=$(OSL_ROOTCERTIFICATE_FILEPATH)'
	@echo '    OSL_ROOTCERTIFICATE_GENERATEPRIVATEKEY_FLAG=$(OSL_ROOTCERTIFICATE_GENERATEPRIVATEKEY_FLAG)'
	@echo '    OSL_ROOTCERTIFICATE_MODULUS=$(OSL_ROOTCERTIFICATE_MODULUS)'
	@echo '    OSL_ROOTCERTIFICATE_NAME=$(OSL_ROOTCERTIFICATE_NAME)'
	@echo '    OSL_ROOTCERTIFICATE_SERIAL=$(OSL_ROOTCERTIFICATE_SERIAL)'
	@echo '    OSL_ROOTCERTIFICATE_SHA256_FLAG=$(OSL_ROOTCERTIFICATE_SHA256_FLAG)'
	@echo '    OSL_ROOTCERTIFICATE_SUBJECT=$(OSL_ROOTCERTIFICATE_SUBJECT)'
	@echo '    OSL_ROOTCERTIFICATE_TTL_DAYS=$(OSL_ROOTCERTIFICATE_TTL_DAYS)'
	@echo '    OSL_ROOTCERTIFICATES_DIRPATH=$(OSL_ROOTCERTIFICATES_DIRPATH)'
	@echo '    OSL_ROOTCERTIFICATES_REGEX=$(OSL_ROOTCERTIFICATES_REGEX)'
	@echo '    OSL_ROOTCERTIFICATES_SET_NAME=$(OSL_ROOTCERTIFICATES_SET_NAME)'
	@echo

_osl_list_targets ::
	@echo 'OpenSSL::RootCertificate ($(_OPENSSL_MK_VERSION)) targets:'
	@echo '    _osl_check_rootcertificate                   - Check everything about a root-certificate'
	@echo '    _osl_check_rootcertificate_integrity         - Check integrity of a root-certificate'
	@echo '    _osl_check_rootcertificate_modulus           - Check modulus of a root-certificate'
	@echo '    _osl_create_rootcertificate                  - Create a root-certificate'
	@echo '    _osl_delete_rootcertificate                  - Delete a root-certificate'
	@echo '    _osl_list_rootcertificates                   - List all root-certificates'
	@echo '    _osl_list_rootcertificates_set               - List a set of root-certificates'
	@echo '    _osl_show_rootcertificate                    - Show everything related to a root-certificate'
	@echo '    _osl_show_rootcertificate_config             - Show config of a root-certificate'
	@echo '    _osl_show_rootcertificate_content            - Show content of a root-certificate'
	@echo '    _osl_show_rootcertificate_decodedcontent     - Show decoded-content of a root-certificate'
	@echo '    _osl_show_rootcertificate_description        - Show description of a root-certificate'
	@echo '    _osl_show_rootcertificate_encodedcontent     - Show encoded-content of a root-certificate'
	@echo '    _osl_show_rootcertificate_modulus            - Show modulus of a root-certificate'
	@echo '    _osl_show_rootcertificate_publickey          - Show public-key embedded in a root-certificate'
	@echo


#----------------------------------------------------------------------
# PRIVATE TARGETS 
#

#----------------------------------------------------------------------
# PUBLIC TARGETS 
#

_osl_check_rootcertificate: _osl_check_rootcertificate_integrity _osl_check_rootcertificate_modulus

_osl_check_rootcertificate_integrity:
	@$(INFO) '$(OSL_UI_LABEL)Checking integrity of root-certificate "$(OSL_ROOTCERTIFICATE_NAME)" ...'; $(NORMAL)
	$(OPENSSL) verify $(__OSL_CAFILE__ROOTCERTIFICATE) $(OSL_ROOTCERTIFICATE_FILEPATH)

_osl_check_rootcertificate_modulus:
	@$(INFO) '$(OSL_UI_LABEL)Checking modulus of root-certificate "$(OSL_ROOTCERTIFICATE_NAME)" ...'; $(NORMAL)
	$(OPENSSL) x509 $(__OSL_IN__ROOTCERTIFICATE) -modulus -noout -text $(|_OSL_CHECK_ROOTCERTIFICATE_MODULUS)

_osl_create_rootcertificate:
	@$(INFO) '$(OSL_UI_LABEL)Creating root-certificate "$(OSL_ROOTCERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a root, self-signed certificate'; $(NORMAL)
	$(if $(OSL_ROOTCERTIFICATE_CONFIG_FILEPATH), cat $(OSL_ROOTCERTIFICATE_CONFIG_FILEPATH); echo)
	$(OPENSSL) req $(__OSL_CONFIG__ROOTCERTIFICATE) $(__OSL_DAYS__ROOTCERTIFICATE) $(__OSL_EXTENSIONS__ROOTCERTIFICATE) $(__OSL_KEYOUT__ROOTCERTIFICATE) -new $(__OSL_NEWKEY__ROOTCERTIFICATE) $(__OSL_NODES__ROOTCERTIFICATE) $(__OSL_OUT__ROOTCERTIFICATE) $(__OSL_SET_SERIAL__ROOTCERTIFICAE) $(__OSL_SHA256__ROOTCERTIFICATE) $(__OSL_SUBJ__ROOTCERTIFICATE) -x509
	@echo 'Generated root-certificate: $(OSL_ROOTCERTIFICATE_FILEPATH)'; $(NORMAL)

_osl_list_rootcertificates:
	@$(INFO) '$(OSL_UI_LABEL)Listing ALL root-certificates ...'; $(NORMAL)
	ls -al $(OSL_CERTIFICATES_DIRPATH)ca.*.crt

_osl_list_rootcertificates_set:
	@$(INFO) '$(OSL_UI_LABEL)Listing root-certificates-set "$(OSL_ROOTCERTIFICATES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Root-certificates are grouped based on the provided directory and regex'; $(NORMAL)
	ls -al $(OSL_ROOTCERTIFICATES_DIRPATH)$(OSL_ROOTCERTIFICATES_REGEX)

_OSL_SHOW_ROOTCERTIFICATE_TARGETS?= _osl_show_rootcertificate_config _osl_show_rootcertificate_content _osl_show_rootcertificate_modulus _osl_show_rootcertificate_publickey _osl_show_rootcertificate_description
_osl_show_rootcertificate: $(_OSL_SHOW_ROOTCERTIFICATE_TARGETS)

_osl_show_rootcertificate_config: 
	@$(INFO) '$(OSL_UI_LABEL)Showing default-config of root-certificate "$(OSL_ROOTCERTIFICATE_NAME)" ...'; $(NORMAL)
	$(if $(OSL_ROOTCERTIFICATE_CONFIG_FILEPATH), \
		cat $(OSL_ROOTCERTIFICATE_CONFIG_FILEPATH) $(|_OSL_SHOW_ROOTCERTIFICATE_CONFIG) \
	, @\
		echo 'OSL_CERTIFICATE_CONFIG_FILEPATH not set' \
	)

_osl_show_rootcertificate_content: _osl_show_rootcertificate_decodedcontent _osl_show_rootcertificate_encodedcontent

_osl_show_rootcertificate_decodedcontent:
	@$(INFO) '$(OSL_UI_LABEL)Showing decoded-content of root-certificate "$(OSL_ROOTCERTIFICATE_NAME)" ...'; $(NORMAL)
	$(OPENSSL) x509 $(__OSL_IN__ROOTCERTIFICATE) -noout -text

_osl_show_rootcertificate_description:
	@$(INFO) '$(OSL_UI_LABEL)Showing description of root-certificate "$(OSL_ROOTCERTIFICATE_NAME)" ...'; $(NORMAL)
	ls -la $(OSL_ROOTCERTIFICATE_FILEPATH)

_osl_show_rootcertificate_encodedcontent:
	@$(INFO) '$(OSL_UI_LABEL)Showing encoded-content of root-certificate "$(OSL_ROOTCERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a BEGIN-CERTIFICATE file'; $(NORMAL)
	cat $(OSL_ROOTCERTIFICATE_FILEPATH) $(|_OSL_SHOW_ROOTCERTIFICATE_ENDCODEDCONTENT)

_osl_show_rootcertificate_modulus:
	@$(INFO) '$(OSL_UI_LABEL)Showing modulus of root-certificate "$(OSL_ROOTCERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the modulus of the embedded public-key'; $(NORMAL)
	$(OPENSSL) x509 $(__OSL_IN__ROOTCERTIFICATE) -modulus -noout $(|_OSL_SHOW_ROOTCERTIFICATE_MODULUS)

_osl_show_rootcertificate_publickey:
	@$(INFO) '$(OSL_UI_LABEL)Showing public-key of root-certificate "$(OSL_ROOTCERTIFICATE_NAME)" ...'; $(NORMAL)
