_AWS_ELASTICBEANSTALK_APPLICATIONVERSION_MK_VERSION= $(_AWS_ELASTICBEANSTALK_MK_VERSION)

EBK_APPLICATIONVERSION_APPLICATION_AUTOCREATE?= false
# EBK_APPLICATIONVERSION_APPLICATION_NAME?= my-application
# EBK_APPLICATIONVERSION_DESCRIPTION?= "This is my application-version description"
# EBK_APPLICATIONVERSION_LABEL?= "Sample Application"
# EBK_APPLICATIONVERSION_SOURCEBUILD?= SourceType=string,SourceRepository=string,SourceLocation=string
# EBK_APPLICATIONVERSION_SOURCEBUNDLE?= S3Bucket="my-bucket",S3Key="sample.war"
RBK_APPLICATIONVERSION_SOURCEBUNDLE_AUTODELETE?= false

# Derived parameters
EBK_APPLICATIONVERSION_APPLICATION_NAME?= $(EBK_APPLICATION_NAME)

# Option parameters
__EBK_APPLICATION_NAME__APPLICATIONVERSION= $(if $(EBK_APPLICATIONVERSION_APPLICATION_NAME), --application-name $(EBK_APPLICATIONVERSION_APPLICATION_NAME))
__EBK_AUTOCREATE_APPLICATION= $(if $(filter true, $(EBK_APPLICATIONVERSION_APPLICATION_AUTOCREATE)), --auto-create-application, --no-auto-create-application)
__EBK_BUILD_CONFIGURATION=
__EBK_DELETE_SOURCE_BUNDLE= $(if $(filter true, $(EBK_APPLICATIONVERSION_SOURCEBUNDLE_AUTODELETE)), --delete-source-bundle, --no-delete-source-bundle)
__EBK_DESCRIPTION__APPLICATIONVERSION= $(if $(EBK_APPLICATIONVERSION_DESCRIPTION), --description $(EBK_APPLICATIONVERSION_DESCRIPTION))
__EBK_PROCESS=
__EBK_SOURCE_BUILD_INFORMATION= $(if $(EBK_APPLICATIONVERSION_SOURCEBUILD), --source-build-information $(EBK_APPLICATIONVERSION_SOURCEBUILD))=
__EBK_SOURCE_BUNDLE= $(if $(EBK_APPLICATIONVERSION_SOURCEBUNDLE), --source-bundle $(EBK_APPLICATIONVERSION_SOURCEBUNDLE))
__EBK_VERSION_LABEL= $(if $(EBK_APPLICATIONVERSION_LABEL), --version-label $(EBK_APPLICATIONVERSION_LABEL))

# UI parameters
EBK_UI_VIEW_APPLICATIONVERSIONS_FIELDS?= .{ApplicationName:ApplicationName,VersionLabel:VersionLabel,dateCreated:DateCreated,dateUpdated:DateUpdated,status:Status}
EBK_UI_VIEW_APPLICATIONVERSIONS_SET_FIELDS?= $(EBK_UI_VIEW_APPLICATIONVERSIONS_FIELDS)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ebk_view_framework_macros ::
	@echo 'AWS::ElasticBeanstalK::ApplicationVersion ($(_AWS_ELASTICBEANSTALK_APPLICATIONVERSION_MK_VERSION)) macros:'
	@echo

_ebk_view_framework_parameters ::
	@echo 'AWS::ElasticBeanstalK::ApplicationVersion ($(_AWS_ELASTICBEANSTALK_APPLICATIONVERSION_MK_VERSION)) parameters:'
	@echo '    EBK_APPLICATIONVERSION_APPLICATION_AUTOCREATE=$(EBK_APPLICATIONVERSION_APPLICATION_AUTOCREATE)'
	@echo '    EBK_APPLICATIONVERSION_APPLICATION_NAME=$(EBK_APPLICATIONVERSION_APPLICATION_NAME)'
	@echo '    EBK_APPLICATIONVERSION_DESCRIPTION=$(EBK_APPLICATIONVERSION_DESCRIPTION)'
	@echo '    EBK_APPLICATIONVERSION_LABEL=$(EBK_APPLICATIONVERSION_LABEL)'
	@echo '    EBK_APPLICATIONVERSION_SOURCEBUILD=$(EBK_APPLICATIONVERSION_SOURCEBUILD)'
	@echo '    EBK_APPLICATIONVERSION_SOURCEBUNDLE=$(EBK_APPLICATIONVERSION_SOURCEBUNDLE)'
	@echo '    EBK_APPLICATIONVERSION_SOURCEBUNDLE_AUTODELETE=$(EBK_APPLICATIONVERSION_SOURCEBUNDLE_AUTODELETE)'
	@echo

_ebk_view_framework_targets ::
	@echo 'AWS::ElasticBeanstalK::ApplicationVersion ($(_AWS_ELASTICBEANSTALK_APPLICATIONVERSION_MK_VERSION)) targets:'
	@echo '    _ebk_create_applicationversion             - Create application-version'
	@echo '    _ebk_delete_applicationversion             - Delete application-version'
	@echo '    _ebk_show_applicationversion               - Show everything related to an application-version'
	@echo '    _ebk_view_applicationversions              - View existing application-versions'
	@echo '    _ebk_view_applicationversions_set          - View a set of application-versions'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ebk_create_applicationversion:
	@$(INFO) '$(AWS_UI_LABEL)Creating version "$(EBK_APPLICATIONVERSION_LABEL)" for application "$(EBK_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk create-application-version $(__EBK_APPLICATION_NAME__APPLICATIONVERSION) $(__EBK_AUTOCREATE_APPLICATION) $(__EBK_BUILD_CONFIGURATION) $(__EBK_DESCRIPTION__APPLICATIONVERSION) $(__EBK_PROCESS) $(__EBK_SOURCE_BUILD_INFORMATION) $(__EBK_SOURCE_BUNDLE) $(__EBK_VERSION_LABEL)

_ebk_delete_applicationversion:
	@$(INFO) '$(AWS_UI_LABEL)Deleting application-version "$(EBK_APPLICATIONVERSION_LABEL)" of application "$(EBK_APPLICATIONVERSION_APPLICATION_NAME)"...'; $(NORMAL)
	$(AWS) elasticbeanstalk delete-application-version $(__EBK_APPLICATION_NAME__APPLICATIONVERSION) $(__EBK_DELETE_SOURCE_BUNDLE) $(__EBK_VERSION_LABEL)

_ebk_show_applicationversion:
	@$(INFO) '$(AWS_UI_LABEL)Showing application-version "$(EBK_APPLICATIONVERSION_LABEL)" of application "$(EBK_APPLICATIONVERSION_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-application-versions $(__EBK_APPLICATION_NAME__APPLICATIONVERSION) --version-labels $(EBK_APPLICATIONVERSION_LABEL)

_ebk_view_applicationversions:
	@$(INFO) '$(AWS_UI_LABEL)Viewing application-versions ...'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-application-versions $(__EBK_APPLICATION_NAME__APPLICATIONVERSION) $(_X__EBK_VERSION_LABELS) --query "ApplicationVersions[]$(EBK_UI_VIEW_APPLICATIONVERSIONS_FIELDS)"

_ebk_view_applicationversions_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing application-versions ...'; $(NORMAL)
	@$(WARN) 'Application-versions are grouped based on the provided version-labels'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-application-versions $(__EBK_APPLICATION_NAME__APPLICATIONVERSION) $(__EBK_VERSION_LABELS) --query "ApplicationVersions[]$(EBK_UI_VIEW_APPLICATIONVERSIONS_SET_FIELDS)"
