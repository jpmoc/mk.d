_AWS_ATHENA_MK_VERSION=0.99.6

# ATA_RESULTS_S3BUCKET= s3://my-bucket

# Derived variables
# ATA_RESULTS_S3BUCKET?= $(ATA_RESULTS_S3BUCKET_DEFAULT)
# ATA_RESULTS_S3BUCKET_DEFAULT?= s3://aws-athena-query-results-$(AWS_ACCOUNT_ID)-$(AWS_REGION)

# Options variables

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_install_framework_dependencies :: _ata_install_framework_dependencies
_ata_install_framework_dependencies:
	@echo 'AWS::AThenA ($(_AWS_ATHENA_MK_VERSION)) dependencies:'
	sudo apt-get install python3-csvkit      # csvlook

_aws_view_makefile_macros :: _ata_view_makefile_macros
_ata_view_makefile_macros ::
	@#echo 'AWS::AThenA ($(_AWS_ATHENA_MK_VERSION)) macros:'
	@#echo

_aws_view_makefile_targets :: _ata_view_makefile_targets
_ata_view_makefile_targets ::
	@#echo 'AWS::AThenA ($(_AWS_ATHENA_MK_VERSION)) targets:'
	@#echo 

_aws_view_makefile_variables :: _ata_view_makefile_variables
_ata_view_makefile_variables ::
	@#echo 'AWS::AThenA ($(_AWS_ATHENA_MK_VERSION)) variables:'
	@#echo '    ATA_RESULTS_S3BUCKET_DEFAULT=$(ATA_RESULTS_S3BUCKET_DEFAULT)'
	@#echo '    ATA_RESULTS_S3BUCKET=$(ATA_RESULTS_S3BUCKET)'
	@#echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_athena_namedquery.mk
-include $(MK_DIR)/aws_athena_queryexecution.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
