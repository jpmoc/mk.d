_TERRAFORM_TEMPLATE_MK_VERSION= $(_TERRAFORM_MK_VERSION)

# TFM_TEMPLATE_COLOR_FLAG?= false
TFM_TEMPLATE_DIFF_FLAG?= false
# TFM_TEMPLATE_DIRPATH?= ./in/snaplogic/
TFM_TEMPLATE_LIST_FLAG?= false
# TFM_TEMPLATE_NAME?= snaplogic
# TFM_TEMPLATE_VARIABLES_KEYVALUES?= key=value ...
# TFM_TEMPLATE_VARIABLES_FILEPATHS?= filepath1 ...
# TFM_TEMPLATES_DIRPATH?= ./in/
# TFM_TEMPLATES_SET_NAME?= my-templates-set

# Derived variables
TFM_TEMPLATE_COLOR_FLAG?= $(TFM_COLOR_FLAG)
TFM_TEMPLATE_DIRPATH?= $(TFM_TEMPLATES_DIRPATH)$(TFM_TEMPLATE_NAME)/
TFM_TEMPLATE_VARIABLES_FILEPATHS?= $(TFM_VARIABLES_FILEPATHS)
TFM_TEMPLATE_VARIABLES_KEYVALUES?= $(TFM_VARIABLES_KEYVALUES)

# Options variables
__TFM_CHECK_VARIABLES?= $(if $(TFM_CHECK_VARIABLES),-check-variables=$(TFM_CHECK_VARIABLES))
__TFM_DIFF?= $(if $(TFM_TEMPLATE_DIFF_FLAG),-diff=$(TFM_TEMPLATE_DIFF_FLAG))
__TFM_LIST?= $(if $(TFM_TEMPLATE_LIST_FLAG),-list=$(TFM_TEMPLATE_LIST_FLAG))
__TFM_NO_COLOR__TEMPLATE?= $(if $(filter false, $(TFM_TEMPLATE_COLOR_FLAG)),-no-color)
__TFM_VAR__TEMPLATE?= $(foreach KV, $(TFM_TEMPLATE_VARIABLES_KEYVALUES),-var '$(KV)' )# With ticks!
__TFM_VAR_FILE__TEMPLATE?= $(foreach F, $(TFM_TEMPLATE_VARIABLES_FILEPATHS),-var-file=$(F) )

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@#echo 'TerraForM::Template ($(_TERRAFORM_TEMPLATE_MK_VERSION)) macros:'
	@#echo

_tfm_view_framework_parameters ::
	@echo 'TerraForM::Template ($(_TERRAFORM_TEMPLATE_MK_VERSION)) parameters:'
	@echo '    TFM_DETAILED_EXITCODE=$(TFM_DETAILED_EXITCODE)'
	@echo '    TFM_DRAW_CYCLES=$(TFM_DRAW_CYCLES)'
	@echo '    TFM_FORCE=$(TFM_FORCE) ==> $(TFM_FORCE_DELETE) $(TFM_FORCE_DESTROY)'
	@echo '    TFM_FORMAT_DIFF=$(TFM_FORMAT_DIFF)'
	@echo '    TFM_IMPORT_CONFIG_DIR=$(TFM_IMPORT_CONFIG_DIR)'
	@echo '    TFM_MODULE_DEPTH=$(TFM_MODULE_DEPTH)'
	@echo '    TFM_PLAN_FILEPATH=$(TFM_PLAN_FILEPATH)'
	@echo '    TFM_PARALLELISM=$(TFM_PARALLELISM)'
	@echo '    TFM_TEMPLATE_COLOR_FLAG=$(TFM_TEMPLATE_COLOR_FLAG)'
	@echo '    TFM_TEMPLATE_DIRPATH=$(TFM_TEMPLATE_DIRPATH)'
	@echo '    TFM_TEMPLATE_NAME=$(TFM_TEMPLATE_NAME)'
	@echo '    TFM_TEMPLATE_VARIABLES_KEYVALUES=$(TFM_TEMPLATE_VARIABLES_KEYVALUES)'
	@echo '    TFM_TEMPLATE_VARIABLES_FILEPATHS=$(TFM_TEMPLATE_VARIABLES_FILEPATHS)'
	@echo '    TFM_TEMPLATES_DIRPATH=$(TFM_TEMPLATES_DIRPATH)'
	@echo

_tfm_view_framework_targets ::
	@echo 'TerraForM::Template ($(_TERRAFORM_TEMPLATE_MK_VERSION)) targets:'
	@echo '    _tfm_show_template                 - Show everything related to a template'
	@echo '    _tfm_show_template_description     - Show description of a template'
	@echo '    _tfm_show_template_modules         - Show modules of a template'
	@echo '    _tfm_show_template_plugins         - Show plugins of a template'
	@echo '    _tfm_show_template_providers       - Show providers of a template'
	@echo '    _tfm_validate_template             - Validate the template'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tfm_show_template: _tfm_show_template_modules _tfm_show_template_providers _tfm_show_template_plugins _tfm_show_template_description

_tfm_show_template_description:
	@$(INFO) '$(TFM_UI_LABEL)Showing description of template "$(TFM_TEMPLATE_NAME)" ...'; $(NORMAL)

_tfm_show_template_modules:
	@$(INFO) '$(TFM_UI_LABEL)Showing modules of template "$(TFM_TEMPLATE_NAME)" ...'; $(NORMAL)

_tfm_show_template_plugins:
	@$(INFO) '$(TFM_UI_LABEL)Showing plugins of template "$(TFM_TEMPLATE_NAME)" ...'; $(NORMAL)

_tfm_show_template_providers:
	@$(INFO) '$(TFM_UI_LABEL)View providers for cluster "$(TFM_CLUSTER_NAME)" ...'; $(NORMAL)
	$(TERRAFORM) providers $(TFM_TEMPLATE_DIRPATH)

_tfm_validate_template:
	@$(INFO) '$(TFM_UI_LABEL)Validating template "$(TFM_TEMPLATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation validates and reformat the template'; $(NORMAL)
	$(TERRAFORM) fmt $(__TFM_CHECK_VARIABLES) $(__TFM_DIFF) $(__TFM_LIST) $(__TFM_NO_COLOR__TEMPLATE) $(TFM_TEMPLATE_DIRPATH)

_tfm_view_templates:
	@$(INFO) '$(TFM_UI_LABEL)View templates ...'; $(NORMAL)
	ls -l $(TFM_TEMPLATES_DIRPATH)

_tfm_view_templates_set:
	@$(INFO) '$(TFM_UI_LABEL)View templates-set "$(TFM_TEMPLATES_SET_NAME)" ...'; $(NORMAL)
