_CHEF_KNIFE_NODE_MK_VERSION=$(_CHEF_KNIFE_MK_VERSION)

# KFE_NODE_IP?= 172.0.0.1
# KFE_NODE_NAME?= localhost
# KFE_NODE_PRIVATE_KEY_FILEPATH?=
# KFE_NODE_SSH_PASSWORD?=
# KFE_NODE_SSH_PORT?=
# KFE_NODE_SSH_QUERY?=
# KFE_NODE_SSH_USER?=
# KFE_NODE_SUDO?= true
# KFE_NODE_SUDO_PASSWORD?= my-sudo-password
# KFE_NODES_SEARCH_QUERY?=

# Derived variables
KFE_NODE_NAME_OR_IP?= $(if $(KFE_NODE_IP),$(KFE_NODE_IP),$(KFE_NODE_NAME))
KFE_NODES_SSH_QUERY?= $(KFE_NODES_SEARCH_QUERY)

# Options
__KFE_ATTRIBUTE?=$(if $(KFE_SSH_ATTRIBUTE), --attribute $(KFE_SSH_ATTRIBUTE))
__KFE_IDENTITY_FILE?=$(if $(KFE_NODE_PRIVATE_KEY_FILEPATH), --identity-file $(KFE_NODE_PRIVATE_KEY_FILEPATH))
__KFE_NODE_NAME?=$(if $(KFE_NODE_NAME), --node-name $(KFE_NODE_NAME))
__KFE_RUN_LIST?=$(if $(KFE_NODE_RUN_LIST), --run-list '$(KFE_NODE_RUN_LIST)')
__KFE_SSH_PASSWORD?=$(if $(KFE_NODE_SSH_PASSWORD), --ssh-password $(KFE_NODE_SSH_PASSWORD))
__KFE_SSH_PORT?=$(if $(KFE_NODE_SSH_PORT), --ssh-port $(KFE_NODE_SSH_PORT))
__KFE_SSH_USER?=$(if $(KFE_NODE_SSH_USER), --ssh-user $(KFE_NODE_SSH_USER))
__KFE_SUDO?=$(if $(filter true, $(KFE_NODE_SUDO)), --sudo)
__KFE_SUDO_PASSWORD?=$(if $(filter true, $(KFE_NODE_SUDO_PASSWORD)), --sudo-password)

# Command

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kfe_view_makefile_macros ::
	@#echo "Chef::KniFE::Node ($(_CHEF_KNIFE_NODE_MK_VERSION)) targets:"
	@#echo

_kfe_view_makefile_targets ::
	@echo "Chef::KniFE::Node ($(_CHEF_KNIFE_NODE_MK_VERSION)) targets:"
	@echo "    _kfe_bootstrap_node                     - Install chef client and execute a run list"
	@echo "    _kfe_search_nodes                       - Search nodes based on a pattern"
	@echo "    _kfe_show_node                          - Show details of a managed node"
	@echo "    _kfe_show_node_tags                     - Show tags of a managed node"
	@echo "    _kfe_ssh_node                           - Ssh into a node to execute a command"
	@echo "    _kfe_view_nodes                         - View managed nodes by chef server"
	@echo

