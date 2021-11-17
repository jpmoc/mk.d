_AWS_S3API_MK_VERSION= 0.99.0

# S3I_BUCKET_COUNT?= 1000
S3I_UI_LABEL?= $(AWS_UI_LABEL)

# Derived parameters

# Options

# Customizations

# Macros
_s3i_get_bucket_count= $(shell $(AWS) s3api list-buckets --query "Buckets[].Name" --output json | jq -r '.[]' | wc -l )

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _s3api_list_macros
_s3i_list_macros ::
	@echo 'AWS::S3API ($(_AWS_S3API_MK_VERSION)) macros:'
	@echo '    _s3i_get_buckeet_count         - Get the number of bucket for a given account'
	@echo

_list_parameters :: _s3i_list_parameters
_s3i_list_parameters ::
	@echo 'AWS::S3API ($(_AWS_S3API_MK_VERSION)) parameters:'
	@echo '    S3I_BUCKET_COUNT=$(S3I_BUCKET_COUNT)'
	@echo '    S3I_UI_LABEL=$(S3I_UI_LABEL)'
	@echo

_list_targets :: _s3i_list_targets
_s3i_list_targets ::
	@echo 'AWS::S3API ($(_AWS_S3API_MK_VERSION)) targets:'
	@echo '    _s3i_view_limits             - View S3-limits'
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

_aws_view_limits :: _s3i_view_limits
_s3i_view_limits:
	@$(INFO) '$(S3I_UI_LABEL)Viewing S3API limits ...'; $(NORMAL)
	@$(WARN) 'The actual account limit can be increased with a support request'; $(NORMAL)
	@echo 'Maximum number of buckets per account=1000 (Hard limit)'
	@echo 'S3I_BUCKET_COUNT=$(S3I_BUCKET_COUNT)'
