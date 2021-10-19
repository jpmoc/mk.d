_AWS_SERVICECATALOG_MANAGEDPRODUCT_MK_VERSION=$(_AWS_SERVICECATALOG_MK_VERSION)

## SCG_PRODUCT_DESCRIPTION?=
## SCG_PRODUCT_DISTRIBUTOR?=
## SCG_PRODUCT_ID?= prod-3kgrq2rxelnzw
## SCG_PRODUCT_LAUNCH_PATH_ID?= lp-5jpilwc4n7flc
## SCG_PRODUCT_LAUNCH_PATH_NAME?= Training Portfolio
# SCG_MANAGEDPRODUCT_NAME?= my-managed-product
## SCG_PRODUCT_OWNER?=
## SCG_PRODUCT_PROTFOLIO_ID?=
## SCG_PRODUCT_SUPPORT_DESCRIPTION?=
## SCG_PRODUCT_SUPPORT_EMAIL?=
## SCG_PRODUCT_SUPPORT_URL?=
## SCG_PRODUCT_TAGS_KEYVALUES?= Key=string,Value=string ...
## SCG_PRODUCT_TYPE?= CLOUD_FORMATION_TEMPLATE
# SCG_MANAGEDPRODUCTS_SET_NAME?= my-set-name

# Derived parameters
# SCG_PRODUCT_PORTFOLIO_ID?= $(SCG_PORTFOLIO_ID)
SCG_MANAGEDPRODUCT_ID?= $(SCG_PRODUCT_ID)
SCG_MANAGEDPRODUCT_NAME?= $(SCG_PRODUCT_NAME)

# Options parameters
__SCG_ID__MANAGEDPRODUCT= $(if $(SCG_MANAGEDPRODUCT_ID),--id $(SCG_MANAGEDPRODUCT_ID))
# __SCG_NAME__PRODUCT= $(if $(SCG_PRODUCT_NAME),--name $(SCG_PRODUCT_NAME))
# __SCG_OWNER_PRODUCT= $(if $(SCG_PRODUCT_OWNER),--owner '$(SCG_PRODUCT_OWNER)')
# __SCG_PATH_ID= $(if $(SCG_PRODUCT_LAUNCH_PATH_ID),--path-id $(SCG_PRODUCT_LAUNCH_PATH_ID))
# __SCG_PRODUCT_TYPE= $(if $(SCG_PRODUCT_TYPE),--product-type $(SCG_PRODUCT_TYPE))
# __SCG_PRODUCT_ID= $(if $(SCG_PRODUCT_ID),--product-id $(SCG_PRODUCT_ID))
# __SCG_PROVISIONING_ARTIFACT_ID= $(if $(SCG_PRODUCT_ARTIFACT_ID),--provisioning-artifact-id $(SCG_PRODUCT_ARTIFACT_ID))
# __SCG_PROVISIONING_ARTIFACT_PARAMETERS= $(if $(SCG_PRODUCT_ARTIFACT_PARAMETERS),--provisioning-artifact-parameters $(SCG_PRODUCT_ARTIFACT_PARAMETERS))
# __SCG_SUPPORT_DESCRIPTION= $(if $(SCG_PRODUCT_SUPPORT_DESCRIPTION),--support-description '$(SCG_PRODUCT_SUPPORT_DESCRIPTION)')
# __SCG_SUPPORT_EMAIL= $(if $(SCG_PRODUCT_SUPPORT_EMAIL),--support-email $(SCG_PRODUCT_SUPPORT_EMAIL))
# __SCG_SUPPORT_URL= $(if $(SCG_PRODUCT_SUPPORT_URL),--support-url $(SCG_PRODUCT_SUPPORT_URL))
# __SCG_TAGS__PRODUCT= $(if $(SCG_PRODUCT_TAGS_KEYVALUES),--tags $(SCG_PRODUCT_TAGS_KEYVALUES))

