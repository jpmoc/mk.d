_ZAPPA_MK_VERSION= 0.99.3

# ZPA_ACCESS_KEY_ID=

# Derived parameters

# Options parameters

# UI parameters
ZPA_UI_LABEL?= [zappa] #

#--- Utilities

ZAPPA_BIN?= zappa
ZAPPA?= $(strip $(__ZAPPA_ENVIRONMENT) $(ZAPPA_ENVIRONMENT) $(ZAPPA_BIN) $(__ZAPPA_OPTIONS) $(ZAPPA_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _zpa_view_framework_macros
_zpa_view_framework_macros ::
	@echo 'ZaPpa:: ($(_ZAPPA_MK_VERSION)) targets:'
	@echo


_view_framework_parameters :: _zpa_view_framework_parameters
_zpa_view_framework_parameters ::
	@echo 'ZaPpa:: ($(_ZAPPA_MK_VERSION)) parameters:'
	@echo '    ZAPPA=$(ZAPPA)'
	@echo

_view_framework_targets :: _zpa_view_framework_targets
_zpa_view_framework_targets ::
	@echo 'ZaPpa:: ($(_ZAPPA_MK_VERSION)) targets:'
	@echo '    _zpa_install_dependencies              - Install dependencies'
	@echo '    _zpa_show_version                      - Show versions of utilities '
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/zappa_application.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _zpa_install_dependencies
_zpa_install_dependencies ::
	@$(INFO) '$(ZPA_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	sudo pip install zappa
	which zappa
	zappa --version

_view_versions :: _zpa_show_version
_zpa_show_version ::
	@$(INFO) '$(ZPA_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	zappa --version
