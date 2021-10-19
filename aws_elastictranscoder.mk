_AWS_ELASTICTRANSCODER_MK_VERSION= 0.99.0

# Derived parameters

# Options parameters

# UI parameters

#--- Commands

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _etr_view_framework_macros
_etr_view_framework_macros ::
	@echo 'AWS::ElasticTranscodeR ($(_AWS_ELASTICTRANSCODER_MK_VERSION)) macros:'
	@echo

_aws_view_framework_parameters :: _etr_view_framework_parameters
_etr_view_framework_parameters ::
	@echo 'AWS::ElasticTranscodeR ($(_AWS_ELASTICTRANSCODER_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _etr_view_framework_targets
_etr_view_framework_targets ::
	@echo 'AWS::ElasticTranscodeR ($(_AWS_ELASTICTRANSCODER_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_elastictranscoder_pipeline.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

