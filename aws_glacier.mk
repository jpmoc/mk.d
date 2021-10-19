_AWS_GLACIER_MK_VERSION=0.99.6

GCR_ACCOUNT_ID?= -

# Derived variables
# GCR_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)

# Options variables
__GCR_ACCOUNT_ID= $(if $(GCR_ACCOUNT_ID), --account-id $(GCR_ACCOUNT_ID))

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _gcr_view_makefile_macros
_gcr_view_makefile_macros ::
	@#echo 'AWS::GlaCieR ($(_AWS_GLACIER_MK_VERSION)) macros:'
	@#echo

_aws_view_makefile_targets :: _gcr_view_makefile_targets
_gcr_view_makefile_targets ::
	@#echo 'AWS::GlaCieR ($(_AWS_GLACIER_MK_VERSION)) targets:'
	@#echo 

_aws_view_makefile_variables :: _gcr_view_makefile_variables
_gcr_view_makefile_variables ::
	@echo 'AWS::GlaCieR ($(_AWS_GLACIER_MK_VERSION)) variables:'
	@echo '    GCR_ACCOUNT_ID=$(GCR_ACCOUNT_ID)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_glacier_archive.mk
-include $(MK_DIR)/aws_glacier_vault.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
