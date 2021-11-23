_AWS_SERVICECATALOG_PROVISIONEDPRODUCT_MK_VERSION=$(_AWS_SERVICECATALOG_MK_VERSION)

# SCG_PROVISIONEDPRODUCT_ARN?= arn:aws:servicecatalog:us-east-1:123456789012:stack/MyWordPress/pp-ciwcjzubsxffu
# SCG_PROVISIONEDPRODUCT_ID?= pp-ciwcjzubsxffu
SCG_PROVISIONEDPRODUCT_IGNOREERRORS_FLAG?= false
# SCG_PROVISIONEDPRODUCT_NAME?= MyWordPress
# SCG_PROVISIONEDPRODUCT_NOTIFICATION_ARNS?= arn:aws:sns:us-east-1:123456789012:WordPressTopic ...
# SCG_PROVISIONEDPRODUCT_OUTPUT_KEY?= key1
# SCG_PROVISIONEDPRODUCT_OUTPUT_VALUE?= value1
# SCG_PROVISIONEDPRODUCT_OUTPUTS_KEYS?= key1 ...
# SCG_PROVISIONEDPRODUCT_PARAMETERS_DIRPATH?= ./in/
# SCG_PROVISIONEDPRODUCT_PARAMETERS_FILENAME?= parameter.json 
# SCG_PROVISIONEDPRODUCT_PARAMETERS_FILEPATH?= ./in/parameter.json 
# SCG_PROVISIONEDPRODUCT_PARAMETERS_KEYVALUES?= Key=string,Value=string ...
# SCG_PROVISIONEDPRODUCT_PREFERENCES?=
# SCG_PROVISIONEDPRODUCT_PRODUCT_ID?= prod-xxxxxxx
# SCG_PROVISIONEDPRODUCT_PRODUCT_NAME?= my-product
# SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_ID?= lpv2-5jpilwc4n7flc
# SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_NAME?=
# SCG_PROVISIONEDPRODUCT_PROVISION_TOKEN?=
# SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_ID?= pa-lgraju2rxkumy
# SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_NAME?= 2.2.0
# SCG_PROVISIONEDPRODUCT_RECORD_ID?= rec-5vn7b4omejj36
SCG_PROVISIONEDPRODUCT_RETAINPHYSICALRESOURCES_FLAG?= false
# SCG_PROVISIONEDPRODUCT_TAGS_KEYVALUES?= Key=string,Value=string ...
# SCG_PROVISIONEDPRODUCTS_SET_NAME?= my-set

# Derived parameters
SCG_PROVISIONEDPRODUCT_PRODUCT_ID?= $(SCG_PRODUCT_ID)
SCG_PROVISIONEDPRODUCT_PRODUCT_NAME?= $(SCG_PRODUCT_NAME)
SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_ID?= $(SCG_PRODUCT_LAUNCHPATH_ID)
SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_NAME?= $(SCG_PRODUCT_LAUNCHPATH_NAME)
SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_ID?= $(SCG_PROVISIONINGARTIFACT_ID)
SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_NAME?= $(SCG_PROVISIONINGARTIFACT_NAME)
SCG_PROVISIONEDPRODUCT_PARAMETERS_DIRPATH?= $(SCG_INPUTS_DIRPATH)
SCG_PROVISIONEDPRODUCT_PARAMETERS_FILEPATH?= $(if $(SCG_PROVISIONEDPRODUCT_PARAMETERS_FILENAME),$(SCG_PROVISIONEDPRODUCT_PARAMETERS_DIRPATH)$(SCG_PROVISIONEDPRODUCT_PARAMETERS_FILENAME))

