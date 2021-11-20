_MAVEN_ARTIFACT_MK_VERSION= $(_MAVEN_MK_VERSION)

# MVN_ARTIFACT_DIRPATH?= ./target/
# MVN_ARTIFACT_FAMILY_NAME?= artifact
# MVN_ARTIFACT_FILENAME?= artifact-0.0.1-SNAPSHOT.jar
# MVN_ARTIFACT_FILEPATH?= ./target/artifact-0.0.1-SNAPSHOT.jar
# MVN_ARTIFACT_NAME?= artifact-0.0.1-SNAPSHOT
# MVN_ARTIFACT_PROJECT_NAME?= project
MVN_ARTIFACT_TYPE?= jar
# MVN_ARTIFACT_URL?= http://localhost:8080/my/path
MVN_ARTIFACT_VERSION?= 0.0.1-SNAPSHOT
# MVN_ARTIFACTS_DIRPATH?= ./target/
# MVN_ARTIFACTS_PROJECT_DIRPATH?= ./
# MVN_ARTIFACTS_PROJECT_NAME?= project
# MVN_ARTIFACTS_REGEX?= *.jar
# MVN_ARTIFACTS_SET_NAME?= *.jar

# Derived parameters
MVN_ARTIFACT_DIRPATH?= $(MVN_ARTIFACTS_DIRPATH)
MVN_ARTIFACT_FAMILY_NAME?= $(MVN_ARTIFACT_PROJECT_NAME)
MVN_ARTIFACT_FILENAME?= $(MVN_ARTIFACT_NAME).jar
MVN_ARTIFACT_FILEPATH?= $(MVN_ARTIFACT_DIRPATH)$(MVN_ARTIFACT_FILENAME)
MVN_ARTIFACT_NAME?= $(MVN_ARTIFACT_FAMILY_NAME)-$(MVN_ARTIFACT_VERSION)
MVN_ARTIFACT_PROJECT_NAME?= $(MVN_ARTIFACTS_PROJECT_NAME)
MVN_ARTIFACTS_DIRPATH?= $(MVN_ARTIFACTS_PROJECT_DIRPATH)target/
MVN_ARTIFACTS_PROJECT_DIRPATH?= $(MVN_PROJECT_DIRPATH)
MVN_ARTIFACTS_PROJECT_NAME?= $(MVN_PROJECT_NAME)

# Options

# Customizations

# Macros

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _mvn_list_macros
_mvn_list_macros ::
	@#echo 'MaVeN::Artifact ($(_MAVEN_ARTIFACT_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _mvn_list_parameters
_mvn_list_parameters ::
	@echo 'MaVeN::Artifact ($(_MAVEN_ARTIFACT_MK_VERSION)) parameters:'
	@echo '    MVN_ARTIFACT_DIRPATH=$(MVN_ARTIFACT_DIRPATH)'
	@echo '    MVN_ARTIFACT_FAMILY_NAME=$(MVN_ARTIFACT_FAMILY_NAME)'
	@echo '    MVN_ARTIFACT_FILENAME=$(MVN_ARTIFACT_FILENAME)'
	@echo '    MVN_ARTIFACT_FILEPATH=$(MVN_ARTIFACT_FILEPATH)'
	@echo '    MVN_ARTIFACT_NAME=$(MVN_ARTIFACT_NAME)'
	@echo '    MVN_ARTIFACT_PROJECT_NAME=$(MVN_ARTIFACT_PROJECT_NAME)'
	@echo '    MVN_ARTIFACT_URL=$(MVN_ARTIFACT_URL)'
	@echo '    MVN_ARTIFACT_VERSION=$(MVN_ARTIFACT_VERSION)'
	@echo '    MVN_ARTIFACTS_DIRPATH=$(MVN_ARTIFACTS_DIRPATH)'
	@echo '    MVN_ARTIFACTS_PROJECT_DIRPATH=$(MVN_ARTIFACTS_PROJECT_DIRPATH)'
	@echo '    MVN_ARTIFACTS_PROJECT_NAME=$(MVN_ARTIFACTS_PROJECT_NAME)'
	@echo '    MVN_ARTIFACTS_REGEX=$(MVN_ARTIFACTS_REGEX)'
	@echo '    MVN_ARTIFACTS_SET_NAME=$(MVN_ARTIFACTS_SET_NAME)'
	@echo

_list_targets :: _mvn_list_targets
_mvn_list_targets ::
	@echo 'MaVeN::Artifact ($(_MAVEN_ARTIFACT_MK_VERSION)) targets:'
	@echo '    _mvn_build_artifacts             - Build artifacts'
	@echo '    _mvn_delete_artifacts            - Delete artifacts'
	@echo '    _mvn_list_artifacts              - List all artifacts'
	@echo '    _mvn_list_artifacts_set          - List a set of artifacts'
	@echo '    _mvn_run_artifact                - Run a artifact'
	@echo '    _mvn_show_artifact               - Show everything related to an artifact'
	@echo '    _mvn_show_artifact_dependencies  - Show the dependencies of an artifact'
	@echo '    _mvn_show_artifact_description   - Show the description of an artifact'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mvn_build_artifact: _mvn_build_artifacts
_mvn_build_artifacts:
	@$(INFO) '$(MVN_UI_LABEL)Buildings one-or-more artifacts ...'; $(NORMAL)
	@$(WARN) 'This operation first download missing dependencies from maven central in the local repository'; $(NORMAL)
	$(MVN) clean package

_mvn_curl_artifact:
	@$(INFO) '$(MVN_UI_LABEL)Curl-ing artifact "$(MVN_ARTIFACT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the artifact is not already running!'; $(NORMAL)
	curl $(MVN_ARTIFACT_URL)

_mvn_delete_artifact: _mvn_delete_artifacts
_mvn_delete_artifacts: 
	@$(INFO) '$(MVN_UI_LABEL)Deleting one-or-more artifacts ...'; $(NORMAL)
	$(MVN) clean

_mvn_list_artifacts:
	@$(INFO) '$(MVN_UI_LABEL)Listing all artifacts ...'; $(NORMAL)
	tree -l $(MVN_ARTIFACTS_DIRPATH)

_mvn_list_artifacts_set:
	@$(INFO) '$(MVN_UI_LABEL)Listing artifacts-set "$(MVN_ARTIFACTS_SET_NAME)" ...'; $(NORMAL)
	tree -l $(MVN_ARTIFACTS_DIRPATH)

_mvn_run_artifact:
	@$(INFO) '$(MVN_UI_LABEL)Running artifact "$(MVN_ARTIFACT_NAME)" ...'; $(NORMAL)
	java -jar $(MVN_ARTIFACT_FILEPATH)

_MVN_SHOW_ARTIFACT_TARGETS?= _mvn_show_artifact_dependencies _mvn_show_artificat_description
_mvn_show_artifact: $(_MVN_SHOW_ARTIFACT_TARGETS)

_mvn_show_artifact_dependencies:
	@$(INFO) '$(MVN_UI_LABEL)Showing dependencies of artifact "$(KCL_ARTIFACT_NAME)" ...'; $(NORMAL)
	$(MVN) dependency:tree

_mvn_show_artifact_description:
	@$(INFO) '$(MVN_UI_LABEL)Showing description of artifact "$(KCL_ARTIFACT_NAME)" ...'; $(NORMAL)
	ls -al $(MVN_ARTIFACT_FILEPATH)

