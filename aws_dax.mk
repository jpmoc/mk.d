_AWS_DAX_MK_VERSION= 0.99.6

# DAX_PARAMETER?=

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _dax_view_framework_macros
_dax_view_framework_macros ::
	@#echo 'AWS::DAX ($(_AWS_DAX_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _dax_view_framework_parameters
_dax_view_framework_parameters ::
	@echo 'AWS::DAX ($(_AWS_DAX_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _dax_view_framework_targets
_dax_view_framework_targets ::
	@echo 'AWS::DAX ($(_AWS_DAX_MK_VERSION)) targets:'
	@echo '    _dax_show_defaultparameters          - Show default parameters'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_dax_cluster.mk
-include $(MK_DIR)/aws_dax_parametergroup.mk
-include $(MK_DIR)/aws_dax_subnetgroup.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dax_show_defaultparameters:
	@$(INFO) '$(AWS_UI_LABEL)Showing default parameters ...'; $(NORMAL)
	$(AWS) dax describe-default-parameters --query "Parameters[]"
