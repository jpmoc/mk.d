_AWS_WAF_XSSMATCHSET_MK_VERSION = $(_AWS_WAF_MK_VERSION)

# WAF_XSSMATCHSET_CHANGETOKEN?=
# WAF_XSSMATCHSET_ID?=
# WAF_XSSMATCHSET_NAME?=
# WAF_XSSMATCHSET_UPDATES?=
# WAF_XSSMATCHSET_UPDATES_FILEPATH?= ./xssmatchset-updates.json
# WAF_XSSMATCHSETS_SET_NAME?=

# Derived parameters
WAF_XSSMATCHSET_CHANGETOKEN?= $(WAF_CHANGETOKEN)
WAF_XSSMATCHSET_UPDATES?= $(if $(WAF_XSSMATCHSET_UPDATES_FILEPATH),file://$(WAF_XSSMATCHSET_UPDATES_FILEPATH))

# Option parameters
__WAF_XSSMATCHSET_ID= $(if $(WAF_XSSMATCHSET_ID), --xss-match-set-id $(WAF_XSSMATCHSET_ID))
__WAF_CHANGE_TOKEN__XSSMATCHSET= $(if $(WAF_XSSMATCHSET_CHANGETOKEN), --change-token $(WAF_XSSMATCHSET_CHANGETOKEN))
__WAF_NAME__XSSMATCHSET= $(if $(WAF_XSSMATCHSET_NAME), --name $(WAF_XSSMATCHSET_NAME))

# UI parameters

#--- MACRO
_waf_get_xssmatchset_id=

#----------------------------------------------------------------------
# USAGE
#

_waf_view_framework_macros ::
	@echo 'AWS::WAF::XssMatchSet ($(_AWS_WAF_XSSMATCHSET_MK_VERSION)) macros:'
	@echo '    _waf_get_xssmatchset_id              - Get ID of a xss-match-set'
	@echo

_waf_view_framework_parameters ::
	@echo 'AWS::WAF::XssMatchSet ($(_AWS_WAF_XSSMATCHSET_MK_VERSION)) parameters:'
	@echo '    WAF_XSSMATCHSET_CHANGETOKEN=$(WAF_XSSMATCHSET_CHANGETOKEN)'
	@echo '    WAF_XSSMATCHSET_ID=$(WAF_XSSMATCHSET_ID)'
	@echo '    WAF_XSSMATCHSET_NAME=$(WAF_XSSMATCHSET_NAME)'
	@echo '    WAF_XSSMATCHSET_UPDATES=$(WAF_XSSMATCHSET_UPDATES)'
	@echo '    WAF_XSSMATCHSET_UPDATES_FILEPATH=$(WAF_XSSMATCHSET_UPDATES_FILEPATH)'
	@echo

_waf_view_framework_targets ::
	@echo 'AWS::WAF::XssMatchSet ($(_AWS_WAF_XSSMATCHSET_MK_VERSION)) targets:'
	@echo '    _waf_create_xssmatchset              - Create a xss-match-set'
	@echo '    _waf_delete_xssmatchset              - Delete a xss-match-set'
	@echo '    _waf_show_xssmatchset                - Show everything related to a xss-match-set'
	@echo '    _waf_update_xssmatchset              - Update a xss-match-set'
	@echo '    _waf_view_xssmatchsets               - View existing xss-match sets'
	@echo '    _waf_view_xssmatchsets_set           - View a set of xss-match sets'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_waf_create_xssmatchset:
	@$(INFO) '$(AWS_UI_LABEL)Creating xss-match-sets "$(WAF_XSSMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf create-xss-match-set $(__WAF_CHANGETOKEN__XSSMATCHSET) $(__WAF_NAME__XSSMATCHSET)

_waf_delete_xssmatchset:
	@$(INFO) '$(AWS_UI_LABEL)Deleting xss-match-sets "$(WAF_XSSMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf delete-xss-match-set $(__WAF_XSSMATCHSET_ID) $(__WAF_CHANGETOKEN__XSSMATCHSET)

_waf_show_xssmatchset:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of xss-match-set "$(WAF_XSSMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf get-xss-match-set $(__WAF_XSSMATCHSET_ID)

_waf_update_xssmatchset:
	@$(INFO) '$(AWS_UI_LABEL)Updating xss-match-set "$(WAF_XSSMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf update-xss-match-set $(__WAF_XSSMATCHSET_ID) $(__WAF_CHANGE_TOKEN__XSSMATCHSET) $(__WAF_UPDATES__XSSMATCHSET)

_waf_view_sets :: _waf_view_xssmatchsets
_waf_view_xssmatchsets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL xss-match-sets ...'; $(NORMAL)
	$(AWS) waf list-xss-match-sets

_waf_view_xssmatchsets_set:

