_AWS_IOT1CLICK_MK_VERSION= 0.99.0

# I1K_ACCOUNT_ID?= 012345678901
# I1K_REGION_NAME?= us-west-2

# Derived parameters
I1K_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)
I1K_REGION_NAME?= $(AWS_REGION_NAME)

# Option parameters

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _i1k_view_framework_macros
_i1k_view_framework_macros ::
	@echo 'AWS::Iot1clicK:: ($(_AWS_IOT1CLICK_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _i1k_view_framework_parameters
_i1k_view_framework_parameters ::
	@echo 'AWS::Iot1clicK:: ($(_AWS_IOT1CLICK_MK_VERSION)) parameters:'
	@echo '    I1K_ACCOUNT_ID=$(I1K_ACCOUNT_ID)'
	@echo '    I1K_REGION_NAME=$(I1K_REGION_NAME)'
	@echo

_view_framework_targets :: _i1k_view_framework_targets
_i1k_view_framework_targets ::
	@echo 'AWS::Iot1clicK:: ($(_AWS_IOT1CLICK_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

-include $(MK_DIR)/aws_iot1click_device.mk
-include $(MK_DIR)/aws_iot1click_placement.mk
-include $(MK_DIR)/aws_iot1click_project.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

