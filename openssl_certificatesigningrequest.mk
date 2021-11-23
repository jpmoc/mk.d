_OPENSSL_CERTIFICATESIGNINGREQUEST_MK_VERSION= $(_OPENSSL_MK_VERSION)

# OSL_CERTIFICATESIGNINGREQUEST_CERTIFICATE_FILEPATH?= ./out/certificate.crt
# OSL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH?= /etc/openssl.cnf
# OSL_CERTIFICATESIGNINGREQUEST_DIRPATH?= ./in/
# OSL_CERTIFICATESIGNINGREQUEST_FILENAME?= certificate.crt
# OSL_CERTIFICATESIGNINGREQUEST_FILEPATH?= ./out/certificate.crt
# OSL_CERTIFICATESIGNINGREQUEST_MODULUS?=
# OSL_CERTIFICATESIGNINGREQUEST_NAME?= my-certificate-signing-request
OSL_CERTIFICATESIGNINGREQUEST_NEWKEY_FLAG?= false
# OSL_CERTIFICATESIGNINGREQUEST_NEWKEY_FORMAT?= rsa:2048
OSL_CERTIFICATESIGNINGREQUEST_NODES_FLAG?= false
# OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_DIRPATH?= ./in/
# OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILENAME?= file.pem
# OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH?= ./in/file.pem
# OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FORMAT?= PEM
# OSL_CERTIFICATESIGNINGREQUEST_SUBJECT?= /C=US/ST=CA/L=PaloAlto/OU=EUC/O=VMware/CN=bookinfo.com
# OSL_CERTIFICATESIGNINGREQUESTS_DIRPATH?=
OSL_CERTIFICATESIGNINGREQUESTS_REGEX?= *.csr
# OSL_CERTIFICATESIGNINGREQUESTS_SET_NAME?=

# Derived parameters
OSL_CERTIFICATESIGNINGREQUEST_CERTIFICATE_FILEPATH?= $(OSL_CERTIFICATE_FILEPATH)
OSL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH?= $(OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH)
OSL_CERTIFICATESIGNINGREQUEST_DIRPATH?= $(OSL_OUTPUTS_DIRPATH)
OSL_CERTIFICATESIGNINGREQUEST_FILEPATH?= $(if $(OSL_CERTIFICATESIGNINGREQUEST_FILENAME),$(OSL_CERTIFICATESIGNINGREQUEST_DIRPATH)$(OSL_CERTIFICATESIGNINGREQUEST_FILENAME))
OSL_CERTIFICATESIGNINGREQUEST_NAME?= $(patsubst %.csr,%,$(OSL_CERTIFICATESIGNINGREQUEST_FILENAME))
OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_DIRPATH?= $(OSL_INPUTS_DIRPATH)
OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH?= $(if $(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILENAME),$(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_DIRPATH)$(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILENAME),$(OSL_PRIVATEKEY_FILEPATH))
OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FORMAT?= $(OSL_PRIVATEKEY_FORMAT)
OSL_CERTIFICATESIGNINGREQUESTS_DIRPATH?= $(OSL_CERTIFICATESIGNINGREQUEST_DIRPATH)

