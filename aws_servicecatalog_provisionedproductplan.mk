_AWS_SERVICECATALOG_PROVISIONEDPRODUCTPLAN_MK_VERSION=$(_AWS_SERVICECATALOG_MK_VERSION)

# SCG_PROVISIONEDPRODUCTPLAN_NAME?= my-plan
# SCG_PROVISIONEDPRODUCTPLAN_PATH_ID?= lp-5jpilwc4n7flc
# SCG_PROVISIONEDPRODUCTPLAN_TAGS_KEYVALUES?= Key=string,Value=string ...
SCG_PROVISIONEDPRODUCTPLAN_TYPE?= CLOUDFORMATION
# SCG_PROVISIONEDPRODUCTPLANS_SET_NAME?= my-plan

# Derived parameters
SCG_PROVISIONEDPRODUCTPLAN_PATH_ID?= $(SCG_PRODUCT_LAUNCH_PATH_ID)

# Options parameters
__SCG_PATH_ID__PROVISIONEDPRODUCTPLAN?= $(if $(SCG_PROVISIONEDPRODUCTPLAN_PATH_ID),--path-id $(SCG_PROVISIONEDPRODUCTPLAN_PATH_ID))
__SCG_PLAN_NAME?= $(if $(SCG_PROVISIONEDPRODUCTPLAN_NAME),--plan-name $(SCG_PROVISIONEDPRODUCTPLAN_NAME))
__SCG_PLAN_TYPE?= $(if $(SCG_PROVISIONEDPRODUCTPLAN_TYPE),--plan-type $(SCG_PROVISIONEDPRODUCTPLAN_TYPE))
__SCG_TAGS__PROVISIONEDPRODUCTPLAN?= $(if $(SCG_PROVISIONEDPRODUCTPLAN_TAGS_KEYVALUES),--tags $(SCG_PROVISIONEDPRODUCTPLAN_TAGS_KEYVALUES))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_scg_view_framework_macros ::
	@echo 'AWS::ServiceCataloG::ProvisionedProductPlan ($(_AWS_SERVICECATALOG_PROVISIONEDPRODUCTPLAN_MK_VERSION)) macros:'
	@echo

_scg_view_framework_parameters ::
	@echo 'AWS::ServiceCataloG::ProvisionedProductPlan ($(_AWS_SERVICECATALOG_PROVISIONEDPRODUCTPLAN_MK_VERSION)) parameters:'
	@echo '    SCG_PROVISIONEDPRODUCTPLAN_NAME=$(SCG_PROVISIONEDPRODUCTPLAN_NAME)'
	@echo '    SCG_PROVISIONEDPRODUCTPLAN_PATH_ID=$(SCG_PROVISIONEDPRODUCTPLAN_PATH_ID)'
	@echo '    SCG_PROVISIONEDPRODUCTPLAN_TAGS_KEYVALUES=$(SCG_PROVISIONEDPRODUCTPLAN_TAGS_KEYVALUES)'
	@echo '    SCG_PROVISIONEDPRODUCTPLAN_TYPE=$(SCG_PROVISIONEDPRODUCTPLAN_TYPE)'
	@echo '    SCG_PROVISIONEDPRODUCTPLANS_SET_NAME=$(SCG_PROVISIONEDPRODUCTPLANS_SET_NAME)'
	@echo

_scg_view_framework_targets ::
	@echo 'AWS::ServiceCataloG::ProvisionedProductPlan ($(_AWS_SERVICECATALOG_PROVISIONEDPRODUCTPLAN_MK_VERSION)) targets:'
	@echo '    _scg_create_provisionedproductplan                           - Create a provisioned product plan'
	@echo '    _scg_delete_provisionedproductplan                           - Delete a provisioned product plan'
	@echo '    _scg_show_provisionedproductplan                             - Show details of a provisioned product plan'
	@echo '    _scg_view_provisionedproductplans                            - View provisioned product plans'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_scg_create_provisionedproductplan:
	@$(INFO) '$(SCG_UI_LABEL)Creating a provisioned product plan "$(SCG_PROVISIONEDPRODUCTPLAN_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Operation only permitted to product/portfolio-principals'; $(NORMAL)
	$(AWS) servicecatalog create-provisioned-product-plan $(__SCG_ACCEPT_LANGUAGE) $(__SCG_NOTIFICATION_ARNS) $(__SCG_PATH_ID__PROVISIONEDPRODUCTPLAN) $(__SCG_PLAN_NAME) $(__SCG_PLAN_TYPE) $(__SCG_PRODUCT_ID) $(__SCG_PROVISIONED_PRODUCT_NAME) $(__SCG_PROVISIONING_ARTIFACT_ID) $(__SCG_PROVISIONING_PARAMETERS) $(__SCG_TAGS__PROVISIONEDPRODUCTPLAN)

_scg_show_provisionedproductplan: _scg_show_provisionedproductplan_description

_scg_show_provisionedproductplan_description:

_scg_view_provisionedproductplans:
	@$(INFO) '$(SCG_UI_LABEL)Viewing ALL provisioned-product-plans ...'; $(NORMAL)
	$(AWS) servicecatalog list-provisioned-product-plans $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PROVISION_PRODUCT_ID)

_scg_view_provisionedproductplans_set:
	@$(INFO) '$(SCG_UI_LABEL)Viewing provisioned-product-plans-set "$(SCG_PROVISIONEDPRODUCTPLANS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Provisioned-product plans are grouped based on ...'; $(NORMAL)
	$(AWS) servicecatalog list-provisioned-product-plans $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PROVISION_PRODUCT_ID)
