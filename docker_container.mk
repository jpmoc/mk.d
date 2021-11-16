_DOCKER_CONTAINER_MK_VERSION= $(_DOCKER_MK_VERSION)

# DKR_CONTAINER_COPY_FOLLOWLINK?= false
# DKR_CONTAINER_COPY_INFILEPATH?=/absolute/path/only
# DKR_CONTAINER_COPY_OUTFILEPATH?= ~/local_dir
# DKR_CONTAINER_COPYN_FROMMAP?= ~/local_dir:/absolute/path
# DKR_CONTAINER_COPYN_TOMAP?= ~/local_dir:/absolute/path
DKR_CONTAINER_DELETE_FORCE?= false
# DKR_CONTAINER_ENVIRONMENT?= ZA_Server=172.17.1.42
# DKR_CONTAINER_EXEC_COMMAND?= /bin/ls
# DKR_CONTAINER_HOSTNAME?= my-hostname
# DKR_CONTAINER_ID?=
# DKR_CONTAINER_IMAGE_CNAME?= weaveworksdemos/load-test
# DKR_CONTAINER_KILL_SIGNAL?= SIGHUP
# DKR_CONTAINER_NAME?= docker-nginx
# DKR_CONTAINER_RENAME_NAME?= docker-new-nginx
# DKR_CONTAINER_REMOVE_LINK?= true
# DKR_CONTAINER_REMOVE_VOLUMES?= true
# DKR_CONTAINER_RUN_ARGS?= -a
# DKR_CONTAINER_RUN_ATTACH?=stdin stdout stderr
# DKR_CONTAINER_RUN_AUTOREMOVAL?= true
# DKR_CONTAINER_RUN_BLKIOWEIGHT?=500
# DKR_CONTAINER_RUN_COMMAND?= /bin/bash
# DKR_CONTAINER_RUN_CPUSHARES?= 1024
# DKR_CONTAINER_RUN_DETACH?= true
# DKR_CONTAINER_RUN_EXPOSE?= 9201
# DKR_CONTAINER_RUN_INTERACTIVE?= true
# DKR_CONTAINER_RUN_MEMORY?= 512M
DKR_CONTAINER_RUN_PUBLISHEXPOSEDPORTS?= false
# DKR_CONTAINER_RUN_PUBLISHPORTS?= 127.0.0.1:8080:80/tcp ...
DKR_CONTAINER_RUN_RESTART?= no
# DKR_CONTAINER_RUN_TTY?= true
# DKR_CONTAINER_SNAPSHOT_AUTHOR?= emayssat
# DKR_CONTAINER_SNAPSHOT_COMMITIMAGENAME?= myregistryhost:5000/fedora/httpd:version1.0
# DKR_CONTAINER_SNAPSHOT_MESSAGE?= New version
# DKR_CONTAINER_SNAPSHOT_NAME?=
DKR_CONTAINER_SSH_SHELL?= /bin/sh
DKR_CONTAINER_STOP_TIME?= 10
# DKR_CONTAINER_STORAGE_OPTIONS?= size=20G
# DKR_CONTAINER_TAIL_COUNT?= 10
# DKR_CONTAINER_TAIL_DETAILS?= false
# DKR_CONTAINER_TAIL_FOLLOW?= false
# DKR_CONTAINER_TAIL_TIMESTAMPS?= false
# DKR_CONTAINER_VOLUMES?= ~/local/absolute_path:/container/absolute_path
# DKR_CONTAINERS_FILTER_KEYVALUES?= name=nginx status=created
# DKR_CONTAINERS_VIEW_ALL?=true
DKR_CONTAINERS_VIEW_COUNT?= -1
DKR_CONTAINERS_VIEW_QUIET?= false

# Derived variables
DKR_CONTAINER_IMAGE_CNAME?= $(DKR_IMAGE_CNAME)

# Options
__DKR_ALL= $(if $(DKR_CONTAINERS_VIEW_ALL),--all=$(DKR_CONTAINERS_VIEW_ALL))
__DKR_ATTACH= $(foreach A, $(DKR_CONTAINER_RUN_ATTACH),--attach $(A))
__DKR_AUTHOR= $(if $(DKR_CONTAINER_SNAPSHOT_AUTHOR),--author $(DKR_CONTAINER_SNAPSHOT_AUTHOR))
__DKR_BLKIO_WEIGHT= $(if $(DKR_CONTAINER_RUN_BLKIOWEIGHT),--blkio-weight $(DKR_CONTAINER_RUN_BLKIOWEIGHT))
__DKR_CPU_SHARES= $(if $(DKR_CONTAINER_RUN_CPUSHARES),--cpu-shares $(DKR_CONTAINER_RUN_CPUSHARES))
__DKR_DETACH= $(if $(filter true, $(DKR_CONTAINER_RUN_DETACH)),--detach)
__DKR_DETAILS= $(if $(filter true, $(DKR_CONTAINER_TAIL_DETAILS)),--details)
__DKR_ENV= $(if $(DKR_CONTAINER_ENVIRONMENT),--env $(DKR_CONTAINER_ENVIRONMENT))
__DKR_FILTER__CONTAINERS= $(foreach F, $(DKR_CONTAINERS_FILTER_KEYVALUES),--filter $(F))
__DKR_FOLLOW= $(if $(filter true, $(DKR_CONTAINER_TAIL_FOLLOW)),--follow)
__DKR_FOLLOW_LINK= $(if $(filter true, $(DKR_CONTAINER_COPY_FOLLOWLINK)),--follow-link)
__DKR_FORCE= $(if $(filter true, $(DKR_CONTAINER_DELETE_FORCE)),--force)
__DKR_HOSTNAME= $(if $(DKR_CONTAINER_HOSTNAME),--hostname $(DKR_CONTAINER_HOSTNAME))
__DKR_INTERACTIVE= $(if $(filter true, $(DKR_CONTAINER_RUN_INTERACTIVE)),--interactive)
__DKR_LAST= $(if $(DKR_CONTAINER_VIEW_COUNT),--last $(DKR_CONTAINER_VIEW_COUNT))
__DKR_MESSAGE= $(if $(DKR_CONTAINER_SNAPSHOT_MESSAGE),--message $(DKR_CONTAINER_SNAPSHOT_MESSAGE))
__DKR_MEMORY= $(if $(DKR_CONTAINER_RUN_MEMORY),--memory $(DKR_CONTAINER_RUN_MEMORY))
__DKR_NAME= $(if $(DKR_CONTAINER_NAME),--name $(DKR_CONTAINER_NAME))
__DKR_NETWORK= $(if $(DKR_CONTAINER_NETWORK),--network='$(DKR_CONTAINER_NETWORK)')
__DKR_NO_STREAM=
__DKR_NO_TRUNC=
__DKR_PUBLISH= $(foreach P, $(DKR_CONTAINER_RUN_PUBLISHPORTS),--publish $(P))
__DKR_PUBLISH_ALL= $(if $(filter true,$(DKR_CONTAINER_RUN_PUBLISHEXPOSEDPORTS)),--publish-all)
__DKR_QUIET= $(if $(filter true, $(DKR_CONTAINERS_VIEW_QUIET)),--quiet=$(DKR_CONTAINERS_VIEW_QUIET))
__DKR_RESTART= $(if $(DKR_CONTAINER_RUN_RESTART),--restart=$(DKR_CONTAINER_RUN_RESTART))
__DKR_RM= $(if $(filter true, $(DKR_CONTAINER_RUN_AUTOREMOVAL)),--rm)
__DKR_SIGNAL= $(if $(filter true, $(DKR_CONTAINER_KILL_SIGNAL)),--signal=$(DKR_CONTAINER_KILL_SIGNAL))
__DKR_STORAGE_OPT= $(if $(filter true, $(DKR_CONTAINER_STORAGE_OPTIONS)),--storage-opt=$(DKR_CONTAINER_STORAGE_OPTIONS))
__DKR_TAIL= $(if $(DKR_CONTAINER_TAIL_COUNT),--tail $(DKR_CONTAINER_TAIL_COUNT))
__DKR_TIMESTAMP= $(if $(filter true, $(DKR_CONTAINER_TAIL_TIMESTAMPS)),--timestamps)
__DKR_TIME= $(if $(DKR_CONTAINER_STOP_TIME),--time $(DKR_CONTAINER_STOP_TIME))
__DKR_TTY= $(if $(filter true, $(DKR_CONTAINER_RUN_TTY)),--tty)
__DKR_VOLUME= $(foreach V, $(DKR_CONTAINER_VOLUMES),--volume $(V))
__DKR_VOLUMES= $(if $(filter true, $(DKR_CONTAINER_REMOVE_VOLUMES)),--volumes)

