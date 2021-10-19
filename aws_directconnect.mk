_AWS_DIRECTCONNECT_MK_VERSION= 0.99.0

# Derived parameters

# Options parameters

# UI parameters

#--- Commands

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _dct_view_framework_macros
_dct_view_framework_macros ::
	@echo 'AWS::DirectConnecT ($(_AWS_DIRECTCONNECT_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _dct_view_framework_parameters
_dct_view_framework_parameters ::
	@echo 'AWS::DirectConnecT ($(_AWS_DIRECTCONNECT_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _dct_view_framework_targets
_dct_view_framework_targets ::
	@echo 'AWS::DirectConnecT ($(_AWS_DIRECTCONNECT_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_directconnect_bgppeer.mk
-include $(MK_DIR)/aws_directconnect_connection.mk
-include $(MK_DIR)/aws_directconnect_gateway.mk
-include $(MK_DIR)/aws_directconnect_gatewayassociation.mk
-include $(MK_DIR)/aws_directconnect_interconnect.mk
-include $(MK_DIR)/aws_directconnect_lag.mk
-include $(MK_DIR)/aws_directconnect_privatevirtualinterface.mk
-include $(MK_DIR)/aws_directconnect_publicvirtualinterface.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

