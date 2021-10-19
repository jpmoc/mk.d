_AWS_CODEPIPELINE_ACTIONTYPE_MK_VERSION= $(_AWS_CODEPIPELINE_MK_VERSION)

# CPE_ACTIONTYPE_CATEGORY?= Build
# CPE_ACTIONTYPE_CONFIGURATION_PEROPERTIES?=
# CPE_ACTIONTYPE_INPUTARTIFACT_DETAILS?=
# CPE_ACTIONTYPE_NAME?=
# CPE_ACTIONTYPE_OWNER?= AWS
# CPE_ACTIONTYPE_OUTPUTARTIFACT_DETAILS?=
# CPE_ACTIONTYPE_PROVIDER?= CodeBuild
# CPE_ACTIONTYPE_VERSION?= 1
# CPE_ACTIONTYPES_OWNER?= AWS
# CPE_ACTIONTYPES_SET_NAME?= my-customactiontypes-set

# Derived parameters
CPE_ACTIONTYPE_NAME?= $(CPE_ACTIONTYPE_CATEGORY)-$(CPE_ACTIONTYPE_OWNER)-$(CPE_ACTIONTYPE_PROVIDER)-$(CPE_ACTIONTYPE_VERSION)
CPE_ACTIONTYPES_OWNER?= $(CPE_ACTIONTYPE_OWNER)

# Options parameters
__CPE_ACTION_OWNER_FILTER= $(if $(CPE_ACTIONTYPES_OWNER), --action-owner-filter $(CPE_ACTIONTYPES_OWNER))
__CPE_ACTION_VERSION= $(if $(CPE_ACTIONTYPE_VERSION), --action-version $(CPE_ACTIONTYPE_VERSION))
__CPE_CATEGORY= $(if $(CPE_ACTIONTYPE_CATEGORY), --category $(CPE_ACTIONTYPE_CATEGORY))
__CPE_CONFIGURATION_PROPERTIES= $(if $(CPE_ACTIONTYPE_CONFIGURATION_PROPERTIES), --configuration-properties $(CPE_ACTIONTYPE_CONFIGURATION_PROPERTIES))
__CPE_INPUT_ARTIFACT_DETAILS= $(if $(CPE_ACTIONTYPE_INPUTARTIFACT_DETAILS), --input-artifact-details $(CPE_ACTIONTYPE_INPUTARTIFACT_DETAILS))
__CPE_OUTPUT_ARTIFACT_DETAILS= $(if $(CPE_ACTIONTYPE_OUTPUTARTIFACT_DETAILS), --output-artifact-details $(CPE_ACTIONTYPE_OUTPUTARTIFACT_DETAILS))
__CPE_PROVIDER= $(if $(CPE_ACTIONTYPE_PROVIDER), --provider $(CPE_ACTIONTYPE_PROVIDER))
__CPE_SETTINGS__ACTIONTYPE= $(if $(CPE_ACTIONTYPE_SETTINGS), --settings $(CPE_ACTIONTYPE_SETTINGS))

# UI parameters
CPE_UI_VIEW_ACTIONTYPES_FIELDS?= .{Category:category,owner:owner,Provider:provider,Version:version}
CPE_UI_VIEW_ACTIONTYPES_SET_FIELDS?= $(CPE_UI_VIEW_ACTIONTYPES_FIELDS)
CPE_UI_VIEW_ACTIONTYPES_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cpe_view_makefile_macros ::
	@#echo 'AWS::CodePipelinE::ActionType ($(_AWS_CODEPIPELINE_ACTIONTYPE_MK_VERSION)) macros:'
	@#echo

