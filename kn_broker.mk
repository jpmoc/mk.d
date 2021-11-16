_KN_BROKER_MK_VERSION= $(_KN_MK_VERSION)

# KN_BROKER_CURL?= time curl
# KN_BROKER_DNSNAME?=
# KN_BROKER_DNSNAME_DOMAIN?=
# KN_BROKER_NAME?= helloworld-go
# KN_BROKER_NAMESPACE_NAME?= eventing-example
# KN_BROKER_URL?= http://helloworld-go.knative-app.example.com
# KN_BROKER_URL_DNSNAME?= helloworld-go.knative-app.example.com
# KN_BROKER_URL_PATH?= /
# KN_BROKER_URL_PORT?= :80
# KN_BROKER_URL_PROTOCOL?= http://
# KN_BROKERS_NAMESPACE_NAME?= eventing-example
# KN_BROKERS_SET_NAME?= my-broker-set

# Derived parameters
KN_BROKER_CURL?= $(KN_CURL)
KN_BROKER_DNSNAME?= $(KN_BROKER_DNSNAME_HOSTNAME).$(KN_BROKER_DNSNAME_SUBDOMAIN)
KN_BROKER_DNSNAME_DOMAIN?= $(KN_DNSNAME_DOMAIN)
KN_BROKER_DNSNAME_HOSTNAME?= $(KN_BROKER_NAME)
KN_BROKER_DNSNAME_SUBDOMAIN?= $(KN_BROKER_NAMESPACE_NAME).$(KN_BROKER_DNSNAME_DOMAIN)
KN_BROKER_NAMESPACE_NAME?= $(KN_NAMESPACE_NAME)
KN_BROKER_URL?= $(KN_BROKER_URL_PROTOCOL)$(KN_BROKER_URL_DNSNAME)$(KN_BROKER_URL_PORT)$(KN_BROKER_URL_PATH)
KN_BROKER_URL_DNSNAME?= $(KN_BROKER_DNSNAME)
KN_BROKERS_NAMESPACE_NAME?= $(KN_BROKER_NAMESPACE_NAME)
KN_BROKERS_SET_NAME?= knative-brokers@@@$(KN_BROKERS_NAMESPACE_NAME)

# Options
__KN_NAMESPACE__BROKER= $(if $(KN_BROKER_NAMESPACE_NAME),--namespace $(KN_BROKER_NAMESPACE_NAME))
__KN_NAMESPACE__BROKERS= $(if $(KN_BROKERS_NAMESPACE_NAME),--namespace $(KN_BROKERS_NAMESPACE_NAME))

# Customizations

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kn_list_macros ::
	@#echo 'KN::Broker ($(_KN_BROKER_MK_VERSION)) macros:'
	@#echo

_kn_list_parameters ::
	@echo 'KN::Broker ($(_KN_BROKER_MK_VERSION)) parameters:'
	@echo '    KN_BROKER_CURL=$(KN_BROKER_CURL_BIN)'
	@echo '    KN_BROKER_DNSNAME=$(KN_BROKER_DNSNAME)'
	@echo '    KN_BROKER_DNSNAME_DOMAIN=$(KN_BROKER_DNSNAME_DOMAIN)'
	@echo '    KN_BROKER_DNSNAME_HOSTNAME=$(KN_BROKER_DNSNAME_HOSTNAME)'
	@echo '    KN_BROKER_DNSNAME_SUBDOMAIN=$(KN_BROKER_DNSNAME_SUBDOMAIN)'
	@echo '    KN_BROKER_NAME=$(KN_BROKER_NAME)'
	@echo '    KN_BROKER_NAMESPACE_NAME=$(KN_BROKER_NAMESPACE_NAME)'
	@echo '    KN_BROKER_URL=$(KN_BROKER_URL)'
	@echo '    KN_BROKER_URL_DNSNAME=$(KN_BROKER_URL_DNSNAME)'
	@echo '    KN_BROKER_URL_PATH=$(KN_BROKER_URL_PATH)'
	@echo '    KN_BROKER_URL_PORT=$(KN_BROKER_URL_PORT)'
	@echo '    KN_BROKER_URL_PROTOCOL=$(KN_BROKER_URL_PROTOCOL)'
	@echo '    KN_BROKERS_NAMESPACE_NAME=$(KN_BROKERS_NAMESPACE_NAME)'
	@echo '    KN_BROKERS_SET_NAME=$(KN_BROKERS_SET_NAME)'
	@echo

