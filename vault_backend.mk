_VAULT_BACKEND_MK_VERSION= $(_VAULT_MK_VERSION)

# VLT_BACKEND_FILE_DIRPATH?= /tmp/vault/
# VLT_BACKEND_NAME?= local-file
VLT_BACKEND_TYPE?= file
# VLT_BACKENDS_SET_NAME?= my-secrets-set

# Derived variables
VLT_BACKEND_NAME?= $(VLT_BACKEND_TYPE)

# Options variables

# Pipe

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::Backend ($(_VAULT_BACKEND_MK_VERSION)) macros:'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::Backend ($(_VAULT_BACKEND_MK_VERSION)) parameters:'
	@echo '    VLT_BACKEND_FILE_DIRPATH=$(VLT_BACKEND_FILE_DIRPATH)'
	@echo '    VLT_BACKEND_NAME=$(VLT_BACKEND_NAME)'
	@echo '    VLT_BACKEND_TYPE=$(VLT_BACKEND_TYPE)'
	@echo '    VLT_BACKENDS_SET_NAME=$(VLT_BACKENDS_SET_NAME)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::Backend ($(_VAULT_BACKEND_MK_VERSION)) targets:'
	@echo '    _vlt_reset_backend                    - Reset a backend'
	@echo '    _vlt_show_backend                     - Show everything related to a backend'
	@echo '    _vlt_show_backend_description         - Show the description of a backend'
	@echo '    _vlt_view_backends                    - View backends'
	@echo '    _vlt_view_backends_set                - View set of backends'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_reset_backend:
	@$(INFO) '$(VLT_UI_LABEL)Reseting backend "$(VLT_BACKEND_NAME)" ...'; $(NORMAL)
	$(if $(filter file, $(VLT_BACKEND_TYPE)), rm -rf $(VLT_BACKEND_FILE_DIRPATH))

_vlt_show_backend: _vlt_show_backend_description

_vlt_show_backend_description:
	@$(INFO) '$(VLT_UI_LABEL)Showing description of backend "$(VLT_BACKEND_NAME)" ...'; $(NORMAL)
	$(if $(filter file, $(VLT_BACKEND_TYPE)), tree -ph $(VLT_BACKEND_FILE_DIRPATH))

_vlt_view_backends:
	@$(INFO) '$(VLT_UI_LABEL)Viewing backends ...'; $(NORMAL)

_vlt_view_backends_set:
	@$(INFO) '$(VLT_UI_LABEL)Viewing backends-set "$(VLT_BACKENDS_SET_NAME)" ...'; $(NORMAL)
