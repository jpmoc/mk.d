_KUBECTL_CLUSTERROLEBINDING_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_CLUSTERROLEBINDING_CLUSTERROLE_NAME?= 
# KCL_CLUSTERROLEBINDING_GROUP_NAMES?= 
# KCL_CLUSTERROLEBINDING_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_CLUSTERROLEBINDING_NAME?= 
# KCL_CLUSTERROLEBINDING_USER_NAMES?= 
# KCL_CLUSTERROLEBINDINGS_MANIFEST_DIRPATH?= ./in/
# KCL_CLUSTERROLEBINDINGS_MANIFEST_FILENAME?= manifest.yaml
# KCL_CLUSTERROLEBINDINGS_MANIFEST_FILEPATH?=  ./in/manifest.yaml
KCL_CLUSTERROLEBINDINGS_MANIFEST_STDINFLAG?= false
# KCL_CLUSTERROLEBINDINGS_MANIFEST_URL?= http://... 
# KCL_CLUSTERROLEBINDINGS_MANIFESTS_DIRPATH?= ./in/
# KCL_CLUSTERROLEBINDINGS_SELECTOR?=
# KCL_CLUSTERROLEBINDINGS_SET_NAME?= my-clusterrolebindings-set

# Derived parameters
KCL_CLUSTERROLEBINDING_CLUSTERROLE_NAME?= $(KCL_CLUSTERROLE_NAME)
KCL_CLUSTERROLEBINDINGS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CLUSTERROLEBINDINGS_MANIFEST_FILEPATH?= $(if $(KCL_CLUSTERROLEBINDINGS_MANIFEST_FILENAME),$(KCL_CLUSTERROLEBINDINGS_MANIFEST_DIRPATH)$(KCL_CLUSTERROLEBINDINGS_MANIFEST_FILENAME))
KCL_CLUSTERROLEBINDINGS_SET_NAME?= cluster-role-bindings@@$(KCL_CLUSTERROLEBINDINGS_SELECTOR)

