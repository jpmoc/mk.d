_DOCKER_REGISTRY_MK_VERSION= $(_DOCKER_MK_VERSION)

# DKR_REGISTRY_API_HOSTPORT?= index.docker.io# Not sure which port is used by default! Fails for 443 !?!
DKR_REGISTRY_API_PROTOCOL?= https://
# DKR_REGISTRY_API_URI?= https://index.docker.io/v1
DKR_REGISTRY_API_VERSION?= v2
DKR_REGISTRY_CNAME?= index.docker.io# Not sure which port is used by default! Fails for 443 !?!
DKR_REGISTRY_NAME?= DockerHub
# DKR_REGISTRY_NO_TRUNC?= false
# DKR_REGISTRY_PASSWORD_STDIN?= false
# DKR_REGISTRY_REGISTRYCONFIG_DIRPATH?= $(HOME)/.docker/
# DKR_REGISTRY_REGISTRYCONFIG_FILENAME?= config.json
# DKR_REGISTRY_REGISTRYCONFIG_FILEPATH?= $(HOME)/.docker/config.json
# DKR_REGISTRY_SEARCH_EXPRESSION?= emayssatware/pilot
# DKR_REGISTRY_REPOSITORY_URI?= docker.io/emayssatware/pilot
# DKR_REGISTRY_SEARCH_FILTER?=
# DKR_REGSITRY_SEARCH_FORMAT?= "table {{.Name}}\t{{.IsAutomated}}\t{{.IsOfficial}}"
DKR_REGISTRY_SEARCH_LIMIT?= 25
# DKR_REGISTRY_USER_NAME?= emayssat
# DKR_REGISTRY_USER_PASSWORD?= my-password

# Derived parameters
DKR_REGISTRY_API_HOSTPORT?= $(DKR_REGISTRY_CNAME)
DKR_REGISTRY_API_URI?= $(if $(DKR_REGISTRY_API_HOSTPORT),$(DKR_REGISTRY_API_PROTOCOL)$(DKR_REGISTRY_API_HOSTPORT)/$(DKR_REGISTRY_API_VERSION)/)
DKR_REGISTRY_SEARCH_EXPRESSION?= $(DKR_REGISTRY_USER_NAME)
DKR_REGISTRY_REGISTRYCONFIG_DIRPATH?= $(DKR_REGISTRYCONFIG_DIRPATH)
DKR_REGISTRY_REGISTRYCONFIG_FILENAME?= $(DKR_REGISTRYCONFIG_FILENAME)
DKR_REGISTRY_REGISTRYCONFIG_FILEPATH?= $(DKR_REGISTRY_REGISTRYCONFIG_DIRPATH)$(DKR_REGISTRY_REGISTRYCONFIG_FILENAME)

# Options
__DKR_FORMAT__REGISTRY= $(if $(DKR_REGISTRY_SEARCH_FORMAT),--format $(DKR_REGSITRY_SEARCH_FORMAT))
__DKR_FILTER= $(if $(DKR_REGISTRY_SEARCH_FILTER),--filter $(DKR_REGISTRY_SEARCH_FILTER))
__DKR_LIMIT= $(if $(DKR_REGISTRY_SEARCH_LIMIT),--limit $(DKR_REGISTRY_SEARCH_LIMIT))
__DKR_NO_TRUNC= $(if $(filter true, $(DKR_REGISTRY_NO_TRUNC)),--no-trunc)
__DKR_PASSWORD= $(if $(DKR_REGISTRY_USER_PASSWORD),--password $(DKR_REGISTRY_USER_PASSWORD))
__DKR_PASSWORD_STDIN= $(if $(filter true,$(DKR_REGISTRY_PASSWORD_STDIN)),--password-stdin)
__DKR_USERNAME= $(if $(DKR_REGISTRY_USER_NAME),--username $(DKR_REGISTRY_USER_NAME))

# Customizations

# Macros

#----------------------------------------------------------------------
# USAGE
#

_dkr_list_macros ::
	@echo 'DocKeR::Registry ($(_DOCKER_REGISTRY_MK_VERSION)) targets:'
	@echo '    _dkr_get_image_id_{|N}        - Get the ID of an image (Name)'
	@echo

