_DOCKER_MK_VERSION= 0.99.1

DKR_GROUP_NAME?= docker#
# DKR_INPUTS_DIRPATH?= ./in/
# DKR_OUTPUTS_DIRPATH?= ./out/
DKR_CONFIG_DIRPATH?= $(HOME)/.docker/
DKR_UI_LABEL?= [docker] #
# DOCKER_CONFIG_DIRPATH?= $(HOME)/.docker/
DOCKER_LOG_LEVEL?= info
# DOCKER_MODE_DEBUG?= false
# DOCKER_TLSCACERT_DIRPATH?= $(HOME)/.docker/
DOCKER_TLSCACERT_FILENAME?= ca.pem 
# DOCKER_TLSCACERT_FILEPATH?= $(HOME)/.docker/ca.pem
# DOCKER_TLSCERT_DIRPATH?= $(HOME)/.docker/
DOCKER_TLSCERT_FILENAME?= cert.pem 
# DOCKER_TLSCERT_FILEPATH?= $(HOME)/.docker/cert.pem
# DOCKER_TLSKEY_DIRPATH?= $(HOME)/.docker/
DOCKER_TLSKEY_FILENAME?= key.pem
# DOCKER_TLSKEY_FILENAME?= /home/vagrant/.docker/key.pem

# Derived parameters
DKR_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
DKR_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
DOCKER_CONFIG_DIRPATH?= $(DKR_CONFIG_DIRPATH)
DOCKER_MODE_DEBUG?= $(CMN_MODE_DEBUG)
DOCKER_TLSCACERT_DIRPATH?= $(DOCKER_CONFIG_DIRPATH)
DOCKER_TLSCACERT_FILEPATH?= $(DOCKER_TLSCACERT_DIRPATH)$(DOCKER_TLSCACERT_FILENAME)
DOCKER_TLSCERT_DIRPATH?= $(DOCKER_CONFIG_DIRPATH)
DOCKER_TLSCERT_FILEPATH?= $(DOCKER_TLSCERT_DIRPATH)$(DOCKER_TLSCERT_FILENAME)
DOCKER_TLSKEY_DIRPATH?= $(DOCKER_CONFIG_DIRPATH)
DOCKER_TLSKEY_FILEPATH?= $(DOCKER_TLSKEY_DIRPATH)$(DOCKER_TLSKEY_FILENAME)

# Options

# Customizations

# Utilities
__DOCKER_OPTIONS+= $(if $(DOCKER_CONFIG_DIRPATH),--config $(DOCKER_CONFIG_DIRPATH))
__DOCKER_OPTIONS+= $(if $(filter true,$(DOCKER_MODE_DEBUG)),--debug)
__DOCKER_OPTIONS+= # $(if $(DOCKER_LOG_LEVEL),--log-level $(DOCKER_LOG_LEVEL))
__DOCKER_OPTIONS+= # $(if $(DOCKER_TLSCACERT_FILEPATH),--tlscacert $(DOCKER_TLSCACERT_FILEPATH))
__DOCKER_OPTIONS+= # $(if $(DOCKER_TLSCERT_FILEPATH),--tlscert $(DOCKER_TLSCERT_FILEPATH))
__DOCKER_OPTIONS+= # $(if $(DOCKER_TLSKEY_FILEPATH),--tlskey $(DOCKER_TLSKEY_FILEPATH))

DOCKER_|?=
DOCKER_BIN?= docker
DOCKER?= $(strip $(DOCKER_|) $(__DOCKER_ENVIRONMENT) $(DOCKER_ENVIRONMENT) $(DOCKER_BIN) $(__DOCKER_OPTIONS) $(DOCKER_OPTIONS))

# Macros

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _dkr_list_macros
_dkr_list_macros ::
	@#echo 'Docker:: ($(_DOCKER_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _dkr_list_parameters
_dkr_list_parameters ::
	@echo 'Docker:: ($(_DOCKER_MK_VERSION)) parameters:'
	@echo '    DKR_CONFIG_DIRPATH=$(DKR_CONFIG_DIRPATH)'
	@echo '    DKR_GROUP_NAME=$(DKR_GROUP_NAME)'
	@echo '    DKR_INPUTS_DIRPATH=$(DKR_INPUTS_DIRPATH)'
	@echo '    DKR_OUTPUTS_DIRPATH=$(DKR_OUTPUTS_DIRPATH)'
	@echo '    DOCKER=$(DOCKER)'
	@echo '    DOCKER_CONFIG_DIRPATH=$(DOCKER_CONFIG_DIRPATH)'
	@echo '    DOCKER_LOG_LEVEL=$(DOCKER_LOG_LEVEL)'
	@echo '    DOCKER_MODE_DEBUG=$(DOCKER_MODE_DEBUG)'
	@echo '    DOCKER_TLSCACERT_DIRPATH=$(DOCKER_TLSCACERT_DIRPATH)'
	@echo '    DOCKER_TLSCACERT_FILENAME=$(DOCKER_TLSCACERT_FILENAME)'
	@echo '    DOCKER_TLSCACERT_FILEPATH=$(DOCKER_TLSCACERT_FILEPATH)'
	@echo '    DOCKER_TLSCERT_DIRPATH=$(DOCKER_TLSCERT_DIRPATH)'
	@echo '    DOCKER_TLSCERT_FILENAME=$(DOCKER_TLSCERT_FILENAME)'
	@echo '    DOCKER_TLSCERT_FILEPATH=$(DOCKER_TLSCERT_FILEPATH)'
	@echo '    DOCKER_TLSKEY_DIRPATH=$(DOCKER_TLSKEY_DIRPATH)'
	@echo '    DOCKER_TLSKEY_FILENAME=$(DOCKER_TLSKEY_FILENAME)'
	@echo '    DOCKER_TLSKEY_FILEPATH=$(DOCKER_TLSKEY_FILEPATH)'
	@echo

_list_targets :: _dkr_list_targets
_dkr_list_targets ::
	@echo 'Docker:: ($(_DOCKER_MK_VERSION)) targets:'
	@echo '    _dkr_clean_system                   - Clean up any dangling resources — images, containers, volumes, and networks'
	@echo '    _dkr_install_dependencies           - Install dependencies'
	@echo '    _dkr_view_versions                  - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIRPATH?= ./
-include $(MK_DIRPATH)docker_container.mk
-include $(MK_DIRPATH)docker_context.mk
-include $(MK_DIRPATH)docker_daemon.mk
-include $(MK_DIRPATH)docker_image.mk
-include $(MK_DIRPATH)docker_network.mk
-include $(MK_DIRPATH)docker_repository.mk
-include $(MK_DIRPATH)docker_registry.mk
-include $(MK_DIRPATH)docker_registryconfig.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dkr_clean_system:
	@$(INFO) '$(DKR_UI_LABEL)Purging system ...'; $(NORMAL)
	$(DOCKER) system prune -a

_install_dependencies :: _dkr_install_dependencies
_dkr_install_dependencies ::
	@$(INFO) '$(DKR_UI_LABEL)Install dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04'; $(NORMAL)
	$(SUDO) apt-get update
	# Uninstall old versions of docker
	$(SUDO) apt-get remove docker docker-engine docker.io
	$(SUDO) apt install docker.io
	$(SUDO) systemctl start docker
	$(SUDO) systemctl enable docker
	# curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine && chmod +x /tmp/docker-machine && sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
	$(SUDO) usermod -aG docker $USER

_view_versions :: _dkr_view_versions
_dkr_view_versions:
	docker --version
