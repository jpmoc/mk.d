_AWS_XRAY_MK_VERSION= 0.99.6

# XRY_PARAMETER?=

# Derived parameters

# Option parameters


# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _xry_view_framework_macros
_xry_view_framework_macros ::
	@echo 'AWS::XRaY ($(_AWS_XRAY_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _xry_view_framework_parameters
_xry_view_framework_parameters ::
	@echo 'AWS::XRaY ($(_AWS_XRAY_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _xry_view_framework_targets
_xry_view_framework_targets ::
	@echo 'AWS::XRaY ($(_AWS_XRAY_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_xray_group.mk
-include $(MK_DIR)/aws_xray_samplingrule.mk
-include $(MK_DIR)/aws_xray_servicegraph.mk
-include $(MK_DIR)/aws_xray_trace.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies:: _xry_install_dependencies

_xry_install_depedencies:
	@$(INFO) '$(AWS_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	sudo apt-get install bc
	which bc

_view_versions:: _xry_show_version
_xry_show_version:
	@$(INFO) '$(AWS_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	bc --version
