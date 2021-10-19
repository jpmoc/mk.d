_JFRGO_ARTIFCACTORY_CONFIGURATIPON_MK_VERSION= $(_JFROG_ARTIFACTORY_MK_VERSION)

# JFG_CONFIGURATION_API_KEY?= AKCp5ccGLXXXXXXXXXXXXdnzLdz8ZzvWehVX5S
# JFG_CONFIGURATION_SERVER_ID?= artifactory.eng.vmware.com
# JFG_CONFIGURATION_SERVER_URL?= https://artifactory.eng.vmware.com
# JFG_CONFIGURATION_USER_NAME?= emayssat
# JFG_CONFIGURATION_USER_PASSWORD?= my-password

# Derived parameters

# Option parameters
__JFG_URL= $(if $(JFG_CONFIGURATION_SERVER_URL),--url $(JFG_CONFIGURATION_SERVER_URL))
__JFG_USER= $(if $(JFG_CONFIGURATION_USER_NAME),--user $(JFG_CONFIGURATION_USER_NAME))
__JFG_PASSWORD= $(if $(JFG_CONFIGURATION_PASSWORD),--password $(JFG_CONFIGURATION_USER_PASSWORD))
__JFG_SERVER_ID= $(if $(JFG_CONFIGURATION_SERVER_ID),--server-id $(JFG_CONFIGURATION_SERVER_ID))

# UI variables

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_jfg_view_framework_macros ::
	@echo 'JFroG::Artifactory::Configuration ($(_JFROG_ARTIFACTORY_CONFIGURATION_MK_VERSION)) macros:' 
	@echo

_jfg_view_framework_parameters ::
	@echo 'JFroG::Artifactory::Configuration ($(_JFROG_ARTIFACTORY_CONFIGURATION_MK_VERSION)) parameters:'
	@echo '    JFG_CONFIGURATION_API_KEY=$(JFG_CONFIGURATION_API_KEY)'
	@echo '    JFG_CONFIGURATION_SERVER_ID=$(JFG_CONFIGURATION_SERVER_ID)'
	@echo '    JFG_CONFIGURATION_SERVER_URL=$(JFG_CONFIGURATION_URL)'
	@echo '    JFG_CONFIGURATION_USER_NAME=$(JFG_CONFIGURATION_USER_NAME)'
	@echo '    JFG_CONFIGURATION_USER_PASSWORD=$(JFG_CONFIGURATION_USER_PASSWORD)'
	@echo

_jfg_view_framework_targets ::
	@echo 'JFroG::Artifactory::Configuration ($(_JFROG_ARTIFACTORY_CONFIGURATION_MK_VERSION)) targets:' 
	@echo '    _jfg_configure_artifactory     - configure CLI for artifactory'
	@echo '    _jfg_ping_configuration        - ping configuration'
	@echo '    _jfg_show_configuration        - show configuration'
	@echo '    _jfg_use_configuration         - use configuration'
	@echo '    _jfg_view_configurations       - view configurations'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_jfg_create_configuration:
	@$(INFO) '$(JFG_UI_LABEL)Creating a new configuration ...'; $(NORMAL)
	jfrog rt config $(__JFG_PASSWORD) $(__JFG_URL) $(__JFG_USER) $(JFG_CONFIGURATION_SERVER_ID)

_jfg_ping_configuration:
	@$(INFO) '$(JFG_UI_LABEL)Pinging configuration  ...'; $(NORMAL)
	jfrog rt ping $(__JFG_SERVER_ID) $(__JFG_URL)

_jfg_use_configuration:
	@$(INFO) '$(JFG_UI_LABEL)Use configuration ...'; $(NORMAL)
	jfrog rt use $(JFG_CONFIGURATION_SERVER_ID)

_jfg_view_configurations:
	@$(INFO) '$(JFG_UI_LABEL)Show configuration ...'; $(NORMAL)
	jfrog rt config show

