_AWS_SERVERLESSREPO_APPLICATION_MK_VERSION= $(_AWS_SERVERLESSREPO_MK_VERSION)

# SRO_APPLICATION_AUTHOR?=
# SRO_APPLICATION_DESCRIPTION?= "This is my serverless-app description"
# SRO_APPLICATION_HOMEPAGE_URL?= http://www.github.com/project
# SRO_APPLICATION_ID?= arn:aws:serverlessrepo:us-east-1:123456789012:applications/my-application
# SRO_APPLICATION_LABELS?=
# SRO_APPLICATION_LICENSE_BODY?=
# SRO_APPLICATION_LICENSE_URL?=
# SRO_APPLICATION_NAME?=
# SRO_APPLICATION_POLICY?= Actions=string,string,Principals=string,string,StatementId=string ...
# SRO_APPLICATION_POLICY_FILEPATH?=
# SRO_APPLICATION_README_BODY?=
# SRO_APPLICATION_README_URL?=
# SRO_APPLICATION_SEMANTIC_VERSION?= MAJOR.MINOR.PATCH
# SRO_APPLICATION_SOURCECODE_URL?=
# SRO_APPLICATION_SPDXLICENSE_IDL?=
# SRO_APPLICATION_TEMPLATE_BODY?=
# SRO_APPLICATION_TEMPLATE_URL?=