_cpe_view_makefile_parameters ::
	@echo 'AWS::CodePipelinE::ActionType ($(_AWS_CODEPIPELINE_ACTIONTYPE_MK_VERSION)) parameters:'
	@echo '    CPE_ACTIONTYPE_CATEGORY=$(CPE_ACTIONTYPE_CATEGORY)'
	@echo '    CPE_ACTIONTYPE_CONFIGURATION_PROPERTIES=$(CPE_ACTIONTYPE_CONFIGURATION_PROPERTIES)'
	@echo '    CPE_ACTIONTYPE_INPUTARTIFACT_DETAILS=$(CPE_ACTIONTYPE_INPUTARTIFACT_DETAILS)'
	@echo '    CPE_ACTIONTYPE_NAME=$(CPE_ACTIONTYPE_NAME)'
	@echo '    CPE_ACTIONTYPE_OWNER=$(CPE_ACTIONTYPE_OWNER)'
	@echo '    CPE_ACTIONTYPE_OUTPUTARTIFACT_DETAILS=$(CPE_ACTIONTYPE_OUTPUTARTIFACT_DETAILS)'
	@echo '    CPE_ACTIONTYPE_PROVIDER=$(CPE_ACTIONTYPE_PROVIDER)'
	@echo '    CPE_ACTIONTYPE_SETTINGS=$(CPE_ACTIONTYPE_SETTINGS)'
	@echo '    CPE_ACTIONTYPE_VERSION=$(CPE_ACTIONTYPE_VERSION)'
	@echo '    CPE_ACTIONTYPES_OWNER=$(CPE_ACTIONTYPES_OWNER)'
	@echo '    CPE_ACTIONTYPES_SET_NAME=$(CPE_ACTIONTYPES_SET_NAME)'
	@echo

_cpe_view_makefile_targets ::
	@echo 'AWS::CodePipelinE::ActionType ($(_AWS_CODEPIPELINE_ACTIONTYPE_MK_VERSION)) targets:'
	@echo '    _cpe_create_actiontype              - Create a new (custom) action-type'
	@echo '    _cpe_delete_actiontype              - Delete an existing (custom) action-type'
	@echo '    _cpe_show_actiontype                - Show details of an action-type'
	@echo '    _cpe_view_actiontypes               - View existing action-types'
	@echo '    _cpe_view_actiontypes_set           - View a set of action-types'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cpe_create_actiontype:
	@$(INFO) '$(AWS_UI_LABEL)Creating action-type "$(CPE_ACTIONTYPE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Created action-types have a owner set to "Custom"'; $(NORMAL)
	$(AWS) codepipeline create-custom-action-type $(__CPE_ACTION_VERSION) $(__CPE_CATEGORY) $(__CPE_CONFIGURATION_PROPERTIES) $(__CPE_INPUT_ARTIFACT_DETAILS) $(__CPE_OUTPUT_ARTIFACT_DETAILS) $(__CPE_PROVIDER) $(__CPE_SETTINGS__ACTIONTYPE)

_cpe_delete_actiontype:
	@$(INFO) '$(AWS_UI_LABEL)Deleting action-type "$(CPE_ACTIONTYPE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Only custom action-types can be deleted'; $(NORMAL)
	$(AWS) codepipeline delete-custom-action-type $(__CPE_ACTION_VERSION) $(__CPE_CATEGORY) $(__CPE_PROVIDER)

_cpe_show_actiontype:
	@$(INFO) '$(AWS_UI_LABEL)Showing action-type "$(CPE_ACTIONTYPE_NAME)" ...'; $(NORMAL)
	$(AWS) codepipeline list-action-types $(_X__ACTION_OWNER_FILTER) --query "actionTypes[?id.category=='$(CPE_ACTIONTYPE_CATEGORY)'&&id.owner=='$(CPE_ACTIONTYPE_OWNER)'&&id.provider=='$(CPE_ACTIONTYPE_PROVIDER)'&&id.version=='$(CPE_ACTIONTYPE_VERSION)']"

_cpe_view_actiontypes:
	@$(INFO) '$(AWS_UI_LABEL)Viewing action-types ...'; $(NORMAL)
	$(AWS) codepipeline list-action-types $(_X__CPE_ACTION_OWNER_FILTER) --query "actionTypes[].id[]$(CPE_UI_VIEW_ACTIONTYPES_FIELDS)"

_cpe_view_actiontypes_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing action-types-set "$(CPE_ACTIONTYPES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Action-types are grouped based on the provided owner and slice'; $(NORMAL)
	$(AWS) codepipeline list-action-types $(__CPE_ACTION_OWNER_FILTER)  --query "actionTypes[$(CPE_UI_VIEW_ACTIONTYPE_SET_SLICE)]$(CPE_UI_VIEW_ACTIONTYPE_SET_FIELDS)"