# Options
__SCG_ACCESS_LEVEL_FILTER=
__SCG_FILTERS__PROVISIONEDPRODUCTS=
__SCG_ID__PROVISIONEDPRODUCT= $(if $(SCG_PROVISIONEDPRODUCT_ID),--id $(SCG_PROVISIONEDPRODUCT_ID))
__SCG_IGNORE_ERROR= $(if $(filter true, $(SCG_PROVISIONEDPRODUCT_IGNOREERRORS_FLAG)),--ignore-errors,--no-ignore-errors)
__SCG_NAME__PROVISIONEDPRODUCT= $(if $(SCG_PROVISIONEDPRODUCT_NAME),--name $(SCG_PROVISIONEDPRODUCT_NAME))
__SCG_NOTIFICATION_ARNS= $(if $(SCG_PROVISIONEDPRODUCT_NOTIFICATION_ARNS),--notification-arns $(SCG_PROVISIONEDPRODUCT_NOTIFICATION_ARNS))
__SCG_OUTPUT_KEYS= $(if $(SCG_PROVISIONEDPRODUCT_OUTPUT_KEYS),--output-keys $(SCG_PROVISIONEDPRODUCT_OUTPUT_KEYS))
__SCG_PATH_ID__PROVISIONEDPRODUCT= $(if $(SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_ID),--path-id $(SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_ID))
__SCG_PATH_NAME__PROVISIONEDPRODUCT= $(if $(SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_NAME),--path-name $(SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_NAME))
__SCG_PRODUCT_ID__PROVISIONEDPRODUCT= $(if $(SCG_PROVISIONEDPRODUCT_PRODUCT_ID),--product-id $(SCG_PROVISIONEDPRODUCT_PRODUCT_ID))
__SCG_PRODUCT_NAME__PROVISIONEDPRODUCT= $(if $(SCG_PROVISIONEDPRODUCT_PRODUCT_NAME),--product-name $(SCG_PROVISIONEDPRODUCT_PRODUCT_NAME))
__SCG_PROVISION_TOKEN= $(if $(SCG_PROVISIONEDPRODUCT_PROVISION_TOKEN),--provision-token $(SCG_PROVISIONEDPRODUCT_PROVISION_TOKEN))
__SCG_PROVISIONED_PRODUCT_ID= $(if $(SCG_PROVISIONEDPRODUCT_ID),--provisioned-product-id $(SCG_PROVISIONEDPRODUCT_ID))
__SCG_PROVISIONED_PRODUCT_NAME= $(if $(SCG_PROVISIONEDPRODUCT_NAME),--provisioned-product-name $(SCG_PROVISIONEDPRODUCT_NAME))
__SCG_PROVISIONING_ARTIFACT_ID= $(if $(SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_ID),--provisioning-artifact-id $(SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_ID))
__SCG_PROVISIONING_ARTIFACT_NAME= $(if $(SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_NAME),--provisioning-artifact-name $(SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_NAME))
__SCG_PROVISIONING_PARAMETERS+= $(if $(SCG_PROVISIONEDPRODUCT_PARAMETERS_KEYVALUES),--provisioning-parameters $(SCG_PROVISIONEDPRODUCT_PARAMETERS_KEYVALUES))
__SCG_PROVISIONING_PARAMETERS+= $(if $(SCG_PROVISIONEDPRODUCT_PARAMETERS_FILEPATH),--provisioning-parameters file://$(SCG_PROVISIONEDPRODUCT_PARAMETERS_FILEPATH))
__SCG_PROVISIONING_PREFERENCES= $(if $(SCG_PROVISIONEDPRODUCT_PREFERENCES),--provisioning-preferences $(SCG_PROVISIONEDPRODUCT_PREFERENCES))
__SCG_RETAIN_PHYSICAL_RESOURCES= $(if $(filter true, $(SCG_PROVISIONEDPRODUCT_RETAINPHYSICALRESOURCES_FLAG)),--retain-physical-resources,--no-retain-physical-resources)
__SCG_SORT_BY__PROVISIONEDPRODUCT=
__SCG_SORT_ORDER__PROVISIONEDPRODUCT=
__SCG_TAGS__PROVISIONEDPRODUCT?= $(if $(SCG_PROVISIONEDPRODUCT_TAGS_KEYVALUES),--tags $(SCG_PROVISIONEDPRODUCT_TAGS_KEYVALUES))

# Customizations
_SCG_LIST_PROVISIONEDPRODUCTS_FIELDS?= .{Name:Name,status:Status,type:Type,Id:Id,userArn:UserArn}
_SCG_LIST_PROVISIONEDPRODUCTS_SET_FIELDS?= $(_SCG_LIST_PROVISIONEDPRODUCTS_FIELDS)
_SCG_LIST_PROVISIONEDPRODUCTS_SET_QUERYFILTER?=
_SCG_SHOW_PROVISIONEDPRODUCT_DESCRIPTION_FIELDS?= .{Status:Status,Name:Name,LastRecordId:LastRecordId,Arn:Arn,CreatedTime:CreatedTime,Type:Type,Id:Id,IdempotencyToken:IdempotencyToken}
_SCG_SHOW_PROVISIONEDPRODUCT_OUTPUTS_FIELDS?= .{OutputKey:OutputKey,OutputValue:OutputValue}
_SCG_SHOW_PROVISIONEDPRODUCT_OUTPUTS_QUERYFILTER?=
_SCG_SHOW_PROVISIONEDPRODUCT_STACKS_FIELDS?=
_SCG_SHOW_PROVISIONEDPRODUCT_STATUS_FIELDS?= .{Status:Status,StatusMessage:StatusMessage}
_SCG_SHOW_PROVISIONEDPRODUCT_DESCRIPTION_|?= -#
_SCG_SHOW_PROVISIONEDPRODUCT_OUTPUTS_|?= -#

# Macros
_scg_get_provisionedproduct_id= $(call _scg_get_provisionedproduct_id_N, $(SCG_PROVISIONEDPRODUCT_NAME))
_scg_get_provisionedproduct_id_N= $(shell $(AWS) servicecatalog search-provisioned-products $(__SCG_ACCEPT_LANGUAGE) --query "ProvisionedProducts[?Name=='$(strip $(1))'].Id" --output text)

_scg_get_provisionedproduct_output_value= $(call _scg_get_provisionedproduct_output_value_K, $(SCG_PROVISIONEDPRODUCT_OUTPUT_KEY))
_scg_get_provisionedproduct_output_value_K= $(call _scg_get_provisionedproduct_output_value_KN, $(1), $(SCG_PROVISIONEDPRODUCT_NAME))
_scg_get_provisionedproduct_output_value_KN= $(shell $(AWS) servicecatalog get-provisioned-product-outputs $(__SCG_ACCEPT_LANGUAGE) --output-keys $(1) --provisioned-product-name $(2) --query "Outputs[].OutputValue" --output text)

#----------------------------------------------------------------------
# USAGE
#

_scg_list_macros ::
	@echo 'AWS::ServiceCataloG::ProvisionedProduct ($(_AWS_SERVICECATALOG_PROVISIONEDPRODUCT_MK_VERSION)) macros:'
	@echo '    _scg_get_provisionedproduct_id_{|N}                      - Get the ID of a provisioning product (Name)'
	@echo '    _scg_get_provisionedproduct_output_{|K|KN}               - Get an output of a provisioning product (Key,Name)'
	@echo

_scg_list_parameters ::
	@echo 'AWS::ServiceCataloG::ProvisionedProduct ($(_AWS_SERVICECATALOG_PROVISIONEDPRODUCT_MK_VERSION)) parameters:'
	@echo '    SCG_PROVISIONEDPRODUCT_ARN=$(SCG_PROVISIONEDPRODUCT_ARN)'
	@echo '    SCG_PROVISIONEDPRODUCT_ID=$(SCG_PROVISIONEDPRODUCT_ID)'
	@echo '    SCG_PROVISIONEDPRODUCT_IGNOREERRORS_FLAG=$(SCG_PROVISIONEDPRODUCT_IGNOREERRORS_FLAG)'
	@echo '    SCG_PROVISIONEDPRODUCT_NAME=$(SCG_PROVISIONEDPRODUCT_NAME)'
	@echo '    SCG_PROVISIONEDPRODUCT_NOTIFICATION_ARNS=$(SCG_PROVISIONEDPRODUCT_NOTIFICATION_ARNS)'
	@echo '    SCG_PROVISIONEDPRODUCT_OUTPUT_KEY=$(SCG_PROVISIONEDPRODUCT_OUTPUT_KEY)'
	@echo '    SCG_PROVISIONEDPRODUCT_OUTPUT_VALUE=$(SCG_PROVISIONEDPRODUCT_OUTPUT_VALUE)'
	@echo '    SCG_PROVISIONEDPRODUCT_OUTPUTS_KEYS=$(SCG_PROVISIONEDPRODUCT_OUTPUTS_KEYS)'
	@echo '    SCG_PROVISIONEDPRODUCT_PARAMETERS_DIRPATH=$(SCG_PROVISIONEDPRODUCT_PARAMETERS_DIRPATH)'
	@echo '    SCG_PROVISIONEDPRODUCT_PARAMETERS_FILENAME=$(SCG_PROVISIONEDPRODUCT_PARAMETERS_FILENAME)'
	@echo '    SCG_PROVISIONEDPRODUCT_PARAMETERS_FILEPATH=$(SCG_PROVISIONEDPRODUCT_PARAMETERS_FILEPATH)'
	@echo '    SCG_PROVISIONEDPRODUCT_PARAMETERS_KEYVALUES=$(SCG_PROVISIONEDPRODUCT_PARAMETERS_KEYVALUES)'
	@echo '    SCG_PROVISIONEDPRODUCT_PREFERENCES=$(SCG_PROVISIONEDPRODUCT_PREFERENCES)'
	@echo '    SCG_PROVISIONEDPRODUCT_PRODUCT_ID=$(SCG_PROVISIONEDPRODUCT_PRODUCT_ID)'
	@echo '    SCG_PROVISIONEDPRODUCT_PRODUCT_NAME=$(SCG_PROVISIONEDPRODUCT_PRODUCT_NAME)'
	@echo '    SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_ID=$(SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_ID)'
	@echo '    SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_NAME=$(SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_NAME)'
	@echo '    SCG_PROVISIONEDPRODUCT_PROVISION_TOKEN=$(SCG_PROVISIONEDPRODUCT_PROVISION_TOKEN)'
	@echo '    SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_ID=$(SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_ID)'
	@echo '    SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_NAME=$(SCG_PROVISIONEDPRODUCT_PROVIONINGARTIFACT_NAME)'
	@echo '    SCG_PROVISIONEDPRODUCT_RECORD_ID=$(SCG_PROVISIONEDPRODUCT_RECORD_ID)'
	@echo '    SCG_PROVISIONEDPRODUCT_RETAINPHYSICALRESOURCES_FLAG=$(SCG_PROVISIONEDPRODUCT_RETAINPHYSICALRESOURCES_FLAG)'
	@echo '    SCG_PROVISIONEDPRODUCT_TAGS_KEYVALUES=$(SCG_PROVISIONEDPRODUCT_TAGS_KEYVALUES)'
	@echo '    SCG_PROVISIONEDPRODUCTS_SET_NAME=$(SCG_PROVISIONEDPRODUCTS_SET_NAME)'
	@echo

_scg_list_targets ::
	@echo 'AWS::ServiceCataloG::ProvisionedProduct ($(_AWS_SERVICECATALOG_PROVISIONEDPRODUCT_MK_VERSION)) targets:'
	@echo '    _scg_create_provisionedproduct                           - Create a provisioned-product'
	@echo '    _scg_delete_provisionedproduct                           - Delete a provisioned-product'
	@echo '    _scg_list_provisionedproducts                            - List all provisioned-products'
	@echo '    _scg_list_provisionedproducts_set                        - List a set of provisioned-product'
	@echo '    _scg_show_provisionedproduct                             - Show everything related to a provisioned-product'
	@echo '    _scg_show_provisionedproduct_description                 - Show description of a provisioned-product'
	@echo '    _scg_show_provisionedproduct_input                       - Show inputs of a provisioned-product'
	@echo '    _scg_show_provisionedproduct_outputs                     - Show outputs of a provisioned-product'
	@echo '    _scg_show_provisionedproduct_status                      - Show status of a provisioned-product'
	@echo '    _scg_update_provisionedproduct                           - Update a provisioned-product'
	@echo '    _scg_write_provisionedproduct_parameters                 - Write parameters for a provisioned-product'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_scg_create_provisionedproduct:
	@$(INFO) '$(SCG_UI_LABEL)Creating provisioned-product "$(SCG_PROVISIONEDPRODUCT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is one of the 2 methods to create a provisioned-product'; $(NORMAL)
	@$(WARN) 'The other method requires a provisioned-product-plan'; $(NORMAL)
	$(if $(SCG_PROVISIONEDPRODUCT_PARAMETERS_FILEPATH),cat $(SCG_PROVISIONEDPRODUCT_PARAMETERS_FILEPATH))
	$(AWS)  servicecatalog provision-product $(strip $(__SCG_ACCEPT_LANGUAGE) $(__SCG_NOTIFICATION_ARNS) $(__SCG_PATH_ID__PROVISIONEDPRODUCT) $(__SCG_PATH_NAME__PROVISIONEDPRODUCT) $(__SCG_PROVISION_TOKEN) $(__SCG_PROVISIONED_PRODUCT_NAME) $(__SCG_PROVISIONING_PARAMETERS) $(__SCG_PROVISIONING_PREFERENCES) $(__SCG_TAGS__PROVISIONEDPRODUCT) ) \
	$(if $(SCG_PROVISIONEDPRODUCT_PRODUCT_ID),$(__SCG_PRODUCT_ID__PROVISIONEDPRODUCT),$(__SCG_PRODUCT_NAME__PROVISIONEDPRODUCT)) \
	$(if $(SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_ID),$(__SCG_PROVISIONING_ARTIFACT_NAME))

_scg_delete_provisionedproduct:
	@$(INFO) '$(SCG_UI_LABEL)Deleting provisioned-product "$(SCG_PROVISIONEDPRODUCT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is only available to portfolio-principals'; $(NORMAL)
	$(AWS)  servicecatalog terminate-provisioned-product $(__SCG_ACCEPT_LANGUAGE) $(__SCG_IGNORE_ERROR) $(__SCG_RETAIN_PHYSICAL_RESOURCES) \
	$(if $(SCG_PROVISIONEDPRODUCT_ID),$(__SCG_PROVISIONED_PRODUCT_ID),$(__SCG_PROVISIONED_PRODUCT_NAME))

_scg_list_provisionedproducts:
	@$(INFO) '$(SCG_UI_LABEL)Listing ALL provisioned-products ...'; $(NORMAL)
	$(AWS) servicecatalog search-provisioned-products $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ACCESS_LEVEL_FILTER) $(__SCG_FILTERS__PROVISIONEDPRODUCTS) $(__SCG_SORT_BY__PROVISIONEDPRODUCT) $(__SCG_SORT_ORDER__PROVISIONEDPRODUCT) --query "ProvisionedProducts[]$(_SCG_LIST_PROVISIONEDPRODUCTS_FIELDS)"

