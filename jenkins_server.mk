_JENKINS_SERVER_MK_VERSION= $(_JENKINS_MK_VERSION)

# JKS_SERVER_HOST?=
# JKS_SERVER_NAME?= master
# JKS_SERVER_URL?= https://jenkins.example.com/

# Derived parameters
JKS_SERVER_HOST?= $(JENKINS_SERVER_HOST)
JKS_SERVER_URL?= $(JENKINS_SERVER_URL)


#----------------------------------------------------------------------
# Usage
#

_jks_view_framework_macros ::
	@echo 'Jenkins::Server ($(_JENKINS_SERVER_MK_VERSION)) macros:'
	@echo

_jks_view_framework_parameters ::
	@echo 'Jenkins::Server ($(_JENKINS_SERVER_MK_VERSION)) parameters:'
	@echo '    JKS_SERVER_HOST=$(JKS_SERVER_HOST)'
	@echo '    JKS_SERVER_NAME=$(JKS_SERVER_NAME)'
	@echo '    JKS_SERVER_URL=$(JKS_SERVER_URL)'
	@echo

_jks_view_framework_targets ::
	@echo 'Jenkins::Server ($(_JENKINS_SERVER_MK_VERSION)) targets:'
	@echo '     _jks_show_server                - Show everything related to a server'
	@echo '     _jks_show_server_description    - Show description of a server'
	@echo '     _jks_show_server_dns            - Show DNS-resolution of a server'
	@echo '     _jks_show_server_plugins        - Show plugins of a server'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

_jks_create_server:

_jks_delete_server:

_jks_show_server :: _jks_show_server_credentialproviders _jks_show_server_dns _jks_show_server_plugins _jks_show_server_description

_jks_show_server_credentialproviders:
	@$(INFO) '$(JKS_UI_LABEL)Showing credentials-provider of server "$(JKS_SERVER_NAME)" ...'; $(NORMAL)
	$(JENKINS)list-credentials-providers

_jks_show_server_description:
	@$(INFO) '$(JKS_UI_LABEL)Showing description of server "$(JKS_SERVER_NAME)" ...'; $(NORMAL)
	curl --head --location --verbose $(JKS_SERVER_URL)/login 2>&1

_jks_show_server_dns:
	@$(INFO) '$(JKS_UI_LABEL)Showing DNS-resolution of server "$(JKS_SERVER_NAME)" ...'; $(NORMAL)
	$(if $(JKS_SERVER_HOST), \
		dig $(JKS_SERVER_HOST) \
	, @\
		echo 'JKS_SERVER_HOST not set'; \
	)

_jks_show_server_plugins:
	@$(INFO) '$(JKS_UI_LABEL)Showing plugins of server "$(JKS_SERVER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the user does NOT have the Overall/Administer permission'; $(NORMAL)
	-$(JENKINS) list-plugins

_jks_view_servers:

_jks_view_servers_set:
