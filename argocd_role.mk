_ARGOCD_ROLE_MK_VERSION= $(_ARGOCD_MK_VERSION)

# ACD_ROLE_DESCRIPTION?= "This is my description"
# ACD_ROLE_NAME?= default
# ACD_ROLE_PROJECT_NAME?= default
ACD_ROLES_REGEX?= *
# ACD_ROLES_SET_NAME?= my-roles-set

# Derived parameters
ACD_ROLE_PROJECT_NAME?= $(ACD_PROJECT_NAME)
ACD_ROLES_SET_NAME?= roles@@@$(ACD_ROLES_REGEX)

# Option parameters
__ACD_DESCRIPTION__ROLE= $(if $(ACD_ROLE_DESCRIPTION),--description $(ACD_ROLE_DESCRIPTION))

# Pipe parameters
|_ACD_VIEW_ROLES_SET?= | grep -E 'ROLE-NAME|$(ACD_ROLES_REGEX)'

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_acd_view_framework_macros ::
	@echo 'ArgoCD::Role ($(_ARGOCD_ROLE_MK_VERSION)) macros:'
	@echo

_acd_view_framework_parameters ::
	@echo 'ArgoCD::Role ($(_ARGOCD_ROLE_MK_VERSION)) parameters:'
	@echo '    ACD_ROLE_DESCRIPTION=$(ACD_ROLE_DESCRIPTION)'
	@echo '    ACD_ROLE_NAME=$(ACD_ROLE_NAME)'
	@echo '    ACD_ROLE_PROJECT_NAME=$(ACD_ROLE_PROJECT_NAME)'
	@echo '    ACD_ROLES_REGEX=$(ACD_ROLES_REGEX)'
	@echo '    ACD_ROLES_SET_NAME=$(ACD_ROLES_SET_NAME)'
	@echo

_acd_view_framework_targets ::
	@echo 'ArgoCD::Role ($(_ARGOCD_ROLE_MK_VERSION)) targets:'
	@echo '    _acd_create_role                 - Create a role'
	@echo '    _acd_delete_role                 - Delete a role'
	@echo '    _acd_show_role                   - Show everything related to a role'
	@echo '    _acd_show_role_description       - Show description of a role'
	@echo '    _acd_show_role_policies          - Show policies of a role'
	@echo '    _acd_show_role_project           - Show project of a role'
	@echo '    _acd_view_roles                  - View roles'
	@echo '    _acd_view_roles_set              - View set of roles'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_acd_create_role:
	@$(INFO) '$(ACD_UI_LABEL)Creating role "$(ACD_ROLE_NAME)" ...'; $(NORMAL)
	$(ARGOCD) proj role create $(__ACD_DESCRIPTION__ROLE) $(ACD_ROLE_PROJECT_NAME) $(ACD_ROLE_NAME)

_acd_delete_role:
	@$(INFO) '$(ACD_UI_LABEL)Deleting role "$(ACD_ROLE_NAME)" ...'; $(NORMAL)
	$(ARGOCD) proj role delete $(ACD_ROLE_PROJECT_NAME) $(ACD_ROLE_NAME)

_acd_show_role :: _acd_show_role_policies _acd_show_role_project _acd_show_role_description

_acd_show_role_description:
	@$(INFO) '$(ACD_UI_LABEL)Showing description role "$(ACD_ROLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns all the tokens that have been issued for that role'; $(NORMAL)
	$(ARGOCD) proj role get $(ACD_ROLE_PROJECT_NAME) $(ACD_ROLE_NAME)

_acd_show_role_policies:
	@$(INFO) '$(ACD_UI_LABEL)Showing policies of role "$(ACD_ROLE_NAME)" ...'; $(NORMAL)
	# $(ARGOCD) proj role 

_acd_show_role_project:
	@$(INFO) '$(ACD_UI_LABEL)Showing project of role "$(ACD_ROLE_NAME)" ...'; $(NORMAL)
	$(ARGOCD) proj get $(ACD_ROLE_PROJECT_NAME)

_acd_view_roles:
	@$(INFO) '$(ACD_UI_LABEL)Viewing roles ...'; $(NORMAL)
	$(ARGOCD) proj role list $(ACD_ROLE_PROJECT_NAME)

_acd_view_roles_set:
	@$(INFO) '$(ACD_UI_LABEL)Viewing roles-set "$(ACD_ROLES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Roles are grouped based on provided project and regex'; $(NORMAL)
	$(ARGOCD) proj role list $(ACD_ROLE_PROJECT_NAME) $(|_ACD_VIEW_ROLES_SET)
