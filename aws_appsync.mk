_AWS_APPSYNC_MK_VERSION= 0.99.6

# EBK_CNAME_PREFIX?= my-cname

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _asc_view_framework_macros
_asc_view_framework_macros ::
	@#echo 'AWS::AppSynC ($(_AWS_APPSYNC_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _asc_view_framework_parameters
_asc_view_framework_parameters ::
	@#echo 'AWS::AppSynC ($(_AWS_APPSYNC_MK_VERSION)) parameters:'
	@#echo

_aws_view_framework_targets :: _asc_view_framework_targets
_asc_view_framework_targets ::
	@#echo 'AWS::AppSynC ($(_AWS_APPSYNC_MK_VERSION)) targets:'
	@#echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_appsync_apikey.mk
-include $(MK_DIR)/aws_appsync_datasource.mk
-include $(MK_DIR)/aws_appsync_graphqlapi.mk
-include $(MK_DIR)/aws_appsync_resolver.mk
-include $(MK_DIR)/aws_appsync_type.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
