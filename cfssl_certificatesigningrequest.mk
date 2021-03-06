_CFSSL_CERTIFICATESIGNINGREQUEST_MK_VERSION= $(_CFSSL_MK_VERSION)

# CFL_CERTIFICATESIGNINGREQUEST_CACERT_FILEPATH?=
# CFL_CERTIFICATESIGNINGREQUEST_CAKEY_FILEPATH?=
# CFL_CERTIFICATESIGNINGREQUEST_CONFIG_DIRPATH?= ./in/
# CFL_CERTIFICATESIGNINGREQUEST_CONFIG_FILENAME?= csr-confg.json
# CFL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH?= ./in/csr-config.json
# CFL_CERTIFICATESIGNINGREQUEST_DIRNAME?= ./out/
# CFL_CERTIFICATESIGNINGREQUEST_DOMAIN_NAME?= www.example.com
# CFL_CERTIFICATESIGNINGREQUEST_FILENAME?= example.csr
# CFL_CERTIFICATESIGNINGREQUEST_FILEPATH?= ./out/example.csr
# CFL_CERTIFICATESIGNINGREQUEST_NAME?=
# CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_DIRPATH?= ./out/
# CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILENAME?= example.pem
# CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH?= ./out/example.pem
# CFL_CERTIFICATESIGNINGREQUESTS_DIRNAME?= ./in/
CFL_CERTIFICATESIGNINGREQUESTS_REGEX?= *.csr
# CFL_CERTIFICATESIGNINGREQUESTS_SET_NAME?=

# Derived parameters
CFL_CERTIFICATESIGNINGREQUEST_CONFIG_DIRPATH?= $(CFL_INPUTS_DIRPATH)
CFL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH?= $(CFL_CERTIFICATESIGNINGREQUEST_CONFIG_DIRPATH)$(CFL_CERTIFICATESIGNINGREQUEST_CONFIG_FILENAME)
CFL_CERTIFICATESIGNINGREQUEST_DIRPATH?= $(CFL_OUTPUTS_DIRPATH)
CFL_CERTIFICATESIGNINGREQUEST_FILENAME?= $(CFL_CERTIFICATESIGNINGREQUEST_NAME).csr
CFL_CERTIFICATESIGNINGREQUEST_FILEPATH?= $(CFL_CERTIFICATESIGNINGREQUEST_DIRPATH)$(CFL_CERTIFICATESIGNINGREQUEST_FILENAME)
# CFL_CERTIFICATESIGNINGREQUEST_GENKEY_DIRPATH?= $(CFL_OUTPUTS_DIRPATH)
# CFL_CERTIFICATESIGNINGREQUEST_GENKEY_FILENAME?= $(CFL_CERTIFICATESIGNINGREQUEST_NAME).genkey
# CFL_CERTIFICATESIGNINGREQUEST_GENKEY_FILEPATH?= $(CFL_CERTIFICATESIGNINGREQUEST_GENKEY_DIRPATH)$(CFL_CERTIFICATESIGNINGREQUEST_GENKEY_FILENAME)
CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_DIRPATH?= $(CFL_OUTPUTS_DIRPATH)
CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILENAME?= $(CFL_CERTIFICATESIGNINGREQUEST_NAME)-key.pem
CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH?= $(CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_DIRPATH)$(CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILENAME)
CFL_CERTIFICATESIGNINGREQUESTS_DIRPATH?= $(CFL_CERTIFICATESIGNINGREQUEST_DIRPATH)
CFL_CERTIFICATESIGNINGREQUESTS_SET_NAME?= certificate-signing-requests@$(CFL_CERTIFICATESIGNINGREQUESTS_DIRPATH)

# Option parameters
__CFL_CA__CERTIFICATESIGNINGREQUEST= $(if $(CFL_CERTIFICATESIGNINGREQUEST_CACERT_FILEPATH),--ca $(CFL_CERTIFICATESIGNINGREQUEST_CACERT_FILEPATH))
__CFL_CA_KEY__CERTIFICATESIGNINGREQUEST= $(if $(CFL_CERTIFICATESIGNINGREQUEST_CAKEY_FILEPATH),--ca-key $(CFL_CERTIFICATESIGNINGREQUEST_CAKEY_FILEPATH))
__CFL_PORT= $(if $(CFL_SERVER_PORT),--port $(CFL_SERVER_PORT))

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_cfl_view_framework_macros ::
	@echo 'CFssl::CertificateSigningRequest ($(_CFSSL_CERTIFICATESIGNINGREQUEST_MK_VERSION)) macros:'
	@echo

_cfl_view_framework_parameters ::
	@echo 'CFssL::CertificateSigningRequest ($(_CFSSL_CERTIFICATESIGNINGREQUEST_MK_VERSION)) variables:'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_CACERT_FILEPATH=$(CFL_CERTIFICATESIGNINGREQUEST_CACERT_FILEPATH)'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_CAKEY_FILEPATH=$(CFL_CERTIFICATESIGNINGREQUEST_CAKEY_FILEPATH)'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_CONFIG_DIRPATH=$(CFL_CERTIFICATESIGNINGREQUEST_CONFIG_DIRPATH)'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_CONFIG_FILENAME=$(CFL_CERTIFICATESIGNINGREQUEST_CONFIG_FILENAME)'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH=$(CFL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH)'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_DIRPATH=$(CFL_CERTIFICATESIGNINGREQUEST_DIRPATH)'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_DOMAIN_NAME=$(CFL_CERTIFICATESIGNINGREQUEST_DOMAIN_NAME)'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_FILENAME=$(CFL_CERTIFICATESIGNINGREQUEST_FILENAME)'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_FILEPATH=$(CFL_CERTIFICATESIGNINGREQUEST_FILEPATH)'
	@#echo '    CFL_CERTIFICATESIGNINGREQUEST_GENKEY_DIRPATH=$(CFL_CERTIFICATESIGNINGREQUEST_GENKEY_DIRPATH)'
	@#echo '    CFL_CERTIFICATESIGNINGREQUEST_GENKEY_FILENAME=$(CFL_CERTIFICATESIGNINGREQUEST_GENKEY_FILENAME)'
	@#echo '    CFL_CERTIFICATESIGNINGREQUEST_GENKEY_FILEPATH=$(CFL_CERTIFICATESIGNINGREQUEST_GENKEY_FILEPATH)'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_NAME=$(CFL_CERTIFICATESIGNINGREQUEST_NAME)'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_DIRPATH=$(CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_DIRPATH)'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILENAME=$(CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILENAME)'
	@echo '    CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH=$(CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH)'
	@echo '    CFL_CERTIFICATESIGNINGREQUESTS_DIRPATH=$(CFL_CERTIFICATESIGNINGREQUESTS_DIRPATH)'
	@echo '    CFL_CERTIFICATESIGNINGREQUESTS_REGEX=$(CFL_CERTIFICATESIGNINGREQUESTS_REGEX)'
	@echo '    CFL_CERTIFICATESIGNINGREQUESTS_SET_NAME=$(CFL_CERTIFICATESIGNINGREQUESTS_SET_NAME)'
	@echo

_cfl_view_framework_targets ::
	@echo 'CFssL::CErtificateSigningRequest ($(_CFSSL_CERTIFICATESIGNINGREQUEST_MK_VERSION)) targets:'
	@echo '    _cfl_create_certificatesigningrequest                - Create a certificate-signing-request'
	@echo '    _cfl_delete_certificatesigningrequest                - Delete a certificate-signing-request'
	@echo '    _cfl_show_certificatesigningrequest                  - Show everything related to a certificate-signing-request'
	@echo '    _cfl_show_certificatesigningrequest_content          - Show content of a certificate-signing-request'
	@echo '    _cfl_show_certificatesigningrequest_decodedcontent   - Show decoded-content of a certificate-signing-request'
	@echo '    _cfl_show_certificatesigningrequest_description      - Show description of a certificate-signing-request'
	@echo '    _cfl_show_certificatesigningrequest_encodedcontent   - Show encoded-content of a certificate-signing-request'
	@echo '    _cfl_sign_certificatesigningrequest                  - Sign a certificate-signing-request'
	@echo '    _cfl_view_certificatesigningrequest                  - View all certificate-signing-requests'
	@echo '    _cfl_view_certificatesigningrequest_set              - View a set of certificate-signing-requests'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cfl_create_certificatesigningrequest:
	@$(INFO) '$(CFL_UI_LABEL)Creating certificate-signing-request "$(CFL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	cat $(CFL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH)
	@# $(CFSSL) genkey $(CFL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH) | tee $(CFL_CERTIFICATESIGNINGREQUEST_GENKEY_FILEPATH)
	@# cat $(CFL_CERTIFICATESIGNINGREQUEST_GENKEY_FILEPATH) | jq -r '.csr' | tee $(CFL_CERTIFICATESIGNINGREQUEST_FILEPATH)
	@# cat $(CFL_CERTIFICATESIGNINGREQUEST_GENKEY_FILEPATH) | jq -r '.key' | tee $(CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH)
	$(CFSSL) genkey $(CFL_CERTIFICATESIGNINGREQUEST_CONFIG_FILEPATH) | $(CFSSLJSON) -bare -f - $(CFL_CERTIFICATESIGNINGREQUESTS_DIRPATH)$(CFL_CERTIFICATESIGNINGREQUEST_NAME)

_cfl_delete_certificatesigningrequest:
	@$(INFO) '$(CFL_UI_LABEL)Deleting certificate-signing-request "$(CFL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	rm $(CFL_CERTIFICATESIGNINGREQUEST_FILEPATH)

_cfl_show_certificatesigningrequest :: _cfl_show_certificatesigningrequest_content _cfl_show_certificatesigningrequest_privatekey _cfl_show_certificatesigningrequest_description

_cfl_show_certificatesigningrequest_content: _cfl_show_certificatesigningrequest_decodedcontent _cfl_show_certificatesigningrequest_encodedcontent

_cfl_show_certificatesigningrequest_decodedcontent:
	@$(INFO) '$(CFL_UI_LABEL)Showing content of certificate-signing-request "$(CFL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	openssl req -in $(CFL_CERTIFICATESIGNINGREQUEST_FILEPATH) -noout -text

_cfl_show_certificatesigningrequest_description:
	@$(INFO) '$(CFL_UI_LABEL)Showing description of certificate-signing-request "$(CFL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	ls -la $(CFL_CERTIFICATESIGNINGREQUEST_FILEPATH)

_cfl_show_certificatesigningrequest_encodedcontent:
	@$(INFO) '$(CFL_UI_LABEL)Showing encoded-content of certificate-signing-request "$(CFL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	cat $(CFL_CERTIFICATESIGNINGREQUEST_FILEPATH)

_cfl_show_certificatesigningrequest_privatekey:
	@$(INFO) '$(CFL_UI_LABEL)Showing private-key of certificate-signing-request "$(CFL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	ls -la $(CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH)
	cat $(CFL_CERTIFICATESIGNINGREQUEST_PRIVATEKEY_FILEPATH)

_cfl_sign_certificatesigningrequest:
	@$(INFO) '$(CFL_UI_LABEL)Signing certificate-signing-request "$(CFL_CERTIFICATESIGNINGREQUEST_NAME)" ...'; $(NORMAL)
	$(CFSSL) sign i$(__CFL_CA__CERTIFICATESIGNINGREQUEST) $(__CFL_CA_KEY__CERTIFICATESIGNINGREQUEST) $(CFL_CERTIFICATESIGNINGREQUEST_DOMAIN) $(CFL_CERTIFICATESIGNINGREQUEST_FILEPATH)

_cfl_view_certificatesigningrequests:
	@$(INFO) '$(CFL_UI_LABEL)Viewing certificate-signing-requests ...'; $(NORMAL)
	ls -al $(CFL_CERTIFICATESIGNINGREQUESTS_DIRPATH)

_cfl_view_certificatesigningrequests_set:
	@$(INFO) '$(CFL_UI_LABEL)Viewing certificate-signing-requests-set "$(CFL_CERTIFICATESIGNINGREQUESTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Certificate-signing-requests are grouped by directory and regex'; $(NORMAL)
	ls -al $(CFL_CERTIFICATESIGNINGREQUESTS_DIRPATH)$(CFL_CERTIFICATESIGNINGREQUESTSERVERS_REGEX)
