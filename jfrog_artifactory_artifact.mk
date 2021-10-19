_JFRGO_ARTIFCACTORY_ARTIFACT_MK_VERSION= $(_JFROG_ARTIFACTORY_MK_VERSION)

# JFG_ARTIFACT_LOCAL_SOURCEPATH?= "build/*.zip"
# JFG_ARTIFACT_LOCAL_TARGETPATH?= repository/repository_path
# JFG_ARTIFACT_FILEPATH?= ./tarball.tgz
# JFG_ARTIFACT_NAME?= tarball.tgz
# JFG_ARTIFACT_REPOSITORY_SOURCEPATH?= "build/*.zip"
# JFG_ARTIFACT_REPOSITORY_TARGETPATH?= repository/repository_path

# Derived parameters
JFG_ARTIFACT_LOCAL_SOURCEPATH?= $(JFG_ARTIFACT_FILEPATH)
JFG_ARTIFACT_LOCAL_TARGETPATH?= $(JFG_ARTIFACT_LOCAL_SOURCEPATH)
JFG_ARTIFACT_REPOSITORY__TARGETPATH?= $(JFG_ARTIFACT_REPOSITORY_SOURCEPATH)

# Option parameters
__JFG_EXCLUDE_PATTERNS=
__JFG_REGEXP=

# UI variables

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_jfg_view_framework_macros ::
	@echo 'JFroG::Artifactory::Artifact ($(_JFROG_ARTIFACTORY_ARTIFACT_MK_VERSION)) macros:' 
	@echo

_jfg_view_framework_parameters ::
	@echo 'JFroG::Artifactory::Artifact ($(_JFROG_ARTIFACTORY_ARTIFACT_MK_VERSION)) parameters:'
	@echo '    JFG_ARTIFACT_LOCAL_SOURCEPATH=$(JFG_ARTIFACT_LOCAL_SOURCEPATH)'
	@echo '    JFG_ARTIFACT_LOCAL_TARGETPATH=$(JFG_ARTIFACT_LOCAL_TARGETPATH)'
	@echo '    JFG_ARTIFACT_FILEPATH=$(JFG_ARTIFACT_FILEPATH)'
	@echo '    JFG_ARTIFACT_NAME=$(JFG_ARTIFACT_NAME)'
	@echo '    JFG_ARTIFACT_REPOSITORY_SOURCEPATH=$(JFG_ARTIFACT_REPOSITORY_SOURCEPATH)'
	@echo '    JFG_ARTIFACT_REPOSITORY_TARGETPATH=$(JFG_ARTIFACT_REPOSITORY_TARGETPATH)'
	@echo

_jfg_view_framework_targets ::
	@echo 'JFroG::Artifactory::Artifact ($(_JFROG_ARTIFACTORY_ARTIFACT_MK_VERSION)) targets:' 
	@echo '    _jfg_download_artifact             - download an artifact'
	@echo '    _jfg_remotecopy_artifact           - remote-copy an artifact within artifactory'
	@echo '    _jfg_upload_artifact               - upload an artifact'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_jfg_download_artifact:
	@$(INFO) '$(JFG_UI_LABEL)downloading artifact "$(JFG_ARTIFACT_NAME)" ...'; $(NORMAL)
	jfrog rt download $(__JFG_EXCLUDE_PATTERNS) $(__JFG_REGEXP) $(JFG_ARTIFACT_REPOSITORY_SOURCEPATH) $(JFG_ARTIFACT_LOCAL_TARGETPATH)

_jfg_remotecopy_artifact:
	@$(INFO) '$(JFG_UI_LABEL)Remote-copying artifact "$(JFG_ARTIFACT_NAME)" ...'; $(NORMAL)
	jfrog rt copy $(__JFG_EXCLUDE_PATTERNS) $(__JFG_REGEXP) $(JFG_ARTIFACT_REPOSITORY_SOURCEPATH) $(JFG_ARTIFACT_REPOSITORY_TARGETPATH)

_jfg_upload_artifact:
	@$(INFO) '$(JFG_UI_LABEL)Uploading artifact "$(JFG_ARTIFACT_NAME)" ...'; $(NORMAL)
	jfrog rt upload $(__JFG_EXCLUDE_PATTERNS) $(__JFG_REGEXP) $(JFG_ARTIFACT_LOCAL_SOURCEPATH) $(JFG_ARTIFACT_REPOSITORY_TARGETPATH)
