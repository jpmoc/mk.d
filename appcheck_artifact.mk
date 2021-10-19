_APPCHECK_ARTIFACT_MK_VERSION= $(_APPCHECK_MK_VERSION)

# ACK_ARTIFACT_API_URL?=
# ACK_ARTIFACT_FILEPATH?= ./artifacts/archive.tar
# ACK_ARTIFACT_GROUP_ID?= 4
# ACK_ARTIFACT_ID?= 97845
# ACK_ARTIFACT_NAME?= NSBU
# ACK_ARTIFACT_URL?= http://get.videolan.org/vlc/2.2.1/macosx/vlc-2.2.1.dmg
# ACK_ARTIFACTS_DIRPATH?= ./artifacts
# ACK_ARTIFACTS_SET_NAME?= my-artifacts-set

# Derived parameters
ACK_ARTIFACT_API_URL?= $(ACK_API_URL)
ACK_ARTIFACT_GROUP_ID?= $(ACK_GROUP_ID)
ACK_ARTIFACT_GROUP_NAME?= $(ACK_GROUP_NAME)
ACK_ARTIFACT_NAME?= $(notdir $(ACK_ARTIFACT_FILEPATH))

# Option parameters
__ACK_HEADERS__ARTIFACT+= $(if $(ACK_ARTIFACT_GROUP_ID),--header 'Group: $(ACK_ARTIFACT_GROUP_ID)')
__ACK_UPLOAD_FILE= $(if $(ACK_ARTIFACT_FILEPATH),--upload-file $(ACK_ARTIFACT_FILEPATH))

# Pipe parameters
|_ACK_FETCH_ARTIFACT?= | jq '.'
|_ACK_SHOW_ARTIFACT_UPLOAD?= | jq '.'
|_ACK_UPLOAD_ARTIFACT?= | jq '.'
|_ACK_VIEW_ARTIFACTS?= | jq '.'

# UI parameters
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ack_view_framework_macros ::
	@echo 'AppChecK::Artifact ($(_APPCHECK_ARTIFACT_MK_VERSION)) macros:'
	@echo

_ack_view_framework_parameters ::
	@echo 'AppChecK::Artifact ($(_APPCHECK_ARTIFACT_MK_VERSION)) parameters:'
	@echo '    ACK_ARTIFACT_API_URL=$(ACK_ARTIFACT_API_URL)'
	@echo '    ACK_ARTIFACT_FILEPATH=$(ACK_ARTIFACT_FILEPATH)'
	@echo '    ACK_ARTIFACT_GROUP_ID=$(ACK_ARTIFACT_GROUP_ID)'
	@echo '    ACK_ARTIFACT_NAME=$(ACK_ARTIFACT_NAME)'
	@echo '    ACK_ARTIFACT_URL=$(ACK_ARTIFACT_URL)'
	@echo '    ACK_ARTIFACTS_DIRPATH=$(ACK_ARTIFACTS_DIRPATH)'
	@echo

_ack_view_framework_targets ::
	@echo 'AppChecK::Artifact ($(_APPCHECK_ARTIFACT_MK_VERSION)) targets:'
	@echo '    _ack_fetch_artifact              - Fetch artifact'
	@echo '    _ack_show_artifact               - Show everything related to an artifact'
	@echo '    _ack_show_artifact_description   - Show description of artifact'
	@echo '    _ack_upload_artifact             - Upload an artifact'
	@echo '    _ack_view_artifacts              - View artifacts'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ack_fetch_artifact:
	@$(INFO) '$(ACK_UI_LABEL)Fetching artifact "$(ACK_ARTIFACT_NAME)" ...'; $(NORMAL)
	$(WARN) 'This operation fetch a remote artifact to store it locally!'; $(NORMAL)
	# $(APPCHECK) -s -X POST $(__ACK_HEADERS__SCAN) $(ACK_ARTIFACT_API_URL)/fetch/ $(|_ACK_FETCH_ARTIFACT)
	wget --output-document=$(ACK_ARTIFACT_FILEPATH) $(ACK_ARTIFACT_URL)

_ack_show_artifact: _ack_show_artifact_description

_ack_show_artifact_description:
	@$(INFO) '$(ACK_UI_LABEL)Show description of artifact "$(ACK_ARTIFACT_NAME)" ...'; $(NORMAL)
	ls -al $(ACK_ARTIFACT_FILEPATH)

_ack_upload_artifact:
	@$(INFO) '$(ACK_UI_LABEL)Uploading artifact "$(ACK_ARTIFACT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a meta.code'; $(NORMAL)
	@$(WARN) '  200: Upload successful and scan started'; $(NORMAL)
	@$(WARN) '  409: Application already being scanned'; $(NORMAL)
	$(APPCHECK) -X PUT $(__ACK_HEADERS__ARTIFACT) $(__ACK_UPLOAD_FILE) $(ACK_ARTIFACT_API_URL)/upload/ $(|_ACK_UPLOAD_ARTIFACT)

_ack_view_artifacts:
	@$(INFO) '$(ACK_UI_LABEL)View artifacts ...'; $(NORMAL)
	ls -al $(ACK_ARTIFACTS_DIRPATH)
