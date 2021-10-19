_KN_TRIGGER_MK_VERSION= $(_KN_MK_VERSION)

# KN_TRIGGER_CURL?= time curl
# KN_TRIGGER_DIG?= dig
# KN_TRIGGER_DNSNAME?= helloworld-go.knative-app.example.com
# KN_TRIGGER_DNSNAME_DOMAIN?= example.com
# KN_TRIGGER_DNSNAME_HOSTNAME?= helloworld-go
# KN_TRIGGER_DNSNAME_SUBDOMAIN?= knative-app.example.com
# KN_TRIGGER_NAME?= helloworld-go
# KN_TRIGGER_NAMESPACE_NAME?= eventing-example
# KN_TRIGGER_URL?= http://helloworld-go.knative-app.example.com:80/my/path
# KN_TRIGGER_URL_DNSNAME?= helloworld-go.knative-app.example.com
# KN_TRIGGER_URL_PATH?= /my/path
# KN_TRIGGER_URL_PORT?= :80
# KN_TRIGGER_URL_PROTOCOL?= http://
# KN_TRIGGERS_NAMESPACE_NAME?= eventing-example
# KN_TRIGGERS_SET_NAME?= knative-triggers@@@

# Derived parameters
KN_TRIGGER_CURL?= $(KN_CURL)
KN_TRIGGER_DIG?= $(KN_DIG)
KN_TRIGGER_DNSNAME?= $(KN_TRIGGER_DNSNAME_HOSTNAME).$(KN_TRIGGER_DNSNAME_SUBDOMAIN)
KN_TRIGGER_DNSNAME_DOMAIN?= $(KN_DNSNAME_DOMAIN)
KN_TRIGGER_DNSNAME_HOSTNAME?= $(KN_TRIGGER_NAME)
KN_TRIGGER_DNSNAME_SUBDOMAIN?= $(KN_TRIGGER_NAMESPACE_NAME).$(KN_TRIGGER_DNSNAME_DOMAIN)
# KN_TRIGGER_MANIFEST_DIRPATH?= $(KN_INPUTS_DIRPATH)
# KN_TRIGGER_MANIFEST_FILEPATH?= $(KN_TRIGGER_MANIFEST_DIRPATH)$(KN_TRIGGER_MANIFEST_FILENAME)
KN_TRIGGER_NAMESPACE_NAME?= $(KN_NAMESPACE_NAME)
KN_TRIGGER_URL?= $(KN_TRIGGER_URL_PROTOCOL)$(KN_TRIGGER_URL_DNSNAME)$(KN_TRIGGER_URL_PORT)$(KN_TRIGGER_URL_PATH)
KN_TRIGGER_URL_DNSNAME?= $(KN_TRIGGER_DNSNAME)
KN_TRIGGERS_NAMESPACE_NAME?= $(KN_TRIGGER_NAMESPACE_NAME)
KN_TRIGGERS_SET_NAME?= knative-triggers@@@$(KN_TRIGGERS_NAMESPACE_NAME)

# Option parameters
# __KN_ALL_NAMESPACES__TRIGGERS=
__KN_ENV__TRIGGER= $(foreach KV, $(KN_TRIGGER_ENV_KEYVALUES),--env $(KV) )
# __KN_FIELD_SELECTOR__TRIGGERS= $(if $(KN_TRIGGERS_FIELDSELECTOR),--field-selector $(KN_TRIGGERS_FIELDSELECTOR))
# __KN_FILENAME__TRIGGER+= $(if $(KN_TRIGGER_MANIFEST_FILEPATH),--filename $(KN_TRIGGER_MANIFEST_FILEPATH))
# __KN_FILENAME__TRIGGER+= $(if $(KN_TRIGGER_MANIFEST_URL),--filename $(KN_TRIGGER_MANIFEST_URL))
__KN_IMAGE__TRIGGER= $(if $(KN_TRIGGER_IMAGE_CNAME),--image $(KN_TRIGGER_IMAGE_CNAME))
__KN_NAMESPACE__TRIGGER= $(if $(KN_TRIGGER_NAMESPACE_NAME),--namespace $(KN_TRIGGER_NAMESPACE_NAME))
__KN_NAMESPACE__TRIGGERS= $(if $(KN_TRIGGERS_NAMESPACE_NAME),--namespace $(KN_TRIGGERS_NAMESPACE_NAME))
# __KN_SELECTOR__TRIGGERS= $(if $(KN_TRIGGERS_SELECTOR),--selector=$(KN_TRIGGERS_SELECTOR))
# __KN_WATCH_ONLY__TRIGGERS= $(if $(KN_TRIGGERS_WATCH_ONLY),--watch-only=$(KN_TRIGGERS_WATCH_ONLY))

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kn_view_framework_macros ::
	@echo 'KN::Trigger ($(_KN_TRIGGER_MK_VERSION)) macros:'
	@echo

