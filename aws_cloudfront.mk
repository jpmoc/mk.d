_AWS_CLOUDFRONT_MK_VERSION= 0.99.6

# CFT_DIRPATH?=

# Derived parameters

# Option parameters

# UI parameters
CFT_UI_LABEL= $(AWS_UI_LABEL)

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _cft_view_framework_macros
_cft_view_framework_macros ::
	@#echo 'AWS::CloudFronT ($(_AWS_CLOUDFRONT_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _cft_view_framework_parameters
_cft_view_framework_parameters ::
	@echo 'AWS::CloudFronT ($(_AWS_CLOUDFRONT_MK_VERSION)) parameters:'
	@echo '    CFT_DIRPATH=$(CFT_DIRPATH)'
	@echo

_aws_view_framework_targets :: _cft_view_framework_targets
_cft_view_framework_targets ::
	@echo 'AWS::CloudFronT ($(_AWS_CLOUDFRONT_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_cloudfront_distribution.mk
-include $(MK_DIR)/aws_cloudfront_invalidation.mk
-include $(MK_DIR)/aws_cloudfront_originaccessidentity.mk
-include $(MK_DIR)/aws_cloudfront_publickey.mk
-include $(MK_DIR)/aws_cloudfront_streamingdistribution.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
