_AWS_APPSTREAM_MK_VERSION= 0.99.6

# ASM_PARAMETER?= Value

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _asm_view_framework_macros
_asm_view_framework_macros ::
	@#echo 'AWS::AppStreaM ($(_AWS_APPSTREAM_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _asm_view_framework_parameters
_asm_view_framework_parameters ::
	@echo 'AWS::AppStreaM ($(_AWS_APPSTREAM_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _asm_view_framework_targets
_asm_view_framework_targets ::
	@echo 'AWS::AppStreaM ($(_AWS_APPSTREAM_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_appstream_directoryconfig.mk
-include $(MK_DIR)/aws_appstream_fleet.mk
-include $(MK_DIR)/aws_appstream_imagebuilder.mk
-include $(MK_DIR)/aws_appstream_stack.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
