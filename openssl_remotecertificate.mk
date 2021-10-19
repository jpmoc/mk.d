_OPENSSL_REMOTECERTIFICATE_MK_VERSION= $(_OPENSSL_MK_VERSION)

# OSL_REMOTECERTIFICATE_CACHAIN_FILEPATH?= ./in/ca_chain.pem
# OSL_REMOTECERTIFICATE_DIRPATH?= ./out/
# OSL_REMOTECERTIFICATE_FILENAME?= remotecertificate.crt
# OSL_REMOTECERTIFICATE_FILEPATH?= ./out/remotecertificate.crt
# OSL_REMOTECERTIFICATE_HOST_NAME?= www.google.com
OSL_REMOTECERTIFICATE_HOST_PORT?= 443
# OSL_REMOTECERTIFICATE_MODULUS?=
# OSL_REMOTECERTIFICATE_NAME?=
# OSL_REMOTECERTIFICATE_SERVERNAME?= my-multihomed-domain

# Derived parameters
OSL_REMOTECERTIFICATE_DIRPATH?= $(OSL_OUTPUTS_DIRPATH)
OSL_REMOTECERTIFICATE_FILENAME?= $(OSL_REMOTECERTIFICATE_HOST_NAME).crt
OSL_REMOTECERTIFICATE_FILEPATH?= $(OSL_REMOTECERTIFICATE_DIRPATH)$(OSL_REMOTECERTIFICATE_FILENAME)
OSL_REMOTECERTIFICATE_NAME?= certificate@$(OSL_REMOTECERTIFICATE_HOST_NAME):$(OSL_REMOTECERTIFICATE_HOST_PORT)

# Option parameters
__OSL_HOST__REMOTECERTIFICATE= $(if $(OSL_REMOTECERTIFICATE_HOST_NAME),-host $(OSL_REMOTECERTIFICATE_HOST_NAME))
__OSL_PORT__REMOTECERTIFICATE= $(if $(OSL_REMOTECERTIFICATE_HOST_PORT),-port $(OSL_REMOTECERTIFICATE_HOST_PORT))
__OSL_SERVERNAME__REMOTECERTIFICATE= $(if $(OSL_REMOTECERTIFICATE_SERVERNAME),-servername $(OSL_REMOTECERTIFICATE_SERVERNAME))

# Pipe parameters
_OSL_DOWNLOAD_REMOTECERTIFICATE_|?= echo quit |
|_OSL_DOWNLOAD_REMOTECERTIFICATE?= | sed -n -e '/BEGIN\ CERTIFICATE/,/END\ CERTIFICATE/p' | tee  $(OSL_REMOTECERTIFICATE_FILEPATH)
|_OSL_SHOW_REMOTECERTIFICATE_ENCODEDCONTENT?= | head -5; echo '...'
|_OSL_SHOW_REMOTECERTIFICATE_MODULUS?= | sed 's/^Modulus=//'

#--- MACROS

_osl_get_remotecertificate_modulus= $(call _osl_get_remotecertificate_modulus_H, $(OSL_REMOTECERTIFICATE_HOSTPORT))
_osl_get_remotecertificate_modulus_F= $(shell XXXX | openssl x509 -modulus -noout | sed 's/^Modulus=//')

#----------------------------------------------------------------------
# INTERFACE
#

_osl_view_framework_macros ::
	@echo 'OpenSSL::RemoteCertificate ($(_OPENSSL_REMOTECERTIFICATE_MK_VERSION)) macros:'
	@echo '    _osl_get_remotecertificate_modulus_{|H}               - Get modulus of a remote-certificate'
	@echo

_osl_view_framework_parameters ::
	@echo 'OpenSSL::RemoteCertificate ($(_OPENSSL_REMOTECERTIFICATE_MK_VERSION)) parameters:'
	@echo '    OSL_REMOTECERTIFICATE_CACHAIN_FILEPATH=$(OSL_REMOTECERTIFICATE_CACHAIN_FILEPATH)'
	@echo '    OSL_REMOTECERTIFICATE_DIRPATH=$(OSL_REMOTECERTIFICATE_DIRPATH)'
	@echo '    OSL_REMOTECERTIFICATE_FILENAME=$(OSL_REMOTECERTIFICATE_FILENAME)'
	@echo '    OSL_REMOTECERTIFICATE_FILEPATH=$(OSL_REMOTECERTIFICATE_FILEPATH)'
	@echo '    OSL_REMOTECERTIFICATE_HOST_NAME=$(OSL_REMOTECERTIFICATE_HOST_NAME)'
	@echo '    OSL_REMOTECERTIFICATE_HOST_PORT=$(OSL_REMOTECERTIFICATE_HOST_PORT)'
	@echo '    OSL_REMOTECERTIFICATE_MODULUS=$(OSL_REMOTECERTIFICATE_MODULUS)'
	@echo '    OSL_REMOTECERTIFICATE_NAME=$(OSL_REMOTECERTIFICATE_NAME)'
	@echo '    OSL_REMOTECERTIFICATE_SRVERNAME=$(OSL_REMOTECERTIFICATE_SERVERNAME)'
	@echo

