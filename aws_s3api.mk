_AWS_S3API_MK_VERSION= 0.99.0

# S3I_BUCKET_COUNT?= 1000

# Derived parameters

# Options

# UI parameters
S3I_UI_LABEL?= $(AWS_UI_LABEL)

#--- MACROS
_s3i_get_bucket_count= $(shell $(AWS) s3api list-buckets --query "Buckets[].Name" --output json | jq -r '.[]' | wc -l )

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _s3api_view_framework_macros
_s3i_view_framework_macros ::
	@echo 'AWS::S3API ($(_AWS_S3API_MK_VERSION)) macros:'
	@echo '    _s3i_get_buckeet_count         - Get the number of bucket for a given account'
	@echo

_view_framework_parameters :: _s3i_view_framework_parameters
_s3i_view_framework_parameters ::
	@echo 'AWS::S3API ($(_AWS_S3API_MK_VERSION)) parameters:'
	@echo '    S3I_BUCKET_COUNT=$(S3I_BUCKET_COUNT)'
	@echo

_view_framework_targets :: _s3i_view_framework_targets
_s3i_view_framework_targets ::
	@echo 'AWS::S3API ($(_AWS_S3API_MK_VERSION)) targets:'
	@echo '    _s3i_view_account_limits             - View S3 limits'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/aws_s3api_bucket.mk
-include $(MK_DIR)/aws_s3api_object.mk
-include $(MK_DIR)/aws_s3api_upload.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aws_view_account_limits :: _s3i_view_account_limits
_s3i_view_account_limits:
	@$(INFO) '$(S3I_UI_LABEL)Viewing S3API limits ...'; $(NORMAL)
	@$(WARN) 'The actual account limit can be increased with a support request'; $(NORMAL)
	@echo 'Maximum number of buckets per account=1000 (Hard limit)'
	@echo 'S3I_BUCKET_COUNT=$(S3I_BUCKET_COUNT)'
