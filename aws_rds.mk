_AWS_RDS_MK_VERSION=0.99.6

# GCR_ACCOUNT_ID?= -

# Derived variables

# Options variables

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _rds_view_makefile_macros
_rds_view_makefile_macros ::
	@#echo 'AWS::GlaCieR ($(_AWS_RDS_MK_VERSION)) macros:'
	@#echo

_aws_view_makefile_targets :: _rds_view_makefile_targets
_rds_view_makefile_targets ::
	@#echo 'AWS::GlaCieR ($(_AWS_RDS_MK_VERSION)) targets:'
	@#echo 

_aws_view_makefile_variables :: _rds_view_makefile_variables
_rds_view_makefile_variables ::
	@#echo 'AWS::GlaCieR ($(_AWS_RDS_MK_VERSION)) variables:'
	@#echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_rds_dbcluster.mk
-include $(MK_DIR)/aws_rds_dbclusterparametergroup.mk
-include $(MK_DIR)/aws_rds_dbclustersnapshot.mk
-include $(MK_DIR)/aws_rds_dbinstance.mk
-include $(MK_DIR)/aws_rds_dbparametergroup.mk
-include $(MK_DIR)/aws_rds_dbsecuritygroup.mk
-include $(MK_DIR)/aws_rds_dbsubnetgroup.mk
-include $(MK_DIR)/aws_rds_optiongroup.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aws_install_framework_dependencies :: _rds_install_framework_dependencies
_rds_install_framework_dependencies ::
	sudo apt-get -y install mysql-client
