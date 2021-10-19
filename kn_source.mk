_KN_SOURCE_MK_VERSION= $(_KN_MK_VERSION)

# KN_SOURCE_CURL_BIN?= time curl
# KN_SOURCE_NAME?= helloworld-go
# KN_SOURCE_NAMESPACE_NAME?= eventing-example
# KN_SOURCES_NAMESPACE_NAME?= eventing-example
# KN_SOURCES_SET_NAME?= my-sources-set

# Derived parameters
KN_SOURCE_NAMESPACE_NAME?= $(KN_NAMESPACE_NAME)
KN_SOURCES_NAMESPACE_NAME?= $(KN_SOURCE_NAMESPACE_NAME)
KN_SOURCES_SET_NAME?= knative-sources@@@$(KN_SOURCES_NAMESPACE_NAME)

# Option parameters
# __KN_ALL_NAMESPACES__SOURCES=
__KN_NAMESPACE__SOURCE= $(if $(KN_SOURCE_NAMESPACE_NAME),--namespace $(KN_SOURCE_NAMESPACE_NAME))
__KN_NAMESPACE__SOURCES= $(if $(KN_SOURCES_NAMESPACE_NAME),--namespace $(KN_SOURCES_NAMESPACE_NAME))

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kn_view_framework_macros ::
	@echo 'KN::Source ($(_KN_SOURCE_MK_VERSION)) macros:'
	@echo

_kn_view_framework_parameters ::
	@echo 'KN::Source ($(_KN_SOURCE_MK_VERSION)) parameters:'
	@echo '    KN_SOURCE_NAME=$(KN_SOURCE_NAME)'
	@echo '    KN_SOURCE_NAMESPACE_NAME=$(KN_SOURCE_NAMESPACE_NAME)'
	@echo '    KN_SOURCES_NAMESPACE_NAME=$(KN_SOURCES_NAMESPACE_NAME)'
	@echo '    KN_SOURCES_SET_NAME=$(KN_SOURCES_SET_NAME)'
	@echo

_kn_view_framework_targets ::
	@echo 'KN::Source ($(_KN_SOURCE_MK_VERSION)) targets:'
	@echo '    _kn_create_source                  - Create a new source'
	@echo '    _kn_delete_source                  - Delete an existing source'
	@echo '    _kn_show_source                    - Show everything related to a source'
	@echo '    _kn_show_source_description        - Show the description of a source'
	@echo '    _kn_view_sources                   - View all sources'
	@echo '    _kn_view_sources_set               - View a set of sources'
	@#echo '    _kn_watch_sources                  - Watch sources'
	@#echo '    _kn_watch_sources_set              - Watch a set of sources'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kn_create_source:
	@$(INFO) '$(KN_UI_LABEL)Creating source "$(KN_SOURCE_NAME)" ...'; $(NORMAL)
	$(KN) source create ... $(__KN_NAMESPACE__SOURCE)

_kn_delete_source:
	@$(INFO) '$(KN_UI_LABEL)Deleting source "$(KN_SOURCE_NAME)" ...'; $(NORMAL)

_kn_show_source: _kn_show_source_description

_kn_show_source_description:
	@$(INFO) '$(KN_UI_LABEL)Showing description source "$(KN_SOURCE_NAME)" ...'; $(NORMAL)
	$(KN) source describe $(__KN_NAMESPACE__SOURCE) $(KN_SOURCE_NAME)

_kn_update_source:
	@$(INFO) '$(KN_UI_LABEL)Updating source "$(KN_SOURCE_NAME)" ...'; $(NORMAL)

_kn_view_sources:
	@$(INFO) '$(KN_UI_LABEL)Viewing sources ...'; $(NORMAL)
	$(KN) source list --all-namespaces=true $(_X__KN_NAMESPACE__SOURCES)

_kn_view_sources_set:
	@$(INFO) '$(KN_UI_LABEL)Viewing sources-set "$(KN_SOURCES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'sources are grouped based on the provided namespace, and ...'; $(NORMAL)
	$(KN) source list --all-namespaces=false $(__KN_NAMESPACE__SOURCES)

_kn_watch_sources:
	@$(INFO) '$(KN_UI_LABEL)Watching sources ...'; $(NORMAL)

_kn_watch_sources_set:
	@$(INFO) '$(KN_UI_LABEL)Watching sources ...'; $(NORMAL)
