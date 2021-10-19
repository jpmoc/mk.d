_AWS_SHIELD_MK_VERSION= 0.99.6

# SHD_PARAMETER?=

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _shd_view_framework_macros
_shd_view_framework_macros ::
	@echo 'AWS::SHielD ($(_AWS_SHIELD_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _shd_view_framework_parameters
_shd_view_framework_parameters ::
	@echo 'AWS::SHielD ($(_AWS_SHIELD_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _shd_view_framework_targets
_shd_view_framework_targets ::
	@echo 'AWS::SHielD ($(_AWS_SHIELD_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_shield_protection.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