# Customizations

# Macros
_dkr_get_container_id= $(call _dkr_get_container_id_N, $(DKR_CONTAINER_NAME))
_dkr_get_container_id_N= $(shell $(DOCKER) ps ... )

#----------------------------------------------------------------------
# Usage
#

_dkr_list_macros ::
	@echo 'Docker::Container ($(_DOCKER_CONTAINER_MK_VERSION)) targets:'
	@echo '    _dkr_get_container_id_{|N}                - Get the ID of a container (Name)'
	@echo

_dkr_list_parameters ::
	@echo 'Docker::Container ($(_DOCKER_CONTAINER_MK_VERSION)) parameters:'
	@echo '    DKR_CONTAINER_COMMITIMAGE_NAME= $(DKR_CONTAINER_COMMITIMAGE_NAME)'
	@echo '    DKR_CONTAINER_COPY_FOLLOWLINK=$(DKR_CONTAINER_COPY_FOLLOWLINK)'
	@echo '    DKR_CONTAINER_COPY_INFILEPATH=$(DKR_CONTAINER_COPY_INFILEPATH)'
	@echo '    DKR_CONTAINER_COPY_OUTFILEPATH=$(DKR_CONTAINER_COPY_OUTFILEPATH)'
	@echo '    DKR_CONTAINER_COPYN_FROMMAP=$(DKR_CONTAINER_COPYN_FROMMAP)'
	@echo '    DKR_CONTAINER_COPYN_TOMAP=$(DKR_CONTAINER_COPYN_TOMAP)'
	@echo '    DKR_CONTAINER_DELETE_FORCE=$(DKR_CONTAINER_DELETE_FORCE)'
	@echo '    DKR_CONTAINER_ENVIRONMENT=$(DKR_CONTAINER_ENVIRONMENT)'
	@echo '    DKR_CONTAINER_EXEC_COMMAND=$(DKR_CONTAINER_EXEC_COMMAND)'
	@echo '    DKR_CONTAINER_HOSTNAME=$(DKR_CONTAINER_HOSTNAME)'
	@echo '    DKR_CONTAINER_ID=$(DKR_CONTAINER_ID)'
	@echo '    DKR_CONTAINER_IMAGE_CNAME=$(DKR_CONTAINER_IMAGE_CNAME)'
	@echo '    DKR_CONTAINER_KILL_SIGNAL=$(DKR_CONTAINER_KILL_SIGNAL)'
	@echo '    DKR_CONTAINER_NAME=$(DKR_CONTAINER_NAME)'
	@echo '    DKR_CONTAINER_NETWORK=$(DKR_CONTAINER_NETWORK)'
	@echo '    DKR_CONTAINER_RENAME_NAME=$(DKR_CONTAINER_RENAME_NAME)'
	@echo '    DKR_CONTAINER_REMOVE_VOLUMES=$(DKR_CONTAINER_REMOVE_VOLUMES)'
	@echo '    DKR_CONTAINER_RUN_ARGS=$(DKR_CONTAINER_RUN_ARGS)'
	@echo '    DKR_CONTAINER_RUN_AUTOREMOVAL=$(DKR_CONTAINER_RUN_AUTOREMOVAL)'
	@echo '    DKR_CONTAINER_RUN_BLKIOWEIGHT=$(DKR_CONTAINER_RUN_BLKIOWEIGHT)'
	@echo '    DKR_CONTAINER_RUN_COMMAND=$(DKR_CONTAINER_RUN_COMMAND)'
	@echo '    DKR_CONTAINER_RUN_CPUSHARES=$(DKR_CONTAINER_RUN_CPUSHARES)'
	@echo '    DKR_CONTAINER_RUN_DETACH=$(DKR_CONTAINER_RUN_DETACH)'
	@echo '    DKR_CONTAINER_RUN_INTERACTIVE=$(DKR_CONTAINER_RUN_INTERACTIVE)'
	@echo '    DKR_CONTAINER_RUN_MEMORY=$(DKR_CONTAINER_RUN_MEMORY)'
	@echo '    DKR_CONTAINER_RUN_PUBLISHEXPOSEDPORTS=$(DKR_CONTAINER_RUN_PUBLISHEXPOSEDPORTS)'
	@echo '    DKR_CONTAINER_RUN_PUBLISHPORTS=$(DKR_CONTAINER_RUN_PUBLISHPORTS)'
	@echo '    DKR_CONTAINER_RUN_TTY=$(DKR_CONTAINER_RUN_TTY)'
	@echo '    DKR_CONTAINER_SNAPSHOT_AUTHOR=$(DKR_CONTAINER_SNAPSHOT_AUTHOR)'
	@echo '    DKR_CONTAINER_SNAPSHOT_NAME=$(DKR_CONTAINER_SNAPSHOT_NAME)'
	@echo '    DKR_CONTAINER_SNAPSHOT_MESSAGE=$(DKR_CONTAINER_SNAPSHOT_MESSAGE)'
	@echo '    DKR_CONTAINER_SSH_SHELL=$(DKR_CONTAINER_SSH_SHELL)'
	@echo '    DKR_CONTAINER_STOP_TIME=$(DKR_CONTAINER_STOP_TIME)'
	@echo '    DKR_CONTAINER_TAIL_COUNT=$(DKR_CONTAINER_TAIL_COUNT)'
	@echo '    DKR_CONTAINER_TAIL_DETAILS=$(DKR_CONTAINER_TAIL_DETAILS)'
	@echo '    DKR_CONTAINER_TAIL_FOLLOW=$(DKR_CONTAINER_TAIL_FOLLOW)'
	@echo '    DKR_CONTAINER_TAIL_TIMESTAMPS=$(DKR_CONTAINER_TAIL_TIMESTAMPS)'
	@echo '    DKR_CONTAINER_VOLUMES=$(DKR_CONTAINER_VOLUMES)'
	@echo '    DKR_CONTAINERS_FILTER_KEYVALUES=$(DKR_CONTAINERS_FILTER_KEYVALUES)'
	@echo '    DKR_CONTAINERS_VIEW_ALL=$(DKR_CONTAINERS_VIEW_ALL)'
	@echo '    DKR_CONTAINERS_VIEW_COUNT=$(DKR_CONTAINERS_VIEW_COUNT)'
	@echo '    DKR_CONTAINERS_VIEW_QUIET=$(DKR_CONTAINERS_VIEW_QUIET)'
	@echo '    DKR_CONTAINERS_SET_NAME=$(DKR_CONTAINERS_SET_NAME)'
	@echo

_dkr_list_targets ::
	@echo 'Docker::Container ($(_DOCKER_CONTAINER_MK_VERSION)) targets:'
	@echo '    _dkr_attach_container                    - Attach a container'
	@echo '    _dkr_clean_containers                    - Clean all exited containers'
	@echo '    _dkr_copyfrom_container                  - Copy single file/folder from a container'
	@echo '    _dkr_copyto_container                    - Copy single file/folder to a container'
	@echo '    _dkr_copyNfrom_container                 - Copy multiple files/folders from a container'
	@echo '    _dkr_copyNto_container                   - Copy multiple files/folders to a container'
	@echo '    _dkr_create_container                    - Run/Instanciate a new container'
	@echo '    _dkr_delete_container                    - Delete a container'
	@echo '    _dkr_exec_container                      - Exec a command in a container'
	@echo '    _dkr_list_containers                     - List all containers'
	@echo '    _dkr_list_containers_set                 - List a set of containers'
	@echo '    _dkr_purge_containers                    - Purge all containers'
	@echo '    _dkr_remove_container                    - Remove a containers'
	@echo '    _dkr_restart_container                   - Restart/reboot a container'
	@echo '    _dkr_show_container                      - Show everything related to a container'
	@echo '    _dkr_show_container_description          - Show description of a container'
	@echo '    _dkr_show_container_env                  - Show the environment of a container'
	@echo '    _dkr_show_container_object               - Show the object-representation of a container'
	@echo '    _dkr_show_container_logs                 - Show the logs of a container'
	@echo '    _dkr_show_container_ports                - Show the ports of a container'
	@echo '    _dkr_show_container_stats                - Show the stats of a container'
	@echo '    _dkr_snapshot_container                  - Create an image of a running container'
	@echo '    _dkr_ssh_container                       - Ssh into the container'
	@echo '    _dkr_start_container                     - Start a stopped container'
	@echo '    _dkr_stats_container                     - Display statistics on a container'
	@echo '    _dkr_stop_container                      - Stop a running container'
	@echo '    _dkr_tail_container                      - Tail the logs of a container'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dkr_attach_container:
	@$(INFO) '$(DKR_UI_LABEL)Attaching to container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(DOCKER) attach $(__DKR_DETACH_KEYS) $(__DKR_NO_STDIN) $(__DKR_SIG_PROXY) $(DKR_CONTAINER_NAME)

