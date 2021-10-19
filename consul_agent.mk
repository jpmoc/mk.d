_CONSUL_AGENT_MK_VERSION= $(_CONSUL_MK_VERSION)

# CSL_AGENT_CONFIG_DIRPATH?= ./in/
# CSL_AGENT_CONFIG_FILENAME?= config.hcl
# CSL_AGENT_CONFIG_FILEPATH?= ./in/config.hcl
# CSL_AGENT_CONFIGS_DIRPATH?= ./in/consul.d/
CSL_AGENT_DEVMODE_FLAG?= false
# CSL_AGENT_ENDPOINT_URL?= http://127.0.0.1:8200
# CSL_AGENT_HOST?=
# CSL_AGENT_IP?= 127.0.0.1
# CSL_AGENT_IP_OR_HOST?= 127.0.0.1
# CSL_AGENT_NAME?= my-development-agent
CSL_AGENT_NODE_NAME?= $(HOST)

# Derived variables
CSL_AGENT_CONFIG_DIRPATH?= $(CSL_INPUTS_DIRPATH)
CSL_AGENT_CONFIG_FILEPATH?= $(if $(CSL_AGENT_CONFIG_FILENAME),$(CSL_AGENT_CONFIG_DIRPATH)$(CSL_AGENT_CONFIG_FILENAME))
CSL_AGENT_CONFIGS_DIRPATH?= $(CSL_AGENT_CONFIG_DIRPATH)
# CSL_AGENT_ENDPOINT_URL?= $(CSL_ENDPOINT_URL)

# Options variables
__CSL_CONFIG_DIR= $(if $(CSL_AGENT_CONFIGS_DIRPATH),--config-dir $(CSL_AGENT_CONFIGS_DIRPATH))
__CSL_CONFIG_FILE= $(if $(CSL_AGENT_CONFIG_FILEPATH),--config-file $(CSL_AGENT_CONFIG_FILEPATH))
__CSL_DETAILED=
__CSL_DEV__AGENT= $(if $(filter true, $(CSL_AGENT_DEVMODE_FLAG)),-dev)
__CSL_ENABLE_LOCAL_SCRIPT_CHECKS=
__CSL_ENABLE_SCRIPT_CHECKS=
# __CSL_METHOD= $(if $(CSL_AGENT_AUTHMETHOD_TYPE),--method $(CSL_AGENT_AUTHMETHOD_TYPE))
__CSL_NODE= $(if $(CSL_AGENT_NODE_NAME),--node $(CSL_AGENT_NODE_NAME))

# Pipe

# UI parameters

# Utilities

#--- MACROS
# _csl_get_agent= $(shell $(CONSUL) status -format json | jq -r '.cluster_name')

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@echo 'ConSuL::Agent ($(_CONSUL_AGENT_MK_VERSION)) macros:'
	@#echo '    _csl_get_agent                 - Get the agent name'
	@echo

_csl_view_framework_parameters ::
	@echo 'ConSuL::Agent ($(_CONSUL_AGENT_MK_VERSION)) parameters:'
	@echo '    CSL_AGENT_CONFIG_DIRPATH=$(CSL_AGENT_CONFIG_DIRPATH)'
	@echo '    CSL_AGENT_CONFIG_FILENAME=$(CSL_AGENT_CONFIG_FILENAME)'
	@echo '    CSL_AGENT_CONFIG_FILEPATH=$(CSL_AGENT_CONFIG_FILEPATH)'
	@echo '    CSL_AGENT_CONFIGS_DIRPATH=$(CSL_AGENT_CONFIG_DIRPATH)'
	@echo '    CSL_AGENT_DEVMODE_FLAG=$(CSL_AGENT_DEVMODE_FLAG)'
	@#echo '    CSL_AGENT_ENDPOINT_URL=$(CSL_AGENT_ENDPOINT_URL)'
	@echo '    CSL_AGENT_HOST=$(CSL_AGENT_HOST)'
	@echo '    CSL_AGENT_IP=$(CSL_AGENT_IP)'
	@echo '    CSL_AGENT_IP_OR_HOST=$(CSL_AGENT_IP_OR_HOST)'
	@echo '    CSL_AGENT_NAME=$(CSL_AGENT_NAME)'
	@echo '    CSL_AGENT_NODE_NAME=$(CSL_AGENT_NODE_NAME)'
	@echo '    CSL_AGENTS_SET_NAME=$(CSL_AGENTS_SET_NAME)'
	@echo

_csl_view_framework_targets ::
	@echo 'ConSuL::Agent ($(_CONSUL_AGENT_MK_VERSION)) targets:'
	@echo '    _csl_join_agent                     - Join quorum by an agent'
	@#echo '    _csl_login_agent                   - Log in the agent'
	@#echo '    _csl_show_agent                    - Show everything related to a agent'
	@#echo '    _csl_show_agent_description        - Show desription of a agent'
	@echo '    _csl_start_agent                    - Start an agent'
	@echo '    _csl_view_agents                    - View agents' 
	@#echo '    _csl_view_agents_set                - View a set of agents' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

