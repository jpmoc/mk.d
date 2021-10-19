_AWS_DMS_MK_VERSION=0.99.0

# DMS_RESOURCE_ARN?=
# DMS_RESOURCE_IDENTIFIER?=

# Option variables
__DMS_RESOURCE_ARN= $(if $(DMS_RESOURCE_ARN), --resource-arn $(DMS_RESOURCE_ARN))

# UI variables
DMS_UI_VIEW_AVAILABLE_ENGINES_FIELDS?= .{ReplicationInstanceClass:ReplicationInstanceClass,EngineVersion:EngineVersion}

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _dms_view_makefile_macros
_dms_view_makefile_macros ::
	@#echo "AWS::DMS ($(_AWS_DMS_MK_VERSION)) macros:"
	@#echo

_aws_view_makefile_targets :: _dms_view_makefile_targets
_dms_view_makefile_targets ::
	@echo "AWS::DMS ($(_AWS_DMS_MK_VERSION)) targets:"
	@echo "    _dms_show_resource_tags                - Show tags of a DMS resource"
	@echo "    _dms_view_account_limits               - View the limits for DMS on this account"
	@echo "    _dms_view_available_endpoint_types     - View available endpoint types"
	@echo "    _dms_view_available_engines            - View available engines"
	@echo

_aws_view_makefile_variables :: _dms_view_makefile_variables
_dms_view_makefile_variables ::
	@echo "AWS::DMS ($(_AWS_DMS_MK_VERSION)) variables:"
	@echo "    DMS_RESOURCE_ARN=$(DMS_RESOURCE_ARN)"
	@echo "    DMS_RESOURCE_IDENTIFIER=$(DMS_RESOURCE_IDENTIFIER)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

-include $(MK_DIR)/aws_dms_certificate.mk
-include $(MK_DIR)/aws_dms_endpoint.mk
-include $(MK_DIR)/aws_dms_event.mk
-include $(MK_DIR)/aws_dms_instance.mk
-include $(MK_DIR)/aws_dms_subnetgroup.mk
-include $(MK_DIR)/aws_dms_task.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dms_show_resource_tags:
	@$(INFO) "$(AWS_UI_LABEL)Showing tags for DMS resource '$(DMS_RESOURCE_IDENTIFIER)' ..."; $(NORMAL)
	$(AWS) dms list-tags-for-resource $(__DMS_RESOURCE_ARN)

_aws_view_account_limits :: _dms_view_account_limits
_dms_view_account_limits:
	@$(INFO) "$(AWS_UI_LABEL)Viewing DMS limits for account '$(AWS_ACCOUNT_ID)' ..."; $(NORMAL)
	$(AWS) dms describe-account-attributes

_dms_view_available_endpoint_types:
	@$(INFO) "$(AWS_UI_LABEL)Viewing DMS endpoint types ..."; $(NORMAL)
	$(AWS) dms describe-endpoint-types

_dms_view_available_engines:
	@$(INFO) "$(AWS_UI_LABEL)Viewing available DMS engines ..."; $(NORMAL)
	$(AWS) dms describe-orderable-replication-instances --query "OrderableReplicationInstances[*]$(DMS_UI_VIEW_AVAILABLE_ENGINES_FIELDS)"

