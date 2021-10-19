_AZ_EXTENSION_MK_VERSION= 0.99.0

# ETN_EXTENSION_FILEPATH?= 
# ETN_EXTENSION_NAME?= 
# ETN_EXTENSION_SOURCE_URI?= 
ETN_EXTENSIONS_INSTALL_DIRPATH?= $(HOME)/.azure/cliextensions/
# ETN_EXTENSIONS_SET_NAME?= my-extensions-set
# ETN_OUTPUT_FORMAT?= table

# Derived parameters
ETN_EXTENSION_FILEPATH?= $(ETN_EXTENSIONS_INSTALL_DIRPATH)$(ETN_EXTENSION_NAME)
ETN_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)

# Options parameters
__ETN_OUTPUT= $(if $(ETN_OUTPUT_FORMAT),--output $(ETN_OUTPUT_FORMAT))
__ETN_NAME__EXTENSION= $(if $(ETN_EXTENSION_NAME),--name $(ETN_EXTENSION_NAME))
__ETN_SOURCE= $(if $(ETN_EXTENSION_SOURCE_URI),--source $(ETN_EXTENSION_SOURCE_URI))

# UI parameters
ETN_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _etn_view_framework_macros
_etn_view_framework_macros ::
	@#echo 'AZ::ExTensioN ($(_AZ_EXTENSION_MK_VERSION)) macros:'
	@#echo

_az_view_framework_parameters :: _etn_view_framework_parameters
_etn_view_framework_parameters ::
	@echo 'AZ::ExTensioN ($(_AZ_EXTENSION_MK_VERSION)) parameters:'
	@echo '    ETN_EXTENSION_FILEPATH=$(ETN_EXTENSION_FILEPATH)'
	@echo '    ETN_EXTENSION_NAME=$(ETN_EXTENSION_NAME)'
	@echo '    ETN_EXTENSION_SOURCE_URI=$(ETN_EXTENSION_SOURCE_URI)'
	@echo '    ETN_EXTENSIONS_INSTALL_DIRPATH=$(ETN_EXTENSIONS_INSTALL_DIRPATH)'
	@echo '    ETN_EXTENSIONS_SET_NAME=$(ETN_EXTENSIONS_SET_NAME)'
	@echo '    ETN_OUTPUT_FORMAT=$(ETN_OUTPUT_FORMAT)'
	@echo

_az_view_framework_targets :: _etn_view_framework_targets
_etn_view_framework_targets ::
	@echo 'AZ::ExTensioN ($(_AZ_EXTENSION_MK_VERSION)) targets:'
	@#echo '    _etn_create_extension                  - Creating a new extension'
	@#echo '    _etn_deleting_extension                - Deleting an extension'
	@echo '    _etn_install_extension                 - Install extension'
	@echo '    _etn_show_extension                    - Show everything related to an extension'
	@echo '    _etn_show_extension_description        - Show description of an extension'
	@echo '    _etn_uninstall_extension               - Uninstall extension'
	@echo '    _etn_view_extenstions                  - View all extensions'
	@echo '    _etn_view_extenstions_set              - View set of extensions'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
# -include $(MK_DIR)/az_account_subscription.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_etn_install_extension:
	@$(INFO) '$(ETN_UI_LABEL)Installing extension "$(ETN_EXTENSION_NAME)" ...'; $(NORMAL)
	$(AZ) extension add $(__ETN_NAME__EXTENSION) $(__ETN_SOURCE)

_etn_show_extension: _etn_show_extension_content _etn_show_extension_description

_etn_show_extension_content:
	@$(INFO) '$(ETN_UI_LABEL)Showing content of extension "$(ETN_EXTENSION_NAME)" ...'; $(NORMAL)
	tree -L 2 $(ETN_EXTENSION_FILEPATH) || true

_etn_show_extension_description:
	@$(INFO) '$(ETN_UI_LABEL)Showing description of extension "$(ETN_EXTENSION_NAME)" ...'; $(NORMAL)
	ls -dl $(ETN_EXTENSION_FILEPATH) || true

_etn_uninstall_extension:
	@$(INFO) '$(ETN_UI_LABEL)Uninstalling extension "$(ETN_EXTENSION_NAME)" ...'; $(NORMAL)
	$(AZ) extension remove $(__ETN_NAME__EXTENSION)

_etn_update_extension:
	@$(INFO) '$(ETN_UI_LABEL)Updating extension "$(ETN_EXTENSION_NAME)" ...'; $(NORMAL)
	$(AZ) extension update $(__ETN_NAME__EXTENSION)

# Other defaults can be added, such as the default-subscription
_etn_view_extensions: _etn_view_extensions_available _etn_view_extensions_installed

_etn_view_extensions_available:
	@$(INFO) '$(ETN_UI_LABEL)Viewing available extensions ...'; $(NORMAL)
	$(AZ) extension list-available $(__ETN_OUTPUT)

_etn_view_extensions_installed:
	@$(INFO) '$(ETN_UI_LABEL)Viewing installed extensions ...'; $(NORMAL)
	mkdir -pv $(ETN_EXTENSIONS_INSTALL_DIRPATH)
	-ls -l $(ETN_EXTENSIONS_INSTALL_DIRPATH)

_etn_view_extensions_set:
	@$(INFO) '$(ETN_UI_LABEL)Viewing extensions-set "$(ETN_EXTENSIONS_SET_NAME)" ...'; $(NORMAL)
