_AWS_SNOWBALL_MK_VERSION= 0.99.6

# SBL_PARAMETER?=

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _sbl_view_framework_macros
_sbl_view_framework_macros ::
	@echo 'AWS::WorkMaiL ($(_AWS_SNOWBALL_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _sbl_view_framework_parameters
_sbl_view_framework_parameters ::
	@echo 'AWS::WorkMaiL ($(_AWS_SNOWBALL_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _sbl_view_framework_targets
_sbl_view_framework_targets ::
	@echo 'AWS::WorkMaiL ($(_AWS_SNOWBALL_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_snowball_address.mk
-include $(MK_DIR)/aws_snowball_cluster.mk
-include $(MK_DIR)/aws_snowball_job.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
