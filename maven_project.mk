_MAVEN_PROJECT_MK_VERSION= $(_MAVEN_MK_VERSION)

MVN_PROJECT_DIRPATH?= ./
# MVN_PROJECT_NAME?= my-project
# MVN_PROJECT_POM_DIRPATH?= ./
MVN_PROJECT_POM_FILENAME?= pom.xml
# MVN_PROJECT_POM_FILEPATH?= ./pom.xml
# MVN_PROJECT_ZIP_DIRPATH?= ./in/
# MVN_PROJECT_ZIP_FILENAME?= project.zip
# MVN_PROJECT_ZIP_FILEPATH?= ./in/project.zip
# MVN_PROJECT_UNZIP?= unzip
# MVN_PROJECTS_DIRPATH?= ../projects/
MVN_PROJECTS_REGEX?= .*
# MVN_PROJECTS_SET_NAME?= projects@dir

# Derived parameters
MVN_PROJECT_POM_DIRPATH?= $(MVN_PROJECT_DIRPATH)
MVN_PROJECT_POM_FILEPATH?= $(MVN_PROJECT_POM_DIRPATH)$(MVN_PROJECT_POM_FILENAME)
MVN_PROJECT_ZIP_DIRPATH?= $(INPUTS_DIRPATH)
MVN_PROJECT_ZIP_FILENAME?= $(if $(MVN_PROJECT_NAME),$(MVN_PROJECT_NAME).zip)
MVN_PROJECT_ZIP_FILEPATH?= $(MVN_PROJECT_ZIP_DIRPATH)$(MVN_PROJECT_ZIP_FILENAME)
MVN_PROJECT_UNZIP?= $(MVN_UNZIP)

# Options

# Customizations
_MVN_SHOW_PROJECT_EFFECTIVEPOM_|?=
_MVN_SHOW_PROJECT_POM_|?=
|_MVN_SHOW_PROJECT_EFFECTIVEPOM?= | head -10
|_MVN_SHOW_PROJECT_POM?= $(|_MVN_SHOW_PROJECT_EFFECTIVEPOM)

# Macros

#----------------------------------------------------------------------
# USAGE
#

_mvn_list_macros ::
	@#echo 'MaVeN::Project ($(_MAVEN_MK_VERSION)) macros:'
	@#echo

_mvn_list_parameters ::
	@echo 'MaVeN::Project ($(_MAVEN_PROJECT_MK_VERSION)) parameters:'
	@echo '    MVN_PROJECT_DIRPATH=$(MVN_PROJECT_DIRPATH)'
	@echo '    MVN_PROJECT_NAME=$(MVN_PROJECT_NAME)'
	@echo '    MVN_PROJECT_POM_DIRPATH=$(MVN_PROJECT_POM_DIRPATH)'
	@echo '    MVN_PROJECT_POM_FILENAME=$(MVN_PROJECT_POM_FILENAME)'
	@echo '    MVN_PROJECT_POM_FILEPATH=$(MVN_PROJECT_POM_FILEPATH)'
	@echo '    MVN_PROJECT_ZIP_DIRPATH=$(MVN_PROJECT_ZIP_DIRPATH)'
	@echo '    MVN_PROJECT_ZIP_FILENAME=$(MVN_PROJECT_ZIP_FILENAME)'
	@echo '    MVN_PROJECT_ZIP_FILEPATH=$(MVN_PROJECT_ZIP_FILEPATH)'
	@echo '    MVN_PROJECTS_DIRPATH=$(MVN_PROJECTS_DIRPATH)'
	@echo '    MVN_PROJECTS_REGEX=$(MVN_PROJECTS_REGEX)'
	@echo '    MVN_PROJECTS_SET_NAME=$(MVN_PROJECTS_SET_NAME)'
	@echo

_mvn_list_targets ::
	@echo 'MaVeN::Project ($(_MAVEN_PROJECT_MK_VERSION)) targets:'
	@echo '    _mvn_list_projects              - List all projects'
	@echo '    _mvn_list_projects_set          - List a set of projects'
	@echo '    _mvn_show_project               - Show everything related to a project'
	@echo '    _mvn_show_project_description   - Show the description of a project'
	@echo '    _mvn_show_project_effectivepom  - Show the effective POM file of a project'
	@echo '    _mvn_show_project_pom           - Show the POM file of a project'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mvn_list_projects:
	@$(INFO) '$(MVN_UI_LABEL)Listing ALL projects ...'; $(NORMAL)

_mvn_list_projects_set:
	@$(INFO) '$(MVN_UI_LABEL)Listing projects-set "$(MVN_PROJECTS_SET)" ...'; $(NORMAL)

_MVN_SHOW_PROJECT_TARGETS?= _mvn_show_project_dependencies _mvn_show_project_effectivepom _mvn_show_project_pom _mvn_show_project_description
_mvn_show_project: $(_MVN_SHOW_PROJECT_TARGETS)

_mvn_show_project_dependencies:
	@$(INFO) '$(MVN_UI_LABEL)Showing dependencies of project "$(MVN_PROJECT_NAME)" ...'; $(NORMAL)
	$(MVN) dependency:list

_mvn_show_project_description:
	@$(INFO) '$(MVN_UI_LABEL)Showing description of project "$(MVN_PROJECT_NAME)" ...'; $(NORMAL)

_mvn_show_project_effectivepom:
	@$(INFO) '$(MVN_UI_LABEL)Showing effective-pom-file of project "$(MVN_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The effective-pom-file is the aggregation of all pom.xml including the local pom, enterprise pom, and the super pom!'; $(NORMAL)
	$(_MVN_SHOW_PROJECT_EFFECTIVEPOM_|)$(MVN) help:effective-pom $(|_MVN_SHOW_PROJECT_EFFECTIVEPOM)

_mvn_show_project_pom:
	@$(INFO) '$(MVN_UI_LABEL)Showing pom-file of project "$(MVN_PROJECT_NAME)" ...'; $(NORMAL)
	$(_MVN_SHOW_PROJECT_POM_|)cat $(MVN_PROJECT_POM_FILEPATH) $(|_MVN_SHOW_PROJECT_POM)

_mvn_unzip_project:
	@$(INFO) '$(MVN_UI_LABEL)Unzipping project "$(MVN_PROJECT_NAME)" ...'; $(NORMAL)
	$(MVN_PROJECT_UNZIP) $(MVN_PROJECT_ZIP_FILEPATH)
