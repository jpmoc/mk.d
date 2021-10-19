_APPCHECK_COMPONENT_MK_VERSION= $(_APPCHECK_MK_VERSION)

# ACK_COMPONENT_API_URL?= https://appcheck.eng.vmware.com/api
# ACK_COMPONENT_NAME?= libpng

# Derived parameters
ACK_COMPONENT_API_URL?= $(ACK_API_URL)

# Option parameters
__ACK_HEADERS__COMPONENT+= --header 'Group: 4'
__ACK_HEADERS__COMPONENT+= $(if $(ACK_COMPONENT_OBJECT_URL),--header 'Url: $(ACK_COMPONENT_OBJECT_URL)')

# Pipe parameters
|_ACK_SHOW_COMPONENT_DESCRIPTION?= | jq --monochrome-output '.component'
|_ACK_SHOW_COMPONENT_VULNERABILITIES?= | jq --monochrome-output '.vulns'

# UI parameters
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ack_view_framework_macros ::
	@echo 'AppChecK::Component ($(_APPCHECK_COMPONENT_MK_VERSION)) macros:'
	@echo

_ack_view_framework_parameters ::
	@echo 'AppChecK::Component ($(_APPCHECK_COMPONENT_MK_VERSION)) parameters:'
	@echo '    ACK_COMPONENT_API_URL=$(ACK_COMPONENT_API_URL)'
	@echo '    ACK_COMPONENT_NAME=$(ACK_COMPONENT_NAME)'
	@echo '    ACK_COMPONENT_PRODUCT_ID=$(ACK_COMPONENT_PRODUCT_ID)'
	@echo '    ACK_COMPONENT_USER_NAME=$(ACK_COMPONENT_USER_NAME)'
	@echo '    ACK_COMPONENT_USER_PASSWORD=$(ACK_COMPONENT_USER_PASSWORD)'
	@echo

_ack_view_framework_targets ::
	@echo 'AppChecK::Component ($(_APPCHECK_COMPONENT_MK_VERSION)) targets:'
	@echo '    _ack_show_component                - Show everything related to a component'
	@echo '    _ack_show_component_results        - Show results of a component'
	@echo '    _ack_show_component_status         - Show status of a component'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ack_show_component: _ack_show_component_vulnerabilities _ack_show_component_description

_ack_show_component_description:
	@$(INFO) '$(ACK_UI_LABEL)Show description of component "$(ACK_COMPONENT_NAME)" ...'; $(NORMAL)
	$(APPCHECK) -s -X GET $(ACK_COMPONENT_API_URL)/components/$(ACK_COMPONENT_NAME)/ $(|_ACK_SHOW_COMPONENT_DESCRIPTION)

_ack_show_component_vulnerabilities:
	@$(INFO) '$(ACK_UI_LABEL)Show vulnerabilities of component "$(ACK_COMPONENT_NAME)" ...'; $(NORMAL)
	$(APPCHECK) -s -X GET $(ACK_COMPONENT_API_URL)/components/$(ACK_COMPONENT_NAME)/vulns/ $(|_ACK_SHOW_COMPONENT_VULNERABILITIES)