# Option parameters
__KCL_CLUSTERROLE= $(if $(KCL_CLUSTERROLEBINDING_CLUSTERROLE_NAME),--clusterrole $(KCL_CLUSTERROLEBINDING_CLUSTERROLE_NAME))
__KCL_FILENAME__CLUSTERROLEBINDINGS+= $(if $(KCL_CLUSTERROLEBINDINGS_MANIFEST_FILEPATH),--filename $(KCL_CLUSTERROLEBINDINGS_MANIFEST_FILEPATH))
__KCL_FILENAME__CLUSTERROLEBINDINGS+= $(if $(filter true,$(KCL_CLUSTERROLEBINDINGS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__CLUSTERROLEBINDINGS+= $(if $(KCL_CLUSTERROLEBINDINGS_MANIFEST_URL),--filename $(KCL_CLUSTERROLEBINDINGS_MANIFEST_URL))
__KCL_FILENAME__CLUSTERROLEBINDINGS+= $(if $(KCL_CLUSTERROLEBINDINGS_MANIFESTS_DIRPATH),--filename $(KCL_CLUSTERROLEBINDINGS_MANIFESTS_DIRPATH))
__KCL_GROUP__CLUSTERROLEBINDING= $(if $(KCL_CLUSTERROLEBINDING_GROUP_NAMES),--group $(subst $(SPACE),$(COMMA),$(KCL_CLUSTERROLEBINDING_GROUP_NAMES)))
__KCL_SELECTOR__CLUSTERROLEBINDINGS= $(if $(KCL_CLUSTERROLEBINDINGS_SELECTOR),--selector $(KCL_CLUSTERROLEBINDINGS_SELECTOR))
__KCL_USER__CLUSTERROLEBINDING= $(if $(KCL_CLUSTERROLEBINDING_USER_NAMES),--user $(subst $(SPACE),$(COMMA),$(KCL_CLUSTERROLEBINDING_USER_NAMES)))

# UI parameters
_KCL_APPLY_CLUSTERROLEBINDINGS_|?= #
_KCL_DIFF_CLUSTERROLEBINDINGS_|?= $(_KCL_APPLY_CLUSTERROLEBINDINGS_|)
_KCL_UNAPPLY_CLUSTERROLEBINDINGS_|?= $(_KCL_APPLY_CLUSTERROLEBINDINGS_|)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::ClusterRoleBinding ($(_KUBECTL_CLUSTERROLEBINDING_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::ClusterRoleBinding ($(_KUBECTL_CLUSTERROLEBINDING_MK_VERSION)) parameters:'
	@echo '    KCL_CLUSTERROLEBINDING_CLUSTERROLE_NAME=$(KCL_CLUSTERROLEBINDING_CLUSTERROLE_NAME)'
	@echo '    KCL_CLUSTERROLEBINDING_GROUP_NAMES=$(KCL_CLUSTERROLEBINDING_GROUP_NAMES)'
	@echo '    KCL_CLUSTERROLEBINDING_LABELS_KEYVALUES=$(KCL_CLUSTERROLEBINDING_LABELS_KEYVALUES)'
	@echo '    KCL_CLUSTERROLEBINDING_NAME=$(KCL_CLUSTERROLEBINDING_NAME)'
	@echo '    KCL_CLUSTERROLEBINDING_USER_NAMES=$(KCL_CLUSTERROLEBINDING_USER_NAMES)'
	@echo '    KCL_CLUSTERROLEBINDINGS_MANIFEST_DIRPATH=$(KCL_CLUSTERROLEBINDINGS_MANIFEST_DIRPATH)'
	@echo '    KCL_CLUSTERROLEBINDINGS_MANIFEST_FILENAME=$(KCL_CLUSTERROLEBINDINGS_MANIFEST_FILENAME)'
	@echo '    KCL_CLUSTERROLEBINDINGS_MANIFEST_FILEPATH=$(KCL_CLUSTERROLEBINDINGS_MANIFEST_FILEPATH)'
	@echo '    KCL_CLUSTERROLEBINDINGS_MANIFEST_STDINFLAG=$(KCL_CLUSTERROLEBINDINGS_MANIFEST_STDINFLAG)'
	@echo '    KCL_CLUSTERROLEBINDINGS_MANIFEST_URL=$(KCL_CLUSTERROLEBINDINGS_MANIFEST_URL)'
	@echo '    KCL_CLUSTERROLEBINDINGS_MANIFESTS_DIRPATH=$(KCL_CLUSTERROLEBINDINGS_MANIFESTS_DIRPATH)'
	@echo '    KCL_CLUSTERROLEBINDINGS_SELECTOR=$(KCL_CLUSTERROLEBINDINGS_SELECTOR)'
	@echo '    KCL_CLUSTERROLEBINDINGS_SET_NAME=$(KCL_CLUSTERROLEBINDINGS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::ClusterRoleBinding ($(_KUBECTL_CLUSTERROLEBINDING_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_clusterrolebinding               - Annotate a cluster-role-binding'
	@echo '    _kcl_apply_clusterrolebindings                 - Applying manifest for one-or-more cluster-role-bindings'
	@echo '    _kcl_create_clusterrolebinding                 - Create a new cluster-role-binding'
	@echo '    _kcl_delete_clusterrolebinding                 - Delete an existing cluster-role-binding'
	@echo '    _kcl_diff_clusterrolebindings                  - Diff current-state with manifest for one-or-more cluster-role-bindings'
	@echo '    _kcl_edit_clusterrolebinding                   - Edit a cluster-role-binding'
	@echo '    _kcl_explain_clusterrolebinding                - Explain the cluster-role-binding object'
	@echo '    _kcl_show_clusterrolebinding                   - Show everything related to a cluster-role-binding'
	@echo '    _kcl_show_clusterrolebinding_description       - Show description of a cluster-role-binding'
	@echo '    _kcl_show_clusterrolebinding_object            - Show object of a cluster-role-binding'
	@echo '    _kcl_show_clusterrolebinding                   - Show everything related to a cluster-role-binding'
	@echo '    _kcl_unapply_clusterrolebindings               - Unpplying manifest for one-or-more cluster-role-bindings'
	@echo '    _kcl_view_clusterrolebindings                  - View all cluster-role-bindings'
	@echo '    _kcl_view_clusterrolebindings_set              - View a set of cluster-role-bindings'
	@echo '    _kcl_view_clusterrolebindings                  - Watch all cluster-role-bindings'
	@echo '    _kcl_view_clusterrolebindings_set              - Watch a set of cluster-role-bindings'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_clusterrolebinding:
	@$(INFO) '$(KCL_UI_LABEL)Annotating cluster-role-binding "$(KCL_CLUSTERROLEBINDING_NAME)" ...'; $(NORMAL)

_kcl_apply_clusterrolebinding: _kcl_apply_clusterrolebindings
_kcl_apply_clusterrolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Applying amnifest for one-or-more cluster-role-bindings ...'; $(NORMAL)
	$(if $(KCL_CLUSTERROLEBINDINGS_MANIFEST_FILEPATH),cat $(KCL_CLUSTERROLEBINDINGS_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_CLUSTERROLEBINDINGS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_CLUSTERROLEBINDINGS_|)cat)
	$(if $(KCL_CLUSTERROLEBINDINGS_MANIFEST_URL),curl -L $(KCL_CLUSTERROLEBINDINGS_MANIFEST_URL))
	$(if $(KCL_CLUSTERROLEBINDINGS_MANIFESTS_DIRPATH),ls -al $(KCL_CLUSTERROLEBINDINGS_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_CLUSTERROLEBINDINGS_|)$(KUBECTL) apply $(__KCL_FILENAME__CLUSTERROLEBINDINGS)

_kcl_create_clusterrolebinding:
	@$(INFO) '$(KCL_UI_LABEL)Creating cluster-role-binding "$(KCL_CLUSTERROLEBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create clusterrolebinding $(__KCL_CLUSTERROLE) $(__KCL_GROUP__CLUSTERROLEBINDING) $(__KCL_USER__CLUSTERROLEBINDING) $(KCL_CLUSTERROLEBINDING_NAME)

_kcl_delete_clusterrolebinding:
	@$(INFO) '$(KCL_UI_LABEL)Deleting cluster-role-binding "$(KCL_CLUSTERROLEBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete clusterrolebinding $(KCL_CLUSTERROLEBINDING_NAME)

_kcl_diff_clusterrolebinding: _kcl_diff_clusterrolebindings
_kcl_diff_clusterrolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster state with manifest for one-or-more cluster-role-bindings ...'; $(NORMAL)
	@$(WARN) 'This operation submits to the cluster the manifest to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_CLUSTERROLEBINDINGS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_CLUSTERROLEBINDINGS_|)cat
	# curl -L $(KCL_CLUSTERROLEBINDINGS_MANIFEST_URL)
	# ls -al $(KCL_CLUSTERROLEBINDINGS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_CLUSTERROLEBINDINGS_|)$(KUBECTL) diff $(__KCL_FILENAME__CLUSTERROLEBINDINGS)

_kcl_edit_clusterrolebinding:
	@$(INFO) '$(KCL_UI_LABEL)Editing cluster-role-binding "$(KCL_CLUSTERROLEBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit clusterrolebinding $(KCL_CLUSTERROLEBINDING_NAME)

_kcl_explain_clusterrolebinding:
	@$(INFO) '$(KCL_UI_LABEL)Explaining cluster-role-binding object ...'; $(NORMAL)
	$(KUBECTL) explain clusterrolebinding

_kcl_label_clusterrolebinding:
	@$(INFO) '$(KCL_UI_LABEL)Labelling cluster-role-binding "$(KCL_CLUSTERROLEBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label clusterrolebinding $(KCL_CLUSTERROLEBINDING_NAME) $(KCL_CLUSTERROLEBINDING_LABELS_KEYVALUES)

_kcl_show_clusterrolebinding: _kcl_show_clusterrolebinding_object _kcl_show_clusterrolebinding_description

_kcl_show_clusterrolebinding_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of cluster-role-binding "$(KCL_CLUSTERROLEBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe clusterrolebinding $(KCL_CLUSTERROLEBINDING_NAME) 

_kcl_show_clusterrolebinding_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of cluster-role-binding "$(KCL_CLUSTERROLEBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get clusterrolebinding --output yaml $(KCL_CLUSTERROLEBINDING_NAME)

_kcl_unapply_clusterrolebinding: _kcl_unapply_clusterrolebindings
_kcl_unapply_clusterrolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more cluster-role-bindings ...'; $(NORMAL)
	# cat $(KCL_CLUSTERROLEBINDINGS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_CLUSTERROLEBINDINGS_|)cat
	# curl -L $(KCL_CLUSTERROLEBINDINGS_MANIFEST_URL)
	# ls -al $(KCL_CLUSTERROLEBINDINGS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_CLUSTERROLEBINDINGS_|)$(KUBECTL) delete $(__KCL_FILENAME__CLUSTERROLEBINDINGS)

_kcl_view_clusterrolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL cluster-role-bindings ...'; $(NORMAL)
	$(KUBECTL) get clusterrolebindings

_kcl_view_clusterrolebindings_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing cluster-role-bindings-set "$(KCL_CLUSTERROLEBINDINGS_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Cluster-role-bindings are grouped based on selector, ...'; $(NORMAL)
	$(KUBECTL) get clusterrolebindings $(__KCL_SELECTOR__CLUSTERROLEBINDINGS)

_kcl_watch_clusterrolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL cluster-role-bindings ...'; $(NORMAL)

_kcl_watch_clusterrolebindings_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching cluster-role-bindings-set "$(KCL_CLUSTERROLEBINDINGS_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Cluster-role-bindings are grouped based on selector, ...'; $(NORMAL)
