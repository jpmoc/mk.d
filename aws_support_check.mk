_AWS_SUPPORT_CHECK_MK_VERSION=$(_AWS_SUPPORT_MK_VERSION)

# SPT_CHECK_ID?= 0Xc6LMYG8P
# SPT_CHECK_LANGUAGE?= en 
# SPT_CHECK_NAME?= My check name
# SPT_CHECKS_IDS?= 0Xc6LMYG8P ...
# SPT_CHECKS_LANGUAGE?= en 

# Derived variables
SPT_CHECK_LANGUAGE?= $(SPT_LANGUAGE)
SPT_CHECKS_LANGUAGE?= $(SPT_CHECK_LANGUAGE)

# Options variables
__SPT_CHECK_ID= $(if $(SPT_CHECK_ID),--check-id $(SPT_CHECK_ID))
__SPT_CHECK_IDS__CHECK= $(if $(SPT_CHECK_ID),--check-ids $(SPT_CHECK_ID))
__SPT_CHECK_IDS__CHECKS= $(if $(SPT_CHECK_IDS),--check-ids $(SPT_CHECK_IDS))
__SPT_LANGUAGE__CHECK= $(if $(SPT_CHECK_LANGUAGE),--language $(SPT_CHECK_LANGUAGE))
__SPT_LANGUAGE__CHECKS= $(if $(SPT_CHECKS_LANGUAGE),--language $(SPT_CHECKS_LANGUAGE))

# UI variables
SPT_UI_VIEW_CHECKS_FIELDS?= .{id:id,name:name,category:category}

#--- Utilities

#--- MACROS
_spt_get_check_name= $(call _spt_get_check_name_I, $(SPT_CHECK_ID))
_spt_get_check_name_I= $(call _spt_get_check_name_IL, $(1), $(SPT_CHECK_LANGUAGE))
_spt_get_check_name_IL= $(shell $(AWS) support describe-trusted-advisor-checks --language $(2) --query "checks[?id=='$(strip $(2))'].name" --output text)

#----------------------------------------------------------------------
# USAGE
#

_spt_view_framework_macros ::
	@echo 'AWS::SuPporT::Check ($(_AWS_SUPPORT_CHECK_MK_VERSION)) macros:'
	@echo '    _spt_get_check_name_{|I|IL}       - Get the name of a check (ID, Language)'
	@echo

_spt_view_framework_parameters ::
	@echo 'AWS::SuPporT::Check ($(_AWS_SUPPORT_CHECK_MK_VERSION)) variables:'
	@echo '    SPT_CHECK_ID=$(SPT_CHECK_ID)'
	@echo '    SPT_CHECK_LANGUAGE=$(SPT_CHECK_LANGUAGE)'
	@echo '    SPT_CHECK_NAME=$(SPT_CHECK_NAME)'
	@echo '    SPT_CHECKS_IDS=$(SPT_CHECKS_IDS)'
	@echo '    SPT_CHECKS_LANGUAGE=$(SPT_CHECKS_LANGUAGE)'
	@echo

_spt_view_framework_targets ::
	@echo 'AWS::SuPporT::Check ($(_AWS_SUPPORT_CHECK_MK_VERSION)) targets:'
	@echo '    _spt_refresh_check         - Refresh a check'
	@echo '    _spt_show_check            - Show everythiing related to a check'
	@echo '    _spt_show_check_results    - Show results of a check'
	@echo '    _spt_view_checks           - View checks'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_spt_refresh_check:
	@$(INFO) '$(AWS_UI_LABEL)Refreshing results of check "$(SPT_CHECK_NAME)" ...'; $(NORMAL)
	$(AWS) support refresh-trusted-advisor-check $(__SPT_CHECK_ID)

_spt_show_check: _spt_show_check_refreshstatus _spt_show_check_results _spt_show_check_summary _spt_show_check_description

_spt_show_check_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of check "$(SPT_CHECK_NAME)" ...'; $(NORMAL)
	$(AWS) support describe-trusted-advisor-checks $(__SPT_LANGUAGE__CHECK) --query "checks[?id=='$(SPT_CHECK_ID)']" --output json

_spt_show_check_refreshstatus:
	@$(INFO) '$(AWS_UI_LABEL)Showing refresh-statuses of check "$(SPT_CHECK_NAME)" ...'; $(NORMAL)
	$(AWS) support describe-trusted-advisor-check-refresh-statuses $(__SPT_CHECK_IDS__CHECK)

_spt_show_check_results:
	@$(INFO) '$(AWS_UI_LABEL)Showing results of check "$(SPT_CHECK_NAME)" ...'; $(NORMAL)
	$(AWS) support describe-trusted-advisor-check-result $(__SPT_CHECK_ID) $(__SPT_LANGUAGE__CHECK)

_spt_show_check_summary:
	@$(INFO) '$(AWS_UI_LABEL)Showing summary of check "$(SPT_CHECK_NAME)" ...'; $(NORMAL)
	$(AWS) support describe-trusted-advisor-check-summaries $(__SPT_CHECK_IDS__CHECK)

_spt_view_checks:
	@$(INFO) '$(AWS_UI_LABEL)Viewing checks for trsuted-advisor ...'; $(NORMAL)
	$(AWS) support describe-trusted-advisor-checks $(__SPT_LANGUAGE__CHECKS) --query 'checks[]$(SPT_UI_VIEW_CHECKS_FIELDS)'
