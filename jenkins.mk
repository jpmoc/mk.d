_JENKINS_MK_VERSION=0.99.0

JENKINS_CLIJAR_DIRPATH?= ${HOME}/bin/
JENKINS_CLIJAR_FILENAME?= jenkins-cli.jar
# JENKINS_CLIJAR_FILEPATH?= ${HOME}/bin/jenkins-cli.jar
# JENKINS_PRIVATEKEY_FILEPATH?= ${HOME}/.ssh/jenkins.key
# JENKINS_PUBLICKEY_FILEPATH?= ${HOME}/.ssh/jenkins.pub
# JENKINS_SERVER_HOST?= jenkins.example.com
# JENKINS_SERVER_URL?= https://jenkins.example.com
# JENKINS_USER_APITOKEN?= 12abcdef-1234-1234-abcd-1234567abcdef
# JENKINS_USER_ID?= emayssat-ms
# JKS_INPUTS_DIRPATH?= ./in/
# JKS_OUTPUTS_DIRPATH?= ./in/

#--- Derived parameter
JENKINS_CLIJAR_FILEPATH?= $(JENKINS_CLIJAR_DIRPATH)$(JENKINS_CLIJAR_FILENAME)
JENKINS_SERVER_URL?= https://$(JENKINS_SERVER_HOST)#
JKS_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
JKS_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

#--- UI parameters
JKS_UI_LABEL?= [jenkins] #

#--- Utilities
__JKSCURL_OPTIONS+= --show-error
__JKSCURL_OPTIONS+= --silent
__JKSCURL_OPTIONS+= --user $(JENKINS_USER_ID):$(JENKINS_USER_APITOKEN)
JKSCURL_BIN?= curl
JKSCURL?= $(strip $(__JKSCURL_ENVIORNMENT) $(JKSCURL_ENVIRONMENT) $(JKSCURL_BIN) $(__JKSCURL_OPTIONS) $(JKSCURL_OPTIONS))

__JENKINS_OPTIONS+= -auth $(JENKINS_USER_ID):$(JENKINS_USER_APITOKEN)
# __JENKINS_OPTIONS+= $(if $(JENKINS_PRIVATEKEY_FILEPATH),-i $(JENKINS_PRIVATEKEY_FILEPATH))
__JENKINS_OPTIONS+= $(if $(JENKINS_SERVER_URL),-s $(JENKINS_SERVER_URL))
JENKINS_BIN?= java -jar $(JENKINS_CLIJAR_FILEPATH)
JENKINS?= $(strip $(__JENKINS_ENVIRONMENT) $(JENKINS_ENVIRONMENT) $(JENKINS_BIN) $(__JENKINS_OPTIONS) $(JENKINS_OPTIONS))

#----------------------------------------------------------------------
# Usage
#

_view_framework_macros :: _jenkins_view_framework_macros
_jks_view_framework_macros ::
	@echo 'Jenkins:: ($(_JENKINS_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _jks_view_framework_parameters
_jks_view_framework_parameters ::
	@echo 'Jenkins:: ($(_JENKINS_MK_VERSION)) parameters:'
	@echo '    JENKINS=$(JENKINS)'
	@echo '    JENKINS_PRIVATEKEY_FILEPATH=$(JENKINS_PRIVATEKEY_FILEPATH)'
	@echo '    JENKINS_PUBLICKEY_FILEPATH=$(JENKINS_PUBLICKEY_FILEPATH)'
	@echo '    JENKINS_SERVER_HOST=$(JENKINS_SERVER_HOST)'
	@echo '    JENKINS_SERVER_URL=$(JENKINS_SERVER_URL)'
	@echo '    JENKINS_USER_APITOKEN=$(JENKINS_USER_APITOKEN)'
	@echo '    JENKINS_USER_ID=$(JENKINS_USER_ID)'
	@echo '    JKS_INPUTS_DIRPATH=$(JKS_INPUTS_DIRPATH)'
	@echo '    JKS_OUTPUTS_DIRPATH=$(JKS_OUTPUTS_DIRPATH)'
	@echo '    JKSCURL=$(JKSCURL)'
	@echo

_view_framework_targets :: _jks_view_framework_targets
_jks_view_framework_targets ::
	@echo 'Jenkins:: ($(_JENKINS_MK_VERSION)) targets:'
	@echo '     _jks_check_cli              - Check the CLI connection, jar, key'
	@echo '     _jks_check_whoiam           - Check who-i-am'
	@echo '     _jks_install_dependencies   - Install the dependencies'
	@echo '     _jks_view_versions          - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/jenkins_build.mk
# -include $(MK_DIR)/jenkins_groovyscript.mk
-include $(MK_DIR)/jenkins_job.mk
-include $(MK_DIR)/jenkins_node.mk
-include $(MK_DIR)/jenkins_server.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_jks_check_cli:
	@$(INFO) '$(JKS_UI_LABEL)Checking the jenkins-cli configuration ...'; $(NORMAL)
	$(JENKINS) help
	$(JENKINS) help who-am-i

_jks_check_whoiam:
	@$(INFO) '$(JKS_UI_LABEL)Checking who-i-am ...'; $(NORMAL)
	$(JENKINS) who-am-i

_install_dependencies :: _jks_install_dependencies
_jks_install_dependencies:
	@$(INFO) '$(JKS_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	curl -X GET $(JKS_SERVER_URL)/jnlpJars/jenkins-cli.jar

_view_versions :: _jks_view_versions
_jks_view_versions:
	@$(INFO) '$(JKS_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(JENKINS) version
