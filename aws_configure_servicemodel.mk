_AWS_CONFIGURE_SERVICEMODEL_MK_VERSION= $(_AWS_CONFIGURE_MK_VERSION)

# CFE_SERVICEMODEL_CONTENT?=
# CFE_SERVICEMODEL_CONTENT_FILEPATH?=
# CFE_SERVICEMODEL_SERVICE_NAME?=

# Derived parameters
CFE_SERVICEMODEL_CONTENT?= $(if $(CFE_SERVICEMODEL_CONTENT_FILEPATH),file://$(CFE_SERVICEMODEL_CONTENT_FILEPATH))

# Option parameters
__CFE_SERVICE_MODEL?= $(if $(CFE_SERVICEMODEL_CONTENT), --service-model $(CFE_SERVICEMODEL_CONTENT))
__CFE_SERVICE_NAME?= $(if $(CFE_SERVICEMODEL_SERVICE_NAME), --service-name $(CFE_SERVICEMODEL_SERVICE_NAME))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cfe_view_framework_macros ::
	@echo 'AWS::ConFigurE::ServiceModel ($(_AWS_CONFIGURE_SERVICEMODEL_VERSION)) macros:'
	@echo

_cfe_view_framework_parameters ::
	@echo 'AWS::ConFigurE::ServiceModel ($(_AWS_CONFIGURE_SERVICEMODEL_VERSION)) parameters:'
	@echo '    CFE_SERVICEMODEL_CONTENT=$(CFE_SERVICEMODEL_CONTENT)'
	@echo '    CFE_SERVICEMODEL_CONTENT_FILEPATH=$(CFE_SERVICEMODEL_CONTENT_FILEPATH)'
	@echo '    CFE_SERVICEMODEL_SERVICE_NAME=$(CFE_SERVICEMODEL_SERVICE_NAME)'
	@echo

_cfe_view_framework_targets ::
	@echo 'AWS::ConFigurE::ServiceModel ($(_AWS_CONFIGURE_SERVICEMODEL_MK_VERSION)) targets:'
	@echo '    _cfe_create_servicemodel                    - Create an service-model'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cfe_create_servicemodel:
	@$(INFO) '$(CFE_UI_LABEL)Creating service-model "$(CFE_SERVICEMODEL_SERVICE_NAME)" ...'; $(NORMAL)
	$(AWS) configure add-model $(__CFE_SERVICE_MODEL) $(__CFE_SERVICE_NAME)
