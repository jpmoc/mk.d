_KN_REVISION_MK_VERSION= $(_KN_MK_VERSION)

# KN_REVISION_CURL?= time curl
# KN_REVISION_NAME?= helloworld-go
# KN_REVISION_NAMESPACE_NAME?= eventing-example
# KN_REVISIONS_NAMESPACE_NAME?= eventing-example
# KN_REVISIONS_SET_NAME?= my-revisions-set

# Derived parameters
KN_REVISION_NAMESPACE_NAME?= $(KN_NAMESPACE_NAME)
KN_REVISIONS_NAMESPACE_NAME?= $(KN_REVISION_NAMESPACE_NAME)
KN_REVISIONS_SET_NAME?= knative-revisions@@@$(KN_REVISIONS_NAMESPACE_NAME)

# Option parameters
# __KN_ALL_NAMESPACES__REVISIONS=
__KN_NAMESPACE__REVISION= $(if $(KN_REVISION_NAMESPACE_NAME),--namespace $(KN_REVISION_NAMESPACE_NAME))
__KN_NAMESPACE__REVISIONS= $(if $(KN_REVISIONS_NAMESPACE_NAME),--namespace $(KN_REVISIONS_NAMESPACE_NAME))

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kn_list_macros ::
	@#echo 'KN::Revision ($(_KN_REVISION_MK_VERSION)) macros:'
	@#echo

_kn_list_parameters ::
	@echo 'KN::Revision ($(_KN_REVISION_MK_VERSION)) parameters:'
	@echo '    KN_REVISION_NAME=$(KN_REVISION_NAME)'
	@echo '    KN_REVISION_NAMESPACE_NAME=$(KN_REVISION_NAMESPACE_NAME)'
	@echo '    KN_REVISIONS_NAMESPACE_NAME=$(KN_REVISIONS_NAMESPACE_NAME)'
	@echo '    KN_REVISIONS_SET_NAME=$(KN_REVISIONS_SET_NAME)'
	@echo

_kn_list_targets ::
	@echo 'KN::Revision ($(_KN_REVISION_MK_VERSION)) targets:'
	@echo '    _kn_create_revision                  - Create a new revision'
	@echo '    _kn_delete_revision                  - Delete an existing revision'
	@echo '    _kn_list_revisions                   - List all revisions'
	@echo '    _kn_list_revisions_set               - List a set of revisions'
	@echo '    _kn_show_revision                    - Show everything related to a revision'
	@echo '    _kn_show_revision_description        - Show the description of a revision'
	@#echo '    _kn_watch_revisions                  - Watch revisions'
	@#echo '    _kn_watch_revisions_set              - Watch a set of revisions'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kn_create_revision:
	@$(INFO) '$(KN_UI_LABEL)Creating revision "$(KN_REVISION_NAME)" ...'; $(NORMAL)
	$(KN) revision create ... $(__KN_NAMESPACE__REVISION_REVISION_NAME)

_kn_delete_revision:
	@$(INFO) '$(KN_UI_LABEL)Deleting revision "$(KN_REVISION_NAME)" ...'; $(NORMAL)

_kn_list_revisions:
	@$(INFO) '$(KN_UI_LABEL)Listing ALL revisions ...'; $(NORMAL)
	$(KN) revision list --all-namespaces=true $(_X__KN_NAMESPACE__REVISIONS)

_kn_list_revisions_set:
	@$(INFO) '$(KN_UI_LABEL)Listing revisions-set "$(KN_REVISIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'revisions are grouped based on the provided namespace, and ...'; $(NORMAL)
	$(KN) revision list --all-namespaces=false $(__KN_NAMESPACE__REVISIONS)

_kn_show_revision: _kn_show_revision_description

_kn_show_revision_description:
	@$(INFO) '$(KN_UI_LABEL)Showing description revision "$(KN_REVISION_NAME)" ...'; $(NORMAL)
	$(KN) revision describe $(__KN_NAMESPACE__REVISION) $(KN_REVISION_NAME)

_kn_update_revision:
	@$(INFO) '$(KN_UI_LABEL)Updating revision "$(KN_REVISION_NAME)" ...'; $(NORMAL)

_kn_watch_revisions:
	@$(INFO) '$(KN_UI_LABEL)Watching revisions ...'; $(NORMAL)

_kn_watch_revisions_set:
	@$(INFO) '$(KN_UI_LABEL)Watching revisions ...'; $(NORMAL)
