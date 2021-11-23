_AWS_SERVICECATALOG_PORTFOLIO_MK_VERSION?= $(_AWS_SERVICECATALOG_MK_VERSION)

# SCG_PORTFOLIO_ARN?= arn:aws:catalog:us-west-2:123456789012:portfolio/port-4drvqlsywjtu4
# SCG_PORTFOLIO_DESCRIPTION?= "This is my portfolio description"
# SCG_PORTFOLIO_ID?= port-4drvqlsywjtu4
# SCG_PORTFOLIO_NAME?= my-portfolio
# SCG_PORTFOLIO_PRINCIPAL_ARN?= 
# SCG_PORTFOLIO_PRINCIPALS_ARNS?= 
SCG_PORTFOLIO_PRINCIPAL_TYPE?= IAM
# SCG_PORTFOLIO_PROVIDER?= Training Team
# SCG_PORTFOLIO_TAGS_KEYVALUES?= Key=string,Value=string ...

# Derived parameters
SCG_PORTFOLIO_PRINCIPALS_ARN?= arn:aws:catalog:$(AWS_REGION_ID):$(AWS_ACCOUNT_ID):portfolio/$(SCG_PORTFOLIO_ID)
SCG_PORTFOLIO_PRINCIPALS_ARNS?= $(SCG_PORTFOLIO_PRINCIPAL_ARN)

# Options
__SCG_DESCRIPTION_PORTFOLIO?= $(if $(SCG_PORTFOLIO_DESCRIPTION),--description $(SCG_PORTFOLIO_DESCRIPTION))
__SCG_DISPLAY_NAME?= $(if $(SCG_PORTFOLIO_NAME),--display-name $(SCG_PORTFOLIO_NAME))
__SCG_ID_PORTFOLIO?= $(if $(SCG_PORTFOLIO_ID),--id $(SCG_PORTFOLIO_ID))
__SCG_PORTFOLIO_ID?= $(if $(SCG_PORTFOLIO_ID),--portfolio-id $(SCG_PORTFOLIO_ID))
__SCG_PRINCIPAL_ARN?= $(if $(SCG_PORTFOLIO_PRINCIPAL_ARN),--principal-arn $(SCG_PORTFOLIO_PRINCIPAL_ARN))
__SCG_PRINCIPAL_TYPE?= $(if $(SCG_PORTFOLIO_PRINCIPAL_TYPE),--principal-type $(SCG_PORTFOLIO_PRINCIPAL_TYPE))
__SCG_PROVIDER_NAME?= $(if $(SCG_PORTFOLIO_PROVIDER),--provider-name '$(SCG_PORTFOLIO_PROVIDER)')
__SCG_TAGS_PORTFOLIO?= $(if $(SCG_PORTFOLIO_TAGS),--tags $(SCG_PORTFOLIO_TAGS))

# Customizations
_SCG_LIST_PORTFOLIOS_FIELDS?= .{Id:Id,DisplayName:DisplayName,ProviderName:ProviderName,description:Description}

# Macros
_scg_get_portfolio_id= $(call _scg_get_portfolio_id_N, $(SCG_PORTFOLIO_NAME))
_scg_get_portfolio_id_N= $(shell $(AWS) servicecatalog list-portfolios --query "PortfolioDetails[?DisplayName=='$(strip $(1))'].Id" --output text)

#----------------------------------------------------------------------
# USAGE
#

_scg_list_macros ::
	@echo 'AWS::ServiceCataloG::Portfolio ($(_AWS_SERVICECATALOG_PORTFOLIO_MK_VERSION)) macros:'
	@echo '    _scg_get_portfolio_id_{|N}                 - Get portfolio ID (portfolioName)'
	@echo

_scg_list_parameters ::
	@echo 'AWS::ServiceCataloG::Portfolio ($(_AWS_SERVICECATALOG_PORTFOLIO_MK_VERSION)) parameters:'
	@echo '    SCG_PORTFOLIO_DESCRIPTION=$(SCG_PORTFOLIO_DESCRIPTION)'
	@echo '    SCG_PORTFOLIO_ID=$(SCG_PORTFOLIO_ID)'
	@echo '    SCG_PORTFOLIO_NAME=$(SCG_PORTFOLIO_NAME)'
	@echo '    SCG_PORTFOLIO_PRINCIPAL_ARN=$(SCG_PORTFOLIO_PRINCIPAL_ARN)'
	@echo '    SCG_PORTFOLIO_PRINCIPAL_TYPE=$(SCG_PORTFOLIO_PRINCIPAL_TYPE)'
	@echo '    SCG_PORTFOLIO_PROVIDER=$(SCG_PORTFOLIO_PROVIDER)'
	@echo '    SCG_PORTFOLIO_TAGS_KEYVALUES=$(SCG_PORTFOLIO_TAGS_KEYVALUES)'
	@echo

