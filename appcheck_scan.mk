_APPCHECK_SCAN_MK_VERSION= $(_APPCHECK_MK_VERSION)

# ACK_SCAN_API_URL?= https://appcheck.eng.vmware.com/api
# ACK_SCAN_PRODUCT_ID?= 98096
# ACK_SCAN_NAME?= my-scane
# ACK_SCAN_OBJECT_URL?= http://get.videolan.org/vlc/2.2.1/macosx/vlc-2.2.1.dmg
# ACK_SCAN_USER_NAME?= username
# ACK_SCAN_USER_PASSWORD?= password

# Derived parameters
ACK_SCAN_API_URL?= $(ACK_API_URL)
ACK_SCAN_NAME?= $(notdir $(basename $(ACK_SCAN_OBJECT_URL)))
ACK_SCAN_USER_NAME?= $(ACK_USER_NAME)
ACK_SCAN_USER_PASSWORD?= $(ACK_USER_PASSWORD)

# Option parameters
__ACK_HEADERS__SCAN+= --header 'Group: 4'
__ACK_HEADERS__SCAN+= $(if $(ACK_SCAN_OBJECT_URL),--header 'Url: $(ACK_SCAN_OBJECT_URL)')
__ACK_USER__SCAN= $(if $(ACK_SCAN_USER_NAME),--user $(ACK_SCAN_USER_NAME))$(if $(ACK_SCAN_USER_PASSWORD),:$(ACK_SCAN_USER_PASSWORD))

# Pipe parameters
|_ACK_CREATE_SCAN?= # | jq '.'

# UI parameters
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ack_view_framework_macros ::
	@echo 'AppChecK::Scan ($(_APPCHECK_SCAN_MK_VERSION)) macros:'
	@echo

_ack_view_framework_parameters ::
	@echo 'AppChecK::Scan ($(_APPCHECK_SCAN_MK_VERSION)) parameters:'
	@echo '    ACK_SCAN_API_URL=$(ACK_SCAN_API_URL)'
	@echo '    ACK_SCAN_NAME=$(ACK_SCAN_NAME)'
	@echo '    ACK_SCAN_PRODUCT_ID=$(ACK_SCAN_PRODUCT_ID)'
	@echo '    ACK_SCAN_USER_NAME=$(ACK_SCAN_USER_NAME)'
	@echo '    ACK_SCAN_USER_PASSWORD=$(ACK_SCAN_USER_PASSWORD)'
	@echo

_ack_view_framework_targets ::
	@echo 'AppChecK::Scan ($(_APPCHECK_SCAN_MK_VERSION)) targets:'
	@echo '    _ack_create_scan              - Create a scan'
	@echo '    _ack_show_scan                - Show everything related to a scan'
	@echo '    _ack_show_scan_results        - Show results of a scan'
	@echo '    _ack_show_scan_status         - Show status of a scan'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ack_create_scan:
	@$(INFO) '$(ACK_UI_LABEL)Starting scan "$(ACK_SCAN_NAME)" ...'; $(NORMAL)
	curl -s -X POST $(__ACK_HEADERS__SCAN) $(__ACK_USER__SCAN) $(ACK_SCAN_API_URL)/fetch/ $(|_ACK_CREATE_SCAN)

_ack_show_scan: _ack_show_scan_results _ack_show_scan_status

_ack_show_scan_results:

_ack_show_scan_status:
	@$(INFO) '$(ACK_UI_LABEL)Show status of scan "$(ACK_SCAN_NAME)" ...'; $(NORMAL)
	curl -X GET $(__ACK_USER__SCAN) $(ACK_SCAN_API_URL)/product/$(ACK_SCAN_PRODUCT_ID)/
