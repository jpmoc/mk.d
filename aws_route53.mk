_AWS_ROUTE53_MK_VERSION= 0.99.6

# R53_INPUTS_DIRPATH?= ./in/
# R53_OUTPUTS_DIRPATH?= ./out/
# R53_UI_LABEL?= [route53] #

# Derived parameters
R53_INPUTS_DIRPATH?= $(AWS_INPUTS_DIRPATH)
R53_OUTPUTS_DIRPATH?= $(AWS_OUTPUTS_DIRPATH)
R53_UI_LABEL?= $(AWS_UI_LABEL)

# Options parameters

# Customizations

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _r53_list_macros
_r53_list_macros ::
	@#echo 'AWS::Route53:: ($(_AWS_ROUTE53_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _r53_list_parameters
_r53_list_parameters ::
	@echo 'AWS::Route53:: ($(_AWS_ROUTE53_MK_VERSION)) parameters:'
	@echo '    R53_INPUTS_DIRPATH=$(R53_INPUTS_DIRPATH)'
	@echo '    R53_OUTPUTS_DIRPATH=$(R53_OUTPUTS_DIRPATH)'
	@echo '    R53_UI_LABEL=$(R53_UI_LABEL)'
	@echo

_list_targets :: _r53_list_targets
_r53_list_targets ::
	@echo 'AWS::Route53:: ($(_AWS_ROUTE53_MK_VERSION)) targets:'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
# -include $(MK_DIR)/aws_route53_healthcheck.mk
-include $(MK_DIR)/aws_route53_hostedzone.mk
# -include $(MK_DIR)/aws_route53_trafficpolicy.mk
-include $(MK_DIR)/aws_route53_record.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