# _csl_login_agent:
	@#$(INFO) '$(CSL_UI_LABEL)Logging in the consul-agent ...'; $(NORMAL)
	# $(CONSUL) login $(__CSL_METHOD) $(CSL_AGENT_TOKEN_ID)
	# [ ! -f $(CSL_AGENT_TOKENCACHE_FILEPATH) ] || cat $(CSL_AGENT_TOKENCACHE_FILEPATH); echo

_csl_join_agent:
	@$(INFO) '$(CSL_UI_LABEL)Joining quorum by consul-agent "$(CSL_AGENT_NAME)" ...'; $(NORMAL)
	$(CONSUL) join $(__CSL_CA_FILE) $(__CSL_CLIENT_CERT) $(__CSL_CLIENT_KEY) $(__CSL_HTTP_ADDR)

_csl_reload_agent:
	@$(INFO) '$(CSL_UI_LABEL)Reloading config from consul-agent "$(CSL_AGENT_NAME)" ...'; $(NORMAL)
	$(CONSUL) reload $(__CSL_CA_FILE) $(__CSL_CLIENT_CERT) $(__CSL_CLIENT_KEY) $(__CSL_HTTP_ADDR)

_csl_show_agent :: _csl_show_agent_config _csl_show_agent_clusterconfig _csl_show_agent_description

_csl_show_agent_config:
	@$(INFO) '$(CSL_UI_LABEL)Showing config of consul-agent "$(CSL_AGENT_NAME)" ...'; $(NORMAL)
	cat $(CSL_AGENT_CONFIG_FILEPATH)

_csl_show_agent_clusterconfig:
	@$(INFO) '$(CSL_UI_LABEL)Showing cluster-config of consul-agent "$(CSL_AGENT_NAME)" ...'; $(NORMAL)
	$(CONSUL) info $(__CSL_CA_FILE) $(__CSL_CLIENT_CERT) $(__CSL_CLIENT_KEY) $(__CSL_HTTP_ADDR)

_csl_show_agent_description:
	@$(INFO) '$(CSL_UI_LABEL)Showing consul-agent "$(CSL_AGENT_NAME)" ...'; $(NORMAL)
	# $(CONSUL) status

_csl_start_agent:
	@$(INFO) '$(CSL_UI_LABEL)Starting agent "$(CSL_AGENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If the UI has been enabled, it is accessible at http://127.0.0.1:8500/ui'; $(NORMAL)
	@$(WARN) 'This operation starts a consul-agent in the foreground'; $(NORMAL)
	@#$(WARN) 'To point you vault client to the correct endpoint: export CONSUL_ADDR=$(CSL_AGENT_ENDPOINT_URL)'
	@$(WARN) 'Press Ctrl-C to quit'; $(NORMAL)
	$(if $(CSL_AGENT_CONFIG_FILEPATH), cat $(CSL_AGENT_CONFIG_FILEPATH); echo)
	$(CONSUL) agent $(__CSL_CONFIG_FILE) $(__CSL_DEV__AGENT) $(__CSL_ENABLE_LOCAL_SCRIPT_CHECKS) $(__CSL_ENABLE_SCRIPT_CHECKS) $(__CSL_NODE)

_csl_stop_agent:
	@$(INFO) '$(CSL_UI_LABEL)Stopping agent "$(CSL_AGENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation gracefully remove an agent from a cluster'; $(NORMAL)
	$(CONSUL) leave $(__CSL_CA_FILE) $(__CSL_CLIENT_CERT) $(__CSL_CLIENT_KEY) $(__CSL_HTTP_ADDR) 

_csl_view_agents:
	@$(INFO) '$(CSL_UI_LABEL)Viewing agents ...'; $(NORMAL)
	@$(WARN) 'This operation returns information collected by the consul-client using the gossip protocol'
	@$(WARN) 'That information is eventually consistent, therefore it can be out-of-sync with the cluster state'; $(NORMAL)
	$(CONSUL) members $(__CSL_CA_FILE) $(__CSL_CLIENT_CERT) $(__CSL_CLIENT_KEY) $(__CSL_DETAILED) $(__CSL_HTTP_ADDR) 
	# $(CSLCURL) localhost:8500/v1/catalog/nodes

_csl_view_agents_set:
	@$(INFO) '$(CSL_UI_LABEL)Viewing agents-set "$(CSL_AGENTS_SET_NAME)" ...'; $(NORMAL)
	# $(CONSUL) members $(__CSL_CA_FILE) $(__CSL_CLIENT_CERT) $(__CSL_CLIENT_KEY) $(__CSL_DETAILED) $(__CSL_HTTP_ADDR)
