_AWS_SERVICECATALOG_PRODUCT_MK_VERSION=$(_AWS_SERVICECATALOG_MK_VERSION)

# SCG_PRODUCT_DESCRIPTION?=
# SCG_PRODUCT_DISTRIBUTOR?=
# SCG_PRODUCT_ID?= prod-3kgrq2rxelnzw
# SCG_PRODUCT_LAUNCHPATH_ID?= lpv2-5jpilwc4n7flc
# SCG_PRODUCT_LAUNCHPATH_NAME?= Training_Portfolio
# SCG_PRODUCT_NAME?= my-product
# SCG_PRODUCT_OWNER?=
# SCG_PRODUCT_PROTFOLIO_ID?=
# SCG_PRODUCT_SUPPORT_DESCRIPTION?=
# SCG_PRODUCT_SUPPORT_EMAIL?=
# SCG_PRODUCT_SUPPORT_URL?=
# SCG_PRODUCT_TAGS_KEYVALUES?= Key=string,Value=string ...
# SCG_PRODUCT_TYPE?= CLOUD_FORMATION_TEMPLATE
SCG_PRODUCTS_PAGE_SIZE?= 20
# SCG_PRODUCTS_PAGE_TOKEN?=
# SCG_PRODUCTS_SET_NAME?= my-products-set

# Derived parameters
SCG_PRODUCT_PORTFOLIO_ID?= $(SCG_PORTFOLIO_ID)

# Options parameters
__SCG_ID__PRODUCT= $(if $(SCG_PRODUCT_ID),--id $(SCG_PRODUCT_ID))
__SCG_NAME__PRODUCT= $(if $(SCG_PRODUCT_NAME),--name $(SCG_PRODUCT_NAME))
__SCG_OWNER__PRODUCT= $(if $(SCG_PRODUCT_OWNER),--owner '$(SCG_PRODUCT_OWNER)')
__SCG_PAGE_SIZE__PRODUCTS= $(if $(SCG_PRODUCTS_PAGE_SIZE),--page-size $(SCG_PRODUCTS_PAGE_SIZE))
__SCG_PAGE_TOKEN__PRODUCTS= $(if $(SCG_PRODUCTS_PAGE_TOKEN),--page-token $(SCG_PRODUCTS_PAGE_TOKEN))
__SCG_PATH_ID= $(if $(SCG_PRODUCT_LAUNCH_PATH_ID),--path-id $(SCG_PRODUCT_LAUNCH_PATH_ID))
__SCG_PORTFOLIO_ID__PRODUCT= $(if $(SCG_PRODUCT_PORTFOLIO_ID),--portfolio-id $(SCG_PRODUCT_PORTFOLIO_ID))
__SCG_PRODUCT_TYPE= $(if $(SCG_PRODUCT_TYPE),--product-type $(SCG_PRODUCT_TYPE))
__SCG_PRODUCT_ID= $(if $(SCG_PRODUCT_ID),--product-id $(SCG_PRODUCT_ID))
__SCG_PROVISIONING_ARTIFACT_ID= $(if $(SCG_PRODUCT_ARTIFACT_ID),--provisioning-artifact-id $(SCG_PRODUCT_ARTIFACT_ID))
__SCG_PROVISIONING_ARTIFACT_PARAMETERS= $(if $(SCG_PRODUCT_ARTIFACT_PARAMETERS),--provisioning-artifact-parameters $(SCG_PRODUCT_ARTIFACT_PARAMETERS))
__SCG_SUPPORT_DESCRIPTION= $(if $(SCG_PRODUCT_SUPPORT_DESCRIPTION),--support-description '$(SCG_PRODUCT_SUPPORT_DESCRIPTION)')
__SCG_SUPPORT_EMAIL= $(if $(SCG_PRODUCT_SUPPORT_EMAIL),--support-email $(SCG_PRODUCT_SUPPORT_EMAIL))
__SCG_SUPPORT_URL= $(if $(SCG_PRODUCT_SUPPORT_URL),--support-url $(SCG_PRODUCT_SUPPORT_URL))
__SCG_TAGS__PRODUCT= $(if $(SCG_PRODUCT_TAGS_KEYVALUES),--tags $(SCG_PRODUCT_TAGS_KEYVALUES))

