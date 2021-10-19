_KUBECTL_CONTOUR_EXTENSIONSERVICE_MK_VERSION= $(_KUBECTL_CONTOUR_MK_VERSION)

# KCL_EXTENSIONSERVICE_LABELS_KEYVALUES?= key=value ...
# KCL_EXTENSIONSERVICE_NAME?= 
# KCL_EXTENSIONSERVICE_NAMESPACE_NAME?= default
# KCL_EXTENSIONSERVICES_FIELDSELECTOR?= metadata.name=my-extension-service
# KCL_EXTENSIONSERVICES_MANIFEST_DIRPATH?= ./in/
# KCL_EXTENSIONSERVICES_MANIFEST_FILENAME?= manifest.yaml 
# KCL_EXTENSIONSERVICES_MANIFEST_FILEPATH?= ./in/manifest.yaml 
# KCL_EXTENSIONSERVICES_MANIFEST_URL?= http://...
# KCL_EXTENSIONSERVICES_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_EXTENSIONSERVICES_NAMESPACE_NAME?= default
# KCL_EXTENSIONSERVICES_SELECTOR?=
# KCL_EXTENSIONSERVICES_SET_NAME?= my-extension-services-set

# Derived parameters
KCL_EXTENSIONSERVICE_ISSUER_NAME?= $(KCL_ISSUER_NAME)
KCL_EXTENSIONSERVICE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_EXTENSIONSERVICE_SECRET_NAME?= $(KCL_SECRET_NAME)
KCL_EXTENSIONSERVICES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_EXTENSIONSERVICES_MANIFEST_FILEPATH?= $(if $(KCL_EXTENSIONSERVICES_MANIFEST_FILENAME),$(KCL_EXTENSIONSERVICES_MANIFEST_DIRPATH)$(KCL_EXTENSIONSERVICES_MANIFEST_FILENAME))
KCL_EXTENSIONSERVICES_NAMESPACE_NAME?= $(KCL_EXTENSIONSERVICE_NAMESPACE_NAME)
KCL_EXTENSIONSERVICES_SET_NAME?= extensionservices@@@$(KCL_EXTENSIONSERVICES_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__EXTENSIONSERVICES+= $(if $(KCL_EXTENSIONSERVICES_MANIFEST_FILEPATH),--filename $(KCL_EXTENSIONSERVICES_MANIFEST_FILEPATH))
__KCL_FILENAME__EXTENSIONSERVICES+= $(if $(KCL_EXTENSIONSERVICES_MANIFEST_URL),--filename $(KCL_EXTENSIONSERVICES_MANIFEST_URL))
__KCL_FILENAME__EXTENSIONSERVICES+= $(if $(KCL_EXTENSIONSERVICES_MANIFESTS_DIRPATH),--filename $(KCL_EXTENSIONSERVICES_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__EXTENSIONSERVICE= $(if $(KCL_EXTENSIONSERVICE_NAMESPACE_NAME),--namespace $(KCL_EXTENSIONSERVICE_NAMESPACE_NAME))
__KCL_NAMESPACE__EXTENSIONSERVICES= $(if $(KCL_EXTENSIONSERVICES_NAMESPACE_NAME),--namespace $(KCL_EXTENSIONSERVICES_NAMESPACE_NAME))

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Contour::ExtensionService ($(_KUBECTL_CONTOUR_EXTENSIONSERVICE_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Contour::ExtensionService ($(_KUBECTL_CONTOUR_EXTENSIONSERVICE_MK_VERSION)) parameters:'
	@echo '    KCL_EXTENSIONSERVICE_LABELS_KEYVALUES=$(KCL_EXTENSIONSERVICE_LABELS_KEYVALUES)'
	@echo '    KCL_EXTENSIONSERVICE_NAME=$(KCL_EXTENSIONSERVICE_NAME)'
	@echo '    KCL_EXTENSIONSERVICE_NAMESPACE_NAME=$(KCL_EXTENSIONSERVICE_NAMESPACE_NAME)'
	@echo '    KCL_EXTENSIONSERVICE_SECRET_NAME=$(KCL_EXTENSIONSERVICE_SECRET_NAME)'
	@echo '    KCL_EXTENSIONSERVICES_FIELDSELECTOR=$(KCL_EXTENSIONSERVICES_FIELDSELECTOR)'
	@echo '    KCL_EXTENSIONSERVICES_MANIFEST_DIRPATH=$(KCL_EXTENSIONSERVICES_MANIFEST_DIRPATH)'
	@echo '    KCL_EXTENSIONSERVICES_MANIFEST_FILENAME=$(KCL_EXTENSIONSERVICES_MANIFEST_FILENAME)'
	@echo '    KCL_EXTENSIONSERVICES_MANIFEST_FILEPATH=$(KCL_EXTENSIONSERVICES_MANIFEST_FILEPATH)'
	@echo '    KCL_EXTENSIONSERVICES_MANIFEST_URL=$(KCL_EXTENSIONSERVICES_MANIFEST_URL)'
	@echo '    KCL_EXTENSIONSERVICES_MANIFESTS_DIRPATH=$(KCL_EXTENSIONSERVICES_MANIFESTS_DIRPATH)'
	@echo '    KCL_EXTENSIONSERVICES_NAMESPACE_NAME=$(KCL_EXTENSIONSERVICES_NAMESPACE_NAME)'
	@echo '    KCL_EXTENSIONSERVICES_SELECTOR=$(KCL_EXTENSIONSERVICES_SELECTOR)'
	@echo '    KCL_EXTENSIONSERVICES_SET_NAME=$(KCL_EXTENSIONSERVICES_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Contour::ExtensionService ($(_KUBECTL_CONTOUR_EXTENSIONSERVICE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_extensionservice                  - Annotate a extension-service'
	@echo '    _kcl_apply_extensionservices                    - Apply a manifest for one-or-more extension-services'
	@echo '    _kcl_create_extensionservice                    - Create a new extension-service'
	@echo '    _kcl_delete_extensionservice                    - Delete an existing extension-service'
	@echo '    _kcl_diff_extensionservices                     - Diff a manifest for one or more extension-services'
	@echo '    _kcl_edit_extensionservice                      - Edit a extension-service'
	@echo '    _kcl_explain_extensionservice                   - Explain the extension-service object'
	@echo '    _kcl_show_extensionservice                      - Show everything related to a extension-service'
	@echo '    _kcl_show_extensionservice_description          - Show description of a extension-service'
	@echo '    _kcl_show_extensionservice_issuer               - Show issuer of a extension-service'
	@echo '    _kcl_show_extensionservice_secret               - Show secret of a extension-service'
	@echo '    _kcl_show_extensionservice_state                - Show state of a extension-service'
	@echo '    _kcl_unapply_extensionservices                  - Un-apply a manifest for one-or-more extension-service'
	@echo '    _kcl_unlabel_extensionservice                   - Un-label a extension-service'
	@echo '    _kcl_view_extensionservices                     - View ALL extension-services'
	@echo '    _kcl_view_extensionservices_set                 - View set of extension-services'
	@echo '    _kcl_watch_extensionservices                    - Watch ALL extension-services'
	@echo '    _kcl_watch_extensionservices_set                - Watch a set of extension-services'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_extensionservice:
	@$(INFO) '$(KCL_UI_LABEL)Annotating extension-service "$(KCL_EXTENSIONSERVICE_NAME)" ...'; $(NORMAL)

_kcl_apply_extensionservice: _kcl_apply_extensionservices
_kcl_apply_extensionservices:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more extension-services ...'; $(NORMAL)
	$(if $(KCL_EXTENSIONSERVICES_MANIFEST_FILEPATH), cat $(KCL_EXTENSIONSERVICES_MANIFEST_FILEPATH); echo)
	$(if $(KCL_EXTENSIONSERVICES_MANIFEST_URL), curl -L $(KCL_EXTENSIONSERVICES_MANIFEST_URL); echo)
	$(if $(KCL_EXTENSIONSERVICES_MANIFESTS_DIRPATH), ls -al $(KCL_EXTENSIONSERVICES_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__EXTENSIONSERVICES) $(__KCL_NAMESPACE__EXTENSIONSERVICES)

_kcl_create_extensionservice:
	@$(INFO) '$(KCL_UI_LABEL)Creating extension-service "$(KCL_EXTENSIONSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create extensionservice $(__KCL_NAMESPACE__EXTENSIONSERVICE) $(KCL_EXTENSIONSERVICE_NAME)

_kcl_delete_extensionservice:
	@$(INFO) '$(KCL_UI_LABEL)Deleting extension-service "$(KCL_EXTENSIONSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete extensionservice $(__KCL_NAMESPACE__EXTENSIONSERVICE) $(KCL_EXTENSIONSERVICE_NAME)

_kcl_diff_extensionservice: _kcl_diff_extensionservices
_kcl_diff_extensionservices:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more extension-services ...'; $(NORMAL)
	# cat $(KCL_EXTENSIONSERVICES_MANIFEST_FILEPATH)
	# curl -L $(KCL_EXTENSIONSERVICES_MANIFEST_URL)
	# ls -al $(KCL_EXTENSIONSERVICES_MANIFESTS_DIRPATH)
	$(KUBECTL) diff $(__KCL_FILENAME__EXTENSIONSERVICES) $(__KCL_NAMESPACE__EXTENSIONSERVICES)

_kcl_edit_extensionservice:
	@$(INFO) '$(KCL_UI_LABEL)Editing extension-service "$(KCL_EXTENSIONSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit extensionservice $(__KCL_NAMESPACE__EXTENSIONSERVICE) $(KCL_EXTENSIONSERVICE_NAME)

_kcl_explain_extensionservice:
	@$(INFO) '$(KCL_UI_LABEL)Explaining extension-service object ...'; $(NORMAL)
	$(KUBECTL) explain extensionservice

_kcl_label_extensionservice:
	@$(INFO) '$(KCL_UI_LABEL)Labelling extension-service "$(KCL_EXTENSIONSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label extensionservice $(__KCL_NAMESPACE__EXTENSIONSERVICE) $(KCL_EXTENSIONSERVICE_NAME) $(KCL_EXTENSIONSERVICE_LABELS_KEYVALUES)

_kcl_show_extensionservice :: _kcl_show_extensionservice_description

_kcl_show_extensionservice_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of extension-service "$(KCL_EXTENSIONSERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe extensionservice $(__KCL_NAMESPACE__EXTENSIONSERVICE) $(KCL_EXTENSIONSERVICE_NAME) 

_kcl_unapply_extensionservice: _kcl_unapply_extensionservices
_kcl_unapply_extensionservices:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more extension-services ...'; $(NORMAL)
	# cat $(KCL_EXTENSIONSERVICES_MANIFEST_FILEPATH)
	# curl -L $(KCL_EXTENSIONSERVICES_MANIFEST_URL)
	# ls -al $(KCL_EXTENSIONSERVICES_MANIFESTS_DIRPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__EXTENSIONSERVICES) $(__KCL_NAMESPACE__EXTENSIONSERVICES)

_kcl_unlabel_extensionservice:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling extension-service "$(KCL_EXTENSIONSERVICE_NAME)" ...'; $(NORMAL)

_kcl_view_extensionservices:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL extension-services ...'; $(NORMAL)
	$(KUBECTL) get extensionservices --all-namespaces=true $(_X__KCL_NAMESPACE__EXTENSIONSERVICES) $(_X__KCL_SELECTOR_EXTENSIONSERVICES)

_kcl_view_extensionservices_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing extension-services-set "$(KCL_EXTENSIONSERVICES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'extension-services are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
	$(KUBECTL) get extensionservices --all-namespaces=false $(__KCL_FIELD_SELECTOR__EXTENSIONSERVICES) $(__KCL_NAMESPACE__EXTENSIONSERVICES) $(__KCL_SELECTOR__EXTENSIONSERVICES)

_kcl_watch_extensionservices:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL extension-services ...'; $(NORMAL)

_kcl_watch_extensionservices_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching extensionservices-set "$(KCL_EXTENSIONSERVICES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'extension-services are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
