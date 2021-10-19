_AWS_CODESTAR_MK_VERSION=0.99.6

# CTL_ACCOUNT_ID?= -

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _csr_view_framework_macros
_csr_view_framework_macros ::
	@#echo 'AWS::CodeStaR ($(_AWS_CODESTAR_MK_VERSION)) macros:'
	@#echo

_view_framework_targets :: _csr_view_framework_targets
_csr_view_framework_targets ::
	@#echo 'AWS::CodeStaR ($(_AWS_CODESTAR_MK_VERSION)) targets:'
	@#echo 

_view_framework_parameters :: _csr_view_framework_parameters
_csr_view_framework_parameters ::
	@#echo 'AWS::CodeStaR ($(_AWS_CODESTAR_MK_VERSION)) parameters:'
	@#echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_codestar_project.mk
-include $(MK_DIR)/aws_codestar_teammember.mk
-include $(MK_DIR)/aws_codestar_userprofile.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
