_SOPS_CONFIG_MK_VERSION= $(_SOPS_MK_VERSION)

SPS_CONFIG_FILEPATH?= $(HOME)/.sops.yaml

# Derived variables

# Options variables

# UI parameters

# Pipe

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sps_view_framework_macros ::
	@echo 'SoPS::Config ($(_SOPS_CONFIG_MK_VERSION)) macros:'
	@echo

_sps_view_framework_parameters ::
	@echo 'SoPS::Config ($(_SOPS_CONFIG_MK_VERSION)) parameters:'
	@echo '    SPS_CONFIG_FILEPATH=$(SPS_CONFIG_FILEPATH)'
	@echo

_sps_view_framework_targets ::
	@echo 'SoPS::Config ($(_SOPS_CONFIG_MK_VERSION)) targets:'
	@echo '    _sps_edit_config                  - Edit the config'
	@echo '    _sps_show_config                  - Show everything related to config ' 
	@echo '    _sps_show_config_content          - Show content of config' 
	@echo '    _sps_show_config_description      - Show description of config' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sps_edit_config:
	@$(INFO) '$(SPS_UI_LABEL)Editing config...'; $(NORMAL)
	$(EDITOR) $(SPS_CONFIG_FILEPATH)

_sps_show_config: _sps_show_config_content _sps_show_config_description

_sps_show_config_description:
	@$(INFO) '$(SPS_UI_LABEL)Showing description of the config ...'; $(NORMAL)
	[ ! -f $(SPS_CONFIG_FILEPATH) ] || ls -al $(SPS_CONFIG_FILEPATH)

_sps_show_config_content:
	@$(INFO) '$(SPS_UI_LABEL)Showing content of config ...'; $(NORMAL)
	[ ! -f $(SPS_CONFIG_FILEPATH) ] || cat $(SPS_CONFIG_FILEPATH)
