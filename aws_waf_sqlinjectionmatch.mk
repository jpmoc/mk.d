_AWS_WAF_SQLINJECTIONMATCHSET_MK_VERSION = $(_AWS_WAF_MK_VERSION)

# WAF_SQLINJECTIONMATCHSET_CHANGETOKEN?=
# WAF_SQLINJECTIONMATCHSET_ID?=
# WAF_SQLINJECTIONMATCHSET_NAME?=
# WAF_SQLINJECTIONMATCHSET_UPDATES?=
# WAF_SQLINJECTIONMATCHSET_UPDATES_FILEPATH?= ./sqlinjectionmatchset-updates.json
# WAF_SQLINJECTIONMATCHSETS_SET_NAME?=

# Derived parameters
WAF_SQLINJECTIONMATCHSET_CHANGETOKEN?= $(WAF_CHANGETOKEN)
WAF_SQLINJECTIONMATCHSET_UPDATES?= $(if $(WAF_SQLINJECTIONMATCHSET_UPDATES_FILEPATH),file://$(WAF_SQLINJECTIONMATCHSET_UPDATES_FILEPATH))

# Option parameters
__WAF_SQLINJECTIONMATCHSET_ID= $(if $(WAF_SQLINJECTIONMATCHSET_ID), --sql-injection-match-set-id $(WAF_SQLINJECTIONMATCHSET_ID))
__WAF_CHANGE_TOKEN__SQLINJECTIONMATCHSET= $(if $(WAF_SQLINJECTIONMATCHSET_CHANGETOKEN), --change-token $(WAF_SQLINJECTIONMATCHSET_CHANGETOKEN))
__WAF_NAME__SQLINJECTIONMATCHSET= $(if $(WAF_SQLINJECTIONMATCHSET_NAME), --name $(WAF_SQLINJECTIONMATCHSET_NAME))

# UI parameters

#--- MACRO
_waf_get_sqlinjectionmatchset_id=

#----------------------------------------------------------------------
# USAGE
#

_waf_view_framework_macros ::
	@echo 'AWS::WAF::SqlInjectionSet ($(_AWS_WAF_SQLINJECTIONMATCHSET_MK_VERSION)) macros:'
	@echo '    _waf_get_sqlinjectionmatchset_id              - Get ID of a sql-injection-match-set'
	@echo

_waf_view_framework_parameters ::
	@echo 'AWS::WAF::SqlInjectionSet ($(_AWS_WAF_SQLINJECTIONMATCHSET_MK_VERSION)) parameters:'
	@echo '    WAF_SQLINJECTIONMATCHSET_CHANGETOKEN=$(WAF_SQLINJECTIONMATCHSET_CHANGETOKEN)'
	@echo '    WAF_SQLINJECTIONMATCHSET_ID=$(WAF_SQLINJECTIONMATCHSET_ID)'
	@echo '    WAF_SQLINJECTIONMATCHSET_NAME=$(WAF_SQLINJECTIONMATCHSET_NAME)'
	@echo '    WAF_SQLINJECTIONMATCHSET_UPDATES=$(WAF_SQLINJECTIONMATCHSET_UPDATES)'
	@echo '    WAF_SQLINJECTIONMATCHSET_UPDATES_FILEPATH=$(WAF_SQLINJECTIONMATCHSET_UPDATES_FILEPATH)'
	@echo

_waf_view_framework_targets ::
	@echo 'AWS::WAF::SqlInjectionSet ($(_AWS_WAF_SQLINJECTIONMATCHSET_MK_VERSION)) targets:'
	@echo '    _waf_create_sqlinjectionmatchset              - Create a sql-injection-match-set'
	@echo '    _waf_delete_sqlinjectionmatchset              - Delete a sql-injection-match-set'
	@echo '    _waf_show_sqlinjectionmatchset                - Show everything related to a sql-injection-match-set'
	@echo '    _waf_update_sqlinjectionmatchset              - Update a sql-injection-match-set'
	@echo '    _waf_view_sqlinjectionmatchsets               - View existing sql-injection-match sets'
	@echo '    _waf_view_sqlinjectionmatchsets_set           - View a set of sql-injection-match sets'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_waf_create_sqlinjectionmatchset:
	@$(INFO) '$(AWS_UI_LABEL)Creating sql-injection-match-sets "$(WAF_SQLINJECTIONMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf create-sql-injection-match-set $(__WAF_CHANGETOKEN__SQLINJECTIONMATCHSET) $(__WAF_NAME__SQLINJECTIONMATCHSET)

_waf_delete_sqlinjectionmatchset:
	@$(INFO) '$(AWS_UI_LABEL)Deleting sql-injection-match-sets "$(WAF_SQLINJECTIONMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf delete-sql-injection-match-set $(__WAF_SQLINJECTIONMATCHSET_ID) $(__WAF_CHANGETOKEN__SQLINJECTIONMATCHSET)

_waf_show_sqlinjectionmatchset:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of sql-injection-match-set "$(WAF_SQLINJECTIONMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf get-sql-injection-match-set $(__WAF_SQLINJECTIONMATCHSET_ID)

_waf_update_sqlinjectionmatchset:
	@$(INFO) '$(AWS_UI_LABEL)Updating sql-injection-match-set "$(WAF_SQLINJECTIONMATCHSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf update-sql-injection-match-set $(__WAF_SQLINJECTIONMATCHSET_ID) $(__WAF_CHANGE_TOKEN__SQLINJECTIONMATCHSET) $(__WAF_UPDATES__SQLINJECTIONMATCHSET)

_waf_view_sets :: _waf_view_sqlinjectionmatchsets
_waf_view_sqlinjectionmatchsets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL sql-injection-match-sets ...'; $(NORMAL)
	$(AWS) waf list-sql-injection-match-sets

_waf_view_sqlinjectionmatchsets_set:

