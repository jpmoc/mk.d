_AWS_SERVICECATALOG_RECORD_MK_VERSION=$(_AWS_SERVICECATALOG_MK_VERSION)

# SCG_RECORD_ID?= rec-3kgrq2rxelnzw
# SCG_RECORD_LAUNCHPATH_ID?=
# SCG_RECORD_NAME?= my-record
# SCG_RECORD_PROVISIONEDPRODUCT_ID?=
# SCG_RECORD_PROVISIONEDPRODUCT_NAME?=
# SCG_RECORD_STATUS?= SUCCEEDED
# SCG_RECORD_TYPE?= TERMINATE_PROVISIONED_PRODUCT
SCG_RECORDS_ACCESSLEVELFILTER_TYPE?= User
# SCG_RECORDS_SEARCHFILTER_TYPE?= provisionedproduct
# SCG_RECORDS_SET_NAME?= my-records-set

# Derived parameters
SCG_RECORD_LAUNCHPATH_ID?= $(SCG_PROVISIONEDPRODUCT_PRODUCTLAUNCHPATH_ID)
SCG_RECORD_PRODUCT_ID?= $(SCG_PROVISIONEDPARODUCT_PRODUCT_ID)
SCG_RECORD_PROVISIONEDPRODUCT_ID?= $(SCG_PROVISIONEDPRODUCT_ID)
SCG_RECORD_PROVISIONEDPRODUCT_NAME?= $(SCG_PROVISIONEDPRODUCT_NAME)
SCG_RECORD_PROVISIONINGARTIFACT_ID?= $(SCG_PROVISIONEDPRODUCT_PROVISIONINGARTIFACT_ID)

# Options
__SCG_ACCESS_LEVEL_FILTER__RECORDS= $(if $(SCG_RECORDS_ACCESSLEVELFILTER_TYPE),--access-level-filter $(SCG_RECORDS_ACCESSLEVELFILTER_TYPE))
__SCG_ID__RECORD= $(if $(SCG_RECORD_ID),--id $(SCG_RECORD_ID))
__SCG_SEARCH_FILTER__RECORDS= $(if $(SCG_RECORDS_SEARCHFILTER_TYPE),--search-filter $(SCG_RECORDS_SEARCHFILTER_TYPE))

# Customizations
_SCG_LIST_RECORDS_FIELDS?= .{RecordId:RecordId,createdTime:CreatedTime,recordType:RecordType,status:Status,provisionedProductName:ProvisionedProductName,updatedTime:UpdatedTime}
_SCG_LIST_RECORDS_SET_FIELDS?= $(_SCG_LIST_RECORDS_FIELDS)
_SCG_LIST_RECORDS_SET_SLICE?=

# Macros
# _scg_get_record_provisioningartifact_id= $(call _scg_get_record_provisioningartifact_id_I, $(SCG_PRODUCT_ARTIFACT_NAME))
# _scg_get_record_provisioningartifact_id_I= $(shell $(AWS) servicecatalog describe-record --id $(1) --query "ProvisioningArtifacts[].Id" --output text)

# _scg_get_record_provisioningartifact_id= $(call _scg_get_record_provisioningartifact_id_I, $(SCG_PRODUCT_ARTIFACT_NAME))
# _scg_get_record_provisioningartifact_id_I= $(shell $(AWS) servicecatalog describe-record --id $(1) --query "ProvisioningArtifacts[].Id" --output text)
#
# _scg_get_record_provisioningartifact_id= $(call _scg_get_record_provisioningartifact_id_I, $(SCG_PRODUCT_ARTIFACT_NAME))
# _scg_get_record_provisioningartifact_id_I= $(shell $(AWS) servicecatalog describe-record --id $(1) --query "ProvisioningArtifacts[].Id" --output text)

#----------------------------------------------------------------------
# USAGE
#

