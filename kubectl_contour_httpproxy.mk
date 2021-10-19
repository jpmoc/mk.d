_KUBECTL_CONTOUR_HTTPPROXY_MK_VERSION= $(_KUBECTL_CONTOUR_MK_VERSION)

# KCL_HTTPPROXY_LABELS_KEYVALUES?= key=value ...
# KCL_HTTPPROXY_NAME?= 
# KCL_HTTPPROXY_NAMESPACE_NAME?= default
# KCL_HTTPPROXIES_FIELDSELECTOR?= metadata.name=my-http-proxy
# KCL_HTTPPROXIES_MANIFEST_DIRPATH?= ./in/
# KCL_HTTPPROXIES_MANIFEST_FILENAME?= manifest.yaml 
# KCL_HTTPPROXIES_MANIFEST_FILEPATH?= ./in/manifest.yaml 
# KCL_HTTPPROXIES_MANIFEST_URL?= http://...
# KCL_HTTPPROXIES_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_HTTPPROXIES_NAMESPACE_NAME?= default
# KCL_HTTPPROXIES_SELECTOR?=
# KCL_HTTPPROXIES_SET_NAME?= my-http-proxies-set

# Derived parameters
KCL_HTTPPROXY_ISSUER_NAME?= $(KCL_ISSUER_NAME)
KCL_HTTPPROXY_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_HTTPPROXY_SECRET_NAME?= $(KCL_SECRET_NAME)
KCL_HTTPPROXIES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_HTTPPROXIES_MANIFEST_FILEPATH?= $(if $(KCL_HTTPPROXIES_MANIFEST_FILENAME),$(KCL_HTTPPROXIES_MANIFEST_DIRPATH)$(KCL_HTTPPROXIES_MANIFEST_FILENAME))
KCL_HTTPPROXIES_NAMESPACE_NAME?= $(KCL_HTTPPROXY_NAMESPACE_NAME)
KCL_HTTPPROXIES_SET_NAME?= httpproxies@@@$(KCL_HTTPPROXIES_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__HTTPPROXIES+= $(if $(KCL_HTTPPROXIES_MANIFEST_FILEPATH),--filename $(KCL_HTTPPROXIES_MANIFEST_FILEPATH))
__KCL_FILENAME__HTTPPROXIES+= $(if $(KCL_HTTPPROXIES_MANIFEST_URL),--filename $(KCL_HTTPPROXIES_MANIFEST_URL))
__KCL_FILENAME__HTTPPROXIES+= $(if $(KCL_HTTPPROXIES_MANIFESTS_DIRPATH),--filename $(KCL_HTTPPROXIES_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__HTTPPROXY= $(if $(KCL_HTTPPROXY_NAMESPACE_NAME),--namespace $(KCL_HTTPPROXY_NAMESPACE_NAME))
__KCL_NAMESPACE__HTTPPROXIES= $(if $(KCL_HTTPPROXIES_NAMESPACE_NAME),--namespace $(KCL_HTTPPROXIES_NAMESPACE_NAME))

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Contour::HttpProxy ($(_KUBECTL_CONTOUR_HTTPPROXY_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Contour::HttpProxy ($(_KUBECTL_CONTOUR_HTTPPROXY_MK_VERSION)) parameters:'
	@echo '    KCL_HTTPPROXY_LABELS_KEYVALUES=$(KCL_HTTPPROXY_LABELS_KEYVALUES)'
	@echo '    KCL_HTTPPROXY_NAME=$(KCL_HTTPPROXY_NAME)'
	@echo '    KCL_HTTPPROXY_NAMESPACE_NAME=$(KCL_HTTPPROXY_NAMESPACE_NAME)'
	@echo '    KCL_HTTPPROXY_SECRET_NAME=$(KCL_HTTPPROXY_SECRET_NAME)'
	@echo '    KCL_HTTPPROXIES_FIELDSELECTOR=$(KCL_HTTPPROXIES_FIELDSELECTOR)'
	@echo '    KCL_HTTPPROXIES_MANIFEST_DIRPATH=$(KCL_HTTPPROXIES_MANIFEST_DIRPATH)'
	@echo '    KCL_HTTPPROXIES_MANIFEST_FILENAME=$(KCL_HTTPPROXIES_MANIFEST_FILENAME)'
	@echo '    KCL_HTTPPROXIES_MANIFEST_FILEPATH=$(KCL_HTTPPROXIES_MANIFEST_FILEPATH)'
	@echo '    KCL_HTTPPROXIES_MANIFEST_URL=$(KCL_HTTPPROXIES_MANIFEST_URL)'
	@echo '    KCL_HTTPPROXIES_MANIFESTS_DIRPATH=$(KCL_HTTPPROXIES_MANIFESTS_DIRPATH)'
	@echo '    KCL_HTTPPROXIES_NAMESPACE_NAME=$(KCL_HTTPPROXIES_NAMESPACE_NAME)'
	@echo '    KCL_HTTPPROXIES_SELECTOR=$(KCL_HTTPPROXIES_SELECTOR)'
	@echo '    KCL_HTTPPROXIES_SET_NAME=$(KCL_HTTPPROXIES_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Contour::HttpProxy ($(_KUBECTL_CONTOUR_HTTPPROXY_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_httpproxy                  - Annotate a http-proxy'
	@echo '    _kcl_apply_httpproxies                   - Apply a manifest for one-or-more http-proxies'
	@echo '    _kcl_create_httpproxy                    - Create a new http-proxy'
	@echo '    _kcl_delete_httpproxy                    - Delete an existing http-proxy'
	@echo '    _kcl_diff_httpproxies                    - Diff a manifest for one or more http-proxies'
	@echo '    _kcl_edit_httpproxy                      - Edit a http-proxy'
	@echo '    _kcl_explain_httpproxy                   - Explain the http-proxy object'
	@echo '    _kcl_show_httpproxy                      - Show everything related to a http-proxy'
	@echo '    _kcl_show_httpproxy_description          - Show description of a http-proxy'
	@echo '    _kcl_show_httpproxy_issuer               - Show issuer of a http-proxy'
	@echo '    _kcl_show_httpproxy_secret               - Show secret of a http-proxy'
	@echo '    _kcl_show_httpproxy_state                - Show state of a http-proxy'
	@echo '    _kcl_unapply_httpproxies                 - Un-apply a manifest for one-or-more http-proxy'
	@echo '    _kcl_unlabel_httpproxy                   - Un-label a http-proxy'
	@echo '    _kcl_view_httpproxies                    - View ALL http-proxies'
	@echo '    _kcl_view_httpproxies_set                - View set of http-proxies'
	@echo '    _kcl_watch_httpproxies                   - Watch ALL http-proxies'
	@echo '    _kcl_watch_httpproxies_set               - Watch a set of http-proxies'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_httpproxy:
	@$(INFO) '$(KCL_UI_LABEL)Annotating http-proxy "$(KCL_HTTPPROXY_NAME)" ...'; $(NORMAL)

_kcl_apply_httpproxy: _kcl_apply_httpproxies
_kcl_apply_httpproxies:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more http-proxies ...'; $(NORMAL)
	$(if $(KCL_HTTPPROXIES_MANIFEST_FILEPATH), cat $(KCL_HTTPPROXIES_MANIFEST_FILEPATH); echo)
	$(if $(KCL_HTTPPROXIES_MANIFEST_URL), curl -L $(KCL_HTTPPROXIES_MANIFEST_URL); echo)
	$(if $(KCL_HTTPPROXIES_MANIFESTS_DIRPATH), ls -al $(KCL_HTTPPROXIES_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__HTTPPROXIES) $(__KCL_NAMESPACE__HTTPPROXIES)

_kcl_create_httpproxy:
	@$(INFO) '$(KCL_UI_LABEL)Creating http-proxy "$(KCL_HTTPPROXY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create httpproxy $(__KCL_NAMESPACE__HTTPPROXY) $(KCL_HTTPPROXY_NAME)

_kcl_delete_httpproxy:
	@$(INFO) '$(KCL_UI_LABEL)Deleting http-proxy "$(KCL_HTTPPROXY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete httpproxy $(__KCL_NAMESPACE__HTTPPROXY) $(KCL_HTTPPROXY_NAME)

_kcl_diff_httpproxy: _kcl_diff_httpproxies
_kcl_diff_httpproxies:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more http-proxies ...'; $(NORMAL)
	# cat $(KCL_HTTPPROXIES_MANIFEST_FILEPATH)
	# curl -L $(KCL_HTTPPROXIES_MANIFEST_URL)
	# ls -al $(KCL_HTTPPROXIES_MANIFESTS_DIRPATH)
	$(KUBECTL) diff $(__KCL_FILENAME__HTTPPROXIES) $(__KCL_NAMESPACE__HTTPPROXIES)

_kcl_edit_httpproxy:
	@$(INFO) '$(KCL_UI_LABEL)Editing http-proxy "$(KCL_HTTPPROXY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit httpproxy $(__KCL_NAMESPACE__HTTPPROXY) $(KCL_HTTPPROXY_NAME)

_kcl_explain_httpproxy:
	@$(INFO) '$(KCL_UI_LABEL)Explaining http-proxy object ...'; $(NORMAL)
	$(KUBECTL) explain httpproxy

_kcl_label_httpproxy:
	@$(INFO) '$(KCL_UI_LABEL)Labelling http-proxy "$(KCL_HTTPPROXY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label httpproxy $(__KCL_NAMESPACE__HTTPPROXY) $(KCL_HTTPPROXY_NAME) $(KCL_HTTPPROXY_LABELS_KEYVALUES)

_kcl_show_httpproxy :: _kcl_show_httpproxy_description

_kcl_show_httpproxy_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of http-proxy "$(KCL_HTTPPROXY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe httpproxy $(__KCL_NAMESPACE__HTTPPROXY) $(KCL_HTTPPROXY_NAME) 

_kcl_unapply_httpproxy: _kcl_unapply_httpproxies
_kcl_unapply_httpproxies:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more http-proxies ...'; $(NORMAL)
	# cat $(KCL_HTTPPROXIES_MANIFEST_FILEPATH)
	# curl -L $(KCL_HTTPPROXIES_MANIFEST_URL)
	# ls -al $(KCL_HTTPPROXIES_MANIFESTS_DIRPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__HTTPPROXIES) $(__KCL_NAMESPACE__HTTPPROXIES)

_kcl_unlabel_httpproxy:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling http-proxy "$(KCL_HTTPPROXY_NAME)" ...'; $(NORMAL)

_kcl_view_httpproxies:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL http-proxies ...'; $(NORMAL)
	$(KUBECTL) get httpproxies --all-namespaces=true $(_X__KCL_NAMESPACE__HTTPPROXIES) $(_X__KCL_SELECTOR_HTTPPROXIES)

_kcl_view_httpproxies_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing http-proxies-set "$(KCL_HTTPPROXIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Http-proxies are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
	$(KUBECTL) get httpproxies --all-namespaces=false $(__KCL_FIELD_SELECTOR__HTTPPROXIES) $(__KCL_NAMESPACE__HTTPPROXIES) $(__KCL_SELECTOR__HTTPPROXIES)

_kcl_watch_httpproxies:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL http-proxies ...'; $(NORMAL)

_kcl_watch_httpproxies_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching httpproxies-set "$(KCL_HTTPPROXIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Http-proxies are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
