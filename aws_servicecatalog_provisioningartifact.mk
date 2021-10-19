_AWS_SERVICECATALOG_PROVISIONINGARTIFACT_MK_VERSION=$(_AWS_SERVICECATALOG_MK_VERSION)

# SCG_PROVISIONINGARTIFACT_DESCRIPTION?= "This is my provisioning-artifact description"
SCG_PROVISIONINGARTIFACT_ENABLE_FLAG?= true
# SCG_PROVISIONINGARTIFACT_ID?= pa-kja56xzyeucrw
# SCG_PROVISIONINGARTIFACT_NAME?= WordPress_v1.0
# SCG_PROVISIONINGARTIFACT_PARAMETERS_DIRPATH?= ./in/
# SCG_PROVISIONINGARTIFACT_PARAMETERS_FILENAME?= product_artifact.json
# SCG_PROVISIONINGARTIFACT_PARAMETERS_FILEPATH?= ./in/product_artifact.json
# SCG_PROVISIONINGARTIFACT_PARAMETERS_KEYVALUES?= Name=string,Description=string,Info={KeyName1=string,KeyName2=string},Type=string
# SCG_PROVISIONINGARTIFACT_PRODUCT_ID?= prod-3kgrq2rxelnzw
# SCG_PROVISIONINGARTIFACT_PRODUCT_NAME?= my-product
# SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_ID?= lpv2-tzez3kywvtt5c
# SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_NAME?= My_Launch_Path
# SCG_PROVISIONINGARTIFACTS_PRODUCT_ID?= prod-3kgrq2rxelnzw
# SCG_PROVISIONINGARTIFACTS_SET_NAME?= my-artifacts-set

# Derived parameters
SCG_PROVISIONINGARTIFACT_PARAMETERS_FILEPATH?= $(if $(SCG_PROVISIONINGARTIFACT_PARAMETERS_FILENAME), $(SCG_PROVISIONINGARTIFACT_PARAMETERS_DIRPATH)$(SCG_PROVISIONINGARTIFACT_PARAMETERS_FILENAME))
SCG_PROVISIONINGARTIFACT_PRODUCT_ID?= $(SCG_PRODUCT_ID)
SCG_PROVISIONINGARTIFACT_PRODUCT_NAME?= $(SCG_PRODUCT_NAME)
SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_ID?= $(SCG_PRODUCT_LAUNCHPATH_ID)
SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_NAME?= $(SCG_PRODUCT_LAUNCHPATH_NAME)
SCG_PROVISIONINGARTIFACTS_PRODUCT_ID?= $(SCG_PROVISIONINGARTIFACT_PRODUCT_ID)
SCG_PROVISIONINGARTIFACTS_SET_NAME?= artifacts@$(SCG_PROVISIONINGARTIFACT_PRODUCT_NAME)@$(SCG_PROVISIONINGARTIFACT_PRODUCT_ID)