# Options
__OSL_CONFIG__CERTIFICATESIGNINGREQUEST?= $(if $(OSL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH),-config $(OSL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH))
__OSL_IN__CERTIFICATESIGNINGREQUEST?= $(if $(OSL_CERTIFICATESIGNINGREQUEST_FILEPATH),-in $(OSL_CERTIFICATESIGNINGREQUEST_FILEPATH))
__OSL_KEY__CERTIFICATESIGNINGREQUEST?= $(if $(filter false,$(OSL_CERTIFICATESIGNINGREQUEST_NEWKEY_FLAG)),$(if $(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH),-key $(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH)))
__OSL_KEYFORM__CERTIFICATESIGNINGREQUEST?= $(if $(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FORMAT),-keyform $(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FORMAT))
__OSL_KEYOUT__CERTIFICATESIGNINGREQUEST?= $(if $(filter true, $(OSL_CERTIFICATESIGNINGREQUEST_NEWKEY_FLAG)),$(if $(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH),-keyout $(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH)))
__OSL_NEWKEY__CERTIFICATESIGNINGREQUEST?= $(if $(OSL_CERTIFICATESIGNINGREQUEST_NEWKEY_TYPE),-newkey $(OSL_CERTIFICATESIGNINGREQUEST_NEWKEY_TYPE))
__OSL_NODES__CERTIFICATESIGNINGREQUEST?= $(if $(filter true, $(OSL_CERTIFICATESIGNINGREQUEST_NODES_FLAG)),-nodes)
__OSL_OUT__CERTIFICATESIGNINGREQUEST?= $(if $(OSL_CERTIFICATESIGNINGREQUEST_FILEPATH),-out $(OSL_CERTIFICATESIGNINGREQUEST_FILEPATH))
__OSL_SUBJ__CERTIFICATESIGNINGREQUEST?= $(if $(OSL_CERTIFICATESIGNINGREQUEST_SUBJECT),-subj $(OSL_CERTIFICATESIGNINGREQUEST_SUBJECT))

# Customizations
|_OSL_CHECK_CERTIFICATESIGNINGREQUEST_SIGNATURE?= | head -0
|_OSL_SHOW_CERTIFICATESIGNINGREQUEST_CONFIG?= | head -5; echo '...'
|_OSL_SHOW_CERTIFICATESIGNINGREQUEST_MODULUS?= | sed 's/^Modulus=//'
|_OSL_SHOW_CERTIFICATESIGNINGREQUEST_PRIVATEKEY?= | head -5; echo '...'
|_OSL_SHOW_CERTIFICATESIGNINGREQUEST_PUBLICKEY?= | head -5; echo '...'
|_OSL_SHOW_CERTIFICATESIGNINGREQUEST_RAWCONTENT?= | head -5; echo '...'

# Macros
_osl_get_certificatesigningrequest_modulus= $(call _osl_get_certificatesigningrequest_modulus_F, $(OSL_CERTIFICATESIGNINGREQUEST_FILEPATH))
_osl_get_certificatesigningrequest_modulus_F= $(shell $(OPENSSL) req -in $(1) -modulus -noout | sed 's/^Modulus=//')

#----------------------------------------------------------------------
# INTERFACE
#

_osl_list_macros ::
	@echo 'OpenSSL::CertificateSigningRequest ($(_OPENSSL_CERTIFICATESIGNINGREQUEST_MK_VERSION)) macros:'
	@echo '    _osl_get_certificatesigningrequest_modulus_{|F}     - Get the modulus of a certificate-signing-request (Filepath)'
	@echo

