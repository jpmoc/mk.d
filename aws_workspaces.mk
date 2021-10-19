_AWS_WORKSPACES_MK_VERSION= 0.99.6

# WSS_BUNDLE_ID?= 

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _wss_view_framework_macros
_wss_view_framework_macros ::
	@#echo 'AWS::WorkSpaceS ($(_AWS_WORKSPACES_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _wss_view_framework_parameters
_wss_view_framework_parameters ::
	@#echo 'AWS::WorkSpaceS ($(_AWS_WORKSPACES_MK_VERSION)) parameters:'
	@#echo

_aws_view_framework_targets :: _wss_view_framework_targets
_wss_view_framework_targets ::
	@#echo 'AWS::WorkSpaceS ($(_AWS_WORKSPACES_MK_VERSION)) targets:'
	@#echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_workspaces_bundle.mk
-include $(MK_DIR)/aws_workspaces_directory.mk
-include $(MK_DIR)/aws_workspaces_ipgroup.mk
-include $(MK_DIR)/aws_workspaces_tags.mk
-include $(MK_DIR)/aws_workspaces_workspace.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
