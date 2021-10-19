_AWS_ACM_MK_VERSION= 0.99.6

# EBK_CNAME_PREFIX?= my-cname

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _acm_view_framework_macros
_acm_view_framework_macros ::
	@#echo 'AWS::ACM ($(_AWS_ACM_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _acm_view_framework_parameters
_acm_view_framework_parameters ::
	@#echo 'AWS::ACM ($(_AWS_ACM_MK_VERSION)) parameters:'
	@#echo

_aws_view_framework_targets :: _acm_view_framework_targets
_acm_view_framework_targets ::
	@#echo 'AWS::ACM ($(_AWS_ACM_MK_VERSION)) targets:'
	@#echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_acm_certificate.mk
-include $(MK_DIR)/aws_acm_certificateauthority.mk
-include $(MK_DIR)/aws_acm_certificateauthorityauditreport.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
