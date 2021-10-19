_AWS_SECRETSMANAGER_MK_VERSION= 0.99.6

# SMR_INPUTS_DIRPATH?= ./in/
# SMR_ENDPOINT_URL?= https://vpce-1234a5678b9012c-12345678.secretsmanager.us-west-2.vpce.amazonaws.com 
# SMR_OUTPUTS_DIRPATH?= ./out/

# Derived parameters
SMR_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
SMR_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Options parameters

# UI parameters
SMR_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _smr_view_framework_macros
_smr_view_framework_macros ::
	@#echo 'AWS::SecretManageR ($(_AWS_SECRETSMANAGER_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _smr_view_framework_parameters
_smr_view_framework_parameters ::
	@echo 'AWS::SecretManageR ($(_AWS_SECRETSMANAGER_MK_VERSION)) parameters:'
	@echo '    SMR_INPUTS_DIRPATH=$(SMR_INPUTS_DIRPATH)'
	@echo '    SMR_ENPOINT_URL=$(SMR_ENDPOINT_URL)'
	@echo '    SMR_OUTPUTS_DIRPATH=$(SMR_OUTPUTS_DIRPATH)'
	@echo

_aws_view_framework_targets :: _smr_view_framework_targets
_smr_view_framework_targets ::
	@#echo 'AWS::SecretManageR ($(_AWS_SECRETSMANAGER_MK_VERSION)) targets:'
	@#echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_secretsmanager_password.mk
-include $(MK_DIR)/aws_secretsmanager_resourcepolicy.mk
-include $(MK_DIR)/aws_secretsmanager_secret.mk
-include $(MK_DIR)/aws_secretsmanager_versionstage.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
