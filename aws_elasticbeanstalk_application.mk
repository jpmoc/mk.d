_AWS_ELASTICBEANSTALK_APPLICATION_MK_VERSION= $(_AWS_ELASTICBEANSTALK_MK_VERSION)

# EBK_APPLICATION_ARN?= arn:aws:elasticbeanstalk:us-east-2:123456789012:application/my-application
# EBK_APPLICATION_DESCRIPTION?= "This is my application description"
# EBK_APPLICATION_NAME?=
# EBK_APPLICATION_NAMES?=
# EBK_APPLICATIONS_SET_NAME?= my-applications-set

# Derived parameters
EBK_APPLICATION_ARN?= arn:aws:elasticbeanstalk:$(AWS_REGION):$(AWS_ACCOUNT_ID):application/$(EBK_APPLICATION_NAME)
EBK_APPLICATION_NAMES?= $(EBK_APPLICATION_NAME)

# Option parameters
__EBK_APPLICATION_NAME= $(if $(EBK_APPLICATION_NAME), --application-name $(EBK_APPLICATION_NAME))
__EBK_APPLICATION_NAMES= $(if $(EBK_APPLICATION_NAMES), --application-names $(EBK_APPLICATION_NAMES))
__EBK_DESCRIPTION__APPLICATION= $(if $(EBK_APPLICATION_DESCRIPTION), --description $(EBK_APPLICATION_DESCRIPTION))
__TERMINATE_ENV_BY_FORCE=

# UI parameters
EBK_UI_VIEW_APPLICATIONS_FIELDS?= .{ApplicationName:ApplicationName,dateCreated:DateCreated,dateUpdated:DateUpdated}
EBK_UI_VIEW_APPLICATIONS_SET_FIELDS?= $(EBK_UI_VIEW_APPLICATIONS_FIELDS)

#--- MACROS
_ebk_get_applicaiton_arn= $(call _ebk_get_application_arn_N, $(EBK_APPLICATION_NAME))
_ebk_get_application_arn_N= $(shell echo arn:aws:elasticbeanstalk:$(AWS_REGION):$(AWS_ACCOUNT_ID):application/$(strip (1)))

#----------------------------------------------------------------------
# USAGE
#

_ebk_view_framework_macros ::
	@echo 'AWS::ElasticBeanstalK::Application ($(_AWS_ELASTICBEANSTALK_APPLICATION_MK_VERSION)) macros:'
	@echo

_ebk_view_framework_parameters ::
	@echo 'AWS::ElasticBeanstalK::Application ($(_AWS_ELASTICBEANSTALK_APPLICATION_MK_VERSION)) parameters:'
	@echo '    EBK_APPLICATION_ARN=$(EBK_APPLICATION_ARN)'
	@echo '    EBK_APPLICATION_DESCRIPTION=$(EBK_APPLICATION_DESCRIPTION)'
	@echo '    EBK_APPLICATION_NAME=$(EBK_APPLICATION_NAME)'
	@echo '    EBK_APPLICATION_NAMES=$(EBK_APPLICATION_NAMES)'
	@echo '    EBK_APPLICATIONS_SET_NAME=$(EBK_APPLICATIONS_SET_NAME)'
	@echo

_ebk_view_framework_targets ::
	@echo 'AWS::ElasticBeanstalK::Application ($(_AWS_ELASTICBEANSTALK_APPLICATION_MK_VERSION)) targets:'
	@echo '    _ebk_create_application             - Create application'
	@echo '    _ebk_delete_application             - Delete application'
	@echo '    _ebk_show_application               - Show everything related to an application'
	@echo '    _ebk_view_applications              - View existing applications'
	@echo '    _ebk_view_applications_set          - View a set of applications'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ebk_create_application:
	@$(INFO) '$(AWS_UI_LABEL)Creating application "$(EBK_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk create-application $(__EBK_APPLICATION_NAME) $(__EBK_DESCRIPTION__APPLICATION)

_ebk_delete_application:
	@$(INFO) '$(AWS_UI_LABEL)Deleting application "$(EBK_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Environments that use this application must first be deleted!'; $(NORMAL)
	$(AWS) elasticbeanstalk delete-application $(__EBK_APPLICATION_NAME) $(__EBK_TERMINATE_ENV_BY_FORCE)

_ebk_show_application:
	@$(INFO) '$(AWS_UI_LABEL)Showing application "$(EBK_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-applications --application-names $(EBK_APPLICATION_NAME) --query "Applications[]"

_ebk_view_applications:
	@$(INFO) '$(AWS_UI_LABEL)Viewing applications ...'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-applications $(_X__EBK_APPLICATION_NAMES) --query "Applications[]$(EBK_UI_VIEW_APPLICATIONS_FIELDS)"

_ebk_view_applications_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing applications-set "$(EBK_APPLICATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This group is defined based on the provided application names'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-applications $(__EBK_APPLICATION_NAMES) --query "Applications[]$(EBK_UI_VIEW_APPLICATIONS_SET_FIELDS)"
