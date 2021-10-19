_AWS_ELASTICACHE_MK_VERSION= 0.99.6

# ECE_PARAMETER?=

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _ece_view_framework_macros
_ece_view_framework_macros ::
	@#echo 'AWS::ElastiCache ($(_AWS_ELASTICACHE_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _ece_view_framework_parameters
_ece_view_framework_parameters ::
	@echo 'AWS::ElastiCache ($(_AWS_ELASTICACHE_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _ece_view_framework_targets
_ece_view_framework_targets ::
	@echo 'AWS::ElastiCache ($(_AWS_ELASTICACHE_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_elasticache_cluster.mk
-include $(MK_DIR)/aws_elasticache_parametergroup.mk
-include $(MK_DIR)/aws_elasticache_replicationgroup.mk
-include $(MK_DIR)/aws_elasticache_securitygroup.mk
-include $(MK_DIR)/aws_elasticache_snapshot.mk
-include $(MK_DIR)/aws_elasticache_subnetgroup.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
