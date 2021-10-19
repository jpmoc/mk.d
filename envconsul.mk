_ENVCONSUL_MK_VERSION= 0.99.4

# EVL_INPUTS_DIRPATH?= ./in/
# EVL_MODE_DEBUG?= false
# EVL_OUTPUTS_DIRPATH?= ./out/
# EVL_SCRIPT_DIRPATH?= ./in/
# EVL_SCRIPT_FILENAME?= script.sh
# EVL_SCRIPT_FILEPATH?= ./in/script.sh
# EVL_SCRIPT_NAME?= my-script
EVL_UPPERCASE_FLAG?= false
# EVL_VAULT_ENDPOINT_URL?= http://127.0.0.1:8200
# EVL_VAULT_SECRET_PATH?= secret/exampleapp/config
# EVL_VAULT_SECRETS_PATHS?= secret/exampleapp/config
# ENVCONSUL_CONFIG_DIRPATH?= ./in/
# ENVCONSUL_CONFIG_FILENAME?= config.hcl
# ENVCONSUL_CONFIG_FILEPATH?= ./in/config.hcl
# ENVCONSUL_LOG_LEVEL?= debug
ENVCONSUL_VAULT_RENEWTOKEN_FLAG?=true
# ENVCONSUL_VAULT_TOKEN?=

# Derived variables
EVL_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
EVL_MODE_DEBUG?= $(CMN_MODE_DEBUG)
EVL_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
EVL_SCRIPT_DIRPATH?= $(EVL_INPUTS_DIRPATH)
EVL_SCRIPT_FILEPATH?= $(EVL_SCRIPT_DIRPATH)$(EVL_SCRIPT_FILENAME)
EVL_SCRIPT_NAME?= $(EVL_SCRIPT_FILENAME)
EVL_VAULT_ENDPOINT_URL?= $(VLT_ENDPOINT_URL)
EVL_VAULT_SECRET_PATH?= $(VLT_SECRET_PATH)
EVL_VAULT_SECRETS_PATHS?= $(EVL_VAULT_SECRET_PATH)
ENVCONSUL_CONFIG_DIRPATH= $(EVL_INPUTS_DIRPATH)
ENVCONSUL_CONFIG_FILEPATH= $(if $(ENVCONSUL_CONFIG_FILENAME),$(ENVCONSUL_CONFIG_DIRPATH)$(ENVCONSUL_CONFIG_FILENAME))
ENVCONSUL_LOG_LEVEL= $(if $(filter true,$(EVL_MODE_DEBUG)),debug,warn)
ENVCONSUL_VAULT_TOKEN?= $(if $(VLT_AUTHMETHOD_TOKEN),$(VLT_AUTHMETHOD_TOKEN),$(VLT_OPERATOR_TOKEN))

# Options variables
__EVL_SECRET?= $(foreach P, $(EVL_VAULT_SECRETS_PATHS),--secret $(P) )
__EVL_UPCASE?= $(if $(filter true, $(EVL_UPPERCASE_FLAG)),--upcase)
__EVL_VAULT_ADDR?= $(if $(EVL_VAULT_ENDPOINT_URL),--vault-addr $(EVL_VAULT_ENDPOINT_URL))

# UI parameters
EVL_UI_LABEL?= [envconsul] #

# Utilities
__ENVCONSUL_ENVIRONMENT+= $(if $(ENVCONSUL_VAULT_TOKEN),VAULT_TOKEN=$(ENVCONSUL_VAULT_TOKEN))

__ENVCONSUL_OPTIONS+= $(if $(ENVCONSUL_CONFIG_FILEPATH),--config $(ENVCONSUL_CONFIG_FILEPATH))
__ENVCONSUL_OPTIONS+= $(if $(ENVCONSUL_LOG_LEVEL),--log-level $(ENVCONSUL_LOG_LEVEL))
__ENVCONSUL_OPTIONS+= $(if $(ENVCONSUL_VAULT_RENEWTOKEN_FLAG),--vault-renew-token=$(ENVCONSUL_VAULT_RENEWTOKEN_FLAG))
--vault-renew-token=false

ENVCONSUL_BIN?= envconsul
ENVCONSUL?= $(strip $(__ENVCONSUL_ENVIRONMENT) $(ENVCONSUL_ENVIRONMENT) $(ENVCONSUL_BIN) $(__ENVCONSUL_OPTIONS) $(ENVCONSUL_OPTIONS))
ENVCONSUL_VERSION?= 0.9.1

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _evl_view_framework_macros
_evl_view_framework_macros ::
	@echo 'EnVconsuL ($(_ENVCONSUL_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _evl_view_framework_parameters
