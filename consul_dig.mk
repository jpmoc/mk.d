_CONSUL_DIG_MK_VERSION= $(_CONSUL_MK_VERSION)

CSL_DIG_API_IP?= 127.0.0.1
CSL_DIG_API_PORT?= 8600
# CSL_DIG_SERVICE_NAME?= consul

# Derived variables

# Options variables
__CSL_PORT__DIG?= $(if $(CSL_DIG_API_PORT),-p $(CSL_DIG_API_PORT))

# Pipe
|_CSL_DIG_NODES?= | jq '.'

# UI parameters

# Utilities
CSL_DIG_BIN?= dig
CSL_DIG?= $(strip $(__CSL_DIG_ENVIRONMENT) $(CSL_DIG_ENVIRONMENT) $(CSL_DIG_BIN) $(__CSL_DIG_OPTIONS) $(CSL_DIG_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_csl_view_framework_macros ::
	@echo 'ConSuL::Dig ($(_CONSUL_DIG_MK_VERSION)) macros:'
	@echo

_csl_view_framework_parameters ::
	@echo 'ConSuL::Dig ($(_CONSUL_DIG_MK_VERSION)) parameters:'
	@echo '    CSL_DIG_API_IP=$(CSL_DIG_API_IP)'
	@echo '    CSL_DIG_API_PORT=$(CSL_DIG_API_PORT)'
	@echo '    CSL_DIG_SERVICE_NAME=$(CSL_DIG_SERVICE_NAME)'
	@echo '    ... all other param are passed as-is ...'
	@echo

_csl_view_framework_targets ::
	@echo 'ConSuL::Dig ($(_CONSUL_DIG_MK_VERSION)) targets:'
	@echo '    _csl_dig_service                  - Dig a service'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csl_dig_service:
	@$(INFO) '$(CSL_UI_LABEL)Dig a service ...'; $(NORMAL)
	$(CSL_DIG) @$(CSL_DIG_API_IP) $(__CSL_PORT__DIG) $(CSL_DIG_SERVICE_NAME).service.consul SRV
