_AWS_ACM_MK_VERSION= 0.99.6

# ACM_INPUTS_DIRPATH?= ./in/
# ACM_OUTPUTS_DIRPATH?= ./out/
# ACM_UI_LABEL?= [acm] #

# Derived parameters
ACM_UI_LABEL?= $(AWS_UI_LABEL)#

# Options

# Customizations

# Utilities

# Macros

#----------------------------------------------------------------------
# USAGE
#

_aws_list_macros :: _acm_list_macros
_acm_list_macros ::
	@#echo 'AWS::ACM ($(_AWS_ACM_MK_VERSION)) macros:'
	@#echo

_aws_list_parameters :: _acm_list_parameters
_acm_list_parameters ::
	@echo 'AWS::ACM ($(_AWS_ACM_MK_VERSION)) parameters:'
	@echo '    ACM_INPUTS_DIRPATH=$(ACM_INPUTS_DIRPATH)'
	@echo '    ACM_OUTPUTS_DIRPATH=$(ACM_OUTPUTS_DIRPATH)'
	@echo '    ACM_UI_LABEL=$(ACM_UI_LABEL)'
	@echo

_aws_list_targets :: _acm_list_targets
_acm_list_targets ::
	@#echo 'AWS::ACM ($(_AWS_ACM_MK_VERSION)) targets:'
	@#echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIRPATH?= ./
-include $(MK_DIRPATH)aws_acm_certificate.mk
-include $(MK_DIRPATH)aws_acm_certificateauthority.mk
-include $(MK_DIRPATH)aws_acm_certificateauthorityauditreport.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
