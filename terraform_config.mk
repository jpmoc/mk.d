_TERRAFORM_CONFIG_MK_VERSION= $(_TERRAFORM_MK_VERSION)

# TFM_CONFIG_DIRPATH?= $(VOME)/.terraform.d
# TFM_CONFIG_FILEPATH?= $(VOME)/.terraformrc
# TFM_CONFIG_PLUGINCACHE_DIRPATH?= $(HOME)/.terraform.d/plugin-cache

# Derived variables
TFM_CONFIG_DIRPATH?= $(HOME)/.terraform.d/
TFM_CONFIG_FILEPATH?= $(HOME)/.terraformrc
TFM_CONFIG_PLUGINCACHE_DIRPATH?= $(TFM_CONFIG_DIRPATH)plugin-cache/

# Options variables

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@echo 'TerraForM::Config ($(_TERRAFORM_TEMPLATE_MK_VERSION)) macros:'
	@echo

_tfm_view_framework_parameters ::
	@echo 'TerraForM::Config ($(_TERRAFORM_CONFIG_MK_VERSION)) parameters:'
	@echo '    TFM_CONFIG_DIRPATH=$(TFM_CONFIG_DIRPATH)'
	@echo '    TFM_CONFIG_FILEPATH=$(TFM_CONFIG_FILEPATH)'
	@echo '    TFM_CONFIG_PLUGINCACHE_DIRPATH=$(TFM_CONFIG_PLUGINCACHE_DIRPATH)'
	@echo

_tfm_view_framework_targets ::
	@echo 'TerraForM::Config ($(_TERRAFORM_CONFIG_MK_VERSION)) targets:'
	@echo '    _tfm_show_config                 - Show everything related to the config'
	@echo '    _tfm_show_config_content         - Show content of the config'
	@echo '    _tfm_show_config_description     - Show description of the config'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tfm_show_config: _tfm_show_config_content _tfm_show_config_description

_tfm_show_config_content:
	@$(INFO) '$(TFM_UI_LABEL)Showing content of the configuration ...'; $(NORMAL)
	[ ! -f $(TFM_CONFIG_FILEPATH) ] || cat $(TFM_CONFIG_FILEPATH)

_tfm_show_config_description:
	@$(INFO) '$(TFM_UI_LABEL)Showing description of the configuration ...'; $(NORMAL)
	[ ! -f $(TFM_CONFIG_FILEPATH) ] || ls -l $(TFM_CONFIG_FILEPATH)
	-ls -al $(TFM_CONFIG_DIRPATH)
