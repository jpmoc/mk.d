_KUBECTL_ROLEBINDING_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_ROLEBINDING_GROUP_NAMES?= group1 ...
# KCL_ROLEBINDING_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_ROLEBINDING_NAME?= my-name 
# KCL_ROLEBINDING_NAMESPACE_NAME?= default 
# KCL_ROLEBINDING_ROLE_NAME?= my-name 
# KCL_ROLEBINDING_SERVICEACCOUNT_NAME?= 
# KCL_ROLEBINDING_USER_NAMES?= emayssat ...
# KCL_ROLEBINDINGS_MANIFEST_DIRPATH?= ./in/
# KCL_ROLEBINDINGS_MANIFEST_FILENAME?= manifest.yaml
# KCL_ROLEBINDINGS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_ROLEBINDINGS_MANIFEST_STDINFLAG?= false
# KCL_ROLEBINDINGS_MANIFEST_URL?= http://...
# KCL_ROLEBINDINGS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_ROLEBINDINGS_NAMESPACE_NAME?= default 
# KCL_ROLEBINDINGS_SELECTOR?=
# KCL_ROLEBINDINGS_SET_NAME?= my-rolebindings-set

# Derived parameters
KCL_ROLEBINDING_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_ROLEBINDING_ROLE_NAME?= $(KCL_ROLE_NAME)
KCL_ROLEBINDINGS_NAMESPACE_NAME?= $(KCL_ROLEBINDING_NAMESPACE_NAME)
KCL_ROLEBINDINGS_SET_NAME?= $(KCL_ROLEBINDINGS_NAMESPACE_NAME)

