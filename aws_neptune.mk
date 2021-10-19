_AWS_NEPTUNE_MK_VERSION= 0.99.6

# GCR_ACCOUNT_ID?= -

# Derived parameters

# Options parameters

# UI parameters
NTE_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _nte_view_framework_macros
_nte_view_framework_macros ::
	@#echo 'AWS::NepTune ($(_AWS_NEPTUNE_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _nte_view_framework_parameters
_nte_view_framework_parameters ::
	@#echo 'AWS::NepTune ($(_AWS_NEPTUNE_MK_VERSION)) parameters:'
	@#echo

_aws_view_framework_targets :: _nte_view_framework_targets
_nte_view_framework_targets ::
	@#echo 'AWS::NepTune ($(_AWS_NEPTUNE_MK_VERSION)) targets:'
	@#echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_neptune_dbcluster.mk
-include $(MK_DIR)/aws_neptune_dbclusterparametergroup.mk
-include $(MK_DIR)/aws_neptune_dbclustersnapshot.mk
-include $(MK_DIR)/aws_neptune_dbinstance.mk
-include $(MK_DIR)/aws_neptune_dbparametergroup.mk
-include $(MK_DIR)/aws_neptune_dbsubnetgroup.mk
-include $(MK_DIR)/aws_neptune_eventsubscription.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
