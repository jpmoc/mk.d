_AWS_ES_PROXY_MK_VERSION= $(_AWS_ES_MK_VERSION)

# ES_PROXY_ENDPOINT_URL?= http://....
ES_PROXY_LISTEN_HOSTPORT?= localhost:9200
# ES_PROXY_MODE_VERBOSE?= true

# Derived variables
ES_PROXY_ENDPOINT_URL?= $(ES_DOMAIN_ENDPOINT_URL)

# Options
__ES_ENDPOINT__PROXY?= $(if $(ES_PROXY_ENDPOINT_URL), -endpoint $(ES_PROXY_ENDPOINT_URL))

# UI variables

#--- Utilities
__ES_PROXY_ENVIRONMENT+=
__ES_PROXY_OPTIONS+= $(if $(ES_PROXY_LISTEN_HOSTPORT), -listen $(ES_PROXY_LISTEN_HOSTPORT))
__ES_PROXY_OPTIONS+= $(if $(filter true, $(ES_PROXY_VERBOSE_ENABLE)), -verbose)

ES_PROXY_BIN?= aws-es-proxy
ES_PROXY?= $(strip $(__ES_PROXY_ENVIRONMENT) $(ES_PROXY_ENVIRONMENT) $(ES_PROXY_BIN) $(__ES_PROXY_OPTIONS) $(ES_PROXY_OPTIONS))


#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_es_install_framework_dependencies ::
	@$(WARN) 'Those commands are to be executed manually!'; $(NORMAL)
	# To install pre-compiled binaries: https://github.com/abutaha/aws-es-proxy/releases/'
	# To install from source: https://github.com/abutaha/aws-es-proxy
	@echo '#requires go1.5'
	go version
	@echo 'export GO15VENDOREXPERIMENT=1'
	@echo 'mkdir -p $$GOPATH/src/github.com/abutaha'
	@echo 'cd $$GOPATH/src/github.com/abutaha'
	@echo 'git clone https://github.com/abutaha/aws-es-proxy'
	@echo 'cd aws-es-proxy'
	@echo '# Glide install docs @ https://glide.sh/'
	@echo 'curl https://glide.sh/get | sh'
	@echo 'glide install'
	@echo 'go build github.com/abutaha/aws-es-proxy'
	@echo 'go install github.com/abutaha/aws-es-proxy'
	@echo 'Now add $$GOPATH/bin in your PATH envvar'
	@echo 'which aws-es-proxy'
	@echo

_es_view_framework_macros ::
	@#echo 'AWS::ElasticSearch::Proxy ($(_AWS_ES_PROXY_MK_VERSION)) macros:' 
	@#echo

_es_view_framework_parameters ::
	@echo 'AWS::ElasticSearch::Proxy ($(_AWS_ES_PROXY_MK_VERSION)) parameters:'
	@echo '    ES_PROXY=$(ES_PROXY)'
	@echo '    ES_PROXY_ENDPOINT_URL=$(ES_PROXY_ENDPOINT_URL)'
	@echo '    ES_PROXY_LISTEN_HOSTPORT=$(ES_PROXY_LISTEN_HOSTPORT)'
	@echo '    ES_PROXY_MODE_VERBOSE=$(ES_PROXY_MODE_VERBOSE)'
	@echo

_es_view_framework_targets ::
	@echo 'AWS::ElasticSearch::Proxy ($(_AWS_ES_PROXY_MK_VERSION)) targets:' 
	@echo '    _es_start_proxy               - Start a local signature 4 proxy to an ES cluster'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_es_start_proxy:
	@$(INFO) '$(AWS_UI_LABEL)Starting proxy on localhost  to connect to ES domain "$(ES_DOMAIN_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This proxy is required because requests need to be sig4 signed!'
	@$(WARN) 'Use http://$(ES_PROXY_LISTEN_HOSTPORT)/_plugin/kibana/'; $(NORMAL)
	$(ES_PROXY) $(__ES_ENDPOINT__PROXY)
