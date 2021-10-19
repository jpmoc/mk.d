_AWS_IAM_INLINEPOLICY_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_INLINEPOLICIES_GROUP_NAME?=
# IAM_INLINEPOLICIES_ROLE_NAME?=
# IAM_INLINEPOLICIES_SET_NAME?= my-groups-set
# IAM_INLINEPOLICIES_USER_NAME?=
# IAM_INLINEPOLICY_DOCUMENT?= 
# IAM_INLINEPOLICY_DOCUMENT_DIRPATH?= ./in/
# IAM_INLINEPOLICY_DOCUMENT_FILENAME?= group-policy-document.json
# IAM_INLINEPOLICY_DOCUMENT_FILEPATH?= ./in/group-policy-document.json
# IAM_INLINEPOLICY_GROUP_NAME?=
# IAM_INLINEPOLICY_NAME?= my-inline-policy
# IAM_INLINEPOLICY_ROLE_NAME?=
# IAM_INLINEPOLICY_USER_NAME?=

# Derived parameters 
IAM_INLINEPOLICIES_GROUP_NAME?= $(IAM_INLINEPOLICY_GROUP_NAME)
IAM_INLINEPOLICIES_ROLE_NAME?= $(IAM_INLINEPOLICY_ROLE_NAME)
IAM_INLINEPOLICIES_USER_NAME?= $(IAM_INLINEPOLICY_USER_NAME)
IAM_INLINEPOLICY_DOCUMENT?= $(if $(IAM_INLINEPOLICY_DOCUMENT_FILEPATH),file://$(IAM_INLINEPOLICY_DOCUMENT_FILEPATH))
IAM_INLINEPOLICY_DOCUMENT_DIRPATH?= $(IAM_INPUTS_DIRPATH)
IAM_INLINEPOLICY_DOCUMENT_FILEPATH?= $(IAM_INLINEPOLICY_DOCUMENT_DIRPATH)$(IAM_INLINEPOLICY_DOCUMENT_FILENAME)
IAM_INLINEPOLICY_GROUP_NAME?= $(IAM_GROUP_NAME)
IAM_INLINEPOLICY_ROLE_NAME?= $(IAM_ROLE_NAME)
IAM_INLINEPOLICY_USER_NAME?= $(IAM_USER_NAME)

# Option parameters
__IAM_GROUP_NAME__INLINEPOLICY= $(if $(IAM_INLINEPOLICY_GROUP_NAME),--group-name $(IAM_INLINEPOLICY_GROUP_NAME))
__IAM_GROUP_NAME__INLINEPOLICIES= $(if $(IAM_INLINEPOLICIES_GROUP_NAME),--group-name $(IAM_INLINEPOLICIES_GROUP_NAME))
__IAM_POLICY_DOCUMENT__INLINEPOLICY= $(if $(IAM_INLINEPOLICY_DOCUMENT),--policy-document $(IAM_INLINEPOLICY_DOCUMENT))
__IAM_POLICY_NAME__INLINEPOLICY= $(if $(IAM_INLINEPOLICY_NAME),--policy-name $(IAM_INLINEPOLICY_NAME))
__IAM_ROLE_NAME__INLINEPOLICY= $(if $(IAM_INLINEPOLICY_ROLE_NAME),--role-name $(IAM_INLINEPOLICY_ROLE_NAME))
__IAM_ROLE_NAME__INLINEPOLICIES= $(if $(IAM_INLINEPOLICIES_ROLE_NAME),--role-name $(IAM_INLINEPOLICIES_ROLE_NAME))
__IAM_USER_NAME__INLINEPOLICY= $(if $(IAM_INLINEPOLICY_USER_NAME),--user-name $(IAM_INLINEPOLICY_USER_NAME))
__IAM_USER_NAME__INLINEPOLICIES= $(if $(IAM_INLINEPOLICIES_USER_NAME),--user-name $(IAM_INLINEPOLICIES_USER_NAME))

# UI parameters 
IAM_UI_VIEW_INLINEPOLICIES_FIELDS?=
IAM_UI_VIEW_INLINEPOLICIES_SET_FIELDS?= $(IAM_UI_VIEW_INLINEPOLICIES_FIELDS)
IAM_UI_VIEW_INLINEPOLICIES_SET_QUERYFILTER?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_iam_view_framework_macros ::
	@echo 'AWS::IAM::InlinePolicy ($(_AWS_IAM_INLINEPOLICY_MK_VERSION)) macros:'
	@echo

_iam_view_framework_parameters ::
	@echo 'AWS::IAM::InlinePolicy ($(_AWS_IAM_INLINEPOLICY_MK_VERSION)) parameters:'
	@echo '    IAM_INLINEPOLICIES_GROUP_NAME=$(IAM_INLINEPOLICIES_GROUP_NAME)'
	@echo '    IAM_INLINEPOLICIES_ROLE_NAME=$(IAM_INLINEPOLICIES_ROLE_NAME)'
	@echo '    IAM_INLINEPOLICIES_SET_NAME=$(IAM_INLINEPOLICIES_SET_NAME)'
	@echo '    IAM_INLINEPOLICIES_USER_NAME=$(IAM_INLINEPOLICIES_USER_NAME)'
	@echo '    IAM_INLINEPOLICY_DOCUMENT=$(IAM_INLINEPOLICY_DOCUMENT)'
	@echo '    IAM_INLINEPOLICY_DOCUMENT_DIRPATH=$(IAM_INLINEPOLICY_DOCUMENT_DIRPATH)'
	@echo '    IAM_INLINEPOLICY_DOCUMENT_FILENAME=$(IAM_INLINEPOLICY_DOCUMENT_FILENAME)'
	@echo '    IAM_INLINEPOLICY_DOCUMENT_FILEPATH=$(IAM_INLINEPOLICY_DOCUMENT_FILEPATH)'
	@echo '    IAM_INLINEPOLICY_GROUP_NAME=$(IAM_INLINEPOLICY_GROUP_NAME)'
	@echo '    IAM_INLINEPOLICY_NAME=$(IAM_INLINEPOLICY_NAME)'
	@echo '    IAM_INLINEPOLICY_ROLE_NAME=$(IAM_INLINEPOLICY_ROLE_NAME)'
	@echo '    IAM_INLINEPOLICY_USER_NAME=$(IAM_INLINEPOLICY_USER_NAME)'
	@echo

_iam_view_framework_targets ::
	@echo 'AWS::IAM::InlinePolicy ($(_AWS_IAM_INLINEPOLICY_MK_VERSION)) targets:'
	@echo '    _iam_create_inlinepolicy                  - Create a new inline-oplicy'
	@echo '    _iam_delete_inlinepolicy                  - Delete an inline-policy'
	@echo '    _iam_show_inlinepolicy                    - Show everything related to an inline-policy'
	@echo '    _iam_show_inlinepolicy_description        - Show the description of an inline-policy'
	@echo '    _iam_show_inlinepolicy_document           - Show the document of an inline-policy'
	@echo '    _iam_view_inlinepolicies                  - View inline-policies'
	@echo '    _iam_view_inlinepolicies_set              - View a set of inline-policies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

_iam_create_inlinepolicy:
	@$(INFO) '$(IAM_UI_LABEL)Creating inline-policy "$(IAM_INLINEPOLICY_NAME)" ...'; $(NORMAL)
	$(if $(IAM_INLINEPOLICY_GROUP_NAME), $(AWS) iam put-group-policy $(__IAM_GROUP_NAME__INLINEPOLICY) $(__IAM_POLICY_DOCUMENT__INLINEPOLICY) $(__IAM_POLICY_NAME__INLINEPOLICY))
	$(if $(IAM_INLINEPOLICY_ROLE_NAME), $(AWS) iam put-role-policy $(__IAM_POLICY_DOCUMENT__INLINEPOLICY) $(__IAM_POLICY_NAME__INLINEPOLICY) $(__IAM_ROLE_NAME__INLINEPOLICY))
	$(if $(IAM_INLINEPOLICY_USER_NAME), $(AWS) iam put-user-policy $(__IAM_POLICY_DOCUMENT__INLINEPOLICY) $(__IAM_POLICY_NAME__INLINEPOLICY) $(__IAM_USER_NAME__INLINEPOLICY))

_iam_delete_inlinepolicy:
	@$(INFO) '$(IAM_UI_LABEL)Deleting inline-policy "$(IAM_INLINEPOLICY_NAME)" ...'; $(NORMAL)
	-$(if $(IAM_INLINEPOLICY_GROUP_NAME),$(AWS) iam delete-group-policy $(__IAM_GROUP_NAME__INLINEPOLICY) $(__IAM_POLICY_NAME__INLINEPOLICY))
	-$(if $(IAM_INLINEPOLICY_ROLE_NAME),$(AWS) iam delete-role-policy $(__IAM_POLICY_NAME__INLINEPOLICY) $(__IAM_ROLE_NAME__INLINEPOLICY))
	-$(if $(IAM_INLINEPOLICY_USER_NAME),$(AWS) iam delete-user-policy $(__IAM_POLICY_NAME__INLINEPOLICY) $(__IAM_USER_NAME__INLINEPOLICY))

_iam_show_inlinepolicy: _iam_show_inlinepolicy_document _iam_show_inlinepolicy_description

_iam_show_inlinepolicy_description:

_iam_show_inlinepolicy_document:
	@$(INFO) '$(IAM_UI_LABEL)Showing document of inline-policy "$(IAM_INLINEPOLICY_NAME)" ...'; $(NORMAL)
	$(if $(IAM_INLINEPOLICY_GROUP_NAME),$(AWS) iam get-group-policy $(__IAM_GROUP_NAME__INLINEPOLICY) $(__IAM_POLICY_NAME__INLINEPOLICY) --output json)
	$(if $(IAM_INLINEPOLICY_ROLE_NAME),$(AWS) iam get-role-policy $(__IAM_POLICY_NAME__INLINEPOLICY) $(__IAM_ROLE_NAME__INLINEPOLICY) --output json)
	$(if $(IAM_INLINEPOLICY_USER_NAME),$(AWS) iam get-user-policy $(__IAM_POLICY_NAME__INLINEPOLICY) $(__IAM_USER_NAME__INLINEPOLICY) --output json)

_iam_view_inlinepolicies:
	@$(INFO) '$(IAM_UI_LABEL)Viewing inline-policies ...'; $(NORMAL)
	$(if $(IAM_INLINEPOLICIES_GROUP_NAME),$(AWS) iam list-group-policies $(__IAM_GROUP_NAME__INLINEPOLICIES) --query 'PolicyNames[]')
	$(if $(IAM_INLINEPOLICIES_ROLE_NAME),$(AWS) iam list-role-policies $(__IAM_ROLE_NAME__INLINEPOLICIES) --query 'PolicyNames[]')
	$(if $(IAM_INLINEPOLICIES_USER_NAME),$(AWS) iam list-user-policies $(__IAM_USER_NAME__INLINEPOLICIES) --query 'PolicyNames[]')

_iam_view_inlinepolicies_set:
	@$(INFO) '$(IAM_UI_LABEL)Viewing inline-policies-set "$(IAM_INLINEPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Inline-policies are grouped based on the query-filter'; $(NORMAL)
	$(if $(IAM_INLINEPOLICIES_GROUP_NAME),$(AWS) iam list-group-policies $(__IAM_GROUP_NAME__INLINEPOLICIES) --query 'PolicyNames[$(IAM_UI_VIEW_INLINEPOLICIES_SET_QUERYFILTER)]')
	$(if $(IAM_INLINEPOLICIES_ROLE_NAME),$(AWS) iam list-role-policies $(__IAM_ROLE_NAME__INLINEPOLICIES) --query 'PolicyNames[$(IAM_UI_VIEW_INLINEPOLICIES_SET_QUERYFILTER)]')
	$(if $(IAM_INLINEPOLICIES_USER_NAME),$(AWS) iam list-user-policies $(__IAM_USER_NAME__INLINEPOLICIES) --query 'PolicyNames[$(IAM_UI_VIEW_INLINEPOLICIES_SET_QUERYFILTER)]')
