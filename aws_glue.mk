_AWS_GLUE_MK_VERSION=0.99.6

# GLE_CATALOG_ID?= 123456789012

# Derived variables

# Options variables
__GLE_CATALOG_ID= $(if $(GLE_CATALOG_ID), --catalog-id $(GLE_CATALOG_ID))

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _gle_view_makefile_macros
_gle_view_makefile_macros ::
	@#echo 'AWS::GLuE ($(_AWS_GLUE_MK_VERSION)) macros:'
	@#echo

_aws_view_makefile_targets :: _gle_view_makefile_targets
_gle_view_makefile_targets ::
	@echo 'AWS::GLuE ($(_AWS_GLUE_MK_VERSION)) targets:'
	@echo '    _gle_show_migration_status               - Show the status of the migration to the glue data-catalog'
	@echo 

_aws_view_makefile_variables :: _gle_view_makefile_variables
_gle_view_makefile_variables ::
	@echo 'AWS::GLuE ($(_AWS_GLUE_MK_VERSION)) variables:'
	@echo '    GLE_CATALOG_ID=$(GLE_CATALOG_ID)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/aws_glue_classifier.mk
-include $(MK_DIR)/aws_glue_connection.mk
-include $(MK_DIR)/aws_glue_crawler.mk
-include $(MK_DIR)/aws_glue_database.mk
-include $(MK_DIR)/aws_glue_job.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gle_show_migration_status:
	@$(INFO) '$(AWS_LABEL)Showing the status of the migration to the glue data-catalog'; $(NORMAL)
	$(AWS) glue get-catalog-import-status $(__GLE_CATALOG_ID) --query "ImportStatus"
