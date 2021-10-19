_AWS_WAF_IPSET_MK_VERSION = $(_AWS_WAF_MK_VERSION)

# WAF_IPSET_CHANGETOKEN?=
# WAF_IPSET_ID?=
# WAF_IPSET_NAME?=
# WAF_IPSET_UPDATES?=
# WAF_IPSETS_SET_NAME?=

# Derived parameters
WAF_IPSET_CHANGETOKEN?= $(WAF_CHANGETOKEN)
WAF_IPSET_UPDATES?= $(if $(WAF_IPSET_UPDATES_FILEPATH),file://$(WAF_IPSET_UPDATES_FILEPATH))

# Option parameters
__WAF_IPSET_ID= $(if $(WAF_IPSET_ID), --ip-set-id $(WAF_IPSET_ID))
__WAF_CHANGE_TOKEN__IPSET= $(if $(WAF_IPSET_CHANGETOKEN), --change-token $(WAF_IPSET_CHANGETOKEN))
__WAF_NAME__IPSET= $(if $(WAF_IPSET_NAME), --name $(WAF_IPSET_NAME))

# UI parameters

#--- MACRO
_waf_get_ipset_id=

#----------------------------------------------------------------------
# USAGE
#

_waf_view_framework_macros ::
	@echo 'AWS::WAF::IpSet ($(_AWS_WAF_IPSET_MK_VERSION)) macros:'
	@echo '    _waf_get_ipset_id              - Get ID of an ip-set'
	@echo

_waf_view_framework_parameters ::
	@echo 'AWS::WAF::IpSet ($(_AWS_WAF_IPSET_MK_VERSION)) parameters:'
	@echo '    WAF_IPSET_CHANGETOKEN=$(WAF_IPSET_CHANGETOKEN)'
	@echo '    WAF_IPSET_ID=$(WAF_IPSET_ID)'
	@echo '    WAF_IPSET_NAME=$(WAF_IPSET_NAME)'
	@echo '    WAF_IPSET_UPDATES=$(WAF_IPSET_UPDATES)'
	@echo '    WAF_IPSET_UPDATES_FILEPATH=$(WAF_IPSET_UPDATES_FILEPATH)'
	@echo

_waf_view_framework_targets ::
	@echo 'AWS::WAF::IpSet ($(_AWS_WAF_IPSET_MK_VERSION)) targets:'
	@echo '    _waf_create_ipset              - Create an ip-set'
	@echo '    _waf_delete_ipset              - Delete an ip-set'
	@echo '    _waf_show_ipset                - Show everything related to an ip-set'
	@echo '    _waf_update_ipset              - Update an ip-set'
	@echo '    _waf_view_ipsets               - View existing ip sets'
	@echo '    _waf_view_ipsets_set           - View a set of ip sets'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_waf_create_ipset:
	@$(INFO) '$(AWS_UI_LABEL)Creating ip-sets "$(WAF_IPSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf create-ip-set $(__WAF_CHANGETOKEN__IPSET) $(__WAF_NAME__IPSET)

_waf_delete_ipset:
	@$(INFO) '$(AWS_UI_LABEL)Deleting ip-sets "$(WAF_IPSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf delete-ip-set $(__WAF_IPSET_ID) $(__WAF_CHANGETOKEN__IPSET)

_waf_show_ipset:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of ip-set "$(WAF_IPSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf get-ip-set $(__WAF_IPSET_ID)

_waf_update_ipset:
	@$(INFO) '$(AWS_UI_LABEL)Updating ip-set "$(WAF_IPSET_NAME)" ...'; $(NORMAL)
	$(AWS) waf update-ip-set $(__WAF_IPSET_ID) $(__WAF_CHANGE_TOKEN__IPSET) $(__WAF_UPDATES__IPSET)

_waf_view_sets :: _waf_view_ipsets
_waf_view_ipsets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL ip-sets ...'; $(NORMAL)
	$(AWS) waf list-ip-sets

_waf_view_ipsets_set:

