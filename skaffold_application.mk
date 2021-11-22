_SKAFFOLD_APPLICATION_MK_VERSION= $(_SKAFFOLD_MK_VERSION)

# SFD_APPLICATION_ARTIFACTS_DIRPATH?= ./in/build-artifacts.json
# SFD_APPLICATION_ARTIFACTS_FILENAME?= build-artifacts.json
# SFD_APPLICATION_ARTIFACTS_FILEPATH?= ./in/build-artifacts.json
# SFD_APPLICATION_CLEANUP_FLAG?= true
# SFD_APPLICATION_CONFIG_DIRPATH?= ./
# SFD_APPLICATION_CONFIG_FILENAME?= skaffold.yaml
# SFD_APPLICATION_CONFIG_FILEPATH?= ./skaffold.yaml
# SFD_APPLICATION_DIRPATH?= ./
# SFD_APPLICATION_IMAGE_TAGS?= ...
# SFD_APPLICATION_NAME?= my-name
# SFD_APPLICATION_NAMESPACE_NAME?= default
# SFD_APPLICATION_PROFILE_NAME?= my-profile
# SFD_APPLICATION_REPOSITORY_NAME?= docker.io/username
SFD_APPLICATION_TAIL_FLAG?= false
SFD_APPLICATION_TOOT_FLAG?= false
# SFD_APPLICATIONS_DIRPATH?= ./apps/
SFD_APPLICATIONS_REGEX?= *
# SFD_APPLICATIONS_SET_NAME?= my-set

# Derived parameters
SFD_APPLICATION_ARTIFACTS_DIRPATH?= $(SFD_INPUTS_DIRPATH)
SFD_APPLICATION_ARTIFACTS_FILEPATH?= $(if $(SFD_APPLICATION_ARTIFACTS_FILENAME),$(SFD_APPLICATION_ARTIFACTS_DIRPATH)$(SFD_APPLICATION_ARTIFACTS_FILENAME))
SFD_APPLICATION_CLEANUP_FLAG?= $(if $(filter true,$(SFD_MODE_DEBUG)),false,true)
SFD_APPLICATION_CONFIG_DIRPATH?= $(SFD_CONFIG_DIRPATH)
SFD_APPLICATION_CONFIG_FILENAME?= $(SFD_CONFIG_FILENAME)
SFD_APPLICATION_CONFIG_FILEPATH?= $(SFD_APPLICATION_CONFIG_DIRPATH)$(SFD_APPLICATION_CONFIG_FILENAME)
SFD_APPLICATION_DIRPATH?= $(if $(SFD_APPLICATIONS_DIRPATH),$(SFD_APPLICATIONS_DIRPATH)$(SFD_APPLICATION_NAME))
SFD_APPLICATION_KUBECONFIG_FILEPATH?= $(SFD_KUBECONFIG_FILEPATH)
SFD_APPLICATION_PROFILE_NAME?= $(SFD_PROFILE_NAME)
SFD_APPLICATION_REPOSITORY_NAME?= $(SFD_REPOSITORY_NAME)
SFD_APPLICATIONS_SET_NAME?= applications@$(SFD_APPLICATIONS_DIRPATH)

# Options
__SFD_BUILD_ARTIFACTS= $(if $(SFD_APPLICATION_ARTIFACTS_FILEPATH),--build-artifacts=$(SFD_APPLICATION_ARTIFACTS_FILEPATH))
__SFD_CLEANUP= $(if $(SFD_APPLICATION_CLEANUP_FLAG),--cleanup=$(SFD_APPLICATION_CLEANUP_FLAG))
__SFD_DEFAULT_REPO__APPLICATION= $(if $(SFD_APPLICATION_REPOSITORY_NAME),--default-repo $(SFD_APPLICATION_REPOSITORY_NAME))
__SFD_FILENAME__APPLICATION= $(if $(SFD_APPLICATION_CONFIG_FILEPATH),--filename $(SFD_APPLICATION_CONFIG_FILEPATH))
__SFD_IMAGE_TAG= $(if $(SFD_APPLICATION_IMAGES_TAGS),--image-tag $(SFD_APPLICATION_IMAGES_TAGS))
__SFD_KUBECONFIG__APPLICATION= $(if $(SFD_APPLICATION_KUBECONFIG_FILEPATH),--kubeconfig $(SFD_APPLICATION_KUBECONFIG_FILEPATH))
__SFD_NAMESPACE__APPLICATION= $(if $(SFD_APPLICATION_NAMESPACE_NAME),--namespace $(SFD_APPLICATION_NAMESPACE_NAME))
__SFD_PROFILE__APPLICATION= $(if $(SFD_APPLICATION_PROFILE_NAME),--profile $(SFD_APPLICATION_PROFILE_NAME))
__SFD_TAIL= $(if $(SFD_APPLICATION_TAIL_FLAG),--tail=$(SFD_APPLICATION_TAIL_FLAG))
__SFD_TOOT= $(if $(SFD_APPLICATION_TOOT_FLAG),--toot=$(SFD_APPLICATION_TOOT_FLAG))

# Customizations
_SFD_CREATE_APPLICATION_|?= $(_SFD_SHOW_APPLICATION_|)
_SFD_DEBUG_APPLICATION_|?= $(_SFD_CREATE_APPLICATION_|)
_SFD_DELETE_APPLICATION_|?= $(_SFD_CREATE_APPLICATION_|)
_SFD_DEPLOY_APPLICATION_|?= $(_SFD_CREATE_APPLICATION_|)
_SFD_DEVELOP_APPLICATION_|?= $(_SFD_CREATE_APPLICATION_|)
_SFD_LIST_APPLICATIONS_|?= cd $(SFD_APPLICATIONS_DIRPATH) && #
_SFD_LIST_APPLICATIONS_SET_|?= $(_SFD_LIST_APPLICATIONS_|)
_|_SFD_LIST_APPLICATIONS?=
_|_SFD_LIST_APPLICATIONS_SET?= $(_|_SFD_LIST_APPLICATIONS)
_SFD_SHOW_APPLICATION_|?= $(if $(SFD_APPLICATION_DIRPATH),cd $(SFD_APPLICATION_DIRPATH) && )#
_SFD_SHOW_APPLICATION_CONFIG_|?= $(_SFD_SHOW_APPLICATION_|)

# Macros

#----------------------------------------------------------------------
# USAGE
#

_sfd_list_macros ::
	@#echo 'SkaFfolD::Application ($(_SKAFFOLD_APPLICATION_MK_VERSION)) macros:'
	@#echo

_sfd_list_parameters ::
	@echo 'SkaFfolD::Application ($(_SKAFFOLD_APPLICATION_MK_VERSION)) parameters:'
	@echo '    SFD_APPLICATION_ARTIFACTS_DIRPATH=$(SFD_APPLICATION_ARTIFACTS_DIRPATH)'
	@echo '    SFD_APPLICATION_ARTIFACTS_FILENAME=$(SFD_APPLICATION_ARTIFACTS_FILENAME)'
	@echo '    SFD_APPLICATION_ARTIFACTS_FILEPATH=$(SFD_APPLICATION_ARTIFACTS_FILEPATH)'
	@echo '    SFD_APPLICATION_CLEANUP_FLAG=$(SFD_APPLICATION_CLEANUP_FLAG)'
	@echo '    SFD_APPLICATION_CONFIG_DIRPATH=$(SFD_APPLICATION_CONFIG_DIRPATH)'
	@echo '    SFD_APPLICATION_CONFIG_FILENAME=$(SFD_APPLICATION_CONFIG_FILENAME)'
	@echo '    SFD_APPLICATION_CONFIG_FILEPATH=$(SFD_APPLICATION_CONFIG_FILEPATH)'
	@echo '    SFD_APPLICATION_DIRPATH=$(SFD_APPLICATION_DIRPATH)'
	@echo '    SFD_APPLICATION_IMAGES_TAGS=$(SFD_APPLICATION_IMAGES_TAGS)'
	@echo '    SFD_APPLICATION_KUBECONFIG_FILEPATH=$(SFD_APPLICATION_KUBECONFIG_FILEPATH)'
	@echo '    SFD_APPLICATION_NAME=$(SFD_APPLICATION_NAME)'
	@echo '    SFD_APPLICATION_NAMESPACE_NAME=$(SFD_APPLICATION_NAMESPACE_NAME)'
	@echo '    SFD_APPLICATION_PROFILE_NAME=$(SFD_APPLICATION_PROFILE_NAME)'
	@echo '    SFD_APPLICATION_REPOSITORY_NAME=$(SFD_APPLICATION_REPOSITORY_NAME)'
	@echo '    SFD_APPLICATION_TAIL_FLAG=$(SFD_APPLICATION_TAIL_FLAG)'
	@echo '    SFD_APPLICATION_TOOT_FLAG=$(SFD_APPLICATION_TOOT_FLAG)'
	@echo '    SFD_APPLICATIONS_DIRPATH=$(SFD_APPLICATIONS_DIRPATH)'
	@echo '    SFD_APPLICATIONS_REGEX=$(SFD_APPLICATIONS_REGEX)'
	@echo '    SFD_APPLICATIONS_SET_NAME=$(SFD_APPLICATIONS_SET_NAME)'
	@echo

_sfd_list_targets ::
	@echo 'SkaFfolD::Application ($(_SKAFFOLD_APPLICATION_MK_VERSION)) targets:'
	@echo '    _sfd_create_application             - Create a new application'
	@echo '    _sfd_debug_application              - Debug an application'
	@echo '    _sfd_delete_application             - Delete an existing application'
	@echo '    _sfd_develop_application            - Develop an application'
	@echo '    _sfd_develop_application            - Develop an application'
	@echo '    _sfd_list_applications              - List all applications'
	@echo '    _sfd_list_applications_set          - List set of applications'
	@echo '    _sfd_show_application               - Show everything related to an application'
	@echo '    _sfd_show_application_description   - Show the description of an application'
	@echo '    _sfd_watch_applications             - Watch all applications'
	@echo '    _sfd_watch_applications_set         - Watch a set of applications'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sfd_create_application:
	@$(INFO) '$(SFD_UI_LABEL)Creating application "$(SFD_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation builds artifacts and deploy them'; $(NORMAL)
	@$(WARN) 'This operation normally pushes the artifacts to a registry which requires credentials or to be already logged-in'; $(NORMAL)
	@$(WARN) 'This operation prefixes the artifact-names with a default registry/repository'; $(NORMAL)
	@$(WARN) 'This operation deploys the artifact-names using a pre-configured clusters and provided manifests'; $(NORMAL)
	$(_SFD_CREATE_APPLICATION_|)$(SKAFFOLD) run $(__SFD_CLEANUP) $(__SFD_DEFAULT_REPO__APPLICATION) $(__SFD_FILENAME__APPLICATION) $(__SFD_NAMESPACE__APPLICATION) $(__SFD_PROFILE__APPLICATION) $(__SFD_TAIL) $(__SFD_TOOT)

_sfd_debug_application:
	@$(INFO) '$(SFD_UI_LABEL)Debugging application "$(SFD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(_SFD_DEBUG_APPLICATION_|)$(SKAFFOLD) debug $(__SFD_DEFAULT_REPO__APPLICATION) $(__SFD_FILENAME__APPLICATION) $(__SFD_NAMESPACE__APPLICATION) $(__SFD_PROFILE__APPLICATION)

_sfd_delete_application:
	@$(INFO) '$(SFD_UI_LABEL)Deleting application "$(SFD_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation un-deploy the application in the cluster'; $(NORMAL)
	@$(WARN) 'This operation does NOT interact with the already-built artifacts'; $(NORMAL)
	$(_SFD_DELETE_APPLICATION_|)$(SKAFFOLD) delete $(__SFD_FILENAME__APPLICATION) $(__SFD_NAMESPACE__APPLICATION) $(__SFD_PROFILE__APPLICATION)

_sfd_deploy_application:
	@$(INFO) '$(SFD_UI_LABEL)Deploying application "$(SFD_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation deploys the artifact-names using a pre-configured clusters and provided manifests'; $(NORMAL)
	@$(WARN) 'This operation updates the artifact-names with a default registry/repository if not provided'; $(NORMAL)
	$(if $(SFD_APPLICATION_ARTIFACTS_FILEPATH),cat $(SFD_APPLICATION_ARTIFACTS_FILEPATH))
	$(_SFD_DEPLOY_APPLICATION_|)$(SKAFFOLD) deploy $(__SFD_BUILD_ARTIFACTS) $(__SFD_DEFAULT_REPO__APPLICATION) $(__SFD_FILENAME__APPLICATION) $(__SFD_NAMESPACE__APPLICATION) $(__SFD_PROFILE__APPLICATION) $(__SFD_TAIL) $(__SFD_TOOT)

_sfd_develop_application:
	@$(INFO) '$(SFD_UI_LABEL)Develop application "$(SFD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(_SFD_DEVELOP_APPLICATION_|)$(SKAFFOLD) dev $(__SFD_CLEANUP) $(__SFD_DEFAULT_REPO__APPLICATION) $(__SFD_FILENAME__APPLICATION) $(__SFD_NAMESPACE__APPLICATION) $(__SFD_PROFILE__APPLICATION)

_sfd_list_applications:
	@$(INFO) '$(SFD_UI_LABEL)Listing ALL applications ...'; $(NORMAL)
	$(_SFD_LIST_APPLICATIONS_|)ls -ald * $(_|_SFD_LIST_APPLICATIONS)

_sfd_list_applications_set:
	@$(INFO) '$(SFD_UI_LABEL)Listing applications-set "$(SFD_APPLICATIONS_SET_NAME)" ...'; $(NORMAL)
	$(_SFD_LIST_APPLICATIONS_SET_|)ls -ald $(SFD_APPLICATIONS_REGEX)$(_|_SFD_LIST_APPLICATIONS)

_SFD_SHOW_APPLICATION_TARGETS?= _sfd_show_application_config _sfd_show_application_description
_sfd_show_application: $(_SFD_SHOW_APPLICATION_TARGETS)

_sfd_show_application_config:
	@$(INFO) '$(SFD_UI_LABEL)Showing config of application "$(SFD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(_SFD_SHOW_APPLICATION_CONFIG_|)$(SKAFFOLD) diagnose $(__SFD_FILENAME__APPLICATION) $(__SFD_PROFILE__APPLICATION)

_sfd_show_application_description:
	@$(INFO) '$(SFD_UI_LABEL)Showing description of application "$(SFD_APPLICATION_NAME)" ...'; $(NORMAL)

_sfd_undeploy_application: _sfd_delete_application

_sfd_watch_applications:
	@$(INFO) '$(SFD_UI_LABEL)Watching ALL applications ...'; $(NORMAL)

_sfd_watch_applications_set:
	@$(INFO) '$(SFD_UI_LABEL)Watching applications-set "$(SFD_APPLICATIONS_SET_NAME)" ...'; $(NORMAL)
