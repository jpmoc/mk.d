_MAVEN_MK_VERSION= 0.9.0

# MVN_CONFIG_DIRPATH?= /usr/share/maven/conf
MVN_HOME_DIRPATH?= /usr/share/maven/
MVN_M2_DIRPATH?= $(HOME)/.m2/
# MVN_SYSTEMSETTINGS_FILEPATH?= /usr/share/maven/conf/settings.xml
MVN_UI_LABEL?= [maven] #
# MVN_UNZIP?= unzip

# Derived parameters
MVN_CONFIG_DIRPATH?= $(MVN_HOME_DIRPATH)conf/
MVN_SYSTEMSETTINGS_FILEPATH?= $(MVN_CONFIG_DIRPATH)settings.xml
MVN_UNZIP?= $(UNZIP)

# Options

# Customizations
|_MVN_SHOW_SYSTEMSETTINGS_CONTENT?= | head -10; echo '...'

# Utilities
# __MVN_OPTIONS+= $(if $(MAVEN_VERBOSITY_LEVEL),--v=$(MAVEN_VERBOSITY_LEVEL))#
MVN_BIN?= mvn
MVN?= $(strip $(__MVN_ENVIRONMENT) $(MVN_ENVIRONMENT) $(MVN_BIN) $(__MVN_OPTIONS) $(MVN_OPTIONS))

# Macros

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _mvn_list_macros
_mvn_list_macros ::
	@#echo 'MaVeN:: ($(_MAVEN_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _mvn_list_parameters
_mvn_list_parameters ::
	@echo 'MaVeN:: ($(_MAVEN_MK_VERSION)) parameters:'
	@echo '    MVN=$(MVN)'
	@echo '    MVN_CONFIG_DIRPATH=$(MVN_CONFIG_DIRPATH)'
	@echo '    MVN_HOME_DIRPATH=$(MVN_HOME_DIRPATH)'
	@echo '    MVN_M2_DIRPATH=$(MVN_M2_DIRPATH)'
	@echo '    MVN_SYSTEMSETTINGS_FILEPATH=$(MVN_SYSTEMSETTINGS_FILEPATH)'
	@echo '    MVN_UI_LABEL=$(MVN_UI_LABEL)'
	@echo

_list_targets :: _mvn_list_targets
_mvn_list_targets ::
	@echo 'MaVeN:: ($(_MAVEN_MK_VERSION)) targets:'
	@echo '    _mvn_install_dependencies              - Install dependencies'
	@echo '    _mvn_show_systemsettings               - Show everything related to system-settings'
	@echo '    _mvn_show_systemsettings_content       - Show content of the system-settings'
	@echo '    _mvn_show_systemsettings_description   - Show the description of the system-settings'
	@echo '    _mvn_view_versions                     - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIRPATH?= ./
-include $(MK_DIRPATH)maven_artifact.mk
-include $(MK_DIRPATH)maven_localrepository.mk
-include $(MK_DIRPATH)maven_plugin.mk
-include $(MK_DIRPATH)maven_project.mk
-include $(MK_DIRPATH)maven_usersettings.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_dependencies :: _mvn_install_dependencies
_mvn_install_dependencies:
	@$(INFO) '$(MVN_UI_LABEL)Installing dependencies ...'; $(NORMAL)

_MVN_SHOW_SYSTEMSETTINGS_TARGETS?= _mvn_show_systemsettings_content _mvn_show_systemsettings_description
_mvn_show_systemsettings: $(_MVN_SHOW_SYSTEMSETTINGS_TARGETS)

_mvn_show_systemsettings_content:
	@$(INFO) '$(MVN_UI_LABEL)Show content of system-settings ...'; $(NORMAL)
	cat $(MVN_SYSTEMSETTINGS_FILEPATH) $(|_MVN_SHOW_SYSTEMSETTINGS_CONTENT)

_mvn_show_systemsettings_description:
	@$(INFO) '$(MVN_UI_LABEL)Show description of system-settings ...'; $(NORMAL)
	ls -al $(MVN_SYSTEMSETTINGS_FILEPATH)

_view_versions :: _mvn_view_versions
_mvn_view_versions ::
	@$(INFO) '$(MVN_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(MVN) --version
	xml --version
