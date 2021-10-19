_AWS_SERVERLESSREPO_MK_VERSION= 0.99.6

# SRO_SERVICE_NAMESPACE?= ec2

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _sro_view_framework_macros
_sro_view_framework_macros ::
	@#echo 'AWS::ServerlessRepO ($(_AWS_SERVERLESSREPO_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _sro_view_framework_parameters
_sro_view_framework_parameters ::
	@#echo 'AWS::ServerlessRepO ($(_AWS_SERVERLESSREPO_MK_VERSION)) parameters:'
	@#echo

_aws_view_framework_targets :: _sro_view_framework_targets
_sro_view_framework_targets ::
	@#echo 'AWS::ServerlessRepO ($(_AWS_SERVERLESSREPO_MK_VERSION)) targets:'
	@#echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_serverlessrepo_application.mk
-include $(MK_DIR)/aws_serverlessrepo_cloudformation.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
