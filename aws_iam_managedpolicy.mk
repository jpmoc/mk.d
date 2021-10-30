_AWS_IAM_MANAGEDPOLICY_MK_VERSION= $(_AWS_IAM_MK_VERSION)

# IAM_MANAGEDPOLICY_AWSACCOUNT_ID?= 123456789012
# IAM_MANAGEDPOLICY_ACCOUNT_ID?=
# IAM_MANAGEDPOLICY_ARN?=
# IAM_MANAGEDPOLICY_CURRENT_VERSION_ID?= v3
# IAM_MANAGEDPOLICY_DOCUMENT?=
# IAM_MANAGEDPOLICY_DOCUMENT_DIRPATH?= ./in/
# IAM_MANAGEDPOLICY_DOCUMENT_FILENAME?= MyPolicyDocument.json
# IAM_MANAGEDPOLICY_DOCUMENT_FILEPATH?= ./in/MyPolicyDocument.json
# IAM_MANAGEDPOLICY_DOCUMENT_VERSION?= v1
# IAM_MANAGEDPOLICY_GROUP_NAME?=
# IAM_MANAGEDPOLICY_NAME?=
IAM_MANAGEDPOLICY_PATH?= /
# IAM_MANAGEDPOLICY_REGION_ID?= us-weset-2
# IAM_MANAGEDPOLICY_ROLE_NAME?= my-role
# IAM_MANAGEDPOLICY_USER_NAME?=
# IAM_MANAGEDPOLICIES_GROUP_NAME?=
IAM_MANAGEDPOLICIES_ONLY_ATTACHED?= false
# IAM_MANAGEDPOLICIES_PATH_PREFIX?= /
# IAM_MANAGEDPOLICIES_ROLE_NAME?=
IAM_MANAGEDPOLICIES_SCOPE?= All
# IAM_MANAGEDPOLICIES_USER_NAME?=
# IAM_MANAGEDPOLICIES_SET_NAME?= my-policy-set

# Derived parameters
IAM_MANAGEDPOLICY_AWSACCOUNT_ID?= $(IAM_AWSACCOUNT_ID)
IAM_MANAGEDPOLICIES_GROUP_NAME?= $(IAM_MANAGEDPOLICY_GROUP_NAME)
IAM_MANAGEDPOLICIES_PATH_PREFIX?= $(IAM_MANAGEDPOLICY_PATH)
IAM_MANAGEDPOLICIES_ROLE_NAME?= $(IAM_MANAGEDPOLICY_ROLE_NAME)
IAM_MANAGEDPOLICIES_SET_NAME?= $(subst /,,$(IAM_MANAGEDPOLICIES_PATH_PREFIX))
IAM_MANAGEDPOLICIES_USER_NAME?= $(IAM_MANAGEDPOLICY_USER_NAME)
IAM_MANAGEDPOLICY_ACCOUNT_ID?= $(IAM_ACCOUNT_ID)
IAM_MANAGEDPOLICY_ARN?= $(if $(IAM_MANAGEDPOLICY_NAME),arn:aws:iam::$(IAM_MANAGEDPOLICY_ACCOUNT_ID):policy$(IAM_MANAGEDPOLICY_PATH)$(IAM_MANAGEDPOLICY_NAME))
IAM_MANAGEDPOLICY_DOCUMENT?= $(if $(IAM_MANAGEDPOLICY_DOCUMENT_FILEPATH),file://$(IAM_MANAGEDPOLICY_DOCUMENT_FILEPATH))
IAM_MANAGEDPOLICY_DOCUMENT_DIRPATH?= $(IAM_INPUTS_DIRPATH)
IAM_MANAGEDPOLICY_DOCUMENT_FILEPATH?= $(IAM_MANAGEDPOLICY_DOCUMENT_DIRPATH)$(IAM_MANAGEDPOLICY_DOCUMENT_FILENAME)
IAM_MANAGEDPOLICY_GROUP_NAME?= $(IAM_GROUP_NAME)
IAM_MANAGEDPOLICY_REGION_ID?= $(IAM_REGION_ID)
IAM_MANAGEDPOLICY_ROLE_NAME?= $(IAM_ROLE_NAME)
IAM_MANAGEDPOLICY_USER_NAME?= $(IAM_USER_NAME)

# Options parameters
__IAM_DESCRIPTION__MANAGEDPOLICY= $(if $(IAM_MANAGEDPOLICY_DESCRIPTION),--description $(IAM_MANAGEDPOLICY_DESCRIPTION))
__IAM_GROUP_NAME__MANAGEDPOLICY?= $(if $(IAM_MANAGEDPOLICY_GROUP_NAME),--group-name $(IAM_MANAGEDPOLICY_GROUP_NAME))
__IAM_ONLY_ATTACHED= $(if $(filter true, $(IAM_MANAGEDPOLICIES_ONLY_ATTACHED)),--only-attached, --no-only-attached)
__IAM_PATH_PREFIX__MANAGEDPOLICIES= $(if $(IAM_MANAGEDPOLICIES_PATH_PREFIX),--path-prefix $(IAM_MANAGEDPOLICIES_PATH_PREFIX))
__IAM_PATH__MANAGEDPOLICY= $(if $(IAM_MANAGEDPOLICY_PATH),--path $(IAM_MANAGEDPOLICY_PATH))
__IAM_POLICY_ARN?= $(if $(IAM_MANAGEDPOLICY_ARN),--policy-arn $(IAM_MANAGEDPOLICY_ARN))
__IAM_POLICY_DOCUMENT__MANAGEDPOLICY?= $(if $(IAM_MANAGEDPOLICY_DOCUMENT),--policy-document $(IAM_MANAGEDPOLICY_DOCUMENT))
__IAM_POLICY_INPUT_LIST?= $(if $(IAM_MANAGEDPOLICY_DOCUMENT),--policy-input-list $(IAM_POLICY_DOCUMENT))
__IAM_POLICY_NAME?= $(if $(IAM_MANAGEDPOLICY_NAME),--policy-name $(IAM_MANAGEDPOLICY_NAME))
__IAM_ROLE_NAME__MANAGEDPOLICY?= $(if $(IAM_MANAGEDPOLICY_ROLE_NAME),--role-name $(IAM_MANAGEDPOLICY_ROLE_NAME))
__IAM_SET_AS_DEFAULT?=
__IAM_SCOPE?= $(if $(IAM_MANAGEDPOLICIES_SCOPE),--scope $(IAM_MANAGEDPOLICIES_SCOPE))
__IAM_USER_NAME__MANAGEDPOLICY?= $(if $(IAM_MANAGEDPOLICY_USER_NAME),--user-name $(IAM_MANAGEDPOLICY_USER_NAME))
__IAM_VERSION_ID?= $(if $(IAM_MANAGEDPOLICY_DOCUMENT_VERSION),--version-id $(IAM_MANAGEDPOLICY_DOCUMENT_VERSION))

# UI parameters
IAM_UI_VIEW_MANAGEDPOLICIES_AWS_FIELDS?= $(IAM_UI_VIEW_MANAGEDPOLICIES_FIELDS)
IAM_UI_VIEW_MANAGEDPOLICIES_AWS_QUERY_FILTER?=
IAM_UI_VIEW_MANAGEDPOLICIES_FIELDS?= .{PolicyId:PolicyId,PolicyName:PolicyName,versionId:DefaultVersionId,path:Path}
IAM_UI_VIEW_MANAGEDPOLICIES_SET_FIELDS?= $(IAM_UI_VIEW_MANAGEDPOLICIES_FIELDS)
IAM_UI_VIEW_MANAGEDPOLICIES_SET_QUERYFILTER?=

_IAM_SHOW_MANAGEDPOLICY_DESCRIPTION_|?= #
_IAM_SHOW_MANAGEDPOLICY_DOCUMENT_|?= #

#--- MACROS
_iam_get_managedpolicy_arn= $(call _iam_get_managedpolicy_arn_N, $(IAM_MANAGEDPOLICY_NAME))
# _iam_get_managedpolicy_arn_N= $(shell $(AWS) iam list-policies --query "Policies[?PolicyName=='$(strip $(1))'].Arn" --output text)
# _iam_get_managedpolicy_arn_N= $(call _iam_get_managedpolicy_arn_NP, $(1), $(IAM_MANAGEDPOLICY_PATH))
_iam_get_managedpolicy_arn_N= $(shell echo 'arn:aws:iam::$(IAM_AWSACCOUNT_ID):policy/$(strip $(1))')

_iam_get_managedpolicy_document_version= $(call _iam_get_managedpolicy_document_version_A, $(IAM_MANAGEDPOLICY_ARN))
_iam_get_managedpolicy_document_version_A= $(shell $(AWS) iam get-policy --policy-arn $(1) --query "Policy.DefaultVersionId" --output text)

_iam_get_managedpolicy_name= $(call _iam_get_managedpolicy_name_A, $(IAM_MANAGEDPOLICY_ARN))
# _iam_get_managedpolicy_name_A= $(shell $(AWS) iam list-policies --query "Policies[?Arn=='$(1)'].PolicyName" --output text)
_iam_get_managedpolicy_name_A= $(lastword $(subst /,$(SPACE),$(IAM_MANAGEDPOLICY_ARN)))

#----------------------------------------------------------------------
# USAGE
#

_iam_view_framework_macros ::
	@echo 'AWS::IAM::ManagedPolicy ($(_AWS_IAM_MANAGEDPOLICY_MK_VERSION)) macros:'
	@echo '    _iam_get_managedpolicy_arn_{|N|NP}              - Get the ARN of a managed-policy (Name,Path)'
	@echo '    _iam_get_managedpolicy_document_version_{|A}    - Get the active version of the managed-policy document (Arn)'
	@echo '    _iam_get_managedpolicy_name_{|A}                - Get the name of a managed-policy (Arn)'
	@echo

_iam_view_framework_parameters ::
	@echo 'AWS::IAM::ManagedPolicy ($(_AWS_IAM_MANAGEDPOLICY_MK_VERSION)) parameters:'
	@echo '    IAM_MANAGEDPOLICIES_AWSACCOUNT_ID=$(IAM_MANAGEDPOLICIES_AWSACCOUNT_ID)'
	@echo '    IAM_MANAGEDPOLICIES_GROUP_NAME=$(IAM_MANAGEDPOLICIES_GROUP_NAME)'
	@echo '    IAM_MANAGEDPOLICIES_ONLY_ATTACHED=$(IAM_MANAGEDPOLICIES_ONLY_ATTACHED)'
	@echo '    IAM_MANAGEDPOLICIES_PATH_PREFIX=$(IAM_MANAGEDPOLICIES_PATH_PREFIX)'
	@echo '    IAM_MANAGEDPOLICIES_ROLE_NAME=$(IAM_MANAGEDPOLICIES_ROLE_NAME)'
	@echo '    IAM_MANAGEDPOLICIES_SCOPE=$(IAM_MANAGEDPOLICIES_SCOPE)'
	@echo '    IAM_MANAGEDPOLICIES_SET_NAME=$(IAM_MANAGEDPOLICIES_SET_NAME)'
	@echo '    IAM_MANAGEDPOLICIES_USER_NAME=$(IAM_MANAGEDPOLICIES_USER_NAME)'
	@echo '    IAM_MANAGEDPOLICY_ACCOUNT_ID=$(IAM_MANAGEDPOLICY_ACCOUNT_ID)'
	@echo '    IAM_MANAGEDPOLICY_ARN=$(IAM_MANAGEDPOLICY_ARN)'
	@echo '    IAM_MANAGEDPOLICY_DOCUMENT=$(IAM_MANAGEDPOLICY_DOCUMENT)'
	@echo '    IAM_MANAGEDPOLICY_DOCUMENT_DIRPATH=$(IAM_MANAGEDPOLICY_DOCUMENT_DIRPATH)'
	@echo '    IAM_MANAGEDPOLICY_DOCUMENT_FILENAME=$(IAM_MANAGEDPOLICY_DOCUMENT_FILENAME)'
	@echo '    IAM_MANAGEDPOLICY_DOCUMENT_FILEPATH=$(IAM_MANAGEDPOLICY_DOCUMENT_FILEPATH)'
	@echo '    IAM_MANAGEDPOLICY_DOCUMENT_VERSION=$(IAM_MANAGEDPOLICY_DOCUMENT_VERSION)'
	@echo '    IAM_MANAGEDPOLICY_GROUP_NAME=$(IAM_MANAGEDPOLICY_GROUP_NAME)'
	@echo '    IAM_MANAGEDPOLICY_NAME=$(IAM_MANAGEDPOLICY_NAME)'
	@echo '    IAM_MANAGEDPOLICY_PATH=$(IAM_MANAGEDPOLICY_PATH)'
	@echo '    IAM_MANAGEDPOLICY_REGION_ID=$(IAM_MANAGEDPOLICY_REGION_ID)'
	@echo '    IAM_MANAGEDPOLICY_ROLE_NAME=$(IAM_MANAGEDPOLICY_ROLE_NAME)'
	@echo '    IAM_MANAGEDPOLICY_USER_NAME=$(IAM_MANAGEDPOLICY_USER_NAME)'
	@echo

_iam_view_framework_targets ::
	@echo 'AWS::IAM::ManagedPolicy ($(_AWS_IAM_MANAGEDPOLICY_MK_VERSION)) targets:'
	@echo '    _iam_attach_managedpolicy                  - Attach a managed-policy'
	@echo '    _iam_create_managedpolicy                  - Create a managed-policy'
	@echo '    _iam_delete_managedpolicy                  - Delete a managed-policy'
	@echo '    _iam_detach_managedpolicy                  - Detach a managed-policy'
	@echo '    _iam_show_managedpolicy                    - Show everything related to a managed-policy'
	@echo '    _iam_show_managedpolicy_contextkeys        - Show context-keys of a managed-policy'
	@echo '    _iam_show_managedpolicy_description        - Show description of a managed-policy'
	@echo '    _iam_show_managedpolicy_document           - Show document on a managed-policy'
	@echo '    _iam_show_managedpolicy_document_filepath  - Show content of document of managed-policy'
	@echo '    _iam_show_managedpolicy_versions           - Show versions of a managed-policy'
	@echo '    _iam_view_managedpolicies                  - View all managed-policies'
	@echo '    _iam_view_managedpolicies_set              - View a set of managed-policies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_iam_attach_managedpolicy:
	@$(INFO) '$(IAM_UI_LABEL)Attaching managed-policy "$(IAM_MANAGEDPOLICY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation attach the managed-policy to a role, a group, a user according to its configuration'; $(NORMAL)
	$(if $(IAM_MANAGEDPOLICY_GROUP_NAME), $(AWS) iam attach-group-policy $(__IAM_GROUP_NAME__MANAGEDPOLICY) $(__IAM_POLICY_ARN))
	$(if $(IAM_MANAGEDPOLICY_ROLE_NAME), $(AWS) iam attach-role-policy $(__IAM_POLICY_ARN) $(__IAM_ROLE_NAME__MANAGEDPOLICY))
	$(if $(IAM_MANAGEDPOLICY_USER_NAME), $(AWS) iam attach-user-policy $(__IAM_POLICY_ARN) $(__IAM_USER_NAME__MANAGEDPOLICY))

_iam_create_managedpolicy:
	@$(INFO) '$(IAM_UI_LABEL)Creating managed-policy "$(IAM_MANAGEDPOLICY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the name of the managed-policy is already in use (regardless of its path)'; $(NORMAL)
	$(AWS) iam create-policy $(__IAM_DESCRIPTION__MANAGEDPOLICY) $(__IAM_PATH__MANAGEDPOLICY) $(__IAM_POLICY_NAME__MANAGEDPOLICY) $(__IAM_POLICY_DOCUMENT__MANAGEDPOLICY) --query "Policy"

_iam_delete_managedpolicy:
	@$(INFO) '$(IAM_UI_LABEL)Deleting managed-policy "$(IAM_MANAGEDPOLICY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the managed-policy is still attached to a group, role, or user'; $(NORMAL)
	-$(AWS) iam delete-policy $(__IAM_POLICY_ARN)

_iam_detach_managedpolicy:
	@$(INFO) '$(IAM_UI_LABEL)Detaching managed-policy "$(IAM_MANAGEDPOLICY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation detach the managed-policy to a role, a group, a user according to its configuration'; $(NORMAL)
	-$(if $(IAM_MANAGEDPOLICY_GROUP_NAME), $(AWS) iam detach-group-policy $(__IAM_GROUP_NAME__MANAGEDPOLICY) $(__IAM_POLICY_ARN))
	-$(if $(IAM_MANAGEDPOLICY_ROLE_NAME), $(AWS) iam detach-role-policy $(__IAM_POLICY_ARN) $(__IAM_ROLE_NAME__MANAGEDPOLICY))
	-$(if $(IAM_MANAGEDPOLICY_USER_NAME), $(AWS) iam detach-user-policy $(__IAM_POLICY_ARN) $(__IAM_USER_NAME__MANAGEDPOLICY))

_IAM_SHOW_MANAGEDPOLICY_TARGETS?= _iam_show_managedpolicy_contextkeys _iam_show_managedpolicy_document _iam_show_managedpolicy_document_filepath _iam_show_managedpolicy_versions _iam_show_managedpolicy_description
_iam_show_managedpolicy: $(_IAM_SHOW_MANAGEDPOLICY_TARGETS)

_iam_show_managedpolicy_contextkeys:
	@$(INFO) '$(IAM_UI_LABEL)Showing context-keys of managed-policy "$(IAM_MANAGEDPOLICY_NAME)" ...'; $(NORMAL)
	#$(if $(IAM_MANAGEDPOLICY_DOCUMENT),$(AWS) iam get-context-keys-for-custom-policy $(__IAM_POLICY_INPUT_LIST))

_iam_show_managedpolicy_description:
	@$(INFO) '$(IAM_UI_LABEL)Showing description of managed-policy "$(IAM_MANAGEDPOLICY_NAME)" ...'; $(NORMAL)
	$(_IAM_SHOW_MANAGEDPOLICY_DESRIPTION_|)$(AWS) iam get-policy $(__IAM_POLICY_ARN) --query "Policy"

_iam_show_managedpolicy_document:
	@$(INFO) '$(IAM_UI_LABEL)Showing document-version "$(IAM_MANAGEDPOLICY_DOCUMENT_VERSION)" of managed-policy "$(IAM_MANAGEDPOLICY_NAME)" ...'; $(NORMAL)
	$(if $(IAM_MANAGEDPOLICY_DOCUMENT_VERSION), \
		$(AWS) iam get-policy-version $(__IAM_POLICY_ARN) $(__IAM_VERSION_ID) --query "PolicyVersion.Document" --output json \
	, \
		@echo 'IAM_MANAGEDPOLICY_DOCUMENT_VERSION not set!' \
	)


_iam_show_managedpolicy_document_filepath:
	@$(INFO) '$(IAM_UI_LABEL)Showing local-file for document of managed-policy "$(IAM_MANAGEDPOLICY_NAME)" ...'; $(NORMAL)
	$(if $(IAM_MANAGEDPOLICY_DOCUMENT_FILEPATH), \
		jq --monochrome-output '.' $(IAM_MANAGEDPOLICY_DOCUMENT_FILEPATH) \
	, \
		@echo 'IAM_MANAGEDPOLICY_DOCUMENT_FILEPATH not set' \
	)

_iam_show_managedpolicy_versions:
	@$(INFO) '$(IAM_UI_LABEL)Showing versions of managed-policy "$(IAM_MANAGEDPOLICY_NAME)" ...'; $(NORMAL)
	# Not yet implamented

_iam_update_managedpolicy:
	@$(INFO) '$(IAM_UI_LABEL)Updating managed-policy "$(IAM_MANAGEDPOLICY_NAME)" ...'; $(NORMAL)
	#$(AWS) create-policy-version $(__IAM_POLICY_ARN) $(__IAM_POLICY_DOCUMENT__MANAGEDPOLICY) $(__IAM_SET_AS_DEFAULT)

_iam_view_managedpolicies:
	@$(INFO) '$(IAM_UI_LABEL)Viewing ALL managed-policies ...'; $(NORMAL)
	$(AWS) iam list-policies $(__IAM_ONLY_ATTACHED) $(_X__IAM_PATH_PREFIX__MANAGEDPOLICY) $(_X_IAM_SCOPE) --scope All --query "Policies[$(IAM_UI_VIEW_AWS_MANAGEDPOLICIES_QUERY_FILTER)]$(IAM_UI_VIEW_MANAGEDPOLICIES_FIELDS)"

_iam_view_managedpolicies_set:
	@$(INFO) '$(IAM_UI_LABEL)Showing managed-policies-set "$(IAM_MANAGEDPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Policies are grouped based on the optional attachment-status, path-prefix, scope, and query-filter'; $(NORMAL)
	$(AWS) iam list-policies $(__IAM_ONLY_ATTACHED) $(__IAM_PATH_PREFIX__MANAGEDPOLICIES) $(__IAM_SCOPE) --query "Policies[$(IAM_UI_VIEW_MANAGEDPOLICIES_SET_QUERYFILTER)]$(IAM_UI_VIEW_MANAGEDPOLICIES_SET_FIELDS)"
	-$(if $(IAM_MANAGEDPOLICIES_GROUP_NAME), $(AWS) iam list-attached-group-policies $(__IAM_GROUP_NAME__MANAGEDPOLICIES) --query 'AttachedPolicies[]')
	-$(if $(IAM_MANAGEDPOLICIES_ROLE_NAME), $(AWS) iam list-attached-role-policies $(__IAM_ROLE_NAME__MANAGEDPOLICIES) --query 'AttachedPolicies[]')
	-$(if $(IAM_MANAGEDPOLICIES_USER_NAME), $(AWS) iam list-attached-user-policies $(__IAM_USER_NAME__MANAGEDPOLICIES) --query 'AttachedPolicies[]')

_iam_watch_managedpolicies:

_iam_watch_managedpolicies_set:
