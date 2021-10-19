_AWS_KMS_MK_VERSION = 0.99.0

# KMS_INPUTS_DIRPATH?= ./in/
# KMS_BYTECOUNT?= 16
# KMS_OUTPUTS_DIRPATH?= ./out/
# KMS_RANDOMIN?= 7456089

# Derived parameters
KMS_INPUTS_DIRPATH?= $(AWS_INPUTS_DIRPATH)
KMS_OUTPUTS_DIRPATH?= $(AWS_OUTPUTS_DIRPATH)

# Options parameters

# UI parameters
KMS_UI_LABEL?= $(AWS_UI_LABEL)

#--- MACRO

_kms_get_randomint= $(call _kms_get_randomint_C, $(KMS_BYTECOUNT))
_kms_get_randomint_C= $(shell $(AWS) kms generate-random --number-of-bytes $(1) --query "Plaintext" --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _kms_view_framework_macros
_kms_view_framework_macros ::
	@echo 'AWS::KMS ($(_AWS_KMS_MK_VERSION)) macros:'
	@echo '    _kms_get_randomint_{|C}           - Get a random integer (byteCount)'
	@echo

_aws_view_framework_parameters :: _kms_view_framework_parameters
_kms_view_framework_parameters ::
	@echo 'AWS::KMS ($(_AWS_KMS_MK_VERSION)) parameters:'
	@echo '    KMS_BYTECOUNT=$(KMS_BYTECOUNT)'
	@echo '    KMS_INPUTS_DIRPATH=$(KMS_INPUTS_DIRPATH)'
	@echo '    KMS_OUTPUTS_DIRPATH=$(KMS_OUTPUTS_DIRPATH)'
	@echo '    KMS_RANDOMINT=$(KMS_RANDOMINT)'
	@echo

_aws_view_framework_targets :: _kms_view_framework_targets
_kms_view_framework_targets ::
	@echo 'AWS::KMS ($(_AWS_KMS_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_kms_alias.mk
-include $(MK_DIR)/aws_kms_file.mk
-include $(MK_DIR)/aws_kms_key.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
