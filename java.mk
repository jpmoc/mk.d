_JAVA_MK_VERSION= 0.99.0

# JVA_PARAMETER?= value

# Derived parameters

# Option parameters

# UI parameters
JVA_UI_LABEL?= [java] #
 
#--- Utilities
JAVA_BIN?= java
JAVA?= $(strip $(__JAVA_ENVIRONMENT) $(JAVA_ENVIRONMENT) $(JAVA_BIN) $(__JAVA_OPTIONS) $(JAVA_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _jva_view_framework_macros
_jva_view_framework_macros ::
	@#echo 'Java:: ($(_JAVA_MK_VERSION)) targets:'
	@#echo

_view_framework_parameters :: _jva_view_framework_parameters
_jva_view_framework_parameters ::
	@#echo 'Java:: ($(_JAVA_MK_VERSION)) parameters:'
	@#echo

_view_framework_targets :: _jva_view_framework_targets
_jva_view_framework_targets ::
	@echo 'JaVA:: ($(_JAVA_MK_VERSION)) targets:'
	@echo '    _jva_install_dependencies         - Install the dependencies'
	@echo '    _jva_show_version                 - Showing versions of dependencies'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

# MK_DIR?= .
# -include $(MK_DIR)/git_branch.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _jva_install_depedencies
_jva_install_dependencies:
	@$(INFO) '$(JVA_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://tecadmin.net/install-oracle-java-11-ubuntu-18-04-bionic/'; $(NORMAL)
	@$(WARN) 'Install docs @ https://www.linuxuprising.com/2019/09/install-oracle-java-13-on-ubuntu-linux.html'; $(NORMAL)
	$(SUDO) apt update
	$(SUDO) apt upgrade
	$(SUDO) add-apt-repository ppa:linuxuprising/java
	$(SUDO) apt update
	$(SUDO) apt install oracle-java13-installer
	$(SUDO) apt install oracle-java13-set-default
	java --version

_view_versions :: _jva_show_version
_jva_show_version:
	@$(INFO) '$(JVA_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	java --version
