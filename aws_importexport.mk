_AWS_IMPORTEXPORT_MK_VERSION= 0.99.6

# IET_PARAMETER?=

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _iet_view_framework_macros
_iet_view_framework_macros ::
	@#echo 'AWS::ImportExporT ($(_AWS_IMPORTEXPORT_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _iet_view_framework_parameters
_iet_view_framework_parameters ::
	@echo 'AWS::ImportExporT ($(_AWS_IMPORTEXPORT_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _iet_view_framework_targets
_iet_view_framework_targets ::
	@echo 'AWS::ImportExporT ($(_AWS_IMPORTEXPORT_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_importexport_job.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