# UI parameters
SCG_UI_SHOW_PRODUCT_LAUNCHPATHS_FIELDS?= .{Id:Id,constraintType:join(' + ', sort(ConstraintSummaries[].Type)),Name:Name}
SCG_UI_SHOW_PRODUCT_PORTFOLIOS_FIELDS?= .{Id:Id,DisplayName:DisplayName,ProviderName:ProviderName,description:Description}
SCG_UI_SHOW_PRODUCT_PROVISIONINGARTIFACTS_FIELDS?= .{Id:Id,Name:Name,description:Description,type:Type,active:Active,createdTime:CreatedTime}
SCG_UI_VIEW_PRODUCTS_FIELDS?= .{Name:Name,ProductId:ProductId,hasDefaultPath:HasDefaultPath,id:Id,owner:Owner,supportEmail:SupportEmail}
SCG_UI_VIEW_PRODUCTS_SET_FIELDS?= $(SCG_UI_VIEW_PRODUCTS_FIELDS)
SCG_UI_VIEW_PRODUCTS_SET_QUERYFILTER?=

#--- Utilities

#--- MACROS
_scg_get_product_provisioningartifact_id= $(call _scg_get_product_provisioningartifact_id_N, $(SCG_PRODUCT_ARTIFACT_NAME))
_scg_get_product_provisioningartifact_id_N= $(call _scg_get_product_provisioningartifact_id_NI, $(1), $(SCG_PRODUCT_ID))
_scg_get_product_provisioningartifact_id_NI= $(shell $(AWS) servicecatalog describe-product --id $(2) --query "ProvisioningArtifacts[?Name=='$(strip $(1))'].Id" --output text)

_scg_get_product_id= $(call _scg_get_product_id_N, $(SCG_PRODUCT_NAME))
_scg_get_product_id_N= $(shell $(AWS) servicecatalog search-products --query "ProductViewSummaries[?Name=='$(strip $(1))'].ProductId" --output text)

_scg_get_product_launchpath_id= $(call _scg_get_product_launchpath_id_N, $(SCG_PRODUCT_LAUNCHPATH_NAME))
_scg_get_product_launchpath_id_N= $(call _scg_get_product_launchpath_id_NI, $(1), $(SCG_PRODUCT_ID))
_scg_get_product_launchpath_id_NI= $(shell $(AWS) servicecatalog list-launch-paths $(__SCG_ACCEPT_LANGUAGE) --product-id $(2) --query "LaunchPathSummaries[?Name=='$(strip $(1))'].Id" --output text)

#----------------------------------------------------------------------
# USAGE
#

_scg_view_framework_macros ::
	@echo 'AWS::ServiceCataloG::Product ($(_AWS_SERVICECATALOG_PRODUCT_MK_VERSION)) macros:'
	@echo '    _scg_get_product_artifact_id_{|N|NI}     - Get the ID of provisioning-artifact for a product (artifactName,productId)'
	@echo '    _scg_get_product_id_{|N}                 - Get the ID of a product ID (productName)'
	@echo '    _scg_get_product_launchpath_id_{|N|NI}   - Get the launch-path ID for a product (pathName,productId)'
	@echo