# UI parameters
# SCG_UI_SHOW_DEPLOYABLE_PRODUCT_LAUNCH_PATHS?= .{Id:Id,constraintType:join(' + ', sort(ConstraintSummaries[].Type)),Name:Name}
# SCG_UI_SHOW_PRODUCT_ARTIFACTS_FIELDS?= .{Id:Id,Name:Name,description:Description,type:Type,active:Active,createdTime:CreatedTime}
# SCG_UI_SHOW_PRODUCT_PORTFOLIOS_FIELDS?= .{Id:Id,DisplayName:DisplayName,ProviderName:ProviderName,description:Description}
# SCG_UI_VIEW_DEPLOYABLE_PRODUCTS_FIELDS?= .{Name:Name,ProductId:ProductId,hasDefaultPath:HasDefaultPath,id:Id,owner:Owner,supportEmail:SupportEmail}
SCG_UI_VIEW_MANAGEDPRODUCTS_FIELDS?= .{Name:ProductViewSummary.Name,shortDescription:ProductViewSummary.ShortDescription,status:Status,ProductId:ProductViewSummary.ProductId}
SCG_UI_VIEW_MANAGEDPRODUCTS_SET_FIELDS?= $(SCG_UI_VIEW_MANAGEDPRODUCT_FIELDS)
SCG_UI_VIEW_MANAGEDPRODUCTS_SET_SLICE?=

#--- Utilities

#--- MACROS
# _scg_get_deployable_product_artifact_id= $(call _scg_get_deployable_product_artifact_id_N, $(SCG_PRODUCT_ARTIFACT_NAME))
# _scg_get_deployable_product_artifact_id_N= $(call _scg_get_deployable_product_artifact_id_NI, $(1), $(SCG_PRODUCT_ID))
# _scg_get_deployable_product_artifact_id_NI= $(shell $(AWS) servicecatalog describe-product --id $(2) --query "ProvisioningArtifacts[?Name=='$(strip $(1))'].Id" --output text)
# 
# _scg_get_deployable_product_id= $(call _scg_get_deployable_product_id_N, $(SCG_PRODUCT_NAME))
# _scg_get_deployable_product_id_N= $(shell $(AWS) servicecatalog search-products --query "ProductViewSummaries[?Name=='$(strip $(1))'].ProductId" --output text)
# 
# _scg_get_deployable_product_launch_path_id= $(call _scg_get_deployable_product_launch_path_id_N, $(SCG_PRODUCT_LAUNCH_PATH_NAME))
# _scg_get_deployable_product_launch_path_id_N= $(call _scg_get_deployable_product_launch_path_id_NI, $(1), $(SCG_PRODUCT_ID))
# _scg_get_deployable_product_launch_path_id_NI= $(shell $(AWS) servicecatalog list-launch-paths $(__SCG_ACCEPT_LANGUAGE) --product-id $(2) --query "LaunchPathSummaries[?Name=='$(strip $(1))'].Id" --output text)
# 
# _scg_get_managed_product_artifact_id= $(call _scg_get_managed_product_artifact_id_N, $(SCG_PRODUCT_ARTIFACT_NAME))
# _scg_get_managed_product_artifact_id_N= $(call _scg_get_managed_product_artifact_id_NI, $(1), $(SCG_PRODUCT_ID))
# _scg_get_managed_product_artifact_id_NI= $(shell $(AWS) servicecatalog list-provisioning-artifacts --product-id $(2) --query "ProvisioningArtifactDetails[?Name=='$(strip $(1))'].Id" --output text)

