_AWS_DS_MK_VERSION= 0.99.6

# WSS_BUNDLE_ID?= 

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _ds_view_framework_macros
_ds_view_framework_macros ::
	@#echo 'AWS::DirectoryService ($(_AWS_DS_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _ds_view_framework_parameters
_ds_view_framework_parameters ::
	@#echo 'AWS::DirectoryService ($(_AWS_DS_MK_VERSION)) parameters:'
	@#echo

_aws_view_framework_targets :: _ds_view_framework_targets
_ds_view_framework_targets ::
	@echo 'AWS::DirectoryService ($(_AWS_DS_MK_VERSION)) targets:'
	@echo '    _ds_view_account_limits              - View the account/region limits'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_ds_adconnector.mk
# -include $(MK_DIR)/aws_ds_computer.mk
# -include $(MK_DIR)/aws_ds_conditionalforwarder.mk
-include $(MK_DIR)/aws_ds_directory.mk
-include $(MK_DIR)/aws_ds_simplead.mk
-include $(MK_DIR)/aws_ds_microsoftad.mk
-include $(MK_DIR)/aws_ds_snapshot.mk
-include $(MK_DIR)/aws_ds_trust.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aws_view_account_limits :: _ds_view_account_limits
_ds_view_account_limits:
	@$(INFO) '$(AWS_UI_LABEL)Viewing directory-service limits in current region...'; $(NORMAL)
	$(AWS) ds get-directory-limits
