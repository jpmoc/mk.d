_AWS_WAF_REGEXPATTERNSET_MK_VERSION = $(_AWS_WAF_MK_VERSION)

# WAF_REGEXPATTERNSET_CHANGETOKEN?=
# WAF_REGEXPATTERNSET_ID?=
# WAF_REGEXPATTERNSET_NAME?=
# WAF_REGEXPATTERNSET_UPDATES?=
# WAF_REGEXPATTERNSET_UPDATES_FILEPATH?= ./regexpatternset-updates.json
# WAF_REGEXPATTERNSETS_SET_NAME?=

# Derived parameters
WAF_REGEXPATTERNSET_CHANGETOKEN?= $(WAF_CHANGETOKEN)
WAF_REGEXPATTERNSET_UPDATES?= $(if $(WAF_REGEXPATTERNSET_UPDATES_FILEPATH),file://$(WAF_REGEXPATTERNSET_UPDATES_FILEPATH))

# Option parameters
__WAF_REGEXPATTERNSET_ID= $(if $(WAF_REGEXPATTERNSET_ID), --regex-pattern-set-id $(WAF_REGEXPATTERNSET_ID))
__WAF_CHANGE_TOKEN__REGEXPATTERNSET= $(if $(WAF_REGEXPATTERNSET_CHANGETOKEN), --change-token $(WAF_REGEXPATTERNSET_CHANGETOKEN))
__WAF_NAME__REGEXPATTERNSET= $(if $(WAF_REGEXPATTERNSET_NAME), --name $(WAF_REGEXPATTERNSET_NAME))

# UI parameters

#--- MACRO
_waf_get_regexpatternset_id=

#----------------------------------------------------------------------
# USAGE
#

_waf_view_framework_macros ::
	@echo 'AWS::WAF::RegexPatternSet ($(_AWS_WAF_REGEXPATTERNSET_MK_VERSION)) macros:'
	@echo '    _waf_get_regexpatternset_id              - Get ID of a regex-pattern-set'
	@echo

_waf_view_framework_parameters ::
	@echo 'AWS::WAF::RegexPatternSet ($(_AWS_WAF_REGEXPATTERNSET_MK_VERSION)) parameters:'
	@echo '    WAF_REGEXPATTERNSET_CHANGETOKEN=$(WAF_REGEXPATTERNSET_CHANGETOKEN)'
	@echo '    WAF_REGEXPATTERNSET_ID=$(WAF_REGEXPATTERNSET_ID)'
	@echo '    WAF_REGEXPATTERNSET_NAME=$(WAF_REGEXPATTERNSET_NAME)'
	@echo '    WAF_REGEXPATTERNSET_UPDATES=$(WAF_REGEXPATTERNSET_UPDATES)'
	@echo '    WAF_REGEXPATTERNSET_UPDATES_FILEPATH=$(WAF_REGEXPATTERNSET_UPDATES_FILEPATH)'
	@echo

_waf_view_framework_targets ::
	@echo 'AWS::WAF::RegexPatternSet ($(_AWS_WAF_REGEXPATTERNSET_MK_VERSION)) targets:'
	@echo '    _waf_create_regexpatternset              - Create a regex-pattern-set'
	@echo '    _waf_delete_regexpatternset              - Delete a regex-pattern-set'
	@echo '    _waf_show_regexpatternset                - Show everything related to a regex-pattern-set'
	@echo '    _waf_update_regexpatternset              - Update a regex-pattern-set'
	@echo '    _waf_view_regexpatternsets               - View existing regex-pattern sets'
	@echo '    _waf_view_regexpatternsets_set           - View a set of regex-pattern sets'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_waf_create_regexpatternset:
	@$(INFO) '$(AWS_UI_LABEL)Creating regex-pattern-sets "$(WAF_REGEXPATTERNSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf create-regex-pattern-set $(__WAF_CHANGETOKEN__REGEXPATTERNSET) $(__WAF_NAME__REGEXPATTERNSET)

_waf_delete_regexpatternset:
	@$(INFO) '$(AWS_UI_LABEL)Deleting regex-pattern-sets "$(WAF_REGEXPATTERNSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf delete-regex-pattern-set $(__WAF_REGEXPATTERNSET_ID) $(__WAF_CHANGETOKEN__REGEXPATTERNSET)

_waf_show_regexpatternset:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of regex-pattern-set "$(WAF_REGEXPATTERNSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf get-regex-pattern-set $(__WAF_REGEXPATTERNSET_ID)

_waf_update_regexpatternset:
	@$(INFO) '$(AWS_UI_LABEL)Updating regex-pattern-set "$(WAF_REGEXPATTERNSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf update-regex-pattern-set $(__WAF_REGEXPATTERNSET_ID) $(__WAF_CHANGE_TOKEN__REGEXPATTERNSET) $(__WAF_UPDATES__REGEXPATTERNSET)

_waf_view_sets :: _waf_view_regexpatternsets
_waf_view_regexpatternsets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL regex-pattern-sets ...'; $(NORMAL)
	$(AWS) waf list-regex-pattern-sets

_waf_view_regexpatternsets_set:

