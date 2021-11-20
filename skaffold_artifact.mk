_SKAFFOLD_ARTIFACT_MK_VERSION= $(_SKAFFOLD_MK_VERSION)

# SFD_ARTIFACT_NAME?= my-artifact
# SFD_ARTIFACTS_APPLICATION_DIRPATH?= ./
# SFD_ARTIFACTS_CONFIG_DIRPATH?= ./
# SFD_ARTIFACTS_CONFIG_FILENAME?= skaffold.yaml
# SFD_ARTIFACTS_CONFIG_FILEPATH?= ./skaffold.yaml
# SFD_ARTIFACTS_CONFIG_NAME?= my-skaffold-config
# SFD_ARTIFACTS_PROFILE_NAME?= my-profile
# SFD_ARTIFACTS_REPOSITORY_NAME?= docker.io/library
# SFD_ARTIFACTS_SET_NAME?= ./src/skaffold-go

# Derived parameters
SFD_ARTIFACTS_APPLICATION_DIRPATH?= $(SFD_APPLICATION_DIRPATH)
SFD_ARTIFACTS_CONFIG_DIRPATH?= $(SFD_CONFIG_DIRPATH)
SFD_ARTIFACTS_CONFIG_FILENAME?= $(SFD_CONFIG_FILENAME)
SFD_ARTIFACTS_CONFIG_FILEPATH?= $(SFD_ARTIFACTS_CONFIG_DIRPATH)$(SFD_ARTIFACTS_CONFIG_FILENAME)
SFD_ARTIFACTS_CONFIG_NAME?= $(SFD_CONFIG_NAME)
SFD_ARTIFACTS_PROFILE_NAME?= $(SFD_PROFILE_NAME)
SFD_ARTIFACTS_REPOSITORY_NAME?= $(SFD_REPOSITORY_NAME)
SFD_ARTIFACTS_SET_NAME?= artifacts@$(SFD_ARTIFACTS_CONFIG_NAME)

# Options
__SFD_FILENAME__ARTIFACTS= $(if $(SFD_ARTIFACTS_CONFIG_FILEPATH),--filename $(SFD_ARTIFACTS_CONFIG_FILEPATH))
__SFD_DEFAULT_REPO__ARTIFACTS= $(if $(SFD_ARTIFACTS_REPOSITORY_NAME),--default-repo $(SFD_ARTIFACTS_REPOSITORY_NAME))
__SFD_PROFILE__ARTIFACTS= $(if $(SFD_ARTIFACTS_PROFILE_NAME),--profile $(SFD_ARTIFACTS_PROFILE_NAME))

# Customizations
_SFD_CREATE_ARTIFACTS_|?= $(if $(SFD_ARTIFACTS_APPLICATION_DIRPATH),cd $(SFD_ARTIFACTS_APPLICATION_DIRPATH) && )#
_SFD_DELETE_ARTIFACTS_|?= $(_SFD_CREATE_ARTIFACTS_|)
|_SFD_CREATE_ARTIFACTS?= # > build_result.json

# Macros

#----------------------------------------------------------------------
# USAGE
#

_sfd_list_macros ::
	@#echo 'SkaFfolD::Artifact ($(_SKAFFOLD_ARTIFACT_MK_VERSION)) macros:'
	@#echo

_sfd_list_parameters ::
	@echo 'SkaFfolD::Artifact ($(_SKAFFOLD_ARTIFACT_MK_VERSION)) parameters:'
	@echo '    SFD_ARTIFACT_NAME=$(SFD_ARTIFACT_NAME)'
	@echo '    SFD_ARTIFACTS_APPLICATION_DIRPATH=$(SFD_ARTIFACTS_APPLICATION_DIRPATH)'
	@echo '    SFD_ARTIFACTS_CONFIG_DIRPATH=$(SFD_ARTIFACTS_CONFIG_DIRPATH)'
	@echo '    SFD_ARTIFACTS_CONFIG_FILENAME=$(SFD_ARTIFACTS_CONFIG_FILENAME)'
	@echo '    SFD_ARTIFACTS_CONFIG_FILEPATH=$(SFD_ARTIFACTS_CONFIG_FILEPATH)'
	@echo '    SFD_ARTIFACTS_CONFIG_NAME=$(SFD_ARTIFACTS_CONFIG_NAME)'
	@echo '    SFD_ARTIFACTS_PROFILE_NAME=$(SFD_ARTIFACTS_PROFILE_NAME)'
	@echo '    SFD_ARTIFACTS_REPOSITORY_NAME=$(SFD_ARTIFACTS_REPOSITORY_NAME)'
	@echo '    SFD_ARTIFACTS_SET_NAME=$(SFD_ARTIFACTS_SET_NAME)'
	@echo

_sfd_list_targets ::
	@echo 'SkaFfolD::Artifact ($(_SKAFFOLD_ARTIFACT_MK_VERSION)) targets:'
	@echo '    _sfd_build_artifacts                - Build one-or-more artifacts'
	@echo '    _sfd_delete_artifacts               - Delete one-or-more artifacts'
	@echo '    _sfd_list_artifacts                 - List artifacts'
	@echo '    _sfd_list_artifacts_set             - List set of artifacts'
	@echo '    _sfd_show_artifact                  - Show everything related to an artifact'
	@echo '    _sfd_show_artifact_description      - Show the description of an artifact'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sfd_build_artifact: _sfd_build_artifacts
_sfd_build_artifacts:
	@$(INFO) '$(SFD_UI_LABEL)Creating/Building one-or-more artifacts ...'; $(NORMAL)
	@$(WARN) 'This operation normally pushes the images to a docker registry'; $(NORMAL)
	@$(WARN) 'If using local-docker ascertain you are already logged in'; $(NORMAL)
	@$(WARN) 'If using minikube-kaniko ascertain the registry-config does not use helper-commands not available in kaniko'; $(NORMAL)
	$(_SFD_CREATE_ARTIFACTS_|)$(SKAFFOLD) build $(__SFD_DEFAULT_REPO__ARTIFACTS) $(__SFD_FILENAME__ARTIFACTS) $(__SFD_PROFILE__ARTIFACTS)$(|_SFD_CREATE_ARTIFACTS)

_sfd_delete_artifact: _sfd_delete_artifacts
_sfd_delete_artifacts:
	@$(INFO) '$(SFD_UI_LABEL)Deleting one-or-more artifacts ...'; $(NORMAL)
	# $(SKAFFOLD) delete

_sfd_list_artifacts:
	@$(INFO) '$(SFD_UI_LABEL)Listing ALL artifacts ...'; $(NORMAL)
	# $(SKAFFOLD)

_sfd_list_artifacts_set:
	@$(INFO) '$(SFD_UI_LABEL)Listing artifacts-set "$(SFD_ARTIFACTS_SET_NAME)" ...'; $(NORMAL)
	# $(SKAFFOLD)

_SFD_SHOW_ARTIFACT_TARGETS?= _sfd_show_artifact_description
_sfd_show_artifact: $(_SFD_SHOW_ARTIFACT_TARGETS)

_sfd_show_artifact_description:
	@$(INFO) '$(SFD_UI_LABEL)Showing description of artifact "$(SFD_ARTIFACT_NAME)" ...'; $(NORMAL)
	# $(SKAFFOLD)
