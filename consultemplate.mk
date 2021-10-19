_CONSULTEMPLATE_MK_VERSION= 0.99.4

# CTE_INPUTS_DIRPATH?= ./in/
# CTE_MODE_DEBUG?= false
# CTE_OUTFILE_DIRPATH?=
# CTE_OUTFILE_FILENAME?=
# CTE_OUTFILE_FILEPATH?=
# CTE_OUTPUTS_DIRPATH?= ./out/
# CTE_TEMPLATE_DIRPATH?= ./in/
# CTE_TEMPLATE_FILENAME?= script.sh
# CTE_TEMPLATE_FILEPATH?= ./in/script.sh
# CTE_TEMPLATE_NAME?= my-script
CTE_UPPERCASE_FLAG?= false
# CTE_VAULT_ENDPOINT_URL?= http://127.0.0.1:8200
# CTE_VAULT_SECRET_PATH?= secret/exampleapp/config
# CTE_VAULT_SECRETS_PATHS?= secret/exampleapp/config
# CONSULTEMPLATE_CONFIG_DIRPATH?= ./in/
# CONSULTEMPLATE_CONFIG_FILENAME?= config.hcl
# CONSULTEMPLATE_CONFIG_FILEPATH?= ./in/config.hcl
# CONSULTEMPLATE_LOG_LEVEL?= debug
CONSULTEMPLATE_VAULT_RENEWTOKEN_FLAG?=true
# CONSULTEMPLATE_VAULT_TOKEN?=

# Derived variables
CTE_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
CTE_MODE_DEBUG?= $(CMN_MODE_DEBUG)
CTE_OUTFILE_DIRPATH?= $(CTE_OUTPUTS_DIRPATH)
CTE_OUTFILE_FILENAME?= $(patsubst %.cte,%,$(CTE_TEMPLATE_FILENAME))
CTE_OUTFILE_FILEPATH?= $(if $(CTE_OUTFILE_FILENAME),$(CTE_OUTFILE_DIRPATH)$(CTE_OUTFILE_FILENAME))
CTE_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
CTE_TEMPLATE_DIRPATH?= $(CTE_INPUTS_DIRPATH)
CTE_TEMPLATE_FILEPATH?= $(if $(CTE_TEMPLATE_FILENAME),$(CTE_TEMPLATE_DIRPATH)$(CTE_TEMPLATE_FILENAME))
CTE_TEMPLATE_NAME?= $(CTE_TEMPLATE_FILENAME)
CTE_VAULT_ENDPOINT_URL?= $(VLT_ENDPOINT_URL)
CTE_VAULT_SECRET_PATH?= $(VLT_SECRET_PATH)
CTE_VAULT_SECRETS_PATHS?= $(CTE_VAULT_SECRET_PATH)
CONSULTEMPLATE_CONFIG_DIRPATH?= $(CTE_INPUTS_DIRPATH)
CONSULTEMPLATE_CONFIG_FILEPATH?= $(if $(CONSULTEMPLATE_CONFIG_FILENAME),$(CONSULTEMPLATE_CONFIG_DIRPATH)$(CONSULTEMPLATE_CONFIG_FILENAME))
CONSULTEMPLATE_LOG_LEVEL?= $(if $(filter true,$(CTE_MODE_DEBUG)),debug,warn)
CONSULTEMPLATE_VAULT_TOKEN?= $(if $(VLT_AUTHMETHOD_TOKEN),$(VLT_AUTHMETHOD_TOKEN),$(VLT_OPERATOR_TOKEN))

# Options variables
__CTE_ONCE?= --once
__CTE_TEMPLATE?= $(if $(CTE_TEMPLATE_FILEPATH),--template "$(CTE_TEMPLATE_FILEPATH):$(CTE_OUTFILE_FILEPATH)")
__CTE_VAULT_ADDR?= $(if $(CTE_VAULT_ENDPOINT_URL),--vault-addr $(CTE_VAULT_ENDPOINT_URL))

# UI parameters
CTE_UI_LABEL?= [consult-template] #

# Utilities
__CONSULTEMPLATE_ENVIRONMENT?= $(if $(CONSULTEMPLATE_VAULT_TOKEN),VAULT_TOKEN=$(CONSULTEMPLATE_VAULT_TOKEN))

__CONSULTEMPLATE_OPTIONS+= $(if $(CONSULTEMPLATE_CONFIG_FILEPATH),--config $(CONSULTEMPLATE_CONFIG_FILEPATH))
__CONSULTEMPLATE_OPTIONS+= $(if $(CONSULTEMPLATE_LOG_LEVEL),--log-level $(CONSULTEMPLATE_LOG_LEVEL))
__CONSULTEMPLATE_OPTIONS+= $(if $(CONSULTEMPLATE_VAULT_RENEWTOKEN_FLAG),--vault-renew-token=$(CONSULTEMPLATE_VAULT_RENEWTOKEN_FLAG))

CONSULTEMPLATE_BIN?= consult-template
CONSULTEMPLATE?= $(strip $(__CONSULTEMPLATE_ENVIRONMENT) $(CONSULTEMPLATE_ENVIRONMENT) $(CONSULTEMPLATE_BIN) $(__CONSULTEMPLATE_OPTIONS) $(CONSULTEMPLATE_OPTIONS))
CONSULTEMPLATE_VERSION?= 0.23.0

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _cte_view_framework_macros
_cte_view_framework_macros ::
	@echo 'ConsulTemplatE ($(_CONSULTEMPLATE_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _cte_view_framework_parameters