# Options parameters
__SCG_ACTIVE= $(if $(filter false, $(SCG_PROVISIONARTIFACT_ENABLE_FALG)),--no-active,--active)
__SCG_DESCRIPTION__ARTIFACT= $(if $(SCG_PROVISIONINGARTIFACT_DESCRIPTION),--description '$(SCG_PROVISIONINGARTIFACT_DESCRIPTION)')
__SCG_NAME__PROVISIONINGARTIFACT= $(if $(SCG_PROVISIONINGARTIFACT_NAME),--name $(SCG_PROVISIONINGARTIFACT_NAME))
__SCG_PARAMETERS__PROVISIONINGARTIFACT+= $(if $(SCG_PROVISIONINGARTIFACT_PARAMETERS_FILEPATH),--parameters file://$(SCG_PROVISIONINGARTIFACT_PARAMETERS_FILEPATH))
__SCG_PARAMETERS__PROVISIONINGARTIFACT+= $(if $(SCG_PROVISIONINGARTIFACT_PARAMETERS_KEYVALUES),--parameters $(SCG_PROVISIONINGARTIFACT_PARAMETERS_KEYVALUES))
__SCG_PATH_ID__PROVISIONINGARTIFACT= $(if $(SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_ID),--path-id $(SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_ID))
__SCG_PATH_NAME__PROVISIONINGARTIFACT= $(if $(SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_NAME),--path-name $(SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_NAME))
__SCG_PRODUCT_ID__PROVISIONINGARTIFACT= $(if $(SCG_PROVISIONINGARTIFACT_PRODUCT_ID),--product-id $(SCG_PROVISIONINGARTIFACT_PRODUCT_ID))
__SCG_PRODUCT_ID__PROVISIONINGARTIFACTS= $(if $(SCG_PROVISIONINGARTIFACTS_PRODUCT_ID),--product-id $(SCG_PROVISIONINGARTIFACTS_PRODUCT_ID))
__SCG_PRODUCT_NAME__PROVISIONINGARTIFACT= $(if $(SCG_PROVISIONINGARTIFACT_PRODUCT_NAME),--product-name $(SCG_PROVISIONINGARTIFACT_PRODUCT_NAME))
__SCG_PROVISIONING_ARTIFACT_ID= $(if $(SCG_PROVISIONINGARTIFACT_ID),--provisioning-artifact-id $(SCG_PROVISIONINGARTIFACT_ID))
__SCG_PROVISIONING_ARTIFACT_NAME= $(if $(SCG_PROVISIONINGARTIFACT_NAME),--provisioning-artifact-name $(SCG_PROVISIONINGARTIFACT_NAME))
__SCG_PROVISIONING_ARTIFACT_PARAMETERS= $(if $(SCG_PROVISIONINGARTIFACT_PARAMETERS),--provisioning-artifact-parameters $(SCG_PROVISIONINGARTIFACT_PARAMETERS))

# UI parameters
SCG_UI_SHOW_PROVISIONINGARTIFACT_CONSTRAINTSUMMARIES_FIELDS?=
SCG_UI_SHOW_PROVISIONINGARTIFACT_OUTPUTS_FIELDS?=
SCG_UI_SHOW_PROVISIONINGARTIFACT_PARAMETERS_FIELDS?= .{ParameterKey:ParameterKey,ParameterType:ParameterType,defaultValue:DefaultValue,description:Description}
SCG_UI_SHOW_PROVISIONINGARTIFACT_TAGOPTIONS_FIELDS?=
SCG_UI_SHOW_PROVISIONINGARTIFACT_USAGEINSTRUCTIONS_FIELDS?=
SCG_UI_SHOW_PROVISIONINGARTIFACT_USAGEINSTRUCTIONS_SLICE?= ?Type!='metadata'
SCG_UI_VIEW_PROVISIONINGARTIFACTS_FIELDS?= .{Id:Id,Name:Name,description:Description,type:Type,active:Active,createdTime:CreatedTime}
SCG_UI_VIEW_PROVISIONINGARTIFACTS_SET_FIELDS?= $(SCG_UI_VIEW_PROVISIONINGARTIFACTS_FIELDS)
SCG_UI_VIEW_PROVISIONINGARTIFACTS_SET_SLICE?=
|_SCG_SHOW_PROVISIONINGARTIFACT_USAGEINSTRUCTIONS?= | jq '.'

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_scg_view_framework_macros ::
	@echo 'AWS::ServiceCataloG::ProvisioningArtifact ($(_AWS_SERVICECATALOG_PRODUCT_MK_VERSION)) macros:'
	@echo

_scg_view_framework_parameters ::
	@echo 'AWS::ServiceCataloG::ProvisioningArtifact ($(_AWS_SERVICECATALOG_PRODUCT_MK_VERSION)) parameters:'
	@echo '    SCG_PROVISIONINGARTIFACT_DESCRIPTION=$(SCG_PROVISIONINGARTIFACT_DESCRIPTION)'
	@echo '    SCG_PROVISIONONGARTIFACT_ENABLE_FLAG=$(SCG_PROVISIONINGARTIFACT_ENABLE_FLAG)'
	@echo '    SCG_PROVISIONINGARTIFACT_ID=$(SCG_PROVISIONINGARTIFACT_ID)'
	@echo '    SCG_PROVISIONINGARTIFACT_NAME=$(SCG_PROVISIONINGARTIFACT_NAME)'
	@echo '    SCG_PROVISIONINGARTIFACT_PARAMETERS=$(SCG_PROVISIONINGARTIFACT_PARAMETERS)'
	@echo '    SCG_PROVISIONINGARTIFACT_PARAMETERS_DIRPATH=$(SCG_PROVISIONINGARTIFACT_PARAMETERS_DIRPATH)'
	@echo '    SCG_PROVISIONINGARTIFACT_PARAMETERS_FILENAME=$(SCG_PROVISIONINGARTIFACT_PARAMETERS_FILENAME)'
	@echo '    SCG_PROVISIONINGARTIFACT_PARAMETERS_FILEPATH=$(SCG_PROVISIONINGARTIFACT_PARAMETERS_FILEPATH)'
	@echo '    SCG_PROVISIONINGARTIFACT_PRODUCT_ID=$(SCG_PROVISIONINGARTIFACT_PRODUCT_ID)'
	@echo '    SCG_PROVISIONINGARTIFACT_PRODUCT_NAME=$(SCG_PROVISIONINGARTIFACT_PRODUCT_NAME)'
	@echo '    SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_ID=$(SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_ID)'
	@echo '    SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_NAME=$(SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_NAME)'
	@echo '    SCG_PROVISIONINGARTIFACTS_PRODUCT_ID=$(SCG_PROVISIONINGARTIFACTS_PRODUCT_ID)'
	@echo '    SCG_PROVISIONINGARTIFACTS_SET_NAME=$(SCG_PROVISIONINGARTIFACTS_SET_NAME)'
	@echo

_scg_view_framework_targets ::
	@echo 'AWS::ServiceCataloG::ProvisioningArtifact ($(_AWS_SERVICECATALOG_PRODUCT_MK_VERSION)) targets:'
	@echo '    _scg_create_provisioningartifact                   - Create a provisioning-artifact'
	@echo '    _scg_delete_provisioningartifact                   - Delete a provisioning-artifact'
	@echo '    _scg_edit_provisioningartifact_parameters          - Edit parameters for a provisioning-artifact'
	@echo '    _scg_show_provisioningartifact                     - Show everything related to a provisioining-artifacts'
	@echo '    _scg_show_provisioningartifact_constraintsummaries - Show the constaint-summaries of a provisioining-artifacts'
	@echo '    _scg_show_provisioningartifact_description         - Show the description of a provisioining-artifacts'
	@echo '    _scg_show_provisioningartifact_outputs             - Show the outputs of a provisioning-artifact'
	@echo '    _scg_show_provisioningartifact_parameters          - Show the parameters of a provisioning-artifact'
	@echo '    _scg_show_provisioningartifact_tagoptions          - Show the tag-options of a provisioning-artifact'
	@echo '    _scg_show_provisioningartifact_template            - Show the template of a provisioning-artifact'
	@echo '    _scg_show_provisioningartifact_usageinstructions   - Show the usage-instructions of a provisioning-artifact'
	@echo '    _scg_update_provisioningartifact                   - Update a provisioining-artifact'
	@echo '    _scg_view_provisioningartifacts                    - View all provisioning-artifacts'
	@echo '    _scg_view_provisioningartifacts_set                - View a set of provisioning-artifacts'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_scg_create_provisioningartifact:
	@$(INFO) '$(SCG_UI_LABEL)Creating provisioning-artifact "$(SCG_PROVISIONINGARTIFACT_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog create-provisioning-artifact $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PARAMETERS_ARTIFACT) $(__SCG_PRODUCT_ID__PROVISIONINGARTIFACT)

_scg_delete_provisioningartifact:
	@$(INFO) '$(SCG_UI_LABEL)Deleting provisioning-artifact "$(SCG_PROVISIONINGARTIFACT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'A product must have at least 1 provisioning-artifact. You cannot delete all of them from a product.'; $(NORMAL)
	$(AWS) servicecatalog delete-provisioning-artifact $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PRODUCT_ID__PROVISIONINGARTIFACT) $(__SCG_PROVISIONING_ARTIFACT_ID)

_scg_edit_provisioningartifact:
	@$(INFO) '$(SCG_UI_LABEL)Editing parameters for provisioning-artifact "$(SCG_PROVISIONINGARTIFACT_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(SCG_PROVISIONINGARTIFACT_PARAMETERS_FILEPATH)

_scg_show_provisioningartifact: _scg_show_provisioningartifact_constraintsummaries _scg_show_provisioningartifact_outputs _scg_show_provisioningartifact_parameters _scg_show_provisioningartifact_tagoptions _scg_show_provisioningartifact_template _scg_show_provisioningartifact_usageinstructions _scg_show_provisioningartifact_description

_scg_show_provisioningartifact_constraintsummaries:
	@$(INFO) '$(SCG_UI_LABEL)Showing the constraint-summaries of provisioning-artifact "$(SCG_PROVISIONINGARTIFACT_NAME)" ...'; $(NORMAL)
	-$(AWS) servicecatalog describe-provisioning-parameters $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PATH_ID__PROVISIONINGARTIFACT) --query "ConstraintSummaries[]$(SCG_UI_SHOW_PROVISIONINGARTIFACT_CONSTRAINTSUMMARIES_FIELDS)" \
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_ID),$(__SCG_PATH_ID__PROVISIONINGARTIFACT),$(__SCG_PATH_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCT_ID),$(__SCG_PRODUCT_ID__PROVISIONINGARTIFACT),$(__SCG_PRODUCT_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_NAME))

_scg_show_provisioningartifact_description:
	@$(INFO) '$(SCG_UI_LABEL)Showing description of provisioning-artifact "$(SCG_PROVISIONINGARTIFACT_NAME)" ...'; $(NORMAL)
	-$(AWS) servicecatalog describe-provisioning-artifact $(__SCG_ACCEPT_LANGUAGE) \
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCT_ID),$(__SCG_PRODUCT_ID__PROVISIONINGARTIFACT),$(__SCG_PRODUCT_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_NAME))

_scg_show_provisioningartifact_outputs:
	@$(INFO) '$(SCG_UI_LABEL)Showing the outputs of provisioning-artifact "$(SCG_PROVISIONINGARTIFACT_NAME)" ...'; $(NORMAL)
	-$(AWS) servicecatalog describe-provisioning-parameters $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PATH_ID__PROVISIONINGARTIFACT) $(__SCG_PRODUCT_ID__PROVISIONINGARTIFACT) $(__SCG_PROVISIONING_ARTIFACT_ID) --query "ProvisioningArtifactOutputs[]$(SCG_UI_SHOW_PROVISIONINGARTIFACT_OUTPUTS_FIELDS)" \
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_ID),$(__SCG_PATH_ID__PROVISIONINGARTIFACT),$(__SCG_PATH_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCT_ID),$(__SCG_PRODUCT_ID__PROVISIONINGARTIFACT),$(__SCG_PRODUCT_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_NAME))

_scg_show_provisioningartifact_parameters:
	@$(INFO) '$(SCG_UI_LABEL)Showing the parameters of provisioning-artifact "$(SCG_PROVISIONINGARTIFACT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'To provision a product using this artificat, you will have to provide a value to all those parameters'; $(NORMAL)
	-$(AWS) servicecatalog describe-provisioning-parameters $(__SCG_ACCEPT_LANGUAGE) --query "ProvisioningArtifactParameters[]$(SCG_UI_SHOW_PROVISIONINGARTIFACT_PARAMETERS_FIELDS)" \
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_ID),$(__SCG_PATH_ID__PROVISIONINGARTIFACT),$(__SCG_PATH_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCT_ID),$(__SCG_PRODUCT_ID__PROVISIONINGARTIFACT),$(__SCG_PRODUCT_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_NAME))

_scg_show_provisioningartifact_tagoptions:
	@$(INFO) '$(SCG_UI_LABEL)Showing tag-options of provisioning-artifact "$(SCG_PROVISIONINGARTIFACT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the possible values for the REQUIRED tags'; $(NORMAL)
	-$(AWS) servicecatalog describe-provisioning-parameters $(__SCG_ACCEPT_LANGUAGE) --query "TagOptions[]$(SCG_UI_SHOW_PROVISIONINGARTIFACT_TAGOPTIONS_FIELDS)" \
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_ID),$(__SCG_PATH_ID__PROVISIONINGARTIFACT),$(__SCG_PATH_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCT_ID),$(__SCG_PRODUCT_ID__PROVISIONINGARTIFACT),$(__SCG_PRODUCT_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_NAME))

