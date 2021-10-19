_AWS_ROUTE53_MK_VERSION= 0.99.6

# CTL_ACCOUNT_ID?= -

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _r53_view_framework_macros
_r53_view_framework_macros ::
	@#echo 'AWS::Route53 ($(_AWS_ROUTE53_MK_VERSION)) macros:'
	@#echo

_view_framework_targets :: _r53_view_framework_targets
_r53_view_framework_targets ::
	@#echo 'AWS::Route53 ($(_AWS_ROUTE53_MK_VERSION)) targets:'
	@#echo 

_view_framework_parameters :: _r53_view_framework_parameters
_r53_view_framework_parameters ::
	@#echo 'AWS::Route53 ($(_AWS_ROUTE53_MK_VERSION)) parameters:'
	@#echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
# -include $(MK_DIR)/aws_route53_healthcheck.mk
-include $(MK_DIR)/aws_route53_hostedzone.mk
# -include $(MK_DIR)/aws_route53_trafficpolicy.mk
-include $(MK_DIR)/aws_route53_record.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
