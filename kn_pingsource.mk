_KN_PINGSOURCE_MK_VERSION= $(_KN_MK_VERSION)

# KN_PINGSOURCE_CURL_BIN?= time curl
# KN_PINGSOURCE_NAME?= helloworld-go
# KN_PINGSOURCE_NAMESPACE_NAME?= eventing-example
# KN_PINGSOURCES_NAMESPACE_NAME?= eventing-example
# KN_PINGSOURCES_SET_NAME?= my-pingsources-set

# Derived parameters
KN_PINGSOURCE_NAMESPACE_NAME?= $(KN_NAMESPACE_NAME)
KN_PINGSOURCES_NAMESPACE_NAME?= $(KN_PINGSOURCE_NAMESPACE_NAME)
KN_PINGSOURCES_SET_NAME?= knative-sources@@@$(KN_PINGSOURCES_NAMESPACE_NAME)

# Option parameters
# __KN_ALL_NAMESPACES__PINGSOURCES=
__KN_NAMESPACE__PINGSOURCE= $(if $(KN_PINGSOURCE_NAMESPACE_NAME),--namespace $(KN_PINGSOURCE_NAMESPACE_NAME))
__KN_NAMESPACE__PINGSOURCES= $(if $(KN_PINGSOURCES_NAMESPACE_NAME),--namespace $(KN_PINGSOURCES_NAMESPACE_NAME))

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kn_list_macros ::
	@#echo 'KN::PingSource ($(_KN_PINGSOURCE_MK_VERSION)) macros:'
	@#echo

_kn_list_parameters ::
	@echo 'KN::PingSource ($(_KN_PINGSOURCE_MK_VERSION)) parameters:'
	@echo '    KN_PINGSOURCE_NAME=$(KN_PINGSOURCE_NAME)'
	@echo '    KN_PINGSOURCE_NAMESPACE_NAME=$(KN_PINGSOURCE_NAMESPACE_NAME)'
	@echo '    KN_PINGSOURCES_NAMESPACE_NAME=$(KN_PINGSOURCES_NAMESPACE_NAME)'
	@echo '    KN_PINGSOURCES_SET_NAME=$(KN_PINGSOURCES_SET_NAME)'
	@echo

_kn_list_targets ::
	@echo 'KN::PingSource ($(_KN_PINGSOURCE_MK_VERSION)) targets:'
	@echo '    _kn_create_pingsource                  - Create a new ping-source'
	@echo '    _kn_delete_pingsource                  - Delete an existing ping-source'
	@echo '    _kn_list_pingsources                   - List all ping-sources'
	@echo '    _kn_list_pingsources_set               - List a set of ping-sources'
	@echo '    _kn_show_pingsource                    - Show everything related to a ping-source'
	@echo '    _kn_show_pingsource_description        - Show the description of a ping-source'
	@#echo '    _kn_watch_pingsources                  - Watch ping-sources'
	@#echo '    _kn_watch_pingsources_set              - Watch a set of ping-sources'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kn_create_pingsource:
	@$(INFO) '$(KN_UI_LABEL)Creating ping-source "$(KN_PINGSOURCE_NAME)" ...'; $(NORMAL)
	$(KN) source ping create ... $(__KN_NAMESPACE__PINGSOURCE)

_kn_delete_pingsource:
	@$(INFO) '$(KN_UI_LABEL)Deleting ping-source "$(KN_PINGSOURCE_NAME)" ...'; $(NORMAL)

_kn_list_pingsources:
	@$(INFO) '$(KN_UI_LABEL)Listing ALL ping-sources ...'; $(NORMAL)
	$(KN) source ping list --all-namespaces=true $(_X__KN_NAMESPACE__PINGSOURCES)

_kn_list_pingsources_set:
	@$(INFO) '$(KN_UI_LABEL)Listing ping-sources-set "$(KN_PINGSOURCES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'sources are grouped based on the provided namespace, and ...'; $(NORMAL)
	$(KN) source ping list --all-namespaces=false $(__KN_NAMESPACE__PINGSOURCES)

_kn_show_pingsource: _kn_show_pingsource_description

_kn_show_pingsource_description:
	@$(INFO) '$(KN_UI_LABEL)Showing description ping-source "$(KN_PINGSOURCE_NAME)" ...'; $(NORMAL)
	$(KN) source ping describe $(__KN_NAMESPACE__PINGSOURCE) $(KN_PINGSOURCE_NAME)

_kn_update_pingsource:
	@$(INFO) '$(KN_UI_LABEL)Updating ping-source "$(KN_PINGSOURCE_NAME)" ...'; $(NORMAL)

_kn_watch_pingsources:
	@$(INFO) '$(KN_UI_LABEL)Watching ping-sources ...'; $(NORMAL)

_kn_watch_pingsources_set:
	@$(INFO) '$(KN_UI_LABEL)Watching ping-sources ...'; $(NORMAL)