_kn_view_framework_parameters ::
	@echo 'KN::Trigger ($(_KN_TRIGGER_MK_VERSION)) parameters:'
	@echo '    KN_TRIGGER_CURL=$(KN_TRIGGER_CURL)'
	@echo '    KN_TRIGGER_DNSNAME=$(KN_TRIGGER_DNSNAME)'
	@echo '    KN_TRIGGER_DNSNAME_DOMAIN=$(KN_TRIGGER_DNSNAME_DOMAIN)'
	@echo '    KN_TRIGGER_DNSNAME_HOSTNAME=$(KN_TRIGGER_DNSNAME_HOSTNAME)'
	@echo '    KN_TRIGGER_DNSNAME_SUBDOMAIN=$(KN_TRIGGER_DNSNAME_SUBDOMAIN)'
	@echo '    KN_TRIGGER_IMAGE_CNAME=$(KN_TRIGGER_IMAGE_CNAME)'
	@#echo '    KN_TRIGGER_MANIFEST_DIRPATH=$(KN_TRIGGER_MANIFEST_DIRPATH)'
	@#echo '    KN_TRIGGER_MANIFEST_FILENAME=$(KN_TRIGGER_MANIFEST_FILENAME)'
	@#echo '    KN_TRIGGER_MANIFEST_FILEPATH=$(KN_TRIGGER_MANIFEST_FILEPATH)'
	@echo '    KN_TRIGGER_NAME=$(KN_TRIGGER_NAME)'
	@echo '    KN_TRIGGER_NAMESPACE_NAME=$(KN_TRIGGER_NAMESPACE_NAME)'
	@echo '    KN_TRIGGER_URL=$(KN_TRIGGER_URL)'
	@echo '    KN_TRIGGER_URL_DNSNAME=$(KN_TRIGGER_URL_DNSNAME)'
	@echo '    KN_TRIGGER_URL_PATH=$(KN_TRIGGER_URL_PATH)'
	@echo '    KN_TRIGGER_URL_PORT=$(KN_TRIGGER_URL_PORT)'
	@echo '    KN_TRIGGER_URL_PROTOCOL=$(KN_TRIGGER_URL_PROTOCOL)'
	@echo '    KN_TRIGGERS_NAMESPACE_NAME=$(KN_TRIGGERS_NAMESPACE_NAME)'
	@#echo '    KN_TRIGGERS_SET_NAME=$(KN_TRIGGERS_SET_NAME)'
	@#echo '    KN_TRIGGERS_SHOW_LABELS=$(KN_TRIGGERS_SHOW_LABELS)'
	@#echo '    KN_TRIGGERS_WATCH_ONLY=$(KN_TRIGGERS_WATCH_ONLY)'
	@echo

_kn_view_framework_targets ::
	@echo 'KN::Trigger ($(_KN_TRIGGER_MK_VERSION)) targets:'
	@echo '    _kn_create_trigger                  - Create a new trigger'
	@echo '    _kn_curl_trigger                    - Curl a trigger'
	@echo '    _kn_dig_trigger                     - Dig a trigger'
	@#echo '    _kn_delete_trigger                  - Delete an existing trigger'
	@echo '    _kn_show_trigger                    - Show everything related to a trigger'
	@echo '    _kn_show_trigger_description        - Show the description of a trigger'
	@echo '    _kn_view_triggers                   - View all triggers'
	@echo '    _kn_view_triggers_set               - View a set of triggers'
	@#echo '    _kn_watch_triggers                  - Watch triggers'
	@#echo '    _kn_watch_triggers_set              - Watch a set of triggers'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kn_create_trigger:
	@$(INFO) '$(KN_UI_LABEL)Creating trigger "$(KN_TRIGGER_NAME)" ...'; $(NORMAL)
	$(KN) trigger create ... $(__KN_NAMESPACE__TRIGGER) $(KN_TRIGGER_NAME)

_kn_curl_trigger:
	@$(INFO) '$(KN_UI_LABEL)Curling trigger "$(KN_TRIGGER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the subscriber URL is an internal URL'; $(NORMAL)
	$(KN_TRIGGER_CURL) $(KN_TRIGGER_URL) 

_kn_delete_trigger:
	@$(INFO) '$(KN_UI_LABEL)Deleting trigger "$(KN_TRIGGER_NAME)" ...'; $(NORMAL)

_kn_dig_trigger:
	@$(INFO) '$(KN_UI_LABEL)Dig-ing trigger "$(KN_TRIGGER_NAME)" ...'; $(NORMAL)
	$(KN_TRIGGER_DIG) $(KN_TRIGGER_DNSNAME) 

_kn_show_trigger: _kn_show_trigger_description

_kn_show_trigger_description:
	@$(INFO) '$(KN_UI_LABEL)Showing description trigger "$(KN_TRIGGER_NAME)" ...'; $(NORMAL)
	$(KN) trigger describe $(__KN_NAMESPACE__TRIGGER) $(KN_TRIGGER_NAME)

_kn_show_trigger_state:
	@$(INFO) '$(KN_UI_LABEL)Showing state of trigger "$(KN_TRIGGER_NAME)" ...'; $(NORMAL)
	$(KN) get trigger $(__KN_NAMESPACE__TRIGGER) $(KN_TRIGGER_NAME) 

_kn_update_trigger:
	@$(INFO) '$(KN_UI_LABEL)Updating trigger "$(KN_TRIGGER_NAME)" ...'; $(NORMAL)

_kn_view_triggers:
	@$(INFO) '$(KN_UI_LABEL)Viewing triggers ...'; $(NORMAL)
	$(KN) trigger list --all-namespaces=true $(_X__KN_NAMESPACE__TRIGGERS) $(__KN_TARGET__TRIGGERS)

_kn_view_triggers_set:
	@$(INFO) '$(KN_UI_LABEL)Viewing triggers-set "$(KN_TRIGGERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'triggers are grouped based on the provided namespace, and ...'; $(NORMAL)
	$(KN) trigger list --all-namespaces=false $(__KN_NAMESPACE__TRIGGERS) $(__KN_TARGET__TRIGGERS)

_kn_watch_triggers:
	@$(INFO) '$(KN_UI_LABEL)Watching triggers ...'; $(NORMAL)

_kn_watch_triggers_set:
	@$(INFO) '$(KN_UI_LABEL)Watching triggers ...'; $(NORMAL)