_evl_view_framework_parameters ::
	@echo 'EnVconsuL ($(_ENVCONSUL_MK_VERSION)) parameters:'
	@echo '    EVL_INPUTS_DIRPATH=$(EVL_INPUTS_DIRPATH)'
	@echo '    EVL_MODE_DEBUG=$(EVL_MODE_DEBUG)'
	@echo '    EVL_OUTPUTS_DIRPATH=$(EVL_OUTPUTS_DIRPATH)'
	@echo '    ENVCONSUL=$(ENVCONSUL)'
	@echo '    ENVCONSUL_CONFIG_DIRPATH=$(ENVCONSUL_CONFIG_DIRPATH)'
	@echo '    ENVCONSUL_CONFIG_FILENAME=$(ENVCONSUL_CONFIG_FILENAME)'
	@echo '    ENVCONSUL_CONFIG_FILEPATH=$(ENVCONSUL_CONFIG_FILEPATH)'
	@echo '    ENVCONSUL_LOG_LEVEL=$(ENVCONSUL_LOG_LEVEL)'
	@echo '    ENVCONSUL_VAULT_RENEWTOKEN_FLAG=$(ENVCONSUL_VAULT_RENEWTOKEN_FLAG)'
	@echo '    ENVCONSUL_VAULT_TOKEN=$(ENVCONSUL_VAULT_TOKEN)'
	@echo '    ENVCONSUL_VERSION=$(ENVCONSUL_VERSION)'
	@echo '    ---'
	@echo '    EVL_SCRIPT_DIRPATH=$(EVL_SCRIPT_DIRPATH)'
	@echo '    EVL_SCRIPT_FILENAME=$(EVL_SCRIPT_FILENAME)'
	@echo '    EVL_SCRIPT_FILEPATH=$(EVL_SCRIPT_FILEPATH)'
	@echo '    EVL_SCRIPT_NAME=$(EVL_SCRIPT_NAME)'
	@echo '    EVL_UPPERCASE_FLAG=$(EVL_UPPERCASE_FLAG)'
	@echo '    EVL_VAULT_ENDPOINT_URL=$(EVL_VAULT_ENDPOINT_URL)'
	@echo '    EVL_VAULT_SECRET_PATH=$(EVL_VAULT_SECRET_PATH)'
	@echo '    EVL_VAULT_SECRETS_PATHS=$(EVL_VAULT_SECRETS_PATHS)'
	@echo

_view_framework_targets :: _evl_view_framework_targets
_evl_view_framework_targets ::
	@echo 'EnVconsuL ($(_ENVCONSUL_MK_VERSION)) targets:'
	@echo '    _evl_exec_script                    - Execute a script'
	@echo '    _evl_install_dependencies          - Install dependencies'
	@echo '    _evl_show_environment              - Show environment'
	@echo '    _evl_view_versions                 - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
# -include $(MK_DIR)/consul_agent.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_evl_exec_script:
	@$(INFO) '$(EVL_UI_LABEL)Executing script "$(EVL_SCRIPT_NAME)" ...'; $(NORMAL)
	$(ENVCONSUL) $(__EVL_SECRET) $(__EVL_UPCASE) $(__EVL_VAULT_ADDR) $(EVL_SCRIPT_FILEPATH)

_install_framework_dependencies :: _evl_install_dependencies
_evl_install_dependencies ::
	@$(INFO) '$(EVL_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs at https://learn.hashicorp.com/consul/getting-started/install.html#installing-consul'; $(NORMAL)
	cd /tmp; wget https://releases.hashicorp.com/envconsul/$(ENVCONSUL_VERSION)/envconsul_$(ENVCONSUL_VERSION)_linux_amd64.tgz
	cd /tmp; tar xvzf envconsul_$(ENVCONSUL_VERSION)_linux_amd64.tgz
	sudo mv /tmp/envconsul /usr/local/bin/envconsul
	which envconsul
	envconsul --version

_evl_show_environment:
	@$(INFO) '$(EVL_UI_LABEL)Showing environment ...'; $(NORMAL)
	@$(WARN) 'This operation shows the environment in which the subprocess would run'; $(NORMAL)
	$(ENVCONSUL) $(__EVL_SECRET) $(__EVL_UPCASE) $(__EVL_VAULT_ADDR) env

_view_versions:: _evl_view_versions
_evl_view_versions:
	@$(INFO) '$(EVL_UI_LABEL)View versions of dependencies ...'; $(NORMAL)
	envconsul --version
