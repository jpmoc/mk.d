_VAULT_SECRETENGINE_MK_VERSION= $(_VAULT_MK_VERSION)

# VLT_SECRETENGINE_DESCRIPTION?= "This is the description of my secrets-engine"
# VLT_SECRETENGINE_ENDPOINT_URL?=
# VLT_SECRETENGINE_NAME?= my-secret-engine
# VLT_SECRETENGINE_NEWPATH?= secret
# VLT_SECRETENGINE_OLDPATH?= secret
# VLT_SECRETENGINE_PATH?= secret
# VLT_SECRETENGINE_TYPE?= kv
# VLT_SECRETENGINE_UPDATE_CONFIG?= kv
VLT_SECRETENGINES_DETAILED_FLAG?= false
# VLT_SECRETENGINES_SET_NAME?= my-secrets-set

# Derived variables
VLT_SECRETENGINE_ENDPOINT_URL?= $(VLT_ENDPOINT_URL)A
VLT_SECRETENGINE_NAME?= $(if $(VLT_SECRETENGINE_TYPE),$(VLT_SECRETENGINE_TYPE):$(VLT_SECRETENGINE_PATH))
VLT_SECRETENGINE_PATH?= $(if $(VLT_SECRETENGINE_TYPE),$(VLT_SECRETENGINE_TYPE)/)

# Options variables
__VLT_ADDRESS__SECRETENGINE= $(if $(VLT_SECRETENGINE_ENDPOINT_URL),--path $(VLT_SECRETENGINE_ENDPOINT_URL))
__VLT_DESCRIPTION__SECRETENGINE= $(if $(VLT_SECRETENGINE_DESCRIPTION),--description $(VLT_SECRETENGINE_DESCRIPTION))
__VLT_DETAILED__SECRETENGINES= $(if $(VLT_SECRETENGINES_DETAILED_FLAG),--detailed=$(VLT_SECRETENGINES_DETAILED_FLAG))
__VLT_PATH__SECRETENGINE= $(if $(VLT_SECRETENGINE_PATH),--path $(VLT_SECRETENGINE_PATH))

# Pipe

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::SecretEngine ($(_VAULT_SECRETENGINE_MK_VERSION)) macros:'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::SecretEngine ($(_VAULT_SECRETENGINE_MK_VERSION)) parameters:'
	@echo '    VLT_SECRETENGINE_DESCRIPTION=$(VLT_SECRETENGINE_DESCRIPTION)'
	@echo '    VLT_SECRETENGINE_ENDPOINT_URL=$(VLT_SECRETENGINE_ENDPOINT_URL)'
	@echo '    VLT_SECRETENGINE_NAME=$(VLT_SECRETENGINE_NAME)'
	@echo '    VLT_SECRETENGINE_NEWPATH=$(VLT_SECRETENGINE_NEWPATH)'
	@echo '    VLT_SECRETENGINE_OLDPATH=$(VLT_SECRETENGINE_OLDPATH)'
	@echo '    VLT_SECRETENGINE_PATH=$(VLT_SECRETENGINE_PATH)'
	@echo '    VLT_SECRETENGINE_TYPE=$(VLT_SECRETENGINE_TYPE)'
	@echo '    VLT_SECRETENGINE_UPDATE_CONFIG=$(VLT_SECRETENGINE_UPDATE_CONFIG)'
	@echo '    VLT_SECRETENGINES_DETAILED_FLAG=$(VLT_SECRETENGINES_DETAILED_FLAG)'
	@echo '    VLT_SECRETENGINES_SET_NAME=$(VLT_SECRETENGINES_SET_NAME)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::SecretEngine ($(_VAULT_SECRETENGINE_MK_VERSION)) targets:'
	@echo '    _vlt_create_secretengine                  - Create a secret-engine'
	@echo '    _vlt_delete_secretengine                  - Delete a secret-engine'
	@echo '    _vlt_disable_secretengine                 - Disable a secret-engine'
	@echo '    _vlt_enable_secretengine                  - Enable a secret-engine'
	@echo '    _vlt_show_secretengine                    - Show everything related to a secret-engine'
	@echo '    _vlt_show_secretengine_description        - Show desription of a secret-engine'
	@echo '    _vlt_view_secretengines                   - View secret-engines'
	@echo '    _vlt_view_secretengines_set               - View set of secret-engines'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
_vlt_create_secretengine:
	@$(INFO) '$(VLT_UI_LABEL)Creating secret-engine "$(VLT_SECRETENGINE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is a NOOP. Instead enable the secret-engine on provided path'; $(NORMAL)

_vlt_delete_secretengine:
	@$(INFO) '$(VLT_UI_LABEL)Deleting secret-engine "$(VLT_SECRETENGINE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is a NOOP. Instead disable the secret-engine on provided path'; $(NORMAL)

_vlt_disable_secretengine:
	@$(INFO) '$(VLT_UI_LABEL)Disabling secret-engine "$(VLT_SECRETENGINE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation disable access to all the secrets that were using this engine'; $(NORMAL)
	$(VAULT) secrets disable $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_SECRETENGINE_PATH)/

_vlt_enable_secretengine:
	@$(INFO) '$(VLT_UI_LABEL)Enabling secret-engine "$(VLT_SECRETENGINE_NAME)" ...'; $(NORMAL)
	$(VAULT) secrets enable $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_DESCRIPTION__SECRETENGINE) $(__VLT_PATH__SECRETENGINE) $(VLT_SECRETENGINE_TYPE)

_vlt_move_secretengine:
	@$(INFO) '$(VLT_UI_LABEL)Moving secret-engine "$(VLT_SECRETENGINE_NAME)" ...'; $(NORMAL)
	$(VAULT) secrets move $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_SECRETENGINE_OLDPATH)/ $(VLT_SECRETENGINE_NEWPATH)/

_vlt_show_secretengine: _vlt_show_secretengine_description

_vlt_show_secretengine_description:
	@$(INFO) '$(VLT_UI_LABEL)Showing secret-engine "$(VLT_SECRETENGINE_NAME)" ...'; $(NORMAL)
	# $(VAULT) kv get $(__VLT_ADDRESS) $(__VLT_FORMAT) $(VLT_SECRET_PATH)

_vlt_update_secretengine:
	@$(INFO) '$(VLT_UI_LABEL)Updating secret-engine "$(VLT_SECRETENGINE_NAME)" ...'; $(NORMAL)
	$(VAULT) secrets tune $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_SECRETENGINE_UPDATE_CONFIG) $(VLT_SECRETENGINE_PATH)/

_vlt_view_secretengines:
	@$(INFO) '$(VLT_UI_LABEL)Viewing secret-engines ...'; $(NORMAL)
	$(VAULT) secrets list $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_DETAILED__SECRETENGINES)

_vlt_view_secretengines_set:
	@$(INFO) '$(VLT_UI_LABEL)Viewing secret-engines-set "$(VLT_SECRETENGINES_SET_NAME)" ...'; $(NORMAL)
	# $(VAULT) secrets list $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_DETAILED)

