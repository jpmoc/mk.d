_CONSUL_MK_VERSION= 0.99.4

# CLS_CLIENT_CERTIFICATE_DIRPATH?= ./out/
# CLS_CLIENT_CERTIFICATE_FILENAME?= dc1-cli-consul-0.pem 
# CLS_CLIENT_CERTIFICATE_FILEPATH?= ./out/dc1-cli-consul-0.pem
# CLS_CLIENT_PRIVATEKEY_DIRPATH?= ./out/
# CLS_CLIENT_PRIVATEKEY_FILENAME?= dc1-cli-consul-0-key.pem 
# CLS_CLIENT_PRIVATEKEY_FILEPATH?= ./out/dc1-cli-consul-0.pem
CSL_ENDPOINT_URL?= http://127.0.0.1:8500
# CSL_INPUTS_DIRPATH?= ./in/
# CSL_MODE_DEBUG?= false
# CSL_OUTPUTS_DIRPATH?= ./out/
# CSL_SERVER_HOST?= localhost
# CSL_SERVER_IP?= 127.0.0.1
# CSL_SERVER_IP_OR_HOST?= 127.0.0.1

# Derived variablesA
CSL_CLIENT_CERTIFICATE_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
CSL_CLIENT_CERTIFICATE_FILEPATH?= $(if $(CSL_CLIENT_CERTIFICATE_FILENAME),$(CSL_CLIENT_CERTIFICATE_DIRPATH)$(CSL_CLIENT_CERTIFICATE_FILENAME))
CSL_CLIENT_CERTIFICATE_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
CSL_CLIENT_CERTIFICATE_FILEPATH?= $(if $(CSL_CLIENT_CERTIFICATE_FILENAME),$(CSL_CLIENT_CERTIFICATE_DIRPATH)$(CSL_CLIENT_CERTIFICATE_FILEPATH))
CSL_CLIENT_PRIVATEKEY_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
CSL_CLIENT_PRIVATEKEY_FILEPATH?= $(if $(CSL_CLIENT_PRIVATEKEY_FILENAME),$(CSL_CLIENT_PRIVATEKEY_DIRPATH)$(CSL_CLIENT_PRIVATEKEY_FILENAME))
CSL_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
CSL_MODE_DEBUG?= $(CMN_MODE_DEBUG)
CSL_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
CSL_SERVER_IP_OR_HOST?= $(if $(CSL_SERVER_IP),$(CSL_SERVER_IP),$(CSL_SERVER_HOST))

# Options variables
__CSL_CA_FILE?= $(if $(CSL_CACERT_FILEPATH),--ca-file $(CSL_CACERT_FILEPATH))
__CSL_CLIENT_CERT?= $(if $(CSL_CLIENT_CERTIFICATE_FILEPATH),--client-cert $(CSL_CLIENT_CERTIFICATE_FILEPATH))
__CSL_CLIENT_KEY?= $(if $(CSL_CLIENT_PRIVATEKEY_FILEPATH),--client-key $(CSL_CLIENT_PRIVATEKEY_FILEPATH))
__CSL_HTTP_ADDR?= $(if $(CSL_ENDPOINT_URL),--http-addr $(CSL_ENDPOINT_URL))

# UI parameters
CSL_UI_LABEL?= [consul] #

# Utilities

CONSUL_BIN?= consul
CONSUL?= $(strip $(__CONSUL_ENVIRONMENT) $(CONSUL_ENVIRONMENT) $(CONSUL_BIN) $(__CONSUL_OPTIONS) $(CONSUL_OPTIONS))
CONSUL_VERSION?= 1.6.2

#--- MACROS

_csl_get_gossip_encryptionkey= $(shell $(CONSUL) keygen)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _csl_view_framework_macros
_csl_view_framework_macros ::
	@echo 'ConSuL ($(_CONSUL_MK_VERSION)) macros:'
	@echo '    _csl_get_gossip_encryptionkey           - Get an encryption key to be used with gossip'
	@echo

_view_framework_parameters :: _csl_view_framework_parameters
_csl_view_framework_parameters ::
	@echo 'ConSuL ($(_CONSUL_MK_VERSION)) parameters:'
	@echo '    CONSUL=$(CONSUL)'
	@echo '    CSL_CLIENT_CERTIFICATE_DIRPATH=$(CSL_CLIENT_CERTIFICATE_DIRPATH)'
	@echo '    CSL_CLIENT_CERTIFICATE_FILENAME=$(CSL_CLIENT_CERTIFICATE_FILENAME)'
	@echo '    CSL_CLIENT_CERTIFICATE_FILEPATH=$(CSL_CLIENT_CERTIFICATE_FILEPATH)'
	@echo '    CSL_CLIENT_PRIVATEKEY_DIRPATH=$(CSL_CLIENT_PRIVATEKEY_DIRPATH)'
	@echo '    CSL_CLIENT_PRIVATEKEY_FILENAME=$(CSL_CLIENT_PRIVATEKEY_FILENAME)'
	@echo '    CSL_CLIENT_PRIVATEKEY_FILEPATH=$(CSL_CLIENT_PRIVATEKEY_FILEPATH)'
	@echo '    CSL_ENDPOINT_URL=$(CSL_ENDPOINT_URL)'
	@echo '    CSL_INPUTS_DIRPATH=$(CSL_INPUTS_DIRPATH)'
	@echo '    CSL_MODE_DEBUG=$(CSL_MODE_DEBUG)'
	@echo '    CSL_OUTPUTS_DIRPATH=$(CSL_OUTPUTS_DIRPATH)'
	@echo '    CSL_SERVER_HOST=$(CSL_SERVER_HOST)'
	@echo '    CSL_SERVER_IP=$(CSL_SERVER_IP)'
	@echo '    CSL_SERVER_IP_OR_HOST=$(CSL_SERVER_IP_OR_HOST)'
	@echo

_view_framework_targets :: _csl_view_framework_targets
_csl_view_framework_targets ::
	@echo 'ConSuL ($(_CONSUL_MK_VERSION)) targets:'
	@echo '    _csl_install_dependencies          - Install dependencies'
	@echo '    _csl_view_versions                 - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/consul_agent.mk
-include $(MK_DIR)/consul_cacert.mk
-include $(MK_DIR)/consul_catalog.mk
-include $(MK_DIR)/consul_certificate.mk
-include $(MK_DIR)/consul_curl.mk
-include $(MK_DIR)/consul_dig.mk
-include $(MK_DIR)/consul_event.mk
-include $(MK_DIR)/consul_kvpair.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _csl_install_dependencies
_csl_install_dependencies ::
	@$(INFO) '$(CSL_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs at https://learn.hashicorp.com/consul/getting-started/install.html#installing-consul'; $(NORMAL)
	cd /tmp; wget https://releases.hashicorp.com/consul/$(CONSUL_VERSION)/consul_$(CONSUL_VERSION)_linux_amd64.zip
	cd /tmp; unzip consul_$(CONSUL_VERSION)_linux_amd64.zip
	sudo mv /tmp/consul /usr/local/bin/consul
	which consul
	consul --version

_csl_get_gossip_encryptionkey:
	@$(INFO) '$(CSL_UI_LABEL)Getting a key to encrypt gossip-traffic ...'; $(NORMAL)
	@$(WARN) 'This operation returns a key to be used in the configuration of the consul-agent'; $(NORMAL)
	$(CONSUL_BIN) keygen

_view_versions :: _csl_view_versions
_csl_view_versions:
	@$(INFO) '$(CSL_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(CONSUL_BIN) --version
