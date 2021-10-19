_CONSUL_CURL_MK_VERSION= $(_CONSUL_MK_VERSION)

# CSL_CURL_API_URL?= http://127.0.0.1:8200/v1
CSL_CURL_API_VERSION?= v1
# CSL_CURL_ENDPOINT_URL?= http://127.0.0.1:8200
# CSL_CURL_TOKEN_ID?=
# CSLCURL_CACERT_FILEPATH?=
# CSLCURL_CLIENT_PRIVATEKEY_FILEPATH?=

# Derived variables
CSL_CURL_API_URL?= $(CSL_ENDPOINT_URL)/$(CSL_CURL_API_VERSION)
CSL_CURL_ENDPOINT_URL?= $(CSL_ENDPOINT_URL)
CSLCURL_CACERT_FILEPATH?= $(CSL_CACERT_FILEPATH)
CSLCURL_CLIENT_CERTIFICATE_FILEPATH?= $(CSL_CLIENT_CERTIFICATE_FILEPATH)
CSLCURL_CLIENT_PRIVATEKEY_FILEPATH?= $(CSL_CLIENT_PRIVATEKEY_FILEPATH)

# Options variables

# Pipe
|_CSL_CURL_NODES?= | jq '.'
|_CSL_CURL_SERVICES?= | jq '.'

# UI parameters

# Utilities
__CSLCURL_OPTIONS+= $(if $(CSLCURL_CACERT_FILEPATH),--cacert $(CSLCURL_CACERT_FILEPATH))
__CSLCURL_OPTIONS+= $(if $(CSLCURL_CLIENT_CERTIFICATE_FILEPATH),--cert $(CSLCURL_CLIENT_CERTIFICATE_FILEPATH))
__CSLCURL_OPTIONS+= $(if $(CSLCURL_CLIENT_PRIVATEKEY_FILEPATH),--key $(CSLCURL_CLIENT_PRIVATEKEY_FILEPATH))
__CSLCURL_OPTIONS+= --silent
CSLCURL_BIN?= curl
CSLCURL?= $(strip $(__CSLCURL_ENVIRONMENT) $(CSLCURL_ENVIRONMENT) $(CSLCURL_BIN) $(__CSLCURL_OPTIONS) $(CSLCURL_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_csl_view_framework_macros ::
	@echo 'ConSuL::Curl ($(_CONSUL_CURL_MK_VERSION)) macros:'
	@echo

_csl_view_framework_parameters ::
	@echo 'ConSuL::Curl ($(_CONSUL_CURL_MK_VERSION)) parameters:'
	@echo '    CSL_CURL_API_URL=$(CSL_CURL_API_URL)'
	@echo '    CSL_CURL_API_VERSION=$(CSL_CURL_API_VERSION)'
	@echo '    CSL_CURL_ENDPOINT_URL=$(CSL_CURL_ENDPOINT_URL)'
	@echo '    ... all other param are passed as-is ...'
	@echo '    CSLCURL=$(CSLCURL)'
	@echo

_csl_view_framework_targets ::
	@echo 'ConSuL::Curl ($(_CONSUL_CURL_MK_VERSION)) targets:'
	@echo '    _csl_curl_leader                    - Curl to find the leader'
	@echo '    _csl_curl_nodes                     - Curl to find the members'
	@echo '    _csl_curl_services                  - Curl to find the services'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csl_curl_leader:
	@$(INFO) '$(CSL_UI_LABEL)Curling leader ...'; $(NORMAL)
	$(CSLCURL) $(CSL_CURL_API_URL)/status/leader 2>/dev/null | grep -E '".+"'

_csl_curl_nodes:
	@$(INFO) '$(CSL_UI_LABEL)Curling nodes ...'; $(NORMAL)
	@$(WARN) 'Unlike the gossip protocol, curl requests go directly to the consul-servers'
	@$(WARN) 'Therefore the returned information is strongly consistent view of the world'; $(NORMAL)
	$(CSLCURL) --request GET $(CSL_CURL_API_URL)/catalog/nodes $(|_CSL_CURL_NODES)

_csl_curl_services:
	@$(INFO) '$(CSL_UI_LABEL)Curling services ...'; $(NORMAL)
	@$(WARN) 'Curl operations return strongly consistent view of the world unlike gossip queries'; $(NORMAL)
	$(CSLCURL) --request GET $(CSL_CURL_API_URL)/catalog/services $(|_CSL_CURL_SERVICES)
