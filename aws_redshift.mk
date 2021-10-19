_AWS_REDSHIFT_MK_VERSION=0.99.6

# RST_AVAILABILITY_ZONE?=us-east-1a

# Derived parameters

# Option parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _rst_view_framework_macros
_rst_view_framework_macros ::
	@echo 'AWS::RedShifT ($(_AWS_REDSHIFT_MK_VERSION)) macros:'
	@echo

_aws_view_framework_targets :: _rst_view_framework_targets
_rst_view_framework_targets ::
	@echo 'AWS::RedShifT ($(_AWS_REDSHIFT_MK_VERSION)) targets:'
	@echo 

_aws_view_framework_parameters :: _rst_view_framework_parameters
_rst_view_framework_parameters ::
	@echo 'AWS::RedShifT ($(_AWS_REDSHIFT_MK_VERSION)) parameters:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_redshift_cluster.mk
-include $(MK_DIR)/aws_redshift_hsmcertificate.mk
-include $(MK_DIR)/aws_redshift_hsmconfiguration.mk
-include $(MK_DIR)/aws_redshift_parametergroup.mk
-include $(MK_DIR)/aws_redshift_snapshot.mk
-include $(MK_DIR)/aws_redshift_subnetgroup.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