_scg_list_provisionedproducts_set:
	@$(INFO) '$(SCG_UI_LABEL)Listing provisioned-products-set "$(SCG_PROVISIONEDPRODUCTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Provisioned-products are grouped based on provided filter, slice'; $(NORMAL)
	$(AWS) servicecatalog search-provisioned-products $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ACCESS_LEVEL_FILTER) $(__SCG_FILTERS__PROVISIONEDPRODUCTS) $(__SCG_SORT_BY__PROVISIONEDPRODUCT) $(__SCG_SORT_ORDER__PROVISIONEDPRODUCT) --query "ProvisionedProducts[$(_SCG_LIST_PROVISIONEDPRODUCTS_SET_QUERYFILTER)]$(_SCG_LIST_PROVISIONEDPRODUCTS_SET_FIELDS)"

_SCG_SHOW_PROVISIONEDPRODUCT_TARGETS?= _scg_show_provisionedproduct_inputs _scg_show_provisionedproduct_outputs _scg_show_provisionedproduct_stacks _scg_show_provisionedproduct_status _scg_show_provisionedproduct_description
_scg_show_provisionedproduct: $(_SCG_SHOW_PROVISIONEDPRODUCT_TARGETS)

_scg_show_provisionedproduct_description:
	@$(INFO) '$(SCG_UI_LABEL)Showing description provisioned-product "$(SCG_PROVISIONEDPRODUCT_NAME)" ...'; $(NORMAL)
	$(+SCG_SHOW_PROVISIONEDPRODUCT_DESCRIPTION_|)$(AWS) servicecatalog describe-provisioned-product $(__SCG_ACCEPT_LANGUAGE) --query "ProvisionedProductDetail$(_SCG_SHOW_PROVISIONEDPRODUCT_FIELDS)" \
	$(if $(SCG_PROVISIONEDPRODUCT_ID),$(__SCG_ID__PROVISIONEDPRODUCT),$(__SCG_NAME__PROVISIONEDPRODUCT))

