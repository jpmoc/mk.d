_AWS_WAF_BYTEMATCHSET_MK_VERSION = $(_AWS_WAF_MK_VERSION)

# WAF_BYTEMATCHSET_CHANGETOKEN?=
# WAF_BYTEMATCHSET_ID?=
# WAF_BYTEMATCHSET_NAME?=
# WAF_BYTEMATCHSET_UPDATES?=
# WAF_BYTEMATCHSET_UPDATES_FILEPATH?= ./bytematchset-updates.json
# WAF_BYTEMATCHSETS_SET_NAME?=

# Derived parameters
WAF_BYTEMATCHSET_CHANGETOKEN?= $(WAF_CHANGETOKEN)
WAF_BYTEMATCHSET_UPDATES?= $(if $(WAF_BYTEMATCHSET_UPDATES_FILEPATH),file://$(WAF_BYTEMATCHSET_UPDATES_FILEPATH))

# Option parameters
__WAF_BYTEMATCHSET_ID= $(if $(WAF_BYTEMATCHSET_ID), --byte-match-set-id $(WAF_BYTEMATCHSET_ID))
__WAF_CHANGE_TOKEN__BYTEMATCHSET= $(if $(WAF_BYTEMATCHSET_CHANGETOKEN), --change-token $(WAF_BYTEMATCHSET_CHANGETOKEN))
__WAF_NAME__BYTEMATCHSET= $(if $(WAF_BYTEMATCHSET_NAME), --name $(WAF_BYTEMATCHSET_NAME))

# UI parameters

#--- MACRO
_waf_get_bytematchset_id=

#----------------------------------------------------------------------
# USAGE
#

_waf_view_framework_macros ::
	@echo 'AWS::WAF::ByteMatchSet ($(_AWS_WAF_BYTEMATCHSET_MK_VERSION)) macros:'
	@echo '    _waf_get_bytematchset_id              - Get ID of a byte-match-set'
	@echo

_waf_view_framework_parameters ::
	@echo 'AWS::WAF::ByteMatchSet ($(_AWS_WAF_BYTEMATCHSET_MK_VERSION)) parameters:'
	@echo '    WAF_BYTEMATCHSET_CHANGETOKEN=$(WAF_BYTEMATCHSET_CHANGETOKEN)'
	@echo '    WAF_BYTEMATCHSET_ID=$(WAF_BYTEMATCHSET_ID)'
	@echo '    WAF_BYTEMATCHSET_NAME=$(WAF_BYTEMATCHSET_NAME)'
	@echo '    WAF_BYTEMATCHSET_UPDATES=$(WAF_BYTEMATCHSET_UPDATES)'
	@echo '    WAF_BYTEMATCHSET_UPDATES_FILEPATH=$(WAF_BYTEMATCHSET_UPDATES_FILEPATH)'
	@echo

_waf_view_framework_targets ::
	@echo 'AWS::WAF::ByteMatchSet ($(_AWS_WAF_BYTEMATCHSET_MK_VERSION)) targets:'
	@echo '    _waf_create_bytematchset              - Create a byte-match-set'
	@echo '    _waf_delete_bytematchset              - Delete a byte-match-set'
	@echo '    _waf_show_bytematchset                - Show everything related to a byte-match-set'
	@echo '    _waf_update_bytematchset              - Update a byte-match-set'
	@echo '    _waf_view_bytematchsets               - View existing byte-match sets'
	@echo '    _waf_view_bytematchsets_set           - View a set of byte-match sets'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_waf_create_bytematchset:
	@$(INFO) '$(AWS_UI_LABEL)Creating byte-match-sets "$(WAF_BYTEMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf create-byte-match-set $(__WAF_CHANGETOKEN__BYTEMATCHSET) $(__WAF_NAME__BYTEMATCHSET)

_waf_delete_bytematchset:
	@$(INFO) '$(AWS_UI_LABEL)Deleting byte-match-sets "$(WAF_BYTEMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf delete-byte-match-set $(__WAF_BYTEMATCHSET_ID) $(__WAF_CHANGETOKEN__BYTEMATCHSET)

_waf_show_bytematchset:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of byte-match-set "$(WAF_BYTEMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf get-byte-match-set $(__WAF_BYTEMATCHSET_ID)

_waf_update_bytematchset:
	@$(INFO) '$(AWS_UI_LABEL)Updating byte-match-set "$(WAF_BYTEMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf update-byte-match-set $(__WAF_BYTEMATCHSET_ID) $(__WAF_CHANGE_TOKEN__BYTEMATCHSET) $(__WAF_UPDATES__BYTEMATCHSET)

_waf_view_sets :: _waf_view_bytematchsets
_waf_view_bytematchsets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL byte-match-sets ...'; $(NORMAL)
	$(AWS) waf list-byte-match-sets

_waf_view_bytematchsets_set:

