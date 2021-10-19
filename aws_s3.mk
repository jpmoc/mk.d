_AWS_S3_MK_VERSION= 0.99.1

# S3_PARAMETER?= value

# Derived parameters 

# Options

# UI parameters
S3_UI_LABEL?= $(AWS_UI_LABEL)

# Commands

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _s3_view_framework_macros
_s3_view_framework_macros ::
	@echo 'AWS::S3:: ($(_AWS_S3_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _s3_view_framework_parameters
_s3_view_framework_parameters ::
	@echo 'AWS::S3:: ($(_AWS_S3_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _s3_view_framework_targets
_s3_view_framework_targets ::
	@echo 'AWS::S3:: ($(_AWS_S3_MK_VERSION)) targets:'
	@echo '    _s3_view_account_limits            - View related AWS limits'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_s3_bucket.mk
-include $(MK_DIR)/aws_s3_folder.mk
-include $(MK_DIR)/aws_s3_object.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aws_view_account_limits :: _s3_view_account_limits
_s3_view_account_limits:
	@$(INFO) '$(S3_UI_LABEL)Viewing S3 account limits ...'; $(NORMAL)
	@echo 'Maximum bucket count=1000'
