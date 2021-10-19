_AWS_DS_TRUST_MK_VERSION= $(_AWS_DS_MK_VERSION)

# DS_TRUST_CONDITIONALFORWARDER_IPS?= "string" ...
# DS_TRUST_DELETE_CONDITIONALFORWARDER?= true
# DS_TRUST_DIRECTION?= Two-Way
# DS_TRUST_DIRECTORY_ID?= d-926728bc5d
# DS_TRUST_ID?=
# DS_TRUST_IDS?=
# DS_TRUST_NAME?= my-trust-relationship
# DS_TRUST_PASSWORD?=
# DS_TRUST_REMOTEDOMAIN_NAME?=
DS_TRUST_TYPE?= Forest
# DS_TRUSTS_SET_NAME?= my-trusts-set

# Derived parameters
DS_TRUST_DIRECTORY_ID?= $(DS_DIRECTORY_ID)
DS_TRUST_IDS?= $(DS_TRUST_ID)

# Option parameters
__DS_CONDITIONAL_FORWARDER_IP_ADDRS= $(if $(DS_TRUST_CONDITIONALFORWARDER_IPS), --conditional-forwarder-ip-addrs $(DS_TRUST_CONDITIONALFORWARDER_IPS))
__DS_DIRECTORY_ID__TRUST= $(if $(DS_TRUST_DIRECTORY_ID), --directory-id $(DS_TRUST_DIRECTORY_ID))
__DS_DELETE_ASSOCIATED_CONDITIONAL_FORWARDER= $(if $(filter true, $(DS_TRUST_DELETE_CONDITIONALFORWARDER)), --delete-associated-conditional-forwarder, --no-delete-associated-conditional-forwarder)
__DS_REMOTE_DOMAIN_NAME= $(if $(DS_TRUST_REMOTEDOMAIN_NAME), --remote-domain-name $(DS_TRUST_REMOTEDOMAIN_NAME))
__DS_TRUST_ID= $(if $(DS_TRUST_ID), --id $(DS_TRUST_ID))
__DS_TRUST_PASSWORD= $(if $(DS_TRUST_PASSWORD), --trust-password $(DS_TRUST_PASSWORD))

# UI parameters
DS_UI_VIEW_TRUSTS_FIELDS?=
DS_UI_VIEW_TRUSTS_SET_FIELDS?= $(DS_UI_VIEW_TRUSTS_FIELDS)
DS_UI_VIEW_TRUSTS_SET_SLICE?=

#--- Utilities

#--- MACROS
_ds_get_trust_id= $(call _ds_get_trust_id_N, $(DS_TRUST_NAME))
_ds_get_trust_id_N= $(shell $(AWS) ds describe-trusts ... --output text)

#----------------------------------------------------------------------
# USAGE
#

_ds_view_framework_macros ::
	@echo 'AWS::DirectoryService::Trust ($(_AWS_DS_TRUST_MK_VERSION)) macros:'
	@echo '    _ds_get_trust_id_{|N}          - Get the ID of a directory-trust'
	@echo

_ds_view_framework_parameters ::
	@echo 'AWS::DirectoryService::Trust ($(_AWS_DS_TRUST_MK_VERSION)) parameters:'
	@echo '    DS_TRUST_CONDITIONALFORWARDER_IPS?=$(DS_TRUST_CONDITIONALFORWARDER_IPS)'
	@echo '    DS_TRUST_DELETE_CONDITIONALFORWARDER?=$(DS_TRUST_DELETE_CONDITIONALFORWARDER)'
	@echo '    DS_TRUST_DIRECTION?=$(DS_TRUST_DIRECTION)'
	@echo '    DS_TRUST_DIRECTORY_ID?=$(DS_TRUST_DIRECTORY_ID)'
	@echo '    DS_TRUST_ID?=$(DS_TRUST_ID)'
	@echo '    DS_TRUST_IDS?=$(DS_TRUST_IDS)'
	@echo '    DS_TRUST_NAME?=$(DS_TRUST_NAME)'
	@echo '    DS_TRUST_PASSWORD?=$(DS_TRUST_PASSWORD)'
	@echo '    DS_TRUST_REMOTEDOMAIN_NAME?=$(DS_TRUST_REMOTEDOMAIN_NAME)'
	@echo '    DS_TRUSTS_SET_NAME?=$(DS_TRUSTS_SET_NAME)'
	@echo

_ds_view_framework_targets ::
	@echo 'AWS::DirectoryService::Trust ($(_AWS_DS_TRUST_MK_VERSION)) targets:'
	@echo '    _ds_create_trust               - Create a new trust-relationship'
	@echo '    _ds_delete_trust               - Delete an existing trust-relationship'
	@echo '    _ds_show_trust                 - Show everything related to a trust-relationship'
	@echo '    _ds_view_trusts                - View available trust-relationships'
	@echo '    _ds_view_trusts_set            - View a set of trust-relationships'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ds_create_trust:
	@$(INFO) '$(AWS_UI_LABEL)Creating a new trust-relationship "$(DS_TRUST_NAME)" ...'; $(NORMAL)
	$(AWS) ds create-directory $(__DS_CONDITONAL_FORWARDER_IP_ADDRS) $(__DS_DIRECTORY_ID__TRUST) $(__DS_REMOTE_DOMAIN_NAME) $(__DS_TRUST_DIRECTION) $(__DS_TRUST_PASSWORD) $(__DS_TRUST_TYPE)

_ds_delete_trust:
	@$(INFO) '$(AWS_UI_LABEL)Deleting trust-relationship "$(DS_TRUST_NAME)" ...'; $(NORMAL)
	$(AWS) ds delete-trust $(__DS_DELETE_ASSOCIATED_CONNDITIONAL_FORWARDER) $(__DS_TRUST_ID)

_ds_show_trust:
	@$(INFO) '$(AWS_UI_LABEL)Showing trust-relationship "$(DS_TRUST_NAME)" ...'; $(NORMAL)
	$(AWS) ds describe-trusts $(__DS_TRUST_IDS)

_ds_view_trusts:
	@$(INFO) '$(AWS_UI_LABEL)Viewing trust-relationships ...'; $(NORMAL)
	$(AWS) ds describe-trusts $(_X__DS_DIRECTORY_ID__TRUST) $(_X__DS_TRUST_IDS) --query "Trusts[]$(DS_UI_VIEW_TRUSTS_FIELDS)"

_ds_view_trusts_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing trust-relationships "$(DS_TRUSTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Trust-relationship are grouped based on the provided directory-ID, trust-IDs, and/or slice'; $(NORMAL)
	$(AWS) ds describe-trusts $(__DS_DIRECTORY_ID__TRUST) $(__DS_TRUST_IDS) --query "Trusts[$(DS_UI_VIEW_TRUSTS_SET_SLICE)]$(DS_UI_VIEW_TRUSTS_SET_FIELDS)"