_dkr_list_parameters ::
	@echo 'DocKeR::Registry ($(_DOCKER_REGISTRY_MK_VERSION)) parameters:'
	@echo '    DKR_REGISTRY_API_HOSTPORT=$(DKR_REGISTRY_API_HOSTPORT)'
	@echo '    DKR_REGISTRY_API_PROTOCOL=$(DKR_REGISTRY_API_PROTOCOL)'
	@echo '    DKR_REGISTRY_API_URI=$(DKR_REGISTRY_API_URI)'
	@echo '    DKR_REGISTRY_API_VERSION=$(DKR_REGISTRY_API_VERSION)'
	@echo '    DKR_REGISTRY_CNAME=$(DKR_REGISTRY_CNAME)'
	@echo '    DKR_REGISTRY_NAME=$(DKR_REGISTRY_NAME)'
	@echo '    DKR_REGISTRY_NO_TRUNC=$(DKR_REGISTRY_NO_TRUNC)'
	@echo '    DKR_REGISTRY_PASSWORD_STDIN=$(DKR_REGISTRY_PASSWORD_STDIN)'
	@echo '    DKR_REGISTRY_REGISTRYCONFIG_DIRPATH=$(DKR_REGISTRY_REGISTRYCONFIG_DIRPATH)'
	@echo '    DKR_REGISTRY_REGISTRYCONFIG_FILENAME=$(DKR_REGISTRY_REGISTRYCONFIG_FILENAME)'
	@echo '    DKR_REGISTRY_REGISTRYCONFIG_FILEPATH=$(DKR_REGISTRY_REGISTRYCONFIG_FILEPATH)'
	@echo '    DKR_REGISTRY_REPOSITORY_NAME=$(DKR_REGISTRY_REPOSITORY_NAME)'
	@echo '    DKR_REGISTRY_REPOSITORY_URI=$(DKR_REGISTRY_REPOSITORY_URI)'
	@echo '    DKR_REGISTRY_SEARCH_FILTER=$(DKR_REGISTRY_SEARCH_FILTER)'
	@echo '    DKR_REGISTRY_SEARCH_LIMIT=$(DKR_REGISTRY_SEARCH_LIMIT)'
	@echo '    DKR_REGISTRY_USER_PASSWORD=$(DKR_REGISTRY_USER_PASSWORD)'
	@echo '    DKR_REGISTRY_USER_NAME=$(DKR_REGISTRY_USER_NAME)'
	@echo

_dkr_list_targets ::
	@echo 'DocKeR::Registry ($(_DOCKER_REGISTRY_MK_VERSION)) targets:'
	@echo '    _dkr_login_registry                     - Log in a Docker registry'
	@echo '    _dkr_logout_registry                    - Log out of a Docker registry'
	@echo '    _dkr_run_registry                       - Run a local registry'
	@echo '    _dkr_search_registry                    - Crawl Docker Hub for images whose name match'
	@echo '    _dkr_show_registry                      - Show everything related to a registry'
	@echo '    _dkr_show_registry_config               - Show the config for a registry'
	@echo '    _dkr_show_registry_repositories         - Show the repositories in a registry'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dkr_login_registry:
	@$(INFO) '$(DKR_UI_LABEL)Logging in registry "$(DKR_REGISTRY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation logs you in at the given URI (ex: https://index.docker.io/v1/)'; $(NORMAL)
	@$(WARN) 'Make sure the same URI (API version, etc) is being used by the other operations'; $(NORMAL)
	$(DOCKER) login $(__DKR_PASSWORD) $(__DKR_PASSWORD_STDIN) $(__DKR_USERNAME) $(DKR_REGISTRY_API_URI)
	[ ! -f $(DKR_REGISTRY_REGISTRYCONFIG_FILEPATH) ] || cat $(DKR_REGISTRY_REGISTRYCONFIG_FILEPATH)

_dkr_logout_registry:
	@$(INFO) '$(DKR_UI_LABEL)Logging out of registry "$(DKR_REGISTRY_NAME)" ...'; $(NORMAL)
	$(DOCKER) logout $(DKR_REGISTRY_API_URI)
	[ ! -f $(DKR_REGISTRY_REGISTRYCONFIG_FILEPATH) ] || cat $(DKR_REGISTRY_REGISTRYCONFIG_FILEPATH)

_dkr_run_registry: 
	@$(INFO) '$(DKR_UI_LABEL)Starting a local registry "$(DKR_REGISTRY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Docs available at https://docs.docker.com/registry/configuration/'; $(NORMAL)
	$(DOCKER) run -d -p 5000:5000 --restart=always --name registry -v `pwd`/config.yml:/etc/docker/registry/config.yml registry:2

_dkr_search_registry:
	@$(INFO) '$(DKR_UI_LABEL)Searching registry "$(DKR_REGISTRY_NAME)" for repositories ...'; $(NORMAL)
	@$(WARN) 'This operation seems to be reading the repo-names from a local cache. May not reflect all existing repos!'; $(NORMAL)
	$(DOCKER) search $(__DKR_FILTER__REGISTRY) $(__DKR_FORMAT__REGISTRY) $(__DKR_LIMIT) $(__DKR_NO_TRUNC) $(DKR_REGISTRY_SEARCH_EXPRESSION)
	@$(WARN) 'On DockerHub, repository-names are username/repo_id'; $(NORMAL)
	@$(WARN) 'On DockerHub, repository-uris are docker.io/username/repo_id'; $(NORMAL)

_DKR_SHOW_REGISTRY_TARGETS?= _dkr_show_registry_config  _dkr_show_registry_repositories
_dkr_show_registry: $(_DKR_SHOW_REGISTRY_TARGETS)

_dkr_show_registry_config:
	@$(INFO) '$(DKR_UI_LABEL)Showing config for registry "$(DKR_REGISTRY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This registry-config file is created by the docker-login command directed at the proper registry'; $(NORMAL)
	@$(WARN) 'The auths section includes an entry for each of the registriies you previously successfully accessed'; $(NORMAL)
	@$(WARN) 'Beware, logins may use helper command-line utilities that are OS and system specific'; $(NORMAL)
	-cat $(DKR_REGISTRY_REGISTRYCONFIG_FILEPATH)

_dkr_show_registry_repositories:
	@$(INFO) '$(DKR_UI_LABEL)Showing repositories in registry "$(DKR_REGISTRY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if credentials are required and not provided'; $(NORMAL)
	curl -s -X GET $(DKR_REGISTRY_API_URI)/_catalog | jq -r '.repositories[]'  | sort
