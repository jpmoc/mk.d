_AWS_IAM_INLINEGROUPPOLICY_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_INLINEGROUPPOLICIES_GROUP_NAME?= my-group
# IAM_INLINEGROUPPOLICIES_SET_NAME?= inline-group-policies@my-group
# IAM_INLINEGROUPPOLICY_DOCUMENT?= 
# IAM_INLINEGROUPPOLICY_DOCUMENT_DIRPATH?= ./in/
# IAM_INLINEGROUPPOLICY_DOCUMENT_FILENAME?= inline-group-policy-document.json
# IAM_INLINEGROUPPOLICY_DOCUMENT_FILEPATH?= ./in/inline-group-policy-document.json
# IAM_INLINEGROUPGROUPPOLICY_GROUP_NAME?=
# IAM_INLINEGROUPPOLICY_NAME?= my-inline-group-policy
# IAM_INLINEGROUPPOLICY_GROUP_NAME?=

# Derived parameters 
IAM_INLINEGROUPPOLICIES_GROUP_NAME?= $(IAM_INLINEGROUPPOLICY_GROUP_NAME)
IAM_INLINEGROUPPOLICIES_SET_NAME?= inline-group-policies@$(IAM_INLINEGROUPPOLICIES_GROUP_NAME)
IAM_INLINEGROUPPOLICY_DOCUMENT?= $(if $(IAM_INLINEGROUPPOLICY_DOCUMENT_FILEPATH),file://$(IAM_INLINEGROUPPOLICY_DOCUMENT_FILEPATH))
IAM_INLINEGROUPPOLICY_DOCUMENT_DIRPATH?= $(IAM_INPUTS_DIRPATH)
IAM_INLINEGROUPPOLICY_DOCUMENT_FILEPATH?= $(IAM_INLINEGROUPPOLICY_DOCUMENT_DIRPATH)$(IAM_INLINEGROUPPOLICY_DOCUMENT_FILENAME)
IAM_INLINEGROUPPOLICY_GROUP_NAME?= $(IAM_GROUP_NAME)

# Options
__IAM_GROUP_NAME__INLINEGROUPPOLICY= $(if $(IAM_INLINEGROUPPOLICY_GROUP_NAME),--group-name $(IAM_INLINEGROUPPOLICY_GROUP_NAME))
__IAM_GROUP_NAME__INLINEGROUPPOLICIES= $(if $(IAM_INLINEGROUPPOLICIES_GROUP_NAME),--group-name $(IAM_INLINEGROUPPOLICIES_GROUP_NAME))
__IAM_POLICY_DOCUMENT__INLINEGROUPPOLICY= $(if $(IAM_INLINEGROUPPOLICY_DOCUMENT),--policy-document $(IAM_INLINEGROUPPOLICY_DOCUMENT))
__IAM_POLICY_NAME__INLINEGROUPPOLICY= $(if $(IAM_INLINEGROUPPOLICY_NAME),--policy-name $(IAM_INLINEGROUPPOLICY_NAME))

# Customizations
_IAM_GET_INLINEGROUPPOLICIES_NAMES_QUERYFILTER?= $(_IAM_LIST_INLINEGROUPPOLICIES_SET_QUERYFILTER)
_IAM_LIST_INLINEGROUPPOLICIES_FIELDS?=
_IAM_LIST_INLINEGROUPPOLICIES_SET_FIELDS?= $(_IAM_LIST_INLINEGROUPPOLICIES_FIELDS)
_IAM_LIST_INLINEGROUPPOLICIES_SET_QUERYFILTER?=

# Macros
_iam_get_inlinegrouppolicies_names= $(call _iam_get_inlinegrouppolicies_names_G, $(IAM_INLINEGROUPPOLICIES_GROUP_NAME))
_iam_get_inlinegrouppolicies_names_G= $(call _iam_get_inlinegrouppolicies_names_GF, $(1), $(_IAM_GET_INLINEGROUPPOLICIES_NAMES_QUERYFILTER))
_iam_get_inlinegrouppolicies_names_GF= $(shell $(AWS) iam list-group-policies --group-name $(1) --query 'PolicyNames[$(2)]' --output text)

#----------------------------------------------------------------------
# USAGE
#

_iam_list_macros ::
	@echo 'AWS::IAM::InlineGroupPolicy ($(_AWS_IAM_INLINEGROUPPOLICY_MK_VERSION)) macros:'
	@echo '    _iam_get_inlinegrouppolicies_names_{|G|GF}     - Get the names of inline-group-policies (Group,Filter)'
	@echo

_iam_list_parameters ::
	@echo 'AWS::IAM::InlineGroupPolicy ($(_AWS_IAM_INLINEGROUPPOLICY_MK_VERSION)) parameters:'
	@echo '    IAM_INLINEGROUPPOLICIES_GROUP_NAME=$(IAM_INLINEGROUPPOLICIES_GROUP_NAME)'
	@echo '    IAM_INLINEGROUPPOLICIES_NAMES=$(IAM_INLINEGROUPPOLICIES_NAMES)'
	@echo '    IAM_INLINEGROUPPOLICIES_SET_NAME=$(IAM_INLINEGROUPPOLICIES_SET_NAME)'
	@echo '    IAM_INLINEGROUPPOLICY_DOCUMENT=$(IAM_INLINEGROUPPOLICY_DOCUMENT)'
	@echo '    IAM_INLINEGROUPPOLICY_DOCUMENT_DIRPATH=$(IAM_INLINEGROUPPOLICY_DOCUMENT_DIRPATH)'
	@echo '    IAM_INLINEGROUPPOLICY_DOCUMENT_FILENAME=$(IAM_INLINEGROUPPOLICY_DOCUMENT_FILENAME)'
	@echo '    IAM_INLINEGROUPPOLICY_DOCUMENT_FILEPATH=$(IAM_INLINEGROUPPOLICY_DOCUMENT_FILEPATH)'
	@echo '    IAM_INLINEGROUPPOLICY_GROUP_NAME=$(IAM_INLINEGROUPPOLICY_GROUP_NAME)'
	@echo '    IAM_INLINEGROUPPOLICY_NAME=$(IAM_INLINEGROUPPOLICY_NAME)'
	@echo

_iam_list_targets ::
	@echo 'AWS::IAM::InlineGroupPolicy ($(_AWS_IAM_INLINEGROUPPOLICY_MK_VERSION)) targets:'
	@echo '    _iam_create_inlinegrouppolicy                  - Create a new inline-oplicy'
	@echo '    _iam_delete_inlinegrouppolicy                  - Delete an inline-group-policy'
	@echo '    _iam_show_inlinegrouppolicy                    - Show everything related to an inline-group-policy'
	@echo '    _iam_show_inlinegrouppolicy_description        - Show the description of an inline-group-policy'
	@echo '    _iam_show_inlinegrouppolicy_document           - Show the document of an inline-group-policy'
	@echo '    _iam_list_inlinegrouppolicies                  - List all inline-group-policies'
	@echo '    _iam_list_inlinegrouppolicies_set              - List a set of inline-group-policies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

_iam_create_inlinegrouppolicy:
	@$(INFO) '$(IAM_UI_LABEL)Creating inline-group-policy "$(IAM_INLINEGROUPPOLICY_NAME)" ...'; $(NORMAL)
	 $(AWS) iam put-group-policy $(__IAM_GROUP_NAME__INLINEGROUPPOLICY) $(__IAM_POLICY_DOCUMENT__INLINEGROUPPOLICY) $(__IAM_POLICY_NAME__INLINEGROUPPOLICY)

_iam_delete_inlinegrouppolicy:
	@$(INFO) '$(IAM_UI_LABEL)Deleting inline-group-policy "$(IAM_INLINEGROUPPOLICY_NAME)" ...'; $(NORMAL)
	$(AWS) iam delete-group-policy $(__IAM_GROUP_NAME__INLINEGROUPPOLICY) $(__IAM_POLICY_NAME__INLINEGROUPPOLICY)

_iam_list_inlinegrouppolicies:
	@$(INFO) '$(IAM_UI_LABEL)Listing ALL inline-group-policies ...'; $(NORMAL)
	$(AWS) iam list-group-policies $(__IAM_GROUP_NAME__INLINEGROUPPOLICIES) --query "PolicyNames[]"

_iam_list_inlinegrouppolicies_set:
	@$(INFO) '$(IAM_UI_LABEL)Listing inline-group-policies-set "$(IAM_INLINEGROUPPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Inline-group-policies are grouped based on the provided query-filter'; $(NORMAL)
	$(AWS) iam list-group-policies $(__IAM_GROUP_NAME__INLINEGROUPPOLICIES) --query "PolicyNames[$(_IAM_LIST_INLINEGROUPPOLICIES_SET_QUERYFILTER)]"

_IAM_SHOW_INLINEGROUPPOLICY_TARGETS?= _iam_show_inlinegrouppolicy_document _iam_show_inlinegrouppolicy_description
_iam_show_inlinegrouppolicy: $(_IAM_SHOW_INLINEGROUPPOLICY_TARGETS)

_iam_show_inlinegrouppolicy_description:

_iam_show_inlinegrouppolicy_document:
	@$(INFO) '$(IAM_UI_LABEL)Showing document of inline-group-policy "$(IAM_INLINEGROUPPOLICY_NAME)" ...'; $(NORMAL)
	$(AWS) iam get-group-policy $(__IAM_GROUP_NAME__INLINEGROUPPOLICY) $(__IAM_POLICY_NAME__INLINEGROUPPOLICY) --output json
