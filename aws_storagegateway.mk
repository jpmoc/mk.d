_AWS_STORAGEGATEWAY_MK_VERSION= 0.99.6

# SGY_PARAMETER?=

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _sgy_view_framework_macros
_sgy_view_framework_macros ::
	@echo 'AWS::StorageGatewaY ($(_AWS_STORAGEGATEWAY_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _sgy_view_framework_parameters
_sgy_view_framework_parameters ::
	@echo 'AWS::StorageGatewaY ($(_AWS_STORAGEGATEWAY_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _sgy_view_framework_targets
_sgy_view_framework_targets ::
	@echo 'AWS::StorageGatewaY ($(_AWS_STORAGEGATEWAY_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_storagegateway_gateway.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
