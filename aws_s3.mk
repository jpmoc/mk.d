_AWS_S3_MK_VERSION= 0.99.1

# S3_PARAMETER?= value
S3_UI_LABEL?= $(AWS_UI_LABEL)

# Derived parameters 

# Options

# Customizations

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_list_macros :: _s3_list_macros
_s3_list_macros ::
	@#echo 'AWS::S3:: ($(_AWS_S3_MK_VERSION)) macros:'
	@#echo

_aws_list_parameters :: _s3_list_parameters
_s3_list_parameters ::
	@echo 'AWS::S3:: ($(_AWS_S3_MK_VERSION)) parameters:'
	@echo

_aws_list_targets :: _s3_list_targets
_s3_list_targets ::
	@echo 'AWS::S3:: ($(_AWS_S3_MK_VERSION)) targets:'
	@echo '    _s3_view_limits            - View S3 limits'
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

_aws_view_limits :: _s3_view_limits
_s3_view_limits:
	@$(INFO) '$(S3_UI_LABEL)Viewing S3 limits ...'; $(NORMAL)
	@$(WARN) 'This operations returns account-limits as S3 is a global service'; $(NORMAL) 
	@echo 'Maximum bucket count=1000'
