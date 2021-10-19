_AWS_WAF_REGEXMATCHSET_MK_VERSION = $(_AWS_WAF_MK_VERSION)

# WAF_REGEXMATCHSET_CHANGETOKEN?=
# WAF_REGEXMATCHSET_ID?=
# WAF_REGEXMATCHSET_NAME?=
# WAF_REGEXMATCHSET_UPDATES?=
# WAF_REGEXMATCHSET_UPDATES_FILEPATH?= ./regexmatchset-updates.json
# WAF_REGEXMATCHSETS_SET_NAME?=

# Derived parameters
WAF_REGEXMATCHSET_CHANGETOKEN?= $(WAF_CHANGETOKEN)
WAF_REGEXMATCHSET_UPDATES?= $(if $(WAF_REGEXMATCHSET_UPDATES_FILEPATH),file://$(WAF_REGEXMATCHSET_UPDATES_FILEPATH))

# Option parameters
__WAF_REGEXMATCHSET_ID= $(if $(WAF_REGEXMATCHSET_ID), --regex-match-set-id $(WAF_REGEXMATCHSET_ID))
__WAF_CHANGE_TOKEN__REGEXMATCHSET= $(if $(WAF_REGEXMATCHSET_CHANGETOKEN), --change-token $(WAF_REGEXMATCHSET_CHANGETOKEN))
__WAF_NAME__REGEXMATCHSET= $(if $(WAF_REGEXMATCHSET_NAME), --name $(WAF_REGEXMATCHSET_NAME))

# UI parameters

#--- MACRO
_waf_get_regexmatchset_id=

#----------------------------------------------------------------------
# USAGE
#

_waf_view_framework_macros ::
	@echo 'AWS::WAF::RegexMatchSet ($(_AWS_WAF_REGEXMATCHSET_MK_VERSION)) macros:'
	@echo '    _waf_get_regexmatchset_id              - Get ID of a regex-match-set'
	@echo

_waf_view_framework_parameters ::
	@echo 'AWS::WAF::RegexMatchSet ($(_AWS_WAF_REGEXMATCHSET_MK_VERSION)) parameters:'
	@echo '    WAF_REGEXMATCHSET_CHANGETOKEN=$(WAF_REGEXMATCHSET_CHANGETOKEN)'
	@echo '    WAF_REGEXMATCHSET_ID=$(WAF_REGEXMATCHSET_ID)'
	@echo '    WAF_REGEXMATCHSET_NAME=$(WAF_REGEXMATCHSET_NAME)'
	@echo '    WAF_REGEXMATCHSET_UPDATES=$(WAF_REGEXMATCHSET_UPDATES)'
	@echo '    WAF_REGEXMATCHSET_UPDATES_FILEPATH=$(WAF_REGEXMATCHSET_UPDATES_FILEPATH)'
	@echo

_waf_view_framework_targets ::
	@echo 'AWS::WAF::RegexMatchSet ($(_AWS_WAF_REGEXMATCHSET_MK_VERSION)) targets:'
	@echo '    _waf_create_regexmatchset              - Create a regex-match-set'
	@echo '    _waf_delete_regexmatchset              - Delete a regex-match-set'
	@echo '    _waf_show_regexmatchset                - Show everything related to a regex-match-set'
	@echo '    _waf_update_regexmatchset              - Update a regex-match-set'
	@echo '    _waf_view_regexmatchsets               - View existing regex-match sets'
	@echo '    _waf_view_regexmatchsets_set           - View a set of regex-match sets'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_waf_create_regexmatchset:
	@$(INFO) '$(AWS_UI_LABEL)Creating regex-match-sets "$(WAF_REGEXMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf create-regex-match-set $(__WAF_CHANGETOKEN__REGEXMATCHSET) $(__WAF_NAME__REGEXMATCHSET)

_waf_delete_regexmatchset:
	@$(INFO) '$(AWS_UI_LABEL)Deleting regex-match-sets "$(WAF_REGEXMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf delete-regex-match-set $(__WAF_REGEXMATCHSET_ID) $(__WAF_CHANGETOKEN__REGEXMATCHSET)

_waf_show_regexmatchset:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of regex-match-set "$(WAF_REGEXMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf get-regex-match-set $(__WAF_REGEXMATCHSET_ID)

_waf_update_regexmatchset:
	@$(INFO) '$(AWS_UI_LABEL)Updating regex-match-set "$(WAF_REGEXMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf update-regex-match-set $(__WAF_REGEXMATCHSET_ID) $(__WAF_CHANGE_TOKEN__REGEXMATCHSET) $(__WAF_UPDATES__REGEXMATCHSET)

_waf_view_sets :: _waf_view_regexmatchsets
_waf_view_regexmatchsets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL regex-match-sets ...'; $(NORMAL)
	$(AWS) waf list-regex-match-sets

_waf_view_regexmatchsets_set:

