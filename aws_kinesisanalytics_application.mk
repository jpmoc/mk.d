_AWS_KINESISANALYTICS_APPLICATION_MK_VERSION= $(_AWS_KINESISANALYTICS_MK_VERSION)

# KAS_APPLICATION_CLOUDWATCH_OPTIONS?=
# KAS_APPLICATION_CODE?=
# KAS_APPLICATION_CREATION_TIMESTAMP?=
# KAS_APPLICATION_DESCRIPTION?=
# KAS_APPLICATION_INPUTS?=
# KAS_APPLICATION_NAME?=
# KAS_APPLICATION_OUTPUTS?=
# KAS_APPLICATIONS_NAMES?=
# KAS_APPLICATIONS_SET_NAME?=

# Derived parameters
KAS_APPLICATIONS_NAMES?= $(KAS_APPLICATION_NAME)

# Option parameters
__KAS_APPLICATION_CODE= $(if $(KAS_APPLICATION_CODE), --application-code $(KAS_APPLICATION_CODE))
__KAS_APPLICATION_DESCRIPTION= $(if $(KAS_APPLICATION_DESCRIPTION), --application-description $(KAS_APPLICATIONS_DESCRIPTION))
__KAS_APPLICATION_NAME= $(if $(KAS_APPLICATION_NAME), --application-name $(KAS_APPLICATION_NAME))
__KAS_CREATION_TIMESTAMP=
__KAS_CLOUD_WATCH_LOGGING_OPTIONS= $(if $(KAS_APPLICATION_CLOUDWATCH_OPTIONS), --cloud-watch-logging-options $(KAS_APPLICATION_CLOUDWATCH_OPTIONS))
__KAS_EXCLUSIVE_START_APPLICATION_NAME=
__KAS_INPUTS= $(if $(KAS_APPLICATION_INPUTS), --inputs $(KAS_APPLICATION_INPUTS))
__KAS_LIMIT__APPLICATION=
__KAS_OUTPUTS= $(if $(KAS_APPLICATION_OUTPUTS), --outputs $(KAS_APPLICATION_OUTPUTS))

# UI parameters
KAS_UI_VIEW_APPLICATIONS_FIELDS?=
KAS_UI_VIEW_APPLICATIONS_SET_FIELDS?= $(KAS_UI_VIEW_APPLICATIONS_FIELDS)
KAS_UI_VIEW_APPLICATIONS_SET_SLICE?=

#--- Utilities

#--- MACROS

_kas_get_application_id= $(call _kas_get_application_id_N, $(KAS_APPLICATION_NAME))
_kas_get_application_id_N= "$(shell $(AWS) kinesisanalytics list-applications --organization-id $(2) --query "Users[?Name=='$(strip $(1))'].Id" --output text)"

#----------------------------------------------------------------------
# USAGE
#

_kas_view_framework_macros ::
	@echo 'AWS::KinesisAnalyticS::Application ($(_AWS_KINESISANALYTICS_APPLICATION_MK_VERSION)) macros:'
	@echo '    _kas_get_application_id_{|N|NO}                     - Get the ID of a application (Name,OrganizationId)'
	@echo

_kas_view_framework_parameters ::
	@echo 'AWS::KinesisAnalyticS::Application ($(_AWS_KINESISANALYTICS_APPLICATION_MK_VERSION)) parameters:'
	@echo '    KAS_APPLICATION_AVAILABILITY_ZONE=$(KAS_APPLICATION_AVAILABILITY_ZONE)'
	@echo '    KAS_APPLICATION_LISTENERS=$(ELKASOADBALANCER_LISTENERS)'
	@echo '    KAS_APPLICATION_NAME=$(KAS_APPLICATION_NAME)'
	@echo '    KAS_APPLICATION_SCHEME=$(KAS_APPLICATION_SCHEME)'
	@echo '    KAS_APPLICATION_SECURITY_GROUPS=$(KAS_APPLICATION_SECURITY_GROUPS)'
	@echo '    KAS_APPLICATION_SUBNETS=$(KAS_APPLICATION_SUBNETS)'
	@echo '    KAS_APPLICATION_TAGS=$(KAS_APPLICATION_TAGS)'
	@echo '    KAS_APPLICATIONS_NAMES=$(KAS_APPLICATION_NAMES)'
	@echo '    KAS_APPLICATIONS_SET_NAME=$(KAS_APPLICATIONS_SET_NAME)'
	@echo

_kas_view_framework_targets ::
	@echo 'AWS::KinesisAnalyticS::Application ($(_AWS_KINESISANALYTICS_APPLICATION_MK_VERSION)) targets:'A
	@echo '    _kas_create_application                           - Create a new load-balancer'
	@echo '    _kas_delete_application                           - Delete an existing load-balancer'
	@echo '    _kas_show_application                             - Show everything related to a load-balancer'
	@echo '    _kas_show_application_description                 - Show description of a load-balancer'
	@echo '    _kas_view_applications                            - View load-balancers'
	@echo '    _kas_view_applications_set                        - View a set of load-balancers'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kas_create_application:
	@$(INFO) '$(AWS_UI_LABEL)Creating application "$(KAS_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) kinesisanalytics create-application $(__KAS_APPLICATION_CODE) $(__KAS_APPLICATION_DESCRIPTION) $(__KAS_APPLICATION_NAME) $(__KAS_CLOUD_WATCH_LOGGING_OPTIONS) $(__KAS_INPUTS) $(__KAS_OUTPUTS)

_kas_delete_application:
	@$(INFO) '$(AWS_UI_LABEL)Deleting application "$(KAS_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) kinesisanalytics delete-application $(__KAS_APPLICATION_NAME) $(__KAS_CREATE_TIMESTAMP)

_kas_show_application: _kas_show_application_description

_kas_show_application_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of application "$(KAS_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) kinesisanalytics describe-application $(__KAS_APPLICATION_NAME) # --query "Application"

_kas_view_applications:
	@$(INFO) '$(AWS_UI_LABEL)Viewing applications ...'; $(NORMAL)
	$(AWS) kinesisanalytics list-applications $(_X__KAS_EXCLUSIVE_START_APPLICATION_NAME) $(_X__KAS_LIMIT__APPLICATION) # --query "Applications[]$(KAS_UI_VIEW_APPLICATIONS_FIELDS)"

_kas_view_applications_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing applications-set "$(KAS_APPLICATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Applications are grouped based on the ... and slice'; $(NORMAL)
	$(AWS) kinesisanalytics list-applications $(__KAS_EXCLUSIVE_START_APPLICATION_NAME) $(__KAS_LIMIT__APPLICATION) # --query "Applications[$(KAS_UI_VIEW_APPLICATIONS_SET_SLICE)]$(KAS_UI_VIEW_APPLICATIONS_SET_FIELDS)"