# Option parameters
__KCL_GROUP__ROLEBINDINGS= $(if $(KCL_ROLEBINDING_GROUP_NAMES),--group $(subst $(SPACE),$(COMMA),$(KCL_ROLEBINDING_GROUP_NAMES)))
__KCL_FILENAME__ROLEBINDINGS= $(if $(KCL_ROLEBINDINGS_MANIFEST_FILEPATH),--filename $(KCL_ROLEBINDINGS_MANIFEST_FILEPATH))
__KCL_FILENAME__ROLEBINDINGS= $(if $(filter true,$(KCL_ROLEBINDINGS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__ROLEBINDINGS= $(if $(KCL_ROLEBINDINGS_MANIFEST_URL),--filename $(KCL_ROLEBINDINGS_MANIFEST_URL))
__KCL_FILENAME__ROLEBINDINGS= $(if $(KCL_ROLEBINDINGS_MANIFESTS_DIRPATH),--filename $(KCL_ROLEBINDINGS_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__ROLEBINDING= $(if $(KCL_ROLEBINDING_NAMESPACE_NAME),--namespace $(KCL_ROLEBINDING_NAMESPACE_NAME))
__KCL_NAMESPACE__ROLEBINDINGS= $(if $(KCL_ROLEBINDINGS_NAMESPACE_NAME),--namespace $(KCL_ROLEBINDINGS_NAMESPACE_NAME))
__KCL_ROLE__ROLEBINDING= $(if $(KCL_ROLEBINDING_ROLE_NAME),--role $(KCL_ROLEBINDING_ROLE_NAME))
__KCL_SELECTOR__ROLEBINDINGS= $(if $(KCL_ROLEBINDINGS_SELECTOR),--selector $(KCL_ROLEBINDINGS_SELECTOR))
__KCL_SERVICEACCOUNT__ROLEBINDING= $(if $(KCL_ROLEBINDING_SERVICEACCOUNT_NAME),--serviceaccount $(KCL_ROLEBINDING_SERVICEACCOUNT_NAME))
__KCL_USER__ROLEBINDING= $(if $(KCL_ROLEBINDING_USER_NAMES),--user $(subst $(SPACE),$(COMMA),$(KCL_ROLEBINDING_USER_NAMES)))

# UI parameters

#--- MACROS
_kcl_get_rolebinding_role_name= $(call _kcl_get_rolebinding_role_name_N, $(KCL_ROLEBINDING_NAME))
_kcl_get_rolebinding_role_name_N= $(call _kcl_get_rolebinding_role_name_NN, $(1) $(KCL_ROLEBINDING_NAMESPACE_NAME))
_kcl_get_rolebinding_role_name_NN= $(shell $(KUBECTL) get rolebinding --namespace $(2) $(1) --output jsonpath="{.roleRef.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::RoleBinding ($(_KUBECTL_ROLEBINDING_MK_VERSION)) macros:'
	@echo '    _kcl_get_rolebinding_role_name_{|N|NN}    - Get the role name of a role-binding (Name, Namespace)'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::RoleBinding ($(_KUBECTL_ROLEBINDING_MK_VERSION)) parameters:'
	@echo '    KCL_ROLEBINDING_GROUP_NAMES=$(KCL_ROLEBINDING_GROUP_NAMES)'
	@echo '    KCL_ROLEBINDING_LABELS_KEYVALUES=$(KCL_ROLEBINDING_LABELS_KEYVALUES)'
	@echo '    KCL_ROLEBINDING_NAME=$(KCL_ROLEBINDING_NAME)'
	@echo '    KCL_ROLEBINDING_NAMESPACE_NAME=$(KCL_ROLEBINDING_NAMESPACE_NAME)'
	@echo '    KCL_ROLEBINDING_ROLE_NAME=$(KCL_ROLEBINDING_ROLE_NAME)'
	@echo '    KCL_ROLEBINDING_SERVICEACCOUNT_NAME=$(KCL_ROLEBINDING_SERVICEACCOUNT_NAME)'
	@echo '    KCL_ROLEBINDING_USER_NAMES=$(KCL_ROLEBINDING_USER_NAMES)'
	@echo '    KCL_ROLEBINDINGS_MANIFEST_DIRPATH=$(KCL_ROLEBINDINGS_MANIFEST_DIRPATH)'
	@echo '    KCL_ROLEBINDINGS_MANIFEST_FILENAME=$(KCL_ROLEBINDINGS_MANIFEST_FILENAME)'
	@echo '    KCL_ROLEBINDINGS_MANIFEST_FILEPATH=$(KCL_ROLEBINDINGS_MANIFEST_FILEPATH)'
	@echo '    KCL_ROLEBINDINGS_MANIFEST_STDINFLAG=$(KCL_ROLEBINDINGS_MANIFEST_STDINFLAG)'
	@echo '    KCL_ROLEBINDINGS_MANIFEST_URL=$(KCL_ROLEBINDINGS_MANIFEST_URL)'
	@echo '    KCL_ROLEBINDINGS_MANIFESTS_DIRPATH=$(KCL_ROLEBINDINGS_MANIFESTS_DIRPATH)'
	@echo '    KCL_ROLEBINDINGS_NAMESPACE_NAME=$(KCL_ROLEBINDINGS_NAMESPACE_NAME)'
	@echo '    KCL_ROLEBINDINGS_SELECTOR=$(KCL_ROLEBINDINGS_SELECTOR)'
	@echo '    KCL_ROLEBINDINGS_SET_NAME=$(KCL_ROLEBINDINGS_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::RoleBinding ($(_KUBECTL_ROLEBINDING_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_rolebinding                 - Create a new role-binding'
	@echo '    _kcl_apply_rolebindings                 - Apply manifest for one-or-more role-bindings'
	@echo '    _kcl_create_rolebinding                 - Create a new role-binding'
	@echo '    _kcl_delete_rolebinding                 - Delete an existing role-binding'
	@echo '    _kcl_diff_rolebindings                  - Diff manifest for one-or-more role-bindings'
	@echo '    _kcl_edit_rolebinding                   - Edit a role-binding'
	@echo '    _kcl_explain_rolebinding                - Explain the role-binding object'
	@echo '    _kcl_show_rolebinding                   - Show everything related to a role-binding'
	@echo '    _kcl_show_rolebinding_description       - Show the description of a role-binding'
	@echo '    _kcl_show_rolebinding_role              - Show the role of a role-binding'
	@echo '    _kcl_show_rolebinding_serviceaccount    - Show the service-account of a role-binding'
	@echo '    _kcl_unapply_rolebindings               - Un-apply manifest for one-or-more role-bindings'
	@echo '    _kcl_unlabel_rolebindings               - Un-label a role-binding'
	@echo '    _kcl_list_rolebindings                  - List all role-bindings'
	@echo '    _kcl_list_rolebindings_set              - List a set of role-bindings'
	@echo '    _kcl_watch_rolebindings                 - Watch all role-bindings'
	@echo '    _kcl_watch_rolebindings_set             - Watch a set of role-bindings'
	@echo '    _kcl_write_rolebindings                 - Write a manifest for one-or-more role-bindings'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_rolebinding:
	@$(INFO) '$(KCL_UI_LABEL)Annotating role-binding "$(KCL_ROLEBINDING_NAME)" ...'; $(NORMAL)

_kcl_apply_rolebinding: _kcl_apply_rolebindings
_kcl_apply_rolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more role-bindings ...'; $(NORMAL)

_kcl_create_rolebinding:
	@$(INFO) '$(KCL_UI_LABEL)Creating role-binding "$(KCL_ROLEBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create rolebinding $(__KCL_GROUP__ROLEBINDING) $(__KCL_NAMESPACE__ROLEBINDING) $(__KCL_ROLE__ROLEBINDING) $(__KCL_USER__ROLEBINDING) $(KCL_ROLEBINDING_NAME) 

_kcl_delete_rolebinding:
	@$(INFO) '$(KCL_UI_LABEL)Deleting role-binding "$(KCL_ROLEBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete rolebinding $(__KCL_NAMESPACE__ROLEBINDING) $(KCL_ROLEBINDING_NAME) 

_kcl_diff_rolebinding: _kcl_diff_rolebindings
_kcl_diff_rolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more role-bindings ...'; $(NORMAL)

_kcl_edit_rolebinding:
	@$(INFO) '$(KCL_UI_LABEL)Editing role-binding "$(KCL_ROLEBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit rolebinding $(__KCL_NAMESPACE__ROLEBINDING) $(KCL_ROLEBINDING_NAME) 

_kcl_explain_rolebinding:
	@$(INFO) '$(KCL_UI_LABEL)Explaining role-binding object ...'; $(NORMAL)
	$(KUBECTL) explain rolebinding

_kcl_label_rolebinding:
	@$(INFO) '$(KCL_UI_LABEL)Labelling role-binding "$(KCL_ROLEBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label rolebinding $(__KCL_NAMESPACE__ROLEBINDING) $(KCL_ROLEBINDING_NAME) $(KCL_ROLEBINDING_LABELS_KEYVALUES)

_KCL_SHOW_ROLEBINDING_TARGETS?= _kcl_show_rolebinding_object _kcl_show_rolebinding_role _kcl_show_rolebinding_serviceaccount _kcl_show_rolebinding_description
_kcl_show_rolebinding: $(_KCL_SHOW_ROLEBINDING_TARGETS)

_kcl_show_rolebinding_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of role-binding "$(KCL_ROLEBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe rolebinding $(__KCL_NAMESPACE__ROLEBINDING) $(KCL_ROLEBINDING_NAME) 

_kcl_show_rolebinding_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of role-binding "$(KCL_ROLEBINDING_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get rolebinding $(__KCL_NAMESPACE__ROLEBINDING) --output yaml $(KCL_ROLEBINDING_NAME) 

_kcl_show_rolebinding_role:
	@$(INFO) '$(KCL_UI_LABEL)Showing role of role-binding "$(KCL_ROLEBINDING_NAME)" ...'; $(NORMAL)
	$(if $(KCL_ROLEBINDING_ROLE_NAME),$(KUBECTL) describe role $(__KCL_NAMESPACE__ROLEBINDING) $(KCL_ROLEBINDING_ROLE_NAME))

_kcl_show_rolebinding_serviceaccount:
	@$(INFO) '$(KCL_UI_LABEL)Showing service-account of role-binding "$(KCL_ROLEBINDING_NAME)" ...'; $(NORMAL)
	$(if $(KCL_ROLEBINDING_SERVICEACCOUNT_NAME),$(KUBECTL) describe serviceaccount $(__KCL_NAMESPACE__ROLEBINDING) $(KCL_ROLEBINDING_SERVICEACCOUNT_NAME))

_kcl_unapply_rolebinding: _kcl_unapply_rolebindings
_kcl_unapply_rolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more role-bindings ...'; $(NORMAL)

_kcl_list_rolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL role-bindings ...'; $(NORMAL)
	$(KUBECTL) get rolebindings --all-namespaces=true $(_X__KCL_NAMESPACE__ROLEBINDINGS) $(_X__KCL_SELECTOR__ROLEBINDINGS)

_kcl_list_rolebindings_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing role-bindings-set "$(KCL_ROLEBINDINGS_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Role-bindings are grouped based on namespace, selector, ...'; $(NORMAL)
	$(KUBECTL) get rolebindings --all-namespace=false $(__KCL_NAMESPACE__ROLEBINDINGS) $(__KCL_SELECTOR__ROLEBINDINGS)

_kcl_watch_rolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL role-bindings ...'; $(NORMAL)

_kcl_watch_rolebindings_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching role-bindings-set "$(KCL_ROLEBINDINGS_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Role-bindings are grouped based on namespace, selector, ...'; $(NORMAL)

_kcl_write_rolebinding: _kcl_write_rolebindings
_kcl_write_rolebindings:
	@$(INFO) '$(KCL_UI_LABEL)Write manifest for one-or-more role-bindings ...'; $(NORMAL)
	$(WRITER) $(KCL_ROLEBINDINGS_MANIFEST_FILEPATH)
