_GITLAB_RUNNER_MK_VERSION= $(_GITLAB_MK_VERSION)

# GLB_RUNNER_CONFIG_FILEPATH?= /etc/gitlab-runner/config.toml
# GLB_RUNNER_COORDINATOR_URL?= https://gitlab.eng.vmware.com/
# GLB_RUNNER_EXECUTOR?= docker
GLB_RUNNER_EXECUTOR_LOCKED?= true
GLB_RUNNER_EXECUTOR_RUNUNTAGGED?= false
# GLB_RUNNER_EXECUTORDOCKER_CACHEDIR?=
GLB_RUNNER_EXECUTORDOCKER_DISABLEENTRYPOINTOVERWRITE?= false
# GLB_RUNNER_EXECUTORDOCKER_IMAGE?= allspark/runner:latest
GLB_RUNNER_EXECUTORDOCKER_OOMKILLDISABLE?= false
GLB_RUNNER_EXECUTORDOCKER_PRIVILEGED?= false
# GLB_RUNNER_EXECUTORDOCKER_PULLPOLICY?= always
GLB_RUNNER_EXECUTORDOCKER_SHMSIZE?= 0
GLB_RUNNER_EXECUTORDOCKER_TLSVERIFY?= false
GLB_RUNNER_EXECUTORDOCKER_VOLUMES+= /cache
# GLB_RUNNER_EXECUTORDOCKER_VOLUMES+= /var/run/docker.sock:/var/run/docker.sock
# GLB_RUNNER_EXECUTORSHELL_WORKDIRPATH?= /home/gitlab-runner
# GLB_RUNNER_EXECUTORSSH_PASSWORD?= pass1234
# GLB_RUNNER_EXECUTORSSH_USER?= root
# GLB_RUNNER_MODE_INTERACTIVE?= true
# GLB_RUNNER_NAME?= my-runner
# GLB_RUNNER_REGISTRATION_TOKEN?= 47dc0d42f56e7277ea036a3XXXXXX
GLB_RUNNER_SERVICE_NAME?= gitlab-runner
# GLB_RUNNER_TAGS?= tag1 ...
# GLB_RUNNER_TOKEN?= 
# GLB_RUNNERS_CONFIG_FILEPATH?= /etc/gitlab-runner/config.toml

# Derived parameters
GLB_RUNNER_CONFIG_FILEPATH?= $(if $(filter true,$(GLB_MODE_SERVICE)),$(GLB_SERVICE_CONFIG_FILEPATH),$(HOME)/.gitlab-runner/config.toml)
GLB_RUNNER_MODE_INTERACTIVE?= $(GLB_MODE_INTERACTIVE)
GLB_RUNNER_NAME?= $(shell hostname -s)
GLB_RUNNERS_CONFIG_FILEPATH?= $(CLB_RUNNER_CONFIG_FILEPATH)

# Option parameters
__GLB_ALL_RUNNERS__RUNNER=
__GLB_CONFIG__RUNNER= $(if $(GLB_RUNNER_CONFIG_FILEPATH),--config $(GLB_RUNNER_CONFIG_FILEPATH))
__GLB_CONFIG__RUNNERS= $(if $(GLB_RUNNERS_CONFIG_FILEPATH),--config $(GLB_RUNNERS_CONFIG_FILEPATH))
__GLB_DOCKER_CACHE_DIR= $(if $(GLB_RUNNER_EXECUTORDOCKER_CACHEDIR),--docker-cache-dir $(GLB_RUNNER_EXECUTORDOCKER_CACHEDIR))
__GLB_DOCKER_DISABLE_ENTRYPOINT_OVERWRITE= $(if $(filter true,$(GLB_RUNNER_EXECUTORDOCKER_DISABLEENTRYPOINTOVERWRITE)),--docker-disable-entrypoint-overwrite)
__GLB_DOCKER_IMAGE= $(if $(GLB_RUNNER_EXECUTORDOCKER_IMAGE),--docker-image $(GLB_RUNNER_EXECUTORDOCKER_IMAGE))
__GLB_DOCKER_OOM_KILL_DISABLE= $(if $(filter true,$(GLB_RUNNER_EXECUTORDOCKER_OOMKILLDISABLE)),--docker-oom-kill-disable)
__GLB_DOCKER_PRIVILEGED= $(if $(filter true,$(GLB_RUNNER_EXECUTORDOCKER_PRIVILEGED)),--docker-privileged)
__GLB_DOCKER_PULL_POLICY= $(if $(GLB_RUNNER_EXECUTORDOCKER_PULLPOLICY),--docker-pull-policy $(GLB_RUNNER_EXECUTORDOCKER_PULLPOLICY))
__GLB_DOCKER_SHM_SIZE= $(if $(GLB_RUNNER_EXECUTORDOCKER_SHMSIZE),--docker-shm-size $(GLB_RUNNER_EXECUTORDOCKER_SHMSIZE))
__GLB_DOCKER_TLS_VERIFY= $(if $(filter true,$(GLB_RUNNER_EXECUTORDOCKER_TLSVERIFY)),--docker-tls-verify)
__GLB_DOCKER_VOLUMES= $(if $(GLB_RUNNER_EXECUTORDOCKER_VOLUMES),$(subst $(SPACE), --docker-volumes , $(strip $(GLB_RUNNER_EXECUTORDOCKER_VOLUMES))))
__GLB_EXECUTOR= $(if $(GLB_RUNNER_EXECUTOR),--executor $(GLB_RUNNER_EXECUTOR))
__GLB_LOCKED= $(if $(GLB_RUNNER_EXECCUTOR_LOCKED),--locked=$(GLB_RUNNER_EXECCUTOR_LOCKED))
__GLB_NAME__RUNNER= $(if $(GLB_RUNNER_NAME),--name $(GLB_RUNNER_NAME))
__GLB_NON_INTERACTIVE__RUNNER= $(if $(filter false,$(GLB_RUNNER_MODE_INTERACTIVE)),--non-interactive)
__GLB_REGISTRATION_TOKEN= $(if $(GLB_RUNNER_REGISTRATION_TOKEN),--registration-token $(GLB_RUNNER_REGISTRATION_TOKEN))
__GLB_RUN_UNTAGGED= $(if $(GLB_RUNNER_EXECUTOR_RUNUNTAGGED),--run-untagged=$(GLB_RUNNER_EXECUTOR_RUNUNTAGGED))
__GLB_SSH_PASSWORD= $(if $(GLB_RUNNER_EXECUTORSSH_PASSWORD),--ssh-password $(GLB_RUNNER_EXECUTORSSH_PASSWORD))
__GLB_SSH_USER= $(if $(GLB_RUNNER_EXECUTORSSH_USER),--ssh-user $(GLB_RUNNER_EXECUTORSSH_USER))
__GLB_TAG_LIST__RUNNER= $(if $(GLB_RUNNER_TAGS),--tag-list $(call _cmn_space2comma_S,$(GLB_RUNNER_TAGS)))
__GLB_TOKEN__RUNNER= $(if $(GLB_RUNNER_TOKEN),--token $(GLB_RUNNER_TOKEN))
__GLB_URL__RUNNER= $(if $(GLB_RUNNER_COORDINATOR_URL),--url $(GLB_RUNNER_COORDINATOR_URL))
__GLB_WORKING_DIRECTORY= $(if $(GLB_RUNNER_EXECUTORSHELL_WORKDIRPATH),--working-directory $(GLB_RUNNER_EXECUTORSHELL_WORKDIRPATH))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_glb_view_framework_macros ::
	@echo 'GitLaB:::Runner ($(_GITLAB_RUNNER_MK_VERSION)) macros:'
	@echo

_glb_view_framework_parameters ::
	@echo 'GitLaB::Runner ($(_GITLAB_RUNNER_MK_VERSION)) parameters:'
	@echo '    GLB_RUNNER_COORDINATOR_URL=$(GLB_RUNNER_COORDINATOR_URL)'
	@echo '    GLB_RUNNER_CONFIG_FILEPATH=$(GLB_RUNNER_CONFIG_FILEPATH)'
	@echo '    GLB_RUNNER_EXECUTOR=$(GLB_RUNNER_EXECUTOR)'
	@echo '    GLB_RUNNER_EXECUTOR_LOCKED=$(GLB_RUNNER_EXECUTOR_LOCKED)'
	@echo '    GLB_RUNNER_EXECUTOR_RUNUNTAGGED=$(GLB_RUNNER_EXECUTOR_RUNUNTAGGED)'
	@echo '    GLB_RUNNER_EXECUTORDOCKER_CACHEDIR=$(GLB_RUNNER_EXECUTORDOCKER_CACHEDIR)'
	@echo '    GLB_RUNNER_EXECUTORDOCKER_DISABLEENTRYPOINTOVERWRITE=$(GLB_RUNNER_EXECUTORDOCKER_DISABLEENTRYPOINTOVERWRITE)'
	@echo '    GLB_RUNNER_EXECUTORDOCKER_IMAGE=$(GLB_RUNNER_EXECUTORDOCKER_IMAGE)'
	@echo '    GLB_RUNNER_EXECUTORDOCKER_OOMKILLDISABLE=$(GLB_RUNNER_EXECUTORDOCKER_OOMKILLDISABLE)'
	@echo '    GLB_RUNNER_EXECUTORDOCKER_PRIVILEGED=$(GLB_RUNNER_EXECUTORDOCKER_PRIVILEGED)'
	@echo '    GLB_RUNNER_EXECUTORDOCKER_PULLPOLICY=$(GLB_RUNNER_EXECUTORDOCKER_PULLPOLICY)'
	@echo '    GLB_RUNNER_EXECUTORDOCKER_SHMSIZE=$(GLB_RUNNER_EXECUTORDOCKER_SHMSIZE)'
	@echo '    GLB_RUNNER_EXECUTORDOCKER_TLSVERIFY=$(GLB_RUNNER_EXECUTORDOCKER_TLSVERIFY)'
	@echo '    GLB_RUNNER_EXECUTORDOCKER_VOLUMES=$(GLB_RUNNER_EXECUTORDOCKER_VOLUMES)'
	@echo '    GLB_RUNNER_EXECUTORSHELL_WORKDIRPATH=$(GLB_RUNNER_EXECUTORSHELL_WORKDIRPATH)'
	@echo '    GLB_RUNNER_EXECUTORSSH_PASSWORD=$(GLB_RUNNER_EXECUTORSSH_PASSWORD)'
	@echo '    GLB_RUNNER_EXECUTORSSH_USER=$(GLB_RUNNER_EXECUTORSSH_USER)'
	@echo '    GLB_RUNNER_MODE_INTERACTIVE=$(GLB_RUNNER_MODE_INTERACTIVE)'
	@echo '    GLB_RUNNER_NAME=$(GLB_RUNNER_NAME)'
	@echo '    GLB_RUNNER_REGISTRATION_TOKEN=$(GLB_RUNNER_REGISTRATION_TOKEN)'
	@echo '    GLB_RUNNER_SERVICE_NAME=$(GLB_RUNNER_SERVICE_NAME)'
	@echo '    GLB_RUNNER_TAGS=$(GLB_RUNNER_TAGS)'
	@echo '    GLB_RUNNER_TOKEN=$(GLB_RUNNER_TOKEN)'
	@echo