_scg_show_provisionedproduct_inputs:
	@$(INFO) '$(SCG_UI_LABEL)Showing inputs of provisioned-product "$(SCG_PROVISIONEDPRODUCT_NAME)" ...'; $(NORMAL)
	$(if $(SCG_PROVISIONEDPRODUCT_PARAMETERS_KEYVALUES),echo $(SCG_PROVISIONEDPRODUCT_PARAMETERS_KEYVALUES))
	$(if $(SCG_PROVISIONEDPRODUCT_PARAMETERS_FILEPATH), \
		cat $(SCG_PROVISIONEDPRODUCT_PARAMETERS_FILEPATH), \
		@echo 'SCG_PROVISIONEDPRODUCT_PARAMETERS_FILEPATH not set ...'\
	)

_scg_show_provisionedproduct_outputs:
	@$(INFO) '$(SCG_UI_LABEL)Showing outputs of provisioned-product "$(SCG_PROVISIONEDPRODUCT_NAME)" ...'; $(NORMAL)
	$(_SCG_SHOW_PROVISIONEDPRODUCT_OUTPUTS_|)$(AWS) servicecatalog get-provisioned-product-outputs $(SCG_ACCEPT_LANGUAGE) $(__SCG_OUTPUT_KEYS) --query "Outputs[$(_SCG_SHOW_PROVISIONEDPRODUCT_OUTPUTS_QUERYFILTER)]$(_SCG_SHOW_PROVISIONEDPRODUCT_OUTPUTS_FIELDS)" --output json \
	$(if $(SCG_PROVISIONEDPRODUCT_ID),$(__SCG_PROVISIONED_PRODUCT_ID),$(__SCG_PROVISIONED_PRODUCT_NAME))