_cte_view_framework_parameters ::
	@echo 'ConsulTemplatE ($(_CONSULTEMPLATE_MK_VERSION)) parameters:'
	@echo '    CTE_INPUTS_DIRPATH=$(CTE_INPUTS_DIRPATH)'
	@echo '    CTE_MODE_DEBUG=$(CTE_MODE_DEBUG)'
	@echo '    CTE_OUTPUTS_DIRPATH=$(CTE_OUTPUTS_DIRPATH)'
	@echo '    CONSULTEMPLATE=$(CONSULTEMPLATE)'
	@echo '    CONSULTEMPLATE_CONFIG_DIRPATH=$(CONSULTEMPLATE_CONFIG_DIRPATH)'
	@echo '    CONSULTEMPLATE_CONFIG_FILENAME=$(CONSULTEMPLATE_CONFIG_FILENAME)'
	@echo '    CONSULTEMPLATE_CONFIG_FILEPATH=$(CONSULTEMPLATE_CONFIG_FILEPATH)'
	@echo '    CONSULTEMPLATE_LOG_LEVEL=$(CONSULTEMPLATE_LOG_LEVEL)'
	@echo '    CONSULTEMPLATE_VAULT_RENEWTOKEN_FLAG=$(CONSULTEMPLATE_VAULT_RENEWTOKEN_FLAG)'
	@echo '    CONSULTEMPLATE_VAULT_TOKEN=$(CONSULTEMPLATE_VAULT_TOKEN)'
	@echo '    CONSULTEMPLATE_VERSION=$(CONSULTEMPLATE_VERSION)'
	@echo '    ---'
	@echo '    CTE_OUTFILE_DIRPATH=$(CTE_OUTFILE_DIRPATH)'
	@echo '    CTE_OUTFILE_FILENAME=$(CTE_OUTFILE_FILENAME)'
	@echo '    CTE_OUTFILE_FILEPATH=$(CTE_OUTFILE_FILEPATH)'
	@echo '    CTE_TEMPLATE_DIRPATH=$(CTE_TEMPLATE_DIRPATH)'
	@echo '    CTE_TEMPLATE_FILENAME=$(CTE_TEMPLATE_FILENAME)'
	@echo '    CTE_TEMPLATE_FILEPATH=$(CTE_TEMPLATE_FILEPATH)'
	@echo '    CTE_TEMPLATE_NAME=$(CTE_TEMPLATE_NAME)'
	@echo '    CTE_UPPERCASE_FLAG=$(CTE_UPPERCASE_FLAG)'
	@echo '    CTE_VAULT_ENDPOINT_URL=$(CTE_VAULT_ENDPOINT_URL)'
	@echo '    CTE_VAULT_SECRET_PATH=$(CTE_VAULT_SECRET_PATH)'
	@echo '    CTE_VAULT_SECRETS_PATHS=$(CTE_VAULT_SECRETS_PATHS)'
	@echo

_view_framework_targets :: _cte_view_framework_targets
_cte_view_framework_targets ::
	@echo 'ConsulTemplatE ($(_CONSULTEMPLATE_MK_VERSION)) targets:'
	@echo '    _cte_expand_template               - Expand a template'
	@echo '    _cte_install_dependencies          - Install dependencies'
	@echo '    _cte_show_environment              - Show the environment'
	@echo '    _cte_view_versions                 - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
# -include $(MK_DIR)/consul_agent.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cte_expand_template:
	@$(INFO) '$(CTE_UI_LABEL)Expanding template "$(CTE_TEMPLATE_NAME)" ...'; $(NORMAL)
	$(if $(CONSULTEMPLATE_CONFIG_FILEPATH),cat $(CONSULTEMPLATE_CONFIG_FILEPATH))
	$(if $(CTE_TEMPLATE_FILEPATH),cat $(CTE_TEMPLATE_FILEPATH))
	$(CONSULTEMPLATE) $(__CTE_ONCE) $(__CTE_TEMPLATE) $(__CTE_VAULT_ADDR)
	$(if $(CTE_OUTFILE_FILEPATH),cat $(CTE_OUTFILE_FILEPATH))

_install_framework_dependencies :: _cte_install_dependencies
_cte_install_dependencies ::
	@$(INFO) '$(CTE_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs at https://learn.hashicorp.com/consul/developer-configuration/consul-template'; $(NORMAL)
	cd /tmp; wget https://releases.hashicorp.com/consul-template/$(CONSULTEMPLATE_VERSION)/consul-template_$(CONSULTEMPLATE_VERSION)_linux_amd64.tgz
	cd /tmp; tar xvzf consul-template_$(CONSULTEMPLATE_VERSION)_linux_amd64.tgz
	sudo mv /tmp/consul-template /usr/local/bin/consul-template
	which consul-template
	consul-template --version

_cte_show_environment:
	@$(INFO) '$(CTE_UI_LABEL)Expanding environment ...'; $(NORMAL)
	@#$(WARN) 'This operation shows the environment in which the subprocess would run'; $(NORMAL)
	#$(CONSULTEMPLATE) $(__CTE_SECRET) $(__CTE_UPCASE) $(__CTE_VAULT_ADDR) env

_view_versions:: _cte_view_versions
_cte_view_versions:
	@$(INFO) '$(CTE_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	consul-template --version
