_MAVEN_MK_VERSION= 0.9.0

MVN_UI_LABEL?= [maven] #
# MVN_UNZIP?= unzip

# Derived parameters
MVN_UNZIP?= $(UNZIP)

# Options

# Customizations

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
	@echo '    MVN_UI_LABEL=$(MVN_UI_LABEL)'
	@echo

_list_targets :: _mvn_list_targets
_mvn_list_targets ::
	@echo 'MaVeN:: ($(_MAVEN_MK_VERSION)) targets:'
	@echo '    _mvn_install_dependencies              - Install dependencies'
	@echo '    _mvn_view_versions                     - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIRPATH?= ./
-include $(MK_DIRPATH)maven_artifact.mk
-include $(MK_DIRPATH)maven_plugin.mk
-include $(MK_DIRPATH)maven_project.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_dependencies :: _mvn_install_dependencies
_mvn_install_dependencies:
	@$(INFO) '$(MVN_UI_LABEL)Installing dependencies ...'; $(NORMAL)

_view_versions :: _mvn_view_versions
_mvn_view_versions ::
	@$(INFO) '$(MVN_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(MVN) --version