_glb_view_framework_targets ::
	@echo 'GitLaB::Runner ($(_GITLAB_RUNNER_MK_VERSION)) targets:'
	@echo '    _glb_register_runner             - register a runner'
	@echo '    _glb_show_runner                 - show everything related to a runner'
	@echo '    _glb_show_runner_config          - show configuration of runner'
	@echo '    _glb_show_runner_process         - show process of runner'
	@echo '    _glb_show_runner_status          - show status of runner'
	@echo '    _glb_show_runner_version         - show version of runner'
	@echo '    _glb_start_runner                - start a runner'
	@echo '    _glb_view_runners                - view runners'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_glb_register_runner:
	@$(INFO) '$(GLB_UI_LABEL)Registering runner "$(GLB_RUNNER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation takes in consideration only the options for the given executor'; $(NORMAL)
	@$(WARN) 'This registration token determines if the runner is group or project level'; $(NORMAL)
	$(GITLABRUNNER) register $(strip $(__GLB_DOCKER_CACHE_DIR) $(__GLB_DOCKER_DISABLE_ENTRYPOINT_OVERWRITE) $(__GLB_DOCKER_IMAGE) $(__GLB_DOCKER_OOM_KILL_DISABLE) $(__GLB_DOCKER_PRIVILEGED) $(__GLB_DOCKER_PULL_POLICY) $(__GLB_DOCKER_SHM_SIZE) $(__GLB_DOCKER_TLS_VERIFY) $(__GLB_DOCKER_VOLUMES) $(__GLB_EXECUTOR) $(__GLB_LOCKED) $(__GLB_NAME__RUNNER) $(__GLB_NON_INTERACTIVE__RUNNER) $(__GLB_REGISTRATION_TOKEN) $(__GLB_RUN_UNTAGGED) $(__GLB_SSH_PASSWORD) $(__GLB_SSH_USER) $(__GLB_TAG_LIST__RUNNER) $(__GLB_URL__RUNNER) )

_glb_show_runner: _glb_show_runner_config _glb_show_runner_status

_glb_show_runner_config:
	@$(INFO) '$(GLB_UI_LABEL)Showing configuration of runner "$(GLB_RUNNER_NAME)" ...'; $(NORMAL)
	echo; sudo cat $(GLB_RUNNER_CONFIG_FILEPATH); echo

_glb_show_runner_status:
	@$(INFO) '$(GLB_UI_LABEL)Showing status of runner ...'; $(NORMAL)
	$(GITLABRUNNER) verify

_glb_start_runner:
	$(GITLABRUNNER) run --working-directory /home/gitlab-runner --config /etc/gitlab-runner/config.toml --service gitlab-runner --syslog --user gitlab-runner

_glb_unregister_runner:
	@$(INFO) '$(GLB_UI_LABEL)Registering runner "$(GLB_RUNNER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If 2 or more runners have the same name, this operation unregister only the first/oldest one'; $(NORMAL)
	$(GITLABRUNNER) unregister $(_X__GLB_ALL_RUNNERS) $(__GLB_NAME__RUNNER) $(__GLB_TOKEN__TIKEN) $(__GLB_URL__RUNNER)

_glb_view_runners:
	@$(INFO) '$(GLB_UI_LABEL)Viewing runners ...'; $(NORMAL)
	$(GITLABRUNNER) list $(__GLB_CONFIG__RUNNERS)
