_AWS_BATCH_MK_VERSION=0.99.0

# BCH_ENVIRONMENT_NAME?= my-compute-environment

# Derived variables

# Options variables

# UI variables

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _bch_view_makefile_macros
_bch_view_makefile_macros ::  
	@#echo "AWS::BatCH ($(_AWS_BATCH_MK_VERSION)) macros:"
	@#echo

_aws_view_makefile_targets :: _bch_view_makefile_targets
_bch_view_makefile_targets ::
	@#echo "AWS::BatCH ($(_AWS_BATCH_MK_VERSION)) targets:"
	@#echo

_aws_view_makefile_variables :: _bch_view_makefile_variables
_bch_view_makefile_variables ::
	@#echo "AWS::BatCH ($(_AWS_BATCH_MK_VERSION)) variables:"
	@#echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/aws_batch_environment.mk
-include $(MK_DIR)/aws_batch_job.mk
-include $(MK_DIR)/aws_batch_queue.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

