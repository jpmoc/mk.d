_AWS_IAM_INLINEROLEPOLICY_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_INLINEROLEPOLICIES_NAMES?= my-inline-role-policy ...
# IAM_INLINEROLEPOLICIES_ROLE_NAME?=
# IAM_INLINEROLEPOLICIES_SET_NAME?= my-groups-set
# IAM_INLINEROLEPOLICY_DOCUMENT?= 
# IAM_INLINEROLEPOLICY_DOCUMENT_DIRPATH?= ./in/
# IAM_INLINEROLEPOLICY_DOCUMENT_FILENAME?= inline-role-policy-document.json
# IAM_INLINEROLEPOLICY_DOCUMENT_FILEPATH?= ./in/inline-role-policy-document.json
# IAM_INLINEROLEPOLICY_NAME?= my-inline-role-policy
# IAM_INLINEROLEPOLICY_ROLE_NAME?=

# Derived parameters 
IAM_INLINEROLEPOLICIES_ROLE_NAME?= $(IAM_INLINEROLEPOLICY_ROLE_NAME)
IAM_INLINEROLEPOLICY_DOCUMENT?= $(if $(IAM_INLINEROLEPOLICY_DOCUMENT_FILEPATH),file://$(IAM_INLINEROLEPOLICY_DOCUMENT_FILEPATH))
IAM_INLINEROLEPOLICY_DOCUMENT_DIRPATH?= $(IAM_INPUTS_DIRPATH)
IAM_INLINEROLEPOLICY_DOCUMENT_FILEPATH?= $(IAM_INLINEROLEPOLICY_DOCUMENT_DIRPATH)$(IAM_INLINEROLEPOLICY_DOCUMENT_FILENAME)
IAM_INLINEROLEPOLICY_ROLE_NAME?= $(IAM_ROLE_NAME)

# Options
__IAM_POLICY_DOCUMENT__INLINEROLEPOLICY= $(if $(IAM_INLINEROLEPOLICY_DOCUMENT),--policy-document $(IAM_INLINEROLEPOLICY_DOCUMENT))
__IAM_POLICY_NAME__INLINEROLEPOLICY= $(if $(IAM_INLINEROLEPOLICY_NAME),--policy-name $(IAM_INLINEROLEPOLICY_NAME))
__IAM_ROLE_NAME__INLINEROLEPOLICY= $(if $(IAM_INLINEROLEPOLICY_ROLE_NAME),--role-name $(IAM_INLINEROLEPOLICY_ROLE_NAME))
__IAM_ROLE_NAME__INLINEROLEPOLICIES= $(if $(IAM_INLINEROLEPOLICIES_ROLE_NAME),--role-name $(IAM_INLINEROLEPOLICIES_ROLE_NAME))

# Customizations
_IAM_GET_INLINEROLEPOLICIES_NAMES_QUERYFILTER?= $(_IAM_LIST_INLINEROLEPOLICIES_SET_QUERYFILTER)
_IAM_LIST_INLINEROLEPOLICIES_FIELDS?=
_IAM_LIST_INLINEROLEPOLICIES_SET_FIELDS?= $(_IAM_LIST_INLINEROLEPOLICIES_FIELDS)
_IAM_LIST_INLINEROLEPOLICIES_SET_QUERYFILTER?=

# Macros
_iam_get_inlinerolepolicies_names= $(call _iam_get_inlinerolepolicies_names_R, $(IAM_INLINEROLEPOLICIES_ROLE_NAME))
_iam_get_inlinerolepolicies_names_R= $(call _iam_get_inlinerolepolicies_names_RF, $(1), $(_IAM_GET_INLINEROLEPOLICIES_NAMES))
_iam_get_inlinerolepolicies_names_RF= $(shell $(AWS) iam list-role-policies --role-name $(1) --query 'PolicyNames[$(_IAM_GET_INLINEROLEPOLICIES_NAMES_QUERYFILTER)].Name')

#----------------------------------------------------------------------
# USAGE
#

_iam_list_macros ::
	@echo 'AWS::IAM::InlineRolePolicy ($(_AWS_IAM_INLINEROLEPOLICY_MK_VERSION)) macros:'
	@echo '    _iam_get_inlinerolepolicies_names_{|R|RF}     - Get the names of inline-role-policies (Role,Filter)'
	@echo

_iam_list_parameters ::
	@echo 'AWS::IAM::InlineRolePolicy ($(_AWS_IAM_INLINEROLEPOLICY_MK_VERSION)) parameters:'
	@echo '    IAM_INLINEROLEPOLICIES_NAMES=$(IAM_INLINEROLEPOLICIES_NAMES)'
	@echo '    IAM_INLINEROLEPOLICIES_ROLE_NAME=$(IAM_INLINEROLEPOLICIES_ROLE_NAME)'
	@echo '    IAM_INLINEROLEPOLICIES_SET_NAME=$(IAM_INLINEROLEPOLICIES_SET_NAME)'
	@echo '    IAM_INLINEROLEPOLICY_DOCUMENT=$(IAM_INLINEROLEPOLICY_DOCUMENT)'
	@echo '    IAM_INLINEROLEPOLICY_DOCUMENT_DIRPATH=$(IAM_INLINEROLEPOLICY_DOCUMENT_DIRPATH)'
	@echo '    IAM_INLINEROLEPOLICY_DOCUMENT_FILENAME=$(IAM_INLINEROLEPOLICY_DOCUMENT_FILENAME)'
	@echo '    IAM_INLINEROLEPOLICY_DOCUMENT_FILEPATH=$(IAM_INLINEROLEPOLICY_DOCUMENT_FILEPATH)'
	@echo '    IAM_INLINEROLEPOLICY_NAME=$(IAM_INLINEROLEPOLICY_NAME)'
	@echo '    IAM_INLINEROLEPOLICY_ROLE_NAME=$(IAM_INLINEROLEPOLICY_ROLE_NAME)'
	@echo

_iam_list_targets ::
	@echo 'AWS::IAM::InlineRolePolicy ($(_AWS_IAM_INLINEROLEPOLICY_MK_VERSION)) targets:'
	@echo '    _iam_create_inlinerolepolicy                  - Create a new inline-oplicy'
	@echo '    _iam_delete_inlinerolepolicy                  - Delete an inline-role-policy'
	@echo '    _iam_show_inlinerolepolicy                    - Show everything related to an inline-role-policy'
	@echo '    _iam_show_inlinerolepolicy_description        - Show the description of an inline-role-policy'
	@echo '    _iam_show_inlinerolepolicy_document           - Show the document of an inline-role-policy'
	@echo '    _iam_list_inlinerolepolicies                  - List all inline-role-policies'
	@echo '    _iam_list_inlinerolepolicies_set              - List a set of inline-role-policies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

_iam_create_inlinerolepolicy:
	@$(INFO) '$(IAM_UI_LABEL)Creating inline-role-policy "$(IAM_INLINEROLEPOLICY_NAME)" ...'; $(NORMAL)
	$(AWS) iam put-role-policy $(__IAM_POLICY_DOCUMENT__INLINEROLEPOLICY) $(__IAM_POLICY_NAME__INLINEROLEPOLICY) $(__IAM_ROLE_NAME__INLINEROLEPOLICY)

_iam_delete_inlinerolepolicy:
	@$(INFO) '$(IAM_UI_LABEL)Deleting inline-role-policy "$(IAM_INLINEROLEPOLICY_NAME)" ...'; $(NORMAL)
	$(AWS) iam delete-role-policy $(__IAM_POLICY_NAME__INLINEROLEPOLICY) $(__IAM_ROLE_NAME__INLINEROLEPOLICY)

_iam_list_inlinerolepolicies:
	@$(INFO) '$(IAM_UI_LABEL)Listing ALL inline-role-policies ...'; $(NORMAL)
	$(AWS) iam list-role-policies $(__IAM_ROLE_NAME__INLINEROLEPOLICIES) --query 'PolicyNames[]'

_iam_list_inlinerolepolicies_set:
	@$(INFO) '$(IAM_UI_LABEL)Listing inline-role-policies-set "$(IAM_INLINEROLEPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Inline-role-policies are grouped based on the provided query-filter'; $(NORMAL)
	$(AWS) iam list-role-policies $(__IAM_ROLE_NAME__INLINEROLEPOLICIES) --query 'PolicyNames[$(_IAM_LIST_INLINEROLEPOLICIES_SET_QUERYFILTER)]'

_IAM_SHOW_INLINEROLEPOLICY_TARGETS?= _iam_show_inlinerolepolicy_document _iam_show_inlinerolepolicy_description
_iam_show_inlinerolepolicy: $(_IAM_SHOW_INLINEROLEPOLICY_TARGETS)

_iam_show_inlinerolepolicy_description:

_iam_show_inlinerolepolicy_document:
	@$(INFO) '$(IAM_UI_LABEL)Showing document of inline-role-policy "$(IAM_INLINEROLEPOLICY_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-role-policy $(__IAM_POLICY_NAME__INLINEROLEPOLICY) $(__IAM_ROLE_NAME__INLINEROLEPOLICY) --output json
