_GCLOUD_CONFIG_CONFIGURATION_MK_VERSION= $(_GCLOUD_CONFIG_MK_VERSION)

GCG_CONFIGURATION_ACTIVATE?= true
# GCG_CONFIGURATION_NAME?= default

# Derived parameters
GCG_CONFIGURATION_NAME?= $(GCD_ACTIVECONFIGURATION_NAME)

# Options parameters
__GCG_ACTIVATE= $(if $(GCG_CONFIGURATION_ACTIVATE),--activate,--no-activate)

# UI parameters

#--- Utilities

#--- MACROS


#----------------------------------------------------------------------
# USAGE
#

_gcg_view_framework_macros ::
	@echo 'Gcloud::ConfiG::Configuration ($(_GCLOUD_CONFIG_CONFIGURATION_MK_VERSION)) macros:'
	@echo


_gcg_view_framework_parameters ::
	@echo 'Gcloud::ConfiG::Configuration ($(_GCLOUD_CONFIG_CONFIGURATION_MK_VERSION)) parameters:'
	@echo '    GCG_CONFIGURATION_ACTIVATE=$(GCG_CONFIGURATION_ACTIVATE)'
	@echo '    GCG_CONFIGURATION_NAME=$(GCG_CONFIGURATION_NAME)'
	@echo

_gcg_view_framework_targets ::
	@echo 'Gcloud::ConfiG::Configuration ($(_GCLOUD_CONFIG_CONFIGURATION_MK_VERSION)) targets:'
	@echo '    _gcg_active_configuration    - Activate a configuration'
	@echo '    _gcg_create_configuration    - Create a new configuration'
	@echo '    _gcg_delete_configuration    - Delete an existing configuration'
	@echo '    _gcg_init_configuration      - Delete an existing configuration'
	@echo '    _gcg_show_configuration      - Show configuration'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gcg_active_configuration:
	@$(INFO) '$(GCD_UI_LABEL)Activating configuration "$(GCG_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(GCLOUD) config configurations active $(GCG_CONFIGURATION_NAME)

_gcg_create_configuration:
	@$(INFO) '$(GCD_UI_LABEL)Creating new configuration "$(GCG_CONFIGURATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Newly created configurations are empty'; $(NORMAL)
	$(GCLOUD) config configurations create $(__GCG_ACTIVATE) $(GCG_CONFIGURATION_NAME)

_gcg_delete_configuration:
	@$(INFO) '$(GCD_UI_LABEL)Deleting configuration "$(GCG_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(GCLOUD) config configurations delete $(GCG_CONFIGURATION_NAME)

_gcg_init_configuration:
	@$(INFO) '$(GCD_UI_LABEL)Creating new configuration "default" ...'; $(NORMAL)
	@$(WARN) 'Properties in this configuration have been set to a sane default'; $(NORMAL)
	$(GCLOUD) init --console-only --skip-diagnostics
	ls -al $(HOME)/.config/gcloud/configurations/config_default

_gcg_show_configuration: _gcg_show_configuration_file _gcg_show_configuration_parameters _gcg_show_configuration_description

_gcg_show_configuration_description:
	@$(INFO) '$(GCD_UI_LABEL)Showing configuration "$(GCG_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(GCLOUD) config configurations describe $(GCG_CONFIGURATION_NAME)

_gcg_show_configuration_file:
	@$(INFO) '$(GCD_UI_LABEL)Showing file for configuration "$(GCG_CONFIGURATION_NAME)" ...'; $(NORMAL)
	ls -al $(HOME)/.config/gcloud/configurations/config_$(GCG_CONFIGURATION_NAME)

_gcg_show_configuration_parameters:
	@$(INFO) '$(GCD_UI_LABEL)Showing parameters of configuration "$(GCG_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(GCLOUD) config list --all

_gcg_view_configurations:
	@$(INFO) '$(GCD_UI_LABEL)Viewing configurations ...'; $(NORMAL)
