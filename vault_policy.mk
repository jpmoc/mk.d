_VAULT_POLICY_MK_VERSION= $(_VAULT_MK_VERSION)

# VLT_POLICY_DOCUMENT_DIRPATH?= ./in/
# VLT_POLICY_DOCUMENT_FILENAME?= my-policy.hcl
# VLT_POLICY_DOCUMENT_FILEPATH?= ./in/my-policy.hcl
# VLT_POLICY_NAME?= my-policy
# VLT_POLICY_TOKEN_ID?=
# VLT_POLICYS_SET_NAME?= my-policys-set

# Derived variables
VLT_POLICY_DOCUMENT_DIRPATH?= $(VLT_INPUTS_DIRPATH)
VLT_POLICY_DOCUMENT_FILEPATH?= $(if $(VLT_POLICY_DOCUMENT_FILENAME),$(VLT_POLICY_DOCUMENT_DIRPATH)$(VLT_POLICY_DOCUMENT_FILENAME))
VLT_POLICY_NAME?= $(patsubst %.hcl,%,$(VLT_POLICY_DOCUMENT_FILENAME))

# Options variables
__VLT_POLICY= $(if $(VLT_POLICY_NAME),--policy $(VLT_POLICY_NAME))

# Pipe
|_VLT_SHOW_POLICY_TOKEN?= # | awk '$$1=="token" {print $$2}'

# UI parameters

# Utilities

#--- MACROS
_vlt_get_policy_token_id= $(call _vlt_get_policy_token_id_N, $(VLT_POLICY_NAME))
_vlt_get_policy_token_id_N= $(shell $(VAULT) token create --policy $(1) | awk '$$1=="token" {print $$2}' )

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::Policy ($(_VAULT_POLICY_MK_VERSION)) macros:'
	@echo '    _vlt_get_policy_token_id_{|N}         - Get a token compliant with the policy (Name)'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::Policy ($(_VAULT_POLICY_MK_VERSION)) parameters:'
	@echo '    VLT_POLICY_DOCUMENT_DIRPATH=$(VLT_POLICY_DOCUMENT_DIRPATH)'
	@echo '    VLT_POLICY_DOCUMENT_FILENAME=$(VLT_POLICY_DOCUMENT_FILENAME)'
	@echo '    VLT_POLICY_DOCUMENT_FILEPATH=$(VLT_POLICY_DOCUMENT_FILEPATH)'
	@echo '    VLT_POLICY_NAME=$(VLT_POLICY_NAME)'
	@echo '    VLT_POLICY_TOKEN_ID=$(VLT_POLICY_TOKEN_ID)'
	@echo '    VLT_POLICIES_SET_NAME=$(VLT_POLICIES_SET_NAME)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::Policy ($(_VAULT_POLICY_MK_VERSION)) targets:'
	@echo '    _vlt_create_policy                  - Create a policy'
	@echo '    _vlt_delete_policy                  - Delete a policy'
	@echo '    _vlt_format_policy_document         - Format the document of a policy'
	@echo '    _vlt_show_policy                    - Show everything related to a policy'
	@echo '    _vlt_show_policy_description        - Show description of a policy'
	@echo '    _vlt_show_policy_document           - Show document of a policy'
	@echo '    _vlt_show_policy_description        - Show desription of a policy'
	@echo '    _vlt_update_policy                  - Update policy'
	@echo '    _vlt_view_policies                  - View policies'
	@echo '    _vlt_view_policies_set              - View set of policies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_create_policy:
	@$(INFO) '$(VLT_UI_LABEL)Creating/updating policy "$(VLT_POLICY_NAME)" ...'; $(NORMAL)
	$(VAULT) policy write $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_POLICY_NAME) $(VLT_POLICY_DOCUMENT_FILEPATH)

_vlt_delete_policy:
	@$(INFO) '$(VLT_UI_LABEL)Deleting policy "$(VLT_POLICY_NAME)" ...'; $(NORMAL)
	$(VAULT) policy delete $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_POLICY_NAME)

_vlt_format_policy_document:
	@$(INFO) '$(VLT_UI_LABEL)Formating document of policy "$(VLT_POLICY_NAME)" ...'; $(NORMAL)
	cat $(VLT_POLICY_DOCUMENT_FILEPATH)
	$(VAULT) policy fmt $(VLT_POLICY_DOCUMENT_FILEPATH)

_vlt_show_policy: _vlt_show_policy_document _vlt_show_policy_token _vlt_show_policy_description

_vlt_show_policy_description:
	@$(INFO) '$(VLT_UI_LABEL)Showing policy "$(VLT_POLICY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the active policy, fails if it does NOT exit'; $(NORMAL)
	-$(VAULT) policy read $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_FORMAT) $(VLT_POLICY_NAME)

_vlt_show_policy_document:
	@$(INFO) '$(VLT_UI_LABEL)Showing document for policy "$(VLT_POLICY_NAME)" ...'; $(NORMAL)
	$(if $(VLT_POLICY_DOCUMENT_FILEPATH), cat $(VLT_POLICY_DOCUMENT_FILEPATH))

_vlt_show_policy_token:
	@$(INFO) '$(VLT_UI_LABEL)Showing token compliant with policy "$(VLT_POLICY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a token you can log in with to test the policy'; $(NORMAL)
	$(VAULT) token create $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_POLICY) $(|_VLT_SHOW_POLICY_TOKEN)

_vlt_update_policy: _vlt_create_policy

_vlt_view_policies:
	@$(INFO) '$(VLT_UI_LABEL)Viewing policys ...'; $(NORMAL)
	$(VAULT) policy list $(__VLT_ADDRESS) $(__VLT_CA_CERT)

_vlt_view_policies_set:
	@$(INFO) '$(VLT_UI_LABEL)Viewing policys-set "$(VLT_POLICIES_SET_NAME)" ...'; $(NORMAL)