_scg_get_managedproduct_id= $(call _scg_get_managedproduct_id_N, $(SCG_MANAGEDPRODUCT_NAME))
_scg_get_managedproduct_id_N= $(shell $(AWS) servicecatalog search-products-as-admin --query "ProductViewDetails[?ProductViewSummary.Name=='$(strip $(1))'].ProductViewSummary.ProductId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_scg_view_framework_macros ::
	@echo 'AWS::ServiceCataloG::Product ($(_AWS_SERVICECATALOG_PRODUCT_MK_VERSION)) macros:'
	@#echo '    _scg_get_deployable_product_artifact_id_{|N|NI}     - Get artifact ID of a deployable product (artifactName,productId)'
	@#echo '    _scg_get_deployable_product_id_{|N}                 - Get a deployable-product ID (productName)'
	@#echo '    _scg_get_deployable_product_launch_path_id_{|N|NI}  - Get a launch-path ID of a deployable product (pathName,productId)'
	@#echo '    _scg_get_managed_product_artifact_id_{|N|NI}        - Get artifact ID of a managed product (artifactName,productId)'
	@echo '    _scg_get_managedproduct_id_{|N}                     - Get a managed-product ID (productName)'
	@echo

_scg_view_framework_parameters ::
	@echo 'AWS::ServiceCataloG::Product ($(_AWS_SERVICECATALOG_PRODUCT_MK_VERSION)) parameters:'
	@#echo '    SCG_PRODUCT_DESCRIPTION=$(SCG_PRODUCT_DESCRIPTION)'
	@#echo '    SCG_PRODUCT_DISTRIBUTOR=$(SCG_PRODUCT_DISTRIBUTOR)'
	@echo '    SCG_MANAGEDPRODUCT_ID=$(SCG_MANAGEDPRODUCT_ID)'
	@#echo '    SCG_PRODUCT_LAUNCHPATH_ID=$(SCG_PRODUCT_LAUNCHPATH_ID)'
	@#echo '    SCG_PRODUCT_LAUNCHPATH_NAME=$(SCG_PRODUCT_LAUNCHPATH_NAME)'
	@echo '    SCG_MANAGEDPRODUCT_NAME=$(SCG_MANAGEDPRODUCT_NAME)'
	@#echo '    SCG_PRODUCT_OWNER=$(SCG_PRODUCT_OWNER)'
	@#echo '    SCG_PRODUCT_PORTFOLIO_ID=$(SCG_PRODUCT_PORTFOLIO_ID)'
	@#echo '    SCG_PRODUCT_PORTFOLIO_NAME=$(SCG_PRODUCT_PORTFOLIO_NAME)'
	@#echo '    SCG_PRODUCT_SUPPORT_DESCRIPTION=$(SCG_PRODUCT_SUPPORT_DESCRIPTION)'
	@#echo '    SCG_PRODUCT_SUPPORT_EMAIL=$(SCG_PRODUCT_SUPPORT_EMAIL)'
	@#echo '    SCG_PRODUCT_SUPPORT_URL=$(SCG_PRODUCT_SUPPORT_URL)'
	@#echo '    SCG_PRODUCT_TAGS_KEYVALUES=$(SCG_PRODUCT_TAGS_KEYVALUES)'
	@#echo '    SCG_PRODUCT_TYPE=$(SCG_PRODUCT_TYPE)'
	@echo '    SCG_MANAGEDPRODUCTS_SET_NAME=$(SCG_MANAGEDPRODUCTS_SET_NAME)'
	@echo

_scg_view_framework_targets ::
	@echo 'AWS::ServiceCataloG::ManagedProduct ($(_AWS_SERVICECATALOG_MANAGEDPRODUCT_MK_VERSION)) targets:'
	@#echo '    _scg_associate_product_with_portfolio      - Associate product with portfolio'
	@#echo '    _scg_create_product                        - Create a new product'
	@#echo '    _scg_delete_product                        - Delete a product'
	@#echo '    _scg_disassociate_product_from_portfolio   - Disassociate a product from portfolio'
	@echo '    _scg_show_managedproduct                    - Show everything related to a product'
	@echo '    _scg_show_managedproduct_description        - Show the description of a product'
	@#echo '    _scg_show_product_launchpaths              - Show the launch-paths of a product'
	@#echo '    _scg_show_managed_product                  - Show details of a managed product'
	@#echo '    _scg_show_product_artifacts                - Show artifacts of a product'
	@#echo '    _scg_show_product_constraints              - Show constraints for a product'
	@#echo '    _scg_show_product_portfolios               - Show portfolios that offer product'
	@echo '    _scg_view_managedproducts                   - View all managed-products'
	@echo '    _scg_view_managedproducts_set               - View set of managed-products'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_scg_show_managedproduct :: _scg_show_managedproduct_description

_scg_show_managedproduct_description:
	@$(INFO) '$(SCG_UI_LABEL)Showing description of managed-product "$(SCG_MANAGEDPRODUCT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Admin view ==> You can manage the below-listed product, but not necessarily deploy it!'; $(NORMAL) 
	$(AWS) servicecatalog describe-product-as-admin $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ID_MANAGEDPRODUCT)

_scg_view_managedproducts:
	@$(INFO) '$(SCG_UI_LABEL)Viewing ALL managed-products ...'; $(NORMAL)
	@$(WARN) 'Admin view ==> You can manage the below-listed products, but not necessarily deploy them!'; $(NORMAL) 
	$(AWS) servicecatalog search-products-as-admin --query "ProductViewDetails[]$(SCG_UI_VIEW_MANAGED_PRODUCTS_FIELDS)"

_scg_view_managedproducts_set:
	@$(INFO) '$(SCG_UI_LABEL)Viewing managed-products-set "$(SCG_MANAGEDPRODUCTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Manged-products are grouped based on the provided slice'; $(NORMAL)
	$(AWS) servicecatalog search-products-as-admin --query "ProductViewDetails[$(SCG_MANAGEDPRODUCTS_SET_SLICE)]$(SCG_UI_VIEW_MANAGEDPRODUCTS_SET_FIELDS)"
