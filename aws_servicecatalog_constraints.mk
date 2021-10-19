_AWS_SERVICECATALOG_CONSTRAINT_MK_VERSION=$(_AWS_SERVICECATALOG_MK_VERSION)

# SCG_CONSTRAINT_DESCRIPTION?= This is my constraint description
# SCG_CONSTRAINT_ID?= cons-xv6nlcilybaws
# SCG_CONSTRAINT_NAME?= product-portfolio
# SCG_CONSTRAINT_PARAMETERS?=
# SCG_CONSTRAINT_PARAMETERS_FILEPATH?= ./template-constrait-rules.json
# SCG_CONSTRAINT_PORTFOLIO_ID?=
# SCG_CONSTRAINT_PRODUCT_ID?=
# SCG_CONSTRAINT_TYPE?= TEMPLATE
# SCG_CONSTRAINTS_SET_NAME?= my-constraints-set

# Derived parameters
SCG_CONSTRAINT_PARAMETERS?= $(if $(SCG_CONSTRAINT_PARAMETERS_FILEPATH), file://$(SCG_CONSTRAINT_PARAMETERS_FILEPATH))
SCG_CONSTRAINT_PORTFOLIO_ID?= $(SCG_PORTFOLIO_ID)
SCG_CONSTRAINT_PRODUCT_ID?= $(SCG_PRODUCT_ID)

# Options parameters
__SCG_DESCRIPTION__CONSTRAINT?= $(if $(SCG_CONSTRAINT_DESCRIPTION),--description '$(SCG_CONSTRAINT_DESCRIPTION)')
__SCG_ID__CONSTRAINT?= $(if $(SCG_CONSTRAINT_ID),--id $(SCG_PRODUCT_CONSTRAINT_ID))
__SCG_PARAMETERS__CONSTRAINT?= $(if $(SCG_PRODUCT_CONSTRAINT_PARAMETERS),--parameters $(SCG_CONSTRAINT_PARAMETERS))
__SCG_TYPE?= $(if $(SCG_CONSTRAINT_TYPE),--type $(SCG_CONSTRAINT_TYPE))

# UI parameters
SCG_UI_CREATE_CONSTRAINT_FIELDS?= .{ConstraintId:ConstraintDetail.ConstraintId,Type:ConstraintDetail.Type,owner:ConstraintDetail.Owner,status:Status,zdescription:ConstraintDetail.Description}
SCG_UI_SHOW_CONSTRAINT_FIELDS?= .{ConstraintId:ConstraintDetail.ConstraintId,Type:ConstraintDetail.Type,owner:ConstraintDetail.Owner,status:Status,zdescription:ConstraintDetail.Description}

#--- Utilities

#--- MACROS
_scg_get_constraint_id= $(call _scg_get_constraint_id_T, $(SCG_CONSTRAINT_TYPE))
_scg_get_constraint_id_T= $(call _scg_get_constraint_id_TP, $(1), $(SCG_CONSTRAINT_PRODUCT_ID))
_scg_get_constraint_id_TP= $(call _scg_get_constraint_id_TPP, $(1), $(2), $(SCG_CONSTRAINT_PORTFOLIO_ID))
_scg_get_constraint_id_TPP= $(shell $(AWS) servicecatalog list-constraints-for-portfolio $(__SCG_ACCEPT_LANGUAGE) --portfolio-id $(3)  --product-id $(2) --query "ConstraintDetails[?contains(Type,'$(strip $(1))')].ConstraintId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_scg_view_framework_macros ::
	@echo 'AWS::ServiceCataloG::Constraint ($(_AWS_SERVICECATALOG_CONSTRAINT_MK_VERSION)) macros:'
	@echo '    _scg_get_constraint_id_{|T|TP|TPP}   - Get a constraint id (Type,Product,Portfolio)'
	@echo

_scg_view_framework_parameters ::
	@echo 'AWS::ServiceCataloG::Constraint ($(_AWS_SERVICECATALOG_CONSTRAINT_MK_VERSION)) parameters:'
	@echo '    SCG_CONSTRAINT_DESCRIPTION=$(SCG_CONSTRAINT_DESCRIPTION)'
	@echo '    SCG_CONSTRAINT_ID=$(SCG_CONSTRAINT_ID)'
	@echo '    SCG_CONSTRAINT_NAME=$(SCG_CONSTRAINT_NAME)'
	@echo '    SCG_CONSTRAINT_PARAMETERS=$(SCG_CONSTRAINT_PARAMETERS)'
	@echo '    SCG_CONSTRAINT_PARAMETERS_FILEPATH=$(SCG_CONSTRAINT_PARAMETERS_FILEPATH)'
	@echo '    SCG_CONSTRAINT_PORTFOLIO_ID=$(SCG_CONSTRAINT_PORTFOLIO_ID)'
	@echo '    SCG_CONSTRAINT_PRODUCT_ID=$(SCG_CONSTRAINT_PRODUCT_ID)'
	@echo '    SCG_CONSTRAINT_TYPE=$(SCG_CONSTRAINT_TYPE)'
	@echo

_scg_view_framework_targets ::
	@echo 'AWS::ServiceCataloG::Constraint ($(_AWS_SERVICECATALOG_CONSTRAINT_MK_VERSION)) targets:'
	@echo '    _scg_create_constraint                     - Create a constraint on a product'
	@echo '    _scg_delete_constraint                     - Delete a constraint'
	@echo '    _scg_show_constraint                       - Show everything related to a constraint'
	@echo '    _scg_show_constraint_description           - Show description of a constraint'
	@echo '    _scg_show_constraint_rules                 - Show rules of a constraint'
	@echo '    _scg_view_constraints                      - View all constraints'
	@echo '    _scg_view_constraints_set                  - View a set of constraints'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_scg_create_constraint:
	@$(INFO) '$(SCG_UI_LABEL)Creating product-constraint "$(SCG_CONSTRAINT_NAME)" ...'; $(NORMAL)
	$(if $(SCG_CONSTRAINT_PARAMETERS_FILEPATH), cat $(SCG_CONSTRAINT_PARAMETERS_FILEPATH))
	$(AWS) servicecatalog create-constraint $(__SCG_ACCEPT_LANGUAGE) $(__SCG_DESCRIPTION__CONSTRAINT) $(__SCG_PARAMETERS__CONSTRAINT) $(__SCG_PORTFOLIO_ID) $(__SCG_PRODUCT_ID) $(__SCG_TYPE) --query "@$(SCG_UI_CREATE_CONSTRAINT_FIELDS)"

_scg_delete_constraint:
	@$(INFO) '$(SCG_UI_LABEL)Deleting product-constraint "$(SCG_CONSTRAINT_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog delete-constraint $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ID__CONSTRAINT)

_scg_show_constraint: _scg_show_constraint_rules _scg_show_constraint_description

_scg_show_constraint_description:
	@$(INFO) '$(SCG_UI_LABEL)Showing the product-constraint "$(SCG_CONSTRAINT_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog describe-constraint $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ID__CONSTRAINT) --query "@$(SCG_UI_SHOW_PRODUCT_CONSTRAINT_FIELDS)"

_scg_show_constraint_rules:
	@$(INFO) '$(SCG_UI_LABEL)Showing rules of product-constraint "$(SCG_CONSTRAINT_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog describe-constraint $(__SCG_ACCEPT_LANGUAGE) $(__SCG_ID__CONSTRAINT) --query "@.ConstraintParameters" --output text

_scg_view_constraints:
	@$(INFO) '$(SCG_UI_LABEL)Viewing product-constraints ...'; $(NORMAL)
	@$(ERROR) 'Constraints can only be listed against a product or portfolio!'; $(NORMAL)

_scg_view_constraints_set:
	@$(INFO) '$(SCG_UI_LABEL)Viewing product-constraints-set "$(SCG_CONSTRAINTS_SET_NAME)"...'; $(NORMAL)
