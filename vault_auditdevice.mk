_VAULT_AUDITDEVICE_MK_VERSION= $(_VAULT_MK_VERSION)

# VLT_AUDITDEVICE_CONFIG?= file_path=/tmp/my-file.txt
# VLT_AUDITDEVICE_DESCRIPTION?= "This is my audit-device"
# VLT_AUDITDEVICE_FILE_FILEPATH?= /tmp/my-file.txt
# VLT_AUDITDEVICE_NAME?= local-file
# VLT_AUDITDEVICE_PATH?= file/
# VLT_AUDITDEVICE_TYPE?= file
VLT_AUDITDEVICES_DETAILED_FLAG?= false
# VLT_AUDITDEVICES_SET_NAME?= my-secrets-set

# Derived variables
VLT_AUDITDEVICE_CONFIG?= $(if $(VLT_AUDITDEVICE_FILE_FILEPATH),file_path=$(VLT_AUDITDEVICE_FILE_FILEPATH))
VLT_AUDITDEVICE_PATH?= $(if $(VLT_AUDITDEVICE_TYPE),$(VLT_AUDITDEVICE_TYPE)/)

# Options variables
__VLT_DESCRIPTION__AUDITDEVICE= $(if $(VLT_AUDITDEVICE_DESCRIPTION),--description $(VLT_AUDITDEVICE_DESCRIPTION))
__VLT_DETAILED__AUDITDEVICES= $(if $(VLT_AUDITDEVICES_DETAILED_FLAG),--detailed=$(VLT_AUDITDEVICES_DETAILED_FLAG))
__VLT_LOCAL=
__VLT_PATH__AUDITDEVICE= $(if $(VLT_AUDITDEVICE_PATH),--path $(VLT_AUDITDEVICE_PATH))

# Pipe

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::AuditDevice ($(_VAULT_AUDITDEVICE_MK_VERSION)) macros:'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::AuditDevice ($(_VAULT_AUDITDEVICE_MK_VERSION)) parameters:'
	@echo '    VLT_AUDITDEVICE_CONFIG=$(VLT_AUDITDEVICE_CONFIG)'
	@echo '    VLT_AUDITDEVICE_DESCRIPTION=$(VLT_AUDITDEVICE_DESCRIPTION)'
	@echo '    VLT_AUDITDEVICE_FILE_FILEPATH=$(VLT_AUDITDEVICE_FILE_FILEPATH)'
	@echo '    VLT_AUDITDEVICE_NAME=$(VLT_AUDITDEVICE_NAME)'
	@echo '    VLT_AUDITDEVICE_PATH=$(VLT_AUDITDEVICE_PATH)'
	@echo '    VLT_AUDITDEVICE_TYPE=$(VLT_AUDITDEVICE_TYPE)'
	@echo '    VLT_AUDITDEVICES_DETAILED_FLAG=$(VLT_AUDITDEVICES_DETAILED_FLAG)'
	@echo '    VLT_AUDITDEVICES_SET_NAME=$(VLT_AUDITDEVICES_SET_NAME)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::AuditDevice ($(_VAULT_AUDITDEVICE_MK_VERSION)) targets:'
	@echo '    _vlt_disable_auditdevice              - Disable an audit-device'
	@echo '    _vlt_enable_auditdevice               - Enable an audit-device'
	@echo '    _vlt_show_auditdevice                 - Show everything related to an audit-device'
	@echo '    _vlt_show_auditdevice_description     - Show description of an audit-device'
	@echo '    _vlt_view_auditdevices                - View audit-devices'
	@echo '    _vlt_view_auditdevices_set            - View set of audit-devices'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_create_auditdevice: _vlt_enable_auditdevice

_vlt_delete_auditdevice: _vlt_disable_auditdevice

_vlt_disable_auditdevice:
	@$(INFO) '$(VLT_UI_LABEL)Disabling audit-device "$(VLT_AUDITDEVICE_NAME)" ...'; $(NORMAL)
	$(VAULT) audit disable $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_AUDITDEVICE_PATH)

_vlt_enable_auditdevice:
	@$(INFO) '$(VLT_UI_LABEL)Enabling audit-device "$(VLT_AUDITDEVICE_NAME)" ...'; $(NORMAL)
	$(VAULT) audit enable $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_DESCRIPTION__AUDITDEVICE) $(__VLT_LOCAL) $(__VLT_PATH__AUDITDEVICE) $(VLT_AUDITDEVICE_TYPE) $(VLT_AUDITDEVICE_CONFIG)

_vlt_show_auditdevice: _vlt_show_auditdevice_description

_vlt_show_auditdevice_descritpion:
	@$(INFO) '$(VLT_UI_LABEL)Showing description of audit-device "$(VLT_AUDITDEVICE_NAME)" ...'; $(NORMAL)

_vlt_view_auditdevices:
	@$(INFO) '$(VLT_UI_LABEL)Viewing audit-devices ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no audit-devices are enabled'; $(NORMAL)
	-$(VAULT) audit list $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_DETAILED__AUDITDEVICES)

_vlt_view_auditdevices_set:
	@$(INFO) '$(VLT_UI_LABEL)Viewing audit-devices-set "$(VLT_AUDITDEVICES_SET_NAME)" ...'; $(NORMAL)