_osl_list_parameters ::
	@echo 'OpenSSL::CertificateSigningRequest ($(_OPENSSL_CERTIFICATESIGNINGREQUEST_MK_VERSION)) parameters:'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_CERTIFICATE_FILEPATH=$(OSL_CERTIFICATESIGNINGREQUEST_CERTIFICATE_FILEPATH)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH=$(OSL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_DIRPATH=$(OSL_CERTIFICATESIGNINGREQUEST_DIRPATH)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_FILENAME=$(OSL_CERTIFICATESIGNINGREQUEST_FILENAME)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_FILEPATH=$(OSL_CERTIFICATESIGNINGREQUEST_FILEPATH)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_MODULUS=$(OSL_CERTIFICATESIGNINGREQUEST_MODULUS)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_NAME=$(OSL_CERTIFICATESIGNINGREQUEST_NAME)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_NEWKEY_FLAG=$(OSL_CERTIFICATESIGNINGREQUEST_NEWKEY_FLAG)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_NEWKEY_TYPE=$(OSL_CERTIFICATESIGNINGREQUEST_NEWKEY_TYPE)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_NODES_FLAG=$(OSL_CERTIFICATESIGNINGREQUEST_NODES_FLAG)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_DIRPATH=$(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_DIRPATH)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILENAME=$(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILENAME)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH=$(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FORMAT=$(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FORMAT)'
	@echo '    OSL_CERTIFICATESIGNINGREQUEST_SUBJECT=$(OSL_CERTIFICATESIGNINGREQUEST_SUBJECT)'
	@echo '    OSL_CERTIFICATESIGNINGREQUESTS_DIRPATH=$(OSL_CERTIFICATESIGNINGREQUESTS_DIRPATH)'
	@echo '    OSL_CERTIFICATESIGNINGREQUESTS_REGEX=$(OSL_CERTIFICATESIGNINGREQUESTS_REGEX)'
	@echo '    OSL_CERTIFICATESIGNINGREQUESTS_SET_NAME=$(OSL_CERTIFICATESIGNINGREQUESTS_SET_NAME)'
	@echo

_osl_list_targets ::
	@echo 'OpenSSL::CertificateSigningRequest ($(_OPENSSL_CERTIFICATESIGNINGREQUEST_MK_VERSION)) targets:'
	@echo '    _osl_approve_certificatesigningrequest             - Approve a certificate-signing-request'
	@echo '    _osl_check_certificatesigningrequest               - Check everything related to a certificate-signing-request'
	@echo '    _osl_check_certificatesigningrequest_modulus       - Check the modulus of a certificate-signing-request'
	@echo '    _osl_create_certificatesigningrequest              - Create a certificate-signing-request'
	@echo '    _osl_delete_certificatesigningrequest              - Delete a certificate-signing-request'
	@echo '    _osl_selfsign_certificatesigningrequest            - Self-sign a certificate-signing-request'
	@echo '    _osl_show_certificatesigningrequest                - Show everything related to a certificate-signing-request'
	@echo '    _osl_show_certificatesigningrequest_config         - Show config of a certificate-signing-request'
	@echo '    _osl_show_certificatesigningrequest_content        - Show content of a certificate-signing-request'
	@echo '    _osl_show_certificatesigningrequest_decodedcontent - Show decoded-content of a certificate-signing-request'
	@echo '    _osl_show_certificatesigningrequest_description    - Show description of a certificate-signing-request'
	@echo '    _osl_show_certificatesigningrequest_encodedcontent - Show endcoded-content of a certificate-signing-request'
	@echo '    _osl_show_certificatesigningrequest_modulus        - Show the modulus of a certificate-signing-request'
	@echo '    _osl_show_certificatesigningrequest_privatekey     - Show the private-key used to generate a certificate-signing-request'
	@echo '    _osl_show_certificatesigningrequest_publickey      - Show the public-key embedded in a certificate-signing-request'
	@echo '    _osl_show_certificatesigningrequest_subject        - Show subject of a certificate-signing-request'
	@echo '    _osl_list_certificatesigningrequests               - List all certificate-signing-requests'
	@echo '    _osl_list_certificatesigningrequests_set           - List a set of certificate-signing-requests'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS 
#

#----------------------------------------------------------------------
# PUBLIC TARGETS 
#

_osl_check_certificatesigningrequest: _osl_check_certificatesigningrequest_modulus _osl_check_certificatesigningrequest_signature

_osl_check_certificatesigningrequest_modulus: _osl_show_privatekey_modulus _osl_show_certificatesigningrequest_modulus

_osl_check_certificatesigningrequest_signature:
	@$(INFO) '$(OSL_UI_LABEL)Checking signature of certificate-signing-request "$(OSL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation check the CSR signature to ascertain the content of the CSR was authored by who you think the author is'; $(NORMAL)
	$(OPENSSL) req -verify $(__OSL_IN__CERTIFICATESIGNINGREQUEST) -text -noout $(|_OSL_CHECK_CERTIFICATESIGNINGREQUEST_SIGNATURE)

_osl_approve_certificatesigningrequest:
	@$(INFO) '$(OSL_UI_LABEL)Approving certificate-signing-request "$(OSL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'Certificate validity: $(OSL_CERT_DAYS) days'; $(NORMAL)
	#$(OPENOSL) x509 -req -CAcreateserial $(__OSL_CA) $(__SSK_CAKEY) $(__OSL_DAYS) $(__OSL_IN_CSR) $(__OSL_OUT_CRT)
	@#$(WARN) 'Generated certificate: $(OSL_CERT_FILEPATH)'; $(NORMAL)

_osl_create_certificatesigningrequest:
	@$(INFO) '$(OSL_UI_LABEL)Creating certificate-signing-request "$(OSL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	@$(if $(OSL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH), cat $(OSL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH))
	@$(if $(filter true, $(OSL_CERTIFICATESIGNINGREQUEST_NODES_FLAG)), echo "-nodes: Do not encrypt the private key")
	@$(WARN) 'Remember to keep the generated private key... private!'; $(NORMAL)
	mkdir -p -v $(OSL_CERTIFICATESIGNINGREQUEST_DIRPATH)
	$(OPENSSL) req -new $(strip $(__OSL_CONFIG__CERTIFICATESIGNINGREQUEST) $(__OSL_KEY__CERTIFICATESIGNINGREQUEST) $(__OSL_KEYFORM__CERTIFICATESIGNINGREQUEST) $(__OSL_KEYOUT__CERTIFICATESIGNINGREQUEST) $(__OSL_NEWKEY__CERTIFICATESIGNINGREQUEST) $(__OSL_NODES__CERTIFICATESIGNINGREQUEST) $(__OSL_OUT__CERTIFICATESIGNINGREQUEST) $(__OSL_SUBJ__CERTIFICATESIGNINGREQUEST) )
	@echo 'Generated certificate-signing-request file: $(OSL_CERTIFICATESIGNINGREQUEST_FILEPATH)'; $(NORMAL)

_osl_selfsign_certificatesigningrequest: _osl_selfsign_certificate

_osl_show_certificatesigningrequest :: _osl_show_certificatesigningrequest_config _osl_show_certificatesigningrequest_content _osl_show_certificatesigningrequest_modulus _osl_show_certificatesigningrequest_privatekey _osl_show_certificatesigningrequest_publickey _osl_show_certificatesigningrequest_subject _osl_show_certificatesigningrequest_description

_osl_show_certificatesigningrequest_config:
	@$(INFO) '$(OSL_UI_LABEL)Showing config of certificate-signing-request '$(OSL_CERTIFICATESIGNINGREQUEST_NAME)' ...'; $(NORMAL)
	@$(WARN) 'This operation returns the default config used to generate CSR'; $(NORMAL)
	$(if $(OSL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH), \
		cat $(OSL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH) $(|_OSL_SHOW_CERTIFICATESIGNINGREQUEST_CONFIG) \
	, @\
		echo 'OSL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH not set' \
	)

_osl_show_certificatesigningrequest_content: _osl_show_certificatesigningrequest_decodedcontent _osl_show_certificatesigningrequest_encodedcontent

_osl_show_certificatesigningrequest_decodedcontent:
	@$(INFO) '$(OSL_UI_LABEL)Showing decoded-content of certificate-signing-request '$(OSL_CERTIFICATESIGNINGREQUEST_NAME)' ...'; $(NORMAL)
	@$(WARN) 'This operation also check the singuature to ascertain the content of the CSR was authored by who you think it is'
	@$(WARN) 'Also note that the public key that will go into the final certificate'; $(NORMAL)
	$(OPENSSL) req $(__OSL_IN__CERTIFICATESIGNINGREQUEST) -noout -text -verify

_osl_show_certificatesigningrequest_description:
	@$(INFO) '$(OSL_UI_LABEL)Showing description of certificate-signing-request '$(OSL_CERTIFICATESIGNINGREQUEST_NAME)' ...'; $(NORMAL)
	ls -al $(OSL_CERTIFICATESIGNINGREQUEST_FILEPATH)

_osl_show_certificatesigningrequest_encodedcontent:
	@$(INFO) '$(OSL_UI_LABEL)Showing encoded-content of certificate-signing-request '$(OSL_CERTIFICATESIGNINGREQUEST_NAME)' ...'; $(NORMAL)
	cat $(OSL_CERTIFICATESIGNINGREQUEST_FILEPATH) $(|_OSL_SHOW_CERTIFICATESIGNINGREQUEST_RAWCONTENT)

_osl_show_certificatesigningrequest_modulus:
	@$(INFO) '$(OSL_UI_LABEL)Showing modulus of certificate-signing-request '$(OSL_CERTIFICATESIGNINGREQUEST_NAME)' ...'; $(NORMAL)
	@$(WARN) 'This operation returns the modulus of the embedded public-key'; $(NORMAL)
	$(OPENSSL) req -in $(OSL_CERTIFICATESIGNINGREQUEST_FILEPATH) -modulus -noout $(|_OSL_SHOW_CERTIFICATESIGNINGREQUEST_MODULUS)

_osl_show_certificatesigningrequest_privatekey:
	@$(INFO) '$(OSL_UI_LABEL)Showing private-key used to generate the certificate-signing-request '$(OSL_CERTIFICATESIGNINGREQUEST_NAME)' ...'; $(NORMAL)
	$(if $(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH), \
	cat $(OSL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH) $(|_OSL_SHOW_CERTIFICATESIGNINGREQUEST_PRIVATEKEY) \
	)

_osl_show_certificatesigningrequest_publickey:
	@$(INFO) '$(OSL_UI_LABEL)Showing public-key embedded in certificate-signing-request '$(OSL_CERTIFICATESIGNINGREQUEST_NAME)' ...'; $(NORMAL)
	@$(WARN) 'This operation returns the same content as the stand-alone BEGIN-PUBLIC-KEY file'; $(NORMAL)
	$(OPENSSL) req -in $(OSL_CERTIFICATESIGNINGREQUEST_FILEPATH) -noout -pubkey $(|_OSL_SHOW_CERTIFICATESIGNINGREQUEST_PUBLICKEY)

_osl_show_certificatesigningrequest_subject:
	@$(INFO) '$(OSL_UI_LABEL)Showing subject of certificate-signing-request '$(OSL_CERTIFICATESIGNINGREQUEST_NAME)' ...'; $(NORMAL)
	@$(WARN) 'Email address        - An email address used to contact your organization'
	@$(WARN) 'Common Name          - The fully qualified domain name of the server, FQDN as entered in the URL of a web browser'
	@$(WARN) 'Organization         - The non-abbreviated legal name of your organization, include suffixes such as Inc, Corp, or LLC'
	@$(WARN) 'Organizational Unit  - The division of your organization handling the certificate'
	@$(WARN) 'City/Locality        - The city where your organization is located'
	@$(WARN) 'State/County/Region  - The non-abbreviated state/region where your organization is located'
	@$(WARN) 'Country              - The two-letter ISO code for the country where your organization is location'; $(NORMAL)
	$(OPENSSL) req $(__OSL_IN__CERTIFICATESIGNINGREQUEST) -noout -subject

_osl_list_certificatesigningrequests:
	@$(INFO) '$(OSL_UI_LABEL)Listing ALL certificate-signing-requests ...'; $(NORMAL)
	ls -al $(OSL_CERTIFICATESIGNINGREQUESTS_DIRPATH)*.csr

_osl_list_certificatesigningrequests_set:
	@$(INFO) '$(OSL_UI_LABEL)Listing certificate-signing-requests-set "$(OSL_CERTIFICATESIGNINGREQUESTS_SET)" ...'; $(NORMAL)
	@$(WARN) 'Certificate-signing-requests are grouped based on the provided directory and regex'; $(NORMAL)
	ls -al $(OSL_CERTIFICATESIGNINGREQUESTS_DIRPATH)$(OSL_CERTIFICATESIGNINGREQUESTS_REGEX)
