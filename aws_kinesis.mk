_AWS_KINESIS_MK_VERSION= 0.99.6

# KSS_SERVICE_NAMESPACE?= ec2

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _kss_view_framework_macros
_kss_view_framework_macros ::
	@#echo 'AWS::KineSiS ($(_AWS_KINESIS_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _kss_view_framework_parameters
_kss_view_framework_parameters ::
	@echo 'AWS::KineSiS ($(_AWS_KINESIS_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _kss_view_framework_targets
_kss_view_framework_targets ::
	@echo 'AWS::KineSiS ($(_AWS_KINESIS_MK_VERSION)) targets:'
	@echo '    _kss_view_account_limits        - View the limits of this AWS account'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_kinesis_record.mk
-include $(MK_DIR)/aws_kinesis_shard.mk
-include $(MK_DIR)/aws_kinesis_stream.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aws_view_account_limits :: _kss_view_account_limits
_kss_view_account_limits:
	@$(INFO) '$(AWS_UI_LABEL)Viewing account limits ...'; $(NORMAL)
	$(AWS) kinesis describe-limits
