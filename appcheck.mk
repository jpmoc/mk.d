_APPCHECK_MK_VERSION= 0.99.0

# ACK_API_URL?= https://appcheck.eng.vmware.com/api
ACK_ENDPOINT_URL?= https://appcheck.eng.vmware.com#
# ACK_USER_NAME?= emayssat
# ACK_USER_PASSWORD?= password

# Derived variables
ACK_API_URL?= $(ACK_ENDPOINT_URL)/api

# Option variables

# UI variables
ACK_UI_LABEL?= [appcheck] #
 
#--- Utilities
__APPCHECK_OPTIONS+= $(if $(ACK_USER_NAME),--user $(ACK_USER_NAME)$(if $(ACK_USER_PASSWORD),:$(ACK_USER_PASSWORD)))
APPCHECK_BIN?= curl
APPCHECK?= $(strip $(__APPCHECK_ENVIRONMENT) $(APPCHECK_ENVIRONMENT) $(APPCHECK_BIN) $(__APPCHECK_OPTIONS) $(APPCHECK_OPTIONS) )

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _ack_view_framework_macros
_ack_view_framework_macros ::
	@#echo 'AppCheck:: ($(_APPCHECK_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _ack_view_framework_parameters
_ack_view_framework_parameters ::
	@echo 'AppChecK:: ($(_APPCHECK_MK_VERSION)) parameters:'
	@echo '    APPCHECK=$(APPCHECK)'
	@echo '    ACK_API_URL=$(ACK_API_URL)'
	@echo '    ACK_ENDPOINT_URL=$(ACK_ENDPOINT_URL)'
	@echo '    ACK_USER_NAME=$(ACK_USER_NAME)'
	@echo '    ACK_USER_PASSWORD=$(ACK_USER_PASSWORD)'
	@echo

_view_framework_targets :: _ack_view_framework_targets
_ack_view_framework_targets ::
	@echo 'AppCheck:: ($(_APPCHECK_MK_VERSION)) targets:'
	@echo '    _ack_install_dependencies            - Install the dependencies'
	@echo '    _ack_show_version                    - Show the version'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/appcheck_apikey.mk
-include $(MK_DIR)/appcheck_artifact.mk
-include $(MK_DIR)/appcheck_component.mk
-include $(MK_DIR)/appcheck_group.mk
-include $(MK_DIR)/appcheck_product.mk
-include $(MK_DIR)/appcheck_user.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _ack_install_dependencies
_ack_install_dependencies:
	@$(INFO) '$(VCD_UI_LABEL)Install Appcheck dependencies ....'; $(NORMAL)
	@$(WARN) 'Docs @ https://confluence.eng.vmware.com/pages/viewpage.action?spaceKey=SDL&title=Appcheck+Automation'; $(NORMAL)

_vke_show_version:
	@$(INFO) '$(VKE_UI_LABEL)Showing version of VKE utility ...'; $(NORMAL)
	# $(APPCHECK) --version