_scg_view_framework_parameters ::
	@echo 'AWS::ServiceCataloG::Product ($(_AWS_SERVICECATALOG_PRODUCT_MK_VERSION)) parameters:'
	@echo '    SCG_PRODUCT_DESCRIPTION=$(SCG_PRODUCT_DESCRIPTION)'
	@echo '    SCG_PRODUCT_DISTRIBUTOR=$(SCG_PRODUCT_DISTRIBUTOR)'
	@echo '    SCG_PRODUCT_ID=$(SCG_PRODUCT_ID)'
	@echo '    SCG_PRODUCT_LAUNCHPATH_ID=$(SCG_PRODUCT_LAUNCHPATH_ID)'
	@echo '    SCG_PRODUCT_LAUNCHPATH_NAME=$(SCG_PRODUCT_LAUNCHPATH_NAME)'
	@echo '    SCG_PRODUCT_NAME=$(SCG_PRODUCT_NAME)'
	@echo '    SCG_PRODUCT_OWNER=$(SCG_PRODUCT_OWNER)'
	@echo '    SCG_PRODUCT_PORTFOLIO_ID=$(SCG_PRODUCT_PORTFOLIO_ID)'
	@echo '    SCG_PRODUCT_PORTFOLIO_NAME=$(SCG_PRODUCT_PORTFOLIO_NAME)'
	@echo '    SCG_PRODUCT_SUPPORT_DESCRIPTION=$(SCG_PRODUCT_SUPPORT_DESCRIPTION)'
	@echo '    SCG_PRODUCT_SUPPORT_EMAIL=$(SCG_PRODUCT_SUPPORT_EMAIL)'
	@echo '    SCG_PRODUCT_SUPPORT_URL=$(SCG_PRODUCT_SUPPORT_URL)'
	@echo '    SCG_PRODUCT_TAGS_KEYVALUES=$(SCG_PRODUCT_TAGS_KEYVALUES)'
	@echo '    SCG_PRODUCT_TYPE=$(SCG_PRODUCT_TYPE)'
	@echo '    SCG_PRODUCTS_PAGE_SIZE=$(SCG_PRODUCTS_PAGE_SIZE)'
	@echo '    SCG_PRODUCTS_SET_NAME=$(SCG_PRODUCTS_SET_NAME)'
	@echo

_scg_view_framework_targets ::
	@echo 'AWS::ServiceCataloG::Product ($(_AWS_SERVICECATALOG_PRODUCT_MK_VERSION)) targets:'
	@echo '    _scg_associate_product_with_portfolio      - Associate product with portfolio'
	@echo '    _scg_create_product                        - Create a new product'
	@echo '    _scg_delete_product                        - Delete a product'
	@echo '    _scg_disassociate_product_from_portfolio   - Disassociate a product from portfolio'
	@echo '    _scg_show_product                          - Show everything related to a product'
	@echo '    _scg_show_product_constraints              - Show constraints for a product'
	@echo '    _scg_show_product_description              - Show the description of a product'
	@echo '    _scg_show_product_launchpaths              - Show the launch-paths of a product'
	@echo '    _scg_show_product_portfolios               - Show portfolios that offer product'
	@echo '    _scg_show_product_provisioningartifacts    - Show provisioning-artifacts of a product'
	@echo '    _scg_view_products                         - View all products'
	@echo '    _scg_view_products_set                     - View set of products'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_scg_associate_product_with_portfolio:
	@$(INFO) '$(SCG_UI_LABEL)Associating product "$(SCG_PRODUCT_NAME)" with portfolio "$(SCG_PRODUCT_PORTFOLIO_NAME)" ...'; $(NORMAL)
	$(AWS)  servicecatalog associate-product-with-portfolio $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PRODUCT_ID) $(__SCG_PORTFOLIO_ID__PRODUCT) $(__SCG_SOURCE_PORTFOLIO_ID)

_scg_create_product:
	@$(INFO) '$(SCG_UI_LABEL)Creating product "$(SCG_PRODUCT_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog create-product $(__SCG_ACCEPT_LANGUAGE) $(__SCG_DESCRIPTION_PRODUCT) $(__SCG_DISTRIBUTOR) $(__SCG_NAME__PRODUCT) $(__SCG_OWNER__PRODUCT) $(__SCG_PRODUCT_TYPE) $(__SCG_PROVISIONING_ARTIFACT_PARAMETERS) $(__SCG_SUPPORT_DESCRIPTION) $(__SCG_SUPPORT_EMAIL) $(__SCG_SUPPORT_URL) $(__SCG_TAGS__PRODUCT)
	@$(WARN) 'The creation process takes a few seconds ...'; $(NORMAL)
	sleep 5

_scg_delete_product:
	@$(INFO) '$(SCG_UI_LABEL)Deleting product "$(SCG_PRODUCT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Before deleting the product, you must disassociate it from its portfolios'; $(NORMAL)
	$(AWS) servicecatalog delete-product $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ID__PRODUCT)

