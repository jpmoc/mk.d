_ARGOCD_POLICY_MK_VERSION= $(_ARGOCD_MK_VERSION)

# ACD_POLICY_ACTION?= get
# ACD_POLICY_NAME?=
# ACD_POLICY_OBJECT?= my-application
# ACD_POLICY_PERMISSION?= allow
# ACD_POLICY_PROJECT_NAME?= default
ACD_POLICIES_REGEX?= *
# ACD_POLICY_ROLE_NAME?= default
# ACD_POLICIESS_SET_NAME?= my-roles-set

# Derived parameters
ACD_POLICY_NAME?= policy-$(ACD_POLICY_ROLE_NAME)
ACD_POLICY_OBJECT?= $(ACD_APPLICATION_NAME)
ACD_POLICY_PROJECT_NAME?= $(ACD_ROLE_PROJECT_NAME)
ACD_POLICY_ROLE_NAME?= $(ACD_ROLE_NAME)
ACD_POLICIES_PROJECT_NAME?= $(ACD_POLICY_PROJECT_NAME)
ACD_POLICIES_ROLE_NAME?= $(ACD_POLICY_ROLE_NAME)
ACD_POLICIES_SET_NAME?= policies@@@$(ACD_POLICIES_REGEX)

# Option parameters
__ACD_ACTION= $(if $(ACD_POLICY_ACTION),--action $(ACD_POLICY_ACTION))
__ACD_OBJECT= $(if $(ACD_POLICY_OBJECT),--object $(ACD_POLICY_OBJECT))
__ACD_PERMISSION= $(if $(ACD_POLICY_PERMISSION),--permission $(ACD_POLICY_PERMISSION))

# Pipe parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_acd_view_framework_macros ::
	@echo 'ArgoCD::Policy ($(_ARGOCD_POLICY_MK_VERSION)) macros:'
	@echo

_acd_view_framework_parameters ::
	@echo 'ArgoCD::Policy ($(_ARGOCD_POLICY_MK_VERSION)) parameters:'
	@echo '    ACD_POLICY_ACTION=$(ACD_POLICY_ACTION)'
	@echo '    ACD_POLICY_NAME=$(ACD_POLICY_NAME)'
	@echo '    ACD_POLICY_OBJECT=$(ACD_POLICY_OBJECT)'
	@echo '    ACD_POLICY_PERMISSION=$(ACD_POLICY_PERMISSION)'
	@echo '    ACD_POLICY_PROJECT_NAME=$(ACD_POLICY_PROJECT_NAME)'
	@echo '    ACD_POLICY_ROLE_NAME=$(ACD_POLICY_ROLE_NAME)'
	@echo '    ACD_POLICIES_PROJECT_NAME=$(ACD_POLICIES_PROJECT_NAME)'
	@echo '    ACD_POLICIES_REGEX=$(ACD_POLICIES_REGEX)'
	@echo '    ACD_POLICIES_ROLE_NAME=$(ACD_POLICIES_ROLE_NAME)'
	@echo '    ACD_POLICIES_SET_NAME=$(ACD_POLICIES_SET_NAME)'
	@echo

_acd_view_framework_targets ::
	@echo 'ArgoCD::Policy ($(_ARGOCD_POLICY_MK_VERSION)) targets:'
	@echo '    _acd_create_policy               - Create a policy'
	@echo '    _acd_delete_policy               - Delete a policy'
	@echo '    _acd_show_policy                 - Show everything related to a policy'
	@echo '    _acd_show_policy_description     - Show description of a policy'
	@echo '    _acd_view_policiies              - View policies'
	@echo '    _acd_view_policies_set           - View set of policies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_acd_create_policy:
	@$(INFO) '$(ACD_UI_LABEL)Creating policy "$(ACD_POLICY_NAME)" ...'; $(NORMAL)
	$(ARGOCD) proj role add-policy $(__ACD_ACTION) $(__ACD_OBJECT) $(__ACD_PERMISSION) $(ACD_POLICY_PROJECT_NAME) $(ACD_POLICY_ROLE_NAME)

_acd_delete_policy:
	@$(INFO) '$(ACD_UI_LABEL)Deleting policy "$(ACD_POLICY_NAME)" ...'; $(NORMAL)
	$(ARGOCD) proj role remove-policy $(__ACD_ACTION) $(ACD_POLICY_PROJECT_NAME) $(ACD_POLICY_ROLE_NAME)

_acd_show_policy :: _acd_show_policy_role _acd_show_policy_description

_acd_show_policy_description:
	@$(INFO) '$(ACD_UI_LABEL)Showing description of policy "$(ACD_POLICY_NAME)" ...'; $(NORMAL)
	#$(ARGOCD) proj get $(ACD_ROLE_PROJECT_NAME)

_acd_show_policy_role:
	@$(INFO) '$(ACD_UI_LABEL)Showing role of policy "$(ACD_POLICY_NAME)" ...'; $(NORMAL)
	$(ARGOCD) proj role get $(ACD_POLICY_PROJECT_NAME) $(ACD_POLICY_ROLE_NAME)

_acd_view_policies:
	@$(INFO) '$(ACD_UI_LABEL)Viewing policies ...'; $(NORMAL)
	#$(ARGOCD) proj role list $(ACD_ROLE_PROJECT_NAME)

_acd_view_policies_set:
	@$(INFO) '$(ACD_UI_LABEL)Viewing policis-set "$(ACD_POLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Policies are grouped based on provided role and regex'; $(NORMAL)
	#$(ARGOCD) proj role list $(ACD_ROLE_PROJECT_NAME) $(|_ACD_VIEW_ROLES_SET)
