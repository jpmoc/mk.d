_CFSSL_SERVER_MK_VERSION= $(_CFSSL_MK_VERSION)

# CFL_SERVER_ADDRESS?= localhost
# CFL_SERVER_CACERT_FILEPATH?=
# CFL_SERVER_CAKEY_FILEPATH?=
# CFL_SERVER_NAME?=
# CFL_SERVER_PORT?= 8888

# Derived parameters

# Option parameters
__CFL_ADDRESS= $(if $(CFL_SERVER_ADDRESS),--address $(CFL_SERVER_ADDRESS))
__CFL_CA= $(if $(CFL_SERVER_CACERT_FILEPATH),--ca $(CFL_SERVER_CACERT_FILEPATH))
__CFL_CA_KEY= $(if $(CFL_SERVER_CAKEY_FILEPATH),--ca-key $(CFL_SERVER_CAKEY_FILEPATH))
__CFL_PORT= $(if $(CFL_SERVER_PORT),--port $(CFL_SERVER_PORT))

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_cfl_view_framework_macros ::
	@echo 'CFssl::Server ($(_CFSSL_SERVER_MK_VERSION)) macros:'
	@echo

_cfl_view_framework_parameters ::
	@echo 'CFssL::Server ($(_CFSSL_SERVER_MK_VERSION)) variables:'
	@echo '    CFL_SERVER_ADDRESS=$(CFL_SERVER_ADDRESS)'
	@echo '    CFL_SERVER_CACERT_FILEPATH=$(CFL_SERVER_CACERT_FILEPATH)'
	@echo '    CFL_SERVER_CAKEY_FILEPATH=$(CFL_SERVER_CAKEY_FILEPATH)'
	@echo '    CFL_SERVER_NAME=$(CFL_SERVER_NAME)'
	@echo '    CFL_SERVER_PORT=$(CFL_SERVER_PORT)'
	@echo

_cfl_view_framework_targets ::
	@echo 'CFssL::Server ($(_CFSSL_SERVER_MK_VERSION)) targets:'
	@echo '    _cfl_start_server               - Start a server'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cfl_start_server:
	@$(INFO) '$(CFL_UI_LABEL)Starting server "$(CFL_SERVER_NAME)" ...'; $(NORMAL)
	$(CFSSL) serve -address=localhost -port=8888 -ca-key=test-key.pem -ca=test-cert.pem