_kn_list_targets ::
	@echo 'KN::Broker ($(_KN_BROKER_MK_VERSION)) targets:'
	@echo '    _kn_create_broker                  - Create a new broker'
	@echo '    _kn_curl_broker                    - Curl a broker'
	@echo '    _kn_delete_broker                  - Delete an existing broker'
	@echo '    _kn_list_brokers                   - List all brokers'
	@echo '    _kn_list_brokers_set               - List a set of brokers'
	@echo '    _kn_show_broker                    - Show everything related to a broker'
	@echo '    _kn_show_broker_description        - Show the description of a broker'
	@#echo '    _kn_watch_brokers                  - Watch brokers'
	@#echo '    _kn_watch_brokers_set              - Watch a set of brokers'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kn_create_broker:
	@$(INFO) '$(KN_UI_LABEL)Creating broker "$(KN_BROKER_NAME)" ...'; $(NORMAL)
	$(KN) broker create ... $(__KN_NAMESPACE__BROKER) $(KN_BROKER_NAME)

_kn_curl_broker:
	@$(INFO) '$(KN_UI_LABEL)Curling broker "$(KN_BROKER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the subscriber URL is an internal URL'; $(NORMAL)
	$(KN_BROKER_CURL_BIN) $(KN_BROKER_SUBSCRIBER_URL) 

_kn_delete_broker:
	@$(INFO) '$(KN_UI_LABEL)Deleting broker "$(KN_BROKER_NAME)" ...'; $(NORMAL)

_KN_SHOW_BROKER_TARGETS?= _kn_show_broker_description
_kn_show_broker: $(_KN_SHOW_BROKER_TARGETS)

_kn_show_broker_description:
	@$(INFO) '$(KN_UI_LABEL)Showing description broker "$(KN_BROKER_NAME)" ...'; $(NORMAL)
	$(KN) broker describe $(__KN_NAMESPACE__BROKER) $(KN_BROKER_NAME)

_kn_show_broker_state:
	@$(INFO) '$(KN_UI_LABEL)Showing state of broker "$(KN_BROKER_NAME)" ...'; $(NORMAL)
	$(KN) get broker $(__KN_NAMESPACE__BROKER) $(KN_BROKER_NAME) 

_kn_update_broker:
	@$(INFO) '$(KN_UI_LABEL)Updating broker "$(KN_BROKER_NAME)" ...'; $(NORMAL)

_kn_list_brokers:
	@$(INFO) '$(KN_UI_LABEL)Listing ALL brokers ...'; $(NORMAL)
	$(KN) broker list --all-namespaces=true $(_X__KN_NAMESPACE__BROKERS) $(__KN_TARGET__BROKERS)

_kn_list_brokers_set:
	@$(INFO) '$(KN_UI_LABEL)Listing brokers-set "$(KN_BROKERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'brokers are grouped based on the provided namespace, and ...'; $(NORMAL)
	$(KN) broker list --all-namespaces=false $(__KN_NAMESPACE__BROKERS) $(__KN_TARGET__BROKERS)

_kn_watch_brokers:
	@$(INFO) '$(KN_UI_LABEL)Watching brokers ...'; $(NORMAL)

_kn_watch_brokers_set:
	@$(INFO) '$(KN_UI_LABEL)Watching brokers ...'; $(NORMAL)
