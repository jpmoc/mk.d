_DOCKERMACHINE_MK_VERSION= 0.99.1

# DME_DIGITALOCEAN_ACCESS_TOKEN?=
# DME_DRIVER?=virtualbox
# DME_ENGINE_ENV?=
# DME_ENGINE_INSECURE_REGISTRY?=
# DME_ENGINE_INSTALL_URL?=https://get.docker.com
# DME_GENERIC_IP_ADDRESS?=192.168.0.1
# DME_GENERIC_SSH_KEY?=~/.vagrant.d/insecure_prive_key
# DME_GENERIC_SSH_USER?=vagrant
# DME_MACHINE_NAME?=machine-name
# DME_SWARM?=
# DME_SWARM_ADDR?=
# DME_SWARM_DISCOVERY?=
# DME_SWARM_EXPERIMENTAL?=
DME_UI_LABEL?= [dockermachine] #
# DME_VIRTUALBOX_CPU_COUNT?=1
# DME_VIRTUALBOX_DISK_SIZE?=100000                     # In MB
# DME_VIRTUALBOX_MEMORY?=8192                          # In MB
# DME_VMWAREFUSION_CPU_COUNT?=4
# DME_VMWAREFUSION_DISK_SIZE?=60000
# DME_VMWAREFUSION_MEMORY_SIZE?=8192

# Options
__DME_DRIVER?= $(if $(DME_DRIVER), --driver $(DME_DRIVER))

# DIGITAL OCEAN
__DME_DIGITALOCEAN_ACCESS_TOKEN?= $(if $(DME_DIGITALOCEAN_ACCESS_TOKEN),--digital-ocean-access-token $(DME_DIGITALOCEAN_ACCESS_TOKEN))
__DME_DIGITALOCEAN_SETTINGS+= $(__DME_DIGITAL_ACCESS_TOKEN)

# GENERIC
__DME_GENERIC_IP_ADDRESS?= $(if $(GENERIC_IP_ADDRESS),--generic-ip-address $(DME_GENERIC_IP_ADDRESS))
__DME_GENERIC_SSH_KEY?= $(if $(GENERIC_SSH_KEY),--generic-ssh-key $(DME_GENERIC_SSH_KEY))
__DME_GENERIC_SSH_USER?= $(if $(GENERIC_SSH_USER),--generic-ssh-user $(DME_GENERIC_SSH_USER))
__DME_GENERIC_SETTINGS+= $(__DME_GENERIC_IP_ADDRESS) $(__DME_GENERIC_SSH_KEY) $(__DME_GENERIC_SSH_USER)

# VIRTUAL BOX
__DME_VIRTUALBOX_CPU_COUNT?= $(if $(DME_VIRTUALBOX_CPU_COUNT),--virtualbox-cpu-count '$(DME_VIRTUALBOX_CPU_COUNT)')
__DME_VIRTUALBOX_DISK_SIZE?= $(if $(DME_VIRTUALBOX_DRIVER),--virtualbox-disk-size '$(DME_VIRTUALBOX_DISK_SIZE)')
__DME_VIRTUALBOX_MEMORY?= $(if $(DME_VIRTUALBOX_MEMORY),--virtualbox-memory $(DME_VIRTUALBOX_MEMORY))
__DME_VIRTUALBOX_SETTINGS+= $(__DME_VIRTUALBOX_CPU_COUNT) $(__DME_VIRTUALBOX_DISK_SIZE) $(__DME_VIRTUALBOX_MEMORY)

# VMWARE FUSION
__DME_VMWAREFUSION_CPU_COUNT?= $(if $(DME_VMWAREFUSION_CPU_COUNT),--vmwarefusion-cpu-count '$(DME_VMWAREFUSION_CPU_COUNT)')
__DME_VMWAREFUSION_DISK_SIZE?= $(if $(DME_VMWAREFUSION_DISK_SIZE),--vmwarefusion-disk-size '$(DME_VMWAREFUSION_DISK_SIZE)')
__DME_VMWAREFUSION_MEMORY_SIZE?= $(if $(DME_VMWAREFUSION_MEMORY_SIZE),--vmwarefusion-memory-size '$(DME_VMWAREFUSION_MEMORY_SIZE)')
__DME_VMWAREFUSION_SETTINGS+= $(__DME_VMWAREFUSION_CPU_COUNT) $(__DME_VMWAREFUSION_DISK_SIZE) $(__DME_VMWAREFUSION_MEMORY_SIZE)

# Customizations

# Macros
_dme_get_ip=$(call _dme_get_ip_N, $(DME_MACHINE_NAME))
_dme_get_ip_N=$(shell $(DOCKERMACHINE) ip $(1))

# Utility
DOCKERMACHINE_BIN?= docker-machine
DOCKERMACHINE?= $(strip $(__DOCKERMACHINE_ENVIRONMENT) $(DOCKERMACHINE_ENVIRONMENT) $(DOCKERMACHINE_BIN) $(__DOCKERMACHINE_OPTIONS) $(DOCKERMACHINE_OPTIONS) )

#----------------------------------------------------------------------
# Usage
#

_list_macros :: _dme_list_macros
_dme_list_macros ::
	@echo 'DockerMachinE ($(_DOCKERMACHINE_MK_VERSION)) macros:'
	@echo '     _dme_get_ip             - Return the IP of the current machine'
	@echo '     _dme_get_ip_N           - Return the IP of a given machine'
	@echo

_list_parameters :: _dme_list_parameters
_dme_list_parameters ::
	@echo 'DockerMachinE ($(_DOCKERMACHINE_MK_VERSION)) variables:'
	@echo '    DME_DIGITALOCEAN_ACCESS_TOKEN=$(DME_DIGITALOCEAN_ACCESS_TOKEN)'
	@echo '    DME_DRIVER=$(DME_DRIVER)'
	@echo '    DME_ENGINE_ENV=$(DME_ENGINE_ENV)'
	@echo '    DME_ENGINE_INSECURE_REGISTRY=$(DME_ENGINE_INSECURE_REGISTRY)'
	@echo '    DME_ENGINE_INSTALL_URL=$(DME_ENGINER_INSTALL_URL)'
	@echo '    DME_MACHINE_NAME=$(DME_MACHINE_NAME)'
	@echo '    DME_SWARM=$(DME_SWARM)'
	@echo '    DME_SWARM_ADDR=$(DME_SWARM_ADDR)'
	@echo '    DME_SWARM_DISCOVERY=$(DME_SWARM_DISCOVERY)'
	@echo '    DME_SWARM_EXPERIMENTAL=$(DME_SWARM_EXPERIMENTAL)'
	@echo '    DME_VIRTUALBOX_CPU_COUNT=$(DME_VIRTUALBOX_CPU_COUNT)'
	@echo '    DME_VIRTUALBOX_DISK_SIZE=$(DME_VIRTUALBOX_DISK_SIZE)'
	@echo '    DME_VIRTUALBOX_MEMORY=$(DME_VIRTUALBOX_MEMORY)'
	@echo

_list_targets :: _dme_list_targets
_dme_list_targets ::
	@echo 'DockerMachinE ($(_DOCKERMACHINE_MK_VERSION)) targets:'
	@echo '    _dme_create_machine             - Create an entirely new machine'
	@echo '    _dme_show_environment           - Show environment to work with new machine'
	@echo '    _dme_ssh_machine                - SSH in the machine'
	@echo '    _dme_restart_machine            - Restart in the machine'
	@echo '    _dme_start_machine              - Start the machine'
	@echo '    _dme_stop_machine               - Stop in the machine'
	@echo '    _dme_view_versions              - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dme_create_machine:
	@$(INFO) '$(DME_UI_LABEL)Creating a new machine ...'; $(NORMAL)
	$(DOCKERMACHINE) create $(__DME_DRIVER) $(__DME_DIGITALOCEAN_SETTINGS) $(__DME_GENERIC_SETTINGS) $(__DME_VIRTUALBOX_SETTINGS) $(__DME_VMWAREFUSION_SETTINGS) $(DME_MACHINE_NAME)

_dme_list_machines:
	@$(INFO) '$(DME_UI_LABEL)List machines ...'; $(NORMAL)
	$(DOCKERMACHINE) ls

_dme_show_environment:
	@$(INFO) '$(DME_UI_LABEL)Show environment to work with '$(DME_MACHINE_NAME)' ...'; $(NORMAL)
	$(DOCKERMACHINE) env $(DME_MACHINE_NAME)

_dme_restart_machine:
	@$(INFO) '$(DME_UI_LABEL)Restarting machine '$(DME_MACHINE_NAME)' ...'; $(NORMAL)
	eval $$($(DOCKERMACHINE) env $(DME_MACHINE_NAME) && docker-machine restart $(DME_MACHINE_START)

_dme_start_machine:
	@$(INFO) '$(DME_UI_LABEL)Starting machine '$(DME_MACHINE_NAME)' ...'; $(NORMAL)
	eval $$($(DOCKERMACHINE) env $(DME_MACHINE_NAME) && docker-machine start $(DME_MACHINE_START)

_dme_stop_machine:
	@$(INFO) '$(DME_UI_LABEL)Stoping machine '$(DME_MACHINE_NAME)' ...'; $(NORMAL)
	eval $$($(DOCKERMACHINE) env $(DME_MACHINE_NAME) && docker-machine stop $(DME_MACHINE_START)

_dme_ssh_machine: _dme_list_machines
	@$(INFO) '$(DME_UI_LABEL)SSHing into machine '$(DME_MACHINE_NAME)' ...'; $(NORMAL)
	eval $$($(DOCKERMACHINE) env $(DME_MACHINE_NAME)) && docker-machine ssh $(DME_MACHINE_NAME)

_view_versions :: _dme_view_versions
_dme_view_versions:
	@$(INFO) '$(DME_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(DOCKERMACHINE) --version
