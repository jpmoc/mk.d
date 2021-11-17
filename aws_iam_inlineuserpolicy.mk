_AWS_IAM_INLINEUSERPOLICY_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_INLINEUSERPOLICIES_NAMES?= my-inline-user-policy ...
# IAM_INLINEUSERPOLICIES_SET_NAME?= inline-user-policies@my-user
# IAM_INLINEUSERPOLICIES_USER_NAME?= my-user
# IAM_INLINEUSERPOLICY_DOCUMENT?= file://./in/inline-user-policy-document.json 
# IAM_INLINEUSERPOLICY_DOCUMENT_DIRPATH?= ./in/
# IAM_INLINEUSERPOLICY_DOCUMENT_FILENAME?= inline-user-policy-document.json
# IAM_INLINEUSERPOLICY_DOCUMENT_FILEPATH?= ./in/inline-user-policy-document.json
# IAM_INLINEUSERPOLICY_NAME?= my-inline-user-policy
# IAM_INLINEUSERPOLICY_USER_NAME?=

# Derived parameters 
IAM_INLINEUSERPOLICIES_USER_NAME?= $(IAM_INLINEUSERPOLICY_USER_NAME)
IAM_INLINEUSERPOLICIES_SET_NAME?= inline-user-policies@$(IAM_INLINEUSERPOLICIES_USER_NAME)
IAM_INLINEUSERPOLICY_DOCUMENT?= $(if $(IAM_INLINEUSERPOLICY_DOCUMENT_FILEPATH),file://$(IAM_INLINEUSERPOLICY_DOCUMENT_FILEPATH))
IAM_INLINEUSERPOLICY_DOCUMENT_DIRPATH?= $(IAM_INPUTS_DIRPATH)
IAM_INLINEUSERPOLICY_DOCUMENT_FILEPATH?= $(IAM_INLINEUSERPOLICY_DOCUMENT_DIRPATH)$(IAM_INLINEUSERPOLICY_DOCUMENT_FILENAME)
IAM_INLINEUSERPOLICY_USER_NAME?= $(IAM_USER_NAME)

# Options
__IAM_POLICY_DOCUMENT__INLINEUSERPOLICY= $(if $(IAM_INLINEUSERPOLICY_DOCUMENT),--policy-document $(IAM_INLINEUSERPOLICY_DOCUMENT))
__IAM_POLICY_NAME__INLINEUSERPOLICY= $(if $(IAM_INLINEUSERPOLICY_NAME),--policy-name $(IAM_INLINEUSERPOLICY_NAME))
__IAM_USER_NAME__INLINEUSERPOLICY= $(if $(IAM_INLINEUSERPOLICY_USER_NAME),--user-name $(IAM_INLINEUSERPOLICY_USER_NAME))
__IAM_USER_NAME__INLINEUSERPOLICIES= $(if $(IAM_INLINEUSERPOLICIES_USER_NAME),--user-name $(IAM_INLINEUSERPOLICIES_USER_NAME))

# Customizations
_IAM_GET_INLINEUSERPOLICIES_NAMES_QUERYFILTER?= $(_IAM_LIST_INLINEUSERPOLICIES_SET_QUERYFILTER)
_IAM_LIST_INLINEUSERPOLICIES_FIELDS?=
_IAM_LIST_INLINEUSERPOLICIES_SET_FIELDS?= $(_IAM_LIST_INLINEUSERPOLICIES_FIELDS)
_IAM_LIST_INLINEUSERPOLICIES_SET_QUERYFILTER?=

# Macros
_iam_get_inlineuserpolicies_names= $(call _iam_get_inlineuserpolicies_names_U, $(IAM_INLINEUSERPOLICIES_USER_NAME))
_iam_get_inlineuserpolicies_names_U= $(call _iam_get_inlineuserpolicies_names_UF, $(1), $(_IAM_GET_INLINEUSERPOLICIES_NAMES))
_iam_get_inlineuserpolicies_names_UF= $(shell $(AWS) ... )

#----------------------------------------------------------------------
# USAGE
#

_iam_list_macros ::
	@echo 'AWS::IAM::InlineUserPolicy ($(_AWS_IAM_INLINEUSERPOLICY_MK_VERSION)) macros:'
	@echo '    _iam_get_inlineuserpolicies_names_{|U|UF}       - Get the names of inline-user-policies (User,Filter)'
	@echo

_iam_list_parameters ::
	@echo 'AWS::IAM::InlineUserPolicy ($(_AWS_IAM_INLINEUSERPOLICY_MK_VERSION)) parameters:'
	@echo '    IAM_INLINEUSERPOLICIES_NAMES=$(IAM_INLINEUSERPOLICIES_NAMES)'
	@echo '    IAM_INLINEUSERPOLICIES_SET_NAME=$(IAM_INLINEUSERPOLICIES_SET_NAME)'
	@echo '    IAM_INLINEUSERPOLICIES_USER_NAME=$(IAM_INLINEUSERPOLICIES_USER_NAME)'
	@echo '    IAM_INLINEUSERPOLICY_DOCUMENT=$(IAM_INLINEUSERPOLICY_DOCUMENT)'
	@echo '    IAM_INLINEUSERPOLICY_DOCUMENT_DIRPATH=$(IAM_INLINEUSERPOLICY_DOCUMENT_DIRPATH)'
	@echo '    IAM_INLINEUSERPOLICY_DOCUMENT_FILENAME=$(IAM_INLINEUSERPOLICY_DOCUMENT_FILENAME)'
	@echo '    IAM_INLINEUSERPOLICY_DOCUMENT_FILEPATH=$(IAM_INLINEUSERPOLICY_DOCUMENT_FILEPATH)'
	@echo '    IAM_INLINEUSERPOLICY_NAME=$(IAM_INLINEUSERPOLICY_NAME)'
	@echo '    IAM_INLINEUSERPOLICY_USER_NAME=$(IAM_INLINEUSERPOLICY_USER_NAME)'
	@echo

_iam_list_targets ::
	@echo 'AWS::IAM::InlineUserPolicy ($(_AWS_IAM_INLINEUSERPOLICY_MK_VERSION)) targets:'
	@echo '    _iam_create_inlineuserpolicy                  - Create a new inline-oplicy'
	@echo '    _iam_delete_inlineuserpolicy                  - Delete an inline-user-policy'
	@echo '    _iam_show_inlineuserpolicy                    - Show everything related to an inline-user-policy'
	@echo '    _iam_show_inlineuserpolicy_description        - Show the description of an inline-user-policy'
	@echo '    _iam_show_inlineuserpolicy_document           - Show the document of an inline-user-policy'
	@echo '    _iam_list_inlineuserpolicies                  - List all inline-user-policies'
	@echo '    _iam_list_inlineuserpolicies_set              - List a set of inline-user-policies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

_iam_create_inlineuserpolicy:
	@$(INFO) '$(IAM_UI_LABEL)Creating inline-user-policy "$(IAM_INLINEUSERPOLICY_NAME)" ...'; $(NORMAL)
	$(AWS) iam put-user-policy $(__IAM_POLICY_DOCUMENT__INLINEUSERPOLICY) $(__IAM_POLICY_NAME__INLINEUSERPOLICY) $(__IAM_USER_NAME__INLINEUSERPOLICY)

_iam_delete_inlineuserpolicy:
	@$(INFO) '$(IAM_UI_LABEL)Deleting inline-user-policy "$(IAM_INLINEUSERPOLICY_NAME)" ...'; $(NORMAL)
	$(AWS) iam delete-user-policy $(__IAM_POLICY_NAME__INLINEUSERPOLICY) $(__IAM_USER_NAME__INLINEUSERPOLICY)

_iam_list_inlineuserpolicies:
	@$(INFO) '$(IAM_UI_LABEL)Listing ALL inline-user-policies ...'; $(NORMAL)
	$(AWS) iam list-user-policies $(__IAM_USER_NAME__INLINEUSERPOLICIES) --query "PolicyNames[]"

_iam_list_inlineuserpolicies_set:
	@$(INFO) '$(IAM_UI_LABEL)Listing inline-user-policies-set "$(IAM_INLINEUSERPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Inline-user-policies are grouped based on the provided query-filter'; $(NORMAL)
	$(AWS) iam list-user-policies $(__IAM_USER_NAME__INLINEUSERPOLICIES) --query "PolicyNames[$(_IAM_LIST_INLINEUSERPOLICIES_SET_QUERYFILTER)]"

_IAM_SHOW_INLINEUSERPOLICY_TARGETS?= _iam_show_inlineuserpolicy_document _iam_show_inlineuserpolicy_description
_iam_show_inlineuserpolicy: $(_IAM_SHOW_INLINEUSERPOLICY_TARGETS)

_iam_show_inlineuserpolicy_description:

_iam_show_inlineuserpolicy_document:
	@$(INFO) '$(IAM_UI_LABEL)Showing document of inline-user-policy "$(IAM_INLINEUSERPOLICY_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-user-policy $(__IAM_POLICY_NAME__INLINEUSERPOLICY) $(__IAM_USER_NAME__INLINEUSERPOLICY) --output json
