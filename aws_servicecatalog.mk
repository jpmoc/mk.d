_AWS_SERVICECATALOG_MK_VERSION=0.99.6

# SCG_INPUTS_DIRPATH?= ./in/
SCG_LANGUAGE_CODE?= en

# Derived parameters
SCG_INPUTS_DIRPATH?= $(AWS_INPUTS_DIRPATH)

# Options parameters
__SCG_ACCEPT_LANGUAGE= $(if $(SCG_LANGUAGE_CODE), --accept-language $(SCG_LANGUAGE_CODE))

# UI parameters
SCG_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- MACROS


#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _scg_view_framework_macros
_scg_view_framework_macros ::
	@echo "AWS::ServiceCataloG ($(_AWS_SERVICECATALOG_MK_VERSION)) macros:"
	@echo

_aws_view_framework_parameters :: _scg_view_framework_parameters
_scg_view_framework_parameters ::
	@echo "AWS::ServiceCataloG ($(_AWS_SERVICECATALOG_MK_VERSION)) parameters:"
	@echo "    SCG_INPUTS_DIRPATH=$(SCG_INPUTS_DIRPATH)"
	@echo "    SCG_LANGUAGE_CODE=$(SCG_LANGUAGE_CODE)"
	@echo

_aws_view_framework_targets :: _scg_view_framework_targets
_scg_view_framework_targets ::
	@echo "AWS::ServiceCataloG ($(_AWS_SERVICECATALOG_MK_VERSION)) targets:"
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_servicecatalog_constraint.mk 
-include $(MK_DIR)/aws_servicecatalog_managedproduct.mk 
-include $(MK_DIR)/aws_servicecatalog_portfolio.mk 
-include $(MK_DIR)/aws_servicecatalog_product.mk 
-include $(MK_DIR)/aws_servicecatalog_provisionedproduct.mk 
-include $(MK_DIR)/aws_servicecatalog_provisionedproductplan.mk 
-include $(MK_DIR)/aws_servicecatalog_provisioningartifact.mk 
-include $(MK_DIR)/aws_servicecatalog_record.mk 
-include $(MK_DIR)/aws_servicecatalog_share.mk 
-include $(MK_DIR)/aws_servicecatalog_tagoption.mk 

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

