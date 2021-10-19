_AZ_CONFIGURE_MK_VERSION= 0.99.0

# CFE_CONFIG_FILEPATH?= $(HOME)/.azure/config
# CFE_DEFAULTS_KEYVALUES?= group='' location='' vm='' web='' ...
# CFE_PARAMETER?= value

# Derived parameters
CFE_CONFIG_FILEPATH?= $(HOME)/.azure/config
CFE_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)

# Options parameters
__CFE_DEFAULTS= $(if $(CFE_DEFAULTS_KEYVALUES),--defaults $(CFE_DEFAULTS_KEYVALUES))
__CFE_OUTPUT= $(if $(CFE_OUTPUT_FORMAT),--output $(CFE_OUTPUT_FORMAT))
___CFE_GLOBALS= $(__CFE_OUTPUT)

# UI parameters
CFE_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _cfe_view_framework_macros
_cfe_view_framework_macros ::
	@#echo 'AZ::ConFigurE ($(_AZ_CONFIGURE_MK_VERSION)) macros:'
	@#echo

_az_view_framework_parameters :: _cfe_view_framework_parameters
_cfe_view_framework_parameters ::
	@echo 'AZ::ConFigurE ($(_AZ_CONFIGURE_MK_VERSION)) parameters:'
	@echo '    CFE_CONFIG_FILEPATH=$(CFE_CONFIG_FILEPATH)'
	@echo '    CFE_DEFAULTS_KEYVALUES=$(CFE_DEFAULT_KEYVALUES)'
	@echo '    CFE_OUTPUT_FORMAT=$(CFE_OUTPUT_FORMAT)'
	@echo

_az_view_framework_targets :: _cfe_view_framework_targets
_cfe_view_framework_targets ::
	@echo 'AZ::ConFigurE ($(_AZ_CONFIGURE_MK_VERSION)) targets:'
	@echo '    _cfe_show_configuration               - Show everything related to the configuration'
	@echo '    _cfe_show_configuration_content       - Show content of the configuration'
	@echo '    _cfe_show_configuration_description   - Show description of the configuration'
	@echo '    _cfe_create_defaults                  - Creating new defaults'
	@echo '    _cfe_deleting_defaults                - Deleting the defaults'
	@echo '    _cfe_show_defaults                    - Show the defaults'
	@echo '    _cfe_update_defaults                  - Update the defaults'
	@echo '    _cfe_view_defaults                    - View defaults'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
# -include $(MK_DIR)/az_account_subscription.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cfe_show_configuration: _cfe_show_configuration_content _cfe_show_configuration_description

_cfe_show_configuration_content:
	@$(INFO) '$(ACT_UI_LABEL)Cat-ing configuration ...'; $(NORMAL)
	cat $(CFE_CONFIG_FILEPATH)

_cfe_show_configuration_description:
	@$(INFO) '$(ACT_UI_LABEL)Showing description of configuration ...'; $(NORMAL)
	ls -al $(CFE_CONFIG_FILEPATH)

_cfe_create_defaults:
	@$(INFO) '$(ACT_UI_LABEL)Creating/Setting defaults ...'; $(NORMAL)
	$(AZ) configure $(__CFE_DEFAULTS)

_cfe_delete_defaults:
	@$(INFO) '$(ACT_UI_LABEL)Deleting/Clearing defaults ...'; $(NORMAL)
	$(AZ) configure --defaults group='' location='' vm='' web=''

_cfe_show_defaults:
	@$(INFO) '$(ACT_UI_LABEL)Showing defaults ...'; $(NORMAL)
	$(AZ) configure $(__CFE_GLOBALS) --list-default

_cfe_update_defaults:
	@$(INFO) '$(ACT_UI_LABEL)Updating/Resetting defaults ...'; $(NORMAL)
	$(AZ) configure $(__CFE_DEFAULTS)

# Other defaults can be added, such as the default-subscription
_cfe_view_defaults :: _cfe_show_defaults