_dkr_clean_containers:
	@$(INFO) '$(DKR_UI_LABEL)Cleaning containers ...'; $(NORMAL)
	@$(WARN) 'This operation removes all exited containers'; $(NORMAL)
	$(DOCKER) ps --all --filter status=exited
	$(DOCKER) ps --all --filter status=exited --no-trunc --quiet | xargs $(DOCKER) rm

_dkr_copyfrom_container:
	@$(INFO) '$(DKR_UI_LABEL)Copying single file/folder from container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(DOCKER) cp $(__DKR_ARCHIVE) $(__DKR_FOLLOW_LINK) $(DKR_CONTAINER_NAME):$(DKR_CONTAINER_COPY_INFILEPATH) $(DKR_CONTAINER_COPY_OUTFILEPATH)

_dkr_copyto_container:
	@$(INFO) '$(DKR_UI_LABEL)Copying single file/folder to container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(DOCKER) cp $(__DKR_ARCHIVE) $(__DKR_FOLLOW_LINK) $(DKR_CONTAINER_COPY_OUTFILEPATH) $(DKR_CONTAINER_NAME):$(DKR_CONTAINER_COPY_INFILEPATH)

_dkr_copyNfrom_container:
	@$(INFO) '$(DKR_UI_LABEL)Copying N files/folders from container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(foreach M, $(DKR_CONTAINER_COPYN_FROMMAP),  \
		docker cp $(__DKR_ARCHIVE) $(__DKR_FOLLOW_LINK) \
			$(DKR_CONTAINER_NAME):$(word 2, $(subst :, , $M)) \
			$(word 1, $(substr :, , $M)); \
	)

_dkr_copyNto_container:
	@$(INFO) '$(DKR_UI_LABEL)Copying N files/folders to container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(foreach M, $(DKR_CONTAINER_COPYN_TOMAP),  \
		docker cp $(__DKR_ARCHIVE) $(__DKR_FOLLOW_LINK) \
			$(word 1, $(subst :, , $M)) \
			$(DKR_CONTAINER_NAME):$(word 2, $(subst :, , $M)); \
	)

