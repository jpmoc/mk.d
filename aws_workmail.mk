_AWS_WORKMAIL_MK_VERSION= 0.99.6

# WML_PARAMETER?=

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _wml_view_framework_macros
_wml_view_framework_macros ::
	@echo 'AWS::WorkMaiL ($(_AWS_WORKMAIL_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _wml_view_framework_parameters
_wml_view_framework_parameters ::
	@echo 'AWS::WorkMaiL ($(_AWS_WORKMAIL_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _wml_view_framework_targets
_wml_view_framework_targets ::
	@echo 'AWS::WorkMaiL ($(_AWS_WORKMAIL_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_workmail_alias.mk
-include $(MK_DIR)/aws_workmail_group.mk
-include $(MK_DIR)/aws_workmail_organization.mk
-include $(MK_DIR)/aws_workmail_resource.mk
-include $(MK_DIR)/aws_workmail_user.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
