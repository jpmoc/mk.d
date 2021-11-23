_AWS_SERVICECATALOG_MK_VERSION=0.99.6

# SCG_INPUTS_DIRPATH?= ./in/
SCG_LANGUAGE_CODE?= en
SCG_UI_LABEL?= $(AWS_UI_LABEL)

# Derived parameters
SCG_INPUTS_DIRPATH?= $(AWS_INPUTS_DIRPATH)

# Options
__SCG_ACCEPT_LANGUAGE= $(if $(SCG_LANGUAGE_CODE),--accept-language $(SCG_LANGUAGE_CODE))

# Customizations

# Macros

#----------------------------------------------------------------------
# USAGE
#

_aws_list_macros :: _scg_list_macros
_scg_list_macros ::
	@#echo "AWS::ServiceCataloG:: ($(_AWS_SERVICECATALOG_MK_VERSION)) macros:"
	@#echo

_aws_list_parameters :: _scg_list_parameters
_scg_list_parameters ::
	@echo "AWS::ServiceCataloG:: ($(_AWS_SERVICECATALOG_MK_VERSION)) parameters:"
	@echo "    SCG_INPUTS_DIRPATH=$(SCG_INPUTS_DIRPATH)"
	@echo "    SCG_LANGUAGE_CODE=$(SCG_LANGUAGE_CODE)"
	@echo "    SCG_UI_LABEL=$(SCG_UI_LABEL)"
	@echo

_aws_list_targets :: _scg_list_targets
_scg_list_targets ::
	@echo "AWS::ServiceCataloG:: ($(_AWS_SERVICECATALOG_MK_VERSION)) targets:"
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIRPATH?= ./
-include $(MK_DIRPATH)aws_servicecatalog_constraint.mk 
-include $(MK_DIRPATH)aws_servicecatalog_managedproduct.mk 
-include $(MK_DIRPATH)aws_servicecatalog_portfolio.mk 
-include $(MK_DIRPATH)aws_servicecatalog_product.mk 
-include $(MK_DIRPATH)aws_servicecatalog_provisionedproduct.mk 
-include $(MK_DIRPATH)aws_servicecatalog_provisionedproductplan.mk 
-include $(MK_DIRPATH)aws_servicecatalog_provisioningartifact.mk 
-include $(MK_DIRPATH)aws_servicecatalog_record.mk 
-include $(MK_DIRPATH)aws_servicecatalog_share.mk 
-include $(MK_DIRPATH)aws_servicecatalog_tagoption.mk 

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

