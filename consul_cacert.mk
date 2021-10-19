_CONSUL_CACERT_MK_VERSION= $(_CONSUL_MK_VERSION)

CSL_CACERT_DOMAIN_NAME?= consul
# CSL_CACERT_DAYS?= 3650
# CSL_CACERT_DIRPATH?= ./out/
# CSL_CACERT_FILENAME?= cacert.pem
# CSL_CACERT_FILEPATH?= ./out/cacert.pem
# CSL_CACERT_PRIVATEKEY_DIRPATH?= ./in/
# CSL_CACERT_PRIVATEKEY_FILENAME?= consul-agent-ca-key.pem
# CSL_CACERT_PRIVATEKEY_FILEPATH?= ./in/consul-agent-ca-key.pem
# CSL_CACERT_NAME?= my-ca-certificate
# CSL_CACERTS_REGEX?= consul-*
# CSL_CACERTS_SET_NAME?=

# Derived variables
CSL_CACERT_DIRPATH?= $(CSL_OUTPUTS_DIRPATH)
CSL_CACERT_FILENAME?= $(CSL_CACERT_DOMAIN_NAME)-agent-ca.pem
CSL_CACERT_FILEPATH?= $(CSL_CACERT_DIRPATH)$(CSL_CACERT_FILENAME)
CSL_CACERT_NAME?= $(CSL_CACERT_DOMAIN_NAME)-cacert
CSL_CACERT_PRIVATEKEY_DIRPATH?= $(CSL_CACERT_DIRPATH)
CSL_CACERT_PRIVATEKEY_FILENAME?= $(CSL_CACERT_DOMAIN_NAME)-agent-ca-key.pem
CSL_CACERT_PRIVATEKEY_FILEPATH?= $(CSL_CACERT_PRIVATEKEY_DIRPATH)$(CSL_CACERT_PRIVATEKEY_FILENAME)
CSL_CACERTS_DIRPATH?= $(CSL_CACERT_DIRPATH)
CSL_CACERTS_REGEX?= $(CSL_CACERT_DOMAIN_NAME)-*
CSL_CACERTS_SET_NAME?= cacerts@$(CSL_CACERTS_DIRPATH)

# Options variables
__CSL_ADDITIONAL_NAME_CONSTRAINT=
__CSL_DAYS__CACERT= $(if $(CSL_CACERT_DAYS),-days $(CSL_CACERT_DAYS))
__CSL_DOMAIN__CACERT= $(if $(CSL_CERTIFICATE_DOMAIN_NAME),-domain $(CSL_CERTIFICATE_DOMAIN_NAME))
__CSL_NAME_CONSTRAINT=

# Pipe

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@echo 'ConSuL::CaCert ($(_CONSUL_CACERT_MK_VERSION)) macros:'
	@echo

_csl_view_framework_parameters ::
	@echo 'ConSuL::CaCert ($(_CONSUL_CACERT_MK_VERSION)) parameters:'
	@echo '    CSL_CACERT_DAYS=$(CSL_CACERT_DAYS)'
	@echo '    CSL_CACERT_DIRPATH=$(CSL_CACERT_DIRPATH)'
	@echo '    CSL_CACERT_DOMAIN_NAME=$(CSL_CACERT_DOMAIN_NAME)'
	@echo '    CSL_CACERT_FILENAME=$(CSL_CACERT_FILENAME)'
	@echo '    CSL_CACERT_FILEPATH=$(CSL_CACERT_FILEPATH)'
	@echo '    CSL_CACERT_PRIVATEKEY_DIRPATH=$(CSL_CACERT_PRIVATEKEY_DIRPATH)'
	@echo '    CSL_CACERT_PRIVATEKEY_FILENAME=$(CSL_CACERT_PRIVATEKEY_FILENAME)'
	@echo '    CSL_CACERT_PRIVATEKEY_FILEPATH=$(CSL_CACERT_PRIVATEKEY_FILEPATH)'
	@echo '    CSL_CACERT_NAME=$(CSL_CACERT_NAME)'
	@echo '    CSL_CACERTS_DIRPATH=$(CSL_CACERTS_DIRPATH)'
	@echo '    CSL_CACERTS_REGEX=$(CSL_CACERTS_REGEX)'
	@echo '    CSL_CACERTS_SET_NAME=$(CSL_CACERTS_SET_NAME)'
	@echo

_csl_view_framework_targets ::
	@echo 'ConSuL::CaCert ($(_CONSUL_CACERT_MK_VERSION)) targets:'
	@echo '    _csl_create_cacert                  - Create a CA-certificate'
	@echo '    _csl_delete_cacert                  - Delete a CA-certificate'
	@echo '    _csl_show_cacert                    - Show everything related to a CA-certificate'
	@echo '    _csl_show_cacert_description        - Show description of a CA-certificate'
	@echo '    _csl_view_cacerts                   - View all CS-certificates' 
	@echo '    _csl_view_cacerts_set               - View a set of CA-certficates' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csl_create_cacert:
	@$(INFO) '$(CSL_UI_LABEL)Creating a CA-certificate "$(CSL_CACERT_NAME)" ...'; $(NORMAL)
	cd $(CSL_CACERT_DIRPATH); \
		$(CONSUL) tls ca create $(__CSL_ADDITIONAL_NAME_CONSTRAINT) $(__CSL_DAYS__CACERT) $(__CSL_DOMAIN__CACERT) $(__CSL_NAME_CONSTRAINT)

_csl_delete_cacert:
	@$(INFO) '$(CSL_UI_LABEL)Deleting CA-certificate "$(CSL_CACERT_NAME)" ...'; $(NORMAL)
	rm $(CSL_CACERT_FILEPATH)
	rm $(CSL_CACERT_PRIVATEKEY_FILEPATH)

_csl_show_cacert :: _csl_show_cacert_description

_csl_show_cacert_description:
	@$(INFO) '$(CSL_UI_LABEL)Showing description of CA-certificacte "$(CSL_CACERT_NAME)" ...'; $(NORMAL)
	ls -la $(CSL_CACERT_FILEPATH) $(CSL_CACERT_PRIVATEKEY_FILEPATH)

_csl_view_cacerts:
	@$(INFO) '$(CSL_UI_LABEL)Viewing CA-certificates ...'; $(NORMAL)
	cd $(CSL_CACERTS_DIRPATH); ls -al

_csl_view_cacerts_set:
	@$(INFO) '$(CSL_UI_LABEL)Viewing CA-certificates-set "$(CSL_CACERTS_SET_NAME)" ...'; $(NORMAL)
	cd $(CSL_CACERTS_DIRPATH); ls -al $(CSL_CACERTS_REGEX)
