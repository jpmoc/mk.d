_GPG_MK_VERSION= 0.99.4

GPG_UI_LABEL?=[gpg] #

# Derived parameters

# Options

# Customizations

#--- Utilities

# __GPG_ENVIRONMENT+=
# __GPG_OPTIONS+= $(if $(filter true, $(GPG_DEBUG)), --debug)
GPG_BIN?= gpg
GPG?= $(strip $(__GPG_ENVIRONMENT) $(GPG_ENVIRONMENT) $(GPG_BIN) $(__GPG_OPTIONS) $(GPG_OPTIONS))

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_install_dependencies :: _gpg_install_dependencies
_gpg_install_dependencies ::

_list_macros :: _gpg_list_macros
_gpg_list_macros ::
	@#echo 'GPG:: ($(_GPG_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _gpg_list_parameters
_gpg_list_parameters ::
	@echo 'GPG:: ($(_GPG_MK_VERSION)) variables:'
	@echo '    GPG=$(GPG)'
	@echo '    GPG_UI_LABEL=$(GPG_UI_LABEL)'
	@echo

_list_targets :: _gpg_list_targets
_gpg_list_targets ::
	@echo 'GPG:: ($(_GPG_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/gpg_file.mk


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

