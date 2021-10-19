_AWS_CLOUDWATCH_MK_VERSION=0.99.3

CWH_UI_LABEL?= $(AWS_UI_LABEL)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _cwh_view_framework_macros
_cwh_view_framework_macros ::
	@echo "AWS::CloudWatcH ($(_AWS_CLOUDWATCH_MK_VERSION)) macros:"
	@echo

_aws_view_framework_parameters :: _cwh_view_framework_parameters
_cwh_view_framework_parameters ::
	@echo "AWS::CloudWatcH ($(_AWS_CLOUDWATCH_MK_VERSION)) parameters:"
	@echo

_aws_view_framework_targets :: _cwh_view_framework_targets
_cwh_view_framework_targetsi ::
	@echo "AWS::CloudWatcH ($(_AWS_CLOUDWATCH_MK_VERSION)) targets:"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_cloudwatch_alarm.mk
-include $(MK_DIR)/aws_cloudwatch_dashboard.mk
-include $(MK_DIR)/aws_cloudwatch_metrics.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aws_install :: _cwh_install_dependencies
_cwh_install_dependencies:
	sudo apt-get install feedgnuplot

