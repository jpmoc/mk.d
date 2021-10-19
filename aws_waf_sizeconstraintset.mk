_AWS_WAF_SIZECONSTRAINTSET_MK_VERSION = $(_AWS_WAF_MK_VERSION)

# WAF_SIZECONSTRAINTSET_CHANGETOKEN?=
# WAF_SIZECONSTRAINTSET_ID?=
# WAF_SIZECONSTRAINTSET_NAME?=
# WAF_SIZECONSTRAINTSET_UPDATES?=
# WAF_SIZECONSTRAINTSET_UPDATES_FILEPATH?= ./sizeconstraintset-updates.json
# WAF_SIZECONSTRAINTSETS_SET_NAME?=

# Derived parameters
WAF_SIZECONSTRAINTSET_CHANGETOKEN?= $(WAF_CHANGETOKEN)
WAF_SIZECONSTRAINTSET_UPDATES?= $(if $(WAF_SIZECONSTRAINTSET_UPDATES_FILEPATH),file://$(WAF_SIZECONSTRAINTSET_UPDATES_FILEPATH))

# Option parameters
__WAF_SIZECONSTRAINTSET_ID= $(if $(WAF_SIZECONSTRAINTSET_ID), --size-constraint-set-id $(WAF_SIZECONSTRAINTSET_ID))
__WAF_CHANGE_TOKEN__SIZECONSTRAINTSET= $(if $(WAF_SIZECONSTRAINTSET_CHANGETOKEN), --change-token $(WAF_SIZECONSTRAINTSET_CHANGETOKEN))
__WAF_NAME__SIZECONSTRAINTSET= $(if $(WAF_SIZECONSTRAINTSET_NAME), --name $(WAF_SIZECONSTRAINTSET_NAME))

# UI parameters

#--- MACRO
_waf_get_sizeconstraintset_id=

#----------------------------------------------------------------------
# USAGE
#

_waf_view_framework_macros ::
	@echo 'AWS::WAF::SizeConstraintSet ($(_AWS_WAF_SIZECONSTRAINTSET_MK_VERSION)) macros:'
	@echo '    _waf_get_sizeconstraintset_id              - Get ID of a size-constraint-set'
	@echo

_waf_view_framework_parameters ::
	@echo 'AWS::WAF::SizeConstraintSet ($(_AWS_WAF_SIZECONSTRAINTSET_MK_VERSION)) parameters:'
	@echo '    WAF_SIZECONSTRAINTSET_CHANGETOKEN=$(WAF_SIZECONSTRAINTSET_CHANGETOKEN)'
	@echo '    WAF_SIZECONSTRAINTSET_ID=$(WAF_SIZECONSTRAINTSET_ID)'
	@echo '    WAF_SIZECONSTRAINTSET_NAME=$(WAF_SIZECONSTRAINTSET_NAME)'
	@echo '    WAF_SIZECONSTRAINTSET_UPDATES=$(WAF_SIZECONSTRAINTSET_UPDATES)'
	@echo '    WAF_SIZECONSTRAINTSET_UPDATES_FILEPATH=$(WAF_SIZECONSTRAINTSET_UPDATES_FILEPATH)'
	@echo

_waf_view_framework_targets ::
	@echo 'AWS::WAF::SizeConstraintSet ($(_AWS_WAF_SIZECONSTRAINTSET_MK_VERSION)) targets:'
	@echo '    _waf_create_sizeconstraintset              - Create a size-constraint-set'
	@echo '    _waf_delete_sizeconstraintset              - Delete a size-constraint-set'
	@echo '    _waf_show_sizeconstraintset                - Show everything related to a size-constraint-set'
	@echo '    _waf_update_sizeconstraintset              - Update a size-constraint-set'
	@echo '    _waf_view_sizeconstraintsets               - View existing size-constraint sets'
	@echo '    _waf_view_sizeconstraintsets_set           - View a set of size-constraint sets'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_waf_create_sizeconstraintset:
	@$(INFO) '$(AWS_UI_LABEL)Creating size-constraint-sets "$(WAF_SIZECONSTRAINTSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf create-size-constraint-set $(__WAF_CHANGETOKEN__SIZECONSTRAINTSET) $(__WAF_NAME__SIZECONSTRAINTSET)

_waf_delete_sizeconstraintset:
	@$(INFO) '$(AWS_UI_LABEL)Deleting size-constraint-sets "$(WAF_SIZECONSTRAINTSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf delete-size-constraint-set $(__WAF_SIZECONSTRAINTSET_ID) $(__WAF_CHANGETOKEN__SIZECONSTRAINTSET)

_waf_show_sizeconstraintset:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of size-constraint-set "$(WAF_SIZECONSTRAINTSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf get-size-constraint-set $(__WAF_SIZECONSTRAINTSET_ID)

_waf_update_sizeconstraintset:
	@$(INFO) '$(AWS_UI_LABEL)Updating size-constraint-set "$(WAF_SIZECONSTRAINTSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf update-size-constraint-set $(__WAF_SIZECONSTRAINTSET_ID) $(__WAF_CHANGE_TOKEN__SIZECONSTRAINTSET) $(__WAF_UPDATES__SIZECONSTRAINTSET)

_waf_view_sets :: _waf_view_sizeconstraintsets
_waf_view_sizeconstraintsets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL size-constraint-sets ...'; $(NORMAL)
	$(AWS) waf list-size-constraint-sets

_waf_view_sizeconstraintsets_set:

