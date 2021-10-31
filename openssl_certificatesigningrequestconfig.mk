_OPENSSL_CERTIFICATESIGNINGREQUESTCONFIG_MK_VERSION= $(_OPENSSL_MK_VERSION)

# OSL_CERTIFICATESIGNINGREQUESTCONFIG_DIRPATH?= /etc/ssl/
# OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILENAME?= openssl.cnf
# OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH?= /etc/openssl.cnf
# OSL_CERTIFICATESIGNINGREQUESTCONFIG_NAME?= my-certificate-signing-request
# OSL_CERTIFICATESIGNINGREQUESTCONFIGS_DIRPATH?= /etc/ssl/@
OSL_CERTIFICATESIGNINGREQUESTCONFIGS_REGEX?= *.conf
# OSL_CERTIFICATESIGNINGREQUESTCONFIGS_SET_NAME?= csrconf@

# Derived parameters
OSL_CERTIFICATESIGNINGREQUESTCONFIG_DIRPATH?= $(OSL_INPUTS_DIRPATH)
OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH?= $(if $(OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILENAME),$(OSL_CERTIFICATESIGNINGREQUESTCONFIG_DIRPATH)$(OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILENAME))
OSL_CERTIFICATESIGNINGREQUESTCONFIG_NAME?= $(patsubst %.conf,%,$(OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILENAME))
OSL_CERTIFICATESIGNINGREQUESTCONFIGS_DIRPATH?= $(OSL_CERTIFICATESIGNINGREQUESTCONFIG_DIRPATH)
OSL_CERTIFICATESIGNINGREQUESTCONFIGS_SET_NAME?= csrconf@$(OSL_CERTIFICATESIGNINGREQUESTCONFIGS_SET_NAME)

# Option parameters

# Pipe parameters

#--- MACROS

#----------------------------------------------------------------------
# INTERFACE
#

_osl_list_macros ::
	@#echo 'OpenSSL::CertificateSigningRequestConfig ($(_OPENSSL_CERTIFICATESIGNINGREQUESTCONFIG_MK_VERSION)) macros:'
	@#echo

_osl_list_parameters ::
	@echo 'OpenSSL::CertificateSigningRequestConfig ($(_OPENSSL_CERTIFICATESIGNINGREQUESTCONFIG_MK_VERSION)) parameters:'
	@echo '    OSL_CERTIFICATESIGNINGREQUESTCONFIG_DIRPATH=$(OSL_CERTIFICATESIGNINGREQUESTCONFIG_DIRPATH)'
	@echo '    OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILENAME=$(OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILENAME)'
	@echo '    OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH=$(OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH)'
	@echo '    OSL_CERTIFICATESIGNINGREQUESTCONFIG_NAME=$(OSL_CERTIFICATESIGNINGREQUESTCONFIG_NAME)'
	@echo '    OSL_CERTIFICATESIGNINGREQUESTCONFIGS_DIRPATH=$(OSL_CERTIFICATESIGNINGREQUESTCONFIGS_DIRPATH)'
	@echo '    OSL_CERTIFICATESIGNINGREQUESTCONFIGS_REGEX=$(OSL_CERTIFICATESIGNINGREQUESTCONFIGS_REGEX)'
	@echo '    OSL_CERTIFICATESIGNINGREQUESTCONFIGS_SET_NAME=$(OSL_CERTIFICATESIGNINGREQUESTCONFIGS_SET_NAME)'
	@echo

_osl_list_targets ::
	@echo 'OpenSSL::CertificateSigningRequestConfig ($(_OPENSSL_CERTIFICATESIGNINGREQUESTCONFIG_MK_VERSION)) targets:'
	@echo '    _osl_create_certificatesigningrequestconfig              - Create a certificate-signing-request-config'
	@echo '    _osl_delete_certificatesigningrequestconfig              - Delete a certificate-signing-request-config'
	@echo '    _osl_list_certificatesigningrequestconfigs               - List all certificate-signing-request-configs'
	@echo '    _osl_list_certificatesigningrequestconfigs_set           - List a set of certificate-signing-request-configs'
	@echo '    _osl_show_certificatesigningrequestconfig                - Show everything related to a certificate-signing-requesti-config'
	@echo '    _osl_show_certificatesigningrequestconfig_content        - Show content of a certificate-signing-request-config'
	@echo '    _osl_show_certificatesigningrequestconfig_description    - Show description of a certificate-signing-request'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS 
#

#----------------------------------------------------------------------
# PUBLIC TARGETS 
#

_osl_create_certificatesigningrequestconfig:
	@$(INFO) '$(OSL_UI_LABEL)Creating certificate-signing-request-config "$(OSL_CERTIFICATESIGNINGREQUESTCONFIG_NAME)" ...'; $(NORMAL)

_osl_delete_certificatesigningrequestconfig:
	@$(INFO) '$(OSL_UI_LABEL)Deleting certificate-signing-request-config "$(OSL_CERTIFICATESIGNINGREQUESTCONFIG_NAME)" ...'; $(NORMAL)

_osl_edit_certificatesigningrequestsconfig:
	@$(INFO) '$(OSL_UI_LABEL)Editing certificate-signing-request-config "$(OSL_CERTIFICATESIGNINGREQUESTCONFIG_NAME)" ...'; $(NORMAL)
	$(if $(OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH), \
		$(EDITOR) $(OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH) \
	, @\
		echo 'OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH not set' \
	)
		
_osl_list_certificatesigningrequestconfigs:
	@$(INFO) '$(OSL_UI_LABEL)Listing certificate-signing-request-configs ...'; $(NORMAL)
	ls -al $(OSL_CERTIFICATESIGNINGREQUESTCONFIGS_DIRPATH)*

_osl_list_certificatesigningrequestconfigs_set:
	@$(INFO) '$(OSL_UI_LABEL)Listing certificate-signing-request-configs-set "$(OSL_CERTIFICATESIGNINGREQUESTCONFIGS_SET)" ...'; $(NORMAL)
	@$(WARN) 'Certificate-signing-request-configs are grouped based on the provided directory and regex'; $(NORMAL)
	ls -al $(OSL_CERTIFICATESIGNINGREQUESTCONFIGS_DIRPATH)$(OSL_CERTIFICATESIGNINGREQUESTCONFIGS_REGEX)

_OSL_SHOW_CERTIFICATESIGNINGREQUESTCONFIG_TARGETS?= _osl_show_certificatesigningrequestconfig_content _osl_show_certificatesigningrequestconfig_description
_osl_show_certificatesigningrequestconfig: $(_OSL_SHOW_CERTIFICATESIGNINGREQUESTCONFIG_TARGETS)

_osl_show_certificatesigningrequestconfig_content:
	@$(INFO) '$(OSL_UI_LABEL)Showing content of certificate-signing-request-config '$(OSL_CERTIFICATESIGNINGREQUESTCONFIG_NAME)' ...'; $(NORMAL)
	$(if $(OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH), \
		cat $(OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH) $(|_OSL_SHOW_CERTIFICATESIGNINGREQUESTCONFIG) \
	, @\
		echo 'OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH not set' \
	)

_osl_show_certificatesigningrequestconfig_description:
	@$(INFO) '$(OSL_UI_LABEL)Showing description of certificate-signing-request-config '$(OSL_CERTIFICATESIGNINGREQUESTCONFIG_NAME)' ...'; $(NORMAL)
	$(if $(OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH), \
		ls -al $(OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH) \
	, @\
		echo 'OSL_CERTIFICATESIGNINGREQUESTCONFIG_FILEPATH not set' \
	)