_scg_list_targets ::
	@echo 'AWS::ServiceCataloG::Portfolio ($(_AWS_SERVICECATALOG_PORTFOLIO_MK_VERSION)) targets:'
	@echo '    _scg_add_portfolio_principal               - Associate a principal to portfolio'
	@echo '    _scg_create_portfolio                      - Create a new portfolio'
	@echo '    _scg_delete_portfolio                      - Delete a portfolio'
	@echo '    _scg_list_portfolios                       - List all portfolios'
	@echo '    _scg_list_portfolios_set                   - List a set of portfolios'
	@echo '    _scg_show_portfolio                        - Show details of a portfolio'
	@echo '    _scg_show_portfolio_constraints            - Show constraints of a portfolio'
	@echo '    _scg_show_portfolio_principals             - Show principals of a portfolio'
	@echo '    _scg_tag_portfolio                         - Tag a portfolio'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_scg_add_portfolio_principal:
	@$(INFO) '$(SCG_UI_LABEL)Associate principal with portfolio "$(SCG_PORTFOLIO_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog associate-principal-with-portfolio $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PORTFOLIO_ID) $(__SCG_PRINCIPAL_ARN) $(__SCG_PRINCIPAL_TYPE)	

_scg_create_portfolio:
	@$(INFO) '$(SCG_UI_LABEL)Creating portfolio "$(SCG_PORTFOLIO_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog create-portfolio $(__SCG_ACCEPT_LANGUAGE) $(__SCG_DESCRIPTION_PORTFOLIO) $(__SCG_DISPLAY_NAME) $(__SCG_PROVIDER_NAME) $(__SCG_TAGS_PORTFOLIO)

_scg_delete_portfolio:
	@$(INFO) '$(SCG_UI_LABEL)Deleting portfolio "$(SCG_PORTFOLIO_NAME)" ...'; $(NORMAL)
	@$(WARN) 'To be deleted, the portfolio should not have any product'; $(NORMAL)
	$(AWS) servicecatalog delete-portfolio $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ID_PORTFOLIO)

_scg_remove_portfolio_principal:
	@$(INFO) '$(SCG_UI_LABEL)Diassociate principal from portfolio "$(SCG_PORTFOLIO_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog disassociate-principal-from-portfolio $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PORTFOLIO_ID) $(__SCG_PRINCIPAL_ARN)

_scg_list_portfolios:
	@$(INFO) '$(SCG_UI_LABEL)Listing available portfolios ...'; $(NORMAL)
	$(AWS) servicecatalog list-portfolios $(__SCG_ACCEPT_LANGUAGE) --query "PortfolioDetails[]$(_SCG_LIST_PORTFOLIOS_FIELDS)"

_scg_list_portfolios_set:
	@$(INFO) '$(SCG_UI_LABEL)Listing portfolios-set "SCG_PORTFOLIOS_SET_NAME)" ...'; $(NORMAL)

_SCG_SHOW_PORTFOLIO_TARGETS?= _scg_show_portfolio_constraints _scg_show_portfolio_principals _scg_show_portfolio_description
_scg_show_portfolio: $(_SCG_SHOW_PORTFOLIO_TARGETS)

_scg_show_portfolio_constraints:
	@$(INFO) '$(SCG_UI_LABEL)Showing configured constraints in portfolio "$(SCG_PORTFOLIO_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Constraints are applied to products at the time of provisioning'; $(NORMAL)
	-$(AWS) servicecatalog list-constraints-for-portfolio $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PORTFOLIO_ID) $(_X__SCG_PRODUCT_ID)

_scg_show_portfolio_description:
	@$(INFO) '$(SCG_UI_LABEL)Showing portfolio "$(SCG_PORTFOLIO_NAME)" ...'; $(NORMAL)
	-$(AWS) servicecatalog describe-portfolio $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ID_PORTFOLIO)

_scg_show_portfolio_principals:
	@$(INFO) '$(SCG_UI_LABEL)Showing principals of portfolio "$(SCG_PORTFOLIO_NAME)" ...'; $(NORMAL)
	-$(AWS) servicecatalog list-principals-for-portfolio $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PORTFOLIO_ID) --query "Principals[]"

_scg_tag_portfolio:
	@$(INFO) '$(SCG_UI_LABEL)Tagging portfolio "$(SCG_PORTFOLIO_NAME)" ...'; $(NORMAL)