_osl_view_framework_targets ::
	@echo 'OpenSSL::RemoteCertificate ($(_OPENSSL_REMOTECERTIFICATE_MK_VERSION)) targets:'
	@echo '    _osl_check_remotecertificate                   - Check everything about a remote-certificate'
	@echo '    _osl_check_remotecertificate_tustchain         - Check the trust-chain of a remote-certificate'
	@echo '    _osl_check_remotecertificate_modulus           - Check the modulus of a remote-certificate'
	@echo '    _osl_download_remotecertificate                - Download a remote-certificate'
	@echo '    _osl_show_remotecertificate                    - Show everything related to a remote-certificate'
	@echo '    _osl_show_remotecertificate_cachain            - Show CA-chain of a remote-certificate'
	@echo '    _osl_show_remotecertificate_content            - Show content of a remote-certificate'
	@echo '    _osl_show_remotecertificate_decodedcontent     - Show decoded-content of a remote-certificate'
	@echo '    _osl_show_remotecertificate_description        - Show description of a remote-certificate'
	@echo '    _osl_show_remotecertificate_encodedcontent     - Show encoded-content of a remote-certificate'
	@echo '    _osl_show_remotecertificate_modulus            - Show modulus of a remote-certificate'
	@echo '    _osl_show_remotecertificate_publickey          - Show public-key embedded in a remote-certificate'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS 
#

#----------------------------------------------------------------------
# PUBLIC TARGETS 
#

_osl_check_remotecertificate: _osl_check_remotecertificate_chain _osl_check_remotecertificate_modulus

_osl_check_remotecertificate_chain:
	@$(INFO) '$(OSL_UI_LABEL)Checking chain of remote-certificate "$(OSL_REMOTECERTIFICATE_NAME)" ...'; $(NORMAL)
	@#(WARN) 'This operation checks whether the provided certificate-chain can validate the certificate'; $(NORMAL)
	@#$(OPENSSL) verify $(__OSL_CAFILE__REMOTECERTIFICATE) $(OSL_REMOTECERTIFICATE_FILEPATH)

_osl_check_remotecertificate_modulus: _osl_show_remotecertificate_modulus

_osl_download_remotecertificate:
	@$(INFO) '$(OSL_UI_LABEL)Downloading remote-certificate "$(OSL_REMOTECERTIFICATE_NAME)" ...'; $(NORMAL)
	$(_OSL_DOWNLOAD_REMOTECERTIFICATE_|) $(OPENSSL) s_client $(__OSL_HOST__REMOTECERTIFICATE) $(__OSL_PORT__REMOTECERTIFICATE) 2>/dev/null $(|_OSL_DOWNLOAD_REMOTECERTIFICATE)
 
_osl_show_remotecertificate :: _osl_show_remotecertificate_cachain _osl_show_remotecertificate_content _osl_show_remotecertificate_modulus _osl_show_remotecertificate_description

_osl_show_remotecertificate_cachain:
	@$(INFO) '$(OSL_UI_LABEL)Showing CA trust-chain of remote-certificate "$(OSL_REMOTECERTIFICATE_NAME)" ...'; $(NORMAL)
	# $(OPENSSL) s_client $(__OSL_HOST__REMOTECERTIFICATE) $(__OSL_PORT__REMOTECERTIFICATE) -showcerts </dev/null | sed -n -e '/BEGIN\ CERTIFICATE/,/END\ CERTIFICATE/p'

_osl_show_remotecertificate_content: _osl_show_remotecertificate_decodedcontent _osl_show_remotecertificate_encodedcontent

_osl_show_remotecertificate_decodedcontent:
	@$(INFO) '$(OSL_UI_LABEL)Showing decoded-content of remote-certificate "$(OSL_REMOTECERTIFICATE_NAME)" ...'; $(NORMAL)
	$(OPENSSL) s_client $(__OSL_HOST__REMOTECERTIFICATE) $(__OSL_PORT__REMOTECERTIFICATE) </dev/null 2>/dev/null | sed -n -e '/BEGIN\ CERTIFICATE/,/END\ CERTIFICATE/p' | $(OPENSSL) x509 -noout -text

_osl_show_remotecertificate_description:
	@$(INFO) '$(OSL_UI_LABEL)Showing description of remote-certificate "$(OSL_REMOTECERTIFICATE_NAME)" ...'; $(NORMAL)
	@# ls -la $(OSL_CERTIFICATE_FILEPATH)

_osl_show_remotecertificate_encodedcontent:
	@$(INFO) '$(OSL_UI_LABEL)Showing encoded-content of certificate "$(OSL_REMOTECERTIFICATE_NAME)" ...'; $(NORMAL)
	$(OPENSSL) s_client $(__OSL_HOST__REMOTECERTIFICATE) $(__OSL_PORT__REMOTECERTIFICATE) </dev/null 2>/dev/null | sed -n -e '/BEGIN\ CERTIFICATE/,/END\ CERTIFICATE/p' $(|_OSL_SHOW_REMOTECERTIFICATE_ENCODEDCONTENT)

_osl_show_remotecertificate_modulus:
	@$(INFO) '$(OSL_UI_LABEL)Showing modulus of remote-certificate "$(OSL_REMOTECERTIFICATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the modulus of the embedded public-key'; $(NORMAL)
	$(OPENSSL) s_client $(__OSL_HOST__REMOTECERTIFICATE) $(__OSL_PORT__REMOTECERTIFICATE) </dev/null 2>/dev/null | sed -n -e '/BEGIN\ CERTIFICATE/,/END\ CERTIFICATE/p' | $(OPENSSL) x509 -modulus -noout $(|_OSL_SHOW_REMOTECERTIFICATE_MODULUS)

_osl_show_remotecertificate_publickey:
	@$(INFO) '$(OSL_UI_LABEL)Showing public-key of remote-certificate "$(OSL_REMOTECERTIFICATE_NAME)" ...'; $(NORMAL)