_dkr_create_container:
	@$(INFO) '$(DKR_UI_LABEL)Creating a container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation pulls the image if not already cached locally'; $(NORMAL)
	@$(WARN) 'This operation creates and starts a container, executes a command until its completes'; $(NORMAL)
	@$(WARN) 'This operation returns the same exit code at the executed command'; $(NORMAL)
	@$(WARN) 'This operation runs the command in detached, attached, or interactive-tty mode'; $(NORMAL)
	@$(WARN) 'This operation assigns a unique name to the container unless one is provided'; $(NORMAL)
	@$(WARN) 'This operation fails if the provided container-name is used by a running, stopped, or exited container'; $(NORMAL)
	@$(WARN) 'This operation must publish the docker exposed ports to map them to the host ports'; $(NORMAL)
	$(DOCKER) run $(strip $(__DKR_BLKIO_WEIGHT) $(__DKR_CPU_SHARES) $(__DKR_DETACH) $(__DKR_ENV) $(__DKR_HOSTNAME) $(__DKR_INTERACTIVE) $(__DKR_MEMORY) $(__DKR_NAME) $(__DKR_PUBLISH) $(__DKR_PUBLISH_ALL) $(__DKR_RESTART) $(__DKR_RM) $(__DKR_STORAGE_OPT) $(__DKR_TTY) $(__DKR_VOLUME) $(DKR_CONTAINER_IMAGE_CNAME) $(DKR_CONTAINER_RUN_COMMAND) $(DKR_CONTAINER_RUN_ARGS) )

_dkr_delete_container:
	@$(INFO) '$(DKR_UI_LABEL)Removing container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation removes only stopped containers, use --force to change that behavior'; $(NORMAL)
	$(DOCKER) rm $(__DKR_FORCE) $(__DKR_LINK) $(__DKR_VOLUMES) $(DKR_CONTAINER_NAME)

_dkr_exec_container:
	@$(INFO) '$(DKR_UI_LABEL)Exec-ing a command in container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation only works on already-running containers'; $(NORMAL)
	$(DOCKER) exec --interactive --tty $(DKR_CONTAINER_NAME) $(DKR_CONTAINER_EXEC_COMMAND)

_dkr_kill_container:
	@$(INFO) '$(DKR_UI_LABEL)Killing container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(DOCKER) kill $(__DKR_SIGNAL) $(DKR_CONTAINER_NAME)

_dkr_list_containers:
	@$(INFO) '$(DKR_UI_LABEL)Listing containers ...'; $(NORMAL)
	@$(WARN) 'This operation displays running, stopped, and terminated containers'; $(NORMAL)
	$(DOCKER) ps $(_X__DKR_ALL) --all $(__DKR_BEFORE) $(_X__DKR_FILTER__CONTAINERS) $(_X__DKR_LAST) $(__DKR_QUIET) $(__DKR_SINCE) $(__DKR_SIZE)

_dkr_list_containers_set:
	@$(INFO) '$(DKR_UI_LABEL)Listing containers-set "$(DKR_CONTAINERS_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Containers are grouped based on count, filter, state, instanciation time, ...'; $(NORMAL) 
	$(DOCKER) ps $(__DKR_ALL) $(__DKR_BEFORE) $(__DKR_FILTER__CONTAINERS) $(__DKR_LAST) $(__DKR_QUIET) $(__DKR_SINCE) $(__DKR_SIZE)

_dkr_purge_containers:
	@$(INFO) '$(DKR_UI_LABEL)Purging containers ...'; $(NORMAL)
	@$(WARN) 'This operation removes all containers'; $(NORMAL)
	$(DOCKER) ps --all
	$(DOCKER) ps --all --no-trunc --quiet | xargs $(DOCKER) rm

_dkr_remove_containers:
	@$(INFO) '$(DKR_UI_LABEL)Removing ALL stopped containers ...'; $(NORMAL)
	$(DOCKER) rm $(_X__DKR_FORCE) $(_X__DKR_LINK) $(_X__DKR_VOLUMES) $$($(DOCKER) ps -a -q)

