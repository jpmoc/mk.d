_TFE_MK_VERSION= 0.99.6

# TFE_ORGANIZATION_NAME?= 10841-10842-DEV
# TFE_SERVER_API_TOKEN?= 
TFE_SERVER_ENDPOINT_PROTO?= https://
# TFE_SERVER_ENDPOINT_URL?= https://tfe.domain.com
# TFE_SERVER_NAME?= tfe.domain.com
# TFE_WORKSPACE_NAME?= 123456789012-terraform-primer
TFE_WORKSPACES_REGEX?= *
# TFE_WORKSPACES_SET_NAME?= workspaces@@*

# Derived parameters
TFE_SERVER_ENDPOINT_URL?= $(TFE_SERVER_ENDPOINT_PROTO)$(TFE_SERVER_NAME)
TFE_WORKSPACES_SET_NAME?= workspace@@$(TFE_WORKSPACES_REGEX)

# Options parameters
__TFE_ENDPOINT= $(if $(TFE_SERVER_ENDPOINT_URL),--endpoint $(TFE_SERVER_ENDPOINT_URL))
__TFE_ORGANIZATION= $(if $(TFE_ORGANIZATION_NAME),--organization $(TFE_ORGANIZATION_NAME))
__TFE_WORKSPACE_NAME= $(if $(TFE_WORKSPACE_NAME),--workspace-name $(TFE_WORKSPACE_NAME))

# Pipe parameters
|_TFE_VIEW_WORKSPACES_SET?= | grep $(TFE_WORKSPACES_REGEX)

# UI parameters
TFE_UI_LABEL?= [tfe] #

#--- Utilities
TFE_BIN?= tfe
TFE?= $(strip $(_TFE_ENVIRONMENT) $(TFE_ENVIRONMENT) $(TFE_BIN) $(_TFE_OPTIONS) $(TFE_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _tfe_view_framework_macros
_tfe_view_framework_macros ::
	@echo 'TFE ($(_TFE_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _tfe_view_framework_parameters
_tfe_view_framework_parameters ::
	@echo 'TFE ($(_TFL_MK_VERSION)) parameters:'
	@echo '    TFE_ORGANIZATION_NAME=$(TFE_ORGANIZATION_NAME)'
	@echo '    TFE_SERVER_API_TOKEN=$(TFE_SERVER_API_TOKEN)'
	@echo '    TFE_SERVER_ENDPOINT_PROTO=$(TFE_SERVER_ENDPOINT_PROTO)'
	@echo '    TFE_SERVER_ENDPOINT_URL=$(TFE_SERVER_ENDPOINT_URL)'
	@echo '    TFE_SERVER_NAME=$(TFE_SERVER_NAME)'
	@echo '    TFE_WORKSPACE_NAME=$(TFE_WORKSPACE_NAME)'
	@echo '    TFE_WORKSPACES_REGEX=$(TFE_WORKSPACES_REGEX)'
	@echo '    TFE_WORKSPACES_SET_NAME=$(TFE_WORKSPACES_SET_NAME)'
	@echo

_view_framework_targets :: _tfe_view_framework_targets
_tfe_view_framework_targets ::
	@echo 'TFL ($(_TFE_MK_VERSION)) targets:'
	@echo '    _tfe_delete_workspace              - Delete the workspace'
	@echo '    _tfe_login_server                  - Log in the server'
	@echo '    _tfe_show_workspace                - Show everything related to a workspace'
	@echo '    _tfe_show_workspace_description    - Show everything related to a workspace'
	@echo '    _tfe_view_workspaces               - View ALL workspaces'
	@echo '    _tfe_view_workspaces_set           - View a set of workspaces'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tfe_login_server:
	@$(INFO) '$(TFE_UI_LABEL)Logging in server "$(TFE_SERVER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation takes a long time if the organization has thousands of workspaces'; $(NORMAL)
	$(TFE) login $(__TFE_ENDPOINT) $(__TFE_ORGANIZATION) $(__TFE_WORKSPACE_NAME)


# Workspace

_tfe_delete_workspace:
	@$(INFO) '$(TFE_UI_LABEL)Deleting workspace "$(TFE_WORKSPACE_NAME)" ...'; $(NORMAL)
	# $(TFE) workspace delete $(__TFL_ENV) $(__TFL_ORG) $(__TFL_TF_VERSION) $(__TFL_WORKSPACE)

_tfe_show_workspace: _tfl_show_workspace_description

_tfe_show_workspace_description:
	@$(INFO) '$(TFE_UI_LABEL)Showing description of workspace "$(TFE_WORKSPACE_NAME)" ...'; $(NORMAL)
	# $(TFE) workspace show $(__TFL_ENV) $(__TFL_ORG) $(__TFL_TF_VERSION) $(__TFL_WORKSPACE)

_tfe_view_workspaces:
	@$(INFO) '$(TFE_UI_LABEL)View ALL workspaces ...'; $(NORMAL)
	@$(WARN) 'This operation queries the active organization'; $(NORMAL)
	$(TFE) workspace list $(_X__TFE_ORGANIZATION)

_tfe_view_workspaces_set:
	@$(INFO) '$(TFE_UI_LABEL)View "$(TFE_WORKSPACES_SET_NAME)" workspaces-set ...'; $(NORMAL)
	@$(WARN) 'This operation queries the active organization'; $(NORMAL)
	@$(WARN) 'Workspaces are grouped based on the regex'; $(NORMAL)
	$(TFE) workspace list $(_X__TFE_ORGANIZATION) $(|_TFE_VIEW_WORKSPACES_SET)
