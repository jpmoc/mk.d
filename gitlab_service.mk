_GITLAB_SERVICE_MK_VERSION= $(_GITLAB_MK_VERSION)

GLB_SERVICE_CONFIG_FILEPATH?= /etc/gitlab-runner/config.toml
GLB_SERVICE_NAME?= gitlab-runner
# GLB_SERVICE_EXECUTORSHELL_PASSWORD?=
GLB_SERVICE_EXECUTORSHELL_USER?= gitlab-runner
# GLB_SERVICE_EXECUTORSHELL__WORKDIRPATH?= /home/gitlab-runner
GLB_SERVICE_SYSLOG_ENABLE?= true

# Derived parameters
GLB_SERVICE_SHELLEXECUTOR_WORKDIRPATH?= ~$(GLB_SERVICE_SHELLEXECUTOR_USER)

# Option parameters
__GLB_CONFIG__SERVICE= $(if $(GLB_SERVICE_CONFIG_FILEPATH),--config $(GLB_SERVICE_CONFIG_FILEPATH))
__GLB_PASSWORD__SERVICE= $(if $(GLB_SERVICE_SHELLEXECUTOR_PASSWORD),--password $(GLB_SERVICE_SHELLEXECUTOR_PASSWORD))
__GLB_SERVICE= $(if $(GLB_SERVICE_NAME),--service $(GLB_SERVICE_NAME))
__GLB_SYSLOG= $(if $(filter true,$(GLB_SERVICE_SYSLOG_ENABLE)),--syslog)
__GLB_USER__SERVICE= $(if $(GLB_SERVICE_EXECUTORSHELL_USER),--user $(GLB_SERVICE_EXECUTORSHELL_USER))
__GLB_WORKING_DIRECTORY__SERVICE= $(if $(GLB_SERVICE_EXECUTORSHELL_WORDDIRPATH),--working-directory $(GLB_SERVICE_EXECUTORSHELL_WORKDIRPATH))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_glb_view_framework_macros ::
	@echo 'GitLaB::Service ($(_GITLAB_SERVICE_MK_VERSION)) macros:'
	@echo

_glb_view_framework_parameters ::
	@echo 'GitLaB::Service ($(_GITLAB_SERVICE_MK_VERSION)) parameters:'
	@echo '    GLB_SERVICE_CONFIG_FILEPATH=$(GLB_SERVICE_CONFIG_FILEPATH)'
	@echo '    GLB_SERVICE_NAME=$(GLB_SERVICE_NAME)'
	@echo '    GLB_SERVICE_EXECUTORSHELL_USER=$(GLB_SERVICE_EXECUTORSHELL_USER)'
	@echo '    GLB_SERVICE_EXECUTORSHELL_WORKDIRPATH=$(GLB_SERVICE_EXECUTORSHELL_WORKDIRPATH)'
	@echo '    GLB_SERVICE_SYSLOG_ENABLE=$(GLB_SERVICE_SYSLOG_ENABLE)'
	@echo

_glb_view_framework_targets ::
	@echo 'GitLaB::Service ($(_GITLAB_SERVICE_MK_VERSION)) targets:'
	@echo '    _glb_install_service              - install the gitlab-service'
	@echo '    _glb_restart_service              - restart the gitlab-service'
	@echo '    _glb_show_service                 - show everything related to the gitlab-service'
	@echo '    _glb_show_service_config          - show configuration of the gitlab-service'
	@echo '    _glb_show_service_process         - show process of the gitlab-service'
	@echo '    _glb_show_service_status          - show status of the gitlab-service'
	@echo '    _glb_show_service_version         - show version of the gitlab-service'
	@echo '    _glb_start_service                - start the gitlab-service'
	@echo '    _glb_stop_service                 - stop the gitlab-service'
	@echo '    _glb_uninstall_service            - uninstall the gitlab-service'
	@echo '    _glb_unregister_service           - unregister all runners on gitlab-service'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_glb_install_service:
	@$(INFO) '$(GLB_UI_LABEL)Installing gitlab-service "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation enables gitlab-service to be started at boot'; $(NORMAL)
	$(GITLABSERVICE) install $(strip $(__GLB_CONFIG__SERVICE) $(__GLB_PASSWORD__SERVICE) $(__GLB_SERVICE) $(__GLB_SYSLOG) $(__GLB_USER__SERVICE) $(__GLB_WORKING_DIRECTORY__SERVICE) )

_glb_restart_service:
	$(INFO) '$(GLB_UI_LABEL)Restart gitlab-service "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	$(GITLABSERVICE) restart $(__GLB_CONFIG__SERVICE) $(__GLB_SERVICE)

_glb_show_service: _glb_show_service_config _glb_show_service_process _glb_show_service_runners _glb_show_service_shellexecutoruser _glb_show_service_version _glb_show_service_status

_glb_show_service_config:
	@$(INFO) '$(GLB_UI_LABEL)Showing configuration of gitlab-service "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	echo; sudo cat $(GLB_SERVICE_CONFIG_FILEPATH); echo

_glb_show_service_process:
	@$(INFO) '$(GLB_UI_LABEL)Showing process of gitlab-service "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	ps -elf | grep -v grep | grep gitlab

_glb_show_service_runners:
	@$(INFO) '$(GLB_UI_LABEL)Showing runners of gitlab-service "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	$(GITLABSERVICE) verify

_glb_show_service_status:
	@$(INFO) '$(GLB_UI_LABEL)Showing status of gitlab-service "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	$(GITLABSERVICE) status $(__GLB_SERVICE)

_glb_show_service_shellexecutoruser:
	@$(INFO) '$(GLB_UI_LABEL)Showing shell-executor-user of gitlab-service "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This user is the one that can execute builds when using the shell-executor'; $(NORMAL)
	getent passwd $(GLB_SERVICE_EXECUTORSHELL_USER) 

_glb_show_service_version:
	@$(INFO) '$(GLB_UI_LABEL)Showing version of gitlab-service "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	$(GITLABSERVICE) --version

_glb_start_service:
	$(INFO) '$(GLB_UI_LABEL)Start gitlab-service "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	$(GITLABSERVICE) start $(__GLB_CONFIG__SERVICE) $(__GLB_SERVICE)

_glb_stop_service:
	$(INFO) '$(GLB_UI_LABEL)Stopping gitlab-service "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	$(GITLABSERVICE) stop $(__GLB_CONFIG__SERVICE) $(__GLB_SERVICE)

_glb_uninstall_service:
	@$(INFO) '$(GLB_UI_LABEL)Uninstalling gitlab-service "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation prevent the gitlab-service from starting at boot'; $(NORMAL)
	$(GITLABSERVICE) uninstall $(__GLB_CONFIG__SERVICE) $(__GLB_SERVICE)

_glb_unregister_service:
	@$(INFO) '$(GLB_UI_LABEL)Unregistering gitlab-service "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation unregisters all runners exposed by this gitlab-service'; $(NORMAL)
	$(GITLABSERVICE) unregister --all-runners $(__GLB_CONFIG__SERVICE)
