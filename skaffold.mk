_SKAFFOLD_MK_VERSION= 0.99.4

# SFD_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config
# SFD_MODE_DEBUG?= false
SFD_REPOSITORY_NAME?= docker.io/library
SFD_UI_LABEL?= [skaffold] #
# SKAFFOLD_DEFAULT_REPO=
# SKAFFOLD_CACHE_FILEPATH= $(HOME)/.skaffold/cache
SKAFFOLD_CONFIG_FILEPATH= $(HOME)/.skaffold/config
# SKAFFOLD_INSECURE_REGISTRY='insecure1.io,insecure2.io'
# SKAFFOLD_VERBOSE_LEVEL?= warn

# Derived parameters
SFD_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
SFD_MODE_DEBUG?= $(CMN_MODE_DEBUG)
SFD_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
SKAFFOLD_VERBOSE_LEVEL?= $(if $(filter true,$(SFD_MODE_DEBUG)),debug,info)

# Options

# Customizations

# Macros

# Utilities
__SKAFFOLD_ENVIRONMENT+= $(if $(SKAFFOLD_DEFAULT_REPO),SKAFFOLD_DEFAULT_REPO=$(SKAFFOLD_DEFAULT_REPO))
__SKAFFOLD_ENVIRONMENT+= $(if $(SKAFFOLD_INSECURE_REGISTRY),SKAFFOLD_INSECURE_REGISTRY=$(SKAFFOLD_INSECURE_REGISTRY))
# __SKAFFOLD_OPTIONS+= --cache-file=$(SKAFFOLD_CACHE_FILEPATH)
__SKAFFOLD_OPTIONS+= --config=$(SKAFFOLD_CONFIG_FILEPATH)
__SKAFFOLD_OPTIONS+= $(if $(SKAFFOLD_VERBOSE_LEVEL),-v $(SKAFFOLD_VERBOSE_LEVEL))
SKAFFOLD_BIN?= skaffold
SKAFFOLD?= $(strip $(__SKAFFOLD_ENVIRONMENT) $(SKAFFOLD_ENVIRONMENT) $(SKAFFOLD_BIN) $(__SKAFFOLD_OPTIONS) $(SKAFFOLD_OPTIONS))

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _sfd_list_macros
_sfd_list_macros ::
	@#echo 'SkaFfolD:: ($(_SKAFFOLD_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _sfd_list_parameters
_sfd_list_parameters ::
	@echo 'SkaFfolD:: ($(_SKAFFOLD_MK_VERSION)) parameters:'
	@echo '    SKAFFOLD=$(SKAFFOLD)'
	@echo '    SFD_INPUTS_DIRPATH=$(SFD_INPUTS_DIRPATH)'
	@echo '    SFD_KUBECONFIG_FILEPATH=$(SFD_KUBECONFIG_FILEPATH)'
	@echo '    SFD_REPOSITORY_NAME=$(SFD_REPOSITORY_NAME)'
	@echo '    SFD_OUTPUTS_DIRPATH=$(SFD_OUTPUTS_DIRPATH)'
	@echo

_list_targets :: _sfd_list_targets
_sfd_list_targets ::
	@echo 'SkaFfolD:: ($(_SKAFFOLD_MK_VERSION)) targets:'
	@echo '    _sfd_install_dependencies    - Install dependencies'
	@echo '    _sfd_view_versions           - View version of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIRPATH?= ./
-include $(MK_DIRPATH)skaffold_application.mk
-include $(MK_DIRPATH)skaffold_artifact.mk
-include $(MK_DIRPATH)skaffold_config.mk
-include $(MK_DIRPATH)skaffold_profile.mk
-include $(MK_DIRPATH)skaffold_userconfig.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_dependencies :: _sfd_install_dependencies
_sfd_install_dependencies ::
	# Install docs at https://github.com/GoogleContainerTools/skaffold
	curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
	chmod +x skaffold
	sudo mv skaffold /usr/local/bin
	which skaffold

_view_versions :: _sfd_view_versions
_sfd_view_versions:
	@$(INFO) '$(SFD_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	skaffold version
