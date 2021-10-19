_KUBECTL_ISTIO_SERVICEENTRY_MK_VERSION= $(_KUBECTL_ISTIO_MK_VERSION)

# KCL_SERVICEENTRY_LABELS_KEYVALUES?=
# KCL_SERVICEENTRY_MANIFEST_DIRPATH?=
# KCL_SERVICEENTRY_MANIFEST_FILENAME?=
# KCL_SERVICEENTRY_MANIFEST_FILEPATH?=
# KCL_SERVICEENTRY_NAME?= default
# KCL_SERVICEENTRY_OUTPUT_FORMAT?=
# KCL_SERVICEENTRIES_FIELDSELECTOR?= metadat.name=my-service-entry
# KCL_SERVICEENTRIES_OUTPUT_FORMAT?=
# KCL_SERVICEENTRIES_SELECTOR?=
# KCL_SERVICEENTRIES_SET_NAME?=
# KCL_SERVICEENTRIES_SORTBY?=

# Derived parameters
KCL_SERVICEENTRY_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SERVICEENTRY_MANIFEST_FILEPATH?= $(KCL_SERVICEENTRY_MANIFEST_DIRPATH)$(KCL_SERVICEENTRY_MANIFEST_FILENAME)
KCL_SERVICEENTRIES_SET_NAME?= service-entries@$(KCL_SERVICEENTRY_FIELDSELECTOR)@$(KCL_SERVICEENTRY_SELECTOR)

