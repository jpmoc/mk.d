_AWS_SUPPORT_MK_VERSION=0.99.6

SPT_LANGUAGE?= en

# Derived variables

# Options variables
__SPT_LANGUAGE= $(if $(SPT_LANGUAGE),--language $(SPT_LANGUAGE))

# UI variables
SPT_UI_LABEL?= $(AWS_UI_LABEL)

#--- Utilities

#--- MACROS
SPT_UI_VIEW_SERVICES_FIELDS?= .{code:code,name:name}

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _spt_view_framework_macros
_spt_view_framework_macros ::
	@#echo 'AWS::SuPport ($(_AWS_SUPPORT_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _spt_view_framework_parameters
_spt_view_framework_parameters ::
	@echo 'AWS::SuPport ($(_AWS_SUPPORT_MK_VERSION)) variables:'
	@echo '    SPT_LANGUAGE=$(SPT_LANGUAGE)'
	@echo

_aws_view_framework_targets :: _spt_view_framework_targets
_spt_view_framework_targets ::
	@echo 'AWS::SuPport ($(_AWS_SUPPORT_MK_VERSION)) targets:'
	@echo '    _spt_show_caseseveritylevels        - Show the severity levels for cases'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_support_case.mk
-include $(MK_DIR)/aws_support_check.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_spt_show_caseseveritylevels:
	@$(INFO) '$(SPT_UI_LABEL)Show severity-levels for cases'; $(NORMAL)
	$(AWS) support describe-severity-levels $(__SPT_LANGUAGE) --query 'severityLevels[]'

_spt_view_services:
	@$(INFO) '$(SPT_UI_LABEL)Show services'; $(NORMAL)
	$(AWS) support describe-services --query 'services[]$(SPT_UI_VIEW_SERVICES_FIELDS)'
