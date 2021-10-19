_JENKINS_NODE_MK_VERSION= $(_JENKINS_MK_VERSION)

# JKS_NODE_CONFIGXML_DIRPATH?= ./xml/
# JKS_NODE_CONFIGXML_FILEPATH?= node.xml
# JKS_NODE_CONFIGXML_FILEPATH?= ./xml/node.xml
# JKS_NODE_NAME?=
# JKS_NODES_SET_NAME?=

# Derived
JKS_NODE_CONFIGXML_DIRPATH?= $(JKS_INPUTS_DIRPATH)
JKS_NODE_CONFIGXML_FILENAME?= $(JKS_NODE_NAME).xml
JKS_NODE_CONFIGXML_FILEPATH?= $(JKS_NODE_CONFIGXML_DIRPATH)$(JKS_NODE_CONFIGXML_FILENAME)

# Option

# Pipe
|_JKS_DOWNLOAD_NODE?= | tee $(JKS_NODE_CONFIGXML_FILEPATH)
_JKS_UPDATE_NODE_|?= cat $(JKS_NODE_CONFIGXML_FILEPATH) |

# UI
JKS_UI_VIEW_NODES_FIELDS?= | [.displayName,"|",.assignedLabels[].name] | @tsv


#----------------------------------------------------------------------
# Usage
#

_jks_view_framework_macros ::
	@echo 'Jenkins::Node ($(_JENKINS_NODE_MK_VERSION)) macros:'
	@echo

_jks_view_framework_parameters ::
	@echo 'Jenkins::Node ($(_JENKINS_NODE_MK_VERSION)) parameters:'
	@echo '    JKS_NODE_CONFIGXML_DIRPATH=$(JKS_CONFIGXML_DIRPATH)'
	@echo '    JKS_NODE_CONFIGXML_FILENAME=$(JKS_CONFIGXML_FILENAME)'
	@echo '    JKS_NODE_CONFIGXML_FILEPATH=$(JKS_CONFIGXML_FILEPATH)'
	@echo '    JKS_NODE_NAME=$(JKS_NODE_NAME)'
	@echo '    JKS_NODES_SET_NAME=$(JKS_NODES_SET_NAME)'
	@echo

_jks_view_framework_targets ::
	@echo 'Jenkins::Node ($(_JENKINS_NODE_MK_VERSION)) targets:'
	@echo '     _jks_download_node           - Download XML-config of node'
	@echo '     _jks_edit_node               - Edit XML-config of node'
	@echo '     _jks_exec_node               - Execute command on node'
	@echo '     _jks_show_node               - Show everything related to a node'
	@echo '     _jks_show_node_configxml     - Show XML-config of a node'
	@echo '     _jks_show_node_description   - Show description of a node'
	@echo '     _jks_show_node_labels        - Show labels running on a node'
	@echo '     _jks_show_node_process       - Show process running on a node'
	@echo '     _jks_ssh_node                - Ssh into node'
	@echo '     _jks_view_nodes              - View nodes'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

_jks_create_node:

_jks_delete_node:

_jks_download_node:
	@$(INFO) '$(JKS_UI_LABEL)Downloading XML-config for node "$(JKS_NODE_NAME)" ...'; $(NORMAL)
	$(JENKINS) get-node $(JKS_NODE_NAME) $(|_JKS_DOWNLOAD_NODE)

_jks_edit_node:
	@$(INFO) '$(JKS_UI_LABEL)Editing XML-config of node "$(JKS_NODE_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(JKS_NODE_CONFIGXML_FILEPATH)

_jks_exec_node:
	@$(INFO) '$(JKS_UI_LABEL)Exec-ing node "$(JKS_NODE_NAME)" ...'; $(NORMAL)

_jks_show_node :: _jks_show_node_configxml _jks_show_node_labels _jks_show_node_process _jks_show_node_description

_jks_show_node_configxml:
	@$(INFO) '$(JKS_UI_LABEL)Showing XML-config of node "$(JKS_NODE_NAME)" ...'; $(NORMAL)
	$(JENKINS) get-node $(JKS_NODE_NAME)

_jks_show_node_description:
	@$(INFO) '$(JKS_UI_LABEL)Showing description of node "$(JKS_NODE_NAME)" ...'; $(NORMAL)
	$(JKSCURL) -X POST $(JENKINS_SERVER_URL)/computer/api/json | jq '.computer[] | select(.displayName=="$(JKS_NODE_NAME)")'

_jks_show_node_labels:
	@$(INFO) '$(JKS_UI_LABEL)Showing labels of node "$(JKS_NODE_NAME)" ...'; $(NORMAL)
	$(JKSCURL) -X POST $(JENKINS_SERVER_URL)/computer/api/json | jq -r '.computer[] | select(.displayName=="hydra-u1404-slave09").assignedLabels[].name'

_jks_show_node_process:
	@$(INFO) '$(JKS_UI_LABEL)Showing process of node "$(JKS_NODE_NAME)" ...'; $(NORMAL)
	# exec_node
	# 0 S jenkins+ 27874 27849  0  80   0 - 3006572 futex_ Feb05 ?      04:02:47 java -jar remoting.jar -workDir /mnt/jenkins/jenkins-slave-data
	#
_jks_ssh_node:
	@$(INFO) '$(JKS_UI_LABEL)Ssh-ing into node node "$(JKS_NODE_NAME)" ...'; $(NORMAL)

_jks_update_node:
	@$(INFO) '$(JKS_UI_LABEL)Updating XML-config of node "$(JKS_NODE_NAME)" ...'; $(NORMAL)
	cat $(JKS_NODE_CONFIGXML_FILEPATH)
	$(_JKS_UPDATE_NODE_|) $(JENKINS) update-node $(JKS_NODE_NAME)

_jks_view_nodes:
	@$(INFO) '$(JKS_UI_LABEL)View nodes ...'; $(NORMAL)
	$(JKSCURL) -X POST $(JENKINS_SERVER_URL)/computer/api/json | jq -r '.computer[]$(JKS_UI_VIEW_NODES_FIELDS)'