_scg_show_provisioningartifact_template:
	@$(INFO) '$(SCG_UI_LABEL)Showing the cloudformation-template of provisioning-artifact "$(SCG_PROVISIONINGARTIFACT_NAME)" ...'; $(NORMAL)
	-$(AWS) servicecatalog describe-provisioning-artifact $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PRODUCT_ID__PROVISIONINGARTIFACT) $(__SCG_PROVISIONING_ARTIFACT_ID) --verbose --query "Info.CloudFormationTemplate" --output text

_scg_show_provisioningartifact_usageinstructions:
	@$(INFO) '$(SCG_UI_LABEL)Showing usage-instructions of provisioning-artifact "$(SCG_PROVISIONINGARTIFACT_NAME)" ...'; $(NORMAL)
	-$(AWS) servicecatalog describe-provisioning-parameters $(__SCG_ACCEPT_LANGUAGE) --query "UsageInstructions[$(SCG_UI_SHOW_PROVISIONINGARTIFACT_USAGEINSTRUCTIONS_SLICE)]$(SCG_UI_SHOW_PROVISIONINGARTIFACT_USAGEINSTRUCTIONS_FIELDS)"
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_ID),$(__SCG_PATH_ID__PROVISIONINGARTIFACT),$(__SCG_PATH_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCT_ID),$(__SCG_PRODUCT_ID__PROVISIONINGARTIFACT),$(__SCG_PRODUCT_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_NAME))
	-$(AWS) servicecatalog describe-provisioning-parameters $(__SCG_ACCEPT_LANGUAGE) --query "UsageInstructions[?Type=='metadata'].Value" --output text \
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCTLAUNCHPATH_ID),$(__SCG_PATH_ID__PROVISIONINGARTIFACT),$(__SCG_PATH_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_PRODUCT_ID),$(__SCG_PRODUCT_ID__PROVISIONINGARTIFACT),$(__SCG_PRODUCT_NAME__PROVISIONINGARTIFACT)) \
		$(if $(SCG_PROVISIONINGARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_NAME)) \
		$(|_SCG_SHOW_PROVISIONINGARTIFACT_USAGEINSTRUCTIONS)

_scg_update_provisioningartifact:
	@$(INFO) '$(SCG_UI_LABEL)Updating provisioning-artifact "$(SCG_PROVISIONINGARTIFACT_NAME)" ...'; $(NORMAL)
	$(AWS)  servicecatalog update-provisioning-artifact $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ACTIVE) $(__SCG_DESCRIPTION__ARTIFACT) $(__SCG_NAME__ARTIFACT) $(__SCG_PRODUCT_ID__PROVISIONINGARTIFACT) $(__SCG_PROVISIONING_ARTIFACT_ID)

_scg_view_provisioningartifacts::
	@$(INFO) '$(SCG_UI_LABEL)Viewing ALL provisioning-artifacts ...'; $(NORMAL)
	@$(WARN) 'Provisioning-artifacts are grouped based on the provided product-id'; $(NORMAL)
	$(AWS) servicecatalog list-provisioning-artifacts $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PRODUCT_ID__PROVISIONINGARTIFACTS) --query "ProvisioningArtifactDetails[]$(SCG_UI_VIEW_PROVISIONINGARTIFACTS_FIELDS)"

_scg_view_provisioningartifacts_set::
	@$(INFO) '$(SCG_UI_LABEL)Viewing provisioning-artifacts-set "$(SCG_PROVISIONINGARTIFACTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Provisioning-artifacts are grouped based on the provided product-id and slice'; $(NORMAL)
	$(AWS) servicecatalog list-provisioning-artifacts $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PRODUCT_ID__PROVISIONINGARTIFACTS) --query "ProvisioningArtifactDetails[$(SCG_UI_VIEW_PROVISIONINGARTIFACTS_SET_SLICE)]$(SCG_UI_VIEW_PROVISIONINGARTIFACTS_SET_FIELDS)"
