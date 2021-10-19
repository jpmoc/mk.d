_TERRAFORM_WORKSPACE_MK_VERSION= $(_TERRAFORM_MK_VERSION)

TFM_WORKSPACE_DELETE_FORCE?= false
# TFM_WORKSPACE_DIRPATH?= .../
TFM_WORKSPACE_NAME?= default
# TFM_WORKSPACES_DIRPATH?= .../

# Immutable variables
# TFM_CURRENT_WORKSPACE?= $(call _tfm_get_current_workspace)
TFM_WORKSPACES_DIRPATH= $(PWD)/terraform.tfstate.d/

# Derived variables
# TFM_STATE_DIR?= $(TFM_CLUSTER_DIR)
# TFM_STATE_FILENAME?= $(TFM_CLUSTER_NAME).tfstate
# TFM_STATE_FILEPATH?= $(TFM_STATE_DIR)/$(TFM_STATE_FILENAME)

# Options variables
__TFM_FORCE__WORKSPACE?= $(if $(filter true, $(TFM_WORKSPACE_DELETE_FORCE)), --force)
__TFM_STATE__WORKSPACE?= $(if $(TFM_WORKSPACE_STATE_FILEPATH),--state=$(TFM_WORKSPACE_STATE_FILEPATH))

# Pipe parameters

_TFM_VIEW_WORKSPACES_|?= cd $(TFM_WORKSPACE_DIRPATHS) && 
# Utilities

#--- MACROS
# _tfm_get_current_workspace= $(shell cd $(TFM_INIT_DIR); terraform workspace show)

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@echo 'TerraForM::Workspace ($(_TERRAFORM_WORKSPACE_MK_VERSION)) macros:'
	@#echo '    _tfm_get_current_workspace         - Get the current workspace'
	@echo

_tfm_view_framework_parameters ::
	@echo 'TerraForM::Workspace ($(_TERRAFORM_WORKSPACE_MK_VERSION)) parameters:'
	@echo '    TFM_WORKSPACE_DELETE_FORCE=$(TFM_WORKSPACE_DELETE_FORCE)'
	@echo '    TFM_WORKSPACE_DIRPATH=$(_TFM_WORKSPACE_DIRPATH)'
	@echo '    TFM_WORKSPACE_NAME=$(TFM_WORKSPACE_NAME)'
	@echo '    TFM_WORKSPACE_STATE_FILEPATH=$(TFM_WORKSPACE_STATE_FILEPATH)'
	@echo '    TFM_WORKSPACES_DIRPATH=$(_TFM_WORKSPACES_DIRPATH)'
	@echo

_tfm_view_framework_targets ::
	@echo 'TerraForM::Workspace ($(_TERRAFORM_WORKSPACE_MK_VERSION)) targets:'
	@echo '    _tfm_create_workspace              - Create a new workspace resources'
	@echo '    _tfm_delete_workspace              - Delete an existing workspace'
	@echo '    _tfm_select_workspace              - Switch to an existing workspace'
	@echo '    _tfm_view_workspaces               - View workspaces'
	@echo '    _tfm_view_workspaces_set           - View set of workspaces'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tfm_create_workspace:
	@$(INFO) '$(TFM_LABEL)Creating workspace "$(TFM_WORKSPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Current workspace is "$(TFM_CURRENT_WORKSPACE)"'; $(NORMAL)
	@$(WARN) 'Creating directory "$(TFM_WORKSPACE_DIRPATH)"'; $(NORMAL)
	$(TERRAFORM) workspace new $(__TFM_STATE__WORKSPACE) $(TFM_WORKSPACE_NAME)
	@$(WARN) 'You are now in workspace '$(TFM_WORKSPACE_NAME)''

_tfm_delete_workspace:
	@$(INFO) '$(TFM_LABEL)Deleting workspace "$(TFM_WORKSPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if you are trying to delete either the current or *default* workspace'; $(NORMAL)
	$(TERRAFORM) workspace delete $(__TFM_FORCE__WORKSPACE) $(TFM_WORKSPACE_NAME)

_tfm_switch_workspace:
	@$(INFO) '$(TFM_LABEL)Switching to workspace "$(TFM_WORKSPACE_NAME)" ...'; $(NORMAL)
	$(TERRAFORM) workspace select $(TFM_WORKSPACE_NAME)

_tfm_view_workspaces:
	@$(INFO) '$(TFM_LABEL)Viewing workspaces ...'; $(NORMAL)
	$(_TFM_VIEW_WORKSPACES_|) $(TERRAFORM) workspace list

_tfm_view_workspaces_set:
	@$(INFO) '$(TFM_LABEL)Viewing workspaces-set "$(TFM_WORKSPACES_SET_NAME)"  ...'; $(NORMAL)
	# $(TERRAFORM) workspace list