_kfe_view_makefile_variables ::
	@echo "Chef::KniFE::Node ($(_CHEF_KNIFE_NODE_MK_VERSION)) variables:"
	@echo "    KFE_NODE_IP=$(KFE_NODE_IP)"
	@echo "    KFE_NODE_NAME=$(KFE_NODE_NAME)"
	@echo "    KFE_NODE_NAME_OR_IP=$(KFE_NODE_NAME_OR_IP)"
	@echo "    KFE_NODE_RUN_LIST=$(KFE_NODE_RUN_LIST)"
	@echo "    KFE_NODE_SSH_PORT=$(KFE_NODE_SSH_PORT)"
	@echo "    KFE_NODE_SSH_USER=$(KFE_NODE_SSH_USER)"
	@echo "    KFE_NODE_PRIVATE_KEY_FILEPATH=$(KFE_NODE_PRIVATE_KEY_FILEPATH)"
	@echo "    KFE_NODE_SUDO=$(KFE_NODE_SUDO)"
	@echo "    KFE_NODE_SUDO_PASSWORD=$(KFE_NODE_SUDO_PASSWORD)"
	@echo "    KFE_NODES_SEARCH_QUERY=$(KFE_NODES_SEARCH_QUERY)"
	@echo "    KFE_NODES_SSH_ATTRIBUTE=$(KFE_NODES_SSH_ATTRIBUTE)"
	@echo "    KFE_NODES_SSH_COMMAND=$(KFE_NODES_SSH_COMMAND)"
	@echo "    KFE_NODES_SSH_QUERY=$(KFE_NODES_SSH_QUERY)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kfe_bootstrap_node:
	@$(INFO) "$(KFE_LABEL)Bootstrapping node '$(KFE_NODE_NAME)' ..."; $(NORMAL)
	$(KNIFE) bootstrap $(__KFE_SUBCOMMAND_OPTIONS) \
		$(__KFE_IDENTITY_FILE) $(__KFE_NODE_NAME) $(__KFE_RUN_LIST) $(__KFE_SSH_PASSWORD) $(__KFE_SSH_PORT) $(__KFE_SSH_USER) $(__KFE_SUDO) $(__KFE_SUDO_PASSWORD) $(KFE_NODE_NAME_OR_IP)

_kfe_search_nodes:
	@$(INFO) "$(KFE_LABEL)Searching nodes with pattern  '$(KFE_NODES_SEARCH_QUERY)' ..."; $(NORMAL)
	$(KNIFE) search node "$(KFE_NODES_SEARCH_QUERY)" -i --not-tested-but-recorded 

_kfe_show_node:
	@$(INFO) "$(KFE_LABEL)Showing managed node '$(KFE_NODE_NAME)' ..."; $(NORMAL)
	$(KNIFE) node show $(__KFE_SUBCOMMAND_OPTIONS) $(KFE_NODE_NAME)

_kfe_show_node_tags:
	@$(INFO) "$(KFE_LABEL)Showing tags of managed node '$(KFE_NODE_NAME)' ..."; $(NORMAL)
	$(KNIFE) tag list $(__KFE_SUBCOMMAND_OPTIONS) $(KFE_NODE_NAME)

_kfe_ssh_node:
	@$(INFO) "$(KFE_LABEL)Ssh into node '$(KFE_NODE_NAME)'  to execute a command ..."; $(NORMAL)
	$(KNIFE) ssh $(__KFE_SUBCOMMAND_OPTIONS) \
		$(__KFE_ATTRIBUTE) $(__KFE_IDENTITY_FILE) $(__KFE_SSH_PASSWORD) $(__KFE_SSH_PORT) $(__KFE_SSH_USER) \
		'$(KFE_NODE_NAME)' '$(KFE_SSH_COMMAND)'

_kfe_ssh_nodes:
	@#KFE_NODE_NAME is actually a regex! You can execute ssh on all managed nodes that fit the regex
	@$(INFO) "$(KFE_LABEL)Ssh into nodes '$(KFE_NODES_SSH_QUERY)'  to execute a command ..."; $(NORMAL)
	$(KNIFE) ssh $(__KFE_SUBCOMMAND_OPTIONS) \
		$(__KFE_ATTRIBUTE) $(__KFE_IDENTITY_FILE) $(__KFE_SSH_PASSWORD) $(__KFE_SSH_PORT) $(__KFE_SSH_USER) \
		'$(KFE_NODES_SSH_QUERY)' '$(KFE_SSH_COMMAND)'

_kfe_view_nodes:
	@$(INFO) "$(KFE_LABEL)Viewing managed nodes ..."; $(NORMAL)
	$(KNIFE) node list $(__KFE_SUBCOMMAND_OPTIONS) $(__KFE_WITH_URI)