_scg_show_provisionedproduct_stacks:
	@$(INFO) '$(SCG_UI_LABEL)Showing cloudformation-stacks of provisioned-product "$(SCG_PROVISIONEDPRODUCT_NAME)" ...'; $(NORMAL)
	-@$(if $(SCG_PROVISIONEDPRODUCT_ID),,$(WARN) "SCG_PROVISIONEDPRODUCT_ID is not set")
	-$(if $(SCG_PROVISIONEDPRODUCT_ID), \
		$(AWS) servicecatalog list-stack-instances-for-provisioned-product $(SCG_ACCEPT_LANGUAGE) $(__SCG_PROVISIONED_PRODUCT_ID) # --query "Stacks[$(_SCG_SHOW_PROVISIONEDPRODUCT_STACKS_QUERYFILTER)]$(_SCG_SHOW_PROVISIONEDPRODUCT_STACKS_FIELDS)")


_scg_show_provisionedproduct_status:
	@$(INFO) '$(SCG_UI_LABEL)Showing status of provisioned-product "$(SCG_PROVISIONEDPRODUCT_NAME)" ...'; $(NORMAL)
	-$(AWS)  servicecatalog describe-provisioned-product $(__SCG_ACCEPT_LANGUAGE) --query "ProvisionedProductDetail$(_SCG_SHOW_PROVISIONEDPRODUCT_STATUS)" --output json \
	$(if $(SCG_PROVISIONEDPRODUCT_ID),$(__SCG_ID__PROVISIONEDPRODUCT),$(__SCG_NAME__PROVISIONEDPRODUCT))

_scg_update_provisionedproduct:
	@$(INFO) '$(SCG_UI_LABEL)Updating provisioned-product "$(SCG_PROVISIONEDPRODUCT_NAME)" ...'; $(NORMAL)

_scg_waitfor_provisionedproduct:
	@$(INFO) '$(SCG_UI_LABEL)Waiting for provisioned-product "$(SCG_PROVISIONEDPRODUCT_NAME)" ...'; $(NORMAL)
	@_STATUS="UNDER_CHANGE"; while [ "x$${_STATUS}" == "xUNDER_CHANGE" ]; do \
		_STATUS=`$(AWS) servicecatalog search-provisioned-products --accept-language en --query "ProvisionedProducts[?Name=='$(SCG_PROVISIONEDPRODUCT_NAME)'].Status" --output text 2>/dev/null`; \
		$(ECHO) -n "." ; sleep 1; \
	done; $(ECHO) $$_STATUS ; $(WARN) 'Provisioning of provisioned-product "$(SCG_PROVISIONEDPRODUCT_NAME)" completed'; $(NORMAL)

_scg_write_provisionedproduct_parameters:
	@$(INFO) '$(SCG_UI_LABEL)Writing parameters for provisioned-product "$(SCG_PROVISIONEDPRODUCT_NAME)" ...'; $(NORMAL)
	$(WRITER) $(SCG_PROVISIONEDPRODUCT_PARAMETERS_FILEPATH)
