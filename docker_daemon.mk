_DOCKER_DAEMON_MK_VERSION= $(_DOCKER_MK_VERSION)

# DKR_DAEMON_GROUP_NAME?= docker#

# Derived parameters
DKR_DAEMON_GROUP_NAME?= $(DKR_GROUP_NAME)

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_dkr_view_framework_macros ::
	@echo 'Docker::Daemon ($(_DOCKER_DAEMON_MK_VERSION)) macros:'
	@echo

_dkr_view_framework_parameters ::
	@echo 'Docker::Daemon ($(_DOCKER_DAEMON_MK_VERSION)) parameters:'
	@echo '    DKR_DAEMON_GROUP_NAME=$(DKR_DAEMON_GROUP_NAME)'
	@echo

_dkr_view_framework_targets ::
	@echo 'Docker::Daemon ($(_DOCKER_DAEMON_MK_VERSION)) targets:'
	@echo '    _dkr_check_daemon              - Check everything related to daemon'
	@echo '    _dkr_check_daemon_group        - Check group of daemon'
	@echo '    _dkr_check_daemon_helloworld   - Check hello-world runtime with daemon'
	@echo '    _dkr_restart_daemon            - Restart the docker daemon'
	@echo '    _dkr_start_daemon              - Start the docker daemon'
	@echo '    _dkr_stop_daemon               - Stop the docker daemon'
	@echo '    _dkr_show_daemon_info          - Show info related to the daemon'
	@echo '    _dkr_show_daemon_status        - Show status of daemon'
	@echo '    _dkr_show_daemon_version       - Show version of daemon'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dkr_check_daemon: _dkr_check_daemon_group _dkr_check_daemon_helloworld _dkr_show_daemon

_dkr_check_daemon_group:
	@$(INFO) '$(DKR_UI_LABEL)Checking user groups ...'; $(NORMAL)
	@$(WARN) 'User "$(USER)" must be part of the "$(DKR_DAEMON_GROUP)" group'; $(NORMAL)
	@$(WARN) 'Command: "sudo gpasswd -a $(USER) $(DKR_DAEMON_GROUP_NAME)" and log back in!'; $(NORMAL)
	id | grep $(DKR_DAEMON_GROUP_NAME)

_dkr_check_daemon_helloworld:
	@$(INFO) '$(DKR_UI_LABEL)Checking pulling of hello-world image ...'; $(NORMAL)
	@$(WARN) 'This operation will pull the hello-world image if required'; $(NORMAL)
	$(DOCKER) run hello-world

_dkr_restart_daemon:
	@$(INFO) '$(DKR_UI_LABEL)Restarting the engine on localhost ...'; $(NORMAL)
	sudo service docker restart

_dkr_show_daemon: _dkr_show_daemon_info _dkr_show_daemon_status _dkr_show_daemon_version

_dkr_show_daemon_info:
	@$(INFO) '$(DKR_UI_LABEL)Showing docker system wide information ...'; $(NORMAL)
	docker info $(__DKR_FORMAT)

_dkr_show_daemon_status:
	@$(INFO) '$(DKR_UI_LABEL)Showing the status of the docker daemon ...'; $(NORMAL)
	service docker status

_dkr_show_daemon_version:
	@$(INFO) '$(DKR_UI_LABEL)Getting version of docker ...'; $(NORMAL)
	@$(WARN) "Ascertain that you are using the community edition (docker-ce)"; $(NORMAL)
	docker --version

_dkr_start_daemon:
	@$(INFO) '$(DKR_UI_LABEL)Starting the engine on localhost ...'; $(NORMAL)
	sudo service docker start

_dkr_stop_daemon:
	@$(INFO) '$(DKR_UI_LABEL)Stopping the engine on localhost ...'; $(NORMAL)
	sudo service docker stop
