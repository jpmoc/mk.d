_AWS_WAF_GEOMATCHSET_MK_VERSION= $(_AWS_WAF_MK_VERSION)

# WAF_GEOMATCHSET_CHANGETOKEN?=
# WAF_GEOMATCHSET_ID?=
# WAF_GEOMATCHSET_NAME?=
# WAF_GEOMATCHSET_UPDATES?=
# WAF_GEOMATCHSET_UPDATES_FILEPATH?= geomatchset-updates.json

# Derived parameters
WAF_GEOMATCHSET_CHANGETOKEN?= $(WAF_CHANGETOKEN)
WAF_GEOMATCHSET_UPDATES?= $(if $(WAF_GEOMATCHSET_UPDATES_FILEPATH),file://$(WAF_GEOMATCHSET_UPDATES_FILEPATH))

# Option parameters
__WAF_GEOMATCHSET_ID= $(if $(WAF_GEOMATCHSET_ID), --geo-match-set-id $(WAF_GEOMATCHSET_ID))
__WAF_CHANGE_TOKEN__GEOMATCHSET= $(if $(WAF_GEOMATCHSET_CHANGETOKEN), --change-token $(WAF_GEOMATCHSET_CHANGETOKEN))
__WAF_NAME__GEOMATCHSET= $(if $(WAF_GEOMATCHSET_NAME), --name $(WAF_GEOMATCHSET_NAME))

# UI parameters

#--- MACRO
_waf_get_geomatchset_id=

#----------------------------------------------------------------------
# USAGE
#

_waf_view_framework_macros ::
	@echo 'AWS::WAF::GeoMatchSet ($(_AWS_WAF_GEOMATCHSET_MK_VERSION)) macros:'
	@echo '    _waf_get_geomatchset_id               - Get the ID of a geo-match-set'
	@echo

_waf_view_framework_parameters ::
	@echo 'AWS::WAF::GeoMatchSet ($(_AWS_WAF_GEOMATCHSET_MK_VERSION)) parameters:'
	@echo '    WAF_GEOMATCHSET_CHANGETOKEN=$(WAF_GEOMATCHSET_CHANGETOKEN)'
	@echo '    WAF_GEOMATCHSET_ID=$(WAF_GEOMATCHSET_ID)'
	@echo '    WAF_GEOMATCHSET_NAME=$(WAF_GEOMATCHSET_NAME)'
	@echo '    WAF_GEOMATCHSET_UPDATES=$(WAF_GEOMATCHSET_UPDATES)'
	@echo '    WAF_GEOMATCHSET_UPDATES_FILEPATH=$(WAF_GEOMATCHSET_UPDATES_FILEPATH)'
	@echo

_waf_view_framework_targets ::
	@echo 'AWS::WAF::GeoMatchSet ($(_AWS_WAF_GEOMATCHSET_MK_VERSION)) targets:'
	@echo '    _waf_create_geomatchset              - Create a geo-match-set'
	@echo '    _waf_delete_geomatchset              - Delete a geo-match-set'
	@echo '    _waf_show_geomatchset                - Show everything related to a geo-match-set'
	@echo '    _waf_update_geomatchset              - Update a geo-match-set'
	@echo '    _waf_view_geomatchsets               - View existing geo-match sets'
	@echo '    _waf_view_geomatchsets_set           - View a set of geo-match sets'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_waf_create_geomatchset:
	@$(INFO) '$(AWS_UI_LABEL)Creating geo-match-sets "$(WAF_GEOMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf create-geo-match-set $(__WAF_CHANGETOKEN__GEOMATCHSET) $(__WAF_NAME__GEOMATCHSET)

_waf_delete_geomatchset:
	@$(INFO) '$(AWS_UI_LABEL)Deleting geo-match-sets "$(WAF_GEOMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf delete-geo-match-set $(__WAF_GEOMATCHSET_ID) $(__WAF_CHANGETOKEN__GEOMATCHSET)

_waf_show_geomatchset:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of geo-match-set "$(WAF_GEOMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf get-geo-match-set $(__WAF_GEOMATCHSET_ID)

_waf_update_geomatchset:
	@$(INFO) '$(AWS_UI_LABEL)Updating geo-match-set "$(WAF_GEOMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf update-geo-match-set $(__WAF_CHANGE_TOKEN__GEOMATCHSET) $(__WAF_GEOMATCHSET_ID) $(__WAF_UPDATES__GEOMATCHSET)

_waf_view_sets :: _waf_view_geomatchsets
_waf_view_geomatchsets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL geo-match-sets ...'; $(NORMAL)
	$(AWS) waf list-geo-match-sets

_waf_view_geomatchsets_set:

