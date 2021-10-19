_AWS_WAF_MK_VERSION= 0.99.0

# Derived parameters

# Options parameters

# UI parameters

#--- Commands

#--- Macros
_waf_get_changetoken= $(shell $(AWS) waf get-change-token --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _waf_view_framework_macros
_waf_view_framework_macros ::
	@echo 'AWS::WAF ($(_AWS_WAF_MK_VERSION)) macros:'
	@echo '    _waf_get_changetoken         - Get a change tocken'
	@echo

_aws_view_framework_parameters :: _waf_view_framework_parameters
_waf_view_framework_parameters ::
	@echo 'AWS::WAF ($(_AWS_WAF_MK_VERSION)) parameters:'
	@echo '    WAF_CHANGETOKEN=$(WAF_CHANGETOKEN)' 
	@echo

_aws_view_framework_targets :: _waf_view_framework_targets
_waf_view_framework_targets ::
	@echo 'AWS::WAF ($(_AWS_WAF_MK_VERSION)) targets:'
	@echo '    _waf_get_changetoken         - Get a change-token'
	@echo '    _waf_view_sets               - View WAF-sets'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_waf_bytematchset.mk
-include $(MK_DIR)/aws_waf_geomatchset.mk
-include $(MK_DIR)/aws_waf_ipset.mk
-include $(MK_DIR)/aws_waf_ratebasedrule.mk
-include $(MK_DIR)/aws_waf_regexmatchset.mk
-include $(MK_DIR)/aws_waf_rule.mk
-include $(MK_DIR)/aws_waf_rulegroup.mk
-include $(MK_DIR)/aws_waf_sizeconstraintset.mk
-include $(MK_DIR)/aws_waf_sqlinjectionmatchset.mk
-include $(MK_DIR)/aws_waf_webacl.mk
-include $(MK_DIR)/aws_waf_xssmatchset.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_waf_get_changetoken:
	@$(INFO) '$(AWS_UI_LABEL)Get WAF/Edge change token ...'; $(NORMAL)
	@$(WARN) 'A change token is not region specific!'; $(NORMAL)
	$(AWS) waf get-change-token

_waf_view_sets::
