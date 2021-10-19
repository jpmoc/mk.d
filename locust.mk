_LOCUST_MK_VERSION= 0.99.0

# LCT_LOCUSFILE_FILEPATH?= ./locustfile.py

# Derived variables
LCT_MODE_DEBUG?= $(CMN_MODE_DEBUG)
LCT_MODE_INTERACTIVE?= $(CMN_MODE_INTERACTIVE)

# Option variables

# UI variables
LCT_UI_LABEL?= [locust] #
 
#--- Utilities
__LOCUST_OPTIONS+= $(if $(filter true, $(VKE_DEBUG_MODE)),--detail)

LOCUST_BIN?= locust
LOCUST?= $(strip $(__LOCUST_ENVIRONMENT) $(LOCUST_ENVIRONMENT) $(LOCUST_BIN) $(__LOCUST_OPTIONS) $(LOCUST_OPTIONS) )

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _lct_install_framework_dependencies
_lct_install_framework_dependencies:
	@$(INFO) '$(LCT_UI_LABEL)Install dependencies ....'; $(NORMAL)
	# Docs @ https://docs.locust.io/en/stable/installation.html
	sudo pip2 install locustio   # Issue with pip->pip3?
	which locust
	locust --version

_view_framework_macros :: _lct_view_framework_macros
_lct_view_framework_macros ::
	@#echo 'Locust ($(_LOCUST_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _lct_view_framework_parameters
_lct_view_framework_parameters ::
	@echo 'Locust:: ($(_LOCUST_MK_VERSION)) parameters:'
	@echo '    LOCUST=$(LOCUST)'
	@echo

_view_framework_targets :: _lct_view_framework_targets
_lct_view_framework_targets ::
	@echo 'Locust:: ($(_LOCUST_MK_VERSION)) targets:'
	@echo '    _lct_show_version                    - Show the version'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/locust_runner.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_lct_show_version:
	@$(INFO) '$(LCT_UI_LABEL)Showing version of utility ...'; $(NORMAL)
	$(LOCUST) --version
