_AWS_SERVICECATALOG_PLAN_MK_VERSION=$(_AWS_SERVICECATALOG_MK_VERSION)

# SCG_PLAN_NAME?= my-plan
# SCG_PLAN_PATH_ID?= lp-5jpilwc4n7flc
# SCG_PLAN_TAGS?= Key=string,Value=string ...
SCG_PLAN_TYPE?= CLOUDFORMATION

# Derived variables
SCG_PLAN_PATH_ID?= $(SCG_PRODUCT_LAUNCH_PATH_ID)

# Options variables
__SCG_PATH_ID_PLAN?= $(if $(SCG_PLAN_PATH_ID), --path-id $(SCG_PLAN_PATH_ID))
__SCG_PLAN_NAME?= $(if $(SCG_PLAN_NAME), --plan-name $(SCG_PLAN_NAME))
__SCG_PLAN_TYPE?= $(if $(SCG_PLAN_TYPE), --plan-type $(SCG_PLAN_TYPE))
__SCG_TAGS_PLAN?= $(if $(SCG_PLAN_TAGS), --tags $(SCG_PLAN_TAGS))

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_scg_view_makefile_macros ::
	@echo "AWS::ServiceCataloG::Plan ($(_AWS_SERVICECATALOG_PLAN_MK_VERSION)) macros:"
	@echo

_scg_view_makefile_targets ::
	@echo "AWS::ServiceCataloG::Plan ($(_AWS_SERVICECATALOG_PLAN_MK_VERSION)) targets:"
	@echo "    _scg_create_plan                           - Create a provisioned product plan"
	@echo "    _scg_delete_plan                           - Delete a provisioned product plan"
	@echo "    _scg_show_plan                             - Show details of a provisioned product plan"
	@echo "    _scg_view_plans                            - View provisioned product plans"
	@echo 

_scg_view_makefile_variables ::
	@echo "AWS::ServiceCataloG::Plan ($(_AWS_SERVICECATALOG_PLAN_MK_VERSION)) variables:"
	@echo "    SCG_PLAN_NAME=$(SCG_PLAN_NAME)"
	@echo "    SCG_PLAN_PATH_ID=$(SCG_PLAN_PATH_ID)"
	@echo "    SCG_PLAN_TAGS=$(SCG_PLAN_TAGS)"
	@echo "    SCG_PLAN_TYPE=$(SCG_PLAN_TYPE)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_scg_create_plan:
	@$(INFO) "$(AWS_LABEL)Creating a provisioned product plan '$(SCG_PLAN_NAME)' ..."; $(NORMAL)
	@$(WARN) "Operation only permitted to product/portfolio-principals"; $(NORMAL)
	$(AWS) servicecatalog create-provisioned-product-plan $(__SCG_ACCEPT_LANGUAGE) $(__SCG_NOTIFICATION_ARNS) $(__SCG_PATH_ID_PLAN) $(__SCG_PLAN_NAME) $(__SCG_PLAN_TYPE) $(__SCG_PRODUCT_ID) $(__SCG_PROVISIONED_PRODUCT_NAME) $(__SCG_PROVISIONING_ARTIFACT_ID) $(__SCG_PROVISIONING_PARAMETERS) $(__SCG_TAGS_PLAN)

_scg_view_plans:
	@$(INFO) "$(AWS_LABEL)Viewing provisioned product plans ..."; $(NORMAL)
	$(AWS) servicecatalog list-provisioned-product-plans $(__SCG_ACCEPT_LANGUAGE) $(__SCG_PROVISION_PRODUCT_ID)
