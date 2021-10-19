_GPG_MK_VERSION= 0.99.4

# GPG_PARAMETER?= value

# Derived parameters

# Option parameters

# UI parameters
GPG_UI_LABEL?=[gpg] #

#--- Utilities

# __GPG_ENVIRONMENT+=
# __GPG_OPTIONS+= $(if $(filter true, $(GPG_DEBUG)), --debug)
GPG_BIN?= gpg
GPG?= $(strip $(__GPG_ENVIRONMENT) $(GPG_ENVIRONMENT) $(GPG_BIN) $(__GPG_OPTIONS) $(GPG_OPTIONS))

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _gpg_install_framework_dependencies
_gpg_install_framework_dependencies ::

_view_framework_macros :: _gpg_view_framework_macros
_gpg_view_framework_macros ::
	@#echo 'GPG:: ($(_GPG_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _gpg_view_framework_parameters
_gpg_view_framework_parameters ::
	@echo 'GPG:: ($(_GPG_MK_VERSION)) variables:'
	@echo '    GPG=$(GPG)'
	@echo

_view_framework_targets :: _gpg_view_framework_targets
_gpg_view_framework_targets ::
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

