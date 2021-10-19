_AWS_SERVICECATALOG_SHARE_MK_VERSION?= $(_AWS_SERVICECATALOG_MK_VERSION)

# SCG_EXPORT_ACCOUNT_ID?= 123456789012
# SCG_IMPORT_ACCOUNT_ID?= 123456789012

# Derived parameters
SCG_EXPORT_PORTFOLIO_ID?= $(SCG_PORTFOLIO_ID)
SCG_EXPORT_PORTFOLIO_NAME?= $(SCG_PORTFOLIO_NAME)
SCG_IMPORT_PORTFOLIO_ID?= $(SCG_PORTFOLIO_ID)
SCG_IMPORT_PORTFOLIO_NAME?= $(SCG_PORTFOLIO_NAME)

# Options parameters
__SCG_ACCOUNT_ID?= $(if $(SCG_EXPORT_ACCOUNT_ID),--account-id $(SCG_EXPORT_ACCOUNT_ID))
__SCG_PORTFOLIO_ID_EXPORT?= $(if $(SCG_EXPORT_PORTFOLIO_ID),--portfolio-id $(SCG_EXPORT_PORTFOLIO_ID))
__SCG_PORTFOLIO_ID_IMPORT?= $(if $(SCG_IMPORT_PORTFOLIO_ID),--portfolio-id $(SCG_IMPORT_PORTFOLIO_ID))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_scg_view_framework_macros ::
	@echo 'AWS::ServiceCataloG::Share ($(_AWS_SERVICECATALOG_SHARE_MK_VERSION)) macros:'
	@echo

_scg_view_framework_parameters ::
	@echo 'AWS::ServiceCataloG::Share ($(_AWS_SERVICECATALOG_SHARE_MK_VERSION)) parameters:'
	@echo '    SCG_EXPORT_ACCOUNT_ID=$(SCG_EXPORT_ACCOUNT_ID)'
	@echo '    SCG_EXPORT_PORTFOLIO_ID=$(SCG_EXPORT_PORTFOLIO_ID)'
	@echo '    SCG_EXPORT_PORTFOLIO_NAME=$(SCG_EXPORT_PORTFOLIO_NAME)'
	@echo

_scg_view_framework_targets ::
	@echo 'AWS::ServiceCataloG::Share ($(_AWS_SERVICECATALOG_SHARE_MK_VERSION)) targets:'
	@echo '    _scg_accept_invitation                      - Accept invitation to access a remote portfolio'
	@echo '    _scg_share_portfolio                        - Share a portfolio with another AWS account'
	@echo '    _scg_revoke_portfolio_share                 - Stop sharing a portfolio with another AWS account'
	@echo '    _scg_reject_invitation                      - Reject invitation to access to a remote portfolio'
	@echo '    _scg_view_imported_portfolios               - View portfolios shared with this account'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_scg_accept_invitation:
	@$(INFO) '$(SCG_UI_LABEL)Accepting access to a remote portfolio "$(SCG_IMPORT_PORTFOLIO_NAME)" from AWS account ID "$(SCG_IMPORT_ACCOUNT_ID)" ...'; $(NORMAL)
	@$(WARN) 'An invitation to use the remote portfolio must first be sent from the other AWS account!'; $(NORMAL)
	$(AWS) servicecatalog accept-portfolio-share $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PORTFOLIO_ID_IMPORT)

_scg_revoke_portfolio_share:
	@$(INFO) '$(SCG_UI_LABEL)Revoking access to portfolio "$(SCG_EXPORT_PORTFOLIO_NAME)" from AWS account ID "$(SCG_EXPORT_ACCOUNT_ID)" ...'; $(NORMAL)
	$(AWS) servicecatalog delete-portfolio-share $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ACCOUNT_ID) $(__SCG_PORTFOLIO_ID_EXPORT)

_scg_reject_invitation:
	@$(INFO) '$(SCG_UI_LABEL)Rejecting access to a remote portfolio "$(SCG_IMPORT_PORTFOLIO_NAME)" from AWS account ID "$(SCG_IMPORT_ACCOUNT_ID)" ...'; $(NORMAL)
	$(AWS) servicecatalog reject-portfolio-share $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PORTFOLIO_ID_IMPORT)

_scg_share_portfolio:
	@$(INFO) '$(SCG_UI_LABEL)Granting access to portfolio "$(SCG_EXPORT_PORTFOLIO_NAME)" from AWS account ID "$(SCG_EXPORT_ACCOUNT_ID)" ...'; $(NORMAL)
	@$(WARN) 'An invitation to use this portfolio has been sent and is now awaiting approval'; $(NORMAL)
	$(AWS) servicecatalog create-portfolio-share $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ACCOUNT_ID) $(__SCG_PORTFOLIO_ID_EXPORT)

_scg_view_imported_portfolios:
	@$(INFO) '$(SCG_UI_LABEL)Viewing portfolios which are shared with this account ...'; $(NORMAL)
	$(AWS) servicecatalog list-accepted-portfolio-shares $(__SCG_ACCEPT_LANGUAGE)
