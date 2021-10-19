_KUBECTL_CLUSTERROLE_MK_VERSION= $(_KUBECTL_MK_VERSION)

KCL_CLUSTERROLE_CREATE_DRYRUN?= false
# KCL_CLUSTERROLE_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_CLUSTERROLE_NAME?= 
# KCL_CLUSTERROLE_RESOURCE_NAMES?= 
# KCL_CLUSTERROLE_RESOURCE_TYPES?= pods pods/status
# KCL_CLUSTERROLE_RESOURCE_VERBS?= create delete deletecollection get list patch update watch
# KCL_CLUSTERROLES_MANIFEST_DIRPATH?= ./in/
# KCL_CLUSTERROLES_MANIFEST_FILENAME?= manifest.yaml
# KCL_CLUSTERROLES_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_CLUSTERROLES_MANIFEST_STDINFLAG?= false
# KCL_CLUSTERROLES_MANIFEST_URL?= http://...
# KCL_CLUSTERROLES_MANIFESTS_DIRPATH?= ./in/
# KCL_CLUSTERROLES_SELECTOR?=
# KCL_CLUSTERROLES_SET_NAME?= my-clusterroles-set

# Derived parameters
KCL_CLUSTERROLES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CLUSTERROLES_MANIFEST_FILEPATH?= $(if $(KCL_CLUSTERROLES_MANIFEST_FILENAME),$(KCL_CLUSTERROLES_MANIFEST_DIRPATH)$(KCL_CLUSTERROLES_MANIFEST_FILENAME))
KCL_CLUSTERROLES_SET_NAME?= $(HOSTNAME)

