_TERRAFORM_RESOURCE_MK_VERSION= $(_TERRAFORM_MK_VERSION)

# TFM_RESOURCE_IMPORT_CONFIGDIR?=
# TFM_RESOURCE_IMPORT_PROVIDER?= 
# TFM_RESOURCE_NAME?= i-abcd1234
# TFM_RESOURCES_SET_NAME?=

# Derived variables

# Options variables
__TFM_FORCE_DESTROY?= $(if $(filter true, $(TFM_RESOURCES_FORCEDESTROY_FLAG)),--force)
__TFM_CONFIG?=# $(if $(TFM_RESOURCE_IMPORT_CONFIGDIR), --config=$(TFM_RESOURCE_IMPORT_CONFIGDIR))
__TFM_PROVIDER?=# $(if $(TFM_IMPORT_PROVIDER), --provider=$(TFM_IMPORT_PROVIDER))

# Pipe 
_TFM_IMPORT_RESOURCE_|?=
_TFM_VIEW_RESOURCES_|?=

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@echo 'TerraForM::Resource ($(_TERRAFORM_RESOURCE_MK_VERSION)) macros:'
	@echo

_tfm_view_framework_parameters ::
	@echo 'TerraForM::Resource ($(_TERRAFORM_RESOURCE_MK_VERSION)) parameters:'
	@echo '    TFM_RESOURCE_IMPORT_CONFIGDIR=$(TFM_RESOURCE_IMPORT_CONFIGDIR)'
	@echo '    TFM_RESOURCE_IMPORT_PROVIDER=$(TFM_RESOURCE_IMPORT_PROVIDER)'
	@echo '    TFM_RESOURCE_NAME=$(TFM_RESOURCE_NAME)'
	@echo '    TFM_RESOURCES_SET_NAME=$(TFM_RESOURCES_SET_NAME)'
	@echo

_tfm_view_framework_targets ::
	@echo 'TerraForM::Resource ($(_TERRAFORM_RESOURCE_MK_VERSION)) targets:'
	@echo '    _tfm_create_resource              - Create a resource'
	@echo '    _tfm_delete_resource              - Delete a resource'
	@echo '    _tfm_import_resource              - Import resources into terraform'
	@echo '    _tfm_show_resource                - Show everything related to a resource'
	@echo '    _tfm_show_resource_description    - Show description of a resource'
	@echo '    _tfm_taint_resource               - Mark an existing resource for recreation'
	@echo '    _tfm_untaint_resource             - Remove taint mark on an existing resource'
	@echo '    _tfm_view_resources               - View ALL resources'
	@echo '    _tfm_view_resources_set           - View a set of resources'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tfm_create_resource:
	@$(INFO) '$(TFM_UI_LABEL)Creating resource "$(TFM_RESOURCE_NAME)" ...'; $(NORMAL)
	# To create a resource, update the associated stack

_tfm_delete_resource:
	@$(INFO) '$(TFM_UI_LABEL)Deleting resource "$(TFM_REOSURCE_NAME)" ...'; $(NORMAL)
	# To delete a resource, update the associated stack

_tfm_import_resource:
	@$(INFO) '$(TFM_UI_LABEL)Importing resource "$(TFM_RESOURCE_NAME)" in terraform state ...'; $(NORMAL)
	# $(_TFM_IMPORT_RESOURCE_|); $(TERRAFORM) import $(__TFM_BACKUP__RESOURCE) $(__TFM_CONFIG) $(__TFM_INPUT__RESOURCE) $(__TFM_LOCK__RESOURCE) $(__TFM_LOCK_TIMEOUT__RESOURCE) $(__TFM_NO_COLOR__RESOURCE) $(__TFM_PROVIDER) $(__TFM_STATE__RESOURCE) $(__TFM_VAR__RESOURCE) $(__TFM_VAR_FILE__RESOURCE) $(TFM_TARGET_RESOURCE) $(TFM_IMPORT_RESOURCE)

_tfm_show_resource :: _tfm_show_resource_description

_tfm_show_resource_description:
	@$(INFO) '$(TFM_UI_LABEL)Showing description of resource "$(TFM_RESOURCE_NAME)" ...'; $(NORMAL)
	# Not implemented yet!

_tfm_taint_resource:
	@$(INFO) '$(TFM_UI_LABEL)Tainting resource "$(TFM_RESOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This resource is marked for deletion/creation at next "terraform apply"'; $(NORMAL)
	# $(TERRAFORM) taint $(__TFM_ALLOW_MISSING) $(__TFM_BACKUP__RESOURCE) $(__TFM_LOCK__RESOURCE) $(__TFM_LOCK_TIMEOUT__RESOURCE) $(__TFM_STATE__RESOURCE) $(__TFM_STATE_OUT__RESOURCE) $(TFM_RESOURCE_NAME)

_tfm_untaint_resource:
	@$(INFO) '$(TFM_UI_LABEL)Unttainting resource "$(TFM_RESOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This resource is marked for deletion/creation at next "terraform apply"'; $(NORMAL)
	# $(TERRAFORM) untaint $(__TFM_ALLOW_MISSING) $(__TFM_BACKUP__RESOURCE) $(__TFM_LOCK__RESOURCE) $(__TFM_LOCK_TIMEOUT__RESOURCE) $(__TFM_STATE__RESOURCE) $(__TFM_STATE_OUT_RESOURCE) $(TFM_RESOURCE_NAME)

_tfm_view_resources:
	@$(INFO) "$(TFM_UI_LABEL)View ALL resources ..."; $(NORMAL)
	@$(WARN) 'Resources are grouped by stack'; $(NORMAL)
	$(_TFM_VIEW_RESOURCES_|) $(TERRAFORM) show $(__TFM_JSON__RESOURCES) $(__TFM_NO_COLOR__RESOURCES) $(TFM_RESOURCES_STATE_FILEPATH)

_tfm_view_resources_set:
	@$(INFO) "$(TFM_UI_LABEL)View resources-set "$(TFM_RESOURCES_SET_NAME)" ..."; $(NORMAL)
