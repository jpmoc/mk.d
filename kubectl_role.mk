_KUBECTL_ROLE_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_ROLE_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_ROLE_NAME?= 
# KCL_ROLE_NAMESPACE_NAME?= 
# KCL_ROLE_RESOURCE_TYPES?= pods deployments 
# KCL_ROLE_RESOURCE_VERBS?= create delete deletecollection get patch update watch
# KCL_ROLES_NAMESPACE_NAME?= 
# KCL_ROLES_SELECTOR?=
# KCL_ROLES_SET_NAME?= my-roles-set

# Derived parameters
KCL_ROLE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_ROLES_NAMESPACE_NAME?= $(KCL_ROLE_NAMESPACE_NAME)
KCL_ROLES_SET_NAME?= $(KCL_ROLES_NAMESPACE_NAME)

# Option parameters
__KCL_NAMESPACE__ROLE= $(if $(KCL_ROLE_NAMESPACE_NAME),--namespace $(KCL_ROLE_NAMESPACE_NAME))
__KCL_NAMESPACE__ROLES= $(if $(KCL_ROLES_NAMESPACE_NAME),--namespace $(KCL_ROLES_NAMESPACE_NAME))
__KCL_RESOURCE_NAME__ROLE= $(if $(KCL_ROLE_RESOURCE_NAMES),--resource-name $(subst $(SPACE),$(COMMA),$(KCL_ROLE_RESOURCE_NAMES)))
__KCL_RESOURCE__ROLE= $(if $(KCL_ROLE_RESOURCE_TYPES),--resource $(subst $(SPACE),$(COMMA),$(KCL_ROLE_RESOURCE_TYPES)))
__KCL_VERB__ROLE= $(if $(KCL_ROLE_RESOURCE_VERBS),--verb $(subst $(SPACE),$(COMMA),$(KCL_ROLE_RESOURCE_VERBS)))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Role ($(_KUBECTL_ROLE_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Role ($(_KUBECTL_ROLE_MK_VERSION)) parameters:'
	@echo '    KCL_ROLE_LABELS_KEYVALUES=$(KCL_ROLE_LABELS_KEYVALUES)'
	@echo '    KCL_ROLE_NAME=$(KCL_ROLE_NAME)'
	@echo '    KCL_ROLE_NAMESPACE_NAME=$(KCL_ROLE_NAMESPACE_NAME)'
	@echo '    KCL_ROLE_RESOURCE_NAMES=$(KCL_ROLE_RESOURCE_NAMES)'
	@echo '    KCL_ROLE_RESOURCE_TYPES=$(KCL_ROLE_RESOURCE_TYPES)'
	@echo '    KCL_ROLE_RESOURCE_VERBS=$(KCL_ROLE_RESOURCE_VERBS)'
	@echo '    KCL_ROLES_MANIFEST_DIRPATH=$(KCL_ROLES_MANIFEST_DIRPATH)'
	@echo '    KCL_ROLES_MANIFEST_FILENAME=$(KCL_ROLES_MANIFEST_FILENAME)'
	@echo '    KCL_ROLES_MANIFEST_FILEPATH=$(KCL_ROLES_MANIFEST_FILEPATH)'
	@echo '    KCL_ROLES_MANIFEST_STDINFLAG=$(KCL_ROLES_MANIFEST_STDINFLAG)'
	@echo '    KCL_ROLES_MANIFEST_URL=$(KCL_ROLES_MANIFEST_URL)'
	@echo '    KCL_ROLES_MANIFESTS_DIRPATH=$(KCL_ROLES_MANIFESTS_DIRPATH)'
	@echo '    KCL_ROLES_SET_NAME=$(KCL_ROLES_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Role ($(_KUBECTL_ROLE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_role               - Annotate a role'
	@echo '    _kcl_apply_roles                 - Apply manifest for one-or-more roles'
	@echo '    _kcl_create_role                 - Create a new role'
	@echo '    _kcl_delete_role                 - Delete an existing role'
	@echo '    _kcl_apply_roles                 - Apply manifest for one-or-more roles'
	@echo '    _kcl_edit_role                   - Edit a role'
	@echo '    _kcl_explain_role                - Explain the role object'
	@echo '    _kcl_list_roles                  - List all roles'
	@echo '    _kcl_list_roles_set              - List set of roles'
	@echo '    _kcl_show_role                   - Show everything related to a role'
	@echo '    _kcl_show_role_description       - Show description of a role'
	@echo '    _kcl_show_role_rolebindings      - Show role-bindings of a role'
	@echo '    _kcl_unapply_roles               - Un-apply manifest for one-or-more roles'
	@echo '    _kcl_unlabe_role                 - Un-label a role'
	@echo '    _kcl_watch_roles                 - Watch all roles'
	@echo '    _kcl_watch_roles_set             - Watch a set of roles'
	@echo '    _kcl_write_roles                 - Write a manifest for one-or-more roles'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_role:
	@$(INFO) '$(KCL_UI_LABEL)Annotating role "$(KCL_ROLE_NAME)" ...'; $(NORMAL)

_kcl_apply_role: _kcl_apply_roles
_kcl_apply_roles:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more roles ...'; $(NORMAL)

_kcl_create_role:
	@$(INFO) '$(KCL_UI_LABEL)Creating role "$(KCL_ROLE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create role $(__KCL_NAMESPACE__ROLE) $(__KCL_RESOURCE__ROLE) $(__KCL_RESOURCE_NAME__ROLE) $(__KCL_VERB__ROLE) $(KCL_ROLE_NAME)

_kcl_delete_role:
	@$(INFO) '$(KCL_UI_LABEL)Deleting role "$(KCL_ROLE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete role $(__KCL_NAMESPACE__ROLE) $(KCL_ROLE_NAME)

_kcl_diff_role: _kcl_diff_roles
_kcl_diff_roles:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more roles ...'; $(NORMAL)

_kcl_edit_role:
	@$(INFO) '$(KCL_UI_LABEL)Editing role "$(KCL_ROLE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit role $(__KCL_NAMESPACE__ROLE) $(KCL_ROLE_NAME)

_kcl_explain_role:
	@$(INFO) '$(KCL_UI_LABEL)Explaining role object ...'; $(NORMAL)
	$(KUBECTL) explain role

_kcl_label_role:
	@$(INFO) '$(KCL_UI_LABEL)Labeling role "$(KCL_ROLE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label role $(__KCL_NAMESPACE__ROLE) $(KCL_ROLE_NAME) $(KCL_ROLE_LABELS_KEYVALUES)

_kcl_list_roles:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL roles ...'; $(NORMAL)
	$(KUBECTL) get roles --all-namespaces=true $(_X__KCL_NAMESPACE_ROLES) $(_X__KCL_SELECTOR_ROLES)

_kcl_list_roles_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing roles-set "$(KCL_ROLES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Roles are grouped based on namespace, selector, ...'; $(NORMAL)
	$(KUBECTL) get roles --all-namespaces=false $(__KCL_NAMESPACE__ROLES) $(__KCL_SELECTOR_ROLES)

_KCL_SHOW_ROLE_TARGETS?= _kcl_show_role_description

_kcl_show_role: $(_KCL_SHOW_ROLE_TARGETS)

_kcl_show_role_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of role "$(KCL_ROLE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe role $(__KCL_NAMESPACE__ROLE) $(KCL_ROLE_NAME) 

_kcl_unapply_role: _kcl_unapply_roles
_kcl_unapply_roles:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more roles ...'; $(NORMAL)

_kcl_unlabel_role:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling role "$(KCL_ROLE_NAME)" ...'; $(NORMAL)

_kcl_watch_roles:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL roles ...'; $(NORMAL)

_kcl_watch_roles_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching roles-set "$(KCL_ROLES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Roles are grouped based on namespace, selector, ...'; $(NORMAL)

_kcl_write_role: _kcl_write_roles
_kcl_write_roles:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more roles ...'; $(NORMAL)
	$(WRITER) $(KCL_ROLES_MANIFEST_FILEPATH)
