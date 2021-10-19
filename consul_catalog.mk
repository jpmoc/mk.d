_CONSUL_CATALOG_MK_VERSION= $(_CONSUL_MK_VERSION)

# CSL_CATALOG_CONFIG_DIRPATH?= ./in/
# CSL_CATALOG_CONFIG_FILENAME?= config.hcl
# CSL_CATALOG_CONFIG_FILEPATH?= ./in/config.hcl
# CSL_CATALOG_ENDPOINT_URL?= http://127.0.0.1:8200
CSL_CATALOG_DEVMODE_FLAG?= false
# CSL_CATALOG_NAME?= my-development-agent

# Derived variables
# CSL_CATALOG_CONFIG_DIRPATH?= $(CSL_INPUTS_DIRPATH)
# CSL_CATALOG_CONFIG_FILEPATH?= $(if $(CSL_CATALOG_CONFIG_FILENAME),$(CSL_CATALOG_CONFIG_DIRPATH)$(CSL_CATALOG_CONFIG_FILENAME))
# CSL_CATALOG_ENDPOINT_URL?= $(CSL_ENDPOINT_URL)

# Options variables
# __CSL_ADDRESS= $(if $(CSL_CATALOG_ENDPOINT_URL),-address=$(CSL_CATALOG_ENDPOINT_URL))
# __CSL_CONFIG= $(if $(CSL_CATALOG_CONFIG_FILEPATH),-config=$(CSL_CATALOG_CONFIG_FILEPATH))
__CSL_DEV__CATALOG= $(if $(filter true, $(CSL_CATALOG_DEVMODE_FLAG)),-dev)
# __CSL_METHOD= $(if $(CSL_CATALOG_AUTHMETHOD_TYPE),--method $(CSL_CATALOG_AUTHMETHOD_TYPE))

# Pipe

# UI parameters

# Utilities

#--- MACROS
# _csl_get_agent= $(shell $(CONSUL) status -format json | jq -r '.cluster_name')

#----------------------------------------------------------------------
# USAGE
#

_csl_view_framework_macros ::
	@echo 'ConSuL::Catalog ($(_CONSUL_CATALOG_MK_VERSION)) macros:'
	@#echo '    _csl_get_agent                 - Get the agent name'
	@echo

_csl_view_framework_parameters ::
	@echo 'ConSuL::Catalog ($(_CONSUL_CATALOG_MK_VERSION)) parameters:'
	@#echo '    CSL_CATALOG_CONFIG_DIRPATH=$(CSL_CATALOG_CONFIG_DIRPATH)'
	@#echo '    CSL_CATALOG_CONFIG_FILENAME=$(CSL_CATALOG_CONFIG_FILENAME)'
	@#echo '    CSL_CATALOG_CONFIG_FILEPATH=$(CSL_CATALOG_CONFIG_FILEPATH)'
	@#echo '    CSL_CATALOG_ENDPOINT_URL=$(CSL_CATALOG_ENDPOINT_URL)'
	@echo '    CSL_CATALOG_DEVMODE_FLAG=$(CSL_CATALOG_DEVMODE_FLAG)'
	@echo '    CSL_CATALOG_NAME=$(CSL_CATALOG_NAME)'
	@echo '    CSL_CATALOGS_SET_NAME=$(CSL_CATALOGS_SET_NAME)'
	@echo

_csl_view_framework_targets ::
	@echo 'ConSuL::Catalog ($(_CONSUL_CATALOG_MK_VERSION)) targets:'
	@echo '    _csl_show_catalog                    - Show everything related to a catalog'
	@echo '    _csl_show_catalog_datacernters       - Show datacenters in a catalog'
	@echo '    _csl_show_catalog_description        - Show description of a catalog'
	@echo '    _csl_show_catalog_nodes              - Show nodes of a catalog'
	@echo '    _csl_show_catalog_services           - Show services of a catalog'
	@echo '    _csl_view_catalogs                   - View all catalogs' 
	@echo '    _csl_view_catalogs_set                - View a set of catalogs' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csl_create_catalog:

_csl_delete_catalog:

_csl_show_catalog: _csl_show_catalog_datacenters _csl_show_catalog_nodes _csl_show_catalog_services _csl_show_catalog_description

_csl_show_catalog_datacenters:
	@$(INFO) '$(CSL_UI_LABEL)Showing datacenters of catalog "$(CSL_CATALOG_NAME)" ...'; $(NORMAL)
	$(CONSUL) catalog datacenters $(__CSL_CA_FILE) $(__CSL_CLIENT_CERT) $(__CSL_CLIENT_KEY) $(__CSL_HTTP_ADDR)

_csl_show_catalog_description:
	@$(INFO) '$(CSL_UI_LABEL)Showing description of catalog "$(CSL_CATALOG_NAME)" ...'; $(NORMAL)

_csl_show_catalog_nodes:
	@$(INFO) '$(CSL_UI_LABEL)Showing nodes of catalog "$(CSL_CATALOG_NAME)" ...'; $(NORMAL)
	$(CONSUL) catalog nodes $(__CSL_CA_FILE) $(__CSL_CLIENT_CERT) $(__CSL_CLIENT_KEY) $(__CSL_HTTP_ADDR)

_csl_show_catalog_services:
	@$(INFO) '$(CSL_UI_LABEL)Showing services of catalog "$(CSL_CATALOG_NAME)" ...'; $(NORMAL)
	$(CONSUL) catalog services $(__CSL_CA_FILE) $(__CSL_CLIENT_CERT) $(__CSL_CLIENT_KEY) $(__CSL_HTTP_ADDR)

_csl_view_catalogs:
	@$(INFO) '$(CSL_UI_LABEL)Viewing catalogs ...'; $(NORMAL)

_csl_view_catalogs_set:
	@$(INFO) '$(CSL_UI_LABEL)Viewing catalogs-set "$(CSL_CATALOGS_SET_NAME)" ...'; $(NORMAL)