_scg_disassociate_product_from_portfolio:
	@$(INFO) '$(SCG_UI_LABEL)Disassociating product "$(SCG_PRODUCT_NAME)" from portfolio "$(SCG_PRODUCT_PORTFOLIO_NAME)" ...'; $(NORMAL)
	$(AWS)  servicecatalog disassociate-product-from-portfolio $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PRODUCT_ID) $(__SCG_PORTFOLIO_ID__PRODUCT) $(__SCG_SOURCE_PORTFOLIO_ID)

_scg_show_product: _scg_show_product_constraints _scg_show_product_launchpaths _scg_show_product_portfolios _scg_show_product_provisioningartifacts _scg_show_product_description

_scg_show_product_constraints:
	@$(INFO) '$(SCG_UI_LABEL)Showing constraints for product "$(SCG_PRODUCT_NAME)" ...'; $(NORMAL)
	-$(AWS) servicecatalog list-constraints-for-portfolio $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PORTFOLIO_ID__PRODUCT) $(__SCG_PRODUCT_ID)

_scg_show_product_description:
	@$(INFO) '$(SCG_UI_LABEL)Showing description of product "$(SCG_PRODUCT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'User view ==> You can deploy the below-listed product, but not necessarily manage it!'; $(NORMAL) 
	-$(AWS) servicecatalog describe-product $(__SCG_ACCEPT_LANGUAGE) \
		$(if $(SCG_PRODUCT_ID),$(__SCG_ID__PRODUCT),$(__SCG_NAME__PRODUCT))

_scg_show_product_launchpaths:
	@$(INFO) '$(SCG_UI_LABEL)Showing launch-paths of product "$(SCG_PRODUCT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is only available to portfolio-principals'; $(NORMAL)
	-$(AWS) servicecatalog list-launch-paths $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PRODUCT_ID) --query "LaunchPathSummaries[]$(SCG_UI_SHOW_PRODUCT_LAUNCHPATHS_FIELDS)"

_scg_show_product_portfolios:
	@$(INFO) '$(SCG_UI_LABEL)Showing portfolios of product "$(SCG_PRODUCT_NAME)" ...'; $(NORMAL)
	-$(AWS) servicecatalog list-portfolios-for-product $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PRODUCT_ID) --query "PortfolioDetails[]$(SCG_UI_SHOW_PRODUCT_PORTFOLIOS_FIELDS)"

_scg_show_product_provisioningartifacts:
	@$(INFO) '$(SCG_UI_LABEL)Showing provisioning-artifacts of product "$(SCG_PRODUCT_NAME)" ...'; $(NORMAL)
	-$(AWS) servicecatalog list-provisioning-artifacts $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PRODUCT_ID) --query "ProvisioningArtifactDetails[]$(SCG_UI_SHOW_PRODUCT_PROVISIONINGARTIFACTS_FIELDS)"

_scg_view_products:
	@$(INFO) '$(SCG_UI_LABEL)Viewing ALL products ...'; $(NORMAL)
	@$(WARN) 'This operation is paginated'; $(NORMAL)
	$(AWS) servicecatalog search-products $(__SCG_PAGE_SIZE__PRODUCTS) $(__SCG_PAGE_TOKEN__PRODUCTS) --query "ProductViewSummaries[]$(SCG_UI_VIEW_PRODUCTS_FIELDS)"

_scg_view_products_set:
	@$(INFO) '$(SCG_UI_LABEL)Viewing products-set "$(SCG_PRODUCTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Products are grouped based on the provided query-filter'; $(NORMAL)
	@$(WARN) 'This operation is paginated'; $(NORMAL)
	$(AWS) servicecatalog search-products $(__SCG_PAGE_SIZE__PRODUCTS) $(__SCG_PAGE_TOKEN__PRODUCTS) --query "ProductViewSummaries[$(SCG_UI_VIEW_PRODUCTS_SET_QUERYFILTER)]$(SCG_UI_VIEW_PRODUCTS_SET_FIELDS)"