# Option parameters
__KCL_AGGREGATION_RULE=
__KCL_DRY_RUN__CLUSTERROLE= $(if $(KCL_CLUSTERROLE_CREATE_DRYRUN),--dry-run=$(KCL_CLUSTERROLE_CREATE_DRYRUN))
__KCL_FILENAME__CLUSTERROLES+= $(if $(KCL_CLUSTERROLES_MANIFEST_FILEPATH),--filename $(KCL_CLUSTERROLES_MANIFEST_FILEPATH))
__KCL_FILENAME__CLUSTERROLES+= $(if $(filter true,$(KCL_CLUSTERROLES_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__CLUSTERROLES+= $(if $(KCL_CLUSTERROLES_MANIFEST_URL),--filename $(KCL_CLUSTERROLES_MANIFEST_URL))
__KCL_FILENAME__CLUSTERROLES+= $(if $(KCL_CLUSTERROLES_MANIFESTS_DIRPATH),--filename $(KCL_CLUSTERROLES_MANIFESTS_DIRPATH))
__KCL_NON_RESOURCE_URL=
__KCL_RESOURCE__CLUSTERROLE= $(if $(KCL_CLUSTERROLE_RESOURCE_TYPES),--resource=$(subst $(SPACE),$(COMMA),$(KCL_CLUSTERROLE_RESOURCE_TYPES)))
__KCL_RESOURCE_NAME__CLUSTERROLE=
__KCL_SELECTOR__CLUSTERROLES= $(if $(KCL_CLUSTERROLES_SELECTOR),--selector=$(KCL_CLUSTERROLES_SELECTOR))
__KCL_VERB__CLUSTERROLE= $(if $(KCL_CLUSTERROLE_RESOURCE_VERBS),--verb=$(subst $(SPACE),$(COMMA),$(KCL_CLUSTERROLE_RESOURCE_VERBS)))

# Pipe parameters
_KCL_APPLY_CLUSTERROLES_|?= #
_KCL_DIFF_CLUSTERROLES_|?= $(_KCL_APPLY_CLUSTERROLES_|)
_KCL_UNAPPLY_CLUSTERROLES_|?= $(_KCL_APPLY_CLUSTERROLES_|)
|_KCL_APPLY_CLUSTERROLES?=
|_KCL_VIEW_CLUSTERROLES_SET?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::ClusterRole ($(_KUBECTL_CLUSTERROLE_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::ClusterRole ($(_KUBECTL_CLUSTERROLE_MK_VERSION)) parameters:'
	@echo '    KCL_CLUSTERROLE_CREATE_DRYRUN=$(KCL_CLUSTERROLE_CREATE_DRYRUN)'
	@echo '    KCL_CLUSTERROLE_LABELS_KEYVALUES=$(KCL_CLUSTERROLE_LABELS_KEYVALUES)'
	@echo '    KCL_CLUSTERROLE_NAME=$(KCL_CLUSTERROLE_NAME)'
	@echo '    KCL_CLUSTERROLE_RESOURCE_NAMES=$(KCL_CLUSTERROLE_RESOURCE_NAMES)'
	@echo '    KCL_CLUSTERROLE_RESOURCE_TYPES=$(KCL_CLUSTERROLE_RESOURCE_TYPES)'
	@echo '    KCL_CLUSTERROLE_RESOURCE_VERBS=$(KCL_CLUSTERROLE_RESOURCE_VERBS)'
	@echo '    KCL_CLUSTERROLES_MANIFEST_DIRPATH=$(KCL_CLUSTERROLES_MANIFEST_DIRPATH)'
	@echo '    KCL_CLUSTERROLES_MANIFEST_FILENAME=$(KCL_CLUSTERROLES_MANIFEST_FILENAME)'
	@echo '    KCL_CLUSTERROLES_MANIFEST_FILEPATH=$(KCL_CLUSTERROLES_MANIFEST_FILEPATH)'
	@echo '    KCL_CLUSTERROLES_MANIFEST_STDINFLAG=$(KCL_CLUSTERROLES_MANIFEST_STDINFLAG)'
	@echo '    KCL_CLUSTERROLES_MANIFEST_URL=$(KCL_CLUSTERROLES_MANIFEST_URL)'
	@echo '    KCL_CLUSTERROLES_MANIFESTS_DIRPATH=$(KCL_CLUSTERROLES_MANIFESTS_DIRPATH)'
	@echo '    KCL_CLUSTERROLES_SELECTOR=$(KCL_CLUSTERROLES_SELECTOR)'
	@echo '    KCL_CLUSTERROLES_SET_NAME=$(KCL_CLUSTERROLES_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::ClusterRole ($(_KUBECTL_CLUSTERROLE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_clusterrole                    - Annotate a cluster-role'
	@echo '    _kcl_apply_clusterroles                      - Apply a manifest for one-or-more cluster-roles'
	@echo '    _kcl_create_clusterrole                      - Create a new cluster-role'
	@echo '    _kcl_delete_clusterrole                      - Delete an existing cluster-role'
	@echo '    _kcl_diff_clusterroles                       - Diff a manifest for one-or-more cluster-roles'
	@echo '    _kcl_edit_clusterrole                        - Edit a cluster-role'
	@echo '    _kcl_explain_clusterrole                     - Explain the cluster-role object'
	@echo '    _kcl_show_clusterrole                        - Show everything related to a cluster-role'
	@echo '    _kcl_show_clusterrole_clusterrolebindings    - Show cluster-role-bindings referring to a cluster-role'
	@echo '    _kcl_show_clusterrole_description            - Show desription of a cluster-role'
	@echo '    _kcl_unapply_clusterroles                    - Un-apply a manifest for one-or-more cluster-roles'
	@echo '    _kcl_unlabel_clusterrole                     - Un-label a cluster-role'
	@echo '    _kcl_update_clusterrole                      - Update a cluster-role'
	@echo '    _kcl_view_clusterroles                       - View cluster-roles'
	@echo '    _kcl_view_clusterroles_set                   - View set of cluster-roles'
	@echo '    _kcl_watch_clusterroles                      - Watch cluster-roles'
	@echo '    _kcl_watch_clusterroles_set                  - Watch a set of cluster-roles'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_clusterrole:
	@$(INFO) '$(KCL_UI_LABEL)Annotating cluster-role "$(KCL_CLUSTERROLE_NAME)" ...'; $(NORMAL)

_kcl_apply_clusterrole: _kcl_apply_clusterroles
_kcl_apply_clusterroles:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more cluster-roles ...'; $(NORMAL)
	$(if $(KCL_CLUSTERROLES_MANIFEST_FILEPATH),cat $(KCL_CLUSTERROLES_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_CLUSTERROLES_MANIFEST_FILEPATH)),$(_KCL_APPLY_CLUSTERROLES_|)cat)
	$(if $(KCL_CLUSTERROLES_MANIFEST_URL),curl -L $(KCL_CLUSTERROLES_MANIFEST_URL))
	$(if $(KCL_CLUSTERROLES_MANIFESTS_DIRPATH),ls -al $(KCL_CLUSTERROLES_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_CLUSTERROLES_|)$(KUBECTL) apply $(__KCL_FILENAME__CLUSTERROLES) $(|_KCL_APPLY_CLUSTERROLES)

_kcl_create_clusterrole:
	@$(INFO) '$(KCL_UI_LABEL)Creating cluster-role "$(KCL_CLUSTERROLE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create clusterrole $(__KCL_AGGREATION_RULE) $(__KCL_DRY_RUN__CLUSTERROLE) $(__KCL_NON_RESOURCE_URL) $(__KCL_RESOURCE__CLUSTERROLE) $(__KCL_VERB__CLUSTERROLE) $(KCL_CLUSTERROLE_NAME)

_kcl_delete_clusterrole:
	@$(INFO) '$(KCL_UI_LABEL)Deleting cluster-role "$(KCL_CLUSTERROLE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete clusterrole $(KCL_CLUSTERROLE_NAME)

_kcl_diff_clusterrole: _kcl_diff_clusterroles
_kcl_diff_clusterroles:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more cluster-roles ...'; $(NORMAL)
	@$(WARN) 'This operation submits the manifest to the cluster to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_CLUSTERROLES_MANIFEST_FILEPATH) 
	# $(_KCL_DIFF_CLUSTERROLES_|)cat
	# curl -L $(KCL_CLUSTERROLES_MANIFEST_URL) 
	# ls -al $(KCL_CLUSTERROLES_MANIFESTS_DIRPATH) 
	$(_KCL_DIFF_CLUSTERROLES_|)$(KUBECTL) diff $(__KCL_FILENAME__CLUSTERROLES)

_kcl_edit_clusterrole:
	@$(INFO) '$(KCL_UI_LABEL)Editing cluster-role "$(KCL_CLUSTERROLE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit clusterrole $(KCL_CLUSTERROLE_NAME)

_kcl_explain_clusterrole:
	@$(INFO) '$(KCL_UI_LABEL)Explaining cluster-role object ...'; $(NORMAL)
	$(KUBECTL) explain clusterrole

_kcl_label_clusterrole:
	@$(INFO) '$(KCL_UI_LABEL)Labelling cluster-role "$(KCL_CLUSTERROLE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label clusterrole $(KCL_CLUSTERROLE_NAME) $(KCL_CLUSTERROLE_LABELS_KEYVALUES)

_kcl_show_clusterrole: _kcl_show_clusterrole_clusterrolebindings _kcl_show_clusterrole_description

_kcl_show_clusterrole_clusterrolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Showing cluster-role-bindings referencing cluster-role "$(KCL_CLUSTERROLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'To be implemented!'; $(NORMAL)

_kcl_show_clusterrole_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of cluster-role "$(KCL_CLUSTERROLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Available verbs are: create delete deletecollection get list patch update watch'; $(NORMAL)
	$(KUBECTL) describe clusterrole $(KCL_CLUSTERROLE_NAME) 

_kcl_unapply_clusterrole: _kcl_unapply_clusterroles
_kcl_unapply_clusterroles:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more cluster-roles ...'; $(NORMAL)
	# cat $(KCL_CLUSTERROLES_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_CLUSTERROLES_|)cat
	# curl -L $(KCL_CLUSTERROLES_MANIFEST_URL)
	# ls -al $(KCL_CLUSTERROLES_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_CLUSTERROLES_|)$(KUBECTL) delete $(__KCL_FILENAME__CLUSTERROLES)

_kcl_unlabel_clusterrole:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling cluster-role "$(KCL_CLUSTERROLE_NAME)" ...'; $(NORMAL)

_kcl_update_clusterrole:
	@$(INFO) '$(KCL_UI_LABEL)Updating cluster-role "$(KCL_CLUSTERROLE_NAME)" ...'; $(NORMAL)

_kcl_view_clusterroles:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL cluster-roles ...'; $(NORMAL)
	$(KUBECTL) get clusterroles $(_X__KCL_SELECTOR__CLUSTERROLES)

_kcl_view_clusterroles_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing cluster-roles-set "$(KCL_CLUSTERROLES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Cluster-roles are grouped based on selector, pipe-filter...'; $(NORMAL)
	$(KUBECTL) get clusterroles $(__KCL_SELECTOR__CLUSTERROLES) $(|_KCL_VIEW_CLUSTERROLES_SET)

_kcl_watch_clusterroles:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL cluster-roles ...'; $(NORMAL)

_kcl_watch_clusterroles_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching cluster-roles-set "$(KCL_CLUSTERROLES_SET_NAME)" ...'; $(NORMAL)