_dkr_rename_container:
	@$(INFO) '$(DKR_UI_LABEL)Renaming container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(DOCKER) rename $(DKR_CONTAINER_NAME) $(DKR_CONTAINER_RENAME_NAME)

_dkr_restart_container:
	@$(INFO) '$(DKR_UI_LABEL)Restarting container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(DOCKER) restart $(__DKR_TIME) $(DKR_CONTAINER_NAME)

_DKR_SHOW_CONTAINER_TARGETS?= _dkr_show_container_env _dkr_show_container_logs _dkr_show_container_object _dkr_show_container_ports _dkr_show_container_stats _dkr_show_container_description
_dkr_show_container: $(_DKR_SHOW_CONTAINER_TARGETS)

_dkr_show_container_description:
	@$(INFO) '$(DKR_UI_LABEL)Showing description of container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	@$(DOCKER) ps -a --no-trunc | head -1 
	$(DOCKER) ps -a --no-trunc | grep $(DKR_CONTAINER_NAME)

_dkr_show_container_env:
	@$(INFO) '$(DKR_UI_LABEL)Showing the environment of container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(DOCKER) exec $(DKR_CONTAINER_NAME) env

_dkr_show_container_logs:
	@$(INFO) '$(DKR_UI_LABEL)Showing logs of container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(DOCKER) logs $(__DKR_DETAILS) $(_X__DKR_FOLLOW) $(__DKR_TAIL) $(__DKR_TIMESTAMPS) $(DKR_CONTAINER_NAME)

_dkr_show_container_object:
	@$(INFO) '$(DKR_UI_LABEL)Showing the object-representation of container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The operation returns info on the state, host-configuration, graph-drivers, mount-points, network-settings, config of container'; $(NORMAL)
	$(DOCKER) inspect $(DKR_CONTAINER_NAME)

_dkr_show_container_ports:
	@$(INFO) '$(DKR_UI_LABEL)Showing ports of container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(DOCKER) port $(DKR_CONTAINER_NAME)

_dkr_show_container_stats:
	@$(INFO) '$(DKR_UI_LABEL)Showing stats of container "$(DKR_CONTAINER_NAME)"  ...'; $(NORMAL)
	$(DOCKER) stats $(_X__DKR_NO_STREAM) --no-stream $(__DKR_NO_TRUNC) $(DKR_CONTAINER_NAME)

_dkr_snapshot_container:
	@$(INFO) '$(DKR_UI_LABEL)Snapshoting container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Container id: $(DKR_CONTAINER_ID)'; $(NORMAL)
	$(DOCKER) commit $(__DKR_MESSAGE) $(__DKR_AUTHOR) $(DKR_CONTAINER_ID) $(DKR_CONTAINER_SNAPSHOT_COMMITIMAGENAME)

_dkr_ssh_container:
	@$(INFO) '$(DKR_UI_LABEL)Sshing into container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation only works on already-running containers'; $(NORMAL)
	$(DOCKER) exec --interactive --tty $(DKR_CONTAINER_NAME) $(DKR_CONTAINER_SSH_SHELL)

_dkr_start_container:
	@$(INFO) '$(DKR_UI_LABEL)Starting container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation can only start stopped containers'; $(NORMAL)
	$(DOCKER) start $(DKR_CONTAINER_NAME)

_dkr_stop_container:
	@$(INFO) '$(DKR_UI_LABEL)Stopping container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(DOCKER) stop $(__DKR_TIME) $(DKR_CONTAINER_NAME)

_dkr_tail_container: _dkr_show_container_logs
	@$(INFO) '$(DKR_UI_LABEL)Tailing logs of container "$(DKR_CONTAINER_NAME)" ...'; $(NORMAL)
	$(DOCKER) logs $(__DKR_DETAILS) $(__DKR_FOLLOW) $(__DKR_TAIL) $(__DKR_TIMESTAMPS) $(DKR_CONTAINER_NAME)
