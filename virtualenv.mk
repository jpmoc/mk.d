_VIRTUALENV_MK_VERSION= 0.99.3

# VEV_PARAMETER?= value

# Derived parameters

# Options parameters

# UI parameters
VEV_UI_LABEL?= [virtualenv] #

#--- Utilities

PIP?= pip3
PYTHON?= python3

# VIRTUALENV_BIN?= virtualenv
VIRTUALENV_BIN?= python3 -m venv
VIRTUALENV?= $(strip $(__VIRTUALENV_ENVIRONMENT) $(VIRTUALENV_ENVIRONMENT) $(VIRTUALENV_BIN) $(__VIRTUALENV_OPTIONS) $(VIRTUALENV_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _vev_view_framework_macros
_vev_view_framework_macros ::
	@echo 'VirtualEnV:: ($(_VIRTUALENV_MK_VERSION)) targets:'
	@echo


_view_framework_parameters :: _vev_view_framework_parameters
_vev_view_framework_parameters ::
	@echo 'VirtualEnV:: ($(_VIRTUALENV_MK_VERSION)) parameters:'
	@echo '    PIP=$(PIP)'
	@echo '    VIRTUALENV=$(VIRTUALENV)'
	@echo

_view_framework_targets :: _vev_view_framework_targets
_vev_view_framework_targets ::
	@echo 'VirtualEnV:: ($(_VIRTUALENV_MK_VERSION)) targets:'
	@echo '    _vev_install_dependencies              - Install dependencies'
	@echo '    _vev_show_version                      - Show version of utilities '
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/virtualenv_environment.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _vev_install_dependencies
_vev_install_dependencies ::
	@$(INFO) '$(VEV_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	# sudo pip install virtualenv
	# which virtualenv
	# virtualenv --version

_view_versions :: _vev_show_version
_vev_show_version ::
	@$(INFO) '$(VEV_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	$(PIP) --version
	$(PYTHON) --version
	# virtualenv --version