# Option parameters
__KCL_FILENAME__SERVICEENTRY= $(if $(KCL_SERVICEENTRY_MANIFEST_FILEPATH),--filename $(KCL_SERVICEENTRY_MANIFEST_FILEPATH))
__KCL_LABELS__SERVICEENTRY= $(if $(KCL_SERVICEENTRY_LABELS_KEYVALUES),--labels $(KCL_SERVICEENTRY_LABELS_KEYVALUES))
__KCL_NASERVICEENTRE__SERVICEENTRY= $(if $(KCL_SERVICEENTRY_NASERVICEENTRE_NAME),--namespace $(KCL_SERVICEENTRY_NASERVICEENTRE_NAME))
__KCL_NASERVICEENTRE__SERVICEENTRIES= $(if $(KCL_SERVICEENTRIES_NASERVICEENTRE_NAME),--namespace $(KCL_SERVICEENTRIES_NASERVICEENTRE_NAME))
__KCL_OUTPUT__SERVICEENTRY= $(if $(KCL_SERVICEENTRY_OUTPUT_FORMAT),--output $(KCL_SERVICEENTRY_OUTPUT_FORMAT))
__KCL_OUTPUT__SERVICEENTRIES= $(if $(KCL_SERVICEENTRIES_OUTPUT_FORMAT),--output $(KCL_SERVICEENTRIES_OUTPUT_FORMAT))
__KCL_SELECTOR__SERVICEENTRIES= $(if $(KCL_SERVICEENTRIES_SELECTOR),--selector=$(KCL_SERVICEENTRIES_SELECTOR))
__KCL_SORT_BY__SERVICEENTRIES= $(if $(KCL_SERVICEENTRIES_SORTBY),--sort-by=$(KCL_SERVICEENTRIES_SORTBY))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Istio::ServiceEntry ($(_KUBECTL_ISTIO_SERVICEENTRY_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Istio::ServiceEntry ($(_KUBECTL_ISTIO_SERVICEENTRY_MK_VERSION)) parameters:'
	@echo '    KCL_SERVICEENTRY_LABELS_KEYVALUES=$(KCL_SERVICEENTRY_LABELS_KEYVALUES)'
	@echo '    KCL_SERVICEENTRY_MANIFEST_DIRPATH=$(KCL_SERVICEENTRY_MANIFEST_DIRPATH)'
	@echo '    KCL_SERVICEENTRY_MANIFEST_FILENAME=$(KCL_SERVICEENTRY_MANIFEST_FILENAME)'
	@echo '    KCL_SERVICEENTRY_MANIFEST_FILEPATH=$(KCL_SERVICEENTRY_MANIFEST_FILEPATH)'
	@echo '    KCL_SERVICEENTRY_NAME=$(KCL_SERVICEENTRY_NAME)'
	@echo '    KCL_SERVICEENTRY_OUTPUT_FORMAT=$(KCL_SERVICEENTRY_OUTPUT_FORMAT)'
	@echo '    KCL_SERVICEENTRIES_FIELDSELECTOR=$(KCL_SERVICEENTRIES_FIELDSELECTOR)'
	@echo '    KCL_SERVICEENTRIES_OUTPUT_FORMAT=$(KCL_SERVICEENTRIES_OUTPUT_FORMAT)'
	@echo '    KCL_SERVICEENTRIES_SELECTOR=$(KCL_SERVICEENTRIES_SELECTOR)'
	@echo '    KCL_SERVICEENTRIES_SET_NAME=$(KCL_SERVICEENTRIES_SET_NAME)'
	@echo '    KCL_SERVICEENTRIES_SORTBY=$(KCL_SERVICEENTRIES_SORTBY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Istio::ServiceEntry ($(_KUBECTL_ISTIO_SERVICEENTRY_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_serviceentry                - Annotate a service-entry'
	@echo '    _kcl_apply_serviceentry                   - Apply a service-entry'
	@echo '    _kcl_create_serviceentry                  - Create a service-entry'
	@echo '    _kcl_delete_serviceentry                  - Delete a service-entry'
	@echo '    _kcl_edit_serviceentry                    - Edit a service-entry'
	@echo '    _kcl_explain_serviceentry                 - Explain service-entry'
	@echo '    _kcl_label_serviceentry                   - Label a service-entry'
	@echo '    _kcl_show_serviceentry                    - Show everything related to a service-entry'
	@echo '    _kcl_show_serviceentry_description        - Show description of a service-entry'
	@echo '    _kcl_show_serviceentry_object             - Show object of a service-entry'
	@echo '    _kcl_show_serviceentry_state              - Show state of a service-entry'
	@echo '    _kcl_unapply_serviceentry                 - Unapply a manifest for a service-entry'
	@echo '    _kcl_unlabel_serviceentry                 - Unlabel a service-entry'
	@echo '    _kcl_view_serviceentries                  - View all service-entries'
	@echo '    _kcl_view_serviceentries_set              - View a set of service-entries'
	@echo '    _kcl_watch_serviceentries                 - Watch service-entries'
	@echo '    _kcl_watch_serviceentries_set             - Watch a set of service-entries'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_serviceentry:
	@$(INFO) '$(KCL_UI_LABEL)Annotating service-entry "$(KCL_SERVICEENTRY_NAME)" ...'; $(NORMAL)

_kcl_apply_serviceentry:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for service-entry "$(KCL_SERVICEENTRY_NAME)" ...'; $(NORMAL)
	cat $(KCL_SERVICEENTRY_MANIFEST_FILEPATH)
	$(KUBECTL) apply $(__KCL_FILENAME__SERVICEENTRY)

_kcl_create_serviceentry:
	@$(INFO) '$(KCL_UI_LABEL)Creating service-entry "$(KCL_SERVICEENTRY_NAME)" ...'; $(NORMAL)

_kcl_delete_serviceentry:
	@$(INFO) '$(KCL_UI_LABEL)Deleting service-entry "$(KCL_SERVICEENTRY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete serviceentry $(KCL_SERVICEENTRY_NAME)

_kcl_edit_serviceentry:
	@$(INFO) '$(KCL_UI_LABEL)Editing service-entry "$(KCL_SERVICEENTRY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit serviceentry $(KCL_SERVICEENTRY_NAME)

_kcl_explain_serviceentry:
	@$(INFO) '$(KCL_UI_LABEL)Explaining service-entry object ...'; $(NORMAL)
	$(KUBECTL) explain serviceentry

_kcl_labe_serviceentry:
	@$(INFO) '$(KCL_UI_LABEL)Labeling service-entry "$(KCL_SERVICEENTRY_NAME)" ...'; $(NORMAL)

_kcl_show_serviceentry: _kcl_show_serviceentry_object _kcl_show_serviceentry_state _kcl_show_serviceentry_description

_kcl_show_serviceentry_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description service-entry "$(KCL_SERVICEENTRY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe serviceentry $(KCL_SERVICEENTRY_NAME)

_kcl_show_serviceentry_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of service-entry "$(KCL_SERVICEENTRY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get serviceentry $(_X__KCL_OUTPUT__SERVICEENTRY) --output yaml $(KCL_SERVICEENTRY_NAME)

_kcl_show_serviceentry_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of service-entry "$(KCL_SERVICEENTRY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get serviceentry $(_X__KCL_OUTPUT__SERVICEENTRY) $(KCL_SERVICEENTRY_NAME)

_kcl_unapply_serviceentry:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for service-entry "$(KCL_SERVICEENTRY_NAME)" ...'; $(NORMAL)
	cat $(KCL_SERVICEENTRY_MANIFEST_FILEPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__SERVICEENTRY)

_kcl_unlabel_serviceentry:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling service-entry "$(KCL_SERVICEENTRY_NAME)" ...'; $(NORMAL)

_kcl_view_serviceentries:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL service-entries ...'; $(NORMAL)
	$(KUBECTL) get serviceentries --all-namespaces=true $(__KCL_OUTPUT__SERVICEENTRIES) $(_X__KCL_SELECTOR__SERVICEENTRIES) $(__KCL_SORT_BY__SERVICEENTRIES)

_kcl_view_serviceentries_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing service-entries-set "$(KCL_SERVICEENTRIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Service-entries are grouped based on the provided namespace, selector, and ...'; $(NORMAL)
	$(KUBECTL) get serviceentries --all-namespaces=false $(__KCL_OUTPUT__SERVICEENTRIES) $(__KCL_SELECTOR__SERVICEENTRIES) $(__KCL_SORT_BY__SERVICEENTRIES)

_kcl_watch_serviceentries:
	@$(INFO) '$(KCL_UI_LABEL)Watching service-entries ...'; $(NORMAL)
	$(KUBECTL) get serviceentries --all-namespaces=true --watch 

_kcl_watch_serviceentries_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching service-entries-set "$(KCL_SERVICEENTRIES_SET_NAME)" ...'; $(NORMAL)