_scg_list_macros ::
	@#echo 'AWS::ServiceCataloG::Record ($(_AWS_SERVICECATALOG_RECORD_MK_VERSION)) macros:'
	@#echo '    _scg_get_product_artifact_id_{|N|NI}     - Get the ID of provisioning-artifact for a product (artifactName,productId)'
	@#echo '    _scg_get_product_id_{|N}                 - Get the ID of a product ID (productName)'
	@#echo '    _scg_get_product_launchpath_id_{|N|NI}   - Get the launch-path ID for a product (pathName,productId)'
	@#echo

_scg_list_parameters ::
	@echo 'AWS::ServiceCataloG::Record ($(_AWS_SERVICECATALOG_RECORD_MK_VERSION)) parameters:'
	@echo '    SCG_RECORD_ID=$(SCG_RECORD_ID)'
	@echo '    SCG_RECORD_LAUNCHPATH_ID=$(SCG_RECORD_LAUNCHPATH_ID)'
	@echo '    SCG_RECORD_LAUNCHPATH_NAME=$(SCG_RECORD_LAUNCHPATH_NAME)'
	@echo '    SCG_RECORD_NAME=$(SCG_RECORD_NAME)'
	@echo '    SCG_RECORD_PROVISIONEDPRODUCT_NAME=$(SCG_RECORD_PROVISIONEDPRODUCT_NAME)'
	@echo '    SCG_RECORD_TYPE=$(SCG_RECORD_TYPE)'
	@echo '    SCG_RECORDS_ACCESSLEVELFILTER_TYPE=$(SCG_RECORDS_ACCESSLEVELFILTER_TYPE)'
	@echo '    SCG_RECORDS_SEARCHFILTER_TYPE=$(SCG_RECORDS_SEARCHFILTER_TYPE)'
	@echo '    SCG_RECORDS_SET_NAME=$(SCG_RECORDS_SET_NAME)'
	@echo

_scg_list_targets ::
	@echo 'AWS::ServiceCataloG::Record ($(_AWS_SERVICECATALOG_RECORD_MK_VERSION)) targets:'
	@echo '    _scg_list_records                          - List all records'
	@echo '    _scg_list_records_set                      - List set of records'
	@echo '    _scg_show_record                           - Show everything related to a record'
	@echo '    _scg_show_record_description               - Show the description of a record'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_scg_list_records:
	@$(INFO) '$(SCG_UI_LABEL)Listing ALL records ...'; $(NORMAL)
	@$(WARN) 'The oldest record/activity is at the top'; $(NORMAL)
	$(AWS) servicecatalog list-record-history $(_X__SCG_ACCESS_LEVEL_FILTER__RECORDS) $(_X__SCG_SEARCH_FILTER__RECORDS) --query "sort_by(RecordDetails,&CreatedTime)[]$(SCG_UI_VIEW_RECORDS_FIELDS)"
	@$(WARN) 'The most recent record/activity is at the bottom'; $(NORMAL)

_scg_list_records_set:
	@$(INFO) '$(SCG_UI_LABEL)Listing records-set "$(SCG_RECORDS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Records are grouped based on the provided access-level-filter, search-filter, slice'; $(NORMAL)
	@$(WARN) 'The oldest record/activity is at the top'; $(NORMAL)
	$(AWS) servicecatalog list-record-history $(__SCG_ACCESS_LEVEL_FILTER__RECORDS) $(__SCG_SEARCH_FILTER__RECORDS) --query "sort_by(RecordDetails,&CreatedTime)[$(SCG_UI_VIEW_RECORDS_SET_SLICE)]$(SCG_UI_VIEW_RECORDS_SET_FIELDS)"
	@$(WARN) 'The most recent record/activity is at the bottom'; $(NORMAL)

_SCG_SHOW_RECORD_TARGETS?= _scg_show_record_description
_scg_show_record: $(_SCG_SHOW_RECORD_TARGETS)

_scg_show_record_description:
	@$(INFO) '$(SCG_UI_LABEL)Showing description of record "$(SCG_RECORD_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog describe-record $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ID__RECORD)
