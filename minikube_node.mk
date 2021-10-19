_MINIKUBE_NODE_MK_VERSION= $(_MINIKUBE_MK_VERSION)

# MKE_NODE_CLUSTER_NAME?=
# MKE_NODE_IPADDRESS?= 192.168.64.10
MKE_NODE_NAME?= minikube
# MKE_NODE_SSHPRIVATEKEY_FILEPATH?= $(HOME)/.minikube/machines/minikube/id_rsa
MKE_NODE_SSHUSER_NAME?= docker
MKE_NODE_TAILFOLLOW_FLAG?= false
MKE_NODE_TAILLENGTH_COUNT?= 50
# MKE_NODE_TAILPROBLEMS_COUNT?= false
# MKE_NODES_SET_NAME?= my-nodes-set

# Derived variables
MKE_NODE_CLUSTER_NAME?= $(MKE_CLUSTER_NAME)
MKE_NODE_SSHPRIVATEKEY_FILEPATH?= $(if $(MKE_NODE_CLUSTER_NAME),$(HOME)/.minikube/machines/$(MKE_NODE_CLUSTER_NAME)/id_rsa)

# Option variables
__MKE_FOLLOW__NODE?= $(if $(filter true,$(MKE_NODE_TAILFOLLOW_FLAG)),--follow)
__MKE_LENGTH__NODE?= $(if $(MKE_NODE_TAILLENGTH_COUNT),--length $(MKE_NODE_TAILLENGTH_COUNT))
__MKE_PROBLEMS__NODE?= $(if $(filter true,$(MKE_NODE_TAILPROBLEMS_FLAG)),--problems)
__MKE_PROFILE__NODE?= $(if $(MKE_NODE_CLUSTER_NAME),--profile $(MKE_NODE_CLUSTER_NAME))

# UI variables
 
#--- Utilities

#--- MACROS
_mke_get_node_ipaddress= $(call _mke_get_node_ipaddress_C, $(MKE_NODE_CLUSTER_NAME))
_mke_get_node_ipaddress_C= $(shell $(MINIKUBE) ip --profile $(1))

#----------------------------------------------------------------------
# USAGE
#

_mke_view_framework_macros ::
	@#echo 'MiniKubE::Node ($(_MINIKUBE_NODE_MK_VERSION)) macros:'
	@#echo

_mke_view_framework_parameters ::
	@echo 'MiniKubE::Node ($(_MINIKUBE_NODE_MK_VERSION)) parameters:'
	@echo '    MKE_NODE_CLUSTER_NAME=$(MKE_NODE_CLUSTER_NAME)'
	@echo '    MKE_NODE_EXEC_COMMAND=$(MKE_NODE_EXEC_COMMAND)'
	@echo '    MKE_NODE_IPADDRESS=$(MKE_NODE_IPADDRESS)'
	@echo '    MKE_NODE_NAME=$(MKE_NODE_NAME)'
	@echo '    MKE_NODE_SSHPRIVATEKEY_NAME=$(MKE_NODE_SSHPRIVATEKEY_NAME)'
	@echo '    MKE_NODE_SSHUSER_NAME=$(MKE_NODE_SSHUSER_NAME)'
	@echo '    MKE_NODE_TAILFOLLOW_FLAG=$(MKE_NODE_TAILFOLLOW_FLAG)'
	@echo '    MKE_NODE_TAILLENGTH_COUNT=$(MKE_NODE_TAILLENGTH_COUNT)'
	@echo '    MKE_NODES_SET_NAME=$(MKE_NODES_SET_NAME)'
	@echo

_mke_view_framework_targets ::
	@echo 'MiniKubE::Node ($(_MINIKUBE_NODE_MK_VERSION)) targets:'
	@echo '    _mke_exec_node               - Exec a command into the node'
	@echo '    _mke_show_node               - Show everything related to a node'
	@echo '    _mke_show_node_description   - Show description of a node'
	@echo '    _mke_show_node_sshcommand    - Show ssh-command of a node'
	@echo '    _mke_ssh_node                - Ssh into the node'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mke_add_node:
	@$(INFO) '$(MKE_UI_LABEL)Adding node to cluster "$(MKE_NODE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) node add # ...

_mke_exec_node:
	@$(INFO) '$(MKE_UI_LABEL)Exec-ing into node of cluster "$(MKE_CONFIG_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) ssh $(__MKE_PROFILE__NODE) $(MKE_NODE_EXEC_COMMAND)

_mke_show_node :: _mke_show_node_sshcommand _mke_show_node_description

_mke_show_node_description:
	@$(INFO) '$(MKE_UI_LABEL)Showing description of node "$(MKE_NODE_NAME)" ...'; $(NORMAL)

_mke_show_node_sshcommand:
	@$(INFO) '$(MKE_UI_LABEL)Showing ssh-command for node "$(MKE_NODE_NAME)" ...'; $(NORMAL)
	# ssh -i $(MKE_NODE_SSHPRIVATEKEY_FILEPATH) -l $(MKE_NODE_SSHUSER_NAME) $$(MKE_NODE_IPADDRESS)
	echo 'ssh -i $(MKE_NODE_SSHPRIVATEKEY_FILEPATH) -l $(MKE_NODE_SSHUSER_NAME) $(MKE_NODE_IPADDRESS)'

_mke_ssh_node:
	@$(INFO) '$(MKE_UI_LABEL)Ssh-ing into node "$(MKE_NODE_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) ssh $(__MKE_PROFILE__NODE)

_mke_tail_node:
	@$(INFO) '$(MKE_UI_LABEL)Tailing logs of node "$(MKE_NODE_NAME)" ...'; $(NORMAL)
	$(MINIKUBE) logs $(__MKE_FOLLOW__NODE) $(__MKE_LENGTH__NODE) $(__MKE_PROBLEMS__NODE)

_mke_view_nodes:
	@$(INFO) '$(MKE_UI_LABEL)View nodes ...'; $(NORMAL)

_mke_view_nodes_set:
	@$(INFO) '$(MKE_UI_LABEL)View nodes-set "$(MKE_NODES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Nodes are grouped based on the provided ...'; $(NORMAL)
