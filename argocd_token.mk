_ARGOCD_TOKEN_MK_VERSION= $(_ARGOCD_MK_VERSION)

ACD_TOKEN_EXPIRATION?= 0s
# ACD_TOKEN_ID?=
# ACD_TOKEN_JWT?=
# ACD_TOKEN_NAME?= my-token
# ACD_TOKEN_ROLE_NAME?= default
# ACD_TOKEN_PROJECT_NAME?= default
# ACD_TOKENS_PROJECT_NAME?= my-roles-seo
ACD_TOKENS_REGEX?= *
# ACD_TOKENS_ROLE_NAME?= my-roles
# ACD_TOKENS_SET_NAME?= my-roles-set

# Derived parameters
ACD_TOKEN_NAME?= token-$(ACD_TOKEN_ROLE_NAME)
ACD_TOKEN_PROJECT_NAME?= $(ACD_PROJECT_NAME)
ACD_TOKEN_ROLE_NAME?= $(ACD_ROLE_NAME)
ACD_TOKENS_PROJECT_NAME?= $(ACD_TOKEN_PROJECT_NAME)
ACD_TOKENS_ROLE_NAME?= $(ACD_TOKEN_ROLE_NAME)
ACD_TOKENS_SET_NAME?= tokens@@@$(ACD_TOKENS_ROLE_NAME)

# Option parameters
__ACD_EXPIRES_IN= $(if $(ACD_TOKEN_EXPIRATION),--expires-in $(ACD_TOKEN_EXPIRATION))

# Pipe parameters
|_ACD_SHOW_TOKEN?= | tee role_token >/dev/null
# |_ACD_SHOW_TOKEN?= | cut  -d . -f 2 | base64 --decode 2>/dev/null
|_ACD_VIEW_TOKENS_SET?= #| grep -E 'ROLE-NAME|$(ACD_ROLES_REGEX)'

# UI parameters

#--- Utilities

#--- MACROS
_acd_get_token_jwt= $(call _acd_get_token_jwt_R, $(ACD_TOKEN_ROLE_NAME))
_acd_get_token_jwt_R= $(call _acd_get_token_jwt_RP, $(1), $(ACD_TOKEN_PROJECT_NAME))
_acd_get_token_jwt_RP= $(call _acd_get_token_jwt_RPE, $(1), $(2), $(ACD_TOKEN_EXPIRATION))
_acd_get_token_jwt_RPE= $(shell $(ARGOCD) proj role create-token --expires-in $(3) $(2) $(1))

#----------------------------------------------------------------------
# USAGE
#

_acd_view_framework_macros ::
	@echo 'ArgoCD::Token ($(_ARGOCD_TOKEN_MK_VERSION)) macros:'
	@echo '    _acd_get_token_jwt          - Get a JWT-token for a role (Role,Project,Expiration)'
	@echo

_acd_view_framework_parameters ::
	@echo 'ArgoCD::Token ($(_ARGOCD_TOKEN_MK_VERSION)) parameters:'
	@echo '    ACD_TOKEN_EXPIRATION=$(ACD_TOKEN_EXPIRATION)'
	@echo '    ACD_TOKEN_ID=$(ACD_TOKEN_ID)'
	@echo '    ACD_TOKEN_JWT=$(ACD_TOKEN_JWT)'
	@echo '    ACD_TOKEN_NAME=$(ACD_TOKEN_NAME)'
	@echo '    ACD_TOKEN_PROJECT_NAME=$(ACD_TOKEN_PROJECT_NAME)'
	@echo '    ACD_TOKEN_ROLE_NAME=$(ACD_TOKEN_ROLE_NAME)'
	@echo '    ACD_TOKENS_PROJECT_NAME=$(ACD_TOKENS_PROJECT_NAME)'
	@echo '    ACD_TOKENS_REGEX=$(ACD_TOKENS_REGEX)'
	@echo '    ACD_TOKENS_ROLE_NAME=$(ACD_TOKENS_ROLE_NAME)'
	@echo '    ACD_TOKENS_SET_NAME=$(ACD_TOKENS_SET_NAME)'
	@echo

_acd_view_framework_targets ::
	@echo 'ArgoCD::Token ($(_ARGOCD_TOKEN_MK_VERSION)) targets:'
	@echo '    _acd_create_token                - Create a token'
	@echo '    _acd_delete_token                - Delete a token'
	@echo '    _acd_show_token                  - Show everything related to a token'
	@echo '    _acd_show_token_description      - Show description of a token'
	@echo '    _acd_show_token_policies         - Show policies of a token'
	@echo '    _acd_show_token_project          - Show project of a token'
	@echo '    _acd_show_token_role             - Show role for a token'
	@echo '    _acd_view_tokens                 - View tokens'
	@echo '    _acd_view_tokens_set             - View set of tokens'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_acd_create_token:
	@$(INFO) '$(ACD_UI_LABEL)Creating token "$(ACD_TOKEN_NAME)" ...'; $(NORMAL)
	$(ARGOCD) proj role create-token $(__ACD_EXPIRES_IN) $(ACD_TOKEN_PROJECT_NAME) $(ACD_TOKEN_ROLE_NAME)

_acd_delete_token:
	@$(INFO) '$(ACD_UI_LABEL)Deleting token "$(ACD_TOKEN_NAME)" ...'; $(NORMAL)
	$(ARGOCD) proj role delete-token $(ACD_TOKEN_PROJECT_NAME) $(ACD_TOKEN_ROLE_NAME) $(ACD_TOKEN_ID)

_acd_show_token :: _acd_show_token_policies _acd_show_token_project _acd_show_token_role _acd_show_token_description

_acd_show_token_description:
	@$(INFO) '$(ACD_UI_LABEL)Showing description of token "$(ACD_TOKEN_NAME)" ...'; $(NORMAL)
	$(if $(ACD_TOKEN_JWT), \
		echo $(ACD_TOKEN_JWT) | cut -d . -f 1 | base64 --decode 2>/dev/null | jq '.' ;\
		echo $(ACD_TOKEN_JWT) | cut -d . -f 2 | base64 --decode 2>/dev/null | jq '.' ;\
		echo $(ACD_TOKEN_JWT) | cut -d . -f 3 ;\
	, @\
		echo 'ACD_TOKEN_JWT not set' ;\
	)

_acd_show_token_policies:
	@$(INFO) '$(ACD_UI_LABEL)Showing policies of token "$(ACD_TOKEN_NAME)" ...'; $(NORMAL)
	# $(ARGOCD) proj role 

_acd_show_token_project:
	@$(INFO) '$(ACD_UI_LABEL)Showing project of token "$(ACD_TOKEN_NAME)" ...'; $(NORMAL)
	$(ARGOCD) proj get $(ACD_TOKEN_PROJECT_NAME)

_acd_show_token_role:
	@$(INFO) '$(ACD_UI_LABEL)Showing role of token "$(ACD_TOKEN_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns all the tokens that have been issued for that role'; $(NORMAL)
	$(ARGOCD) proj role get $(ACD_ROLE_PROJECT_NAME) $(ACD_ROLE_NAME)

_acd_view_tokens:
	@$(INFO) '$(ACD_UI_LABEL)Viewing tokens ...'; $(NORMAL)
	$(ARGOCD) proj role get $(ACD_ROLE_PROJECT_NAME) $(ACD_ROLE_NAME)

_acd_view_tokens_set:
	@$(INFO) '$(ACD_UI_LABEL)Viewing roles-set "$(ACD_ROLES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Roles are grouped based on provided project and regex'; $(NORMAL)
	$(ARGOCD) proj role get $(ACD_ROLE_PROJECT_NAME) $(ACD_ROLE_NAME) $(|_ACD_VIEW_TOKENS_SET)
