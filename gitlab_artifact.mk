_GITLAB_ARTIFACT_MK_VERSION= $(_GITLAB_MK_VERSION)

GLB_ARTIFACT_ARCHIVE_FILEPATH?= ./archive.tar.gz
GLB_ARTIFACT_BUILD_ID?= 0
# GLB_ARTIFACT_BUILD_TOKEN?=
# GLB_ARTIFACT_COMMIT_SHA?= v1.11.1
# GLB_ARTIFACT_COORDINATOR_URL?=
# GLB_ARTIFACT_FORMAT?=
GLB_ARTIFACT_MODE_VERBOSE?= true
GLB_ARTIFACT_NAME?= artifacts
# GLB_ARTIFACT_PATH?=
# GLB_ARTIFACT_PROJECT_ID?= 9316
# GLB_ARTIFACT_TYPE?=

# Derived parameters
GLB_ARTIFACT_COORDINATOR_URL?= $(GLB_RUNNER_COORDINATOR_URL)
GLB_ARTIFACT_PROJECT_ID?= $(GLB_PROJECT_ID)

# Option parameters
__GLB_ARTIFACT_FORMAT= $(if $(GLB_ARTIFACT_FORMAT),--artifact-format $(GLB_ARTIFACT_FORMAT))
__GLB_ARTIFACT_TYPE= $(if $(GLB_ARTIFACT_TYPE),--artifact-type $(GLB_ARTIFACT_TYPE))
__GLB_EXPIRE_IN=
__GLB_ID__ARTIFACT= $(if $(GLB_ARTIFACT_BUILD_ID),--id $(GLB_ARTIFACT_BUILD_ID))
__GLB_NAME__ARTIFACT= $(if $(GLB_ARTIFACT_NAME),--name $(GLB_ARTIFACT_NAME))
__GLB_PATH__ARTIFACT= $(if $(GLB_ARTIFACT_PATH),--path $(GLB_ARTIFACT_PATH))
__GLB_RETRY=
__GLB_RETRY_TIME=
__GLB_TLS_CA_FILE=
__GLB_TLS_CERT_FILE=
__GLB_TLS_KEY_FILE=
__GLB_TOKEN__ARTIFACT= $(if $(GLB_ARTIFACT_BUILD_TOKEN),--token $(GLB_ARTIFACT_BUILD_TOKEN))
__GLB_URL__ARTIFACT= $(if $(GLB_ARTIFACT_COORDINATOR_URL),--url $(GLB_ARTIFACT_COORDINATOR_URL))
__GLB_VERBOSE__ARTIFACT= $(if $(filter true,$(GLB_ARTIFACT_mODE_VERBOSE)),--verbose)

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_glb_view_framework_macros ::
	@echo 'GitLaB::Artifact ($(_GITLAB_ARTIFACT_MK_VERSION)) macros:'
	@echo

_glb_view_framework_parameters ::
	@echo 'GitLaB::Artifact ($(_GITLAB_ARTIFACT_MK_VERSION)) parameters:'
	@echo '    GLB_ARTIFACT_ARCHIVE_FILEPATH=$(GLB_ARTIFACT_ARCHIVE_FILEPATH)'
	@echo '    GLB_ARTIFACT_BUILD_ID=$(GLB_ARTIFACT_BUILD_ID)'
	@echo '    GLB_ARTIFACT_BUILD_TOKEN=$(GLB_ARTIFACT_BUILD_TOKEN)'
	@echo '    GLB_ARTIFACT_COMMIT_SHA=$(GLB_ARTIFACT_COMMIT_SHA)'
	@echo '    GLB_ARTIFACT_COORDINATOR_URL=$(GLB_ARTIFACT_COORDINATOR_URL)'
	@echo '    GLB_ARTIFACT_FORMAT=$(GLB_ARTIFACT_FORMAT)'
	@echo '    GLB_ARTIFACT_MODE_VERBOSE=$(GLB_ARTIFACT_MODE_VERBOSE)'
	@echo '    GLB_ARTIFACT_NAME=$(GLB_ARTIFACT_NAME)'
	@echo '    GLB_ARTIFACT_PATH=$(GLB_ARTIFACT_PATH)'
	@echo '    GLB_ARTIFACT_TYPE=$(GLB_ARTIFACT_TYPE)'
	@echo

_glb_view_framework_targets ::
	@echo 'GitLaB::Artifact ($(_GITLAB_ARTIFACT_MK_VERSION)) targets:'
	@echo '    _glb_download_artifact          - download an artifact'
	@echo '    _glb_upload_artifact            - upload an artifact'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_glb_download_artifact:
	@$(INFO) '$(GLB_UI_LABEL)Downloading artifact ...'; $(NORMAL)
	# $(GITLABRUNNER) artifacts-downloader $(__GLB_ID__ARTIFACT) $(__GLB_RETRY) $(__GLB_RETRY_TIME) $(__GLB_TLS_CA_FILE__ARTIFACT) $(__GLB_TLS_CERT_FILE) $(__GLB_TLS_KEY_FILE) $(__GLB_TOKEN__ARTIFACT) $(__GLB_URL__ARTIFACT)
	curl -H "PRIVATE-TOKEN: $(GLB_PROFILE_PRIVATE_TOKEN)" '$(GLB_PROFILE_API_URL)/projects/$(GLB_ARTIFACT_PROJECT_ID)/repository/archive.tar.gz?sha=$(GLB_ARTIFACT_COMMIT_SHA)' -o $(GLB_ARTIFACT_ARCHIVE_FILEPATH)
	ls -al $(GLB_ARTIFACT_ARCHIVE_FILEPATH)

_glb_upload_artifact:
	@$(INFO) '$(GLB_UI_LABEL)Uploading artifact ... "$(GLB_SERVICE_NAME)" ...'; $(NORMAL)
	$(GITLABRUNNER) artifacts-uploader $(__GLB_ARTIFACT_FORMAT) $(__GLB_ARTIFACT_TYPE) $(__GLB_EXPIRE_IN) $(__GLB_ID__ARTIFACT) $(__GLB_NAME__ARTIFACT) $(__GLB_PATH__ARTIFACT) $(__GLB_RETRY) $(__GLB_RETRY_TIME) $(__GLB_TLS_CA_FILE__ARTIFACT) $(__GLB_TLS_CERT_FILE) $(__GLB_TLS_KEY_FILE) $(__GLB_TOKEN__ARTIFACT) $(__GLB_UNTRACKED__ARTIFACT) $(__GLB_URL__ARTIFACT) $(__GLB_VERBOSE__ARTIFACT)