# Derived parameters
SRO_APPLICATION_POLICY?= $(if $(SRO_APPLICATION_POLICY_FILEPATH),file://$(SRO_APPLICATION_POLICY_FILEPATH))

# Option parameters
__SRO_APPLICATION_ID= $(if $(SRO_APPLICATION_ID), --application-id $(SRO_APPLICATION_ID))
__SRO_AUTHOR= $(if $(SRO_APPLICATION_AUTHOR), --author $(SRO_APPLICATION_AUTHOR))
__SRO_DESCRIPTION= $(if $(SRO_APPLICATION_DESCRIPTION), --description $(SRO_APPLICATION_DESCRIPTION))
__SRO_HOME_PAGE_URL= $(if $(SRO_APPLICATION_HOMEPAGE_URL), --home-page-url $(SRO_APPLICATION_HOMEPAGE_URL))
__SRO_LABELS= $(if $(SRO_APPLICATION_LABELS), --labels $(SRO_APPLICATION_LABELS))
__SRO_LICENSE_BODY= $(if $(SRO_APPLICATION_LICENSE_BODY), --license-body $(SRO_APPLICATION_LICENSE_BODY))
__SRO_LICENSE_URL= $(if $(SRO_APPLICATION_LICENSE_URL), --license-url $(SRO_APPLICATION_LICENSE_BODY))
__SRO_NAME__APPLICATION= $(if $(SRO_APPLICATION_NAME), --name $(SRO_APPLICATION_NAME))
__SRO_README_BODY= $(if $(SRO_APPLICATION_README_BODY), --readme-body $(SRO_APPLICATION_README_BODY))
__SRO_README_URL= $(if $(SRO_APPLICATION_README_URL), --readme-url $(SRO_APPLICATION_README_URL))
__SRO_SEMANTIC_VERSION= $(if $(SRO_APPLICATION_SEMANTIC_VERSION), --semantic-version $(SRO_APPLICATION_SEMANTIC_VERSION))
__SRO_SOURCE_CODE_URL= $(if $(SRO_APPLICATION_SOURCECODE_URL), --source-code-url $(SRO_APPLICATION_SOURCECODE_URL))
__SRO_STATEMENT= $(if $(SRO_APPLICATION_POLICY), --statement $(SRO_APPLICATION_POLICY))
__SRO_SPDX_LICENSE_ID= $(if $(SRO_APPLICATION_SPDXLICENSE_ID), --spdx-license-id $(SRO_APPLICATION_SPDXLICENSE_ID))
__SRO_TEMPLATE_BODY= $(if $(SRO_APPLICATION_TEMPLATE_BODY), --template-body $(SRO_APPLICATION_TEMPLATE_BODY))
__SRO_TEMPLATE_URL= $(if $(SRO_APPLICATION_TEMPLATE_URL), --template-url $(SRO_APPLICATION_TEMPLATE_URL))

# UI parameters
SRO_UI_VIEW_APPLICATIONS_FIELDS?= .{Name:Name,author:Author,spdxLicenseId:SpdxLicenseId,labels:Labels[]| join(' ',@)}
SRO_UI_VIEW_APPLICATIONS_SET_FIELDS?= $(SRO_UI_VIEW_APPLICATIONS_FIELDS)
SRO_UI_VIEW_APPLICATIONS_SET_SLICE?=

#--- Utilities

#--- MACROS
_sro_get_application_id= $(call _sro_get_application_id_N, $(SRO_APPLICATION_NAME))
_sro_get_application_id_N= $(shell echo "arn:aws:serverlessrepo:$(AWS_REGION):$(AWS_ACCOUNT_ID):applications/$(strip $(1))")

#----------------------------------------------------------------------
# USAGE
#

_sro_view_framework_macros ::
	@echo 'AWS::ServerlessRepO::Application ($(_AWS_SERVERLESSREPO_APPLICATION_MK_VERSION)) macros:'
	@echo '    _sro_get_application_id_{|N}                      - Get the ID of an application on a repository'
	@echo

_sro_view_framework_parameters ::
	@echo 'AWS::ServerlessRepO::Application ($(_AWS_SERVERLESSREPO_APPLICATION_MK_VERSION)) parameters:'
	@echo '    SRO_APPLICATION_AUTHOR=$(SRO_APPLICATION_AUTHOR)'
	@echo '    SRO_APPLICATION_DESCRIPTION=$(SRO_APPLICATION_DESCRIPTION)'
	@echo '    SRO_APPLICATION_HOMEPAGE_URL=$(SRO_APPLICATION_HOMEPAGE_URL)'
	@echo '    SRO_APPLICATION_ID=$(SRO_APPLICATION_ID)'
	@echo '    SRO_APPLICATION_LABELS=$(SRO_APPLICATION_LABELS)'
	@echo '    SRO_APPLICATION_LICENSE_BODY=$(SRO_APPLICATION_LICENSE_BODY)'
	@echo '    SRO_APPLICATION_LICENSE_URL=$(SRO_APPLICATION_LICENSE_URL)'
	@echo '    SRO_APPLICATION_NAME=$(SRO_APPLICATION_NAME)'
	@echo '    SRO_APPLICATION_POLICY=$(SRO_APPLICATION_POLICY)'
	@echo '    SRO_APPLICATION_POLICY_FILEPATH=$(SRO_APPLICATION_POLICY_FILEPATH)'
	@echo '    SRO_APPLICATION_README_BODY=$(SRO_APPLICATION_README_BODY)'
	@echo '    SRO_APPLICATION_README_URL=$(SRO_APPLICATION_README_URL)'
	@echo '    SRO_APPLICATION_SEMANTIC_VERSION=$(SRO_APPLICATION_SEMANTIC_VERSION)'
	@echo '    SRO_APPLICATION_SOURCECODE_URL=$(SRO_APPLICATION_SOURCECODE_URL)'
	@echo '    SRO_APPLICATION_SPDXLICENSE_ID=$(SRO_APPLICATION_SPDXLICENSE_ID)'
	@echo '    SRO_APPLICATION_TEMPLATE_BODY=$(SRO_APPLICATION_TEMPLATE_BODY)'
	@echo '    SRO_APPLICATION_TEMPLATE_URL=$(SRO_APPLICATION_TEMPLATE_URL)'
	@echo '    SRO_APPLICATIONS_SET_NAME=$(SRO_APPLICATIONS_SET_NAME)'
	@echo

_sro_view_framework_targets ::
	@echo 'AWS::ServerlessRepO::Application ($(_AWS_SERVERLESSREPO_APPLICATION_MK_VERSION)) targets:'A
	@echo '    _sro_create_application                           - Create a new application'
	@echo '    _sro_delete_application                           - Delete an existing application'
	@echo '    _sro_show_application                             - Show everything related to an application'
	@echo '    _sro_show_application_description                 - Show description of an application'
	@echo '    _sro_show_application_policy                      - Show policy of an application'
	@echo '    _sro_update_application                           - Update an application'
	@echo '    _sro_view_applications                            - View applications'
	@echo '    _sro_view_applications_set                        - View a set of applications'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sro_create_application:
	@$(INFO) '$(AWS_UI_LABEL)Creating application "$(SRO_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will fail if the application-name is already in use in this repo'; $(NORMAL)
	$(AWS) serverlessrepo create-application $(__SRO_AUTHOR) $(__SRO_DESCRIPTION) $(__SRO_HOME_PAGE_URL) $(__SRO_LABELS) $(__SRO_LICENSE_BODY) $(__SRO_LICENSE_URL) $(__SRO_NAME__APPLICATION) $(__SRO_README_BODY) $(__SRO_README_URL) $(__SRO_SEMANTIC_VERSION) $(__SRO_SOURCE_CODE_URL) $(__SRO_SPDX_LICENSE_ID) $(__SRO_TEMPLATE_BODY) $(__SRO_TEMPLATE_URL)

_sro_delete_application:
	@$(INFO) '$(AWS_UI_LABEL)Deleting application "$(SRO_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) serverlessrepo delete-application $(__SRO_APPLICATION_ID)

_sro_show_application: _sro_show_application_policy _sro_show_application_description

_sro_show_application_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of application "$(SRO_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) serverlessrepo get-application $(__SRO_APPLICATION_ID) $(__SRO_SEMANTIC_VERSION) # --query "ApplicationDescriptionSummary"

_sro_show_application_policy:
	@$(INFO) '$(AWS_UI_LABEL)Showing policy of application "$(SRO_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) serverlessrepo get-application-policy $(__SRO_APPLICATION_ID) # --query "ApplicationDescription.EnhancedMonitoring[]"

_sro_show_application_versions:
	@$(INFO) '$(AWS_UI_LABEL)Showing versions of application "$(SRO_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) serverlessrepo list-application-versions $(__SRO_APPLICATION_ID) # --query "ApplicationDescription.EnhancedMonitoring[]"

_sro_update_application_description:
	@$(INFO) '$(AWS_UI_LABEL)Updating description of application "$(SRO_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) serverlessrepo update-application $(__SRO_APPLICATION_ID) $(__SRO_AUTHOR) $(__SRO_DESCRIPTION) $(__SRO_HOME_PAGE_URL) $(__SRO_LABELS) $(__SRO_README_BODY) $(__SRO_README_URL)

_sro_update_applicaiton_policy:
	@$(INFO) '$(AWS_UI_LABEL)Updating policy of application "$(SRO_APPLICATION_NAME)" ...'; $(NORMAL)
	$(AWS) serverlessrepo put-application-policy $(__SRO_APPLICATION_ID) $(__SRO_STATEMENTS)

_sro_view_applications:
	@$(INFO) '$(AWS_UI_LABEL)Viewing applications ...'; $(NORMAL)
	@$(WARN) 'This operation only list applications owned by the requester!'; $(NORMAL)
	$(AWS) serverlessrepo list-applications --query "Applications[]$(SRO_UI_VIEW_APPLICATIONS_FIELDS)"

_sro_view_applications_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing applications-set "$(SRO_APPLICATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Applications are grouped based on the provided slice'; $(NORMAL)
	$(AWS) serverlessrepo list-applications --query "Applications[$(SRO_UI_VIEW_APPLICATIONS_SET_SLICE)]$(SRO_UI_VIEW_APPLICATIONS_FIELDS)"
